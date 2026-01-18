Return-Path: <netdev+bounces-250774-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CC743D3921B
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 02:40:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 6E1A43015465
	for <lists+netdev@lfdr.de>; Sun, 18 Jan 2026 01:40:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AB720E6E2;
	Sun, 18 Jan 2026 01:39:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GANmK4Jq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E073E205E25
	for <netdev@vger.kernel.org>; Sun, 18 Jan 2026 01:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768700398; cv=none; b=hu2ZmTmFWjdYDydKhSaZ46x2y4iMz/2DIBDDGyamUSPdgOHWExzvmB/w++yzjyrir6kxwlJBp5awtXAYdhXHHcuPVM6OFFwJKc/WQUkpuVUPNopX4o5yFPAuhfNQ3OSV1CosC+7nNEfq1YIhaF7aIZPZB22Ma4C+9r0LHJ2SUMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768700398; c=relaxed/simple;
	bh=1dMRjURizLmyAKEXN7wjz53SViwwPTPux9yr0Zr60gY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLA+tp79eM/gFaMSzNc9xov6+3xJwULI4aDwiAVrerayR+s4gUCHIcGfjxHmuBMxNsuQdrc6cv20N36j4eRpLfbvD/3F3RgN1bs5SGwbC5AaHe36FByysxYv1YydR1RVjDRvfrQw24qvkzKwFnPD/iDX2qq/PuJ1skRiwIWpDIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GANmK4Jq; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2a0d5c365ceso24890945ad.3
        for <netdev@vger.kernel.org>; Sat, 17 Jan 2026 17:39:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768700396; x=1769305196; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=umLx+BGjT4uYx/x7sL81vw16fF3imM/rUa8KKEKKGMc=;
        b=GANmK4JqJwvG1sHDEQiQJeA3wSaYbQy/Zkr8MorppD54fRpYnG+P4Vq+jONsGeG/ZU
         maZQeZ5ZfEoArN8dRSj2lDW7YohH282YwWvm4ckaZzfCvxVnqHuwNXiyxHZSotJOkpvb
         /itZtjnXKLauEMfqonTNpYmj4Yfrema4GcAjHfIC0T/ixY+RTliawZL1CT8iEEubxbeo
         +xVCiKOYffJhB1aPhi3fFA7BoWVSAwVBU3PHP9S3h7ygDgZA+QieYzdfo8qfa+DRuODJ
         EcEG4I0IVTLb4iA3z/qyuHEedP602oyf0kZJTYNzZGxQ27xeEOydCPkymel8kFPG0ucq
         eP7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768700396; x=1769305196;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=umLx+BGjT4uYx/x7sL81vw16fF3imM/rUa8KKEKKGMc=;
        b=eeQUstWn64yN+fWwYsVinqnk2SE2UVrqUDvAU+ueWCKak/BFNYrI0MH8wRGEJtqZEv
         3cPuccHTWF2U8Bk8BhrVg5DRbLcp7kzVy+/w+3EJFK66NeaxQYz/Dr0MSCX5bkW6N6EI
         t1WqAQ53Nw3uPbTWyIG+DVtwPCDkSvaBj63pxJf6BgVGBJqZfBpBr6l16inJQbWF8IM2
         c+FRWaDHH4ATV8dCTsnhdKn7QBVc59Z8xeOKPgOCtsYaOIOWZ8iip/JPSPa/oMOVCQiV
         vrWbLeTICB8DLuivmMEdJ/EOD1xlkz13YeEIQZHaG/GOyPx3ERdvL81n73ErwUx/BFwD
         GH+Q==
X-Gm-Message-State: AOJu0Yzs3IQloGsxLGEdRkPp+OOHQAOvCd8alP7gLQnCny2Ae/116wNE
	NSh7RhDlDcb+MWP5Wu4ORgIZJiLS+b/O9Vh0UMixJNPtSD2tchnrca5sIwja0g==
