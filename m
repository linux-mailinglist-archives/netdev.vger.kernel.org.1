Return-Path: <netdev+bounces-150067-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF499E8CD5
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 09:00:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC1EF164D77
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:00:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D78ED215163;
	Mon,  9 Dec 2024 08:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b="Wg4gUh25"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-f171.google.com (mail-lj1-f171.google.com [209.85.208.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9591821507E
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733731200; cv=none; b=AgUpWYq/b69Bw7zIBKDrQuBWcAm3FCrJG65uqmkZVLXPioO1ukYulL+si6dmqb5bA2U6FfhtcHqckv7YRS9ydSRijq0cW2hnlGC9aSVWP5cznClebO0XS3f96SB0Yw0l5jmvh2PMj/2HTo86ukMdAHmv9Aop36OMCkgItIIXo3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733731200; c=relaxed/simple;
	bh=UsGGTZ2nD/E5yGIXaoCFDWmRL4HG9Qwb6kXnKLoJ/7M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=bbpAeFkwCFFDTWtIOVPsSZgCt9/7h4/RDnjV0uWNUIWRDPVdwfZ5djMo7zAD6+SHr30ce3VPR5IEZ58zQYI5DVSoGvKBDPD7Fm5JL+/sCK6i7PkP9bSbPY1m8BiFv81Me4TqcaAclKcc1bqVbVa9BfYrx6nwiPm1u6QiE8Lfq7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com; spf=pass smtp.mailfrom=cogentembedded.com; dkim=pass (2048-bit key) header.d=cogentembedded-com.20230601.gappssmtp.com header.i=@cogentembedded-com.20230601.gappssmtp.com header.b=Wg4gUh25; arc=none smtp.client-ip=209.85.208.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cogentembedded.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cogentembedded.com
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2f75c56f16aso32715211fa.0
        for <netdev@vger.kernel.org>; Sun, 08 Dec 2024 23:59:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20230601.gappssmtp.com; s=20230601; t=1733731197; x=1734335997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=lyaICWOg29JMNgD4hxKKtD1x7CHdhnKiLgfWSMOBd7Q=;
        b=Wg4gUh25f40I7NOy2JFwLuQTS6bWAAAG899qyUNhT0PzN2U67MGEGoy1+4GveIHhxw
         qbLtb0yN55Li1YThiPGt2rCx3iSBD/+JkmxmBYrC90uLflhAmaO39EN5nCj+OO71P+Fi
         EiBZaTVMbarDWKRS3AFNJOyvj8Zsc+2w2niF9Rg7mGrr0QKJWrrw2zUfnRmAVGV4i3mO
         nHrOOVjArw/LIlLPRkgpUN5DGc476mWjOLUvY/e9Eh/NjOemo0XbQt2mzuVe9+QzIJeD
         wivnak6//zK4DKNb3GUR/34dp6Kysla3aWBFtbVjerlSPMaFoEKj7YCtWrFrjhXOjUw/
         hnUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733731197; x=1734335997;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lyaICWOg29JMNgD4hxKKtD1x7CHdhnKiLgfWSMOBd7Q=;
        b=sfcms0yCuhRagr7Z9gJBhZubUyBWW+eJJPyatYLNuoDAq5F7GGF7tJjQjcaT4NCR+9
         gX8IOFCNSSfLVkKXjg9ubyiRF/2OCS6da43QI6MdbShyVnwCPxz1TsgpeFXlCVgkL6hs
         72rDQOeBXg5g/LB9hg3mdxQ9zZnjagQsP7zU3EP0+hfhTktUZPkwF9eBD9Rxn6Paic63
         LyiJf5SKIIYtCqcQjeeDAhi4K+KXNgjaPFlLQiJ2pylrXcwBZM09wPpIbtWJ/VGIfQrr
         WmtzOjC3dwTPmTRHVxUvCFk7mW8t5DytYXwBaNrlb+zh9larbEQUQIN3zNlS3gPmzXMU
         b4tg==
X-Gm-Message-State: AOJu0Yw9LmT2CTioMbHmEdXrUnx43l1+r3MI7dWRvdhFDND1lPBHn1YY
	hqcGYPpuY3hHnmlryI5p4Nbl1qKW3lanHeVW85v1B6LCbWg/6ko7fl6GNOOKF4h1cmb9zJnsVmq
	D9Ew=
X-Gm-Gg: ASbGncuWmZ18Zg7l/pBSfAX0VpKsAJBNoxLmkKVaYcMPWvSELAn6fqrHqAkVdXKA78p
	X2j3JwmLizNSPPzcEizFjyzBTRJsFx86MtmRcOhDqTNMPwMy8tg31SfZ8Iscxiyn5UKlt/tj7rM
	CtVhV4eaQkxKmEVn7pb6cFPoARtpZRq9+XhdUobgNRDBinDMln2lYk9h74I0JtaBtDCuf+Gv8hl
	7NEmMYRwxSWMGqvsBW+y/amJs04b/tfCtp8O8Ol/2e8D1IfHYUHOfNSmgYs2MCw
X-Google-Smtp-Source: AGHT+IH4yjPZ1ALGBr4+xtqjqm4342HJGSTD7ZfSUlKbMYjDcvCHYG3uzYKEc1m8Irx/IaUkQJYYFA==
X-Received: by 2002:a2e:86da:0:b0:302:2620:ec89 with SMTP id 38308e7fff4ca-3022620ef1dmr4409821fa.19.1733731196698;
        Sun, 08 Dec 2024 23:59:56 -0800 (PST)
Received: from cobook.home ([91.198.101.25])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-300342fc466sm8388761fa.125.2024.12.08.23.59.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Dec 2024 23:59:56 -0800 (PST)
From: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
To: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	Andrew Lunn <andrew@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>
Cc: netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Dege <michael.dege@renesas.com>,
	Christian Mardmoeller <christian.mardmoeller@renesas.com>,
	Dennis Ostermann <dennis.ostermann@renesas.com>,
	Nikita Yushchenko <nikita.yoush@cogentembedded.com>
Subject: [PATCH net] net: renesas: rswitch: fix initial MPIC register setting
Date: Mon,  9 Dec 2024 12:59:51 +0500
Message-Id: <20241209075951.163924-1-nikita.yoush@cogentembedded.com>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

MPIC.PIS must be set per phy interface type.
MPIC.LSC must be set per speed.

Do that strictly per datasheet, instead of hardcoding MPIC.PIS to GMII.

Fixes: 3590918b5d07 ("net: ethernet: renesas: Add support for "Ethernet Switch"")
Signed-off-by: Nikita Yushchenko <nikita.yoush@cogentembedded.com>
---
 drivers/net/ethernet/renesas/rswitch.c | 27 ++++++++++++++++++++------
 drivers/net/ethernet/renesas/rswitch.h | 14 ++++++-------
 2 files changed, 28 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/renesas/rswitch.c b/drivers/net/ethernet/renesas/rswitch.c
index 7f17b9656cc3..6ca5f72193eb 100644
--- a/drivers/net/ethernet/renesas/rswitch.c
+++ b/drivers/net/ethernet/renesas/rswitch.c
@@ -1124,25 +1124,40 @@ static int rswitch_etha_wait_link_verification(struct rswitch_etha *etha)
 
 static void rswitch_rmac_setting(struct rswitch_etha *etha, const u8 *mac)
 {
-	u32 val;
+	u32 pis, lsc;
 
 	rswitch_etha_write_mac_address(etha, mac);
 
+	switch (etha->phy_interface) {
+	case PHY_INTERFACE_MODE_SGMII:
+		pis = MPIC_PIS_GMII;
+		break;
+	case PHY_INTERFACE_MODE_USXGMII:
+	case PHY_INTERFACE_MODE_5GBASER:
+		pis = MPIC_PIS_XGMII;
+		break;
+	default:
+		pis = FIELD_GET(MPIC_PIS, ioread32(etha->addr + MPIC));
+		break;
+	}
+
 	switch (etha->speed) {
 	case 100:
-		val = MPIC_LSC_100M;
+		lsc = MPIC_LSC_100M;
 		break;
 	case 1000:
-		val = MPIC_LSC_1G;
+		lsc = MPIC_LSC_1G;
 		break;
 	case 2500:
-		val = MPIC_LSC_2_5G;
+		lsc = MPIC_LSC_2_5G;
 		break;
 	default:
-		return;
+		lsc = FIELD_GET(MPIC_LSC, ioread32(etha->addr + MPIC));
+		break;
 	}
 
-	iowrite32(MPIC_PIS_GMII | val, etha->addr + MPIC);
+	rswitch_modify(etha->addr, MPIC, MPIC_PIS | MPIC_LSC,
+		       FIELD_PREP(MPIC_PIS, pis) | FIELD_PREP(MPIC_LSC, lsc));
 }
 
 static void rswitch_etha_enable_mii(struct rswitch_etha *etha)
diff --git a/drivers/net/ethernet/renesas/rswitch.h b/drivers/net/ethernet/renesas/rswitch.h
index 741b089c8523..abcf2aac49cd 100644
--- a/drivers/net/ethernet/renesas/rswitch.h
+++ b/drivers/net/ethernet/renesas/rswitch.h
@@ -725,13 +725,13 @@ enum rswitch_etha_mode {
 
 #define EAVCC_VEM_SC_TAG	(0x3 << 16)
 
-#define MPIC_PIS_MII		0x00
-#define MPIC_PIS_GMII		0x02
-#define MPIC_PIS_XGMII		0x04
-#define MPIC_LSC_SHIFT		3
-#define MPIC_LSC_100M		(1 << MPIC_LSC_SHIFT)
-#define MPIC_LSC_1G		(2 << MPIC_LSC_SHIFT)
-#define MPIC_LSC_2_5G		(3 << MPIC_LSC_SHIFT)
+#define MPIC_PIS		GENMASK(2, 0)
+#define MPIC_PIS_GMII		2
+#define MPIC_PIS_XGMII		4
+#define MPIC_LSC		GENMASK(5, 3)
+#define MPIC_LSC_100M		1
+#define MPIC_LSC_1G		2
+#define MPIC_LSC_2_5G		3
 
 #define MPSM_PSME		BIT(0)
 #define MPSM_MFF		BIT(2)
-- 
2.39.5


