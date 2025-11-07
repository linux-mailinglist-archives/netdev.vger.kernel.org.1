Return-Path: <netdev+bounces-236680-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BACD4C3EE48
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 09:11:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 32E7A3B27C4
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 08:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B3D7313289;
	Fri,  7 Nov 2025 08:08:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IwREXhVg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ECA9310644
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 08:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762502892; cv=none; b=Jm69JDd2SnAuXSv37467gU3/PFC4MdDCYtSCiF3F5cp89bf4umacAsrP94bnknCF/3LTDhc6PXQMEY7tzMV/XW2G/Js/eTga0xC+3BIavWpyqK+ul3botNvKjFKlB+/TEhml3m2x+mh1hyLcOQ+PFF/n0Iu8nyC1ZUcyVn52iRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762502892; c=relaxed/simple;
	bh=tMGAtjDdxCi9/9zWmB6IYJaxSxBHhxBmGXpAr5ob+3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ArJKxYtYOze4+hJ6esVnWL7A8JJjghE/eMP9vQbIdq9nS28LkZiJVTtXBc8YuQ1JfH6alKg0NS2vqcARFs5hnphf3b4YqGpQPBjFslX+aZJtwfczTYBpDZrdzQtgn+beBM/n4jTW3MWftAAwLi+pKdmpA9DPT8mYsMbyXilJh3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IwREXhVg; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b727f330dd2so66414566b.2
        for <netdev@vger.kernel.org>; Fri, 07 Nov 2025 00:08:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762502889; x=1763107689; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Iuf9P5KPx2jXNqYADTXinaVkfIdFLshS7KxiibOK2ZI=;
        b=IwREXhVgzD4e62dUNgrcTyCVsFd9yT2LK6WQ751XRwxa2wPwVzKrnXfibOX6e42dkX
         RHoGY9et4pKcKLwnbXjyL4jcQzE3aVdsBkd59rSQD6hyjlCv9M0wt61N/rLUKUfiZKeQ
         RjWEzoElWW38nHcrlxRfQxKomMVspRxb/jpH+UNxru3/FYq3vwMfGoBKYT0hYfdn8E3a
         40fd95Z5/djWpgmZACR/FXncrWbJmGTpCvaJA8k41QlM0TEMTYRIbTEdk641tJIzVaTf
         VnRjrsr+eo8zf5ZILOGF1Y90EZ8CSSINrxURVdulm8m8RSnMb7pFhl9N9iqWYrP7Qrx1
         QGNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762502889; x=1763107689;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Iuf9P5KPx2jXNqYADTXinaVkfIdFLshS7KxiibOK2ZI=;
        b=awPm6XqXuVeaWdWriTFAlY5HTusD3GNv1/bmN4Um0ubvWIAIK3/q6WFzLy8tu0WnIu
         dem7Y+hQlf8iGSwVlLiFZwKQYLjeHsI245OFDJjwfr9kFvgB1y1HY3YkHAN1iqvH8hKI
         RSl+gCBxg5CL4zDQQbi4dyLQBUMoF3QCWa/y0foTLsa0sVkOuoJgdWKCS59HUHHTFHB/
         qpMaNy9l/J1l4ay54oDiBDcRnOwlmlCDnypbQ3cv44ay9cz9241s/97YwoxZRRERR116
         +9VMaQsyXOTHLNr0GKFgYcD/jwtDC3KN9V6+SyAxctN9MzUaP55d/sHmYGPCCsG1en/K
         V6FA==
X-Gm-Message-State: AOJu0Yz/rI3ND7OoHfD+R4Im3q+4C5NMvhaLscgBmdajEjsUcf+ekK9K
	vFVV47jccaVZKp5IZDSeiMQ5k9XY+RC/VzmqcEKPdWx/XDk8fDIHAWYf
X-Gm-Gg: ASbGncuKaq2AA/v9Fg4m9lS7RzjH3XaL5wIlPoaPcRDdCghV2EERRSacYr4RgFcnPiG
	MHVtSQ3kNf2btXyn1XSDumRLIs/8gGfdvIpoipV/jGDFNooUaCAN6m79kUg7l2e0AaDs3O6bNgG
	7huxlO3JrtYmX2AQ+jKYosi4n0e+mC1TUOJILMgwEDk/+fy/sn8ToI7UICiUychDw8BrOE007Z1
	M/nrBD2owL/13T5e7ajhE966lXSp2Wq1+2tfKCUKjwbpbh/gFGmNRO72oPKTK5BtzYI/N8zowLX
	cwee2QMVw1V61N8fUnjbX9S4V/JC+zaTnDL5pli1kwixSQqK54OLmJeR1Pyn2HZ0ZijCfTxUd7S
	JpG3ohheKtZyaxZoNZHU8TKStEXEBPi/0AvsL+lZiAXXs5mlPfF/IC8REfnD4cnqb3Vc4IW7ynS
	jspiUA2dr1zMxTVA+weYltwmhwNdOLtMah6y9fNBp654k8cYt8QfoCLUyf
