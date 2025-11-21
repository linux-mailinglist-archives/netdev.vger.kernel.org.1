Return-Path: <netdev+bounces-240813-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A8C7AE3B
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 17:40:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 339A036144A
	for <lists+netdev@lfdr.de>; Fri, 21 Nov 2025 16:40:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DB3F2EBBA9;
	Fri, 21 Nov 2025 16:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWIORc5j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F18752EB866
	for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 16:39:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763743199; cv=none; b=h72jDqjGP2YvM0/2s945RuXI3iBfC+mhMfbtS933IZI1Ipts8ZwaS11vt5GWr6vfIAkmT+XkF+2TBfm7bi8dZiviWRUgFrINnMTW1HbN2LRYznDQUFnXpkqDilSCcyKwTVniMMuMoo4xvx1vAjH52pK0GSCFOcG6s+X895UuYb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763743199; c=relaxed/simple;
	bh=ngyHNiwtuvUwVCnPhnfpjjmHddHj3te8fICfL5WgfZU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h2ok3p6yRmhRkbZzTqbrbYMU8AF0GD7hDC3VwAwLF1D8xEmmCRWS5/eIP0iFcjB0BAcUQruRKVrs25c2QAc8ipfADe/JMdTzlO1OYG3Dj2s9lmd0c/fvx58Oqn9MpwXrEhtRfikM37vNrXn81w+wmHvD/OYiCEuPnaqHOgxzGEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWIORc5j; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7aa2170adf9so1930662b3a.0
        for <netdev@vger.kernel.org>; Fri, 21 Nov 2025 08:39:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763743197; x=1764347997; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CaGyQEZSctvVRBAP//rlsIipfvN6rLxYrl+a/OqFMiQ=;
        b=CWIORc5jgRcFb/UxWU0CrSjgos8kgAjXsmY5W8wCfgY6c+92M1OcJ4TUBwoTCE4NC2
         QlHam5U3VUJNPr6t+XKGG2z4G2S9ngqMwmBADSFGuRDU8xOj4bgW+p0waSUKcItjEEZV
         sW1kMF9QcLYv3hLzvAbBS/SKEnYCtzdXFpC/dW9eSpwbyxNYvOp0jwctth5eDM9N9E3p
         nM/3HFz+t7RH8lTZqi8qz+ggDsCh2mOvm8kIBxQqqpWEmUTftFIyJD6LnCwCq6wtBKLs
         2JxCfLBKPsNr4uKn0NY6C+cObRXUm9+yeDlmQaZTWYtmLuAK7iMO7t9Pj7w/2Ze3P9zJ
         uZUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763743197; x=1764347997;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaGyQEZSctvVRBAP//rlsIipfvN6rLxYrl+a/OqFMiQ=;
        b=ZHuaqthhJ7NpV2y8dX3qQ93E3tHRSl21xDtWSPAxUolU45rS5EiUsrvF5mlpeGnUUc
         vLx+Egw+/C4L5+petLq96u6Rn2r1n0gFtE+xxqGrooDtrpF2e7STqf+neZ2R9NtbiJ0t
         Mq8LTzKDO0WseetjrqlZ0HAVknkBsZBmqfXnglNUjSb2JxtX+akld3byyGxcjgviYZqI
         YckKJqO+GQMtDOx+C9rDkKGcMSrkTgM8i58lvSjwacslg/IQghnskTYkmlbJBZpCRfAh
         6g4Xe+P+50qp32z4cEhypd8/5T4qsmDZYpzMuohBGlioS+5Cpa7ec89mSO28Gcr4zdqi
         8y8g==
X-Gm-Message-State: AOJu0YxYUB5PJWmSeMAf17+ABlShGxSFbcd/pLJJ/t2eY0EiZrQwtGdr
	7kC30sAbX+R/EXd5bpzbRs4GJ2f91rpYhNzwUsUuQWP/tNXfPAWltuPa
X-Gm-Gg: ASbGncvleaeyGKPJjfiREYCokCyHZtSB5zj+/OWUj4eIuVuoFP98+z7KrgNZEXxywT8
	4+H7jbMJ1qlUMiZ/GQfbVl/leMWse/7ZRzGl9V+CetCTb2R+h5PsyOB/Cv7vKM/0K3flgHr+1O6
	KWvdTA4u/d/mjtkHIvPxEjE2dnObC4Us8wejSvM4w6/BgoB5gK+b0z7Q/E0csrJJg3DdHUJB6tE
	iMZ8rmOqxSSJ+qr9h3PTVbU1xetaMRoByyBj4xIEAIJ0gUBj3tvBz/9+dE0L2P1Cyvobvvmc0Us
	iELxxTX8/J1Q2NpS+Lp0dbnrChWn9gC5Z8u00Q0G+/7mlfUSivgkVP1Cs0QHoOXBKpsqFdINRN7
	7PDjIc6UuBbe60MOyM44Ive2VTP73Pl7mPBtl2zFJrfjO6BnyDW+Kw/z1c9u+ReGOBX8s3eWT6U
	SPbQ+e4W37XfJp1sKYK33jvnDYEi0ipiaylWJcrxOYVNZg
