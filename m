Return-Path: <netdev+bounces-95873-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F64C8C3BC1
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 09:13:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C914C281186
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 07:13:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 689A9146A76;
	Mon, 13 May 2024 07:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="B6t296Yz"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3626146A67
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 07:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715584405; cv=none; b=L5LSI2+QNdpU+opeRravZx/XPf1DSwuxcUxDSLSg3KO7s2gaK3wQJVhCxo4D9vM07zt2r8asyOMz+WYpMmSpgbpYIrJ4y0n0IRgFXMJE1E8ZczaaWCadlpTO6/nQxjCI4Wvh9L0NBpx89o3My0ZBprJQeZ675H5yqaueIr92GCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715584405; c=relaxed/simple;
	bh=lqzBOlWtEzWCLIk55JNslVFZUbK9TKPulPnag8fnPsU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ABkTBUH/ZfuSKL8Sl4OO9wwLUxiXFv0BtXDRx60JAWuPbJJN3g65H3dOAsyw1AaMibb4fNlJIHNyJH2dHOoin9qAgEwS8XQHp0yHB398Gl/SXr1EmkQBj4MduBPqrWYIzQbalp8ssPjCm5rjS5zq+sGzZ2gpuqP1dYMRnaLi2IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=B6t296Yz; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-420180b59b7so2750535e9.0
        for <netdev@vger.kernel.org>; Mon, 13 May 2024 00:13:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1715584401; x=1716189201; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=jQEcIl9FtmXGTW9ZMv+yfRerO/hFl0F5Y+rNnRO5HhY=;
        b=B6t296YzOi95UUze8J9Ap/GJuA8cijQQOHCLoyA7X+ArfMK5UQgCqrE+L/gSjb1GQH
         ih5m8btIHvjZ+gKB5PEFlLpEC3+qQgp6nJJyEuexN+JAOLAy4+pTEm5QWmvoVKeLjL6P
         WZ7CWOqAIteRoTIOJpPzRLZsQxa2BDDVKAFBMOfn/7HcZCrOB83e2bnXAiiw7RLvOo+G
         ey7CpgKkJZwv1sHOrq1Yl9jSiqqg6WyCMqmdZ23CSK0qJUP9lGHPZHJvZM2AM02lziB1
         gNFDd1NT3mmWnX6Z00KgvrQTxG8Q5KUpiHNMfBIPKfNnjOdC+hSxgkZ+A08R4YowVeBg
         UOtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715584401; x=1716189201;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQEcIl9FtmXGTW9ZMv+yfRerO/hFl0F5Y+rNnRO5HhY=;
        b=qGG9DcN7FmpVdy1UemYU5HpadrDOFcROeHLtOMVfT3dWZT2tpgdRgnys4a9HNewUy5
         OKbYGu04p7k8GO9wl9jjevjRTg6iRbnNV6lL/N01Zkb2cylPX/4eTxRTjO2wv5Ygm3UC
         dt0DIWj+iY9rMP5Pk6rw5II/Ddb46y+MBjSZ0xdqpEZYTH5KH9/+OoenFgpFl+ivuXBK
         RASFx4Ic5Xp7gRIn1p178a9D/yEkmPnirG4Czp/TRDoQztSHBKQrEycNziQIdCJ2dZdA
         tltn0WhSgWpLEt3JJJJZmX+QIIvHqMRI/jeycuqWIB8gt60ZyqqkC4D5cJn4+vkjSJWY
         rI7A==
X-Gm-Message-State: AOJu0YybcOewlSA5g9ipd+cjqVeQ7bHXqwCcGHORBsrpKuXXXZ6mekX1
	aI0YArtLpjObV5Cr3sr+t9ug9KES+H9XifuO5M+Gz6Y8Bd+OLfOw3bUE7HTgtGg=
X-Google-Smtp-Source: AGHT+IG2Ibrbx5dGiriVHPPoBkwURzV8tlOR6ZPIH+Tyu5n5VauHpk4LhQUf2r0oiNRjk+zaPfmUww==
X-Received: by 2002:a05:600c:4fcf:b0:420:1585:7a99 with SMTP id 5b1f17b1804b1-42015857b80mr21594575e9.38.1715584400768;
        Mon, 13 May 2024 00:13:20 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:b0a4:8921:8456:9b28? ([2001:67c:2fbc:0:b0a4:8921:8456:9b28])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-41f87c235b4sm181513535e9.11.2024.05.13.00.13.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 May 2024 00:13:20 -0700 (PDT)
