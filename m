Return-Path: <netdev+bounces-196843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EDD9DAD6B04
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 10:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D6E187ACF46
	for <lists+netdev@lfdr.de>; Thu, 12 Jun 2025 08:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D12A922A7F9;
	Thu, 12 Jun 2025 08:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="friikbIv"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E411A2253EA;
	Thu, 12 Jun 2025 08:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749717477; cv=none; b=drJFHM3nLNheAnxX1XszFRZ9dqmEM2Drg1Z2B4fnerN45syjvf0yVFIygCtfxWoFVIvwqbGfw4o5GEJq8X4M/CGvA2h/VXqaLOgKqaVLldhpb8f4MD125vlLkjt6BiiESJXu2mELdsziEnYrDm70w+yUakmVwqKJfL6RdMNec4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749717477; c=relaxed/simple;
	bh=5kNxnD3+SbZKfPXiMYutEJNsOJl+xVYKVGc6E8RoHKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SMVu4tN8Xtm3SAdVu2EPRV4DtM6MwfNShf2KlrISNq5+F6a+je81yYfdDHkV6uqYu05dh9pSkH/cVQzCTFTVKEvh0JaM6Y5pfGMCu+Gi1vsr9OgEPEXwNE/Jzg8maZBwjF5irh0VlBUAhxApmePqh7v44FoVrOGnoARay0kJ7uw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=friikbIv; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-450ce671a08so3660545e9.3;
        Thu, 12 Jun 2025 01:37:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749717474; x=1750322274; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/3vjBnVSsL/AVQ5DWQO6/WstPUY+2e2Mt4DVotijAg0=;
        b=friikbIvJ2LRbsUEaDmsMo1fKDnUfGoPsWucAqEEl5+eS1oEHaEBek+gIG+LGw+igp
         kzRq2orBD3u/jwcyt4YKXinIIrixcZBRuEjT4fab587V6IQwx9v40a3GoBifx54gV9b5
         I15n4396jJ7Ssw8OPbRXKRL5ZF9ZQC7B/nNGujBKfGxfo/ra5K/RJGPOS70TB6bsOobY
         SisA9+OWDXIi9pCT4HAQ//7bYBFxOuZwu5DCBytT5e6A8/2FvDZAK3Xe+Rpvl5VaAok4
         6SG6DtArIXQUQXyzwvp4D2RQPhcAiBBHGydQ8e0hbhGQfywFgVXGgDr6cGF4PCiFMdRb
         jxwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749717474; x=1750322274;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/3vjBnVSsL/AVQ5DWQO6/WstPUY+2e2Mt4DVotijAg0=;
        b=bzKeRi3jXnN1Rg5xOPkwsnSseO6wisnOMzm9GCg8XjXk3R1epnRJnaCBrVrsnVKwiP
         9lobb/XFqZcP3rN/H48C+fQYhRZQBgaVBHKfeNkANHvSDTSV4TEtQXQNA3/P9eSPB1Hs
         Ts0nW8PVlxo5hUv0ZdYcbIuE6InvGzuiAyP9COgIJ0hFNPsGNutNkjeSyJ1UoUFETs6m
         uta+6immt36ZaOn14NDS7/8EEHggBZcBYHjxqTx2thOQIUa8RIuGe9IY3Rpimx4tzKzm
         936LqQUSbMthBQNAlhQRE0nbnD1gAdHhSV5PU+9eSeD8S8cC7kPw8xNEKHBWxrTeEMlR
         hWVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUHe1EYmBzuAOGH/kHPCsv6YcmbvaxJJ6JPyF1c7E4sLo/DIVaNJ/xwE1hMu5pVV6N9ZH6GFCnj6yzI4wQ=@vger.kernel.org, AJvYcCXGsNgs3/C7GFcgn+oqsSzY7ypomP7vdW11U1JjgTZptPp9QaxRClKWN+ZCoQqiq2GgzZzvk8DX@vger.kernel.org
X-Gm-Message-State: AOJu0YyLV0MMFcEBr2js8lYOEoiHp7/r/K9pkbz8gabIBBueMCpYCA3M
	BMmiQeh75RBXm4FEL+3Rcxpc1H9WqXlVNThCVSPpYSUL5bOzP4dcZJTr
X-Gm-Gg: ASbGncvYBOF4f0bZIPDsjiWG5tSaF4P198RtMujwQ5VwJCJKM3njdC4w8fLPYLSJ+ob
	FZy9U/84qQ1IlCf36zxrrXEGxVuJLmvMzHcdAV4Y5FIrPBabmzW/WRVG9nFHwY3VHgwc1yXkQXQ
	OAAZ9g/sZD7hU65+lTApLUiOZgWBOUeipCeDEfKNQA9lJKMFfKlDuSuX9mss79XODYxpQisFuP4
	JLm5tidKWIn3bPj4jWRZ7kanK2Tus8CjJIBHE2OfOIphTQ4y8U53/9aV/H9v/3ZGgTgiiKpF3y/
	rx68iP5sQQNCqwUjkDqwTXzVRvaMsVXvhAqtPRZctZzT2AwjoF1T9moAJlayrPmI1kZIwhfFRIL
	GRtKFP+iTd+I0YVMYRuTpmbIuG/dyezUa1IXvTphhjlyyz+bnuiSVIzinbOI18mGIPAh5INN2m4
	hBmFC1tE2ybvKs
