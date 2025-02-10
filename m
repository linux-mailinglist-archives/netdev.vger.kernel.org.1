Return-Path: <netdev+bounces-164557-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 346C3A2E365
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 06:09:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FECA7A2524
	for <lists+netdev@lfdr.de>; Mon, 10 Feb 2025 05:08:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C88F15CD52;
	Mon, 10 Feb 2025 05:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="KboGDcVd"
X-Original-To: netdev@vger.kernel.org
Received: from out30-119.freemail.mail.aliyun.com (out30-119.freemail.mail.aliyun.com [115.124.30.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70AD42F2A;
	Mon, 10 Feb 2025 05:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.119
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739164145; cv=none; b=eWsm3oCiHIu/dwk1tde6Z8PKzBUcgCc1Pq2Yg2fmz6HSv8aSNa4zWtQ5R6KPwY/I6Gc0Q/ZmtTW6OZBa37Vs3gxSYJMlNDfF9ZQaiRJkpCiGbl/LaQatcrIjyTEoUK1h1cUpO2omr0Fz55Pa29ZNArP/TplRLqK7oOIgkzwyFyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739164145; c=relaxed/simple;
	bh=GrGoLPWTuqbFu04kHEX8uIkan9MVGKWMGiOqmDkaD7E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QaI2AxGGmsfuDtKmhI98mjkc7HpaqQXcLlHS1/1AOsM/NnNAM2yg0ywC2+4xJoCIP1XRGqmy7r/Embd4bFvTmCQ23zg7naKyT2NvvL58uBUF+yVJfjaZCmHZWlY4xccjV3fBg+TBMaftjWbIqh1CgHvake26+SYGmeApT4iWBz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=KboGDcVd; arc=none smtp.client-ip=115.124.30.119
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1739164133; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=0lJ80j8f4PuDCGx2UI8jp4JUqbAEwGpMW2Sj3lGEKFs=;
	b=KboGDcVdgyJzwG4VHW+/fhC1SioSc6zZ8YdGFFoKRCuWZ8qTkmgyTknRyxCI2OqzHzgfjeQVf5Zeo3dMl1F5+fD73/TUvOefEigyPEAQzUNNOtaXpi69MAyCDQuWYAOB81jtbnDFCm9PGFSt2XJL+sD6hjtTtQfjY8655jow+co=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WP4wzUG_1739164131 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 10 Feb 2025 13:08:52 +0800
Date: Mon, 10 Feb 2025 13:08:51 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: Alexandra Winter <wintera@linux.ibm.com>,
	Niklas Schnelle <schnelle@linux.ibm.com>,
	Julian Ruess <julianr@linux.ibm.com>,
	Wenjia Zhang <wenjia@linux.ibm.com>,
	Jan Karcher <jaka@linux.ibm.com>, Gerd Bayer <gbayer@linux.ibm.com>,
	Halil Pasic <pasic@linux.ibm.com>,
	"D. Wythe" <alibuda@linux.alibaba.com>,
	Tony Lu <tonylu@linux.alibaba.com>,
	Wen Gu <guwen@linux.alibaba.com>,
	Peter Oberparleiter <oberpar@linux.ibm.com>,
	David Miller <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Thorsten Winkler <twinkler@linux.ibm.com>, netdev@vger.kernel.org,
	linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Simon Horman <horms@kernel.org>
Subject: Re: [RFC net-next 0/7] Provide an ism layer
Message-ID: <20250210050851.GS89233@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20250115195527.2094320-1-wintera@linux.ibm.com>
 <20250116093231.GD89233@linux.alibaba.com>
 <D73H7Q080GUQ.3BDOH23P4WDOL@linux.ibm.com>
 <0f96574a-567e-495a-b815-6aef336f12e6@linux.ibm.com>
 <20250117021353.GF89233@linux.alibaba.com>
 <dc2ff4c83ce8f7884872068570454f285510bda2.camel@linux.ibm.com>
 <20250118153154.GI89233@linux.alibaba.com>
 <d1927140-443b-401c-92ff-f467c12d3e75@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d1927140-443b-401c-92ff-f467c12d3e75@linux.ibm.com>

On 2025-01-28 17:04:53, Alexandra Winter wrote:
>
>
>On 18.01.25 16:31, Dust Li wrote:
>> On 2025-01-17 11:38:39, Niklas Schnelle wrote:
>>> On Fri, 2025-01-17 at 10:13 +0800, Dust Li wrote:
>>>>>
>>> ---8<---
>>>>> Here are some of my thoughts on the matter:
>>>>>>>
>>>>>>> Naming and Structure: I suggest we refer to it as SHD (Shared Memory
>>>>>>> Device) instead of ISM (Internal Shared Memory). 
>>>>>
>>>>>
>>>>> So where does the 'H' come from? If you want to call it Shared Memory _D_evice?
>>>>
>>>> Oh, I was trying to refer to SHM(Share memory file in the userspace, see man
>>>> shm_open(3)). SMD is also OK.
>>>>
>>>>>
>>>>>
>>>>> To my knowledge, a
>>>>>>> "Shared Memory Device" better encapsulates the functionality we're
>>>>>>> aiming to implement. 
>>>>>
>>>>>
>>>>> Could you explain why that would be better?
>>>>> 'Internal Shared Memory' is supposed to be a bit of a counterpart to the
>>>>> Remote 'R' in RoCE. Not the greatest name, but it is used already by our ISM
>>>>> devices and by ism_loopback. So what is the benefit in changing it?
>>>>
>>>> I believe that if we are going to separate and refine the code, and add
>>>> a common subsystem, we should choose the most appropriate name.
>>>>
>>>> In my opinion, "ISM" doesn’t quite capture what the device provides.
>>>> Since we’re adding a "Device" that enables different entities (such as
>>>> processes or VMs) to perform shared memory communication, I think a more
>>>> fitting name would be better. If you have any alternative suggestions,
>>>> I’m open to them.
>>>
>>> I kept thinking about this a bit and I'd like to propose yet another
>>> name for this group of devices: Memory Communication Devices (MCD)
>>>
>>> One important point I see is that there is a bit of a misnomer in the
>>> existing ISM name in that our ISM device does in fact *not* share
>>> memory in the common sense of the "shared memory" wording. Instead it
>>> copies data between partitions of memory that share a common
>>> cache/memory hierarchy while not sharing the memory itself. loopback-
>>> ism and a possibly future virtio-ism on the other hand would share
>>> memory in the "shared memory" sense. Though I'd very much hope they
>>> will retain a copy mode to allow use in partition scenarios.
>>>
>>> With that background I think the common denominator between them and
>>> the main idea behind ISM is that they facilitate communication via
>>> memory buffers and very simple and reliable copy/share operations. I
>>> think this would also capture our planned use-case of devices (TTYs,
>>> block devices, framebuffers + HID etc) provided by a peer on top of
>>> such a memory communication device.
>> 
>> Make sense, I agree with MCD.
>> 
>> Best regard,
>> Dust
>> 
>
>

Hi Winter,

Sorry for the late reply; we were on break for the Chinese Spring
Festival.

>
>In the discussion with Andrew Lunn, it showed that
>a) we need an abstract description of 'ISM' devices (noted)
>b) DMBs (Direct Memory Buffers) are a critical differentiator.
>
>So what do your think of Direct Memory Communication (DMC) as class name for these devices?
>
>I don't have a strong preference (we could also stay with ISM). But DMC may be a bit more
>concrete than MCD or ISM.

I personally prefer MCD over Direct Memory Communication (DMC).

For loopback or Virtio-ISM, DMC seems like a good choice. However, for
IBM ISM, since there's a DMA copy involved, it doesn’t seem truly "Direct,"
does it?

Additionally, since we are providing a device, MCD feels like a more
fitting choice, as it aligns better with the concept of a "device."

Best regards,
Dust

