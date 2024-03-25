Return-Path: <netdev+bounces-81528-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 95CBD88A261
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 14:36:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4EDBF2C7E19
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 13:36:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 165541B2510;
	Mon, 25 Mar 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nCbSnaAj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5EMt8LMi"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AADB13958A
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 07:50:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711353016; cv=none; b=DryyUIz333K9g2XVGnsrR74iDUMGvvDoiarTT4C8W0TfTGyx52CF/dt67cKwhAJzbyXx5WSyLqfvyhAlrPu2HntN9NT6XyemZ8tMn+7rMs7lsmeOMyypTJN4PK0jvBS+N7Ha6b7OCRwVVEnOrzO0C+bUOjHYLA6zFgwsTPJzrwI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711353016; c=relaxed/simple;
	bh=Ml5v7QxcMpAz++fFB4ebPbllke6rkv02SvjeLhgb/Ng=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=FwhgPGwKNjqKL1/ATFptI9nUHziFH02CBeGIlqN24FPhpwokZ9+11wBnv6FhCEa4TK7Ms9WupaVeJX7z5Yvl2Q+zo62c1Pqi/AqPIiec2PHPMru+z9r/kq7FxXw29OBgW/Y+6P6GfNVAyuZkl2RvWGPlyBrOGCx9nP01Ipi8L3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nCbSnaAj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5EMt8LMi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1711353012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QUrSR0eU+xRU8iQECZaiAf9G0XAqo8+ovRzBnNHaxOo=;
	b=nCbSnaAjo+K1PbO5g1gNZJE4xxMDpIRMS9TtcqwTzCOYBszW4cgUpLpQPqY8bpAqbHc/ZD
	DQKegQXS5FInZpX/AgNDB5vZBeD17oeYRseTi0A6ki2Rcr218ReJKJGL4+vxjudK5lV/J9
	JDn15Xt5KJdwtN0Cm2kUvYG1A3LMyDpFyYHP75NsLMxYUJn0Ylr9SZPwaF1QxxlBuzAfwr
	/fKl6Ft2iGnonUtLV70J89BBzs8fPeki4v5jOpooiScVdunIEuMt9Ev2W99UHUpXF1FHdU
	LCTyAC5Vn40prKo/GgjcJeoPN9B9mWY5CYwkF1Nj3PLRlLlms1NkGcS2kXGq3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1711353012;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=QUrSR0eU+xRU8iQECZaiAf9G0XAqo8+ovRzBnNHaxOo=;
	b=5EMt8LMiQVtn1pDfIg1KO3T3OAVzd0MFbx1fMnOSHU41BMd0IOztgg7dTIt/O3L4QsYJJB
	G3THBeDGHpMJqpBQ==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH v6 net-next 0/4] net: Provide SMP threads for backlog NAPI
Date: Mon, 25 Mar 2024 08:40:27 +0100
Message-ID: <20240325074943.289909-1-bigeasy@linutronix.de>
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
- v5=E2=80=A6v6 https://lore.kernel.org/all/20240309090824.2956805-1-bigeas=
y@linutronix.de/

  - Rebase on top of current net-next.

- v4=E2=80=A6v5 https://lore.kernel.org/all/20240305120002.1499223-1-bigeas=
y@linutronix.de/

  - Rebase on top of current net-next.

- v3=E2=80=A6v4 https://lore.kernel.org/all/20240228121000.526645-1-bigeasy=
@linutronix.de/

  - Rebase on top of current net-next, collect Acks.

  - Add struct softnet_data as an argument to kick_defer_list_purge().

  - Add sd_has_rps_ipi_waiting() check to napi_threaded_poll_loop() which w=
as
    accidentally removed.

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


