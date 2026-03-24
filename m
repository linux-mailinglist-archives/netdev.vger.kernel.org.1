Return-Path: <netdev+bounces-271204-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2DvtA6zOwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271204-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:49:32 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id B1EA731A4D1
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D6E7830439F0
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:47:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2880D40B6CB;
	Tue, 24 Mar 2026 17:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOiLfKc7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04E0E40824B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374475; cv=none; b=tbuUMrpYs06cvfYxk+kS1tJFm4XWa3t5kRlAUA5FqbFwY7WSJt81xCFvIVKfoes/1AQSUuRJ4cvtFDrgFx+6ZcgGRQGT36+QBP22Y0Iv3wR0nsXR6q02NVVsS+nsR0NJfrNaC/hb03tPNmuQn+0D/WyD6FmDyTol1Ss+684gs4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374475; c=relaxed/simple;
	bh=CcwoNPIwzDuuQUlg2LdF8utRYm++HfK4cMy0kJw7ZBA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=q76Te8tyAtrfQB1Pl8fA2Iq+cFif2tuzz8bqLQecIKIW0N/H/S/wm3w3ImjMhIZkKuSP/vte5dH0qAMhq5UA88qSb7mfKnVgIFUrZ10YeUPzePsfGoGwUmwzPopRBETRO4olgBqHzLyKydBrlyoT6aeP4K+FmYnHOa2w5TUJbeM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOiLfKc7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27FD9C2BC87;
	Tue, 24 Mar 2026 17:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374474;
	bh=CcwoNPIwzDuuQUlg2LdF8utRYm++HfK4cMy0kJw7ZBA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOiLfKc7R14yMJ2K9Vy+655ZJL8xcXk7m0Huucwirb1Wwdc5hs7tHUvVFMeVlUZlk
	 VCcHaMvVl7HI57nbihCvdjN9r8o18Hpq51qs7zcjptalw3y8OWyISsnltx3YbHPzaf
	 /z3x2lN7Azan0x0M8CUQVKbFDoNGKgZUIyeoZf5uPh9vFxRRUZU5YgDgUA46f5i6jF
	 Ucgd9IuTXq05uHt3HWW+a5SZNMSrpFcwQ+7bxxzKyAqqyCM+ZEeVM+MJySR2eeA1jY
	 RNikcTGQZ4NQetWmLFaXbjgYzlxLo2mGKf3NKSqczYAd7xeGP1z2WafwTm59LoDKRe
	 8n5VsiFAaYj6A==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	jhs@mojatatu.com,
	jiri@resnulli.us,
	j.koeppeler@tu-berlin.de,
	kernel-team@cloudflare.com
Subject: [PATCH 0/5] veth: add Byte Queue Limits (BQL) support
Date: Tue, 24 Mar 2026 18:46:59 +0100
Message-ID: <20260324174719.1224337-2-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260324174719.1224337-1-hawk@kernel.org>
References: <20260324174719.1224337-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271204-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: B1EA731A4D1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

This series adds BQL (Byte Queue Limits) to the veth driver, reducing
latency by dynamically limiting in-flight bytes in the ptr_ring and
moving buffering into the qdisc where AQM algorithms can act on it.

Problem:
  veth's 256-entry ptr_ring acts as a "dark buffer" -- packets queued
  there are invisible to the qdisc's AQM.  Under load, the ring fills
  completely (DRV_XOFF backpressure), adding up to 256 packets of
  unmanaged latency before the qdisc even sees congestion.

Solution:
  BQL (STACK_XOFF) dynamically limits in-flight bytes, stopping the
  queue before the ring fills.  This keeps the ring shallow and pushes
  excess packets into the qdisc, where sojourn-based AQM can measure
  and drop them.

  Test setup: veth pair, UDP flood, 13000 iptables rules in consumer
  namespace (slows NAPI-64 cycle to ~6-7ms), ping measures RTT under load.

                   BQL off                    BQL on
  fq_codel:  RTT ~22ms, 4% loss         RTT ~1.3ms, 0% loss
  sfq:       RTT ~24ms, 0% loss          RTT ~1.5ms, 0% loss

  BQL reduces ping RTT by ~17x for both qdiscs.  Consumer throughput
  is unchanged (~10K pps) -- BQL adds no overhead.

