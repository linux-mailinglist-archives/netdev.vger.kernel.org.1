Return-Path: <netdev+bounces-75211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDFAB868A3A
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 08:52:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6C2611F2203D
	for <lists+netdev@lfdr.de>; Tue, 27 Feb 2024 07:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F4FA56748;
	Tue, 27 Feb 2024 07:52:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bkLibyer"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6E5F5645A
	for <netdev@vger.kernel.org>; Tue, 27 Feb 2024 07:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709020339; cv=none; b=CdBjY2NJdJFw/TPxGAI6cDGSnYgwRbuG+p0FDArmTIdjNustwT1yjeEIiNg4gqU/q0f32s9Fu4fNOMMKIqHZxM1SBd5Fz+G2U2JEx8VvGcH9fpWdUxhLpmNN4uCbmG7fRsn//I+PnZ4X1y9znNHl9xrFUcbhDPnBKs17BuIDglk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709020339; c=relaxed/simple;
	bh=iNUVONiCgXWIdBbyX3aMxuHW1SaejZ9p096IqdLXhX4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a1MSBDJ30UvN6ocCkZezU1MSEyljGT21a7m71c9jdK1drD/Kuss0KBmtFElqK8e1SvhTYYlLBCH00STyA+GFtASwmcV9wt7/Uui3ust62Dpft2R0Xt8GJ4nkxXzClRmSZiHJ+ZjuwK5TdS0HCrOwHlQCzFDVUyFJ6Ql1+wSrWiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bkLibyer; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a3e706f50beso492513066b.0
        for <netdev@vger.kernel.org>; Mon, 26 Feb 2024 23:52:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709020336; x=1709625136; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AcQFpI+Jx90bvTbBWSDvWvM5mR00vIVjwL1CQlQ/ueQ=;
        b=bkLibyer4b4vJ8XCFKeYkEXYZnAKjsqFXzGLlYrFdH8BABaFlFofcb4KSfODQyHPGk
         I7mIWV1cxwN+nSiUDg2qG1l/qiFP/bTA5zn0pJusGyCsgFa3N//imAAyvVwOF5Zfh5gk
         qwbxcoRfUBiw0tRZ3VoPe80VL1kpZTPtviTGLKhA4WDkCAD6JhUXbGK8brIRYwGTO9iF
         UKG2o7YSoZ0w3/LSWpYAsWqGYoa4kSTob/piLoXEVvHCxgeEoS0Cblr31mt69vf2FVt0
         HD220W5uNS7eJi769MD3YJCO8HXDt9RgATCB42s/woResC4rUhsdJoOsocUfYa3o136f
         N8BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709020336; x=1709625136;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AcQFpI+Jx90bvTbBWSDvWvM5mR00vIVjwL1CQlQ/ueQ=;
        b=ATQtdY2hLZmx7ppK0RnI5F8RuaxFm4o78qqpj7vkqmijZ0wYtUmiuUAbwie9u4o3VY
         bUa/UqDZkO9MvlruNkInDRyxA304c6wQcjW4Av5jcI1Aha1v2P8Z+hQjvPbgiLZcCe+B
         a/qvOCut5lDTys7gZlwCAv270vKtBfuyj2P+Pfwuw+PmlBICbloaBNGMAqx9TUgXiq37
         eJnyU1dKm7J26J2tQYeBFzhrXxJz26vef4w7iaZKODfv0e5qFTgcWnpDzjD5Feky88nq
         UzY3KjnsANpHgqqRKXq4ciZ12wqSiPmDG5Cie+5ux+yUIwipWZGmF3HtAtKimLKe1PNE
         1n9Q==
X-Gm-Message-State: AOJu0YwpT4lEtcwjhd+uN+DRjTBK0Go3jeqMcURzSnWlFRytEMX7i9uN
	awqUelXtBaTGWGTVm3l2OwZeHOz/LSAY36/sWPDSDGXLhHgSr/g7
X-Google-Smtp-Source: AGHT+IFYRiVJrhFvzYS9R5LqIoW+RmlX5z5Xg5r2eYBEJvkaZs1N7v7+ZzxGpNjGUDjR4Fs2IkWT5Q==
X-Received: by 2002:a17:906:565a:b0:a3e:6a25:2603 with SMTP id v26-20020a170906565a00b00a3e6a252603mr6379614ejr.33.1709020336180;
        Mon, 26 Feb 2024 23:52:16 -0800 (PST)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id un6-20020a170907cb8600b00a3f0dbdf106sm496460ejc.105.2024.02.26.23.52.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 23:52:15 -0800 (PST)
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
Subject: [PATCH RFC net-next 5/6] net: phy: sfp: Fixup for OEM SFP-2.5G-T module
Date: Tue, 27 Feb 2024 08:51:50 +0100
Message-ID: <20240227075151.793496-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240227075151.793496-1-ericwouds@gmail.com>
References: <20240227075151.793496-1-ericwouds@gmail.com>
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
index f75c9eb3958e..144feffe09f9 100644
--- a/drivers/net/phy/sfp.c
+++ b/drivers/net/phy/sfp.c
@@ -385,6 +385,13 @@ static void sfp_fixup_rollball(struct sfp *sfp)
 	sfp->phy_t_retry = msecs_to_jiffies(1000);
 }
 
+// For 2.5GBASE-T short-reach modules
+static void sfp_fixup_oem_2_5g(struct sfp *sfp)
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
+	SFP_QUIRK_F("OEM", "SFP-2.5G-T", sfp_fixup_oem_2_5g),
 	SFP_QUIRK_F("OEM", "RTSFP-10", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("OEM", "RTSFP-10G", sfp_fixup_rollball_cc),
 	SFP_QUIRK_F("Turris", "RTSFP-10", sfp_fixup_rollball),
-- 
2.42.1


