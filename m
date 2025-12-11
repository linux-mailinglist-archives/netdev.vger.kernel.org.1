Return-Path: <netdev+bounces-244338-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 22399CB5159
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 09:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1BD9C300A1DA
	for <lists+netdev@lfdr.de>; Thu, 11 Dec 2025 08:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BD5D2957C2;
	Thu, 11 Dec 2025 08:13:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NlfLN/PI"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C274E946A
	for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 08:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765440812; cv=none; b=NTaZr01wkd2+1dfoepGKpqKQvejW0hOL/5owP4AdcWDjTciWt8qMqAhhg12T0zFBIhmYIiudbZmeYD7bl0m1oRAt8xGpOnb9C6aqPmzrwla6+n0u1yFK1q+fz5b4ZFCLUg6+fPsQUQcRH6IkGb7XENa+d3SZXns3y9Utm1j4tw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765440812; c=relaxed/simple;
	bh=CRdQskgW/O6U/RpBs/bh42YAt536V9Rswk+rIj7pjMU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=belaczfBUTo6095QPR0zDGLF5lf7YylQ/9VJOxrb9DawkrnAItOBXMeWUpQfH6IZRd+klE8zYGovJI+QZgJo3uOyCY5BAV0XxM2qV2jqHahs0MfphjlcrMaaf63OtznH7JLTQidxHLHj97PMfaG60cmA0yu2SP7nMKcF1ytGfLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NlfLN/PI; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-298144fb9bcso7121705ad.0
        for <netdev@vger.kernel.org>; Thu, 11 Dec 2025 00:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765440810; x=1766045610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=trUfnuuHzLWg0hqtTbFZbrBapbqubE16vGf51eAqUyI=;
        b=NlfLN/PInJl3l93OXCX/IrY6gg8tW2yrkeDFDYQ75GGNEGfhf61rtrqglE0t7tFr/e
         OkRBc1lkaFE/q2IGYbP16CwLYiWAc95IffbvIR5pvYBNGr+48ZTc4koCbVgnJnK89tQu
         DjF++058N2d8Kpl9FIUiKbdGbWk10xK21EjG2IW09EoEDOLvRe+isNwC6Z3OFx0wpjSv
         JfoRwjY84Wy8BgUw1rSiqshv8fqS2o77QYG77MbusJsreJx8lPfpYvcXZkfOi+2WtQ20
         YUJEaYXHwCPfMUxQ64JozbC+B2SnYg9jlKbjOQ5051BV8k+HQ/gg4nxWkhLi3nlQhgGB
         hlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765440810; x=1766045610;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=trUfnuuHzLWg0hqtTbFZbrBapbqubE16vGf51eAqUyI=;
        b=mvWiWdOTTZ4ls3D03BFL4QrTQHnu8Fhwr6gIm65ZGx2eZZfW5Ucox62hA/HR3nc/Sm
         SJZ+xAdi9/kfKfd3BK0ZlP9yiMhEcdtiEVSo7iifrXVzuf8QA/SORfl8s2kJjT9kFJB6
         i8cQiXz7/U2RTXLFrWY4j3cpkfepR2DAx95Uvk8spa/tQUDdPOYEKcR8Doeub2eALe/j
         NWJuTuVRCYmy8gZIK+lmkVgjcJj4PI2Eq877GcQIrpr4EzBxonAzjjtZXeUdChBPwnyx
         MSNpYdEqWXPd+FPAVSwW9p9rJlXlIq25oya/Rg6WEBQXqEBTGOyMRIU8Fv/p6l9zypqx
         WZkg==
X-Forwarded-Encrypted: i=1; AJvYcCWJ6gS0wfCq1RHecI9z8TF+dK4PDoUaC4N1gUQL2azpEcQIPfzlFyjg/+zg1fi249QvvwmUkO0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg/KOA3TL1peG1omXWR3j4u1+7LvHPBBuFIO5esqKs8EToV/9i
	6xIrVqtXHV3J+HdeAEHQ8GajpDiERDbUPHdOxPXMrks9Kel4qDmh0HTF
X-Gm-Gg: AY/fxX7RYdHf56yjCo2oh4hynpZPDjH6H8TwuVnEe4JzDKtFZqEWk/YBkrgdTKmRPo0
	rh8UjXbA1u11XpuMyQIQR5W0GoF5zpThXXeO/lMEGkEkaKSGLVx1Ht+aoHQ3sMUslkK1iVzQ/VQ
	aCyQWJZX8KgU+qSQkVTfaynq9XNJ0F/u2MIeFL06Zx5Ka9K3rKPCB0IBxsd7gCAfPvUdydwJQvW
	GuL0DDTQESqBNnKQaQv4jp/j060822yJ0xrIAISl5gCmq7emXY9fxU/1vjbE80dyzU1ZnWopG1M
	kprtoSHmWWyr+RvvgGqiR7Bw6g6Nnco2Z2ITGdn2a5KXMKjnSKt7L3UYts4Qji0AoxGisufnZ8l
	5IYiOvKQmW3XS3BP3uDc9vazEfMEIJw/zDXmaiiy3go7mbhozNdQd853beuYnPjO4AZGbJXDTEX
	Ew5p+Sj62N
X-Google-Smtp-Source: AGHT+IGpU0Pf7s9UlmMW8EGY8yYMuomHFnlX0/Df9bPI6JMt8uShHZ+gMWWhZpAR4wob/58V/qG9Zw==
X-Received: by 2002:a17:903:2c7:b0:295:6a69:4ad5 with SMTP id d9443c01a7336-29ec2803d18mr60221255ad.56.1765440810038;
        Thu, 11 Dec 2025 00:13:30 -0800 (PST)
Received: from c45b92c47440.. ([202.120.234.58])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29eea04036bsm16048855ad.78.2025.12.11.00.13.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Dec 2025 00:13:29 -0800 (PST)
From: Miaoqian Lin <linmq006@gmail.com>
To: Daniel Golle <daniel@makrotopia.org>,
	Qingfang Deng <dqfext@gmail.com>,
	SkyLake Huang <SkyLake.Huang@mediatek.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] net: phy: mediatek: fix nvmem cell reference leak in mt798x_phy_calibration
Date: Thu, 11 Dec 2025 12:13:13 +0400
Message-Id: <20251211081313.2368460-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When nvmem_cell_read() fails in mt798x_phy_calibration(), the function
returns without calling nvmem_cell_put(), leaking the cell reference.

Move nvmem_cell_put() right after nvmem_cell_read() to ensure the cell
reference is always released regardless of the read result.

Found via static analysis and code review.

Fixes: 98c485eaf509 ("net: phy: add driver for MediaTek SoC built-in GE PHYs")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/net/phy/mediatek/mtk-ge-soc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/phy/mediatek/mtk-ge-soc.c b/drivers/net/phy/mediatek/mtk-ge-soc.c
index cd09fbf92ef2..2c4bbc236202 100644
--- a/drivers/net/phy/mediatek/mtk-ge-soc.c
+++ b/drivers/net/phy/mediatek/mtk-ge-soc.c
@@ -1167,9 +1167,9 @@ static int mt798x_phy_calibration(struct phy_device *phydev)
 	}
 
 	buf = (u32 *)nvmem_cell_read(cell, &len);
+	nvmem_cell_put(cell);
 	if (IS_ERR(buf))
 		return PTR_ERR(buf);
-	nvmem_cell_put(cell);
 
 	if (!buf[0] || !buf[1] || !buf[2] || !buf[3] || len < 4 * sizeof(u32)) {
 		phydev_err(phydev, "invalid efuse data\n");
-- 
2.25.1


