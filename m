Return-Path: <netdev+bounces-146062-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EBA109D1E0F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 03:20:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8188E1F22509
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 02:20:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12BED13777F;
	Tue, 19 Nov 2024 02:20:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HcmJCB+X"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0D68137742
	for <netdev@vger.kernel.org>; Tue, 19 Nov 2024 02:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731982806; cv=none; b=i6ZiHvBWH20LUQhc36oHXFFRFR+hcAr/2FGJ7GSo9PM3Nj4s4xxQb+qgfcBUsk0Yj55xW8Af1Xm17RdIVdvIimhvokDNacIWWFqythPh8k9MN2qY6DI+sPAX2mwC2FMSrGihqoM6r31qqsSdywHSxZrZvsxOQBwuVy062N+iLAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731982806; c=relaxed/simple;
	bh=m4Dd/xFXyAlcLHzQpeqb5UVAmSZ/qSLEmJte09EhxuY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tIg0xCcoz6W16Goa1xZ6tXs/v58hi+hHmDswJVjPCb5WnK1BZBhkrailc5PybkgFdMv3hfsh+SQnfUICEGTw2nCXQNw9Wm/s+SVSRjiki4xDeSJcBFH39E9SbYcCWgxKNQj9Wc5g8zi+hxjzucXT2z9O12gYKGPBXghB0m2QbEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HcmJCB+X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2669AC4CECC;
	Tue, 19 Nov 2024 02:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731982805;
	bh=m4Dd/xFXyAlcLHzQpeqb5UVAmSZ/qSLEmJte09EhxuY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=HcmJCB+XfUkC7LERyq/t56bbcT6e9neINorVZMtH9vE4KfDQWPrOSzNII3Tt6hq+I
	 nwtjM6GRdjp0Na5xscEn8/3nqr7r6I/EBtW3jMpDWEtk4FNOl3WKoTA+S92W+uBJZN
	 NbT0KXgr5XLi6wNXTlbbIPmXTEH7jLMVWlExSmg819FaYBbKWl2cPO/uaWu3LP8/lu
	 +Dm87FGuf7auzPgalAPkFp04TgPcggrfJILCYaKGKCpwhfAahie1NZ4TGzm6AyJdnA
	 Tk/ytTPt/B3tcHTBUI9wbgSEcn71AcY1Qo//edOYVWzFkKQhey1slGbKruGIO2KngB
	 8BBNmP+/UHCmA==
Date: Mon, 18 Nov 2024 18:20:04 -0800
From: Jakub Kicinski <kuba@kernel.org>
To: Gilad Naaman <gnaaman@drivenets.com>
Cc: "David S. Miller" <davem@davemloft.net>, David Ahern
 <dsahern@kernel.org>, Eric Dumazet <edumazet@google.com>, Paolo Abeni
 <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
 netdev@vger.kernel.org
Subject: Re: [PATCH net-next] ipv6: Avoid invoking addrconf_verify_rtnl
 unnecessarily
Message-ID: <20241118182004.5d38fac2@kernel.org>
In-Reply-To: <20241111171607.127691-1-gnaaman@drivenets.com>
References: <20241111171607.127691-1-gnaaman@drivenets.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Mon, 11 Nov 2024 17:16:07 +0000 Gilad Naaman wrote:
> Do not invoke costly `addrconf_verify_rtnl` if the added address
> wouldn't need it, or affect the delayed_work timer.
> 
> Signed-off-by: Gilad Naaman <gnaaman@drivenets.com>
> ---
> addrconf_verify_rtnl() deals with either management/temporary (Security)
> addresses, or with addresses that have some kind of lifetime.
> 
> This patches makes it so that ops on addresses that are permanent would
> not trigger this function.
> 
> This does wonders in our use-case of modifying a lot of (~24K) static
> addresses, since it turns the addition or deletion of addresses to an
> amortized O(1), instead of O(N).
> 
> Modification of management addresses or "non-permanent" (not sure what
> is the correct jargon) addresses are still slow.
> 
> We can improve those in the future, depending on the case:
> 
> If the function is called only to handle cases where the scheduled work should
> be called earlier, I think this would be better served by saving the next
> expiration and equating to it, since it would save iteration of the
> table.
> 
> If some upkeep *is* needed (e.g. creating a temporary address)
> I Think it is possible in theory make these modifications faster as
> well, if we only iterate `idev->if_addrs` as a response for a
> modification, since it doesn't seem to me like there are any
> cross-device effects.
> 
> I opted to keep this patch simple and not solve this, on the assumption
> that there aren't many users that need this scale.

I'd rather you put too much in the commit message than too little.
Move more (all?) of this above the --- please.

> diff --git a/net/ipv6/addrconf.c b/net/ipv6/addrconf.c
> index d0a99710d65d..12fdabb1deba 100644
> --- a/net/ipv6/addrconf.c
> +++ b/net/ipv6/addrconf.c
> @@ -3072,8 +3072,7 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  		 */
>  		if (!(ifp->flags & (IFA_F_OPTIMISTIC | IFA_F_NODAD)))
>  			ipv6_ifa_notify(0, ifp);
> -		/*
> -		 * Note that section 3.1 of RFC 4429 indicates
> +		/* Note that section 3.1 of RFC 4429 indicates
>  		 * that the Optimistic flag should not be set for
>  		 * manually configured addresses
>  		 */
> @@ -3082,7 +3081,15 @@ static int inet6_addr_add(struct net *net, int ifindex,
>  			manage_tempaddrs(idev, ifp, cfg->valid_lft,
>  					 cfg->preferred_lft, true, jiffies);
>  		in6_ifa_put(ifp);
> -		addrconf_verify_rtnl(net);
> +
> +		/* Verify only if this address is perishable or has temporary
> +		 * offshoots, as this function is too expansive.
> +		 */
> +		if ((cfg->ifa_flags & IFA_F_MANAGETEMPADDR) ||
> +		    !(cfg->ifa_flags & IFA_F_PERMANENT) ||
> +		    cfg->preferred_lft != INFINITY_LIFE_TIME)

Would be very useful for readability to extract the condition into 
some helper. If addrconf_verify_rtnl() also used that same helper
reviewing this patch would be trivial..

> +			addrconf_verify_rtnl(net);
> +
>  		return 0;
>  	} else if (cfg->ifa_flags & IFA_F_MCAUTOJOIN) {
>  		ipv6_mc_config(net->ipv6.mc_autojoin_sk, false,
> @@ -3099,6 +3106,7 @@ static int inet6_addr_del(struct net *net, int ifindex, u32 ifa_flags,
>  	struct inet6_ifaddr *ifp;
>  	struct inet6_dev *idev;
>  	struct net_device *dev;
> +	int is_mgmt_tmp;

The flag naming isn't super clear, but it's manageD, not manageMENT,
as in "managed by the kernel".

>  
>  	if (plen > 128) {
>  		NL_SET_ERR_MSG_MOD(extack, "Invalid prefix length");

I think this change will need to wait until after the merge window
(Dec 2nd), sorry nobody reviewed it in time for 6.13 :(
-- 
pw-bot: defer

