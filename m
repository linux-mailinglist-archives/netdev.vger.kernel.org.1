Return-Path: <netdev+bounces-124181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ACE09686E9
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 14:02:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03B6D285729
	for <lists+netdev@lfdr.de>; Mon,  2 Sep 2024 12:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37D9C18455C;
	Mon,  2 Sep 2024 12:01:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="HFF1FD0N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AED7417F394
	for <netdev@vger.kernel.org>; Mon,  2 Sep 2024 12:01:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725278517; cv=none; b=OIgt5ktoH0kOIzGxP9wK0wxqZkpbSQRGDTSjxg5tRQhqd8thGEL9M77RPBiOcqj4VnE+visgGR2TNjY4y3oWCh2m7zmXkvgUsKY7VVikoMeUb3Fm/oK4ZWAhu9FFSPfgK5iEXOpAtOvOlcQBX40RxHMHp8wm8lLWcIFZdFp3tqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725278517; c=relaxed/simple;
	bh=85/4B5UrXA6agLMdbP3H9K1Mzw2Y8lP+yrRCbVdTlpo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ci62acopnShR7kl5+0Ti/gLKUUIbBZ3O0I9wUOG5cq2A+MYoaFO4GVuNREBq3qI6+mKmcTDRKnIBNplK4vM1ltLup4dSN6Jdlphr0zcqGBSplg+MrSdyG/tv/022zs4JYFUwpTtnB5sOrGZAZGjjg0Tc9tos7Q1Nl23UYEAwIaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=HFF1FD0N; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42bbd16fcf2so26216075e9.2
        for <netdev@vger.kernel.org>; Mon, 02 Sep 2024 05:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1725278513; x=1725883313; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=d+PG5oUJxA0435PSYviQLRAdwBXq0onVLuFzi6gfhyQ=;
        b=HFF1FD0NCd20GjFtxvqM7yZ7op9msw7qjIuoU0VUL1hOnZhSVYYAti4QRN+H6EK668
         M/eYT/U1QjI865fX/B6DYJ5VNjbOr6k+OZ50Tf7YHWv4yUcPCdRNV+ZX3RzSh40mQVqH
         dp7LE/PeJZDVSf7z7n6sz+3u5yOqNOcG3ldU52f1oX3nayfQri+hsPzUoi1rk5HCniLN
         CcsvEIXrm9z/JYWq0lJbQQeFBOMAM0dSYrYY3QujbygQqEkhgi797lRaJzY+8T0uUsQ8
         tTspDd3sV8Jr0y+Wj0S4ABrMB3jSqRm5gYiGLfrr2reak0ONI9yTg/iFiT5T4JwLQGrr
         majA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725278513; x=1725883313;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :content-language:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d+PG5oUJxA0435PSYviQLRAdwBXq0onVLuFzi6gfhyQ=;
        b=V7eOW6HhDHG0wkapFoo7YGTXGZ7eVQD3z+dFEuvXayS217DJ/PLjzfK5NuBqSf2CjU
         W12t8muA2y6TLDewLBPPM+Lee5BJv2EmHGx0awlI96roYVyahJuEav7weC1jE8+0/MEi
         dsh8KmV2+aMcak0bV9Kn0DMZxXA/3DI49SeIKKclRSRacRIxwzNrjbHVaHEDNbMOs/52
         KKYdQOnnbR+Vx3E9JsRqyXn+3EIu5mTYNI9cTiFPPyReAdDN0qLCu/tFWKkqkEJP8z6V
         bF3IbZurdo232AoYabTEq0PxZyV3xHeliBPZL8cF0ns9aiRch59d+tppUQ76ewXWhWpG
         Od8A==
X-Gm-Message-State: AOJu0Yyb5CUm0VNEjCstaiPyuRwBc91rSvJ9GAfX1A+OWDOyr5i1rXOl
	gkGK8UWiVfMPjY2rAC/OiSlp8Vvz8qgPsebcXea6sQW8Lu8qHFQg9WpIWTU6KJM=
