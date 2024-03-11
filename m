Return-Path: <netdev+bounces-79230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D766878577
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 17:30:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A100C1C21B61
	for <lists+netdev@lfdr.de>; Mon, 11 Mar 2024 16:30:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA7A55C26;
	Mon, 11 Mar 2024 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b="VSEUtuzg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BD974C61F
	for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710174470; cv=none; b=mOznVIWIbCR/A+oOzVP0qx96Ia++Jn1FaaIYYDFruncVBOVGcvSuzeDRne+qC9wMXf2hHe+O5ixSDgA9MQ080N7ohkM2NekCs2iNaXfFXGvjwge92/d979gNSU6PFbZHoPST98fGMgIg0zeOoiLriPJAw7IcOIWqbrzuRXVlL+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710174470; c=relaxed/simple;
	bh=icfEGdBlnRAP0yk1flphk/l4+OVOr1PniPVo+1ib7zg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=m5ehXpCIqj5/yR7zkz42dXnSNKnZOPo102TvPaG/dkIRz9FKTIYIpu56/cFruRPycRNjS0NT2R5uQXpyr/DRpTtW2uNSyDJ13A7Ty/+NBzwv8iHh3Rr2xfDH+f/hhSH8EDN+jtbdw0xTtCAoKFj5qsp4AxW77aeRDu6pFjUEUZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net; spf=pass smtp.mailfrom=openvpn.com; dkim=pass (2048-bit key) header.d=openvpn.net header.i=@openvpn.net header.b=VSEUtuzg; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=openvpn.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvpn.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-33e94c12f33so1434997f8f.3
        for <netdev@vger.kernel.org>; Mon, 11 Mar 2024 09:27:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvpn.net; s=google; t=1710174467; x=1710779267; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=lJQELEmaDQ2s04UlQFFvQPrbC8N/sW6mmdFWuvs/FGQ=;
        b=VSEUtuzgezwegUiELiC1MTVPSiGbfgb8tBqVo64kBbyUdTW61xU3fMq1hPRTyrv6fi
         qspDYu5J1Wp6X1ITuoSgEjk2zmpAgKJVeiaQU/3+jG73YW1FETShTQMTQ18bKmFOyVj6
         BsszkxBNhzaRidXjaFLQmuttzvWOR36BXkE8v0lLUp0rJ/HNJdWgLU504E7OPQQF3D4j
         XLU4R9l1pnKoUgaPo6cEYC6VhA5cOZ+FquU5b5QiAGkuS0CVZHkPiR54yICMa2bT9gEg
         Wk0dFCt2wpFibDfk37tjNRCIXtQu4sKYxXhoFa7l8jjRCayQS7TW3IpIhKvtBwawA6M4
         Rzbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710174467; x=1710779267;
        h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lJQELEmaDQ2s04UlQFFvQPrbC8N/sW6mmdFWuvs/FGQ=;
        b=kiGG6jNQOFE9gShsecmhXtkfJT1QJYlkXMYJ3M/SLSEGJl6aVSu5PTuUsN3g0AgPwU
         AfPMoA1Rr0e/Jco1gjnOm9cBw0WKlW3EjYsXX1thlpMtJoej/l8mYoX5pUQ3sphTr5BI
         K1rRh87hj3jqjlaY7zthb2PwXgknF/Acq9RWjAN/Jtu/xC+xTIXQYM4mTTwCV85q1qll
         AtJSoIPpKGo+RVuBdWeq0KA/tApyu8/SdZ4vJUugXSkqdK6O68PIyBADsGKtyD0qPsyp
         mFgEVB2W5ZDj7ikTfBpMQ/ieETcE8hOLVGfA8LkcYOQARWR+xAyi23RIgbJNuVciZcKk
         75WA==
X-Forwarded-Encrypted: i=1; AJvYcCWAErZwxJKkTfDOzEF/Y6nV/QNPhxPsHFk6ypY9lb9cQsGOAGKhHLjE2nHBLUwScwpofePQrmvsIgIQLaH+fRLMTHAKzHEd
X-Gm-Message-State: AOJu0YxHM3Ddx3SCmO6H60afyGoIcXdkxuddGqRFSbLTQBd4kyuvcyDY
	1Vx2LhsI9bbcrRdfcA9ngVkXnjIaeB97ya9MixaWEaTs0Vm+kkIYx2EppptdZmM=
X-Google-Smtp-Source: AGHT+IGdz7OUh32DV5pfZ8xkCEeE84/OZGF6ltB1l1jwR7n7ZaM/ffM4bXnNQqU+K0l1bnY/BkmyMw==
X-Received: by 2002:a5d:56d2:0:b0:33e:6ce2:88ab with SMTP id m18-20020a5d56d2000000b0033e6ce288abmr4559155wrw.46.1710174466770;
        Mon, 11 Mar 2024 09:27:46 -0700 (PDT)
