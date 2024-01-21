Return-Path: <netdev+bounces-64515-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9F88357DF
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 22:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A2FA2816E5
	for <lists+netdev@lfdr.de>; Sun, 21 Jan 2024 21:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0A7381DC;
	Sun, 21 Jan 2024 21:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b="rRg8tP81"
X-Original-To: netdev@vger.kernel.org
Received: from mail.foo.to (mail.foo.to [144.76.29.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13E5F38DD4
	for <netdev@vger.kernel.org>; Sun, 21 Jan 2024 21:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.29.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705871680; cv=none; b=R5GGwYtMDIo9WMK/7kIxB4kbqyey/LAP9krzGsovgT77NbMaxto2mjUDCg6jlh2hj0WmpC3ACOrp11HGKmaFHBU80jSenGCuhlj+yikA6i9Y7OGBYexID3t6z++gHtsATGQOdi62RIYitxYkT5WaEwqxlY9B3Mb544yHYU8p+a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705871680; c=relaxed/simple;
	bh=kQujN3tNXeutF412+A9QZPM0EE/ovHGgRVWYDcP/hHE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Wqs+uaAES4WOUhd6yJMtO03Yqe73ysjrxoflTNWa3anAAydHV8GtGdORKHKc00j1T30ues1XlTouK+Q/6cgkyaAzTuQTtkcLsGQVBNksEVpQt3IvI+Zz90H3IrUSjuXCNifhYOZ0K7eP2YAtEaEo8gebauGVhiJU02b1w6qrX9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net; spf=pass smtp.mailfrom=pwaller.net; dkim=pass (1024-bit key) header.d=pwaller.net header.i=@pwaller.net header.b=rRg8tP81; arc=none smtp.client-ip=144.76.29.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pwaller.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pwaller.net
Message-ID: <e98f7617-b0fe-4d2a-be68-f41fb371ba36@pwaller.net>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pwaller.net; s=mail;
	t=1705871110; bh=kQujN3tNXeutF412+A9QZPM0EE/ovHGgRVWYDcP/hHE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rRg8tP81hhgFnGTEMJJbhwrtTcsU5FfAVyfv21Kphssy9RdcRKCIMlrbQSj1oJbmC
	 vMh46fGTgYDWDUqLebSETAIOm7tY4s6ChqjzLormYr2Tbd2fkVLqPQbWyurugSFdHB
	 51Dd5qIpu5qW6k1D/46hEUpKpLyjwAESjAYo3q3o=
Date: Sun, 21 Jan 2024 21:05:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [EXT] Aquantia ethernet driver suspend/resume issues
Content-Language: en-US
To: Igor Russkikh <irusskikh@marvell.com>, Jakub Kicinski <kuba@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>,
 Netdev <netdev@vger.kernel.org>
References: <CAHk-=wiZZi7FcvqVSUirHBjx0bBUZ4dFrMDVLc3+3HCrtq0rBA@mail.gmail.com>
 <cf6e78b6-e4e2-faab-f8c6-19dc462b1d74@marvell.com>
 <20231127145945.0d8120fb@kernel.org>
 <9852ab3e-52ce-d55a-8227-c22f6294c61a@marvell.com>
 <20231128130951.577af80b@kernel.org>
 <262161b7-9ba9-a68c-845e-2373f58293be@marvell.com>
From: Peter Waller <p@pwaller.net>
In-Reply-To: <262161b7-9ba9-a68c-845e-2373f58293be@marvell.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

I see a fix for double free [0] landed in 6.7; I've been running that 
for a few days and have hit a resume from suspend issue twice. Stack 
trace looks a little different (via __iommu_dma_map instead of 
__iommu_dma_free), provided below.

I've had resume issues with the atlantic driver since I've had this 
hardware, but it went away for a while and seems as though it may have 
come back with 6.7. (No crashes since logs begin on Dec 15 till Jan 12, 
Upgrade to 6.7; crashes 20th and 21st, though my usage style of the 
system has also varied, maybe crashes are associated with higher memory 
usage?).

Possibly unrelated but I also see fairly frequent (1 to ten times per 
boot, since logs begin?) messages in my logs of the form "atlantic 
0000:0c:00.0: AMD-Vi: Event logged [IO_PAGE_FAULT domain=0x0014 
address=0xffce8000 flags=0x0020]".

[0] 
https://github.com/torvalds/linux/commit/7bb26ea74aa86fdf894b7dbd8c5712c5b4187da7

- Peter

kworker/u65:2: page allocation failure: order:6, 
mode:0x40d00(GFP_NOIO|__GFP_COMP|__GFP_ZERO), 
nodemask=(null),cpuset=/,mems_allowed=0
CPU: 18 PID: 166017 Comm: kworker/u65:2 Not tainted 6.7.0
Hardware name: ASUS System Product [...] BIOS 1502 06/08/2023
Workqueue: events_unbound async_run_entry_fn
Call Trace:
  <TASK>
  dump_stack_lvl+0x47/0x60
  warn_alloc+0x165/0x1e0
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __alloc_pages_direct_compact+0xb3/0x290
  __alloc_pages+0x109e/0x1130
  ? iommu_dma_alloc_iova+0xd4/0x120
  ? srso_alias_return_thunk+0x5/0xfbef5
  ? __iommu_dma_map+0x84/0xf0
  ? aq_ring_alloc+0x22/0x80 [atlantic]
  __kmalloc_large_node+0x77/0x130
  __kmalloc+0xc6/0x150
  aq_ring_alloc+0x22/0x80 [atlantic]
  aq_vec_ring_alloc+0xee/0x1a0 [atlantic]
  aq_nic_init+0x118/0x1d0 [atlantic]
  atl_resume_common+0x40/0xd0 [atlantic]


On 30/11/2023 12:59, Igor Russkikh wrote:
>
> On 11/28/2023 10:09 PM, Jakub Kicinski wrote:
>> For Rx under load larger rings are sometimes useful to avoid drops.
>> But your Tx rings are larger than Rx, which is a bit odd.
> Agree. Just looked into the history, and it looks like this size was chosen
> since the very first commit of this driver.
>
>> I was going to say that with BQL enabled you're very unlikely to ever
>> use much of the 4k Tx ring, anyway. But you don't have BQL support :S
>>
>> My free advice is to recheck you really need these sizes and implement
>> BQL :)
> Thanks for the hint, will consider this.
>
> Regards
>    Igor



