Return-Path: <netdev+bounces-214519-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C5ACBB2A03B
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 13:24:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C3EE03BCDB0
	for <lists+netdev@lfdr.de>; Mon, 18 Aug 2025 11:22:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4515B3176F5;
	Mon, 18 Aug 2025 11:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cn90VWsG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501B01D5AB7;
	Mon, 18 Aug 2025 11:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755516177; cv=none; b=rOa+yLwwxOMrRRSiik9Q7VKyvwPvZzWKeplzNNqConFpa7T6ZMjR0L54ovE8zUWOilxw2wmEP5dkd9QCLkBlE2D5qY4kCABL2/uU+VE5JmFCQ3aA2kgWVbG72hs1tthAUZ2jswL0iDskWxcJBPrtbf+bgoSzkeu78S1jiqrnrHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755516177; c=relaxed/simple;
	bh=BQL0SA6XaKPL1/GGgpFkxkE845V67jAs0R7WLk77ebw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r7dYQtyZNMPbaLALTaVSQq/N4SvDhghZ2gcvkFtRm8Exxg6jJ17RB1Ai2qpedtfgGbbRnkmxi8E6+F3eDa27bBIFHp1iEa0a6kd7c3h6LdrwAnwpQaWQ2hNcz0ds9ZaXPErts/AwtwhpOggHYquK61q8fgjL2R0p7zZ28qxlNlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cn90VWsG; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3b9dc5c6521so2882466f8f.1;
        Mon, 18 Aug 2025 04:22:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755516173; x=1756120973; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:from:to:cc:subject:date:message-id
         :reply-to;
        bh=t+g+H/X7Ptdu1coq2expUezipmKk6idAUXY7w1+ZpAE=;
        b=cn90VWsG0WWSoE/jt0+ZXNz2WwixrHetkcIJ5I2Xs01jTa62XTLNaM3nbDSUcXulQe
         G4mJMb1koEsgXwm5QP2ReZ3J1DtvN5mXkV1z2UezHq2eS9XvNouN1KG406i76BtSckvK
         y3Bdr7mcob6nyYYqIfbhB5FgWBEDcsofM0G21/3iyG07mj/Wxtbd5bO3FZfkTkIwJrdN
         o57MwyxPapfBNhK2p7coWtcUotrMoWbmZSWWstg1y2zR96XjYPYC0Bp/T+jpMzthWKU5
         7z1ASZ8qa/hNzV/2HOPVZZ2emU9DprTT/3aaPEmC7Wc9uc48/5WJBbNDalBrchoOQwUq
         wc3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755516173; x=1756120973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=t+g+H/X7Ptdu1coq2expUezipmKk6idAUXY7w1+ZpAE=;
        b=dMIYjpeXxaG1pwEf2glt/s9t1usTidnTrt/mKbpWwdvwQdDRNDR0yFr0KVPKFXGR+i
         IgU2kNkc1+VCdKCu+oNsB/lrzhD3CjnubAJUSli+hXlb6foV6m4HKly3DxcpNlebFykj
         DY1XjBQR+BIXx3lLWamwdC3OxlbGT8Kg8DIo74hjfc/Xp68fQK24N5wWVmqqlhCIdMcV
         +IcrgzLUQzskHr7X3p1yRP1z7nS0Sl6DYaL1D6eutsSDrEjyxUW6fYZJGID87XbjsKrY
         GIq4zegud1Z431fxQDiqG79DOscoPniLa1M4P//TwyF3u9EH0mNDuRM+R8ZcC5m5O/Ax
         idqw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ3dqipd+0zKQ2xCKnpTFnh86z9fVFdfrM2RtaeUa7t93hUjTYddsyAixGzETusuH+vKWh9hA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5Fo1fhw/F0YV94IiHbeiRqAsIVuL5aEBT31SW3SNZOwT48f6F
	ttCcu5WFlMNBwgC4EfmMF/oMy6w2O+fZH6G9YlC7I4A4KZOkEXghKl7mLCqYs58faEo=