Received: from ?IPV6:2001:67c:2fbc:0:c0e1:a7b8:608:a4bd? ([2001:67c:2fbc:0:c0e1:a7b8:608:a4bd])
        by smtp.gmail.com with ESMTPSA id z2-20020a5d44c2000000b0033e2b9f647asm6831570wrr.31.2024.03.11.09.27.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Mar 2024 09:27:46 -0700 (PDT)
Message-ID: <13c356da-09e5-4830-8ca5-be7e7df31676@openvpn.net>
Date: Mon, 11 Mar 2024 17:28:13 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2 08/22] ovpn: implement basic TX path (UDP)
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 netdev@vger.kernel.org
Cc: Jakub Kicinski <kuba@kernel.org>, Sergey Ryazanov
 <ryazanov.s.a@gmail.com>, Paolo Abeni <pabeni@redhat.com>,
 Eric Dumazet <edumazet@google.com>
References: <20240304150914.11444-1-antonio@openvpn.net>
 <20240304150914.11444-9-antonio@openvpn.net> <87ttlgrb86.fsf@toke.dk>
 <0273cf51-fbca-453d-81da-777b9462ce3c@openvpn.net> <87edcgre2m.fsf@toke.dk>
From: Antonio Quartulli <antonio@openvpn.net>
Autocrypt: addr=antonio@openvpn.net; keydata=
 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
Organization: OpenVPN Inc.
In-Reply-To: <87edcgre2m.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 11/03/2024 16:19, Toke Høiland-Jørgensen wrote:
> Antonio Quartulli <antonio@openvpn.net> writes:
> 
>> Hi Toke,
>>
>> On 08/03/2024 16:31, Toke Høiland-Jørgensen wrote:
>>> Antonio Quartulli <antonio@openvpn.net> writes:
>>>
>>>> +/* send skb to connected peer, if any */
>>>> +static void ovpn_queue_skb(struct ovpn_struct *ovpn, struct sk_buff *skb, struct ovpn_peer *peer)
>>>> +{
>>>> +	int ret;
>>>> +
>>>> +	if (likely(!peer))
>>>> +		/* retrieve peer serving the destination IP of this packet */
>>>> +		peer = ovpn_peer_lookup_by_dst(ovpn, skb);
>>>> +	if (unlikely(!peer)) {
>>>> +		net_dbg_ratelimited("%s: no peer to send data to\n", ovpn->dev->name);
>>>> +		goto drop;
>>>> +	}
>>>> +
>>>> +	ret = ptr_ring_produce_bh(&peer->tx_ring, skb);
>>>> +	if (unlikely(ret < 0)) {
>>>> +		net_err_ratelimited("%s: cannot queue packet to TX ring\n", peer->ovpn->dev->name);
>>>> +		goto drop;
>>>> +	}
>>>> +
>>>> +	if (!queue_work(ovpn->crypto_wq, &peer->encrypt_work))
>>>> +		ovpn_peer_put(peer);
>>>> +
>>>> +	return;
>>>> +drop:
>>>> +	if (peer)
>>>> +		ovpn_peer_put(peer);
>>>> +	kfree_skb_list(skb);
>>>> +}
>>>
>>> So this puts packets on a per-peer 1024-packet FIFO queue with no
>>> backpressure? That sounds like a pretty terrible bufferbloat situation.
>>> Did you do any kind of latency-under-load testing of this, such as
>>> running the RRUL test[0] through it?
>>
>> Thanks for pointing this out.
>>
>> Andrew Lunn just raised a similar point about these rings being
>> potential bufferbloat pitfalls.
>>
>> And I totally agree.
>>
>> I haven't performed any specific test, but I have already seen latency
>> bumping here and there under heavy load.
>>
>> Andrew suggested at least reducing rings size to something like 128 and
>> then looking at BQL.
>>
>> Do you have any hint as to what may make sense for a first
>> implementation, balancing complexity and good results?
> 
> Hmm, I think BQL may actually be fairly straight forward to implement
> for this; if you just call netdev_tx_sent_queue() when the packet has
> been encrypted and sent on to the lower layer, the BQL algorithm should
> keep the ring buffer occupancy just at the level it needs to be to keep
> the encryption worker busy. I am not sure if there is some weird reason
> this won't work for something like this, but I can't think of any off
> the top of my head. And implementing this should be fairly simple (it's
> just a couple of function calls in the right places). As an example, see
> this commit adding it to the mvneta driver:
> 
> a29b6235560a ("net: mvneta: add BQL support")
> 
> Not sure if some additional mechanism is needed to keep a bunch of
> encrypted packets from piling up in the physical device qdisc (after
> encryption), but that will be in addition, in that case.

Thank you very much - really appreciated.

I will look into the mentioned commit and will try to implement this 
logic in the next patchset iteration.

Regards,


-- 
Antonio Quartulli
OpenVPN Inc.