X-Gm-Gg: AY/fxX4bW/HzoDvd0UiIKwslkcnlpUSnZAIM0N5VJ5lfjT5adxmOUv7/xiyTGXr6dzd
	K78pxJsTACYTRXQJsbsKK6HxDcnof2VLpX4ZQwp3ggfNJK7H+BzYm1GGE0LKBf8hND5OsQigj+M
	FimGK8KPwQ4guwSGYAMMp19ksrEqnz5JKzVxaImnByUoXyVRmTopVthSbEUkwsW/hEhEIgARcMN
	HmqaAP2Hg1q1o9n/455cTd6yTbJEdjY11MeWDFEEdtrbxV88namTSP/U9sAPXu0Zj8vWvzxqEyA
	iFWetQWF0B5mAC/MfHI1Usgi3tmChlVepq7sXOhTsUvsSvm7bK7Z9LP2orWlF3Depj99rC4/aez
	FzUcRp5tZ6xVLrdB1tQbrvWHi1j7NIHv4isGMerf2NFD5NG+6BE33j32LqerSR0RJ5CfcSzyUwN
	z9LkunnOyIrLic/wIlVT87V93FG0PphaK43RPmu9jcqftT70cp0w==
X-Received: by 2002:a17:902:f652:b0:269:8d1b:40c3 with SMTP id d9443c01a7336-2a71888abfdmr77013255ad.12.1768700395992;
        Sat, 17 Jan 2026 17:39:55 -0800 (PST)
Received: from d.home.mmyangfl.tk ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a7193dbbf5sm56030615ad.47.2026.01.17.17.39.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Jan 2026 17:39:55 -0800 (PST)
From: David Yang <mmyangfl@gmail.com>
To: netdev@vger.kernel.org
Cc: David Yang <mmyangfl@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v6 3/3] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Sun, 18 Jan 2026 09:30:16 +0800
Message-ID: <20260118013019.1078847-4-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260118013019.1078847-1-mmyangfl@gmail.com>
References: <20260118013019.1078847-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

64-bit variables might not be atomic on 32-bit architectures, thus
cannot be unconditionally made lock-free. Use u64_stats_t so it would
still be lock-free on 64-bit architectures.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 236 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 114 ++++++++++---------
 2 files changed, 205 insertions(+), 145 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index fe08385445d2..f850117e7a68 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -18,6 +18,7 @@
 #include <linux/of.h>
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
+#include <linux/u64_stats_sync.h>
 
 #include <net/dsa.h>
 
@@ -666,22 +667,20 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
 static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 {
 	struct yt921x_port *pp = &priv->ports[port];
+	struct yt921x_mib *mib_new = &pp->mib_new;
 	struct device *dev = to_device(priv);
 	struct yt921x_mib *mib = &pp->mib;
+	u64 rx_frames;
+	u64 tx_frames;
 	int res = 0;
 
-	/* Reading of yt921x_port::mib is not protected by a lock and it's vain
-	 * to keep its consistency, since we have to read registers one by one
-	 * and there is no way to make a snapshot of MIB stats.
-	 *
-	 * Writing (by this function only) is and should be protected by
-	 * reg_lock.
+	/* u64_stats_read/set is redundant for mib_new, but I don't want to
+	 * declare a plain u64 yt921x_mib variant.
 	 */
 
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64 *valp = &((u64 *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -690,7 +689,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = u64_stats_read(&mib->stats[i]);
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -704,7 +703,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		WRITE_ONCE(*valp, val);
+		u64_stats_set(&mib_new->stats[i], val);
 	}
 
 	if (res) {
@@ -713,14 +712,29 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 		return res;
 	}
 
-	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
-			mib->rx_128_255byte + mib->rx_256_511byte +
-			mib->rx_512_1023byte + mib->rx_1024_1518byte +
-			mib->rx_jumbo;
-	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
-			mib->tx_128_255byte + mib->tx_256_511byte +
-			mib->tx_512_1023byte + mib->tx_1024_1518byte +
-			mib->tx_jumbo;
+	rx_frames = u64_stats_read(&mib_new->rx_64byte) +
+		    u64_stats_read(&mib_new->rx_65_127byte) +
+		    u64_stats_read(&mib_new->rx_128_255byte) +
+		    u64_stats_read(&mib_new->rx_256_511byte) +
+		    u64_stats_read(&mib_new->rx_512_1023byte) +
+		    u64_stats_read(&mib_new->rx_1024_1518byte) +
+		    u64_stats_read(&mib_new->rx_jumbo);
+	tx_frames = u64_stats_read(&mib_new->tx_64byte) +
+		    u64_stats_read(&mib_new->tx_65_127byte) +
+		    u64_stats_read(&mib_new->tx_128_255byte) +
+		    u64_stats_read(&mib_new->tx_256_511byte) +
+		    u64_stats_read(&mib_new->tx_512_1023byte) +
+		    u64_stats_read(&mib_new->tx_1024_1518byte) +
+		    u64_stats_read(&mib_new->tx_jumbo);
+
+	u64_stats_update_begin(&pp->syncp);
+	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+		u64_stats_set(&mib->stats[i],
+			      u64_stats_read(&mib_new->stats[i]));
+	}
+	u64_stats_set(&pp->rx_frames, rx_frames);
+	u64_stats_set(&pp->tx_frames, tx_frames);
+	u64_stats_update_end(&pp->syncp);
 
 	return 0;
 }
