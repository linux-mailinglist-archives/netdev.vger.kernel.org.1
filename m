Return-Path: <netdev+bounces-203230-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C10CFAF0DAD
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 10:20:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1EA921C25073
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE66B23184A;
	Wed,  2 Jul 2025 08:20:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F+7dgAk6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QFzUn/9T"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3101E5B6D;
	Wed,  2 Jul 2025 08:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751444403; cv=none; b=eKx3x3V3ZuSlt2KLc26B9i3qlbSPU4MrTEkhrMRiYdt7okY8ESE2Uj3NMbLnEfguon3k4bLdF4pur/fg7tFjPHRNG4hKtMnWQGsVhOJ6WXoKszrteUl+BR+mD8d+m70U5XclEG7JYPwW9Zp+Ieadb9VJ4060jQEzkSG9BS8WrWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751444403; c=relaxed/simple;
	bh=EV5QXVXGfpdTlb5VRL12T06rS5uWOt/aq32Twib2cQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pmnFUcVdNfeJyIVOEPGHEgMGx9QG0XOHBNeM/1/Hrw4FYXUblspp8I0u1++jsKLg0Z5JsrrvRhjflzrEGgeLLL9Hw/tGK95lG63O78z3Axcxz109fz/fDJ3NTJBF5CzNxfF3rdK4qrGEhoOKfzcQPS4GuYzeiAOXEnXn2J0vnFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F+7dgAk6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QFzUn/9T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751444393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4FJzELuFODfgNSIV4TeKXhIkb92UUd/Tq2J9QNGF0c=;
	b=F+7dgAk6GRhsd2MLHjZzWW+BpwnF64ETph8aObq+x4HTeZsVb387HkShAThQx8ZQWHnUC+
	OQ/3BNgJyCDI90VehXcJSTGyb8q2RlwPz3EAZo+9E2+IgkQNcl7UUdOfzQQCdK0sPGqUz3
	tXhJkHlMYP+8bf5KAZsi9BtR4ttbOivYtV17SDcpG3wV1ZLKV8k4sB5ZZ5VCzLoJ4/tCs/
	tBhoq6pnodwhrCG3KSOzFE1djxyEdsXN29n2qoUfrPyI+JOxTc0z14IToOArNv4cwJWN0A
	/xVZ9QdfAIUwwJSZm1aUR8dDw8wN4TPQ+S1xL9Xk+MKtvuRd1JBb27MQL1yW6A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751444393;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A4FJzELuFODfgNSIV4TeKXhIkb92UUd/Tq2J9QNGF0c=;
	b=QFzUn/9TpSuNvKEd7a3KsP/ilF15hyXB5HX7FkcatY2xeyMe1My/bNl2rMnzM/ZrNRdNkR
	CPUnZXWmTu5ceRAQ==
To: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 netdev@vger.kernel.org, Richard Cochran <richardcochran@gmail.com>,
 Christopher Hall <christopher.s.hall@intel.com>, John Stultz
 <jstultz@google.com>, Frederic Weisbecker <frederic@kernel.org>,
 Anna-Maria
 Behnsen <anna-maria@linutronix.de>, Miroslav Lichvar <mlichvar@redhat.com>,
 Werner Abt <werner.abt@meinberg-usa.com>, David Woodhouse
 <dwmw2@infradead.org>, Stephen Boyd <sboyd@kernel.org>, Thomas
 =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>, Kurt
 Kanzenbach <kurt@linutronix.de>, Nam Cao <namcao@linutronix.de>, Antoine
 Tenart <atenart@kernel.org>
Subject: Re: [patch 0/3] ptp: Provide support for auxiliary clocks for
 PTP_SYS_OFFSET_EXTENDED
In-Reply-To: <20250701165610.6e2b9af2@kernel.org>
References: <20250626124327.667087805@linutronix.de>
 <852d45b4-d53d-42b6-bcd9-62d95aa1f39d@redhat.com> <871pr0m75g.ffs@tglx>
 <20250701165610.6e2b9af2@kernel.org>
Date: Wed, 02 Jul 2025 10:19:52 +0200
Message-ID: <87frffknrr.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Tue, Jul 01 2025 at 16:56, Jakub Kicinski wrote:
> On Tue, 01 Jul 2025 14:23:39 +0200 Thomas Gleixner wrote:
>> > I guess we want to avoid such duplicates, but I don't see how to avoid
>> > all of them. A stable branch on top of current net-next will avoid the
>> > ptp cleanup series duplicates, but will not avoid duplicates for
>> > prereqs. Am I missing something obvious?  
>> 
>> No. I messed that up by not telling that the PTP series should be
>> applied as a seperate branch, which is merged into net-next. That way I
>> could have merged that branch back into tip and apply this pile on top.
>> 
>> Let me think about an elegant way to make this work without creating an
>> utter mess in either of the trees (or both).
>
> Sorry about that, I read the previous cover letter as the branch being
> provided for convenience, not that I _should_ pull from it. I should
> have asked..

I should have made it entirely clear. Next time :)

