Return-Path: <netdev+bounces-110554-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 992A292D0C7
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 13:36:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4B2F9289227
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 11:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F7190486;
	Wed, 10 Jul 2024 11:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="MVLpnQ6y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5807D412
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 11:36:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720611397; cv=none; b=fizh/ea4MKeSKfmJX2MecVYJhUbTfXlluMa8Lc4yz8xi2XrJtQFNBo9xuGRAnV+jMB/xRQV5T/axahSDHKAARG2PmyeQdCdMwAeW+lTf+hgqq/428DngHLK0EDTUivJeH1tjkv3xctAaverrj4SDBH8aVUvpaMAAmu9t31rdxFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720611397; c=relaxed/simple;
	bh=pf4nazwilOKu8jf65C5CXW9gEBzuk9C71Q+ZSsdxP28=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=FZfpOZ+76gkP94+gWq2gY+KWy9SkKj3u6VEy+1eVXUSgb9oV7X4TCmJSS9IFVATsbEYn0VZtTBdxjWIQE190J/HQdZDuJvWorwE8prjGupKh/xXelGW96XXaYLcauG41srz0XaKFIbIx/bHOCsDCO8g6sDr7lkOnK978eRHnhfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=MVLpnQ6y; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-a77e7420697so547144766b.1
        for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 04:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1720611393; x=1721216193; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=thK62u9jcQ43Rg6t9uNsJ9x5mZZUz73vhYa6GguoI5A=;
        b=MVLpnQ6y6XnUDmSAK6D5UA18E7IPx5hoMriq/EmmbaQZa4Sy+USgxPxSTR+VAoC+Nu
         GHyYNZy6rPtN+Q3zZkGdJIFzHdvXA5FUbX9HunKoqlSNdZtgIQ9eyFIBMoo3WTFvY83A
         ROQIK66YNfFcS272r9Fm6Y9E2KKZdxBBOdmGQjP/j6IREbTwp/jYybNJlUoMYKwso8Rg
         iQasvoQtPsqwwSOXuvAtTkLK5c4a9j+dJ8NxUDl5YgI2JokDvDGsmcMDLx10KIAkCL3x
         mqkfPtE0SH+6da2Onw/PepC6/8+V4Pz3zWNMWcE05H3urxuXqIvtczEuxIkir0B3gtLC
         Ts9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720611393; x=1721216193;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=thK62u9jcQ43Rg6t9uNsJ9x5mZZUz73vhYa6GguoI5A=;
        b=k+wMF4hT+sZdy1IELXggiKw+hLLavbk5oAXEk6pivVqdP9SGtnMi4NQgIQf8J3BYQs
         NMXkcVzdOQP1ilq8QYQ1Ie9X8bIfW1pCW7dD835tI4RmBP17y/XkcQ/4vV5p+UGSicrE
         Uw4pq4Jtsom/rXvCx362w6o5kQ328DfsFYXngWLZd3lHcoekE6an8yJlu1uZuLOtVDZZ
         P7WS+/bMv0kP6fDEmPmM7e5hMM2zN+nz033uluy7Ic2dpmZZwLzsAIWekPp57OIcWE6b
         /AsSkA8+YL/Dpugt8MYxIymcwrWAOE8d6196SsmdpOSBlHguTWE6c0cufnIEf47fbg0W
         io2Q==
X-Gm-Message-State: AOJu0Yy4YzufJzaB/7LnMY4p+OVh30r/qP7RWZu8Dc+JZmeHqYn953/1
	23+J9O9yyLXR2XctIpz2Lgdp3uY3rHi4XkYGBGB59SReJ6xYnHfqXo0isZt6QsI=
X-Google-Smtp-Source: AGHT+IEUqMsJYmLK3gPDy/dswZkdfQ30Yz9PKsa9a67BYwKcz1vsEqWu2oaq7bUFyUyTtEGl/G65dA==
X-Received: by 2002:a17:907:3f97:b0:a79:8290:ab with SMTP id a640c23a62f3a-a7982900482mr69452666b.15.1720611393301;
        Wed, 10 Jul 2024 04:36:33 -0700 (PDT)
