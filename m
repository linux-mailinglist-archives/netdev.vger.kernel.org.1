Return-Path: <netdev+bounces-222809-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F261B56335
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 23:23:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB74FAA246A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 21:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5F1D281358;
	Sat, 13 Sep 2025 21:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WbjCJORV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zAsyiRek"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15B3A280A5B
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 21:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757798540; cv=none; b=AgbNS/+GuEO0AfjMzlTPfRJc2dOm0ooo4xHfegkGHJftc6Ae3Tbv9axtCc9I6GP4R6RUofveQKn0Q4aM+LAvgFi3pyPT1Jrg/I5QbPLvUAujh1LwaG+9U39S2TCBIlGkz56sCeesz+ySKF1aBf/YwMKfbvB/EImVSo/a63r/Q24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757798540; c=relaxed/simple;
	bh=P6/RDnXuyvGR5/p3YqZlXfHx3y0Wzd9Q1lGTBel91xE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SbeMkYkHhnU8XoVymrcSDRhqSrRQ8zh+EprSP/kiZRGFL+tUG6CEYDGwetKG2hjsYC6O7NUyH9Yy8owlUGlAqYrGbFFB1PYDhiqKHBu5gfZ4zXURa7d0OmQRe5PYUXigZC3rq3uk0gA2Cyc+lmmjYTb+EYr3xhTOkTQuvFck7xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WbjCJORV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zAsyiRek; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Sep 2025 23:22:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757798533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5C7fkGF35hiR7LwAwgyg4oFIfaQBXBh0CwYsral4wc=;
	b=WbjCJORVN0ATu4p4hmUogZc/L9UBJ89/tRVIqAzIJJjlA6TfROh6zz2X6/h3+Rfg1daidZ
	qJuqWdfnVaxrsERYmCVg30T1aGbinrqUbwSnoUQ820vuIMAdq1qFC61qD6ZVw01SOykHWs
	lx7ER1dv55Pm94Zjtw92ZMBCcvH4W7EUTSnk67hlsoT7km984upOsH/BSNyeq3xyDNspLp
	pOkLDqTM4CIpFtev/MRZXsr6XpWU/S4Ir6mCSGvGeLTUW17cNgIoScdqzNq85+quOTO6Q8
	3cVtpm2HbZdTR56JrSq8DJOn+Hx9wQMMSuYcPAVvMQqo3Vb0dRhsJQtZSFKYiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757798533;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D5C7fkGF35hiR7LwAwgyg4oFIfaQBXBh0CwYsral4wc=;
	b=zAsyiRek2uOkhkCW78BDEONvnrWYao3wF4Qn3FR6rk/pyn+8x23FC6gp3aUYuxJ6rJ3yoG
	pU4ScYThXEt00QBg==
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To: Kurt Kanzenbach <kurt@linutronix.de>
Cc: Miroslav Lichvar <mlichvar@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Subject: Re: [Intel-wired-lan] [PATCH iwl-next] igb: Retrieve Tx timestamp
 directly from interrupt
Message-ID: <20250913212212.3nwetWbI@linutronix.de>
References: <20250815-igb_irq_ts-v1-1-8c6fc0353422@linutronix.de>
 <aKMbekefL4mJ23kW@localhost>
 <c3250413-873f-4517-a55d-80c36d3602ee@intel.com>
 <aKV_rEjYD_BDgG1A@localhost>
 <87ikhodotj.fsf@jax.kurt.home>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <87ikhodotj.fsf@jax.kurt.home>

On 2025-09-12 11:04:24 [+0200], Kurt Kanzenbach wrote:
=E2=80=A6
> I did run the same test as you mentioned here. But, my numbers are
> completely different. Especially the number of hardware TX timestamps
> are significantly lower overall.
=E2=80=A6

Using the command line, I see hardly any difference over 5 runs. One
thing that made me curious:

| NTP packets received       : 1061901
| NTP daemon TX timestamps   : 565892
| NTP kernel TX timestamps   : 327905
| NTP hardware TX timestamps : 168104
| tx_hwstamp:395778

tx_hwstamp is a counter in igb_ptp_tx_tstamp_event() keeping track how
many packets it processed. So it processed ~395k packets but "NTP
hardware TX" says 168k. Reading the timestamp directly or via the
worker, it looks mostly like noise. I see on ntpperf side ~ 45% - 55%
loss.

If I do
| ntpperf -i X =E2=80=A6 -I -r 1000 -t 2

then there is no loss and on other side I see

| NTP packets received       : 2201
| NTP timestamps held        : 2101
| NTP daemon TX timestamps   : 200
| NTP kernel TX timestamps   : 901
| NTP hardware TX timestamps : 1100
| tx_hwstamp:2101

Here the tx_hwstamp counter colorates with "NTP timestamps held". Does
it this make any sense? I don't see this matching with the "larger" runs
where ntpperf reports loss.

> Thanks,
> Kurt

Sebastian