Message-ID: <d2733aaa-58fa-47da-a469-a848a6100759@openvpn.net>
Date: Mon, 13 May 2024 09:14:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 11/24] ovpn: implement packet processing
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Sergey Ryazanov <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>, Andrew Lunn <andrew@lunn.ch>,
 Esben Haabendal <esben@geanix.com>
References: <20240506011637.27272-1-antonio@openvpn.net>
 <20240506011637.27272-12-antonio@openvpn.net> <ZkCB2sFnpIluo3wm@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZkCB2sFnpIluo3wm@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/05/2024 10:46, Sabrina Dubroca wrote:
> 2024-05-06, 03:16:24 +0200, Antonio Quartulli wrote:
>> diff --git a/drivers/net/ovpn/bind.c b/drivers/net/ovpn/bind.c
>> index c1f842c06e32..7240d1036fb7 100644
>> --- a/drivers/net/ovpn/bind.c
>> +++ b/drivers/net/ovpn/bind.c
>> @@ -13,6 +13,7 @@
>>   #include "ovpnstruct.h"
>>   #include "io.h"
>>   #include "bind.h"
>> +#include "packet.h"
>>   #include "peer.h"
> 
> You have a few hunks like that in this patch, adding an include to a
> file that is otherwise not being modified. That's odd.

Argh. The whole ovpn was originall a single patch, which I the went and 
divided in smaller changes for easier review.

As you may imagine this process is prone to mistakes like this, 
expecially when the number of patches is quite high...

I will go through all the patches and clean them up from issues like 
this and like the one below..

Sorry about that.