X-Google-Smtp-Source: AGHT+IFu6ZfTNThPdqjaL1g5Hw21C3pnbqFrHDMpBXbwlPnr/OVqxocUuZQkdwM3BG16HzqRkLhy+w==
X-Received: by 2002:a05:6000:250e:b0:3a4:eda1:6c39 with SMTP id ffacd0b85a97d-3a561308a8emr1635284f8f.13.1749717473894;
        Thu, 12 Jun 2025 01:37:53 -0700 (PDT)
Received: from slimbook.localdomain (2a02-9142-4580-1900-0000-0000-0000-0011.red-2a02-914.customerbaf.ipv6.rima-tde.net. [2a02:9142:4580:1900::11])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e224956sm13350975e9.4.2025.06.12.01.37.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jun 2025 01:37:53 -0700 (PDT)
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
Subject: [PATCH net-next v3 04/14] net: dsa: b53: detect BCM5325 variants
Date: Thu, 12 Jun 2025 10:37:37 +0200
Message-Id: <20250612083747.26531-5-noltari@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250612083747.26531-1-noltari@gmail.com>
References: <20250612083747.26531-1-noltari@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Older BCM5325M switches lack some registers that newer BCM5325E have, so
we need to be able to differentiate them in order to check whether the
registers are available or not.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 34 ++++++++++++++++++++++++++------
 drivers/net/dsa/b53/b53_priv.h   | 16 +++++++++++++--
 2 files changed, 42 insertions(+), 8 deletions(-)

 v3: detect BCM5325 variants as requested by Florian.

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 222107223d109..2975dab6ee0bb 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2490,8 +2490,18 @@ struct b53_chip_data {
 
 static const struct b53_chip_data b53_switch_chips[] = {
 	{
-		.chip_id = BCM5325_DEVICE_ID,
-		.dev_name = "BCM5325",
+		.chip_id = BCM5325M_DEVICE_ID,
+		.dev_name = "BCM5325M",
+		.vlans = 16,
+		.enabled_ports = 0x3f,
+		.arl_bins = 2,
+		.arl_buckets = 1024,
+		.imp_port = 5,
+		.duplex_reg = B53_DUPLEX_STAT_FE,
+	},
+	{
+		.chip_id = BCM5325E_DEVICE_ID,
+		.dev_name = "BCM5325E",
 		.vlans = 16,
 		.enabled_ports = 0x3f,
 		.arl_bins = 2,
@@ -2938,10 +2948,22 @@ int b53_switch_detect(struct b53_device *dev)
 		b53_write16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25, 0xf);
 		b53_read16(dev, B53_VLAN_PAGE, B53_VLAN_TABLE_ACCESS_25, &tmp);
 
-		if (tmp == 0xf)
-			dev->chip_id = BCM5325_DEVICE_ID;
-		else
+		if (tmp == 0xf) {
+			u32 phy_id;
+			int val;
+
+			val = b53_phy_read16(dev->ds, 0, MII_PHYSID1);
+			phy_id = (val & 0xffff) << 16;
+			val = b53_phy_read16(dev->ds, 0, MII_PHYSID2);
+			phy_id |= (val & 0xffff);
+
+			if (phy_id == 0x0143bc30)
+				dev->chip_id = BCM5325E_DEVICE_ID;
+			else
+				dev->chip_id = BCM5325M_DEVICE_ID;
+		} else {
 			dev->chip_id = BCM5365_DEVICE_ID;
+		}
 		break;
 	case BCM5389_DEVICE_ID:
 	case BCM5395_DEVICE_ID:
@@ -2975,7 +2997,7 @@ int b53_switch_detect(struct b53_device *dev)
 		}
 	}
 
-	if (dev->chip_id == BCM5325_DEVICE_ID)
+	if (is5325(dev))
 		return b53_read8(dev, B53_STAT_PAGE, B53_REV_ID_25,
 				 &dev->core_rev);
 	else
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index a5ef7071ba07b..deea4d83f0e93 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -60,7 +60,8 @@ struct b53_io_ops {
 
 enum {
 	BCM4908_DEVICE_ID = 0x4908,
-	BCM5325_DEVICE_ID = 0x25,
+	BCM5325M_DEVICE_ID = 0x25,
+	BCM5325E_DEVICE_ID = 0x25e,
 	BCM5365_DEVICE_ID = 0x65,
 	BCM5389_DEVICE_ID = 0x89,
 	BCM5395_DEVICE_ID = 0x95,
@@ -162,7 +163,18 @@ struct b53_device {
 
 static inline int is5325(struct b53_device *dev)
 {
-	return dev->chip_id == BCM5325_DEVICE_ID;
+	return dev->chip_id == BCM5325E_DEVICE_ID ||
+		dev->chip_id == BCM5325M_DEVICE_ID;
+}
+
+static inline int is5325e(struct b53_device *dev)
+{
+	return dev->chip_id == BCM5325E_DEVICE_ID;
+}
+
+static inline int is5325m(struct b53_device *dev)
+{
+	return dev->chip_id == BCM5325M_DEVICE_ID;
 }
 
 static inline int is5365(struct b53_device *dev)
-- 
2.39.5


