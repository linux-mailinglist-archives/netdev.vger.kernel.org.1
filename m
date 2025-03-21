Return-Path: <netdev+bounces-176833-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31134A6C4F3
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 22:17:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6BE3F463558
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 21:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49364231C9C;
	Fri, 21 Mar 2025 21:17:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="Cm3IapUg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1D0F1E9B34
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 21:17:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742591841; cv=none; b=iM3cU/jA0bCCl+JqZ1KjljtITgNQVeNY+fcEBS1SmE4aBb8fiDuBvhpprDzlpcJk6nUpn/mVTkhGmdSkGqBevKbgLR5CgTaXlpfhQJBzNvsl1ws6P9Bo2I+/CbVaTHl/CRSFpF2qo+uUK6rU/7eYBUlsgQpqgse+8qk8kvWsBq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742591841; c=relaxed/simple;
	bh=8VH5ZBR2pM/FZIhsdwpFvhRpQCc3sQ7FLUxfUytMFew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pm5nWjT4xCHlnRMXtc9Xzrgbc/yFCo26eR6n+XNKZcfWAKsPTpXQ5rUUQ5zmDET08b1XTSdh2Ib+qE12lzHXC2lHvTy5d8Pt5gZfaELv+CCQ8mK+9nCOiwGOUhRLHrafFWbrAxqIdpHDZpKBTlt+4Sp4h5zwHFgHzoWGk61m9aE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=Cm3IapUg; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-223594b3c6dso58234695ad.2
        for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 14:17:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1742591839; x=1743196639; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0GWxDl3NKRQpR9b0MB26S0fCiRIMgEtnDkyEGLrp2mE=;
        b=Cm3IapUgXDCoWmaubOIAupKpeVTupTiwvGKm3X6RYKLLAkZdiPJZtvGZpX3UVzdrmz
         wla7DUWkZd9q5G4ref1vLnqicvLY7ApTMi4sF4kLHvaE96KcLVJPrYzBWozxtVc7tzyr
         4hY1TCx0Rl6gQMIuPriR142syhK7h1cli5Rak=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742591839; x=1743196639;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0GWxDl3NKRQpR9b0MB26S0fCiRIMgEtnDkyEGLrp2mE=;
        b=PehmnJ+AzoOsF2urKF9RZ2lFUtQ3V5y+XCd6+MibDcEpw1UmW67zFMUxDbRtNVg5i+
         Flr4Up0OjapbH7RUMjnHfNWH+SCyjkyGm2z6uf95O84rBJxE1zj5+USR05P7/OO79Gg1
         WlP0dRBKrRIkMabsYbhBKtPyrySc8JqXdygENx8RFA2AORO8j2DFvuWjx4Frf/L2M/Jg
         d/EFV1C1wnklgqPqJpKU5mU1xmd46KG7Rum+ZunrNqn5toOQxyYG6ULKnfOVAznl8s5I
         DLKNWGHdkL+/4y3GoUMa4Xd4xTXMLCk0LEi9qlXhI7N68CG4g2Ki4GRbtOk9u33cTGyl
         o0bA==
X-Gm-Message-State: AOJu0Yx0E6Sl78XS5UQ4T89uYbN9R9Zpyxsrg2MtBGtQvK06c/X2NKQO
	ghvO8R8FN38+eJ1s7FyWWszN6f7LHmVps7oH774hp/2QdbcUFn23icVT9S0EIg==
X-Gm-Gg: ASbGnctnYLv6qMn5UT7SeWLCSKXf3dfE1Ul8ngwpgp434x/C6Tr6aV+ss322g3aOzhf
	tX9Qs65kkC0RVAjDCmmcvRZPRTyfLDwFQ9eWXnsqVaJzZvgfESAoSeRT8JXGrxDkvAIMX9uV6Al
	qHjJduXS1dalvowhIrudeexD32NhL9vrL8TbfBEd07RG2mIQaz1L0Na28siuKOuMohcKjNnhA+k
	EcICkeHWFPBU72zlePqAE8pzD8Et/t3p26UbPqxKPnv9K2jc73yn+L+o5er78PMz5px6snfegh9
	uICFrrSQLes90tD8oa8sjBvGY7OTq2M0VuaZYQIxrbk23n1FbZgAyOQyBsYqurU5DkzE/9GwBI4
	owg8jyOe8xyqr5bmgzcL4
