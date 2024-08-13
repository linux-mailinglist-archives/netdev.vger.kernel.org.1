Return-Path: <netdev+bounces-118016-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08E23950426
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 13:50:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 452CCB2654D
	for <lists+netdev@lfdr.de>; Tue, 13 Aug 2024 11:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8364D199381;
	Tue, 13 Aug 2024 11:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C4bzC4Co"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 096BB194A6B;
	Tue, 13 Aug 2024 11:49:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723549749; cv=none; b=cQ5IjoX2cCOpg1oiiUUWfEcfqK3EIDjOUVt01WhP+oPybScQbD40p1qe4LIwZ84Ss+4XIXCMk+f6AYolETUdZNlD6UiUza8sfgo6+D9F2Z770S0RfcX7fm4U19SUpthI/hHWe+Xz61ncMO/9V2v9iyG/yNeMHyGtuB9ErhyoNX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723549749; c=relaxed/simple;
	bh=ssuowxGx1W1czzS4z3jUmO13iFXqMJk3d83GpkAW4Hc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jY0iGugWzcOZMVDRigunhIhVzsroPftYQTJ6z/6sdj9CUIxTvcpQRQOd1luwQkhNGnBtClkWrlFhSw56rKDAiHZA6L8UuY0dtQhmmi1DrJkU5rNrH3kMVWpnjO0/EziM4q5qVfcE8pYhbSmwOmCLPb4lbkW0gH6lA3qRYixDGlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C4bzC4Co; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-710dc3015bfso2577617b3a.0;
        Tue, 13 Aug 2024 04:49:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723549747; x=1724154547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aMG2j52tw1mgszoYcGKshXhchCJaL/s4L2M1KESDv+U=;
        b=C4bzC4CooCBv7W8YxM9TOCAio6PNhsFE/h0z39PkUOME0TQVGfoBT5UEDtCxwBvSEk
         FN+w/FfiWRvthIOVYXEXQnkXoHWrB5vonRbKrnafLiEa6yYBGvp1sRmnPZ10xYmWcPXz
         2ZHygn2SCr4zPAzp0dmKvYs5/BgJhdQvfZZx8d0Run4uU+7LN5rUIWLggTgujymuJwpU
         sYKuzgDRnkCCx1/7h8FUyqJvy8j59edYFcyjgvD1hHfs1KG6xYjrthjPeLloLmEX4qOq
         01bpt8Apa7E0JJcjMpa9j80V1PNqmaLSctN4DKXW8L7C2xEL3+XO2x4WsefBolZHNO/B
         Qw/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723549747; x=1724154547;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aMG2j52tw1mgszoYcGKshXhchCJaL/s4L2M1KESDv+U=;
        b=azAHLCWCZPWET+5/owLh0YJ6pNXQMkAguhOHuVbdfW+nsBRbUrgAiL52OaiaQvEQ4a
         HYAr6Z+DhgTorP+1mi1T0eBoQdkbRe/aGrs/p4BowWI+6hf4R/jzeHJpmtVkqacPP0xP
         POxrGFX8miH4aEoS/JRlVG8LwhmTQdbaa9rqNKWHqt7lHdLchfZajFkhvcJAAXh2Q/1b
         1kQwpiNo36M6NxY6TWFgu+OmOctW0IdtzM4ytFXSOMrVAPZwlnQgdk6WNlvtLrV5DbxL
         yvbL4NSgdgQ5zJKCfnIhSAhx7txtRAu7Ce3kLysLuWHbjeH2SgtTwhuxXn/X2sYzy2MP
         BL8g==
X-Forwarded-Encrypted: i=1; AJvYcCVjhqpDZI174BXAI4hQ6+pi08NniiT4RXGcF/a3dhf3f/uIsFrYJz4+hmjewg5X48OV0KPJV1UB2p+/lIxd+w9ogWc1B8CzQALCBa24
X-Gm-Message-State: AOJu0Yydb5A18YaWWCmxUKBK05N3rhJ8wzQBoFN/+OYuEN8SheALsKnb
	jzX6+zF9bnGVuAl1tiCqb69WPvVoKJJTup/Hs/FM3xCX9+DEsqdm
X-Google-Smtp-Source: AGHT+IHg9p5XaWZp0fr8FwtTPtazfdJh8IlGlsjar3+6d5LzFggbsasYv2qGTijgOoDA9e+iE9Xztw==
X-Received: by 2002:a05:6a00:9188:b0:70e:cf2a:4503 with SMTP id d2e1a72fcca58-71257011c24mr4195800b3a.11.1723549747060;
        Tue, 13 Aug 2024 04:49:07 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-710e5a562bbsm5548755b3a.111.2024.08.13.04.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Aug 2024 04:49:06 -0700 (PDT)
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
	rock.xu@nio.com,
	Furong Xu <0x1207@gmail.com>
Subject: [PATCH net-next v2 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Tue, 13 Aug 2024 19:47:32 +0800
Message-Id: <7ae5ca1f640f298cd0409553886693e8989c87cc.1723548320.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723548320.git.0x1207@gmail.com>
References: <cover.1723548320.git.0x1207@gmail.com>
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


