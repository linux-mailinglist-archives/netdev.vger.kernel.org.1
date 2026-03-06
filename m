Return-Path: <netdev+bounces-264867-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +LwiGfX3qmlxZAEAu9opvQ
	(envelope-from <netdev+bounces-264867-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F24C02243D9
	for <lists+netdev@lfdr.de>; Fri, 06 Mar 2026 16:51:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 29B2F305D263
	for <lists+netdev@lfdr.de>; Fri,  6 Mar 2026 15:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D1353EBF09;
	Fri,  6 Mar 2026 15:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rr5T8ZVo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E932F3EB7F8
	for <netdev@vger.kernel.org>; Fri,  6 Mar 2026 15:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772812175; cv=none; b=O3RUe6RBZvSf+1haTqd5D1CIivSgE72ZerTwLY6o/T3C7OA8Kjc9UOrwod0MWkdjJT0JavL3usesTH7ij3L5JZ4bsj+5cyl4oTA+9ibOb5N6nef9D4b0gxnIhsst+fAGpVOnxhCm2AmHrgcDNjFicIZutSUA7l9FHnnUZzNoud4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772812175; c=relaxed/simple;
	bh=2bqmAe4MDbDAkCULiEykTd+QxH4ulctvP2IJ9jekacs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DYrtYwqphVK9TAcbgXlLhwFly4sNGzbL97XYNFBiQ0WjmU6VArO1gZh4WeLBqOp9NNxqXM0c25ITsdwigt8Ge8RY2yxP28YNY+1MnlidqL5ujKfv+wvc49svhvQa5+JczyGMNXkV3ahAOJZammTVf/NvVbmj0ITxWHWuehy6NGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rr5T8ZVo; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-359a5d8b3f8so2051642a91.3
        for <netdev@vger.kernel.org>; Fri, 06 Mar 2026 07:49:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772812173; x=1773416973; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wouP51WRVkoVl7gi11YNMLD9kIN48p1TbHSTtEAAOxY=;
        b=Rr5T8ZVoEzlvHuUS+/K5y67qjCPCQCcz1JDSV1EUHvTGXqntNHPe0sd7e6h9DoUfgS
         ex6qCC2SI7kMqIGDI0p/x/1cGjsqgTQ+nV3g3NCqRtMSfSaYam+M8ni5ohX4f2mxbfPU
         uTGh5JVgzQ8N7iOL+xuF5OOCessgzy5yVBtiNHAytuVoV+nLdyAdLdV/MVa74awdpqW9
         Wd7oO48yhuLG1dRIE9L1ZpVjRDkdgBpE+z8i+lVWeWauyLGBMjsKh7kuc3UaYfwJ7REm
         2c31+JDxLC48eQgU5JWGcqTcNWM0MsP/J04o9coC2Y46/UQ7f9ZZiSwVJGADlYs4Kd0l
         5B8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772812173; x=1773416973;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wouP51WRVkoVl7gi11YNMLD9kIN48p1TbHSTtEAAOxY=;
        b=JddIbzoePAuq9L0OgRZH2K0AVkInKK9Zbd+GoUEtJ6j7BAww3nJMwuoZQXjmGcFm/2
         e8W9xv3DA9kERsilVtmNNG8Ym0uczpMC+0XpFEwAriss3U1e87JQIVWXzNemVmca0C7w
         nhVaBdQjSYALeg8q6OmLRWqGWimCP4htmFyEQQ7pHHRkb0ZvgPavASiWf+VsCOCtKCQH
         aE9shGq9449XQS+USOywg1V8Bi7sjDiYcTRntK7GnI7FCq5RYhB9v2q92ppgDOxMrpGz
         yA0hOMq8u4t0AGaCo2r+XPsPVDD5r3q7xc59tfrZPSNcgNGNz2jpYs9pp1rEcSuXAACX
         NVLA==
X-Gm-Message-State: AOJu0YyQDkVRpNed4miNGIAjzIMTHEdYd+t4Pw+KjmjgQ2VixLkzT6nj
	hma7ciWXvELiwZw/r5BS8cRy9N9yHzW5p2ZbC+s6aTjGirwQfbOY5vadjGGywbT2Fjg=
X-Gm-Gg: ATEYQzxg3EQ76vr5TYvaYSkoSTuJGxjIvIa9cO+gEpXmJlb+wYXAJ1HPgdyrwFu8tSh
	b8GaM5rTWRrU9RTT6YkidbOZsYwf41t7Nu3/asCAveg+BB1kDPbBjLVkxTCvSuHnrBCz+MPIphb
	x1nda3uvbMohprwyC4B7h7dOhdXIw3qannmM+6kk60l+i0f0b53/VbsSGzxQhLTk7gB6CCQeFyQ
	h3IYizM5hb8vWBFnvgq4Jf0mBhyQMMIqz9NuTDmsG0/65LjAymx1k97uZRogAIGyTjZCDxAjhDY
	sdIv1hpZgBrrV7IW3EELoHqIVqMwmytkbA0/t1bfuRu71XF/ouz51qDKnVkZIQKM2M/c9eDQtX+
	fRMNbUtvVrklZiZqzpIWV1Ww9NLF3G79P+YzPulAluPU0lA06GTTPkubo1yZfuZfrt6F9uhBowp
	oWmaQv6V2CrtYvg9PtQ7Hltc3DDnxajlO0bGTss7GbN0Sy
X-Received: by 2002:a17:90b:33c4:b0:359:806c:7a94 with SMTP id 98e67ed59e1d1-359be233997mr2425732a91.7.1772812173122;
        Fri, 06 Mar 2026 07:49:33 -0800 (PST)
Received: from d.home.yangfl.dn42 ([2603:c020:800b:d7ff::38])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-359bbaa5fa1sm1532769a91.0.2026.03.06.07.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2026 07:49:32 -0800 (PST)
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
Subject: [PATCH net-next v4 2/2] net: dsa: yt921x: Use u64_stats_t for MIB stats
Date: Fri,  6 Mar 2026 23:46:27 +0800
Message-ID: <20260306154637.3126497-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260306154637.3126497-1-mmyangfl@gmail.com>
References: <20260306154637.3126497-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: F24C02243D9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-264867-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mmyangfl@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-0.980];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

