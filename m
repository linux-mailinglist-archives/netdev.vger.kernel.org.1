Return-Path: <netdev+bounces-233687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65B9EC17647
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 00:45:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22B2D3A99C0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 23:45:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67D6122D4E9;
	Tue, 28 Oct 2025 23:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s9hBZqgV"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1144D7405A
	for <netdev@vger.kernel.org>; Tue, 28 Oct 2025 23:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761695122; cv=none; b=QmlSJqZzLBSD1oWGTJLx0LJzoYUyN9oM763YmcL/uZVBfAmOwlo0EUfKVLjWdgZmj3i/wrvTcu3imiOMtzpsidaIQ4KwbC9KBrkYMcTVwVPBHqZgTasxGKyfdR7/vMgptDiS6JYYuqgAeIm9UfTx5ylv37CEfd9HCkpAJ4MmZ2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761695122; c=relaxed/simple;
	bh=pvORYJ5rE/jqWp1h5Wifw8LnZkhqt67QzZd23qnqtEs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EGRbBJHT+X2yTqRdCI6iZZiO5XzjG1BOujmdWRLHb8Z9sC5uRlF4EBQhe54K5IDtPbYy965m6mVN1/VeO7gEtBWy3oycRddCnpBvsRC+rvMdCqPyrZfboO3mufqikUzHTABobB0LpKE6Ti9ZC40CAv/13kwX4h3z9VHbkNwbgso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s9hBZqgV; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cd154e3c-0cac-4ead-a3d0-39dc617efa74@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761695118;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bVdLbIqZfPVV9nzaikXAAecCSd3I2FTL+HXFgib0190=;
	b=s9hBZqgVlWkSOYt6BK5gYHgMND6u8gafxaO3QunUF18Km/MlmW4ZJJnamgtdya4sIRTTe5
	Krw+3ruO6soP5Svqstsmj+NMp81kDf572yxl555qKDIyUmenGdBF4GwGMzubUe6w2AHYYG
	NjuB85dDSetbSCOCyivijDWUHG/XNBI=
Date: Tue, 28 Oct 2025 23:45:13 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] ptp: guard ptp_clock_gettime() if neither gettimex64 nor
To: Jakub Kicinski <kuba@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>
Cc: richardcochran@gmail.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, junjie.cao@intel.com, linux-kernel@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com,
 syzbot+c8c0e7ccabd456541612@syzkaller.appspotmail.com,
 syzkaller-bugs@googlegroups.com, thostet@google.com
References: <aQDOpeQIU1G4nA1F@hoboy.vegasvil.org>
 <20251028155318.2537122-1-kuniyu@google.com>
 <20251028161309.596beef2@kernel.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
In-Reply-To: <20251028161309.596beef2@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 28.10.2025 23:13, Jakub Kicinski wrote:
> On Tue, 28 Oct 2025 15:51:50 +0000 Kuniyuki Iwashima wrote:
>> From: Richard Cochran <richardcochran@gmail.com>
>> Date: Tue, 28 Oct 2025 07:09:41 -0700
>>> On Tue, Oct 28, 2025 at 05:51:43PM +0800, Junjie Cao wrote:
>>>> Syzbot reports a NULL function pointer call on arm64 when
>>>> ptp_clock_gettime() falls back to ->gettime64() and the driver provides
>>>> neither ->gettimex64() nor ->gettime64(). This leads to a crash in the
>>>> posix clock gettime path.
>>>
>>> Drivers must provide a gettime method.
>>>
>>> If they do not, then that is a bug in the driver.
>>
>> AFAICT, only GVE does not have gettime() and settime(), and
>> Tim (CCed) was preparing a fix and mostly ready to post it.
> 
> cc: Vadim who promised me a PTP driver test :) Let's make sure we
> tickle gettime/setting in that test..

Heh, call gettime/settime is easy. But in case of absence of these callbacks
the kernel will crash - not sure we can gather good signal in such case?

