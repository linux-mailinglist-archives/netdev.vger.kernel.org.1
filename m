Return-Path: <netdev+bounces-252529-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uMVvEo+Fcml4lwAAu9opvQ
	(envelope-from <netdev+bounces-252529-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:16:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8886B6D5F5
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 21:16:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 791243012CC4
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 20:16:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D563806B8;
	Thu, 22 Jan 2026 20:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PkuwXz4H"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1D63320CD6
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 20:16:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769112971; cv=none; b=jbfkW3CVGRzL7yU7n2NRbJ9lHGMVH54fI+G45RnTfYlS8A4yv4Uw1WhPbJ8Tltff8cZpUL/SVKFZ0Xfx7S1Xvai3UyiaJmV738KvFlxrHw/0b5Heb8ZDIq1VJ0T/cVLiJfduSGps/wqLUVjlq2plwzm74/+VKfcyLkSyB3J/Sns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769112971; c=relaxed/simple;
	bh=Tehk9JrlgFpNSfXPDNiROc3FDw4ecgDHXj6NwGxDsyw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IGjsd6pXVDSApqyTZ+8cdJuNCz1ZQUSIPXtrkGJB3nx3Nw/se0dHZqG/wtVf8pkj+QYuc5i/IQMi9+yqCN9w4SqypzEfct1w+5AaUpLEOnWY1pA9deLxBdgY8+BJCqz+O+bYi34x/UvYz4TxCijFv+K/caAqzTM6Tag/6NdzKEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PkuwXz4H; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so1195371a91.3
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 12:16:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769112960; x=1769717760; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Sm1p55Lhtr7bC52ssSuFAxbhrBupFEQ8dwcLX8l+9PY=;
        b=PkuwXz4HCt4jVia5m5Rg/A+HmLEpYCtTFZQe1irdbNC/a1xZ0++tfXcyiVByjliNO8
         JAHMj5Nzd7tTlIASo4PQgIaHoUBAXi0eDnWpn8OTiF9+/6PESGhBWJkgU6Wh+ogY8+nW
         aYuPOIZz08rC7CK73fnK2FJi7qyQ+RqVbJXSUik+1kJhQp9s/t/fP5Tjs7zCsdZGCOg+
         5XWBOnzazrTSRZbYZrbDz+qAFA7XuJGKUDvmeLUhLVFtnb5jPb7J7K44QtHKeak1EmZb
         crHGkEZR7lpU6SSPCrRasC8D+JY2n+W97rpUuI9GieY924s9FYvf31yA94g50xKy3jJ0
         9gmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769112960; x=1769717760;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Sm1p55Lhtr7bC52ssSuFAxbhrBupFEQ8dwcLX8l+9PY=;
        b=oRyMiWd2BhJMUz9ocpxhw5cl0HflDJohMg2bPcub7/ux+Jr2Oo1K1Dh4nD0soLHGVy
         WE/P6P+OTLM4+nGQl1L2q5JcqeueRW58INrSq26I1u2y57VbOSnWUQ+nxC8OMJCrkpdD
         09ybDu1es9RwRWmy2RDhwbzX9mz4ErQefesNleo2XPCkaXCPbTOnfPeYUCB6To1U0bGX
         3didbU1G+Nvq58DqVXADNGm03xHC+Qe0NTKxhdFHFDr3oe9GwGulMHhiix+qqst1BdUc
         z2dmS2D6eKwO/k2cxEa7mGmf5WU/ZiNVgtlYGm+hbVXUu0dJGncxDGbGDfBDyWECWkfQ
         /fvw==
X-Gm-Message-State: AOJu0YzQ4z1Y2cWpZrop+aOu2i1+9litakoJdVYQRJkTD44cUNtQenZM
	FqwKxLgHSAj4N8DLbRjSl9qSGuRZMp490I4CUB+j0BUDEXly03wggLb7XJwPtw==
X-Gm-Gg: AZuq6aK8CvlR0wvO4FYtV8ijcFcFgPcZNKXYU8PfJsF6mENN7PwjJqA+fodGfvyq+z1
	Zm7T4/4/rg7f/x++NCg8+DXcaP4P6vVgRic/zDzg8e7reA2AcYz/3KNAXwEXS7DqOCiNGxGxSy+
	HuwZDJ5AsR3uuw+eFHxRB+b8d/wIfgFUjDRKBLbVPKgkeS+s+PCFgIxoNZfmEIC7TIDKjGPpRav
	bgJtlmTHnEKY4PrvZg1nlZK2IsnekFwKoZ8CpnUrrBJS7FRmbbTcpzKiyzGJheAR4eI6S2EfQsC
	odTf+lH3aeajyieI+DO9MGS2tHIVYPNO+ojXGRaFfwliPMHnOFUB1bBzOH+bX+QK0UHjy6CCd1h
	spqxdtNFiquD8P6R1j81Qymq98UQH/tOYRw8YV/H+fuwREvGG4Ic/iXWo/Qm2iOaMQmqsjywszB
	cqkRdbIwWprDCKJXY4sALpHPkgJ3o24wMxXpw3WM6ajj9B5eKPNin2rQ==
X-Received: by 2002:a17:90b:1f88:b0:349:3fe8:e7df with SMTP id 98e67ed59e1d1-35368953071mr522308a91.22.1769112959695;
        Thu, 22 Jan 2026 12:15:59 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3536b00fdb1sm104462a91.1.2026.01.22.12.15.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jan 2026 12:15:59 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next] net: systemport: Use u64_stats_t with u64_stats_sync properly
