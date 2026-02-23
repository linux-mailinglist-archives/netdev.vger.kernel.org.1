Return-Path: <netdev+bounces-260121-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CLTWJlCFnGm7IwQAu9opvQ
	(envelope-from <netdev+bounces-260121-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:50:24 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 18F9017A263
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 17:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3E9D330A31AA
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 16:39:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09219329C66;
	Mon, 23 Feb 2026 16:38:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GaIvDxCf"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f227.google.com (mail-pg1-f227.google.com [209.85.215.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985CD329C79
	for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 16:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771864681; cv=none; b=D8TzAvhfHNgv3meeLQj8jJv6ARk4WqBt9wZfUjaCL+em4bRGEJyOhbl5C/xT6wvIys0RgqvPzGoH5K0ggjUgluohmdJ+GjVyBfdHjmi3iU4ZZwkcCVQG6BkeExyap92bPt6h/aYPATjha7gk5EHg+1/+/3Xp6HRHQt7HNp2sp94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771864681; c=relaxed/simple;
	bh=EDNg3P30qp6TpoJ+LaUb8hlMM2SdRTBe0QhS1deiRbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=biGDqP7erZmqziyr/eIRxYk4VD22E4hwUO4f+M96HsO4JeAnC0ZmlMkdOL91IBqeqUYyfl9X5erIatz/ih69cARxq5F+gsUc2RTNFagtgt6WjhaTseORcf6qpDJyIIr9ZYBXtLmW8haon985SNeibOT9TWVTNM+FwXrJE3nkAp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=GaIvDxCf; arc=none smtp.client-ip=209.85.215.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pg1-f227.google.com with SMTP id 41be03b00d2f7-c6e191c4b8fso1616047a12.0
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:38:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771864680; x=1772469480;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=moTkq8uSx6FpuB82+cTHGTek2ppzwZXDRC3f5Mlpkf4=;
        b=C1no99tPjIw8S5pEu/gB8m9ek7uiL4h51fMx2Ua8je0mXaOGYAP25n4bgRvqJ+0cPE
         UkQPFSBLXR/RvlmNOpKLTr3gVmFGS+66tBj61FGFlfhjIHYZSq9KA/SXvK5U6MIo/xKs
         QUFoirxrQOmSWIMdXAdldO3hYqesOQ/XvV8PXDoMKnAq/kFpG1k5vLIGkfdU7ehF5G4p
         vONWiSJUHS8VspQv/nkRoI2Rbr0L11LtbvE8k3Fc1FHiXZzlB5wTOO7FJh1WgEZwHkq6
         dej4+xfN+pC9ahiaETzHBDF9KLcj0hcS6rtrXXPaPna8nKtK5ixNZoDFA+C41Rwh2zNY
         xsjg==
X-Gm-Message-State: AOJu0Yw+CpgaAad0N0Djh2+ahxIFIXU/X9/H4pl0Zh7NIiDGk6kHPDgy
	cD6rGZt91fyR3di6IebAsLmGNFb0yvjEbpw81HHfiwgm86KjaoOTYtFqv2BVP4k4QYLPD6X3N+T
	dBIXm2TXLmTFUfMRagGDcXDOxvQ0iCkQk8TYOCJ+9yKUG54IQ0cltZ44ntxvMcP9DiYW6fCPKpF
	AB6gXCUZ18WlhqVbqhoh8vQbZsIvndy61dw10WFyCB5vGFWc5VDGrqrPwfOWpOAbHvwzNW+lDBt
	q6nxRW3t3+AY4ktAg==
X-Gm-Gg: ATEYQzwKBuuDMM4I4hRnFoRhPDKJc5PCYXWBEVVMw5LtjH8RrkXY7ufqToCQ+gAGAVN
	NYqlTxKY39OiPQHW1prDEqfEInK8UHcNxbVc0+oM/WntEXKNyOumpue+WSl48EzYfpPg/u5Nz0i
	5vlBGoV1zL55fzh76vhYIAk/VOjKXHbAWq6Lk6HB3Ticx9Fnp/ZY+xFDC+YaE7c0q0fyueTJOqG
	gxnLazsigab1wuK2AvbZpwda00oRCLe5Pq8ts4U0KDGdp3M/52PCobsDSewHbO4FTOl4u7cjGAo
	VyChRK/heIKzaK8od9APDBk3nJEFjwOzLahaJ1zO9mVecMYsGPQrLrbS/jB5U8fa8RFYnS5Eho/
	ZLoxqTYVnswdl1ixTgjpz6dXWmyZ+0QllY07KCKxJTwm+5xWxgyPyvejjhkMhstSCGRTCN1a9qF
	rjMm2nNMEtNS7e2hzRyneLGANcGCABHrJ677nIXGKb7rYxTsejaF+5nyXHGenetuHlBg==
X-Received: by 2002:a17:90b:562d:b0:356:5b3d:2249 with SMTP id 98e67ed59e1d1-358ae8f0f53mr8123506a91.32.1771864679769;
        Mon, 23 Feb 2026 08:37:59 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-103.dlp.protect.broadcom.com. [144.49.247.103])
        by smtp-relay.gmail.com with ESMTPS id 98e67ed59e1d1-358cef37629sm232324a91.4.2026.02.23.08.37.59
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Feb 2026 08:37:59 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2a75ed2f89dso42794055ad.1
        for <netdev@vger.kernel.org>; Mon, 23 Feb 2026 08:37:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1771864678; x=1772469478; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moTkq8uSx6FpuB82+cTHGTek2ppzwZXDRC3f5Mlpkf4=;
        b=GaIvDxCfKS2/FzTqjq8lsPZwewVI1IAz6wPNlzqvLzCDmnNXcRoTuCJ0FdOHqwNZS7
         W9pWLh7NcO0VC30lgIPHEqRFk0vRdp7XUscmjYFcmPljk41g310Q6PS7JhfhRBwPZgH1
         3/I0AUgnfyyyFDSNmbjVQT889YmlL+qS9e/Mc=
