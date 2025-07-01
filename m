Return-Path: <netdev+bounces-202900-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B003BAEF988
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 15:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A4D24E0CDB
	for <lists+netdev@lfdr.de>; Tue,  1 Jul 2025 13:01:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A7264627;
	Tue,  1 Jul 2025 13:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gmPLdk/O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WxUo7Zx/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663221487E9;
	Tue,  1 Jul 2025 13:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751374861; cv=none; b=iP1+k0Y6KU7yzYHtgO7YdPwR7oH+KT2hKiWy323OWuBdj/zFDcGEA+PZt+8zL8DOcy8c689hu1sp5LMy7zNR1FVHXyUcXmTDL1wC5pVRTsn7qMt/Tlun6PdYVOcoQ7civQ+jH8x2yNo8CvsdzzJGXVq0WZU+puhmZBiAtZ4sv6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751374861; c=relaxed/simple;
	bh=0xEo39UYir8VKYvKmSgF6qdDFKOYaTcqdh87szu1JXM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qTnRasj/OmwW3bCxhUL79b4XaBFmSWFRmZnK28NVJRWRujYpFScKWiLsY3l/5Il8DRBZTx1M4RnzaBeEPUQzGikMRyyFPrKwATkLElU2bA9j2ai+34C8SV38tit6pgSeCTCgYQ2/IBxGzfj6JB4X8NY1oKM2z2nzj6vvCqBN7qg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gmPLdk/O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WxUo7Zx/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751374857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvDxm3AAf2lx7IpXIWXQXvmn9EsYxBzEGSE1FPW2Zk=;
	b=gmPLdk/O8Riwcbqrmk61cvhCIuZimwcLa0VvVMoNOpY/7tZbRz10kQwuHTRkf58BQl8tSf
	L1+EGPFCvzLtMJY2Zz57Gy32m6HVGuoEPlQEhJzFuLJyj+M7OQBzLLoiKO69Z4bCPUXD4r
	ospDaqL988WKn8oru8PXZsP49IpmgrhTVKxDoryUulLUwYkOKZyh07P87ASAc3ikCngCpq
	tr5VBSeP4OMDznPt/KxwSvCxRRlVtfME7fvvd0PFGaZJ8lx/7nbZ8YSEOZnDZihmgqCHWw
	OgujMli+wPV2ouC5QO/lsYYmZspxkrsXs2oZzoDqJTr3O/WQpKZP0/nWcxXFLw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751374857;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=FlvDxm3AAf2lx7IpXIWXQXvmn9EsYxBzEGSE1FPW2Zk=;
	b=WxUo7Zx/cQ6ItR0BYa1GCORtan58Jzu2mpQTU7vlL0vwkbbuX3NgcFCqNjw2s+kqo4SszN
	t3eAcv2CDorEHbAg==
To: LKML <linux-kernel@vger.kernel.org>
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
Subject: Re: [patch 3/3] ptp: Enable auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <20250626131708.544227586@linutronix.de>
References: <20250626124327.667087805@linutronix.de>
 <20250626131708.544227586@linutronix.de>
Date: Tue, 01 Jul 2025 15:00:56 +0200
Message-ID: <87tt3wkquv.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 15:27, Thomas Gleixner wrote:
> +	switch (extoff->clockid) {
> +	case CLOCK_REALTIME:
> +	case CLOCK_MONOTONIC:
> +	case CLOCK_MONOTONIC_RAW:
> +	case CLOCK_AUX ... CLOCK_AUX_LAST:
> +		break;

While trying to solve the merge logistics problem I noticed that this
should be:

	switch (extoff->clockid) {
	case CLOCK_REALTIME:
	case CLOCK_MONOTONIC:
	case CLOCK_MONOTONIC_RAW:
        	break;
	case CLOCK_AUX ... CLOCK_AUX_LAST:
        	if (IS_ENABLED(CONFIG_POSIX_AUX_CLOCKS))
			break;
		fallthrough;

obviously as there is no point in going all the way down into the time
stamping code to figure out that this is disabled.

I blame it all on the heat wave of course :)

