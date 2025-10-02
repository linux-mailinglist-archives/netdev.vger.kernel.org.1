Return-Path: <netdev+bounces-227543-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 48856BB2653
	for <lists+netdev@lfdr.de>; Thu, 02 Oct 2025 04:49:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E6AA73234AB
	for <lists+netdev@lfdr.de>; Thu,  2 Oct 2025 02:49:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8E3E7D098;
	Thu,  2 Oct 2025 02:49:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RX2k/IDB"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 726B129A2
	for <netdev@vger.kernel.org>; Thu,  2 Oct 2025 02:49:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759373349; cv=none; b=KWBHjQ5oWo48UsyrItjnLMxdPNhXol1tSXqY6Oh/v8Wwkstt4lw/wDenoonByCY3z2kNtH278pas+M4Yt8VyOTYyY2r42FuClcNmurtrDIYEoOrQumLS7MG402Em6u0wAg64iqntsDSr9UOwZ90u9f+Kc1E6MO0pxKubZddENh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759373349; c=relaxed/simple;
	bh=Rlm3SRdluo6yATbX4oF9ZqGmVsyUJvCoJRvFMc9x7uE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nW41ywMaZDdYg1P2STvPP39vL+uhWgOyHoRJcUH+2lcPkpg3O5KZjCMw1at88iPPQsXMFTTTBHfUx6S7Y34+Eujk5b9VjBn00S4qNw7/CodBPJ5jTVrxfplB/hjdyIz0NInAHSu7fiRI0K66H20XXJ3aGjBBrkN4L6hnnR+5aGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RX2k/IDB; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-76e6cbb991aso544325b3a.1
        for <netdev@vger.kernel.org>; Wed, 01 Oct 2025 19:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759373346; x=1759978146; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tx+T52VXaGxHIwE5ue3lwEYrArbLgvH+yochMGJeg3w=;
        b=RX2k/IDBFpj7OaiBMMNw2ldViDFkCSCVMLjiRm9ajwCmkjJdz/7W7a0ZEjwKSqktUI
         xn+zO/YTabnn/CAjD+gU36LXyet0alW1Sx1uj5cSQ0zepUpsd7yNNawoDFvhPuzXuCOw
         scCkIPjZa4Vdjb+BGVveCM9EAO01sTRdiyGmlLZGN5QNOS9rpUFKT44a+PYc/qMvEHNH
         LM2D485bez5S7WPnsZiol/R98+9t024VbuTZIvVnLumcyt7JlXHupaUPBXZGkmRFdMBs
         UQvpagS9hbPihMnv9oAKEYaOE6hB6ayfOSA0Ci7Osr5YdlMsCs6rFvhMjb0Mn32Tlcjf
         PAzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759373346; x=1759978146;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tx+T52VXaGxHIwE5ue3lwEYrArbLgvH+yochMGJeg3w=;
        b=BwRD3tTVSS3qnFQVLMo570rJoENNfLMmlTVNxhhL1UZ+Lf2IzA8k+p5y+YjlyhTrvM
         I5tZR2baRDronA+x6ighIoZB3yjmoFlcouu4AQLDob3+4SpvnVwEyqvKSag+uNb9TIwT
         yoU5oeKycdOUk5kI2+9u8sMciyhJpqfy78s2JNu73Rk+0YTTfV/LOdbefmXlwCfZsmKX
         lonBefltdsNh8JTFCeetW7T0foIzM7wdIh6TQU1HKRHr7UCJbDOba9BY3rNIIwqkaVGA
         JmY3jWg8MdOyybP80sSoxJCWFoIgkxtntkbQOebrt1p3XcuYuKMCkBXFxO9ImQFMFs+1
         FLbA==
X-Forwarded-Encrypted: i=1; AJvYcCVN/bFUSvp9SiW9GdqHx+ZRJauR7AfYyS77LMr/8wjzEzccBsiuLEISOPGyoWBCPGCBZlOCe/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgAcP/JOxig6XwsV/A5GvxQJRftvqLC20ccgAXlaBJInEeqynU
	cp1NSopEJn4R8ow91T/cm24LiLKwESWiKHfvGeIaAnn8No4Nw45zittT
X-Gm-Gg: ASbGncuS45zjimSV0J2gZjNF7iURHmdiCEneQQfTpE4w7EqFrjfGr4Wf5Cf4MNUcEGm
	khjQk4aAihCZ5wxqHdDlRv29V+a+Ftb8ywpuDTbGm8Jq1WnH9J43Jo4FHJ50cTv+uW1RvjEdueQ
	55QPAqzf59FUY1fVpqbzJGR565KRv+plh8KdNnxIwcJTFBDC2GdR4KzoXUiE+44xTAR+DuetFvl
	oai726cB7uQIQSmHyYVoYwGvNHARBWDQjQc2e87GJDmrL0gZl9hqRkoOCN09OzRBGP7OtmguXP3
	wt/GwIO/+EIjjWgISlObtP+rBXY78bP6ouWBVWI8fjTw3BVO8dhUmoOKV1YctfbFVo1PCkrvY49
	uJfkJ7ITtlp/49dTDxufdvxGWakps2VbXydhYNJgFmG832jCVMwrBwwAg0BpbUi6d1HyNOzk=
X-Google-Smtp-Source: AGHT+IETH7I1DUb42a6zVBccP/CPta+Puwg/XA6sZLcvnAAu5JdYF0uhLuw9HJFtEs02mk+EPLAu+w==
X-Received: by 2002:a05:6a20:d306:b0:263:3b40:46d4 with SMTP id adf61e73a8af0-321eb7f0ea7mr7236687637.56.1759373345690;
        Wed, 01 Oct 2025 19:49:05 -0700 (PDT)
Received: from u.. (61-222-64-201.hinet-ip.hinet.net. [61.222.64.201])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b6099f72f99sm845643a12.47.2025.10.01.19.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Oct 2025 19:49:05 -0700 (PDT)
From: Sammy Hsu <zelda3121@gmail.com>
X-Google-Original-From: Sammy Hsu <sammy.hsu@wnc.com.tw>
To: chandrashekar.devegowda@intel.com
Cc: chiranjeevi.rapolu@linux.intel.com,
	haijun.liu@mediatek.com,
	ricardo.martinez@linux.intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Sammy Hsu <sammy.hsu@wnc.com.tw>
Subject: [PATCH] net: wwan: t7xx: add support for HP DRMR-H01
Date: Thu,  2 Oct 2025 10:48:41 +0800
Message-ID: <20251002024841.5979-1-sammy.hsu@wnc.com.tw>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

add support for HP DRMR-H01 (0x03f0, 0x09c8)

Signed-off-by: Sammy Hsu <sammy.hsu@wnc.com.tw>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index 8bf63f2dcbbf..00c0161f0c78 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -940,6 +940,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 static const struct pci_device_id t7xx_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x4d75) },
 	{ PCI_DEVICE(0x14c0, 0x4d75) }, // Dell DW5933e
+	{ PCI_DEVICE(0x03f0, 0x09c8) }, // HP DRMR-H01
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
-- 
2.43.0


