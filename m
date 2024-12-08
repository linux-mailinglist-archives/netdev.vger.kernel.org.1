Return-Path: <netdev+bounces-149984-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8489E8610
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 16:53:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3192218839F4
	for <lists+netdev@lfdr.de>; Sun,  8 Dec 2024 15:53:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD081684B4;
	Sun,  8 Dec 2024 15:52:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="Yp5OhfG+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lf1-f42.google.com (mail-lf1-f42.google.com [209.85.167.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B702415B971
	for <netdev@vger.kernel.org>; Sun,  8 Dec 2024 15:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733673170; cv=none; b=kGCQQgIu4j6nwqvLF4rMn+A0r14IjsG303kTP6kriyZvnOQmp9ASa96lxhQqP1fw2VtpnQC/ZkoNtjienv2di3XeYae/EL1SAdExNn1i9mcjL3AdMqOMlv1fvilNiKusbABKDIkvOGU2iZu3h6juf8Akh6SuMNbNRy9pb1AGb/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733673170; c=relaxed/simple;
	bh=RWCtaYm/JVslyITM0sBPkX8+GSKakwBGh/MBx/cs9wU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Zw4j/QCYVwnc/8qAXAONQY3B/JApN04pFWPhgq329ADldmo+Xi1e9paZUplZuWZpeLPi2NA1tdwVqJ8HgpK9zKUEmrhvHZbGeL9YMBhtawXInmcbQFv4+rMDtdh6hNqk2TCznP7mWlvrlyJThBQhM/rYhvb5PDcxU9HvMwL85IE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=Yp5OhfG+; arc=none smtp.client-ip=209.85.167.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-53e3a90336eso1258410e87.3
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 07:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733673165; x=1734277965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZQxkVzK7EnNsOjYzKhrnJfnqM/CbI5Zj781Mc6uR9Vc=;
        b=Yp5OhfG+J9JKgunbNkXmnc13IO1iI1fkc+BxXTEkaXSfmRtjqzhRoinzRW7GUMExKG
         pTfSm6S5bppsl/ryi0REEUKPzZ4wcQrGQ9wb30ATElqKTtKZkpqdBUwBTEvU4YF0mTHB
         FAjLq+yfrc4YDyEzYgLUidQToRb684WbbOnd4rBkIrkosa3/KPrn2BimLwTS5ZQAaH/O
         XDs8CSeWhsAM8Qz3ucDh3H3BRjK7cOjxRzU2H3onNjZe4pQRuGDtaijRa3sfpKS7PWRj
         rpW3kuvC6nRwS36AOGT7OVooEtQ4NMeHoql4EMJxFRz0YCUG6w17Njidc4YIoSYliHZI
         c4Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733673165; x=1734277965;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZQxkVzK7EnNsOjYzKhrnJfnqM/CbI5Zj781Mc6uR9Vc=;
        b=jwJanlTfCevhXbNek+c+L9FZO4OSmVylKWRJeAMxzGThRkfpLuZfhVBaQRAsW3dgYL
         g2UhJ8K/+mQsQBem3alSzScGuXHIU0bpL/CsrTq161wAb5QT1iVub9em1LVee3GeqZab
         dUs91zeeOsm0LSU21dJsyo+f5ReEdp9+2BjmTznFLT60XqLLPN+XQmv9AqrBBqgN0Bje
         7uS96UZgFoEfLOqDuuQnJ9x3rC5TsVriclsrz7Hw1tgzMmEltVQlpJmPyBV9HqktVa+G
         s9BFSm/VNpQQU4mSEyO+JjWBtK2pi+VYr8K6A12WhaPDPq7ZLeFGNNGufmmOJ4O+nQBa
         SyxQ==
X-Gm-Message-State: AOJu0YwvLAIzlH7AOKDoxVDa/V0xOhxGdKCwmeQ+/AH/ePofVg7pMyX/
	10TxN6SdIkYJHLZ6cIwK+0Fdh7l9nn7u+MWpbAmh7PpMH4Xhf1uQeFi79vZIHpQ=
