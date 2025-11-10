Return-Path: <netdev+bounces-237254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D089C47C8D
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:09:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2BEEE18950DB
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B2D274FDF;
	Mon, 10 Nov 2025 16:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MKlz0y2N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F09626FA77
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:01:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790470; cv=none; b=ln7iUaKPcsIPmBmIlYo/QxVkEOB3fZiUsNAlyfQFVTSXsMHv6C6KVc/qvwMm0OoYc8TVGNqFqFIr4P2l1yNNWdnSma1Cd/mHe4bbfwNteJx6pfq6zCK/RyJV0d5b/bxfipXjKJccgWIfLCIl1UPW3gLg7lSgYsncayAjY/yjSvM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790470; c=relaxed/simple;
	bh=HkQ4kILA9wNIWSnxvnjS6gXCu8uHOLraWRf740qpvjI=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kPcHcakWAxCbfRFLwC1pycrGPNYxq7zONKLPjYWEAvvCdqAvRJZDvAsdlklYb3ouBBR+I4cf7LzSG7hjPKs61KbiP4pN5oHsq3skOByonbVlnGaIOYdMeASeDfoIxdG94Uiv2WnMOPxYCDS6sgm+PQbW+Y0+BWkW3ATN6dVfums=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MKlz0y2N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-295548467c7so34001965ad.2
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:01:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790468; x=1763395268; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=d0GHWQNMIh3x080W5fJnrRO6tAzQzglX3ock4yg5pxk=;
        b=MKlz0y2N+gEjiYeAII0JcKUIZAgRMySbAUmhZnXLGNbBpXSgNMUAAenvpwVb7jw3ee
         PfQR4aCSt+pbAyjN7p0NIFLmLmaDRXYd3As9th4uFuiwPM1CCSRx06brGAkfyXTiK6q4
         Oy33VHDpjLGPJoPVhoYVIvJEI1OKqqpNePMW8deNFVMvJqiu29fsTRT+2QI43rh/6veR
         XOSwBQhgKhEIHqnkSzegfj8Ufv8Hj6uEO7TujDmeSUz72fReCblttQdUmt+Yk+EAn5YK
         VtQA6/QaNs0j+tTIX5cypBx0qWRW1YAuxBSz2aaVADCIf187K/rjQIRKcjWywlPc1ffn
         1e9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790468; x=1763395268;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d0GHWQNMIh3x080W5fJnrRO6tAzQzglX3ock4yg5pxk=;
        b=uFjOnNh/Deb7CwJkIk7GnFK+uqDM2VjUJYJW/WHemy/mWZQlwq9av9V46cZ3LFX03N
         MZgknEfPen63S9YJpTaC2CvYZ8dmrSx/9Asbk4JlRG+IrTg8oSUqCdHguV8jwX9e7LKY
         Ymf2z0mYzu0x++JRMw7VSY7wOTwI/c2L9C8rRF387kP9bD+HyGTD5t+NWosyf9KZMID4
         ok5Fz3Ihw5DCj3XWITq5+7CfxEDVkcnx985c8HNjePttnOdcOlhVM3ykNFfcOVA7AFQ0
         1XDC9IrPushpVfvEnhqmVDwcLJB2vR9LO5B4VaCUlisePxk1sRnF6w49Is4rOLgeTXZn
         1n/w==
X-Gm-Message-State: AOJu0YwfhowAEH5cib0PnIVfot/LutRuU5cq2yjqv7xx+xIINesjJMpr
	C7fKAWjuc9kXjqUiOXKQW58vjNmbIXZWudpTprnS0WSX/2cMeD6DKJTGStz74g==
X-Gm-Gg: ASbGnctvhwRDmd66ZP3Ka3Umz7yLwex5KTiTKLbLKFEG2dG66JKhNB8x3ZrkuId7iIY
	8infm2ir/K3mDgdwuM/jr0UuxrKxi9Jan4Ztd0z/orAEW8MbLxNiVuqQRoyw5gFLy7GszYhEy/X
	pKGLFftysQwCmR6GzXOEmhyk0b2taP5Q1X1jAvKEVKOjxAwp0rtPx6/9Wpv1NIg8OZ2aG2zY9Ts
	J1cVQsqUIVT6csR/H6aAPMaMFGdok7GhyLa9MiAnj0Su28zbUHJBjvxlpjOVzaoBULWzPxgCRlx
	q1T5y96gEJrG7jQ/uk1Rk1Dl8M9SvLYu2EQR2gwgSKCgq7LMkoOnCR1tPVzqGBGsC4bBVdODrmM
	TOqKhvm/0nVTxaxnZ5Qs4U9d0TxxYD1W+WeHLnJ6ObHqOtTPb0Fljduyqc0mdEzlNO5SzJuwIS2
	rMLEKLL9hri64oeEbT1c1gqLMgG3c0K84FoQ==
X-Google-Smtp-Source: AGHT+IES0NB/mpbUwKy2xxXE5+MOiVax2vgsSRwb/yh718c+rlo4jIJZ0NhLEP1ymT2wWvLe7mEvoQ==
X-Received: by 2002:a17:903:2b06:b0:297:f5ad:6708 with SMTP id d9443c01a7336-297f5ad67dbmr87314065ad.43.1762790461819;
        Mon, 10 Nov 2025 08:01:01 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651ca1eb7sm153291565ad.89.2025.11.10.08.01.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:01:01 -0800 (PST)
Subject: [net-next PATCH v3 01/10] net: phy: Add support for 25,
 50 and 100Gbps PMA to genphy_c45_read_pma
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:00:59 -0800
Message-ID: 
 <176279045960.2130772.11393060400220095710.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176279018050.2130772.17812295685941097123.stgit@ahduyck-xeon-server.home.arpa>
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

Add support for reading 25, 50, and 100G from the PMA interface for a C45
device. By doing this we enable support for future devices that support
higher speeds than the current limit of 10G.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |    9 +++++++++
 include/uapi/linux/mdio.h |    6 ++++++
 2 files changed, 15 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index e8e5be4684ab..1d747fbaa10c 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -627,6 +627,15 @@ int genphy_c45_read_pma(struct phy_device *phydev)
 	case MDIO_CTRL1_SPEED10G:
 		phydev->speed = SPEED_10000;
 		break;
+	case MDIO_PMA_CTRL1_SPEED25G:
+		phydev->speed = SPEED_25000;
+		break;
+	case MDIO_PMA_CTRL1_SPEED50G:
+		phydev->speed = SPEED_50000;
+		break;
+	case MDIO_PMA_CTRL1_SPEED100G:
+		phydev->speed = SPEED_100000;
+		break;
 	default:
 		phydev->speed = SPEED_UNKNOWN;
 		break;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 6975f182b22c..75ed41fc46c6 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -116,6 +116,12 @@
 #define MDIO_CTRL1_SPEED10G		(MDIO_CTRL1_SPEEDSELEXT | 0x00)
 /* 10PASS-TS/2BASE-TL */
 #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
+/* 100 Gb/s */
+#define MDIO_PMA_CTRL1_SPEED100G	(MDIO_CTRL1_SPEEDSELEXT | 0x0c)
+/* 25 Gb/s */
+#define MDIO_PMA_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x10)
+/* 50 Gb/s */
+#define MDIO_PMA_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
 /* 2.5 Gb/s */
 #define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */



