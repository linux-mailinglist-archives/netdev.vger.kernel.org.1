Return-Path: <netdev+bounces-219711-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A42FDB42C15
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 23:44:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 63E0BA00C2D
	for <lists+netdev@lfdr.de>; Wed,  3 Sep 2025 21:44:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 789202EBBA8;
	Wed,  3 Sep 2025 21:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imhn+ath"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D1B1A7264
	for <netdev@vger.kernel.org>; Wed,  3 Sep 2025 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756935861; cv=none; b=kkXDHy3ml53RC/MZFRyfuULyTnL0hALsi/1ujnCbeiBqw3DYEyRPdvoTVLsu/7ux+LHUAKUpB7/K7e1GEY4+NnnxXIj4np7T/Iws0FEaAAhG/sCiEyDLmcCV7174B5j839nvK672sDSPtqg3I3Efs8s+NHM2X4rNQZBkxa6hDQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756935861; c=relaxed/simple;
	bh=lJzSgJib4EFoOQeYqgZwa8EDwxl7ibD+9/ogk06CkQ4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=icKbtu5KEyyv30Nuf/iD37fvXWEAig/rYjjvrB09JofkvIapCCy3/HSGn4QRYvLYPIG9luoj9NK29vFl//KYaNGX7vffwD2+FEUMOxz67VMtXTrcd6wfo0nAKqHmVmE+oOPtNNu3VqzAyFS5+gBS2t4rAzTj+HkVQqKkhstdToo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imhn+ath; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1756935858;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6IuCNS7pDho9ZKiwaVee/+v5YbDlDITCmQruYWgSMFA=;
	b=imhn+athoYEnOH/HD+UYWzYUCJ1g4K31tXxXLmT09L9NxJZhSjVlNLCiqpN+e0CGjrr5fd
	3D918nnrHdOdtqYrmPGYxMM8671c3f0hY1CMB/bpxT/8iYlaigM9RCKqOL00TPHCIx1jV6
	eTU2KnduPBnuAfHcC4YwsG4HhMS6XoM=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-353-qcRpAYhEMk2AqxC07qJ0mQ-1; Wed, 03 Sep 2025 17:44:17 -0400
X-MC-Unique: qcRpAYhEMk2AqxC07qJ0mQ-1
X-Mimecast-MFC-AGG-ID: qcRpAYhEMk2AqxC07qJ0mQ_1756935857
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-71e781fd54aso6381147b3.1
        for <netdev@vger.kernel.org>; Wed, 03 Sep 2025 14:44:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756935856; x=1757540656;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6IuCNS7pDho9ZKiwaVee/+v5YbDlDITCmQruYWgSMFA=;
        b=mKBAK5sC0kOxIbHz/SXXE0nmo0n+opJkH7RaOvlT9gz8yBzi9Z1Kx3eO2TqnxDcm9p
         Fczq52QtyUnTjnkAa9p/XuuFz5XLHJIdfvdJhpGKR9xsNj7ZSj5AyaJ0yk+OPZj3b/bD
         Odk/9cVA7J/yts+BC1mPFXmcy5S+495I5W0QnMKacxkXV2kFMC/noNu70+1GHLVX/SRm
         xR0AWSqMfaaKpPU1hSbD0Za9PDnhzg1ONXgRAieCZzGGH+OiPzYsy0Ml+lGqpFXVgfnh
         hf/CTXLIG/jkUXe98Y9wWJKZwIg+3w3BVJIRccv/HA7S58V2P1ONhqbM/aLtImxwGsWX
         SBng==
X-Forwarded-Encrypted: i=1; AJvYcCVZhP/1rE1pG2mI/cv+v0oxXg6mW73ZGuwkUCHn1Uakynqwh2P7IYx9GJFR7jDUHU7F2h9GiiE=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywa+dzmqo92MgLBeoNFnahPtYLCGc6BD4cccnk3CeMxTmSLeRxt
	bvh4xu4hvK9sl45GKF/aoG9dHHwS+iWABILhnLm4nuNp+quhZOty8u8XUmoIQdXeUiHbfDX10YE
	iIo4eryn2laYr7n2wzn6AQTrDpqtvsFtRzud8YX9w49oRdWs2TB+dUHC6Ug==
X-Gm-Gg: ASbGncvZhU265nXJg1c86dGdP5vRnJ9voiN3cNI+JeITNqKuIFsBvKXOsExK+wDhQKQ
	ufGVqZZzlcvPy0OaQ6pMwPhmoZH2e5455P0Z6igwk2J5R1aTpeoU5RAHQhMr5Ms0UDOQkvnFYDM
	Oeb/SUKDcsWperMYkugF5EctZsqty3ytWaVNVOXlaNXPvF/Bs8ZYbPl43/3A3MH1NSGXw5nHK6m
	25LNRrS2zPSXm10JoOVnaMUxRvqqrBXoFmc7hjZe8ZtQGeDeeN6LqvKmD5kDQypoKiq8Iw9Hey3
	hOPE5q0vTqf+YGmCesZzV8JcuWoe/MZORxH1qvadHKY=
X-Received: by 2002:a05:690c:8e10:b0:723:b3a6:781c with SMTP id 00721157ae682-723b3a67b21mr48037497b3.43.1756935856642;
        Wed, 03 Sep 2025 14:44:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZwb3LytZni2u9cZ2InCnvHlul8mehbMHJNDAE0FmjECYBPUHP1jyQCKVnIWbCznr4CyjB/w==
X-Received: by 2002:a05:690c:8e10:b0:723:b3a6:781c with SMTP id 00721157ae682-723b3a67b21mr48037247b3.43.1756935856029;
        Wed, 03 Sep 2025 14:44:16 -0700 (PDT)
Received: from [192.168.68.125] ([147.235.216.242])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-723a8511f0asm16193297b3.34.2025.09.03.14.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 Sep 2025 14:44:15 -0700 (PDT)
Message-ID: <7a6d4052-537d-4de6-b1af-a26e362704ab@redhat.com>
Date: Thu, 4 Sep 2025 00:44:12 +0300
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next,v2,1/2] devlink: Add new "max_mac_per_vf" generic
 device param
To: Jacob Keller <jacob.e.keller@intel.com>, intel-wired-lan@lists.osuosl.org
Cc: przemyslawx.patynowski@intel.com, jiri@resnulli.us,
 netdev@vger.kernel.org, horms@kernel.org, aleksandr.loktionov@intel.com,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com
References: <20250903190229.49193-1-mheib@redhat.com>
 <6033dd40-8adc-48f4-9acb-be50d992add7@intel.com>
Content-Language: en-US
From: mohammad heib <mheib@redhat.com>
In-Reply-To: <6033dd40-8adc-48f4-9acb-be50d992add7@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Jacob,

Thanks for the review.

It’s indeed an easy change. I’m wondering why untrusted VFs were 
originally limited to 16+2 MACs, and if changing this (overwriting that 
behavior) could be risky.

Anyway, I applied your suggestions in v3.

On 9/3/25 11:11 PM, Jacob Keller wrote:
> 
> 
> On 9/3/2025 12:02 PM, mheib@redhat.com wrote:
>> From: Mohammad Heib <mheib@redhat.com>
>>
>> Add a new device generic parameter to controls the maximum
>> number of MAC filters allowed per VF.
>>
>> While this parameter is named `max_mac_per_vf`, the exact enforcement
>> policy may vary between drivers. For example, i40e applies this limit
>> only to trusted VFs, whereas other drivers may choose to apply it
>> uniformly across all VFs. The goal is to provide a consistent devlink
>> interface, while allowing flexibility for driver-specific behavior.
>>
> 
> Would it make more sense to apply the limit to all VFs if set, and apply
> the default variable behavior for when its unset? This would avoid the
> need to have this much flexibility and latitude for each driver.
> 
> It seems like that wouldn't be too difficult.


