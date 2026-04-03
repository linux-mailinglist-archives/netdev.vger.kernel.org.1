Return-Path: <netdev+bounces-274928-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4N9gNORuz2kTwQYAu9opvQ
	(envelope-from <netdev+bounces-274928-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:40:20 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C12B391CAA
	for <lists+netdev@lfdr.de>; Fri, 03 Apr 2026 09:40:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92A753062065
	for <lists+netdev@lfdr.de>; Fri,  3 Apr 2026 07:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7E237CD4A;
	Fri,  3 Apr 2026 07:38:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Jc98MH7y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f226.google.com (mail-qk1-f226.google.com [209.85.222.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E2337BE6A
	for <netdev@vger.kernel.org>; Fri,  3 Apr 2026 07:38:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775201935; cv=none; b=iYpBTTDI8h/jOpztIyC9pMYg+qBfCzPF6pg7+upMnI3OmHjcolz/eQNyPvi3JSzZw62cnGsx6Fneqp6sCjFE2Ep15yagN6lXxy8AraDUn0/JfxzIKz9PSPQSVJt86pYuQJg72y5IXWMETNdB9nPwbJp58v9a2fmJKxQxyvW1Lug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775201935; c=relaxed/simple;
	bh=ZZqrPTcVEVCs2us9N1me1Ia3g2J0SjMmqgrQS0luHOY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AM/WB0OtwyPg6dt8WWwrRE+mQ5fejJxwp3h5G2cZhHTCq3OOLKLdZBdPXy3EEMR1L6+h0rMPbAlycMHvQW2lThvcd++hUb3VNnfI7KM+jeH/q/tXdnpC6k5+qxGAvM7a8grsKvl0Ue74hHHGUPtR84FplX2uOUBRmOBBDopdagc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Jc98MH7y; arc=none smtp.client-ip=209.85.222.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f226.google.com with SMTP id af79cd13be357-8d4694105e5so24096285a.1
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775201932; x=1775806732;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jBA5mYoFs7U2kVrS4kBVEGeuAEMM/jKmYSPSiTVI568=;
        b=fewu9zaxuRwhx1b177v2GvKVMAx4YBl7j3enYyhskrKsOAT1GZL9koexlwx00NyeoT
         d2tC9H+ZBW9ia6wsJv9BqKdf7NVjPLXgx16Z5zPsHGSNVxKXbnWWYjYHd64kCQlb/GTp
         lTp/z4NdLDUFzSmOWB1x2uSZ4Y4CIMYnKNZS01ERAIDoX9N/9C/+KiM/IZLTcA+ax2iQ
         QzLkzLQE5P6onXbLojHiAoUcoLXuurpU/3JcWAlbcBHUdIQ+79TXvOva0uhki111YFhH
         Ph6Qqs4yIZjKO7P4gHpZZyvdjtgJfnRV3jdBcNLo7duDQhfP4Tw0ezh8f8jbkcQ4ADaP
         37ww==
X-Gm-Message-State: AOJu0YzLt4c4E5wZNQDVI5qQxqJxb4hRCpRqW7WCiOFPSYZdaLoaJpxN
	r/euzAUISUHEP42dphytu0MHS9hpJMSYLi7gX4TWG55gylrtaD77Rd5Ck0HB47eV6drs1Y6LuU1
	rECVeutDP04WsD5B8lzt/3Fy7X+D+lQlKA6449fbM9nHwUaswkWXKeFB3xYDHn+K3OGdyOISV+V
	+DA8oTf6GhinVtRnpRlBm+psYVp7E38Cp4ncapggWmuHm+L1r7B1l0L1tm2nbUBWE+CZ80+fMpG
	bWgLF5aFyI6gJ5SXg==
X-Gm-Gg: AeBDieu09mjwnAP18Lzoj3pNZJACVFAVrEW3ECjPjy3+QfG1DmiNHCCSxi3JC1tJB9r
	NM1VPQCKqksSzqpe1d8Soj2OuuqG5j7H7oHYnaNDQS9F1RdnYuB/xfT30tu1tXd88oK3+LaEykw
	Bpa39iiOkC51TuIUDdiGqnXJPbD6efJv66Xqb/bDuEXr3lICWp+aGAkTo54qm6UoGyfCIC8UdyF
	xLxv4Noc/Sdfz3IACf1HsLNpHyVWCbV57z95JoYxZgVmDingv6RPbBy001cSYENQBEyoc/jn5eW
	Z1P8TJ+kwb+7+KXoCox4z7oiWZqWafarDahIWsl/r2+37kQSKbWXINBRKlLQEnROq9xtY3X1fDf
	ZCm4RjJ3k3wbOq/y6ZZGvp5eQ59x3BW2xm4eEekIcSpQXi2UtwQV5p3JugsygK6vK+h1bkM2osC
	O0CHc6uNYQAve9BN50c5JnyXlfeWRwTaL7SD47YD81Ryl/7V9sq6r37k7Z6mZRfzs=
X-Received: by 2002:a05:6214:2605:b0:8a2:4fea:4d44 with SMTP id 6a1803df08f44-8a7265ce890mr23115226d6.41.1775201932197;
        Fri, 03 Apr 2026 00:38:52 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-24.dlp.protect.broadcom.com. [144.49.247.24])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-8a5900d7183sm5089756d6.0.2026.04.03.00.38.51
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Apr 2026 00:38:52 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-35d9f68d00fso3597407a91.2
        for <netdev@vger.kernel.org>; Fri, 03 Apr 2026 00:38:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1775201931; x=1775806731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jBA5mYoFs7U2kVrS4kBVEGeuAEMM/jKmYSPSiTVI568=;
        b=Jc98MH7y5L1cGo7xYBR7wtVxUV0+SYbiNostYOApL7aGUcpi7sZLq3kxK0B29WMCml
         zv8JJ3VjS8vKIewHE67L/ArYPo4lGLcNrvQB2PJQyTsSZ5oXDqPeTXXtPU8E6mucSBmf
         i71m9zb27tMaMsSa5WsZEjXIM3MbXnx+d8PEA=
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr1758392a91.28.1775201930934;
        Fri, 03 Apr 2026 00:38:50 -0700 (PDT)
X-Received: by 2002:a17:90a:d005:b0:35d:9d28:e897 with SMTP id 98e67ed59e1d1-35de699f483mr1758378a91.28.1775201930506;
        Fri, 03 Apr 2026 00:38:50 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35dbe9377b7sm13124901a91.10.2026.04.03.00.38.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 00:38:50 -0700 (PDT)
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
Subject: [PATCH net-next v11 09/10] bng_en: implement netdev_stat_ops
Date: Fri,  3 Apr 2026 13:07:23 +0530
Message-ID: <20260403073724.194360-10-bhargava.marreddy@broadcom.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
References: <20260403073724.194360-1-bhargava.marreddy@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-274928-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bhargava.marreddy@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,broadcom.com:dkim,broadcom.com:email,broadcom.com:mid];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 6C12B391CAA
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
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 227 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   7 +
 2 files changed, 234 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 9a5d667defea..84090b048ba6 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2859,6 +2859,7 @@ static int bnge_open_core(struct bnge_net *bn)
 	}
 
 	set_bit(BNGE_STATE_OPEN, &bd->state);
