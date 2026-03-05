Return-Path: <netdev+bounces-264534-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QKerOpjhqWnDGwEAu9opvQ
	(envelope-from <netdev+bounces-264534-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:03:36 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 95F75217EFD
	for <lists+netdev@lfdr.de>; Thu, 05 Mar 2026 21:03:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 168973031395
	for <lists+netdev@lfdr.de>; Thu,  5 Mar 2026 20:03:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854BD41C31C;
	Thu,  5 Mar 2026 20:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="PK5o3JuU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C5D141C2F8
	for <netdev@vger.kernel.org>; Thu,  5 Mar 2026 20:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772740903; cv=none; b=N4/PkWZIeVHfYIV96kcBDM1C5wSNGTWd7ND/88n7OJubsQU0YczOuHVMW/cZhscxOuAv+ucqqDnwAZNI6g/uN50r/K8CbBtI8vM7wI2oRIyoZ+h0hSXyCWZitAYv0XzdVTI7l/poOT9+HIfr4XBZnsh8WUioE48GFoqMKPEGE54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772740903; c=relaxed/simple;
	bh=9AGF9XBFZghn+Ips10ZkQuoIQMsvGj2VhGcNFsPlZic=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6DDnOphQrQ4qS2WCuBjg3p0rsiv00E3o2RlkOTFQBCRHUkteWPl1XV3aSxGY470z29U2xGW7qPOCc6xxXS0G7HEeDybGHDe+q39xGTBPbgDc5KdkZwJmXqAX0znTh3QuxAolhypsMQMRukT/PG49epV0Hb6vDGFlv8Z6RZ3X7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=PK5o3JuU; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-64ca423ad53so7507994d50.0
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772740901; x=1773345701;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RNQeU+4LebvP/QMzlSZElEzQh9gAOoO2ziXaLHa9JPc=;
        b=UEZMNPbon7YB4KGaWKdmYtVpZB4zgKXWfITUB1vupxchjnHHSQaWo0Eahx9j7wPKJs
         qJIdKnuCDXUrJZKq9LcsLnR6qGqrzCWUuzTxCnCj5wCafaiJwFiU+gA8/pylyCJ5il8r
         4gzpvA9thTbVEbNQX8lR1jqd4naqxVfIjMwOERNSEP1op9wKfQ1CWQXsWVCCbdkAJnOu
         fbsaJdQmYabWBUNDS4HnhCtwDS/xvMnH6E23a6BOAk223iJ+z4KLDsXAfgMTItjMnXdU
         HLOtbYEGgWcNtktWVQQlDYGOgYqKFWFvmiV4m4hCSeCKDZ3WEAcQO12Zaz5rRDh8JM7z
         aeEA==
X-Gm-Message-State: AOJu0YxkzVt0xypbEjlaqTAIgzxeZowixIEhP+V4A59bPwPd9oeUHgyw
	DBhw04cR+E69NRJcnNqE3tNECsdLW3RcBcNoGZ55T6u2x6sDdFLIrBNmTPxl6jOcbkWyhjYR/rJ
	mNHpxK8S/xZmZm1RVZvklQbmJfLbpTAjDLMssmsbSxLpOaVgIQJH/QpibqR015QgXyeZrTdARFj
	O7rDljQrop7gHBuyolXtdynnN1gE57AS23b+8D1rKwqKdpTJIQGKhvo9xxDgf2iakukOEHz4AY7
	ej3NaChw3KTKs4V9g==
X-Gm-Gg: ATEYQzwSAUWLCMAfzshvYAIiuDGzAn286m6oyhmS8Xj0cO+DVri7OIawKIK5IjGCmaI
	ioKEpLSnMpwcJ2CO4faCGwXAwJ9mzKRi0cvzTnB4nWW/yLy9tHCLTGxznFwqeKOGqhQ7o9G3ICy
	0DG7H2dksOr3TSlAtztBcwnhN2nHw3w5VLKn3snhG/YnD7Q/kH7yoopgu+ja/MeuKLalsO7pGtc
	BUxlvHlbF8Kk25tUmdcz8n0FwRje4FJ40HPPCojJy/Wcw2CryfneFMYzrMHL9K9Ssx7mid13lBD
	2s13t49XFDGPD/QCiyq2PXijqNh6i36tdeg4dDX0TLk/eGoevmfGQ5+iw9XaFrNf7UAz00KiYqT
	/41qpiwhnqXaMUF6hvWzNt6zvz2QZcqIXXhfXfVvFTrpdkM5PEOdRbEdmVg6NkS3w7PIjmCaGj8
	yrmDdbwqtNPR7UxOWpDKibFxyc11UK9CKLaWYJCkPc7a75OZa2nUF92yw0/W/zjVA=
X-Received: by 2002:a05:690e:e28:b0:64c:f740:cb3c with SMTP id 956f58d0204a3-64d10bddbb5mr873251d50.12.1772740900704;
        Thu, 05 Mar 2026 12:01:40 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-19.dlp.protect.broadcom.com. [144.49.247.19])
        by smtp-relay.gmail.com with ESMTPS id 956f58d0204a3-64cb75fb6bfsm2272350d50.8.2026.03.05.12.01.40
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2026 12:01:40 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2aad5fec175so303551495ad.2
        for <netdev@vger.kernel.org>; Thu, 05 Mar 2026 12:01:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1772740899; x=1773345699; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RNQeU+4LebvP/QMzlSZElEzQh9gAOoO2ziXaLHa9JPc=;
        b=PK5o3JuUQQeDg4bRNCegQNHmXCc7KWXXJxxdMqFCHlBSO92eoab1kq1+hP1UxODGKa
         JchnVoFw3oXJtRcWJE976pKRIueSk/hkjDg0mOGrJfepXUAMTRqYxaheCy4bXDPvyqZY
         CkLI/PLVrmgJOZJakxYtMtvTIm/qjKRsmwVSk=
