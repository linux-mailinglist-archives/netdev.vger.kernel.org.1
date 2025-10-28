Return-Path: <netdev+bounces-233472-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 30D81C13FB0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD36E3A8D95
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 09:57:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7C34302168;
	Tue, 28 Oct 2025 09:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RnpTpsnh"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01990301010
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 09:57:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761645467; cv=none; b=dI3eM7nKlaSMnR8SA2Evl0FQgBbi9ZyVcnE0onLYKhfxFvnTu/3WocDPgr5tAkE4J1h3+xlwe/PUfZGcijcN2+Y8gF5GptFPc3tE+5SapfKeZYEfkHw3qwVLtQyhHqvCJobG/wfeotiUQMGRugS7J8xrC705m0x4AqoRpFOkeno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761645467; c=relaxed/simple;
	bh=mfTHpsTxrS0GRVOGyogmOgzNBE++mmmkoqWmimNeCDA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gKpzzqBMazKTgr+IAwqh2WaBRSUYLSk8PB12p6THcFbrGImP/+4IfjRC2eLmFUeJG9KlwA/cWvR2+b3kF9yNMFqfo9i3Vi9PLhV42OlsBROMPZqoDxr7oiCVZuQt7A37k84Y7NPGMA0pJvnL5vN/C7qFqTdgIN7XoVUexN2kA5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RnpTpsnh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761645465;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=56vwggYHsixFZVV59LtI7c2gTMZmsoUndn9sUNVFrqA=;
	b=RnpTpsnhewm9Ll2lP8/0gxwDVCWJlTVj2PqHBu9JtTh+a1gyrpFwhvFVlPAFeFZfss6vmS
	F6pbcdC/SbI8hao+BebuOzug0dMSAIiTKB9l00+e1/0+pova+9UbpvCJRsfa0mGb3UIW03
	KeKexrYiNG0hyxeSmPzZvl8CPnG8+RI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-215-IQbOATiSNJuB3wyDQL-fdA-1; Tue, 28 Oct 2025 05:57:41 -0400
X-MC-Unique: IQbOATiSNJuB3wyDQL-fdA-1
X-Mimecast-MFC-AGG-ID: IQbOATiSNJuB3wyDQL-fdA_1761645460
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-47113538d8cso26246475e9.1
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 02:57:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761645460; x=1762250260;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=56vwggYHsixFZVV59LtI7c2gTMZmsoUndn9sUNVFrqA=;
        b=cSM7YX7M5OwT3DizkKmcOs7H9zsYLJUDabUyQt6N6+Qf4S10AUC7ItJ8ztsK8tpNSx
         QhLumdIVG8tQHDdWYaSTo/EN85+JRFgmrdNHlbxut7hYwTC58qSQZzad1160qPrJpci9
         yXtFfidCEf62SbqKfUq5gRkLrRRI2C0Rjv827Tsy1AUPCJwYhYclW92R062PoU9PZS7u
         hw9GcQ3JeuzjO9Hyxq7mCO3oWnQPVLWc3xoP8QGNgI3flaanMa3qoQFv4fygZUPqi0HD
         02lsudEoItiX9UICdRvofiJvsQzNM1Gdob7FXxrp1UohEM53So+gWRKbMHDw6Adn6sjk
         iVDg==
X-Forwarded-Encrypted: i=1; AJvYcCUgfZLgh4//ZEohwlwvwF7avlORiXE5akNbr6tJ1dRDl4d/gkxTGMfuDzkxG6Xf98fEDXGRxi0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxexFo5IGqvF6bDm63XvSuJQfljcimNspW4wMQutcMGnRD3cqfw
	8yTaByimw5nZm9o9XZua0crzsazAtGOW+QCrJfGUzFXzQ9XxCQ1g16nw8iJgdGmuV/FuGf6qy1p
	tdn3mOGzMJBAXJTBV/IBefwi8zBD7N2PJKnKdtj18TEgPDpbREM7emM+Iog==
X-Gm-Gg: ASbGnctrB+GYttK7+92bfzr84519pt9EXkHG5XrXgufB/PZGgCDdxZKw0SMmarQERPC
	9YnzG57D43yV/Gr3M1YXFXkoxl1CNQ6yaYoCUFvLhHXW+fpjaRUVscxejAY86UQO7nTVlAfllx3
	hgHLxK8mD91xVv62NtxIo1t0urm2100ShKq16lMpqCBjrqqEcNo4wykkLWBbgk7ctaApYBj9Xng
	z28H02rYHVLPmbvvLHDf2tFVhfJjvZY9arj3vyDjgESxBkbZsJ0jiSNq6yGE1IOEuPDJGrEPs+v
	GdxCOKAdtapaXf+b+3xSWyT+Mx7NwSLdJG9uFE5bF6Q3F3IfEUy//W/ym7tlO69esXbFCduuMHy
	cWScM6A7/1GRtOVKoz44YKcAfe0fdXZ5RFAq+OYUqZK9iwFE=
