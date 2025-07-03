Return-Path: <netdev+bounces-203885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D2060AF7E35
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 18:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 461834A7BA1
	for <lists+netdev@lfdr.de>; Thu,  3 Jul 2025 16:52:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BEC025A62D;
	Thu,  3 Jul 2025 16:52:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xJjpINlM";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Gb2Fsyrb"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 801F525A2C4;
	Thu,  3 Jul 2025 16:52:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751561550; cv=none; b=O6faHJrGnGZ+5+d3qXFIzsEaozONmVX4H/S2syUjnEJc1o4Ta5ggjeXsmEWyvalGewNd3sYIFghTkM/4TVAgd/bu3PFipdDdArLkt2lXw7FtFlgfTv6cnYtL+kEv2wv4KUeOQQiRNGtsyeRyqq+CdOYSwfuCpCxmuPm77V0N34s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751561550; c=relaxed/simple;
	bh=LYNhsMbTFPjdJCNDr4z7z8KknIyhEZePgpf5rFEKV4I=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L1qoiFiYWJsJmmt6LWoaTe3RdheAw93l0uXAI2OOzOYPJ231YAkD6+qMdghQ3cvXrZzpH24BlA0TwwTXZ86hhw1X4P8YSOguoJcv9yTkZHldMMSLpIzG2g4uiOZSBx2pMmUJUm1wb3WJrkqBrbDP8AzBiKMty3sXoT1Aes3J5pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xJjpINlM; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Gb2Fsyrb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751561546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qu6yM52VHL1/dwassjBDy0LPjhTfFriEOOjhqhzzPlM=;
	b=xJjpINlMBWfXUSHvm2m6dQDR1UMt3vDeElfNxVaji5eGdq4F65+Tj3oMey1+l/bToisXnH
	8/9tfR1wewdvTbwhUHFnIlWaIBb4f277VuJ3J6HAL32+7FKJ0hp5FnxucRX3h6llo8yEUV
	X+iuTV4e3a0qn6zuVa+/0gyj7OQMm3Rxz6n+38go6UVOBeqoPJcfC4lugXKk6+E8ih4I8w
	GnBLeoX4GD+kt59HbPNUiCpPh6OHvlEHjZlbbXyR6bs6GtY4Ju2E7I6XkZ3yoaof6KkFG8
	kB7a3JjQ/Lb5nvfCurz91CcVRvF8jimjB8Sa7JGyyV4uX4wXRhAQPFcDqbySPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751561546;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=qu6yM52VHL1/dwassjBDy0LPjhTfFriEOOjhqhzzPlM=;
	b=Gb2Fsyrb9bv/crq4Hd0et/hLtYIzJP9LdeuG94xo3bneW8GRsLT4EILcxf5hwB6hiy2tbp
	CjlwN8RNJIhcR0Dg==
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
In-Reply-To: <4cab9be0-3516-454f-883b-7a999994c447@redhat.com>
References: <20250701130923.579834908@linutronix.de>
 <faca1b8e-bd39-4501-a380-24246a8234d6@redhat.com> <87ecuxwic0.ffs@tglx>
 <4cab9be0-3516-454f-883b-7a999994c447@redhat.com>
Date: Thu, 03 Jul 2025 18:52:25 +0200
Message-ID: <87ms9ltdx2.ffs@tglx>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

On Thu, Jul 03 2025 at 15:48, Paolo Abeni wrote:
> On 7/3/25 2:48 PM, Thomas Gleixner wrote:
>> Here you go:
>> 
>>   git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git ktime-get-clock-ts64-for-ptp
>> 
>> I merged it locally into net-next, applied the PTP patches on top and
>> verified that the combination with the tip timers/ptp branch, which has
>> the tag integrated and the workaround removed, creates the expected
>> working result.
>
> I had to wrestle a bit with the script I use - since the whole thing was
> a little different from my usual workflow - but it's in now, hoping I
> did not mess badly with something.

Looks perfect!

Thank you for the extra mile!

      tglx

