Return-Path: <netdev+bounces-246740-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CD2CF0D37
	for <lists+netdev@lfdr.de>; Sun, 04 Jan 2026 12:19:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A8F9B3000E87
	for <lists+netdev@lfdr.de>; Sun,  4 Jan 2026 11:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CAA9258CCC;
	Sun,  4 Jan 2026 11:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LFvFHx+I"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91ABA20C00C
	for <netdev@vger.kernel.org>; Sun,  4 Jan 2026 11:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767525586; cv=none; b=MpubWmZ6GgIauw/BOb0KslaRZXTwZKwrfE+Ko/1aRUFtB/SwUdMcRUjD/Yu0VdWDImYC4nY1vaGzUOU/9oBhrDCKuV9zU9Utj+LUoiHKSPHiX6N9f0fi8/+L35RAass2lCVNupaXjcn4J0hKajfhMosfu7l+5woAXVlabQvQkws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767525586; c=relaxed/simple;
	bh=yBrqkYj1jnzncmJZwro64AcHNTLTvquv/IKdVLYG8Dc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d06YmIriXX89IDfis3OWILg122M5ItxYGNZECKaDxQ67X86s4wecMiM4x5/OSdTplp6ucVMCckDvXh1BFAZn5DnBFfv2r79mGzloE2pYxyQAxsspj+zchTM262niFgd76t2deD6KvSWWlwqGEQ4y03HlCpOtFOkgaje4NHE08Dk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LFvFHx+I; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-29f2676bb21so184290295ad.0
        for <netdev@vger.kernel.org>; Sun, 04 Jan 2026 03:19:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767525584; x=1768130384; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=557gGaDYszK6QJZXXNva39IMoUKqT6OCm1hcM4MYEI4=;
        b=LFvFHx+Io0DF+VWalgvj8AnE5Zbb/6vzfrnkriS8UkE4p5Ji37lcWFQ5AhQZmNRob/
         AMNrbWQFdQ34q1fYz94Dv7PeV+DHA/CcEkAW5x0e1qPnSkY6I1zzS4XWhJ6C/pNiVICo
         8RzE3CIE9CYbFJuEpDBp+zJSXkttePO21eA5PdHgLAvuDMZp1JLklgNgGZFKCGAqTEU0
         E1CTKbJkEgthCvyPJkzHL0UKVN0Xk1ih6c8CvRhsoqK06Po1lgMEQA8Sk4/bVrzoE7Lx
         Ii4lCosZkGz48Z7SjSP/M1RSferJS/uLYeIjTd6mLACvqZanuR5Oedf3ebpZGZH91wwl
         djZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767525584; x=1768130384;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=557gGaDYszK6QJZXXNva39IMoUKqT6OCm1hcM4MYEI4=;
        b=qpDrJ4mX3xobRRHegyleuw/aNbffyfjElKiaLUDY7UBA6rB2M2efFdb4FX0VVCk5P5
         LbrBlYXFNQGtjRY1zlbYzpA29sioMK40pgGsAwxSy1nBAd8TNhN6u7iLkOgCYhtuLJ2k
         JHp8q69/O9JPXafefBa/uNd5/dVd0ZS4zoqSgtajupE+W9HJBtBvvIDl3paIeUlFC03s
         jrMt+Xy5q9K/W5O11YKGn9YzH4YufYYzVGgBSmRSUFAeeRU+uU7UyA/cDIRzrem+1GlD
         FB9stRawDEp1GvkQ+wgWHKSxB/P4rXQwGPXunz09UkVLt6RlhvvO45EMYxxwYABWk1Gr
         2NIg==
X-Gm-Message-State: AOJu0YxSMUpt16dw1MW3BR4JY8fFtMZC6T7b55Wdvm7s2YbalsJTC5YT
	noMYqRA5TQO7ESRIv1iKy22sfXKK2ojarhiGkCOgzO2ARKpHxLsoRe9M
