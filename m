Return-Path: <netdev+bounces-195350-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E755ACFB3F
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 04:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCA2A18975A9
	for <lists+netdev@lfdr.de>; Fri,  6 Jun 2025 02:24:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6B971D5AC6;
	Fri,  6 Jun 2025 02:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FbaRxCqo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oi1-f180.google.com (mail-oi1-f180.google.com [209.85.167.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0802A17548
	for <netdev@vger.kernel.org>; Fri,  6 Jun 2025 02:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749176668; cv=none; b=lRZAS8njYIuGU+g8UhQ0gh7unShbmemgzNXyJFxNlKO/8aXZWoQkeEfYvctWFdtbZAFXtd/LeiYX/gK51qZmf7GhYXyRJIPNS4xXR2uZA2k4JCbqZb22gmD2J/cEYUfApliQKgw9Ziu1zIZNwltQAK3AcSmUedcFCyfuMyFQP9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749176668; c=relaxed/simple;
	bh=3osgMJ75cTjUs9AXJIyhi7j0c7lWSEZ2U2fFD7KbH9I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YYZnk42+zcx6EVbVdYt9lvm7q4XffA8iHcFUGbiW+2fxfyOAFzNj3f5/RIpRVmaWOouhiatgdy08PwdHBPN5ALvdRaKVsrM+wx2kJTf0mClSjRePgGpkI6g0NGe8pAQCsCt4ATF8ssk3fIXzcbpMznk1eXp8yH6fAJItPHxRAss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FbaRxCqo; arc=none smtp.client-ip=209.85.167.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f180.google.com with SMTP id 5614622812f47-407a3913049so981953b6e.2
        for <netdev@vger.kernel.org>; Thu, 05 Jun 2025 19:24:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749176666; x=1749781466; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LlGXWEUQVIDy1ejGC7NLM0C8ptRsfsrNUJ/C3SvYAZ0=;
        b=FbaRxCqoPxFccmB/RLhbAgZ81TKhqd3lDyPDb6BRCS60+5p8nna0Moquty9zZP3WOd
         lEkZgaJSZ3hqoM91kSgtefXJrC3vpzQ83imKhp037DsyWDHfInHDp4L18UnOS0xF03ba
         +oYFYUSweU2Nv0e3MHuQyIb6owxOixki+QTIZA3RnivnzGUfKHLSQspMZsdugkCMzmQl
         yKbITLvV3kUk3GnpxPlXR2Ha4Cd1h+MQXRU29a/QHXhHrDh/c5/5m66/RfMCi+N2LU2P
         p7EkF9r8GIGsPo28IRHlzlOhYxMk7iNcJx7gRSEbxTSStTtHeBRxUFLZAfV4fSQ1dCF5
         Xwcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749176666; x=1749781466;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LlGXWEUQVIDy1ejGC7NLM0C8ptRsfsrNUJ/C3SvYAZ0=;
        b=QrOrUWFm4NBVv5UEaHZcp4M0sKzOVb0tXig7tg6E9YwZWNFqSkt/o6sOTzS41/cFMk
         WatodZwiRX8gc45am4QR8kVG/nQ+WpCUczjNf/2CDHBgOUO6a4OiIAyH1g4GT6dCl2cQ
         h7UJeI4hGIRG6CX40jN+DFInbCdCjTlKDfyRmTlKoCVgulNzOfREtUq9Gr92JD4lFEtS
         zE6wC/gHLYIH0QgPQG++i2MqCW1TLlU869l5R3UPgZ6W++nkkCQR/yUQzZOQ7+LXVUkQ
         W5LP7fHH3jqwHK/EdcZthjhS/VzPH35qqFibLMovwCdxx6TXn3bzsncJ+Ki0pEJPQXFn
         ADBQ==
X-Gm-Message-State: AOJu0YxhaL0m88HL87Gk8cS+22uaey6CuL8q52BOVUtYqokZmf3DeMLM
	V2eHPyzobwwYBnKHxSp2KEZ+GPHV9q5Dzy9M/jgZCwtgjfPSy3ZeDQ+tFcqcNQ==
X-Gm-Gg: ASbGncuj2z9765a7dgO+r2Dxrh+qDyHjnoQnysYvgIzbCpr44TP0cutwnnFjIpTORk8
	YbYOxwy2BXPcqWFqhDM3JsM2mfTaUtpmjm4QTJkXdgtce3Mc3/PVH5k6EQCH0msMTe7bdzSM5Xd
	poMhyYF6QmK51QkVXUGyst0HZHA3CMcYc07s7Qak913Hr5LTWlJNT1k0zIRXUX5BwoEQOKUKpQe
	jDeCroCB8ZOqhlnQeTvHtD0F0Z+ywFBecNLvA7GpNySaeXGLfNgivcn/3TsGV4MyoFIgO96UA61
	usuBoqB+kFBO8VRH196PP/lxLuhqwQVuf95y0YQM8dwUka/JacP8u8mEjfdZgKAhx1aNogQvKZ9
	R6DqxwQ==
X-Google-Smtp-Source: AGHT+IG2aoAd3w8qWDrJoBhEayfj9TIj6kjKlsLBNVTaQZIRW0kTYpBM+MamELnGczqDDSQEIP53JA==
X-Received: by 2002:a05:6808:3192:b0:403:3502:80f0 with SMTP id 5614622812f47-40905245469mr1496360b6e.24.1749176665851;
        Thu, 05 Jun 2025 19:24:25 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bcf:c121:baa8:78d3:f2cf])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-73889f2d20bsm137391a34.4.2025.06.05.19.24.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Jun 2025 19:24:25 -0700 (PDT)
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
Subject: [PATCH V2] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Date: Thu,  5 Jun 2025 21:22:03 -0500
Message-ID: <20250606022203.479864-1-macroalpha82@gmail.com>
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

Changes since V1:
 - Call sfp_fixup_ignore_tx_fault() and sfp_fixup_ignore_los() instead
   of setting the state_hw_mask.

---
 drivers/net/phy/sfp.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index 347c1e0e94d9..a7fee449fa92 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -412,6 +412,19 @@ static void sfp_fixup_halny_gsfp(struct sfp *sfp)
 	sfp->state_hw_mask &= ~(SFP_F_TX_FAULT | SFP_F_LOS);
 }
 
+static void sfp_fixup_potron(struct sfp *sfp)
+{
+	/*
+	 * The TX_FAULT and LOS pins on this device are used for serial
+	 * communication, so ignore them. Additionally, provide extra
+	 * time for this device to fully start up.
+	 */
+
+	sfp_fixup_long_startup(sfp);
+	sfp_fixup_ignore_tx_fault(sfp);
+	sfp_fixup_ignore_los(sfp);
+}
+
 static void sfp_fixup_rollball_cc(struct sfp *sfp)
 {
 	sfp_fixup_rollball(sfp);
@@ -512,6 +525,8 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRC-1", sfp_fixup_fs_10gt),
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
+	SFP_QUIRK_F("YV", "SFP+ONU-XGSPON", sfp_fixup_potron),
+
 	// OEM SFP-GE-T is a 1000Base-T module with broken TX_FAULT indicator
 	SFP_QUIRK_F("OEM", "SFP-GE-T", sfp_fixup_ignore_tx_fault),
 
-- 
2.43.0


