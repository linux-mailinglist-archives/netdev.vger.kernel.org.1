Return-Path: <netdev+bounces-202225-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85474AECC59
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 14:01:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A81D73B42A7
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:00:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ABD5132103;
	Sun, 29 Jun 2025 12:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HVQU3up1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AAF8320B;
	Sun, 29 Jun 2025 12:01:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751198468; cv=none; b=P/K4UJuK1SlgB5SeHH2vQTTjK6kCc7U5iuq2O3qiLy3u8j1QWTkdfr8yBJXcqxm+3WIP9nvwAJWnRtLzmN9lwFzzaBk+vp4NNs1TkPfFvJbvIYbGNkddswOI0+e5zafd4QESUbHAIB9EoMGBjPCK3igxjaw8/Z1JFsskUxUMWBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751198468; c=relaxed/simple;
	bh=xTWnCwiFHUcg+AaeKlm6+y0nP5bwGd0f5b6EaHOiD88=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Va4VwfhCcoNwPuvXRu2mnTOGrdFh26b5bFJ4fDLRaADNHfroOeMwNPszLXWGF8D1GEVp3C625FR8y47tSfx7fSrRNNv3zAWy7I3/llkpXJk1bvw039Fc2CNL1WK4HE9k8GX6Bj6bg+0AUD02cp2jOc+jJ8Xa3dGilQrIVqI/W2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HVQU3up1; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-b34a6d0c9a3so1410475a12.3;
        Sun, 29 Jun 2025 05:01:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751198466; x=1751803266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=E1sn6VbvjjR/oI2nWRShk8F3QlCxvBjWaHGE0Fp6CMk=;
        b=HVQU3up1EB30pzAt+Ox5CAHqzbQ/JmKko8GoV/e208f86AaupTiWPnfOp2bOc4TNep
         ksvKVtwud8NTw5nNc+Nwi5+LOPh929w5AYpeTp+Vt9eF375I2QX56aDjv/Muo9E70l8r
         d9LsGVN58LlT/nsKPv3+FoWSKTk+Gdt3hZvZ1zNr8eenOKFJW3zhJVaUsoRKEAvumz1l
         SYT+jNZC0w5xephbA0ia+PXur37VaxZ8/CIqcj1i2RjMlzWy/KqUuXvmWHEtjwTDaolN
         vfg1kfESG3tJegwsKZi7Ita5SZ6ZIIaZMosr/Fh3gmxez/Mmnx+vw9dKmd34362lnzxn
         6Mzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751198466; x=1751803266;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=E1sn6VbvjjR/oI2nWRShk8F3QlCxvBjWaHGE0Fp6CMk=;
        b=WKVvoan+sbagqggMfw3qllKz3vgw6VyE8cYvKBcvozZJhcnEDAzoOA7xfXbnYftvFn
         ZOyANYBL1UGE0OrEbX3NSAJdIfmX4t7gZENQ4vSmWd6j5/xE6bXBk/ljWFCuHXRkzL6A
         kqHfjrgZxju/2lmgcTweIP1t+iQoWIKNxbw88AssOkE6k3P/RpfjSncVuae9Ko4hfsNp
         /OwcxJHdGZuEqo1EwbpIwurybx5krzhUwxpI1hYlso9gorufqKgjFN8llr/8Rp9BpEdQ
         u5LF3HHvqRywD2t3CyWk4zNT+NlYlTgOmu7AzCy3YtVyNU7ksD6UrThk/DT+HZ5X9Q5G
         3kaA==
X-Forwarded-Encrypted: i=1; AJvYcCXfDQ1lTJdsEY1RYx1VauekSq6cVXq/Vi3B7CLHRTcTPduAxgqYi6M83xyOL2h+AQaUowuPp33tGGextGk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyzjOn3PzCZu43PS+SAam8kYXYgftPca6aflLjdj/RuMJMfli9h
	TEMehggB1TKSiRWAUWkdfd9XGG6Oabk7Q2/XAbJi2gayKPV4p7AB7k9+26cw9w==