X-Google-Smtp-Source: AGHT+IFsmajE3p8SHxqwVfYsadm82+1ZIMneZ1sWvsSlJ1ya9DkkeaHWafknDE6TcfPoHeCykGWpLQ==
X-Received: by 2002:a5d:5f4a:0:b0:374:c269:df79 with SMTP id ffacd0b85a97d-374c269e0d7mr5020587f8f.22.1725278512810;
        Mon, 02 Sep 2024 05:01:52 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:1:8ddb:ca93:fc13:4f49? ([2001:67c:2fbc:1:8ddb:ca93:fc13:4f49])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42bb6e273eesm135517355e9.32.2024.09.02.05.01.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Sep 2024 05:01:52 -0700 (PDT)
Message-ID: <4f241c3b-8256-494c-bb84-178e0ee12b72@openvpn.net>
Date: Mon, 2 Sep 2024 14:03:57 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 10/25] ovpn: implement basic TX path (UDP)
To: Sabrina Dubroca <sd@queasysnail.net>
Cc: netdev@vger.kernel.org, kuba@kernel.org, pabeni@redhat.com,
 ryazanov.s.a@gmail.com, edumazet@google.com, andrew@lunn.ch
References: <20240827120805.13681-1-antonio@openvpn.net>
 <20240827120805.13681-11-antonio@openvpn.net> <ZtH7HWxCn0Qyk3wU@hog>
