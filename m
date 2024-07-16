Return-Path: <netdev+bounces-111651-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41E00931EFE
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 04:49:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EC0F02813FF
	for <lists+netdev@lfdr.de>; Tue, 16 Jul 2024 02:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D31336AC0;
	Tue, 16 Jul 2024 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nsVIk3I6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A90D17BAF
	for <netdev@vger.kernel.org>; Tue, 16 Jul 2024 02:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721098162; cv=none; b=OZ0KYg9axXkQoWszC4sGbaFjcsn+m95UUEQUACho3Uo4qcWlQjfuu9sxyGzUE2B/1oaqKlBT6OwV3Ke46rAR9qNaRClXvRCrS2bveNW6DpS/LzJQF3RYktZs3GcSRapnfl7vfY/fCpadQXdDYwULQyigalmixxWG6x9JgHJaFGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721098162; c=relaxed/simple;
	bh=D5xmb7PyIcSPj66edI9owo+MndntFQuu8kNpgT2Yfxs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gzEtbdmrw3v3/G0fAlcCD48GduidZoaHe7CCz7PzMAGzqYh+00ARjdoOlmnAevnKuwgxLbUvp8IF1C6U+4ez6oAkygLUHqGmroFdVmDdWQ3wKd5zb7AQJGPydsWqW0CoH/fLbnNTo5AIjZ+0bAQPP+9co/cBWrzZITH3lZDou0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nsVIk3I6; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-38713b03039so18744945ab.0
        for <netdev@vger.kernel.org>; Mon, 15 Jul 2024 19:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721098160; x=1721702960; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=POQeuwFqxPs3c9WInVyLeovx7yI2dSQuf14N8K8wNFs=;
        b=nsVIk3I6GCtYpINYb0tgfYtM7faVd71zycOkMj3eJ8mF4V+AXvxmis6WRGjw7QfLEi
         fWBguLCB2CoIo31HkY7472KxW6gUuxcaC2KIEoPrvF7045K2cJzxx0VTz7IuLtZLLXhg
         mBC7AR6XL0LULfrPUlhNN/cA3oQL74bYyLwi4mudIghqKwAWq3LQXjONuvgbPky3Gpfm
         uO55VDObmNIAmZraDO9cb2SESJQPSXCRaCx7jMxMuM+ooyhH/tgu7HwscscLid7xuanv
         2sOTyHLCPBeTrqsObcsVYtGmDlr8e1TfBqBUKyAgv6QEQdIdec58zN/lRPvHo2+U0yJN
         q/GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721098160; x=1721702960;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=POQeuwFqxPs3c9WInVyLeovx7yI2dSQuf14N8K8wNFs=;
        b=bgg4fK92qjHA8OhSxMl6j3bvKFqLR+X8p7qxq48LjymMpSFPj8kz7/KfziNgkHSGrw
         XwuXekWJTuaxIer6anB8QILVtoaHs/DqwJut3dYLC1IeWCyTqeFPkCvfW4XSm2rg/mxr
         5Za5iUVduhP4sAEoZaBeBbYpwKslEeEi8LUlUxhcFLKCkHGhOBNj+VkodSIfqYoL64vW
         mWoHyElsddbn8NgYh2vCPdYyQynVyoEXT2hRkfFwlE5t93doZ91W8PyTB+Es9I9y7Voo
         AuWZMiwUWvEEESB6hikNC+CH4xGKnnFr0Rxp0UDLomNixfXqp/u1VZtAcdsvzS/VeXlv
         wdJg==
X-Gm-Message-State: AOJu0YzqYhVKLkEn23EGi3mN8+Ab/KG67Y2V2HU6Q9XjetIf6BrJK6bJ
	C+z6lpETiOPBf18chl19TZnNBoyD+iU1Z4+7Q4K67ikDIJBfgq9npSpOlNwei3g=
X-Google-Smtp-Source: AGHT+IEjyb2mtrY+P1BKzg6tpcnIJiYfWOfgztUKFB9E4H8vnox3uKWlhBvsBEdFsXQlUyfoLpunmw==
X-Received: by 2002:a05:6e02:1c49:b0:383:71d5:347 with SMTP id e9e14a558f8ab-393d0e2461bmr12484475ab.6.1721098160143;
        Mon, 15 Jul 2024 19:49:20 -0700 (PDT)
Received: from localhost ([2402:7500:577:906:e634:edb:c059:7bd2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-70b7ecc948asm5092078b3a.197.2024.07.15.19.49.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jul 2024 19:49:19 -0700 (PDT)
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
	linux-arm-kernel@lists.infradead.org,
	angelogioacchino.delregno@collabora.com,
	linux-mediatek@lists.infradead.org,
	matthias.bgg@gmail.com,
	Jack Wu <wojackbb@gmail.com>
Subject: [PATCH] [net,v3] net: wwan: t7xx: add support for Dell DW5933e
Date: Tue, 16 Jul 2024 10:49:02 +0800
Message-Id: <20240716024902.16054-1-wojackbb@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Wu <wojackbb@gmail.com>

add support for Dell DW5933e (0x14c0, 0x4d75)

Signed-off-by: Jack Wu <wojackbb@gmail.com>
---
 drivers/net/wwan/t7xx/t7xx_pci.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/wwan/t7xx/t7xx_pci.c b/drivers/net/wwan/t7xx/t7xx_pci.c
index e0b1e7a616ca..10a8c1080b10 100644
--- a/drivers/net/wwan/t7xx/t7xx_pci.c
+++ b/drivers/net/wwan/t7xx/t7xx_pci.c
@@ -852,6 +852,7 @@ static void t7xx_pci_remove(struct pci_dev *pdev)
 
 static const struct pci_device_id t7xx_pci_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x4d75) },
+	{ PCI_DEVICE(0x14c0, 0x4d75) }, // Dell DW5933e
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, t7xx_pci_table);
-- 
2.34.1


