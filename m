Return-Path: <netdev+bounces-210046-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F0E6B11F07
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 14:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0C9F18941C2
	for <lists+netdev@lfdr.de>; Fri, 25 Jul 2025 12:54:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C509C2ECD17;
	Fri, 25 Jul 2025 12:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWeHC8nj"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3FA62405F9
	for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 12:54:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753448053; cv=none; b=GYaQ4/xkMoneK1lxMRZLpVvJOGeKcz8n7rjC++hUamfzOrxrtuBjOLCzrHOO0SC08K3fy07ybMwLWX5eiUMQiQ/FAM52Dn6gzvN01iT8T9zPPsdKibUW2Pqyfv7tWTTTx70pu1F4tpFzZE+KFNvzSNWIhy280eHtsGywUSwoLs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753448053; c=relaxed/simple;
	bh=n6Pv49YI2ixqQxeXeoElRqTOz7LINnIIS8q9IK1ssoM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Vx/sL9/LsnwsG46OTUXmRh46De7rE3PAQPUMQICKVAAH3bys9k8HgVG+MQKM4GjXxlsKprjRBdgjzXUz8/0+1Fg87zkCcWBbWWpcrQ9qcf0dVGHnLaOfj2D/0rftVsGe9U1jySzGEVNCIIYJ1B6e0hCBYIxlV8yDzfN4nx7qqt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWeHC8nj; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753448050;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gnS/9RA0O+Nr1ONscGv61A0UEDWCGQVb3k03oaKVO74=;
	b=aWeHC8nj6VZbcK9974JxiBBC6l7VDvQx2FWAWPAs+CpzDnYU3KKO9ZyaunVXkFU9uzaM5K
	IvXmR2BBqjuBjzeB30kFCpHZeXa+dEaC0dmhUKrSmCuoacomIsORO3s9/k0sVuUFhBpEHA
	k9A6gg7tN2ZTFzGXmhia2fE1me9g+38=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-d3T-znw0Nqu22NcrH7KP0g-1; Fri, 25 Jul 2025 08:54:09 -0400
X-MC-Unique: d3T-znw0Nqu22NcrH7KP0g-1
X-Mimecast-MFC-AGG-ID: d3T-znw0Nqu22NcrH7KP0g_1753448048
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4f6ba526eso1552935f8f.1
        for <netdev@vger.kernel.org>; Fri, 25 Jul 2025 05:54:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753448048; x=1754052848;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gnS/9RA0O+Nr1ONscGv61A0UEDWCGQVb3k03oaKVO74=;
        b=LovDu4s8p7eQ5JmJC10VoYabTKzOMgDANYBgvvKMTfvTCaXFf4PFYI6vtVQwZl2yzS
         0MkjnqzcQkjKZ1JB+M4rrQPdkdc2IuKhSyALWkkoO4JrJVfK6m99InyPuEXTzTRv5hhj
         YAbfMowgEs6iayCalS1J16IGg3X3UzW29GPUttCX3bZmUxv2L7pa+1HNGedXcbiPBLn6
         0vvpMCD1h+0/Wnh32buU1+yxtqEaMzEOcoqrmsANyf4wT6F2Lk2IHMxxXITBo03ZB3sD
         BFukz8Q1xLMhbnYPih9tMRpwrflNZGxkwGp9tS5nUh6rBVr3B0WcKRGreUvhznODWMF7
         hTkA==
X-Gm-Message-State: AOJu0Yx072fkLg5OBg9M02WVwuySImxCxP313UnAjpTMR+XAfU4oOMBU
	GVEomsWcW/K9WexKb44pwiaoqqq/PKfzp8pNjkbx1s7zz7AIJtc3FPyd82svveRtLfGLXBD61s8
	g9YjLJOa4HvyBCjAASrsBpQoO5rR2Lx53GNiI/y8fmgXG60hMULukXzfeDA==
X-Gm-Gg: ASbGncumQEuE9GUMP1WMoDWFotPF6WQKxlC8GIsiF60NIwgwFv9qm1kjBVIHQZEaaZr
	mJsNEI7xIijdcXewWGWvIBdT5NzcVwolT5AoZXf3PPXSN3CJp9HbttgNXZ+2e2Q3ZEPMmkyK/LG
	DxKMCVEvL/w/po85qz/lOy2zV48CLA6lkIJ7dPuB/PwZB6d6xwF8xafI4gbsGT1QZrk1+zMrhTN
	y989kUUMwl908PF+1I5EpMnmvmp41oltxK9+B6N5Wxk4La8r1uom6w8EDNkHfp+CPUyJWTO6MfP
	D6WXN4zigB0WITpWFvH2OwgFXMPGfIFUu/GpSXloDHSmL9qI+AV1oi26O28fPeWzH2OvHm/9+n4
	eo9LypPzeDY8=
X-Received: by 2002:a5d:584a:0:b0:3b6:463:d886 with SMTP id ffacd0b85a97d-3b77673ccd7mr1532680f8f.20.1753448048280;
        Fri, 25 Jul 2025 05:54:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnV/rTUIg6XNZcuQXqD7Mby5vL1dPZ+EQSiUq6okt35LgK8UVlU5ZqK2/bmlNQOz46/9c5Tw==