X-Google-Smtp-Source: AGHT+IEWJ9LaNh3/4jHt9AopZylkCMg0KKSIGrRqyu/n5Gr/HIExvjCDHFaVqE6a0g5mUNueJJyyEQ==
X-Received: by 2002:a17:902:ce0f:b0:223:66bc:f1de with SMTP id d9443c01a7336-22780d7e389mr82414725ad.21.1742591839009;
        Fri, 21 Mar 2025 14:17:19 -0700 (PDT)
Received: from lvnvda3289.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22780f4a034sm22386055ad.98.2025.03.21.14.17.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Mar 2025 14:17:18 -0700 (PDT)
From: Michael Chan <michael.chan@broadcom.com>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	pavan.chebbi@broadcom.com,
	andrew.gospodarek@broadcom.com,
	osk@google.com,
	Somnath Kotur <somnath.kotur@broadcom.com>,
	Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Subject: [PATCH net 2/2] bnxt_en: Linearize TX SKB if the fragments exceed the max
Date: Fri, 21 Mar 2025 14:16:39 -0700
Message-ID: <20250321211639.3812992-3-michael.chan@broadcom.com>
X-Mailer: git-send-email 2.43.4
In-Reply-To: <20250321211639.3812992-1-michael.chan@broadcom.com>
References: <20250321211639.3812992-1-michael.chan@broadcom.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If skb_shinfo(skb)->nr_frags excceds what the chip can support,
linearize the SKB and warn once to let the user know.
net.core.max_skb_frags can be lowered, for example, to avoid the
issue.

Fixes: 3948b05950fd ("net: introduce a config option to tweak MAX_SKB_FRAGS")
Reviewed-by: Somnath Kotur <somnath.kotur@broadcom.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Reviewed-by: Andy Gospodarek <andrew.gospodarek@broadcom.com>
Signed-off-by: Michael Chan <michael.chan@broadcom.com>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 11 +++++++++++
 drivers/net/ethernet/broadcom/bnxt/bnxt.h |  4 ++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index 158e9789c1f4..2cd79b59cf00 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -485,6 +485,17 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	txr = &bp->tx_ring[bp->tx_ring_map[i]];
 	prod = txr->tx_prod;
 
+#if (MAX_SKB_FRAGS > TX_MAX_FRAGS)
+	if (skb_shinfo(skb)->nr_frags > TX_MAX_FRAGS) {
+		netdev_warn_once(dev, "SKB has too many (%d) fragments, max supported is %d.  SKB will be linearized.\n",
+				 skb_shinfo(skb)->nr_frags, TX_MAX_FRAGS);
+		if (skb_linearize(skb)) {
+			dev_kfree_skb_any(skb);
+			dev_core_stats_tx_dropped_inc(dev);
+			return NETDEV_TX_OK;
+		}
+	}
+#endif
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
 		/* We must have raced with NAPI cleanup */
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index 3b4a044db73e..d621fb621f30 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -84,6 +84,10 @@ struct tx_bd {
 
 #define TX_BD_CNT(n)	(((n) << TX_BD_FLAGS_BD_CNT_SHIFT) & TX_BD_FLAGS_BD_CNT)
 
+#define TX_MAX_BD_CNT	32
+
+#define TX_MAX_FRAGS		(TX_MAX_BD_CNT - 2)
+
 struct tx_bd_ext {
 	__le32 tx_bd_hsize_lflags;
 	#define TX_BD_FLAGS_TCP_UDP_CHKSUM			(1 << 0)
-- 
2.30.1


