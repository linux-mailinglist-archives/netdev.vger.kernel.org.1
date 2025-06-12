Return-Path: <netdev+bounces-196882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 73F57AD6C56
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 11:35:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 95997189E46E
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 09:35:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D658F229B16;
	Thu, 12 Jun 2025 09:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aWCmocSx"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE284229B36
	for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 09:34:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749720896; cv=none; b=hmvViMZU3vctzYa4e7taO5ysBfEpZgsL7uiaK+qPmLWrSEU1BTkxnoaapPnylJa02lVYRCFYuMXfaV8mtkRhIS4XaR9PJe6axyUxsOnDTBD+12Kg/VOl8uY01PAKOp1YFvxNt+2eVOM/99H4JylFm10nHz0MqXI9y6w4n4y4wZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749720896; c=relaxed/simple;
	bh=DSyr8/6mo3/7JRB1XAiPDN2HSM+NqDTRh1iMBQd+3Bk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oeVweVVZwEf0L16mft+NVpo+HnFF8u6pIFSiVrd+JgGC5IlAFVxArtD6F9hwgBox1ZcbIOR2fOc34WDHsSsPZ1cSEw3PELUI34wio+ZWpgR4Iy3f+VqUOmq9GBdHluRt2aOWNpx37E4kkcec06SEuSwQU1+xbtC86KP3iGlaNkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=aWCmocSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749720893;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=K5vTTBowN3xYnMLoi2pnSbr3ixJ6ZJA/32wV4sZG16M=;
	b=aWCmocSxqkvRJ4LQcQka/ZkDMTuQXoFC5P9/LEMxEyiBQ/NUi2QRUUamDGQulsF5xKF+/v
	uQqBceM040/haumA/ltq5W97fr/tHPOU5PZRpbB1V9DJtO0qNzy7S3/vCt/B1g49sdbxLq
	iY7+sgYDRCGoXRKQ/1QCgsgE4l5mnlw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-225-Hx5hpDDtOXeh1ydI_Jwn_A-1; Thu, 12 Jun 2025 05:34:52 -0400
X-MC-Unique: Hx5hpDDtOXeh1ydI_Jwn_A-1
X-Mimecast-MFC-AGG-ID: Hx5hpDDtOXeh1ydI_Jwn_A_1749720891
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-45311704d22so4213035e9.2
        for <netdev@vger.kernel.org>; Thu, 12 Jun 2025 02:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749720891; x=1750325691;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K5vTTBowN3xYnMLoi2pnSbr3ixJ6ZJA/32wV4sZG16M=;
        b=hDC9EN+BhnF2BjnAx68SmB42ElCHtQoTpyrCaDvt7XnPmgGVToL5GaFunM3aFyd5Vk
         5TSqo0C25n7zLBOJYiDeKPRZIgJp0Kj2kXY/EUC+LckJHh8QN3NytktC4Mn889Mm4TJ4
         0Dzpbya9P8dTDr6vJ5nKacN392D53lWogg7Q02kfgootvS7u+DSwQc824qz56PevP9Di
         ahsAVJQZwxS0NEFdWGL51vJStZ3lfxKcvzFS1MP15nri4ZoeVzUyJlmZpLbjbtDXKHkB
         HvnKSY1NvNmXOQDzML8ZF/s8fdfTBbJxgc+rrEzQZ/luarVx+AJCavH11N+n+rrODUDl
         Aeiw==
X-Gm-Message-State: AOJu0YzR7+DYa8xb5zR8KErPRcKJ9mMrKM6GAdUNEaGsfON9GtV00a0R
	VkVRz1WIu0J7z/3o89Q23tab1ZO9y8L+tp7/YHbBhBME7PBkd1arT2PdDq5UdzyjT7lgMrJH9P6
	oHnzpYOQ7n81MXjiHVQCmUzKxE9ceHO9rIB7G9/j8tuIavpzoz+V4YL4WLw==
