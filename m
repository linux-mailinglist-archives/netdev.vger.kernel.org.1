Return-Path: <netdev+bounces-166222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B22AA35116
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 23:17:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BB5643AC4E5
	for <lists+netdev@lfdr.de>; Thu, 13 Feb 2025 22:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E9B32054E1;
	Thu, 13 Feb 2025 22:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uesIjA04";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jbQ/8OFV"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8ED744C7C
	for <netdev@vger.kernel.org>; Thu, 13 Feb 2025 22:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739485042; cv=none; b=JVnX76tqbxrB3/lo//pxoK+/cJV4Ni2xzXqo5YWGU4A+r0AX8AVrqSOgzOCGEijGmzQqEOAzgYqE+GyOjs7CLZRwgJ6HpL1V9qWAIE1qsq8hvlGGmhNOkLBfLZPgWybee0ETK6coFICVrTB1uZpJ54D/YvICpA2X7oTCo8EJWkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739485042; c=relaxed/simple;
	bh=o8DynuN+MeIjdBJFtNPB+k11e0TUSWi9GTCZk52JxU8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HMxA6R3EwR/gBKI8SSd43CeZX7e4vhBKT4nVrbkOGGK4z9Fiu1ahSoRw6DRmeyoVF+I63WzAe0d4Vlof7jVeSCJUtxccpjLgbxwxRUrml8VnOnGZE/x/QfbbZouV18Dsb1dvDt94C60ANQ/IU4XnYSaq97nXXbuX0Uev3wKnXO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uesIjA04; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jbQ/8OFV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739485038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+otAH8znQRXuiKFQuQB5/RWAVkATidkhO7F2Hl+xUHY=;
	b=uesIjA04fFzLbbyZf9eFLLXn0i3bxNZbeXvT8KqDRE9dxSNt4yeHBWPDLEfI2s9pH/VWnI
	WuH3dNJ3vydLniilPjZcWl4WEZ3dWd75DcxcW6W6ZEJ0UKdoWi1pA7b5Fj92dGnV71Q4Hl
	qQoG+DK1yfefEEFEUd+DgObU+ozCla5Y9xcwh0iBOufgxevfD2e5v0kvdWwnjRyWrrfgsh
	jnO0Wll7hgTdxKcCh+6HwsaGCggwWZ/aUka/ibsNtntc2Rz7umYoODyC3nn7SqUytmsQ9i
	QRb+y0Q4ad/Oa1kZrKjMhJUuYoeq5D/NmygNw3nhQ4aVI4v0lavVgwBy6l6zYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739485038;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+otAH8znQRXuiKFQuQB5/RWAVkATidkhO7F2Hl+xUHY=;
	b=jbQ/8OFVUKxJvGDo3wWLAukpjRLUmBRLp+vC4Cytb70/tG+8vCA1YS+gOy5QR7yzV6wRSF
	2tjseLkkWLwoT/Cw==
To: Paolo Abeni <pabeni@redhat.com>, Wojtek Wasko <wwasko@nvidia.com>,
 netdev@vger.kernel.org
Cc: richardcochran@gmail.com, vadim.fedorenko@linux.dev, kuba@kernel.org,
 horms@kernel.org, Anna-Maria Behnsen <anna-maria@linutronix.de>, Frederic
 Weisbecker <frederic@kernel.org>
Subject: Re: [PATCH net-next v2 1/3] posix clocks: Store file pointer in
 clock context
In-Reply-To: <a360c048-96f3-486e-a097-e3456a6243a8@redhat.com>
References: <20250211150913.772545-1-wwasko@nvidia.com>
 <20250211150913.772545-2-wwasko@nvidia.com>
 <a360c048-96f3-486e-a097-e3456a6243a8@redhat.com>
Date: Thu, 13 Feb 2025 23:17:18 +0100
Message-ID: <87msepjxqp.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Feb 13 2025 at 12:37, Paolo Abeni wrote:
> Posix clock maintainers have not being CC-ed, adding them.

Tx!

> $Subject: posix clocks: Store file pointer in clock context

s/posix_clocks:/posix-clock:/

s/clock context/struct posix_clock_context/

>> Dynamic clocks (e.g. PTP clocks) need access to the permissions with
>> which the clock was opened to enforce proper access control.
>> 
>> Native POSIX clocks have access to this information via
>> posix_clock_desc. However, it is not accessible from the implementation
>> of dynamic clocks.

>> Add struct file* to POSIX clock context for access from dynamic
>> clocks.

What is a native posix clock? posix_clock_desc is used in the context of
dynamic posix clocks, no?

I assume this wants to say:

 "The file descriptor based sys_clock_*() operations of dynamic posix
  clocks have access to the file pointer and implement permission checks
  in the generic code before invoking the relevant PTP clock callback.

  The character device operations (open, read, poll, ioctl) do not have
  a generic permission control and the PTP clock callbacks have no
  access to the file pointer to implement them.

  Extend struct posix_clock_context with a struct file pointer and
  initialize it in posix_clock_open(), so that all PTP clock callbacks
  can access it.

Or something like that, right?
 
>> @@ -95,10 +95,13 @@ struct posix_clock {
>>   * struct posix_clock_context - represents clock file operations context
>>   *
>>   * @clk:              Pointer to the clock
>> + * @fp:               Pointer to the file used for opening the clock
>>   * @private_clkdata:  Pointer to user data
>>   *
>>   * Drivers should use struct posix_clock_context during specific character
>> - * device file operation methods to access the posix clock.
>> + * device file operation methods to access the posix clock. In particular,
>> + * the file pointer can be used to verify correct access mode for custom
>> + * ioctl calls.

s/custom ioctl calls/ioctl() calls/

Other than that this looks sane.

Thanks,

        tglx

