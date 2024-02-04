Return-Path: <netdev+bounces-68989-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 600D6849174
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 00:15:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 926C61C21BE1
	for <lists+netdev@lfdr.de>; Sun,  4 Feb 2024 23:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30753BE68;
	Sun,  4 Feb 2024 23:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b="hgVtu/DL"
X-Original-To: netdev@vger.kernel.org
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C69BA2D
	for <netdev@vger.kernel.org>; Sun,  4 Feb 2024 23:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=156.67.10.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707088495; cv=none; b=ULP29NCJIoeiB/6i6TJlaQCKVZ1FtIfsYPpK9eCV1wgNui9zQeEWebTzgM7EFJiEhHFnHBDJCFKQczRXSRh7NTqYrZVurqfsPeRDurPlgam6UwjE149Wh/8UzhTRty2khSX4ziDxr8+ExCRPqGLcsN+4sWOzIiU9jMHV0RF7li4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707088495; c=relaxed/simple;
	bh=lSApe1f45434Y16fWlHxkIrPd3CF3MSK1dKbSaqtf7g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qWjgmRtFglJqF9/24HhHj1cmaXy856A+n7ImROPeqbHWlDYPzuIqCyTD3VGMHcTd68d/9KYKmalfpgc4unSGvYEh+Vzv3iZOuhTL5Gk5nV/ZAjr6xG4kFZCB8BewJQJQiQVw9JvH5/3g7HjemOejkWL+AbwyB7as23VjBOu0Psw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch; spf=pass smtp.mailfrom=lunn.ch; dkim=pass (1024-bit key) header.d=lunn.ch header.i=@lunn.ch header.b=hgVtu/DL; arc=none smtp.client-ip=156.67.10.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=lunn.ch
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lunn.ch
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
	s=20171124; h=Cc:To:In-Reply-To:References:Message-Id:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:From:
	Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
	In-Reply-To:References; bh=YxDRx6iIkJdAnrZ/1KbNGt9k3sbK2qsQMF3OilEVOC8=; b=hg
	Vtu/DLHdjc6QciC/M24SQMRGb8uk3cFZ66sMYZwX09SksJg+ygKwSYE7MEW+uv26x0M7UCy48cZXl
	LG0Lx0pUtyfqsIPF3//hZhjOmLKNZjrMmHm/l8n2FsbcbfibK/jPmctP/R0LP1LMEQlgz8nms6Z/F
	p9synemS1oJTRkE=;
Received: from c-76-156-36-110.hsd1.mn.comcast.net ([76.156.36.110] helo=thinkpad.home.lunn.ch)
	by vps0.lunn.ch with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <andrew@lunn.ch>)
	id 1rWlhE-006z0G-Gv; Mon, 05 Feb 2024 00:14:44 +0100
From: Andrew Lunn <andrew@lunn.ch>
Date: Sun, 04 Feb 2024 17:14:15 -0600
Subject: [PATCH net-next v2 2/2] net: dsa: mv88e6xxx: Return -ENODEV when
 C45 not supported
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240204-unify-c22-c45-scan-error-handling-v2-2-0273623f9c57@lunn.ch>
References: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
In-Reply-To: <20240204-unify-c22-c45-scan-error-handling-v2-0-0273623f9c57@lunn.ch>
To: Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: netdev@vger.kernel.org, Tim Menninger <tmenninger@purestorage.com>, 
 Andrew Lunn <andrew@lunn.ch>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1039; i=andrew@lunn.ch;
 h=from:subject:message-id; bh=lSApe1f45434Y16fWlHxkIrPd3CF3MSK1dKbSaqtf7g=;
 b=owEBbQKS/ZANAwAKAea/DcumaUyEAcsmYgBlwBpbetX6ZQaZKH/ZLIN45Jgh6/vRX2U9Ss54q
 mISQSzxT7yJAjMEAAEKAB0WIQRh+xAly1MmORb54bfmvw3LpmlMhAUCZcAaWwAKCRDmvw3LpmlM
 hGFlD/9zy8/JUQLJ7Q2jU4SDpd2rmXkZtL2WiKAhC/tCt9WljxpZxKqFdD5cJAKIANazKukAXfF
 PySnNoVSBtPNzaaqNDE7mDs1XWSvc1CTRvqokQfVMo5/W1coVCdfsO6EhDnc9grJGxExkc7btmf
 PmC9eQAZzYhYDzg1vAbe6IriiBA/gnbPkRPY0QXf3T4Mc4409T8aSbeX3wscmyrox45BXPDRRLx
 ATEyqKU0ZCx9ID/eKv3pYH+43Y1bA1kA09B76uTRYRtp2b24WBchhQ+rHvxKSisPaaghC//APta
 l1DZsJKkbh0vSMmOEJLo+OqCctuwnL2SJav5M4zH6/zpk3VbimJzbuUuhY0mX11Dm+t1+iJiigy
 jt8lk9TwPPYj2uDf8dq15AXcDMF/rFlp8ekooJfBnS7LWdo/+DQeseFiVzF8av/Gd011/iKXBPf
 TnqNCc1cmT1uiXCqoVRPcsfVsrza1wDNVZU+rQbOrym7LeEoT5LGmIoC+2wYs0WAqYBEoYi0K/B
 xEBH2SRuLjGFLIW2lh2JAcPBUvzO/hR7nbCaEPas4EfQyoZ2HGArHUV2BG4zttiUZh03MOYbzK4
 AwQKMau/EE1lrVvQv8/nYsr6usAg4tsGCgH0zXiM/k2LQrnTGFjdaC6R3vEHrKu3fe8dAWs2YzR
 IHFpFHC7Sdj6tNQ==
X-Developer-Key: i=andrew@lunn.ch; a=openpgp;
 fpr=61FB1025CB53263916F9E1B7E6BF0DCBA6694C84

MDIO bus drivers can return -ENODEV when they know the bus does not
have a device at the given address, e.g. because of hardware
limitation. One such limitation is that the bus does not support C45
at all. This is more efficient than returning 0xffff, since it
immediately stops the probing on the given address, where as further
reads can be made when 0xffff is returned.

Signed-off-by: Andrew Lunn <andrew@lunn.ch>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index 6eec2e4aa031..9caecb4dfbfa 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -3659,7 +3659,7 @@ static int mv88e6xxx_mdio_read_c45(struct mii_bus *bus, int phy, int devad,
 	int err;
 
 	if (!chip->info->ops->phy_read_c45)
-		return 0xffff;
+		return -ENODEV;
 
 	mv88e6xxx_reg_lock(chip);
 	err = chip->info->ops->phy_read_c45(chip, bus, phy, devad, reg, &val);

-- 
2.43.0


