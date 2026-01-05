Return-Path: <netdev+bounces-246832-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 25241CF19B8
	for <lists+netdev@lfdr.de>; Mon, 05 Jan 2026 03:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 785FF3000DEE
	for <lists+netdev@lfdr.de>; Mon,  5 Jan 2026 02:10:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B780D31195F;
	Mon,  5 Jan 2026 02:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fGHiE4Ng"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE91430DEC0
	for <netdev@vger.kernel.org>; Mon,  5 Jan 2026 02:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767579011; cv=none; b=pK1BN10fsZ59fD+vyLrDf7eJ25k3UbDVYef0xhM2fG0aJkCxAb+YCU3qTR9luzF5DS2gowRGVOxrNTcYNcNMJ2JmwONMSDVt+z4g8E5GcswCp5rpySRyrK6p7v0p049AUbtaTwu72+j+IGNaDxsr0Yuf0KuD7fnJdGMDWfPWyLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767579011; c=relaxed/simple;
	bh=NAGZrhvuaAq9xQJmOkhL+QIcYkGlNtQ7/wDoWYeHTXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EOTvW9pBIHn4uVjZxyMb61FFofuJ6RrqkgQzinqrOCSViotRhPqJvzGxQtSDnt288UZKge6dyxzMElbsoyGQSqVGXb/azbOXIwlaJVJvKzmIUUk5kYIVHpqj3WJe9NpJQgJNVdSq+Qwu1YF/X4RgiXCd1BwRXSwAH8qS6OSaf3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fGHiE4Ng; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-34c24f4dfb7so10709375a91.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 18:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767579009; x=1768183809; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mz+CZAF5dzBQAy9zX9ZKNHPdrpYwNX+2FouNd+rPU/o=;
        b=fGHiE4NgCTHn0L640pSbUSGo2hWac792k4MpPvzkf7F6rimPhsQxE+IXBOtM3Lhgep
         pPijMi8bdtddLFYNVLly50Nf2XM38Jb5LIixafn97ufeiZ7oncwDKvLUyDrU0idqqDKo
         FznAuA9bZd3ekhSSVuHhEBxmJt0lpOJsmK9tfSXmFUNPu8lZo+RKMIZ0PwAtvKVW+n7v
         sj7DHvs7uhgcS+WdRcT3MK4ten09Hj9mZ1RwFmG5SRw9ZzcJkGiKpwyyALy82OKFVMTx
         8ZDAOvY6Sw3AK0ROa2kOLneYE8NpPle2xyjjOhQ/qsEGDOB5FqEsjLYYTtSMfMVPtSDs
         Y+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767579009; x=1768183809;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mz+CZAF5dzBQAy9zX9ZKNHPdrpYwNX+2FouNd+rPU/o=;
        b=f2aky2QiuUd2V6I0OWW/Atfx+M0BwMNpnC7euMNxx07gkEEAgVO20qqCMTD61Ac6S6
         T8IJ2LJXPnYPHlEj31GmmpYlyZkBY+YVHC2BB8T/LOBH8Re1GoIMwgH1GuIOJ1xkkZcL
         tjvAXY/iQZaQLSIsWMc3cm10XwSzN+3iHQZ4e5fzDpMqebRJUocW8+iRolwqBkshQeRZ
         ih8aVFJvsCRtUyIKc21B+znCVHbKSQ+BRucoeQu/weX8Cv33vNkhky49pUhISrE2ioqD
         3fB4tL+SeBQ53NNRh6JIQ9OrfAJpVF4Kzv3NxDJns/EatATbY+f0NGVeuNe0jOZeQW9A
         ugmw==
X-Gm-Message-State: AOJu0YxzYu9IXS26VRAZakwc2sYLm+P343TsY3r49jsjNCW6rfKrG3hf
	nJUW243vDYiaLsBM8ZA4jRRNdidoTBrtwKEANQwx7jwqG2yH7J5QdglZ115XdQ==
X-Gm-Gg: AY/fxX5J8zBYG1Rq7pNuE3Zop93t/VQ+2i6Ks7eCU41ieqIu/mZIjKslWfTfPG+fXGf
	JnLKseARNQaJXvrFdPI0kz4EvGlIg9zKYhgzmEqLWl7ZqazSeFJ6+Dh3FNCNA59rs9e1lheDpWp
	rXkn2eAhetHxul6FrWqC0smmreCQyhMpsE4ehETui7jb4ly1Wgq1rNh3P7TZDSlz9S4LyhjpGlL
	x/YbH/+6d30RuncQN/Pt9OFcs/KAIw1U1nnqaXdzX9B9R8Dw3D/C7YNv+I96C9EHiVGT6USUYVS
	bx+n3kvrrkmITeFsrj1Yj1hUY/vOfJck/m23Ou+Wio9StQ//ulyx+0IegS8+pDJW9f37YuEXQdj
	h6ZufbKgAWOHWt1/s6GnCfVn+SkNxW5b/gMji2LlZzTqGYejdNnLc1xlrICeS53LpgyZ+nShJsM
	Lc9Lk2TwJntrnWi/moFM9V+yt7OC2bOTRhT0aDI7J8k+8+zkDWyTl9QA==
X-Google-Smtp-Source: AGHT+IEtg8F8tWWOM1Grzf2Ly52nOpLQAUmBmMQZIAHRYsqwqUUUKT0FWi+0LEhlI3WJKQCUJm/BbA==
X-Received: by 2002:a17:90b:4a52:b0:34c:35ce:3c5f with SMTP id 98e67ed59e1d1-34e9212f6c8mr42631157a91.5.1767579008863;
        Sun, 04 Jan 2026 18:10:08 -0800 (PST)
