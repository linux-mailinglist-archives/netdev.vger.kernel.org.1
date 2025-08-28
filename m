Return-Path: <netdev+bounces-217866-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A737B3A379
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 17:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A33316D540
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 15:00:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D56314B76;
	Thu, 28 Aug 2025 14:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IjAYaN6p"
X-Original-To: netdev@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2CA22D4F6
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 14:57:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756393074; cv=none; b=TxGjKlvQ52v/iSItMbLPfzwXI87rYsIsJeIw+9BEe1lPIVarBi6Nmsu+ivfeN1cMxJRzm0QlpnSmRFEXeAp9dojAHwF9g8Pemx6P1rV0WHFIqy9lPvsNXwdk6c15B9L8Uwe16QT29bjGVu94T3kWBwThQUwuCAtg+8E3WSmnTB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756393074; c=relaxed/simple;
	bh=/piA/tAynLslqC3CI5eA5S97oqvJFuIUWdyDi0O7ez8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tBTWvnX0NlUawQCzwjh9sPHo+BpPzsgTBYy8PtHUjtnEZUajOZnoggTYpnv8dbEsPvxNqACTq6rSIAweEctGWmOyVtxj/l+xxo26Cgyk6TVtSLVfZeiAJMOJrU9C6xUGIWUg483ABWhn+VWroXcugfpgwOoRMRKJ3oXsvNic3Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IjAYaN6p; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <cbc6389e-069e-4f59-8544-fa59678e401b@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1756393071;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r2OlzHNvPNbmcUFVqgSbczvsRH//BtNhcm7pgGO6xi8=;
	b=IjAYaN6pjGv8XZdchjBQ6pLDHxL77XCMmfZZEHWwvYJRmLCMM1LG6DslFjRE/bcTalb7eF
	Le2I5gHHR9q2U2qBUT4Plmmpyut7cDFxm6ZL6mJYzDoQUWWmQgycWAivy8FMnGZCuDda+A
	coXWnK/YGJx//si0q1idP3EICl7mKfU=
Date: Thu, 28 Aug 2025 10:57:42 -0400
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: netpoll: raspberrypi [4 5] driver locking woes
To: Mike Galbraith <efault@gmx.de>, Robert Hancock <robert.hancock@calian.com>
Cc: Breno Leitao <leitao@debian.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>
References: <4698029bbe7d7a33edd905a027e3a183ac51ad8a.camel@gmx.de>
 <e32a52852025d522f44d9d6ccc88c716ff432f8f.camel@gmx.de>
 <f4fa3fcc637ffb6531982a90dbd9c27114e93036.camel@gmx.de>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Sean Anderson <sean.anderson@linux.dev>
In-Reply-To: <f4fa3fcc637ffb6531982a90dbd9c27114e93036.camel@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

Hi Mike,

On 8/27/25 12:02, Mike Galbraith wrote:
> Unexpected addendum to done deal datapoint, so off list.
> 
> On Tue, 2025-08-26 at 11:49 +0200, Mike Galbraith wrote:
>> 
>> The pi5 gripe fix is equally trivial, but submitting that is pointless
>> given there's something else amiss in fingered commit.  This is all of
>> the crash info that escapes the box w/wo gripes silenced.
>> 
>> [   51.688868] sysrq: Trigger a crash
>> [   51.688892] Kernel panic - not syncing: sysrq triggered crash
>> [   51.698066] CPU: 0 UID: 0 PID: 0 Comm: swapper/0 Not tainted 6.17.0-rc2-v8-lockdep #533 PREEMPTLAZY
>> [   51.707234] Hardware name: Raspberry Pi 5 Model B Rev 1.0 (DT)
>> [   51.713085] Call trace:
>> [   51.715532]  show_stack+0x20/0x38 (C)
>> [   51.719206]  dump_stack_lvl+0x38/0xd0
>> [   51.722878]  dump_stack+0x18/0x28
>> 
>> That aspect is a punt and run atm (time.. and dash of laziness:).
> 
> Plan was to end datapoint thread, but after booting pi5's 6.12 kernel,
> for some reason I fired up netconsole.. and box promptly exhibited the
> netpoll locking bug warning, indicating presence of 138badbc21a0. 
> Instead of saying to self "nope, just walk away", I poked SysRq-C.. and
> the bloody damn monitoring box received a 100% complete death rattle. 
> Well bugger.

Did you get a backtrace for this?

And to be clear, the steps to reproduce this are to boot a kernel with
lockdep enabled with netconsole on macb and then hit sysrq?

> Two trees contain locking buglet introducing 138badbc21a0, 6.12.41 and
> 6.17.0, but only the later reproduces the above mess.  A quick stare at
> git diff inspired checking e6a532185daa, and sure enough reverting only
> it reproduced a functional netconsole, modulo warnings, ie the mess
> above manifests only with BOTH resident.  Either revert 138badbc21a0,
> or revert e6a532185daa and fix the 138badbc21a0 locking buglet, and the
> result is the same, a perfectly functional warning free netconsole.


