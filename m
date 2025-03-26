Return-Path: <netdev+bounces-177650-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F21A70E30
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 01:25:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85375188F8F7
	for <lists+netdev@lfdr.de>; Wed, 26 Mar 2025 00:25:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A84812E7E;
	Wed, 26 Mar 2025 00:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0PxYMJv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59603440C;
	Wed, 26 Mar 2025 00:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742948685; cv=none; b=gZB8QQcUCt1Xr68B5xLmkbibMDZrJMP7v+PWUKR/BflvS9R9zvqCPcVi5wpznM55rqAcuGAJ+EcAUfYnfhQabYo0W6Y/ah6qw55SD2e+qmPrnD/QUk+Tl3UQwJRn+P4lM5BPgd5bO0LF+vhLu3ddwO6Z6t/vRYhZiOc5SG4DAAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742948685; c=relaxed/simple;
	bh=YlqWdp7KHySmrnVbrhruqOfIAlpuPaSAe7u4OiJzz/s=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pw4qOGfOUIxoxcUowIrieu247ND07/zs9p5KQgnLVy3EPMtPPNZNlIKeObMuUwgxJ4n7PnHL9g/iXuSzOVlAj9C0cH5Su72UqxGtQgGtk8gcO71/Kj6WLSSf9mu4Yxar1isjptQVCpbyg+5Vh6/sLcYugJiRAWvh6z01bgqQFoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0PxYMJv; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-43bb6b0b898so60053055e9.1;
        Tue, 25 Mar 2025 17:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742948682; x=1743553482; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zgv+6M5qxsLwEYP63zX59ytO+RlyseNMsitW0p4czII=;
        b=X0PxYMJvqBX7CeeD/gM6g39QtjT+24diSQvdCkvhBv+4liaxeb6+IumUDcQFmQ+xzI
         c3Txhd7h+l0j6gd7qvkjNFSgwNBK63x7TU+8YkbIHFgRtEoNrDzE+qymYfp9QLTgDfm2
         SeQFRj4Bou1YfcFCuxAI7rzOQ2pOevMupc2VMHAz+fDNp1zvZOaKo+OXrbmHwMBu0Qa1
         OazWsA86ywElPyDiKA7EkGda9qMCVYG5RstopcZuUUctDa5CFdl6kwSBGPndsSJzwF2e
         HMyiG+7q68d3XJIUORCpwRXbjl2ezAYKJB172spGfTIUp2KgCZ4GdZvcu+P52e5Y1mLj
         rz7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742948682; x=1743553482;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Zgv+6M5qxsLwEYP63zX59ytO+RlyseNMsitW0p4czII=;
        b=nfaJotBH8XvJ/O1RKgTJ/AREk9j6BRIooNIxDkNgE1X0gOKdrV4YKhNwyfzcwisEvw
         8Cxo2wmfthv+UIgNsluyP/DtKoMruDZcbtx5TFHvY90HIpTexQiMBs5dxTPQp2SrXsDz
         wzTxClH/c/cVzJQgKnQg3o8DriJfhAzesJWWg79Oc0VkQgcYop+sayZD5wUnxvLLwr7O
         wjeXBLhDpvGAuRTJzb2RF93WcZvLT8te/BIpdF8K9hJLciDBr8T8FOESVxvHXF0o3RQA
         KeLhTaCyzjABnNwUbtTdhEaBsCvWJqWrYSJy3UP6C+qxd0DXsjzp3T1Cf15Kx+cE+lw0
         O0jg==
X-Forwarded-Encrypted: i=1; AJvYcCUOR0gRxEHC9C/FKHpUL5fmPGbEkcg9Rh9yuBzJbhEIohb0q3iEMfHSi76wuCwK/Hl2iT1r3+uU@vger.kernel.org, AJvYcCWlDbKdGrc27PS0l31CXBk1B9HjkzvStMpzkjT+Is2CENa0r7xRP+YCUq05fOcjfGTNlj4/1dM+vdAr@vger.kernel.org, AJvYcCXHYkISyLNSNY2orhWt2JqpOjZF6l4ITEsSrHc3gdLrWloSGBnP++cCjgZLftqGp8s0pm9rzKBn3LTb3Tx5@vger.kernel.org
X-Gm-Message-State: AOJu0YybDaVVPrOC/W8EgYquB1h70lDH4qarHzbtu+ih4TROAshntWuv
	RQRWkRMjrmLiSb7XLAj9JdsqcUMkhdRIuFY33sUZh4J8qpMYPHm+