> 
>> diff --git a/drivers/net/ovpn/crypto.c b/drivers/net/ovpn/crypto.c
>> new file mode 100644
>> index 000000000000..98ef1ceb75e0
>> --- /dev/null
>> +++ b/drivers/net/ovpn/crypto.c
>> @@ -0,0 +1,162 @@
>> +// SPDX-License-Identifier: GPL-2.0
>> +/*  OpenVPN data channel offload
>> + *
>> + *  Copyright (C) 2020-2024 OpenVPN, Inc.
>> + *
>> + *  Author:	James Yonan <james@openvpn.net>
>> + *		Antonio Quartulli <antonio@openvpn.net>
>> + */
>> +
>> +#include <linux/types.h>
>> +#include <linux/net.h>
>> +#include <linux/netdevice.h>
>> +//#include <linux/skbuff.h>
> 
> That's also odd :)
> 
> 
> [...]
>> +/* Reset the ovpn_crypto_state object in a way that is atomic
>> + * to RCU readers.
>> + */
>> +int ovpn_crypto_state_reset(struct ovpn_crypto_state *cs,
>> +			    const struct ovpn_peer_key_reset *pkr)
>> +	__must_hold(cs->mutex)
>> +{
>> +	struct ovpn_crypto_key_slot *old = NULL;
>> +	struct ovpn_crypto_key_slot *new;
>> +
>> +	lockdep_assert_held(&cs->mutex);
>> +
>> +	new = ovpn_aead_crypto_key_slot_new(&pkr->key);
> 
> This doesn't need the lock to be held, you could move the lock to a
> smaller section (only around the pointer swap).

I think you're right. I also like the idea of shrinking the lock active 
area.. Will fix this!


> 
>> +	if (IS_ERR(new))
>> +		return PTR_ERR(new);
>> +
>> +	switch (pkr->slot) {
>> +	case OVPN_KEY_SLOT_PRIMARY:
>> +		old = rcu_replace_pointer(cs->primary, new,
>> +					  lockdep_is_held(&cs->mutex));
>> +		break;
>> +	case OVPN_KEY_SLOT_SECONDARY:
>> +		old = rcu_replace_pointer(cs->secondary, new,
>> +					  lockdep_is_held(&cs->mutex));
>> +		break;
>> +	default:
>> +		goto free_key;
> 
> And validating pkr->slot before alloc could avoid a pointless
> alloc/free (and simplify the code: once _new() has succeeded, no
> failure can occur anymore).

right! will fix

> 
>> +	}
>> +
>> +	if (old)
>> +		ovpn_crypto_key_slot_put(old);
>> +
>> +	return 0;
>> +free_key:
>> +	ovpn_crypto_key_slot_put(new);
>> +	return -EINVAL;
>> +}
>> +
>> +void ovpn_crypto_key_slot_delete(struct ovpn_crypto_state *cs,
>> +				 enum ovpn_key_slot slot)
>> +{
>> +	struct ovpn_crypto_key_slot *ks = NULL;
>> +
>> +	mutex_lock(&cs->mutex);
>> +	switch (slot) {
>> +	case OVPN_KEY_SLOT_PRIMARY:
>> +		ks = rcu_replace_pointer(cs->primary, NULL,
>> +					 lockdep_is_held(&cs->mutex));
>> +		break;
>> +	case OVPN_KEY_SLOT_SECONDARY:
>> +		ks = rcu_replace_pointer(cs->secondary, NULL,
>> +					 lockdep_is_held(&cs->mutex));
>> +		break;
>> +	default:
>> +		pr_warn("Invalid slot to release: %u\n", slot);
>> +		break;
>> +	}
>> +	mutex_unlock(&cs->mutex);
>> +
>> +	if (!ks) {
>> +		pr_debug("Key slot already released: %u\n", slot);
> 
> This will also be printed in case of an invalid argument, which would
> be mildly confusing.

although we will have the pr_warn printed in as well that case.
But I agree this is not nice. will fix

> 
>> +		return;
>> +	}
>> +	pr_debug("deleting key slot %u, key_id=%u\n", slot, ks->key_id);
>> +
>> +	ovpn_crypto_key_slot_put(ks);
>> +}
> 
> 
>> +static struct ovpn_crypto_key_slot *
>> +ovpn_aead_crypto_key_slot_init(enum ovpn_cipher_alg alg,
>> +			       const unsigned char *encrypt_key,
>> +			       unsigned int encrypt_keylen,
>> +			       const unsigned char *decrypt_key,
>> +			       unsigned int decrypt_keylen,
>> +			       const unsigned char *encrypt_nonce_tail,
>> +			       unsigned int encrypt_nonce_tail_len,
>> +			       const unsigned char *decrypt_nonce_tail,
>> +			       unsigned int decrypt_nonce_tail_len,
>> +			       u16 key_id)
>> +{
> [...]
>> +
>> +	if (sizeof(struct ovpn_nonce_tail) != encrypt_nonce_tail_len ||
>> +	    sizeof(struct ovpn_nonce_tail) != decrypt_nonce_tail_len) {
>> +		ret = -EINVAL;
>> +		goto destroy_ks;
>> +	}
> 
> Those checks could be done earlier, before bothering with any
> allocations.

ACK

> 
>> +
>> +	memcpy(ks->nonce_tail_xmit.u8, encrypt_nonce_tail,
>> +	       sizeof(struct ovpn_nonce_tail));
>> +	memcpy(ks->nonce_tail_recv.u8, decrypt_nonce_tail,
>> +	       sizeof(struct ovpn_nonce_tail));
>> +
>> +	/* init packet ID generation/validation */
>> +	ovpn_pktid_xmit_init(&ks->pid_xmit);
>> +	ovpn_pktid_recv_init(&ks->pid_recv);
>> +
>> +	return ks;
>> +
>> +destroy_ks:
>> +	ovpn_aead_crypto_key_slot_destroy(ks);
>> +	return ERR_PTR(ret);
>> +}
>> +
>> +struct ovpn_crypto_key_slot *
>> +ovpn_aead_crypto_key_slot_new(const struct ovpn_key_config *kc)
>> +{
>> +	return ovpn_aead_crypto_key_slot_init(kc->cipher_alg,
>> +					      kc->encrypt.cipher_key,
>> +					      kc->encrypt.cipher_key_size,
>> +					      kc->decrypt.cipher_key,
>> +					      kc->decrypt.cipher_key_size,
>> +					      kc->encrypt.nonce_tail,
>> +					      kc->encrypt.nonce_tail_size,
>> +					      kc->decrypt.nonce_tail,
>> +					      kc->decrypt.nonce_tail_size,
>> +					      kc->key_id);
>> +}
> 
> Why the wrapper? You could just call ovpn_aead_crypto_key_slot_init
> directly.

