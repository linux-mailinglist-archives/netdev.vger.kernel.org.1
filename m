Return-Path: <netdev+bounces-190345-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 912FEAB6629
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:38:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29CE0467657
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:38:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C778221280;
	Wed, 14 May 2025 08:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2bx1nADR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wc8bpNEn"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81FB21CC41;
	Wed, 14 May 2025 08:37:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747211881; cv=none; b=WxSBQhzo7jJWErLMWdT2j7nrgsndPy6Iq+T5RyON0uykFfMJpIF7RHLaxAfJfi9qX2DDyANdktm3aFisXodOks9RVmyxGaIjOsP9q03Nw9sV60LZTVNPvKUgcjyrX19UJBS7p+itP+GXpytU46ip0UZGo5MJi23JYJnvVcDGr1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747211881; c=relaxed/simple;
	bh=+5rCn2iJM3/+15GQqNgcVtfUNJP+2pYhlwz8Biexyn4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EI9B7VYGaA3+v/Zs3G1Lb+aKpzHHepKvp81ImeSsv+3cn4+y/HrakDK2GRmh6HQZWRCty/1NwD2b0YB8SYX5d+rXWugmYr64Uim/mjI8mtuymJd5G5IoQKke7qXirhPSgalLhOusBB4hf/YEh8qi3OC9dst5xgfEoCkRoGa7Jx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2bx1nADR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wc8bpNEn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747211877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6B1pqh0lgQxFasnFPopgGBCyTtvPXq3g8C+FwEpDug=;
	b=2bx1nADRERLw1c5x6CjWkGVRPDkSi9fry8i+eb6LaHbEvMDSfZawA+gj+fDfSusNHKG9jo
	Ubye+jZ+YzhTQTbuTifmatu1fJ0OU34CEMQzemMfLtuiwHAqgq24CoS78LguCa4LMeoeDx
	3hvnN9BO3RsxHkx2dEQ2Tlit6wTCVZTJWHCG6gvBBa+91Ol3WeDA7D7J3tLIoMMg7OfvGJ
	XoTBi5qZEO0RcUR6urKYEsRroHkdX7PiCsGfAJM9EwC4uBmQrRhP8GxwfakMrDXFcTyjci
	yazdWqe9El/+gx30qS9AYqe96RNw+a4dvMJOPPC46Q0PhaDWAIcKjCUc3zAarA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747211877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=C6B1pqh0lgQxFasnFPopgGBCyTtvPXq3g8C+FwEpDug=;
	b=wc8bpNEncnXMTG81t448Buj3vH7sV+PSILhZl3tiEQCxKd76sTF6oDSTK9w3IhML/WQNSE
	lASdDtqQ04MN3ZBw==
To: Antoine Tenart <atenart@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, David Zage <david.zage@intel.com>, John
 Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach
 <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Alex Gieringer
 <gieri@linutronix.de>
Subject: Re: [patch 26/26] timekeeping: Provide interface to control
 independent PTP clocks
In-Reply-To: <htnwor46q3435pddkafm7flmx4m2bs4553gq3mx4jzevtfgg2l@h4abniqo4dzf>
References: <20250513144615.252881431@linutronix.de>
 <20250513145138.212062332@linutronix.de>
 <htnwor46q3435pddkafm7flmx4m2bs4553gq3mx4jzevtfgg2l@h4abniqo4dzf>
Date: Wed, 14 May 2025 10:37:57 +0200
Message-ID: <874ixnk2oq.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 14 2025 at 10:07, Antoine Tenart wrote:
> On Tue, May 13, 2025 at 05:13:44PM +0200, Thomas Gleixner wrote:
>> +++ b/Documentation/ABI/stable/sysfs-kernel-time-ptp
>> @@ -0,0 +1,6 @@
>> +What:		/sys/kernel/time/ptp/<ID>/enable
>
> The path added below is /sys/kernel/time/ptp_clocks/<ID>/enable.

Ooops.