X-Gm-Gg: ASbGncs/NXZTkEQO2Lu8SeTxFM5OylhYMvWXMgYi0GMPckdnahXxw/8SdLCbF/ZKcan
	LSad1F69i3zb+EpAWEBtgNs4YjwAbdL6+Ff4ZtjpTuj8YTRIMV1aASCqbKL7Jh4NdUYzGNuq/ao
	nSkG3ffGpnErMpKwNCQAwWZ6V17DpU+NnMp2xEmK/VOAJAYKtNdqAeWBza6TQVNjoY1pIGZPTzv
	dEHzztuiM6QkvYipuHlh+uyihkITmhHhA4G0yRVUJNMNU/gHAah4zuxdkYdkFWnXp6VAlm+MV/p
	jBJlS+hvPUTkMhzZDuPnelLgEGfkeajkQ2zvmO5RSFREvhbblvF7tMQGZlznTtwcd66LppP1nJF
	GW7+EwmeAlXYiHw==
X-Google-Smtp-Source: AGHT+IEjrEPmJIobgQmmVVgr4TNgNHICiCdySXxD2NABF/aIbGhHte6olocyV/igcsh7epdaYhjHHw==
X-Received: by 2002:a5d:59a2:0:b0:38f:6287:6474 with SMTP id ffacd0b85a97d-3997f8fc43dmr17091924f8f.15.1742948681351;
        Tue, 25 Mar 2025 17:24:41 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-129.ip49.fastwebnet.it. [93.34.90.129])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39acb5d0c33sm1881990f8f.26.2025.03.25.17.24.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Mar 2025 17:24:40 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Christian Marangi <ansuelsmth@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	netdev@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [net-next RFC PATCH v2 1/3] net: phy: permit PHYs to register a second time
Date: Wed, 26 Mar 2025 01:23:57 +0100
Message-ID: <20250326002404.25530-2-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250326002404.25530-1-ansuelsmth@gmail.com>
References: <20250326002404.25530-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Some PHY might needs to register AGAIN after a firmware is loaded to
correctly provide the real PHY ID.

It was found that some PHY expose on the BUS with a PHY ID that change
as soon as the PHY firmware is loaded and started.

To better handle this case and provide to the system correct info on
what PHY is actually present on the BUS, introduce a new option for PHY
device, needs_reregister, that register the PHY device 2 times.

With needs_reregister enabled, in phy_device_register() the PHY is first
registered with the driver detected for the PHY ID. The PHY driver is
then released and the PHY ID for the PHY address is rescanned.
The phy_id and c45_ids entry are updated for the PHY device and finally
the PHY is registered again with the more specific PHY driver. (matching
the new PHY ID)

It's assumed that loading the firmware doesn't cause the PHY ID to change
to different vendor or PHY of different family (provided by different
drivers)

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/net/phy/phy_device.c | 27 +++++++++++++++++++++++++++
 include/linux/phy.h          |  5 +++++
 2 files changed, 32 insertions(+)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 46713d27412b..d5938aacc0fe 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -987,6 +987,33 @@ int phy_device_register(struct phy_device *phydev)
 		goto out;
 	}
 
+	/* Some PHY might needs to register AGAIN after a firmware
+	 * is loaded to correctly provide the real PHY ID.
+	 * For PHY that needs this, release the PHY driver, rescan
+	 * the MDIO bus for the PHY address and attach a driver
+	 * again.
+	 * This second time, the real PHY is provided and the
+	 * more specific PHY driver OPs are used.
+	 */
+	if (phydev->needs_reregister) {
+		device_release_driver(&phydev->mdio.dev);
+
+		if (phydev->is_c45)
+			get_phy_c45_ids(phydev->mdio.bus,
+					phydev->mdio.addr,
+					&phydev->c45_ids);
+		else
+			get_phy_c22_id(phydev->mdio.bus,
+				       phydev->mdio.addr,
+				       &phydev->phy_id);
+
+		err = device_attach(&phydev->mdio.dev);
+		if (err <= 0) {
+			phydev_err(phydev, "failed to reattach\n");
+			goto out;
+		}
+	}
+
 	return 0;
 
  out:
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 19f076a71f94..00ddfbe7033b 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -578,6 +578,10 @@ struct macsec_ops;
  * @mac_managed_pm: Set true if MAC driver takes of suspending/resuming PHY
  * @wol_enabled: Set to true if the PHY or the attached MAC have Wake-on-LAN
  * 		 enabled.
+ * @needs_reregister: Set to true if the PHY needs to register AGAIN after
+ *		 first registration. This is to handle special case where the
+ *		 PHY needs to load a firmware to correctly communicate the
+ *		 specific PHY ID.
  * @state: State of the PHY for management purposes
  * @dev_flags: Device-specific flags used by the PHY driver.
  *
@@ -681,6 +685,7 @@ struct phy_device {
 	unsigned is_on_sfp_module:1;
 	unsigned mac_managed_pm:1;
 	unsigned wol_enabled:1;
+	unsigned needs_reregister;
 
 	unsigned autoneg:1;
 	/* The most recently read link state */
-- 
2.48.1


