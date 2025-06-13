Return-Path: <netdev+bounces-197573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4215AD9393
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 19:12:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8734E1E4D0B
	for <lists+netdev@lfdr.de>; Fri, 13 Jun 2025 17:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A017222596;
	Fri, 13 Jun 2025 17:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b9hzUne/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6C412222BB
	for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 17:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749834750; cv=none; b=fl7Kb3WiXWZTflHzMyrgl44yLaEyzFAg8wm53/lJPxM5TUIJzQ8hOFQiGL8JYJnHTiXim35bMTipKy7QeLXmZ2UwPj/rV8Yzv7VNLSVQ9OEJOoWbXnxUbIG6zBOlnzI9ADelrcvVvr4Nb2OX1yWfhp1B3kz+E7qRfA95XgJtzPI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749834750; c=relaxed/simple;
	bh=IQtNptGG8oTh7qKX+hv/hVuyP+Ali7iAkX26hbgIWH0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=exsuwsTKNdICEc/m+wOlVZFSBrOgshZ1HBahEk5AU6YfM347h+SpOkYvnXXXeROZdXh30uZNecviOYmLkuJ19RmNlaxKPZy3wQDWUBXp8ycSiS610DTT5NJnNr+GkpqGKPi1YuAInnqn52sBDH6AsicvtoNXi8yalxsJAW+nkGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b9hzUne/; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2eacb421554so429044fac.1
        for <netdev@vger.kernel.org>; Fri, 13 Jun 2025 10:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749834747; x=1750439547; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8f02TCjx45QWguf0ghPJxBhFO8vPqb57r8rzy98Mxp0=;
        b=b9hzUne/kRIunzKFJFemsMKhkJrgn50PvV3bCHrzdQCoWRch4toIy14cqQXm2t46/E
         pFJ7z3Fv+v9KV99FfZ+Ip5gYesZ+cjUDlkD09/A3X0UsQyWK5y0Etn7j/CNB/whF4QWV
         h6Z2Xs52WX2djI+cGtNf7imqgpjqL+6EheFBwIb/Npody2FWEEMCwR+E8NtYT8gfitD4
         yPsfC7dIOwKnuP2BXog9fM0/3Db1SrsRT3elToeZ3OnKHS/E+SO/DPYREOrR1EUz5N35
         ZbZZmpDftNKHf7jazVxX75oAHwDLacW4sJeKWn1m+tT2pVI2LqP/BcV8U8vIFEh0P8tk
         uqWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749834747; x=1750439547;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8f02TCjx45QWguf0ghPJxBhFO8vPqb57r8rzy98Mxp0=;
        b=LPHML41fsZAff0O2L94acSzLusaz9jTO9FAQFPQpPMlkltKr1I9Wf/dWxFiqFO/vhA
         ruEn9MUKGjdi0ZqFdoWweCsuXAoFaRiwiAAQmZhiok9WFnIRP2gNu5z4eL8F2AprSOey
         cVS15A4gAMyLTEC/nq4rP9CBMpVlxQ+hVzIFvGTv3vq3fUJasuVWjwnQ/p9k6d7lbTaj
         T/vbc9EIB/qeyrkHpkKCr9BJccHnaYGQZTi9axDw2N5Sxlv//oZ9KDLpyNkv9TbMubhl
         DZtV6FoAlm9/BT9Tz1N1i4mA3WGFujS3gQ4Ffpj8DcMJjU50baUgl3WPoTcNi5wXjXHZ
         ZtyA==
X-Gm-Message-State: AOJu0YxzZJSrARbFKpN4rXY83gXB7vbP8VZuHKBZOU1JcZGzuO0lyG09
	ZjrFM2dsfxMUqLdTqCGdCjFkKLhNYhTGuYmztkFPJOBq3vPTbtWgSiumVgoXwA==
X-Gm-Gg: ASbGncuuR7ol5tDnLlaKh9EbP29FM+HzuzJHXgjudKUpwVGULr4AUFlW7GxNp/L4JOs
	kRnAIgaWBIBG01J5KK9AJj5ELHSqE8fKgc++h24zF6gMk8mUHqo4KFcbmScMtRP49IKikwn2Rus
	8v0oWvfh+DE3BxOIsLI7fwKJPBYMtboeMeeXA/wA+YVgXQzvDPyHKF/2P7blu0GGOhXLrOzFREp
	T3M1Vx3GHSwaL2orCXMZSsI2bFLP6+LN7+8MJ6SIWuHh0ok/tYdL9cxTsV2VEuuj1u0BUP6Ah0Y
	GMLzD91z8cI0SplzWNvCk5OK/bKcCNC9Cw1ty46dQ9QvuXlaKSPmrJQfosKKlv8J/P6XIq0cKoq
	j14Heig==
X-Google-Smtp-Source: AGHT+IFQwne912yYVIrX9xSvgf28Fidj26Rp57SZSu8L/KocJ8j5nBgIC9IbsvgAmf9J9BFdDiMcbQ==
X-Received: by 2002:a05:6870:a11a:b0:2d8:957a:5176 with SMTP id 586e51a60fabf-2eaf0464523mr377963fac.5.1749834747381;
        Fri, 13 Jun 2025 10:12:27 -0700 (PDT)
Received: from localhost.localdomain ([2600:1700:fb0:1bc0:3419:8bb3:9d82:416d])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-2eab842907bsm794238fac.0.2025.06.13.10.12.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Jun 2025 10:12:26 -0700 (PDT)
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
Subject: [PATCH v3] net: sfp: add quirk for Potron SFP+ XGSPON ONU Stick
Date: Fri, 13 Jun 2025 12:10:02 -0500
Message-ID: <20250613171002.50749-1-macroalpha82@gmail.com>
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
index 347c1e0e94d9..3829ff32e829 100644
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
+	sfp_fixup_ignore_hw(sfp, (SFP_F_TX_FAULT | SFP_F_LOS));
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
+	sfp_fixup_ignore_hw(sfp, (SFP_F_TX_FAULT | SFP_F_LOS));
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


