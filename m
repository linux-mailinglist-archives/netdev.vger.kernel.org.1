Return-Path: <netdev+bounces-294714-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id iewfC8AJIGogugAAu9opvQ
	(envelope-from <netdev+bounces-294714-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:02:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7737B636CB9
	for <lists+netdev@lfdr.de>; Wed, 03 Jun 2026 13:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=secunet.com header.s=202301 header.b=l1jlTbwA;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-294714-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-294714-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=secunet.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0C1F304A8CB
	for <lists+netdev@lfdr.de>; Wed,  3 Jun 2026 10:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784CF3CCA11;
	Wed,  3 Jun 2026 10:58:10 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx1.secunet.com (mx1.secunet.com [62.96.220.36])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742993AB482;
	Wed,  3 Jun 2026 10:58:08 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780484290; cv=none; b=ZBteQd+1hsE20P0NeXucYUH/PH5BD109n23zZ8pCarGfLa/5OADI4W/qG9O1oRj/WojJmxwifV0f84zDiXV095tIA2771ton+iKgRZgKIcn1gl/Fr4CENeLxMkD2Rrn7cikHZ8M7f3503yChoVQC9Y854YBy7Ayp7URSlhO+Q90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780484290; c=relaxed/simple;
	bh=kPDU3xfYprAjGu4n0CFmoBNElqvioUcz7b1ZVCVBhjE=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3QACK5IHD/wOUNjpGUMtRSNd9SL6aRYxABpH0abRwe+Gmxs+Lc70Qni9bIxZ3MMq2UtWSe9fTfQ0WqU5CpT6rFt2QyQVVH9pwFfIxj3kolzx6nnX4GMeFFOMHQ8l+9xysvEOoYNEo+Bpus/7o8nbQBeU8mHCjZ5g9DINqg2JZE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=secunet.com; spf=pass smtp.mailfrom=secunet.com; dkim=pass (2048-bit key) header.d=secunet.com header.i=@secunet.com header.b=l1jlTbwA; arc=none smtp.client-ip=62.96.220.36
Received: from localhost (localhost [127.0.0.1])
	by mx1.secunet.com (Postfix) with ESMTP id AD43D201E4;
	Wed,  3 Jun 2026 12:58:06 +0200 (CEST)
X-Virus-Scanned: by secunet
Received: from mx1.secunet.com ([127.0.0.1])
 by localhost (mx1.secunet.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5199KdRImnJU; Wed,  3 Jun 2026 12:58:06 +0200 (CEST)
Received: from EXCH-01.secunet.de (rl1.secunet.de [10.32.0.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.secunet.com (Postfix) with ESMTPS id F0E3020185;
	Wed,  3 Jun 2026 12:58:05 +0200 (CEST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mx1.secunet.com F0E3020185
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=secunet.com;
	s=202301; t=1780484286;
	bh=88vfyAI5BxlYrHH4ipjrMq+DkRlkWfuHHgJg1xonYC0=;
	h=Date:From:To:CC:Subject:References:In-Reply-To:From;
	b=l1jlTbwAnSBJdefmwNF+5UnPZC+sSO/I7cRwi2iRQ+USK7moSihUldUct9FPx7v94
	 frL1ieLBeQ3H6o/P0af21cYUDhwApp0Nno3QLF+5EEJz7/OoSeW4gMz46k3WSj6pUX
	 CzYAiW4QMpXzghblK9mPmFCrXjQS5IhF5936RA9LsUiDWjjp+F70NB2XYQCsIvegtB
	 hYSd0+cgmHnavzEfvgThUmMJWuV2nq0EtSzn9r5OklahhtxoqPFpjPGdaZhuU3gXG7
	 i7sf7W7gnHkICd1awW6jOAhzLnWR7aj8eDE+/Zaj06Sy0jkef1Z5+st9f3kn0ueQQl
	 ud9MAiiytaQ8A==
Received: from secunet.com (10.182.7.193) by EXCH-01.secunet.de (10.32.0.171)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 3 Jun
 2026 12:58:05 +0200
Received: (nullmailer pid 1858503 invoked by uid 1000);
	Wed, 03 Jun 2026 10:58:05 -0000
Date: Wed, 3 Jun 2026 12:58:05 +0200
From: Steffen Klassert <steffen.klassert@secunet.com>
To: Alessandro Schino <7991aleschino@gmail.com>
CC: <netdev@vger.kernel.org>, <herbert@gondor.apana.org.au>,
	<davem@davemloft.net>, <pabeni@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH ipsec] esp: fix page frag reference leak on skb_to_sgvec
 failure
Message-ID: <aiAIvUX8a43ci-DF@secunet.com>
References: <20260601134526.82-1-7991aleschino@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20260601134526.82-1-7991aleschino@gmail.com>
X-ClientProxiedBy: EXCH-02.secunet.de (10.32.0.172) To EXCH-01.secunet.de
 (10.32.0.171)
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[secunet.com,none];
	R_DKIM_ALLOW(-0.20)[secunet.com:s=202301];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
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
	TAGGED_FROM(0.00)[bounces-294714-lists,netdev=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7737B636CB9

On Mon, Jun 01, 2026 at 03:45:25PM +0200, Alessandro Schino wrote:
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
>  net/ipv4/esp4.c | 14 ++++++++------
>  net/ipv6/esp6.c | 14 ++++++++------
>  2 files changed, 16 insertions(+), 12 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 513c8215c947..2429c7845984 100644
> --- a/net/ipv4/esp4.c
> +++ b/net/ipv4/esp4.c
> @@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
>  			     __alignof__(struct scatterlist));
>  }
>  
> -static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
> +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
>  {
>  	struct crypto_aead *aead = x->data;
>  	int extralen = 0;
> @@ -113,8 +113,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
>  	/* Unref skb_frag_pages in the src scatterlist if necessary.
>  	 * Skip the first sg which comes from skb->data.
>  	 */
> -	if (req->src != req->dst)
> -		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
> +	if (already_unref || req->src != req->dst)
> +		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
>  			skb_page_unref(page_to_netmem(sg_page(sg)),
>  				       skb->pp_recycle);
>  }
> @@ -220,7 +220,7 @@ static void esp_output_done(void *data, int err)
>  	}
>  
>  	tmp = ESP_SKB_CB(skb)->tmp;
> -	esp_ssg_unref(x, tmp, skb);
> +	esp_ssg_unref(x, tmp, skb, false);
>  	kfree(tmp);
>  
>  	if (xo && (xo->flags & XFRM_DEV_RESUME)) {
> @@ -569,8 +569,10 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
>  		err = skb_to_sgvec(skb, dsg,
>  			           (unsigned char *)esph - skb->data,
>  			           assoclen + ivlen + esp->clen + alen);
> -		if (unlikely(err < 0))
> +		if (unlikely(err < 0)) {
> +			esp_ssg_unref(x, tmp, skb, true);
>  			goto error_free;
> +		}
>  	}
>  
>  	if ((x->props.flags & XFRM_STATE_ESN))
> @@ -602,7 +604,7 @@ int esp_output_tail(struct xfrm_state *x, struct sk_buff *skb, struct esp_info *
>  	}
>  
>  	if (sg != dsg)
> -		esp_ssg_unref(x, tmp, skb);
> +		esp_ssg_unref(x, tmp, skb, false);
>  
>  	if (!err && x->encap && x->encap->encap_type == TCP_ENCAP_ESPINTCP)
>  		err = esp_output_tail_tcp(x, skb);
> diff --git a/net/ipv6/esp6.c b/net/ipv6/esp6.c
> index 57481e423e59..50af6ab9b8fc 100644
> --- a/net/ipv6/esp6.c
> +++ b/net/ipv6/esp6.c
> @@ -113,7 +113,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
>  			     __alignof__(struct scatterlist));
>  }
>  
> -static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
> +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
>  {
>  	struct crypto_aead *aead = x->data;
>  	int extralen = 0;
> @@ -130,8 +130,8 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
>  	/* Unref skb_frag_pages in the src scatterlist if necessary.
>  	 * Skip the first sg which comes from skb->data.
>  	 */
> -	if (req->src != req->dst)
> -		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
> +	if (already_unref || req->src != req->dst)
> +		for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))
>  			skb_page_unref(page_to_netmem(sg_page(sg)),
>  				       skb->pp_recycle);
>  }

Now checkpatch complains about this:

WARNING: line length of 106 exceeds 100 columns
#21: FILE: net/ipv4/esp4.c:117:
+               for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))

WARNING: line length of 106 exceeds 100 columns
#75: FILE: net/ipv6/esp6.c:134:
+               for (sg = sg_next(already_unref ? esp_req_sg(aead, req) : req->src); sg; sg = sg_next(sg))


This is not a big issue, but it makes the code unreadable
over time.

Please check your patches before you send it.