X-Gm-Gg: AY/fxX44M2fmi+/KQkR01yOh3DU+FJkXnTF4VXSLr/xlO9gJhEdz5ShZhs49CC3h+DP
	GRaZj5wMkQpyTlw2mP8ET4UIufBL4cc4ma/LLYeTUDAzuxW2Be2/9/eMf7zrnW5eiIk+WH7c4Oy
	lGrxAwxFZNuqQr5mq3GEeQhuk6/4S2C3/3IHhlU+mmR2cGv/DKbFCfnqoTl1tnEuReOsvr68U14
	qXTrBsxhLZdSNWDoTe0kxVVnJb42ZIREfKrpeQEu1INVqcjYTpzFQVG5ar5w/6ceIBOD1uM+arz
	9vw7+GGERGpZ+OmVXXG6UwlbomM7CVIJT4w6C7KduwuoAMEig5Bm6PaR9mWFvnpdKuYc3+Qm/Mi
	+veW0Mk6tMsJZUYLKu8Szw2l/pfwmzc8Nij4qSEOy04eedcEt3ShgqBtQLuC0GgvrwqRBDUWinE
	atuTCEOw64
X-Google-Smtp-Source: AGHT+IHRVJEybvq3AyLDdbIXZOJCVDPxlEoUyjmGZKGMx1FXIn8jyOWGH+ZMCKi8vQaSqiPwzL2bbw==
X-Received: by 2002:a17:903:1cd:b0:258:f033:3ff9 with SMTP id d9443c01a7336-2a2f2a4f072mr412570065ad.48.1767525583766;
        Sun, 04 Jan 2026 03:19:43 -0800 (PST)
Received: from mythos-cloud ([61.82.116.93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2a3560ad15dsm281946715ad.86.2026.01.04.03.19.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Jan 2026 03:19:43 -0800 (PST)
From: Yeounsu Moon <yyyynoom@gmail.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Yeounsu Moon <yyyynoom@gmail.com>
Subject: [PATCH net-next] net: dlink: replace printk() with netdev_info() in rio_probe1()
Date: Sun,  4 Jan 2026 20:18:50 +0900
Message-ID: <20260104111849.10790-2-yyyynoom@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Replace rio_probe1() printk(KERN_INFO) messages with netdev_info().

Log rx_timeout on a separate line since netdev_info() prefixes each
message and the multi-line formatting looks broken otherwise.

No functional change intended.

Tested-on: D-Link DGE 550T Rev-A3
Signed-off-by: Yeounsu Moon <yyyynoom@gmail.com>
---
 drivers/net/ethernet/dlink/dl2k.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/dlink/dl2k.c b/drivers/net/ethernet/dlink/dl2k.c
index 846d58c769ea..b2af6399c3e8 100644
--- a/drivers/net/ethernet/dlink/dl2k.c
+++ b/drivers/net/ethernet/dlink/dl2k.c
@@ -279,18 +279,15 @@ rio_probe1 (struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	card_idx++;
 
-	printk (KERN_INFO "%s: %s, %pM, IRQ %d\n",
-		dev->name, np->name, dev->dev_addr, irq);
+	netdev_info(dev, "%s, %pM, IRQ %d", np->name, dev->dev_addr, irq);
 	if (tx_coalesce > 1)
-		printk(KERN_INFO "tx_coalesce:\t%d packets\n",
-				tx_coalesce);
-	if (np->coalesce)
-		printk(KERN_INFO
-		       "rx_coalesce:\t%d packets\n"
-		       "rx_timeout: \t%d ns\n",
-				np->rx_coalesce, np->rx_timeout*640);
+		netdev_info(dev, "tx_coalesce:\t%d packets", tx_coalesce);
+	if (np->coalesce) {
+		netdev_info(dev, "rx_coalesce:\t%d packets", np->rx_coalesce);
+		netdev_info(dev, "rx_timeout: \t%d ns", np->rx_timeout * 640);
+	}
 	if (np->vlan)
-		printk(KERN_INFO "vlan(id):\t%d\n", np->vlan);
+		netdev_info(dev, "vlan(id):\t%d", np->vlan);
 	return 0;
 
 err_out_unmap_rx:
-- 
2.52.0


