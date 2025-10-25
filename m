Return-Path: <netdev+bounces-232914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B3E8C09EA4
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 20:50:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F03191B24E41
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 18:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842EE301039;
	Sat, 25 Oct 2025 18:49:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ca3NAAkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A430B2D978A
	for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 18:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761418196; cv=none; b=lhXgTul4aH18OCpSXUZv+tFTHEFGRKCvv2BH4WEcVBQpgn/qvQqKWNvj0SJdmp1S/pUl7SDIf31U6v8tvhuCQAtgGUKs3Jbx/S22oqz5OoNa68hRbKoQuQtfhp7xPZ3qtDSqiUN08gibgoRPaPa2l7dfyqaAHSBseYyuOhvoS1w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761418196; c=relaxed/simple;
	bh=1c8VwZwCLQgKitT09IMgpoLdbo8O8tL2/Cjsynfmiis=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eB6f35umjog3S1NvycuzdLdJCWwHOBy4aDRXQKDZeS9j8azTrB55n7HJs+6a3a+6Kel43hiJtbW3DgxP8oC04dxwub5rzlg8GOOcPxRcad/83bDUqJXYZ5xytQechoYOWUFrur4qHunegCcUd6h50ZcYCo+VMFz9IKX80bUAhSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ca3NAAkW; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-47114a40161so34358105e9.3
        for <netdev@vger.kernel.org>; Sat, 25 Oct 2025 11:49:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761418193; x=1762022993; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=YOP1Dq47ETt740QI5S9S9RVh1nYdnTXk8kdvsRVfgJc=;
        b=ca3NAAkWkdg+Ph+CIgrAy43Fgad3W/eugC+H++UsA0R3k3diAdYU4qr4bqsJGUzIMv
         wwg8hhVXqFKQ3i7wvRuH3uL1jLzG64E+PvL1+POvaYzMUR2XkPkItXpJMCiyHwDWKYgF
         MsabGKpmTtvEiR58Grbvy0gND2GHJLOPhcOLvQt82ADXzZnzLGI6CHMd1mlE65AdVP/N
         BjlVFUoNNcZSZYKjsSWPoQ8FicBaiBt4aPmV6OwVqoshpdmQ9yUs7a4Zp9scaZ2fxM8X
         6Lx0TcsuGmf/XdQAK3H65jRHDLtsSFd5bmWuL+y2UxtBnw29zbE/2qTcWvnXLYOGJA4K
         2UUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761418193; x=1762022993;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YOP1Dq47ETt740QI5S9S9RVh1nYdnTXk8kdvsRVfgJc=;
        b=xQzVTUkLknHg2oVtARMZ32AjqM0GmAo/b+3a+MdK+2tuvPiDI+QvycRnMHb9OfttZ1
         mTDE5jO1UAQqHRuC1cjsXZFfZOHkX3+8UOHHQiUnLAvgNxpsUJG8q+TqLEYSCi0CLfEu
         VZXjxdand1HHeQwdEsvsnW82gdvHor4kfm5+aDXM2KqBFGvPwhRrv3f642HBXI5dNNZV
         +dvTTnWCV14CbMZyWcGYLKwkgb0DHM2WYwlCb+uuNFzMWK2tBKBpq1JnLQ6Xi7JjSWMJ
         8B0CCtQ7Q1cPp/WsZKuCpTzNeYK07K8k/lH9L22OkF0lR8inbj8+BSP8840s4JD59jN0
         uEaA==
X-Gm-Message-State: AOJu0YwZHhW0SHfABR3si23KLdusVi5p0tIoDkoWzNH4+r20UvfQ9oYg
	xvlzQG5N0v51eDgcWRl6r96YxyA0FXBhf0zGp3Fq+ERe/LFs2RSY0J2a
X-Gm-Gg: ASbGncs5o1THd1FWZWrcSCjjkY42brAij5s8Pv/ffbVHkygiERLX1fLLwBGeKdNTvr+
	0QhstOjYoiFWuPqmqy09vyST0X/+8k/xevEotIsH//he4nIdKJMjfHX6uPMLlPMOmUt9A2Kd6ca
	EkFTj104YpuoTlYAK9Q1BfdOLNxMBU69fWfY16hmIYHW82Awig7DYOseY10wrw/WByGJ4ypw3Ux
	LafS26hesXEj47kVhIquEjHroxE4kjE0EY8n2NC3KM0q+2+lqXwS7vMdTp8mLY8L/M2vmbtx08x
	4e+B2EjwjpxXEd6lCzqETEGYqch9+Y7vIbLi90mLN0PbPrVdT0QelInD8lujpenMqOQrY7c351A
	yjRHNiGqLAPPm+PwM8NFNV5VWwq6SGJNyv7Ww/oZrL3eq71UI5w0ABUkXn5nF5O+gANW2fJfEu4
	++fjBC5gu3b8ADup4H74B7tE+Y1VyBuregxoi2wDnk8+iOuKq8VxWKo4D88JDe86k4n0jj+vjII
	Td11i0UpL8z9bYlCkyno+d4sUJ/DOd5O20jbkOaFBto1bkwZSwWfg==