+	set_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
 
 	bnge_enable_int(bn);
 
@@ -2897,6 +2898,77 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
 	return 0;
 }
 
+static void bnge_add_prev_ring_stats64(struct bnge_net *bn,
+				       struct rtnl_link_stats64 *stats)
+{
+	struct netdev_queue_stats_rx *rx_save = &bn->rxq_prv_stats;
+	struct netdev_queue_stats_tx *tx_save = &bn->txq_prv_stats;
+	struct rtnl_link_stats64 *stats64_save = &bn->prv_stats64;
+
+	stats->rx_packets += rx_save->packets;
+	stats->tx_packets += tx_save->packets;
+	stats->rx_bytes += rx_save->bytes;
+	stats->tx_bytes += tx_save->bytes;
+	stats->rx_missed_errors += rx_save->hw_drop_overruns;
+	stats->tx_dropped += tx_save->hw_drop_errors;
+
+	stats->multicast += stats64_save->multicast;
+}
+
+static void bnge_get_ring_stats64(struct bnge_dev *bd,
+				  struct rtnl_link_stats64 *stats)
+{
+	struct bnge_net *bn = netdev_priv(bd->netdev);
+	int i;
+
+	for (i = 0; i < bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		u64 tx_bytes, tx_packets, tx_dropped;
+		u64 multicast, rx_missed_errors;
+		struct bnge_nq_ring_info *nqr;
+		u64 rx_bytes, rx_packets;
+		unsigned int start;
+		u64 *sw;
+
+		nqr = &bnapi->nq_ring;
+		sw = nqr->stats.sw_stats;
+
+		do {
+			start = u64_stats_fetch_begin(&nqr->stats.syncp);
+
+			rx_packets = BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+			rx_packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+			rx_packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+
+			tx_packets = BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+			tx_packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+			tx_packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+
+			rx_bytes = BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+			rx_bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+			rx_bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+
+			tx_bytes = BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+			tx_bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+			tx_bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+
+			multicast = BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+			rx_missed_errors =
+				BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+			tx_dropped =
+				BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+		} while (u64_stats_fetch_retry(&nqr->stats.syncp, start));
+
+		stats->rx_packets += rx_packets;
+		stats->tx_packets += tx_packets;
+		stats->rx_bytes += rx_bytes;
+		stats->tx_bytes += tx_bytes;
+		stats->multicast += multicast;
+		stats->rx_missed_errors += rx_missed_errors;
+		stats->tx_dropped += tx_dropped;
+	}
+}
+
 static void bnge_get_port_stats64(struct bnge_net *bn,
 				  struct rtnl_link_stats64 *stats)
 {
@@ -2928,6 +3000,22 @@ static void bnge_get_port_stats64(struct bnge_net *bn,
 	} while (u64_stats_fetch_retry(&bn->port_stats.syncp, start));
 }
 
