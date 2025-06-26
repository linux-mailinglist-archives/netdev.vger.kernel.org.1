Return-Path: <netdev+bounces-201668-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 16487AEA579
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 20:36:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D57B31C4380E
	for <lists+netdev@lfdr.de>; Thu, 26 Jun 2025 18:36:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A320FABC;
	Thu, 26 Jun 2025 18:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JuNTDdqY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YaEmGzTG"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D58A1C4A24;
	Thu, 26 Jun 2025 18:36:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750962971; cv=none; b=AdGE65NXDenMpqJNgezbtxzjIOPbhZuiLOdNz7b9dXa/PsfF5QuU3IwAAGs5eNFj8DeLBvWl5X4zctGBqa4ySUedm5QGUJEbvX6ruygc5Nd+MwWSQxBWbgMKpemvYvi9hpPBgZjbd/sCgYIeBScXD00ZjLHqzEiAC5o5Qtrs5Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750962971; c=relaxed/simple;
	bh=l+PpKd/gZBCb6mKDxZICFdoM91ReaiUuWZSvIo7vy7c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iPiukQPYk5SIv+eBrwP17Dm31q58D8pFouYHM8LMdm7Nr4vGUiJWrGks35ZYJad/nfwUo910xT2rFCH77btkss6/nUV9yu32xuP1up+rdUYzzkea6toS5KA+KJZW53Xem4bC52vAaadGFg+ntLGAaHyARaeW2t8HUC/5E28kRCI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JuNTDdqY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YaEmGzTG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750962968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFa2FfI29GyRJRoLkrA9c0mHIbh5kx7UGDwLuoXYduk=;
	b=JuNTDdqYrgY/8TQVyOvUsXkagwSEIIrK9ptb+bi6HW2v/x7gWPOH8PdyqHzMVwNpbDWttv
	DVJrXDW8YEq4HHBwIWIkDKGHFYnmWrw7u9fNnny6jubX9mdlqJMuzhBDEPo5I9EP+F6Soa
	jQdDAsWsiLvAopEoflr0OkJMxftieHYIiEKcYGQSKfB7U3YedsgmxDfQ4vbxmWQO+3jZlq
	L0Di0UhEoBw9IcAdyJNd3My/92dhUGgaAOsHs0HFw6lj+oVrcue1HVZ1tXvLvUfERVAsb1
	6vaym8XdlmkEI32AOasjFpGWIgo3R6nDAA8BwYFpskwfga502cRBTvp60afv0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750962968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RFa2FfI29GyRJRoLkrA9c0mHIbh5kx7UGDwLuoXYduk=;
	b=YaEmGzTGO/xrrsyIWqlRvsQakR7gjjE+IcoLG/DFmhwrdEUJRIBuIL9JRzT/zJNNoI4qI+
	WrslAPKd8kDVwTCw==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, John Stultz <jstultz@google.com>, Frederic
 Weisbecker <frederic@kernel.org>, Anna-Maria Behnsen
 <anna-maria@linutronix.de>, Werner Abt <werner.abt@meinberg-usa.com>,
 David Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>,
 Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach
 <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [patch 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <aF1e40rkAO5mOFBZ@localhost>
References: <20250626124327.667087805@linutronix.de>
 <aF1e40rkAO5mOFBZ@localhost>
Date: Thu, 26 Jun 2025 20:36:06 +0200
Message-ID: <87y0tepcyx.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 16:53, Miroslav Lichvar wrote:
> On Thu, Jun 26, 2025 at 03:27:28PM +0200, Thomas Gleixner wrote:
>> This is obviously incomplete as the user space steering daemon needs to be
>> able to correlate timestamps from these auxiliary clocks with the
>> associated PTP device timestamp. The PTP_SYS_OFFSET_EXTENDED IOCTL command
>> already supports to select clock IDs for pre and post hardware timestamps,
>> so the first step for correlation is to extend that IOCTL to allow
>> selecting auxiliary clocks.
>
>> Miroslav: This branch should enable you to test the actual steering via a
>> 	  PTP device which has PTP_SYS_OFFSET_EXTENDED support in the driver.
>
> Nice! I ran few quick tests and it seems to be working great. The
> observed delay and stability with an AUX clock synchronized to a PHC
> seems to be the same as with CLOCK_REALTIME.

Thank you for taking the time!

> Are there any plans to enable software timestamping of packets by
> AUX clocks?

I'm not aware of any plans or efforts so far, but obviously that'd be
the next logical step.

> That would allow an NTP/PTP instance using SW timestamps
> to be fully isolated from the adjustments of the CLOCK_REALTIME clock,
> e.g. to run an independent NTP/PTP server in a container. This might
> be tricky as the skb would likely need to contain the MONOTONIC_RAW
> timestamp to be converted later when it gets to a socket, so some
> history of adjustments of each clock would need to be saved and
> reapplied to the raw timestamp.

Either that or you could go and implement some BPF magic to take a
timestamp with a particular clock ID based on the packet type. But what
do I know? That's something the network wizards needs to figure out.

Thanks,

        tglx

