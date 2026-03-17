Return-Path: <netdev+bounces-268448-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6E+qJ/DxuGmTmAEAu9opvQ
	(envelope-from <netdev+bounces-268448-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:17:20 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2D552A43E4
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 07:17:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id C2642300BC6C
	for <lists+netdev@lfdr.de>; Tue, 17 Mar 2026 06:17:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A4333A039;
	Tue, 17 Mar 2026 06:17:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mwvL1r/N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7BF2882B6
	for <netdev@vger.kernel.org>; Tue, 17 Mar 2026 06:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773728234; cv=none; b=FukyPwf+3gNwED5NxtkSMJN5hNu0PM8AVZTzvmZKRGm9qeO24tD8uqeCcRwYoF8r70AdL0ZCz+FmkuHKx3C0GxpNN3zQhjlffDVl9pTkgUvpNzklBZ238FNZ9/EEstJSXpzUDfk/i07vJysujJfFBbbWhjRFVhUuMBZhOZXPP7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773728234; c=relaxed/simple;
	bh=KhEyLhwD3t/1DeNzsLf35QUe9prb/Rf9evk+SRQ3r5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d9cNUyfDRT/vqA7yF3G3pw6YkZjujV3gLboGCX63a31w1COakpcU0CJMa6RXmEvPc3gWBbT8rfQk3NhP+nV1MwSwru0bGUe/+3ysx1NamFjI0KpEzHwo+FjLithGwV7iXTNumLlqAnb+bFSppufwFyDNP3n7xLPu0GbEg2P+aN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mwvL1r/N; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2aae4816912so35409545ad.2
        for <netdev@vger.kernel.org>; Mon, 16 Mar 2026 23:17:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773728232; x=1774333032; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=JfBd9wzIm3z3/w3s3Qc6qftjWXvNIg0CtCWF9vzwZi4=;
        b=mwvL1r/Nia+qDop5xvnetxBHBqVMMnAJjn944wA8GhJiGcGKmjJh4kYHqmTld08jNp
         w/F7nA2j3J5/SZtWumuQIAzYs9uWEivaQ6vHn4z7hRGnONaxatTMbepsKMWSFcc/OpLF
         Bug9bT/EtWRFp4HEnf871Q40tR3q7wHQ1FgwK7orcZrWNrFAK5BLup6LM5kwmXI6AKtM
         BlYr2laQiABh4L68sR8IGW7Me7ODX+97ut8IjEogajSuuQTs+VCVI0LceEbW2qIQK5e/
         xM/GmyhezInWJglTLWeWESdnXYYqKqLiYHzH/uFPQopGrKxY9EAENdg6WQG32ucVqtuh
         S0Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773728232; x=1774333032;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JfBd9wzIm3z3/w3s3Qc6qftjWXvNIg0CtCWF9vzwZi4=;
        b=XoA8AFZhfA3AT51+hJB3M4Y5XIhVZvZWZwu6UhWHCW9cOfASQlRTaUQk/f8dAC2+j5
         6UsBo2wh4g10rYLZ6N5fWh9TiZmpC3isn9xNF6llxBahdSdArOIpdaZs7nOCtePn4qmM
         Af1x6LzbB4kXCBKi1GdRcBjSyXtWUipDBgSLQkwilyLI58Ba6mggX9qzJnjJAIKyRdyG
         qp2XkDR+GmoP+sp3jLK4SYGqS62G/sHrOgBUsys2ICUzJtTjSzhnRaa/rh9U3ygczr9a
         CDU3Ud5Do3BcVzj3w7xvEvrrVFcKNC033UOVEySdIifAMomcGYuXuqGYT5QOCBW96WBE
         V2kA==
X-Forwarded-Encrypted: i=1; AJvYcCVhxMMZ2M1Kv/s7foUSD5UNq3EOJxEEs1mL7wgIX/sFqcYqwuGUX4iqbhP5CLNf9XJ06WkY4jY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzQbcSckIOPLOhXRRYj/qGa6yrVxfU2vtb9sVcPSgZT9/Rduf7t
	kNvtnrVXtNparWF/lVaaxrphGim5vD0KnjHW3F/vlNN+aWu3/qo4IWBiDx/pzA==
X-Gm-Gg: ATEYQzzwgpsBCqGG7CoBFBCD5oBDA0i25bYzWvBME3MK80XeBMLXF+kx4DtoYzR/blU
	Ou3a6kGyf8rPjr8l5HarOUFII6N9REPA+foGQZlk1EE+b6ZgUf5j1bFzMMTNDXMbpljxgltl4MF
	NGdoyx/OR/YHdFtrU9I8oY36wWVKPjfnPYMpO9znPuydWNSzzJu1wp+BS3xFdDkSO4ocsci8qaV
	O5gXuk2SJ7YwfndcF01Jr6Bu3nuaBHLxnWVXk+KpSiHaJ0i48SJcPLMcGnFqoRUN/nzpyt5yHyx
	QgQJJjnQLXi2I0gAQMHb8/uOtgfE/i7VugUjBAptkndSAAPFE6QS8XJ9sXP4YR6NCZ8tAqwWwPk
	Rmj12bhDbfZqQ8TNJ8TN+6vSuK8zB7AENDarTC+8HxW583OOUHdiNOihpLgn14gNxtcavCN2Yom
	R9AAZ+p55kysyDytIRhVMXVSeONJaEKvM=
X-Received: by 2002:a17:903:2308:b0:2b0:659e:97bb with SMTP id d9443c01a7336-2b0659e9ceemr16900895ad.46.1773728232301;
        Mon, 16 Mar 2026 23:17:12 -0700 (PDT)
Received: from rockpi-5b ([45.112.0.200])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b05b4e6094sm44173875ad.77.2026.03.16.23.17.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 16 Mar 2026 23:17:11 -0700 (PDT)
From: Anand Moon <linux.amoon@gmail.com>
To: Heiner Kallweit <hkallweit1@gmail.com>,
	nic_swsd@realtek.com (maintainer:8169 10/100/1000 GIGABIT ETHERNET DRIVER),
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Shawn Lin <shawn.lin@rock-chips.com>,
	Hans Zhang <18255117159@163.com>,
	Niklas Cassel <cassel@kernel.org>,
	netdev@vger.kernel.org (open list:8169 10/100/1000 GIGABIT ETHERNET DRIVER),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH next v1] r8169: Fix PHY lookup for mdiobus_get_phy() and improve error reporting during probe
