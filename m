Return-Path: <netdev+bounces-76891-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0403486F467
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 11:29:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 36C81282805
	for <lists+netdev@lfdr.de>; Sun,  3 Mar 2024 10:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBB8CF9CD;
	Sun,  3 Mar 2024 10:29:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecGhRoFG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08DF0C8DD
	for <netdev@vger.kernel.org>; Sun,  3 Mar 2024 10:29:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709461743; cv=none; b=S/iRSbfp6NNrY8kB+NfD/Nq5uPLRSXNQ9y8dojoGYcQUillwtUVZsYEcF5DTjxq720IZPjN4CSD7DaBv2kLqcbupyH/Yt/r999/FPuLxSJPCh7P1cuejmGh/ytBuXBbJ1Il0FSoTaKDAFJPadxgOiNhSwtneh81Cf4UjXpdrI4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709461743; c=relaxed/simple;
	bh=NADieCLHvmauHdvFGOZwK01kjEzmX8uhgvaitQEwXrE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Xd/oV5aAuF+mGlsSv4FBgOkb1vBnav5zu9wnlFcQk4LoYie7Gv6X/qen787p/wLU0JnC+5nHJQK5StZQT8ymaPBBuMoJ6BhGXdknCXDsJxR07dKSvNTEQnaUKcfIX3Q0zmkRZKzESULmOkL2vTc06HQx1vGczJsqG0V3D+2exRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecGhRoFG; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a293f2280c7so646310366b.1
        for <netdev@vger.kernel.org>; Sun, 03 Mar 2024 02:29:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709461740; x=1710066540; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mOHO6PaXxHrQBiZKIQI4cHnyJKRPwWtRkmhgTbnZV7w=;
        b=ecGhRoFGb9O4zERbw/LJGUuueQKq0+fb8jBT1mStnvZk32Lt4bXA1MUK6ACX27PLWf
         TWgeR4vG4jJ3ziND958blfMkyZYQEY77UkOd0wd+kSK2h/ys4aXG0Ch5pkxBuWNCrVb+
         Ys/3gz0iVLJC9KeHd3zbTnexSxtZlXdsXBPb1oofbPqXHO3N7NZr/4hLEDFLgMt5IkRS
         82p2CXDsyO2zrzSlcGmellhTTQ6ezGgPCTGT4jkyitwRKxb7BbGAEfjhzN8V1qMo8nbD
         HrDCbsIaWL4ir25NXegJb2K2XGM+vP/4qcFu0uLPf288uztEVOtCxVWQuTY9kxqyIDbv
         rrjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709461740; x=1710066540;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mOHO6PaXxHrQBiZKIQI4cHnyJKRPwWtRkmhgTbnZV7w=;
        b=eH7NGQzGsTDvrEsxMxpBJvNboUYIL0V2Yrk9eJNSijJ0forYxTQRovKFdAwtSz/v1W
         iBPAnZNDAe5TCnjzp7V7iX2nRJN57hb/+gjtZuCV+irU+L1y1DZO5zGSviKZE7bVTqF3
         x3fjgf8d6NXuEPH5+9tXnTqrONOTPxoqafRyNr+O4dwD2EhvmXdEQcIwzhINklBQMBj4
         Ph7/09bPzymAT13H5gup480DxpimVJDLrFJVkkGIPLyqdqIgBir1JWtg85V+8QzRcftN
         zQ/lVrI609F52UGzmRFOQLfZCiVbJuH9ZkiCa7L2rZopes0rTT43yYH9FiJihSE4hJ2R
         1aWQ==
X-Gm-Message-State: AOJu0Yz4oWxIRMbmUhtEtggj50LMX5880XUVSqiBM1796edqKbk4gz2A
	MSDvaqg5GXcbO0MoaSxhOpf+XL2ZAFFmF4f+qfy4XwMRIWbh4QsF
X-Google-Smtp-Source: AGHT+IFcbKdHIOBpWau7pzB2f/XxSNUhyzCa9N4pVZqypnnx55rT8YlV7prnF5DUwAlglbYgf351EA==
X-Received: by 2002:a17:906:4558:b0:a43:9857:8112 with SMTP id s24-20020a170906455800b00a4398578112mr4654140ejq.20.1709461740403;
        Sun, 03 Mar 2024 02:29:00 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id um9-20020a170906cf8900b00a44d01aff81sm1530759ejb.97.2024.03.03.02.28.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Mar 2024 02:29:00 -0800 (PST)
From: Eric Woudstra <ericwouds@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	"Frank Wunderlich" <frank-w@public-files.de>,
	Daniel Golle <daniel@makrotopia.org>
Cc: netdev@vger.kernel.org,
	Eric Woudstra <ericwouds@gmail.com>
Subject: [PATCH v2 net-next 6/7] net: sfp: Fixup for OEM SFP-2.5G-T module
Date: Sun,  3 Mar 2024 11:28:47 +0100
Message-ID: <20240303102848.164108-7-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240303102848.164108-1-ericwouds@gmail.com>
References: <20240303102848.164108-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Change from quirk to fixup for the OEM SFP-2.5G-T module.

Implementing this fixup, the rtl8221b phy is attached and the quirk is no
longer used.

The module is re-branded to different brands, the one I have that applies
to this patch is branded LuLeey.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/sfp.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/sfp.c b/drivers/net/phy/sfp.c
index f75c9eb3958e..191a6d5dc925 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,6 +385,13 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
+// For 2.5GBASE-T short-reach modules
+static void sfp_fixup_oem_2_5gbaset(struct sfp *sfp)
+{
+	sfp_fixup_rollball(sfp);
+	sfp->id.base.extended_cc = SFF8024_ECC_2_5GBASE_T;
+}
+
 static void sfp_fixup_fs_10gt(struct sfp *sfp)
 {
 	sfp_fixup_10gbaset_30m(sfp);
@@ -503,7 +510,7 @@ static const struct sfp_quirk sfp_quirks[] = {
 	SFP_QUIRK_F("Walsun", "HXSX-ATRI-1", sfp_fixup_fs_10gt),
 
 	SFP_QUIRK_F("OEM", "SFP-10G-T", sfp_fixup_rollball_cc),
-	SFP_QUIRK_M("OEM", "SFP-2.5G-T", sfp_quirk_oem_2_5g),
+	SFP_QUIRK_F("OEM", "SFP-2.5G-T", sfp_fixup_oem_2_5gbaset),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
-- 
2.42.1