X-Received: by 2002:a5d:584a:0:b0:3b6:463:d886 with SMTP id ffacd0b85a97d-3b77673ccd7mr1532648f8f.20.1753448047723;
        Fri, 25 Jul 2025 05:54:07 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-458705377dasm53895725e9.4.2025.07.25.05.54.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jul 2025 05:54:07 -0700 (PDT)
Message-ID: <5fce419c-622f-4eda-ab92-86deaf0db5ca@redhat.com>
Date: Fri, 25 Jul 2025 14:54:06 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v2] net: pppoe: implement GRO support
To: Alexander Lobakin <aleksander.lobakin@intel.com>,
 Felix Fietkau <nbd@nbd.name>
Cc: netdev@vger.kernel.org, Michal Ostrowski <mostrows@earthlink.net>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, linux-kernel@vger.kernel.org
References: <20250716081441.93088-1-nbd@nbd.name>
 <5f250beb-6a81-42b2-bf6f-da02c04cbf15@redhat.com>
 <0861d960-d1e7-4b51-b320-c2e033b49f12@nbd.name>
 <46fd972c-14d9-4876-8df5-1212f6530971@intel.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <46fd972c-14d9-4876-8df5-1212f6530971@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 7/25/25 2:42 PM, Alexander Lobakin wrote:
> From: Felix Fietkau <nbd@nbd.name> Date: Tue, 22 Jul 2025 10:56:10 +0200
>> On 22.07.25 10:36, Paolo Abeni wrote:
>>> On 7/16/25 10:14 AM, Felix Fietkau wrote:
>>>> +static struct sk_buff *pppoe_gro_receive(struct list_head *head,
>>>> +                     struct sk_buff *skb)
>>>> +{
>>>> +    const struct packet_offload *ptype;
>>>> +    unsigned int hlen, off_pppoe;
>>>> +    struct sk_buff *pp = NULL;
>>>> +    struct pppoe_hdr *phdr;
>>>> +    struct sk_buff *p;
>>>> +    __be16 type;
>>>> +    int flush = 1;
>>>
>>> Minor nit: please respect the reverse christmas tree order above
>>
>> Will do
>>
>>>> +    off_pppoe = skb_gro_offset(skb);
>>>> +    hlen = off_pppoe + sizeof(*phdr) + 2;
>>>> +    phdr = skb_gro_header(skb, hlen, off_pppoe);
>>>> +    if (unlikely(!phdr))
>>>> +        goto out;
>>>> +
>>>> +    /* ignore packets with padding or invalid length */
>>>> +    if (skb_gro_len(skb) != be16_to_cpu(phdr->length) + hlen - 2)
>>>> +        goto out;
>>>> +
>>>> +    NAPI_GRO_CB(skb)->network_offsets[NAPI_GRO_CB(skb)->encap_mark]
>>>> = hlen;
>>>> +
>>>> +    type = pppoe_hdr_proto(phdr);
>>>> +    if (!type)
>>>> +        goto out;
>>>> +
>>>> +    ptype = gro_find_receive_by_type(type);
>>>> +    if (!ptype)
>>>> +        goto out;
>>>> +
>>>> +    flush = 0;
>>>> +
>>>> +    list_for_each_entry(p, head, list) {
>>>> +        struct pppoe_hdr *phdr2;
>>>> +
>>>> +        if (!NAPI_GRO_CB(p)->same_flow)
>>>> +            continue;
>>>> +
>>>> +        phdr2 = (struct pppoe_hdr *)(p->data + off_pppoe);
>>>> +        if (compare_pppoe_header(phdr, phdr2))
>>>> +            NAPI_GRO_CB(p)->same_flow = 0;
>>>> +    }
>>>> +
>>>> +    skb_gro_pull(skb, sizeof(*phdr) + 2);
>>>> +    skb_gro_postpull_rcsum(skb, phdr, sizeof(*phdr) + 2);
>>>> +
>>>> +    pp = ptype->callbacks.gro_receive(head, skb);
>>>
>>> Here you can use INDIRECT_CALL_INET()
>>
>> I did that in the initial version, but then I got reports of build
>> failures with the patch:
>>
>> ERROR: modpost: "inet_gro_receive" [drivers/net/ppp/pppoe.ko] undefined!
>> ERROR: modpost: "inet_gro_complete" [drivers/net/ppp/pppoe.ko] undefined!
>>
>> Should I leave it out, or export inet_gro_receive/complete?
> 
> Could be exported I'd say. This would allows more modules to implement
> GRO support.
> INDIRECT_CALL() here gives good boosts here, at least I got some after
> switching VLAN and TEB code several years ago.
> 
> If everyone is fine with exporting, I'd say those need to be exported as
> GPL-only.

Thanks Olek, I was almost missing this!

I agree with exporting GPL-only the symbols.

Thanks,

Paolo


