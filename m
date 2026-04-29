Return-Path: <netdev+bounces-282447-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CFvVOos+8mlypAEAu9opvQ
	(envelope-from <netdev+bounces-282447-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:23:23 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 322D7498259
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 19:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 927983067079
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 17:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B4FF410D39;
	Wed, 29 Apr 2026 17:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LOdH6bKo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA29C40FDBE;
	Wed, 29 Apr 2026 17:21:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777483269; cv=none; b=g69sUaroHVOqy5LAedlMxjnW038gOCYuF9+EJu4aIYD6cfdZ9ImhOHJVjB2lPoVTXdD8rWpOCXgoSncy5WFVTb4tGHrcSCoRfqvqQQff+AAQkTAEwRYRKcjCzMG2HPajC3sMniujThgvzag3OM/himdbYugo5+BiL+esjOsHtHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777483269; c=relaxed/simple;
	bh=CMgPFvxlON4+7OLw+PdbUMI/e6AKAVVQsp6VOR38JjM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZMPqoLKuxNgp9AiBhi0gNK4wkqEol1MN4ZP08oAHwxQtRsg5m9tYeOSIDqsusfVJddN/0fGz35vkoRgK9AINH9ofydPfHbVq9gblyivMhM6KTZfHHyVpOT5mQxX2XEIBoLGPiec1yrAnf4MqOxE3dUpNqoWZSQAWeAnzQ8K2mEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LOdH6bKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25E3C19425;
	Wed, 29 Apr 2026 17:20:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777483269;
	bh=CMgPFvxlON4+7OLw+PdbUMI/e6AKAVVQsp6VOR38JjM=;
	h=From:To:Cc:Subject:Date:From;
	b=LOdH6bKog+tIlKyTj0RTLhtWyd6AugOJJh1f5pXfyWrv1PlA8mYS38Fw97PtGZhtL
	 n6rlHNwYGvInyIbI9EGTfKLJ7QfaAZP+lzai2W+pkhFmuiX9UajPR+/RSnA1cZcYBf
	 okHDI3w9q3UBSz9ZiH3cvahNWEW64DkH7d2hL+MoRN2Lwh2TAcOeho730mOm6DTx41
	 +DDjI0E2jgGgCh13Fury48bWEf0LLDFLR5UrQun6XS/UZVGO7kob1vQtxe9WowIbHv
	 L3T2b6qVSQL2sZKnF9aGVhZ/dgddSgppWA9HeKIY/IVUUosog7JvqEkzkvfi8Y8cZN
	 x6aYzJPtg6yFQ==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kselftest@vger.kernel.org,
	Chris Arges <carges@cloudflare.com>,
	Mike Freemon <mfreemon@cloudflare.com>,
	=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Breno Leitao <leitao@debian.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v3 0/5] veth: add Byte Queue Limits (BQL) support
Date: Wed, 29 Apr 2026 19:20:27 +0200
Message-ID: <20260429172036.1028526-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 322D7498259
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-282447-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,toke.dk,tu-berlin.de,debian.org,iogearbox.net,gmail.com,fomichev.me];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	TO_DN_SOME(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

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
  flows like ICMP ping.  A fix for this has been applied to the net tree:
    https://git.kernel.org/netdev/net/c/815980fe6dbb

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
  caused by the dark buffer itself.  A fix has been applied to the net tree:
    https://git.kernel.org/netdev/net/c/815980fe6dbb

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
 drivers/net/veth.c                            |  94 +-
 include/linux/netdevice.h                     |   2 +
 net/core/net-sysfs.c                          |   8 +-
 net/sched/sch_generic.c                       |   8 +-
 tools/testing/selftests/net/Makefile          |   3 +
 tools/testing/selftests/net/config            |   1 +
 tools/testing/selftests/net/napi_poll_hist.bt |  40 +
 tools/testing/selftests/net/veth_bql_test.sh  | 821 ++++++++++++++++++
 .../selftests/net/veth_bql_test_virtme.sh     | 124 +++
 10 files changed, 1086 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/net/napi_poll_hist.bt
 create mode 100755 tools/testing/selftests/net/veth_bql_test.sh
 create mode 100755 tools/testing/selftests/net/veth_bql_test_virtme.sh

V2: https://lore.kernel.org/all/20260413094442.1376022-1-hawk@kernel.org/

Changes since V2:
  - Patch 2 (veth BQL): fix syzbot WARNING in veth_napi_del_range():
    clamp BQL reset loop to peer's real_num_tx_queues.  The loop was
    iterating dev->real_num_rx_queues but indexing peer's txq[], which
    goes out of bounds when the peer has fewer TX queues (e.g. veth
    enslaved to a bond with XDP attached).
  - Patch 5 (selftests): fix CONFIG_NET_SCH_SFQ alphabetical ordering
    in net/config (Breno Leitao).

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
  - Patch 5 (selftests): fix shellcheck warnings and infos:
    - Quote variables passed to kill_process and exit.
    - Declare and assign local variables separately (SC2155).
    - Use read -r to avoid mangling backslashes (SC2162).
    - Add shellcheck disable comments for intentional word splitting
      (set -- $line, tc $qdisc $opts) and indirect invocation (trap).
    - Make iptables-restore failure a hard FAIL instead of continuing.
    - Add veth_bql_test.sh to TEST_PROGS in net/Makefile.
    - Add veth_bql_test_virtme.sh to TEST_FILES (needs kernel build tree).
    - Add napi_poll_hist.bt to TEST_FILES in net/Makefile.
    - Add CONFIG_NET_SCH_SFQ=m to net/config (default qdisc is sfq).
    - Reduce default test duration from 300s to 30s for kselftest CI.
    - Fix virtme wrapper: empty args bug, check vmlinux instead of test path.
  - Cover letter: update CoDel fix reference to merged commit in net tree.

Cc: "David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@google.com>
Cc: Jakub Kicinski <kuba@kernel.org>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>
Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Cc: Chris Arges <carges@cloudflare.com>
Cc: Mike Freemon <mfreemon@cloudflare.com>
Cc: Toke Høiland-Jørgensen <toke@toke.dk>
Cc: Jonas Köppeler <j.koeppeler@tu-berlin.de>
Cc: Breno Leitao <leitao@debian.org>
Cc: kernel-team@cloudflare.com

-- 
2.43.0


