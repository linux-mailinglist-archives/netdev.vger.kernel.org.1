Return-Path: <netdev+bounces-128075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 43051977D54
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AF0B1B244F8
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:28:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892A1D7997;
	Fri, 13 Sep 2024 10:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f+KDZ72J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="csyzP1S9"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E8801E505;
	Fri, 13 Sep 2024 10:28:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726223307; cv=none; b=EznyEhZw2sb1ldN97E/DFgRUh4wqufIQKhwKptYClGD+cachMGNYV7naWrtO1j+8vVbrr2wIb7qr4EbvGpMzyM0NmqQiktUTQp1JRL2ZirCmNrFVC4kDEYUJxgwJ9rPbmm/IJfeg0wBIxqTNEZx2+AxlcFB8kbcQhqdQgaRJnR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726223307; c=relaxed/simple;
	bh=g0SjbxtrMJO64fUZYphm2pNEqSVLNaL0h5RxlOmSR0o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PwVcpBfRcUgsungos9/+YLeio/bb5ZlJlM243C5879cNgD3CHEs5HAre3F3Graf+Te5TlUasY3MRZg8KvdPlC/rULpmhAonRfQk/Vvl8dvNeN1GfDtU4fRLPAakqtqQm/E8bvlzGD8f+jV1Vhbm7YWlEY2HuXWcdoOWd8IUGyNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f+KDZ72J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=csyzP1S9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726223303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlfHzf6XiBChfJPS9GuvmZ1d8n37zsnAfcpjdp0ve9Q=;
	b=f+KDZ72JyURmWxk10fRuAmRxXk02HueY7bSv3Qk4YgC5rgtbgvy8o7bYWIanw0dbAIcMxD
	lnGZyz/GgNG1u5ntclKPaj+wkYLP/kOrekzC2SBbbJqASHz6OJMU7J+SIyLt5U+C2yi2/4
	wHKV5dX8os/Fnx+6WpVrX56EWVN1botrugJKjAZtx5kPLbcqoswcli86/UAopXjBUbVBU4
	J08Ft/Vc9YXJTOqqsgbL58r2Xtsw8cZ/fKyIYnjqAHLZKjECRI0vkBNffyv5Dls/66U58a
	TrZdsTJqKJ4OOVTDDDVC96wVbMmSEMapXfkDNPWNEcQULJpBrCEbeV/IJuLhVQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726223303;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=XlfHzf6XiBChfJPS9GuvmZ1d8n37zsnAfcpjdp0ve9Q=;
	b=csyzP1S9jLFGk5McSFeJ2/MX9OxGfYRLPEe7bDgDzxZqDnB8WjDZQV90MYm4QTk+FJPBnd
	QxtGkPoAnmRgnFAQ==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: John Stultz <jstultz@google.com>, Frederic Weisbecker
 <frederic@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-kernel@vger.kernel.org, netdev@vger.kernel.org, Richard Cochran
 <richardcochran@gmail.com>, Christopher S Hall
 <christopher.s.hall@intel.com>
Subject: Re: [PATCH 00/21] ntp: Rework to prepare support of indenpendent
 PTP clocks
In-Reply-To: <ZuKii1KDGHSXElB6@localhost>
References: <20240911-devel-anna-maria-b4-timers-ptp-ntp-v1-0-2d52f4e13476@linutronix.de>
 <ZuKii1KDGHSXElB6@localhost>
Date: Fri, 13 Sep 2024 12:28:22 +0200
Message-ID: <87bk0rj1a1.fsf@somnus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Miroslav Lichvar <mlichvar@redhat.com> writes:

> On Wed, Sep 11, 2024 at 03:17:36PM +0200, Anna-Maria Behnsen wrote:
>> This problem can be solved by emulating clock_gettime() via the system
>> clock source e.g. TSC on x86. Such emulation requires:
>> 
>> 1. timekeeping mechanism similar to the existing system timekeeping
>> 2. clock steering equivalent to NTP/adjtimex()
>
> I'm trying to understand what independent PTP clocks means here. Is
> the goal to provide virtual PTP clocks running on top of the system
> clocksource (e.g. TSC) similarly to what is currently done for
> physical PTP clocks by writing to /sys/class/ptp/ptp*/n_vclocks,
> expecting the virtual clocks to be synchronized by applications like
> phc2sys?
>
> Or is this more about speeding up the reading of the PHC, where the
> kernel itself would be tracking the offset using one of the PTP
> driver's PTP_SYS_OFFSET operations and emulating a fast-reading PHC?

That's one aspect.

The independant PTP clocks are PTP clocks which are not synchronized
with CLOCK_TAI. They are "standalone". They are used in automation and
automotive setups. They have a grand clock master which is not
synchronized to anything. There are also requirements for redundant
networks where the clocks are not allowed to be synchronized between the
networks to prevent common cause failures.

These clocks are used for TSN and both applications and the network
stack needs to be able to read the time. Going through the file
decriptor based interfaces is slow and not possible in the kernel.

The goal is to provide infrastructure which allows these clocks to be
read via kernel interfaces and clock_gettime(PTPID) by emulating the
clock via the system clocksource (e.g. TSC).

That means they need timekeeping and steering infrastructure, to keep
them in sync with the PHC. It's the identical mechanism to what system
timekeeping and NTP do for the system clocks.

So instead of creating duplicate infrastructure, this aims to reuse the
existing one.

Hope this helps to make it more clear.

Thanks,

        Anna-Maria