Date: Fri, 23 Jan 2026 04:15:41 +0800
Message-ID: <20260122201545.2792428-1-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,broadcom.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252529-lists,netdev=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8886B6D5F5
X-Rspamd-Action: no action

On 64bit arches, struct u64_stats_sync is empty and provides no help
against load/store tearing. Convert to u64_stats_t to ensure atomic
operations.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
RFC Comment:

I couldn't find the lock associated with u64_stats_sync. Should this be
considered an issue?
 drivers/net/ethernet/broadcom/bcmsysport.c | 56 ++++++++++++----------
 drivers/net/ethernet/broadcom/bcmsysport.h | 12 ++---
 2 files changed, 37 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bcmsysport.c b/drivers/net/ethernet/broadcom/bcmsysport.c
index bc4e1f3b3752..7017b2d2a1b5 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.c
+++ b/drivers/net/ethernet/broadcom/bcmsysport.c
@@ -435,8 +435,8 @@ static void bcm_sysport_update_tx_stats(struct bcm_sysport_priv *priv,
 		ring = &priv->tx_rings[q];
 		do {
 			start = u64_stats_fetch_begin(&priv->syncp);
-			bytes = ring->bytes;
-			packets = ring->packets;
+			bytes = u64_stats_read(&ring->bytes);
+			packets = u64_stats_read(&ring->packets);
 		} while (u64_stats_fetch_retry(&priv->syncp, start));
 
 		*tx_bytes += bytes;
@@ -458,8 +458,10 @@ static void bcm_sysport_get_stats(struct net_device *dev,
 	if (netif_running(dev)) {
 		bcm_sysport_update_mib_counters(priv);
 		bcm_sysport_update_tx_stats(priv, &tx_bytes, &tx_packets);
-		stats64->tx_bytes = tx_bytes;
-		stats64->tx_packets = tx_packets;
+		u64_stats_update_begin(&priv->syncp);
+		u64_stats_set(&stats64->tx_bytes, tx_bytes);
+		u64_stats_set(&stats64->tx_packets, tx_packets);
+		u64_stats_update_end(&priv->syncp);
 	}
 
 	for (i =  0, j = 0; i < BCM_SYSPORT_STATS_LEN; i++) {
@@ -482,28 +484,32 @@ static void bcm_sysport_get_stats(struct net_device *dev,
 		    s->type == BCM_SYSPORT_STAT_NETDEV64) {
 			do {
 				start = u64_stats_fetch_begin(syncp);
-				data[i] = *(u64 *)p;
+				data[i] = u64_stats_read((u64_stats_t *)p);
 			} while (u64_stats_fetch_retry(syncp, start));
 		} else
 			data[i] = *(u32 *)p;
 		j++;
 	}
 
-	/* For SYSTEMPORT Lite since we have holes in our statistics, j would
-	 * be equal to BCM_SYSPORT_STATS_LEN at the end of the loop, but it
-	 * needs to point to how many total statistics we have minus the
-	 * number of per TX queue statistics
-	 */
-	j = bcm_sysport_get_sset_count(dev, ETH_SS_STATS) -
-	    dev->num_tx_queues * NUM_SYSPORT_TXQ_STAT;
+	do {
+		/* For SYSTEMPORT Lite since we have holes in our statistics, j
+		 * would be equal to BCM_SYSPORT_STATS_LEN at the end of the
+		 * loop, but it needs to point to how many total statistics we
+		 * have minus the number of per TX queue statistics
+		 */
+		j = bcm_sysport_get_sset_count(dev, ETH_SS_STATS) -
+		    dev->num_tx_queues * NUM_SYSPORT_TXQ_STAT;
 
-	for (i = 0; i < dev->num_tx_queues; i++) {
-		ring = &priv->tx_rings[i];
-		data[j] = ring->packets;
-		j++;
-		data[j] = ring->bytes;
-		j++;
-	}
+		start = u64_stats_fetch_begin(syncp);
+
+		for (i = 0; i < dev->num_tx_queues; i++) {
+			ring = &priv->tx_rings[i];
+			data[j] = u64_stats_read(&ring->packets);
+			j++;
+			data[j] = u64_stats_read(&ring->bytes);
+			j++;
+		}
+	} while (u64_stats_fetch_retry(syncp, start));
 }
 
 static void bcm_sysport_get_wol(struct net_device *dev,
@@ -829,8 +835,8 @@ static unsigned int bcm_sysport_desc_rx(struct bcm_sysport_priv *priv,
 		ndev->stats.rx_packets++;
 		ndev->stats.rx_bytes += len;
 		u64_stats_update_begin(&priv->syncp);
-		stats64->rx_packets++;
-		stats64->rx_bytes += len;
+		u64_stats_inc(&stats64->rx_packets);
+		u64_stats_add(&stats64->rx_bytes, len);
 		u64_stats_update_end(&priv->syncp);
 
 		napi_gro_receive(&priv->napi, skb);
@@ -914,8 +920,8 @@ static unsigned int __bcm_sysport_tx_reclaim(struct bcm_sysport_priv *priv,
 	}
 
 	u64_stats_update_begin(&priv->syncp);
-	ring->packets += pkts_compl;
-	ring->bytes += bytes_compl;
+	u64_stats_add(&ring->packets, pkts_compl);
+	u64_stats_add(&ring->bytes, bytes_compl);
 	u64_stats_update_end(&priv->syncp);
 
 	ring->c_index = c_index;
@@ -1857,8 +1863,8 @@ static void bcm_sysport_get_stats64(struct net_device *dev,
 
 	do {
 		start = u64_stats_fetch_begin(&priv->syncp);
-		stats->rx_packets = stats64->rx_packets;
-		stats->rx_bytes = stats64->rx_bytes;
+		stats->rx_packets = u64_stats_read(&stats64->rx_packets);
+		stats->rx_bytes = u64_stats_read(&stats64->rx_bytes);
 	} while (u64_stats_fetch_retry(&priv->syncp, start));
 }
 
diff --git a/drivers/net/ethernet/broadcom/bcmsysport.h b/drivers/net/ethernet/broadcom/bcmsysport.h
index a34296f989f1..91b1c8293a23 100644
--- a/drivers/net/ethernet/broadcom/bcmsysport.h
+++ b/drivers/net/ethernet/broadcom/bcmsysport.h
@@ -652,10 +652,10 @@ struct bcm_sysport_stats {
 
 struct bcm_sysport_stats64 {
 	/* 64bit stats on 32bit/64bit Machine */
-	u64	rx_packets;
-	u64	rx_bytes;
-	u64	tx_packets;
-	u64	tx_bytes;
+	u64_stats_t	rx_packets;
+	u64_stats_t	rx_bytes;
+	u64_stats_t	tx_packets;
+	u64_stats_t	tx_bytes;
 };
 
 /* Software house keeping helper structure */
@@ -698,8 +698,8 @@ struct bcm_sysport_tx_ring {
 	unsigned int	clean_index;	/* Current clean index */
 	struct bcm_sysport_cb *cbs;	/* Transmit control blocks */
 	struct bcm_sysport_priv *priv;	/* private context backpointer */
-	unsigned long	packets;	/* packets statistics */
-	unsigned long	bytes;		/* bytes statistics */
+	u64_stats_t	packets;	/* packets statistics */
+	u64_stats_t	bytes;		/* bytes statistics */
 	unsigned int	switch_queue;	/* switch port queue number */
 	unsigned int	switch_port;	/* switch port queue number */
 	bool		inspect;	/* inspect switch port and queue */
-- 
2.51.0


