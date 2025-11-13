Return-Path: <netdev+bounces-238252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC3CC56566
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 09:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C5B2F3513B5
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 08:39:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B9CE33437B;
	Thu, 13 Nov 2025 08:37:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="aesMCvoo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F505331A4E
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763023056; cv=none; b=Ukrl5KLWLCvOmEADXZtBRq13rlLqI3C9poL136tL6KdSNIFF/ZuRLLoEeu22RvpSWoyk0fp4z2oSQWXEZ4q9Sh98QIGayln2HeVZppu6csLnOkZorLPSde8+neRUCQZT/YBfZ4ehjupg2mNNEvPqnP0w3C+k/0kA3WGUx4YHHNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763023056; c=relaxed/simple;
	bh=Y8ujME5YPq+z8mYj6Yta+rJHrlWOzEAhgEDFwFYlHpU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=BFO7VLGGZs6e09QcEts5O9wg3AYisEiZ7usoAIgpMMh3p9AzvGzwQ8Yw9z/WvE2A1CzDxknBoBjBvPjmKhDz9VGMvJIOPg3G+VUyB/J9SYB113IHZrPt62ywYfE7Y5sPum9zKq2CrVFbnBVEQSDxWuHoqC62q2GlynokSXkHzKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=aesMCvoo; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-64175dfc338so969864a12.0
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 00:37:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1763023051; x=1763627851; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=PaRdo5laVENx0qNWKIj3e2Wj2YB7pYrMnrhNZ1Af824=;
        b=aesMCvoo0RY0c3AQJD9PoEptkoC87JuWMMebH5J65n9pFvzNMLroT9ztFFVegpEUsD
         ELOI97dkQJOH42/Ao17gyDAv97HqBn0DwYxyPX0OpU9sb4wdRAE4OiKgUXx+v/44+0e4
         oCYwQim7vTR2Wz1hCtrvGRrN6J9uidVJ4Ow1t/Oe+7XJwvkRVEEccBvt36IXqvojmuwd
         iK9kCk/sE49BhEsU3IHR+t331eEOyXDvY0Y84A0fRk6/IkLUXHgw+/GBwi9vJk9fyY6U
         5BK9Gvj1eZa3i0IrZM+J986SvJzS107Otnc3dsuYmz1RkQWq6mcOoaZxjtYenk3kUi0q
         9f0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763023051; x=1763627851;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PaRdo5laVENx0qNWKIj3e2Wj2YB7pYrMnrhNZ1Af824=;
        b=XTxOsISuj1EwKTcuyOzmVoxJHKmPi/NEN0U7FIZYcUEOt3w9gJfuRHP7kkdQegDYoz
         Ojn9CmR52Onx0bCjkY3/jJNcks3FmFMt0S83LMdeoSC6CUMxMqVZSBYVhZIKdhxxpAEU
         WmacMRJUwmyDbynpJljhHXRRErJf5/vkb1+NxItKvV0/0Rw8p+zvzIzWnvU9wg3MkAWd
         klT9diPWxhJIPpuqSBE2FaSsesLPsb9GeQ3avauMjceA9KbQ2Xi4ppCysgfHhK3cGq0c
         wHp2vdAyKNEgyTQ/PQJH5HyxuCVuKbZQ7QyyrriIHs4g6IdRxv0DojAnnDAZCRtx2Trz
         mxqg==
X-Gm-Message-State: AOJu0Yw5psC7p7B050fxlSo2cOQFpuliyZzbBfXArcu/4nvfsHbheKB+
	8rplt0dPa1DZ2tykoJ4p9Zt891NERrvrsaNdaxcesUkSNMJ+wI9t5vlFY+qsQIdFXUMsiMBak2h
	AEx3nr11dIS6zOcMykS4bP/YQacT6b+9t7RHJCV5b0VzNbbAbHTIegMGmBs0hrOSFlGo=
