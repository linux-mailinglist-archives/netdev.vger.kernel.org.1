Return-Path: <netdev+bounces-292698-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNZYLk5IGGr2iQgAu9opvQ
	(envelope-from <netdev+bounces-292698-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:51:10 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 16D765F308A
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 15:51:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2193D30277FA
	for <lists+netdev@lfdr.de>; Thu, 28 May 2026 13:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D88D3E00AE;
	Thu, 28 May 2026 13:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="D31hQX0I";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="AtNXrsBs"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A36CD3CF977
	for <netdev@vger.kernel.org>; Thu, 28 May 2026 13:44:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779975864; cv=none; b=NJhcVXJ0d29WhCBTMUz1+9KeFk6Be1t7kxSq3Sabdtdlj9HZ3CMV+3vmsmyeiBTY75gG+mW/jZL2pMqI3VwbMWfJtbioZt7aK77d8LoHabvoG1VYptIPn/4mbSF6aOA+My/mi0DibnKHnecBfmBCfqpiPsUgj+lkIpMlFlrXfp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779975864; c=relaxed/simple;
	bh=VHaoDmgCkgTC0UcKu8H53Pd0FdmiriLBjfqSStS2ur4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=SgBfdAWWFYJKvqLlVEglMENEnPSJdhx8U8LqHAfjytfmIx8nLyg8Pfcf2A+KbapgQUE5gIJGW8uGu/yhPDLTmNFm7twjBnKqYo56FRaORAZI4Jwg9+uQ8Ec/41mjWiDs0/zR736rmdXIDo4QG3nr5I5rNFyiSMAgu4Zj/jEGkzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=D31hQX0I; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=AtNXrsBs; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779975861;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IwaHDMlFJk38IE4DVFS/xPewZFhWzBUixHbPcP51qO4=;
	b=D31hQX0IrCOEH8RNo+FxvbXVtNpku/Npb4opg3u97c4sIwTo/ygJ4vRGzNBQhhJwpH8996
	0AnD5jPbkWjR2Y0TSFrB4Mz5/sNzPk5xHdPEQHG66X1jEJSaEXdsVzAse5TmpBIKQPm6nS
	2Cx2fR6LnGEeB9Xk+FQ4SC6E7LwH0r4=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-607-8akXLEDnPZyyKVWAOk_oEA-1; Thu, 28 May 2026 09:44:18 -0400
X-MC-Unique: 8akXLEDnPZyyKVWAOk_oEA-1
X-Mimecast-MFC-AGG-ID: 8akXLEDnPZyyKVWAOk_oEA_1779975857
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-449b2a183d3so8143378f8f.0
        for <netdev@vger.kernel.org>; Thu, 28 May 2026 06:44:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779975857; x=1780580657; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IwaHDMlFJk38IE4DVFS/xPewZFhWzBUixHbPcP51qO4=;
        b=AtNXrsBsaR/yBxAdBIRgIiERHJd6H3dgfh9ehV4eXSZdFCLO8zY4mG2S23eEA0s1VR
         OwuDBfdmBPmu/Vh/Ma4XXRT4DpuOqsjzCB/XTvWwz5JuJCUa9C+7EeupZOzbAuZLWj1M
         HO5ZFvAkjASUhZJrhnxm5tiKf9sF1ddoOTDB7f50idwOTu6U7uSvEgU9KyLyhgF2jTfe
         BlWmE87D4/c4FdJRTpYBB3CpBu2y2Zkhe5QDNRcJ4zBmQstOkIuVKf6yvIgLhr68WEnd
         9xjWhs+4CMi90IvPAZHnIDqqkq2I7g2+Slw1TmWzwetKLOjQxEwW7ItQBpS7Xw/bFAks
         lYsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779975857; x=1780580657;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IwaHDMlFJk38IE4DVFS/xPewZFhWzBUixHbPcP51qO4=;
        b=Q5rmKYKCrt0Af+E1fFbrLMKa6Pf36Jebbt0s8QVMmgmQrsBDq1bAU/N1dbCQLPjvyr
         d1sU10wN3qCMdyvrgvezY39/3qQI02RGbVjUkq8bZKFd+ZHLqXvjy+A8Hus0RJL/YDRX
         j5NUtDRBDMPgdYv3kI8+AeU2N+ld+ajJwXC988Crt7wRs4OPakiB6n6chegPR2lwVcZ5
         hWTMAZdtaUN0XnGxTDLITzm/NeBlO9ynFuNx6hEMpJ/B/eByyINMSXPmLix4Nq4aFmoe
         FzqA31kpNdNd+EPz5O+x8kWLGDPRqQ2RibCDkIx6OnQ0Scd0PkOZCx/BNRyDGbYUcsTO
         hLrw==
X-Forwarded-Encrypted: i=1; AFNElJ+xkjwSZJfy+Cbklvv4pZOKTpL2rBhvTABfmDl6kSEBq5fKo5Y2BH9MKRuBc16oJFNtBzWcgs4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzg8GhM2gtOxkyckXNCF7Skdhl7viwjvQ68/w3nuDoElyth4FHR
	S/uyHHVhw+s2oY30juituq1p2KnAxpjhRR9zvLyDzFblec00VKKTQ+1wABP1vNFa8LCLTgSxx0P
	bikJo5ZUkqhtWARB19y9mg7TVzscpePR8+zD0QwAtLacec1RcT/4kn6DMbw==
X-Gm-Gg: Acq92OHSZ412ZbfM0QJkH7E9kj5D8CzOnpDMt5BCfc+oKTTEEdSosSkeWfPkDSMTWC4
	TFkDUXvWXTF0eju/IrFKDFNyuZZNalFygXTaoADLEqmzvESQyj9htHJAWKM4hpaSwSyQn4qeIgS
	Rl2S125JpI+lMurEh12dNiwo4ugYaF3ciM5a8uxv4I3rQRAECSfcSVIIDMy84lIs5TpBxegQwLf
	8iCJ9F4DcSWp/S3kINlFK+WKcy/CoBQ6G2yaEcmnqWuMW1p7uzNW3g02WjbidfXTBo4VCEphah1
	gqxOw0CYZM1teoxghA7L5uTe+t08Q2t9bwvRs3A8w0DC9pFMVHEVO0xAJ5CC3iq5+a4k1gluchD
	PPhJXDZ2TCNlxs3yNDoU5sdXXKE5RNoMIST0g3CetWVIrAH0OD0XtC+m15xJqs31auA==
X-Received: by 2002:a05:6000:4605:b0:45e:8e69:955a with SMTP id ffacd0b85a97d-45eeba0ce21mr2985063f8f.9.1779975856736;
        Thu, 28 May 2026 06:44:16 -0700 (PDT)
X-Received: by 2002:a05:6000:4605:b0:45e:8e69:955a with SMTP id ffacd0b85a97d-45eeba0ce21mr2985018f8f.9.1779975856277;
        Thu, 28 May 2026 06:44:16 -0700 (PDT)
Received: from [192.168.88.32] ([216.128.11.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45edb5b1a28sm13709292f8f.26.2026.05.28.06.44.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2026 06:44:15 -0700 (PDT)
Message-ID: <0902bdb9-2746-45fd-ba4d-8e5b96617b8b@redhat.com>
Date: Thu, 28 May 2026 15:44:14 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] esp: fix page frag reference leak on skb_to_sgvec
 failure
To: Steffen Klassert <steffen.klassert@secunet.com>,
 David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
 <20260527084148.3489759-6-steffen.klassert@secunet.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <20260527084148.3489759-6-steffen.klassert@secunet.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-292698-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 16D765F308A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/27/26 10:41 AM, Steffen Klassert wrote:
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
> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
> unconditionally unrefs the source scatterlist frags without checking
> req->src and req->dst, since those fields are not yet initialized by
> aead_request_set_crypt() at the point of the error. Existing callers
> pass false to preserve the original behavior.
> 
> The same issue exists in both esp4 and esp6 as the code is identical.
> 
> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
> 
> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
> ---
>  net/ipv4/esp4.c | 12 +++++++-----
>  net/ipv6/esp6.c | 12 +++++++-----
>  2 files changed, 14 insertions(+), 10 deletions(-)
> 
> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
> index 6a5febbdbee4..8314d7bddcb7 100644
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
> @@ -113,7 +113,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
>  	/* Unref skb_frag_pages in the src scatterlist if necessary.
>  	 * Skip the first sg which comes from skb->data.
>  	 */
> -	if (req->src != req->dst)
> +	if (already_unref || req->src != req->dst)
>  		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
>  			skb_page_unref(page_to_netmem(sg_page(sg)),
>  				       skb->pp_recycle);

Sashiko points the above is still unsafe:

---
When the new caller passes already_unref = true, can the loop still be
reached safely?
Looking at the allocation and request setup in esp_output_tail():
	tmp = esp_alloc_tmp(aead, esp->nfrags + 2, extralen);
	...
	req = esp_tmp_req(aead, iv);
	sg  = esp_req_sg(aead, req);
esp_alloc_tmp() calls kmalloc(len, GFP_ATOMIC) — the buffer is not
zeroed.
esp_tmp_req() only does aead_request_set_tfm(req, aead), which assigns
req->base.tfm. It does not touch req->src or req->dst.
The local variable sg is filled in by skb_to_sgvec(skb, sg, ...) but
nothing copies sg into req->src; that assignment is performed later by
aead_request_set_crypt(req, sg, dsg, ivlen + esp->clen, iv).
In the new error path the call sequence is:
	err = skb_to_sgvec(skb, dsg, ...);
	if (unlikely(err < 0)) {
		esp_ssg_unref(x, tmp, skb, true);   /* before set_crypt */
		goto error_free;
	}
	...
	aead_request_set_crypt(req, sg, dsg, ivlen + esp->clen, iv);
Inside esp_ssg_unref() with already_unref = true, the predicate is
short-circuited but the loop body still dereferences req->src:
	if (already_unref || req->src != req->dst)
		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
			skb_page_unref(page_to_netmem(sg_page(sg)),
				       skb->pp_recycle);
Since req->src has not been initialized at this point (the kmalloc
buffer holds whatever was there before, and aead_request_set_crypt()
has not yet run), sg_next(req->src) walks an arbitrary pointer,
sg_page(sg) reads sg->page_link from arbitrary memory, and
skb_page_unref(page_to_netmem(...), ...) then drops a refcount on a
fabricated page.
The commit message also seems to acknowledge this:
    Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
    unconditionally unrefs the source scatterlist frags without checking
    req->src and req->dst, since those fields are not yet initialized by
    aead_request_set_crypt() at the point of the error.
If req->src/req->dst are not yet initialized, how can the loop
sg = sg_next(req->src) be valid?  Should the helper instead walk the
local sg returned by esp_req_sg(aead, req) (which was actually
populated by the first skb_to_sgvec()), or should
aead_request_set_crypt() be moved before the failure check so that
req->src/req->dst are well defined?
The same construct appears in net/ipv6/esp6.c:
---

And the SoB is incorrect for this patch. Do you rebase your tree? (I'm
not suggesting starting that otherwise!!!) If so you could possibly drop
this patch ?!?

/P