X-Google-Smtp-Source: AGHT+IGg1HBIr268jUp/OkiHLu7m8BYHJzQgps2UOW+w9yzyN2Jc6WgsG9eUuNap4D78HMtAusreFQ==
X-Received: by 2002:a05:600c:4f09:b0:475:de14:db25 with SMTP id 5b1f17b1804b1-475de14dc59mr17418675e9.28.1761418192733;
        Sat, 25 Oct 2025 11:49:52 -0700 (PDT)
Received: from ?IPV6:2003:ea:8f39:8b00:d401:6211:9005:e76e? (p200300ea8f398b00d40162119005e76e.dip0.t-ipconnect.de. [2003:ea:8f39:8b00:d401:6211:9005:e76e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952b7b22sm4903790f8f.9.2025.10.25.11.49.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Oct 2025 11:49:52 -0700 (PDT)
Message-ID: <cd112f15-401a-43d9-8525-9ff0965a68cd@gmail.com>
Date: Sat, 25 Oct 2025 20:49:50 +0200
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 net-next 1/4] net: phy: add iterator mdiobus_for_each_phy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>,
 Clark Wang <xiaoning.wang@nxp.com>, Siddharth Vadapalli
 <s-vadapalli@ti.com>, Roger Quadros <rogerq@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Andrew Lunn <andrew+netdev@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Paolo Abeni <pabeni@redhat.com>, Jakub Kicinski <kuba@kernel.org>,
 Eric Dumazet <edumazet@google.com>, David Miller <davem@davemloft.net>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 linux-omap@vger.kernel.org, imx@lists.linux.dev
References: <07fc63e8-53fd-46aa-853e-96187bba9d44@gmail.com>
Content-Language: en-US
In-Reply-To: <07fc63e8-53fd-46aa-853e-96187bba9d44@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Add an iterator for all PHY's on a MII bus, and phy_find_next()
as a prerequisite.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
v3:
- add missing return value description for phy_find_next
---
 drivers/net/phy/phy_device.c | 16 +++++++++-------
 include/linux/phy.h          | 11 ++++++++++-
 2 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 7a67c900e..c4fbacbc3 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -1214,22 +1214,24 @@ int phy_get_c45_ids(struct phy_device *phydev)
 EXPORT_SYMBOL(phy_get_c45_ids);
 
 /**
- * phy_find_first - finds the first PHY device on the bus
+ * phy_find_next - finds the next PHY device on the bus
  * @bus: the target MII bus
+ * @pos: cursor
+ *
+ * Return: next phy_device on the bus, or NULL
  */
-struct phy_device *phy_find_first(struct mii_bus *bus)
+struct phy_device *phy_find_next(struct mii_bus *bus, struct phy_device *pos)
 {
-	struct phy_device *phydev;
-	int addr;
+	for (int addr = pos ? pos->mdio.addr + 1 : 0;
+	     addr < PHY_MAX_ADDR; addr++) {
+		struct phy_device *phydev = mdiobus_get_phy(bus, addr);
 
-	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
-		phydev = mdiobus_get_phy(bus, addr);
 		if (phydev)
 			return phydev;
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(phy_find_first);
+EXPORT_SYMBOL_GPL(phy_find_next);
 
 /**
  * phy_prepare_link - prepares the PHY layer to monitor link status
diff --git a/include/linux/phy.h b/include/linux/phy.h
index 3c7634482..3809ca705 100644
--- a/include/linux/phy.h
+++ b/include/linux/phy.h
@@ -1848,7 +1848,7 @@ int phy_sfp_probe(struct phy_device *phydev,
 	          const struct sfp_upstream_ops *ops);
 struct phy_device *phy_attach(struct net_device *dev, const char *bus_id,
 			      phy_interface_t interface);
-struct phy_device *phy_find_first(struct mii_bus *bus);
+struct phy_device *phy_find_next(struct mii_bus *bus, struct phy_device *pos);
 int phy_attach_direct(struct net_device *dev, struct phy_device *phydev,
 		      u32 flags, phy_interface_t interface);
 int phy_connect_direct(struct net_device *dev, struct phy_device *phydev,
@@ -1875,6 +1875,15 @@ bool phy_check_valid(int speed, int duplex, unsigned long *features);
 int phy_restart_aneg(struct phy_device *phydev);
 int phy_reset_after_clk_enable(struct phy_device *phydev);
 
+static inline struct phy_device *phy_find_first(struct mii_bus *bus)
+{
+	return phy_find_next(bus, NULL);
+}
+
+#define mdiobus_for_each_phy(_bus, _phydev)		\
+	for (_phydev = phy_find_first(_bus); _phydev;	\
+	     _phydev = phy_find_next(_bus, _phydev))
+
 #if IS_ENABLED(CONFIG_PHYLIB)
 int phy_start_cable_test(struct phy_device *phydev,
 			 struct netlink_ext_ack *extack);
-- 
2.51.1