X-Gm-Gg: ASbGncuz+OicpI4dcF1vg4jOyasRDvAz7jqXscVn49CmJsUjoZlApb8I8sg8t1s9rVe
	jqACLlamWBRciGoQj4z6Pshf24wp+kKYNsuwUORz0OIbrlyH6B4XfVZR6Mi7+dWGFzy2QLdwgXn
	6CVoktQTLppYA7ZfnCuayb/sF7yg4FZyCE9SJuIEzl/NsHdB5J+8KyXSXOiC0CKiAuqhaQjDtRR
	ECB0GjrSikW25X6tZJqodFe+C/fv7pySnp8eyYuVfmHE0YQGrmzbsQX+0z9RpgG9Di42GZuvBWR
	8xhA4I5oZrmzUvixERFSa0tfpn7KT6FSxvaQpUmsgzOs1Lk37NjubxZXaTvDLzqC62qZ/vZUxTr
	V4Q7DTXfW7m+R7sE0Ce/mYzR/R00WmHxD6Lg6u6CRE6PrhDPPvIlDvU7mR2jE+BossiheRIz+dX
	uKkGgD9zN9xH2FeJWZvRYeo+t+UYcGouwtx7A3mwQ=
X-Google-Smtp-Source: AGHT+IGh1I6xM2zO8re4VXPeusjhFgRnAF9eS/Gl7OMH50kJVFWZekU4Id4X8gsG6WzkOr1tZkNsyg==
X-Received: by 2002:a05:6402:909:b0:63c:1170:656a with SMTP id 4fb4d7f45d1cf-6431a586af8mr5359346a12.37.1763023051378;
        Thu, 13 Nov 2025 00:37:31 -0800 (PST)
Received: from ?IPV6:2001:67c:2fbc:1:7016:8c92:f4ad:3b7b? ([2001:67c:2fbc:1:7016:8c92:f4ad:3b7b])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6433a3f8e6dsm941233a12.10.2025.11.13.00.37.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Nov 2025 00:37:30 -0800 (PST)
Message-ID: <ffe3eb53-ac49-4049-8508-bd4ffe890ce2@openvpn.net>
Date: Thu, 13 Nov 2025 09:37:29 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 6/8] ovpn: consolidate crypto allocations in one
 chunk
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Ralf Lici <ralf@mandelbit.com>
References: <20251111214744.12479-1-antonio@openvpn.net>
 <20251111214744.12479-7-antonio@openvpn.net> <aRS13OqKdhx4aVRo@krikkit>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <aRS13OqKdhx4aVRo@krikkit>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Sabrina,

On 12/11/2025 17:29, Sabrina Dubroca wrote:
> 2025-11-11, 22:47:39 +0100, Antonio Quartulli wrote:
>> From: Ralf Lici <ralf@mandelbit.com>
>>
>> Currently ovpn uses three separate dynamically allocated structures to
>> set up cryptographic operations for both encryption and decryption. This
>> adds overhead to performance-critical paths and contribute to memory
>> fragmentation.
>>
>> This commit consolidates those allocations into a single temporary blob,
>> similar to what esp_alloc_temp() does.
> 
> nit: esp_alloc_tmp (no 'e')
> 
>> The resulting performance gain is +7.7% and +4.3% for UDP when using AES
>> and ChaChaPoly respectively, and +4.3% for TCP.
> 
> Nice improvement! I didn't think it would be that much.

Yep! Quite impressive.

> 
> 
>> Signed-off-by: Ralf Lici <ralf@mandelbit.com>
>> Signed-off-by: Antonio Quartulli <antonio@openvpn.net>
> 
> BTW, I didn't see any of these patches posted on the openvpn-devel
> list or on netdev before this pull request. Otherwise I'd have
> reviewed them earlier.

You're right. I worked with Ralf to get this patch done and I directly 
pulled it in my tree.

Next time we will make sure all patches land on the openvpn-devel 
mailing list before being staged for net-next.

This said, Ralf will get back to you on the questions below.

Thanks!

Regards,

