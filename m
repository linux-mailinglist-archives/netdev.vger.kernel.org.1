Return-Path: <netdev+bounces-293017-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KFOYDxE+GWpVtAgAu9opvQ
	(envelope-from <netdev+bounces-293017-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:19:45 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F8DD5FE6C7
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 09:19:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 49371307AE6E
	for <lists+netdev@lfdr.de>; Fri, 29 May 2026 07:14:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F533AE6E6;
	Fri, 29 May 2026 07:14:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+V68Tla";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="gy/uHAGa"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A3493AF641
	for <netdev@vger.kernel.org>; Fri, 29 May 2026 07:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780038876; cv=none; b=YT1L0ABPJ9s0IkI/PSap7nIPF5KqaT5INob1YmmpLAk81LiPM43/ToIL9w5Mue2BiQBRbDPoevMjTAOpQmT2aS+N6UokaCwh7cy0bLEajoJ/TEKqegC94h+6diwlPzOS/0R5k7yfTTvGzPXSPmbtsF2e6ZaRaXIotmstU7AsylI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780038876; c=relaxed/simple;
	bh=AyodW9s6qr7nPQ5UzSde6U08bmL5XV5Bya4M0hb664s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pkYwC3z52Mj7hJMTnT9+yjE1Gk5Z38/8f4a5Hax0+f6zDa1YRVI1In+uwXd5zCu7HpaAzsWwaid9/RhCwbFDf/fLxjsAeZcRoizGSwLxxv7TwkSzN6y4cqzqeeOuxuuqDXuBMM3+pf67bhwPU2hvYPm35zQN2yc/BgiPjnEJfqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+V68Tla; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=gy/uHAGa; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780038874;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GpgwVwtTE1d0hUiN+aFsOjG2i9VgukmbDWuVMcl4U4I=;
	b=R+V68TlaeBX5pBAweR/Tqb8QAWZopQliqhgQbkuso/R76bt4i8sFMSmWXclsTz+2SsekNl
	C/5IpjmmauaCNNVQDa1WNhQAKwgNiSPzBYLS8+NsdWcNHqMqusLKZZrMIBZ5G6CZHc87mO
	DYQWAp22n7dVcOjssqngg+2MI61dXS4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-ON7eCCHvMBm-YhL_nlqrLg-1; Fri, 29 May 2026 03:14:32 -0400
X-MC-Unique: ON7eCCHvMBm-YhL_nlqrLg-1
X-Mimecast-MFC-AGG-ID: ON7eCCHvMBm-YhL_nlqrLg_1780038871
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef3aeeb41so86339f8f.1
        for <netdev@vger.kernel.org>; Fri, 29 May 2026 00:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1780038871; x=1780643671; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GpgwVwtTE1d0hUiN+aFsOjG2i9VgukmbDWuVMcl4U4I=;
        b=gy/uHAGazB/WoP+A3X1RX6B0U8xh/cQ+Hz66rRX50cDcemvgLPXnEXy2rsCOh3APkD
         goNHwerl/jUt4O7pHRXCfWmY24CXaVhUF47yCy+5VhrDVMzKe/WVnU6WS83vqYKSwv7q
         FhtIdgqMBPZbECDFIUU34EX2nLXIGQRIHNCH/x3+DOR9xcC0+EDi3b7XZzEQVTRI/XzN
         ius13rLBI4oCT6HuFduvbMzsgbz7RnkZoIBLVOKLcuS+3R7POxJYonZ/n27pOWzMXs0C
         piEGFBP1LEt078Zm1eK6AOts6SNdJklBncOhjcg7FrMCEELy8bcs6BUPAzMq3q+WrzLv
         tMeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780038871; x=1780643671;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpgwVwtTE1d0hUiN+aFsOjG2i9VgukmbDWuVMcl4U4I=;
        b=pdp877+5wkULcPydJiFRw25CtAa54tu6xprTtn9dfnO/YKZuFkBJO4fGWWWfUehE9h
         mBsU8wYTsNESo6iq5Roux7YanawWB5vPPUOP58yRqPbs9CLPdlec97wJfHoKFC3px7bQ
         EJRqpH6QQBKFWvNEXZYOFZi//d8XqYksE1Z0u3NEPEwPtWq3OxqO3VuSgCETthVvBa8q
         137JZnd/rM2pOjJsvmhx5jFm24zgriQr3gEpUP7CgVgjJVOfMeCI8V+LYTY6mUWp+6Ww
         OqcYrTFyvZco64uFg0PG7j8BA1fB2J0MW/ahEgXqOh0iQ6WiKm7W3gm0gcd4DoOyRTwz
         C56Q==
X-Forwarded-Encrypted: i=1; AFNElJ+SHRTK/EtJlpNsQ/Wkez3JQg8ZW0WoPHlmsPr5KVp+sjnrsKQ51sCGFibtYvcciAxl87kmHLQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzhffRU86DpJIT1eIvrkzyqSqkiVVBL+HCze253iP3Lna5AVFcA
	fJWPeGwcngbk9dfavzARYCuTdlpGMO/BZ7sXxFJd4/4xsQRbTyg0BRszpp/9T6ZgyUopHQqNR00
	RR3nGU9wh5voIGWeAgWLnbQfDBClriXuzzecOH6e8UcnwwhUNIInioOSJV+q9e9FSMw==
X-Gm-Gg: Acq92OFXftNKPiCYgUveDBhyXg+TveEu5WhbiODQ+IEz9jSosZIFg30XAhfE1ai9ZKu
	C/jRo1OhaompiOvzw94Dki5Px7LS2phkU4sQL5vZLusHuCui12JCPK0Mq5J5HVe4AqEBiSnTXg2
	VjqCC2kCPpETfxoHeVeodR9yTkeVfFoWc1wHqp6RaR2SN8S/tY0SGDJpCZ9Vk/1lK3+ydbruM6B
	AL8uZ0T11Jrw0PaJRSDmF2wuVV+HJvvcy4NJxPBAkQPutfskpfGXXAOJtmCxsjSM0CkwwylKhmZ
	OBrIMsc3to78j6Kv19htzkElWUgDS3jSkKSa2ScOlN59KGAocRYBWB1LgLmjlWRvdoK+bDvG4N6
	Q18Y+i2MXPoX6W8kOHm6KKqYAmNyTRT1T2XuE2FOp7Bt8s28NGPIFlv5H9wP90WDWn2A=
X-Received: by 2002:a05:6000:2081:b0:45e:e561:4184 with SMTP id ffacd0b85a97d-45ef1449478mr2666373f8f.29.1780038870759;
        Fri, 29 May 2026 00:14:30 -0700 (PDT)
X-Received: by 2002:a05:6000:2081:b0:45e:e561:4184 with SMTP id ffacd0b85a97d-45ef1449478mr2666313f8f.29.1780038870253;
        Fri, 29 May 2026 00:14:30 -0700 (PDT)
Received: from [192.168.88.32] ([150.228.93.150])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45ef34a0374sm1304412f8f.2.2026.05.29.00.14.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2026 00:14:29 -0700 (PDT)
Message-ID: <e7124e98-5633-4982-a850-8787c3949174@redhat.com>
Date: Fri, 29 May 2026 09:14:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/9] esp: fix page frag reference leak on skb_to_sgvec
 failure
