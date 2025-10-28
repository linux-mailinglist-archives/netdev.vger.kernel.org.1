Return-Path: <netdev+bounces-233475-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 04FCEC1404D
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 11:14:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EC7134E26DC
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 10:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 311E32C3769;
	Tue, 28 Oct 2025 10:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ft4FLfAt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9886819E96D
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 10:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761646444; cv=none; b=a0c+S/mTrvx5IoZH9Cuta9fnNAlW+q2QSFSBjXQ5lRiixn5bXYYm1671qOAyyYY8HxQWBi2AlDxLNEBfs23MdskVRx5jANXk7XXzyMnaXmys4PgaTaVw4Oox9ieYojaF1XamQsDqGGteJpEKGWFFtX+1XF/cwcyhJHMRzuILts4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761646444; c=relaxed/simple;
	bh=m4so6IGFPXEcYvbhKAT6MoOPeAqvtbCZnJg8zIhms94=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uBiEIe/O2JOgdg0B0RLI+rdO8tLJU+1fno8cxVud3ZYkaq9m/q4TabQ83zct4/CGNG96zCHkS0SVesnTJXAs8BMt8v7bGb7YzWaLFzY96c5Vo8LGhTLPxBLjdHrNa5fHOXMv4zZApoa2Nve1FL29KEppBUrdjRCvukBOwzkRNpk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ft4FLfAt; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761646441;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B6UDUZTk5Iy4k44e3/ML5QCHFRg0Z07tvb3WKav93qg=;
	b=Ft4FLfAtDLfGCdQDbOUGNpParD+6rQLkcfi0nCecLk7zaK+qLpB4L11YGtifSRlEQOEcrU
	oglZ5MZrEKY2XmfOztvOOXibBNXL6bmfroopT1NtBTycRdBZzADCiMjJ0PgRmQl5B7aTRJ
	5d9/nI8xz532/DH1siYU44t0dyx0H/Y=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-412-IBprgp7NOLGDeevh3_2pZg-1; Tue, 28 Oct 2025 06:14:00 -0400
X-MC-Unique: IBprgp7NOLGDeevh3_2pZg-1
X-Mimecast-MFC-AGG-ID: IBprgp7NOLGDeevh3_2pZg_1761646439
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4770dea2551so57899895e9.0
        for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 03:13:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761646439; x=1762251239;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B6UDUZTk5Iy4k44e3/ML5QCHFRg0Z07tvb3WKav93qg=;
        b=ZeLSF2qDEor5+G/3UL07xYHE2HeuimOf2e+MdpW2GbwIfNyTfasuvm1x9WS5I2ffIM
         1fh2bYs1cmp/GhF0kN2R+09bVij1yBmJk2353EkWsNILfH4xmn4YaycnN9wkfvBzSLp0
         w/ETVc/YC2HPpiUdHeXqCQS6z+DlqCoewVi4cf0YzAqBDVIyDon8gAzFswrHpVxepa9U
         bEYjxYVafxQtQlH0wTiqUb3xQ/5m3RD5ejgpozb7kswFQL09Q3tbWt5x7W6+Z4KizvNh
         4jzukepN2SevJ8dfdFRh5mgJyN+ztyiniBK9JzI+9lZ6D+kDi6tn/XrVusW9VkJYiXz1
         9iKg==
X-Forwarded-Encrypted: i=1; AJvYcCXntTrL6o1uxE2wTPc7sbb8iKN68r1YRzZG3mEMWi8NmITTxP7aHPCXYuhouS7Lvo/7YxS5sEA=@vger.kernel.org
X-Gm-Message-State: AOJu0YylY8bSEhGbEOMs6cCiXYF7O0aZZABuKeotm6o92ZEhHQK6i6my
	MG6ztfvzIydTQ5Q3veDmqTPq9y1Qa9Ku9RDwe9tv12VIXpG+2GSXsLyU5X88ERPvVIXeH6Ruo0e
	IeILMAlkdFu7XEYgzowX1cOoVkz2jLYOfSeN7DO+XYotRGXYEuZdudnQA+w==
