Return-Path: <netdev+bounces-125043-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B50A96BB88
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 14:05:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 66B0D1C22B45
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 12:05:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CAAF1D61B7;
	Wed,  4 Sep 2024 12:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="ehWO+0AR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0069784A21
	for <netdev@vger.kernel.org>; Wed,  4 Sep 2024 12:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725451523; cv=none; b=YZRfTPcOJOlfPhZFrqX8cJDfl6IU6CMrpmyTwmwZBRuiFQHzjS0PsDrTMrIBEYFTpDYF0gejy/b4s1/9CTiKK63QM/WcHKbA8tHktWTXA7LeJwKFYLN7tBa1n5e48ui2n4CshvDzdfTS07XEch1crcsytUnfHzI+zihJd3I8Rt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725451523; c=relaxed/simple;
	bh=gJVumYmq0rR3sRWIKklrwLse0iJCp3Eeo1QJtv60ecw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=acumFUCPlOaTGbG6mpViruEUhLZZ1jLVzxGi9fqNkvBa4jKW8DND+b8Dl9fso8p+x+e2ef9fxB3KupJslUM1WYiV/+QBAawPq5AWcN7/jKFLgX8uF6MhtVf4p9qYjwD5o851eVqQUq1Cib+AWwmIGLH4uAN/bWCJzjDQazAjgf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=ehWO+0AR; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-5c26a52cf82so1308699a12.2
        for <netdev@vger.kernel.org>; Wed, 04 Sep 2024 05:05:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725451519; x=1726056319; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lR/Z+Mt/Zj66/88t/ftgle+mxTMmLWmkcAzoV5HAJ1g=;
        b=ehWO+0ARiRLh7YRHkHKyLX79RtJtPUH0o3pfkVVGjY5km2vhPCwy9x0o++8irhr1Gf
         O3zgHqYcGPYsRv2SpbwEpAdWQve4GRc0TDN9mRzIS86KZZU2RTKhLnqgcr+mtREwGrZk
         DfWZdiyOH478+odxNktBRuMD/bryzBOV4Mb6U5xFgz5PUnRufE0NkM50nF339OGQKi7x
         rqQbQtmHNeQEwc99v4+VhQvtbpCj9JQuRQpjkEwxrlqEs4wyFzzYZfVPWi7mSTpIRZ8e
         KEb5C8XFdFTBIFA05ETB1wmq1E3M0rm3w1lwV5Mt/JmeU3pMt2W9bPq6HvsIze9cTNl6
         zCLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725451519; x=1726056319;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lR/Z+Mt/Zj66/88t/ftgle+mxTMmLWmkcAzoV5HAJ1g=;
        b=OZYQ4IHtLxFHuI+jmOpxWmRe0o5XdQq41GiMpDh4ppxeNJ8VsfWh3ULOqsrtLN1ih4
         mqsqw7wi4foet55lnAHsuLkL74tRKRzhicWAhjgWn671t6knwXElsNT3LxjK2Kp+GZ00
         /cVjmEkvXFGSWWuYuBfvKdbOCxqCI+KwFAzLmUk7QOWleV+PegPHBVMil8wI6NAOZzCO
         Uy65lOiMZ9PFHHJIVDbL8Yuxeu5L4wb345//hhOeUVOMNX9EBNWRPd32UjDXS81e1PMF
         4VhH1qh+Vy+Hlpg35uRhTq2TIhHCvyxMCwdrC7KhVfXoOtDaNpcZU+m8HS10f2T1He+8
         dcUw==
X-Gm-Message-State: AOJu0YwR4rnOmbvNHwO9hQFJnlohUDAv4HmWePtRPCoL3Su2l37WCHk/
	mDatN6LQ02b6HNEToplUupqoDO01Ls+v9GTO8Pe7bD1eVGph1PA7+NBLqbzRcdo=
X-Google-Smtp-Source: AGHT+IHMQ8aFRJBNQAQV1zW76oxdtXMGlWy2aQFWCdCbRku/iOs6lVWVBqm5sdp3DNRzm/AYenQkxA==
X-Received: by 2002:a05:6402:35ca:b0:5c2:50a2:98ad with SMTP id 4fb4d7f45d1cf-5c250a35a45mr9782047a12.7.1725451518951;
        Wed, 04 Sep 2024 05:05:18 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:b66b:f411:39c3:d616? ([2001:67c:2fbc:1:b66b:f411:39c3:d616])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5c226c6a399sm7479861a12.8.2024.09.04.05.05.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 04 Sep 2024 05:05:18 -0700 (PDT)
