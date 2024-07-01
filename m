Return-Path: <netdev+bounces-108041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5931791DA8D
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 10:53:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 890241C21A08
	for <lists+netdev@lfdr.de>; Mon,  1 Jul 2024 08:53:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC0E412BF2B;
	Mon,  1 Jul 2024 08:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="GxOKHRw6"
X-Original-To: netdev@vger.kernel.org
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C97B7126F02;
	Mon,  1 Jul 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823849; cv=none; b=uNLXuhOVjjvY29+Cs5xPhOrg6a5tvDzVpFQzcGPKZqe16FN6EBfYlWfgJbm1O/btF6nYCDKbYnQKzWHB3WTNN4DKGtnK+KTVnLe7etwHDDc20dw0ev2rJmEgylpd4RfkOUME/OIj7fqU6OOiuucAaQ8BVlh3hkv4V1ZK5wvS9Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823849; c=relaxed/simple;
	bh=4erFu/spT9FjrZekQ2U9iz8hr99jm+tE7VnqW8IDVLs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NcwWw2aaPih8miJm09Y/A2Pk9+X//sHIDMCWgvxwctQRL+3h7XmYdzX8/8Dd+SJlaXxWaeBF+zbvO9HI5ZKS1tUEjtVLSGfi0MsoAK+R0RXicyDJBP+ctOE2ULDI2UULMHfh9BlOjj4Ec8QKTG8BlkoUVCwcC+u8vg483leIEDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=GxOKHRw6; arc=none smtp.client-ip=217.70.183.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 0D52BC0004;
	Mon,  1 Jul 2024 08:50:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1719823845;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zn0q+gZqrKKeF19k9TKaX7hCYo/kcK3UWiKgxWYe21c=;
	b=GxOKHRw6nyjpfFNCwjheFQHkEkQJKFcK0eoOsjcB0KVSy8MQUl6/PaVMqWy27NjhTBnLXT
	gRqiV/Soa6R7lcL5Rd6vrZsgwj7TIQcP28EhsQ92/4IBueOcs4+atBmaCJsvexKzWUAyH9
	2agXzxrDRQagSLvWKz03+mILx71siCOYPSbsbrTWlkTsTzf/voXQ5bMpBKcVsmsn4kOQqg
	JkHRtw9egjXuwxVHYxnPrnsxbpYagm27Pe8FpzxvAyGRU+hDjSPIBlrxeZYgKyN4SZtg06
	Ufodxg+hdaKLTureOdCIBSk6agaCyS1pxY39NW2R/oF0pyIkhoMuNNDTCK6EeA==
From: Romain Gantois <romain.gantois@bootlin.com>
Date: Mon, 01 Jul 2024 10:51:04 +0200
Subject: [PATCH net-next 2/6] net: phy: dp83869: Perform software restart
 after configuring op mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240701-b4-dp83869-sfp-v1-2-a71d6d0ad5f8@bootlin.com>
References: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
In-Reply-To: <20240701-b4-dp83869-sfp-v1-0-a71d6d0ad5f8@bootlin.com>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Romain Gantois <romain.gantois@bootlin.com>
X-Mailer: b4 0.14.0
X-GND-Sasl: romain.gantois@bootlin.com

The DP83869 PHY requires a software restart after OP_MODE is changed in the
OP_MODE_DECODE register.

Add this restart in dp83869_configure_mode().

Signed-off-by: Romain Gantois <romain.gantois@bootlin.com>
---
 drivers/net/phy/dp83869.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/phy/dp83869.c b/drivers/net/phy/dp83869.c
index f6b05e3a3173e..6bb9bb1c0e962 100644
--- a/drivers/net/phy/dp83869.c
+++ b/drivers/net/phy/dp83869.c
@@ -786,6 +786,10 @@ static int dp83869_configure_mode(struct phy_device *phydev,
 		return -EINVAL;
 	}
 
+	ret = phy_write(phydev, DP83869_CTRL, DP83869_SW_RESTART);
+
+	usleep_range(10, 20);
+
 	return ret;
 }
 

-- 
2.45.2


