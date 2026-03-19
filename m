Return-Path: <netdev+bounces-269633-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KGOcAKZVvGkXwwIAu9opvQ
	(envelope-from <netdev+bounces-269633-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:59:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9CA2D1E36
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 20:59:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA78A30D451A
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 19:56:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80DA339DBF8;
	Thu, 19 Mar 2026 19:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="XxvOS7+M"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 782FF338906
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 19:56:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.84.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773950219; cv=none; b=dVg+xR7V5gmblzZM1RRhXpr9tt3ho+l+UfM/wBNtK9DnLJnsp4P7OgBIMTJp13DGE2aErfpdl0TnftoBrnH6i3nJPVQy2cNBMqbNui+u52HoF+ANnKqzvC6ySFEW60wdRwKxQUkTD4i1MWe2x0tiMPed7KMziMRRQZLUoD56mzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773950219; c=relaxed/simple;
	bh=A5ZzQf31sXGiyMkHY7CP5QbAbk7vbbn517yUbBfo44s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hzKZrt2WHQvmGHLWezRHhUG6tNW2dS6lg1kjCCWDO6JWC8nM2Hot92sDAQLUtmSxaymvy5JwEiwZeYYfZKk8+OsHLXAPfPRU9hFqC58AmzatwclJw7oHrkUiOX2Cyc8JiIOPyWgGkKNVfAg7DONAv+B7CtsXMZHMaEETaiS3Qgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=XxvOS7+M; arc=none smtp.client-ip=185.246.84.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id A15CC1A2EE9;
	Thu, 19 Mar 2026 19:56:53 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 6904460050;
	Thu, 19 Mar 2026 19:56:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 507AB10450A9C;
	Thu, 19 Mar 2026 20:56:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1773950212; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=cm39P2d/41DdSfdDZCfUJLAJ/BGyonppmELDf76R9UI=;
	b=XxvOS7+Mr7dkDyD+4Xtt6WqyG1iBNRgP8jj9BFlmVqB91FM5yVSIyhwAlfC5kl04J/r4Gv
	wwCGP/Iw8BUpDmvdgZkmpGZQQQsZmTVkmM+fI+hYdUlK8Vsxg/epPiLaAPct53XF7h6Eg5
	pQ7t9JP+H2hhL+W7NuPQGbKbY58U5FIY0bgwAj43f8MK48vYmMw7I7j9P5OvI1tzG7ofa7
	OXa3RZYyEwEGS5vCQ/ES3WpX0eT+xEl32oiWJeQllbIFgDd6P0suFjfT/Dul/S0VmATgtR
	GDma6ce4742Ti2GK9Dxk9MMUm6Luv7YV7bzbWa+QDEnzVJkYWQw0PWL0WbS29g==
Message-ID: <2e4a7b45-8029-425e-8b86-9f3031bd081e@bootlin.com>
Date: Thu, 19 Mar 2026 20:56:46 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/2] net: page_pool: support dumping pps of a
 specific ifindex via Netlink
To: Jakub Kicinski <kuba@kernel.org>, davem@davemloft.net
Cc: netdev@vger.kernel.org, edumazet@google.com, pabeni@redhat.com,
 andrew+netdev@lunn.ch, horms@kernel.org, donald.hunter@gmail.com,
 shuah@kernel.org, matttbe@kernel.org, chuck.lever@oracle.com,
 hawk@kernel.org, linux-kselftest@vger.kernel.org
References: <20260319035649.2396137-1-kuba@kernel.org>
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
Content-Language: en-US
In-Reply-To: <20260319035649.2396137-1-kuba@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[bootlin.com,reject];
	R_DKIM_ALLOW(-0.20)[bootlin.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269633-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maxime.chevallier@bootlin.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[bootlin.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,bootlin.com:dkim,bootlin.com:mid]
X-Rspamd-Queue-Id: 9D9CA2D1E36
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

On 19/03/2026 04:56, Jakub Kicinski wrote:
> NIPA tries to make sure that HW tests don't modify system state.
> It saves the state of page pools, too. Now that I write this commit
> message I realize that this is impractical since page pool IDs and
> state will get legitimately changed by the tests. But I already
> spent a couple of hours implementing the filtering, so..
> 
> Signed-off-by: Jakub Kicinski <kuba@kernel.org>

[...]

> diff --git a/net/core/page_pool_user.c b/net/core/page_pool_user.c
> index ee5060d8eec0..01509d1b3cba 100644
> --- a/net/core/page_pool_user.c
> +++ b/net/core/page_pool_user.c
> @@ -79,7 +79,7 @@ struct page_pool_dump_cb {
>  
>  static int
>  netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
> -			     pp_nl_fill_cb fill)
> +			     pp_nl_fill_cb fill, struct nlattr *ifindex_attr)
>  {
>  	struct page_pool_dump_cb *state = (void *)cb->ctx;
>  	const struct genl_info *info = genl_info_dump(cb);
> @@ -88,9 +88,17 @@ netdev_nl_page_pool_get_dump(struct sk_buff *skb, struct netlink_callback *cb,
>  	struct page_pool *pool;
>  	int err = 0;
>  
> +	if (ifindex_attr)
> +		state->ifindex = nla_get_u32(ifindex_attr);
> +
>  	rtnl_lock();
>  	mutex_lock(&page_pools_lock);
>  	for_each_netdev_dump(net, netdev, state->ifindex) {
> +		/* Either the provided ifindex doesn't exist or done dumping */
> +		if (ifindex_attr &&
> +		    netdev->ifindex != nla_get_u32(ifindex_attr))
> +			break;

If the passed ifindex doesn't exist, isn't netdev NULL here ?

Maxime