X-Received: by 2002:a17:903:2409:b0:2ae:5063:b3e2 with SMTP id d9443c01a7336-2ae8012d6femr6717485ad.9.1772740898996;
        Thu, 05 Mar 2026 12:01:38 -0800 (PST)
X-Received: by 2002:a17:903:2409:b0:2ae:5063:b3e2 with SMTP id d9443c01a7336-2ae8012d6femr6717115ad.9.1772740898353;
        Thu, 05 Mar 2026 12:01:38 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb69ef1csm247398505ad.53.2026.03.05.12.01.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 12:01:37 -0800 (PST)
From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
To: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	michael.chan@broadcom.com,
	pavan.chebbi@broadcom.com,
	vsrama-krishna.nemani@broadcom.com,
	vikas.gupta@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
Subject: [PATCH net-next v4 08/10] bng_en: implement ndo_get_stats64
Date: Fri,  6 Mar 2026 01:30:15 +0530
Message-ID: <20260305200018.111728-9-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
References: <20260305200018.111728-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Queue-Id: 95F75217EFD
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-264534-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[broadcom.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 110 +++++++++++++++++-
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   1 +
 2 files changed, 109 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 29c072e38a7..ec0a8c5e28d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2924,6 +2924,102 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_get_ring_stats(struct bnge_dev *bd,
+				struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr = &bnapi->nq_ring;
+		u64 *sw = nqr->stats.sw_stats;
+
+		stats->rx_packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+		stats->rx_packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+		stats->rx_packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+		stats->tx_packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+		stats->tx_packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+		stats->tx_packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+		stats->rx_bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+		stats->rx_bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+		stats->rx_bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+		stats->tx_bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+		stats->tx_bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+		stats->tx_bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+
+		stats->rx_missed_errors +=
+			BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+
+		stats->multicast += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+
+		stats->tx_dropped += BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+
+		stats->rx_dropped +=
+			nqr->sw_stats->rx.rx_netpoll_discards +
+			nqr->sw_stats->rx.rx_oom_discards;
+	}
+}
+
+static void bnge_add_prev_stats(struct bnge_net *bn,
+				struct rtnl_link_stats64 *stats)
+{
+	struct rtnl_link_stats64 *prev_stats = &bn->net_stats_prev;
+
+	stats->rx_packets += prev_stats->rx_packets;
+	stats->tx_packets += prev_stats->tx_packets;
+	stats->rx_bytes += prev_stats->rx_bytes;
+	stats->tx_bytes += prev_stats->tx_bytes;
+	stats->rx_missed_errors += prev_stats->rx_missed_errors;
+	stats->multicast += prev_stats->multicast;
+	stats->rx_dropped += prev_stats->rx_dropped;
+	stats->tx_dropped += prev_stats->tx_dropped;
+}
+
+static void bnge_get_stats64(struct net_device *dev,
+			     struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_dev *bd = bn->bd;
+
+	rcu_read_lock();
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		rcu_read_unlock();
+		*stats = bn->net_stats_prev;
+		return;
+	}
+
+	bnge_get_ring_stats(bd, stats);
+	bnge_add_prev_stats(bn, stats);
+
+	if (bn->flags & BNGE_FLAG_PORT_STATS) {
+		u64 *rx = bn->port_stats.sw_stats;
+		u64 *tx = bn->port_stats.sw_stats +
+			  BNGE_TX_PORT_STATS_BYTE_OFFSET / 8;
+
+		stats->rx_crc_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_fcs_err_frames);
+		stats->rx_frame_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_align_err_frames);
+		stats->rx_length_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_undrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_ovrsz_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_runt_frames);
+		stats->rx_errors =
+			BNGE_GET_RX_PORT_STATS64(rx, rx_false_carrier_frames) +
+			BNGE_GET_RX_PORT_STATS64(rx, rx_jbr_frames);
+		stats->collisions =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_total_collisions);
+		stats->tx_fifo_errors =
+			BNGE_GET_TX_PORT_STATS64(tx, tx_fifo_underruns);
+		stats->tx_errors = BNGE_GET_TX_PORT_STATS64(tx, tx_err);
+	}
+	rcu_read_unlock();
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2931,14 +3027,23 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
-	/* Ensure BNGE_STATE_OPEN is cleared before checking drv_busy */
-	smp_mb__after_atomic();
+	/* No explicit barrier needed - synchronize_rcu() provides full
+	 * ordering between clear_bit() above and drv_busy() below.
+	 */
+	synchronize_rcu();
 	while (bnge_drv_busy(bn))
 		msleep(20);
 
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	if (bn->bnapi) {
+		bnge_get_ring_stats(bd, &bn->net_stats_prev);
+		bnge_get_ring_err_stats(bn, &bn->ring_err_stats_prev);
+	}
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2988,6 +3093,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index f160ba9b69c..5a2defa970c 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -382,6 +382,7 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
 	struct bnge_total_ring_err_stats ring_err_stats_prev;
 
 	struct bnge_stats_mem	port_stats;
-- 
2.47.3


