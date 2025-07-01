Return-Path: <netdev+bounces-202913-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E678AEFA92
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:30:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 16F0716A7DF
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAC12275110;
	Tue,  1 Jul 2025 13:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A0oQEXq6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5NIw0p6I"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E156267B98;
	Tue,  1 Jul 2025 13:26:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751376420; cv=none; b=CQZ9EdSKM2L0rFFgMQ3QoOswhyGdAJvpUYy5JjY34KO0IOd8075icjaknokNsx5mIhuCvfpXhoCsEGiC0nUVFLAM1B+ggyI8uWGixKMWTdmmrgBakNk1Rpa0GfzeyPVGwM9UGtJlmp3px41m73729u/iZ8yUVYJc3PkrI5ZdpvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751376420; c=relaxed/simple;
	bh=QLhc9pcG+Qb9T747Cx78M2hk7ddHZi2C0MBD7dOL0Ok=;
	h=Message-ID:From:To:Cc:Subject:Date; b=j3eGfG+gWdIcVYfAVjIDiQ6meI2i3OdKvuQvtd7/vsYIi01tf5Hp4OdnDkdkWnijUcPpIBxDZelKCqF+eqRlwz5EqKhtw2RsEnMWaZ4JvFz4h9HiAMAbMUAFRoWVwCP5ytkZgDa+j0zL+YgwWSl5CpCzyylxfDPua6dlZ3WCkTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A0oQEXq6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5NIw0p6I; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <20250701130923.579834908@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751376417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Nkd39a2sf1aF3rWoMJ5uEhDZRMTzM6invRFK1HdX2P4=;
	b=A0oQEXq6uQJeA2t8CEAFE53Q6nnuh6Bhte99CyclkWfn2VULthRiLV2HdtFVGT1RLrKE9V
	CmBAvruRJx0jXuEqiOytFuNyNbJfDHefd2hu5HznySjUNv4/wvoS/sXwJ23Os9o0bhFkbD
	HhyLN1i8HsrYXZUuLNQb5LuzGPWmH8NItB5fftR3Z/BKFcYVqAbjvvr4TY8fN97yJFdGZR
	KyyQyzCjHM7fABY/vH1ju3NSBsMtOlDcG2OtU7bp600S6eSxcuzP3MAh69k4qXJvSzEy2b
	833xEwVS4FSlk+OYApDyU0yo8vs13AqYouuTk4NeaIerg82K6w39aURgIQ8ycw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751376417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc; bh=Nkd39a2sf1aF3rWoMJ5uEhDZRMTzM6invRFK1HdX2P4=;
	b=5NIw0p6IcLnN/fjZhSBxi479NtGJYDlQS0YB70tC3/P0zdD+5RdWDhn7ScewEhlABudw3y
	dCckWBFbY37xAWCg==
From: Thomas Gleixner <tglx@linutronix.de>
To: LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org,
 Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>,
 John Stultz <jstultz@google.com>,
 Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>,
 Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
 Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>,
 Antoine Tenart <atenart@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>
Subject: [patch V2 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
Date: Tue,  1 Jul 2025 15:26:56 +0200 (CEST)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>

This is a follow up to the V1 series, which can be found here:

     https://lore.kernel.org/all/20250626124327.667087805@linutronix.de

to address the merge logistics problem, which I created myself.

Changes vs. V1:

    - Make patch 1, which provides the timestamping function temporarily
      define CLOCK_AUX* if undefined so that it can be merged independently,

    - Add a missing check for CONFIG_POSIX_AUX_CLOCK in the PTP IOCTL

    - Picked up tags

Merge logistics if agreed on:

    1) Patch #1 is applied to the tip tree on top of plain v6.16-rc1 and
       tagged

    2) That tag is merged into tip:timers/ptp and the temporary CLOCK_AUX
       define is removed in a subsequent commit

    3) Network folks merge the tag and apply patches #2 + #3

So the only fallout from this are the extra merges in both trees and the
cleanup commit in the tip tree. But that way there are no dependencies and
no duplicate commits with different SHAs.

Thoughts?

Due to the above constraints there is no branch offered to pull from right
now. Sorry for the inconveniance. Should have thought about that earlier.

Thanks,

	tglx
---
 drivers/ptp/ptp_chardev.c        |   24 +++++++++++++++++++-----
 include/linux/ptp_clock_kernel.h |   34 ++++------------------------------
 include/linux/timekeeping.h      |   10 ++++++++++
 kernel/time/timekeeping.c        |   33 +++++++++++++++++++++++++++++++++
 4 files changed, 66 insertions(+), 35 deletions(-)


