Return-Path: <netdev+bounces-125781-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D6BC96E8E1
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 06:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD8A2281859
	for <lists+netdev@lfdr.de>; Fri,  6 Sep 2024 04:58:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6B113D896;
	Fri,  6 Sep 2024 04:57:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nfqLF8rq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA2284A2F;
	Fri,  6 Sep 2024 04:57:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725598636; cv=none; b=ZtXpwgktS++mwXFsz/iRTA0We2rlaPuvwJ9TP/rWDHxw/DmkKpCgBC1lQ9Op/roZfh82dQbh7kzIy72zwgxeMatQdaDnajzcIi7OfCMl3naNtvRG9QGpMAcIvcHqG3T5A8jeSO57iKIpm5VSCSQ2BW7GdqFF+v1iVGGySnWH4Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725598636; c=relaxed/simple;
	bh=WXVoPHI2DTi73HvWZ/c6p21mBNKm4WrBpvKfioQ8IiY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=dLj4W8j7D1tSKYj9Al/3X1etFMpl7gjItt02sULjcij/VPeWDbNn6Z2JMNOArR5rjri9M3zYpZ68OWiVWKGFQYZf8iBR3YoDe2hcvCeMoPwAYB8jbIiHJHSenSS9nPnZVXzlJZKJvyvVXy+55CzRBvSjnrvv0J8djrj6koa4rUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nfqLF8rq; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5d5eec95a74so980009eaf.1;
        Thu, 05 Sep 2024 21:57:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725598633; x=1726203433; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pUTbWYSzdPbEowJ7j1vGQGnAzD494Zg9qCau1Jp3NnY=;
        b=nfqLF8rqosqoi+MmIWV+UgVXxjlfYH8NjF1PRi+l39J1pIcS41SsCONwBauF7u6hGI
         olL8QNXBnTX5J2Gc+BsI3sECX6PgqER2kr5jEh4MOukb52J71+0vfF4seDm/bYi2pH/i
         3MSm4HrUpL4V8oZzrtFpuc6tUX2Emi+s3+A8dEZma9Y0MJSh81stQxF2tltGl3+XvEU/
         QIY3L7l/k2Kes7XrXdGl5GSq6oAaNW6V8Rgiip/en+K6GwLAsdFj79jh53pRa1XRva7L
         tp/vmtzllOZdKYay0guj+fZvrf1Dn75welh6qMtNbDi6xnbyEa4xZVZHb/fdWI0s+qGI
         i2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725598633; x=1726203433;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pUTbWYSzdPbEowJ7j1vGQGnAzD494Zg9qCau1Jp3NnY=;
        b=PHj2YTmfzVDqWoOXIxyJRampdhSpXmI6IWglDuBoQcOPYvjDSw5tOYMytWeJ/ZQgE4
         9PBrMu811Yio7sXygix28OgqvyNO3YI/TG8J3Nsffvtr+l9u1xrkXK+UhdM+bW+H9MV0
         t0T6TxIrBK2gXdkOtRZQOgfHi7hDPLqqDGxGi2+jlcQJh94SkPTHU1w9+jluUK21ctkd
         9ha6b5UCgWpVqauCq/u/YelgNmHe0nQrR6g4DYxwD8XwyX7LEdl+IEBCVDkdWzlisph7
         A9NyQDqrTzhE7kIIUWk07EG66+xlGZ4zW3mfpIhMlgkK/xNIQQkxwfbAyjYrSuB5ksIc
         NIlw==
X-Forwarded-Encrypted: i=1; AJvYcCWyfV3WvweV0htCDZpDe7fj9UXchMGNda/9gYjJnU0C85FQZU8iUUQ7D8RsadXQbRExs2FCCdxAET1XcfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz8p4bUmg2pOV5Lw+PB3skkcvWLgsPITtz2sG4KUKclS255sLOE
	NFVnBDLD6eK/QBJ5VEtglVbkqxm6id1alHFaQEsN6Q46chQL5XIs
X-Google-Smtp-Source: AGHT+IEmwYoF6D91vqG3EN8hhpjG7cVhE7/POmkWJ+xVqKe899Zu0KnuMeWe7OE+KzPXhV7cKxv0Nw==
X-Received: by 2002:a05:6358:5425:b0:1b5:f81c:8768 with SMTP id e5c5f4694b2df-1b8385ceffbmr195848055d.9.1725598633429;
        Thu, 05 Sep 2024 21:57:13 -0700 (PDT)
Received: from localhost.localdomain ([129.146.253.192])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-71791e54585sm1704002b3a.182.2024.09.05.21.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 21:57:12 -0700 (PDT)
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
Subject: [PATCH net-next v9 6/7] net: stmmac: support fp parameter of tc-taprio
Date: Fri,  6 Sep 2024 12:56:01 +0800
Message-Id: <8e72e92a48e1aca2a38794037d7eb3382711e305.1725597121.git.0x1207@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1725597121.git.0x1207@gmail.com>
References: <cover.1725597121.git.0x1207@gmail.com>
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


