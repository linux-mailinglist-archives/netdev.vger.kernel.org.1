Return-Path: <netdev+bounces-233693-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F282C176E0
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:57:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BF57E355B40
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0567306B3D;
	Tue, 28 Oct 2025 23:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vQJLaygl"
X-Original-To: netdev@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27F13314C3
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:57:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695835; cv=none; b=VcXSZyBGJ1deilyloq4TKqPbs4jujUn+BidoODBE4bmea8FzS2fnXQQ+8nryq1FsH/shNmufQj9SnXfhWdErO8sTwVOCuumks1RiScyEMkY6P4PThRyOUekP7tOneuVMSeIlBdzBLqldJGOMWpLi1ovgvGOU6PzDcO33ByyBXjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695835; c=relaxed/simple;
	bh=nfXwQEEoKbz32wsva1mlhMAr5uMiWOaKJ17zPrNr9jg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lVhkAa7WRVCs7ZZg5ogPh52pQKmlDnZK2ahYgCcw1h4BtydeSPpdvcbM2DPXza4llmDGTSyIYitVQtZIeH4++OC/fnESDU8nC63lAJO0caBqWXnLIIDqnBEKatLfWTgJw4ZSAcnEI1w4mqK9ZCtO4v4hZ8VseHh31mw9YE7hEJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vQJLaygl; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <9e1ccd0f-ecb6-438e-9763-5ba04bce5928@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761695830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nV9YHEylTMHdGs2pO/O/fQk1/0VXLst22ComzqI7Qec=;
	b=vQJLayglCIxWNRErrNx+2ciXKBsU4AaqGYoisrMSjbzepRLpdZhcN8YtNAO5Htll7iaS4G
	9BssoguFQlJnlXkbo7cJ7L0Lqkt091RD5snLJ9drmeQ7ZkwSXkTtrAFLHg1omNY8shoeCB
	+fCKUXnqDiSfLN9jgIDon0yTraUU9yg=
Date: Tue, 28 Oct 2025 23:56:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Kuniyuki Iwashima <kuniyu@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>, richardcochran@gmail.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 junjie.cao@intel.com, linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
 pabeni@redhat.com, syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, thostet@google.com
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
 <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org>
 <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
 <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <CAAVpQUCYFoKhUn1MU47koeyhD6roCS0YpOFwEikKgj4Z_2M=YQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

On 28.10.2025 23:54, Kuniyuki Iwashima wrote:
> On Tue, Oct 28, 2025 at 4:45 PM Vadim Fedorenko
> <vadim.fedorenko@linux.dev> wrote:
>>
>> On 28.10.2025 23:13, Jakub Kicinski wrote:
>>> On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
>>>> From: Richard Cochran <richardcochran@gmail.com>
>>>> Date: Tue, 28 Oct 2025 07:09:41 -0700
>>>>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
>>>>>> Syzbot reports a NULL function pointer call on arm64 when
>>>>>> ptp_clock_gettime() falls back to ->gettime64() and the driver provides
>>>>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
>>>>>> posix clock gettime path.
>>>>>
>>>>> Drivers must provide a gettime method.
>>>>>
>>>>> If they do not, then that is a bug in the driver.
>>>>
>>>> AFAICT, only GVE does not have gettime() and settime(), and
>>>> Tim (CCed) was preparing a fix and mostly ready to post it.
>>>
>>> cc: Vadim who promised me a PTP driver test :) Let's make sure we
>>> tickle gettime/setting in that test..
>>
>> Heh, call gettime/settime is easy. But in case of absence of these callbacks
>> the kernel will crash - not sure we can gather good signal in such case?
> 
> At least we could catch it on NIPA.
> 
> but I suggested Tim adding WARN_ON_ONCE(!info->gettime64 &&
> !info-> getimex64) in ptp_clock_register() so that a developer can
> notice that even while loading a buggy module.

Yeah, that looks like a solution

