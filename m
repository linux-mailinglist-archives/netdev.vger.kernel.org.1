Return-Path: <netdev+bounces-184093-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 79573A9350C
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 11:03:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C052B3AC67F
	for <lists+netdev@lfdr.de>; Fri, 18 Apr 2025 09:02:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE3DA26F449;
	Fri, 18 Apr 2025 09:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NERegK84"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279BD26E162
	for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 09:02:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744966981; cv=none; b=UeFxBsA9tn77etjXUkHjMQtnpWfGXo6hIuxHyum8BzrvU8sJAApNBjNdtMy5vSg88raTmtvaw1rd3ULGT0qlDRXsVckvvvL0soXjmqN8TjXdp1Earc+Fq562+393Z7wKM4+oYsgzkTL8rJ0p4+EU36yfYi3y1qUFluGWXlfZhJY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744966981; c=relaxed/simple;
	bh=iCS7wgYyddvV5xjUuSIlYDS0MobsMn91cxM9cMUVqwo=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:Content-Type; b=BcRf3ITv9lY1OPYwE858YFN9ei53r7afURq23dgyJJvMIZRhVD7cW+mKM5ArfqBAfRLHKSDZl0s2MeiW8TVbjE3GdFr3GlgnnAzqm5jBay3hlqT8EDmwRifQMfOgG8NRN3Y5k0+15U5Ui71FWzrl6iZLVFAoBX2HbzneLFb/WQs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NERegK84; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-43cebe06e9eso13634385e9.3
        for <netdev@vger.kernel.org>; Fri, 18 Apr 2025 02:02:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744966978; x=1745571778; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4atSrq3QLaKsFiy4Txe8A/PYSbYP/gPGwaO+RMGAeK4=;
        b=NERegK84v3gI4q2LV4572MPnzb9cLblyJIW9OYv60gVNw8nXtTan263Iy4bu8udvQB
         uwBGhIRp24um3n5Q1g4/cRAHU55ydSupVLCzlpZQ1eT25WiAyC5Ituj1ht8WLHiRM4ls
         6q+KQj83uk6QtW0aKZmujoGoFDsCk5PiNB9hc/j1Ob9yUOQ/OPcBYKVKo90wXu65+0l3
         HA0qeJydeY8XawJqU1SPD42l/oTa/KewemmPJARH6qoZfQeKMK4N8Lx9e9Z96ZyVEIgw
         wILP5xiC2KsinogUayEqroZXFEFoIOh1Prc9GVbSi1fXJRApRQsVFFMJYU+41tvOYsgV
         EENQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744966978; x=1745571778;
        h=content-transfer-encoding:cc:to:subject:autocrypt:from
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4atSrq3QLaKsFiy4Txe8A/PYSbYP/gPGwaO+RMGAeK4=;
        b=HT9dxZYlFOpjnj8YKn8LkHmL2DPBtjeL/fpPVxaIxUm3Rjas9dctYJvyhAHlA/3Q8o
         dhauHsSS/nvc5+JOJk+EjoHdtvR5C/jA06W9WXGRaAM3pWvBua6MMmMv8a3NhIihiJas
         RV4apZDUCdMHb81voWW+cBfMYpzJZ2gIq8FLobeDBv9qylAlTjfDfCLgBUM3FdJMhP/5
         lPtwcoWph3onfeW+3tRZkHXUkqlKVBl7a622vYXRhvhMoZywXa7Z+YJHeqo1yGFoh5vG
         D898T0y1+O7rdNYJsXFw18aKeEd0oG0W8FjSjMGbCESCXF68ZyZuRCYZvlf2zENeEFV5
         Tq5w==
X-Gm-Message-State: AOJu0Yxynq6cVQmIvdUjYjl3Qylt71MkK18yVZqsSyqU28DnoJfzZFQP
	EGByaDb5EJdhXRYqrM88hdXibaQTw8kOrR45t3OBqrdJ9IxkKFoP
X-Gm-Gg: ASbGnctCPZp5+OxC208X9s/VXgbO18rLhVJ/QgVnGmZSKqw0bSnhaS0GAOOQEmHNYmS
	OOGp8KgNd09wjo7FeFvMMHJ2hgQHYzRqY4dHyQpcU8qZSxQHI+dHQqofXv62uvOHUhTqadfRv4L
	DlqnqobYXjdahY3lexq8ghQQk3CklFiMrxiEO1654cdjOkIG4SIswTYdYG2Ke8DTrjW3xij8CEa
	hmrkQBoBwP8EFczbmjPDY3eeD9MXKiCwTjK5CJpSWlplfqQQwY7/tss5dmtgOhqEF+ctYfEqkr5
	ehKvrfNV5oH/S2omb+udXV4iO4Cs1Obh7hCG4CSQvI+N3B7HJ6mzMeDnnvEAjHnI4E/4fEMXpKZ
	XowvYxwoK5fTVM/PhhS9JRYD8N/jsBrmTYievVYImMLW6ts4sdSXJbRzerVhOum8UDsxEQnpRYj
	KccV0/dWCKCeUYz813khoEdQ19aanmHzlj