@@ -765,22 +779,27 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
+	unsigned int start;
 	size_t j;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	j = 0;
-	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
-		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
+	do {
+		start = u64_stats_fetch_begin(&pp->syncp);
 
-		if (!desc->name)
-			continue;
+		j = 0;
+		for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
+			const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 
-		data[j] = ((u64 *)mib)[i];
-		j++;
-	}
+			if (!desc->name)
+				continue;
+
+			data[j] = u64_stats_read(&((u64_stats_t *)mib)[i]);
+			j++;
+		}
+	} while (u64_stats_fetch_retry(&pp->syncp, start));
 }
 
 static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -807,33 +826,38 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
+	unsigned int start;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	mac_stats->FramesTransmittedOK = pp->tx_frames;
-	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
-	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
-	mac_stats->FramesReceivedOK = pp->rx_frames;
-	mac_stats->FrameCheckSequenceErrors = mib->rx_crc_errors;
-	mac_stats->AlignmentErrors = mib->rx_alignment_errors;
-	mac_stats->OctetsTransmittedOK = mib->tx_good_bytes;
-	mac_stats->FramesWithDeferredXmissions = mib->tx_deferred;
-	mac_stats->LateCollisions = mib->tx_late_collisions;
-	mac_stats->FramesAbortedDueToXSColls = mib->tx_aborted_errors;
-	/* mac_stats->FramesLostDueToIntMACXmitError */
-	/* mac_stats->CarrierSenseErrors */
-	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
-	/* mac_stats->FramesLostDueToIntMACRcvError */
-	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
-	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
-	/* mac_stats->FramesWithExcessiveDeferral */
-	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
-	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
-	/* mac_stats->InRangeLengthErrors */
-	/* mac_stats->OutOfRangeLengthField */
-	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+	do {
+		start = u64_stats_fetch_begin(&pp->syncp);
+
+		mac_stats->FramesTransmittedOK = u64_stats_read(&pp->tx_frames);
+		mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
+		mac_stats->MultipleCollisionFrames = u64_stats_read(&mib->tx_multiple_collisions);
+		mac_stats->FramesReceivedOK = u64_stats_read(&pp->rx_frames);
+		mac_stats->FrameCheckSequenceErrors = u64_stats_read(&mib->rx_crc_errors);
+		mac_stats->AlignmentErrors = u64_stats_read(&mib->rx_alignment_errors);
+		mac_stats->OctetsTransmittedOK = u64_stats_read(&mib->tx_good_bytes);
+		mac_stats->FramesWithDeferredXmissions = u64_stats_read(&mib->tx_deferred);
+		mac_stats->LateCollisions = u64_stats_read(&mib->tx_late_collisions);
+		mac_stats->FramesAbortedDueToXSColls = u64_stats_read(&mib->tx_aborted_errors);
+		/* mac_stats->FramesLostDueToIntMACXmitError */
+		/* mac_stats->CarrierSenseErrors */
+		mac_stats->OctetsReceivedOK = u64_stats_read(&mib->rx_good_bytes);
+		/* mac_stats->FramesLostDueToIntMACRcvError */
+		mac_stats->MulticastFramesXmittedOK = u64_stats_read(&mib->tx_multicast);
+		mac_stats->BroadcastFramesXmittedOK = u64_stats_read(&mib->tx_broadcast);
+		/* mac_stats->FramesWithExcessiveDeferral */
+		mac_stats->MulticastFramesReceivedOK = u64_stats_read(&mib->rx_multicast);
+		mac_stats->BroadcastFramesReceivedOK = u64_stats_read(&mib->rx_broadcast);
+		/* mac_stats->InRangeLengthErrors */
+		/* mac_stats->OutOfRangeLengthField */
+		mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
+	} while (u64_stats_fetch_retry(&pp->syncp, start));
 }
 
 static void
