Return-Path: <netdev+bounces-284868-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO9NLDNP+2lFZQMAu9opvQ
	(envelope-from <netdev+bounces-284868-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:24:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 430C44DC184
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 16:24:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 487A330269E9
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 14:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC6D4963A8;
	Wed,  6 May 2026 14:11:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="BnIouqo9"
X-Original-To: netdev@vger.kernel.org
Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53690492510;
	Wed,  6 May 2026 14:11:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778076666; cv=none; b=NXUltGrJ1XE2BspuMuHecVlfIGs7aZVcL5xTdMmX4QqfqFUWt3Eg4u3mud9ccp4HzqUGoTSMlG20DZtRPTsFVvCVT+4QH3b+3d73P6m6tTuDAdyO6KdCxLuhuF/JTa6G9jmX5RgA+ocgJ2R15oES24Z4YKsRvwLOjyyxjwZApbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778076666; c=relaxed/simple;
	bh=4ebU+CzqnDYV0UkRyUU+znmrPZfYugt+GMlID6BAu2c=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SGq/wUKIwdOvXy5xN8rpBfVohLMII6MHf0c8UQqPRMSD62oijmPC9S+qXlItGIf94jXhzJtiGAs/IePeVZmMMnDTW6kH3hXeMXxEyzJxYJRs+4RWNv8qDXhJr5nYpVpcRRaJkZFUAwG1QzhpKxRhKCEcDK8Uz3YI/e+foX0IB80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=BnIouqo9; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1778076651;
	bh=4ebU+CzqnDYV0UkRyUU+znmrPZfYugt+GMlID6BAu2c=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=BnIouqo9aw7E1ZEEos6exl6iXUN5iKqDZyZXkhLsT2Eb3KUvekuftMwDwN+dRnop2
	 eP6wJu07vliZ5TKH973DkXkpzQbD8ozDexKg+nJNB52A6B4sHmzM5MuJsNEGjkLCGP
	 OP4HuNWjSJUI8tp6n4cEYckwGPwmdK1CzlxJ0No0=
Received: from simon-Latitude-5450.cni.e-technik.tu-dortmund.de ([129.217.186.46])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.1/8.19.0.1) with ESMTPSA id 646EAnWe015408
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 6 May 2026 16:10:51 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
Subject: [PATCH net-next v10 4/4] tun/tap & vhost-net: avoid ptr_ring tail-drop when a qdisc is present
Date: Wed,  6 May 2026 16:10:33 +0200
Message-ID: <20260506141033.180450-5-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
References: <20260506141033.180450-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 430C44DC184
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tu-dortmund.de,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[tu-dortmund.de:s=unimail];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,networkplumber.org,nutanix.com,tu-dortmund.de,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-284868-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[simon.schippers@tu-dortmund.de,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[tu-dortmund.de:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_TWELVE(0.00)[18];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-dortmund.de:email,tu-dortmund.de:dkim,tu-dortmund.de:mid]

This commit prevents tail-drop when a qdisc is present and the ptr_ring
becomes full. Once an entry is successfully produced and the ptr_ring
reaches capacity, the netdev queue is stopped instead of dropping
subsequent packets. If no qdisc is present, the previous tail-drop
behavior is preserved.

If producing an entry fails anyways due to a race, tun_net_xmit() drops
the packet. Such races are expected because LLTX is enabled and the
transmit path operates without the usual locking.

The __tun_wake_queue() function of the consumer races with the producer
for waking/stopping the netdev queue, which could result in a stalled
queue. Therefore, an smp_mb__after_atomic() is introduced that pairs
with the smp_mb() of the consumer. It follows the principle of store
buffering described in tools/memory-model/Documentation/recipes.txt:

- The producer in tun_net_xmit() first sets __QUEUE_STATE_DRV_XOFF,
  followed by an smp_mb__after_atomic() (= smp_mb()), and then reads the
  ring with __ptr_ring_produce_peek().

- The consumer in __tun_wake_queue() first writes zero to the ring in
  __ptr_ring_consume(), followed by an smp_mb(), and then reads the queue
  status with netif_tx_queue_stopped().

=> Following the aforementioned principle, it is impossible for the
   producer to see a full ring (and therefore not wake the queue on the
   re-check) while the consumer simultaneously fails to see a stopped
   queue (and therefore also does not wake it).

Benchmarks:
The benchmarks show a slight regression in raw transmission performance
when using two sending threads. Packet loss also occurs only in the
two-thread sending case; no packet loss was observed with a single
sending thread.

Test setup:
AMD Ryzen 5 5600X at 4.3 GHz, 3200 MHz RAM, isolated QEMU threads;
Average over 50 runs @ 100,000,000 packets. SRSO and spectre v2
mitigations disabled.

Note for tap+vhost-net:
XDP drop program active in VM -> ~2.5x faster; slower for tap due to
more syscalls (high utilization of entry_SYSRETQ_unsafe_stack in perf)

+--------------------------+--------------+----------------+----------+
| 1 thread                 | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 1.132 Mpps   | 1.133 Mpps     | +0.1%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 3.765 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 3.857 Mpps   | 3.905 Mpps     | +1.2%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 0.802 Mpps   | 0 pps          |          |
+------------+-------------+--------------+----------------+----------+

+--------------------------+--------------+----------------+----------+
| 2 threads                | Stock        | Patched with   | diff     |
| sending                  |              | fq_codel qdisc |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 1.115 Mpps   | 1.092 Mpps     | -2.1%    |
|            +-------------+--------------+----------------+----------+
|            | Lost/s      | 8.490 Mpps   | 359 pps        |          |
+------------+-------------+--------------+----------------+----------+
| TAP        | Received    | 3.664 Mpps   | 3.549 Mpps     | -3.1%    |
|            +-------------+--------------+----------------+----------+
| +vhost-net | Lost/s      | 5.330 Mpps   | 832 pps        |          |
+------------+-------------+--------------+----------------+----------+

Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c | 25 +++++++++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index fc358c4c355b..d9ffbf88cfd8 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -1018,6 +1018,7 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct netdev_queue *queue;
 	struct tun_file *tfile;
 	int len = skb->len;
+	int ret;
 
 	rcu_read_lock();
 	tfile = rcu_dereference(tun->tfiles[txq]);
@@ -1072,13 +1073,33 @@ static netdev_tx_t tun_net_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	nf_reset_ct(skb);
 
-	if (ptr_ring_produce(&tfile->tx_ring, skb)) {
+	queue = netdev_get_tx_queue(dev, txq);
+
+	spin_lock(&tfile->tx_ring.producer_lock);
+	ret = __ptr_ring_produce(&tfile->tx_ring, skb);
+	if (!qdisc_txq_has_no_queue(queue) &&
+	    (__ptr_ring_produce_peek(&tfile->tx_ring) || ret)) {
+		netif_tx_stop_queue(queue);
+		/* Paired with smp_mb() in __tun_wake_queue() */
+		smp_mb__after_atomic();
+		if (!__ptr_ring_produce_peek(&tfile->tx_ring))
+			netif_tx_wake_queue(queue);
+	}
+	spin_unlock(&tfile->tx_ring.producer_lock);
+
+	if (ret) {
+		/* This should be a rare case if a qdisc is present, but
+		 * can happen due to lltx.
+		 * Since skb_tx_timestamp(), skb_orphan(),
+		 * run_ebpf_filter() and pskb_trim() could have tinkered
+		 * with the SKB, returning NETDEV_TX_BUSY is unsafe and
+		 * we must drop instead.
+		 */
 		drop_reason = SKB_DROP_REASON_FULL_RING;
 		goto drop;
 	}
 
 	/* dev->lltx requires to do our own update of trans_start */
-	queue = netdev_get_tx_queue(dev, txq);
 	txq_trans_cond_update(queue);
 
 	/* Notify and wake up reader process */
-- 
2.43.0


