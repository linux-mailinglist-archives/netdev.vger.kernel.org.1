Return-Path: <netdev+bounces-284395-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GNGLF0/w+WmcFQMAu9opvQ
	(envelope-from <netdev+bounces-284395-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:27:43 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 60B434CE788
	for <lists+netdev@lfdr.de>; Tue, 05 May 2026 15:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 90785303D7C8
	for <lists+netdev@lfdr.de>; Tue,  5 May 2026 13:22:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1EC68365A00;
	Tue,  5 May 2026 13:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WMr3X792"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFC3A335555;
	Tue,  5 May 2026 13:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777987329; cv=none; b=ttuiStpDa0+3zWlonsIlo3lab0XkrGJD3gAJM8eN9N6vHs51AeNZHOkmFZ2g1QdHyHiWP61wUIHvitL8dUZHHNX2ZCS0dIUddefODV8T5IbfOzVshPLMUQ01LQpemPaw+Sya0X15J00zm3TiME72CyeAiLPp7L7Q0uElLFLw+J0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777987329; c=relaxed/simple;
	bh=rsNXvHZFXruMLnsGUPFyTQ0lT0Wwh0YQovcguINFEy4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EhMuOfNFwc8YEvOaabbCwUXf0/RQf2FAXpBrsJG0a+aTHLwohOxReyqJg8H0Z/TXGiNIvkpsO98HsAvgbpfzPuGG1C3Ir3LlcDNd+LBCFzlmZqVwFwEIUyCXPPnfy9aswHxC39zJ8DTk+fDdQkK2FSuSEcGCVav0Y4w04cPuv2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WMr3X792; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E59ACC2BCB4;
	Tue,  5 May 2026 13:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777987328;
	bh=rsNXvHZFXruMLnsGUPFyTQ0lT0Wwh0YQovcguINFEy4=;
	h=From:To:Cc:Subject:Date:From;
	b=WMr3X792ZQLV7ao4Zlh5ye75S4tqSqVnNWIQeuk5X9TUJT0JzwvA7AiTmdlDY+G4k
	 wZvcADh5OrTU/JLEuwnRbEfIg707fzsPRoDP0+YHZcCWQFvf1zZV3RZHWeuRw9EhqB
	 7eOOisYdm3TpZ0WzReSbTBagckLFB5PgtJ7dla7Si+garjrrsMwqcAzpgIGjEasIxw
	 RUh/rvYcGpxMz/LQmkcQNWHqxSuP9Cspba6zxCEwc4moWe27XtWF3QyHqTbxy9mvPi
	 OdMEjgzL4bnUAn0diLcAyfGNAlnw5H80py6vyaJZwyPp8S1OZlcqyW00LAZquTymAp
	 FZh6uah92a6cQ==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Chris Arges <carges@cloudflare.com>,
	Mike Freemon <mfreemon@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Breno Leitao <leitao@debian.org>,
	Simon Schippers <simon.schippers@tu-dortmund.de>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v5 0/5] veth: add Byte Queue Limits (BQL) support
Date: Tue,  5 May 2026 15:21:52 +0200
Message-ID: <20260505132159.241305-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 60B434CE788
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-284395-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,davemloft.net,google.com,redhat.com,toke.dk,tu-berlin.de,debian.org,tu-dortmund.de,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Jesper Dangaard Brouer <hawk@kernel.org>

This series adds BQL (Byte Queue Limits) to the veth driver, reducing
latency by dynamically limiting in-flight packets in the ptr_ring and
moving buffering into the qdisc where AQM algorithms can act on it.

Problem:
  veth's 256-entry ptr_ring acts as a "dark buffer" -- packets queued
  there are invisible to the qdisc's AQM.  Under load, the ring fills
  completely (DRV_XOFF backpressure), adding up to 256 packets of
  unmanaged latency before the qdisc even sees congestion.

Solution:
  BQL (STACK_XOFF) dynamically limits in-flight packets, stopping the
  queue before the ring fills.  This keeps the ring shallow and pushes
  excess packets into the qdisc, where sojourn-based AQM can measure
  and drop them.

  Test setup: veth pair, UDP flood, 13000 iptables rules in consumer
  namespace (slows NAPI-64 cycle to ~6-7ms), ping measures RTT under load.

                   BQL off                    BQL on
  fq_codel:  RTT ~22ms, 4% loss         RTT ~1.3ms, 0% loss
  sfq:       RTT ~24ms, 0% loss         RTT ~1.5ms, 0% loss

  BQL reduces ping RTT by ~17x for both qdiscs.  Consumer throughput
  is unchanged (~10K pps) -- BQL adds no overhead.

