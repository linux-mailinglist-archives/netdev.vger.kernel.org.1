Return-Path: <netdev+bounces-232906-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B9986C09DB0
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 19:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5AE371A60A96
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 17:14:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC95E303C9B;
	Sat, 25 Oct 2025 17:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bs88pHsP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 203EF27057D
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 17:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761412412; cv=none; b=d2qPRZ6Mpd88Tigjlu1wc4AtuZ6Tnqi5SE8ZjYhIWK9cJy/+UTPg4LpjrKylP45we53WVrgn3fyVs7EfeSIT98wz4L6pPP0i+7g61ppUP9ogHXL50ORSeYBXwI/LSG6z+N9+5/8hnNvJR1axy/21elS6rlJBkux3Kt0Anxok188=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761412412; c=relaxed/simple;
	bh=uOFfSvYybj5U/YMLdHhj4kE0AVO6RfvG+9hqVvgsk+M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YwxeP5m+iEfDk6Z15N1uUyYNBKSdxw0/XdzZQnc4x8mDIyHyQUiu8fCOxCgl2Bg4DkwUHHwilZyqmbdSjL1NvugxI/R/kscojqzjQ2HdoZmMmhceolatUcUOEns/vXhGhiMRcwN0sM9JaUf8Bl72HH7HzTsl4A3+15GNb32Za3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Bs88pHsP; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-7833765433cso4115346b3a.0
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 10:13:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761412410; x=1762017210; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=skkIsPjZzdIgiE62Lq5VQ7m30JaRsLRctIZwjBpQojY=;
        b=Bs88pHsPdWJ6e67+xU6Ifv4t/Mrl5R0GW/zuT6h09P/FS5nuWLrJmpaKZy2nq6vzKb
         NjEPGNG60xiq9KDxaKq7DnYZ+FLnqlNNsFocKw+U2956/TLeS3lwzs6nU9qGvd5zZnP4
         hw3IhNXo5i+Y+wN+Q0kktfSOzDgYy09ZOUzCflYrOiGQ9weWLMUzWm1hpUctl5NhC6kb
         mk+FVZdqKmoNNCObPeux7ZI1UplaVawCRbHOWlJ2rdd3FOuvVY7/QlVbS3sEEAygbCyp
         eSGwonu/zdRsHUKvxq3UFV8SwWTsZ5q2klSif4VCX8Iw+7UKomQfQyXBE0MgXe6XFRWv
         Mlmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761412410; x=1762017210;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=skkIsPjZzdIgiE62Lq5VQ7m30JaRsLRctIZwjBpQojY=;
        b=NTy2lx22rJNzwXoeaAYrxiGowRQXloNtehjYfUJn4wO7gRNAGTAu2qvW3OqYNfY211
         iu0JJd9TqgmJ7swZf05bUMsPJ7BnZGF1fjsVUBRmIZarjWUQONpd+7brMKwYgYEqWL5K
         9D3BaUc9MfBIQvw5S15eQ6XACqcYyexCGEVA8dximgUHKLbUxPOZshkWr0etf9/Uye+z
         HAbW7T7bExzIADk8bWkeVWbFeQvWuTg7D1isuOWEZZilGAl2WPCdLL9gyteq8DMWl0JD
         QM+aI9dIdrEwFKBKwULu9e9MKsMzqQrbk/i9Xc2VAAYunj/69EMEcdc8NNp5C83VqgPA
         /nVA==
X-Gm-Message-State: AOJu0YzzQhX82u7vzTFJyiySM2o9mQA6d6P9aj2IM8fp3+LVIUBSjIxx
	IZcBPGfyn9do6nJ1kayT2DrNpkIzcOGWwY4095/xvPuMtELVqSaZgJF8OAhnT6Er
X-Gm-Gg: ASbGnctz/bqLNVBstW2squm6E/qF6CiU8VQsVEQ02uzUDwgaV1/ci1z/T47+CKLoG+F
	RCXjh9f0OlGV57v6PQ8VKqCZKCrk0wsIcbCxcxdPkqFWsou0kuBJj2Hh2wW69I5yuWZfjFetk60
	4P0ZooRwzkiNxP2SGxu8lZe0n4j/lBszoYgH/tuAWZZTp7gjGIWTu6QUxf7MIGJiuwgDxey9MYF
	qZ02GMshoT4iXIlkPj+2nZkaXaIdIPRgmjyKk8Vzyy6UEpf7vDlzkSpMZ0Vpq1/EoYWM7Bv2aQx
	pUmugNOnr051JAHQj37yFOACIqhgCvj1HMohG7yYucucvPTQAoMuZOsOYbf70cRBp6qzOjgabBx
	EILhb+R2mqGm3nZpa9PH2AkY07Rt+gIMFoy316CzW2wDalcDlapcTY/fMFmRIuJIMXpJKdYLmG7
	gsf0hA/kqLQr5zlvAilg==
X-Google-Smtp-Source: AGHT+IFrE/I5QcKhRbXEdfK7JwyY2O+27cboGMuNOwu2tayp52hBp3cLe68UEO4DrutT6WE5Naid3g==
X-Received: by 2002:a05:6a00:94d5:b0:780:7eaa:938 with SMTP id d2e1a72fcca58-7a220a7f285mr41815292b3a.12.1761412409917;
        Sat, 25 Oct 2025 10:13:29 -0700 (PDT)
