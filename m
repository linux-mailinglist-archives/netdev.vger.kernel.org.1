Return-Path: <netdev+bounces-153484-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6548C9F82F3
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 19:12:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61ABD1884ED8
	for <lists+netdev@lfdr.de>; Thu, 19 Dec 2024 18:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4BF19D8A9;
	Thu, 19 Dec 2024 18:11:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aVLxeXVq"
X-Original-To: netdev@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778B41922F1
	for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 18:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734631914; cv=none; b=tqAnaxJ7IZeSIEMOqSqaQEd4W6kFfviXQ/c3mri8IvUaPGqL/ehMmykPX1fPp1ElG9ieersYPypgB138ES0Yy5Quyvn+IeslBJWJsGwQNsAZ5atBQmcTflSeSjEkaEFEr6XRPwxo9aeiZ24SLHJsbm6/Dlox5NMpth7MNgC5BvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734631914; c=relaxed/simple;
	bh=gdEPCqzw4MlwBS/ShETotZ5KsNu7Zoo2vLPgV/zwdqU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N77k7BUi+MbYwmiIWou4uPAdzLPSL7JNZrKIU3CpuGGAWzB5j80NQXORdyzdcfZjg8NrEBwHqT4UDr1NYKLcswN8g5CoiqFiTMYrSL1QDE++1yV/DzjXmCl3kb/bLBIYPb1STQiCsmuOfnBOTCyFnOjCSalROGHwOad44IioHfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aVLxeXVq; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <97220e81-9835-4bd1-8cd2-15c2eda1dbfb@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1734631910;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FHZChDR1k0tGFZ0mMlC4NeuSgi+rzQhZDbhqe1iwJZc=;
	b=aVLxeXVqag+uUKwPK1B0+I+F3g47iJy50timtelVagiigRnK1OqbD+6U5DgBe3cTI5xdIu
	l5kPfVUn7cYPAIXQ+1ZXJWmNPfHmdtHyaIj1nSTObGqPim1kaXnRew9wbYZDCIe64e9mUd
	StHTfyMQNqTai8KNlC/ZXIG1xu8XDFQ=
Date: Thu, 19 Dec 2024 10:11:44 -0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: tcp_diag for all network namespaces?
To: Kuniyuki Iwashima <kuniyu@amazon.com>, dave.seddon.ca@gmail.com
Cc: netdev@vger.kernel.org, bpf <bpf@vger.kernel.org>
References: <CANypexQX+MW_00xAo-sxO19jR1yCLVKNU3pCZvmFPuphk=cRFw@mail.gmail.com>
 <20241210020057.26127-1-kuniyu@amazon.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Martin KaFai Lau <martin.lau@linux.dev>
In-Reply-To: <20241210020057.26127-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 12/9/24 6:00 PM, Kuniyuki Iwashima wrote:
>> G'day,
>>
>> Short
>> Is there a way to extract tcp_diag socket data for all sockets from
>> all network name spaces please?
> I think there's no such interface.
> 
> I remember there was a similar request for TCP BPF iterator,
> but now it's difficult because each netns could have its own
> TCP hash table for established connections.

It would be nice to be able to iterate netns in bpf. There is a bpf task/file 
iterator that iterates tasks and all files under each task 
(tools/testing/selftests/bpf/progs/bpf_iter_task_file.c). The netns/sock 
iteration feels similar. The first step could be to allow bpf prog to iterate 
all netns first. Then it will allow bpf to inspect "struct net". There is also a 
newer open iterator approach in bpf which should be considered also.

