Return-Path: <netdev+bounces-193421-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EA8BAC3E80
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 13:20:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2E7116C79A
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 11:20:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1A611EB5C2;
	Mon, 26 May 2025 11:20:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bp6dKkrk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D4D210FD
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 11:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748258428; cv=none; b=tRE9UdDlTBbhQG10Ers57J6HnFnbMK7G/rhAP0QhC2lbX29jGGg64XBagB7fG7gQVnHrMpUhN2Q3YLKCbjV6/taTpXLTRZENhfn6Y5hESHxsJci+/727omrwMufcbg10xfr91oI8m8p/NEfC7w8xENVtag2vt0q8EmyCy1ICvok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748258428; c=relaxed/simple;
	bh=rpxSdpFxcoJLJRBV8OTl+NT0zOPPnH2F2gahAtX+le4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ZEEUNgfJvHgDTuwUAXrjIH3UIKVywydT4oM6cBtJA99B29ONxHDqLlyiGEK/+EZE6pz1rDXL27uFufHIRu7XuyuWsGjZxzKRtMquRJlV6134RF1PvcTC4H8rzCZG7IUnJnVFZ8h7Esw3r33Eywy2tm83tWD2XPLo3KRqn41h/Qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bp6dKkrk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748258426;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+rbtnQ8tK66wxJ5+UxQWgjYxAQ3PgeJVPEY2gCgNQ5M=;
	b=bp6dKkrkqhDV95CC04CYylM8J4LMxGnfRCalx46ES0xjtQ1MJqU/kXH85/4FzpsERkFCgq
	TGKke1OltdNb52jZ7r89x/qV3Av0TBCmNOEdvwZOFkWyKEt+QQRZ0G6S5C7z+f4GkLjYmW
	UVseH31ytnzc3yr42FhUed8cNXzlus4=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-470-PC6_h4c_PrSQr4ws92SR_A-1; Mon, 26 May 2025 07:20:24 -0400
X-MC-Unique: PC6_h4c_PrSQr4ws92SR_A-1
X-Mimecast-MFC-AGG-ID: PC6_h4c_PrSQr4ws92SR_A_1748258423
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-3a376da334dso1325338f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 04:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748258423; x=1748863223;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+rbtnQ8tK66wxJ5+UxQWgjYxAQ3PgeJVPEY2gCgNQ5M=;
        b=Ths+j45GUwh7TmnDTDiGQnhiKTeTDsTNzK5NZrE25YQJQIJTJkPrxq6Z30vqxcUIEC
         mdEhmiTwu1me3YSOqP5Nh8RZ0f6opWrZyk7NeBd9dgE7TOij3hHaS+CFiguj7cm8RbmJ
         c8AXrumL68ep58zhW5QOSzXoMFmsxZqzD3y9Z8l8AnfRZLP9DSDH80tAujjwqOwQTESY
         rR8E5R2GAuNmNjQmLnF9ON+TursRy6BiOfrmAEY9PPcN27mlTJu4lEB5gaDAoC23ul+c
         KgpAE32PS7VO/5CdTo0zHLgKLmck14XlVYG1kuquYdmhlEUUILAUcdTnJLX4DdfBirCe
         re+A==
X-Gm-Message-State: AOJu0YwZdlbalcarwysWHZBWDdJYVXIs8t3wOHDhaB3JmKrjs5YhAGcF
	6eXeg2VU8bo5Cqe55YO5+xu0heh5F7+UNa6R0Ny8PaWM9CH/jxriXDJhu1lrRLY9NSgb6fW7ByZ
	kHW7zueMXzfirIqigzHxWG09gCxVwktLijx//bm/YbLAuRabhqjX/Ii5UPA==
X-Gm-Gg: ASbGnctHIFSvi/y5CMY472Zt/73eG1T7bQ/D2/Llq7P1+tVYVzCDeIflxD2Hq/4c8Jw
	y8TgzG40FZg7SFUo0UT8rXKfd93V/HjrDmrcGB6fBqVSaZPgOQLB2NCnKWJq/wKCH7FppAnanTO
	JzEfWBxTtF7TsmU63qJL73+Tx59fBb5meh4rrVQcsRFBWZsLPm68J0/5TwKIZ/NLkzgsTqRoCr5
	6Aak8aC947Y254OH2lSmgZw9MEjYEPgT2gqVhmUr/GhqRMEywEnCGVaAusW+OsE50cAdGQcuVt9
	yYuJj0W0ogX27ab3ytc=
X-Received: by 2002:a05:6000:4e9:b0:3a4:cbc6:9dc4 with SMTP id ffacd0b85a97d-3a4cbc69ecemr4592582f8f.53.1748258423136;
        Mon, 26 May 2025 04:20:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGAltQINZek0o1cdEemWmpyVJE4Njr32JVaDeJsBR8pnkiPiaJj1ecWYRxpOJHu+XwG+nha6w==
