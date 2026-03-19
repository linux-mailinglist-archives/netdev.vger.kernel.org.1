Return-Path: <netdev+bounces-269311-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sPqLFHmPu2lmlgIAu9opvQ
	(envelope-from <netdev+bounces-269311-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:54:01 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2F4E2C65B9
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 06:54:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 61CE3302F6A2
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 05:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E521C399374;
	Thu, 19 Mar 2026 05:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ISqdaKcY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f98.google.com (mail-qv1-f98.google.com [209.85.219.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D326399011
	for <netdev@vger.kernel.org>; Thu, 19 Mar 2026 05:53:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773899592; cv=none; b=FvHRPwLKb917LIH+ky9yt8f8/RB2fXHUZT2fVfgtM/rJyVbnZPGqYOLTaMl9WKbd8LMV0Sv5lSxk5vWoJXx75wu8m3zWhKyXb3DaA7wiSNOy2vzhXvq1Lh/7pEfOMlOOPbtRzWStx8qVRmvRSZ5MvFQsS3u93h3mpuOpGmv9WIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773899592; c=relaxed/simple;
	bh=6pVUObxKJcpqyg60HNgCKSEoCpNjAVM+AGL3wGaoVXg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=U3vLsZhKPJGd5vCkmDr7pS/cIi308aKVCw2OR4Hvda+5iN39zOLGCjrDHiTdMfFsvqCVBUUsyTFgvGqBhghOGWdtJku3OyAIzHgvKlFskuxSFrAOUY9EKR6SETCnRI+Hj19xdQXZPgXHXbiSYynlRh48PI47eF4HBZavqeLh6fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=ISqdaKcY; arc=none smtp.client-ip=209.85.219.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qv1-f98.google.com with SMTP id 6a1803df08f44-89c452e9cc4so8533586d6.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:53:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773899590; x=1774504390;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=K7FaWhADbrt2uVZb4x2KUlFR/3vOeNIrrqP+sLNFjXo=;
        b=ZR0lKwyywf4n/ng7Dors5qwRHRSpnnBNDSvyRs28TH9tt6lUTBz8/RHpOCILtsFKg0
         H4EWsVtGWGKfR6t/kdyl0NxZTQxISUtOlgwLbEqAmUxlOjImE5yVrRnVjBvsHDgSGyEK
         H7EFqywK7tJHhzpqJubVSyoVyTJ4rqZTO6Vv0m4jVrpICsf+AQG5O0Ee9qWpbiq/mjyV
         t3gpJNmTWPtISydDvtuYMrWrqGQhpi+vRvuuKpnLucXUiemRbUrZsUjond8Cn7qDEXIf
         f1WWIhOtVo3AUdXr+XU/nExAC0LH7h4erJv5seYLs8ntY5DhF+5rLqUx0OcKEbRIkQQg
         ELUA==
X-Gm-Message-State: AOJu0YzLFS6VTaWK+EPImqezyAQ+GJBpFtDhjRXbgSNnqwHXNsrH2IbG
	xlBWWpSkHSfu+fixeT7BHa7Cq8y0hUF8FTjX9QR7d/B20to5aPX1O/cqiThNLSSegyOsGqmtda3
	GMrXA1LFwfMkanNaPOLcjvKY8brHSr5NZagxZ8/mMGV41P2a+RTvoRHGtLaLfmwoId5q104NIuY
	l2JtsUi7L0qtHTSBVigRVZdtXUCLW5umPYBcI7Zl035Vt7LEb75B6X7qpnveqVVx067ZPjYekaX
	on6MSTX7w==
X-Gm-Gg: ATEYQzzJCpqx6/nlADsEafGaqb4n9YH8JWaE0WwKIfZuYmgmZCYpKUfTpjKRAOI5SpT
	It7HgwLHyIAlq08uQY/C3X4zWOJUX/79Ptj6fRupEuwrfKSrjMA3/PBR80Zc/CYwj9CYDLLhWon
	2pPO0qsfqAycXDRgp9B1IRzAZ298ypfuGIaCB8VXkoUoZCoXeNR5FmXZgdMGWnn6uv7A+CMjKtI
	Odi3DYfp6eNF5VbMuviuF76UKiP9NEbPtr2cO/825OZkU8xPtPxnkBYArq5yQ620ujAD9XzIzxB
	X2JowCRomWJrkhAJh8NOJjjgp4SOGbootg6Nybe8VYviwq95T6i6zUrQtgFnGWjPN2holVj5Qso
	QUuPDOCZgFUxit6vO+kEWcDu6B0lcIrKM68tRTJntZ6TB8GXyNg4s2S/0sWEQD0a4L9oVaneGfG
	WiZtDjRawxxv1Q7FdFNqYfU93+2tA/c6vBuMKA3f8kEHQskKvCljLMkAzzWQ==
X-Received: by 2002:a05:6214:509a:b0:899:ea9e:31c2 with SMTP id 6a1803df08f44-89c6b72b299mr86821076d6.58.1773899590371;
        Wed, 18 Mar 2026 22:53:10 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-102.dlp.protect.broadcom.com. [144.49.247.102])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-89c6b9ab41esm4882756d6.19.2026.03.18.22.53.10
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 18 Mar 2026 22:53:10 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-64ca9ec3eedso642054d50.2
        for <netdev@vger.kernel.org>; Wed, 18 Mar 2026 22:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773899590; x=1774504390; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=K7FaWhADbrt2uVZb4x2KUlFR/3vOeNIrrqP+sLNFjXo=;
        b=ISqdaKcYulmVIsSmuq0V3vl2yKoXgmAmu1j3EI3V4DrbKeaVFQRVaGCZIoho2V62O0
         38/0r1bRbTaqsOozzwhBiQ7aHO89MZyf0ECpwBx7bA4u1Fc801T1ZmEqm7bk+7O4tC0U
         zal132VZZuDzUHErMbehJZOnTEXFUt+e2uGJ8=
X-Received: by 2002:a05:690e:205c:b0:649:c523:13e9 with SMTP id 956f58d0204a3-64e915ce8bemr4583727d50.41.1773899589533;
        Wed, 18 Mar 2026 22:53:09 -0700 (PDT)
X-Received: by 2002:a05:690e:205c:b0:649:c523:13e9 with SMTP id 956f58d0204a3-64e915ce8bemr4583715d50.41.1773899589081;
        Wed, 18 Mar 2026 22:53:09 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64e91a1cd32sm2918980d50.2.2026.03.18.22.53.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2026 22:53:08 -0700 (PDT)
From: Vikas Gupta <vikas.gupta@broadcom.com>
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
	rajashekar.hudumula@broadcom.com,
	ajit.khaparde@broadcom.com,
	Bhargava Marreddy <bhargava.marreddy@broadcom.com>,
	Vikas Gupta <vikas.gupta@broadcom.com>
Subject: [PATCH net-next v8 09/10] bng_en: implement netdev_stat_ops
Date: Thu, 19 Mar 2026 11:21:23 +0530
Message-ID: <20260319055124.1350670-10-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
References: <20260319055124.1350670-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269311-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.979];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: C2F4E2C65B9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

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
index 2513b0907693..fa732b99358e 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -3031,6 +3031,81 @@ static int bnge_close(struct net_device *dev)
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
@@ -3194,6 +3269,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
-- 
2.47.1


