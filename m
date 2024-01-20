Return-Path: <netdev+bounces-64448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8AF8332BC
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 05:21:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44216282AD9
	for <lists+netdev@lfdr.de>; Sat, 20 Jan 2024 04:21:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4872F111E;
	Sat, 20 Jan 2024 04:21:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="mWtf0V/3"
X-Original-To: netdev@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A676110C
	for <netdev@vger.kernel.org>; Sat, 20 Jan 2024 04:21:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705724477; cv=none; b=j7TEp9Nf+1g/6XeShUXs40oQOGWfDdFqxUD0fb8EOfhttfhO3iJjgOUynaQz6OqmE80NB6m0Axu8lP2qMQYOoZst6WTEKgrIJ0Upd63c+FfI0sK/Rr62SXbtowYVXR03g7PjoP5T4LtLSdtjYKId6js9ftGk7yyWHn6A762ICO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705724477; c=relaxed/simple;
	bh=QyLK+OphhYc9hxQqF8HtqtQrcaiy3iMrgozIAevqjps=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NB/yCJu/d1GdI4+SF4oDV7mKR0fiRZ3mWUpOAor0JR5GkJ/87AewqusRvG2IvM6cetz2WeB9q54bEvSj3dBYHAEalUkXPeeVo8tPAkhugaRiBiNSV69hwHVCfzlv1gZBXMV/66rcaUltYIPINJUnD4T6sfMr97Dkpm3k3myyWIQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=mWtf0V/3; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cb1aed07-47f8-48a2-91e7-a66b3237cb5b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1705724472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BKFpauz7ZWQ55RHrqHuUkp6+YwmtIzKTQV+qqJYgyxA=;
	b=mWtf0V/3fwm2b1HD3lyBN1TcqPARbGV4iH0h6zhVoc/IA35kM/ZVqCLMl6fAeXnad07nE4
	mI1C6GyTPUU2YJWHsVXoaLGvYAIgsHd+ECPDZTbUgW6uWyDZNtcPwoWIq2FfXJpTmrChWK
	NVjBU2PLJbJ24CovFYk6Tzk5aB3JXdY=
Date: Sat, 20 Jan 2024 12:21:05 +0800
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

Thanks. The 2 functions read_poll_timeout() and 
read_poll_timeout_atomic() are interesting.

Zhu Yanjun

>
> 	Andrew

