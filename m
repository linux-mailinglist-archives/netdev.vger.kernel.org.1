Return-Path: <netdev+bounces-125403-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2896B96D00E
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 09:04:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D492F283A0C
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:04:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44260194A4F;
	Thu,  5 Sep 2024 07:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TOKW0fcp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90273192B85;
	Thu,  5 Sep 2024 07:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725519815; cv=none; b=hnQkXFJHJIHdWBolXYAw8t8AH/mpjBe5HAgKF8uTVz6p64/3lfQUizYNxPS1xHQmij9xX58zN4rFNzhzEMVJTrB3wpMB5d4TnNdar30G4wjkKxdxmKO8dvJR0XV5n/e5eJNplwQBREXzzlGDvnhGNPQHXFrd5r2feIxLoUNEHsg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725519815; c=relaxed/simple;
	bh=VwxBAGKFthljZz4Y5lROQz2rgLOsx3YXmfAcWP+WpuI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Gln/KmxQOVh5z/ulLgSAl9JlO4ZNwvw9UohgKIqyuthN1/wOIqUMm9fI+Z+mULVFJYga6CIy+FA4Myy2UKvFppsfe01/JF5V4YkEHZ2gXZIkTBPCJhyBLOlCUomMPs0CiX2DIXDKVZasAR++uOZ1zIlbvBaj2BtlhDLuVkMrBZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TOKW0fcp; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-277c742307fso198143fac.2;
        Thu, 05 Sep 2024 00:03:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725519812; x=1726124612; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=otlVOJXZzrcHMJzriiHIIRnACM+mCrGtCzdOQVIQKiY=;
        b=TOKW0fcpblm1AO9TZD9FJVmLGK/xEZ67O7Izpx1xnjZlbc4UXdLKZFh+ru6yHZwUDa
         +WQiUFRNcogbTJgeDqh8MeZ+wNJevUT5JsHNa/2yev0/N7CvOielWlUtpm4eUnJTmptB
         /cUo5/hdPgsRjqwA6nYJaAjqtmWZTFCH0oQE1786NpJZmEqoxpVGbQ7iACOyBdLODHar
         0b9hxGSo/5L5GzG34+p16CzMUM3RGZoLiSuLQ/BXJ1srv95GA4sAyKraIxR/W8Kf4CzG
         vk5/IoHDucnl+iW4qXPjjRXiOj4hOdx1Pg3qb4kBf6g7/BcW3PW4D4rVnGcTZGTd0hjQ
         9cIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725519812; x=1726124612;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=otlVOJXZzrcHMJzriiHIIRnACM+mCrGtCzdOQVIQKiY=;
        b=kd7GheL0WMEgYViboTUWRTXlW+IwfG7p5+X5wQKime5istXwLfnP1sZ+LEzYQ30JBh
         /rnyseYjGYoE0jk67mJ7XxhWKykLbSzaaBbPD8YPDl8Hmo5HBjploEzUlnbbxU9s5h8c
         DKxPEaYE2Dsy9XcqfvUDmAmHN4a9mjNqfcRZJeCCVShAlI06KNAG+58ml8i0twi99nps
         QJVH0yH1aJz0WUZUnODow5tkKXd1RUN0putnAtL18Xgx5rWTp0jqXMi6zsRwwBiKcfdO
         lgVcQ5b8yt29xb7Cllz+8jh9eYEWKYGAvvBR2RHo4r0yPKc65nYdm21ouSX1H//EXQj+
         WojQ==
X-Forwarded-Encrypted: i=1; AJvYcCUkOGSipfkqMOMSRHpiZXTGCXQ6KisswSSwT8O/pqnW0JAirMGg55Kc/4pSe7ZyOfw3qMqnRHOT8wF1nMk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw4FPJcw2d0Ok768HzEieU06rZZdGlKD9H0e2dqYz3kQhdtU5/+
	y0seatZls1FXBf7SgAPapDanLAqZcm/5AhvPz9gotIC/hBG3MAcH
X-Google-Smtp-Source: AGHT+IHO4Nnb6GEpkOPdgYkTNs+lbZZUJ+YeIrG/dwz3pm5cwFCq5eRB8Be3JRWFblSobOIRGjxzQQ==
X-Received: by 2002:a05:6870:a688:b0:277:f002:8073 with SMTP id 586e51a60fabf-277f0028866mr14198864fac.16.1725519812601;
        Thu, 05 Sep 2024 00:03:32 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71778595107sm2604897b3a.150.2024.09.05.00.03.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 00:03:32 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Serge Semin <fancer.lancer@gmail.com>,
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
	rmk+kernel@armlinux.org.uk,
	linux@armlinux.org.uk,
	xfr@outlook.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v8 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Thu,  5 Sep 2024 15:02:27 +0800
