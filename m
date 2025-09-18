Return-Path: <netdev+bounces-224566-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D78EB8646A
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:40:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C003D1CC225E
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 17:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 093AD30DEC5;
	Thu, 18 Sep 2025 17:39:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b="v6vfnRAC"
X-Original-To: netdev@vger.kernel.org
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [78.32.30.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C982D7DFC
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 17:39:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=78.32.30.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758217184; cv=none; b=tjOMBIsrzuULsss/oPPwRR30tfQPwifJ5LB63Kj0pVgU5CPXYG+K5EGCaRJRmq1grxvSJQXVGc+V+7sjCZS7rveh4xinvmTY63dRR+WmBUulpT29bmjNfE6JiABmBCY534zUaIi+PGYKS84VD7qdoBe8RbRL43MQ0rOgHvzc9vw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758217184; c=relaxed/simple;
	bh=EVwPP9wf6kqfbhh4WYEsHL4Bh8lLAF5i8TibL+p3XZs=;
	h=In-Reply-To:References:From:To:Cc:Subject:MIME-Version:
	 Content-Disposition:Content-Type:Message-Id:Date; b=IaFqgNqvH8BqXezjiGNLd/nRrsZwR9I+PsPQgMt9j7kKPUkeKzwuSz7t34PuPUG29J5l+m6rJHfc6KlJ+r6hJjcJypyFgO6hvFAPrcQPXMbD4kz/2MxDcTC/wdKzx/nzK4CJnZmC1uHIoZqZ6KEyreZCUOJnli3ilkC3Xhe7NmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk; spf=none smtp.mailfrom=armlinux.org.uk; dkim=pass (2048-bit key) header.d=armlinux.org.uk header.i=@armlinux.org.uk header.b=v6vfnRAC; arc=none smtp.client-ip=78.32.30.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=armlinux.org.uk
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=armlinux.org.uk
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:References:
	In-Reply-To:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TLHS/pYo4q7lYYk5/OZV5ykFCP4Gyitj1gsYvskMGQE=; b=v6vfnRACgoONRQ6y6OQD97cplc
	TxAWlvZO3QDjA07D7ChEvdL1LbIiKWlmlR43pcglyp7Ee1yO53HBvcSXkKCq4DCnzbT5pDlI+8ZiA
	XwqUC+5uHFSO291dRxPe7XgvnA9yPOuElAgTWBzw4SZuRwdYcT+Jqvo8jRMGk4RAWaZE5HARPu35a
	P5l8Vg8rfp7/Y3fYsmCwFwYlrOiddx0DC3dOxCNgXtvE1aoyxJ+qnTcGucJ0+4OcMjdMaFCyDXrk/
	9UXGpRKSNFMZyU/G/cvk4Z9qLEVluGbPchFT4rGcNGqaVD4aJkjDFQEevDYTegmfVGpdCoBYmeWZI
	n4JviV9Q==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:35152 helo=rmk-PC.armlinux.org.uk)
	by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <rmk@armlinux.org.uk>)
	id 1uzIba-000000001c0-2jxY;
	Thu, 18 Sep 2025 18:39:38 +0100
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.98.2)
	(envelope-from <rmk@rmk-PC.armlinux.org.uk>)
	id 1uzIbZ-00000006mzu-3pQK;
	Thu, 18 Sep 2025 18:39:37 +0100
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
Subject: [PATCH RFC net-next 09/20] net: dsa: mv88e6xxx: always verify
 PTP_PF_NONE
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1uzIbZ-00000006mzu-3pQK@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date: Thu, 18 Sep 2025 18:39:37 +0100

Setting a pin to "no function" should always be supported. Move this
to mv88e6xxx_ptp_verify(). This allows mv88e6352_ptp_verify() to be
simplified as the only supported PTP pin mode function is
PTP_PF_EXTTS.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 drivers/net/dsa/mv88e6xxx/ptp.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/ptp.c b/drivers/net/dsa/mv88e6xxx/ptp.c
index 03f30424ba97..72ad6be05943 100644
--- a/drivers/net/dsa/mv88e6xxx/ptp.c
+++ b/drivers/net/dsa/mv88e6xxx/ptp.c
@@ -319,6 +319,10 @@ static int mv88e6xxx_ptp_verify(struct ptp_clock_info *ptp, unsigned int pin,
 {
 	struct mv88e6xxx_chip *chip = ptp_to_chip(ptp);
 
+	/* Always allow a pin to be set to no function */
+	if (func == PTP_PF_NONE)
+		return 0;
+
 	return chip->info->ops->ptp_ops->ptp_verify(chip, pin, func, chan);
 }
 
@@ -382,14 +386,9 @@ static int mv88e6352_ptp_enable(struct mv88e6xxx_chip *chip,
 static int mv88e6352_ptp_verify(struct mv88e6xxx_chip *chip, unsigned int pin,
 				enum ptp_pin_function func, unsigned int chan)
 {
-	switch (func) {
-	case PTP_PF_NONE:
-	case PTP_PF_EXTTS:
-		break;
-	case PTP_PF_PEROUT:
-	case PTP_PF_PHYSYNC:
+	if (func != PTP_PF_EXTTS)
 		return -EOPNOTSUPP;
-	}
+
 	return 0;
 }
 
-- 
2.47.3