Received: from d.home.mmyangfl.tk ([2001:19f0:8001:1644:5400:5ff:fe3e:12b1])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34f476fb838sm4427102a91.7.2026.01.04.18.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 18:10:08 -0800 (PST)
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
Subject: [PATCH net-next v3 2/2] net: dsa: yt921x: Protect MIB stats with a lock
Date: Mon,  5 Jan 2026 10:09:01 +0800
Message-ID: <20260105020905.3522484-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260105020905.3522484-1-mmyangfl@gmail.com>
References: <20260105020905.3522484-1-mmyangfl@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

64bit variables might not be atomic on 32bit architectures, thus cannot
be made lock-free. Protect them with a spin lock since get_stats64()
cannot sleep.

Signed-off-by: David Yang <mmyangfl@gmail.com>
---
 drivers/net/dsa/yt921x.c | 63 ++++++++++++++++++++++++++--------------
 drivers/net/dsa/yt921x.h |  5 ++++
 2 files changed, 46 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 5e4e8093ba16..98ee517e0675 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -666,22 +666,16 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
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
-	 */
-
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
 		u32 reg = YT921X_MIBn_DATA0(port) + desc->offset;
-		u64 *valp = &((u64 *)mib)[i];
 		u32 val0;
 		u64 val;
 
@@ -690,7 +684,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = ((u64 *)mib)[i];
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -704,22 +698,31 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			val = ((u64)val1 << 32) | val0;
 		}
 
-		WRITE_ONCE(*valp, val);
+		((u64 *)mib_new)[i] = val;
 	}
 
-	pp->rx_frames = mib->rx_64byte + mib->rx_65_127byte +
-			mib->rx_128_255byte + mib->rx_256_511byte +
-			mib->rx_512_1023byte + mib->rx_1024_1518byte +
-			mib->rx_jumbo;
-	pp->tx_frames = mib->tx_64byte + mib->tx_65_127byte +
-			mib->tx_128_255byte + mib->tx_256_511byte +
-			mib->tx_512_1023byte + mib->tx_1024_1518byte +
-			mib->tx_jumbo;
-
-	if (res)
+	if (res) {
 		dev_err(dev, "Failed to %s port %d: %i\n", "read stats for",
 			port, res);
-	return res;
+		return res;
+	}
+
+	rx_frames = mib->rx_64byte + mib->rx_65_127byte +
+		    mib->rx_128_255byte + mib->rx_256_511byte +
+		    mib->rx_512_1023byte + mib->rx_1024_1518byte +
+		    mib->rx_jumbo;
+	tx_frames = mib->tx_64byte + mib->tx_65_127byte +
+		    mib->tx_128_255byte + mib->tx_256_511byte +
+		    mib->tx_512_1023byte + mib->tx_1024_1518byte +
+		    mib->tx_jumbo;
+
+	spin_lock(&pp->stats_lock);
+	*mib = *mib_new;
+	pp->rx_frames = rx_frames;
+	pp->tx_frames = tx_frames;
+	spin_unlock(&pp->stats_lock);
+
+	return 0;
 }
 
 static void yt921x_poll_mib(struct work_struct *work)
@@ -768,6 +771,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	j = 0;
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
@@ -778,6 +782,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		data[j] = ((u64 *)mib)[i];
 		j++;
 	}
+	spin_unlock(&pp->stats_lock);
 }
 
 static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -809,6 +814,7 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	mac_stats->FramesTransmittedOK = pp->tx_frames;
 	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
 	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
@@ -831,6 +837,7 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
 	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+	spin_unlock(&pp->stats_lock);
 }
 
 static void
@@ -845,9 +852,11 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
 	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
 	/* ctrl_stats->UnsupportedOpcodesReceived */
+	spin_unlock(&pp->stats_lock);
 }
 
 static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
@@ -876,6 +885,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
 	*ranges = yt921x_rmon_ranges;
 
+	spin_lock(&pp->stats_lock);
+
 	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
 	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
 	rmon_stats->fragments = mib->rx_alignment_errors;
@@ -896,6 +907,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
 	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
 	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+
+	spin_unlock(&pp->stats_lock);
 }
 
 static void
@@ -906,6 +919,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	spin_lock(&pp->stats_lock);
+
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
 	stats->rx_over_errors = mib->rx_oversize_errors;
@@ -932,6 +947,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	/* stats->tx_dropped */
 	stats->multicast = mib->rx_multicast;
 	stats->collisions = mib->tx_collisions;
+
+	spin_unlock(&pp->stats_lock);
 }
 
 static void
@@ -946,8 +963,10 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	pause_stats->tx_pause_frames = mib->tx_pause;
 	pause_stats->rx_pause_frames = mib->rx_pause;
+	spin_unlock(&pp->stats_lock);
 }
 
 static int
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 61bb0ab3b09a..0c9d1b6cbc23 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -533,9 +533,14 @@ struct yt921x_port {
 	bool isolated;
 
 	struct delayed_work mib_read;
+	/* protect the access to mib, rx_frames and tx_frames */
+	spinlock_t stats_lock;
 	struct yt921x_mib mib;
 	u64 rx_frames;
 	u64 tx_frames;
+
+	/* only used by read routine to avoid huge allocations on the stack */
+	struct yt921x_mib mib_new;
 };
 
 struct yt921x_reg_ops {
-- 
2.51.0


