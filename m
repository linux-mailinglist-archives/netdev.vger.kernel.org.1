Return-Path: <netdev+bounces-286298-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kDl4Cb6hAGqTLAEAu9opvQ
	(envelope-from <netdev+bounces-286298-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:18:22 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D41504C50
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 17:18:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 285E5300D631
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 15:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DE5039FCD0;
	Sun, 10 May 2026 15:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="qtB+4LQj"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CBC039EF1A;
	Sun, 10 May 2026 15:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778426276; cv=none; b=JfMiWagJL6vq9oMC0oBSQJl7QhLtSedGWaP2jWmA+zz08ygRftuBt1Nzu2HYhOY0cG7l7yZRvpvgzyDGDfSgbhob5ONVDXnjcsz3Ad3s7uHH4E7uD0gw+SNHGS3Yj3nzo35TCEE6dq5upD8QlSMwhKBLbHrJ5SFZ+svdV8OjW5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778426276; c=relaxed/simple;
	bh=kgUtIdmSmQrv9eOIVZgv1f+W5y415aK1wJ6VOR/nZyw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=KlcvyqC5kgkG2JuR7NbCPPYvNPNycWlOt7vrFyJAirTpPClvZKZp8WX0Okt1Q/PCPR14neK21YGgvslmb6vh1ijsbRCslsbRGPO390X/0JIynMrL7/YfUb9BeeBMv7nGWsGJg62fSfBf/pC/vpcWm5UvO/orgLEcGVI8CYa32ns=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=qtB+4LQj; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778426258;
	bh=kgUtIdmSmQrv9eOIVZgv1f+W5y415aK1wJ6VOR/nZyw=;
	h=From:To:Subject:Date;
	b=qtB+4LQj7cD/K60MTODPDCK+s05YD3Xe8htid9R+B3Jn7LiWQ9SZeO1wHAeCwu+Zi
	 yg02PzyqbcjGplvUdggxKoYNNEbTYKDYZCGw7Ipi2LeLZsCZXZzLRZzak/E6v+1SKR
	 fyU6WQClDx8saTyp9pgffF+zJ6pZhNcl5CJdM9RI=
Received: from simon-Latitude-5450.fritz.box (pd9eaa57d.dip0.t-ipconnect.de [217.234.165.125])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 64AFHaT8009831
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Sun, 10 May 2026 17:17:37 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v12 0/4] tun/tap & vhost-net: apply qdisc backpressure on full ptr_ring to reduce TX drops
Date: Sun, 10 May 2026 17:15:25 +0200
Message-ID: <20260510151529.43895-1-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90D41504C50
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-286298-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.989];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,stackexchange.com:url]
X-Rspamd-Action: no action

This patch series deals with tun/tap & vhost-net which drop incoming
SKBs whenever their internal ptr_ring buffer is full. Instead, with this 
patch series, the associated netdev queue is stopped - but only when a
qdisc is attached. If no qdisc is present the existing behavior is
preserved. The XDP transmit path is not affected. This patch series
touches tun/tap and vhost-net, as they share common logic and must be
updated together. Modifying only one of them would break the other.

By applying proper backpressure, this change allows the connected qdisc to 
operate correctly, as reported in [1], and significantly improves
performance in real-world scenarios, as demonstrated in our paper [2]. For 
example, we observed a 36% TCP throughput improvement for an OpenVPN 
connection between Germany and the USA.

Synthetic pktgen benchmarks indicate a slight regression, and packet
loss is reduced to near zero. Pktgen benchmarks are provided per commit,
with the final commit showing the overall performance.

Thanks!

[1] Link: https://unix.stackexchange.com/questions/762935/traffic-shaping-ineffective-on-tun-device
[2] Link: https://cni.etit.tu-dortmund.de/storages/cni-etit/r/Research/Publications/2025/Gebauer_2025_VTCFall/Gebauer_VTCFall2025_AuthorsVersion.pdf

