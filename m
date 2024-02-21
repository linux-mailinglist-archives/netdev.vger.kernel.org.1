Return-Path: <netdev+bounces-73766-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E6FEF85E46E
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 18:20:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9D1B61F25D12
	for <lists+netdev@lfdr.de>; Wed, 21 Feb 2024 17:20:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E13BF81203;
	Wed, 21 Feb 2024 17:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AL3HI6es";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PaWGoSbo"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB175B5D1
	for <netdev@vger.kernel.org>; Wed, 21 Feb 2024 17:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708536042; cv=none; b=VCL0GdBuZgKMqckNYCi/psUt1WqsYzLGP/brFohnTetpDGTmdt49d1oFyd2yb9szZKjKBijHJG9ZKWCLonrRjSww5ubKpKAKHnC99CqEi952bs3Qx6KPv+JNCCuQvhseH/lg6/FRlUlCxgaNVUjsTrxAFadzEWWWmXyqQdjdSGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708536042; c=relaxed/simple;
	bh=87NB9LOg/lVHveENm6X5t18JhykctIBHamucYdnKsjQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GgxQGr7y2MXvGCBmTByLccXdbHDTvKkmp8Mib7SLDtyPyWafOzvuC9jFsyNr+THFzqrMB/ba1aU/H9g4KoZCqGbfieIsqmY3Y8yX4fnPg3yA9quvowB+0ND+aPEiJk3vBVCVV/1C7/gNU6ETA6PsmGrkcnfmIA3dIG1FYl6mT68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AL3HI6es; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PaWGoSbo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1708536039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kW+6XifLDpjBf1ZdMQv80B5XX4hd9J7fUKsnZeDNQWg=;
	b=AL3HI6esNgy0yF0+K2KO4LnjOU3tNWPX55wNp2uIGycLpGiyyXZeQVLAtp5VoJj25eThRi
	mGhfeZkejeATgeTde8syT59yUAg/gox6pL/B7xrKEfZK/+ZrRT8b8OUPeuF2tai2CimwUm
	/Jd6fYlYtdYnDaT+MYEzBZeE+ZSB3IeWOc0bF+fNYoi8dJOjIq7krCGRJ/oUAHS/PH/RrS
	j2eALphtGqLq2Hze+eHvIZKliBZikps0rNzYoydljP5LJUIM8qg9xrKseB1Am3jtm7W6+F
	7HYSrpFvE57eW5L7CZ5aavfN+ZxZd/f8Mb00bJe+Q7wVGzIlAaxJVT2J2tjPpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1708536039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=kW+6XifLDpjBf1ZdMQv80B5XX4hd9J7fUKsnZeDNQWg=;
	b=PaWGoSbotLhNJoi9xcCv6mMg+M8G3bOc/xsO5REJ5ZQ7K85oCxMdXftlcOfy9rvAz5+k5c
	kKDM3891gZkYYsCA==
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Wander Lairson Costa <wander@redhat.com>,
	Yan Zhai <yan@cloudflare.com>
Subject: [PATCH v2 net-next 0/3] net: Provide SMP threads for backlog NAPI
Date: Wed, 21 Feb 2024 18:00:10 +0100
Message-ID: <20240221172032.78737-1-bigeasy@linutronix.de>
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


