Return-Path: <netdev+bounces-125964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D928796F6C9
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 16:32:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A16BB218A5
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 14:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DA621D3187;
	Fri,  6 Sep 2024 14:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Zc0y2/LU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAE0B1D1F76;
	Fri,  6 Sep 2024 14:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725633079; cv=none; b=Ggp88dsE4QBFFWF8X3Q4iCPUIuxcuLCiJHBb82G1ZJ4X/h3Gt1UTi7QxwCOnitFXBJsNRjkMReEVyyvyV02SiIpS/fAIKGQ75AWFX9Fu+aHG5cw/ROONADg4b3U5+3ZqtrYvujGbJW3BTIUYAOeKnRznS1UR+1/+Z/fz+UMpjqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725633079; c=relaxed/simple;
	bh=WXVoPHI2DTi73HvWZ/c6p21mBNKm4WrBpvKfioQ8IiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dwtYWxWLqTU6/Tvk+nXK12zah7tl2YUOmjBrFiKRRYxEd0bvL3kccpaBPmvpZR0Cy/b8PbOnzZ2H9hT3rQGFMPM6y192BbvsXTfD5kBfxPFu0iOONG10Tpj2xiPT4LrQ/E+MmOilclMMw1VeY7dd2CbF4WhOcRCJ91OuP3W/TiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Zc0y2/LU; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-206aee40676so19228635ad.0;
        Fri, 06 Sep 2024 07:31:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725633077; x=1726237877; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUTbWYSzdPbEowJ7j1vGQGnAzD494Zg9qCau1Jp3NnY=;
        b=Zc0y2/LUmXRb5nLb6Amw4Ezks43onZ85+1zwxM4jODpbYqDH0LhZ1SYhrF6a+K+xtz
         ScTXmTxWmtOOB4YWOLRgY1b6ctr8FWObvmwv98Ggj0OD9H1ZZZIVvz++IxxySlXfPgDb
         FapTyD4LkPFXtwkFj6s8nexdgG7qllc0onh8MRDpuV0xRVs6EjpY0/1Chs+FLjSEQc8y
         31fdx0lQPh0DMzXBR3VMLHaZxskVrMeNHJG7rbwtRAcZbmj7olUlJfbXYx6SpX3LMxXZ
         RIhlpFfnF+cOKTjzSS7ss3K/XWbErkNEobaQkD/tR6Mw6RswxtijYfhlx4sWs6eMwlWI
         tJJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725633077; x=1726237877;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUTbWYSzdPbEowJ7j1vGQGnAzD494Zg9qCau1Jp3NnY=;
        b=FO8gaqSpbMmD/LGXk+PZeBY6jnn0KIApRPhOT+MwisEGu/BHi4+xifUHD07+81u2Q4
         wfXXYS7fvlmOuAJ5rZ+UC3FWUeZKLvhs00QHyjS08tnF7uZApNy4dS+OPyHM3wjrPgY8
         gtYEOCDElFmf8BarxEKGxsjubfZMolFYqklrf0AdsycdFdmHptyZkwdMX0iS2NjZoI2D
         qjwJL4Soejw0mBzc8wMMei2EvyNw7gt2Aea+Jz4XS1k1i7esQygn9j8LSMGXs2fYAE+P
         6KTUuS9JdEdKaWhIP0pGQ4VOPcW8KZJlOBFAJdpvXIQoRivVhHZZXZeR7JnmfOd8Qhw+
         n7RQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQt/PyQgzrG5ZPepVXF/osHLs7VSkqIlSTQG+uCE9jIiAMaH3GDpkBcrsnu2pkHdKFhF8omj2KwiqOrh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzkgWoEypaun67+baDsyOpzLX7ak7T36CyviHU8g8MRDLr7mOM
	0siP9/MiUK/lp60ETSX/gGwHHcybRoozJwnEwN3sqYaQoukXrdHPOAkclg==
X-Google-Smtp-Source: AGHT+IHEx2KlKqIogbryWTF06yYq8RmV29cy2nf4PiQ7C9em+RXj04x+NmrAYS58JHWsjDTVLM8yEw==
X-Received: by 2002:a17:903:2310:b0:205:951b:563f with SMTP id d9443c01a7336-20706fffc16mr421975ad.49.1725633077004;
        Fri, 06 Sep 2024 07:31:17 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-206ae94dcf3sm43951975ad.80.2024.09.06.07.31.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Sep 2024 07:31:16 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Vladimir Oltean <olteanv@gmail.com>,
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
Subject: [PATCH net-next v10 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Fri,  6 Sep 2024 22:30:11 +0800
Message-Id: <0d21ae356fb3cab77337527e87d46748a4852055.1725631883.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725631883.git.0x1207@gmail.com>
References: <cover.1725631883.git.0x1207@gmail.com>
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
Reviewed-by: Vladimir Oltean <olteanv@gmail.com>
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


