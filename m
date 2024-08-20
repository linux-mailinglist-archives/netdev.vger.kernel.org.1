Return-Path: <netdev+bounces-120068-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D3139582EF
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:42:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6B7F31C20E7D
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 09:42:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF4618EFF8;
	Tue, 20 Aug 2024 09:39:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OTmBr1n9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167118CBF1;
	Tue, 20 Aug 2024 09:39:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724146769; cv=none; b=KKMlpNVxmgr9t2rcjuaIozxXsXz4GoX7FjCZKhNxAj/xInEt5OkuVvIdKEcEKXVBclqXJUPyKNvPFS6mK1NnS9ygLAONU+eGV8ylDcbhswF18aK4lL09rrI5x9MVq9Z/uUXZgWdoBbUz1j7A6+K9qe3LonowlGT/sIsCF5MQQtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724146769; c=relaxed/simple;
	bh=pvuIQuXjkzNMJYT3uEFGY3Kq0l11eWYClalium1xMsc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HNTtWe3dBKnSjFrBhx3oqhay1UG2Twtuj8i0yxBXFHpWQi2yRf/hTYXgKp+zQC9w3whE3Wg/y6Gmzm/P84OJBZNjdR01IYg7ICJRLnzmiaYQ9+qoqRBba7Uvz4msJnXdC52tegyWxFMUNjsUPcJyrG7thDskX6awUdDAj3ybvJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OTmBr1n9; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-2d3d0b06a2dso3664538a91.0;
        Tue, 20 Aug 2024 02:39:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724146768; x=1724751568; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MBziSSli8cMhwVRS/XUpMid3dlyuuWsBGzCQhQohhLw=;
        b=OTmBr1n9KzylEWmJ2EgK0Gtv5MggkYq8+XMYQCugApXc3Qh0AnBUiExpod5xWRGUm/
         0MpykCIRVllk6fosHl5GVC1HU7x1fH4lFzTa3bLlOwm4apLY4DPtfepf7IrNlda+mCLy
         2eFkfN6n3LoF4S5VmuUYG3JL989lHMCvbfw4PZyjgXnNiQjPQU+ySxH4+qgWkOnBDSKp
         Gtl9t/Z5JEqjxsrRcwcno+1mi/9Lhy/qalp7WS930trSbMGlTJgVdqq5NDsfyy5tHh1J
         iYorQK1ujjbDV489z6gxMKS/ZgxAqhwJMwZLQiXf6SDmilqLTA2J/49S6SuwIUMrsVAb
         D7Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724146768; x=1724751568;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MBziSSli8cMhwVRS/XUpMid3dlyuuWsBGzCQhQohhLw=;
        b=Rrb/6lK11J/qN4XBnVwZq8xkjNne6YnkTrYBfcum15o1rzEfGlmDl6FypIhrZA6t3L
         44Yn+fJyxcOSD5fDbRAnAMEtu5a5W1Zt9W8hTIe61QVfztrBHLt6aPHW8gqh4JqbI+O3
         JdFSVD9Ej8wXSEDBvcg8uTGhRaIBYPij53OyK5hqFg4OjQtCugTkZ8AXlNgKTau8/BVr
         duO2JwrNxdxigghvJ/WnBOTxSNunIlQSym+hdqifW/JJAlVFnIQYzgb2k51MXB5MnC8y
         KFvZ1ZyOeDvwnV8a32mVGRRjTDJ/MnGuYt1wryHY81VQaTggWIyOgHX0nvLIiIaapAD5
         vi4Q==
X-Forwarded-Encrypted: i=1; AJvYcCVQxYSnoXVUSd4/nrKe+U4quvXWzNMdOq/xeWddiG6CIQ46ddr2ko8oxhQNLJkpuy2sKUzjkvqpE6kgr6s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1Yf02vmkcY2Kl+gusA/hG/zAH8ZP6An2A/eHwYhsyNkd/kzg+
	QSflqnOcES9ch+WFw/DpxmcbQvFGmAFoqs7mTrc85hB/zHlZpAdULXH7+Q==
X-Google-Smtp-Source: AGHT+IGv2yZnBNN0ZbnLqzVXOK4cuhP5PFCjq22WGkpxCpnGjZAQC6MUuCRjeBTUVeo52ol6QEcEwg==
X-Received: by 2002:a17:90a:db8d:b0:2cb:5aaf:c12e with SMTP id 98e67ed59e1d1-2d3e03e8cfbmr14850301a91.37.1724146767418;
        Tue, 20 Aug 2024 02:39:27 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-2d45246061dsm3230608a91.8.2024.08.20.02.39.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 02:39:27 -0700 (PDT)
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
Subject: [PATCH net-next v4 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Tue, 20 Aug 2024 17:38:34 +0800
Message-Id: <b3e9cba8331a65523a66e498179153361fac18bd.1724145786.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724145786.git.0x1207@gmail.com>
References: <cover.1724145786.git.0x1207@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index f8f09ef2d447..589fbe9de09b 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
@@ -932,9 +932,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 			       struct tc_taprio_qopt_offload *qopt)
 {
 	u32 size, wid = priv->dma_cap.estwid, dep = priv->dma_cap.estdep;
+	struct netlink_ext_ack *extack = qopt->mqprio.extack;
 	struct timespec64 time, current_time, qopt_time;
 	ktime_t current_time_ns;
-	bool fpe = false;
 	int i, ret = 0;
 	u64 ctr;
 
@@ -1019,16 +1019,12 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
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
@@ -1059,7 +1055,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 
 	tc_taprio_map_maxsdu_txq(priv, qopt);
 
-	if (fpe && !priv->dma_cap.fpesel) {
+	if (qopt->mqprio.preemptible_tcs && !ethtool_dev_mm_supported(priv->dev)) {
+		NL_SET_ERR_MSG_MOD(extack, "Device does not support preemption");
 		mutex_unlock(&priv->est_lock);
 		return -EOPNOTSUPP;
 	}
@@ -1072,6 +1069,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		goto disable;
 	}
 
+	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, extack,
+				       qopt->mqprio.preemptible_tcs);
+
 	netdev_info(priv->dev, "configured EST\n");
 
 	return 0;
@@ -1090,11 +1090,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		mutex_unlock(&priv->est_lock);
 	}
 
-	stmmac_fpe_configure(priv, priv->ioaddr,
-			     &priv->fpe_cfg,
-			     priv->plat->tx_queues_to_use,
-			     priv->plat->rx_queues_to_use,
-			     false, false);
+	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, extack, 0);
+
 	netdev_info(priv->dev, "disabled FPE\n");
 
 	return ret;
-- 
2.34.1


