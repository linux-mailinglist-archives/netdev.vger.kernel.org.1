Return-Path: <netdev+bounces-288611-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gFrXDPdNCGoDiwMAu9opvQ
	(envelope-from <netdev+bounces-288611-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:59:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FFA155B3EF
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 12:59:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D3D0C30048E4
	for <lists+netdev@lfdr.de>; Sat, 16 May 2026 10:59:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A82F43D410C;
	Sat, 16 May 2026 10:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b="Z6tUNnh8"
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7F023183C;
	Sat, 16 May 2026 10:58:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.96.220.36
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778929138; cv=none; b=g13wi20IIaVCojudEJpOqIP1f93ABhYHb2gmV9mqOHsuNjZyRgSrTSZNtwSA8CF3jY6hVUH+kGts3ZOqjwhxWPVahXsDf45eNA79cAQtWx+x6ywas0C+d8WSCR/kv2Me7TSx1BLu9BlTfyKtMuf60AJiJgkOAjFiDDUzyWkuf3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778929138; c=relaxed/simple;
	bh=I7GSJk2c2RHnoZMQnTGC4LTdrNjCzRqsB79MliUuRGo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=U+pEqP4mILypAOFUDI8yjv6EvfVm/PJfY8Dv8Ac5Eg22wFE7rHBpPeh059gXYeILjlSFZtNt4jAyP2DBDsY9PFHfkSv3GEUiHga9TuRJlJHda6GBL8G9+tTUHze5RFfm+LK5jDnSgSd5Q1tvrhhd6S5vAkAiQk/KGWY2moR9ZVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=Z6tUNnh8; arc=none smtp.client-ip=62.96.220.36
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=secunet.com
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id 8AAF02084C;
	Sat, 16 May 2026 12:58:53 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XnPTF8AX56iX; Sat, 16 May 2026 12:58:52 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id 67AF62084B;
	Sat, 16 May 2026 12:58:52 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com 67AF62084B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1778929132;
	bh=uoyLavdb5OXd27kVBWFFoKu3PF40D6zyXQqhrgraDW0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=Z6tUNnh8k5KzOUFQXW0GYuzk4rXKEuERyQXjuhOMtHmIIWV1qjOPb5DXWiGDHh/U/
	 bh7toElxDUfrwP8UzssL9nXXen0Nxy76x/mxDA2sG3YRH3pCeLVcJFTfpiiH8F+J11
	 8LdzLGenogiBMJgdxvghxDiP5oi0QhIZ/pvlFbcpi8Ie/HlSVfiZMVO1nZ6QUPLFPl
	 VBmMMpMtyagei4jQUOkwBkyrYxGyO9zqOk8D0LtUOvwYn6zbElTgTQWYlDn39isvBY
	 WRhDgmZOy/VuG36ryoemlDBq3uDd767dESJ5i/bFRJSw7AD/hupLT/zLTnTd5ylA4S
	 lJbd/EZMlT+Ig==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Sat, 16 May
 2026 12:58:51 +0200
Received: (nullmailer pid 651158 invoked by uid 1000);
	Sat, 16 May 2026 10:58:51 -0000
Date: Sat, 16 May 2026 12:58:51 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <linux-kernel@vger.kernel.org>, e521588
	<alessandro.schino@sbb.ch>
Subject: Re: [PATCH] esp: fix page frag reference leak on skb_to_sgvec failure
Message-ID: <aghN6yEFydKa9Ej0@secunet.com>
References: <20260516092001.679-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260516092001.679-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-01.secunet.de (10.32.0.171) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Queue-Id: 9FFA155B3EF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-288611-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[steffen.klassert@secunet.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[secunet.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

On Sat, May 16, 2026 at 11:20:01AM +0200, Alessandro Schino wrote:
> From: e521588 <alessandro.schino@sbb.ch>
> 
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
>   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
>   5. kfree_skb() only releases frag[0] (the new page), not the old ones
> 
> Fix this by introducing esp_ssg_unref_frags(), a variant of
> esp_ssg_unref() that unconditionally unrefs the source scatterlist
> frags without checking req->src and req->dst, since those fields are
> not yet initialized at this point. The new function is called before
> the goto error_free when the second skb_to_sgvec() fails, at which
> point the source scatterlist in tmp is fully populated.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> 
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
> ---
>  net/ipv4/esp4.c | 22 +++++++++++++++++++++-
>  net/ipv6/esp6.c | 22 +++++++++++++++++++++-
>  2 files changed, 42 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 5c4b162c1bb5..bc5245c6a29a 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -119,6 +119,26 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
>  				       skb->pp_recycle);
>  }
>  
> +static void esp_ssg_unref_frags(struct xfrm_state *x, void *tmp,
> +                                struct sk_buff *skb)
> +{
> +	struct crypto_aead *aead = x->data;
> +	int extralen = 0;
> +	u8 *iv;
> +	struct aead_request *req;
> +	struct scatterlist *sg;
> +
> +	if (x->props.flags & XFRM_STATE_ESN)
> +		extralen += sizeof(struct esp_output_extra);
> +
> +	iv = esp_tmp_iv(aead, tmp, extralen);
> +	req = esp_tmp_req(aead, iv);
> +
> +	for (sg = sg_next(req->src); sg; sg = sg_next(sg))
> +		skb_page_unref(page_to_netmem(sg_page(sg)),
> +			       skb->pp_recycle);
> +}

Sorry, I wasn't exactly precise. Instead of duplicating esp_ssg_unref()
it might make more sense to add a flag to esp_ssg_unref() and check
src and dst of the crypto request based on that flag.

