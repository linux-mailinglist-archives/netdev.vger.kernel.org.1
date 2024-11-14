Return-Path: <netdev+bounces-144848-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 620A69C8912
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:36:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1FF06B2D205
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:17:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507341F9420;
	Thu, 14 Nov 2024 11:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="t01cljVs"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4358B1F8EE1;
	Thu, 14 Nov 2024 11:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582977; cv=none; b=mhM4Ay4i74SZWig72bZfu/Y/GSWvwEb/bMmHZ0LURXJhIFZiJx24K5ZXpDIVOx/nOLLD8/GaauAWVouI4EtNUCKmkWpy0O5NmrDcURt16F9DyW1FM5anJYFlQRSjmDeb5DYSfuQeTkpo/cdmccmBLKdN8UK+HPiZ7s7UmkmVKGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582977; c=relaxed/simple;
	bh=oO+lZI88A+uACM5J4ckiMLLfEfG09VCXVFJIdYlvEGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MwQJDso1Dfb12bsFLJeAA9MmQKBwvopuvTvCoEarKK2r6lpYsiyeIKo9Nc1JyXBTdtvnIoXXn1o14fOBlPF/IIkHbYAyONyJkh1+nVSTlVtW3HkqVmlfoZvdnprP4m/z4hHOPfyC83dK7lSRBtdNQ5wzE0lOHc+9db6jKO2eZRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=t01cljVs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBG05G02903788, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731582960; bh=oO+lZI88A+uACM5J4ckiMLLfEfG09VCXVFJIdYlvEGY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=t01cljVsqayQbayCQ7Ltvp4oJ9Q6bDR/vBg+b0Bb79aE/KmRhGn/O7xzD59Dqbb71
	 OibMPNDLw9gDGez/xPKAMlNv194PCr/0w/OmuvSDi54eb6NFRHRWyN4D7VZo3a1ZcR
	 VLEiQm4weWwq1J4eA6veL1hipmZGVjTg+dbRjreu0W5mWkWuU+2pmPQpoY1z08jj6G
	 V1PQEad3poO+R4PDkHSR5Pbu+0/4zli7wvrugE1rJb1aTZCFUT9U9dteC8X5wToTcW
	 Y8oIqIP4eSfJS6DbNtQ9fH8RvL45Rd4jAzs1B0SdvsPZ90BL94dmue6i7zYZGJl8h/
	 Oqby4X45drTEA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBG05G02903788
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:16:00 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:16:00 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:16:00 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net 4/4] rtase: Corrects error handling of the rtase_check_mac_version_valid()
Date: Thu, 14 Nov 2024 19:14:43 +0800
Message-ID: <20241114111443.375649-5-justinlai0215@realtek.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241114111443.375649-1-justinlai0215@realtek.com>
References: <20241114111443.375649-1-justinlai0215@realtek.com>
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

Corrects error handling of the rtase_check_mac_version_valid().

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index 958b1543c4af..f503de91c713 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -2123,6 +2123,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 	if (ret != 0) {
 		dev_err(&pdev->dev,
 			"unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+		goto err_out_release_board;
 	}
 
 	rtase_init_software_variable(pdev, tp);
@@ -2197,6 +2198,7 @@ static int rtase_init_one(struct pci_dev *pdev,
 		netif_napi_del(&ivec->napi);
 	}
 
+err_out_release_board:
 	rtase_release_board(pdev, dev, ioaddr);
 
 	return ret;
-- 
2.34.1