+static void bnge_fill_prev_stats64(struct bnge_net *bn,
+				   struct rtnl_link_stats64 *stats)
+{
+	struct netdev_queue_stats_rx *rx_save = &bn->rxq_prv_stats;
+	struct netdev_queue_stats_tx *tx_save = &bn->txq_prv_stats;
+	struct rtnl_link_stats64 *stats64_save = &bn->prv_stats64;
+
+	stats->rx_packets = rx_save->packets;
+	stats->tx_packets = tx_save->packets;
+	stats->rx_bytes = rx_save->bytes;
+	stats->tx_bytes = tx_save->bytes;
+	stats->rx_missed_errors = rx_save->hw_drop_overruns;
+	stats->tx_dropped = tx_save->hw_drop_errors;
+	stats->multicast = stats64_save->multicast;
+}
+
 static void bnge_get_stats64(struct net_device *dev,
 			     struct rtnl_link_stats64 *stats)
 {
@@ -2935,6 +3023,57 @@ static void bnge_get_stats64(struct net_device *dev,
 
 	if (bn->flags & BNGE_FLAG_PORT_STATS)
 		bnge_get_port_stats64(bn, stats);
+
+	spin_lock_bh(&bn->stats_lock);
+	if (!test_bit(BNGE_STATE_STATS_ENABLE, &bn->state)) {
+		bnge_fill_prev_stats64(bn, stats);
+		spin_unlock_bh(&bn->stats_lock);
+		return;
+	}
+
+	bnge_get_ring_stats64(bn->bd, stats);
+	bnge_add_prev_ring_stats64(bn, stats);
+	spin_unlock_bh(&bn->stats_lock);
+}
+
+static void bnge_save_ring_stats(struct bnge_net *bn)
+{
+	struct netdev_queue_stats_rx *rx_save = &bn->rxq_prv_stats;
+	struct netdev_queue_stats_tx *tx_save = &bn->txq_prv_stats;
+	struct rtnl_link_stats64 *stats64_save = &bn->prv_stats64;
+	int i;
+
+	for (i = 0; i < bn->bd->nq_nr_rings; i++) {
+		struct bnge_napi *bnapi = bn->bnapi[i];
+		struct bnge_nq_ring_info *nqr;
+		u64 *sw;
+
+		nqr = &bnapi->nq_ring;
+		sw = nqr->stats.sw_stats;
+
+		rx_save->packets += BNGE_GET_RING_STATS64(sw, rx_ucast_pkts);
+		rx_save->packets += BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+		rx_save->packets += BNGE_GET_RING_STATS64(sw, rx_bcast_pkts);
+		rx_save->bytes += BNGE_GET_RING_STATS64(sw, rx_ucast_bytes);
+		rx_save->bytes += BNGE_GET_RING_STATS64(sw, rx_mcast_bytes);
+		rx_save->bytes += BNGE_GET_RING_STATS64(sw, rx_bcast_bytes);
+		rx_save->hw_drop_overruns += BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+		rx_save->hw_drops += BNGE_GET_RING_STATS64(sw, rx_error_pkts) +
+				BNGE_GET_RING_STATS64(sw, rx_discard_pkts);
+
+		tx_save->packets += BNGE_GET_RING_STATS64(sw, tx_ucast_pkts);
+		tx_save->packets += BNGE_GET_RING_STATS64(sw, tx_mcast_pkts);
+		tx_save->packets += BNGE_GET_RING_STATS64(sw, tx_bcast_pkts);
+		tx_save->bytes += BNGE_GET_RING_STATS64(sw, tx_ucast_bytes);
+		tx_save->bytes += BNGE_GET_RING_STATS64(sw, tx_mcast_bytes);
+		tx_save->bytes += BNGE_GET_RING_STATS64(sw, tx_bcast_bytes);
+		tx_save->hw_drop_errors += BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+		tx_save->hw_drops += BNGE_GET_RING_STATS64(sw, tx_discard_pkts) +
+				BNGE_GET_RING_STATS64(sw, tx_error_pkts);
+
+		stats64_save->multicast +=
+			BNGE_GET_RING_STATS64(sw, rx_mcast_pkts);
+	}
 }
 
 static void bnge_close_core(struct bnge_net *bn)
@@ -2948,6 +3087,13 @@ static void bnge_close_core(struct bnge_net *bn)
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	spin_lock_bh(&bn->stats_lock);
+	bnge_save_ring_stats(bn);
+	clear_bit(BNGE_STATE_STATS_ENABLE, &bn->state);
+	spin_unlock_bh(&bn->stats_lock);
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2966,6 +3112,85 @@ static int bnge_close(struct net_device *dev)
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
+	rx->packets = bn->rxq_prv_stats.packets;
+	rx->bytes = bn->rxq_prv_stats.bytes;
+	rx->hw_drops = bn->rxq_prv_stats.hw_drops;
+	rx->hw_drop_overruns = bn->rxq_prv_stats.hw_drop_overruns;
+
+	tx->packets = bn->txq_prv_stats.packets;
+	tx->bytes = bn->txq_prv_stats.bytes;
+	tx->hw_drops = bn->txq_prv_stats.hw_drops;
+	tx->hw_drop_errors = bn->txq_prv_stats.hw_drop_errors;
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
@@ -3112,6 +3337,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	bd->netdev = netdev;
 
 	netdev->netdev_ops = &bnge_netdev_ops;
+	netdev->stat_ops = &bnge_stat_ops;
 
 	bnge_set_ethtool_ops(netdev);
 
@@ -3211,6 +3437,7 @@ int bnge_netdev_alloc(struct bnge_dev *bd, int max_irqs)
 	rc = bnge_alloc_port_stats(bn);
 	if (rc)
 		goto err_free_workq;
+	spin_lock_init(&bn->stats_lock);
 
 	netdev->request_ops_lock = true;
 	rc = register_netdev(netdev);
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index a73f51b01bc2..f4636b5b0cf3 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -8,6 +8,7 @@
 #include <linux/io-64-nonatomic-lo-hi.h>
 #include <linux/refcount.h>
 #include <linux/u64_stats_sync.h>
+#include <net/netdev_queues.h>
 #include "bnge_db.h"
 #include "bnge_hw_def.h"
 #include "bnge_link.h"
@@ -264,6 +265,7 @@ struct bnge_stats_mem {
 
 enum bnge_net_state {
 	BNGE_STATE_NAPI_DISABLED,
+	BNGE_STATE_STATS_ENABLE,
 };
 
 #define BNGE_TIMER_INTERVAL	HZ
@@ -361,6 +363,11 @@ struct bnge_net {
 	u16			fw_rx_stats_ext_size;
 	u16			fw_tx_stats_ext_size;
 
+	struct netdev_queue_stats_rx	rxq_prv_stats;
+	struct netdev_queue_stats_tx	txq_prv_stats;
+	struct rtnl_link_stats64	prv_stats64;
+	spinlock_t			stats_lock;
+
 	u8			pri2cos_idx[8];
 	bool			pri2cos_valid;
 };
-- 
2.47.3


