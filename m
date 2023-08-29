Return-Path: <netdev+bounces-31135-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E316178BCFD
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 04:45:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBDCD1C20995
	for <lists+netdev@lfdr.de>; Tue, 29 Aug 2023 02:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85B9A7EC;
	Tue, 29 Aug 2023 02:45:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451C1EA6
	for <netdev@vger.kernel.org>; Tue, 29 Aug 2023 02:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FF4BC433C8;
	Tue, 29 Aug 2023 02:45:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1693277123;
	bh=hH2/zSFJebPe7D39TykbqHcZy5SmvHwnaWolx9gVkzY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=JJ0mb0KTN62N+r1ktmDaoC3MGU1ek0z87gqQBvNJ3jWHtgE4UINiEQOBxOORHeCJS
	 3JrbfD3XFqafnMeGDDKbcs06+xBWDXmc13KCrGrgQTdXPiBN6EHo5xI0NZ137stBW7
	 TNSRC9cGG4AykY8t1T7BlPvIR3RjyhkFrckBmAwa667ZKpiCA9BjPxLhTej4uRY/rh
	 T+3Amn1N0pY0dan5MVAsqUq4wf+mgQ5EmTYcVnV0ZVGTm0IYYsMzPjFghL6G+JiHrj
	 kCDpheWEY3Gyb7jdnaLa4x+2J00dynNVcLhxv9b5W5C5NpNKoiCanbMEWM9+VCZlMU
	 7JynWHOKJiRVw==
Message-ID: <fea6db56-3a01-b7c8-b800-a6c885e99feb@kernel.org>
Date: Mon, 28 Aug 2023 20:45:22 -0600
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.14.0
Subject: Re: [PATCH net] ipv4: igmp: Remove redundant comparison in
 igmp_mcf_get_next()
Content-Language: en-US
To: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
 "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
References: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
From: David Ahern <dsahern@kernel.org>
In-Reply-To: <20230828085926.424703-1-Ilia.Gavrilov@infotecs.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/28/23 3:01 AM, Gavrilov Ilia wrote:
> The 'state->im' value will always be non-zero after
> the 'while' statement, so the check can be removed.
> 
> Found by InfoTeCS on behalf of Linux Verification Center
> (linuxtesting.org) with SVACE.
> 
> Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
> ---
>  net/ipv4/igmp.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/net/ipv4/igmp.c b/net/ipv4/igmp.c
> index 48ff5f13e797..6ebf06886527 100644
> --- a/net/ipv4/igmp.c
> +++ b/net/ipv4/igmp.c
> @@ -2943,8 +2943,6 @@ static struct ip_sf_list *igmp_mcf_get_next(struct seq_file *seq, struct ip_sf_l
>  				continue;
>  			state->im = rcu_dereference(state->idev->mc_list);
>  		}
> -		if (!state->im)
> -			break;
>  		spin_lock_bh(&state->im->lock);
>  		psf = state->im->sources;
>  	}

Same with this one: agree the check is not needed, but I also believe it
does not need to be backported. Since net-next is closed, resubmit after
9/11.

--
pw-bot: defer