X-Gm-Gg: ASbGnct2Yc1N0COSSEbH+zrQ4dMQbfDjATQgiXW6io54eIqizEK9oi32dS3udaEhKpP
	WkssAKWxfN0S9sAPi+fl2XVZeUDvB3iuvSGWqHgjdg0iM8aiRKaKvP4Mcs1MYgrSIkSKM5pgl2F
	wi80L/T1OsG5uvfz9/m9tGid9qxSUpyGu18ZWJOyj0QOPLCHalxgFhZMihAuQ8/KMyMS7kUGgU9
	kfCU25eh4mxYhyVxqJIZbsvdtkY+kJh6FEy5PsQsJE0dp1W2ZZ2xiZhoSo/WdHQ
X-Google-Smtp-Source: AGHT+IFN0e6LLKXo0Wdi3CnElwzhg/3WaQvnNCfHh7dkeACryOt6FCzNDEV9CQMLSH98javWI++cxQ==
X-Received: by 2002:a05:6512:3092:b0:540:1d58:da72 with SMTP id 2adb3069b0e04-5401d58db83mr536069e87.4.1733673165577;
        Sun, 08 Dec 2024 07:52:45 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53e3a1ce70bsm580882e87.66.2024.12.08.07.52.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 07:52:45 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
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
Subject: [PATCH net-next 2/4] net: renesas: rswitch: align mdio C45 operations with datasheet
Date: Sun,  8 Dec 2024 20:52:34 +0500
Message-Id: <20241208155236.108582-3-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
References: <20241208155236.108582-1-nikita.yoush@cogentembedded.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Per rswitch datasheet, software can know that mdio operation completed
either by polling MPSM.PSME bit, or via interrupt.

Instead, the driver currently polls for interrupt status bit. Although
this still provides correct result, it requires additional register
operations to clean the interrupt status bits, and generally looks wrong.

Fix it to poll MPSM.PSME bit, as the datasheet suggests.

Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 57d0f992f9a5..120d56754692 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1177,32 +1177,26 @@ static int rswitch_etha_set_access(struct rswitch_etha *etha, bool read,
 	if (devad == 0xffffffff)
 		return -ENODEV;
 
-	writel(MMIS1_CLEAR_FLAGS, etha->addr + MMIS1);
-
 	val = MPSM_PSME | MPSM_MFF_C45;
 	iowrite32((regad << 16) | (devad << 8) | (phyad << 3) | val, etha->addr + MPSM);
 
-	ret = rswitch_reg_wait(etha->addr, MMIS1, MMIS1_PAACS, MMIS1_PAACS);
+	ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 	if (ret)
 		return ret;
 
-	rswitch_modify(etha->addr, MMIS1, MMIS1_PAACS, MMIS1_PAACS);
-
 	if (read) {
 		writel((pop << 13) | (devad << 8) | (phyad << 3) | val, etha->addr + MPSM);
 
-		ret = rswitch_reg_wait(etha->addr, MMIS1, MMIS1_PRACS, MMIS1_PRACS);
+		ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 		if (ret)
 			return ret;
 
 		ret = (ioread32(etha->addr + MPSM) & MPSM_PRD_MASK) >> 16;
-
-		rswitch_modify(etha->addr, MMIS1, MMIS1_PRACS, MMIS1_PRACS);
 	} else {
 		iowrite32((data << 16) | (pop << 13) | (devad << 8) | (phyad << 3) | val,
 			  etha->addr + MPSM);
 
-		ret = rswitch_reg_wait(etha->addr, MMIS1, MMIS1_PWACS, MMIS1_PWACS);
+		ret = rswitch_reg_wait(etha->addr, MPSM, MPSM_PSME, 0);
 	}
 
 	return ret;
-- 
2.39.5


