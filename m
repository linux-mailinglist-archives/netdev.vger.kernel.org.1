Return-Path: <netdev+bounces-194255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A29CAC80C6
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 18:17:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3E2861C00726
	for <lists+netdev@lfdr.de>; Thu, 29 May 2025 16:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEC26205E3E;
	Thu, 29 May 2025 16:17:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nvw88PBi"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81A31D86C6
	for <netdev@vger.kernel.org>; Thu, 29 May 2025 16:17:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748535465; cv=none; b=efoyirfUzAZ7XXggITi1/HAo4jgDVtEQt9cDY7bUA2tBWOOMY5lXYhQpOkc4f+YeVJwHFK9XPUrSlzOYAIALlcdJwL8Uil0nIFVvgHH2cfDfkun+p/6ZUXZW7RCpIjIWLlzLfqAnVMmGOfW8OBKOPmtdCXWWlN92TVNXgPIZ44Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748535465; c=relaxed/simple;
	bh=P0CevtuTr8QsIefgcOe3r7zYgM3L+xRZU8hQxoY5uBs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=HAcc9i8gl1VY5KEjDPKdIVtC8tL08YgazkrZuuWKheengW/4fHCk0sqLVWSmgnAf+jx42DH4SCpERQtMqq+m0JwZhSPD4xBhoxxgq/ts6/CC5lgkcrAN4g4P01AO1B60Ignu9OU688sWWCoWLeWJNFIWMgADex08MQLEsW3lBkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nvw88PBi; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748535462;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lwYfLyKrTghuL9CSWY0ubFvImQj3daz66v1a8Nck3I0=;
	b=Nvw88PBi9BwIbsW4JJBTiP/75/XQtMuXx/q9qhQkOGWNxzbZukbK9crTOQrDERfC6+Qw83
	pxzJPKfwBD5y8+iFJ+MkrOx6+dCMQnvu9XgUgXdWFO6vFofTKhXYhgEPdxF8rYqwxAnRYt
	VZr5ttT7hTn9VQ6zxO1AW7sBDgCH2Po=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-373-hvLdGfR1MBqac6BklWf4RQ-1; Thu, 29 May 2025 12:17:31 -0400
X-MC-Unique: hvLdGfR1MBqac6BklWf4RQ-1
X-Mimecast-MFC-AGG-ID: hvLdGfR1MBqac6BklWf4RQ_1748535450
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-43d0830c3f7so9769935e9.2
        for <netdev@vger.kernel.org>; Thu, 29 May 2025 09:17:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748535450; x=1749140250;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lwYfLyKrTghuL9CSWY0ubFvImQj3daz66v1a8Nck3I0=;
        b=rFmuL47R3MXTKmjIoekEhdDOLHSGZLgso4GZqfUlXvnIv0thHO5fhChjGK/w8hTBir
         Gd7yGxopPj74qBbzQiVO0zChA5e2A/uPgwgIa1dWTO7AdWWveZgCyzhDNeKKwISMP0GC
         FsPndQVgUaK3P86WQFCXJB5vXHH/LYgOqCaFA8JTrvPVeV9cwals23ngpxaQGyRfECQr
         2IFz2aiPwHi7yn2P9HKNkicPt6Z1a/rURjuMyNtoQMrqQ2xKb7THJlNJdqBVzWpvqiIH
         lmPMszVytP2XscCTg72x/EDP9cwkF5LbujKfdhhF6o+C/ffPEL0uWYGoWDIdDqd1y2Bu
         ap1A==
X-Gm-Message-State: AOJu0Ywe/8hzUDW98FzAsJY6FoGIAIM7lCs5G0zrwNOHxyyakRc99AJE
	BAhlMNKKg6htcI/oyp96lUO3nOrvx373eV8hCsMrZLTJKNhkc2KvXBS5kIwN5Y7o6tVPf0YDE+5
	NX5U/nEO5bi2M2w/jAdWpKQokP5VXcBq5QtbUAc9OtkSmR73bY+ZU4ysDog==
X-Gm-Gg: ASbGncu7zGotheoKyTHiTecJd+fpB68mk7W0a7AW4U4qNFI4Hbnu/SC5ocCGw0MQGJ+
	DjXZQzveeCVPbuldB74prMYorbsyUCrj6VzmS6iY8iXIflcXutnXCsDvRt36VBRwCzEnmNHA+Ko
	ltlisH11PDoYB6hnVvfFnUD+X8oizbbcQWqUbHcvW/c7GkrgJT6T6uhYw7SYSPtM/CqcoraCCr7
	M5Shpwsezlwyaot1lgy0KhZRR9wekRj2A0JWP59fv2Thb4JHyuP9o9XTWWSevU3IJoI16vg55h+
	gEA0nSMsFBAQsExk2NE=
