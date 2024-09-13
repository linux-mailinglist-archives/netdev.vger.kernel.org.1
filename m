Return-Path: <netdev+bounces-128078-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F34977DE7
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 12:46:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A2151F25822
	for <lists+netdev@lfdr.de>; Fri, 13 Sep 2024 10:46:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9771D7E59;
	Fri, 13 Sep 2024 10:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RckU/D8L";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JaR8+4ix"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F8891D7E39;
	Fri, 13 Sep 2024 10:46:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726224391; cv=none; b=Rsh6LszN4miBwG+0AC5bqqUNS3hMgYqNiyvRhVK5wypRHgII02OOdxU5hfdsgDyMmKOPzyh4ExY5rU2CN82DMl/p9cy01XoTEeKEIeyGydCDuynAcZw0XMaNbB63odzyYJ8ltGUJ+ANzhwHMIpv++O66rOmCn1MfB8wU3lq6quA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726224391; c=relaxed/simple;
	bh=KCWk/dnVPJwIbDkehd9oHsFwt8PrYfUPofvCbjHB2G0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=E0GQ+x51Ua+a6X9s/s6jT7Nssxt64EVvVprgyWHaQLlfwOveub9k5bBa35AvgixVMYungj1oSldSib1N/MFKurWGLCp0jcl9PG+zKEBl0ne8ksjwx4awfyZrOIwjv0eivwuvZt/yxT6DIQdkjXle4igqTEFQRYfMp6Sr+2lx6Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RckU/D8L; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JaR8+4ix; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1726224388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnsRMqXCsoNSxev+bzoyLtV5/e+uievz8pnFWnbeXXU=;
	b=RckU/D8LtemwgfefZNK5f3PvEUsmbnsCEktJoUmFDsViCepWwZ56LLJY+99843OpLnX47U
	WSnPZ3FX++x1FeY+V7jCSbVrEPOm3PEGN4FZZ2xPDhDjiPLu1fqWEf5rgDNASTQe3+v7Mz
	MaNebGhBoOGFp9V3OqvrLioyFsn81dGxQn0RyfTutdKlPkJ/8oZuKbNLQaiAe2S0dG2xd8
	xho197EemNvBl2RXxTwS2KXC1QiVksEsJhpAmie+m3ecj7mhHmUKD9TBMu1H4dEtL+N22F
	R/KApj//MRmg+e3wdZNWuXYQ+fzkQFgh0LYi5PrgdAmsd49DbQljsYQIn9mbTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1726224388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BnsRMqXCsoNSxev+bzoyLtV5/e+uievz8pnFWnbeXXU=;
	b=JaR8+4ixFirPagxehqLX8jzIZ+iLxSrrJtSdtxmc/fAQ4ZLTYv8Z6fx32DjesY/CkTBjFj
	toFF1MlSfVy5dXDw==
To: Jinjie Ruan <ruanjinjie@huawei.com>, Richard Cochran
 <richardcochran@gmail.com>
Cc: bryan.whitehead@microchip.com, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, anna-maria@linutronix.de,
 frederic@kernel.org, UNGLinuxDriver@microchip.com, mbenes@suse.cz,
 jstultz@google.com, andrew@lunn.ch, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3 1/2] posix-timers: Check timespec64 before call
 clock_set()
In-Reply-To: <46efd1be-688e-ecd0-a9e1-cf5f69d0110f@huawei.com>
References: <20240909074124.964907-1-ruanjinjie@huawei.com>
 <20240909074124.964907-2-ruanjinjie@huawei.com>
 <Zt8SFUpFp7JDkNbM@hoboy.vegasvil.org>
 <ea351ea0-5095-d7ae-5592-ec3bd45c771c@huawei.com> <874j6l9ixk.ffs@tglx>
 <46efd1be-688e-ecd0-a9e1-cf5f69d0110f@huawei.com>
Date: Fri, 13 Sep 2024 12:46:28 +0200
Message-ID: <87v7yz96gr.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Sep 12 2024 at 20:24, Jinjie Ruan wrote:
> On 2024/9/12 20:04, Thomas Gleixner wrote:
>> How does this code validate timespecs for clock_settime(clockid) where
>> clockid != CLOCK_REALTIME?
>
> According to the man manual of clock_settime(), the other clockids are
> not settable.
>
> And in Linux kernel code, except for CLOCK_REALTIME which is defined in
> posix_clocks array, the clock_set() hooks are not defined and will
> return -EINVAL in SYSCALL_DEFINE2(clock_settime), so the check is not
> necessary.

You clearly understand the code you are modifying:

const struct k_clock clock_posix_dynamic = {
	.clock_getres           = pc_clock_getres,
        .clock_set              = pc_clock_settime, 

which is what PTP clocks use and that's what this is about, no?

Thanks,

        tglx