Message-Id: <55067bfa505933731cbd018d19213b89126321e3.1725518136.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725518135.git.0x1207@gmail.com>
References: <cover.1725518135.git.0x1207@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tc-taprio can select whether traffic classes are express or preemptible.

0) tc qdisc add dev eth1 parent root handle 100 taprio \
        num_tc 4 \
        map 0 1 2 3 2 2 2 2 2 2 2 2 2 2 2 3 \
        queues 1@0 1@1 1@2 1@3 \
        base-time 1000000000 \
        sched-entry S 03 10000000 \
        sched-entry S 0e 10000000 \
        flags 0x2 fp P E E E

1) After some traffic tests, MAC merge layer statistics are all good.

Local device:
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
            "MACMergeFragCountTx": 17837,
            "MACMergeHoldCount": 18639
        }
    } ]

Remote device:
[ {
        "ifname": "end1",
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
            "MACMergeFrameAssOkCount": 17189,
            "MACMergeFragCountRx": 17837,
            "MACMergeFragCountTx": 0,
            "MACMergeHoldCount": 0
        }
    } ]

Tested on DWMAC CORE 5.10a

Signed-off-by: Furong Xu <0x1207@gmail.com>
---
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 39 +++++++++++--------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index cfdb9ab1fa2a..05ffff00a524 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -931,9 +931,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
+	struct netlink_ext_ack *extack = qopt->mqprio.extack;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
-	bool fpe = false;
 	int i, ret = 0;
 	u64 ctr;
 
@@ -1018,16 +1018,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 		switch (qopt->entries[i].command) {
 		case TC_TAPRIO_CMD_SET_GATES:
-			if (fpe)
-				return -EINVAL;
 			break;
 		case TC_TAPRIO_CMD_SET_AND_HOLD:
 			gates |= BIT(0);
-			fpe = true;
 			break;
 		case TC_TAPRIO_CMD_SET_AND_RELEASE:
 			gates &= ~BIT(0);
-			fpe = true;
 			break;
 		default:
 			return -EOPNOTSUPP;
@@ -1058,11 +1054,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	if (fpe && !priv->dma_cap.fpesel) {
-		mutex_unlock(&priv->est_lock);
-		return -EOPNOTSUPP;
-	}
-
 	ret = stmmac_est_configure(priv, priv, priv->est,
 				   priv->plat->clk_ptp_rate);
 	mutex_unlock(&priv->est_lock);
@@ -1071,6 +1062,11 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		goto disable;
 	}
 
+	ret = stmmac_fpe_map_preemption_class(priv, priv->dev, extack,
+					      qopt->mqprio.preemptible_tcs);
+	if (ret)
+		goto disable;
+
 	netdev_info(priv->dev, "configured EST\n");
 
 	return 0;
@@ -1089,11 +1085,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	stmmac_fpe_configure(priv, priv->ioaddr,
-			     &priv->fpe_cfg,
-			     priv->plat->tx_queues_to_use,
-			     priv->plat->rx_queues_to_use,
-			     false, false);
+	stmmac_fpe_map_preemption_class(priv, priv->dev, extack, 0);
+
 	netdev_info(priv->dev, "disabled FPE\n");
 
 	return ret;
@@ -1150,6 +1143,18 @@ static int tc_setup_taprio(struct stmmac_priv *priv,
 	return err;
 }
 
+static int tc_setup_taprio_without_fpe(struct stmmac_priv *priv,
+				       struct tc_taprio_qopt_offload *qopt)
+{
+	if (!qopt->mqprio.preemptible_tcs)
+		return tc_setup_taprio(priv, qopt);
+
+	NL_SET_ERR_MSG_MOD(qopt->mqprio.extack,
+			   "taprio with FPE is not implemented for this MAC");
+
+	return -EOPNOTSUPP;
+}
+
 static int tc_setup_etf(struct stmmac_priv *priv,
 			struct tc_etf_qopt_offload *qopt)
 {
@@ -1266,7 +1271,7 @@ const struct stmmac_tc_ops dwmac4_tc_ops = {
 	.setup_cls_u32 = tc_setup_cls_u32,
 	.setup_cbs = tc_setup_cbs,
 	.setup_cls = tc_setup_cls,
-	.setup_taprio = tc_setup_taprio,
+	.setup_taprio = tc_setup_taprio_without_fpe,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_mqprio_unimplemented,
@@ -1288,7 +1293,7 @@ const struct stmmac_tc_ops dwxgmac_tc_ops = {
 	.setup_cls_u32 = tc_setup_cls_u32,
 	.setup_cbs = tc_setup_cbs,
 	.setup_cls = tc_setup_cls,
-	.setup_taprio = tc_setup_taprio,
+	.setup_taprio = tc_setup_taprio_without_fpe,
 	.setup_etf = tc_setup_etf,
 	.query_caps = tc_query_caps,
 	.setup_mqprio = tc_setup_mqprio_unimplemented,
-- 
2.34.1