X-Gm-Gg: ASbGncsy+nI9j47kkK7uhO4lh6FkzX8s37cwC6eXWoR8F88w8CjQcDIBELoRJhh8LgH
	DhbIzoawl9BkwhtgD4I+xWKRHwf0XAEtLd08h0Dy+/MVdO2who9H3cQkf1IpdqjgLXdvSzj2tRB
	RB2Hv4+T451xaQ6k47tvg3yO9T4k3et2Cc4JgtG0CjNoKZfkDyLfAyMg1au2Rx4t7q8IxALmRKa
	eJJ7StUpPMPQPHZW+AC87006GNJOlZZjNbNknXPxI14igzst5X/rMbbo3onllztz32p56s9/yeb
	zUt7TQVORpkIC0ZjzR/MXSWAljeGrZXsqf4/A/gGACRcx8xCumFbS4Itv9I9YhXIS1oRsKJtCyt
	UZAC0rGd17O7bnRhM+8gt90u9dKWcSd89wQ7EriJFZE2y
X-Google-Smtp-Source: AGHT+IGrknLZ8TL0IEIB04yKmBwI/H1DuAmurmt0b/omwVR2yL015y4vAUDdzx6FJ8CkPcb35RZeAw==
X-Received: by 2002:a5d:5885:0:b0:3a4:d6ed:8df8 with SMTP id ffacd0b85a97d-3bb68cf8eacmr8021530f8f.39.1755516173151;
        Mon, 18 Aug 2025 04:22:53 -0700 (PDT)
Received: from localhost ([45.10.155.11])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3bb680795a4sm12222333f8f.51.2025.08.18.04.22.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Aug 2025 04:22:52 -0700 (PDT)
Message-ID: <e01a463b-c52c-4f8a-9477-fd413286e41a@gmail.com>
Date: Mon, 18 Aug 2025 13:22:42 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH net-next v3] net: pppoe: implement GRO/GSO support
To: Felix Fietkau <nbd@nbd.name>, netdev@vger.kernel.org,
 Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Ahern <dsahern@kernel.org>, Simon Horman <horms@kernel.org>
Cc: linux-kernel@vger.kernel.org
References: <20250811095734.71019-1-nbd@nbd.name>
 <68be885c-f3ea-48aa-91c9-673f9c67fe28@gmail.com>
 <b5bd82bb-b625-4824-9d45-4d1f41c100ad@nbd.name>
