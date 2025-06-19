Return-Path: <netdev+bounces-199524-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F38AE09BF
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 17:08:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E79141C20804
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 15:04:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 558E023E325;
	Thu, 19 Jun 2025 14:59:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GGB+2G1c"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81F2222D4E2
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 14:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750345186; cv=none; b=i+NY/7QlMvm1m207kpl7VwT1C+qxU5zWJcIIxCGVi6msMRHZ5WFJU7brDqV8yqLE6Wg7HkM0nmGGx45YHTTFRXICYV6bpYgcaNwSKY3Xb7Gtz0Lo2lh1PKNo7dOTFrZlqndPSiCX8nLL1WPCGSQx3a+bvT7Qq+lLu4FuUU+A6VY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750345186; c=relaxed/simple;
	bh=jdt5vyk2rGT/UFrxnWkDYF/G4T5l3x23XuhutV8VxAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eUwEQEVSycevJ40uxX0H+7AlZ7Fsx5O0zuRXOGQofHrjWNCUIZwgBGM7ER7ORbpSEL6V5AE0sJBU7WLHnmpVgmoAdT8J//UJj6cy+n0mpVJq24QlfYM2AwTQxySj8ominsLNUza63FNjBFKDinI4UtMsDnLxMcLUVQ7TuW6LHxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GGB+2G1c; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750345183;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hoOpWKQ80BmgPQH2gFwc671ctHYuJlZgk3ms5f0BgKk=;
	b=GGB+2G1cqTzW8SPEBL6e7pS8Adi+H9WdlJ0irec7Ql159YESAeWx86goAJ6RU3rvHotnIp
	TP34NvD/H8P74eeCYiWvDbrD/Nwonx+e91Uvtwf1RVMdXs0T/E1K1TzTt/HrIVJlJbdDoP
	dZq7BSro/WrGevzB8Dry9nsNWQtzZPA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-483-HaW1h-YLOOGWQza9nQSxbw-1; Thu, 19 Jun 2025 10:59:42 -0400
X-MC-Unique: HaW1h-YLOOGWQza9nQSxbw-1
X-Mimecast-MFC-AGG-ID: HaW1h-YLOOGWQza9nQSxbw_1750345181
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a4edf5bb4dso687611f8f.0
        for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 07:59:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750345181; x=1750949981;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hoOpWKQ80BmgPQH2gFwc671ctHYuJlZgk3ms5f0BgKk=;
        b=EZf72G3JVTU/gSsd5/u6Yi8UwKGBNK1mdm4aUuQbS242NYwOXZfpJ50cen2QDSidbG
         +R2wSF4DgLASJWw0d8ZImX1xHqOMCPFn+rJXR2cepQBIX45VIcSp61x7nHJEmXGpuJ10
         bHfnNWjlyw1cL75wVHcDFxZgpTE+MAwLtAZIxOgVvxulOAkjOCImZZdd+lqqlbLByqEH
         kY7txf6Vw8WrVKns4usnFP7qZ0XDob1JLQgGuZOWaLwKjAsNhr9I/Q8pEPw2DDZzTnv9
         9FwHNv2bUQoUu/SHYxdofgTnuieZK4nxsBEXU3nQ4g4XIsnUaNHvL6rkszlaBUVcdru4
         LWjg==
X-Gm-Message-State: AOJu0YwUjU4PghiFkT79CADXsQMQQwZ5rwOw1t5wUdmYk/tetyuDFWX2
	nNtV5tw3o1pc/D4Ka9VibYNoj0aPYM/PmJcVRwCg2lsJxiCVlzO0211yYq7kPJiTs+6HsjwwoYD
	AkXoJK0Qy3f2uIGrf335y1LAwQXIPRjQl4V8uawjXHX2Crn25KBgou295Sw==
X-Gm-Gg: ASbGncv/gv0NOG4bAHIn3kxwlz5ZkOWkYhQIlNDYIWKZR0faain3v0ehMg6kUkPq+hN
	HMldLpZT8GCoHaNhCXfjROWqGOgVQx1QmY8pYAFaJNc0etxTBx6cKkvwR/Bg0V7JYUUEsSv8qof
	Rckte25QH9AHtdO+i+9EoM3xE3qAgkTGF5QKJFDmUzFc1CckIN5A3oiu7B+J+NGlPqBEhVnQgMY
	XDieudKvF3v0eQPcPnigOMZ9E5RimLvB1EdcS46Dk8PEHUhMohy/wQezNE9g5zkcizAnRzaBqH8
	rEL7oTi9Ppxqun4qzqZGyZnV31jHRA==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3a572e7971cmr18812000f8f.27.1750345180815;
        Thu, 19 Jun 2025 07:59:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE50SSWyBU/AplPHkcaIPkeDDARb5kbF3shaTcKoegACqaTfnSVFR6JVbSgCJbUXeG+s6z26Q==
X-Received: by 2002:a05:6000:1ac8:b0:3a5:2ef8:34f9 with SMTP id ffacd0b85a97d-3a572e7971cmr18811979f8f.27.1750345180402;
        Thu, 19 Jun 2025 07:59:40 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:271a:7310::f39? ([2a0d:3344:271a:7310::f39])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4535e97ac4asm30996745e9.3.2025.06.19.07.59.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jun 2025 07:59:39 -0700 (PDT)
Message-ID: <c527a435-dbe4-439c-b55b-7210df3b8dc9@redhat.com>
Date: Thu, 19 Jun 2025 16:59:38 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 net-next 5/8] net: implement virtio helpers to handle
 UDP GSO tunneling.
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1750176076.git.pabeni@redhat.com>
 <5385db79f3fdb59c8cbf235ef4453122ef19ae7e.1750176076.git.pabeni@redhat.com>
 <CACGkMEsx-pcwC=_-cMMMdGZ=E5P-5W=4YoivMQiy=FB1W7GKog@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEsx-pcwC=_-cMMMdGZ=E5P-5W=4YoivMQiy=FB1W7GKog@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/18/25 6:08 AM, Jason Wang wrote:
> On Wed, Jun 18, 2025 at 12:13 AM Paolo Abeni <pabeni@redhat.com> wrote:
>> +/*
>> + * vlan_hlen always refers to the outermost MAC header. That also
>> + * means it refers to the only MAC header, if the packet does not carry
>> + * any encapsulation.
>> + */
>> +static inline int
>> +virtio_net_hdr_tnl_from_skb(const struct sk_buff *skb,
>> +                           struct virtio_net_hdr_v1_hash_tunnel *vhdr,
>> +                           bool tnl_hdr_negotiated,
>> +                           bool little_endian,
> 
> Nit: it looks to me we can just accept netdev_features_t here.

That will replace a single bool argument with a netdev_features_t, right?

I guess we can do that when it will allow reducing the arguments number.

Thanks,

Paolo


