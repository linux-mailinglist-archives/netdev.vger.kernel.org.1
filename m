Return-Path: <netdev+bounces-271203-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QEDqIWbPwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271203-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:52:38 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9789A31A595
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D856A3008456
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DCE540825B;
	Tue, 24 Mar 2026 17:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KXxOiYAa"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B036391E55
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374461; cv=none; b=aa4sqAI4Sp3+nQPSkbzfRP2P4aX68BEcCzJFVzFs9otOFkImfPt26LBFPyhwGa/s9dlHBDWRyHs7epObHcFXQj4wAQRN+vslNWkUj/7oWhLfi8qYPt9EhHoMlf9Pv6lBHGXZQPpubkziaPHcpac+nx4YMhk9kD+ZEkFx8lBAnVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374461; c=relaxed/simple;
	bh=A1eOoOl3KfrucHwVTHSRkOCXPdZRyO6VuVfaQ6x61iM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QtU4+dlxbjYTc4P6oBF1EHW1/DjAq1gmx7Eal68gSoBkd25Pn3VOIZBXBOw1l7wBV3KhxPRbaoeK1EJybIkgMaNL9aMQE1m5dJf7kOQGUSl2DzVIWYpWsIDKvHgbFXYnLC6ul4N45Fcn8PzXv24hhpyLrvtKQWbMtBgfPux9AmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KXxOiYAa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94560C19424;
	Tue, 24 Mar 2026 17:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374460;
	bh=A1eOoOl3KfrucHwVTHSRkOCXPdZRyO6VuVfaQ6x61iM=;
	h=From:To:Cc:Subject:Date:From;
	b=KXxOiYAalQ3xnZqcA5cFxBCpaDB8hlOU1m1IcfjFxR79ndDaZP759CoiMTIHjaJDN
	 fhnIGSAqBBeyzEp3xYBBi/+O6Omegx+sGtngdjqwoTplp9JFmdp77KG9VG4D4QLdbH
	 5sTnp66yFklFSsNKFg9ZqB0AiaoQ4QbdVpGBqewFT65H+LZYhc6h32vh87aHyZIKli
	 gdwhUxIHIuoLCtfwDADtYhCz3uUwDQSZIuE2SbB/v6vki1Ijq8zLADjhjnn3QNcvvW
	 nsMKjRWRnnPBbf3zGKDqZnL0bzvDSAzZ0wlQSh4TmIyE7DzUtOu5AgcHp/fyXDmiWZ
	 nF2kITsXH6MaA==
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
	kernel-team@cloudflare.com,
	Chris Arges <chris.arges@gmail.com>,
	Mike Freemon <mike.freemon@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
Subject: [PATCH net-next 0/5] veth: add Byte Queue Limits (BQL) support
Date: Tue, 24 Mar 2026 18:46:58 +0100
Message-ID: <20260324174719.1224337-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-271203-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[kernel.org,lunn.ch,davemloft.net,google.com,redhat.com,mojatatu.com,resnulli.us,tu-berlin.de,cloudflare.com,gmail.com,toke.dk];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,cloudflare.com:email,toke.dk:email]
X-Rspamd-Queue-Id: 9789A31A595
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

Cc: Chris Arges <chris.arges@gmail.com>
Cc: Mike Freemon <mike.freemon@cloudflare.com>
Cc: Toke Høiland-Jørgensen <toke@toke.dk>

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