X-Received: by 2002:a05:6000:4e9:b0:3a4:cbc6:9dc4 with SMTP id ffacd0b85a97d-3a4cbc69ecemr4592555f8f.53.1748258422686;
        Mon, 26 May 2025 04:20:22 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4db7e2e87sm1847089f8f.22.2025.05.26.04.20.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 04:20:22 -0700 (PDT)
Message-ID: <68620cd9-923e-49df-ad39-482c3fa22be4@redhat.com>
Date: Mon, 26 May 2025 13:20:21 +0200
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
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEv5cXoA7aPOUmE63fRg21Kefx3MNE4VenGciL92WbvS_g@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 6:40 AM, Jason Wang wrote:
> On Wed, May 21, 2025 at 6:34 PM Paolo Abeni <pabeni@redhat.com> wrote:
>>
>> Add new tun features to represent the newly introduced virtio
>> GSO over UDP tunnel offload. Allows detection and selection of
>> such features via the existing TUNSETOFFLOAD ioctl, store the
>> tunnel offload configuration in the highest bit of the tun flags
>> and compute the expected virtio header size and tunnel header
>> offset using such bits, so that we can plug almost seamless the
>> the newly introduced virtio helpers to serialize the extended
>> virtio header.
>>
>> As the tun features and the virtio hdr size are configured
>> separately, the data path need to cope with (hopefully transient)
>> inconsistent values.
> 
> I'm not sure it's a good idea to deal with this inconsistency in this
> series as it is not specific to tunnel offloading. It could be a
> dependency for this patch or we can leave it for the future and just
> to make sure mis-configuration won't cause any kernel issues.

The possible inconsistency is not due to a misconfiguration, but to the
facts that:
- configuring the virtio hdr len and the offload is not atomic
- successful GSO over udp tunnel parsing requires the relevant offloads
to be enabled and a suitable hdr len.

Plain GSO don't have a similar problem because all the relevant fields
are always available for any sane virtio hdr length, but we need to deal
with them here.

>> @@ -1698,7 +1700,8 @@ static ssize_t tun_get_user(struct tun_struct *tun, struct tun_file *tfile,
>>         struct sk_buff *skb;
>>         size_t total_len = iov_iter_count(from);
>>         size_t len = total_len, align = tun->align, linear;
>> -       struct virtio_net_hdr gso = { 0 };
>> +       char buf[TUN_VNET_TNL_SIZE];
> 
> I wonder why not simply
> 
> 1) define the structure virtio_net_hdr_tnl_gso and use that
> 
> or
> 
> 2) stick the gso here and use iter advance to get
> virtio_net_hdr_tunnel when necessary?

Code wise 2) looks more complex and 1) will require additional care when
adding hash report support.

>> diff --git a/drivers/net/tun_vnet.h b/drivers/net/tun_vnet.h
>> index 58b9ac7a5fc40..ab2d4396941ca 100644
>> --- a/drivers/net/tun_vnet.h
>> +++ b/drivers/net/tun_vnet.h
>> @@ -5,6 +5,12 @@
>>  /* High bits in flags field are unused. */
>>  #define TUN_VNET_LE     0x80000000
>>  #define TUN_VNET_BE     0x40000000
>> +#define TUN_VNET_TNL           0x20000000
>> +#define TUN_VNET_TNL_CSUM      0x10000000
>> +#define TUN_VNET_TNL_MASK      (TUN_VNET_TNL | TUN_VNET_TNL_CSUM)
>> +
>> +#define TUN_VNET_TNL_SIZE (sizeof(struct virtio_net_hdr_v1) + \
> 
> Should this be virtio_net_hdr_v1_hash?

If tun does not support HASH_REPORT, no: the GSO over UDP tunnels header
could be present regardless of the hash-related field presence. This has
been discussed extensively while crafting the specification.

Note that tun_vnet_parse_size() and  tun_vnet_tnl_offset() should be
adjusted accordingly after that HASH_REPORT support is introduced.

>> +                          sizeof(struct virtio_net_hdr_tunnel))
>>
>>  static inline bool tun_vnet_legacy_is_little_endian(unsigned int flags)
>>  {
>> @@ -45,6 +51,13 @@ static inline long tun_set_vnet_be(unsigned int *flags, int __user *argp)
>>         return 0;
>>  }
>>
>> +static inline void tun_set_vnet_tnl(unsigned int *flags, bool tnl, bool tnl_csum)
>> +{
>> +       *flags = (*flags & ~TUN_VNET_TNL_MASK) |
>> +                tnl * TUN_VNET_TNL |
>> +                tnl_csum * TUN_VNET_TNL_CSUM;
> 
> We could refer to netdev via tun_struct, so I don't understand why we
> need to duplicate the features in tun->flags (we don't do that for
> other GSO/CSUM stuffs).

Just to be consistent with commit 60df67b94804b1adca74854db502a72f7aeaa125

/P


