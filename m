Return-Path: <netdev+bounces-283132-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cHNIKYRT9GmsAgIAu9opvQ
	(envelope-from <netdev+bounces-283132-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:17:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC164AAEBB
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 09:17:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 27BFB3012BE7
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 07:17:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDB0D369206;
	Fri,  1 May 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GalY/qwM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB4483630AC;
	Fri,  1 May 2026 07:16:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777619818; cv=none; b=MEJxWkPu1YW/qhflXjWdywWhg/wEMLbyOe+CKNYJW1ADWOmc+D1UKmbOMBBJT1iCaVJUivHkouCg0zBB5vtHTmAwAX2GJOLNOKvjM8Larl5PmMdd/8F5kNXAsNkAKKRg1dhq0Ry8KxDNPYfXT+yRbiRuOIq35bwg8YgJvaWTcWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777619818; c=relaxed/simple;
	bh=gb8XJrhOM7OyaOgd25hPYdSzkbBzhMyrw+KarXVSWas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cqFLD1Ry0WKtKESOzZtlSGg5xIlWcIIxeCCCVddT4I4XniMMkW1/If5dD/xX1pLxukTGl6jZJ0WDVfaylT3zPcLyFt5UwT+QeSgJUWiprUjdAfvAVzQtbO7H04rTYo9HQWcs+q/FDsc+elGdKNlxMYyn5/AORWK2mPYjeAamtiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GalY/qwM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49FCDC2BCB4;
	Fri,  1 May 2026 07:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777619818;
	bh=gb8XJrhOM7OyaOgd25hPYdSzkbBzhMyrw+KarXVSWas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GalY/qwMtb24EnSMgl0fbgbwYrGaQWGukDlitoWGb+/hgZw4NYQEDQY2+Gts3SSZE
	 48CMwhsz+ySe1q895PY8Lt7gvP9ItOgW1jzsAsWL3nAP7+jsuEmOkGJ2TdCl3IjQWY
	 oVEwOv//teuHEkC2GL/Lgb/18hxytSWeWpao+gOP8rN/5X9iVfLC/DUX+hwLgLLUpN
	 y6tk6Hep2GIsdMx+Z6hnQdlvYqC/AfELzIiNr0lc1qgMDK+LScSAq/BnJrWl5w5hAR
	 Aa2aVoOxLcVGPmZXNdgrN/4AliZawdfuoggpJTaTdEUDmS97XWSpoAxvTNCQKYIcyH
	 UrgAcEOHswZPA==
From: hawk@kernel.org
To: netdev@vger.kernel.org
Cc: hawk@kernel.org,
	kernel-team@cloudflare.com,
	=?UTF-8?q?Jonas=20K=C3=B6ppeler?= <j.koeppeler@tu-berlin.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 3/4] veth: add tx_timeout watchdog as BQL safety net
Date: Fri,  1 May 2026 09:16:30 +0200
Message-ID: <20260501071633.644353-4-hawk@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260501071633.644353-1-hawk@kernel.org>
References: <20260501071633.644353-1-hawk@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4FC164AAEBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-283132-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hawk@kernel.org,netdev@vger.kernel.org];
	FROM_NO_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,tu-berlin.de:email]

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
index 3de25ba34a90..9d7b085c9548 100644
--- a/drivers/net/veth.c
+++ b/drivers/net/veth.c
@@ -1431,6 +1431,22 @@ static int veth_set_channels(struct net_device *dev,
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
@@ -1769,6 +1785,7 @@ static const struct net_device_ops veth_netdev_ops = {
 	.ndo_bpf		= veth_xdp,
 	.ndo_xdp_xmit		= veth_ndo_xdp_xmit,
 	.ndo_get_peer_dev	= veth_peer_dev,
+	.ndo_tx_timeout		= veth_tx_timeout,
 };
 
 static const struct xdp_metadata_ops veth_xdp_metadata_ops = {
@@ -1808,6 +1825,7 @@ static void veth_setup(struct net_device *dev)
 	dev->priv_destructor = veth_dev_free;
 	dev->pcpu_stat_type = NETDEV_PCPU_STAT_TSTATS;
 	dev->max_mtu = ETH_MAX_MTU;
+	dev->watchdog_timeo = msecs_to_jiffies(16000);
 
 	dev->hw_features = VETH_FEATURES;
 	dev->hw_enc_features = VETH_FEATURES;
-- 
2.43.0


