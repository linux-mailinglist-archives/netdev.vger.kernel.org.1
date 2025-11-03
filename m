Return-Path: <netdev+bounces-235193-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E3CE0C2D560
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:04:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 188621881801
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:01:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E76731D726;
	Mon,  3 Nov 2025 17:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HRX/cshU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E639F31AF3E
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189215; cv=none; b=Y4BfJMvqUQpzREyOGX9tTy7Frixd/e1FS3qhYsCwUx+hAHWn0TvUCMtnJhmgwCT+EdxJjC1Tk6akh1trlhp2c6DSINf3TmhGNqdP4HBs6OjylvF0S8TAPw9SosLKBaYw79mTxQOFtkkoeOSpGYgbTj1CHuXVWyHJQ8EbLWhjDTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189215; c=relaxed/simple;
	bh=RshgPXp5opwvc+lyJiT7DHVL/AnAssmHB0sB6fauaZA=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=if+Y8PDGvjV6t35Ds918h58a+IN8/Gt5wDtd5bpsr26Cf3NbqCh6oWnEPuLWUXGeemWaDh8/KbLPkixQ2akyI6n9MOzc/3HgOC7eOmYjy5Frq5I2aZYxd49jVtTLYe25GxxY4jgl7a9wM8GUMXNt0B66OWOJP5bcDn/rN0DGjpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HRX/cshU; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-294fb21b068so53252295ad.1
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189213; x=1762794013; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=wP5ncc9Nzdd6on2tHMbtIfRnRAxgLIyZWOyl8IbSfVU=;
        b=HRX/cshURSF/4czWwJI6sjXwO402K3/JLsDem73cC+hJ6peIaO7mrLJgySrkC45UGc
         dk3PI5oKoh9zLVvJmOKIk1/nWHBlOg+M05xBZY3Sg8redIaL7AZXEmr1viTWKlNkpzZg
         JSioirL69kZ0OwVY2vtyeCyG9NSoqY1/v6ZbdEgfPeFSLdlGBbtVEi3YK3wK9UpCjI2u
         6O55Pu7hfSA5n65C2hsBfEKlqRO4WMXIxL3dpAt+LafHGl6B8y2vT5bUeqpGpbOGDBTg
         t4c6dCkM01tf/SBB60mQ+JGhtxiEy2n/gnp5Mj2Ut79LUiyHJwIWkHbZ+ABAbuno1iAm
         pkfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189213; x=1762794013;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=wP5ncc9Nzdd6on2tHMbtIfRnRAxgLIyZWOyl8IbSfVU=;
        b=vxHD8JcFhess83zLaz/iABM5HOgmBzaPe+WdvbyBVe15DEQcMclXHkD/mzJe9VylNY
         F0TmjKxuAREkN0Z6sQC6H5uiIzEdrqP299/ZSU2VMEnzitkZDTNu0zZj2UnmOu5X4s9I
         LqdTA35fc8yKyLqB5dWtWoFpk3NTy4F7YUqtIOwjm/itT7EVj7E6tG+zt019LB2p05fn
         yPX+NvX6rxE2EjQpMpk7VDX229YbrtL1alAhvNtbgs+mPh/CAv9ltARjutD4ALIUjgz5
         vAqJ9P/vpxf4gvSqUWWgncFzt6GwPi+9TdNU7W0SiOE4iUIDaRiiJaPwL9xA+Uwkp03R
         /WBg==
X-Gm-Message-State: AOJu0YxAdEWDF/AUpDKWmQ3UaDhtm8PHr2snKkww0VZUU4hltSnvN3rC
	sQG2DxUAgE5wBCLnnDlsYz7mMRc6xG8SlrC4qik0tcYMaNo9NO9Gtgqt4glIBw==
X-Gm-Gg: ASbGncvqqqCqyaMDtw12DMbD77vGHQkR9oXSEynE+pEzKtxZoITa9HQTPZ5p1qZerJ6
	pYeY+0CjE86XiefO14GPaDsQLzT1/ceK9jwMzEnnbGWJjeed9fSpums7fhjG9Ivb0I84jXJg+i4
	bWvN/tKCm1HNRTkH5XqJ3xop3p1MSpexhKvtoXALoi8VqrwAN+GXZgxIvmAAnT44Fv+M6RCjDYU
	Cz3wJgjjhStU9xUXgSS6P6VNlTexEDAZhIIPUZUkHikhlk4jfbbdh1L4gHOWzIu5fnApRHagEYX
	wGVaHKOYNM/tv8zFZSSb3SuD4w24it4FW3oQtRILbrLhVEvFLA/3JPrPFzV6HVzNRflTbinjNng
	GYk4e/Eci2WYjZDW+vuwT2A5nEh1C/gnDjKQ531p/w3yMKQCOhgIw0by/Tlg4uMg5UvDzx3unq+
	hHCFM6Ig8EuiXMsoo9UsG+oQCW5pFIh8yoztnLghfSuSjzKS82jf+yIC3RaHz/M1y7ar1j/yo=
