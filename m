Return-Path: <netdev+bounces-94812-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 58E418C0C13
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 09:45:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E9A1AB225BE
	for <lists+netdev@lfdr.de>; Thu,  9 May 2024 07:45:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44188148307;
	Thu,  9 May 2024 07:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cpor8yFW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 621B1624
	for <netdev@vger.kernel.org>; Thu,  9 May 2024 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715240708; cv=none; b=Mv+1uhp39m2D7PCsbGPs3DfqJlMhFOwi1z5L4Qd+5NIYZzgw2BQeuIAdjayecj5srLKIOJq9a1BYY22l+8Pm254BeAFLqyFyp/NMresieowqyC74rpV93yziLw2EmJfyJ8l7JbgIM6+VM/6JDGjUi0hlfuPT6DdSnJ8bDNjaaX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715240708; c=relaxed/simple;
	bh=uqSFUt+6hbQp7AmSUqu4k6Ig0CACIiBo5+SXZJf395Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=h5Zi3WqWk8ApeAYeQkTcISx/Sfr0IpnG3FvFyeeXOzeGHD9sGiJRrfbV87DkBUD/eRKiPl5oURwnu7ETPeWFrPV7NvtXHOaELoKqHG4XoVEwA7+O/j+ohdYyDCDH8HtX8JBMndMNFWFF9GPNGMORpt1NK1XWwuUXDeGCAkPLlTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Cpor8yFW; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a599af16934so132962966b.1
        for <netdev@vger.kernel.org>; Thu, 09 May 2024 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1715240704; x=1715845504; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=5y+uXmNpnj2RaNWPj3qJCxN72WzccnwLe4mZM9KaQP4=;
        b=Cpor8yFWxoww24sem1pSa6MeoVj5ObDMXKojslcYo/4Gtrx0UKdXMOpz9Hz2Nb+sO1
         Gqgc0NR6FbmS51ShWU/pNNe6YclB+5HxkoYyf2t/srIgSqi73PA3LZFgY1Qh0ypSAPUE
         lELG/86ivRIYQGo/gz6at/8l4sUbVBuVVKDd6wIi9b+zb8WCvy2/5+xploJkkmEm1wrA
         GuLV/Iben33GVSnkxSXEMZdEg/R4VDSg5E0w56a2DGyDRTrk+6sqNxNVX8ZzaBQ9vUQN
         IZIH4Dn0mqcAdFBTjMyfgI3kdIK9V2YxSk3qKNOu1LT4B4g9QgwXwIe8kiU0uyEzHSuM
         N09w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715240704; x=1715845504;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5y+uXmNpnj2RaNWPj3qJCxN72WzccnwLe4mZM9KaQP4=;
        b=LW5kHaUVqCIdvD3COSzBqchyzr+yk/GBdmVR3LtIvgk8NV7r/sF5C1vmh9xODMdjBL
         OMosF01V5B5C2d5VOGi7qy6yKK22597Va26kYvza432ngfICLaLor/mXhFaehll9l/NB
         o3q8nxuNjyx1vpTMwDq/btBkd1GU4uCbYnJ1TlKjxU1ByXrgf5Z0CdHpFfpcy2Icpz9v
         /ZD4sSdHZIdkYMaLjxTYiXOEW40hP/TZ1LrrTC5ldf1of7xU67c9olzk8keK+kmvF2FJ
         0I+ZcIp4I0iqEKpr66QR3BT4kbCejAXxn/StmLElRrqaL1Rdh56T9HiDnU9tOmCKyMns
         +Dsg==
X-Gm-Message-State: AOJu0YzsxZ0zSELCX1WoBIgAz5tYlmYtejsbzNUIwvBgpdZtuBDBaRGc
	6bJBd7uoAnXZmLzaofArHQ8b8X88PexSXnMjAQEClwj24SAKsHvAKHhEgCuIGwY=
X-Google-Smtp-Source: AGHT+IHkxv73L0WnVY6pllsaFfzFkhW688GQPZ4oxPVl/JII/T+P+dihkb6kL9L805SfRzC7qVPiQQ==
X-Received: by 2002:a17:906:f917:b0:a59:b02a:90e7 with SMTP id a640c23a62f3a-a59fb9f0eeemr316243166b.64.1715240704533;
        Thu, 09 May 2024 00:45:04 -0700 (PDT)
