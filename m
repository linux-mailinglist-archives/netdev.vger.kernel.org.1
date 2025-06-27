Return-Path: <netdev+bounces-201972-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1314AEBA96
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D56B1C4370C
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 821F52E88A9;
	Fri, 27 Jun 2025 14:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TfHM5Ljp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aCucV8Th"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCCFF2E8892;
	Fri, 27 Jun 2025 14:57:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751036255; cv=none; b=gQawNBog+mHSsiTH8zKff7GN4NkSRFLQMnoNCMqyFUsG4UnVaPLUxe6aGKr/X1lipC4CksTO+s+pd/Nvk2puJszAR3WhR5hy0v/AS+35GuOr40BSy79yQ7EcbqpgSMuIklO6Eu4AQ47pE1hKbY3QCdPUZ3aYi3PxY6Guhd4IZCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751036255; c=relaxed/simple;
	bh=xZbTmD86sEhU8AI4zrEanIw7Ar7agxZDcHD3nGgxk3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=EYw5ma1lrBj2OW6wbKY8WRfopoBRNSEefh8oFX4YDw48KDePOx6zR0CPXKRfnHFtR6dW+u4hWoixFj8vq15YiHOviX4Eu4FAiJy75M7rOYvuOCaQJzSOOlfjjoMvohsop9JYU+Fubx2XdQuRn1k5wTeZfW9oGusjgxoHqzapxm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TfHM5Ljp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aCucV8Th; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751036252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bQC5mOsy0X3y6YunJaTMnOlKBLNzqK+7WUtDYc4TKI=;
	b=TfHM5Ljpjs5hdt4e98fWyuNUO/Q9pItDM2tujxu3cJP8p2jCdXe+fVyS+UnYvlUn3EuFEV
	FFjtAhlis4mhIHinHpmp+5uN4hrohQ5CmgcEkwii5IkmhQnCbmJukRzcKOo7JfAXB2Twir
	Fwjdz6lDCyeQSklvghCgnRWkO468onWPTDSu6KLyX36rOj6ZXf8ak40LbP6OBkJAPc3Jm9
	+33bFnisCG20yeavoTV0cHXQ8BQ7j2eA/bfENOW1WMiTvRXtDsi5TxNZCMJ3QnWoE7QbYM
	OMVv3HjOS/Rl+5ofXmkw9cUWNzsv4kkM/Mrr1nU/TIWa+yp83vCR8MJjYVmlqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751036252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/bQC5mOsy0X3y6YunJaTMnOlKBLNzqK+7WUtDYc4TKI=;
	b=aCucV8ThJQED3l2MRuvwx0TMAEFtugz4Lzo7dJN8+xJi+QRK//S5Vh4Z5qAVYuRMQOz+/R
	ok2LRwPavTuhfbCQ==
To: John Stultz <jstultz@google.com>
Cc: LKML <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org, Richard
 Cochran <richardcochran@gmail.com>, Christopher Hall
 <christopher.s.hall@intel.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
 Tenart <atenart@kernel.org>
Subject: Re: [patch V3 04/11] timekeeping: Provide time setter for auxiliary
 clocks
In-Reply-To: <87ldpdnu8y.ffs@tglx>
References: <20250625182951.587377878@linutronix.de>
 <20250625183757.995688714@linutronix.de>
 <CANDhNCpu5+ZVxFg0XVU4KYEWnNCbSruPob9dOeF3btxqJ1N70g@mail.gmail.com>
 <87ldpdnu8y.ffs@tglx>
Date: Fri, 27 Jun 2025 16:57:31 +0200
Message-ID: <87ikkhnsf8.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 27 2025 at 16:18, Thomas Gleixner wrote:

> On Thu, Jun 26 2025 at 21:23, John Stultz wrote:
>> On Wed, Jun 25, 2025 at 11:38=E2=80=AFAM Thomas Gleixner <tglx@linutroni=
x.de> wrote:
>>>
>>> Add clock_settime(2) support for auxiliary clocks. The function affects=
 the
>>> AUX offset which is added to the "monotonic" clock readout of these clo=
cks.
>>>
>>> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
>>> ---
>>
>> Minor fretting: I worry a little that the difference here between the
>> default timekeeper where set adjusts the REALTIME offset from
>> MONOTONIC, and here where it directly adjusts "mono" might confuse
>> later readers?
>
> Actually it's not really that different.
>
> In both cases the new offset to the monotonic clock is calculated and
> stored in the relevant tk::offs_* member.
>
> The difference is that the core timekeeper operates on xtime, but for
> simplicity I chose to calculate the resulting tk::offs_aux directly from
> the monotonic base. That's valid with the aux clocks as they don't
> need any of the xtime parts.

Actually using xtime and adjusting it and xtime_to_mono does not work
for those auxiliary clocks because the offset to clock "monotonic" is
allowed to be negative, unless it would result in a overall negative
time readout.

This is required for those clocks because the TSN/PTP zoo out there
especially in automation/automotive uses clockmasters starting at the
epoch for their specialized networks. So if the clockmaster starts up
_after_ the client, then the pile of xtime sanity checks would prevent
setting the clock back to the epoch.

I tried to work around that, but the result was more horrible and
fragile than the current approach with the aux specific offset.

Don't ask :)

Thanks,

        tglx


