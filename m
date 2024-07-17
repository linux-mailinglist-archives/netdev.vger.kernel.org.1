Return-Path: <netdev+bounces-111892-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7D933FA7
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 17:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 44F691C23364
	for <lists+netdev@lfdr.de>; Wed, 17 Jul 2024 15:29:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C91A5181CE9;
	Wed, 17 Jul 2024 15:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="WpN/6NWC"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E70718132E
	for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 15:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721230102; cv=none; b=CisKBQzEQJRLpwyuLDqohPi98LoiuBp4gown0+XvNmE738M/oVZ/VKs5GH50abHkH2ePRGjNr5vqOVhZ9SmnOcJG63fDfYuKFzE5fGHY95OUNpBJJUNz6jb73JGLK0LKX7siUm9LA4oQGupreW0nHzJe3zzoABkkSyEXbHAV3Po=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721230102; c=relaxed/simple;
	bh=WaCtWbTvg3allP222pT4SWD1duP89YHN6Gm+AtqsOps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KxqKW3b7xoqhnAaeozAwM+eXRw+85vz27vuqjD9Np49MfGmL+HRTf/g3SrqSSgR6Pq5NtUGEwy4iujnxL7e5FsKImo74Pd5MFkaXDRpJHJGmdHmDv2ykukiW3I8hsBn+ngphU5/5w8EHAgjyfl+Ls+JO7ijZ4j+elUa0ucelrBo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=WpN/6NWC; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-367b0cc6c65so4259446f8f.3
        for <netdev@vger.kernel.org>; Wed, 17 Jul 2024 08:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1721230099; x=1721834899; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=mWPTjCB0gxhPGoqjkSY+aiprYrXCClny16WIxuVE3w8=;
        b=WpN/6NWCGpZPQDMN+vIks0HSltmYraUiIXOgcbQq99v1yXV/iXponuTnNpj0uynFYx
         /NDMS8tIFVN6+gyMc6oqu9wDtkbjJmJTOpWZDZCroG5S8ZURcaBk7vxnA0uC02vLYvZm
         UsS21FEEFKcsN+u/CENm0FOx26zXHgdGvkqYjzhFu3i9qnruoRJppRE7csAcIRwaRYCx
         274NhiMOY5Mh4uSI0tAl5MhGDH+lt6xXor4ndzWbJ0Eib3E0W3Sz8rAHxu0n1X0ZnjyQ
         DW2losLEWUmrQmj65O+7wnbghKeTLqJkT8w2zTY8jCF8ehiY8Rp2eivlac2QbMFYnV5R
         OZDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721230099; x=1721834899;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mWPTjCB0gxhPGoqjkSY+aiprYrXCClny16WIxuVE3w8=;
        b=RVIwjtiZL0hXQ7AlAmIlgLijL66Ja3SV3xLbC8CG2FNFp+ZvP67l+RgksITmIron25
         U2UzL8BJmaZdWGCfEkjeW04YL0G2RTsN36ter5DW5iCn74DSvNYbswiKteJn+xmllVmb
         EaM3UNgJrFKBQQ9gv0b1nvB0Gk76ncRVljXUUKxoVA5g7Dc34Y2FGj+bC3XpjBiIdXU/
         EP6KA5MdvoPOOqDjDGQ4cHcdySH11N6dhPi7fCweipn4ctba0tnmX8oFrK1cdYI31LY0
         dzy6nO57GE4PrANf3uv+BVkDSmwDGp/cMbG6KoczQEf9Agk2OxxTDpM5YLMUF2za/cjV
         X3FA==
X-Gm-Message-State: AOJu0YxgkH+b0L7bcNrupRW2+yeL0e3MUZTTtmil6wyCvVwcIXW/w5Gd
	Cy238C9H22RRoZVAbr5Z6LjM8yw7YeOS0A1U6sDNPR8cfZ/7Ra7lWqlnLzksxKS9L3EbuA6dTs/
	S
X-Google-Smtp-Source: AGHT+IFtLxAFUOBVlvOeSQkd6AcLB55ryAsRyarHJ4IVk9+miRqPULLIW4yuytDl/kwyb1qMimAaQQ==
X-Received: by 2002:adf:f6c8:0:b0:367:96b9:760a with SMTP id ffacd0b85a97d-3683171fa20mr1601430f8f.41.1721230098508;
        Wed, 17 Jul 2024 08:28:18 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:4c30:cffb:9097:30fc? ([2001:67c:2fbc:1:4c30:cffb:9097:30fc])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3680dafbea9sm12149732f8f.82.2024.07.17.08.28.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Jul 2024 08:28:18 -0700 (PDT)