Received: from [192.168.182.20] ([185.242.181.163])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a780a6e17b1sm152844666b.83.2024.07.10.04.36.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Jul 2024 04:36:32 -0700 (PDT)
Message-ID: <9bcdabb0-7682-4723-aa2f-ca64f1b8202a@openvpn.net>
Date: Wed, 10 Jul 2024 13:38:28 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 12/25] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-13-antonio@openvpn.net> <Zoz6FdiZ64bQhU0c@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <Zoz6FdiZ64bQhU0c@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 09/07/2024 10:51, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:30 +0200, Antonio Quartulli wrote:
>> +/* removes the primary key from the crypto context */
>> +void ovpn_crypto_kill_primary(struct ovpn_crypto_state *cs)
>> +{
>> +	struct ovpn_crypto_key_slot *ks;
>> +
>> +	mutex_lock(&cs->mutex);
>> +	ks = rcu_replace_pointer(cs->primary, NULL,
>> +				 lockdep_is_held(&cs->mutex));
> 
> Should there be a check that we're killing the key that has expired
> and not some other key?  I'm wondering if this could happen:
> 
> ovpn_encrypt_one
>      ovpn_aead_encrypt
>          ovpn_pktid_xmit_next
>              seq_num reaches threshold
>              returns -ERANGE
>          returns -ERANGE
> 
>                                              ovpn_crypto_key_slots_swap
>                                                  replaces cs->primary with cs->secondary
> 
>      ovpn_encrypt_post
>          ret = -ERANGE
>          ovpn_crypto_kill_primary
>              kills the freshly installed primary key
> 
>> +	ovpn_crypto_key_slot_put(ks);
>> +	mutex_unlock(&cs->mutex);
>> +}

hm I think you're right.

This is theoretically possible...
Userspace might be reneweing the key exactly when the primary key is 
expiring..

We need to specify the key_id and kill exactly that key.


>> +
> 
> [...]
>> +static void ovpn_aead_encrypt_done(void *data, int ret)
>> +{
>> +	struct sk_buff *skb = data;
>> +
>> +	aead_request_free(ovpn_skb_cb(skb)->req);
>> +	ovpn_encrypt_post(skb, ret);
>> +}
>> +
>> +int ovpn_aead_encrypt(struct ovpn_crypto_key_slot *ks, struct sk_buff *skb,
>> +		      u32 peer_id)
>> +{
>> +	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
>> +	const unsigned int head_size = ovpn_aead_encap_overhead(ks);
>> +	struct scatterlist sg[MAX_SKB_FRAGS + 2];
>> +	DECLARE_CRYPTO_WAIT(wait);
> 
> unused? (also in _decrypt)

Right. Leftover from the sync crypto approach. Will drop it.

> 
> [...]
>> +
>> +	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
>> +	if (unlikely(!req))
>> +		return -ENOMEM;
>> +
>> +	/* setup async crypto operation */
>> +	aead_request_set_tfm(req, ks->encrypt);
>> +	aead_request_set_callback(req, 0, ovpn_aead_encrypt_done, NULL);
> 
> NULL? That should be skb, ovpn_aead_encrypt_done needs it (same for
> decrypt).

Ouch

> 
> I suspect you haven't triggered the async path in testing. For that,
> you can use crconf:

Yeah, I doubt I did, although I tried pumping as much traffic as 
possible (but it may not have been enough to trigger the needed conditions).

> 
> git clone https://git.code.sf.net/p/crconf/code
> cd code && make
> ./src/crconf add driver 'pcrypt(generic-gcm-aesni)' type 3  priority 10000
> 
> Then all packets encrypted with gcm(aes) should go through the async
> code.

Amazing! Thanks! Will give it a go.

> 
>> +	aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
>> +	aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
>> +
>> +	ovpn_skb_cb(skb)->req = req;
>> +	ovpn_skb_cb(skb)->ks = ks;
>> +
>> +	/* encrypt it */
>> +	return crypto_aead_encrypt(req);
>> +}
> 
> [...]
>> @@ -77,14 +133,45 @@ static void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>>   /* pick next packet from RX queue, decrypt and forward it to the device */
>>   void ovpn_recv(struct ovpn_peer *peer, struct sk_buff *skb)
>>   {
>> +	struct ovpn_crypto_key_slot *ks;
>> +	u8 key_id;
>> +
>> +	/* get the key slot matching the key ID in the received packet */
>> +	key_id = ovpn_key_id_from_skb(skb);
>> +	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
> 
> This takes a reference on the keyslot (ovpn_crypto_key_slot_hold), but
> I don't see it getting released in ovpn_decrypt_post. In
> ovpn_encrypt_post you're adding a ovpn_crypto_key_slot_put (to match
> ovpn_crypto_key_slot_primary), but nothing equivalent in
> ovpn_decrypt_post?

good catch! I don't think it triggered any critical side effect (Except 
from the leak) hence it went unnoticed.

Will add the ovpn_crypto_key_slot_put in the exit path.


Thanks!


> 
>> +	if (unlikely(!ks)) {
>> +		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
>> +				     peer->ovpn->dev->name, peer->id, key_id);
>> +		dev_core_stats_rx_dropped_inc(peer->ovpn->dev);
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>>   	ovpn_skb_cb(skb)->peer = peer;
>> -	ovpn_decrypt_post(skb, 0);
>> +	ovpn_decrypt_post(skb, ovpn_aead_decrypt(ks, skb));
>>   }
> 

-- 
Antonio Quartulli
OpenVPN Inc.

