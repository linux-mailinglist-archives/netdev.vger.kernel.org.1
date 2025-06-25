Return-Path: <netdev+bounces-201072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EA79AE7F8F
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 12:35:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 44EDD5A40E8
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 10:35:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1CD22D542D;
	Wed, 25 Jun 2025 10:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="C7nKcv10";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M1lX4h+W"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CF022D3A8C;
	Wed, 25 Jun 2025 10:33:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750847635; cv=none; b=mOTDthLvwiwNHVuC/jEiaQeS0mqCYhDS2YqwXCUj8b1T5wDYMmuuXXN5dg22+bYK+OzOhhf/ohJ+MK7b9qrbxZwWGu5Lvn+RVZP2iCKCsm+c2wELt+UF3ls4wEdLTiQMs1bcMYVoapCM92w9gAPeolCKA6RcXAtqsn004bQsRrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750847635; c=relaxed/simple;
	bh=u2JL3FczzXcYtFQ+pSya9xx54ScgFCYZ3yXRPtod8d8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CyulyUXJ4NjLqP5hARtQIRJDvyc6PadyoVV7TiJjPK13Z4H11v65ZIIivW0cKVfiqjR1yuHNFkWUK8EQQoGqf6O2lIebZ5kM1LGdT+3I1vtVLsSIigUc8fAV6N4xEeoDP+wlYU6CnZ68arW96nWt5MT+egJqrVu2YZdD2Zna+F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=C7nKcv10; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M1lX4h+W; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1750847630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qS6j5Ud4Qg98bvTPqfEkTAjFzlZLvEpnPb7sBn/6J2s=;
	b=C7nKcv10PjDtpZWxlW9pXi3qXgMwERA0tp2jp8bAUfPULc59b16dAsTVfszFSpVMPW0O+L
	raoe3dlxusFPIq7J9QlFkruKRA52JarS1EHM4p1wHxjR7tY7Mgd6oB/w8TFBb0voUcQ7Ke
	80IEWbb82LsBNDv2LiZd8MjSKTLPRRLKhzJDNe59g8kTBdZevRi2BY1ZzmYpCIKv4uaxoH
	mko4vwSABGGo6ntRAt9SmoKWXU6DA/hBprR8T1fFaTMRSCN9Vvkdnxlrw5wSdpuHe2w1wH
	QJRZMYMdDn9GJgs/gdJGsVHNQoS/R3YXadX+YUUAUPtEL8KmHcQYjFWQxWFl1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1750847630;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qS6j5Ud4Qg98bvTPqfEkTAjFzlZLvEpnPb7sBn/6J2s=;
	b=M1lX4h+WkCPuP3pfhTegwN2nuqTnB/U/ZQTpdRI1p1XTEg3ctbLdvLz5eDWTVq2OdMwDZa
	ijiPqw+ctrXqWYCQ==
To: Jakub Kicinski <kuba@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Richard Cochran
 <richardcochran@gmail.com>, netdev@vger.kernel.org
Subject: Re: [patch 13/13] ptp: Convert ptp_open/read() to __free()
In-Reply-To: <20250624093600.17c655a8@kernel.org>
References: <20250620130144.351492917@linutronix.de>
 <20250620131944.533741574@linutronix.de>
 <20250624093600.17c655a8@kernel.org>
Date: Wed, 25 Jun 2025 12:33:50 +0200
Message-ID: <87cyasaz5d.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jun 24 2025 at 09:36, Jakub Kicinski wrote:
> On Fri, 20 Jun 2025 15:24:50 +0200 (CEST) Thomas Gleixner wrote:
>> Get rid of the kfree() and goto maze and just return error codes directly.
>
> Maybe just skip this patch?  FWIW we prefer not to use __free()
> within networking code.  But this is as much time as networking
> so up to you.
>
>   Using device-managed and cleanup.h constructs
>   ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
>    [...]
>
>   Low level cleanup constructs (such as ``__free()``) can be used when building
>   APIs and helpers, especially scoped iterators. However, direct use of
>   ``__free()`` within networking core and drivers is discouraged.
>   Similar guidance applies to declaring variables mid-function.

Interesting decision, unfortunately it lacks a rationale in that
documentation.

I reworked the patch without the __free(), which still cleans up the mix
of goto exit and return ERRCODE inconsistencies.

Let me send out V3 with that and network/ptp people can still decided to
ignore it :)

Thanks,

        tglx