X-Gm-Gg: ASbGnctOLLoXpL1samdsjtT7mlM0E7DW4wZrp23NQ2tmqA58C6qvYI5yPfYCWwzHRZh
	O1Rh9o7Qj+BTfamjbYRqer+NzXWNB7hN42bmIDEbZ9qF+20YzOupuInuyXJRGvSctzs5m23vr7v
	j7YJXCgondDpSj3WmHv87fL6vb7KVWix5GHxnplNimIJ8gYwaA6K62PI9ZpKCwCxBMZH0u8p0oW
	ZTunS9E5gpWvTq2iaPHe7x/Od7bv2+Lc4BcdUY8e/agOY4t8Pz6pbvvRKJkQWrRpQdMvgJ5xxjU
	s5QrwD4odBbHXOXzZII4YgxQ2/YP42AtvguqxlelXf1Cb21CxWohPVwcwrUh0vQTJq4r0OVDawE
	TMP8n8ebKyl+csZaTOMLO3Ax12mf7w3uB1VuiO2Az3SiW/QVd6hKA2krF+LI/gwe6sLSk
X-Google-Smtp-Source: AGHT+IEw1tpy/lJ8vIdU3FBcw0DG+ETQo7xhE8V8Vq1NG03tbbcabRmg6GYPa7lqJzB/1WQTUW6l3A==
X-Received: by 2002:a05:6a20:729c:b0:1f5:8a1d:3904 with SMTP id adf61e73a8af0-220a113c6d2mr16151574637.7.1751198465840;
        Sun, 29 Jun 2025 05:01:05 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b34e31d842fsm5666139a12.51.2025.06.29.05.01.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Jun 2025 05:01:05 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: linux-clk@vger.kernel.org,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	kuba@kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	daniel@makrotopia.org,
	ericwouds@gmail.com
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	joseph.lin@airoha.com,
	wenshin.chung@airoha.com,
	lucien.jheng@airoha.com,
	albert-al.lee@airoha.com,
	"Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1 net-next PATCH 1/1] net: phy: air_en8811h: Introduce resume/suspend and clk_restore_context to ensure correct CKO settings after network interface reinitialization.
Date: Sun, 29 Jun 2025 19:59:11 +0800
Message-Id: <20250629115911.51392-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the user reinitializes the network interface, the PHY will reinitialize,
and the CKO settings will revert to their initial configuration(be enabled).
To prevent CKO from being re-enabled,
en8811h_clk_restore_context and en8811h_resume were added
to ensure the CKO settings remain correct.

Signed-off-by: Lucien.Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 27 +++++++++++++++++++++++----
 1 file changed, 23 insertions(+), 4 deletions(-)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 57fbd8df9438..94cafda1f535 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -11,6 +11,7 @@
  * Copyright (C) 2023 Airoha Technology Corp.
  */

+#include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/phy.h>
 #include <linux/firmware.h>
@@ -865,11 +866,20 @@ static int en8811h_clk_is_enabled(struct clk_hw *hw)
 	return (pbus_value & EN8811H_CLK_CGM_CKO);
 }

+static void en8811h_clk_restore_context(struct clk_hw *hw)
+{
+	if (!__clk_get_enable_count(hw->clk))
+		en8811h_clk_disable(hw);
+	else
+		en8811h_clk_enable(hw);
+}
+
 static const struct clk_ops en8811h_clk_ops = {
-	.recalc_rate	= en8811h_clk_recalc_rate,
-	.enable		= en8811h_clk_enable,
-	.disable	= en8811h_clk_disable,
-	.is_enabled	= en8811h_clk_is_enabled,
+	.recalc_rate		= en8811h_clk_recalc_rate,
+	.enable			= en8811h_clk_enable,
+	.disable		= en8811h_clk_disable,
+	.is_enabled		= en8811h_clk_is_enabled,
+	.restore_context	= en8811h_clk_restore_context,
 };

 static int en8811h_clk_provider_setup(struct device *dev, struct clk_hw *hw)
@@ -1149,6 +1159,13 @@ static irqreturn_t en8811h_handle_interrupt(struct phy_device *phydev)
 	return IRQ_HANDLED;
 }

+static int en8811h_resume(struct phy_device *phydev)
+{
+	clk_restore_context();
+
+	return genphy_resume(phydev);
+}
+
 static struct phy_driver en8811h_driver[] = {
 {
 	PHY_ID_MATCH_MODEL(EN8811H_PHY_ID),
@@ -1159,6 +1176,8 @@ static struct phy_driver en8811h_driver[] = {
 	.get_rate_matching	= en8811h_get_rate_matching,
 	.config_aneg		= en8811h_config_aneg,
 	.read_status		= en8811h_read_status,
+	.resume			= en8811h_resume,
+	.suspend		= genphy_suspend,
 	.config_intr		= en8811h_clear_intr,
 	.handle_interrupt	= en8811h_handle_interrupt,
 	.led_hw_is_supported	= en8811h_led_hw_is_supported,
--
2.34.1