CoDel bug discovered during BQL development:
  Our original motivation for BQL was fq_codel ping loss observed under
  load (4-26% depending on NAPI cycle time).  Investigating this led us
  to discover a bug in the CoDel implementation: codel_dequeue() does
  not reset vars->first_above_time when a flow goes empty, contrary to
  the reference algorithm.  This causes stale CoDel state to persist
  across empty periods in fq_codel's per-flow queues, penalizing sparse
  flows like ICMP ping.  A fix for this is submitted separately:
    https://lore.kernel.org/netdev/20260323174920.253526-1-hawk@kernel.org

  BQL remains valuable independently: it reduces RTT by ~17x by moving
  buffering from the dark ptr_ring into the qdisc.  Additionally, BQL
  clears STACK_XOFF per-SKB as each packet completes, rather than
  batch-waking after 64 packets (DRV_XOFF).  This keeps sojourn times
  below fq_codel's target, preventing CoDel from entering dropping
  state on non-congested flows in the first place.

Key design decisions:
  - Charge-under-lock in veth_xdp_rx(): The BQL charge must precede
    the ptr_ring produce, because the NAPI consumer can run on another
    CPU and complete the SKB immediately after it becomes visible.  To
    avoid a pre-charge/undo pattern, the charge is done under the
    ptr_ring producer_lock after confirming the ring is not full.  BQL
    is only charged when produce is guaranteed to succeed, keeping
    num_queued monotonically increasing.  HARD_TX_LOCK already
    serializes dql_queued() (veth requires a qdisc for BQL); the
    ptr_ring lock additionally would allow noqueue to work correctly.

  - Per-SKB BQL tracking via pointer tag: A VETH_BQL_FLAG bit in the
    ptr_ring pointer records whether each SKB was BQL-charged.  This is
    necessary because the qdisc can be replaced live (noqueue->sfq or
    vice versa) while SKBs are in-flight -- the completion side must
    know the charge state that was decided at enqueue time.

  - IFF_NO_QUEUE + BQL coexistence: A new dev->bql flag enables BQL
    sysfs exposure for IFF_NO_QUEUE devices that opt in to DQL
    accounting, without changing IFF_NO_QUEUE semantics.

Background and acknowledgments:
  Mike Freemon reported the veth dark buffer problem internally at
  Cloudflare and showed that recompiling the kernel with a ptr_ring
  size of 30 (down from 256) made fq_codel work dramatically better.
  This was the primary motivation for a proper BQL solution that
  achieves the same effect dynamically without a kernel rebuild.

  Chris Arges wrote a reproducer for the dark buffer latency problem:
    https://github.com/netoptimizer/veth-backpressure-performance-testing
  This is where we first observed ping packets being dropped under
  fq_codel, which became our secondary motivation for BQL.  In
  production we switched to SFQ on veth devices as a workaround.

  Jonas Koeppeler provided extensive testing and code review.
  Together we discovered that the fq_codel ping loss was actually a
  12-year-old CoDel bug (stale first_above_time in empty flows), not
  caused by the dark buffer itself.  A fix is submitted separately:
    https://lore.kernel.org/netdev/20260323174920.253526-1-hawk@kernel.org

Patch overview:
  1. net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  2. veth: implement Byte Queue Limits (BQL) for latency reduction
  3. veth: add tx_timeout watchdog as BQL safety net
  4. net: sched: add timeout count to NETDEV WATCHDOG message
  5. selftests: net: add veth BQL stress test

Jesper Dangaard Brouer (5):
  net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  veth: implement Byte Queue Limits (BQL) for latency reduction
  veth: add tx_timeout watchdog as BQL safety net
  net: sched: add timeout count to NETDEV WATCHDOG message
  selftests: net: add veth BQL stress test

 .../networking/net_cachelines/net_device.rst  |   1 +
 drivers/net/veth.c                            |  92 +-
 include/linux/netdevice.h                     |   1 +
 net/core/net-sysfs.c                          |   8 +-
 net/sched/sch_generic.c                       |   8 +-
 tools/testing/selftests/net/veth_bql_test.sh  | 784 ++++++++++++++++++
 .../selftests/net/veth_bql_test_virtme.sh     | 124 +++
 7 files changed, 1001 insertions(+), 17 deletions(-)
 create mode 100755 tools/testing/selftests/net/veth_bql_test.sh
 create mode 100755 tools/testing/selftests/net/veth_bql_test_virtme.sh

-- 
2.43.0


