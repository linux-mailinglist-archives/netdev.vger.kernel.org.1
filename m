Return-Path: <netdev+bounces-201960-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2E49AEB96F
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 16:04:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E98FC642CA1
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 14:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B92C62DD5E4;
	Fri, 27 Jun 2025 14:04:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="voHDQSQN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p9frIgck"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31CC92DCBEF;
	Fri, 27 Jun 2025 14:04:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751033089; cv=none; b=ZauIHUtFngx//K+Q64wSKmt/fesEfivuyfcdttnThIjFNnjpG9AyLgn2kRSHz9g7PWmEy/hzhTp218fUAz/MVhwFGVku9WoqXOGm8grGNVFyeqhXLW4ohPQpPSG/TVn3IfZ7fdOlO2UnfcgS78TMrOPNAFpr95PCFJgiWDkrwLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751033089; c=relaxed/simple;
	bh=s2S42hWkHNbnZv7OCqrUp4lqLfra6M/wkKx5NSNANSs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VVFpVCujdmjHXdUDDPPQwcw//zXp5jVraR1/eSTPgx8eAgCTLA82QYERUq8KT2is5P+k5i0HdTwvY1PCu5XuRUL0wEwoe5s1f/qpH8jdCefx4YV7mU5Vco6sCG/1Y0/tbN8wTkaBqws2R8cSfr06DxdG1hvaCv3iLsa4rRAnIdk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=voHDQSQN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p9frIgck; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751033086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRnlofzL0omWkVGViWnN13/n3c33AdU47NpbKuHNqWc=;
	b=voHDQSQN+D80toFeQZXaPAOd+RgFTjw2YEOIUO/ggx2lbkuoqjJHHCclqFscNJKvxsSvWV
	X5GY0Z5EWemWLGJmn6TQA3Zxe65Q0FUZI5kQFylyk4jYvFO4kobXguHjcCQwq4sMzVuck1
	Upk4FLLHDZyGOpJn81kswhC0hdBc+gRglf2kaZQxh3IvKaFDPWEIshqJenpsv9VYrfcpl1
	TMNNNO5EU/3jqkgVG95SnsQ/fgsonIDssnyuMj6B7byZxGq8mM6TZJ8wbBm0QeSmuwL6/D
	JeBMH/FrrpyGedyGK52i0HeE/TFLNIFF66ByfwiEYbBj9ur8jGBYADZ7RXYElg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751033086;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=pRnlofzL0omWkVGViWnN13/n3c33AdU47NpbKuHNqWc=;
	b=p9frIgckAMrrCPtdWfMM6SCzMCcKbIPDSmS3R6pT7rKhcRWAn9ol/ZlGYlxyRGMBdOXe2K
	6nxAdYG9hVEoQnBw==
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
Subject: Re: [patch V3 01/11] timekeeping: Update auxiliary timekeepers on
 clocksource change
In-Reply-To: <CANDhNCqLST-im8WJXTWPsXmqhq2JM9+nVB6phixxH2PT-tQ3Tg@mail.gmail.com>
References: <20250625182951.587377878@linutronix.de>
 <20250625183757.803890875@linutronix.de>
 <CANDhNCqLST-im8WJXTWPsXmqhq2JM9+nVB6phixxH2PT-tQ3Tg@mail.gmail.com>
Date: Fri, 27 Jun 2025 16:04:44 +0200
Message-ID: <87o6u9nuv7.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jun 26 2025 at 21:43, John Stultz wrote:
>> +/* Bitmap for the activated auxiliary timekeepers */
>> +static unsigned long aux_timekeepers;
>> +
>
> Nit: Would it be useful to clarify this is accessed without locks, and
> the related tks->clock_valid *must* be checked while holding the lock
> before using a timekeeper that is considered activated in the
> aux_timekeepers bitmap?

I'll amend all your nits when applying the pile.

Thanks,

        tglx

