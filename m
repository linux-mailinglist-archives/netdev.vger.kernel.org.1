Return-Path: <netdev+bounces-201961-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 931AFAEB997
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:18:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B57B1645511
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:17:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E622E265D;
	Fri, 27 Jun 2025 14:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JTPcY4Ho";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q3EcjBDw"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFE922E2659;
	Fri, 27 Jun 2025 14:18:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033890; cv=none; b=tCSTBrCrsLARG3b+4NpTNGdJbCJlbqWoaIAoz6iJ/Blm92a6RZqoGQgJYXVMdcoplx5YI19o2LWb0eNOdrJCgBJuoHVoY+zdwDBIbdUI1hbKXYBmqjNpbi/LL+4nMgOyugg/JOAUFtEFZNKq5HCTqq6w1glce5cGhGSVJqUeCwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033890; c=relaxed/simple;
	bh=+pi/wIlcbLNnuX1RBlHCp/Nab1wavZUXPEn3t0yFunw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PWEH241TdVpYusXB5BjcDp4aTdU9bnMfS90R3KjewrAU2J6X863+udK3d+IDXoFQZ6Vnw7pfQXsHwQWkANX3S4D6MEZTPQg0AAD+isH/Nt3nsP3nsAmXjTTB2enDi7wi7VWtlHu73SDhwA5+vsSA2sNwMU2m84giFCglbGJDMmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JTPcY4Ho; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q3EcjBDw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751033886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pi/wIlcbLNnuX1RBlHCp/Nab1wavZUXPEn3t0yFunw=;
	b=JTPcY4HoWZjBfcsbsJvA20ZnzRcsLjqZpqs0Jlsl3cDrD5fEbEdlxzCcLfv+V5H3VIF5Ia
	WJSYgj7fV3v8zsIDuYccFnqV8Lsvj+7zYNTC8ocHNb0y2El6cDfDgSoIDhhb+18yIiMlrV
	MQIFYflQnev9ornTwTrbf02qojHXO5rrdhaBHZkALH+cJIerWy8VPU1lZB0Q7Qtu9XmJCg
	UvyqUwsuc6MRISQxYKe6kQRo2/cBXjdFfdp/co+esDkEoYxgFEQpgxXBeEobAcAp6pduZa
	khGakssZhUgJR4unZsJgwBNpw7SIbi7CHfxCTmstt6pjHZ3TAi4CKseThnKfvQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751033886;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+pi/wIlcbLNnuX1RBlHCp/Nab1wavZUXPEn3t0yFunw=;
	b=q3EcjBDwDSlN5SU0XlMs2o0HMzKupClunf6b0FpPvH0MA5Ck52MaMeWKpP4eEXeeMW4l9B
	3OwavwLkwWlcU/DA==
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach
 <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [patch V3 04/11] timekeeping: Provide time setter for auxiliary
 clocks
In-Reply-To: <CANDhNCpu5+ZVxFg0XVU4KYEWnNCbSruPob9dOeF3btxqJ1N70g@mail.gmail.com>
References: <20250625182951.587377878@linutronix.de>
 <20250625183757.995688714@linutronix.de>
 <CANDhNCpu5+ZVxFg0XVU4KYEWnNCbSruPob9dOeF3btxqJ1N70g@mail.gmail.com>
Date: Fri, 27 Jun 2025 16:18:05 +0200
Message-ID: <87ldpdnu8y.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26 2025 at 21:23, John Stultz wrote:
> On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutronix=
.de> wrote:
>>
>> Add clock_settime(2) support for auxiliary clocks. The function affects =
the
>> AUX offset which is added to the "monotonic" clock readout of these cloc=
ks.
>>
>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>> ---
>
> Minor fretting: I worry a little that the difference here between the
> default timekeeper where set adjusts the REALTIME offset from
> MONOTONIC, and here where it directly adjusts "mono" might confuse
> later readers?

Actually it's not really that different.

In both cases the new offset to the monotonic clock is calculated and
stored in the relevant tk::offs_* member.

The difference is that the core timekeeper operates on xtime, but for
simplicity I chose to calculate the resulting tk::offs_aux directly from
the monotonic base. That's valid with the aux clocks as they don't
need any of the xtime parts.

I added some blurb to it.



