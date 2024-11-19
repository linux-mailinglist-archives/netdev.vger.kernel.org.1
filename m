Return-Path: <netdev+bounces-146174-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D559D22E9
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 10:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5776B282E0F
	for <lists+netdev@lfdr.de>; Tue, 19 Nov 2024 09:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACEFF1C175C;
	Tue, 19 Nov 2024 09:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Kh6Lkyhj"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFFE71993B4;
	Tue, 19 Nov 2024 09:59:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732010350; cv=none; b=I1mzRkbu5U4UaeK2+SztLEiX2bvPbk6Gqaa68nj5WDPvMXlolqrhtByAiLel2yavwjDWd3hBXBlaZg6/hVgnzjpaKWqxqr3ujA5S3sxZArF1/JcmwHo8gcMdFPsc8TYa9taZZk4uipHqoXV7OXnBp4ROsIhksCFx0XbLyRtAGaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732010350; c=relaxed/simple;
	bh=8bdC6Bi01ufgEL6GHDaSWYWsoDtMSp5Xfp0U+4Cg+Xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKoa3JHASHpD9G9jlcJPsqkC/qIpq92RSXNob8/rOomOLtTsizenJRxl0rhbXyM7bukluszkmdIJb0SKGN/Wl7Nm8Cr6o4jFVv+k7EIS+RjCUY2QGXJHiPMp3T35IrPukcJsqbo7HS2WzeK0eY/OPqE/GUy2YRKHyIoRCFQvyDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Kh6Lkyhj; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AJ9wqq872265740, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732010332; bh=8bdC6Bi01ufgEL6GHDaSWYWsoDtMSp5Xfp0U+4Cg+Xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=Kh6Lkyhj60i9QYnduMFyTG3ECwLKn4LD69iDqxbNr0YMKPBeelkZPmavI5U0AilWS
	 xDMlf3N2l9DV8oG7wBYqfCaToB14nRybyDrVeNRQ9W1qHQRSLyFVEzSyn+omDluCH8
	 RWI29roDbYfBBOx9a5dyzqneP0wRnj0UjTepTZPv+IFMTOvMeBhG+q0xfPtOn+Ay7M
	 fBkIaSsxwD2dsB5VTfmQ8gWE4fwOsbSEgS37UwaPDOb5R/74B/vhVXpWvLioC9c1TR
	 Aw98aqiTaHb7Bh63HcI8G6xb8+eFEiI2LAKyTUfWONcjZeMTg/9lQCbch5sMhNb4vh
	 Z21V3gK1MXQfA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AJ9wqq872265740
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 19 Nov 2024 17:58:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 19 Nov 2024 17:58:53 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Tue, 19 Nov
 2024 17:58:52 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v4 3/4] rtase: Corrects error handling of the rtase_check_mac_version_valid()
Date: Tue, 19 Nov 2024 17:57:05 +0800
Message-ID: <20241119095706.480752-4-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241119095706.480752-1-justinlai0215@realtek.com>
References: <20241119095706.480752-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36506.realtek.com.tw (172.21.6.27) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Previously, when the hardware version ID was determined to be invalid,
only an error message was printed without any further handling. Therefore,
this patch makes the necessary corrections to address this.

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 5b8012987ea6..26331a2b7b2d 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2122,6 +2122,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
 			tp->hw_ver);
+		goto err_out_release_board;
 	}
 
 	rtase_init_software_variable(pdev, tp);
@@ -2196,6 +2197,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		netif_napi_del(&ivec->napi);
 	}
 
+err_out_release_board:
 	rtase_release_board(pdev, dev, ioaddr);
 
 	return ret;
-- 
2.34.1


