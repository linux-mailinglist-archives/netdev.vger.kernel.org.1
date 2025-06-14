Return-Path: <netdev+bounces-197722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 715DFAD9B19
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 10:01:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED39B3B9FA6
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 08:00:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 497331FF7BC;
	Sat, 14 Jun 2025 08:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBf5zB+d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com [209.85.221.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542E51FBEB1;
	Sat, 14 Jun 2025 08:00:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749888013; cv=none; b=WH3WQweClQ2DJx+/Pd3UWezd7zfhw2xNa1pNaKTqvepo95pwU1BgSsY+EfRBjX/y+bn3IB/x8K4FKXZRN37GXFbZIl6xqBvmVEgsFUZ+PoQAME7RIRUgucjVbPo4og8TsgbnIWz9idoAXoV5cuwBWfmTj4/AT9qAjnHFIC1en9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749888013; c=relaxed/simple;
	bh=bcY9f0/XSJcXeplWGQXkLvBPRse1p8CAC8CIVCUNVN0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=c4nonYwBkm5D+/Si50BHje3i4JXQ2q/tonI3Qywyfid+jho73+mufolMU20m3qAPGebt3O7cUot7WnK70wyLsLCPGklpmfssoLB4PDfnxkDj4UDIYd3Ju8CmzKRkhDP0zFzw/UWA0JHqS/oq+ACW6G1t3EaP4dEyZfZlMTixUcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VBf5zB+d; arc=none smtp.client-ip=209.85.221.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f48.google.com with SMTP id ffacd0b85a97d-3a4f71831abso2614374f8f.3;
        Sat, 14 Jun 2025 01:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749888010; x=1750492810; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0gzliT29V2BC55uTgUs70QieRTBAGDNh9NCehiFYnyA=;
        b=VBf5zB+dLPqxzed+hnpf95Fq6BzH+qoeS6sieuQiEje3I12/FZ9lZTsGrTDgha2D7H
         5IjUFdiaedZ/FTJ/ueYBMdVlyzT7MPrJ/6gsEXOn50iZ50aVDXlr5PxZ4O77ca1ixRcZ
         nKA+yJYqMkd+3PLo15CWzerk3k6mQMFLL5/KFcgk1nPS2uXIJ2ekVhE/XI0IfoMd0VYf
         3zxuf2nq2DiyA3Wh0Kbp4qHVEwGEDMNXmXkdXar9tgcc5NjiyaQu3ir2t74JFUNZJapS
         ITqU7+DYlNbzoQrk/juT4er+ptkmKS47veIArexma9V2cTSKMvTHsZz+C5MgtBiEyt1U
         KmVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749888010; x=1750492810;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0gzliT29V2BC55uTgUs70QieRTBAGDNh9NCehiFYnyA=;
        b=Z39ttQvAXMwcAh9l+KCxejzaVARciF50A73pGPi3GpA6DtzmEX8ohEUtkym1YSgwuM
         5lScOxTblI48Ib+gJU6ilXYY/2+l9IzPSTR+WxXSQDBvANsrtapJssSS0ObNLPao5WkO
         9izUVP8lfKRBZfgdKQVSvPi3w0AkjwEZ/YOuS/BJSwnZLpG1a7s9Ms00O/twmHJs1VEN
         WqKAJ6l5SuIwD3LFXpI5m1+seH/56YP2ISDmWuT+IMeeT7TYkT+z9ZLEiAsxdAt61MDT
         r/cqjddyslRW5Xr9M2hsrbgr5xUF5XxIu5aiZolWfp+wVdP9Swt2hkBdlysDLCUA6GGh
         3aXA==
X-Forwarded-Encrypted: i=1; AJvYcCUkgLNlZoHBDdH0WwZAT9vN0aJyif577Xyi5wRwAhZfmtzvwVc1d114A2IKjIb6QI7sAcMs+jWE@vger.kernel.org, AJvYcCXGqHlvHOxgUecy59oZDRnU0ZlKoX7GjiZxqzIkG+hiUfLFl14vaTAU60UlVePokTwseA6wZ315oDtDmAs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3RcCa3Qv7lVBxDXWv8b9UR/nzLQFgZNmuXwIFERkAIcPFbc2N
	tSK4Lox0IzVJrerl8iQiJO4bDzFyldR0JB+mGZ5cgz724u3BPrJqM3ky
X-Gm-Gg: ASbGnctjsR15FOXZOnjPYtQeNzGjYtnhAmlib8QfqXjl1yBCv7gnhOuUdNe7l72FvXx
	z9VLEvJx5RjWL2Bnte35fPZj1I3HtW4aMQagxG4h/eqgQMbf99oLfDU5Z8vrIjdFT4T9bi0gBBl
	lL6tBJja8laEnu5l7cYVY9InJQzKQDyFpVGJNOWQcDjreWTcLqxDZfY+Tq+meRsuVIbT0fZ7ZJ7
	os7LRmO5+VgI5z2yPkK0UvXsTJyH+JPONYkR4c5N1NRxSDZRGLc2VQmyee2MkOv3h1r1xfOX6La
	WwBCT8r4AXqttCs+YYbSY9pabCl7bco+6FUFMyf/yX+qLfDNJVtI7jwj5bhsrciHCTlgV8oIU1P
	WFuT+V4sYjNzx43TUuW6xBh+sL+P7qFM18/C0nvIfHLHVKqC4sbPmiYY0p/0YvsQ=
X-Google-Smtp-Source: AGHT+IHVrPhtpNPEMqHo8KrU7PDlOJw+RnNlhzLGjJZ7IOR1lvhX2XDYAVl0UY/4tT5Zi2Dnbm72tg==
X-Received: by 2002:a05:6000:2dc3:b0:3a5:1240:6802 with SMTP id ffacd0b85a97d-3a572e58463mr2160977f8f.57.1749888009443;
        Sat, 14 Jun 2025 01:00:09 -0700 (PDT)
Received: from skynet.lan (2a02-9142-4580-2300-0000-0000-0000-0008.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:2300::8])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532de8c50esm75443535e9.4.2025.06.14.01.00.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Jun 2025 01:00:08 -0700 (PDT)
From: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
To: jonas.gorski@gmail.com,
	florian.fainelli@broadcom.com,
	andrew@lunn.ch,
	olteanv@gmail.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	vivien.didelot@gmail.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	dgcbueu@gmail.com