Message-ID: <ae23ac0f-2ff9-4396-9033-617dc60221eb@openvpn.net>
Date: Wed, 4 Sep 2024 14:07:23 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 12/25] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-13-antonio@openvpn.net> <ZtXOw-NcL9lvwWa8@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtXOw-NcL9lvwWa8@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 02/09/2024 16:42, Sabrina Dubroca wrote:
> 2024-08-27, 14:07:52 +0200, Antonio Quartulli wrote:
>> +/* this swap is not atomic, but there will be a very short time frame where the
> 
> Since we're under a mutex, I think we might get put to sleep for a
> not-so-short time frame.
> 
>> + * old_secondary key won't be available. This should not be a big deal as most
> 
> I could be misreading the code, but isn't it old_primary that's
> unavailable during the swap? rcu_replace_pointer overwrites
> cs->primary, so before the final assign, both slots contain
> old_secondary?

Right. The comment is not correct.

cs->secondary (old_secondary, that is the newest key) is what is 
probably being used by the other peer for sending traffic.
Therefore old_secondary is what is likely to be needed.

However, this is pure speculation and may not be accurate.

The fact that we could sleep before having completed the swap sounds 
like something we want to avoid.
Maybe I should convert this mutex to a spinlock. Its usage is fairly 
contained anyway.

> 
>> + * likely both peers are already using the new primary at this point.
>> + */
>> +void ovpn_crypto_key_slots_swap(struct ovpn_crypto_state *cs)
>> +{
>> +	const struct ovpn_crypto_key_slot *old_primary, *old_secondary;
>> +
>> +	mutex_lock(&cs->mutex);
>> +
>> +	old_secondary = rcu_dereference_protected(cs->secondary,
>> +						  lockdep_is_held(&cs->mutex));
>> +	old_primary = rcu_replace_pointer(cs->primary, old_secondary,
>> +					  lockdep_is_held(&cs->mutex));
>> +	rcu_assign_pointer(cs->secondary, old_primary);
>> +
>> +	pr_debug("key swapped: %u <-> %u\n",
>> +		 old_primary ? old_primary->key_id : 0,
>> +		 old_secondary ? old_secondary->key_id : 0);
>> +
>> +	mutex_unlock(&cs->mutex);
>> +}
> 
> [...]
>> +int ovpn_aead_encrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>> +		      struct sk_buff *skb)
>> +{
>> +	const unsigned int tag_size = crypto_aead_authsize(ks->encrypt);
>> +	const unsigned int head_size = ovpn_aead_encap_overhead(ks);
>> +	DECLARE_CRYPTO_WAIT(wait);
> 
> nit: unused

ACK

> 
>> +	struct aead_request *req;
>> +	struct sk_buff *trailer;
>> +	struct scatterlist *sg;
>> +	u8 iv[NONCE_SIZE];
>> +	int nfrags, ret;
>> +	u32 pktid, op;
>> +
>> +	/* Sample AEAD header format:
>> +	 * 48000001 00000005 7e7046bd 444a7e28 cc6387b1 64a4d6c1 380275a...
>> +	 * [ OP32 ] [seq # ] [             auth tag            ] [ payload ... ]
>> +	 *          [4-byte
>> +	 *          IV head]
>> +	 */
>> +
>> +	/* check that there's enough headroom in the skb for packet
>> +	 * encapsulation, after adding network header and encryption overhead
>> +	 */
>> +	if (unlikely(skb_cow_head(skb, OVPN_HEAD_ROOM + head_size)))
>> +		return -ENOBUFS;
>> +
>> +	/* get number of skb frags and ensure that packet data is writable */
>> +	nfrags = skb_cow_data(skb, 0, &trailer);
>> +	if (unlikely(nfrags < 0))
>> +		return nfrags;
>> +
>> +	if (unlikely(nfrags + 2 > (MAX_SKB_FRAGS + 2)))
>> +		return -ENOSPC;
>> +
>> +	ovpn_skb_cb(skb)->ctx = kmalloc(sizeof(*ovpn_skb_cb(skb)->ctx),
>> +					GFP_ATOMIC);
>> +	if (unlikely(!ovpn_skb_cb(skb)->ctx))
>> +		return -ENOMEM;
> 
> I think you should clear skb->cb (or at least ->ctx) at the start of
> ovpn_aead_encrypt. I don't think it will be cleaned up by the previous
> user, and if we fail before this alloc, we will possibly have bogus
> values in ->ctx when we get to kfree(ovpn_skb_cb(skb)->ctx) at the end
> of ovpn_encrypt_post.
> 
> (Similar comments around cb/ctx freeing and initialization apply to
> ovpn_aead_decrypt and ovpn_decrypt_post)

good point - will clear it in both cases.

> 
>> +	sg = ovpn_skb_cb(skb)->ctx->sg;
>> +
>> +	/* sg table:
>> +	 * 0: op, wire nonce (AD, len=OVPN_OP_SIZE_V2+NONCE_WIRE_SIZE),
>> +	 * 1, 2, 3, ..., n: payload,
>> +	 * n+1: auth_tag (len=tag_size)
>> +	 */
>> +	sg_init_table(sg, nfrags + 2);
>> +
>> +	/* build scatterlist to encrypt packet payload */
>> +	ret = skb_to_sgvec_nomark(skb, sg + 1, 0, skb->len);
>> +	if (unlikely(nfrags != ret)) {
>> +		kfree(sg);
> 
> This is the only location in this function (and ovpn_encrypt_post)
> that frees sg. Is that correct? sg points to an array contained within
> ->ctx, I don't think you want to free that directly.

No, it is not correct. As you pointed out 'sg' is an actual array so 
should not be free'd.

This is a leftover of the first version where 'sg' was kmalloc'd.

FTR: this restructuring is the result of having tested 
encryption/decryption with pcrypt: sg, that is passed to the crypto 
code, was initially allocated on the stack, which was obviously not 
working for async crypto.
The solution was to make it part of the skb CB area, so that it can be 
carried around until crypto is done.

> 
>> +		return -EINVAL;
>> +	}
>> +
>> +	/* append auth_tag onto scatterlist */
>> +	__skb_push(skb, tag_size);
>> +	sg_set_buf(sg + nfrags + 1, skb->data, tag_size);
>> +
>> +	/* obtain packet ID, which is used both as a first
>> +	 * 4 bytes of nonce and last 4 bytes of associated data.
>> +	 */
>> +	ret = ovpn_pktid_xmit_next(&ks->pid_xmit, &pktid);
>> +	if (unlikely(ret < 0)) {
>> +		kfree(ovpn_skb_cb(skb)->ctx);
> 
> Isn't that going to cause a double-free when we get to the end of
> ovpn_encrypt_post? Or even UAF when we try to get ks/peer at the
> start?

ouch. you're right.
I should better leave it alone and let ovpn_encrypt_post take care of 
free'ing it at the end.

> 
>> +		return ret;
>> +	}
>> +
>> +	/* concat 4 bytes packet id and 8 bytes nonce tail into 12 bytes
>> +	 * nonce
>> +	 */
>> +	ovpn_pktid_aead_write(pktid, &ks->nonce_tail_xmit, iv);
>> +
>> +	/* make space for packet id and push it to the front */
>> +	__skb_push(skb, NONCE_WIRE_SIZE);
>> +	memcpy(skb->data, iv, NONCE_WIRE_SIZE);
>> +
>> +	/* add packet op as head of additional data */
>> +	op = ovpn_opcode_compose(OVPN_DATA_V2, ks->key_id, peer->id);
>> +	__skb_push(skb, OVPN_OP_SIZE_V2);
>> +	BUILD_BUG_ON(sizeof(op) != OVPN_OP_SIZE_V2);
>> +	*((__force __be32 *)skb->data) = htonl(op);
>> +
>> +	/* AEAD Additional data */
>> +	sg_set_buf(sg, skb->data, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
>> +
>> +	req = aead_request_alloc(ks->encrypt, GFP_ATOMIC);
>> +	if (unlikely(!req)) {
>> +		kfree(ovpn_skb_cb(skb)->ctx);
> 
> Same here.

yap

> 
>> +		return -ENOMEM;
>> +	}
>> +
>> +	/* setup async crypto operation */
>> +	aead_request_set_tfm(req, ks->encrypt);
>> +	aead_request_set_callback(req, 0, ovpn_aead_encrypt_done, skb);
>> +	aead_request_set_crypt(req, sg, sg, skb->len - head_size, iv);
>> +	aead_request_set_ad(req, OVPN_OP_SIZE_V2 + NONCE_WIRE_SIZE);
>> +
>> +	ovpn_skb_cb(skb)->ctx->peer = peer;
>> +	ovpn_skb_cb(skb)->ctx->req = req;
>> +	ovpn_skb_cb(skb)->ctx->ks = ks;
>> +
>> +	/* encrypt it */
>> +	return crypto_aead_encrypt(req);
>> +}
>> +
>> +static void ovpn_aead_decrypt_done(void *data, int ret)
>> +{
>> +	struct sk_buff *skb = data;
>> +
>> +	aead_request_free(ovpn_skb_cb(skb)->ctx->req);
> 
> This function only gets called in the async case. Where's the
> corresponding aead_request_free in the sync case? (same for encrypt)
> This should be moved into ovpn_decrypt_post, I think.

I agree, although I am pretty sure I moved it here in the past for a reason.
Maybe code changes eliminated that reason.

anyway, thanks for spotting this. I'll definitely move it to the _post 
functions.

> 
>> +	ovpn_decrypt_post(skb, ret);
>> +}
>> +
>> +int ovpn_aead_decrypt(struct ovpn_peer *peer, struct ovpn_crypto_key_slot *ks,
>> +		      struct sk_buff *skb)
>> +{
>> +	const unsigned int tag_size = crypto_aead_authsize(ks->decrypt);
>> +	int ret, payload_len, nfrags;
>> +	unsigned int payload_offset;
>> +	DECLARE_CRYPTO_WAIT(wait);
> 
> nit: unused

ACK

> 
> 
> [...]
>> -static void ovpn_encrypt_post(struct sk_buff *skb, int ret)
>> +void ovpn_encrypt_post(struct sk_buff *skb, int ret)
>>   {
>> -	struct ovpn_peer *peer = ovpn_skb_cb(skb)->peer;
>> +	struct ovpn_crypto_key_slot *ks = ovpn_skb_cb(skb)->ctx->ks;
>> +	struct ovpn_peer *peer = ovpn_skb_cb(skb)->ctx->peer;
> 
> ovpn_skb_cb(skb)->ctx may not have been set by ovpn_aead_encrypt.

right. we may have hit a return before kmalloc'ing it.

> 
>> +
>> +	/* encryption is happening asynchronously. This function will be
>> +	 * called later by the crypto callback with a proper return value
>> +	 */
>> +	if (unlikely(ret == -EINPROGRESS))
>> +		return;
>>   
>>   	if (unlikely(ret < 0))
>>   		goto err;
>>   
>>   	skb_mark_not_on_list(skb);
>>   
>> +	kfree(ovpn_skb_cb(skb)->ctx);
>> +
>>   	switch (peer->sock->sock->sk->sk_protocol) {
>>   	case IPPROTO_UDP:
>>   		ovpn_udp_send_skb(peer->ovpn, peer, skb);
>>   		break;
>>   	default:
>>   		/* no transport configured yet */
>>   		goto err;
> 
> ovpn_skb_cb(skb)->ctx has just been freed before this switch, and here
> we jump to err and free it again.

Thanks. Will reworka bit the error path here.

> 
>>   	}
>>   	/* skb passed down the stack - don't free it */
>>   	skb = NULL;
>>   err:
>>   	if (unlikely(skb)) {
>>   		dev_core_stats_tx_dropped_inc(peer->ovpn->dev);
>> -		kfree_skb(skb);
>> +		kfree(ovpn_skb_cb(skb)->ctx);
>>   	}
>> +	kfree_skb(skb);
>> +	ovpn_crypto_key_slot_put(ks);
>>   	ovpn_peer_put(peer);
>>   }
> 

This patch was basically re-written after realizing that the async 
crypto path was not working as expected, therefore sorry if there were 
some "kinda obvious" mistakes.

Thanks a lot for your review.


-- 
Antonio Quartulli
OpenVPN Inc.

