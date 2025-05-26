Return-Path: <netdev+bounces-193373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 24A67AC3A89
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 09:21:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A6C81894B00
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 07:21:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B09D1DED5D;
	Mon, 26 May 2025 07:20:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FmrncuCN"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39F75F9D9
	for <netdev@vger.kernel.org>; Mon, 26 May 2025 07:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748244059; cv=none; b=GZFR/7Kk84UFLZld3o3ZSEkGUYSz3V0I5ZoFPPCa6rFAiI0l9KgMDcWRNAHWjnLoeJhAtcc0ezzTxkruZSfpR0Z4BUlWg9rwW35JL8q2QXVCyFmLU6U6N3aioxMCWm6jiAluwXDE/ru5tXaolxzixrLqy1Uzc4Ygw957sfwqLo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748244059; c=relaxed/simple;
	bh=EETjJrackThg8DMHzmIgQpEyG3h/Ft/zMIn4vpUlzqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Zv2+67K04Yj2DCimCzL8jMeTEUXyKdEd1EwVq0pCakZyaLZxEnWqVwchybcHadh1Leg9yK2ilMEsLEhhuPrxHXBm44uT42ZziPQy63ltHBbTSbWHCAZ1R+fCwhjq68l79etZD25Cup8zkykxG+ek8YQqTmYqvtTv+sYtAo1DbI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FmrncuCN; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1748244056;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cWzxzwSmXRwedV1fejsDubHS7cAYbZVteuEpksvDhWY=;
	b=FmrncuCNHcwJdBnh9frAIjq3ineFLAYr/4juv3Tg7Rynp909upNBPVEKvuMplB782Wf8Rm
	TV5esH654pEHPhbOtNnqXgrnkJJDwkEsbURJDmFl5PL++yqhhI4Orqw9so8JFNHCU5hU0h
	3LcyowaeSyC+e5X/rUVUINro6KGD/ns=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-660-rZq3qCkbPeyJDAe4nWf5bA-1; Mon, 26 May 2025 03:20:54 -0400
X-MC-Unique: rZq3qCkbPeyJDAe4nWf5bA-1
X-Mimecast-MFC-AGG-ID: rZq3qCkbPeyJDAe4nWf5bA_1748244053
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3a375938404so1248176f8f.0
        for <netdev@vger.kernel.org>; Mon, 26 May 2025 00:20:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748244053; x=1748848853;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cWzxzwSmXRwedV1fejsDubHS7cAYbZVteuEpksvDhWY=;
        b=mE9LuKct9OKtwnYoetnL0TOBUwBOQqeC8n1uZ75Gp5k/ubOz1nR0BmXVaqfjliSQa2
         ldXcPSNJT7nm1S0R2LzFcK35vkar3A5HbblYBLhLkkgWSiZ4WyRmxUyTRiHpxAxHSk1H
         qNATFaKMPWYU1bxtl3+SP0qctA/kbu7jmgJQKGtZnHPnBxzexi+gDteeZcSrWu7U7LyS
         LNJzLs3cQFhKTTb3MMs3iUtVmYEUjJ+Dt8M5DALSk8YcSui9m6RQ4rn8aUqouS0AYdGC
         vvRRb4q6BmMvgoKgqpGYBpsg7TfIe/sQlqODHb2kpCNeOiOXPOyrDmyY/shw0AZBf2w9
         0X0A==
X-Gm-Message-State: AOJu0YyELBLlXvnlP7AHR+8owc5E5vcCV++ZMKBsRYaXAaTe0RoOQSmd
	F5doJN/bw3SYU+WJSIC5n4zR84zvS98vw3hiw2i+LB+Ro+USKF8OdUMO8M5uuykIlpmpQDRo3k/
	7cqJu8p37+O8ZcLXyXuDZCyYVen1WtWThcME9Kp+8U5GuvIpzKf5nTwzL9Q==
