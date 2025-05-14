Return-Path: <netdev+bounces-190351-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 46AF2AB668E
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 10:54:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28D947B05C0
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 08:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E4BD221F27;
	Wed, 14 May 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="geX9DKyC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="76FbdPpm"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67A6E221F21;
	Wed, 14 May 2025 08:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747212876; cv=none; b=gVf6Tbna2GnqxRxNpOVMjkduDrfu/9ue9+Mr7Mt/HoZ5+oVlvO/AxGNG3IsLJivwbcDOIoE9/ujVjPSJi7sLkR75wTPmA52LAeeSfzUrqd19CJX4jFbnYkrAjygn2h6zRkNtpw/HnMForhjy7d5KYvZ8oh7TJqpY4u7moSaRyYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747212876; c=relaxed/simple;
	bh=NSB3KYpYuZwE5geG5kldlOXmJgRY/zvHKfDYIujp2c0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iAwOI32qPtflvVMqCUDkmo93XHslHDrlwAs36xe7hztO420GYniBik/NdIRwo/B9xk5QIekoT1xnqLTKneoLWHgSzZkYQjAIRYGWWxLt57Zoc0WzfpkuBIKw9wN1oqasKwwmCZOIqvVMtk3e/6n9YeGhut6ognrWIorWyhH18eI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=geX9DKyC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=76FbdPpm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747212873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dR0nfxpeD75uPlrjbS3tiAFIhXTeUmWW74aUM3I0kug=;
	b=geX9DKyCf7fqXREn5zPWbkALfbNRagl//Y6J6TuCBDhHCW915C3FL/nPfc8QCt/AmzaXAl
	hbehstWaTavr5kAqtygUb6UZkv3oH5QuySfwFMp4xojhZ9esyerhPLFmVpeqS1psvIGRcD
	+Amn0rOvr4uf+6MHGsmuRjq4MF1URIYlUDKHTnyrNAqBqCJ8NtRemJcHH504gQi9432Fpg
	sTviWQjkhdxfWU3xTSVEn1wm7DhxPAJnDK3cfct6zGItUUr6VQfsflxfSg39c9pr0L6kqC
	/2d40uUr7sqQM8jmHjle0Yy/XlszOJ+R+CauRPwHGtXY6TcSDg8iVtH0v6lpAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747212873;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dR0nfxpeD75uPlrjbS3tiAFIhXTeUmWW74aUM3I0kug=;
	b=76FbdPpmfQRFgytAgOIJ4zOF2NdKYISUCWzG/cKWpCUHfvON6wwr5dbtHSjHcAZ6yCFQkJ
	p6YHQSyIpgjK3xDw==
To: Miroslav Lichvar <mlichvar@redhat.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, David Zage <david.zage@intel.com>, John
 Stultz <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Werner Abt
 <werner.abt@meinberg-usa.com>, David Woodhouse <dwmw2@infradead.org>,
 Stephen Boyd <sboyd@kernel.org>, Thomas =?utf-8?Q?Wei=C3=9Fschuh?=
 <thomas.weissschuh@linutronix.de>, Kurt Kanzenbach <kurt@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, Alex Gieringer <gieri@linutronix.de>
Subject: Re: [patch 00/26] timekeeping: Provide support for independent PTP
 timekeepers
In-Reply-To: <aCRCe8STiX03WcxU@localhost>
References: <20250513144615.252881431@linutronix.de>
 <aCRCe8STiX03WcxU@localhost>
Date: Wed, 14 May 2025 10:54:33 +0200
Message-ID: <871psrk1x2.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Wed, May 14 2025 at 09:12, Miroslav Lichvar wrote:
> On Tue, May 13, 2025 at 05:12:54PM +0200, Thomas Gleixner wrote:
>> This series addresses the timekeeping part by utilizing the existing
>> timekeeping and NTP infrastructure, which has been prepared for
>> multi-instance in recent kernels.
>
> This looks very interesting. I ran some quick tests and it seems to
> work as expected from the user space point of view. I can enable the
> clock and synchronize it to a PTP HW clock or the system REALTIME
> clock. ADJ_TICK works too.

Cool.

> To get accuracy and stability comparable to CLOCK_REALTIME, there will
> need to be some support for cross timestamping against CLOCK_REALTIME
> and/or PTP HW clocks, e.g. a variant of the PTP_SYS_OFFSET_PRECISE and
> PTP_SYS_OFFSET_EXTENDED ioctls where the target clock can be selected.

Yes, that's required, but for that to implement we need the core muck
first :)

> The "PTP" naming of these new clocks doesn't seem right to me though
> and I suspect it would just create more confusion. I don't see
> anything specific to PTP here. There is no timestamping of network
> packets, no /dev/ptp device, no PTP ioctls. To me they look like
> secondary or auxiliary system realtime clocks. I propose to rename
> them from CLOCK_PTP0-7 to CLOCK_REALTIME2-9, CLOCK_AUXILIARY0-7, or
> CLOCK_AUX0-7.

CLOCK_REALTIME2-9 would be weird as those clocks have not necessarily a
relationship to CLOCK_REALTIME. They can have a seperate resulting
frequency and starting point when they are soleley used for application
specific purposes within a network (think automation, automotive, audio
etc.).

CLOCK_AUX0-7 sounds really good to me and makes sense. I picked PTP
because that's where I was coming from. I'll rework that accordingly and
make the config enablement independent of PTP as well:

config POSIX_CLOCKS_AUX
       bool "Enable auxiliary POSIX clocks" if POSIX_TIMERS
       help
            Add blurb

and PTP can eventually select it (or not). Something like that.

Thanks,

        tglx

