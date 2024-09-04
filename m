Return-Path: <netdev+bounces-124939-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EFF496B679
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 11:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53C1A1C21D2B
	for <lists+netdev@lfdr.de>; Wed,  4 Sep 2024 09:24:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887E31CF7A1;
	Wed,  4 Sep 2024 09:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ws6siSYj"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1E31CF5F8;
	Wed,  4 Sep 2024 09:22:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725441766; cv=none; b=C7s76OeHhDOFVi+CjuNrjdndQWmDBlf92RM2t9sQGpSELsrKlTRMR/HoG4djfpQ6tGYsBvm6F+A6E3mjpYkOQpm1HHs/wiVtPkWWDbfrZclM/tjLCCmjDaAfDMx6GEy5UBXj3CF3PZrFx+bP3hqaJChaLeD2xWxUAzsbTKDhYQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725441766; c=relaxed/simple;
	bh=94TyASZYJGAnbwHft+3rGcHSXuwmMXEV5c1xXybSAjk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=djGMPFFXUmIDFPO/0tFBJNN/Jsvpwxx1sz+F7KSHx914XR232M0j0OWqrJfIR8uD0IDMc8lm3FlnyiRMxn1NOdG4dL7L/OGYHJrhYAjpUnRMGnbuvr4ynOqKbs2h1OCfd9Wc11I7QzrIzcgzkq/kbkavSeBoUQI6CdGVZc4V13s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ws6siSYj; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-277c28fac92so3623773fac.3;
        Wed, 04 Sep 2024 02:22:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725441764; x=1726046564; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f93INA09DMIOXaqhvfxTfomEqawOII5zBMQHUuwv7xk=;
        b=Ws6siSYjLsVjRMX2cLizkEhXjNKrLY+9kc+lUKZ7LhumPyGWDt+d9s+7vtBtB2eoPC
         ncWtt2Wn8Fe+wvtCTg2/4ugey2LMF54RZJ/PacVTDs3pgvxBGGMMrgE2eZztZT4nBPEF
         duNmtL8Vgv85DhxJlE8FJys6+/Mg6Q3epPpijutlAkdgyVowV1pQgrkgZPyWfD/8Y/hN
         BjnJWmJw8BF/bdSPguPdG2xzYQX6qDYmUw+NM/1kCALkxtU4nBnVHpq38iBQc3XCKVVc
         iqwsv4eAVHTlEVIpsQQ9A7aT8VO8jwuDCozwyNY/rNIDVMMapXmzf/xpG15f60ePYDOK
         ukXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725441764; x=1726046564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=f93INA09DMIOXaqhvfxTfomEqawOII5zBMQHUuwv7xk=;
        b=NNae7wUlQJGIBqiflNKqTS+LGGfnUyp+L4bHtW2BupjPwK+qY1BbtF9Nc3mE4YTq+Y
         1CeSdS9c0QuyaIMwhKCyw58giaplTep4rfzxdFTTBctYLJ6khMqE1QAHt6OMGMnVXXIG
         douvW7gbLl1A+b1QvlIWBzeEFKbIDDEy40TbqzNUFHSK4nLvKsXkbbo+GfBmU1m+8iX6
         E77hUMSvIouSyTUgivs4e+urOMdz91c1638MYr+WP/8+TqjnUevzhBbJvwl63wJmzEXq
         8Wd/mH6b3ntSmuMZekXWFmSyQZRkIugnvVROsGFGJj/ki9J2vD/vzhXFmfO6xxiqXQCS
         cRGA==
X-Forwarded-Encrypted: i=1; AJvYcCVr8RMcZkc59NAjIKQp+aOr48VCacWwN8GTVwMqEOzv24GwBhA8pL4p1DJWB0PiH4lY6B/PQ8VbHanGyvU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+g78tr+q6plkD3Z9IzcTo6DOUiWopjZQP1MtRwuFEQ7PjFvNS
	16lJuaGVAYEsG13NbBeLHwSmoaUvlg147AYlDm4FpRD0Jmo4sxno
X-Google-Smtp-Source: AGHT+IHfYqlv3eIcYyWGBnu/IU/NNPsjKTuOUdU83UVXH4tEzccuzhL00qdC/ENlfqKhPKlAdB5TgQ==
X-Received: by 2002:a05:6870:b508:b0:277:d563:9b41 with SMTP id 586e51a60fabf-27810b27c69mr6792025fac.9.1725441764098;
        Wed, 04 Sep 2024 02:22:44 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-7177859968csm1232048b3a.146.2024.09.04.02.22.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Sep 2024 02:22:43 -0700 (PDT)
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
Subject: [PATCH net-next v7 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Wed,  4 Sep 2024 17:21:21 +0800
Message-Id: <3bf0857f46b15980e60f3ec71acd0f80452863e4.1725441317.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725441317.git.0x1207@gmail.com>
References: <cover.1725441317.git.0x1207@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 23 +++++++------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 9ec2e6ab81aa..2bdb22e175bc 100644
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
-- 
2.34.1


