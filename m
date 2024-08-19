Return-Path: <netdev+bounces-119595-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EA8949564A9
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 09:27:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1779A1C2171D
	for <lists+netdev@lfdr.de>; Mon, 19 Aug 2024 07:27:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E36115AADE;
	Mon, 19 Aug 2024 07:26:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y9t8BtvA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4D315AAD6;
	Mon, 19 Aug 2024 07:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724052397; cv=none; b=pr1lr77Bd52p/bgEfg4WMYH1d01SB18srSZi9IEQ+clQwd6PpYK/nG8slmn9pPIH2DmD4C6Cwpc27TI/1hs+1rx2Yi8SkcgcqhJQTq5ZoRKXSm2s4scyzHHLLhg1HwTHuaKJu2MoVhpSH3iSK+TO07/AGzRh100en4BlH2QCFIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724052397; c=relaxed/simple;
	bh=ssuowxGx1W1czzS4z3jUmO13iFXqMJk3d83GpkAW4Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Wk/g67/kmq3mlUGHz4PQq1UU1aRbOYmMxX07KOTY7FhSxOGdI4OMS9U1j5bGk4rxb6xKBNPlsU8KV7w0b+CUH+V/66v+fYPFt2ZebPg1/WwB+vtgcxhnjBREscvd15zTHsH9hPmXn39sepXKxpwO6jlqQhjxHNIpocoMtEga/SA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y9t8BtvA; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20219a0fe4dso13524455ad.2;
        Mon, 19 Aug 2024 00:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724052395; x=1724657195; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMG2j52tw1mgszoYcGKshXhchCJaL/s4L2M1KESDv+U=;
        b=Y9t8BtvAbvrTbQHElzwLEJZuZcKhjbxrPRKJVzMM2n1Qmk1ocGeRq6GWlXHw4jxB17
         rRgE/acpNB4crET/zO4gCs+6XBbZstj3UacJITAARqM6tz+z0wEBJTlu2tG5xvZLJc07
         Mk4N9FebVcFm9tg9pVCI2XJDhspBsUuXPVTuGP2C62i90tejlFCI64C6a+SEHcKBQ3FQ
         4NSpNUgLp9/fbINFPNHtcKNHV5GS7vmS+5/hON1CRIz4I16ZNjkopq1tEj/Df6pYvpd1
         EXVX/NT39BDJ8mDlzFsZCAJSGVWdBCC45DPwaEmR1udE0EgwI8WblIXdJlEqCvG+VxxM
         dwVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724052395; x=1724657195;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMG2j52tw1mgszoYcGKshXhchCJaL/s4L2M1KESDv+U=;
        b=FtWC9Hvm9qzukXYWjeUMr231vRedNEx5GJ9Zy4VDATgZ91u+j+NpVRma4PQC5hbguJ
         u9q7e/VFGucHQ1tkIdSdrFuzxL5gKUAmYLQF08YS7E/nL/j0Y50iDLQuYJ0g+mGgFJ6J
         Pjz3xw3XbuLqFYIAfq7Yn2BPxhPRADulni746ZTSFSEBceca9X0TdwZ9yNvafIpYBbqe
         41CEErpCLvYRxYpB6wL6pD8NFpU6zmcmQlYqycAhPTRAIwZzK07HLnM8cwri20TWfYuj
         O8EH6esN3WAJfvco8h/H8v0+nuvz/0RTUlehINg+l37jl7Kjb9gjJ9ZvikOdswF3V48g
         +8OA==
X-Forwarded-Encrypted: i=1; AJvYcCUgtvajt88nxFYOP5IZEc5GjXBCEM4PZzdsfwkeuCdlMCiE9tHh5koTDANyW3Ssjbg24kAo0rhGguXEtH5rq9nel2w4lNBbdrHNfVmy
X-Gm-Message-State: AOJu0YytT4PO+ZEttGkFJSU6HMLU/9/XIBIkHdN2i42cjhKEl5SS6EmX
	YHu9vQ6ivefHVHOca632f6U5EHxTXdAzgbvU9KaKeJbGxi9eiJPX
X-Google-Smtp-Source: AGHT+IEA3vuuj8hHvQm/FT75+3Cmov/g2QhDCgVu6DKTepAiVLdnHDZxmVIV9K1VMgQFzR5yfzj/JQ==
X-Received: by 2002:a17:902:f68d:b0:1fd:93d2:fb67 with SMTP id d9443c01a7336-20219696b8bmr66815325ad.52.1724052394666;
        Mon, 19 Aug 2024 00:26:34 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f02faa5dsm58340855ad.2.2024.08.19.00.26.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:26:34 -0700 (PDT)
From: Furong Xu <0x1207@gmail.com>
To: Serge Semin <fancer.lancer@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v3 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Mon, 19 Aug 2024 15:25:19 +0800
Message-Id: <28f3b68dd0e0744e851a0b9d90fdee69792fbc0f.1724051326.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724051326.git.0x1207@gmail.com>
References: <cover.1724051326.git.0x1207@gmail.com>
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
 drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c | 17 ++++++-----------
 1 file changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index a967c6f01e4e..05b870b35947 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -933,7 +933,6 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
-	bool fpe = false;
 	int i, ret = 0;
 	u64 ctr;
 
@@ -1018,16 +1017,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
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
@@ -1058,7 +1053,7 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	if (fpe && !priv->dma_cap.fpesel) {
+	if (qopt->mqprio.preemptible_tcs && !priv->dma_cap.fpesel) {
 		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
@@ -1071,6 +1066,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		goto disable;
 	}
 
+	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, qopt->mqprio.extack,
+				       qopt->mqprio.preemptible_tcs);
+
 	netdev_info(priv->dev, "configured EST\n");
 
 	return 0;
@@ -1089,11 +1087,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	stmmac_fpe_configure(priv, priv->ioaddr,
-			     &priv->fpe_cfg,
-			     priv->plat->tx_queues_to_use,
-			     priv->plat->rx_queues_to_use,
-			     false, false);
+	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, qopt->mqprio.extack, 0);
+
 	netdev_info(priv->dev, "disabled FPE\n");
 
 	return ret;
-- 
2.34.1