Cc: =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= <noltari@gmail.com>
Subject: [PATCH net-next v4 04/14] net: dsa: b53: detect BCM5325 variants
Date: Sat, 14 Jun 2025 09:59:50 +0200
Message-Id: <20250614080000.1884236-5-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250614080000.1884236-1-noltari@gmail.com>
References: <20250614080000.1884236-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

We need to be able to differentiate the BCM5325 variants because:
- BCM5325M switches lack the ARLIO_PAGE->VLAN_ID_IDX register.
- BCM5325E have less 512 ARL buckets instead of 1024.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 24 +++++++++++++++++++++---
 drivers/net/dsa/b53/b53_priv.h   | 19 +++++++++++++++++++
 2 files changed, 40 insertions(+), 3 deletions(-)

 v4: add changes requested by Jonas and other improvements:
  - Introduce variant_id field in b53_device.
  - Reduce number of ARL buckets for BCM5325E.
  - Disable ARLIO_PAGE->VLAN_ID_IDX access for BCM5325M.

 v3: detect BCM5325 variants as requested by Florian.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 9a038992f043..a7c75f44369a 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -1778,7 +1778,8 @@ static int b53_arl_op(struct b53_device *dev, int op, int port,
 
 	/* Perform a read for the given MAC and VID */
 	b53_write48(dev, B53_ARLIO_PAGE, B53_MAC_ADDR_IDX, mac);
-	b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
+	if (!is5325m(dev))
+		b53_write16(dev, B53_ARLIO_PAGE, B53_VLAN_ID_IDX, vid);
 
 	/* Issue a read operation for this MAC */
 	ret = b53_arl_rw_op(dev, 1);
@@ -2833,6 +2834,9 @@ static int b53_switch_init(struct b53_device *dev)
 		}
 	}
 
+	if (is5325e(dev))
+		dev->num_arl_buckets = 512;
+
 	dev->num_ports = fls(dev->enabled_ports);
 
 	dev->ds->num_ports = min_t(unsigned int, dev->num_ports, DSA_MAX_PORTS);
@@ -2934,10 +2938,24 @@ int b53_switch_detect(struct b53_device *dev)
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25, 0xf);
 		b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25, &tmp);
 
-		if (tmp == 0xf)
+		if (tmp == 0xf) {
+			u32 phy_id;
+			int val;
+
 			dev->chip_id = BCM5325_DEVICE_ID;
-		else
+
+			val = b53_phy_read16(dev->ds, 0, MII_PHYSID1);
+			phy_id = (val & 0xffff) << 16;
+			val = b53_phy_read16(dev->ds, 0, MII_PHYSID2);
+			phy_id |= (val & 0xfff0);
+
+			if (phy_id == 0x00406330)
+				dev->variant_id = B53_VARIANT_5325M;
+			else if (phy_id == 0x0143bc30)
+				dev->variant_id = B53_VARIANT_5325E;
+		} else {
 			dev->chip_id = BCM5365_DEVICE_ID;
+		}
 		break;
 	case BCM5389_DEVICE_ID:
 	case BCM5395_DEVICE_ID:
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index a5ef7071ba07..e8689410b5d0 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -84,6 +84,12 @@ enum {
 	BCM53134_DEVICE_ID = 0x5075,
 };
 
+enum b53_variant_id {
+	B53_VARIANT_NONE = 0,
+	B53_VARIANT_5325E,
+	B53_VARIANT_5325M,
+};
+
 struct b53_pcs {
 	struct phylink_pcs pcs;
 	struct b53_device *dev;
@@ -118,6 +124,7 @@ struct b53_device {
 
 	/* chip specific data */
 	u32 chip_id;
+	enum b53_variant_id variant_id;
 	u8 core_rev;
 	u8 vta_regs[3];
 	u8 duplex_reg;
@@ -165,6 +172,18 @@ static inline int is5325(struct b53_device *dev)
 	return dev->chip_id == BCM5325_DEVICE_ID;
 }
 
+static inline int is5325e(struct b53_device *dev)
+{
+	return is5325(dev) &&
+		dev->variant_id == B53_VARIANT_5325E;
+}
+
+static inline int is5325m(struct b53_device *dev)
+{
+	return is5325(dev) &&
+		dev->variant_id == B53_VARIANT_5325M;
+}
+
 static inline int is5365(struct b53_device *dev)
 {
 #ifdef CONFIG_BCM47XX
-- 
2.39.5


