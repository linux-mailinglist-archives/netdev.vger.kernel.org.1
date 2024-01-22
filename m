Return-Path: <netdev+bounces-64525-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A0A835940
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 03:12:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 602641C2143E
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 02:12:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73175393;
	Mon, 22 Jan 2024 02:12:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nTAto0eb"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta1.migadu.com (out-180.mta1.migadu.com [95.215.58.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77E89804
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 02:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705889544; cv=none; b=Q/ViDXuvVwZN0vXrb50Vf589yQUASKGU+0gqD1gSUnxu+M28yMdb1JJrk+e5YzTh0Wr7M9/Cb78mBVXztpshxVGX3hFj87fpp50E3+sLn6F7kgeDn1SsuVrVxf1u5grRUYiFthvpgKJGxM2H4X/wtLpd60mur36qmVh/TawV6UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705889544; c=relaxed/simple;
	bh=oNv4o9o9tRfsG+JGqIYZXTByroNF80ULNbCLqByX5AA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JDG1Vvy8Z9sz+GFC1BCemP3DuQUU+aE9KAwcews1WEWmz8BwOO1LRo+0xaYJvF8dUSZXMYQRbmK7rDBtXwoDQ1oG1EHg4wb42segsqDSug9noVp7l05UBCwnj1Edlumc0TUl8BxSNzDkG+/mZKD6tMJLeQK2BK3zoEJNWoWE7gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nTAto0eb; arc=none smtp.client-ip=95.215.58.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <64270652-8e0c-4db7-b245-b970d9588918@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705889540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kJ9Z8zlhSyhWT9mMG7D9a1D7Qu+r3YhbOg1Qrk4gn5M=;
	b=nTAto0ebANGTNSyu8hi3jEJnozM3/m9YZYNi4YBF5k5jmlPPJ8CxKixhsQL8ilQ5a5imOh
	AMnk/pTzlmMw6jLeTaeARWDLCpeu86j3W7ZbDh3kdKRN6vdHX8v/NDkDyRBGBINo1wg+t5
	H1bye+kGwTGSnCLX1OEMUnW8RuhTwZk=
Date: Mon, 22 Jan 2024 10:12:15 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 1/1] virtio_net: Add timeout handler to avoid kernel hang
To: Andrew Lunn <andrew@lunn.ch>, Heng Qi <hengqi@linux.alibaba.com>
Cc: Paolo Abeni <pabeni@redhat.com>, Zhu Yanjun <yanjun.zhu@intel.com>,
 mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
 virtualization@lists.linux.dev, netdev@vger.kernel.org
References: <20240115012918.3081203-1-yanjun.zhu@intel.com>
 <ea230712e27af2c8d2d77d1087e45ecfa86abb31.camel@redhat.com>
 <667a9520-a53f-40a2-810a-6c1e45146589@linux.dev>
 <7dd89fc0-f31e-4f83-9c02-58ee67c2d436@linux.alibaba.com>
 <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Zhu Yanjun <yanjun.zhu@linux.dev>
In-Reply-To: <430b899c-aed4-419d-8ae8-544bb9bec5d9@lunn.ch>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT


在 2024/1/20 1:29, Andrew Lunn 写道:
>>>>>        while (!virtqueue_get_buf(vi->cvq, &tmp) &&
>>>>> -           !virtqueue_is_broken(vi->cvq))
>>>>> +           !virtqueue_is_broken(vi->cvq)) {
>>>>> +        if (timeout)
>>>>> +            timeout--;
>>>> This is not really a timeout, just a loop counter. 200 iterations could
>>>> be a very short time on reasonable H/W. I guess this avoid the soft
>>>> lockup, but possibly (likely?) breaks the functionality when we need to
>>>> loop for some non negligible time.
>>>>
>>>> I fear we need a more complex solution, as mentioned by Micheal in the
>>>> thread you quoted.
>>> Got it. I also look forward to the more complex solution to this problem.
>> Can we add a device capability (new feature bit) such as ctrq_wait_timeout
>> to get a reasonable timeout？
> The usual solution to this is include/linux/iopoll.h. If you can sleep
> read_poll_timeout() otherwise read_poll_timeout_atomic().

I read carefully the functions read_poll_timeout() and 
read_poll_timeout_atomic(). The timeout is set by the caller of the 2 
functions.

As such, can we add a module parameter to customize this timeout value 
by the user?

Or this timeout value is stored in device register, virtio_net driver 
will read this timeout value at initialization?

Zhu Yanjun

>
> 	Andrew

