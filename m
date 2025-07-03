Return-Path: <netdev+bounces-203810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 65DECAF748D
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 14:49:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CE5DF16B566
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 12:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FA23274FCB;
	Thu,  3 Jul 2025 12:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nzOPRlPV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rktf6H7n"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5932F29;
	Thu,  3 Jul 2025 12:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751546931; cv=none; b=oEEkW1ruwhY4yVlz5vECEklXhUCMIVXX4AlSChknVsj49ls0kRpj8CybRoWiHCBmORs9wf+EiG0HZfkTM3BlGut8otUBVS0oVLmXQyDjW5OzBPD21qe0T+B/7A8m3Z1t5Ed3zzVtKnsoFv/4qKr5K4v+H/URry50FAOEc+Qzrbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751546931; c=relaxed/simple;
	bh=OUHvmnZpJKhe5oLTPLz2vd8ZBDivUxZPS2UpsRddvW0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GApcRXdrCFsCbKbroneKINQztuP5dfVPPrz9WgkTFKlJwPuTr75g5IObeybmDbSQ6BMzCj/jNnsRu84cvyDvVlCeVuesyNpjEAOu75DcysXr6qQ/uuVcziOp5lF9M8FwB9EPb/ergzT54ZSPQVc/VPvBrExfJy5yd6Npd/KHp3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nzOPRlPV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rktf6H7n; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751546928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtoy6yPzx+lwD2CNFlvJO5ejGFbqqUUABUK8za/Wazw=;
	b=nzOPRlPVFD3f968p46y/sUsHDNHnoo2WpsoHInNEhLveQ6UykPO8kS5Gy56OR5pd9S/Mb+
	iFNMPqNkZbptV9DxBKA35yj+6F9acqefr1YCEhmoP3S1WyhHQKkG/7ooVySRBmSU978R8U
	rbbRFFYlW7BOFv+0shrwQHbBsGkDNQSKlrDidrU4KacD8MTu3s2HBVHWUiNIenNAhvVVRK
	e/JVNDHHAci5b8gWBpClbWUrfgGbFVfghXNCVAC7ecT8YqG1A4BIdrN9RbsDJYBfvtvtBr
	feac738+flaa6ciFnpO45ShHHRPMtlS/oDYP3IGFpkhe4jy+jC9G1JOgxpt09w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751546928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qtoy6yPzx+lwD2CNFlvJO5ejGFbqqUUABUK8za/Wazw=;
	b=rktf6H7nFtixj5gWOogKnF/7IDfcUwWG1P2WDjT3GzRfJ2TOYkIiRFWQ4SaKkeAMS5vqxc
	XHm8BImCEEtZCnDQ==
To: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Cc: netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>, John Stultz
 <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar
 <mlichvar@redhat.com>, Werner Abt <werner.abt@meinberg-usa.com>, David
 Woodhouse <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach
 <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine Tenart
 <atenart@kernel.org>
Subject: Re: [patch V2 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <faca1b8e-bd39-4501-a380-24246a8234d6@redhat.com>
References: <20250701130923.579834908@linutronix.de>
 <faca1b8e-bd39-4501-a380-24246a8234d6@redhat.com>
Date: Thu, 03 Jul 2025 14:48:47 +0200
Message-ID: <87ecuxwic0.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Paolo!

On Thu, Jul 03 2025 at 12:27, Paolo Abeni wrote:
> On 7/1/25 3:26 PM, Thomas Gleixner wrote:
>> Merge logistics if agreed on:
>> 
>>     1) Patch #1 is applied to the tip tree on top of plain v6.16-rc1 and
>>        tagged
>> 
>>     2) That tag is merged into tip:timers/ptp and the temporary CLOCK_AUX
>>        define is removed in a subsequent commit
>> 
>>     3) Network folks merge the tag and apply patches #2 + #3
>> 
>> So the only fallout from this are the extra merges in both trees and the
>> cleanup commit in the tip tree. But that way there are no dependencies and
>> no duplicate commits with different SHAs.
>> 
>> Thoughts?
>
> I'm sorry for the latency here; the plan works for me! I'll wait for the
> tag reference.

No problem. Rome wasn't built in a day either :)

> Could you please drop a notice here when such tag will be available?

Here you go:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ktime-get-clock-ts64-for-ptp

I merged it locally into net-next, applied the PTP patches on top and
verified that the combination with the tip timers/ptp branch, which has
the tag integrated and the workaround removed, creates the expected
working result.

Thanks,

        tglx