X-Received: by 2002:a17:903:3bcc:b0:2a9:4369:940c with SMTP id d9443c01a7336-2ad745a8ce1mr89168585ad.53.1771864677971;
        Mon, 23 Feb 2026 08:37:57 -0800 (PST)
X-Received: by 2002:a17:903:3bcc:b0:2a9:4369:940c with SMTP id d9443c01a7336-2ad745a8ce1mr89168325ad.53.1771864677495;
        Mon, 23 Feb 2026 08:37:57 -0800 (PST)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ad74e3445fsm96763825ad.13.2026.02.23.08.37.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Feb 2026 08:37:57 -0800 (PST)
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
Subject: [PATCH net-next 7/7] bng_en: implement ndo_get_stats64
Date: Mon, 23 Feb 2026 22:06:41 +0530
Message-ID: <20260223163641.755200-8-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
References: <20260223163641.755200-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260121-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:mid,broadcom.com:dkim,broadcom.com:email];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 18F9017A263
X-Rspamd-Action: no action

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
Reviewed-by: Ajit Kumar Khaparde <ajit.khaparde@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 108 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |  11 +-
 2 files changed, 118 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index e2715419b6f..c6079b4c949 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2939,6 +2939,106 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
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
+	set_bit(BNGE_STATE_READ_STATS, &bn->state);
+	/* Make sure bnge_close_core() sees that we are reading stats before
+	 * we check the BNGE_STATE_OPEN flag.
+	 */
+	smp_mb__after_atomic();
+	if (!test_bit(BNGE_STATE_OPEN, &bd->state)) {
+		clear_bit(BNGE_STATE_READ_STATS, &bn->state);
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
+	clear_bit(BNGE_STATE_READ_STATS, &bn->state);
+}
+
 static void bnge_close_core(struct bnge_net *bn)
 {
 	struct bnge_dev *bd = bn->bd;
@@ -2954,6 +3054,13 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
 	timer_delete_sync(&bn->timer);
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
@@ -3003,6 +3110,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 107c8a69c93..4b68a8ed229 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -227,6 +227,12 @@ struct bnge_tpa_info {
 #define BNGE_GET_RING_STATS64(sw, counter)		\
 	(*((sw) + offsetof(struct ctx_hw_stats, counter) / 8))
 
+#define BNGE_GET_RX_PORT_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct rx_port_stats, counter) / 8))
+
+#define BNGE_GET_TX_PORT_STATS64(sw, counter)		\
+	(*((sw) + offsetof(struct tx_port_stats, counter) / 8))
+
 #define BNGE_PORT_STATS_SIZE				\
 	(sizeof(struct rx_port_stats) + sizeof(struct tx_port_stats) + 1024)
 
@@ -285,6 +291,7 @@ struct bnge_sw_stats {
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
 	BNGE_STATE_IN_SP_TASK,
+	BNGE_STATE_READ_STATS,
 };
 
 #define BNGE_TIMER_INTERVAL	HZ
@@ -377,6 +384,7 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
 	struct bnge_total_ring_err_stats ring_err_stats_prev;
 
 	struct bnge_stats_mem	port_stats;
@@ -650,7 +658,8 @@ struct bnge_l2_filter {
 
 static inline bool bnge_drv_busy(struct bnge_net *bn)
 {
-	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state);
+	return test_bit(BNGE_STATE_IN_SP_TASK, &bn->state) ||
+	       test_bit(BNGE_STATE_READ_STATS, &bn->state);
 }
 
 u16 bnge_cp_ring_for_rx(struct bnge_rx_ring_info *rxr);
-- 
2.47.3