Content-Language: en-US
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <ZtH7HWxCn0Qyk3wU@hog>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 30/08/2024 19:02, Sabrina Dubroca wrote:
> Hi Antonio,
> 
> Thanks for the updated patchset. I'm going through it again.
> 
> 2024-08-27, 14:07:50 +0200, Antonio Quartulli wrote:
>> +/* send skb to connected peer, if any */
>> +static void ovpn_send(struct ovpn_struct *ovpn, struct sk_buff *skb,
>> +		      struct ovpn_peer *peer)
>> +{
>> +	struct sk_buff *curr, *next;
>> +
>> +	if (likely(!peer))
>> +		/* retrieve peer serving the destination IP of this packet */
>> +		peer = ovpn_peer_get_by_dst(ovpn, skb);
>> +	if (unlikely(!peer)) {
>> +		net_dbg_ratelimited("%s: no peer to send data to\n",
>> +				    ovpn->dev->name);
>> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +		goto drop;
>> +	}
>> +
>> +	/* this might be a GSO-segmented skb list: process each skb
>> +	 * independently
>> +	 */
>> +	skb_list_walk_safe(skb, curr, next)
>> +		if (unlikely(!ovpn_encrypt_one(peer, curr))) {
>> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +			kfree_skb(curr);
> 
> Is this a bit inconsistent with ovpn_net_xmit's behavior? There we
> drop the full list if we fail one skb_share_check, and here we only
> drop the single packet that failed and handle the rest? Or am I
> misreading this?

You're right, it's inconsistent.

In ovpn_send() each call to ovpn_encrypt_one() will result in the skb 
being sent, therefore, if we wanted, we could free only skbs we haven't 
sent yet.

Maybe it makes sense to always try sending the rest and assume that the 
upper layer will deal with the missing data.

I'll adjust ovpn_net_xmit() to drop only the failing skb and move on.

> 
>> +		}
>> +
>> +	/* skb passed over, no need to free */
>> +	skb = NULL;
>> +drop:
>> +	if (likely(peer))
>> +		ovpn_peer_put(peer);
>> +	kfree_skb_list(skb);
>> +}
>>   
>>   /* Send user data to the network
>>    */
>>   netdev_tx_t ovpn_net_xmit(struct sk_buff *skb, struct net_device *dev)
>>   {
>> +	struct ovpn_struct *ovpn = netdev_priv(dev);
>> +	struct sk_buff *segments, *tmp, *curr, *next;
>> +	struct sk_buff_head skb_list;
>> +	__be16 proto;
>> +	int ret;
>> +
>> +	/* reset netfilter state */
>> +	nf_reset_ct(skb);
>> +
>> +	/* verify IP header size in network packet */
>> +	proto = ovpn_ip_check_protocol(skb);
>> +	if (unlikely(!proto || skb->protocol != proto)) {
>> +		net_err_ratelimited("%s: dropping malformed payload packet\n",
>> +				    dev->name);
>> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +		goto drop;
>> +	}
>> +
>> +	if (skb_is_gso(skb)) {
>> +		segments = skb_gso_segment(skb, 0);
>> +		if (IS_ERR(segments)) {
>> +			ret = PTR_ERR(segments);
>> +			net_err_ratelimited("%s: cannot segment packet: %d\n",
>> +					    dev->name, ret);
>> +			dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +			goto drop;
>> +		}
>> +
>> +		consume_skb(skb);
>> +		skb = segments;
>> +	}
>> +
>> +	/* from this moment on, "skb" might be a list */
>> +
>> +	__skb_queue_head_init(&skb_list);
>> +	skb_list_walk_safe(skb, curr, next) {
>> +		skb_mark_not_on_list(curr);
>> +
>> +		tmp = skb_share_check(curr, GFP_ATOMIC);
>> +		if (unlikely(!tmp)) {
>> +			kfree_skb_list(next);
> 
> Those don't get counted as dropped, but the ones we've already handled
> (and put on skb_list) will be counted as dev_core_stats_tx_dropped_inc?
> (it probably doesn't matter that much, since if we'd dropped before/at
> skb_gso_segment we'd only count one drop)

Once I change this part, I'll ensure we count each single dropped packet.
The downside is that any failure before skb_gso_segment() is counted as 
1 drop, while anything later than that is counter per-segment.
I don't think we can do anything about it though.

> 
>> +			net_err_ratelimited("%s: skb_share_check failed\n",
>> +					    dev->name);
>> +			goto drop_list;
>> +		}
>> +
>> +		__skb_queue_tail(&skb_list, tmp);
>> +	}
>> +	skb_list.prev->next = NULL;
>> +
>> +	ovpn_send(ovpn, skb_list.next, NULL);
>> +
>> +	return NETDEV_TX_OK;
>> +
>> +drop_list:
>> +	skb_queue_walk_safe(&skb_list, curr, next) {
>> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +		kfree_skb(curr);
>> +	}
>> +drop:
>>   	skb_tx_error(skb);
>> -	kfree_skb(skb);
>> +	kfree_skb_list(skb);
>>   	return NET_XMIT_DROP;
>>   }
> 
> 
> [...]
>> +void ovpn_udp_send_skb(struct ovpn_struct *ovpn, struct ovpn_peer *peer,
>> +		       struct sk_buff *skb)
>> +{
>> +	struct ovpn_bind *bind;
>> +	struct socket *sock;
>> +	int ret = -1;
>> +
>> +	skb->dev = ovpn->dev;
>> +	/* no checksum performed at this layer */
>> +	skb->ip_summed = CHECKSUM_NONE;
>> +
>> +	/* get socket info */
>> +	sock = peer->sock->sock;
>> +	if (unlikely(!sock)) {
>> +		net_warn_ratelimited("%s: no sock for remote peer\n", __func__);
>> +		goto out;
>> +	}
>> +
>> +	rcu_read_lock();
>> +	/* get binding */
>> +	bind = rcu_dereference(peer->bind);
>> +	if (unlikely(!bind)) {
>> +		net_warn_ratelimited("%s: no bind for remote peer\n", __func__);
>> +		goto out_unlock;
>> +	}
>> +
>> +	/* crypto layer -> transport (UDP) */
>> +	ret = ovpn_udp_output(ovpn, bind, &peer->dst_cache, sock->sk, skb);
>> +
>> +out_unlock:
>> +	rcu_read_unlock();
>> +out:
>> +	if (unlikely(ret < 0)) {
>> +		dev_core_stats_tx_dropped_inc(ovpn->dev);
>> +		kfree_skb(skb);
>> +		return;
>> +	}
>> +
>> +	dev_sw_netstats_tx_add(ovpn->dev, 1, skb->len);
> 
> I don't think it's safe to access skb->len after calling
> udp_tunnel(6)_xmit_skb.

Absolutely right! Thanks!

> 
> For example, vxlan_xmit_one (drivers/net/vxlan/vxlan_core.c) has a
> similar counter and saves skb->len into pkt_len.

Yap, will do the same.

Cheers,

-- 
Antonio Quartulli
OpenVPN Inc.

