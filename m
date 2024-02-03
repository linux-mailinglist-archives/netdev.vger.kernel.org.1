Return-Path: <netdev+bounces-68859-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EEE08488DD
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 21:53:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38955B22688
	for <lists+netdev@lfdr.de>; Sat,  3 Feb 2024 20:53:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A89A11714;
	Sat,  3 Feb 2024 20:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="fOaXywUF"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831DE111AE
	for <netdev@vger.kernel.org>; Sat,  3 Feb 2024 20:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706993613; cv=none; b=OSv1PHsxfE7LewOmy8pWo83NhltqHkL9djiBuwup62F2u8PFvxU7wZauv8prVQ1ZDJVMTNLGYkIyGwLdjpXO3wB3c+66e8cgp39i8qlZF99hW3mstDzCWpbJwbEH9y1EVfZNkoHwN9GE7qBJQRtZZrS4HQqjBMx3wAB5WjeSnFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706993613; c=relaxed/simple;
	bh=qu169GEumHvNvv9UgSCcOQ8/DCAEs+xjyo7cUJd1D0U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OKhINtiTqVAoovip97/wKP6M+bB4PHmfZX7aSlmUnh9OCCymBLKgbfBWm+NTNawo+o11TTKB5/XD13kSsmJV4bTwT0Y9XVaIWSP24ckQL7OtbvOuXvrEqJqfu/zZIHcH1Y7lxXAX1WRy19lv09xO202xPahJ4YYTogX54jiMHFM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=fOaXywUF; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=ejO5e+PFYubo5A40MRKGh6GVUJx2o46x/9WbysR9nc8=; b=fO
	aXywUFLAwUEDnsYTDapU/hMnkP4L0INyisfATo1EUQFBNFDGIiwl1m98A+YMP0v6I/a1tAde/xm4d
	wVb4pcRpK2zTf+Yy1xW3MV+o+scpHchE21ghnpfgqDCa6ViLhRqJ5u5A54qI6dDGEuebEWn7WGKEs
	BAerPGXMPmMBVIc=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWN0y-006vPr-N2; Sat, 03 Feb 2024 21:53:28 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sat, 03 Feb 2024 14:52:49 -0600
Subject: [PATCH net-next 2/2] net: dsa: mv88e6xxx: Return -ENODEV when
 C22/C45 not supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240203-unify-c22-c45-scan-error-handling-v1-2-8aa9fa3c4fca@lunn.ch>
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

MDIO bus drivers can return -ENODEV when they know the bus does not
have a device at the given address, e.g. because of hardware
limitation. One such limitation is that the bus does not support C22
or C45 at all. This is more efficient than returning 0xffff, since it
immediately stops the probing on the given address, where as further
reads can be made when 0xffff is returned.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6eec2e4aa031..ce4e4bdf475d 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3633,7 +3633,7 @@ static int mv88e6xxx_mdio_read(struct mii_bus *bus, int phy, int reg)
 	int err;
 
 	if (!chip->info->ops->phy_read)
-		return -EOPNOTSUPP;
+		return -ENODEV;
 
 	mv88e6xxx_reg_lock(chip);
 	err = chip->info->ops->phy_read(chip, bus, phy, reg, &val);
@@ -3659,7 +3659,7 @@ static int mv88e6xxx_mdio_read_c45(struct mii_bus *bus, int phy, int devad,
 	int err;
 
 	if (!chip->info->ops->phy_read_c45)
-		return 0xffff;
+		return -ENODEV;
 
 	mv88e6xxx_reg_lock(chip);
 	err = chip->info->ops->phy_read_c45(chip, bus, phy, devad, reg, &val);

-- 
2.43.0


