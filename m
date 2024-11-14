Return-Path: <netdev+bounces-144845-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A79B09C88DA
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 12:26:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F2A64B29F14
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 11:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06181F9420;
	Thu, 14 Nov 2024 11:15:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="XwvhQ5HC"
X-Original-To: netdev@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4E851F9430;
	Thu, 14 Nov 2024 11:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731582931; cv=none; b=byqyJwYAktSOq4Pk/i/xnyiKN+imzJ2CRW5Dj/ddeJFlxVcwLgzU/rkezz7rtUHiPHfNo1Z9FSgeCuYKoRFhGFz4Uo9r5I/i4s8xZNX53kBkEmxEKufERx6q1Hhbz9+efFHkCGEfQz9YxyyBq2kzD5ozlHT1ndV86gA3abBbmLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731582931; c=relaxed/simple;
	bh=59ogwsUR/nMWX9lDNlOM0W/OBKVEjU293ZcZdF6p6lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UBYt6elpvRhiEBW9lUXjHyNKKclRswoIxtfpW4yIMFsRpqlPzJ+dmHQk07Wsvu9p4IDhoZO9gSFLRte1D4pP6c9obBHLpOCKVL3vrV6Usn8PdctxeBCB4OyeDTMu30dycD487WqVmglaPbxidIHgL1nQyHIRJ9ufzKWWb687jrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=XwvhQ5HC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AEBF9fL42903552, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731582909; bh=59ogwsUR/nMWX9lDNlOM0W/OBKVEjU293ZcZdF6p6lw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=XwvhQ5HCLlA1CW2C8W/Qvzf7rW4agSAuCd5OGnO7dTKSfrHvELbI4C851l6OCFxd/
	 65cYmFa5HcyyRTxLh27EZwfsqzqT/Kk8y7I5LnM8E/zx4/D9hePAK8UnNr1409QJgB
	 jXsjIRJJcSzymvTu73YntsXfSojrFFIlquB1D7OXv7Odj2+koMvvFHseoDd9d1XvZU
	 P5Yd9UTP3kxAXjqVYb2zH7XqSBXgnFMwimi/LcY9YeTceoTtzhslbjLmfbkQpC4ZWJ
	 oWnyxxrOwsuVwtAx2RhJ61Xqjy5DepfwO/V5iXF3oZc0jdLwnsY7icv2HE/1SNf2Wn
	 w/68AAWNgfssQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AEBF9fL42903552
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 14 Nov 2024 19:15:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 14 Nov 2024 19:15:09 +0800
Received: from RTDOMAIN (172.21.210.74) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 14 Nov
 2024 19:15:09 +0800
From: Justin Lai <justinlai0215@realtek.com>
To: <kuba@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
        <andrew+netdev@lunn.ch>, <linux-kernel@vger.kernel.org>,
        <netdev@vger.kernel.org>, <horms@kernel.org>, <pkshih@realtek.com>,
        <larry.chiu@realtek.com>, Justin Lai <justinlai0215@realtek.com>
Subject: [PATCH net 1/4] rtase: Refactor the rtase_check_mac_version_valid() function
Date: Thu, 14 Nov 2024 19:14:40 +0800
Message-ID: <20241114111443.375649-2-justinlai0215@realtek.com>
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

1. Sets tp->hw_ver.
2. Changes the return type from bool to int.

Signed-off-by: Justin Lai <justinlai0215@realtek.com>
---
 drivers/net/ethernet/realtek/rtase/rtase.h    |  2 ++
 .../net/ethernet/realtek/rtase/rtase_main.c   | 21 +++++++++++--------
 2 files changed, 14 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/realtek/rtase/rtase.h b/drivers/net/ethernet/realtek/rtase/rtase.h
index 583c33930f88..547c71937b01 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase.h
+++ b/drivers/net/ethernet/realtek/rtase/rtase.h
@@ -327,6 +327,8 @@ struct rtase_private {
 	u16 int_nums;
 	u16 tx_int_mit;
 	u16 rx_int_mit;
+
+	u32 hw_ver;
 };
 
 #define RTASE_LSO_64K 64000
diff --git a/drivers/net/ethernet/realtek/rtase/rtase_main.c b/drivers/net/ethernet/realtek/rtase/rtase_main.c
index f8777b7663d3..33808afd588d 100644
--- a/drivers/net/ethernet/realtek/rtase/rtase_main.c
+++ b/drivers/net/ethernet/realtek/rtase/rtase_main.c
@@ -1972,20 +1972,21 @@ static void rtase_init_software_variable(struct pci_dev *pdev,
 	tp->dev->max_mtu = RTASE_MAX_JUMBO_SIZE;
 }
 
-static bool rtase_check_mac_version_valid(struct rtase_private *tp)
+static int rtase_check_mac_version_valid(struct rtase_private *tp)
 {
-	u32 hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
-	bool known_ver = false;
+	int ret = -ENODEV;
 
-	switch (hw_ver) {
+	tp->hw_ver = rtase_r32(tp, RTASE_TX_CONFIG_0) & RTASE_HW_VER_MASK;
+
+	switch (tp->hw_ver) {
 	case 0x00800000:
 	case 0x04000000:
 	case 0x04800000:
-		known_ver = true;
+		ret = 0;
 		break;
 	}
 
-	return known_ver;
+	return ret;
 }
 
 static int rtase_init_board(struct pci_dev *pdev, struct net_device **dev_out,
@@ -2105,9 +2106,11 @@ static int rtase_init_one(struct pci_dev *pdev,
 	tp->pdev = pdev;
 
 	/* identify chip attached to board */
-	if (!rtase_check_mac_version_valid(tp))
-		return dev_err_probe(&pdev->dev, -ENODEV,
-				     "unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	ret = rtase_check_mac_version_valid(tp);
+	if (ret != 0) {
+		dev_err(&pdev->dev,
+			"unknown chip version, contact rtase maintainers (see MAINTAINERS file)\n");
+	}
 
 	rtase_init_software_variable(pdev, tp);
 	rtase_init_hardware(tp);
-- 
2.34.1