X-Google-Smtp-Source: AGHT+IGqJgc6LTCV1MsE/WaZqIDUQDLUjUJh8APoPESjHMwKaHSY+bDrMDqvkg7aj3ntOlSks+12bA==
X-Received: by 2002:a05:600c:4f8f:b0:440:54ef:dfdc with SMTP id 5b1f17b1804b1-4406ab9342dmr13194415e9.8.1744966977977;
        Fri, 18 Apr 2025 02:02:57 -0700 (PDT)
Received: from ?IPV6:2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8? (dynamic-2a02-3100-a14c-6800-64c1-f857-3ca4-c5c8.310.pool.telefonica.de. [2a02:3100:a14c:6800:64c1:f857:3ca4:c5c8])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-39efa433354sm2187395f8f.32.2025.04.18.02.02.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 02:02:57 -0700 (PDT)
Message-ID: <f7a69a1f-60e9-4ac0-8b7c-481e0cc850e7@gmail.com>
Date: Fri, 18 Apr 2025 11:04:01 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
From: Heiner Kallweit <hkallweit1@gmail.com>
Autocrypt: addr=hkallweit1@gmail.com; keydata=
 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
Subject: [PATCH net-next] net: phy: remove function stubs
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

All callers of these functions depend on PHYLIB or select it directly
or indirectly by selecting PHYLINK. Stubs make sense for optional
functionality, but that's not the case here.

MDIO_XGENE usually is selected by NET_XGENE which also selects PHYLIB.
Add a dependency to PHYLIB nevertheless, in order not to break
randconfig builds.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/mdio/Kconfig |  1 +
 include/linux/phy.h      | 37 -------------------------------------
 2 files changed, 1 insertion(+), 37 deletions(-)

diff --git a/drivers/net/mdio/Kconfig b/drivers/net/mdio/Kconfig
index 4a7a303be..4687339b7 100644
--- a/drivers/net/mdio/Kconfig
+++ b/drivers/net/mdio/Kconfig
@@ -57,6 +57,7 @@ config MDIO_SUN4I
 config MDIO_XGENE
 	tristate "APM X-Gene SoC MDIO bus controller"
 	depends on ARCH_XGENE || COMPILE_TEST
+	depends on PHYLIB
 	help
 	  This module provides a driver for the MDIO busses found in the
 	  APM X-Gene SoC's.
diff --git a/include/linux/phy.h b/include/linux/phy.h
index fb755358d..5e1f4ad1f 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1753,7 +1753,6 @@ int phy_modify_paged(struct phy_device *phydev, int page, u32 regnum,
 struct phy_device *phy_device_create(struct mii_bus *bus, int addr, u32 phy_id,
 				     bool is_c45,
 				     struct phy_c45_device_ids *c45_ids);
-#if IS_ENABLED(CONFIG_PHYLIB)
 int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id);
 struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode);
 struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode);
@@ -1761,42 +1760,6 @@ struct fwnode_handle *fwnode_get_phy_node(const struct fwnode_handle *fwnode);
 struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45);
 int phy_device_register(struct phy_device *phy);
 void phy_device_free(struct phy_device *phydev);
-#else
-static inline int fwnode_get_phy_id(struct fwnode_handle *fwnode, u32 *phy_id)
-{
-	return 0;
-}
-static inline
-struct mdio_device *fwnode_mdio_find_device(struct fwnode_handle *fwnode)
-{
-	return 0;
-}
-
-static inline
-struct phy_device *fwnode_phy_find_device(struct fwnode_handle *phy_fwnode)
-{
-	return NULL;
-}
-
-static inline
-struct fwnode_handle *fwnode_get_phy_node(struct fwnode_handle *fwnode)
-{
-	return NULL;
-}
-
-static inline
-struct phy_device *get_phy_device(struct mii_bus *bus, int addr, bool is_c45)
-{
-	return NULL;
-}
-
-static inline int phy_device_register(struct phy_device *phy)
-{
-	return 0;
-}
-
-static inline void phy_device_free(struct phy_device *phydev) { }
-#endif /* CONFIG_PHYLIB */
 void phy_device_remove(struct phy_device *phydev);
 int phy_get_c45_ids(struct phy_device *phydev);
 int phy_init_hw(struct phy_device *phydev);
-- 
2.49.0