64-bit variables might not be atomic on 32-bit architectures, and could
lead to load/store tearing. Use u64_stats_t to ensure consistency.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 197 +++++++++++++++++++++++----------------
 drivers/net/dsa/yt921x.h | 114 ++++++++++++----------
 2 files changed, 178 insertions(+), 133 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index a968a3fb56f8..b9ae49e01c2e 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -20,6 +20,7 @@
 #include <linux/of_mdio.h>
 #include <linux/of_net.h>
 #include <linux/sort.h>
+#include <linux/u64_stats_sync.h>
 
 #include <net/dsa.h>
 #include <net/dscp.h>
@@ -670,22 +671,20 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
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
 
@@ -694,7 +693,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = u64_stats_read(&mib->stats[i]);
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -708,7 +707,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		WRITE_ONCE(*valp, val);
+		u64_stats_set(&mib_new->stats[i], val);
 	}
 
 	if (res) {
@@ -717,14 +716,29 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
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
@@ -772,8 +786,8 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	size_t j;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_read_mib(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	j = 0;
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
@@ -782,9 +796,11 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		if (!desc->name)
 			continue;
 
-		data[j] = ((u64 *)mib)[i];
+		data[j] = u64_stats_read(&mib->stats[i]);
 		j++;
 	}
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -813,31 +829,33 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	struct yt921x_mib *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_read_mib(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
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
+	mac_stats->FramesTransmittedOK = u64_stats_read(&pp->tx_frames);
+	mac_stats->SingleCollisionFrames = u64_stats_read(&mib->tx_single_collisions);
+	mac_stats->MultipleCollisionFrames = u64_stats_read(&mib->tx_multiple_collisions);
+	mac_stats->FramesReceivedOK = u64_stats_read(&pp->rx_frames);
+	mac_stats->FrameCheckSequenceErrors = u64_stats_read(&mib->rx_crc_errors);
+	mac_stats->AlignmentErrors = u64_stats_read(&mib->rx_alignment_errors);
+	mac_stats->OctetsTransmittedOK = u64_stats_read(&mib->tx_good_bytes);
+	mac_stats->FramesWithDeferredXmissions = u64_stats_read(&mib->tx_deferred);
+	mac_stats->LateCollisions = u64_stats_read(&mib->tx_late_collisions);
+	mac_stats->FramesAbortedDueToXSColls = u64_stats_read(&mib->tx_aborted_errors);
 	/* mac_stats->FramesLostDueToIntMACXmitError */
 	/* mac_stats->CarrierSenseErrors */
-	mac_stats->OctetsReceivedOK = mib->rx_good_bytes;
+	mac_stats->OctetsReceivedOK = u64_stats_read(&mib->rx_good_bytes);
 	/* mac_stats->FramesLostDueToIntMACRcvError */
-	mac_stats->MulticastFramesXmittedOK = mib->tx_multicast;
-	mac_stats->BroadcastFramesXmittedOK = mib->tx_broadcast;
+	mac_stats->MulticastFramesXmittedOK = u64_stats_read(&mib->tx_multicast);
+	mac_stats->BroadcastFramesXmittedOK = u64_stats_read(&mib->tx_broadcast);
 	/* mac_stats->FramesWithExcessiveDeferral */
-	mac_stats->MulticastFramesReceivedOK = mib->rx_multicast;
-	mac_stats->BroadcastFramesReceivedOK = mib->rx_broadcast;
+	mac_stats->MulticastFramesReceivedOK = u64_stats_read(&mib->rx_multicast);
+	mac_stats->BroadcastFramesReceivedOK = u64_stats_read(&mib->rx_broadcast);
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
-	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+	mac_stats->FrameTooLongErrors = u64_stats_read(&mib->rx_oversize_errors);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 static void
@@ -849,12 +867,14 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	struct yt921x_mib *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_read_mib(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
-	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
-	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
+	ctrl_stats->MACControlFramesTransmitted = u64_stats_read(&mib->tx_pause);
+	ctrl_stats->MACControlFramesReceived = u64_stats_read(&mib->rx_pause);
 	/* ctrl_stats->UnsupportedOpcodesReceived */
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
@@ -878,31 +898,33 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	struct yt921x_mib *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_read_mib(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
 	*ranges = yt921x_rmon_ranges;
 
-	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
-	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
-	rmon_stats->fragments = mib->rx_alignment_errors;
+	rmon_stats->undersize_pkts = u64_stats_read(&mib->rx_undersize_errors);
+	rmon_stats->oversize_pkts = u64_stats_read(&mib->rx_oversize_errors);
+	rmon_stats->fragments = u64_stats_read(&mib->rx_alignment_errors);
 	/* rmon_stats->jabbers */
 
-	rmon_stats->hist[0] = mib->rx_64byte;
-	rmon_stats->hist[1] = mib->rx_65_127byte;
-	rmon_stats->hist[2] = mib->rx_128_255byte;
-	rmon_stats->hist[3] = mib->rx_256_511byte;
-	rmon_stats->hist[4] = mib->rx_512_1023byte;
-	rmon_stats->hist[5] = mib->rx_1024_1518byte;
-	rmon_stats->hist[6] = mib->rx_jumbo;
+	rmon_stats->hist[0] = u64_stats_read(&mib->rx_64byte);
+	rmon_stats->hist[1] = u64_stats_read(&mib->rx_65_127byte);
+	rmon_stats->hist[2] = u64_stats_read(&mib->rx_128_255byte);
+	rmon_stats->hist[3] = u64_stats_read(&mib->rx_256_511byte);
+	rmon_stats->hist[4] = u64_stats_read(&mib->rx_512_1023byte);
+	rmon_stats->hist[5] = u64_stats_read(&mib->rx_1024_1518byte);
+	rmon_stats->hist[6] = u64_stats_read(&mib->rx_jumbo);
+
+	rmon_stats->hist_tx[0] = u64_stats_read(&mib->tx_64byte);
+	rmon_stats->hist_tx[1] = u64_stats_read(&mib->tx_65_127byte);
+	rmon_stats->hist_tx[2] = u64_stats_read(&mib->tx_128_255byte);
+	rmon_stats->hist_tx[3] = u64_stats_read(&mib->tx_256_511byte);
+	rmon_stats->hist_tx[4] = u64_stats_read(&mib->tx_512_1023byte);
+	rmon_stats->hist_tx[5] = u64_stats_read(&mib->tx_1024_1518byte);
+	rmon_stats->hist_tx[6] = u64_stats_read(&mib->tx_jumbo);
 
-	rmon_stats->hist_tx[0] = mib->tx_64byte;
-	rmon_stats->hist_tx[1] = mib->tx_65_127byte;
-	rmon_stats->hist_tx[2] = mib->tx_128_255byte;
-	rmon_stats->hist_tx[3] = mib->tx_256_511byte;
-	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
-	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
-	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+	mutex_unlock(&priv->reg_lock);
 }
 
 static void
@@ -912,33 +934,41 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
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
@@ -950,11 +980,13 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	struct yt921x_mib *mib = &pp->mib;
 
 	mutex_lock(&priv->reg_lock);
+
 	yt921x_read_mib(priv, port);
-	mutex_unlock(&priv->reg_lock);
 
-	pause_stats->tx_pause_frames = mib->tx_pause;
-	pause_stats->rx_pause_frames = mib->rx_pause;
+	pause_stats->tx_pause_frames = u64_stats_read(&mib->tx_pause);
+	pause_stats->rx_pause_frames = u64_stats_read(&mib->rx_pause);
+
+	mutex_unlock(&priv->reg_lock);
 }
 
 static int
@@ -3423,6 +3455,7 @@ static int yt921x_mdio_probe(struct mdio_device *mdiodev)
 
 		pp->index = i;
 		INIT_DELAYED_WORK(&pp->mib_read, yt921x_poll_mib);
+		u64_stats_init(&pp->syncp);
 	}
 
 	ds = &priv->ds;
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3f129b8d403f..93d0f55d1745 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -6,6 +6,8 @@
 #ifndef __YT921X_H
 #define __YT921X_H
 
+#include <linux/u64_stats_sync.h>
+
 #include <net/dsa.h>
 
 #define YT921X_SMI_SWITCHID_M		GENMASK(3, 2)
@@ -530,55 +532,61 @@ enum yt921x_fdb_entry_status {
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
+		u64_stats_t stats[];
+	};
 };
 
 struct yt921x_port {
@@ -588,9 +596,13 @@ struct yt921x_port {
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


