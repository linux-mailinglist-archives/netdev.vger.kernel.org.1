Return-Path: <netdev+bounces-224572-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 86147B864A9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B55BA5860D9
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:41:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 619F731B80F;
	Thu, 18 Sep 2025 17:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="K9hJebfr"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBA8031CA4E
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217216; cv=none; b=OJKklrQQ1KwSKzR0qyViI7nsS6svZ9rlLNUbYhny+76Xbx+JEDWPucpKm8qeKPcvEGmONc/PJFzuhFoqDfhVHpHPQDUP8C2sJ1pA/LmUbF9rwauW9j526iGQEHxXbpQgLgCqrOQKGtAh/Zvrpe+FY5inB2EjH3K1fZFo3eYLfP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217216; c=relaxed/simple;
	bh=b2H6ZHkJhs/mnkJhYbMMAhFZEQvksb82bsmO0IjKk44=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=b88lxGrsebPOZKeu/QmnmR7qP+IprG1UDr8aNqsU2xYI05jjgBak2wRL2Gqt3thWn6NyegwDpsu2wfH0k9XbZU60yh2owCL5RFMliKZm4ryK7LlynxuDC3RUuMXflabvJPsW3pXHOqgjXavg8uRVyL1OYICy+5ggSsl8KL/RfIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=K9hJebfr; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=rLwi6ayExidn0eLSLaQnTD0WY+LBABxQT/UgJjPF7D8=; b=K9hJebfrgsmSEqSuibpHMLjyeI
	JiL8XNDK4+8VTQW74T4+KPCxBrln47RIW/fh7idfAQteNDc9MSO2IwrwbH/dHV7OHaK/Ba6iep9fJ
	qgPSqsUlKuMrW34Ya/B+L54jBiGBcgAFSFTrDbfz59S/T4WuQG9iCk2KLFMJS21bMUY0D9LoZaPxH
	q/iq+iGmPA22z8pGZz2xDVPfYr3zdBRKWBDnom+yGZOo5y7m69jKjBkS5X7NlqdZvYnoiGYKTRdwu
	LliBT6k/ddQXvTK9T4xQm6iMBlaSQimvIFonvb3PTeYiXlybU3ER4ZDNG/0PP51bLqOtDHk/UZQo2
	hgiYYUZg==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:46306 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIc5-000000001dL-1lYg;
	Thu, 18 Sep 2025 18:40:09 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIc4-00000006n0f-2Wye;
	Thu, 18 Sep 2025 18:40:08 +0100
In-Reply-To: <aMxDh17knIDhJany@shell.armlinux.org.uk>
References: <aMxDh17knIDhJany@shell.armlinux.org.uk>
From: "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Subject: [PATCH RFC net-next 15/20] net: dsa: mv88e6xxx: allow generic core to
 configure global regs
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIc4-00000006n0f-2Wye@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:40:08 +0100

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/hwtstamp.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/hwtstamp.c b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
index 0a56e7bcbcd9..dc92381d5c07 100644
--- a/drivers/net/dsa/mv88e6xxx/hwtstamp.c
+++ b/drivers/net/dsa/mv88e6xxx/hwtstamp.c
@@ -544,6 +544,17 @@ static int mv88e6xxx_hwtstamp_port_setup(struct mv88e6xxx_chip *chip, int port)
 	return 0;
 }
 
+static int mv88e6xxx_ts_global_write(struct device *dev, u8 reg, u16 val)
+{
+	struct mv88e6xxx_chip *chip = dev_to_chip(dev);
+
+	return chip->info->ops->avb_ops->ptp_write(chip, reg, val);
+}
+
+static const struct marvell_ts_ops mv88e6xxx_ts_ops = {
+	.ts_global_write = mv88e6xxx_ts_global_write,
+};
+
 int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 {
 	const struct mv88e6xxx_ptp_ops *ptp_ops = chip->info->ops->ptp_ops;
@@ -564,8 +575,7 @@ int mv88e6xxx_hwtstamp_setup(struct mv88e6xxx_chip *chip)
 			return err;
 	}
 
-	/* Set the ethertype of L2 PTP messages */
-	err = mv88e6xxx_ptp_write(chip, MV88E6XXX_PTP_ETHERTYPE, ETH_P_1588);
+	err = marvell_ts_global_config(chip->dev, &mv88e6xxx_ts_ops);
 	if (err)
 		return err;
 
-- 
2.47.3