@@ -843,14 +867,19 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
+	unsigned int start;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
-	/* ctrl_stats->UnsupportedOpcodesReceived */
+	do {
+		start = u64_stats_fetch_begin(&pp->syncp);
+
+		ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
+		ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
+		/* ctrl_stats->UnsupportedOpcodesReceived */
+	} while (u64_stats_fetch_retry(&pp->syncp, start));
 }
 
 static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
@@ -872,6 +901,7 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
+	unsigned int start;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
@@ -879,26 +909,30 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
 	*ranges = yt921x_rmon_ranges;
 
-	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
-	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
-	rmon_stats->fragments = mib->rx_alignment_errors;
-	/* rmon_stats->jabbers */
-
-	rmon_stats->hist[0] = mib->rx_64byte;
-	rmon_stats->hist[1] = mib->rx_65_127byte;
-	rmon_stats->hist[2] = mib->rx_128_255byte;
-	rmon_stats->hist[3] = mib->rx_256_511byte;
-	rmon_stats->hist[4] = mib->rx_512_1023byte;
-	rmon_stats->hist[5] = mib->rx_1024_1518byte;
-	rmon_stats->hist[6] = mib->rx_jumbo;
-
-	rmon_stats->hist_tx[0] = mib->tx_64byte;
-	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
-	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
-	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
-	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
-	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
-	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+	do {
+		start = u64_stats_fetch_begin(&pp->syncp);
+
+		rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
+		rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
+		rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
+		/* rmon_stats->jabbers */
+
+		rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
+		rmon_stats->hist[1] = u64_stats_read(&mib->rx_65_127byte);
+		rmon_stats->hist[2] = u64_stats_read(&mib->rx_128_255byte);
+		rmon_stats->hist[3] = u64_stats_read(&mib->rx_256_511byte);
+		rmon_stats->hist[4] = u64_stats_read(&mib->rx_512_1023byte);
+		rmon_stats->hist[5] = u64_stats_read(&mib->rx_1024_1518byte);
+		rmon_stats->hist[6] = u64_stats_read(&mib->rx_jumbo);
+
+		rmon_stats->hist_tx[0] = u64_stats_read(&mib->tx_64byte);
+		rmon_stats->hist_tx[1] = u64_stats_read(&mib->tx_65_127byte);
+		rmon_stats->hist_tx[2] = u64_stats_read(&mib->tx_128_255byte);
+		rmon_stats->hist_tx[3] = u64_stats_read(&mib->tx_256_511byte);
+		rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
+		rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
+		rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
+	} while (u64_stats_fetch_retry(&pp->syncp, start));
 }
 
 static void
