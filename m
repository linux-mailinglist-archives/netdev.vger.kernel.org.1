Return-Path: <netdev+bounces-224567-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3489B86478
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:41:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 99F765839A0
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D6D319616;
	Thu, 18 Sep 2025 17:39:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="iAWYvHHz"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECCF61DD543
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217191; cv=none; b=MNXJf+v6IQp7568s7xn1Xpe7Eu6TNVbtbX48q+Y9ic+gBhn5q5Tbq0IaAVzHBI0h8HaMVe9NtK/I1DUiqq2J+2TpL3G0fviFTrQgGtscoWjdpd1pwPDf1n4QXi4BhIIxwYlYOOTv4IXM2H/roE+oaZWSHr+UNoG/WjWFi7sturI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217191; c=relaxed/simple;
	bh=56Ru27kKxKdkhnvKOEYz67Iyd4VmSe6icicoM+g5je8=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=eO0QFdYv5UqinyYulYlVqDnpZzboUqCWZbQg4Vk3ohbjy0kAO7CIxOte7QrJr9D8qqg7uZhPOpTugjISgKx9LdqgIPacMA6+MUjtRSmBZuPbwHySfnwf7Fpmg2eAHEzjw1dgkIzDM4nPiQ7Rm0I4W3WSBhnlK0UqCSGJIKmQ1M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=iAWYvHHz; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ho4Y3UFIppmUcWfXSSOwcnwjX0+FZNDBvuDNo8HR7+c=; b=iAWYvHHzO0C7iE4/tM2+ZfFtN8
	HrRQBtMfF8Nwr/AcLErd/Ub/PnLm/8vVfx2pPMfrYPzXXBc3zFqq41fVVCQ9D8BWRiZTmUo8V53Zv
	PoTCn44KfAyQnLvCK15EXY31dMW2P64BhZlEphZhWTglHl4QW+MkfWRmmghDN4Pe0tx/sB4J6gY+a
	HwunZ5D/tyNDqt2KUJqAwgdZBPIX/vbrMaAezoI/QEFdp/4KrYythSg3SAsYOmNVf8b0TAxKDOkAc
	y09nZjkvgOHtlHfJJtnzk0oEDKZTIsP8jH7UN3aeWw0k6+d4/Zygff7lOqet5mbjahUqatBJLOM3u
	gbpq+4Ug==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:50382 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbf-000000001cE-3AvW;
	Thu, 18 Sep 2025 18:39:43 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbf-00000006n00-06XG;
	Thu, 18 Sep 2025 18:39:43 +0100
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
Subject: [PATCH RFC net-next 10/20] net: dsa: mv88e6xxx: only support EXTTS
 for pins
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbf-00000006n00-06XG@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:43 +0100

The sole implementation for the PTP verify/enable methods only supports
the EXTTS function. Move these checks into mv88e6xxx_ptp_verify() and
mv88e6xxx_ptp_enable(), renaming the ptp_enable() method to
ptp_enable_extts().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  4 ++--
 drivers/net/dsa/mv88e6xxx/ptp.c  | 26 +++++++++-----------------
 2 files changed, 11 insertions(+), 19 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index 7618f6db235e..ae56a88ca1c5 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -731,8 +731,8 @@ struct mv88e6xxx_avb_ops {
 
 struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
-	int (*ptp_enable)(struct mv88e6xxx_chip *chip,
-			  struct ptp_clock_request *rq, int on);
+	int (*ptp_enable_extts)(struct mv88e6xxx_chip *chip,
+				struct ptp_clock_request *rq, int on);
 	int (*ptp_verify)(struct mv88e6xxx_chip *chip, unsigned int pin,
 			  enum ptp_pin_function func, unsigned int chan);
 	void (*event_work)(struct work_struct *ugly);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 72ad6be05943..de44622d8513 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -311,7 +311,10 @@ static int mv88e6xxx_ptp_enable(struct ptp_clock_info *ptp,
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
 
-	return chip->info->ops->ptp_ops->ptp_enable(chip, req, enable);
+	if (req->type != PTP_CLK_REQ_EXTTS)
+		return -EOPNOTSUPP;
+
+	return chip->info->ops->ptp_ops->ptp_enable_extts(chip, req, enable);
 }
 
 static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
@@ -323,6 +326,9 @@ static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
 	if (func == PTP_PF_NONE)
 		return 0;
 
+	if (func != PTP_PF_EXTTS)
+		return -EOPNOTSUPP;
+
 	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
 }
 
@@ -372,23 +378,9 @@ static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
 	return err;
 }
 
-static int mv88e6352_ptp_enable(struct mv88e6xxx_chip *chip,
-				struct ptp_clock_request *rq, int on)
-{
-	switch (rq->type) {
-	case PTP_CLK_REQ_EXTTS:
-		return mv88e6352_ptp_enable_extts(chip, rq, on);
-	default:
-		return -EOPNOTSUPP;
-	}
-}
-
 static int mv88e6352_ptp_verify(struct mv88e6xxx_chip *chip, unsigned int pin,
 				enum ptp_pin_function func, unsigned int chan)
 {
-	if (func != PTP_PF_EXTTS)
-		return -EOPNOTSUPP;
-
 	return 0;
 }
 
@@ -410,7 +402,7 @@ const struct mv88e6xxx_ptp_ops mv88e6165_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable = mv88e6352_ptp_enable,
+	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
 	.ptp_verify = mv88e6352_ptp_verify,
 	.event_work = mv88e6352_tai_event_work,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
@@ -433,7 +425,7 @@ const struct mv88e6xxx_ptp_ops mv88e6352_ptp_ops = {
 
 const struct mv88e6xxx_ptp_ops mv88e6390_ptp_ops = {
 	.clock_read = mv88e6352_ptp_clock_read,
-	.ptp_enable = mv88e6352_ptp_enable,
+	.ptp_enable_extts = mv88e6352_ptp_enable_extts,
 	.ptp_verify = mv88e6352_ptp_verify,
 	.event_work = mv88e6352_tai_event_work,
 	.port_enable = mv88e6352_hwtstamp_port_enable,
-- 
2.47.3


