Return-Path: <netdev+bounces-137903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF0E79AB0E9
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 16:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5123B1F240E0
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 14:32:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E940C19E97F;
	Tue, 22 Oct 2024 14:31:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qq34XOCz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pKfWqgqh"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4761A19D060;
	Tue, 22 Oct 2024 14:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729607497; cv=none; b=CmKLtD5i5CZUDXcAYBIv0Jp2Ax8eok7BzkWob+yb4HY7hdGwIAc6gXxIyUXuIMPaievkk83EeNSjTZAzQud0acIkDZSoT4doo2i1bAuEoMw7Ocs5APyvewQgwdj98ChvO13Y4GSvQAbQgVjHUT0VDfcjD3l2F2FitOEh13kwadc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729607497; c=relaxed/simple;
	bh=LpgT8Yd7zrkaCPtkZnHUcp+Mj4CWRueHn/5O6SrjW3o=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:MIME-Version:
	 Content-Type; b=BSKUcyN7TEGDqyfD1k+7hNBero27+A8plYknLgk2Otct4Jm4BlmXAowWr3fWmNZGRz3Yp/8wseHNL+Z/wYmD3J4wTytvF5syTGtICnqSHAP/LIJPMnk7iW1j8pt4IU99CwZ79W7iRPEWmoPZIrS/nIymsYhbZCgPj8+2Sduw0L4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qq34XOCz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pKfWqgqh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Anna-Maria Behnsen <anna-maria@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729607494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=I9+4TXaziuIvZZF1dq0RG29aOHytEa0AUdL0KSv7OOc=;
	b=qq34XOCzWRsOQx80barfal50qwKN1CTLM7/miQyL+TNGjJNulre+RySeM0Jk9+n8s6thDq
	h6ldicKpQp5TD/ccuYu4j88aqowb0flw/hifRKvYgMGKzpjvBMVyJDZ/vzDrL3tTLEibxf
	h071JeV5T1lI7tZF6GwVTjGkNAKdU9REjZr1WBUIicYyKajXaA9KCInNn2rJ+u9ckl6kR6
	O4HeyeeBGkN/n6Ux6FOpGOEC4HXUJPs9upf8MnFiOMwiTlFHB43UxKyTTIzzqTeosp4B9p
	ZPfu2jeFEg59C9NVtpRvSVl5II2cudF8cTRPhHWKdBke0YbaFUUvlWxAjuG66A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729607494;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to; bh=I9+4TXaziuIvZZF1dq0RG29aOHytEa0AUdL0KSv7OOc=;
	b=pKfWqgqhtCfWd2p695IUzbtSyYIbddIxypBKi87GgP5I9Tc2arlh+KUBMdNXUrI/9l2PZH
	fNO/zMVoeBsaIhCA==
To: Pavel Machek <pavel@ucw.cz>, Thomas Gleixner <tglx@linutronix.de>, Greg
 KH <greg@kroah.com>
Cc: Jakub Kicinski <kuba@kernel.org>, Jinjie Ruan <ruanjinjie@huawei.com>,
 bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 pabeni@redhat.com, frederic@kernel.org, richardcochran@gmail.com,
 johnstul@us.ibm.com, UNGLinuxDriver@microchip.com, jstultz@google.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 RESEND 1/2] posix-clock: Fix missing timespec64 check
 in pc_clock_settime()
In-Reply-To: <ZxeLMu1Hy2VCqzJ6@duo.ucw.cz>
Date: Tue, 22 Oct 2024 16:31:33 +0200
Message-ID: <87ttd45hve.fsf@somnus>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pavel Machek <pavel@ucw.cz> writes:

> Hi!
>
>> >> > I'm guessing we can push this into 6.12-rc and the other patch into
>> >> > net-next. I'll toss it into net on Monday unless someone objects.  
>> >> 
>> >> Can you folks please at least wait until the maintainers of the code in
>> >> question had a look ?
>> >
>> > You are literally quoting the text where I say I will wait 3 more days.
>> > Unfortunately "until the maintainers respond" leads to waiting forever
>> > 50% of the time, and even when we cap at 3 working days we have 300
>> > patches in the queue (292 right now, and I already spent 2 hours
>> > reviewing today). Hope you understand.
>> 
>> I understand very well, but _I_ spent the time to review the earlier
>> variants of these patches and to debate with the submitter up to rev
>> 5.
>> 
>> Now you go and apply a patch to a subsystem you do not even maintain just
>> because I did not have the bandwidth to look at it within the time
>> limit you defined? Seriously?
>> 
>> This problem is there for years, so a few days +/- are absolutely not
>> relevant.
>> 
>> > Sorry if we applied too early, please review, I'll revert if it's no
>> > good.
>
> It is no good :-( and it is now in stable.
>
> It needs to goto out in the error case, to permit cleanups.

The check needs to be done before taking the lock. There is already a
patch around which solves it:

https://lore.kernel.org/r/20241018100748.706462-1-ruanjinjie@huawei.com/

Thanks,

	Anna-Maria