CoDel bug discovered during BQL development:
  Our original motivation for BQL was fq_codel ping loss observed under
  load (4-26% depending on NAPI cycle time).  Investigating this led us
  to discover a bug in the CoDel implementation: codel_dequeue() does
  not reset vars->first_above_time when a flow goes empty, contrary to
  the reference algorithm.  This causes stale CoDel state to persist
  across empty periods in fq_codel's per-flow queues, penalizing sparse
  flows like ICMP ping.  A fix for this has been applied to the net tree
  815980fe6dbb ("net_sched: codel: fix stale state for empty flows in fq_codel")
  
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
  caused by the dark buffer itself.

Patch overview:
  1. veth: fix OOB txq access in veth_poll() with asymmetric queue counts
  2. net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  3. veth: implement Byte Queue Limits (BQL) for latency reduction
  4. veth: add tx_timeout watchdog as BQL safety net
  5. net: sched: add timeout count to NETDEV WATCHDOG message

Jesper Dangaard Brouer (5):
  veth: fix OOB txq access in veth_poll() with asymmetric queue counts
  net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  veth: implement Byte Queue Limits (BQL) for latency reduction
  veth: add tx_timeout watchdog as BQL safety net
  net: sched: add timeout count to NETDEV WATCHDOG message

 .../networking/net_cachelines/net_device.rst  |   1 +
 drivers/net/veth.c                            | 107 ++++++++++++++++--
 include/linux/netdevice.h                     |   2 +
 net/core/net-sysfs.c                          |   8 +-
 net/sched/sch_generic.c                       |   8 +-
 5 files changed, 109 insertions(+), 17 deletions(-)

V4: https://lore.kernel.org/all/20260501071633.644353-1-hawk@kernel.org/

Changes since V4:
  - New patch 1: fix OOB txq access in veth_poll() when veth peers have
    asymmetric RX/TX queue counts.  XDP redirect can deliver frames to
    an RX queue index that exceeds the peer's TX queue count, causing
    an out-of-bounds netdev_get_tx_queue() access.  Found by sashiko-bot.
  - Patch 3 (veth BQL): wake stopped peer txqs in veth_napi_del_range()
    to clear DRV_XOFF after NAPI teardown.  A concurrent veth_xmit()
    can set DRV_XOFF between rcu_assign_pointer(napi, NULL) and
    synchronize_net(); with NAPI gone, no veth_poll() clears it.
    Guarded by netif_running() to skip during device close.

V3: https://lore.kernel.org/all/20260429172036.1028526-1-hawk@kernel.org/

Changes since V3:
  - Drop selftest patch (patch 5 from V3) per maintainer request.
  - Rebase on latest net-next.

V2: https://lore.kernel.org/all/20260413094442.1376022-1-hawk@kernel.org/

Changes since V2:
  - Patch 2 (veth BQL): fix syzbot WARNING in veth_napi_del_range():
    clamp BQL reset loop to peer's real_num_tx_queues.  The loop was
    iterating dev->real_num_rx_queues but indexing peer's txq[], which
    goes out of bounds when the peer has fewer TX queues (e.g. veth
    enslaved to a bond with XDP attached).

V1: https://lore.kernel.org/all/20260324174719.1224337-1-hawk@kernel.org/

Changes since V1:
  - Patch 1 (dev->bql flag): add kdoc entry for @bql in struct net_device.
  - Patch 2 (veth BQL): charge fixed VETH_BQL_UNIT (1) per packet instead
    of skb->len.  veth has no link speed; the ptr_ring is packet-indexed.
    Byte-based charging lets small packets sneak many entries into the ring.
    Testing: min-size packet flood causes 3.7x ping RTT degradation with
    skb->len vs no change with fixed-unit charging.
  - Patch 3 (tx_timeout watchdog): fix race with peer NAPI: replace
    netdev_tx_reset_queue() with clear_bit(STACK_XOFF) + netif_tx_wake_queue()
    to avoid dql_reset() racing with concurrent dql_completed().
  - Cover letter: update CoDel fix reference to merged commit in net tree.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Chris Arges <carges@cloudflare.com>
Cc: Mike Freemon <mfreemon@cloudflare.com>
Cc: Toke Høiland-Jørgensen <toke@toke.dk>
Cc: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Cc: Breno Leitao <leitao@debian.org>
Cc: Simon Schippers <simon.schippers@tu-dortmund.de>
Cc: kernel-team@cloudflare.com

-- 
2.43.0


