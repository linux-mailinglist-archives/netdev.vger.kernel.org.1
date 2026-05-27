Return-Path: <netdev+bounces-292311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aD5qJsf3FmrUywcAu9opvQ
	(envelope-from <netdev+bounces-292311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:55:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 386605E5639
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 15:55:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6EB4230323B7
	for <lists+netdev@lfdr.de>; Wed, 27 May 2026 13:54:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC2F2421EFB;
	Wed, 27 May 2026 13:54:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ef7zP2nM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 488393D3337;
	Wed, 27 May 2026 13:54:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779890085; cv=none; b=dchsmFgv2hHtUbnH8zMDmGNFnYVqnwRFIoSCxriDwdKJf+5GHnK4/muWI0yKQsvrQ1BuIL11LmdZE6KaX+JRkrxT9OTYQ3efRBfhpH488umjZkqnT1/Uu/ly9wxP+IzliP+23uX5BaKbQa6/gUEPjnN5Pp+JLDc+aX4r06tmDMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779890085; c=relaxed/simple;
	bh=HIMLdcqHsEo5Rklq6VlFUdLmvZ2giDFHdQRBxcR7wgQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qRaneEFOI+XMyQPr+m30f5szt7SwpjWY1v3PTmqiD0xnHGwatSpJ1/tPaXicwQ0hg9pppPTf4EyjFxJ3DVkfT8K0So7vMA1Z8tFUZour5ZS2BWtpoctLXvMW3XIFOcGT+EYTdsgfPUiBDOm/49J/zSovFBdAgpdL4TwwSljTjhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ef7zP2nM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 552421F00A3D;
	Wed, 27 May 2026 13:54:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779890080;
	bh=6Ka+n7OBUP0yYWoq+9tlyGt/+12faQ5c1Cvz9bdk5Lg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ef7zP2nMAq6rpZezWdKuqpxQU10YIRkj4z4rUaGrm8X9CMaILwzboWYSlyvg1GtS3
	 bX3HCbP8+5vC2ddBb9Aoq0rnpxsgeGTlawxU3iqhJfo1VAlPKwGI5GIyzyP5avyZyC
	 IvCQTp0yJZaK/wuNsdVci9tL4TObV60N64fMsEUu7myPewbEWVnyuRBX4cEruPYZ3q
	 rseU4claw7CNQKT4+sVrvX1Xq1FbIuZtZQoR54P9Hy0PlP+hpCeyEGNVnHOIglmnmi
	 3WunN01EAzh5QFdesB284/dJ3RBOpeKlEKJ3TyuOHhF2MdRFqk4oyuKza2ptpT39z1
	 3ZXDkRrHQ3OZw==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 3/5] veth: add tx_timeout watchdog as BQL safety net
Date: Wed, 27 May 2026 15:54:14 +0200
Message-ID: <20260527135418.1166665-4-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260527135418.1166665-1-hawk@kernel.org>
References: <20260527135418.1166665-1-hawk@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-292311-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tu-berlin.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 386605E5639
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Jesper Dangaard Brouer <hawk@kernel.org>

With the introduction of BQL (Byte Queue Limits) for veth, there are
now two independent mechanisms that can stop a transmit queue:

 - DRV_XOFF: set by netif_tx_stop_queue() when the ptr_ring is full
 - STACK_XOFF: set by BQL when the byte-in-flight limit is reached

If either mechanism stalls without a corresponding wake/completion,
the queue stops permanently. Enable the net device watchdog timer and
implement ndo_tx_timeout as a failsafe recovery.

The timeout handler resets BQL state (clearing STACK_XOFF) and wakes
the queue (clearing DRV_XOFF), covering both stop mechanisms. The
watchdog fires after 16 seconds, which accommodates worst-case NAPI
processing (budget=64 packets x 250ms per-packet consumer delay)
without false positives under normal backpressure.

Signed-off-by: Jesper Dangaard Brouer <hawk@kernel.org>
Tested-by: Jonas Köppeler <j.koeppeler@tu-berlin.de>
---
 drivers/net/veth.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/drivers/net/veth.c b/drivers/net/veth.c
index 21ff78533943..d5675d9d5236 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1442,6 +1442,22 @@ static int veth_set_channels(struct net_device *dev,
 	goto out;
 }
 
+static void veth_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct netdev_queue *txq = netdev_get_tx_queue(dev, txqueue);
+
+	netdev_err(dev,
+		   "veth backpressure(0x%lX) stalled(n:%ld) TXQ(%u) re-enable\n",
+		   txq->state, atomic_long_read(&txq->trans_timeout), txqueue);
+
+	/* Cannot call netdev_tx_reset_queue(): dql_reset() races with
+	 * peer NAPI calling dql_completed() concurrently.
+	 * Just clear the stop bits; the qdisc will re-stop if still stuck.
+	 */
+	clear_bit(__QUEUE_STATE_STACK_XOFF, &txq->state);
+	netif_tx_wake_queue(txq);
+}
+
 static int veth_open(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
@@ -1780,6 +1796,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1819,6 +1836,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(16000);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0


