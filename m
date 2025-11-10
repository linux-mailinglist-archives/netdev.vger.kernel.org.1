Return-Path: <netdev+bounces-237255-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 06CB6C47D07
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 17:13:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B437E4F4D10
	for <lists+netdev@lfdr.de>; Mon, 10 Nov 2025 16:01:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E4BE274643;
	Mon, 10 Nov 2025 16:01:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jBjp7XVq"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03067272E56
	for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 16:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762790477; cv=none; b=Ghc6efOSsVd5aRUOQhWNl5lXtbBK20yyf1WmG7uZd/PFFbrfeYXA2ZoYQmQlhajtF8DEgzVkvjiHpnEpRzgK/1F5Xe77w9/igbQXTPQLV9QH2zEB/KW3Px727ZVsgw59P9oMprhpmnZCcOe6RUJVzxHfstmXNQwwE53VuuENgZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762790477; c=relaxed/simple;
	bh=m+EE7Lc7jS+OgxnObEyiAufzLFGenbeHPEox1PkgnQ0=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cP4+XYJC4shhFklWRif8o4wyF/R+P01GesKjbsglqX/kApbULvwjttcgQo7zJa3bVJHPDa0pCaAhzeDIwbm6Y/Ruf5VHQ+IcGaxy+1AIt1lT5K+lLA0GJDlTOwW2dceKJBsh8umyWRdZ8NPbzwGRhICDMp32UboGExBx/fyKjFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jBjp7XVq; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-ba4874edb5dso1828509a12.0
        for <netdev@vger.kernel.org>; Mon, 10 Nov 2025 08:01:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762790475; x=1763395275; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=xOOi6azjwMv6A6/LaGhr9ldJj5E9AaAR07IeIHO68rk=;
        b=jBjp7XVq0/nNd6uGdGuqZYG7VpbJIQA0l2ALuJfdoWKAW/CHwMeGBKtw6GnDhICdme
         TN6UMaI9aOU9suzRAYkpqr6495CWk0QODoroZ5EwzyaOkanvTTHEIiHtVskBDRdscS/T
         JDIPUqmhAMjn/fPtNyqqTft3kS3BfirDYvtJsK+CDbTOfCWJDOSV1dtKfmwzVUOmhGBf
         t1FYomjhRTS6UWC49nr33xZakYHeNQ4hCxUFHOwORh3+VfyUNAwb/mrzBaze/ff7fVP9
         lKj5LFlk5anuSUjQ8jzy+Pqw0iXe7Z7Y39GBlz8t9mKWV7mLFXqCSLqQ/iImj2X63LIM
         HANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762790475; x=1763395275;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xOOi6azjwMv6A6/LaGhr9ldJj5E9AaAR07IeIHO68rk=;
        b=SCaeM3ij4Keejs1gmEn8hK3yurHyEWGfcd9vJhzGuQ/pr5ea/cYHlivzlzesX1dgwD
         zDNfYFKaUPM3QS5gZ2c4q/OQ+CVgxUvg//lEIaEeL6fwfS42Jprgh1OAt+12FND79E5p
         xw2+xxyzq7kGZw4VUYZl8gfWtUvHoU7o2hWGO3Z648MOUbmJ17NFVRtXBDBAQRsTIp/m
         ceep8I0XDJvIcI+RnY+6rORkjg2iY1VP0wYqlN55xppb8ABF4wjpU4uS9r1oQC4HYg2Y
         02r+/LsASUSkrtcXgBdYdfsMHTgVAi4jikVIIgm7LPp8s2QwXhSlyHfeyjpyHIkjMQ8X
         xl0w==
X-Gm-Message-State: AOJu0YzUMgVP7/TRcchmSYpjBcbTR21Hjp9Ig0r10p9DU8VuTnRZPMGV
	zHsIpID/GVdSiBeHRSEOTp+b69sxjAlbQTRBKS71nhR+UNOJnsfTSvffqJN9BQ==
X-Gm-Gg: ASbGnctL6RDNViTppph+JWog9qgFD/BqmacdFOv+vcTZq0Q+xS05FoNoj1WvYLJNaUH
	EGFWXwbjg8o6V8kAyXrCdtpdYwWJtJpaCEJIaHgZspVOspD52JJhf7L4NfkcQW+GK4nasOaAPeG
	364mEHGdJ4KsD16Hcqw1qJVJlU2xbWkojgkd/rbWik11vIyTNyt+lZM6LLmEVXRPB5ibz6A7SLJ
	vJPKq6Crk5lOew0dBDjv9POycC6zGLFZ5f8JyJbC2MhdDOMvEW/bx8zghifBXNEV0UrL9AfpgMK
	/WAh4FEFz7KUQl41wnds4PAr9R5NVpkDc8nIl39C3/yT718f/GhwsjO+9QAB6DqVJ6z1HOD+dK9
	AnQh3e4zZyjEHOZOWIAC5jIBtzmfwFSYsxzh09EuC0S5PSzutkcpN/e3/LH3cnzZd0KAsTxPCOR
	xQsHdAzoXUTsT+2gF0LdF6AxB7gukBi0941g==
X-Google-Smtp-Source: AGHT+IGm7DozT0DChzM8QNry6/zOzudTEovhJT7krePiD+MfVtFwu7/u5G5eiSPoTGzf7yKunNvtGw==
X-Received: by 2002:a17:902:d581:b0:267:a95d:7164 with SMTP id d9443c01a7336-297e570b78dmr100813475ad.60.1762790472811;
        Mon, 10 Nov 2025 08:01:12 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([2605:59c8:829:4c00:9e5c:8eff:fe4f:f2d0])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29651cd2418sm150378605ad.109.2025.11.10.08.01.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Nov 2025 08:01:11 -0800 (PST)
Subject: [net-next PATCH v3 02/10] net: phy: Rename MDIO_CTRL1_SPEED for 2.5G
 and 5G to reflect PMA values
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 10 Nov 2025 08:01:10 -0800
Message-ID: 
 <176279047080.2130772.6017646787024578804.stgit@ahduyck-xeon-server.home.arpa>
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

The 2.5G and 5G values are not consistent between the PCS CTRL1 and PMA
CTRL1 values. In order to avoid confusion between the two I am updating the
values to include "PMA" in the name similar to values used in similar
places.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |    8 ++++----
 include/uapi/linux/mdio.h |    4 ++--
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 1d747fbaa10c..d161fe3fee75 100644
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
index 75ed41fc46c6..c33aa864ef66 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -123,9 +123,9 @@
 /* 50 Gb/s */
 #define MDIO_PMA_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
 /* 2.5 Gb/s */
-#define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
+#define MDIO_PMA_CTRL1_SPEED2_5G	(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */
-#define MDIO_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
+#define MDIO_PMA_CTRL1_SPEED5G		(MDIO_CTRL1_SPEEDSELEXT | 0x1c)
 
 /* Status register 1. */
 #define MDIO_STAT1_LPOWERABLE		0x0002	/* Low-power ability */