@@ -908,33 +942,41 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
+	unsigned int start;
+
+	do {
+		start = u64_stats_fetch_begin(&pp->syncp);
+
+		stats->rx_length_errors = u64_stats_read(&mib->rx_undersize_errors) +
+					  u64_stats_read(&mib->rx_fragment_errors);
+		stats->rx_over_errors = u64_stats_read(&mib->rx_oversize_errors);
+		stats->rx_crc_errors = u64_stats_read(&mib->rx_crc_errors);
+		stats->rx_frame_errors = u64_stats_read(&mib->rx_alignment_errors);
+		/* stats->rx_fifo_errors */
+		/* stats->rx_missed_errors */
+
+		stats->tx_aborted_errors = u64_stats_read(&mib->tx_aborted_errors);
+		/* stats->tx_carrier_errors */
+		stats->tx_fifo_errors = u64_stats_read(&mib->tx_undersize_errors);
+		/* stats->tx_heartbeat_errors */
+		stats->tx_window_errors = u64_stats_read(&mib->tx_late_collisions);
+
+		stats->rx_packets = u64_stats_read(&pp->rx_frames);
+		stats->tx_packets = u64_stats_read(&pp->tx_frames);
+		stats->rx_bytes = u64_stats_read(&mib->rx_good_bytes) -
+				  ETH_FCS_LEN * stats->rx_packets;
+		stats->tx_bytes = u64_stats_read(&mib->tx_good_bytes) -
+				  ETH_FCS_LEN * stats->tx_packets;
+		stats->rx_dropped = u64_stats_read(&mib->rx_dropped);
+		/* stats->tx_dropped */
+		stats->multicast = u64_stats_read(&mib->rx_multicast);
+		stats->collisions = u64_stats_read(&mib->tx_collisions);
+	} while (u64_stats_fetch_retry(&pp->syncp, start));
 
-	stats->rx_length_errors = mib->rx_undersize_errors +
-				  mib->rx_fragment_errors;
-	stats->rx_over_errors = mib->rx_oversize_errors;
-	stats->rx_crc_errors = mib->rx_crc_errors;
-	stats->rx_frame_errors = mib->rx_alignment_errors;
-	/* stats->rx_fifo_errors */
-	/* stats->rx_missed_errors */
-
-	stats->tx_aborted_errors = mib->tx_aborted_errors;
-	/* stats->tx_carrier_errors */
-	stats->tx_fifo_errors = mib->tx_undersize_errors;
-	/* stats->tx_heartbeat_errors */
-	stats->tx_window_errors = mib->tx_late_collisions;
-
-	stats->rx_packets = pp->rx_frames;
-	stats->tx_packets = pp->tx_frames;
-	stats->rx_bytes = mib->rx_good_bytes - ETH_FCS_LEN * stats->rx_packets;
-	stats->tx_bytes = mib->tx_good_bytes - ETH_FCS_LEN * stats->tx_packets;
 	stats->rx_errors = stats->rx_length_errors + stats->rx_over_errors +
 			   stats->rx_crc_errors + stats->rx_frame_errors;
 	stats->tx_errors = stats->tx_aborted_errors + stats->tx_fifo_errors +
 			   stats->tx_window_errors;
-	stats->rx_dropped = mib->rx_dropped;
-	/* stats->tx_dropped */
-	stats->multicast = mib->rx_multicast;
-	stats->collisions = mib->tx_collisions;
 }
 
 static void
@@ -944,13 +986,18 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	struct yt921x_priv *priv = to_yt921x_priv(ds);
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
+	unsigned int start;
 
 	mutex_lock(&priv->reg_lock);
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
-	pause_stats->tx_pause_frames = mib->tx_pause;
-	pause_stats->rx_pause_frames = mib->rx_pause;
+	do {
+		start = u64_stats_fetch_begin(&pp->syncp);
+
+		pause_stats->tx_pause_frames = u64_stats_read(&mib->tx_pause);
+		pause_stats->rx_pause_frames = u64_stats_read(&mib->rx_pause);
+	} while (u64_stats_fetch_retry(&pp->syncp, start));
 }
 
 static int
@@ -2971,6 +3018,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 		pp->index = i;
 		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		u64_stats_init(&pp->syncp);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 61bb0ab3b09a..29d82f2b7733 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -6,6 +6,8 @@
 #ifndef __YT921X_H
 #define __YT921X_H
 
+#include <linux/u64_stats_sync.h>
+
 #include <net/dsa.h>
 
 #define YT921X_SMI_SWITCHID_M		GENMASK(3, 2)
