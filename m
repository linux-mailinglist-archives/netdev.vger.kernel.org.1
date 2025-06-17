Return-Path: <netdev+bounces-198764-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FE63ADDB24
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 20:06:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2EC4B19421B4
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 18:06:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F77227991E;
	Tue, 17 Jun 2025 18:05:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bVJOm9ed"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC66F2E9ED9
	for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 18:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750183555; cv=none; b=pbNd9vLVrcq0sjkYWkG1/4OIabPBX7uTH9G/HdeP8spwKQU+F1g1Dd93pzZlz7cYg1hc+F/oONafHbq/LShFr63mqLzs8wovuWSQxQCrYUSF+wDkFmez6c9eZR80+Mmjz+5fCD6OXEk7BvG8uZZJWdVpqpcVEYGIKMcvnO8KABk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750183555; c=relaxed/simple;
	bh=h7LPw6HAuuf1bCeJa1RgcpqeqeCQipjupmPiTv7RMOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=old/kGTK1AFRkU8Po4H7CDxvH31iukFfRCwIe4JgITZVSvzgF73ZzaBwhTF8/LO4y4oHnkQoUkCjNm3vIeHW8F08lzwRYMn8DUB1x9e6DsOmt40KafnJmhETrx8gOprJsryWaL+ktDB/PtO8eevdwwkEnAo/CzQVvQ4rsuYTN2Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bVJOm9ed; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-735ac221670so3299240a34.0
        for <netdev@vger.kernel.org>; Tue, 17 Jun 2025 11:05:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750183553; x=1750788353; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=J9eX4yKKsn7UK5SuJXx14EEAvCxdu+2h+1upkUapmAo=;
        b=bVJOm9edqnYZv7HFrTF2Zgp/CRIX1cJVRQ1ziMHnUcZX4+92ngytmNa6g7ce+Nq6YJ
         xLmg04KMwk/+/FPUAt3dsmbI+pLtS9M8Rn4cJ2VaeeDERqdsUt9fI7blPHuuHgx5yjA/
         BpLKW0sWba0n7nBCWybSdp+kbh+lY376BZ8fC3FuyebeKNz/aB2ZwWVnHLPWW+/Hb2CQ
         WYzoWMtJxf/CfAvCZFgGusi7jPokfBcG/ZGNLFGZEV8L4HnP3EvORNMc7fly4mjG4d3G
         hVMrEJ4f8gtGO/8prwQPHLyVEA63uHqaB6Tn+gR0LsxirWP7HBtI2g8llfndTj+ZEtos
         gcnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750183553; x=1750788353;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J9eX4yKKsn7UK5SuJXx14EEAvCxdu+2h+1upkUapmAo=;
        b=aLF4Xp3LS+Ae1LOWqnYzkPsmmhlH66MHGc2eS+awh8hoM4Rg6dbKT/Fqsgqz74Icrh
         1NBwCOPDg/omWlo0Pr1YQEde1FT3Vcfh7lwXEnhRzedJiVwaYqFruj4V0ZKJ03RJLCo7
         CswgXpstoNhodxRCOt2n1A9UXK8u/Iv+eShHW7G/CGnXVLGXe8uoGDTz43jts0r+iEdE
         QnxsxveR38wJ/blgabwfJa9HcStaV503dJqNh6qJ4GOQcOz0N9wrh+Zxf0/b06EkV0JK
         P//Y5SkUIWKzPKSbIXcIXmktX7J4+cl/1FrbdVhLeMVz5Z/m5clMPDo34rQFVfBuD3wD
         hKsQ==
X-Gm-Message-State: AOJu0YynVYH6WWy7tNeyY5L2k64FV3cq60n0fp9uS4plS/RynOAhn1iC
	EFL7yVo/c6SCmemZ1rBQiG2vY2az4cCZw5AEmAil/x02a4peHuHDY4OdDEdjew==
