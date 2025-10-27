Return-Path: <netdev+bounces-233221-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 20952C0EDD2
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 16:15:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 393A43BE982
	for <lists+netdev@lfdr.de>; Mon, 27 Oct 2025 15:07:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB6C62FF679;
	Mon, 27 Oct 2025 15:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cga75pyY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FABE2E7645
	for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 15:06:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577566; cv=none; b=L3/56MAv+EhoRovHRS+Mkjq2MuY9rzlE0ZnF/sfsrQjTK9EpaESSmS/f+HOAOc2qJKbQEjvZIWkTOspSqOthToVgiN7nQpeLoW31BvQ0/bXJPPpZojgo84cPEwJdJv/RzjkVEov5JMMBFG3MMyRP5mPQWB3HfjQe67CnH/J7rpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577566; c=relaxed/simple;
	bh=juEvfZ6xSAmrjLQLGlrgYpDF4UPOG2/XdIWNOau1zWU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JIohR6OybRp0me/O1ro5ka8lHtrJMe1XPT8MwRn0nh6RgEAU07G4/jeii0f9q3zP9FFSPRD1Yen5dH7u3Zi2LKUKUAT4BhjAaaZRSNgxVihP1Y1Xz2XMkNLnzLfQjurNODEsvyex83mMC8n/XE/aVE9cyJSiXuTytZzWg/25A+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cga75pyY; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-7930132f59aso6259498b3a.0
        for <netdev@vger.kernel.org>; Mon, 27 Oct 2025 08:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577564; x=1762182364; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AuqEiBypQSyV+NhjApDxiloo6xn14f1pCOFw2OHgWCg=;
        b=cga75pyYWkfWyAmGprUyG2WKLOg1VmODLKx0KcZ7GkpyHFm5MGLnx8K9CmYb/uMlx6
         ASJhnkue4K9dkKJS8sMNlzGbCfFfkhx9Mk5n53cqWg7lVWS+hlXlBjycCxZuisn8wzeV
         QZ3FHSVBEaC59/EJYzetfJ+xbLs7icHDY1M2Gne8mELptFcfAbRtemdU27iXNNsl8Vkq
         IfcVWVolO2p16Eha0XVhS75zpZSvkOP6fr+rcB8a2ehhb56qRct8Nxx9OhT+35OMYA3c
         3KE3GZ8kwcjHE2JTHpdD994T9cSjK6Hzdt97YUdzGAVh4xyi4Ku0AcK6hSMNCZij2WqJ
         cx3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577564; x=1762182364;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AuqEiBypQSyV+NhjApDxiloo6xn14f1pCOFw2OHgWCg=;
        b=AwUyr6znRu/2C6bCTCdIn89Hb+3ObBpdf9sCeCtH2XvHexu70/pRWwz0jIPcqgtOn9
         UO1Mr/7GKGUE7XZp9h5w1xrlVZQ2saouEhPCZFOIQOxR8Uhyi6DmL+zRrlnYLxmM5I+T
         gMWtPCwqkvPNYMP+bZOl2HOD6TQKqkvMbDj/3l2CeSVmZdU8tnBXBhHvZpG14AvIkZ1D
         xpTYBRFUJXVQQZhgcA/qQdzGqtEhxLshSLcruVfD7FkiQUwwUJ616Jw6fAEj6YxTtNGD
         BTzjMbso+6EyZMh94juoBjiP2GonaLE4C1OGIOFYInH3O1KBGfKx1oqjZovdXvVdUe8X
         tEOg==
X-Forwarded-Encrypted: i=1; AJvYcCVIzYJtheRTjaCXex3lpFa93l96WbScWlf90xVI+j0ElG9WX3agR9w0jw+0K9tbuiO4U9DB1WM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkLHc5NcBEhiCttDsj/7le8VW+XEj1zs5daMc8Hvb4MyGkOCj3
	+GIP0ghjNe5TKlUnfSYckLsa6e7JrU2l8LrU+LnpOm6PFI0bAhapymuc
X-Gm-Gg: ASbGncuhYeQEmirFm6K6ffXgogpWEacsaLyPDgN17JqlN4gHPIQbiYL9SbKLKKBwiLd
	kwD/W3WwMFFs1wvlqJeJjXcajQFW4MxbELbf5faQ7SK9hHCHIC0YmSLolzDQGO19Hj2DT1LSuEi
	hqpblpfy+Gn7KWbvg8SeN1E7tiVBUSl1FVSbdeFUfHeuxWGX+emYVIubvptZEQM730HS7V3zc/Q
	RrIERLX4ETCGIkYq0ydDxHyMRBt87OljivJ5ByyvA1k24QRIRVoVa7gfGGVQsS4Xeh32RWdf/dP
	mdCqjH8ZTXU79wtRbNosS2PvEzj4vWcNuNS/7AFgDctKepGXB1+eeX+PfZq8KeJ6h9XIxTp9ZR3
	4S++suUcTY26mesxGd3nXRnc+ztjajBpOS811IEuFDgU6jJBj/SG3jiO7Vm9MQl9umCfXTiOF6+
	pZaLPHsPWXK9FssmUki5K3NzyJfSz9EavuTAMgbOYn2IeMGaE5Q70=
