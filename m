Return-Path: <netdev+bounces-224569-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 71849B86494
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:41:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD95E565E97
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58DF2FFF81;
	Thu, 18 Sep 2025 17:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="NXf0spph"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FA4625B31B
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217201; cv=none; b=ni4vyvSW/gFrfvygiLL5Jk9o34Rs+BCouxjmS3TreutX9SR1dXwQLghtQlPKazfxZFYhQ4+vmz08/uMmXM83blRfJ8BqqEDvOQfmvYqT7Ch1c6OV8TLgVVvooSFVo/PUv05IIjZXBuJKdAZe75ljaZz3RsevxqAdqRam0ScO87M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217201; c=relaxed/simple;
	bh=kyNUBET6TwNu1SUP4UGmaMgeLRcADSKAuWCufxlxCP4=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=tTPI19RQZ6HGlPtNYOZMO8uDVGaAh8pXGe97LpEKY/zOI2QyNInWfvdW/dHpajnT5cJyieBLUyE2EVMjYRF6xenWb6Hb+UcFIMcg/Ucz0x6EDJuT3MenquADItgTiFKnJjPddmSaq0FBx7vqU0W5ibZha/9YSJqN0yzE7tyNZRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=NXf0spph; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Oy3pq9dFlN8FLYKnEeHIOZ8k3ZKZk37FUWnn/gLKJ3s=; b=NXf0spphT3kf/Sh1Lh8JNqfpZ1
	aVv7/NONj9CL3tb0ExvV71EHiZJIbJftSjcLntjH+RbYn5M9HtpCUpa2ViNOuYzXAnmzJP69DUt0U
	kKciieXNKomvuvHdfP9BH19QlsdYratX1c8vwT2ZStqPM+mIisK/SQOwdXArE9RgCMlT9S00zgSHg
	n20vXd0RcoD+VhM9PO5SUIhcgf12wrmSlxadGrUc3Cckzwkgqzt8NIOYp5XuNIgJita1h2QmEeuyZ
	pE/kW+k/VSBPOf5z1UzajTfTqeIBcrZPFdX2Ga5Q3NxR7+BQtMYQZYp+4tLCYQiWDQJWyF8lh9kZV
	zUKIal5g==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51530 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIbq-000000001cg-03nZ;
	Thu, 18 Sep 2025 18:39:54 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbp-00000006n0M-0xxM;
	Thu, 18 Sep 2025 18:39:53 +0100
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
Subject: [PATCH RFC net-next 12/20] net: dsa: mv88e6xxx: move EXTTS flag
 validation and pin lookup
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbp-00000006n0M-0xxM@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:53 +0100

Move the flag validation and pin lookup to mv88e6xxx_ptp_enable()
mv88e6352_ptp_enable_extts().

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/chip.h |  2 +-
 drivers/net/dsa/mv88e6xxx/ptp.c  | 29 +++++++++++++++--------------
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.h b/drivers/net/dsa/mv88e6xxx/chip.h
index ae56a88ca1c5..fe4a618c8ddd 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.h
+++ b/drivers/net/dsa/mv88e6xxx/chip.h
@@ -732,7 +732,7 @@ struct mv88e6xxx_avb_ops {
 struct mv88e6xxx_ptp_ops {
 	u64 (*clock_read)(struct mv88e6xxx_chip *chip);
 	int (*ptp_enable_extts)(struct mv88e6xxx_chip *chip,
-				struct ptp_clock_request *rq, int on);
+				struct ptp_clock_request *rq, int pin, int on);
 	int (*ptp_verify)(struct mv88e6xxx_chip *chip, unsigned int pin,
 			  enum ptp_pin_function func, unsigned int chan);
 	void (*event_work)(struct work_struct *ugly);
diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 19ccc8cda1f0..efaefca1eef1 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -324,11 +324,23 @@ static int mv88e6xxx_ptp_enable(struct ptp_clock_info *ptp,
 				struct ptp_clock_request *req, int enable)
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
+	int pin;
 
 	if (req->type != PTP_CLK_REQ_EXTTS)
 		return -EOPNOTSUPP;
 
-	return chip->info->ops->ptp_ops->ptp_enable_extts(chip, req, enable);
+	/* Reject requests to enable time stamping on both edges. */
+	if (req->extts.flags & PTP_STRICT_FLAGS &&
+	    req->extts.flags & PTP_ENABLE_FEATURE &&
+	    (req->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
+		return -EOPNOTSUPP;
+
+	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, req->extts.index);
+	if (pin < 0)
+		return -EBUSY;
+
+	return chip->info->ops->ptp_ops->ptp_enable_extts(chip, req, pin,
+							  enable);
 }
 
 static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
@@ -347,24 +359,13 @@ static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
 }
 
 static int mv88e6352_ptp_enable_extts(struct mv88e6xxx_chip *chip,
-				      struct ptp_clock_request *rq, int on)
+				      struct ptp_clock_request *rq, int pin,
+				      int on)
 {
 	int rising = (rq->extts.flags & PTP_RISING_EDGE);
 	int func;
-	int pin;
 	int err;
 
-	/* Reject requests to enable time stamping on both edges. */
-	if ((rq->extts.flags & PTP_STRICT_FLAGS) &&
-	    (rq->extts.flags & PTP_ENABLE_FEATURE) &&
-	    (rq->extts.flags & PTP_EXTTS_EDGES) == PTP_EXTTS_EDGES)
-		return -EOPNOTSUPP;
-
-	pin = ptp_find_pin(chip->ptp_clock, PTP_PF_EXTTS, rq->extts.index);
-
-	if (pin < 0)
-		return -EBUSY;
-
 	mv88e6xxx_reg_lock(chip);
 	err = mv88e6352_ptp_pin_setup(chip, pin, PTP_PF_EXTTS, on);
 
-- 
2.47.3


