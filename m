Return-Path: <netdev+bounces-26556-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E76B8778201
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 22:17:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2ABB21C20CB8
	for <lists+netdev@lfdr.de>; Thu, 10 Aug 2023 20:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4AA823BCB;
	Thu, 10 Aug 2023 20:17:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F8AA200BC
	for <netdev@vger.kernel.org>; Thu, 10 Aug 2023 20:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B58E9C433C8;
	Thu, 10 Aug 2023 20:17:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691698644;
	bh=2LkXagz5/siA1FP/5dAE4Mt0Kkq6mddlWPM/k+TwkN4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PLNG2GbnlGKmswJnGAu5gAiTYxAO0k/kY32xwa0BpD+q/lQFemPAZAnfjHiLMUPhN
	 35XypHILHqpLIZ9OeSmnh1vcDvot7cnI9Ot6Nb60+9/Zhdr3szP50uXicWaQuBshgP
	 aAJtE04opiq1P1IoYIc9Bx6WqGKuocDb3VV9tFobIK+I64ITD7CnKnZe/lw5AE+TYG
	 EgBveYoYMBQsh3WnEv0ENrpyDkyL7DiE5VVy4YCurVRViAHKTGIWfxlgVbRjMUyHpx
	 DiO7z1HSPgrXLQnDM8Bj6OJ4Vb7iywv7OiJE0RpRhS+Skv+KwmelkQXnJI0vNKI8IB
	 Rxr0L7i6u4/Ww==
Date: Thu, 10 Aug 2023 22:17:18 +0200
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: rdunlap@infradead.org, benjamin.poirier@gmail.com, davem@davemloft.net,
	kuba@kernel.org, edumazet@google.com,
	Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
	open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net-next v5 1/2] netconsole: Create a allocation helper
Message-ID: <ZNVFzhBVT/LyhTuR@vergenet.net>
References: <20230810095452.3171106-1-leitao@debian.org>
 <20230810095452.3171106-2-leitao@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230810095452.3171106-2-leitao@debian.org>

On Thu, Aug 10, 2023 at 02:54:50AM -0700, Breno Leitao wrote:
> De-duplicate the initialization and allocation code for struct
> netconsole_target.
> 
> The same allocation and initialization code is duplicated in two
> different places in the netconsole subsystem, when the netconsole target
> is initialized by command line parameters (alloc_param_target()), and
> dynamically by sysfs (make_netconsole_target()).
> 
> Create a helper function, and call it from the two different functions.
> 
> Suggested-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Breno Leitao <leitao@debian.org>
> ---
>  drivers/net/netconsole.c | 42 +++++++++++++++++++++-------------------
>  1 file changed, 22 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/netconsole.c b/drivers/net/netconsole.c
> index 87f18aedd3bd..f93b98d64a3c 100644
> --- a/drivers/net/netconsole.c
> +++ b/drivers/net/netconsole.c
> @@ -167,19 +167,16 @@ static void netconsole_target_put(struct netconsole_target *nt)
>  
>  #endif	/* CONFIG_NETCONSOLE_DYNAMIC */
>  
> -/* Allocate new target (from boot/module param) and setup netpoll for it */
> -static struct netconsole_target *alloc_param_target(char *target_config)
> +/* Allocate and initialize with defaults.
> + * Note that these targets get their config_item fields zeroed-out.
> + */
> +static struct netconsole_target *alloc_and_init(void)
>  {
> -	int err = -ENOMEM;
>  	struct netconsole_target *nt;
>  
> -	/*
> -	 * Allocate and initialize with defaults.
> -	 * Note that these targets get their config_item fields zeroed-out.
> -	 */
>  	nt = kzalloc(sizeof(*nt), GFP_KERNEL);
>  	if (!nt)
> -		goto fail;
> +		return nt;
>  
>  	nt->np.name = "netconsole";
>  	strscpy(nt->np.dev_name, "eth0", IFNAMSIZ);
> @@ -187,6 +184,21 @@ static struct netconsole_target *alloc_param_target(char *target_config)
>  	nt->np.remote_port = 6666;
>  	eth_broadcast_addr(nt->np.remote_mac);
>  
> +	return nt;
> +}
> +
> +/* Allocate new target (from boot/module param) and setup netpoll for it */
> +static struct netconsole_target *alloc_param_target(char *target_config)
> +{
> +	struct netconsole_target *nt;
> +	int err;

Hi Breno,

This function returns err.
However, clang-16 W=1 and Smatch warn that there is a case
where this may occur without err having being initialised.

> +
> +	nt = alloc_and_init();
> +	if (!nt) {
> +		err = -ENOMEM;
> +		goto fail;
> +	}
> +
>  	if (*target_config == '+') {
>  		nt->extended = true;
>  		target_config++;

...

-- 
pw-bot: changes-requested