---
Changelog:
v12:
Patch 1: 
- Revert tun_queue_purge() to plain ptr_ring_consume() and instead
  explicitly wake the queue in __tun_detach() for the ntfile taking
  over the queue slot (if its ring is empty).
- Inlined tun_reset_cons_cnt(), because only tun_attach() uses it.

- Patches 2-4 and cover letter unchanged.
- Compiled and short pktgen test.

v11:
- Renamed __ptr_ring_produce_peek() to __ptr_ring_check_produce()
  (Sashiko)
- Add return code -EINVAL to __ptr_ring_check_produce() which lets
  tun_net_xmit() stop the queue only on -ENOSPC. (MST)
- Resolve race on tfile->queue_index by locking tx_ring.consumer_lock
  in __tun_detach(). (Sashiko)
- Wake the queue in tun_queue_resize() to avoid possible stalls.
- Other minor adjustments & reran the benchmarks.

v10: https://lore.kernel.org/netdev/20260506141033.180450-1-simon.schippers@tu-dortmund.de/
- Changed the term "Transmitted" to "Received" in the benchmarks,
  as correctly pointed out by MST, and reran the benchmarks.

Addressed the Sashiko AI review:
- Avoid a data race on tfile->cons_cnt by always locking.
- Correctly count the number of consumed packets for vhost-net.
- Corrected a typo in the commit message of commit 3.
- Added a missing barrier on the consumer side.
--> The barriers now follow the "store buffering" principle.
- No longer return NETDEV_TX_BUSY at all, because it is unsafe.
--> Result: There are still a few drops with multiple senders, which
            would be avoided by disabling LLTX.

V9: https://lore.kernel.org/netdev/20260428123859.19578-1-simon.schippers@tu-dortmund.de/
- Addressed minor nit by MST in patches 1 and 2.
- Rebased patch 3 because of commit d748047
  ("ptr_ring: disable KCSAN warnings").
- Documented the pair of the smp_mb__after_atomic() in tun_net_xmit()
  with tun_ring_consume().
  --> It simply pairs with the test_and_clear_bit() inside of
      netif_wake_subqueue().
- Use 1 ptr_ring consumer spinlock instead of 2.
- Ran pktgen benchmarks with pg_set SHARED for 50 iterations on
  latest kernel
  --> No significant performance difference noticed

V8: https://lore.kernel.org/netdev/20260312130639.138988-1-simon.schippers@tu-dortmund.de/
- Drop code changes in drivers/net/tap.c; The code there deals with
  ipvtap/macvtap which are unrelated to the goal of this patch series
  and I did not realize that before
-> Greatly simplified logic, 4 instead of 9 commits
-> No more duplicated logics and distinction in vhost required
- Only wake after the queue stopped and half of the ring was consumed
  as suggested by MST
-> Performance improvements for TAP, but still slightly slower
- Better benchmarking with pinned threads, XDP drop program for
  tap+vhost-net and disabling CPU mitigations (and newer Ryzen 5 5600X
  processor) as suggested by Jason Wang

V7: https://lore.kernel.org/netdev/20260107210448.37851-1-simon.schippers@tu-dortmund.de/
- Switch to an approach similar to veth (excluding the recently fixed 
variant), as suggested by MST, with minor adjustments discussed in V6
- Rename the cover-letter title
- Add multithreaded pktgen and iperf3 benchmarks, as suggested by Jason 
Wang
- Rework __ptr_ring_consume_created_space() so it can also be used after 
batched consume

...

---

Simon Schippers (4):
  tun/tap: add ptr_ring consume helper with netdev queue wakeup
  vhost-net: wake queue of tun/tap after ptr_ring consume
  ptr_ring: move free-space check into separate helper
  tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present

 drivers/net/tun.c        | 109 ++++++++++++++++++++++++++++++++++++---
 drivers/vhost/net.c      |  21 +++++---
 include/linux/if_tun.h   |   3 ++
 include/linux/ptr_ring.h |  20 ++++++-
 4 files changed, 139 insertions(+), 14 deletions(-)

-- 
2.43.0