X-Received: by 2002:a05:600c:348c:b0:475:dd87:fa32 with SMTP id 5b1f17b1804b1-47717df6965mr24455695e9.1.1761645460301;
        Tue, 28 Oct 2025 02:57:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHfvGvAXIxMGxMt5qnRV9V4eVSHT+20qORZtOfo2sFh3kW29aY8yAm1WYmSttOd9/cvNwTc2Q==
X-Received: by 2002:a05:600c:348c:b0:475:dd87:fa32 with SMTP id 5b1f17b1804b1-47717df6965mr24455415e9.1.1761645459854;
        Tue, 28 Oct 2025 02:57:39 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7a94sm22527595f8f.5.2025.10.28.02.57.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 02:57:39 -0700 (PDT)
Message-ID: <76d6ba7e-f428-4a58-bde8-77cca1f5c3b6@redhat.com>
Date: Tue, 28 Oct 2025 10:57:37 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 2/7] net/mlx5e: Use TIR API in
 mlx5e_modify_tirs_lb()
To: Tariq Toukan <ttoukan.linux@gmail.com>, Simon Horman <horms@kernel.org>,
 Tariq Toukan <tariqt@nvidia.com>
Cc: Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Saeed Mahameed <saeedm@nvidia.com>,
 Leon Romanovsky <leon@kernel.org>, Mark Bloch <mbloch@nvidia.com>,
 netdev@vger.kernel.org, linux-rdma@vger.kernel.org,
 linux-kernel@vger.kernel.org, Gal Pressman <gal@nvidia.com>,
 Carolina Jubran <cjubran@nvidia.com>, Dragos Tatulea <dtatulea@nvidia.com>
References: <1761201820-923638-1-git-send-email-tariqt@nvidia.com>
 <1761201820-923638-3-git-send-email-tariqt@nvidia.com>
 <aPouFMQsE48tkse9@horms.kernel.org>
 <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <83aad5ca-21e5-41a2-89c9-e3c8e9006e6a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/26/25 1:50 PM, Tariq Toukan wrote:
> On 23/10/2025 16:31, Simon Horman wrote:
>> On Thu, Oct 23, 2025 at 09:43:35AM +0300, Tariq Toukan wrote:
>>> diff --git a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> index 376a018b2db1..fad6b761f622 100644
>>> --- a/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> +++ b/drivers/net/ethernet/mellanox/mlx5/core/en_common.c
>>> @@ -250,43 +250,30 @@ void mlx5e_destroy_mdev_resources(struct mlx5_core_dev *mdev)
>>>   int mlx5e_modify_tirs_lb(struct mlx5_core_dev *mdev, bool enable_uc_lb,
>>>   			 bool enable_mc_lb)
>>
>> ...
>>
>>>   	list_for_each_entry(tir, &mdev->mlx5e_res.hw_objs.td.tirs_list, list) {
>>> -		tirn = tir->tirn;
>>> -		err = mlx5_core_modify_tir(mdev, tirn, in);
>>> +		err = mlx5e_tir_modify(tir, builder);
>>>   		if (err)
>>>   			break;
>>>   	}
>>>   	mutex_unlock(&mdev->mlx5e_res.hw_objs.td.list_lock);
>>>   
>>> -	kvfree(in);
>>> +	mlx5e_tir_builder_free(builder);
>>>   	if (err)
>>>   		mlx5_core_err(mdev,
>>>   			      "modify tir(0x%x) enable_lb uc(%d) mc(%d) failed, %d\n",
>>> -			      tirn,
>>> +			      mlx5e_tir_get_tirn(tir),
>>
>> Sorry, for not noticing this before sending my previous email.
>>
>> Coccinelle complains about the line above like this:
>>
>> .../en_common.c:276:28-31: ERROR: invalid reference to the index variable of the iterator on line 265
>>
>> I think this is a false positive because the problem only occurs if
>> the list iteration runs to completion. But err guards against
>> tir being used in that case.
>>
> 
> Exactly.
> 
>> But, perhaps, to be on the safe side, it would be good practice
>> to stash tir somewhere?
>>
> 
> I tried to keep the error print out of the critical lock section.
> It's not time-sensitive so optimization is not really needed.
> I can simply move the print inside where it belongs.

Yes please!

Also the printk is performed on error, should not affect the path
critical path performances even if that would be time-sensitive.

/P


