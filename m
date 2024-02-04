Return-Path: <netdev+bounces-68987-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C7951849172
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 00:14:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 03F511C213CC
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 23:14:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0857F3D72;
	Sun,  4 Feb 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="06QIF1u5"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE82D10A1E
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 23:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088491; cv=none; b=nnWkVFGsxjtaECnjZPCkLsMl1maXd73tAK8BZ85meW0rIfThZy7RYGo7VXk8y4peLsBxrmfeVBkvhAFiuHYVHU8E2/m/Fj/N7rUUxPJWX6ga3VcKiAQU0ftYMppG1qSgWEcGsJAnoiUev7xpivCalgpszJInnL4OhbLBvYM15pA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088491; c=relaxed/simple;
	bh=hr3VDNqsiPzwrV4cIrfixH5ewYIEGscJvRxb7+ro83k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=ayyanR/oR98k5ymWNk7mrzWh34pKqUZI3qLCtI9o3c4up2jlLRlVDdppnAQPlrLcCj56hzbc8pzIMbp9pRWD6ZEgh4AMhxiSoQDru+aWWBuERiwCb5aRbE465BhARf4D7M3I8h9qQ9Q1h5a5GOTkGSUwD1CbJNwgWJ6F4ezr0Vg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=06QIF1u5; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=dECwZK/EjJpLBQV8aj5CWOMpjNG1SYKjnGkls8vvdHc=; b=06
	QIF1u5rbWAf1c9QHtCNU2YuKIaaBFUGxQ35pkzNnMM9/LtcQPHE84SuTiPyi0BMv/uUcq584ILOSM
	dFSpg0iMc6+AS4eEn2jJ0hvFKhFCIqaZkkTIgvXAKQ7k1E+gGnaLS+HTXfB2DI4/IUzjpKTr7/0sZ
	f0O89VtlRDhfWrM=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWlhB-006z0G-LB; Mon, 05 Feb 2024 00:14:41 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:14:14 -0600
Subject: [PATCH net-next v2 1/2] net: phy: c45 scanning: Don't consider
 -ENODEV fatal
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-unify-c22-c45-scan-error-handling-v2-1-0273623f9c57@lunn.ch>
References: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
In-Reply-To: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>, 
 Andrew Lunn <andrew@lunn.ch>, 
 Florian Fainelli <florian.fainelli@broadcom.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1661; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=hr3VDNqsiPzwrV4cIrfixH5ewYIEGscJvRxb7+ro83k=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwBpaW5X3aNGNkAdO9xguKgjV0u6kI5xJu0FcU
 uYJgzREFLGJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAaWgAKCRDmvw3LpmlM
 hHktEADeoaPxw06cBTMAB1AwoMSJL/dgjdu4Ifa36p1vWd0Ys04UNV/oudx7zNYjE5Tjyfebjah
 Q/vDR8JajuB3B+Fy9eoLxMUWshBksWnj/RmfS85hZOj6k0pjqjLusucEnLMI+HEUeEpoq9+asuv
 lsYrLIbW3R8TI4VscoEy5j4yKf6IYx/DgX2hngXpsqYkJDI41ZWqQf9PFTfRvZGrOg4T+tpydyA
 J1nkPafQ95tjvPwIg65WWKMCXdwyzFDoYTb3yM/ENE0P9H2RLjmLx0cMAJ0+UEGGszgJNyALHk3
 5FXRADGmwxM7jy7lOGzZkWmQH8l5Lf3uMYyPwkFZwN2gFz17UjfNVf2Q0s5yBEOv8dlGKIQ6tNE
 CPERh+akdFp72oiKjKO41f0KwAbt2RFhaEfAv7ir7MNno2/k6caextfrYn2MC7EaYMKCJqIQu49
 E2xcBqqlu2M5GeKK0zAtKfvmLKZzech0W/VTGqfsqLcbFXxNl2ugrWcTDAlFwxwMHTcG+Hyk2Ei
 IZtkcN1a/ySI7OJDzwtC/oQ4fqKK8S3GmGlqKegME9nKZRJZlLqNbgFyfa6LRu1BKFjIqcX/1HN
 omGO+9qEYTMrEot4x4WOlWmnKuPL7819Z665y/aeSoycMXDZGn2kujWM+Y+ADNFUCMiZ44i12pC
 m6DByC4Q67Lb+jg==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

When scanning the MDIO bus for C22 devices, the driver returning
-ENODEV is not considered fatal, it just indicates the MDIO bus master
knows there is no device at that address, maybe because of hardware
limitation.

Make the C45 scan code act on -ENODEV the same way, to make C22 and
C45 more uniform.

It is expected all reads for a given address will return -ENODEV, so
within get_phy_c45_ids() only the first place a read occurs has been
changed.

Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
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