> 
> 
>>   drivers/net/ovpn/crypto_aead.c | 151 +++++++++++++++++++++++++--------
>>   drivers/net/ovpn/io.c          |   8 +-
>>   drivers/net/ovpn/skb.h         |  13 ++-
>>   3 files changed, 129 insertions(+), 43 deletions(-)
>>
>> diff --git a/drivers/net/ovpn/crypto_aead.c b/drivers/net/ovpn/crypto_aead.c
>> index cb6cdf8ec317..9ace27fc130a 100644
>> --- a/drivers/net/ovpn/crypto_aead.c
>> +++ b/drivers/net/ovpn/crypto_aead.c
>> @@ -36,6 +36,105 @@ static int ovpn_aead_encap_overhead(const struct ovpn_crypto_key_slot *ks)
>>   		crypto_aead_authsize(ks->encrypt);	/* Auth Tag */
>>   }
>>   
>> +/*
> 
> nit: missing a 2nd * to make it kdoc?
> 
>> + * ovpn_aead_crypto_tmp_size - compute the size of a temporary object containing
>> + *			       an AEAD request structure with extra space for SG
>> + *			       and IV.
>> + * @tfm: the AEAD cipher handle
>> + * @nfrags: the number of fragments in the skb
>> + *
>> + * This function calculates the size of a contiguous memory block that includes
>> + * the initialization vector (IV), the AEAD request, and an array of scatterlist
>> + * entries. For alignment considerations, the IV is placed first, followed by
>> + * the request, and then the scatterlist.
>> + * Additional alignment is applied according to the requirements of the
>> + * underlying structures.
>> + *
>> + * Return: the size of the temporary memory that needs to be allocated
>> + */
>> +static unsigned int ovpn_aead_crypto_tmp_size(struct crypto_aead *tfm,
>> +					      const unsigned int nfrags)
>> +{
>> +	unsigned int len = crypto_aead_ivsize(tfm);
>> +
>> +	if (likely(len)) {
> 
> Is that right?
> 
> Previously iv was reserved with a constant size (OVPN_NONCE_SIZE), and
> we're always going to write some data into ->iv via
> ovpn_pktid_aead_write, but now we're only reserving the crypto
> algorithm's IV size (which appear to be 12, ie OVPN_NONCE_SIZE, for
> both chachapoly and gcm(aes), so maybe it doesn't matter).
> 
> 
>> @@ -71,13 +171,15 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>>   	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
>>   		return -ENOSPC;
>>   
>> -	/* sg may be required by async crypto */
>> -	ovpn_skb_cb(skb)->sg = kmalloc(sizeof(*ovpn_skb_cb(skb)->sg) *
>> -				       (nfrags + 2), GFP_ATOMIC);
>> -	if (unlikely(!ovpn_skb_cb(skb)->sg))
>> +	/* allocate temporary memory for iv, sg and req */
>> +	tmp = kmalloc(ovpn_aead_crypto_tmp_size(ks->encrypt, nfrags),
>> +		      GFP_ATOMIC);
>> +	if (unlikely(!tmp))
>>   		return -ENOMEM;
>>   
>> -	sg = ovpn_skb_cb(skb)->sg;
>> +	iv = ovpn_aead_crypto_tmp_iv(ks->encrypt, tmp);
>> +	req = ovpn_aead_crypto_tmp_req(ks->encrypt, iv);
>> +	sg = ovpn_aead_crypto_req_sg(ks->encrypt, req);
>>   
>>   	/* sg table:
>>   	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+OVPN_NONCE_WIRE_SIZE),
>> @@ -105,13 +207,6 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>>   	if (unlikely(ret < 0))
>>   		return ret;
>>   
>> -	/* iv may be required by async crypto */
>> -	ovpn_skb_cb(skb)->iv = kmalloc(OVPN_NONCE_SIZE, GFP_ATOMIC);
>> -	if (unlikely(!ovpn_skb_cb(skb)->iv))
>> -		return -ENOMEM;
>> -
>> -	iv = ovpn_skb_cb(skb)->iv;
>> -
>>   	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
>>   	 * nonce
>>   	 */
>> @@ -130,11 +225,7 @@ int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>>   	/* AEAD Additional data */
>>   	sg_set_buf(sg, skb->data, OVPN_AAD_SIZE);
>>   
>> -	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
>> -	if (unlikely(!req))
>> -		return -ENOMEM;
>> -
>> -	ovpn_skb_cb(skb)->req = req;
>> +	ovpn_skb_cb(skb)->crypto_tmp = tmp;
> 
> That should be done immediately after the allocation, so that any
> failure before this (skb_to_sgvec_nomark, ovpn_pktid_xmit_next) will
> not leak this blob? ovpn_aead_encrypt returns directly and lets
> ovpn_encrypt_post handle the error and free the memory, but only after
>   ->crypto_tmp has been set.
> 
> (same thing on the decrypt path)
> 

-- 
Antonio Quartulli
OpenVPN Inc.


