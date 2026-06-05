Return-Path: <netdev+bounces-295793-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id t0NrMgS0ImqCcQEAu9opvQ
	(envelope-from <netdev+bounces-295793-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:33:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 28EAA647BF7
	for <lists+netdev@lfdr.de>; Fri, 05 Jun 2026 13:33:24 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=A8Xp+JZB;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-295793-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-295793-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F15BE3014BFC
	for <lists+netdev@lfdr.de>; Fri,  5 Jun 2026 11:26:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C944A4D2EFA;
	Fri,  5 Jun 2026 11:26:28 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D5EE3BBFAF;
	Fri,  5 Jun 2026 11:26:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780658788; cv=none; b=Vy3Qf6LcDoO7+Cmq6XpgzYkaSqJe+8RH73TCvxPu2kNMkj4m1jCk2UbBEo9+aggMrsB0N5xOsOVaqizRPF/ZpoE3xi+ny3LR+EivH/p47KYkZjzorGr++YfBoOhrx5DwvDRh1gjFRUIR6SSwqs5jnfkj7VT2EAmHW3VYmQJbD6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780658788; c=relaxed/simple;
	bh=UQNjvhsS0kyP9yZjiftX5re9UssabP7shCO1bYn/BEo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=e480eB6HoqXEvcUAs9QxCmu5FI1tUJGbEdwFwScFCXpfPXkIEI+Tr2jgk0838nPBlH0Yd+1hsCfuWRx3f8nRekbMV9TfllRtpJo8jrRaYBj8WxajKF+gN9EB8XtAonY1MyxmGPBi6+IthhD6uAMyNWQZsGETAr7CbhJ1X7u/Swc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=A8Xp+JZB; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 145412080B;
	Fri,  5 Jun 2026 13:26:25 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JVgEhEhNj6FO; Fri,  5 Jun 2026 13:26:24 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 60418205CD;
	Fri,  5 Jun 2026 13:26:24 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 60418205CD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780658784;
	bh=Ars2tic3lzf/ipie+1QBlNBvTaWoFizgll5R0E9sbeg=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=A8Xp+JZBabijuLMWups3YB4RQd/J+bmBIAP0u6Ufp/yOdMbXxo/BaoE8J269GFNWt
	 Suzz2pexXdDq0G2NAuxRiTh7wwpdXCI3w4gEzQTg9dTWBbB9pn0DLm0aNTXR/AhPwE
	 WM5r7NHJOFBBobPo6aWcRFiOTiTPM3X2I+IE7WEdVDC7LcGb7XJ/ceULiwBGUfvRmN
	 Z1h/jpuc550HGpzHXEoCkyeOFHyUwD10IY+7FqiOopTUENkdkV+r095egRAy8/Y258
	 CMcMg5Q0z3q4KbKRWUzv3m+zMQdwHXOOXrYBSWYZGICk8u/9Iwqu2Q9McuWjDoTRJJ
	 4v/aqOmr373KA==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Fri, 5 Jun
 2026 13:26:23 +0200
Received: (nullmailer pid 389996 invoked by uid 1000);
	Fri, 05 Jun 2026 11:26:23 -0000
Date: Fri, 5 Jun 2026 13:26:23 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec v2] esp: fix page frag reference leak on
 skb_to_sgvec failure
Message-ID: <aiKyX8XlbFoTuZ4U@secunet.com>
References: <20260603114507.1443-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260603114507.1443-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_RECIPIENTS(0.00)[m:7991aleschino@gmail.com,m:netdev@vger.kernel.org,m:herbert@gondor.apana.org.au,m:davem@davemloft.net,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-295793-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:mid,secunet.com:from_mime,secunet.com:dkim,vger.kernel.org:from_smtp];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[secunet.com:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 28EAA647BF7

On Wed, Jun 03, 2026 at 01:45:07PM +0200, Alessandro Schino wrote:
> In esp_output_tail(), when esp->inplace is false, the old skb page frags
> are replaced with a new page from the xfrm page_frag cache. The source
> scatterlist (sg) is built from the old frags before the replacement, and
> esp_ssg_unref() is responsible for releasing the old page references
> after the crypto operation completes.
> 
> However, if the second skb_to_sgvec() call (which builds the destination
> scatterlist from the new page) fails, the code jumps to error_free which
> only calls kfree(tmp). The old page frag references captured in the
> source scatterlist are never released:
> 
>   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>   2. nr_frags is set to 1 and frag[0] is replaced with the new page
>   3. Second skb_to_sgvec() fails -> goto error_free
> 
> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> unconditionally unrefs the source scatterlist frags. Since req->src is
> not yet initialized by aead_request_set_crypt() at the point of the
> error, the source scatterlist is obtained directly via esp_req_sg().
> Existing callers pass false to preserve the original behavior.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
> ---
> v2: split the long line in esp_ssg_unref() to keep it under 100 columns
> 
>  net/ipv4/esp4.c | 7 +++++--
>  net/ipv6/esp6.c | 7 +++++--
>  2 files changed, 10 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 2429c7845984..dfc81ee969ae 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -113,10 +113,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
>  	/* Unref skb_frag_pages in the src scatterlist if necessary.
>  	 * Skip the first sg which comes from skb->data.
>  	 */
> -	if (already_unref || req->src != req->dst)
> -		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
> +	if (already_unref || req->src != req->dst) {
> +		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;

This looks like a diff beween two versions of your patch.
We don't have already_unref in the code, so it does not
apply.

> +
> +		for (sg = sg_next(src); sg; sg = sg_next(sg))
>  			skb_page_unref(page_to_netmem(sg_page(sg)),
>  				       skb->pp_recycle);
> +	}
>  }
>  
>  #ifdef CONFIG_INET_ESPINTCP
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 50af6ab9b8fc..296b57926abb 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -130,10 +130,13 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb,
>  	/* Unref skb_frag_pages in the src scatterlist if necessary.
>  	 * Skip the first sg which comes from skb->data.
>  	 */
> -	if (already_unref || req->src != req->dst)
> -		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
> +	if (already_unref || req->src != req->dst) {
> +		struct scatterlist *src = already_unref ? esp_req_sg(aead, req) : req->src;

Same here.