@@ -475,55 +477,61 @@ enum yt921x_fdb_entry_status {
 #define yt921x_port_is_external(port) (8 <= (port) && (port) < 9)
 
 struct yt921x_mib {
-	u64 rx_broadcast;
-	u64 rx_pause;
-	u64 rx_multicast;
-	u64 rx_crc_errors;
-
-	u64 rx_alignment_errors;
-	u64 rx_undersize_errors;
-	u64 rx_fragment_errors;
-	u64 rx_64byte;
-
-	u64 rx_65_127byte;
-	u64 rx_128_255byte;
-	u64 rx_256_511byte;
-	u64 rx_512_1023byte;
-
-	u64 rx_1024_1518byte;
-	u64 rx_jumbo;
-	u64 rx_good_bytes;
-
-	u64 rx_bad_bytes;
-	u64 rx_oversize_errors;
-
-	u64 rx_dropped;
-	u64 tx_broadcast;
-	u64 tx_pause;
-	u64 tx_multicast;
-
-	u64 tx_undersize_errors;
-	u64 tx_64byte;
-	u64 tx_65_127byte;
-	u64 tx_128_255byte;
-
-	u64 tx_256_511byte;
-	u64 tx_512_1023byte;
-	u64 tx_1024_1518byte;
-	u64 tx_jumbo;
-
-	u64 tx_good_bytes;
-	u64 tx_collisions;
-
-	u64 tx_aborted_errors;
-	u64 tx_multiple_collisions;
-	u64 tx_single_collisions;
-	u64 tx_good;
-
-	u64 tx_deferred;
-	u64 tx_late_collisions;
-	u64 rx_oam;
-	u64 tx_oam;
+	union {
+		struct {
+			u64_stats_t rx_broadcast;
+			u64_stats_t rx_pause;
+			u64_stats_t rx_multicast;
+			u64_stats_t rx_crc_errors;
+
+			u64_stats_t rx_alignment_errors;
+			u64_stats_t rx_undersize_errors;
+			u64_stats_t rx_fragment_errors;
+			u64_stats_t rx_64byte;
+
+			u64_stats_t rx_65_127byte;
+			u64_stats_t rx_128_255byte;
+			u64_stats_t rx_256_511byte;
+			u64_stats_t rx_512_1023byte;
+
+			u64_stats_t rx_1024_1518byte;
+			u64_stats_t rx_jumbo;
+			u64_stats_t rx_good_bytes;
+
+			u64_stats_t rx_bad_bytes;
+			u64_stats_t rx_oversize_errors;
+
+			u64_stats_t rx_dropped;
+			u64_stats_t tx_broadcast;
+			u64_stats_t tx_pause;
+			u64_stats_t tx_multicast;
+
+			u64_stats_t tx_undersize_errors;
+			u64_stats_t tx_64byte;
+			u64_stats_t tx_65_127byte;
+			u64_stats_t tx_128_255byte;
+
+			u64_stats_t tx_256_511byte;
+			u64_stats_t tx_512_1023byte;
+			u64_stats_t tx_1024_1518byte;
+			u64_stats_t tx_jumbo;
+
+			u64_stats_t tx_good_bytes;
+			u64_stats_t tx_collisions;
+
+			u64_stats_t tx_aborted_errors;
+			u64_stats_t tx_multiple_collisions;
+			u64_stats_t tx_single_collisions;
+			u64_stats_t tx_good;
+
+			u64_stats_t tx_deferred;
+			u64_stats_t tx_late_collisions;
+			u64_stats_t rx_oam;
+			u64_stats_t tx_oam;
+		};
+
+		u64_stats_t stats[39];
+	};
 };
 
 struct yt921x_port {
@@ -533,9 +541,13 @@ struct yt921x_port {
 	bool isolated;
 
 	struct delayed_work mib_read;
+	struct u64_stats_sync syncp;
 	struct yt921x_mib mib;
-	u64 rx_frames;
-	u64 tx_frames;
+	u64_stats_t rx_frames;
+	u64_stats_t tx_frames;
+
+	/* only used by read routine to avoid huge allocations on the stack */
+	struct yt921x_mib mib_new;
 };
 
 struct yt921x_reg_ops {
-- 
2.51.0