X-Google-Smtp-Source: AGHT+IGHTPmnycrbCbQMStGGHM7EEHx/6RLVxroUmG2xDQ6CnABAg+Lp9gvgXeJFnvYf2xJ2SftWIA==
X-Received: by 2002:a05:6a00:4b43:b0:7ab:39a2:919b with SMTP id d2e1a72fcca58-7c58e116e59mr3011671b3a.20.1763743197318;
        Fri, 21 Nov 2025 08:39:57 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed37b0c7sm6531832b3a.20.2025.11.21.08.39.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Nov 2025 08:39:56 -0800 (PST)
Subject: [net-next PATCH v5 1/9] net: phy: Add MDIO_PMA_CTRL1_SPEED for 2.5G
 and 5G to reflect PMA values
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Fri, 21 Nov 2025 08:39:55 -0800
Message-ID: 
 <176374319569.959489.6610469879021800710.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176374310349.959489.838154632023183753.stgit@ahduyck-xeon-server.home.arpa>
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

The 2.5G and 5G values are not consistent between the PCS CTRL1 and PMA
CTRL1 values. In order to avoid confusion between the two I am updating the
values to include "PMA" in the name similar to values used in similar
places.

To avoid breaking UAPI I have retained the original macros and just defined
them as the new PMA based defines.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |    8 ++++----
 include/uapi/linux/mdio.h |   12 ++++++++++--
 2 files changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index e8e5be4684ab..f5e23b53994f 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -148,12 +148,12 @@ int genphy_c45_pma_setup_forced(struct phy_device *phydev)
 		ctrl2 |= MDIO_PMA_CTRL2_1000BT;
 		break;
 	case SPEED_2500:
-		ctrl1 |= MDIO_CTRL1_SPEED2_5G;
+		ctrl1 |= MDIO_PMA_CTRL1_SPEED2_5G;
 		/* Assume 2.5Gbase-T */
 		ctrl2 |= MDIO_PMA_CTRL2_2_5GBT;
 		break;
 	case SPEED_5000:
-		ctrl1 |= MDIO_CTRL1_SPEED5G;
+		ctrl1 |= MDIO_PMA_CTRL1_SPEED5G;
 		/* Assume 5Gbase-T */
 		ctrl2 |= MDIO_PMA_CTRL2_5GBT;
 		break;
@@ -618,10 +618,10 @@ int genphy_c45_read_pma(struct phy_device *phydev)
 	case MDIO_PMA_CTRL1_SPEED1000:
 		phydev->speed = SPEED_1000;
 		break;
-	case MDIO_CTRL1_SPEED2_5G:
+	case MDIO_PMA_CTRL1_SPEED2_5G:
 		phydev->speed = SPEED_2500;
 		break;
-	case MDIO_CTRL1_SPEED5G:
+	case MDIO_PMA_CTRL1_SPEED5G:
 		phydev->speed = SPEED_5000;
 		break;
 	case MDIO_CTRL1_SPEED10G:
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 6975f182b22c..9ee6eeae64b8 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -116,10 +116,18 @@
 #define MDIO_CTRL1_SPEED10G		(MDIO_CTRL1_SPEEDSELEXT | 0x00)
 /* 10PASS-TS/2BASE-TL */
 #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
+/* Note: the MDIO_CTRL1_SPEED_XXX values for everything past 10PASS-TS/2BASE-TL
+ * do not match between the PCS and PMA values. Any additions past this point
+ * should be PMA or PCS specific. The following 2 defines are workarounds for
+ * values added before this was caught. They should be considered deprecated.
+ */
+#define MDIO_CTRL1_SPEED2_5G		MDIO_PMA_CTRL1_SPEED2_5G
+#define MDIO_CTRL1_SPEED5G		MDIO_PMA_CTRL1_SPEED5G
 /* 2.5 Gb/s */
-#define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
+#define MDIO_PMA_CTRL1_SPEED2_5G	(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */
-#define MDIO_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
+#define MDIO_PMA_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
+
 
 /* Status register 1. */
 #define MDIO_STAT1_LPOWERABLE		0x0002	/* Low-power ability */