Message-ID: <73a305c5-57c1-40d9-825e-9e8390e093db@openvpn.net>
Date: Wed, 17 Jul 2024 17:30:17 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v5 17/25] ovpn: implement keepalive mechanism
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, ryazanov.s.a@gmail.com,
 pabeni@redhat.com, edumazet@google.com, andrew@lunn.ch
References: <20240627130843.21042-1-antonio@openvpn.net>
 <20240627130843.21042-18-antonio@openvpn.net> <ZpU15_ZNAV5ysnCC@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZpU15_ZNAV5ysnCC@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

On 15/07/2024 16:44, Sabrina Dubroca wrote:
> 2024-06-27, 15:08:35 +0200, Antonio Quartulli wrote:
>> +static const unsigned char ovpn_keepalive_message[] = {
>> +	0x2a, 0x18, 0x7b, 0xf3, 0x64, 0x1e, 0xb4, 0xcb,
>> +	0x07, 0xed, 0x2d, 0x0a, 0x98, 0x1f, 0xc7, 0x48
>> +};
>> +
>> +/**
>> + * ovpn_is_keepalive - check if skb contains a keepalive message
>> + * @skb: packet to check
>> + *
>> + * Assumes that the first byte of skb->data is defined.
>> + *
>> + * Return: true if skb contains a keepalive or false otherwise
>> + */
>> +static bool ovpn_is_keepalive(struct sk_buff *skb)
>> +{
>> +	if (*skb->data != OVPN_KEEPALIVE_FIRST_BYTE)
> 
> You could use ovpn_keepalive_message[0], and then you wouldn't need
> this extra constant.

Indeed, shame on me, will do as suggested

> 
>> +		return false;
>> +
>> +	if (!pskb_may_pull(skb, sizeof(ovpn_keepalive_message)))
>> +		return false;
>> +
>> +	return !memcmp(skb->data, ovpn_keepalive_message,
>> +		       sizeof(ovpn_keepalive_message));
> 
> Is a packet that contains some extra bytes after the exact keepalive
> considered a valid keepalive, or does it need to be the correct
> length?

I checked the userspace code and it assumes the length of the received 
keepalive message to be the same as the ovpn_keepalive_message array.

So no extra byte expected, otherwise the message is not considered a 
keepalive anymore.

This means I must add an extra check before the memcmp to make sure 
there is no extra data.

Good catch, thanks!

> 
>> +}
>> +
>>   /* Called after decrypt to write the IP packet to the device.
>>    * This method is expected to manage/free the skb.
>>    */
>> @@ -91,6 +116,9 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>>   		goto drop;
>>   	}
>>   
>> +	/* note event of authenticated packet received for keepalive */
>> +	ovpn_peer_keepalive_recv_reset(peer);
>> +
>>   	/* point to encapsulated IP packet */
>>   	__skb_pull(skb, ovpn_skb_cb(skb)->payload_offset);
>>   
>> @@ -107,6 +135,12 @@ void ovpn_decrypt_post(struct sk_buff *skb, int ret)
>>   			goto drop;
>>   		}
>>   
>> +		if (ovpn_is_keepalive(skb)) {
>> +			netdev_dbg(peer->ovpn->dev,
>> +				   "ping received from peer %u\n", peer->id);
> 
> That should probably be _ratelimited, but it seems we don't have
> _ratelimited variants for the netdev_* helpers.

Right.
I have used the net_*_ratelimited() variants when needed.
Too bad we don't have those.

> 
> 
> 
>> +/**
>> + * ovpn_xmit_special - encrypt and transmit an out-of-band message to peer
>> + * @peer: peer to send the message to
>> + * @data: message content
>> + * @len: message length
>> + *
>> + * Assumes that caller holds a reference to peer
>> + */
>> +static void ovpn_xmit_special(struct ovpn_peer *peer, const void *data,
>> +			      const unsigned int len)
>> +{
>> +	struct ovpn_struct *ovpn;
>> +	struct sk_buff *skb;
>> +
>> +	ovpn = peer->ovpn;
>> +	if (unlikely(!ovpn))
>> +		return;
>> +
>> +	skb = alloc_skb(256 + len, GFP_ATOMIC);
> 
> Where is that 256 coming from?

"Reasonable number" which should be enough[tm] to hold the entire packet.

> 
>> +	if (unlikely(!skb))
>> +		return;
> 
> Failure to send a keepalive should probably have a counter, to help
> users troubleshoot why their connection dropped.
> (can be done later unless someone insists)

This will be part of a more sophisticated error counting that I will 
introduce later on.

> 
> 
>> +	skb_reserve(skb, 128);
> 
> And that 128?

same "logic" as 256.

> 
>> +	skb->priority = TC_PRIO_BESTEFFORT;
>> +	memcpy(__skb_put(skb, len), data, len);
> 
> nit: that's __skb_put_data

oh cool, thanks!

> 
>> +	/* increase reference counter when passing peer to sending queue */
>> +	if (!ovpn_peer_hold(peer)) {
>> +		netdev_dbg(ovpn->dev, "%s: cannot hold peer reference for sending special packet\n",
>> +			   __func__);
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>> +	ovpn_send(ovpn, skb, peer);
>> +}
>> +
>> +/**
>> + * ovpn_keepalive_xmit - send keepalive message to peer
>> + * @peer: the peer to send the message to
>> + */
>> +void ovpn_keepalive_xmit(struct ovpn_peer *peer)
>> +{
>> +	ovpn_xmit_special(peer, ovpn_keepalive_message,
>> +			  sizeof(ovpn_keepalive_message));
>> +}
> 
> I don't see other users of ovpn_xmit_special in this series, if you
> don't have more planned in the future you could drop the extra function.

initially there were plans, but I have always fought back any idea about 
adding more unnecessary logic to the kernel side. So for now there is 
nothing planned.
I'll remove the extra wrapper.

> 
> 
>> +/**
>> + * ovpn_peer_expire - timer task for incoming keepialive timeout
> 
> typo: s/keepialive/keepalive/

Thanks

> 
> 
> 
>> +/**
>> + * ovpn_peer_keepalive_set - configure keepalive values for peer
>> + * @peer: the peer to configure
>> + * @interval: outgoing keepalive interval
>> + * @timeout: incoming keepalive timeout
>> + */
>> +void ovpn_peer_keepalive_set(struct ovpn_peer *peer, u32 interval, u32 timeout)
>> +{
>> +	u32 delta;
>> +
>> +	netdev_dbg(peer->ovpn->dev,
>> +		   "%s: scheduling keepalive for peer %u: interval=%u timeout=%u\n",
>> +		   __func__, peer->id, interval, timeout);
>> +
>> +	peer->keepalive_interval = interval;
>> +	if (interval > 0) {
>> +		delta = msecs_to_jiffies(interval * MSEC_PER_SEC);
>> +		mod_timer(&peer->keepalive_xmit, jiffies + delta);
> 
> Maybe something to consider in the future: this could be resetting a
> timer that was just about to go off to a somewhat distant time in the
> future. Not sure the peer will be happy about that (and not consider
> it a timeout).

Normally this timer is only set upon connection, or maybe upon some 
future parameter exchange. In both cases we can assume the connection is 
alive, so this case should not scare us.

But thanks for pointing it out

> 
>> +	} else {
>> +		timer_delete(&peer->keepalive_xmit);
>> +	}
>> +
>> +	peer->keepalive_timeout = timeout;
>> +	if (timeout) {
> 
> pedantic nit: inconsistent style with the "interval > 0" test just
> above

ACK, will make them uniform.

> 
>> +		delta = msecs_to_jiffies(timeout * MSEC_PER_SEC);
>> +		mod_timer(&peer->keepalive_recv, jiffies + delta);
>> +	} else {
>> +		timer_delete(&peer->keepalive_recv);
>> +	}
>> +}
>> +
> 
> [...]
>> +/**
>> + * ovpn_peer_keepalive_recv_reset - reset keepalive timeout
>> + * @peer: peer for which the timeout should be reset
>> + *
>> + * To be invoked upon reception of an authenticated packet from peer in order
>> + * to report valid activity and thus reset the keepalive timeout
>> + */
>> +static inline void ovpn_peer_keepalive_recv_reset(struct ovpn_peer *peer)
>> +{
>> +	u32 delta = msecs_to_jiffies(peer->keepalive_timeout * MSEC_PER_SEC);
>> +
>> +	if (unlikely(!delta))
>> +		return;
>> +
>> +	mod_timer(&peer->keepalive_recv, jiffies + delta);
> 
> This (and ovpn_peer_keepalive_xmit_reset) is going to be called for
> each packet. I wonder how well the timer subsystem deals with one
> timer getting updated possibly thousands of time per second.
> 

May it even introduce some performance penalty?

Maybe we should get rid of the timer object and introduce a periodic 
(1s) worker which checks some last_recv timestamp on every known peer?
What do you think?


Thanks!


-- 
Antonio Quartulli
OpenVPN Inc.

