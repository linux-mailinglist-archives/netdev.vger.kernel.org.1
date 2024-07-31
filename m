Return-Path: <netdev+bounces-114510-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A807942C46
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 12:44:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EB9241F264F2
	for <lists+netdev@lfdr.de>; Wed, 31 Jul 2024 10:44:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83AE01AC451;
	Wed, 31 Jul 2024 10:44:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HDBG9O8N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CB11AC43C;
	Wed, 31 Jul 2024 10:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722422661; cv=none; b=m4IXbuG2h/SHdEsYhoLThsgAwGjShthkDxg4WkafinF7eQdYy2pVfH9mj2RBBQ2/aAeDhPknHCkwo+y+G0HOpxy3KeQuUrifMSmZYmxz+ZLuDFKdB72ar+jS6594nnOPJ2zmjS747hQargtxX8CVaWhaXQgTD2k4rpWiHmrB0AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722422661; c=relaxed/simple;
	bh=p11lj5iJV2QtSeN2s6BsoXJxSTFxLs1xnjmR/evjQ4g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qisNQ1SrHUA+bAP+8endEnPNMOXWGHV87LrX/GZ3RxHbaDx+LSZmBcnB/bbgY7X3ZD6rrJ5Kkvp2BtYy1Jh/nbJVJpZaxru9BDkvV+C0Gv7kesxv7877HNZt705vJa8QzmkxeM6FF08l77/vo1sUVC0dHM3k694SkXY/BqNk7OI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HDBG9O8N; arc=none smtp.client-ip=209.85.210.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-7093f6adc4aso2034026a34.3;
        Wed, 31 Jul 2024 03:44:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722422659; x=1723027459; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RikSfSLSzK3NY5MUlBg8b34sVeLezToR4ZzwAPjg5Sw=;
        b=HDBG9O8NF6TCCutWe6mUOZ8cawmHtLuoTdyZr2cVxZrTVw4gz6HKcDbQVjc5DaDmIg
         qlligkriXrSvtBwQWGPsV7ZuB/kAos5cFiwrKF2I+QuoVKOE5LpPAc2igr854RdNVdUp
         7RsXoh2JOZIDBjy9neUVkHipt/iSkSx52/+uDZa8tOHlHLWyCAdD3h71GYcVSPoGzDLD
         gUS/KTvERiy4rzz3rOS+LdwQOi1oFj4m/pFS5wFht+9XqPnb4ew4lKsd7cfYH2MBfFS6
         RD+HHqL+yP+c6pQ2wkMpyzafNS0O159/dNIMlg+YY6RWeuD26Ozm57gMbbOusNmdz5Bs
         OfvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722422659; x=1723027459;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RikSfSLSzK3NY5MUlBg8b34sVeLezToR4ZzwAPjg5Sw=;
        b=KjN8Cbv9xIPkoKv9i7meetGFAOn0wCFKXDDdoVAyvYoqFa1ghPGekruAsh8OG7yR+O
         TKFwpWLoQHPQAAh4TdZ/rB/Udv1ypHROzoMiMi8seswVAiiLWk+7tHTbVJbaUCoBvE+T
         qty1duYRTGTcht6HwzC6fqo6CIV21OYVpKgsKvVJXYBnYY8bdOIV5uuObzw0TwRvQmEP
         xOLiS6As4xdIVEE0aNW1zGcor7bt6kTpvyGA/0lx65qyPyw/CDkPtb7lqjwcmAIMQTMd
         3BNX15O+TOw+NcBK4f5Qh0e0/CxKo2RWC3MYs30VG5wtjKDDprCeGRgZdBQ8kF1hTwrR
         1sSw==
X-Forwarded-Encrypted: i=1; AJvYcCXPxa3Dl3B1GmnlSL3jn2QWnGhQS2O++1nP+tG2osTSPYWVg2j/0i3gV/gM9VjG9OCQEYchQaGnC6av0f/6MNfjuUmWWt9k/wLJ3Al+
X-Gm-Message-State: AOJu0YwtIZ9IbXPgxMsVEhWp+wSeyPc6TE/1VKjXQ4w7xQTvshuRWmk/
	1FEiazLQe2Oy6+SVhrbdvF+SiFoDp8u9BakHoW4bFOv7pT9cPsT0
