Return-Path: <netdev+bounces-120123-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18C909585B4
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 13:23:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B6071C244D9
	for <lists+netdev@lfdr.de>; Tue, 20 Aug 2024 11:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB2EB18FDA7;
	Tue, 20 Aug 2024 11:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbdgeggn"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7330018E02C;
	Tue, 20 Aug 2024 11:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724152915; cv=none; b=Onj2C4aAX7t7GSqrip6wmm4p+b/8UGnPs4Cv0C5b5nzzbI7FfazEvUEbWllmOA4HtZGfhY89oSgo0s9e6GWygCE+btctPSuOqvnzTxXC7S/xB4hNySuI8n89o4NwTLzRxKFEEI39xoMdtSz+V+K2feQNSYE7L6v+u1sVmtSHVfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724152915; c=relaxed/simple;
	bh=RdPZAva+qriSqOMR4T3ZPVViGtVpGvXV5dkFheYXk6o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Xyd2q/B9Je3kS4+sKQIbouetinjVWRPKq7NFST0qnQr0czEfc98MFImZi0DLuSfS6fgvR4xvj1HfdXGZmksBSR8h9Fo2j9rhvubsLhM6O/4UTySteEgKku3dJ+62Hh9Tj8YW+OvYlMgZpScr9Vi8My1Izy8NRLzh01ilYwS1dnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbdgeggn; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-201d5af11a4so49683135ad.3;
        Tue, 20 Aug 2024 04:21:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724152914; x=1724757714; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=s8g4Op27qwr2/uTcnTjiy2kZfiW5TvWb5gnrsh3SjPg=;
        b=TbdgeggnjxN+erKC26ANfH+Ov+TnNBfFXNjdBqGocuOfkBRr2APCbleyUPGzh55zLq
         fF17idR8zMNY6VdbJuYSeVhIHaXE4INPXWCGSDt8LZ7C6fCprT3Ae2lpmA6GbhEVYJxh
         uCIgz6GgI4mGER/lL/Zk7pnSOaASCoxC6bsuflvia0eL5ikrWlgtgZxj/gQaLtaLJRBO
         V1W5OYOUPUyidxs11Xr52iCgi0cnkEBdGTW8YUFU+UG4fza4qOTbDVnusdnj85t50Kmi
         /Nz3R573N8YXNNZ2QTKSjqHRU0YgPKfeemgagskfmT08nFpIkXjelfCJLypjgS9STp0T
         H+EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724152914; x=1724757714;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=s8g4Op27qwr2/uTcnTjiy2kZfiW5TvWb5gnrsh3SjPg=;
        b=IAhlqOemfgzaDy+hnvBnol1PSq/gI04pRBKfv5Scltd0gI0P/aUEEArVuJbYnYSqbM
         ctICkcnKdAG53wS34lmriBi4gbFapxFE19738q9Y8pcVNee/Qmc78ahhwr90BtXUzX/K
         8eLJWGmVkhpjKCK+BVLMUyVbxRzypav2dPStpZZzUmk+E4uXRESG9IPaowdmPRc8NFg/
         yFPOmpRpD6BslVrC1N1R8xAJ58om3Z7msHZMF9Pnv/M588XcxkMAeSLnUF1LWh/xLSrA
         E8+KvqNF6CXHz3WkzAAZ0YFRghquyTtxGJhOkezwHV582VzJSEQpKQuXtx9TZ0bkC0jg
         UaWQ==
X-Forwarded-Encrypted: i=1; AJvYcCUsJKMR/oIT9g4I1hSKY/VYTyiJxUK1eOOoNWkST6Gykpd7Uylu9VyKXREdLMdi0+miWDD2cjpK/HLk5/vhxXZMMN28ZHyxx40IM2d3
X-Gm-Message-State: AOJu0YxrYqJ3NAfMuRUyHypAyDThPRZVGyvf7A0XktKlGbskLC02a6DV
	uKxuJCL/vN+g1Ynj0pcplwh5fry/fdTnUVZzzpfOTOaz6/7h/MYv
X-Google-Smtp-Source: AGHT+IFoakYw/z/6J97NlZxGYjThK4OBQnPRiS4KWgOFICCw1vB9echW2rbYnDYD5YFBvqlJnKRRLA==
X-Received: by 2002:a17:902:e885:b0:202:3174:9d44 with SMTP id d9443c01a7336-2023174a2fcmr102827975ad.20.1724152913439;
        Tue, 20 Aug 2024 04:21:53 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-201f03756f6sm76465355ad.172.2024.08.20.04.21.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Aug 2024 04:21:53 -0700 (PDT)
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
Subject: [PATCH net-next v5 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Tue, 20 Aug 2024 19:20:40 +0800
Message-Id: <c8c0b7d3315bea9149a70c7d3fa3fc0826e44dc5.1724152528.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1724152528.git.0x1207@gmail.com>
References: <cover.1724152528.git.0x1207@gmail.com>
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
 .../net/ethernet/stmicro/stmmac/stmmac_tc.c   | 21 ++++++-------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_tc.c
index 08fda0ed5ff3..84b566351c5d 100644
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
@@ -1071,6 +1062,9 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
 		goto disable;
 	}
 
+	stmmac_fpe_set_preemptible_tcs(priv, priv->dev, extack,
+				       qopt->mqprio.preemptible_tcs);
+
 	netdev_info(priv->dev, "configured EST\n");
 
 	return 0;
@@ -1089,11 +1083,8 @@ static int tc_taprio_configure(struct stmmac_priv *priv,
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