To: Steffen Klassert <steffen.klassert@secunet.com>
Cc: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
 Herbert Xu <herbert@gondor.apana.org.au>, netdev@vger.kernel.org,
 Alessandro Schino <7991aleschino@gmail.com>
References: <20260527084148.3489759-1-steffen.klassert@secunet.com>
 <20260527084148.3489759-6-steffen.klassert@secunet.com>
 <0902bdb9-2746-45fd-ba4d-8e5b96617b8b@redhat.com>
 <ahkphzYYBeoCcbRI@secunet.com>
From: Paolo Abeni <pabeni@redhat.com>
Content-Language: en-US
In-Reply-To: <ahkphzYYBeoCcbRI@secunet.com>
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
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[davemloft.net,kernel.org,gondor.apana.org.au,vger.kernel.org,gmail.com];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-293017-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sbb.ch:email,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,secunet.com:email]
X-Rspamd-Queue-Id: 8F8DD5FE6C7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/29/26 7:52 AM, Steffen Klassert wrote:
> Ccing the author of this patch.
> 
> On Thu, May 28, 2026 at 03:44:14PM +0200, Paolo Abeni wrote:
>> On 5/27/26 10:41 AM, Steffen Klassert wrote:
>>> From: e521588 <alessandro.schino@sbb.ch>
>>>
>>> In esp_output_tail(), when esp->inplace is false, the old skb page frags
>>> are replaced with a new page from the xfrm page_frag cache. The source
>>> scatterlist (sg) is built from the old frags before the replacement, and
>>> esp_ssg_unref() is responsible for releasing the old page references
>>> after the crypto operation completes.
>>>
>>> However, if the second skb_to_sgvec() call (which builds the destination
>>> scatterlist from the new page) fails, the code jumps to error_free which
>>> only calls kfree(tmp). The old page frag references captured in the
>>> source scatterlist are never released:
>>>
>>>   1. sg[] is built from old frags via skb_to_sgvec() (no extra get_page)
>>>   2. nr_frags is set to 1 and frag[0] is replaced with the new page
>>>   3. Second skb_to_sgvec() fails -> goto error_free
>>>   4. kfree(tmp) frees the sg[] memory but old frags are not unref'd
>>>   5. kfree_skb() only releases frag[0] (the new page), not the old ones
>>>
>>> Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
>>> unconditionally unrefs the source scatterlist frags without checking
>>> req->src and req->dst, since those fields are not yet initialized by
>>> aead_request_set_crypt() at the point of the error. Existing callers
>>> pass false to preserve the original behavior.
>>>
>>> The same issue exists in both esp4 and esp6 as the code is identical.
>>>
>>> Fixes: cac2661c53f3 ("esp4: Avoid skb_cow_data whenever possible")
>>> Fixes: 03e2a30f6a27 ("esp6: Avoid skb_cow_data whenever possible")
>>>
>>> Signed-off-by: Alessandro Schino <7991aleschino@gmail.com>
>>> Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
>>> ---
>>>  net/ipv4/esp4.c | 12 +++++++-----
>>>  net/ipv6/esp6.c | 12 +++++++-----
>>>  2 files changed, 14 insertions(+), 10 deletions(-)
>>>
>>> diff --git a/net/ipv4/esp4.c b/net/ipv4/esp4.c
>>> index 6a5febbdbee4..8314d7bddcb7 100644
>>> --- a/net/ipv4/esp4.c
>>> +++ b/net/ipv4/esp4.c
>>> @@ -96,7 +96,7 @@ static inline struct scatterlist *esp_req_sg(struct crypto_aead *aead,
>>>  			     __alignof__(struct scatterlist));
>>>  }
>>>  
>>> -static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
>>> +static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb, bool already_unref)
>>>  {
>>>  	struct crypto_aead *aead = x->data;
>>>  	int extralen = 0;
>>> @@ -113,7 +113,7 @@ static void esp_ssg_unref(struct xfrm_state *x, void *tmp, struct sk_buff *skb)
>>>  	/* Unref skb_frag_pages in the src scatterlist if necessary.
>>>  	 * Skip the first sg which comes from skb->data.
>>>  	 */
>>> -	if (req->src != req->dst)
>>> +	if (already_unref || req->src != req->dst)
>>>  		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
>>>  			skb_page_unref(page_to_netmem(sg_page(sg)),
>>>  				       skb->pp_recycle);
>>
>> Sashiko points the above is still unsafe:
> 
> For the original patch submission, sashiko reported 'failed
> to apply' because it was targeted to the ipsec tree. Now
> with the full pull request it applied and it found issues,
> but now it is too late for me to fix this.
> 
> Would it be possible to integrate subtrees of net and net-next
> into the netdev CI? This would avoid such problems in future.
> 
>> ---
>> When the new caller passes already_unref = true, can the loop still be
>> reached safely?
>> Looking at the allocation and request setup in esp_output_tail():
>> 	tmp = esp_alloc_tmp(aead, esp->nfrags + 2, extralen);
>> 	...
>> 	req = esp_tmp_req(aead, iv);
>> 	sg  = esp_req_sg(aead, req);
>> esp_alloc_tmp() calls kmalloc(len, GFP_ATOMIC) — the buffer is not
>> zeroed.
>> esp_tmp_req() only does aead_request_set_tfm(req, aead), which assigns
>> req->base.tfm. It does not touch req->src or req->dst.
>> The local variable sg is filled in by skb_to_sgvec(skb, sg, ...) but
>> nothing copies sg into req->src; that assignment is performed later by
>> aead_request_set_crypt(req, sg, dsg, ivlen + esp->clen, iv).
>> In the new error path the call sequence is:
>> 	err = skb_to_sgvec(skb, dsg, ...);
>> 	if (unlikely(err < 0)) {
>> 		esp_ssg_unref(x, tmp, skb, true);   /* before set_crypt */
>> 		goto error_free;
>> 	}
>> 	...
>> 	aead_request_set_crypt(req, sg, dsg, ivlen + esp->clen, iv);
>> Inside esp_ssg_unref() with already_unref = true, the predicate is
>> short-circuited but the loop body still dereferences req->src:
>> 	if (already_unref || req->src != req->dst)
>> 		for (sg = sg_next(req->src); sg; sg = sg_next(sg))
>> 			skb_page_unref(page_to_netmem(sg_page(sg)),
>> 				       skb->pp_recycle);
>> Since req->src has not been initialized at this point (the kmalloc
>> buffer holds whatever was there before, and aead_request_set_crypt()
>> has not yet run), sg_next(req->src) walks an arbitrary pointer,
>> sg_page(sg) reads sg->page_link from arbitrary memory, and
>> skb_page_unref(page_to_netmem(...), ...) then drops a refcount on a
>> fabricated page.
>> The commit message also seems to acknowledge this:
>>     Fix this by adding a bool parameter to esp_ssg_unref() that, when true,
>>     unconditionally unrefs the source scatterlist frags without checking
>>     req->src and req->dst, since those fields are not yet initialized by
>>     aead_request_set_crypt() at the point of the error.
>> If req->src/req->dst are not yet initialized, how can the loop
>> sg = sg_next(req->src) be valid?  Should the helper instead walk the
>> local sg returned by esp_req_sg(aead, req) (which was actually
>> populated by the first skb_to_sgvec()), or should
>> aead_request_set_crypt() be moved before the failure check so that
>> req->src/req->dst are well defined?
>> The same construct appears in net/ipv6/esp6.c:
>> ---
>>
>> And the SoB is incorrect for this patch. Do you rebase your tree? (I'm
>> not suggesting starting that otherwise!!!) If so you could possibly drop
>> this patch ?!?
> 
> No, I never rebased the ipsec tree so far. I could revert it, or you can
> do so if you don't accept the patch as is. Rebasing would be the last
> resort as this creates problems for everyone who cloned my tree.

Sure, I just could not remember if xfrm tree was usually rebased or not.
A revert or an incremental patch are just fine.

/P