X-Google-Smtp-Source: AGHT+IE2jiVapYwFvA5Ymfuzc66v1gbK3DosbYWq6PakXzXkcZhsXP+tkGA7JHLN1NMmna4+AcYEmA==
X-Received: by 2002:a05:6358:d3aa:b0:1af:1b40:5357 with SMTP id e5c5f4694b2df-1af1b405467mr466369255d.24.1722422658533;
        Wed, 31 Jul 2024 03:44:18 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 41be03b00d2f7-7a9f816da59sm8791375a12.29.2024.07.31.03.44.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 03:44:17 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Joao Pinto <jpinto@synopsys.com>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	xfr@outlook.com,
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v1 3/5] net: stmmac: support fp parameter of tc-taprio
Date: Wed, 31 Jul 2024 18:43:14 +0800
Message-Id: <4603a4f68616ce41aca97bac2f55e5d51c865f53.1722421644.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1722421644.git.0x1207@gmail.com>
References: <cover.1722421644.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc-taprio can select whether traffic classes are express or preemptible.

After some traffic tests, MAC merge layer statistics are all good.

Local device:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": true,
        "tx-active": true,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": true,
        "verify-time": 100,
        "max-verify-time": 128,
        "verify-status": "SUCCEEDED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 0,
            "MACMergeFragCountRx": 0,
            "MACMergeFragCountTx": 1398,
            "MACMergeHoldCount": 15783
        }
    } ]

Remote device:
ethtool --include-statistics --json --show-mm eth1
[ {
        "ifname": "eth1",
        "pmac-enabled": true,
        "tx-enabled": true,
        "tx-active": true,
        "tx-min-frag-size": 60,
        "rx-min-frag-size": 60,
        "verify-enabled": true,
        "verify-time": 100,
        "max-verify-time": 128,
        "verify-status": "SUCCEEDED",
        "statistics": {
            "MACMergeFrameAssErrorCount": 0,
            "MACMergeFrameSmdErrorCount": 0,
            "MACMergeFrameAssOkCount": 1388,
            "MACMergeFragCountRx": 1398,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

Tested on DWMAC CORE 5.10a

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 34 ++-----------------
 1 file changed, 3 insertions(+), 31 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 494fe2f68300..eeb5eb453b98 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -943,7 +943,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
-	bool fpe = false;
 	int i, ret = 0;
 	u64 ctr;
 
@@ -1028,16 +1027,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
-			if (fpe)
-				return -EINVAL;
-			break;
-		case TC_TAPRIO_CMD_SET_AND_HOLD:
-			gates |= BIT(0);
-			fpe = true;
-			break;
-		case TC_TAPRIO_CMD_SET_AND_RELEASE:
-			gates &= ~BIT(0);
-			fpe = true;
 			break;
 		default:
 			return -EOPNOTSUPP;
@@ -1068,16 +1057,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	if (fpe && !priv->dma_cap.fpesel) {
+	if (qopt->mqprio.preemptible_tcs && !priv->dma_cap.fpesel) {
 		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
 
-	/* Actual FPE register configuration will be done after FPE handshake
-	 * is success.
-	 */
-	priv->plat->fpe_cfg->enable = fpe;
-
 	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
@@ -1088,10 +1072,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	netdev_info(priv->dev, "configured EST\n");
 
-	if (fpe) {
-		stmmac_fpe_handshake(priv, true);
-		netdev_info(priv->dev, "start FPE handshake\n");
-	}
+	stmmac_fpe_set_preemptible_tcs(priv, priv->ioaddr, qopt->mqprio.preemptible_tcs);
 
 	return 0;
 
@@ -1109,16 +1090,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	priv->plat->fpe_cfg->enable = false;
-	stmmac_fpe_configure(priv, priv->ioaddr,
-			     priv->plat->fpe_cfg,
-			     priv->plat->tx_queues_to_use,
-			     priv->plat->rx_queues_to_use,
-			     false);
-	netdev_info(priv->dev, "disabled FPE\n");
-
-	stmmac_fpe_handshake(priv, false);
-	netdev_info(priv->dev, "stop FPE handshake\n");
+	stmmac_fpe_set_preemptible_tcs(priv, priv->ioaddr, 0);
 
 	return ret;
 }
-- 
2.34.1