X-Received: by 2002:a05:600c:4fc6:b0:442:f4a3:9338 with SMTP id 5b1f17b1804b1-450d6584e7fmr3133595e9.21.1748535450233;
        Thu, 29 May 2025 09:17:30 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHU575vv8UjJwjluX08uktE8GX7LrdHIeNDKwk+GwD0rj7r8X0aVDCuipWGMf4NrUD5j235Kg==
X-Received: by 2002:a05:600c:4fc6:b0:442:f4a3:9338 with SMTP id 5b1f17b1804b1-450d6584e7fmr3133265e9.21.1748535449767;
        Thu, 29 May 2025 09:17:29 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:cce5:2e10::f39? ([2a0d:3341:cce5:2e10::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4efe6c842sm2390085f8f.29.2025.05.29.09.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 29 May 2025 09:17:29 -0700 (PDT)
Message-ID: <82b00219-73e8-4330-99b4-3a0a2fe86a50@redhat.com>
Date: Thu, 29 May 2025 18:17:27 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] tun: enable gso over UDP tunnel support.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <bb441f9ccadc27bf41eb1937101d1d30fa827af5.1747822866.git.pabeni@redhat.com>
 <CACGkMEv5cXoA7aPOUmE63fRg21Kefx3MNE4VenGciL92WbvS_g@mail.gmail.com>
 <68620cd9-923e-49df-ad39-482c3fa22be4@redhat.com>
 <CACGkMEvpr1cqh2CaA6rP03T-dqzKcqkKV6cq+zCfCgAew=+CRw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvpr1cqh2CaA6rP03T-dqzKcqkKV6cq+zCfCgAew=+CRw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/27/25 6:19 AM, Jason Wang wrote:
> On Mon, May 26, 2025 at 7:20 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> On 5/26/25 6:40 AM, Jason Wang wrote:
>>> On Wed, May 21, 2025 at 6:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>>>
>>>> Add new tun features to represent the newly introduced virtio
>>>> GSO over UDP tunnel offload. Allows detection and selection of
>>>> such features via the existing TUNSETOFFLOAD ioctl, store the
>>>> tunnel offload configuration in the highest bit of the tun flags
>>>> and compute the expected virtio header size and tunnel header
>>>> offset using such bits, so that we can plug almost seamless the
>>>> the newly introduced virtio helpers to serialize the extended
>>>> virtio header.
>>>>
>>>> As the tun features and the virtio hdr size are configured
>>>> separately, the data path need to cope with (hopefully transient)
>>>> inconsistent values.
>>>
>>> I'm not sure it's a good idea to deal with this inconsistency in this
>>> series as it is not specific to tunnel offloading. It could be a
>>> dependency for this patch or we can leave it for the future and just
>>> to make sure mis-configuration won't cause any kernel issues.
>>
>> The possible inconsistency is not due to a misconfiguration, but to the
>> facts that:
>> - configuring the virtio hdr len and the offload is not atomic
>> - successful GSO over udp tunnel parsing requires the relevant offloads
>> to be enabled and a suitable hdr len.
>>
>> Plain GSO don't have a similar problem because all the relevant fields
>> are always available for any sane virtio hdr length, but we need to deal
>> with them here.
> 
> Just to make sure we're on the same page.
> 
> I meant tun has TUNSETVNETHDRSZ, so user space can set it to any value
> at any time as long as it's not smaller than sizeof(struct
> virtio_net_hdr). Tun and vhost need to cope with this otherwise it
> should be a bug. This is allowed before the introduction of tunnel
> gso.

This code here is intended to support such scenario; but if the virtio
hdr size is configured to be lower than the minimum required for UDP
tunnel hdr fields, the related offload could not be used.

>>>> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>>>         struct sk_buff *skb;
>>>>         size_t total_len = iov_iter_count(from);
>>>>         size_t len = total_len, align = tun->align, linear;
>>>> -       struct virtio_net_hdr gso = { 0 };
>>>> +       char buf[TUN_VNET_TNL_SIZE];
>>>
>>> I wonder why not simply
>>>
>>> 1) define the structure virtio_net_hdr_tnl_gso and use that
>>>
>>> or
>>>
>>> 2) stick the gso here and use iter advance to get
>>> virtio_net_hdr_tunnel when necessary?
>>
>> Code wise 2) looks more complex
> 
> I don't know how to define complex but we've already use a conatiner structure:
> 
> struct virtio_net_hdr_v1_hash {
>         struct virtio_net_hdr_v1 hdr;
>         __le32 hash_value;
> ...
>         __le16 hash_report;
>         __le16 padding;
> };
> 
>> and 1) will require additional care when
>> adding hash report support.
> 
> I don't understand here, you're doing:
> 
>         iov_iter_advance(from, sz - parsed_size);
> 
> in __tun_vnet_hdr_get(), so this logic needs to be extended for hash
> report as well.