X-Gm-Gg: ASbGncu8+aj2Q8NsOENWYUXct3KYENuIf5MHa/eXGMrPozO2z9gUDN+b/GqPzN6uBmD
	PQZktcBfe7VPEvoh1TcR1YwFCR9evVYBAN5Lnqg8JwINP6aPFaTN5M95oPYQqhM3GWMhl2jB7h9
	MrxubRWompwNVjVBwKMzZk8KZJssV6lTck+VGfhAarTtL6rNah3U693OBPiXbt1jUGyRCpTI7oy
	76tRwx31+7iKyej45Zd8u5vnakkVdHn9fBVCmS75Tv0S67BHUlDBOw/bMJHnKfGwnqKvzCkJ2vf
	x1PDvAKjLD3XVIjsbhy4ly00TzhirVCxpDq3b35CYSaVvkkN6HRlm7hY7EtsoQ7UK3sN5vffMxS
	x+bKElQ==
X-Google-Smtp-Source: AGHT+IG0nsz+Bl72AGaTdQTESqmfkLtO8iAQgXdaDwDrd1QYndP7Yv7BCQbiL2PS+jjMyQzc1Rm7fA==
X-Received: by 2002:a9d:630e:0:b0:735:a61d:5764 with SMTP id 46e09a7af769-73a60a123bamr1665205a34.9.1750183552747;
        Tue, 17 Jun 2025 11:05:52 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:f874:e308:dae5:7d9f])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73a283dc014sm1659906a34.7.2025.06.17.11.05.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Jun 2025 11:05:52 -0700 (PDT)
From: Chris Morgan <macroalpha82@gmail.com>
To: netdev@vger.kernel.org
Cc: linux@armlinux.org.uk,
	andrew@lunn.ch,
	hkallweit1@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	Chris Morgan <macromorgan@hotmail.com>
Subject: [PATCH v4] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Date: Tue, 17 Jun 2025 13:03:24 -0500
Message-ID: <20250617180324.229487-1-macroalpha82@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chris Morgan <macromorgan@hotmail.com>

Add quirk for Potron SFP+ XGSPON ONU Stick (YV SFP+ONT-XGSPON).

This device uses pins 2 and 7 for UART communication, so disable
TX_FAULT and LOS. Additionally as it is an embedded system in an
SFP+ form factor provide it enough time to fully boot before we
attempt to use it.

https://www.potrontec.com/index/index/list/cat_id/2.html#11-83
https://pon.wiki/xgs-pon/ont/potron-technology/x-onu-sfpp/

Signed-off-by: Chris Morgan <macromorgan@hotmail.com>
---
Changes since v3:
 - Removed unnecessary parenthesis.
Changes since v2:
 - Waited until merge window closed (sorry).
 - Only disable hardware LOS and TX_FAULT, as software appears to
   work.
 - Created sfp_fixup_ignore_hw() helper which is used to disable
   specific hardware signals and use said helper with both the
   SFP+ONT-XGSPON stick as well as the existing sfp_fixup_halny_gsfp()
   which performs similar fixups.
---
 drivers/net/phy/sfp.c | 21 ++++++++++++++++++++-
 1 file changed, 20 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 347c1e0e94d9..5347c95d1e77 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -361,6 +361,11 @@ static void sfp_fixup_ignore_tx_fault(struct sfp *sfp)
 	sfp->state_ignore_mask |= SFP_F_TX_FAULT;
 }
 
+static void sfp_fixup_ignore_hw(struct sfp *sfp, unsigned int mask)
+{
+	sfp->state_hw_mask &= ~mask;
+}
+
 static void sfp_fixup_nokia(struct sfp *sfp)
 {
 	sfp_fixup_long_startup(sfp);
@@ -409,7 +414,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	 * these are possibly used for other purposes on this
 	 * module, e.g. a serial port.
 	 */
-	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
+}
+
+static void sfp_fixup_potron(struct sfp *sfp)
+{
+	/*
+	 * The TX_FAULT and LOS pins on this device are used for serial
+	 * communication, so ignore them. Additionally, provide extra
+	 * time for this device to fully start up.
+	 */
+
+	sfp_fixup_long_startup(sfp);
+	sfp_fixup_ignore_hw(sfp, SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
@@ -512,6 +529,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-- 
2.43.0