Received: from [192.168.1.140] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a5a17b0172fsm45002466b.183.2024.05.09.00.45.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 May 2024 00:45:04 -0700 (PDT)
From: Linus Walleij <linus.walleij@linaro.org>
Date: Thu, 09 May 2024 09:44:54 +0200
Subject: [PATCH net] net: ethernet: cortina: Locking fixes
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240509-gemini-ethernet-locking-v1-1-afd00a528b95@linaro.org>
X-B4-Tracking: v=1; b=H4sIAPV+PGYC/x2MwQqDMBAFf0X27MIqkaK/UjzY+IxL7SpJkIL47
 w09DszMRQlRkWioLoo4NeluBZq6Ir9OFsA6F6ZWWied9BzwUVNGXhENmbfdv9UCP3zjXyIOs+u
 p1EfEot//+UlFpPG+f/NEJoNuAAAA
To: Hans Ulli Kroll <ulli.kroll@googlemail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>
Cc: netdev@vger.kernel.org, Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.13.0

This fixes a probably long standing problem in the Cortina
Gemini ethernet driver: there are some paths in the code
where the IRQ registers are written without taking the proper
locks.

Fixes: 4d5ae32f5e1e ("net: ethernet: Add a driver for Gemini gigabit ethernet")
Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
 drivers/net/ethernet/cortina/gemini.c | 12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/cortina/gemini.c b/drivers/net/ethernet/cortina/gemini.c
index 705c3eb19cd3..d1fbadbf86d4 100644
--- a/drivers/net/ethernet/cortina/gemini.c
+++ b/drivers/net/ethernet/cortina/gemini.c
@@ -1107,10 +1107,13 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 {
 	struct gemini_ethernet_port *port = netdev_priv(netdev);
 	struct gemini_ethernet *geth = port->geth;
+	unsigned long flags;
 	u32 val, mask;
 
 	netdev_dbg(netdev, "%s device %d\n", __func__, netdev->dev_id);
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
+
 	mask = GMAC0_IRQ0_TXQ0_INTS << (6 * netdev->dev_id + txq);
 
 	if (en)
@@ -1119,6 +1122,8 @@ static void gmac_tx_irq_enable(struct net_device *netdev,
 	val = readl(geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
 	val = en ? val | mask : val & ~mask;
 	writel(val, geth->base + GLOBAL_INTERRUPT_ENABLE_0_REG);
+
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
 }
 
 static void gmac_tx_irq(struct net_device *netdev, unsigned int txq_num)
@@ -1415,15 +1420,19 @@ static unsigned int gmac_rx(struct net_device *netdev, unsigned int budget)
 	union gmac_rxdesc_3 word3;
 	struct page *page = NULL;
 	unsigned int page_offs;
+	unsigned long flags;
 	unsigned short r, w;
 	union dma_rwptr rw;
 	dma_addr_t mapping;
 	int frag_nr = 0;
 
+	spin_lock_irqsave(&geth->irq_lock, flags);
 	rw.bits32 = readl(ptr_reg);
 	/* Reset interrupt as all packages until here are taken into account */
 	writel(DEFAULT_Q0_INT_BIT << netdev->dev_id,
 	       geth->base + GLOBAL_INTERRUPT_STATUS_1_REG);
+	spin_unlock_irqrestore(&geth->irq_lock, flags);
+
 	r = rw.bits.rptr;
 	w = rw.bits.wptr;
 
@@ -1726,10 +1735,9 @@ static irqreturn_t gmac_irq(int irq, void *data)
 		gmac_update_hw_stats(netdev);
 
 	if (val & (GMAC0_RX_OVERRUN_INT_BIT << (netdev->dev_id * 8))) {
+		spin_lock(&geth->irq_lock);
 		writel(GMAC0_RXDERR_INT_BIT << (netdev->dev_id * 8),
 		       geth->base + GLOBAL_INTERRUPT_STATUS_4_REG);
-
-		spin_lock(&geth->irq_lock);
 		u64_stats_update_begin(&port->ir_stats_syncp);
 		++port->stats.rx_fifo_errors;
 		u64_stats_update_end(&port->ir_stats_syncp);

---
base-commit: 4cece764965020c22cff7665b18a012006359095
change-id: 20240509-gemini-ethernet-locking-7c1cb004ed49

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>