X-Gm-Gg: ASbGncviRKgI4akFHQZNVAob9CCly2Z3bofWRn/rrOTfk7hK3kKbjM8GfIYi3mW7Pzi
	Hw48hAuLYFqNFGHjqxOiBF5LXQe++YJOz9YCxGxY2QAOPLOQ7h9QOI7IpOrJQR/MEsSi0Wg/H3l
	/M+z2SN9uNQmp3PacHf/63QVzNwJ2Cw9i2THBT2tGBz0V41L20g/9w53ELid3xBfefHrzjk0BUC
	AtTiB1xraVVzR1V4AhCjTkr70Jw5mbd49UlA8IB6D09zJnks3H8ZJ+ZrOLDiIWi9qUjvUMsE5R7
	ZD5GKKyiq48OphyRXDFJAerhbL2S/8sut8ykOoewB9IqBN37W6jZjcii
X-Received: by 2002:a05:600c:6092:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-4532d328cd4mr22989545e9.31.1749720891315;
        Thu, 12 Jun 2025 02:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFBBX41DDTE4Z+d/OBqPserycdkXjs1S1kS8LZ4oM3fygAIWKFhgLJdlTZmGZys8fhq6dcEEw==
X-Received: by 2002:a05:600c:6092:b0:43e:afca:808f with SMTP id 5b1f17b1804b1-4532d328cd4mr22989215e9.31.1749720890933;
        Thu, 12 Jun 2025 02:34:50 -0700 (PDT)
Received: from ?IPV6:2001:67c:1220:8b4:8b:591b:3de:f160? ([2001:67c:1220:8b4:8b:591b:3de:f160])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8f2e0sm15032745e9.8.2025.06.12.02.34.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 12 Jun 2025 02:34:50 -0700 (PDT)
Message-ID: <d6d049b1-ab7a-4f68-9956-55c24de8e737@redhat.com>
Date: Thu, 12 Jun 2025 11:34:39 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v3 2/8] virtio_pci_modern: allow configuring extended
 features
To: Jason Wang <jasowang@redhat.com>
Cc: netdev@vger.kernel.org, Willem de Bruijn
 <willemdebruijn.kernel@gmail.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Yuri Benditovich <yuri.benditovich@daynix.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>
References: <cover.1749210083.git.pabeni@redhat.com>
 <19ee74a1a46e9eb302fc742fb7c9913bcc6b7d86.1749210083.git.pabeni@redhat.com>
 <CACGkMEvH8cq+AdvJMO0eV0jps_-t1tUMc-cbdfReJdWFThOVuw@mail.gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <CACGkMEvH8cq+AdvJMO0eV0jps_-t1tUMc-cbdfReJdWFThOVuw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 6/12/25 2:57 AM, Jason Wang wrote:
> On Fri, Jun 6, 2025 at 7:46 PM Paolo Abeni <pabeni@redhat.com> wrote:
>> -u64 vp_modern_get_features(struct virtio_pci_modern_device *mdev);
>> -u64 vp_modern_get_driver_features(struct virtio_pci_modern_device *mdev);
>> -void vp_modern_set_features(struct virtio_pci_modern_device *mdev,
>> -                    u64 features);
>> +void
>> +vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
>> +                                      u64 *features);
>> +void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
>> +                                    u64 *features);
>> +void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
>> +                                    const u64 *features);
>> +
>> +static inline u64
>> +vp_modern_get_features(struct virtio_pci_modern_device *mdev)
>> +{
>> +       u64 features_array[VIRTIO_FEATURES_DWORDS];
>> +       int i;
>> +
>> +       vp_modern_get_extended_features(mdev, features_array);
>> +       for (i = 1; i < VIRTIO_FEATURES_DWORDS; ++i)
>> +               WARN_ON_ONCE(features_array[i]);
> 
> It looks to me it's sufficient and safe to just return
> featuers_array[0] here. Or maybe we need some comment to explain why
> we need WARN here.

vp_modern_get_extended_features() can return a 'features' array
including extended features. Callers of vp_modern_get_features() can
deal with/expect features to be present only in the lower 64 bit range.

This check is intended to catch early device bug/inconsistencies, but
I'm unsure if e.g. syzkaller could hit with some fancy setup.

I can drop the check in the next revision.

/P


