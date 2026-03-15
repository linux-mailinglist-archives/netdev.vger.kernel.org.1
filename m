Return-Path: <netdev+bounces-267904-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CsMFHm3tmn6GAEAu9opvQ
	(envelope-from <netdev+bounces-267904-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:43:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 11500290C65
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 14:43:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id C6B5330099BB
	for <lists+netdev@lfdr.de>; Sun, 15 Mar 2026 13:43:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5745935F8B9;
	Sun, 15 Mar 2026 13:43:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ThGqqeEy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4232B2D7
	for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 13:43:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773582198; cv=none; b=QxcbG5Hfa70T5+YoMxcN3E3yGOcgrETGGzEwFQ4msGjfBlBZxm4Mq4m9VggrnZqFTg7nZk7FZbW9oxZhoTJzLGAPfiNhZdkVXDiIdSN+PBkNKtM8typ71zpbmHUcOHWSyocbz35hqCljIWvuj6yGuOdt0s2pMDpcTU1oiADSUlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773582198; c=relaxed/simple;
	bh=qV1yMuwrTIkchvUDPYDLyE2bkW3himIbKKouZnbaxUU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cT0HRDsCHO7tMG1W8HE69dtNzzejhtvdkiRv8NZUCmAq7LpIac+j8rN00KpiCUGTlwc5aVJ239xDvr6/8RLK3Qih9PY/sCWPb2IvUojfNs9aMamOJQMhQC681VRsEwRAEaOeFfoTHOD8LPVau7CBLheiZDSxsAYLPh4Y+dJnhjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ThGqqeEy; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2aecc6b0861so12587815ad.2
        for <netdev@vger.kernel.org>; Sun, 15 Mar 2026 06:43:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773582195; x=1774186995; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=480mqwLmtEUdXj6IGWFUouNnjM+D+2n/aWYyEZDCGn4=;
        b=ThGqqeEy1uzrPC/M4AcvCnLBmKVpwPTzBNfogLqVzW8F9dppkV4Pjz0VYcDD6SUIZK
         H2FghBKAXhPLFJNtktnb9wNqHmbs6siLLBtf5h0ZfjzKQJK0PNANV9q2tI/7h+/js9rV
         oNDqVRT3QgTjJN8jOzi6TqxRgnkzRskvawzb42FsjAEYu385cHfp1+EChrFPAF69x07l
         2OIFEmhof8arNf5rfGHlgg24HZwI3dfhURwGKL4Tz/03m0rBNHWdnlJxbzIJTFKydYCc
         ZMurQctmufYXoAlVII0HsdKZapEIIcO4ioGIkHIfeAQ8aVWsSkd0zAWmgdlpIqDxJMXg
         ggFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773582195; x=1774186995;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=480mqwLmtEUdXj6IGWFUouNnjM+D+2n/aWYyEZDCGn4=;
        b=I22w06sUvYQaocopHa6kUvCippntRZpCEl8yjYadCMMuz48lNlUFhGGVXnUoIfZmGr
         aNIqRz2Et6dRK6Res0HsymbdFKqbb8Q2woIWtx+qKTlSoyJfdKvRM2eizwBNDYhVHc+0
         q0/D+n0Z2kWlrmAlDWcXl/JSn09XIri/Uumx0pEY41JxxSvLCTgqYywQmPXs5FDCYQfv
         r5VG4m3Zx6K0GfppWnymupQQIzgtXIjN4fF14mxXZqRyB+njdw8nG4CEruPxxjXgF5ax
         ekXylM52d0EWbHvj/LygG4pEPKbF3OqclxsQIQS/siKbW7XtCqMGx9z1OtSuzwM2PF1w
         kANA==
X-Forwarded-Encrypted: i=1; AJvYcCW5wdSuQWevnFafeDy3nShRpvRfm49hjlqUMyAleWlxVLMRjbhNJnf2KTLsG/nlUizTMJYfNQw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+OJUjQAreWTIZ8hLARQOLxEQBhiV9HZY+wOdHEqfdX9JcIr+5
	JrTb6m9ufBR1BKZ05bzDnd9mFzAkYO18toGWQo1iYroqkvf7o9n9AHGdKNk4Jw==
X-Gm-Gg: ATEYQzxSvxsQdIJvNbxbw5T0EUQUWAsM9oQBJI11eR5ZQ8VnRLGkR36WAeEit166rZL
	dx7grzPtxV7lb68NTKR0ZbaUBclbt4G9xWR5En5s7HnK05RHWfs89ix6T39yOJSZjxSU7h1uBwB
	4+Bj72EXbvW6NiYqJ3jRzzmHwqno3tI8xx8C+UBaUMZ+m9OiMSDi4tcJlU02tgMgpYzQLkOuWXB
	P+9ooE/Dl3AtKTxLCnvPP98byN9YmDuqOgeK3gGOdJ4635g4zwdd59XKiTIYTbGcLMFg02IZN1a
	D/NYgu8fBDSEFdiDIY3VPhIo5PyLeIh+9cpDmun+jPqwkG6npi9KK4ThKcLnlaS7ch3/Dso2ge+
	LIQf5WWY4xehAm2PWERR/frGHWEiay3/z01/q9/vayng8qkbbW4RIIKSlHacrxS0BDwPQ0Xfonz
	S0u3D8rIzklfG7N5AOHzV/eYTppwlaYpmKinMCEm416XdUMLHDUU+r5B1hoa3YWmv971GbIoDxW
	PLmdSkfGdR76qaw0UdDvQ==
X-Received: by 2002:a17:902:f70a:b0:2ae:ba08:a48d with SMTP id d9443c01a7336-2aeca793aeamr91719335ad.0.1773582195001;
        Sun, 15 Mar 2026 06:43:15 -0700 (PDT)
Received: from localhost.localdomain (124-218-201-66.cm.dynamic.apol.com.tw. [124.218.201.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2aece56cdf4sm101135625ad.8.2026.03.15.06.43.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 Mar 2026 06:43:14 -0700 (PDT)
From: "Lucien.Jheng" <lucienzx159@gmail.com>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: ericwouds@gmail.com,
	frank-w@public-files.de,
	daniel@makrotopia.org,
	lucien.jheng@airoha.com,
	"Lucien.Jheng" <lucienzx159@gmail.com>
Subject: [PATCH v1] net: phy: airoha: add AN8811HB MCU assert/deassert support
Date: Sun, 15 Mar 2026 21:41:55 +0800
Message-Id: <20260315134155.142750-1-lucienzx159@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267904-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,public-files.de,makrotopia.org,airoha.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_TO(0.00)[lunn.ch,gmail.com,armlinux.org.uk,davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienzx159@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 11500290C65
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

AN8811HB requires the MCU to be held in reset before firmware
loading and released afterwards via a dedicated PBUS register
pair (0x5cf9f8 / 0x5cf9fc), accessed through the PHY-addr+8
MDIO bus node rather than the BUCKPBUS indirect path.

Add __air_pbus_reg_write() as a low-level helper for this
access, then implement an8811hb_mcu_assert() / _deassert()
on top of it.  Wire both into an8811hb_load_firmware() and
en8811h_restart_mcu() so every firmware load or MCU restart
on AN8811HB correctly sequences the reset control registers.

Signed-off-by: Lucien Jheng <lucienzx159@gmail.com>
---
 drivers/net/phy/air_en8811h.c | 105 ++++++++++++++++++++++++++++++++++
 1 file changed, 105 insertions(+)

diff --git a/drivers/net/phy/air_en8811h.c b/drivers/net/phy/air_en8811h.c
index 29ae73e65caa..d36e946aa224 100644
--- a/drivers/net/phy/air_en8811h.c
+++ b/drivers/net/phy/air_en8811h.c
@@ -170,6 +170,16 @@
 #define   AN8811HB_CLK_DRV_CKO_LDPWD		BIT(13)
 #define   AN8811HB_CLK_DRV_CKO_LPPWD		BIT(14)
 
+#define AN8811HB_MCU_SW_RST		0x5cf9f8
+#define   AN8811HB_MCU_SW_RST_HOLD		BIT(16)
+#define   AN8811HB_MCU_SW_RST_RUN		(BIT(16) | BIT(0))
+#define AN8811HB_MCU_SW_START		0x5cf9fc
+#define   AN8811HB_MCU_SW_START_EN		BIT(16)
+
+/* MII register constants for PBUS access (PHY addr + 8) */
+#define AIR_PBUS_ADDR_HIGH		0x1c
+#define AIR_PBUS_DATA_HIGH		0x10
+
 /* Led definitions */
 #define EN8811H_LED_COUNT	3
 
@@ -254,6 +264,36 @@ static int air_phy_write_page(struct phy_device *phydev, int page)
 	return __phy_write(phydev, AIR_EXT_PAGE_ACCESS, page);
 }
 
+static int __air_pbus_reg_write(struct phy_device *phydev,
+				u32 pbus_reg, u32 pbus_data)
+{
+	struct mii_bus *bus = phydev->mdio.bus;
+	int pbus_addr = phydev->mdio.addr + 8;
+	int ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, AIR_EXT_PAGE_ACCESS,
+			      upper_16_bits(pbus_reg));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_ADDR_HIGH,
+			      (pbus_reg & GENMASK(15, 6)) >> 6);
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, (pbus_reg & GENMASK(5, 2)) >> 2,
+			      lower_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	ret = __mdiobus_write(bus, pbus_addr, AIR_PBUS_DATA_HIGH,
+			      upper_16_bits(pbus_data));
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
 static int __air_buckpbus_reg_write(struct phy_device *phydev,
 				    u32 pbus_address, u32 pbus_data)
 {
@@ -570,10 +610,65 @@ static int an8811hb_load_file(struct phy_device *phydev, const char *name,
 	return ret;
 }
 
+static int an8811hb_mcu_assert(struct phy_device *phydev)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
+				   AN8811HB_MCU_SW_RST_HOLD);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START, 0);
+	if (ret < 0)
+		goto unlock;
+
+	msleep(50);
+	phydev_info(phydev, "MCU asserted\n");
+
+unlock:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
+static int an8811hb_mcu_deassert(struct phy_device *phydev)
+{
+	int ret;
+
+	phy_lock_mdio_bus(phydev);
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_START,
+				   AN8811HB_MCU_SW_START_EN);
+	if (ret < 0)
+		goto unlock;
+
+	ret = __air_pbus_reg_write(phydev, AN8811HB_MCU_SW_RST,
+				   AN8811HB_MCU_SW_RST_RUN);
+	if (ret < 0)
+		goto unlock;
+
+	msleep(50);
+	phydev_info(phydev, "MCU deasserted\n");
+
+unlock:
+	phy_unlock_mdio_bus(phydev);
+	return ret;
+}
+
 static int an8811hb_load_firmware(struct phy_device *phydev)
 {
 	int ret;
 
+	ret = an8811hb_mcu_assert(phydev);
+	if (ret < 0)
+		return ret;
+
+	ret = an8811hb_mcu_deassert(phydev);
+	if (ret < 0)
+		return ret;
+
 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
@@ -662,6 +757,16 @@ static int en8811h_restart_mcu(struct phy_device *phydev)
 {
 	int ret;
 
+	if (phy_id_compare_model(phydev->phy_id, AN8811HB_PHY_ID)) {
+		ret = an8811hb_mcu_assert(phydev);
+		if (ret < 0)
+			return ret;
+
+		ret = an8811hb_mcu_deassert(phydev);
+		if (ret < 0)
+			return ret;
+	}
+
 	ret = air_buckpbus_reg_write(phydev, EN8811H_FW_CTRL_1,
 				     EN8811H_FW_CTRL_1_START);
 	if (ret < 0)
-- 
2.34.1


