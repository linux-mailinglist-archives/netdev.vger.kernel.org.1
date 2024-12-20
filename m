Return-Path: <netdev+bounces-153588-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 220009F8B22
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 05:18:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9FF207A2227
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 04:17:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C817189BB3;
	Fri, 20 Dec 2024 04:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="C/5/BU97"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 422BF157E99
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 04:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734668234; cv=none; b=VNDImxfgNVMHaHcgvCD0ZVMrZnqNH5al9MVL293SNOl9Br5drzYeCRf9sv6h687ZMBt+XukdnR9TouYhXOxUg1m7f2EhfxTub04xmcjBcKRAhGctb3FbUOqBtgOu9Zq5+05gOn1MwsWQsU4lGEXCZ+M00jxILDzn2PqOqIt4GQU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734668234; c=relaxed/simple;
	bh=7UUTsmjRchZRPWt1L9EdlY0v8i26VrF6o4c6qJ5IuEw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=gV2x3QI1rvzhywjjIWc0iA7uv2l5yzAenvB0CP/7qiMXJHLd6WsyF/4OA5oqcm8UNljo8guOxi/MGXzYfan3XaDiqP2XVQJEKylVyeMzZOwW3GByQzXNSRRq7SvE7A6LCAHsz06jJPKIH2AAoTrOP5J0jvbO5FJT1wsFTXXJ0l8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=C/5/BU97; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-53e3a5fa6aaso2775754e87.0
        for <netdev@vger.kernel.org>; Thu, 19 Dec 2024 20:17:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1734668229; x=1735273029; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LTwIjsFkDY5wb4hiAoIm9JErxNYkg5bDw1x4lkN+29w=;
        b=C/5/BU97WUAHskdaqwHOyALD2wJogE7lKIPRtIv0mxSpReUWljdAJq9HG5SQCI4aBD
         Moq5j1i67w6Pfq8M+Iy4JpSSsAS/wBYXrtEe3tpF6sT+3oJIDU5tlhKPme3Z80vixWvL
         BjuCHWiu0za2Hrcx0o9PNF3xhLTwjUybjLRy3RiSi2/gOLKK44j2ArfpaxqloBshXsMG
         Da2lmcWbGP3M+7b4K3pHjV5c5PRMH4Lg+QTGk7jQMK+ZWZz5N+PSixYm3RFbfdc5SXGm
         R5jDdqg0LJMAvzqXR/rIsQmw+ppKCQnORD/IEDYvKbH25OrqaDORtQwouw7NYJqY0cfT
         IoEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734668229; x=1735273029;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LTwIjsFkDY5wb4hiAoIm9JErxNYkg5bDw1x4lkN+29w=;
        b=MllUxWNj2wtp0LRb7faeK6KxdpwhvTHz+AzxjMWoZG3Zt9CRruHeZaQYB4/7Sk9CB2
         cW1nn5v89/JucAlI75R3Q+t1nL3r2uw0ruqkYG94Ir2OOMRFjVseLBhCO3guuiRbBrpJ
         10Ln9JANbNxSMQcufvJJDSLovoE7Q0pzl2C6XcyUxVTnGVQ54U1nQuKrzjdU+L6w9wFG
         yeVofAMkYLX6Q59qg3ZnXqqrWI6A6FsJaOvdb49liAo+T+tliP0SV9a+peId511kZcR6
         oTv7ELcKHXnNUTagtv2rfJuaLozvFUVDKd7lIjh9BYavyuIA8GgOP4m3UnhRI4fZrTyP
         ZxKw==
X-Gm-Message-State: AOJu0Yy4Cfa0UGDqMgMjcHnZ0bhzMTot8JCF/bmlHRVE9GpbW3gEC/2W
	wAgG3TUL0oLusZiFfgXTsb5DY0LLbo4TAXnfPg0+znGWFlVeo40ExYyjyOR2oq0=
X-Gm-Gg: ASbGncuuxhTeX2H7N4Fg4zJuv7ftPkrFp1DqnmT6I+vzEL75QXlICtrerX6KA13K/A5
	KojeWE8RZHkwamfBIIFVjmOitQgRgdYMFa3FkBHR6vwnaZASxAhgM7LA/Mpv9sf+Ei8aD97jCKc
	Tsl+ff+mJTYgIR+Lv6UFII0/MnBdOaPC6hPoJOzBptsMv1P1usXTqj0jNgX3Yy3it7+8MqIF0iW
	dyQGK6X1b8Yi1HussxA0xhqtCeFvH1GwQARF9NAy0HzGV1burLytg/W3HdsRbIibgVGVPU=