X-Google-Smtp-Source: AGHT+IH+yZl2FjuJidqQM6bfTuvE9GAJg77AxTWXbwraxKJDsuNtif9QOdEXx7oX7Psp7oiXTXGQPg==
X-Received: by 2002:a17:902:f68f:b0:26a:8171:dafa with SMTP id d9443c01a7336-2951a38be8emr199237595ad.21.1762189212592;
        Mon, 03 Nov 2025 09:00:12 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa (mobile-166-176-187-76.mycingular.net. [166.176.187.76])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-341599419d3sm1675152a91.7.2025.11.03.09.00.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:12 -0800 (PST)
Subject: [net-next PATCH v2 02/11] net: phy: Add support for 25G, 50G,
 and 100G interfaces to xpcs driver
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:08 -0800
Message-ID: 
 <176218920872.2759873.3935936327928788544.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176218882404.2759873.8174527156326754449.stgit@ahduyck-xeon-server.home.arpa>
User-Agent: StGit/1.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

From: Alexander Duyck <alexanderduyck@fb.com>

With this change we are adding support for 25G, 50G, and 100G interface
types to the XPCS driver. This had supposedly been enabled with the
addition of XLGMII but I don't see any capability for configuration there
so I suspect it may need to be refactored in the future.

With this change we can enable the XPCS driver with the selected interface
and it should be able to detect link, speed, and report the link status to
the phylink interface.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/pcs/pcs-xpcs.c |   60 ++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/drivers/net/pcs/pcs-xpcs.c b/drivers/net/pcs/pcs-xpcs.c
index 3d1bd5aac093..f2a6fdb972e7 100644
--- a/drivers/net/pcs/pcs-xpcs.c
+++ b/drivers/net/pcs/pcs-xpcs.c
@@ -37,6 +37,15 @@ static const int xpcs_10gkr_features[] = {
 	__ETHTOOL_LINK_MODE_MASK_NBITS,
 };
 
+static const int xpcs_25gmii_features[] = {
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_25000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_25000baseSR_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
 static const int xpcs_xlgmii_features[] = {
 	ETHTOOL_LINK_MODE_Pause_BIT,
 	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
@@ -67,6 +76,31 @@ static const int xpcs_xlgmii_features[] = {
 	__ETHTOOL_LINK_MODE_MASK_NBITS,
 };
 
+static const int xpcs_50gmii_features[] = {
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseKR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseSR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseCR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseLR_ER_FR_Full_BIT,
+	ETHTOOL_LINK_MODE_50000baseDR_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
+static const int xpcs_100gmii_features[] = {
+	ETHTOOL_LINK_MODE_Pause_BIT,
+	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
+	ETHTOOL_LINK_MODE_100000baseKR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseSR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseCR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseLR2_ER2_FR2_Full_BIT,
+	ETHTOOL_LINK_MODE_100000baseDR2_Full_BIT,
+	__ETHTOOL_LINK_MODE_MASK_NBITS,
+};
+
 static const int xpcs_10gbaser_features[] = {
 	ETHTOOL_LINK_MODE_Pause_BIT,
 	ETHTOOL_LINK_MODE_Asym_Pause_BIT,
@@ -533,9 +567,19 @@ static void xpcs_resolve_pma(struct dw_xpcs *xpcs,
 	case PHY_INTERFACE_MODE_10GKR:
 		state->speed = SPEED_10000;
 		break;
+	case PHY_INTERFACE_MODE_25GBASER:
+		state->speed = SPEED_25000;
+		break;
 	case PHY_INTERFACE_MODE_XLGMII:
 		state->speed = xpcs_get_max_xlgmii_speed(xpcs, state);
 		break;
+	case PHY_INTERFACE_MODE_50GBASER:
+	case PHY_INTERFACE_MODE_LAUI:
+		state->speed = SPEED_50000;
+		break;
+	case PHY_INTERFACE_MODE_100GBASEP:
+		state->speed = SPEED_100000;
+		break;
 	default:
 		state->speed = SPEED_UNKNOWN;
 		break;
@@ -1312,10 +1356,26 @@ static const struct dw_xpcs_compat synopsys_xpcs_compat[] = {
 		.interface = PHY_INTERFACE_MODE_10GKR,
 		.supported = xpcs_10gkr_features,
 		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_25GBASER,
+		.supported = xpcs_25gmii_features,
+		.an_mode = DW_AN_C73,
 	}, {
 		.interface = PHY_INTERFACE_MODE_XLGMII,
 		.supported = xpcs_xlgmii_features,
 		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_50GBASER,
+		.supported = xpcs_50gmii_features,
+		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_LAUI,
+		.supported = xpcs_50gmii_features,
+		.an_mode = DW_AN_C73,
+	}, {
+		.interface = PHY_INTERFACE_MODE_100GBASEP,
+		.supported = xpcs_100gmii_features,
+		.an_mode = DW_AN_C73,
 	}, {
 		.interface = PHY_INTERFACE_MODE_10GBASER,
 		.supported = xpcs_10gbaser_features,



