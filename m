Return-Path: <netdev+bounces-16705-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E52774E762
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 08:33:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 48B0E1C209B8
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 06:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10CAF443C;
	Tue, 11 Jul 2023 06:33:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2DA13D81
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 06:33:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABDCC433C7;
	Tue, 11 Jul 2023 06:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689057233;
	bh=acU76Y6k1QN2XPJ4c01Abf7FhYW/VoN5gp3/z0pL7I4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BVKsrX0gYKSG/0sv5oXX9VH941YTcpvKPUXuxW/wrnzQXs4L0JtwHeS4ZPStVcq6b
	 zkjHWxf7uvzsp0FOys/nLc1hH3LANzfo9LktDNJM3QmRYPhU/hA1IyB8QLaPZJW1Zm
	 8eEqqTBn5MiZqZ1LnWGQUftZo3FfmXXyBMar1OxcVP71I0ZJqa4+q1ZUIX7QnUG4kB
	 o5DdIwZsd8xk66vtoqyQy/zn1aIN6W+yOLfD2lLAZ8zkmNx+gjpaAaJFlL5nY9KIgd
	 DQjPeFTxkA86B2nZebXGOe2woTcKoOuoNxF7M21zOZrZQ5KLe9mGPK3G1faImw9SWp
	 Bf/F4smByyWaA==
Date: Tue, 11 Jul 2023 09:33:48 +0300
From: Leon Romanovsky <leon@kernel.org>
To: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc: Jakub Kicinski <kuba@kernel.org>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH net-next][resend v1 1/1] netlink: Don't use int as bool
 in netlink_update_socket_mc()
Message-ID: <20230711063348.GB41919@unreal>
References: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230710100624.87836-1-andriy.shevchenko@linux.intel.com>

On Mon, Jul 10, 2023 at 01:06:24PM +0300, Andy Shevchenko wrote:
> The bit operations take boolean parameter and return also boolean
> (in test_bit()-like cases). Don't threat booleans as integers when
> it's not needed.
> 
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  net/netlink/af_netlink.c | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
> index 383631873748..d81e7a43944c 100644
> --- a/net/netlink/af_netlink.c
> +++ b/net/netlink/af_netlink.c
> @@ -1623,9 +1623,10 @@ EXPORT_SYMBOL(netlink_set_err);
>  /* must be called with netlink table grabbed */
>  static void netlink_update_socket_mc(struct netlink_sock *nlk,
>  				     unsigned int group,
> -				     int is_new)
> +				     bool new)
>  {
> -	int old, new = !!is_new, subscriptions;
> +	int subscriptions;
> +	bool old;
>  
>  	old = test_bit(group - 1, nlk->groups);
>  	subscriptions = nlk->subscriptions - old + new;

So what is the outcome of "int - bool + bool" in the line above?

> @@ -2152,7 +2153,7 @@ void __netlink_clear_multicast_users(struct sock *ksk, unsigned int group)
>  	struct netlink_table *tbl = &nl_table[ksk->sk_protocol];
>  
>  	sk_for_each_bound(sk, &tbl->mc_list)
> -		netlink_update_socket_mc(nlk_sk(sk), group, 0);
> +		netlink_update_socket_mc(nlk_sk(sk), group, false);
>  }
>  
>  struct nlmsghdr *
> -- 
> 2.40.0.1.gaa8946217a0b
> 
> 

