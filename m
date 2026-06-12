Return-Path: <netdev+bounces-298519-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id dGV4IOrEK2rGEgQAu9opvQ
	(envelope-from <netdev+bounces-298519-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:35:54 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA016677D8C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 10:35:53 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=XJeL0jHU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298519-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298519-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1A093304346C
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 08:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAE7835A3BF;
	Fri, 12 Jun 2026 08:35:38 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 786FF221721;
	Fri, 12 Jun 2026 08:35:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781253338; cv=none; b=ZnR/p0dzCFgzeELv1AkFw4VU/nLaon/wbu1wPW4XrrRxqucCJ3ilKQNdBzpCGRIQKKjBvQ4Ci6pdmP+gz8n8xS5u6ln8io+DLkLtj1BUKEIwPMylcn32Wda8M4d3jxlnyCP62/yg9I3pOk/h/JO6b4yA4r77gx7oAD/ZmrlvgK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781253338; c=relaxed/simple;
	bh=gi+KxDQWAoE6iCQ7B/uKnweekywnkmlvpqc+6XjmUs0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GdjLUiTE5AkYTDyTsyqlmiSBKj3zYwP9GxmUS9CdCP22uUGYaoxaSxgtpkuFOouM75Ldf9Fyuo+udjgcNX1IOqDckXtL2TCdCsozne3uAxtEkMiotqWb0p8yqsan/AiyT3Py+Vf1XINxEGyfn61Z1WWN4MoHrrYcxPrOXYfHaeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XJeL0jHU; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7B541F000E9;
	Fri, 12 Jun 2026 08:35:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781253337;
	bh=p3uQ7PUl/XTt+QFJA86ayYU5Tjov97jDvKlT4lyYFnc=;
	h=From:To:Cc:Subject:Date;
	b=XJeL0jHUrbR63A12uao3iWCIUtU3f69jmUJmx010qvH7aabAfnHQiSW6k8AlGZjp1
	 jJVouPGjhl6l1wxcxA3wc/khO/EGdk+p0GS8s1ZtJG0yR/JdG63uzMN5ODhFwP/3L2
	 6p6nfQm5T8ronblIf0uTtFAJklgRB4Ge/7rTUxfDanlx3+mM4F3n8TzSZMXeZn0V/M
	 AnE8AZrVMgkC4PeUbjJ4a45yWBjx4MD68BFtbVjP+gZhDcXmfCkDH5jHLzUm71bAB3
	 fxZrl/vZiwDSwWh/dHRv8Le59DxAbVS++trq0SK8ivDcJmG6R3hxh6KQMB4mIPALvq
	 qUiYgI/GozB1A==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: kernel-team@cloudflare.com,
	simon.schippers@tu-dortmund.de,
	Jesper Dangaard Brouer <hawk@kernel.org>,
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
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	bpf@vger.kernel.org
Subject: [PATCH net-next v7 0/5] veth: add Byte Queue Limits (BQL) support
Date: Fri, 12 Jun 2026 10:35:23 +0200
Message-ID: <20260612083530.1650245-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-298519-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:kernel-team@cloudflare.com,m:simon.schippers@tu-dortmund.de,m:hawk@kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:carges@cloudflare.com,m:mfreemon@cloudflare.com,m:toke@toke.dk,m:j.koeppeler@tu-berlin.de,m:leitao@debian.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:sdf@fomichev.me,m:bpf@vger.kernel.org,m:johnfastabend@gmail.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_TWELVE(0.00)[19];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[cloudflare.com,tu-dortmund.de,kernel.org,davemloft.net,google.com,redhat.com,toke.dk,tu-berlin.de,debian.org,iogearbox.net,gmail.com,fomichev.me,vger.kernel.org];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA016677D8C

From: Jesper Dangaard Brouer <hawk@kernel.org>

This series adds BQL (Byte Queue Limits) to the veth driver, reducing
latency by dynamically limiting in-flight packets in the ptr_ring and
moving buffering into the qdisc where AQM algorithms can act on it.

Problem: veth's 256-entry ptr_ring acts as a "dark buffer" invisible
to the qdisc's AQM.  Under load the ring fills, adding up to 256
packets of unmanaged latency before the qdisc sees congestion.

Solution: BQL stops the queue before the ring fills, pushing excess
packets into the qdisc where sojourn-based AQM can drop them.
Time-based completion coalescing (ethtool tx-usecs, default 100 us)
lets DQL converge on a limit that bounds actual queuing delay rather
than oscillating at limit=2 with per-packet completion.

Test setup: veth pair, UDP flood, 13000 iptables rules in consumer
namespace (slows NAPI-64 cycle to ~6-7 ms).  Ping measures RTT.

                   BQL off                    BQL on
  fq_codel:  RTT ~22 ms, 4% loss        RTT ~1.3 ms, 0% loss
  sfq:       RTT ~24 ms, 0% loss        RTT ~1.5 ms, 0% loss

BQL reduces ping RTT by ~17x for both qdiscs.  Consumer throughput
unchanged.

Why BQL over configurable ring size (ethtool -G): BQL auto-tunes per
workload via DQL; a static ring size requires per-setup manual tuning
and a too-small ring drops XDP packets in batches of 16-64.

Selftests: https://github.com/netoptimizer/veth-backpressure-performance-testing

Background:
  Mike Freemon reported the veth dark buffer problem internally at
  Cloudflare and showed that recompiling with ptr_ring size 30 made
  fq_codel work dramatically better -- motivating a dynamic BQL
  solution.  Chris Arges wrote the reproducer.  Jonas Koeppeler and
  Simon Schippers provided extensive testing and code review.

  During BQL development we also fixed an unrelated 12-year-old CoDel
  bug (stale first_above_time in empty flows), see
  commit 815980fe6dbb ("net_sched: codel: fix stale state for empty flows in fq_codel").
  BQL remains valuable independently.

Patch overview:
  1. net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  2. veth: implement Byte Queue Limits (BQL) for latency reduction
  3. veth: add tx_timeout watchdog as BQL safety net
  4. net: sched: add timeout count to NETDEV WATCHDOG message
  5. veth: time-based BQL completion coalescing via ethtool tx-usecs

Jesper Dangaard Brouer (4):
  net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  veth: implement Byte Queue Limits (BQL) for latency reduction
  veth: add tx_timeout watchdog as BQL safety net
  net: sched: add timeout count to NETDEV WATCHDOG message

Simon Schippers (1):
  veth: time-based BQL completion coalescing via ethtool tx-usecs

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

---
Changes since V6:
  - Patch 2 (teardown): rework veth_napi_del_range() to drain the ptr_ring
    and balance the peer txq's BQL/DQL by completing the outstanding charges
    via netdev_tx_completed_queue(), instead of netdev_tx_reset_queue().
    dql_reset() races with a concurrent producer, whereas completion is the
    normal single-completer path and is safe once NAPI is gone
    (synchronize_net()) and the producer has stopped charging BQL (it
    observes rq->napi == NULL).  Fixes races reported by sashiko.  The
    peer txq is still woken to clear any leaked DRV_XOFF.
  - Patch 2: document the lltx/DQL locking model at the BQL charge site --
    veth is lltx so the stack skips HARD_TX_LOCK; the ring producer_lock is
    the single-producer lock for dql_queued() (1:1 with the peer txq) and
    the peer NAPI in veth_xdp_rcv() is the single completer.
  - Patch 3 (watchdog): add a VETH_WATCHDOG_TIMEOUT_MS #define for the
    tx_timeout value instead of an inline magic number, and expand the
    math behind the value (64-packet NAPI budget * 250 ms/pkt = 16 s)
    in a comment (Paolo).
  - Patches 2+5: add Co-developed-by for Jonas Koeppeler.
  - Patch 5 (coalescing): flush when n_bql exceeds dql.limit to handle
    BQL starvation.  Removes the empty-ring STACK_XOFF check (and its
    smp_rmb) -- the dql.limit comparison handles it more directly.
  - Patch 5: at teardown, also complete the coalesced bql_state.n_bql
    pending from the last NAPI poll, on top of the patch 2 ring drain.
  - Patch 5: mirror tx_coal_usecs onto the peer in veth_set_coalesce() so
    a veth pair always coalesces symmetrically; the completion path reads
    its own device's value.
  - Patch 5: use WRITE_ONCE/READ_ONCE for tx_coal_usecs (Paolo).
  - Patch 5: init bql_state before napi_enable() to avoid race (sashiko).
  - Patch 5: tx-usecs=0 handled as normal path, no special case.
  - Patch 5: n_bql type changed to uint; explicit if/++ instead of
    implicit bool-to-int addition.
  - Patch 5: call veth_bql_maybe_complete() on every iteration for
    accurate completion intervals with mixed XDP/non-XDP packets.
  - Patch 5: reject tx-usecs above half the tx_timeout watchdog in
    veth_set_coalesce() (return -ERANGE) -- the coalescing window delays
    BQL completions, so an over-large value could trip a false watchdog;
    half the watchdog leaves a generous margin.

Prior versions:
  V6: https://lore.kernel.org/all/20260527135418.1166665-1-hawk@kernel.org/
  V5: https://lore.kernel.org/all/20260505132159.241305-1-hawk@kernel.org/
  V4: https://lore.kernel.org/all/20260501071633.644353-1-hawk@kernel.org/
  V3: https://lore.kernel.org/all/20260429172036.1028526-1-hawk@kernel.org/
  V2: https://lore.kernel.org/all/20260413094442.1376022-1-hawk@kernel.org/
  V1: https://lore.kernel.org/all/20260324174719.1224337-1-hawk@kernel.org/

Changes since V5:
  - Drop patch 1 (OOB txq fix) -- applied to net tree by Paolo as
    08f566e8f83b, already in net-next.
  - New patch 5: time-based BQL completion coalescing via ethtool
    tx-usecs (Simon Schippers).  Resolves the throughput regression
    Paolo flagged on V5: per-packet completion forced DQL to limit=2,
    causing cache-line bouncing between producer/consumer CPUs.
    Coalescing batches completions on a configurable time threshold
    (default 100 us), letting DQL discover a higher useful limit.
  - Patch 2: use __ptr_ring_check_produce() instead of open-coded
    ring-full check (Simon Schippers nit).

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

Changes since V3:
  - Drop selftest patch (patch 5 from V3) per maintainer request.
  - Rebase on latest net-next.

Changes since V2:
  - Patch 2 (veth BQL): fix syzbot WARNING in veth_napi_del_range():
    clamp BQL reset loop to peer's real_num_tx_queues.  The loop was
    iterating dev->real_num_rx_queues but indexing peer's txq[], which
    goes out of bounds when the peer has fewer TX queues (e.g. veth
    enslaved to a bond with XDP attached).

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

 .../networking/net_cachelines/net_device.rst  |   1 +
 drivers/net/veth.c                            | 267 +++++++++++++++++-
 include/linux/netdevice.h                     |   2 +
 net/core/net-sysfs.c                          |   8 +-
 net/sched/sch_generic.c                       |   6 +-
 5 files changed, 270 insertions(+), 14 deletions(-)

-- 
2.43.0