Date: Tue, 17 Mar 2026 11:46:58 +0530
Message-ID: <20260317061700.7734-1-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-268448-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,arm.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,realtek.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,rock-chips.com,163.com,vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[linuxamoon@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,arm.com:email]
X-Rspamd-Queue-Id: A2D552A43E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The driver currently assumes the PHY is always at address 0. On some
hardware or buggy BIOS implementations, the PHY may reside at a
different address on the MDIO bus. Update r8169_mdio_register()
to scan the bus for the first available PHY instead of hardcoding
address 0.

Additionally, switch to dev_err_probe() in the main probe path to
provide standardized error handling and cleaner log output for
registration failures.

Link: https://lore.kernel.org/all/87bc37ee-234c-4568-b72e-955c130a6838@arm.com/
Fixes: ec392abc9593 ("PCI: dw-rockchip: Enable async probe by default")
Cc: Robin Murphy <robin.murphy@arm.com>
Cc: Danilo Krummrich <dakr@kernel.org>
Cc: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
 drivers/net/ethernet/realtek/r8169_main.c | 34 ++++++++++++++++-------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index 791277e750ba..0fd735beff92 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -5427,7 +5427,8 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 {
 	struct pci_dev *pdev = tp->pci_dev;
 	struct mii_bus *new_bus;
-	int ret;
+	struct phy_device *phydev;
+	int ret, addr;
 
 	/* On some boards with this chip version the BIOS is buggy and misses
 	 * to reset the PHY page selector. This results in the PHY ID read
@@ -5462,18 +5463,31 @@ static int r8169_mdio_register(struct rtl8169_private *tp)
 	if (ret)
 		return ret;
 
-	tp->phydev = mdiobus_get_phy(new_bus, 0);
-	if (!tp->phydev) {
+	/* find the first (lowest address) PHY on the current MAC's MII bus */
+	for (addr = 0; addr < PHY_MAX_ADDR; addr++) {
+		struct phy_device *tmp = mdiobus_get_phy(new_bus, addr);
+
+		if (tmp) {
+			phydev = tmp;
+			break;
+		}
+	}
+
+	if (!phydev) {
+		dev_err(&pdev->dev, "no PHY found on bus\n");
 		return -ENODEV;
-	} else if (!tp->phydev->drv) {
-		/* Most chip versions fail with the genphy driver.
-		 * Therefore ensure that the dedicated PHY driver is loaded.
-		 */
+	}
+
+	/* Most chip versions fail with the genphy driver.
+	 * Therefore ensure that the dedicated PHY driver is loaded.
+	 */
+	if (!phydev->drv) {
 		dev_err(&pdev->dev, "no dedicated PHY driver found for PHY ID 0x%08x, maybe realtek.ko needs to be added to initramfs?\n",
-			tp->phydev->phy_id);
+			phydev->phy_id);
 		return -EUNATCH;
 	}
 
+	tp->phydev = phydev;
 	tp->phydev->mac_managed_pm = true;
 	if (rtl_supports_eee(tp))
 		phy_support_eee(tp->phydev);
@@ -5790,11 +5804,11 @@ static int rtl_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 
 	rc = r8169_mdio_register(tp);
 	if (rc)
-		return rc;
+		return dev_err_probe(&pdev->dev, rc, "mdio register failure\n");
 
 	rc = register_netdev(dev);
 	if (rc)
-		return rc;
+		return dev_err_probe(&pdev->dev, rc, "register newdev failure\n");
 
 	if (IS_ENABLED(CONFIG_R8169_LEDS)) {
 		if (rtl_is_8125(tp))

base-commit: 95c541ddfb0815a0ea8477af778bb13bb075079a
-- 
2.50.1


