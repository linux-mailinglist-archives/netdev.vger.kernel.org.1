Return-Path: <netdev+bounces-109398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 524769284DD
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 11:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF7FE1F21F70
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 09:13:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 158CF14601D;
	Fri,  5 Jul 2024 09:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TO72eB/2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA666145B21
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 09:12:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720170778; cv=none; b=gXL3cisoewcoGtbm5mYK9w9gkG342Ef9TwCOCO2RVqxB8a40ot8+7o/+o0eLkgucQi8930ZEZQe/Ec6H7jD5PwhXEmagrdQDH6ZCOP9kBapENcH+8Lq/cmtTbmoTDiKHiGQPr/fQIStI7hpD0XYZ8mMD9C6qqrttuyuV27AwrGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720170778; c=relaxed/simple;
	bh=Eg0ZC4E+9HjgLT96m4ApciWRyd7GnlXW287wuigi1+s=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=UouS8iGEoGYcKFzJvqAY5HYwtBLge6WAuE3GR2HXo5n01+7jbH6BebLdiUjgCBtOXTs1+lh/9pOfLXGYDfZ46J4sQMtd+xg922l5wqOcgd2wjTXTCQXANVyOPhxQOEfe8BNcDYNgW6oDLnlRxZbB+A6nTAnfIWTVNtkhEj5qc+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TO72eB/2; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-1fb0d88fdc8so6856635ad.2
        for <netdev@vger.kernel.org>; Fri, 05 Jul 2024 02:12:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720170776; x=1720775576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=R2z2N0FIhvVT7Pm142enyggu6yTxiTfmHspIFBG8Nh0=;
        b=TO72eB/26KVLj1R1edpoaZR1MlQBS0IM3O3aOkY7MkwvT49liWj83pgQ6qtl3GY64B
         muv4f5dGiO9HNL4PyF4jZz6rX5P8i84tBr+9G2L6x84cVxMVA7dPMMsewJ05k6DHTVQr
         zl/7OqjSBBOjrZ8723BJXEjyQX2oWMitIVaaNRnmWd/Q6dsjdAsuesB2P+vZF3Mgr4dr
         UXbptcR5grs0M4WeV7l+zOEynuC5yxr+mI88U4DtMzey2Iiz1RzDBnAPgK34O/xjem87
         aIku1eYsV4ptMjSteErIieshC0HCV0kXTfBkv1ZbYmvWmPllAHPpGOw2Sey2Q4pNoszt
         Qnfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720170776; x=1720775576;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R2z2N0FIhvVT7Pm142enyggu6yTxiTfmHspIFBG8Nh0=;
        b=f8m7DPaKdnM8lutCdBTdifkKilRVHlXDegpw2yhL6CanoePhv1iizNK7CbxSsG+oXv
         8dR4LJ6o4jAAD/aKIAiGl04YKHK+KD2hmsiBS5/rI0y7qT3EvgOidk789En+SCwQWKE1
         UPtHw0HxYUAqjycDF1Yk2mLuuro7QRgAwlYe8Pqz54Q3VKUVZoicbtbBZVH0xZ7DYbqv
         02ti/oa032pPsX0BAOgRCRF7wv6gpD2ZghWCGw6yazzI97pmDu87nG+iqUpfCnqMqo8W
         /ihLKckjtYT2Uq5+CLiUHyzOqEysWA1onHuM5bupEwvsV8zLTKJosuhkCiajhAgwZ+rL
         5yGw==
X-Gm-Message-State: AOJu0YzZYMkHO1XhPgltbkVUMOxRlnAbfWrr3CczKILxlSbwFOn6Rlmi
	K6Vhpn2+v+zY7uQTcLlm6bXBGcw20LP5GWbAUiEY80XB7fDgF6DoAHtHL7N2Fmg=
X-Google-Smtp-Source: AGHT+IFm2/8yR5AFtpPuhbktBPmgCO4mvQK681Sb+GSmk+4HdpVgj6Ixh37vrtXb8ZAMyhkyujbuMw==
X-Received: by 2002:a17:902:c94f:b0:1fa:b511:5d44 with SMTP id d9443c01a7336-1fb33edfe7bmr28620835ad.46.1720170775602;
        Fri, 05 Jul 2024 02:12:55 -0700 (PDT)
Received: from localhost ([2402:7500:487:c5af:fb81:3659:f2a:922])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fb48dc7220sm10306415ad.145.2024.07.05.02.12.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jul 2024 02:12:55 -0700 (PDT)
From: wojackbb@gmail.com
To: netdev@vger.kernel.org
Cc: chandrashekar.devegowda@intel.com,
	chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	m.chetan.kumar@linux.intel.com,
	ricardo.martinez@linux.intel.com,
	loic.poulain@linaro.org,
	ryazanov.s.a@gmail.com,
	johannes@sipsolutions.net,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jackbb_wu <wojackbb@gmail.com>
Subject: [PATCH] [PATCH net] net: wwan: t7xx: add support for Dell DW5933e
Date: Fri,  5 Jul 2024 17:12:23 +0800
Message-Id: <20240705091223.653749-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: jackbb_wu <wojackbb@gmail.com>

add support for Dell DW5933e (0x14c0, 0x4d75)

Signed-off-by: jackbb_wu <wojackbb@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..7f3d0f51c350 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -852,6 +852,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id t7xx_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x4d75) },
+	{ PCI_DEVICE(0x14c0, 0x4d75) },//Dell DW5933e
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
-- 
2.34.1


