Return-Path: <netdev+bounces-271207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YG3cBUHPwmnRmQQAu9opvQ
	(envelope-from <netdev+bounces-271207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:52:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 80DFF31A578
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 18:52:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6D2F230B7B6F
	for <lists+netdev@lfdr.de>; Tue, 24 Mar 2026 17:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CE3F40B6CF;
	Tue, 24 Mar 2026 17:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VGORQV5G"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6B740824B
	for <netdev@vger.kernel.org>; Tue, 24 Mar 2026 17:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774374484; cv=none; b=EfRc3XKa6OyNjRpSdylXtvqBU48xcWIeM6rIp0n0b9Asyfzz6Gno5lnKyj96Eg/yADFesQMEiIUZGvL9PdDRT5X2nCMBfBZOu6BFEJ/TRIsNbp8JN8oAhaK5hBQsWC3vLT47N6mqODBBRkyZabVZaVOcwv6DjQnWwX9S4W6NAA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774374484; c=relaxed/simple;
	bh=2lT/nbKz2NsconMJ2mio1pAH/hxhyuVcITRVPeS+q1A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fpTwe8lr0taC+dVGH3UvyaqB7VxPM0ku4Dm6QYvjJGCEaJyzyZ89rx5RJg/AP6cFkUwCV905gyA0Ymr57H5Ms3VvZxU2d2Kk/GOMzVcTRxPshiOsOr6WAxVeDhUW2cVMxKrvqKkZFuLKuUAfiDSxPgo19dxCGOnn/Ys575xP9VI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VGORQV5G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B13AC19424;
	Tue, 24 Mar 2026 17:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774374483;
	bh=2lT/nbKz2NsconMJ2mio1pAH/hxhyuVcITRVPeS+q1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VGORQV5GgUylHTVACEHH1XRBmien8uZRQ48jDR3eytQ8iElbDZQOZRuknC2HzBWuG
	 qgYPluHBnI8guzVsc7zkCKYJz7KKZKl3KHizOYj1jEozp8aYiO55c17RdOBvx4QxEb
	 dc5M/7bW3jX79er78XaJ4Z1fTPxhWrvTlOF92MInAiWIpbJNECHlPXKZ2KX8+1Dpg7
	 8Eapi6rc8XfRv6u3HHxNcHXmhHkv2ALIp9JPYBjmC2pIbPeZvgBCrUqgYCBdqULANX
	 Lw6TzgjMWsGLPg8eZJSMI4l/yL8HtXfKtpvwywwo8IkLd8oLZsfbpHyP/fwKhXWzTO
	 ncGQxdeP05H+g==
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
Subject: [PATCH net-next 3/5] veth: add tx_timeout watchdog as BQL safety net
Date: Tue, 24 Mar 2026 18:47:02 +0100
Message-ID: <20260324174719.1224337-5-hawk@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-271207-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,tu-berlin.de:email]
X-Rspamd-Queue-Id: 80DFF31A578
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
index b9a79d066703..beb4c31d8fd7 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1426,6 +1426,22 @@ static int veth_set_channels(struct net_device *dev,
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
+	/* Clear both stop mechanisms:
+	 * - DRV_XOFF: set by netif_tx_stop_queue (ptr_ring backpressure)
+	 * - STACK_XOFF: set by BQL when byte limit is reached
+	 */
+	netdev_tx_reset_queue(txq);
+	netif_tx_wake_queue(txq);
+}
+
 static int veth_open(struct net_device *dev)
 {
 	struct veth_priv *priv = netdev_priv(dev);
@@ -1764,6 +1780,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1803,6 +1820,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(16000);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0