Note that there are at least 2 different virtio net hdr binary layout
supporting UDP tunnel offload:

struct virtio_net_hdr_v1_tnl {
   struct virtio_net_hdr_v1 hdr;
   struct virtio_net_hdr_tunnel tnl;
};

and

struct virtio_net_hdr_v1_hash_tnl {
   struct virtio_net_hdr_v1_hash hdr;
   struct virtio_net_hdr_tunnel tnl;
};

depending on the negotiated features. Using directly a struct to
fill/fetch the tunnel fields is problematic.

With the current approach the binary layout differences are abstracted
by the tun_vnet_parse_size()/tun_vnet_tnl_offset() helpers. The
expectation is that enabling hash report will set a bit in `flags`, too,
 so that helpers could compute the correct offset accordingly.

No other change should be required.

>>>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>>>> index 58b9ac7a5fc40..ab2d4396941ca 100644
>>>> --- a/drivers/net/tun_vnet.h
>>>> +++ b/drivers/net/tun_vnet.h
>>>> @@ -5,6 +5,12 @@
>>>>  /* High bits in flags field are unused. */
>>>>  #define TUN_VNET_LE     0x80000000
>>>>  #define TUN_VNET_BE     0x40000000
>>>> +#define TUN_VNET_TNL           0x20000000
>>>> +#define TUN_VNET_TNL_CSUM      0x10000000
>>>> +#define TUN_VNET_TNL_MASK      (TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
>>>> +
>>>> +#define TUN_VNET_TNL_SIZE (sizeof(struct virtio_net_hdr_v1) + \
>>>
>>> Should this be virtio_net_hdr_v1_hash?
>>
>> If tun does not support HASH_REPORT, no: the GSO over UDP tunnels header
>> could be present regardless of the hash-related field presence. This has
>> been discussed extensively while crafting the specification.
> 
> Ok, so it excludes the hash report fields, more below.
> 
>>
>> Note that tun_vnet_parse_size() and  tun_vnet_tnl_offset() should be
>> adjusted accordingly after that HASH_REPORT support is introduced.
> 
> This is suboptimal as we know a hash report will be added so we can
> treat the field as anonymous one. See
> 
> https://patchwork.kernel.org/project/linux-kselftest/patch/20250307-rss-v9-3-df76624025eb@daynix.com/

I know hash support is in the work. The current design is intended to
minimize the conflicts with such feature. But I can't follow the
statement above. Could you please re-phrase it?

>>>> +                          sizeof(struct virtio_net_hdr_tunnel))
>>>>
>>>>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>>>  {
>>>> @@ -45,6 +51,13 @@ static inline long tun_set_vnet_be(unsigned int *flags, int __user *argp)
>>>>         return 0;
>>>>  }
>>>>
>>>> +static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, bool tnl_csum)
>>>> +{
>>>> +       *flags = (*flags & ~TUN_VNET_TNL_MASK) |
>>>> +                tnl * TUN_VNET_TNL |
>>>> +                tnl_csum * TUN_VNET_TNL_CSUM;
>>>
>>> We could refer to netdev via tun_struct, so I don't understand why we
>>> need to duplicate the features in tun->flags (we don't do that for
>>> other GSO/CSUM stuffs).
>>
>> Just to be consistent with commit 60df67b94804b1adca74854db502a72f7aeaa125
> 
> I don't see a connection here, the above commit just moves decouple
> vnet to make it reusable, it doesn't change the semantic of
> tun->flags.

You are right, I used a bad commit reference.

The goal here is to keep all the virtio-layout-related information in a
single place. tun->flags is already used for that (for little endian
flag), so I piggybacked there.

Ideally another bit there will be allocated used to mark the hash report
presence, too. That will allow the tun_vnet helpers to determine the
virtio net hdr layout using a single argument.

Note that we can't relay on the netdev->features to determine the virtio
net hdr binary layout because user-space could enable/disable GSO over
UDP tunnel support after ioctl(TUNSETOFFLOAD).

/P




