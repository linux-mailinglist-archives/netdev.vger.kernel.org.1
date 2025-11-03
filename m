Return-Path: <netdev+bounces-235192-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E368C2D54E
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 18:03:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C32CF189D21E
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 17:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E88031A7FE;
	Mon,  3 Nov 2025 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOYAj9Wo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD41531A7FF
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762189208; cv=none; b=a6KfG1Zi4aXexPdDVvuJfYIMmJWI+mQJ77fF/d7Aex0gAG57Yrlv+tHdAlAOoqidemI0NaAzAxhaFRhDRrobao6IsWnFVF6OZ+u9LTWDaZtmfPqdrNGN/qVZnXz58D7RvniJ6op11x30Xy40ZCU0yaXynNs0NdVmULH45RpvpNE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762189208; c=relaxed/simple;
	bh=in9qww92BdZ5ZnRSuX98wmRJhNhmwZjwXZ8p8nlwc3k=;
	h=Subject:From:To:Cc:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RF26NwM0dcWOgm5ClmM6f1vTyzYxpu8P84ja/UXvPtgADcDQSRLZlJVVVieAGXnHoZTdDppVgqJjNB9rS9Ucuwb6GWiqst8cEMPfE/5sX5HmCbwPht3hhZcN6lIhOZaFi7b99+iYlLfhqEJ9JD12pa20PwzMNZzbNoo6wbS5Xs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOYAj9Wo; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-295247a814bso45106255ad.0
        for <netdev@vger.kernel.org>; Mon, 03 Nov 2025 09:00:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762189203; x=1762794003; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:from:to:cc:subject
         :date:message-id:reply-to;
        bh=he1REuWvauVVZTkF0srpQjWCb/eqg8SW8zrQctPhFgQ=;
        b=VOYAj9WoMf5qA4N4KFWXHXXBG9DSIXNECLYuQo0/UDttjk6W2M3/nGjKBteywBQQwE
         BzKA0zone9rixgmcUQHOSQx1z8+I2Pi2WSNbRATbJ+US2nsPHst1Mcdcb9QjYYvuSyfN
         sjALCBklgyytBVHqa0VLs7EZmPycFtWwjFaV7rVDSAba9L9CcdBJJ507sB08+gU17HUa
         919iUN+BMvUDX4hndMG+oS4LWJqn8ABaouMJwhyoVAu6h+adDzsfzaC+gKsfkjFXTqJP
         xOfDtrC5F7vZTq8FYNPtOCRM5zogj3NjnPmZBisqZ+8cjuvgeK1NfCtxhU0Bm7Ip42ZA
         UJMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762189203; x=1762794003;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:message-id:date:cc:to:from:subject:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=he1REuWvauVVZTkF0srpQjWCb/eqg8SW8zrQctPhFgQ=;
        b=vc8bPHq99NEDiIgZLUzKjK5RU9LQmlIFTbk6tUp4WoeR/wrDKDSdqPhzfQK/7hLc1t
         0PG0GNg+VfF8onkuUZuO7MR+N21JUWTMAbd81TsKJ/K30qBqpZWUTWbNMJCScGus16KN
         aT3LYgsm//NHsFXswHZqpHJL1AW3ZUArEBwRKCcy4X8qF+e0L+Cp9KhtOc4kpYmJPVd7
         luZrQpJJBqqOzh/rbTCJe0VrHS7FF0JQRZbBtLLQPYJ4wmwUTWT7rZcV2VsMF3ZnMH+l
         Yu8Jeafy5hqEnT5MINZ89yV7AwdJ3bKuxEUXKqiNxSsTkhg2b9Nvfo9ZTTeUInIW14gc
         DpNw==
X-Gm-Message-State: AOJu0Yx6riifkdc/mNmMH3tUjMJKyf1C8IX1qD/03MAVnJaBtqjW4NYq
	nlW3I8ZBPlig3tgKbsFJQG6njfnFztHa5OIAwoHlxZVozjsDoby2bE1YGySsdw==
X-Gm-Gg: ASbGncsqK1VYioeSpX138QwwTJKNw0yF2GhQDL9MAvzFTrpG9QpyV0pbGpae1thr7pq
	0XbI8x3vlTXQKzZnbysoCMoJiEjuKDOHolRtkvlEuaK4mzbdXtOKkJ2wPRKXtxTWvpkSVCZGoft
	gm860OAJVsiDXATzrUo7jD6dTkzwd5aZIcm3NiQjD5rqoyMc9a2QoDjRufBF6xln5g9lxPtjrbb
	nfBlWgJe9kPMUVjY2DEUQWrXIAdtjVjeNAmrLboPQ20XtL5jVVyCnD+nR3bid9c63ZhGqxZH3Cn
	kXQygLbFihOyOzjfwt370816883hyw4kBNo4orwKt/CUIHWObS2HI1hfG8wcS94Cm0QsP+K+WVP
	8dI53ckZZ6H2EIstboWE1hfjZu737iEln3+Fz2wDJS1j62o0qCTtTeq30NlEC4OF5nARb/83+ek
	auAPAkmWd+AUyiti7aw5W2dHE7JUGs
