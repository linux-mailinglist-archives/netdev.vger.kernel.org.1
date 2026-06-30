Return-Path: <netdev+bounces-302950-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id HtoLHyhEQ2oUWQoAu9opvQ
	(envelope-from <netdev+bounces-302950-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:20:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id EA1276E03BA
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 06:20:55 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=WepGYRF2;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-302950-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-302950-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4859130889BF
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 04:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948873E6DDD;
	Tue, 30 Jun 2026 04:16:52 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD1453E5A31
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 04:16:50 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782793012; cv=none; b=EP5B0nSfBvdjFMlv+1mwxakFRqicFENJ/MgcX5lJGZH2pFlVHF31H0PDbLf5JPwcd/I0YUXxwZXr+GUcyVi0NUqGsOpIi9elViF2c5/kgplT81MH/Ar0XQrgUdsvnuyHsyMwLIj7bTrYfXRJ/lK5AYn2rWdAWJ2no6Y4fP8LxnI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782793012; c=relaxed/simple;
	bh=64aL75OIgqDclMA6C8tWWwaoVnGiBmBtYT/k0X5tWGo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G5tPXKHhESpIHQJw3LjVNbzRZR1HPY8A4Var2zLVjVoghaMknp5hc1I9unSXjuuNfmB6Co2PXa9GOeXSz+dbhCoHD1lDHAEzlCkFYEi/tC/uIyxAwAC15T8a3ySBhC8QsqzzFU1Z0qpJxZXj2WPGjFC7cFAb7y3t0T06PFpCOiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WepGYRF2; arc=none smtp.client-ip=209.85.215.169
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-c8fee9f63d5so1616635a12.0
        for <netdev@vger.kernel.org>; Mon, 29 Jun 2026 21:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782793010; x=1783397810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9NXRc86Umg+xwqOwvqqu82cgLkqOtrrtEqy6z9NCU5o=;
        b=WepGYRF2oX2AX4FpdPtkA5tflrv//lcqhbnhmZ2Vbgcl+vzeQYPEIKJmnmocEz+5MJ
         jM3XqsfRPVkmco4nt2SAVT+D4gVHohp5bJgCLx9ssHDbbWiNt3k27s8gEWcM0c4QskqK
         If1cjOudN/Gl374qjvQPVTjw2oSoCe7M8rXxm0yprWzCevL11yLbEe8Y3RDJjDfWsHJ6
         W6/Aq1rnbLree//n7Lx2nEEghDzY7v5NpAGXr9unA3UFu70bOl4LtE3YCtVRgcw+NAOx
         qQfY7w4ksFglMIaW8WnVugXUntkS0ZMue+oKayjnBPAUj0xwrxLJ2jq+I7SXAy6GcFUU
         XJ6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782793010; x=1783397810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9NXRc86Umg+xwqOwvqqu82cgLkqOtrrtEqy6z9NCU5o=;
        b=Y162K8w/QECCyPVwB/4FrWkYd9qP+lGuoWVFgjs+DEyEdp/IoOdBL8yXGScnfTBN/d
         6sCoj55kIqXqo3XYalrUwW4t9taTVOkCLn4uJckOtHI7/LHSfBdcexCCsGhYe7wC+h7C
         C7rnUANoVV3V/v1ZgwDJzvobtczK/i1skCUJunRP/gyYQBeuWgTxf5ugB/zmBb8qgA6/
         wXlZL/QlVhaBnJc5c7unShD1CfAYmMlY5s+6ZfsPfsVUd4nkA7nf0RcIEZZRfahxzDkw
         AGOnqhqpKwIvL8i7voVRf9bXAaufiCfHJ6ryvR5SVIa0anmleLDKNGySlBlB+0DtqGfq
         Qu0g==
X-Gm-Message-State: AOJu0YwSqWc2w4kXddIJsUA9LXOeuubVvq/hCNpUhlJo/qzIyC2xL73M
	Wg5TNJesytWbhVxXVCuaKpND/PyPD2kQw9nNIRBZClfcPH9GStffFOvMTPEUOCkN
X-Gm-Gg: AfdE7cnNU6Wyh8luslApAPr3i6qbhjtAzdDu5SbPy0SRJiMWyjRe+XEzCrlZfMo3dl8
	dnHsWw536uBHRDwpSJOccAgosXKPKZADSWatvSy+WOUEpgthbV0CCHNpRxtughMENvypVgppPxf
	DYhQ4zzoqihPv1T6d3Zqq8Vp0Zg/SiUHxZAkwCwha9/u7NZvzqSKo4rrm50R9hc5u2k8RLQqZOo
	QuGRJ+dNJCGh17ecmBHBzwCKBkL+g5c61I3oGVwCqxQE+qD9iiYS42G2zHpD04IHVo3IWlnYyJ6
	M9mSa0PA2i4wuAJ8kocvTZsUn8y9fqDCCAsndEhQ3XQP1PahEOsKtdJRRD0cmV8GlDh5j2tXkFP
	mkAWsKKryGw5vJ7rved+O9G8NDcX1F7h6oHozQhZxCFVrZ7BLHaBFqzB1xwawuqDJF6+cWyRw4I
	T6T/Jy9aXM9DNvj7TR+DzCTDO5ZLydTr14KSvgGQHfqUm1NXHC798e6UyIVihvwL8arWzidNaPR
	m0NVaoPfQ==
X-Received: by 2002:a05:6a21:6013:b0:3bf:7ab7:98a4 with SMTP id adf61e73a8af0-3bfc5101243mr1788990637.27.1782793009975;
        Mon, 29 Jun 2026 21:16:49 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8000:7a86::e34])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c9bbf95a3e7sm702659a12.19.2026.06.29.21.16.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Jun 2026 21:16:49 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 10/10] net: emac: use ndo_get_stats64 instead of ndo_get_stats