Received: from d.home.yangfl.dn42 ([45.32.227.231])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7a414012bcesm2850481b3a.8.2025.10.25.10.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Oct 2025 10:13:29 -0700 (PDT)
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
Subject: [PATCH net-next v2 2/2] net: dsa: yt921x: Protect MIB stats with a lock
Date: Sun, 26 Oct 2025 01:13:11 +0800
Message-ID: <20251025171314.1939608-3-mmyangfl@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251025171314.1939608-1-mmyangfl@gmail.com>
References: <20251025171314.1939608-1-mmyangfl@gmail.com>
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
 drivers/net/dsa/yt921x.h |  4 +++
 2 files changed, 45 insertions(+), 22 deletions(-)

diff --git a/drivers/net/dsa/yt921x.c b/drivers/net/dsa/yt921x.c
index 97a7eeb4ea15..e5d7c6820089 100644
--- a/drivers/net/dsa/yt921x.c
+++ b/drivers/net/dsa/yt921x.c
@@ -671,22 +671,16 @@ yt921x_mbus_ext_init(struct yt921x_priv *priv, struct device_node *mnp)
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
 		u64 val;
 		u32 val0;
 
@@ -695,7 +689,7 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			break;
 
 		if (desc->size <= 1) {
-			u64 old_val = *valp;
+			u64 old_val = ((u64 *)mib)[i];
 
 			val = (old_val & ~(u64)U32_MAX) | val0;
 			if (val < old_val)
@@ -709,22 +703,31 @@ static int yt921x_read_mib(struct yt921x_priv *priv, int port)
 			val = ((u64)val0 << 32) | val1;
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
@@ -773,6 +776,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	j = 0;
 	for (size_t i = 0; i < ARRAY_SIZE(yt921x_mib_descs); i++) {
 		const struct yt921x_mib_desc *desc = &yt921x_mib_descs[i];
@@ -783,6 +787,7 @@ yt921x_dsa_get_ethtool_stats(struct dsa_switch *ds, int port, uint64_t *data)
 		data[j] = ((u64 *)mib)[i];
 		j++;
 	}
+	spin_unlock(&pp->stats_lock);
 }
 
 static int yt921x_dsa_get_sset_count(struct dsa_switch *ds, int port, int sset)
@@ -814,6 +819,7 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	mac_stats->FramesTransmittedOK = pp->tx_frames;
 	mac_stats->SingleCollisionFrames = mib->tx_single_collisions;
 	mac_stats->MultipleCollisionFrames = mib->tx_multiple_collisions;
@@ -836,6 +842,7 @@ yt921x_dsa_get_eth_mac_stats(struct dsa_switch *ds, int port,
 	/* mac_stats->InRangeLengthErrors */
 	/* mac_stats->OutOfRangeLengthField */
 	mac_stats->FrameTooLongErrors = mib->rx_oversize_errors;
+	spin_unlock(&pp->stats_lock);
 }
 
 static void
@@ -850,9 +857,11 @@ yt921x_dsa_get_eth_ctrl_stats(struct dsa_switch *ds, int port,
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	ctrl_stats->MACControlFramesTransmitted = mib->tx_pause;
 	ctrl_stats->MACControlFramesReceived = mib->rx_pause;
 	/* ctrl_stats->UnsupportedOpcodesReceived */
+	spin_unlock(&pp->stats_lock);
 }
 
 static const struct ethtool_rmon_hist_range yt921x_rmon_ranges[] = {
@@ -881,6 +890,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 
 	*ranges = yt921x_rmon_ranges;
 
+	spin_lock(&pp->stats_lock);
+
 	rmon_stats->undersize_pkts = mib->rx_undersize_errors;
 	rmon_stats->oversize_pkts = mib->rx_oversize_errors;
 	rmon_stats->fragments = mib->rx_alignment_errors;
@@ -901,6 +912,8 @@ yt921x_dsa_get_rmon_stats(struct dsa_switch *ds, int port,
 	rmon_stats->hist_tx[4] = mib->tx_512_1023byte;
 	rmon_stats->hist_tx[5] = mib->tx_1024_1518byte;
 	rmon_stats->hist_tx[6] = mib->tx_jumbo;
+
+	spin_unlock(&pp->stats_lock);
 }
 
 static void
@@ -911,6 +924,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	struct yt921x_port *pp = &priv->ports[port];
 	struct yt921x_mib *mib = &pp->mib;
 
+	spin_lock(&pp->stats_lock);
+
 	stats->rx_length_errors = mib->rx_undersize_errors +
 				  mib->rx_fragment_errors;
 	stats->rx_over_errors = mib->rx_oversize_errors;
@@ -937,6 +952,8 @@ yt921x_dsa_get_stats64(struct dsa_switch *ds, int port,
 	/* stats->tx_dropped */
 	stats->multicast = mib->rx_multicast;
 	stats->collisions = mib->tx_collisions;
+
+	spin_unlock(&pp->stats_lock);
 }
 
 static void
@@ -951,8 +968,10 @@ yt921x_dsa_get_pause_stats(struct dsa_switch *ds, int port,
 	yt921x_read_mib(priv, port);
 	mutex_unlock(&priv->reg_lock);
 
+	spin_lock(&pp->stats_lock);
 	pause_stats->tx_pause_frames = mib->tx_pause;
 	pause_stats->rx_pause_frames = mib->rx_pause;
+	spin_unlock(&pp->stats_lock);
 }
 
 static int
diff --git a/drivers/net/dsa/yt921x.h b/drivers/net/dsa/yt921x.h
index 3e85d90826fb..be69c3508da8 100644
--- a/drivers/net/dsa/yt921x.h
+++ b/drivers/net/dsa/yt921x.h
@@ -470,9 +470,13 @@ struct yt921x_port {
 	bool isolated;
 
 	struct delayed_work mib_read;
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


