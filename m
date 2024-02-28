Return-Path: <netdev+bounces-75689-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 97ADE86AED1
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 13:10:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 393821F2406F
	for <lists+netdev@lfdr.de>; Wed, 28 Feb 2024 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C70352560C;
	Wed, 28 Feb 2024 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jxN1xxHK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AX9M5BI/"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CFCE7353E
	for <netdev@vger.kernel.org>; Wed, 28 Feb 2024 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709122206; cv=none; b=BMRM8KbbBAAn5y8KRfK7LqSgIgsubwKML44ivSrquhXpzEyVgsmlVcM9or7n+H6Laqtxqv88DssyjBaMKfNqRCAkFMo+9M9wiNTklIKnRtOcaykthIkROmyPlCykMSk3t4cSzoXrrZ7q5+F2mOuBMileMlIPzM8/csonnqrAxv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709122206; c=relaxed/simple;
	bh=5NATaaEcHBuD7hEw5SfkIqMBiAFnRTlktYpUPib1zdE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hbhoXc0DQwno7Y64LLg1Bc1HPiVEeXVNfzYieK6bcuY4ZivqP6Saal+bClG/9Skx3q8OjYRm+lIAq/RVi0JD5HtSzc4jbES9Wx9kd9j2HkY5VsaYrQwKVBD5sQTbTkSi1vP4z89J2/W2uN9uvn1RBjkrMfIvelZB4CHN7JFdhto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jxN1xxHK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AX9M5BI/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1709122202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xgzLqYLdam7+v9xMnqdtB7ChwLBrEJUOKW30jSTfWi4=;
	b=jxN1xxHKXVGSoVVTSmWLwzaSZqc9cdekh0oMO//O0/1tmn6+6S9WvqEilWvOKQNPXbkIri
	baETKpju+cSI/IIzMIQA8SL9iAYfpq7eli3IvzhlhL16fh128v7orRhMGvmBvn+OASCSNE
	QRP+CQRXqgLJRwJcpQwIa0HzAoqxd8nX+i/EDP+xKRwAZx5cM2vatGdomnVwvvBCdfGxei
	KRSA82RVOjZ/jw4PA7/zUJi5UjPVlzcc/I+zpYEZW6EzUpbNodkveVpUlIuZAAS1cNrOor
	3JF2m7GLt/9w1YzwOEl8A38UfRenzQO7fsHY1JoWJLmcIR4kV33QssxrnqvHRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1709122202;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xgzLqYLdam7+v9xMnqdtB7ChwLBrEJUOKW30jSTfWi4=;
	b=AX9M5BI/LNGAf43jcDXAgGGwy9ComCvztXH6Mja853wHiTx2eZ5Jn7oclzsxU0HqayRvvq
	DPFwTsLPecDxQbBA==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH v3 net-next 0/3] net: Provide SMP threads for backlog NAPI
Date: Wed, 28 Feb 2024 13:05:47 +0100
Message-ID: <20240228121000.526645-1-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

The RPS code and "deferred skb free" both send IPI/ function call
to a remote CPU in which a softirq is raised. This leads to a warning on
PREEMPT_RT because raising softiqrs from function call led to undesired
behaviour in the past. I had duct tape in RT for the "deferred skb free"
and Wander Lairson Costa reported the RPS case.

This series only provides support for SMP threads for backlog NAPI, I
did not attach a patch to make it default and remove the IPI related
code to avoid confusion. I can post it for reference it asked.

The RedHat performance team was so kind to provide some testing here.
The series (with the IPI code removed) has been tested and no regression
vs without the series has been found. For testing iperf3 was used on 25G
interface, provided by mlx5, ix40e or ice driver and RPS was enabled. I
can provide the individual test results if needed.

Changes:
- v2=E2=80=A6v3 https://lore.kernel.org/all/20240221172032.78737-1-bigeasy@=
linutronix.de/

  - Move the "if use_backlog_threads()" case into the CONFIG_RPS block
    within napi_schedule_rps().

  - Use __napi_schedule_irqoff() instead of napi_schedule_rps() in
    kick_defer_list_purge().

- v1=E2=80=A6v2 https://lore.kernel.org/all/20230929162121.1822900-1-bigeas=
y@linutronix.de/

  - Patch #1 is new. It ensures that NAPI_STATE_SCHED_THREADED is always
    set (instead conditional based on task state) and the smboot thread
    logic relies on this bit now. In v1 NAPI_STATE_SCHED was used but is
    racy.

  - The defer list clean up is split out and also relies on
    NAPI_STATE_SCHED_THREADED. This fixes a different race.

- RFC=E2=80=A6v1 https://lore.kernel.org/all/20230814093528.117342-1-bigeas=
y@linutronix.de/

   - Patch #2 has been removed. Removing the warning is still an option.

   - There are two patches in the series:
     - Patch #1 always creates backlog threads
     - Patch #2 creates the backlog threads if requested at boot time,
       mandatory on PREEMPT_RT.
     So it is either or and I wanted to show how both look like.

   - The kernel test robot reported a performance regression with
     loopback (stress-ng --udp X --udp-ops Y) against the RFC version.
     The regression is now avoided by using local-NAPI if backlog
     processing is requested on the local CPU.

Sebastian