X-Google-Smtp-Source: AGHT+IE5czr4LmTwoALi/RSdvS2Orti1CAw/4SDl5Z6ra7AljW2hSxHfLwtSebbfg5iMM0wrj4ad/w==
X-Received: by 2002:a05:6512:1042:b0:540:2add:c1f1 with SMTP id 2adb3069b0e04-5422133b657mr1889695e87.18.1734668229367;
        Thu, 19 Dec 2024 20:17:09 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-54223832c1bsm357078e87.280.2024.12.19.20.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 20:17:09 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net-next 2/2] net: renesas: rswitch: request ts interrupt at port open
Date: Fri, 20 Dec 2024 09:16:59 +0500
Message-Id: <20241220041659.2985492-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241220041659.2985492-1-nikita.yoush@cogentembedded.com>
References: <20241220041659.2985492-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Data interrupts are now requested at port open and freed at port close.

For symmetry, do the same for ts interrupt.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 35 +++++++++++++-------------
 drivers/net/ethernet/renesas/rswitch.h |  2 +-
 2 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index eb9dea8b16f3..cc8f2a4e3d70 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -989,18 +989,6 @@ static irqreturn_t rswitch_gwca_ts_irq(int irq, void *dev_id)
 	return IRQ_NONE;
 }
 
-static int rswitch_gwca_ts_request_irqs(struct rswitch_private *priv)
-{
-	int irq;
-
-	irq = platform_get_irq_byname(priv->pdev, GWCA_TS_IRQ_RESOURCE_NAME);
-	if (irq < 0)
-		return irq;
-
-	return devm_request_irq(&priv->pdev->dev, irq, rswitch_gwca_ts_irq,
-				0, GWCA_TS_IRQ_NAME, priv);
-}
-
 /* Ethernet TSN Agent block (ETHA) and Ethernet MAC IP block (RMAC) */
 static int rswitch_etha_change_mode(struct rswitch_etha *etha,
 				    enum rswitch_etha_mode mode)
@@ -1510,8 +1498,14 @@ static int rswitch_open(struct net_device *ndev)
 	unsigned long flags;
 	int ret;
 
-	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
+	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS)) {
+		ret = request_irq(rdev->priv->gwca.ts_irq, rswitch_gwca_ts_irq,
+				  0, "rswitch_ts", rdev->priv);
+		if (ret < 0)
+			return ret;
+
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDIE);
+	}
 
 	napi_enable(&rdev->napi);
 
@@ -1535,8 +1529,10 @@ static int rswitch_open(struct net_device *ndev)
 err_request_irq:
 	napi_disable(&rdev->napi);
 
-	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
+	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS)) {
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
+		free_irq(rdev->priv->gwca.ts_irq, rdev->priv);
+	}
 
 	return ret;
 };
@@ -1562,8 +1558,10 @@ static int rswitch_stop(struct net_device *ndev)
 
 	napi_disable(&rdev->napi);
 
-	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS))
+	if (bitmap_empty(rdev->priv->opened_ports, RSWITCH_NUM_PORTS)) {
 		iowrite32(GWCA_TS_IRQ_BIT, rdev->priv->addr + GWTSDID);
+		free_irq(rdev->priv->gwca.ts_irq, rdev->priv);
+	}
 
 	for (tag = find_first_bit(rdev->ts_skb_used, TS_TAGS_PER_PORT);
 	     tag < TS_TAGS_PER_PORT;
@@ -2001,9 +1999,10 @@ static int rswitch_init(struct rswitch_private *priv)
 	if (err < 0)
 		goto err_ptp_register;
 
-	err = rswitch_gwca_ts_request_irqs(priv);
+	err = platform_get_irq_byname(priv->pdev, GWCA_TS_IRQ_RESOURCE_NAME);
 	if (err < 0)
-		goto err_gwca_ts_request_irq;
+		goto err_gwca_ts_irq;
+	priv->gwca.ts_irq = err;
 
 	err = rswitch_gwca_hw_init(priv);
 	if (err < 0)
@@ -2035,7 +2034,7 @@ static int rswitch_init(struct rswitch_private *priv)
 	rswitch_gwca_hw_deinit(priv);
 
 err_gwca_hw_init:
-err_gwca_ts_request_irq:
+err_gwca_ts_irq:
 	rcar_gen4_ptp_unregister(priv->ptp_priv);
 
 err_ptp_register:
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index a1e62a6b3844..54b9f059707a 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -58,7 +58,6 @@
 #define GWRO			RSWITCH_GWCA0_OFFSET
 
 #define GWCA_TS_IRQ_RESOURCE_NAME	"gwca0_rxts0"
-#define GWCA_TS_IRQ_NAME		"rswitch: gwca0_rxts0"
 #define GWCA_TS_IRQ_BIT			BIT(0)
 
 #define FWRO	0
@@ -978,6 +977,7 @@ struct rswitch_gwca {
 	struct rswitch_gwca_queue *queues;
 	int num_queues;
 	struct rswitch_gwca_queue ts_queue;
+	int ts_irq;
 	DECLARE_BITMAP(used, RSWITCH_MAX_NUM_QUEUES);
 };
 
-- 
2.39.5