X-Google-Smtp-Source: AGHT+IE//ftoG7hudWyqwVqH7rp/r57M0IzNCI5Ivf6IYwy5vXRcB+e2jlZU94XIYDL362p6j8hxMg==
X-Received: by 2002:a05:6a20:3c90:b0:341:5d9f:8007 with SMTP id adf61e73a8af0-3415d9f87a5mr9096245637.57.1761577564184;
        Mon, 27 Oct 2025 08:06:04 -0700 (PDT)
Received: from ?IPV6:2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318? ([2001:ee0:4f4c:210:d7dc:fc1f:94d0:3318])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414087005sm8526808b3a.60.2025.10.27.08.05.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Oct 2025 08:06:03 -0700 (PDT)
Message-ID: <e7e05a6f-1995-4c49-929d-3d8ee7b0ac5c@gmail.com>
Date: Mon, 27 Oct 2025 22:05:55 +0700
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net v5] virtio-net: fix received length check in big
 packets
To: Parav Pandit <parav@nvidia.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "Minggang(Gavin) Li" <gavinl@nvidia.com>, Gavi Teitz <gavi@nvidia.com>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <20251024150649.22906-1-minhquangbui99@gmail.com>
 <CY8PR12MB71951A2ADD74508A9FC60956DCFEA@CY8PR12MB7195.namprd12.prod.outlook.com>
 <8e2b6a66-787b-4a03-aa74-a00430b85236@gmail.com>
 <CY8PR12MB7195F589628BD6617A77F81CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Language: en-US
From: Bui Quang Minh <minhquangbui99@gmail.com>
In-Reply-To: <CY8PR12MB7195F589628BD6617A77F81CDCFCA@CY8PR12MB7195.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10/27/25 21:55, Parav Pandit wrote:
>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>> Sent: 27 October 2025 08:19 PM
>>
>> On 10/25/25 14:11, Parav Pandit wrote:
>>>> From: Bui Quang Minh <minhquangbui99@gmail.com>
>>>> Sent: 24 October 2025 08:37 PM
>>>>
>>>> Since commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>>>> for big packets"), when guest gso is off, the allocated size for big
>>>> packets is not MAX_SKB_FRAGS * PAGE_SIZE anymore but depends on
>>>> negotiated MTU. The number of allocated frags for big packets is
>>>> stored in vi-
>>>>> big_packets_num_skbfrags.
>>>> Because the host announced buffer length can be malicious (e.g. the
>>>> host vhost_net driver's get_rx_bufs is modified to announce incorrect
>>>> length), we need a check in virtio_net receive path. Currently, the
>>>> check is not adapted to the new change which can lead to NULL page
>>>> pointer dereference in the below while loop when receiving length that is
>> larger than the allocated one.
>>> This looks wrong.
>>> A device DMAed N bytes, and it reports N + M bytes in the completion?
>>> Such devices should be fixed.
>>>
>>> If driver allocated X bytes, and device copied X + Y bytes on receive packet, it
>> will crash the driver host anyway.
>>> The fixes tag in this patch is incorrect because this is not a driver bug.
>>> It is just adding resiliency in driver for broken device. So driver cannot have
>> fixes tag here.
>>
>> Yes, I agree that the check is a protection against broken device.
>>
>> The check is already there before this commit, but it is not correct since the
>> changes in commit 4959aebba8c0 ("virtio-net: use mtu size as buffer length
>> for big packets"). So this patch fixes the check corresponding to the new
>> change. I think this is a valid use of Fixes tag.
> I am missing something.
> If you don’t have the broken device, what part if wrong in the patch which needs fixes tag?

The host can load the own vhost_net driver and sends the incorrect 
length. IMHO, it's good to sanity check the received input.

The check

     if (unlikely(len > MAX_SKB_FRAGS * PAGE_SIZE))
         goto err;

is wrong because the allocated buffer is (vi->big_packets_num_skbfrags + 
1) * PAGE_SIZE not MAX_SKB_FRAGS * PAGE_SIZE anymore. 
vi->big_packets_num_skbfrags depends on the negotiated mtu between host 
and guest when guest_gso is off as in function virtnet_set_big_packets.

Thanks,
Quang Minh.