Date: Mon, 29 Jun 2026 21:16:34 -0700
Message-ID: <20260630041634.284127-11-rosenp@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260630041634.284127-1-rosenp@gmail.com>
References: <20260630041634.284127-1-rosenp@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:linux-kernel@vger.kernel.org,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-302950-lists,netdev=lfdr.de];
	FORGED_SENDER(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EA1276E03BA

Replace the legacy emac_stats() callback with emac_get_stats64()
that fills struct rtnl_link_stats64 directly from the driver's
u64 counters, avoiding truncation of 64-bit values on 32-bit
architectures.

Assisted-by: opencode:big-pickle
Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 drivers/net/ethernet/ibm/emac/core.c | 84 ++++++++++++++--------------
 1 file changed, 41 insertions(+), 43 deletions(-)

diff --git a/drivers/net/ethernet/ibm/emac/core.c b/drivers/net/ethernet/ibm/emac/core.c
index da5f3d436aa3..c62abc8aa471 100644
--- a/drivers/net/ethernet/ibm/emac/core.c
+++ b/drivers/net/ethernet/ibm/emac/core.c
@@ -2026,57 +2026,55 @@ static irqreturn_t emac_irq(int irq, void *dev_instance)
 	return IRQ_HANDLED;
 }
 
-static struct net_device_stats *emac_stats(struct net_device *ndev)
+static void emac_get_stats64(struct net_device *ndev,
+			     struct rtnl_link_stats64 *stats)
 {
 	struct emac_instance *dev = netdev_priv(ndev);
 	struct emac_stats *st = &dev->stats;
 	struct emac_error_stats *est = &dev->estats;
-	struct net_device_stats *nst = &ndev->stats;
 	unsigned long flags;
 
 	DBG2(dev, "stats" NL);
 
-	/* Compute "legacy" statistics */
 	spin_lock_irqsave(&dev->lock, flags);
-	nst->rx_packets = (unsigned long)st->rx_packets;
-	nst->rx_bytes = (unsigned long)st->rx_bytes;
-	nst->tx_packets = (unsigned long)st->tx_packets;
-	nst->tx_bytes = (unsigned long)st->tx_bytes;
-	nst->rx_dropped = (unsigned long)(est->rx_dropped_oom +
-					  est->rx_dropped_error +
-					  est->rx_dropped_resize +
-					  est->rx_dropped_mtu);
-	nst->tx_dropped = (unsigned long)est->tx_dropped;
-
-	nst->rx_errors = (unsigned long)est->rx_bd_errors;
-	nst->rx_fifo_errors = (unsigned long)(est->rx_bd_overrun +
-					      est->rx_fifo_overrun +
-					      est->rx_overrun);
-	nst->rx_frame_errors = (unsigned long)(est->rx_bd_alignment_error +
-					       est->rx_alignment_error);
-	nst->rx_crc_errors = (unsigned long)(est->rx_bd_bad_fcs +
-					     est->rx_bad_fcs);
-	nst->rx_length_errors = (unsigned long)(est->rx_bd_runt_packet +
-						est->rx_bd_short_event +
-						est->rx_bd_packet_too_long +
-						est->rx_bd_out_of_range +
-						est->rx_bd_in_range +
-						est->rx_runt_packet +
-						est->rx_short_event +
-						est->rx_packet_too_long +
-						est->rx_out_of_range +
-						est->rx_in_range);
-
-	nst->tx_errors = (unsigned long)(est->tx_bd_errors + est->tx_errors);
-	nst->tx_fifo_errors = (unsigned long)(est->tx_bd_underrun +
-					      est->tx_underrun);
-	nst->tx_carrier_errors = (unsigned long)est->tx_bd_carrier_loss;
-	nst->collisions = (unsigned long)(est->tx_bd_excessive_deferral +
-					  est->tx_bd_excessive_collisions +
-					  est->tx_bd_late_collision +
-					  est->tx_bd_multple_collisions);
+	stats->rx_packets = st->rx_packets;
+	stats->rx_bytes = st->rx_bytes;
+	stats->tx_packets = st->tx_packets;
+	stats->tx_bytes = st->tx_bytes;
+	stats->rx_dropped = est->rx_dropped_oom +
+			    est->rx_dropped_error +
+			    est->rx_dropped_resize +
+			    est->rx_dropped_mtu;
+	stats->tx_dropped = est->tx_dropped;
+
+	stats->rx_errors = est->rx_bd_errors;
+	stats->rx_fifo_errors = est->rx_bd_overrun +
+				est->rx_fifo_overrun +
+				est->rx_overrun;
+	stats->rx_frame_errors = est->rx_bd_alignment_error +
+				 est->rx_alignment_error;
+	stats->rx_crc_errors = est->rx_bd_bad_fcs +
+			       est->rx_bad_fcs;
+	stats->rx_length_errors = est->rx_bd_runt_packet +
+				  est->rx_bd_short_event +
+				  est->rx_bd_packet_too_long +
+				  est->rx_bd_out_of_range +
+				  est->rx_bd_in_range +
+				  est->rx_runt_packet +
+				  est->rx_short_event +
+				  est->rx_packet_too_long +
+				  est->rx_out_of_range +
+				  est->rx_in_range;
+
+	stats->tx_errors = est->tx_bd_errors + est->tx_errors;
+	stats->tx_fifo_errors = est->tx_bd_underrun +
+				est->tx_underrun;
+	stats->tx_carrier_errors = est->tx_bd_carrier_loss;
+	stats->collisions = est->tx_bd_excessive_deferral +
+			    est->tx_bd_excessive_collisions +
+			    est->tx_bd_late_collision +
+			    est->tx_bd_multple_collisions;
 	spin_unlock_irqrestore(&dev->lock, flags);
-	return nst;
 }
 
 static struct mal_commac_ops emac_commac_ops = {
@@ -3040,7 +3038,7 @@ static int emac_init_config(struct emac_instance *dev)
 static const struct net_device_ops emac_netdev_ops = {
 	.ndo_open		= emac_open,
 	.ndo_stop		= emac_close,
-	.ndo_get_stats		= emac_stats,
+	.ndo_get_stats64	= emac_get_stats64,
 	.ndo_set_rx_mode	= emac_set_multicast_list,
 	.ndo_eth_ioctl		= emac_ioctl,
 	.ndo_tx_timeout		= emac_tx_timeout,
@@ -3052,7 +3050,7 @@ static const struct net_device_ops emac_netdev_ops = {
 static const struct net_device_ops emac_gige_netdev_ops = {
 	.ndo_open		= emac_open,
 	.ndo_stop		= emac_close,
-	.ndo_get_stats		= emac_stats,
+	.ndo_get_stats64	= emac_get_stats64,
 	.ndo_set_rx_mode	= emac_set_multicast_list,
 	.ndo_eth_ioctl		= emac_ioctl,
 	.ndo_tx_timeout		= emac_tx_timeout,
-- 
2.54.0