From: Richard Gobert <richardbgobert@gmail.com>
In-Reply-To: <b5bd82bb-b625-4824-9d45-4d1f41c100ad@nbd.name>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Felix Fietkau wrote:
> On 14.08.25 16:30, Richard Gobert wrote:
>> Felix Fietkau wrote:
>>> Only handles packets where the pppoe header length field matches the exact
>>> packet length. Significantly improves rx throughput.
>>>
>>> When running NAT traffic through a MediaTek MT7621 devices from a host
>>> behind PPPoE to a host directly connected via ethernet, the TCP throughput
>>> that the device is able to handle improves from ~130 Mbit/s to ~630 Mbit/s,
>>> using fraglist GRO.
>>>
>>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>>> ---
>>> v2: fix compile error
>>> v3:
>>>   - increase priority value
>>>   - implement GSO support
>>>   - use INDIRECT_CALL_INET
>>>   - update pppoe length field
>>>   - remove unnecessary network_offsets update
>>>
>>>  drivers/net/ppp/pppoe.c | 160 +++++++++++++++++++++++++++++++++++++++-
>>>  net/ipv4/af_inet.c      |   2 +
>>>  net/ipv6/ip6_offload.c  |   2 +
>>>  3 files changed, 163 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/net/ppp/pppoe.c b/drivers/net/ppp/pppoe.c
>>> index 410effa42ade..a8d8eb870bce 100644
>>> --- a/drivers/net/ppp/pppoe.c
>>> +++ b/drivers/net/ppp/pppoe.c
>>> +compare_pppoe_header(struct pppoe_hdr *phdr, struct pppoe_hdr *phdr2)
>>> +{
>>> +    return (__force __u16)((phdr->sid ^ phdr2->sid) |
>>> +                   (phdr->tag[0].tag_type ^ phdr2->tag[0].tag_type));
>>> +}
>>> +
>>> +static __be16 pppoe_hdr_proto(struct pppoe_hdr *phdr)
>>> +{
>>> +    switch (phdr->tag[0].tag_type) {
>>> +    case cpu_to_be16(PPP_IP):
>>> +        return cpu_to_be16(ETH_P_IP);
>>> +    case cpu_to_be16(PPP_IPV6):
>>> +        return cpu_to_be16(ETH_P_IPV6);
>>> +    default:
>>> +        return 0;
>>> +    }
>>> +
>>> +}
>>> +
>>> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
>>> +                     struct sk_buff *skb)
>>> +{
>>> +    const struct packet_offload *ptype;
>>> +    unsigned int hlen, off_pppoe;
>>> +    struct sk_buff *pp = NULL;
>>> +    struct pppoe_hdr *phdr;
>>> +    struct sk_buff *p;
>>> +    int flush = 1;
>>> +    __be16 type;
>>> +
>>> +    off_pppoe = skb_gro_offset(skb);
>>> +    hlen = off_pppoe + sizeof(*phdr);
>>> +    phdr = skb_gro_header(skb, hlen + 2, off_pppoe);
>>> +    if (unlikely(!phdr))
>>> +        goto out;
>>> +
>>> +    /* ignore packets with padding or invalid length */
>>> +    if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen)
>>> +        goto out;
>>> +
>>> +    type = pppoe_hdr_proto(phdr);
>>> +    if (!type)
>>> +        goto out;
>>> +
>>> +    ptype = gro_find_receive_by_type(type);
>>> +    if (!ptype)
>>> +        goto out;
>>> +
>>> +    flush = 0;
>>> +
>>> +    list_for_each_entry(p, head, list) {
>>> +        struct pppoe_hdr *phdr2;
>>> +
>>> +        if (!NAPI_GRO_CB(p)->same_flow)
>>> +            continue;
>>> +
>>> +        phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
>>> +        if (compare_pppoe_header(phdr, phdr2))
>>> +            NAPI_GRO_CB(p)->same_flow = 0;
>>> +    }
>>> +
>>> +    skb_gro_pull(skb, sizeof(*phdr) + 2);
>>> +    skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
>>> +
>>> +    pp = indirect_call_gro_receive_inet(ptype->callbacks.gro_receive,
>>> +                        ipv6_gro_receive, inet_gro_receive,
>>> +                        head, skb);
>>> +
>>> +out:
>>> +    skb_gro_flush_final(skb, pp, flush);
>>> +
>>> +    return pp;
>>> +}
>>> +
>>> +static int pppoe_gro_complete(struct sk_buff *skb, int nhoff)
>>> +{
>>> +    struct pppoe_hdr *phdr = (struct pppoe_hdr *)(skb->data + nhoff);
>>> +    __be16 type = pppoe_hdr_proto(phdr);
>>> +    struct packet_offload *ptype;
>>> +    int len, err;
>>> +
>>> +    ptype = gro_find_complete_by_type(type);
>>> +    if (!ptype)
>>> +        return -ENOENT;
>>> +
>>> +    err = INDIRECT_CALL_INET(ptype->callbacks.gro_complete,
>>> +                 ipv6_gro_complete, inet_gro_complete,
>>> +                 skb, nhoff + sizeof(*phdr) + 2);
>>> +    if (err)
>>> +        return err;
>>> +
>>> +    len = skb->len - (nhoff + sizeof(*phdr));
>>> +    phdr->length = cpu_to_be16(len);
>>> +
>>> +    return 0;
>>> +}
>>> +
>>> +static struct sk_buff *pppoe_gso_segment(struct sk_buff *skb,
>>> +                     netdev_features_t features)
>>> +{
>>
>> I don't think this will be called for PPPoE over GRE packets,
>> since gre_gso_segment skips everything up to the network header.
> 
> What's a good solution to this issue? Use the outer network header instead of the inner one when the protocol is PPPoE?
> 
> - Felix

I don't really have a good solution for this. You could explicitly check
if the protocol is PPPoE in gre_gso_segment, but that wouldn't be very
elegant or future-proof.
 
I think setting skb->inner_network_header in pppoe_gro_complete
(while not resetting it in inet_gro_complete) wouldn't work since other
functions assume that skb->inner_network_header is an IP header.


