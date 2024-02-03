Return-Path: <netdev+bounces-68860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DDA58488DE
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 00FA51F239D9
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5B0F11C8B;
	Sat,  3 Feb 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="5Zedetam"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5A10A11
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706993613; cv=none; b=rye0fDToPR8ILJMArV66M6d65CrFXn9HpZmaOFnJro/72WFxVH+IzX4Q0dMsbDbYTF1AYSRc98Y09IjyHpByClRZvYUVUjPL7WAnE7dozsRn/F7Og86sk5YsoCA5Z6VnXoYB8TUblZ60FU3BJ/uoO4VBHCpWgls9CfVELkIAvYw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706993613; c=relaxed/simple;
	bh=7nsBao2j4yH1nAS0a3c2dFEXqBSj444mxPDfHt60bOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pp+oYQl/DEyeyD91lAPty3G9CQ3KxhzSI02Uo/8DvFCp9dd8m9vyhPYeAr/2JTetlOZ2Vey03VTgL7h/j61AZ/i+Z66yUUtksA4rpot/1Ng5jOEycrVRHCY3ch1qCf3U84/ps3Y0z04OovIKEaoCVByN9kQoLISGzAuQ1s7+Q3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=5Zedetam; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=srLZxFsDGhm2yJ40n65dVal0f1ULH3nj6wwqVFrGgGE=; b=5Z
	edetam+TQpsp5Oot8jieTE/7wgumufiobgEzkRnCC3k7Ae1S5MZthnzmzbM/te02xNJ4rT5R3JWAr
	jWYQedxmuiDdHGVLFIWsdR8/U8JSNqYaeppeExlQjCBkAxiBJcezeOcr6c3+qaS8OV0oJXUwRaIVa
	cQUTRxojTCcWleI=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWN0v-006vPr-RM; Sat, 03 Feb 2024 21:53:26 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 03 Feb 2024 14:52:48 -0600
Subject: [PATCH net-next 1/2] net: phy: c45 scanning: Don't consider
 -ENODEV fatal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-unify-c22-c45-scan-error-handling-v1-1-8aa9fa3c4fca@lunn.ch>
References: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
In-Reply-To: <20240203-unify-c22-c45-scan-error-handling-v1-0-8aa9fa3c4fca@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4

When scanning the MDIO bus for C22 devices, the driver returning
-ENODEV is not considered fatal, it just indicates the MDIO bus master
knows there is no device at that address, maybe because of hardware
limitation.

Make the C45 scan code act on -ENODEV the same way, to make C22 and
C45 more uniform.

It is expected all reads for a given address will return -ENODEV, so
within get_phy_c45_ids() only the first place a read occurs has been
changed.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/phy/phy_device.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/phy_device.c b/drivers/net/phy/phy_device.c
index 52828d1c64f7..962ab53c23ff 100644
--- a/drivers/net/phy/phy_device.c
+++ b/drivers/net/phy/phy_device.c
@@ -780,7 +780,7 @@ static int get_phy_c45_devs_in_pkg(struct mii_bus *bus, int addr, int dev_addr,
  * and identifiers in @c45_ids.
  *
  * Returns zero on success, %-EIO on bus access error, or %-ENODEV if
- * the "devices in package" is invalid.
+ * the "devices in package" is invalid or no device responds.
  */
 static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 			   struct phy_c45_device_ids *c45_ids)
@@ -803,7 +803,11 @@ static int get_phy_c45_ids(struct mii_bus *bus, int addr,
 			 */
 			ret = phy_c45_probe_present(bus, addr, i);
 			if (ret < 0)
-				return -EIO;
+				/* returning -ENODEV doesn't stop bus
+				 * scanning
+				 */
+				return (phy_reg == -EIO ||
+					phy_reg == -ENODEV) ? -ENODEV : -EIO;
 
 			if (!ret)
 				continue;

-- 
2.43.0


