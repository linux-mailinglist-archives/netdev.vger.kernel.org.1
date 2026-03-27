Return-Path: <netdev+bounces-272678-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WMs0KvzoxmloQAUAu9opvQ
	(envelope-from <netdev+bounces-272678-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E49A34AFD6
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 21:30:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 87AAE314613E
	for <lists+netdev@lfdr.de>; Fri, 27 Mar 2026 20:19:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C15E3C5DBB;
	Fri, 27 Mar 2026 20:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="QL0qR527"
X-Original-To: netdev@vger.kernel.org
Received: from mail-vk1-f228.google.com (mail-vk1-f228.google.com [209.85.221.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010633C5DA7
	for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 20:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774642531; cv=none; b=BueJBtX6M0ZQjYKrfV5nIUAG4cJyFcZMHc/ZaOynj8Sza4j7TRuLlr/yiD/6aD9pHNafmrz1SCb0H7xvZXK94YsAXKaO5hGkoSROYCh9yDTZLAeGQh6APPtCVtc+IWDzoIA5nIte4iAI2oTCT5AUePH3Ed6YvCNsfDHmZ7t2KGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774642531; c=relaxed/simple;
	bh=B4RW7li4SIxXRELSNpViAsFoBRy0nCOah+RnGswByJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fmbKsFq7SPM4oYmMlapbfuBVAYRU4mYJXrhQd9ayWKD4rpirnNMJI3Cp+w8lr+LBSLklyJQeMaJRNl96bmPnqaZ5c/WmUYdPGhhoJqK7Rx1K4XuaIENHrZ+y4ndglDf1M6Md6rMKcctVfSCSvhS73J/X1/f5T3gziPiLE/MzWkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=QL0qR527; arc=none smtp.client-ip=209.85.221.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-vk1-f228.google.com with SMTP id 71dfb90a1353d-56ce44a204dso1856552e0c.1
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774642529; x=1775247329;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oQqYIQoxCZiC5R197ntCR1iTwngnfxL/IuLhWJbqKi8=;
        b=D0XLZqqrQSVumTc+BcoveReHPdpddnu+DaPJAAZ/iqLZtQyNVLPuJgPA4S7XxTEPdC
         0Gb28Sjn3ZDuS9GiEVhB/joLNFEARXNFeMrr61ttuYakdG4MslwoppS6yLpIQcNLBzRj
         v3xDP84pjK2cyDqC+UM+hF/7YKfbP/3pUrGBrc3thWKBvTWZ9oyvIcYELlD7jGlXj0t5
         s/9goZ1n6PS/s32c1TDktp4VKIjdi4kBlgzYdX141GKlUHT7GNKbyvG1uV8WCgSeVF4j
         GlHM2DoUD4e9fgJEcVgBtIQr4am73LFJi2+1qRRU1sMnYH+SgZSdWL7C5GYzujMCXINk
         0P/Q==
X-Gm-Message-State: AOJu0YzCIX1G35e5w565KzBlOHzTTMwGvVqNSvBUv2/wsfbX8htn9ZVe
	NhVk9z1n9KbQrm6rG6FzoQQvycqAfMPw0ynGZr0tRVtk8wkfmMHz0E3XO92ZXxtq42pdZNu6/fy
	mXNyRZEack6jtbXs1FNGH4DqT0C8c24QgLapL1FnptCHWqp0ZAnl8VrFHANZqw+0L0jGY2ygmS8
	SeVCXn4THxQfs2rLJyWKhIAIviXB91tAQ6HD6jUC1m/S1PavoJtHNdR8QuRBYhTJxR+C5VsIjCF
	FPzT4XuSTDtvNT1QLFX
X-Gm-Gg: ATEYQzwhSaIzFLqNX4vcspCDBQ4tMp4kvoWcazFsCs5ELjIXzREU9BnptHAf/b1xDiW
	Un9GuInd6UZCyuhuSrH8wfbU950axvFKs36qgHFeo9QCakO4pWBs5fwnwE6wGlCvzvMD5ejXj67
	FszjQfqO9uyJvtlqFvsmseOAnyNf1GOJLq3dcCwsQVXyd5peehPpkSrDqn3HYMD7gQ1YeCPElYV
	MCn7Zv32Zc3dvjRRb3k9b0s360OiHeSku7mzBtCtvo1jpuld/4dbGgt8TBeWQnQmAF4xjZXLgYR
	nU/XkXTi0nbyWyf3ZlhApMQkPn0tKvT0E/9PrFYTkqYZeaKj2MDKfgM4iDM8kAosOx+ffzZkKLq
	hZdP0nYp0QC9wQsOX+9zCX0VVHtVf+I93Ak29zfDqUpUJxU13vtdj24lz4OWyu2WFdHEAqdw7fG
	UePndxrFqWjqnXN/Q6fCxKOxsbcxsgj79rqhtXRVeM2LBq9hkjwq82QQYeBvNtps4=
X-Received: by 2002:a05:6122:1793:b0:56c:d5cd:1e7c with SMTP id 71dfb90a1353d-56d4a5091e3mr2061142e0c.5.1774642528844;
        Fri, 27 Mar 2026 13:15:28 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-25.dlp.protect.broadcom.com. [144.49.247.25])
        by smtp-relay.gmail.com with ESMTPS id 71dfb90a1353d-56d58873680sm4414e0c.2.2026.03.27.13.15.28
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 27 Mar 2026 13:15:28 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7965223b026so51885287b3.0
        for <netdev@vger.kernel.org>; Fri, 27 Mar 2026 13:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1774642528; x=1775247328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oQqYIQoxCZiC5R197ntCR1iTwngnfxL/IuLhWJbqKi8=;
        b=QL0qR527ulZ57utxqA3UuoM1ds1CShd8hBchqgDo/HZsHlMgOThhmDDOYS01k6nwHe
         TIGcPaqdIAg4+2K4VQFk/s/gE6VvFX4IgU1GdeQINs9hMXXnLNDw+hjAVv0Wo+j8avvF
         GEvekd7xl4zWH5c3Wb8keKxW6Rwl/S1qUaOuI=
X-Received: by 2002:a05:690c:7308:b0:794:baaa:cca7 with SMTP id 00721157ae682-79bddd2171bmr40534677b3.20.1774642527877;
        Fri, 27 Mar 2026 13:15:27 -0700 (PDT)
X-Received: by 2002:a05:690c:7308:b0:794:baaa:cca7 with SMTP id 00721157ae682-79bddd2171bmr40534187b3.20.1774642527166;
        Fri, 27 Mar 2026 13:15:27 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-79cb9a8f324sm119057b3.28.2026.03.27.13.15.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 13:15:26 -0700 (PDT)
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
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Subject: [PATCH net-next v10 09/10] bng_en: implement netdev_stat_ops
Date: Sat, 28 Mar 2026 01:43:42 +0530
Message-ID: <20260327201343.16146-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
References: <20260327201343.16146-1-bhargava.marreddy@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272678-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 1E49A34AFD6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implement netdev_stat_ops to provide standardized per-queue
statistics via the Netlink API.

Below is the description of the hardware drop counters:

rx-hw-drop-overruns: Packets dropped by HW due to resource limitations
(e.g., no BDs available in the host ring).
rx-hw-drops: Total packets dropped by HW (sum of overruns and error
drops).
tx-hw-drop-errors: Packets dropped by HW because they were invalid or
malformed.
tx-hw-drops: Total packets dropped by HW (sum of resource limitations
and error drops).

The implementation was verified using the ynl tool:

./tools/net/ynl/pyynl/cli.py --spec \
Documentation/netlink/specs/netdev.yaml --dump qstats-get --json \
'{"ifindex":14, "scope":"queue"}'

[{'ifindex': 14, 'queue-id': 0, 'queue-type': 'rx', 'rx-bytes': 758,
'rx-hw-drop-overruns': 0, 'rx-hw-drops': 0, 'rx-packets': 11},
 {'ifindex': 14, 'queue-id': 1, 'queue-type': 'rx', 'rx-bytes': 0,
'rx-hw-drop-overruns': 0, 'rx-hw-drops': 0, 'rx-packets': 0},
{'ifindex': 14, 'queue-id': 0, 'queue-type': 'tx', 'tx-bytes': 0,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 0},
 {'ifindex': 14, 'queue-id': 1, 'queue-type': 'tx', 'tx-bytes': 0,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 0},
 {'ifindex': 14, 'queue-id': 2, 'queue-type': 'tx', 'tx-bytes': 810,
'tx-hw-drop-errors': 0, 'tx-hw-drops': 0, 'tx-packets': 10},]

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 76 +++++++++++++++++++
 1 file changed, 76 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index b5cc96d1ee0e..7ffd8e8e70fb 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3041,6 +3041,81 @@ static int bnge_close(struct net_device *dev)
 	return 0;
 }
 
+static void bnge_get_queue_stats_rx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_rx *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_nq_ring_info *nqr;
+	u64 *sw;
+
+	if (!bn->bnapi)
+		return;
+
+	nqr = &bn->bnapi[i]->nq_ring;
+	sw = nqr->stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+	stats->hw_drop_overruns = BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+	stats->hw_drops = BNGE_GET_RING_STATS64(sw, rx_error_pkts) +
+				stats->hw_drop_overruns;
+}
+
+static void bnge_get_queue_stats_tx(struct net_device *dev, int i,
+				    struct netdev_queue_stats_tx *stats)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+	struct bnge_napi *bnapi;
+	u64 *sw;
+
+	if (!bn->tx_ring)
+		return;
+
+	bnapi = bn->tx_ring[bn->tx_ring_map[i]].bnapi;
+	sw = bnapi->nq_ring.stats.sw_stats;
+
+	stats->packets = 0;
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+	stats->packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+	stats->bytes = 0;
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+	stats->bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+
+	stats->hw_drop_errors = BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+	stats->hw_drops = BNGE_GET_RING_STATS64(sw, tx_discard_pkts) +
+				stats->hw_drop_errors;
+}
+
+static void bnge_get_base_stats(struct net_device *dev,
+				struct netdev_queue_stats_rx *rx,
+				struct netdev_queue_stats_tx *tx)
+{
+	struct bnge_net *bn = netdev_priv(dev);
+
+	rx->packets = bn->net_stats_prev.rx_packets;
+	rx->bytes = bn->net_stats_prev.rx_bytes;
+
+	tx->packets = bn->net_stats_prev.tx_packets;
+	tx->bytes = bn->net_stats_prev.tx_bytes;
+}
+
+static const struct netdev_stat_ops bnge_stat_ops = {
+	.get_queue_stats_rx	= bnge_get_queue_stats_rx,
+	.get_queue_stats_tx	= bnge_get_queue_stats_tx,
+	.get_base_stats		= bnge_get_base_stats,
+};
+
 static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
@@ -3204,6 +3279,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
-- 
2.47.3