X-Google-Smtp-Source: AGHT+IFnFGkrt1uMk6QFxmhpBVkXne7MSZyK27z1FgCbLMCewD/ubpgl1IolJWXSTq/K3tor3E2dtg==
X-Received: by 2002:a17:907:6090:b0:b6d:7f28:4319 with SMTP id a640c23a62f3a-b72c08dc342mr219131966b.3.1762502888526;
        Fri, 07 Nov 2025 00:08:08 -0800 (PST)
Received: from localhost (dslb-002-205-018-238.002.205.pools.vodafone-ip.de. [2.205.18.238])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b72bf312240sm179779666b.18.2025.11.07.00.08.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Nov 2025 00:08:08 -0800 (PST)
From: Jonas Gorski <jonas.gorski@gmail.com>
To: Florian Fainelli <florian.fainelli@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 8/8] net: dsa: b53: add support for bcm63xx ARL entry format
Date: Fri,  7 Nov 2025 09:07:49 +0100
Message-ID: <20251107080749.26936-9-jonas.gorski@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251107080749.26936-1-jonas.gorski@gmail.com>
References: <20251107080749.26936-1-jonas.gorski@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The ARL registers of BCM63XX embedded switches are somewhat unique. The
normal ARL table access registers have the same format as BCM5389, but
the ARL search registers differ:

* SRCH_CTL is at the same offset of BCM5389, but 16 bits wide. It does
  not have more fields, just needs to be accessed by a 16 bit read.
* SRCH_RSLT_MACVID and SRCH_RSLT are aligned to 32 bit, and have shifted
  offsets.
* SRCH_RSLT has a different format than the normal ARL data entry
  register.
* There is only one set of ENTRY_N registers, implying a 1 bin layout.

So add appropriate ops for bcm63xx and let it use it.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 drivers/net/dsa/b53/b53_common.c | 44 +++++++++++++++++++++++++++-----
 drivers/net/dsa/b53/b53_priv.h   | 15 +++++++++++
 drivers/net/dsa/b53/b53_regs.h   |  9 +++++++
 3 files changed, 61 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 73ea9adb95b7..72c85cd34a4e 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -2058,12 +2058,20 @@ static void b53_read_arl_srch_ctl(struct b53_device *dev, u8 *val)
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
-	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev))
+	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) ||
+		 is63xx(dev))
 		offset = B53_ARL_SRCH_CTL_89;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
-	b53_read8(dev, B53_ARLIO_PAGE, offset, val);
+	if (is63xx(dev)) {
+		u16 val16;
+
+		b53_read16(dev, B53_ARLIO_PAGE, offset, &val16);
+		*val = val16 & 0xff;
+	} else {
+		b53_read8(dev, B53_ARLIO_PAGE, offset, val);
+	}
 }
 
 static void b53_write_arl_srch_ctl(struct b53_device *dev, u8 val)
@@ -2072,12 +2080,16 @@ static void b53_write_arl_srch_ctl(struct b53_device *dev, u8 val)
 
 	if (is5325(dev) || is5365(dev))
 		offset = B53_ARL_SRCH_CTL_25;
-	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev))
+	else if (dev->chip_id == BCM5389_DEVICE_ID || is5397_98(dev) ||
+		 is63xx(dev))
 		offset = B53_ARL_SRCH_CTL_89;
 	else
 		offset = B53_ARL_SRCH_CTL;
 
-	b53_write8(dev, B53_ARLIO_PAGE, offset, val);
+	if (is63xx(dev))
+		b53_write16(dev, B53_ARLIO_PAGE, offset, val);
+	else
+		b53_write8(dev, B53_ARLIO_PAGE, offset, val);
 }
 
 static int b53_arl_search_wait(struct b53_device *dev)
@@ -2131,6 +2143,18 @@ static void b53_arl_search_read_89(struct b53_device *dev, u8 idx,
 	b53_arl_to_entry_89(ent, mac_vid, fwd_entry);
 }
 
