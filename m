Return-Path: <netdev+bounces-267916-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0FOMLBDBtmkWHwEAu9opvQ
	(envelope-from <netdev+bounces-267916-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:24:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CB9F291012
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 15:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9068B305EEB3
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:19:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D263368291;
	Sun, 15 Mar 2026 14:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="O8Wifsiw"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f97.google.com (mail-ot1-f97.google.com [209.85.210.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0F33368941
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 14:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773584320; cv=none; b=iW0M0o6kvEDe+le0k3EWWCwsNyMXMWhn0JeD3+vkWe7gTj++TYuvbKF2qJxae7PtezW7i2Ra2q4aYiq2njI/Lbaq4wg/HctJpg1KRJ6BbUHWSVagNtDp6o8+vF/Fwr/yOdWSjTbQExQJzZSJbg9GM24qVnB4WXBGnNTCicCx97A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773584320; c=relaxed/simple;
	bh=xeLBGKWLDwoWzVUgrLFagxSMqAxIiAVyI6AvxJHgAb4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nd1cU01hOvu0d+CKQMhwi7sRMtugsartSCEvWBEf5d1TxTWNwEKx/gq/D1WqlJMHZC3XpqZIZ3/f3N+rZ2yykFvwOm/J7IEiYDfQCy0bD0lMik+iEdVF3oGTyEzLgHRjj+pmLWE84ztTBxzpS5VlZkQfYQvGPjg3PKmO4Qnn6Is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=O8Wifsiw; arc=none smtp.client-ip=209.85.210.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ot1-f97.google.com with SMTP id 46e09a7af769-7d7422b4ff1so1625846a34.3
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773584317; x=1774189117;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:dkim-signature:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AAh3ISKJQxB+of/XmTrFR/7AjtNkBJimjNnj4gDwdz4=;
        b=rokZXhPmvDwqIrcQzCRsMV+0r0wig3vIGq2K53m/IKwn8Sa4GceLrmDrLZnJcfV9Ic
         PKjUsNIOQfDFJrKsgolr6pp37GhNUOWNPXqt6tj7xOek3ifxnoCTt7JAlxGYekBhmJXi
         i5BT5skqpNU8Qx6TWlUwNFMjLnolpf4NOvAKDVIHPI3A4kMRDVemdbb94tHwsagQRAqb
         RWizr0qa1a6y/RmgcGDNY0tW9M7Y6plT1N6rqRmE+rJZZepV41go9wVZIHQN6jjI/mgY
         nirgkGCfEiYw6uHQ4yE03LiCyStUZpPyHEkqaczzqDXMaTq1deCUg5Jx3103xl6CIPUJ
         ptCw==
X-Gm-Message-State: AOJu0YwLtJlAGmMzW3mgjiGdWMlq7hA39/9WIuO/3775rHnhWpqM2v77
	AQ1BH9kACidM0fYkVPv04f2iWMKKMm6NEgvArr5kwFOayDpaM94dseXzwq46G/JTsQlWdxcQlKC
	Bi32rjUqBTee6Rv94hvKss5x4eVV2ltGh32/mfWqmzDOAv9jkkakOf5vXfDsjNgy+YQIy6YLwVx
	EyypiTTrEDgrcq8KDgVHkiwnu+WlCTNZpqCRygmEIjtmiVOCiuJQjNRrMl86EUv6VOxzqZZBQgd
	CJy1xB/pg==
X-Gm-Gg: ATEYQzzJ9/QG+wZcrY+vgWD64YN8qMLMKA1rjHusKEdxuHojnBzaE01cCniRaKK89H2
	VJZUr7BpzyWrDN7IhtPLjDJy/N/TIw09oYlO2W7vIhYVyLb5fubsHUeqkMAPCnvaY4Dljwb46VF
	2t/Q0JchTYO8hS6KfVY8uEKttfaiU5VnElRrN5uqUAi0H5PwSlvksNpQzq9NPgd2b4fzTQ7NRgg
	KdUWL3bqeoizpYXrDJOtgtOfWd4Kw7Ua7y6VN16oBjRBFvL7yevRJDUGF50nJTZsmboQZK+ztcM
	mjAUUvfTWKgRQ7DtOiF91/gA8wWkqNGbBDCeUr6AkOFbsQPgLskbH0/DEfMSrDq6emXaC6Q7SAP
	2eUNwp16+rRBrguPn3Y6bKSL2iIXw1il01NM2/rjjH9QiJ23Pj34+16vnnR+JPhIPBH/8RKpeNV
	mHg+qmBT+rDixSITho8XlKsNsXcQePCqLFqohXVclf1OZGwGlIuMLSvo0=
X-Received: by 2002:a05:6830:6c11:b0:7d7:5748:b99f with SMTP id 46e09a7af769-7d78242a0d0mr5955670a34.4.1773584316774;
        Sun, 15 Mar 2026 07:18:36 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-63.dlp.protect.broadcom.com. [144.49.247.63])
        by smtp-relay.gmail.com with ESMTPS id 46e09a7af769-7d76ad6da27sm1823089a34.3.2026.03.15.07.18.36
        for <netdev@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 15 Mar 2026 07:18:36 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-pl1-f198.google.com with SMTP id d9443c01a7336-2ae57228f64so40570255ad.0
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 07:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1773584315; x=1774189115; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AAh3ISKJQxB+of/XmTrFR/7AjtNkBJimjNnj4gDwdz4=;
        b=O8WifsiwAynbZnvBLuMUfhcM3Gwp5VZ7CBYCIpvWpLGquin7jF7qbcXvYroOH2YFhM
         gqG+54gJpwJ/iR/1MwlqKXHYBj66mXqEpKi5lTgwDe/9bDBQ3FEfWwDNvDuLZstLhJ/M
         DSYDM5pexqGI6UK0T17eaTzC4UjxWOXUMOcHA=
X-Received: by 2002:a17:903:32c5:b0:2b0:489f:84e9 with SMTP id d9443c01a7336-2b0489f8931mr38383335ad.7.1773584315375;
        Sun, 15 Mar 2026 07:18:35 -0700 (PDT)
X-Received: by 2002:a17:903:32c5:b0:2b0:489f:84e9 with SMTP id d9443c01a7336-2b0489f8931mr38383155ad.7.1773584314916;
        Sun, 15 Mar 2026 07:18:34 -0700 (PDT)
Received: from localhost.localdomain ([192.19.203.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56c393sm76185395ad.17.2026.03.15.07.18.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 07:18:34 -0700 (PDT)
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
Subject: [PATCH net-next v7 08/10] bng_en: implement ndo_get_stats64
Date: Sun, 15 Mar 2026 19:46:03 +0530
Message-ID: <20260315141605.410878-9-vikas.gupta@broadcom.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260315141605.410878-1-vikas.gupta@broadcom.com>
References: <20260315141605.410878-1-vikas.gupta@broadcom.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-267916-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[broadcom.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vikas.gupta@broadcom.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[broadcom.com:dkim,broadcom.com:email,broadcom.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 2CB9F291012
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Bhargava Marreddy <bhargava.marreddy@broadcom.com>

Implement the ndo_get_stats64 callback to report aggregate network
statistics. The driver gathers these by accumulating the per-ring
counters into the provided rtnl_link_stats64 structure.

Signed-off-by: Bhargava Marreddy <bhargava.marreddy@broadcom.com>
Reviewed-by: Vikas Gupta <vikas.gupta@broadcom.com>
---
 .../net/ethernet/broadcom/bnge/bnge_netdev.c  | 100 ++++++++++++++++++
 .../net/ethernet/broadcom/bnge/bnge_netdev.h  |   2 +
 2 files changed, 102 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
index 93f0149bd775..2513b0907693 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.c
@@ -2904,6 +2904,99 @@ static int bnge_shutdown_nic(struct bnge_net *bn)
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
+		struct bnge_nq_ring_info *nqr;
+		u64 *sw;
+
+		nqr = &bnapi->nq_ring;
+		sw = nqr->stats.sw_stats;
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
+		stats->tx_dropped += BNGE_GET_RING_STATS64(sw, tx_error_pkts);
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
@@ -2911,10 +3004,16 @@ static void bnge_close_core(struct bnge_net *bn)
 	bnge_tx_disable(bn);
 
 	clear_bit(BNGE_STATE_OPEN, &bd->state);
+	synchronize_rcu();
 
 	timer_delete_sync(&bn->timer);
 	bnge_shutdown_nic(bn);
 	bnge_disable_napi(bn);
+
+	/* Save ring stats before shutdown */
+	if (bn->bnapi)
+		bnge_get_ring_stats(bd, &bn->net_stats_prev);
+
 	bnge_free_all_rings_bufs(bn);
 	bnge_free_irq(bn);
 	bnge_del_napi(bn);
@@ -2936,6 +3035,7 @@ static const struct net_device_ops bnge_netdev_ops = {
 	.ndo_open		= bnge_open,
 	.ndo_stop		= bnge_close,
 	.ndo_start_xmit		= bnge_start_xmit,
+	.ndo_get_stats64	= bnge_get_stats64,
 	.ndo_features_check	= bnge_features_check,
 };
 
diff --git a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
index 548c5a77e76a..a23302a1ab9d 100644
--- a/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
+++ b/drivers/net/ethernet/broadcom/bnge/bnge_netdev.h
@@ -353,6 +353,8 @@ struct bnge_net {
 
 	u64			flags;
 
+	struct rtnl_link_stats64	net_stats_prev;
+
 	struct bnge_stats_mem	port_stats;
 	struct bnge_stats_mem	rx_port_stats_ext;
 	struct bnge_stats_mem	tx_port_stats_ext;
-- 
2.47.1