X-Gm-Gg: ASbGncv+FGLR554p3ehd28hj22GjUh13fuDI8cagnTC8EUWkR4YvURur1WAjfePSBwH
	s91UlZxE6sPTVpkxD5yr1gCcJ2s4I97AjZQzc7/az2x1GU5lKPaIS+A7vjP1qLFIDWZkOkneWN7
	+fhyZuvP00D5RBEuXbLyaJBu+1xn5bw52spYCqCRL4RXawuXeGbOVRtPBKKeDF+jkGWQREvORX6
	N37jVHnv2XjPIIt3RfPFhzsSsfyBUPBzjAcAZWWlBxPzChuOg9vp6PhPKyzW4JEY2qXFfbhmSqB
	eGkljNu6musl0tlkc3Ujmo/F3jz+aN0lrDalccPk2Wbz8AxbzBzboibFvzr1DeGVp6wlyd+cdHp
	v3n6zRTdFoJE8orOwJzLi/oTOsv92+UT68jfMwqE9px+JVz4=
X-Received: by 2002:a05:600c:4fd4:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-47717e6befcmr28032285e9.32.1761646438802;
        Tue, 28 Oct 2025 03:13:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEJ0ZBf/JaFACw6W5VidqgGCD57Uclj71azPGP6UqMT6JqtBFJAx5Wu2NucJErwaxI1+vp7eg==
X-Received: by 2002:a05:600c:4fd4:b0:475:e09c:960e with SMTP id 5b1f17b1804b1-47717e6befcmr28031835e9.32.1761646438355;
        Tue, 28 Oct 2025 03:13:58 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c? ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952cb55asm19552829f8f.17.2025.10.28.03.13.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Oct 2025 03:13:57 -0700 (PDT)
Message-ID: <b95eecd5-3dab-4557-aa2a-36f58779c230@redhat.com>
Date: Tue, 28 Oct 2025 11:13:55 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/5] net/mlx5: Add balance ID support for LAG
 multiplane groups
To: Tariq Toukan <ttoukan.linux@gmail.com>, Zhu Yanjun
 <yanjun.zhu@linux.dev>, Tariq Toukan <tariqt@nvidia.com>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>
Cc: Saeed Mahameed <saeedm@nvidia.com>, Leon Romanovsky <leon@kernel.org>,
 Mark Bloch <mbloch@nvidia.com>, netdev@vger.kernel.org,
 linux-rdma@vger.kernel.org, linux-kernel@vger.kernel.org,
 Gal Pressman <gal@nvidia.com>, Moshe Shemesh <moshe@nvidia.com>,
 Shay Drori <shayd@nvidia.com>
References: <1761211020-925651-1-git-send-email-tariqt@nvidia.com>
 <328ebb4f-b1ce-4645-9cea-5fe81d3483e0@linux.dev>
 <2f84a4ee-8e45-460a-8e62-3f9a48da892a@gmail.com>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <2f84a4ee-8e45-460a-8e62-3f9a48da892a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 10/26/25 1:53 PM, Tariq Toukan wrote:
> On 26/10/2025 1:59, Zhu Yanjun wrote:
>> 在 2025/10/23 2:16, Tariq Toukan 写道:
>>> 1. Add the hardware interface bits (load_balance_id and lag_per_mp_group)
>>> 2. Clean up some duplicate code while we're here
>>> 3. Rework the system image GUID infrastructure to handle variable lengths
>>> 4. Update PTP clock pairing to use the new approach
>>> 5. Restructure capability setting to make room for the new feature
>>> 6. Actually implement the balance ID support
>>>
>>> The key insight is in patch 6: we only append the balance ID when both
>>
>> In the above, patch 6 is the following patch? It should be patch 5?
>>
>> [PATCH net-next 5/5] net/mlx5: Add balance ID support for LAG multiplane 
>> groups
>>
>> Yanjun.Zhu
> 
> Right.
> 
> Indices shifted because we sent the preparation IFC patch a priori:
> 137d1a635513 net/mlx5: IFC add balance ID and LAG per MP group bits

No need to repost. I'll adjust the indexes while applying the series.

Thanks,

Paolo


