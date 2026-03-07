Return-Path: <netdev+bounces-265192-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4OxuGbqZrGlarAEAu9opvQ
	(envelope-from <netdev+bounces-265192-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:33:46 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7162C22DB9E
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 22:33:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9A53D300980E
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 21:33:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CC03290AF;
	Sat,  7 Mar 2026 21:33:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YNYfBIxm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8389F25E469
	for <netdev@vger.kernel.org>; Sat,  7 Mar 2026 21:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772919220; cv=none; b=bk9oaNqBdmDYA7o7b2P8fU73YnGMbQPGOU24yPWenVeELXHRs0t7vkkxY5X/KiglC3kGITjX6IXAY64IK2sEUx+DIn5Ug9sdebezc8zQ88Pg7qtWWFCwRgUn7anyMIi8xSXnjwdgM2OWgqdNsAg0KmK3RP1BgaWQrECkD6ZTh7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772919220; c=relaxed/simple;
	bh=/dIZrM5IUttYsSyyQTMorm0yElUCp9TuGSDmE5kDcdU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=qd++KnzFIe+xbcPBTWjkGIqVsK/TKis5FOzkfHYJjC65f2LCuQWlBEAFAdPDjC4oO2RGAzqlrJdHAEZzh5hBilYhd/oq884c9w/dZnqiLuBRQU4Ub4pJVt7INjZo05XpENHZNJE5Le5FsZXtBWgcy8FYwP4plxyLiQJ8OgGkRkU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YNYfBIxm; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-4852afd42ceso12229015e9.2
        for <netdev@vger.kernel.org>; Sat, 07 Mar 2026 13:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772919218; x=1773524018; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EjqtMmTP6qLcmK14ISsOFqL48TISXYv0ejZVuQlmDiE=;
        b=YNYfBIxmqqEsWPKcHEmL9rcPJiZNej7yESJDNa6WIbuKyfEsBKl9JymST9+qsG6Au3
         m6dFY7wg8M7f39akd7y1XfGJfGq7BHxlrkggIKtn74RlrbOFXlS4lxvabbZ4SS+j8DtS
         gjnZNgG2jJ4RBf9gMdHsNApv7buhbw3D1TAolv4m3ep5HYg/v2NVwwmYTI7U+qPLpt5z
         m0rnysk0OoH4zsascZ9ek7crnjAbHuOOQvpjM3wEs1XFLOcqncrFEG/3aflnhldGsAs6
         xhJn/tzXW29DhWVdjEQu5V9R2Z5g2VzMiebVItbfYf/82L3pqUJ6zAiNcGMc0BlHEQ7+
         07bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772919218; x=1773524018;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EjqtMmTP6qLcmK14ISsOFqL48TISXYv0ejZVuQlmDiE=;
        b=qhCHb22dnKY3p/MR9rTvNr0PeSnLNwZEquzWBD3EakkVLuObbiz88x1kzCBbADgGwA
         SHmDOwol8kvAhO3/U8Cq4cATvsEiK4btIA0gdWhcTC4Az8rqYeaKFEdfGl6kawogMwMc
         a+lN4Pp0876kU+ZeLl107PaU8cYBdmneSs+k2GfkuUOuB3STD7dMjK8H04IyWT5JzIRT
         LHSbgINX6yXywIF0eXhupJjaBW5t5PtkVHSw0n9IQVMJU+KgmizsRl50po9F3gUwLQ3I
         RZp4elBG9Ioa8Ktvi46T/FRaGyAVbw9CUWah7cmEjxQpCS6GacWMGEnWQsotKJ/D/Y1n
         7tVA==
X-Gm-Message-State: AOJu0Yzqmvlak0DH8e/LKv/CWG/jnkQcrUd9svDI9OPJ+gtKG9pa5ZX8
	MdlE8Cd1LGtdu71RUy8ESa9qrCAxhwPG/2aMH7MmVJ11vZnmZw/zb6k88thdsA==
X-Gm-Gg: ATEYQzxlsGuY4uxjD3EFW1jYR+4gJpaFZPV0AkBv3mAuBnJW+ANw1kv5TEQlcOYr9QM
	M8aTmvww/NyLFDfI88fyjs0FQK6iyiDz+DxxIWkDrbdeKeqSQqtmcGzwtgRbfwp2KEDjytaUH/X
	Cs6QeEeh+0Jz3SdONSEXXdDo9nWFr6iiV3yu9b7MN71bKNRWwrzVTz/1PBIAYxT+sMtZ4jLnfKG
	F2vCAAGIHr/Gj3T79zaek+WPfOW+hgJggdhvh4PAmI0kKQPELLXADLXZF04DVbYJG5AaGOSSIan
	ABve/e/JpQaIV4PO/wZIOq9a1pU0h63zGJ7ZnFtTDqAWfkgYK/DFWFusBk2u5zi4Y8SASo6MIhq
	A1KC7Q3Fa7xEdDGL84fI/lnwD1BBsu3gm8Zm27CSEhPZYqg2ofpky7nU1dCDRQK3woMdULF/URd
	yNx70IKJJE+xxYX15yJp2pUCS2jM5OUV22/jFtLteXUxGe8pmft3mCJ4skBJt9rfmwX1ExGUXQy
	JvR1v+KjzNHTnzTwxkebeVJ2/eIMCSB31k5bwNfg/EaFGACQffVVMDkr/9n+tpxOw==
X-Received: by 2002:a05:600c:3acf:b0:483:6bb1:117 with SMTP id 5b1f17b1804b1-48526978984mr105433475e9.32.1772919217760;
        Sat, 07 Mar 2026 13:33:37 -0800 (PST)
Received: from ?IPV6:2003:ea:8f0f:7f00:f48b:e818:2b17:74e3? (p200300ea8f0f7f00f48be8182b1774e3.dip0.t-ipconnect.de. [2003:ea:8f0f:7f00:f48b:e818:2b17:74e3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4853044d849sm95181655e9.11.2026.03.07.13.33.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Mar 2026 13:33:37 -0800 (PST)
Message-ID: <42d94a7e-2c07-476c-b2f8-f3051f1b1222@gmail.com>
Date: Sat, 7 Mar 2026 22:33:36 +0100
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH net-next 4/5] net: phy: move registering mdio_bus_class and
 mdio_bus_type to libphy
From: Heiner Kallweit <hkallweit1@gmail.com>
To: Andrew Lunn <andrew@lunn.ch>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 David Miller <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Philipp Zabel <p.zabel@pengutronix.de>
References: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Language: en-US
In-Reply-To: <8b34944e-3abf-4dd1-908d-c21d08c62c34@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 7162C22DB9E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-265192-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hkallweit1@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.832];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Action: no action

The MDIO consumer side shouldn't register class and bus_type.
Therefore move this to libphy.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
---
 drivers/net/phy/mdio_bus.c   | 23 -----------------------
 drivers/net/phy/phy_device.c | 13 +++++++++++++
 2 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/drivers/net/phy/mdio_bus.c b/drivers/net/phy/mdio_bus.c
index c9a495390d2..9fb47332602 100644
--- a/drivers/net/phy/mdio_bus.c
+++ b/drivers/net/phy/mdio_bus.c
@@ -905,28 +905,5 @@ const struct bus_type mdio_bus_type = {
 };
 EXPORT_SYMBOL(mdio_bus_type);
 
-static int __init mdio_bus_init(void)
-{
-	int ret;
-
-	ret = class_register(&mdio_bus_class);
-	if (!ret) {
-		ret = bus_register(&mdio_bus_type);
-		if (ret)
-			class_unregister(&mdio_bus_class);
-	}
-
-	return ret;
-}
-
-static void __exit mdio_bus_exit(void)
-{
-	class_unregister(&mdio_bus_class);
-	bus_unregister(&mdio_bus_type);
-}
-
-subsys_initcall(mdio_bus_init);
-module_exit(mdio_bus_exit);
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("MDIO bus/device layer");
diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index d1cbcfc3d2a..0edff47478c 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -3913,6 +3913,14 @@ static int __init phy_init(void)
 {
 	int rc;
 
+	rc = class_register(&mdio_bus_class);
+	if (rc)
+		return rc;
+
+	rc = bus_register(&mdio_bus_type);
+	if (rc)
+		goto err_class;
+
 	rtnl_lock();
 	ethtool_set_ethtool_phy_ops(&phy_ethtool_phy_ops);
 	phylib_register_stubs();
@@ -3941,6 +3949,9 @@ static int __init phy_init(void)
 	phylib_unregister_stubs();
 	ethtool_set_ethtool_phy_ops(NULL);
 	rtnl_unlock();
+	bus_unregister(&mdio_bus_type);
+err_class:
+	class_unregister(&mdio_bus_class);
 
 	return rc;
 }
@@ -3953,6 +3964,8 @@ static void __exit phy_exit(void)
 	phylib_unregister_stubs();
 	ethtool_set_ethtool_phy_ops(NULL);
 	rtnl_unlock();
+	bus_unregister(&mdio_bus_type);
+	class_unregister(&mdio_bus_class);
 }
 
 subsys_initcall(phy_init);
-- 
2.53.0



