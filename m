Return-Path: <netdev+bounces-292308-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QC4kBF74FmrUywcAu9opvQ
	(envelope-from <netdev+bounces-292308-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:57:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 685425E56D8
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:57:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B62D03007ADD
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:54:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238B742188B;
	Wed, 27 May 2026 13:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OeUm1MA8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE636354AE3
	for <netdev@vger.kernel.org>; Wed, 27 May 2026 13:54:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890071; cv=none; b=ld7m4mGeBPgIukzS+V1jKZ/q6ppPy83PT1gb0e3xPzmoUvABHoYX1kSNk45scNCfu5Gwf7Bkmdgnt+bjeTyeZcdamC2SkbE/jGBMSyPb+bDrq03XPHojeGRHdnXIaTY3zVJAh2oiH3TJU88QuoG9zJquu7C844PbelzndHRB8m8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890071; c=relaxed/simple;
	bh=GBP3Sbnyruj9fAjV93eGqs1e7ljlWfGQLDvD24nyxR4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Pi3AszbCg30FoDAHldLQQlIS7V6bt/0Fy/sMRNcyFvVjJqQNHXgUT++rDFjTdskVYiySoocjar1o8dVpHjDKUKwy5JaFcRKcZvUxfE0+Nu1Ae5bzXsV9ArWJGOaa25a0RyKrggmSklUkDNl71ncZ/m+KuyjmPcNNHcAXMEVNpUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OeUm1MA8; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1E0A41F000E9;
	Wed, 27 May 2026 13:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890069;
	bh=JGI7cOeuPCbJc5h2VlcjB/dkq7VJRxp4CYk5XvD2hyU=;
	h=From:To:Cc:Subject:Date;
	b=OeUm1MA8ftlVwayM9VBPnfuMSSseZL3IzunLdDxLY+UNSbUgRJNB+BykmmEAbHIcd
	 0BoXELAWlWCfCoeiJvn/rfa6qICRXz0MBOaBwPPNcWy8Rcw26cdLfHHjQc567VvXKK
	 Xav+AHohwr2H+2juALkStRWpKTqN1lnIkZRUY2mDY6NcNdXIBUbE8OHQDIILxtp7s2
	 4g89lCp6h8tTXTYEFQD9i1DumG57OTGOsBsRJs/DSR/yrupAtNIrrAKL1Coys42i1Q
	 xNm5PXnEClAnKMRuyQyWtpbIw485DXmRz/XZCgDkLLC+RmDRT/LjW1nQ+9hNUIwK0U
	 pWyD/vrj1pEhA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
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
	Simon Schippers <simon@schippers-hamm.de>,
	kernel-team@cloudflare.com
Subject: [PATCH net-next v6 0/5] veth: add Byte Queue Limits (BQL) support
Date: Wed, 27 May 2026 15:54:11 +0200
Message-ID: <20260527135418.1166665-1-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-292308-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 685425E56D8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

This series adds BQL (Byte Queue Limits) to the veth driver, reducing
latency by dynamically limiting in-flight packets in the ptr_ring and
moving buffering into the qdisc where AQM algorithms can act on it.

Problem: veth's 256-entry ptr_ring acts as a "dark buffer" invisible
to the qdisc's AQM.  Under load the ring fills, adding up to 256
packets of unmanaged latency before the qdisc sees congestion.

Solution: BQL stops the queue before the ring fills, pushing excess
packets into the qdisc where sojourn-based AQM can drop them.  V6 adds
time-based completion coalescing (ethtool tx-usecs, default 100 us)
so DQL converges on a limit that bounds actual queuing delay rather
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

Selftests:
  https://github.com/netoptimizer/veth-backpressure-performance-testing

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
Cc: Simon Schippers <simon@schippers-hamm.de>
Cc: kernel-team@cloudflare.com

Jesper Dangaard Brouer (4):
  net: add dev->bql flag to allow BQL sysfs for IFF_NO_QUEUE devices
  veth: implement Byte Queue Limits (BQL) for latency reduction
  veth: add tx_timeout watchdog as BQL safety net
  net: sched: add timeout count to NETDEV WATCHDOG message

Simon Schippers (1):
  veth: time-based BQL completion coalescing via ethtool tx-usecs

 .../networking/net_cachelines/net_device.rst  |   1 +
 drivers/net/veth.c                            | 198 +++++++++++++++++-
 include/linux/netdevice.h                     |   2 +
 net/core/net-sysfs.c                          |   8 +-
 net/sched/sch_generic.c                       |   8 +-
 5 files changed, 201 insertions(+), 16 deletions(-)

---
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

Prior versions:
  V5: https://lore.kernel.org/all/20260505132159.241305-1-hawk@kernel.org/
  V4: https://lore.kernel.org/all/20260501071633.644353-1-hawk@kernel.org/
  V3: https://lore.kernel.org/all/20260429172036.1028526-1-hawk@kernel.org/
  V2: https://lore.kernel.org/all/20260413094442.1376022-1-hawk@kernel.org/
  V1: https://lore.kernel.org/all/20260324174719.1224337-1-hawk@kernel.org/

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

-- 
2.43.0

