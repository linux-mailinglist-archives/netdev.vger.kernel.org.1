Return-Path: <netdev+bounces-85985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EC9CC89D30D
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 09:31:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEFF32831FB
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 07:31:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5057B7E112;
	Tue,  9 Apr 2024 07:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNWvqDEE"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BCEB7E0E9
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 07:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712647832; cv=none; b=f1fdCtSqNp/t0VpA65uH0kwX4O8020CIIT+jjQQGf7zPe9mf/+/7ICUxO6pY4NdxWjP5UNiCGsHQUHtO9LHzMu7a9BtiBK+3VFKHGSs30Q6LN+xSUo/k1SEAdMVu1/91zPhTAbrlYWnYebGI6vg0Dbhcam2fF04Y65TmgGOdkec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712647832; c=relaxed/simple;
	bh=GngB600xY5hfqgfmZBmIjGlASFh2xiuAmDjoCxb9TB4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz7oe5jn+dFmwMv16wQNxrT3fBA8MW3BXIOibbIwgORF48XtkrjT4YmBHP7D7Kg5/sYDtCuAdppeZ3LrK8OR898MQ9cPM2ffb36a+YtKfHWxB/moCQ90wGuB1K+/Eueq5xCrO2Cb3tIVoZgCsfqtmE2HFKQ0zdbXf/m99SWG+jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNWvqDEE; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a51969e780eso638050866b.3
        for <netdev@vger.kernel.org>; Tue, 09 Apr 2024 00:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712647829; x=1713252629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uQx9pZpqUKcaSj5KJw0x3/f5LiaORM0IdemqNK5rHwU=;
        b=eNWvqDEEBuP8qxSZymXyMTrgjSvVp3kH/e57gezSF9oPKvoY6MD9sVkAaN5479TvFw
         wvAaCahJ0q4WRVhymnP7EMkkK9i2TgfLP/2kXT3tVV2WUmqQYFkccv53GXRNYvr1x7db
         K0qm69zhz/Lh5IkbnAHmjzwgjI+m7qdww9idz93JCJpyqxTuL+Jw+zmqHaPSXbgaPwD0
         oDSELZEyKCnazXEINuimIsJ7df21WRBpuuGC4W+cGahJjD/eTmhAKwCKTutI/3rc52DB
         ZngGY80iwZpkp06Rwfw+ag+c3DgDblarZy9FVtpBtOmFoO8YsxQNqsKYh7thh8lLNhaY
         vy0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712647829; x=1713252629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=uQx9pZpqUKcaSj5KJw0x3/f5LiaORM0IdemqNK5rHwU=;
        b=adOB9cUMUKyrFGOH0nHVqUtIqQNCbvTKBeE73u8SeHBG9AY3iXNVzWiF/QwRfE3duO
         BlN9MeZGTCO9F44hcgMoBAzmnPjs2QpTScmRrIcfXy7XERu93zf4v2ZOJ7L3IdfqjqLm
         1s1xgHTcOmzai2eCvQ9yQ9IcWcZyueFEtheq5pxyeNjdUz1MPi0h/r0OIGcLIP0CyPJi
         wXDqpXjA3LMN6EhlsHchTbEQwIRmsw0JA16OuSlJ9wROCpTXyydM09DMCeGWO6TdC6Xg
         R1KtElPj2hP6xF5xXqUEld+lfpums3h7p+rVBAt5MwWJVoVwLy3kjNntcOQO9bmUqeqv
         Cyow==
X-Gm-Message-State: AOJu0YwWS0vfa3xRmlTQGnomz02BuMluJAAtrxIQ6KCFhpG5LGQh2TqB
	tPjRSm4BjuLQTkelbJjlTd945WEQda1CwjJ2QjUhmI/5x3GI2D5I
X-Google-Smtp-Source: AGHT+IHgLM4cWNg+ObY3d/CCSOHeInIJcaDzr/1exsaJQZ6Y6C6WQNAEzBAzWrofBzF1KsKHrgk+pw==
X-Received: by 2002:a17:906:36da:b0:a51:f463:cfa6 with SMTP id b26-20020a17090636da00b00a51f463cfa6mr792335ejc.29.1712647828654;
        Tue, 09 Apr 2024 00:30:28 -0700 (PDT)
Received: from corebook.localdomain (2001-1c00-020d-1300-1b1c-4449-176a-89ea.cable.dynamic.v6.ziggo.nl. [2001:1c00:20d:1300:1b1c:4449:176a:89ea])
        by smtp.gmail.com with ESMTPSA id j25-20020a1709066dd900b00a473362062fsm5315694ejt.220.2024.04.09.00.30.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Apr 2024 00:30:28 -0700 (PDT)
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
Subject: [PATCH v4 net-next 5/6] net: phy: realtek: add rtl822x_c45_get_features() to set supported port
Date: Tue,  9 Apr 2024 09:30:15 +0200
Message-ID: <20240409073016.367771-6-ericwouds@gmail.com>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20240409073016.367771-1-ericwouds@gmail.com>
References: <20240409073016.367771-1-ericwouds@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Sets ETHTOOL_LINK_MODE_TP_BIT in phydev->supported.

Signed-off-by: Eric Woudstra <ericwouds@gmail.com>
---
 drivers/net/phy/realtek.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 901c6f7b04c2..7ab41f95dae5 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -843,6 +843,14 @@ static int rtl822xb_read_status(struct phy_device *phydev)
 	return 0;
 }
 
+static int rtl822x_c45_get_features(struct phy_device *phydev)
+{
+	linkmode_set_bit(ETHTOOL_LINK_MODE_TP_BIT,
+			 phydev->supported);
+
+	return genphy_c45_pma_read_abilities(phydev);
+}
+
 static int rtl822x_c45_config_aneg(struct phy_device *phydev)
 {
 	bool changed = false;
@@ -1272,6 +1280,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VB-CG 2.5Gbps PHY (C45)",
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822xb_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
@@ -1293,6 +1302,7 @@ static struct phy_driver realtek_drvs[] = {
 		.name           = "RTL8221B-VN-CG 2.5Gbps PHY (C45)",
 		.config_init    = rtl822xb_config_init,
 		.get_rate_matching = rtl822xb_get_rate_matching,
+		.get_features   = rtl822x_c45_get_features,
 		.config_aneg    = rtl822x_c45_config_aneg,
 		.read_status    = rtl822xb_c45_read_status,
 		.suspend        = genphy_c45_pma_suspend,
-- 
2.42.1


