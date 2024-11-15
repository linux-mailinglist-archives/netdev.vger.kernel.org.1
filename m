Return-Path: <netdev+bounces-145224-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B00079CDBF6
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 10:56:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68A871F2323E
	for <lists+netdev@lfdr.de>; Fri, 15 Nov 2024 09:56:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D47193084;
	Fri, 15 Nov 2024 09:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="uB4rMB9Q"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D0C192D8B;
	Fri, 15 Nov 2024 09:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731664575; cv=none; b=rgu55ghQeiTt60fnoFEF8mk4PqzCF7olQ08zWz6tODcLZF6ppcjOmU6b5g2ZkE3+1m8a2tsic0D7iDjSoUhMT1RKKE/sWVXeXA0tOCRR0LuT2LUuslFrNawGa8ETTp+dwReB1/YXR/QYNJEIwtrHCzkZh8SFpkzYBisoy/etgpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731664575; c=relaxed/simple;
	bh=iNEkoZdxO96vD4vM5hSViTE1pWccSIWCSA1SLIHKBbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RsHP4JsrFp6PXZtdzwg5cnoN7aFplxY4EIh5RT2ONG7GGbjDdSFlozcHa/DEF8t1r3nnlwgjiQk9cagRRSgG+wUWcc+YX++AQUYnxCUePkNHJQCcyc6kgComfwMI25zblf/NTxOH6vJkJM9C6AEmcIySXQRLh2ZpvK4Ozu/iUoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=uB4rMB9Q; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AF9twzvF290974, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731664558; bh=iNEkoZdxO96vD4vM5hSViTE1pWccSIWCSA1SLIHKBbw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=uB4rMB9QsmSVCBTB72AKrQY/iBhyffjhdwcIJDVu32zFrIU6cA3Em7EJGvQu/f0er
	 AR4Ic7MCBeqkPwk7nVIK+Ar0dERysLHDKziZb3BC/x/lLYBAydofleBpzpssYp+nJN
	 FUtluGNt61JisgwANY76XaRatplyw+0dscYNPl61F0C/sKhtnXEzyxmDafKRCr/TjK
	 I3KHqs50PPJmRti2JFmXICeFdQhQ9PfYLDN+MuTItzMC0yHKox6Wi+zGO3wo6P+TBa
	 j03MnxoUn21SlGpvqhHdmO+ubgPU+Dwn2A9KX49FSocLsLQHzBAV5F2anBrqo+a+6U
	 lBjHhsQSvgYWw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AF9twzvF290974
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Nov 2024 17:55:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 15 Nov 2024 17:55:58 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 15 Nov
 2024 17:55:57 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net v2 4/5] rtase: Corrects error handling of the rtase_check_mac_version_valid()
Date: Fri, 15 Nov 2024 17:54:28 +0800
Message-ID: <20241115095429.399029-5-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241115095429.399029-1-justinlai0215@realtek.com>
References: <20241115095429.399029-1-justinlai0215@realtek.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

Corrects error handling of the rtase_check_mac_version_valid().

Fixes: a36e9f5cfe9e ("rtase: Add support for a pci table in this module")
Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 22389911a7d4..91ad19e80f67 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2124,6 +2124,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		dev_err(&pdev->dev,
 			"unknown chip version: 0x%08x, contact rtase maintainers (see MAINTAINERS file)\n",
 			tp->hw_ver);
+		goto err_out_release_board;
 	}
 
 	rtase_init_software_variable(pdev, tp);
@@ -2198,6 +2199,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		netif_napi_del(&ivec->napi);
 	}
 
+err_out_release_board:
 	rtase_release_board(pdev, dev, ioaddr);
 
 	return ret;
-- 
2.34.1