X-Google-Smtp-Source: AGHT+IHa0t8YNida5SaIoGVnxCqe+s/SC0obI7lieioDjk1OXjphunqRbpStyBiiAlE7Rh0XACXoAg==
X-Received: by 2002:a17:903:41cd:b0:24c:da3b:7376 with SMTP id d9443c01a7336-2951a3b0522mr180855935ad.26.1762189203571;
        Mon, 03 Nov 2025 09:00:03 -0800 (PST)
Received: from ahduyck-xeon-server.home.arpa ([98.97.33.201])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-295269bd6f4sm124110445ad.101.2025.11.03.09.00.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 09:00:03 -0800 (PST)
Subject: [net-next PATCH v2 01/11] net: phy: Add support for 25,
 50 and 100Gbps PMA to genphy_c45_read_pma
From: Alexander Duyck <alexander.duyck@gmail.com>
To: netdev@vger.kernel.org
Cc: kuba@kernel.org, kernel-team@meta.com, andrew+netdev@lunn.ch,
 hkallweit1@gmail.com, linux@armlinux.org.uk, pabeni@redhat.com,
 davem@davemloft.net
Date: Mon, 03 Nov 2025 09:00:02 -0800
Message-ID: 
 <176218920220.2759873.8935077152054914787.stgit@ahduyck-xeon-server.home.arpa>
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

Add support for reading 25, 50, and 100G from the PMA interface for a C45
device. By doing this we enable support for future devices that support
higher speeds than the current limit of 10G.

Signed-off-by: Alexander Duyck <alexanderduyck@fb.com>
---
 drivers/net/phy/phy-c45.c |    9 +++++++++
 include/uapi/linux/mdio.h |    9 +++++++++
 2 files changed, 18 insertions(+)

diff --git a/drivers/net/phy/phy-c45.c b/drivers/net/phy/phy-c45.c
index 61670be0f095..2b178a789941 100644
--- a/drivers/net/phy/phy-c45.c
+++ b/drivers/net/phy/phy-c45.c
@@ -626,6 +626,15 @@ int genphy_c45_read_pma(struct phy_device *phydev)
 	case MDIO_CTRL1_SPEED10G:
 		phydev->speed = SPEED_10000;
 		break;
+	case MDIO_CTRL1_SPEED25G:
+		phydev->speed = SPEED_25000;
+		break;
+	case MDIO_CTRL1_SPEED50G:
+		phydev->speed = SPEED_50000;
+		break;
+	case MDIO_CTRL1_SPEED100G:
+		phydev->speed = SPEED_100000;
+		break;
 	default:
 		phydev->speed = SPEED_UNKNOWN;
 		break;
diff --git a/include/uapi/linux/mdio.h b/include/uapi/linux/mdio.h
index 6975f182b22c..eee38690ddc4 100644
--- a/include/uapi/linux/mdio.h
+++ b/include/uapi/linux/mdio.h
@@ -116,6 +116,12 @@
 #define MDIO_CTRL1_SPEED10G		(MDIO_CTRL1_SPEEDSELEXT | 0x00)
 /* 10PASS-TS/2BASE-TL */
 #define MDIO_CTRL1_SPEED10P2B		(MDIO_CTRL1_SPEEDSELEXT | 0x04)
+/* 100 Gb/s */
+#define MDIO_CTRL1_SPEED100G		(MDIO_CTRL1_SPEEDSELEXT | 0x0c)
+/* 25 Gb/s */
+#define MDIO_CTRL1_SPEED25G		(MDIO_CTRL1_SPEEDSELEXT | 0x10)
+/* 50 Gb/s */
+#define MDIO_CTRL1_SPEED50G		(MDIO_CTRL1_SPEEDSELEXT | 0x14)
 /* 2.5 Gb/s */
 #define MDIO_CTRL1_SPEED2_5G		(MDIO_CTRL1_SPEEDSELEXT | 0x18)
 /* 5 Gb/s */
@@ -137,9 +143,12 @@
 #define MDIO_SPEED_10G			0x0001	/* 10G capable */
 #define MDIO_PMA_SPEED_2B		0x0002	/* 2BASE-TL capable */
 #define MDIO_PMA_SPEED_10P		0x0004	/* 10PASS-TS capable */
+#define MDIO_PMA_SPEED_50G		0x0008	/* 50G capable */
 #define MDIO_PMA_SPEED_1000		0x0010	/* 1000M capable */
 #define MDIO_PMA_SPEED_100		0x0020	/* 100M capable */
 #define MDIO_PMA_SPEED_10		0x0040	/* 10M capable */
+#define MDIO_PMA_SPEED_100G		0x0200	/* 100G capable */
+#define MDIO_PMA_SPEED_25G		0x0800	/* 25G capable */
 #define MDIO_PMA_SPEED_2_5G		0x2000	/* 2.5G capable */
 #define MDIO_PMA_SPEED_5G		0x4000	/* 5G capable */
 #define MDIO_PCS_SPEED_10P2B		0x0002	/* 10PASS-TS/2BASE-TL capable */