+static void b53_arl_search_read_63xx(struct b53_device *dev, u8 idx,
+				     struct b53_arl_entry *ent)
+{
+	u16 fwd_entry;
+	u64 mac_vid;
+
+	b53_read64(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_MACVID_63XX,
+		   &mac_vid);
+	b53_read16(dev, B53_ARLIO_PAGE, B53_ARL_SRCH_RSLT_63XX, &fwd_entry);
+	b53_arl_search_to_entry_63xx(ent, mac_vid, fwd_entry);
+}
+
 static void b53_arl_search_read_95(struct b53_device *dev, u8 idx,
 				   struct b53_arl_entry *ent)
 {
@@ -2730,6 +2754,12 @@ static const struct b53_arl_ops b53_arl_ops_89 = {
 	.arl_search_read = b53_arl_search_read_89,
 };
 
+static const struct b53_arl_ops b53_arl_ops_63xx = {
+	.arl_read_entry = b53_arl_read_entry_89,
+	.arl_write_entry = b53_arl_write_entry_89,
+	.arl_search_read = b53_arl_search_read_63xx,
+};
+
 static const struct b53_arl_ops b53_arl_ops_95 = {
 	.arl_read_entry = b53_arl_read_entry_95,
 	.arl_write_entry = b53_arl_write_entry_95,
@@ -2899,14 +2929,14 @@ static const struct b53_chip_data b53_switch_chips[] = {
 		.dev_name = "BCM63xx",
 		.vlans = 4096,
 		.enabled_ports = 0, /* pdata must provide them */
-		.arl_bins = 4,
-		.arl_buckets = 1024,
+		.arl_bins = 1,
+		.arl_buckets = 4096,
 		.imp_port = 8,
 		.vta_regs = B53_VTA_REGS_63XX,
 		.duplex_reg = B53_DUPLEX_STAT_63XX,
 		.jumbo_pm_reg = B53_JUMBO_PORT_MASK_63XX,
 		.jumbo_size_reg = B53_JUMBO_MAX_SIZE_63XX,
-		.arl_ops = &b53_arl_ops_95,
+		.arl_ops = &b53_arl_ops_63xx,
 	},
 	{
 		.chip_id = BCM53010_DEVICE_ID,
diff --git a/drivers/net/dsa/b53/b53_priv.h b/drivers/net/dsa/b53/b53_priv.h
index d6d25bb3945b..2bfd0e7c95c9 100644
--- a/drivers/net/dsa/b53/b53_priv.h
+++ b/drivers/net/dsa/b53/b53_priv.h
@@ -409,6 +409,21 @@ static inline void b53_arl_from_entry_89(u64 *mac_vid, u32 *fwd_entry,
 		*fwd_entry |= ARLTBL_AGE_89;
 }
 
+static inline void b53_arl_search_to_entry_63xx(struct b53_arl_entry *ent,
+						u64 mac_vid, u16 fwd_entry)
+{
+	memset(ent, 0, sizeof(*ent));
+	u64_to_ether_addr(mac_vid, ent->mac);
+	ent->vid = mac_vid >> ARLTBL_VID_S;
+
+	ent->port = fwd_entry & ARL_SRST_PORT_ID_MASK_63XX;
+	ent->port >>= 1;
+
+	ent->is_age = !!(fwd_entry & ARL_SRST_AGE_63XX);
+	ent->is_static = !!(fwd_entry & ARL_SRST_STATIC_63XX);
+	ent->is_valid = 1;
+}
+
 static inline void b53_arl_read_entry(struct b53_device *dev,
 				      struct b53_arl_entry *ent, u8 idx)
 {
diff --git a/drivers/net/dsa/b53/b53_regs.h b/drivers/net/dsa/b53/b53_regs.h
index c303507d3034..69ebbec932f6 100644
--- a/drivers/net/dsa/b53/b53_regs.h
+++ b/drivers/net/dsa/b53/b53_regs.h
@@ -368,11 +368,13 @@
 #define B53_ARL_SRCH_ADDR_25		0x22
 #define B53_ARL_SRCH_ADDR_65		0x24
 #define B53_ARL_SRCH_ADDR_89		0x31
+#define B53_ARL_SRCH_ADDR_63XX		0x32
 #define  ARL_ADDR_MASK			GENMASK(14, 0)
 
 /* ARL Search MAC/VID Result (64 bit) */
 #define B53_ARL_SRCH_RSTL_0_MACVID	0x60
 #define B53_ARL_SRCH_RSLT_MACVID_89	0x33
+#define B53_ARL_SRCH_RSLT_MACVID_63XX	0x34
 
 /* Single register search result on 5325 */
 #define B53_ARL_SRCH_RSTL_0_MACVID_25	0x24
@@ -388,6 +390,13 @@
 #define B53_ARL_SRCH_RSTL_MACVID(x)	(B53_ARL_SRCH_RSTL_0_MACVID + ((x) * 0x10))
 #define B53_ARL_SRCH_RSTL(x)		(B53_ARL_SRCH_RSTL_0 + ((x) * 0x10))
 
+/* 63XX ARL Search Data Result (16 bit) */
+#define B53_ARL_SRCH_RSLT_63XX		0x3c
+#define   ARL_SRST_PORT_ID_MASK_63XX	GENMASK(9, 1)
+#define   ARL_SRST_TC_MASK_63XX		GENMASK(13, 11)
+#define   ARL_SRST_AGE_63XX		BIT(14)
+#define   ARL_SRST_STATIC_63XX		BIT(15)
+
 /*************************************************************************
  * IEEE 802.1X Registers
  *************************************************************************/
-- 
2.43.0