X-Gm-Gg: ASbGncv94cQL6ABzKdzXgHEDZrUC1DA/G7g3wQhwv1ddj8eAlb/s7eZdIfwFYYJx6gb
	+ug7OUsSoGkQJXxqIMXsVcT+PXLrbO87uyZkqdukD/CznS6vWB7bw8HQ1G2KI3fZUWqzSoOf0Qp
	HctjYLUP1gaZUKFDHXLvu8hUqm2F81Z5K+2eUAcMiy+g4theL5ZoA3fLdSCDclyAsnssO4LRSZO
	nkJBqVyhm730HA9czLC4cur0p9Zun+Fjnj3r2eJ8ikSMsdVWHzn6ldSQQeDUc497Ex5D6xJOJFU
	0FuHOPtYMalWAyjFunw=
X-Received: by 2002:adf:f34f:0:b0:3a4:ce5c:5e90 with SMTP id ffacd0b85a97d-3a4ce5c6369mr4897583f8f.10.1748244052806;
        Mon, 26 May 2025 00:20:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFIxDxxne/nsqx1uAR9vLNXLVfWG++EoFbH5+xMHv7BvU9zPTDuiPchB0iODRKaUgUDNtcLKw==
X-Received: by 2002:adf:f34f:0:b0:3a4:ce5c:5e90 with SMTP id ffacd0b85a97d-3a4ce5c6369mr4897556f8f.10.1748244052403;
        Mon, 26 May 2025 00:20:52 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2728:e810::f39? ([2a0d:3344:2728:e810::f39])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a4d67795eesm3140789f8f.86.2025.05.26.00.20.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 May 2025 00:20:51 -0700 (PDT)
Message-ID: <2119d432-5547-4e0b-b7fc-42af90ec6b7a@redhat.com>
Date: Mon, 26 May 2025 09:20:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 1/8] virtio: introduce virtio_features_t
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>
References: <cover.1747822866.git.pabeni@redhat.com>
 <9a1c198245370c3ec403f14d118cd841df0fcfee.1747822866.git.pabeni@redhat.com>
 <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEtGRK-DmonOfqLodYVqYhUHyEZfrpsZcp=qH7GMCTDuQg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 5/26/25 2:43 AM, Jason Wang wrote:
> On Wed, May 21, 2025 at 6:33 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> diff --git a/include/linux/virtio_features.h b/include/linux/virtio_features.h
>> new file mode 100644
>> index 0000000000000..2f742eeb45a29
>> --- /dev/null
>> +++ b/include/linux/virtio_features.h
>> @@ -0,0 +1,23 @@
>> +/* SPDX-License-Identifier: GPL-2.0 */
>> +#ifndef _LINUX_VIRTIO_FEATURES_H
>> +#define _LINUX_VIRTIO_FEATURES_H
>> +
>> +#include <linux/bits.h>
>> +
>> +#if IS_ENABLED(CONFIG_ARCH_SUPPORTS_INT128)
>> +#define VIRTIO_HAS_EXTENDED_FEATURES
>> +#define VIRTIO_FEATURES_MAX    128
>> +#define VIRTIO_FEATURES_WORDS  4
>> +#define VIRTIO_BIT(b)          _BIT128(b)
>> +
>> +typedef __uint128_t            virtio_features_t;
> 
> Consider:
> 
> 1) need the trick for arch that doesn't support 128bit
> 2) some transport (e.g PCI) allows much more than just 128 bit features
> 
>  I wonder if it's better to just use arrays here.

I considered that, it has been discussed both on the virtio ML and
privatelly, and I tried a resonable attempt with such implementation.

The diffstat would be horrible, touching a lot of the virtio/vhost code.
Such approach will block any progress for a long time (more likely
forever, since I will not have the capacity to complete it).

Also the benefit are AFAICS marginal, as 32 bits platform with huge
virtualization deployments on top of it (that could benefit from GSO
over UDP tunnel) are IMHO unlikely, and transport features space
exhaustion is AFAIK far from being reached (also thanks to reserved
features availables).

TL;DR: if you consider a generic implementation for an arbitrary wide
features space blocking, please LMK, because any other consideration
would be likely irrelevant otherwise.

/P


