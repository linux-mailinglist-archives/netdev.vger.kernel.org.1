Return-Path: <netdev+bounces-238440-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id B5B12C59101
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 18:17:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1B5554F42E5
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 16:42:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7503D35772A;
	Thu, 13 Nov 2025 16:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z+JY57XY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6996A358D35
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 16:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763051587; cv=none; b=ilDT/gKI5QZvDy1Cy5Je5558POXY/ngifDHaAQY1Ex4weFBln10iQNXVI+AS7av8yj325LMY0Tazy4rXusfLNOoDcCWdbCgW148OnM3ARilgAu5SNb/KWdL5vJGPdJKpsXRjdU+9+SdRhEZEhY8C/Kv/Xw/SNvBfslG6L29WVXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763051587; c=relaxed/simple;
	bh=ngyHNiwtuvUwVCnPhnfpjjmHddHj3te8fICfL5WgfZU=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MzfPzmnX2z7Pgcdwl7hBvRbuNlrduHot3qzKaLXHuRAb69wPmy+ztyO7guwCZgaagEtShiCkNCws+LvvSXBy5CDyK6h+w5r4QGHxSuX3fzc3J9LyIvwEhOh/s+moDfAuitxgOWo/jedziLqmHEE7c3gT96ThSnTnCg5dfQl65oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Z+JY57XY; arc=none smtp.client-ip=209.85.216.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-343774bd9b4so971913a91.2
        for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 08:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763051585; x=1763656385; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CaGyQEZSctvVRBAP//rlsIipfvN6rLxYrl+a/OqFMiQ=;
        b=Z+JY57XYfInnVZuOjJ9CaRQ32dc4gcFBNQa7r6Dwr2+IH2bpH7Uj7eLHGaVXs/fBoh
         r/DUWpw8wAMz90NTBhsYlUPFboYZYuHVrfvB3QnjZsIiyezBrIdaULXoTiCn5dElrzEs
         OUNmx0yXLhk0OURUnlYCaCHLMhgFvPvYFLZY/TUUUtp6Gn3Q59XeCn14OajCuKkFmuRo
         +8wXuHgEDT8YUOTkGsq0bupwFhclZUiHPltN3iWeyHu3vMnExojcIAoB09ta5m1HmgLG
         RMSt5G3pWN+kdNErcbGTymWjd8j94YxGpRfwDV/Z+iKwXZBb2tgMUPMLSgB5SDZdpnrS
         zpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763051585; x=1763656385;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CaGyQEZSctvVRBAP//rlsIipfvN6rLxYrl+a/OqFMiQ=;
        b=rq16ESZdoVbJV6HIRtnIljDAcYUQ7sgOua+gQQSVjHMtDSzoxjlJ1MnhqIRHRH5vAs
         Dg32FwSM2SCVp1Bs/WNVRwsf9wgeGo/WIrgQXNAT/BdHifxeDIYg6zwI5p1btT9kZip2
         ge6L4k56QlNPGthRZqOntUYjPaggoT/Zzk7nRXV7O9t/tBYR641NFqmNNzjib+MSgG0N
         8NNYpaYzHrnM7cVrWsJml9fRqBxER4gy99BPm5xfti2wi6HQFvVjVZ6ZACb3k60oO55Y
         Z11DEXaUHaTmHUeugJ5iKLv6tN3ooR3ouO2063IrM59BrlnPVEqH1DTpmrDSC7yJx898
         3StA==
X-Gm-Message-State: AOJu0YzAgAUov4buIAeUcZPROdGHT5MNxCYzEqnW9jStEu3NAV7m8NXB
	fhhinq+SwGMdxHcTKQy8PvNejwzG8oVcVKUOBgYrLqn3QkOXA2uN/YYR
X-Gm-Gg: ASbGncs7f/lB8wag0wcfmu9n5GmTwcIkSzPsyyzHGn/PnRAnbVw/C6WsYeriCMd/x2c
	RwqPFugWLRLTloqsQlsafYIMqmY9VSSYzzd4ACc8+pbOPJpkVKQXzDfJowk4TDxQkjYPhKuQ3LD
	Sgj6YjMi4vQUy1+lrqei7J3GSp5cy0HccP8HyY55WahJjBNVICW9usa8BIyvjmctUOlMNV5busr
	wzRcrOIaNG7nfhmdzLgSxWnj3aNb6rx2o0P92UcVIzAQ0UZbUIT+cW8lr2ZT2tkLqtkcA1r3ofE
	3cdY/IxOkRO054/Z8hiarWaU+67gE5YsVC617uWL6oJ6ADpw/udpY1aQ0emecGS08uaZjjja1lP
	4M0UM2rvh03OVBPEcfA1kyEBIyW2aEGTmDnZ5Se2yLxJ2085y0w7aw/h7iwIskP8y2bYix570UQ
	NE8FxzzZkpfrWX+QaLJ3VhpKAGFAiA2yUhhrXNu0OMkg+s
X-Google-Smtp-Source: AGHT+IGA0gC2ZtJUL1NaydEPOX3fIobg7/JjBlcV/ZLe5wxQS/2eW+4Fv2a9RaBLn1GFqpFqMz9nZw==
X-Received: by 2002:a17:90b:4a50:b0:343:684c:f8ac with SMTP id 98e67ed59e1d1-343dddd4dccmr8474672a91.8.1763051584387;
        Thu, 13 Nov 2025 08:33:04 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm3055881a91.6.2025.11.13.08.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 08:33:03 -0800 (PST)
Subject: [net-next PATCH v4 01/10] net: phy: Rename MDIO_CTRL1_SPEED for 2.5G
 and 5G to reflect PMA values
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Thu, 13 Nov 2025 08:33:02 -0800
Message-ID: 
 <176305158293.3573217.9476472903287080085.stgit@ahduyck-xeon-server.home.arpa>
In-Reply-To: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
References: 
 <176305128544.3573217.7529629511881918177.stgit@ahduyck-xeon-server.home.arpa>
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