Mostly for ahestetic reasons, being the call very large.
On top of that this is a little leftover from a previous version where 
this call happened more than once as part of an internal abstraction, 
hence the decision to create a wrapper.

But I think it's ok to remove it now.

> 
>> diff --git a/drivers/net/ovpn/io.c b/drivers/net/ovpn/io.c
>> index 9935a863bffe..66a4c551c191 100644
>> --- a/drivers/net/ovpn/io.c
>> +++ b/drivers/net/ovpn/io.c
>> @@ -110,6 +114,27 @@ int ovpn_napi_poll(struct napi_struct *napi, int budget)
>>   	return work_done;
>>   }
>>   
>> +/* Return IP protocol version from skb header.
>> + * Return 0 if protocol is not IPv4/IPv6 or cannot be read.
>> + */
>> +static __be16 ovpn_ip_check_protocol(struct sk_buff *skb)
> 
> nit: if you put this function higher up in the patch that introduced
> it, you wouldn't have to move it now

ACK

> 
>> +{
>> +	__be16 proto = 0;
>> +
>> +	/* skb could be non-linear, make sure IP header is in non-fragmented
>> +	 * part
>> +	 */
>> +	if (!pskb_network_may_pull(skb, sizeof(struct iphdr)))
>> +		return 0;
>> +
>> +	if (ip_hdr(skb)->version == 4)
>> +		proto = htons(ETH_P_IP);
>> +	else if (ip_hdr(skb)->version == 6)
>> +		proto = htons(ETH_P_IPV6);
>> +
>> +	return proto;
>> +}
>> +
>>   /* Entry point for processing an incoming packet (in skb form)
>>    *
>>    * Enqueue the packet and schedule RX consumer.
>> @@ -132,7 +157,81 @@ int ovpn_recv(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>>   
>>   static int ovpn_decrypt_one(struct ovpn_peer *peer, struct sk_buff *skb)
>>   {
>> -	return true;
> 
> I missed that in the RX patch, true isn't an int :)
> Were you intending this function to be bool like ovpn_encrypt_one?
> Since you're not actually using the returned value in the caller, it
> would be reasonable, but you'd have to convert all the <0 error values
> to bool.

Mhh let me think what's best and I wil make this uniform.

> 
>> +	struct ovpn_peer *allowed_peer = NULL;
>> +	struct ovpn_crypto_key_slot *ks;
>> +	__be16 proto;
>> +	int ret = -1;
>> +	u8 key_id;
>> +
>> +	/* get the key slot matching the key Id in the received packet */
>> +	key_id = ovpn_key_id_from_skb(skb);
>> +	ks = ovpn_crypto_key_id_to_slot(&peer->crypto, key_id);
>> +	if (unlikely(!ks)) {
>> +		net_info_ratelimited("%s: no available key for peer %u, key-id: %u\n",
>> +				     peer->ovpn->dev->name, peer->id, key_id);
>> +		goto drop;
>> +	}
>> +
>> +	/* decrypt */
>> +	ret = ovpn_aead_decrypt(ks, skb);
>> +
>> +	ovpn_crypto_key_slot_put(ks);
>> +
>> +	if (unlikely(ret < 0)) {
>> +		net_err_ratelimited("%s: error during decryption for peer %u, key-id %u: %d\n",
>> +				    peer->ovpn->dev->name, peer->id, key_id,
>> +				    ret);
>> +		goto drop;
>> +	}
>> +
>> +	/* check if this is a valid datapacket that has to be delivered to the
>> +	 * tun interface
> 
> s/tun/ovpn/ ?

yap. we used to call "tun" any interface used by openvpn...just legacy 
that fills our brains :-) will fix

> 
>> +	 */
>> +	skb_reset_network_header(skb);
>> +	proto = ovpn_ip_check_protocol(skb);
>> +	if (unlikely(!proto)) {
>> +		/* check if null packet */
>> +		if (unlikely(!pskb_may_pull(skb, 1))) {
>> +			netdev_dbg(peer->ovpn->dev,
>> +				   "NULL packet received from peer %u\n",
>> +				   peer->id);
>> +			ret = -EINVAL;
>> +			goto drop;
>> +		}
>> +
>> +		netdev_dbg(peer->ovpn->dev,
>> +			   "unsupported protocol received from peer %u\n",
>> +			   peer->id);
>> +
>> +		ret = -EPROTONOSUPPORT;
>> +		goto drop;
>> +	}
>> +	skb->protocol = proto;
>> +
>> +	/* perform Reverse Path Filtering (RPF) */
>> +	allowed_peer = ovpn_peer_get_by_src(peer->ovpn, skb);
>> +	if (unlikely(allowed_peer != peer)) {
>> +		if (skb_protocol_to_family(skb) == AF_INET6)
>> +			net_warn_ratelimited("%s: RPF dropped packet from peer %u, src: %pI6c\n",
>> +					     peer->ovpn->dev->name, peer->id,
>> +					     &ipv6_hdr(skb)->saddr);
>> +		else
>> +			net_warn_ratelimited("%s: RPF dropped packet from peer %u, src: %pI4\n",
>> +					     peer->ovpn->dev->name, peer->id,
>> +					     &ip_hdr(skb)->saddr);
>> +		ret = -EPERM;
>> +		goto drop;
>> +	}
> 
> Have you considered holding rcu_read_lock around this whole RPF check?
> It would avoid taking a reference on the peer just to release it 3
> lines later. And the same could likely be done for some of the other
> ovpn_peer_get_* lookups too.

thinking about this..you're right, because the peer object never leavs 
this context and therefore it is not stricly needed to hold the 
reference and do the full dance..

Sometimes I fear that I may envelope too many instructions within the 
rcu_read_lock and thus I go with the smallest area needed (a bit like a 
classic lock). But I agree that for these lookups this is not truly the 
case.

Will review the other lookups and change them accordingly.

Thanks!

> 
> 
>> +	ret = ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
>> +drop:
>> +	if (likely(allowed_peer))
>> +		ovpn_peer_put(allowed_peer);
>> +
>> +	if (unlikely(ret < 0))
>> +		kfree_skb(skb);
>> +
>> +	return ret;
> 
> Mixing the drop/success returns looks kind of strange. This would be a
> bit simpler:
> 
> ovpn_peer_put(allowed_peer);
> return ptr_ring_produce_bh(&peer->netif_rx_ring, skb);
> 
> drop:
> if (allowed_peer)
>      ovpn_peer_put(allowed_peer);
> kfree_skb(skb);
> return ret;

Honestly I have seen this pattern fairly often (and implemented it this 
way fairly often).

I presume it is mostly a matter of taste.

The idea is: when exiting a function 90% of the code is shared between 
success and failure, therefore let's just write it once and simply add a 
few branches based on ret.

This way we have less code and if we need to chang somethig in the exit 
path, we can change it once only.

A few examples:
* 
https://elixir.bootlin.com/linux/v6.9-rc7/source/net/batman-adv/translation-table.c#L813
* 
https://elixir.bootlin.com/linux/v6.9-rc7/source/net/batman-adv/routing.c#L269
* https://elixir.bootlin.com/linux/v6.9-rc7/source/net/mac80211/scan.c#L1344


ovpn code can be further simplified by setting skb to NULL in case of 
success (this way we avoid checking ret) and let ovpn_peer_put handle 
the case of peer == NULL (we avoid the NULL check before calling it).

What do you think?


> 
> 
>> diff --git a/drivers/net/ovpn/packet.h b/drivers/net/ovpn/packet.h
>> index 7ed146f5932a..e14c9bf464f7 100644
>> --- a/drivers/net/ovpn/packet.h
>> +++ b/drivers/net/ovpn/packet.h
>> @@ -10,7 +10,7 @@
>>   #ifndef _NET_OVPN_PACKET_H_
>>   #define _NET_OVPN_PACKET_H_
>>   
>> -/* When the OpenVPN protocol is ran in AEAD mode, use
>> +/* When the OpenVPN protocol is run in AEAD mode, use
> 
> nit: that typo came in earlier

ops


Thanks!

> 

-- 
Antonio Quartulli
OpenVPN Inc.

