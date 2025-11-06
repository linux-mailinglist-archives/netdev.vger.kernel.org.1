Return-Path: <netdev+bounces-236352-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 890B6C3B0A8
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 14:00:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BCCB31AA28F2
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 12:54:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEA3032D43E;
	Thu,  6 Nov 2025 12:53:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KfTiNcb2"
X-Original-To: netdev@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675FD32AAD8
	for <netdev@vger.kernel.org>; Thu,  6 Nov 2025 12:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762433601; cv=none; b=EreIGkTxU9EzdWMiajlmjbAcfs+XwxQCvX0HEtUtabb4Co2jf1Y/qafiNcj3Kh0I3XQh6ATXGMEWFJ5CQAKIghli60QVp1P7q+uSCPg7e/WIzT+CmM/m+BansQuUqmIQOOnmD/E8Nv6+zrg+aBoaa3Sh59xvSARK8mRmGe7fzK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762433601; c=relaxed/simple;
	bh=7iYJ58BtlFxh5N4iUZr364GIyx6CI8EugINx7k/GPGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=sA5otsbceNRxo7PU8wcxJEyVrf2JfQj85ttfjpc1Lr6YK152y0s/f8zBTWYTZH0K1TmgjSz8JPryGUDx6RetGCYTXUAzvNgLDYLmzkZS3LRXtdHUTij8SCW1bfySlobAKVgRCOrJc/rD3V1h8E5McRlnkRWBADArALHXFSjKjmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KfTiNcb2; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id A992AC0FA8B;
	Thu,  6 Nov 2025 12:52:56 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id B90046068C;
	Thu,  6 Nov 2025 12:53:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id B57F011851026;
	Thu,  6 Nov 2025 13:53:15 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1762433597; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=1kW23ym1qnGitde+ICvZliYafoUJFTsz+cQqqnstk2I=;
	b=KfTiNcb2SktS5gXFxeLxKb2KcDHFrbuTj/xhx2G47u3EY0Js6ZdMP/cVC7nHOWHyLxyoCU
	uIWVCJ5f8DCfd6D3jZor15lECxcarAOFsgQ19lF5fp+r3Yjp9gNGcaH/6TqflWn20w/6VV
	x0+6/DLsFCQHMkRR1as/ayxbcXCFoIlssAWqnH1gk4aHM7r2KP843m1gF0d4avyWQS/9GF
	nAd3Ph8dZKSXsI7/gmLtoqM9fLgO8378VAPoXunRGGDvtgNdXx9z2l9SbAc4vW9+dFahJr
	UKuzTDrc/+ChxqLkm+Thr42JGlrP9FG2G2sMHpmn1IW/Yuw++1FhLOTmLQm4og==
From: "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
Date: Thu, 06 Nov 2025 13:53:08 +0100
Subject: [PATCH net v2 1/4] net: dsa: microchip: common: Fix checks on
 irq_find_mapping()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251106-ksz-fix-v2-1-07188f608873@bootlin.com>
References: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
In-Reply-To: <20251106-ksz-fix-v2-0-07188f608873@bootlin.com>
To: Woojung Huh <woojung.huh@microchip.com>, UNGLinuxDriver@microchip.com, 
 Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Arun Ramadoss <arun.ramadoss@microchip.com>
Cc: Pascal Eberhard <pascal.eberhard@se.com>, 
 =?utf-8?q?Miqu=C3=A8l_Raynal?= <miquel.raynal@bootlin.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 "Bastien Curutchet (Schneider Electric)" <bastien.curutchet@bootlin.com>
X-Mailer: b4 0.14.2
X-Last-TLS-Session-Version: TLSv1.3

irq_find_mapping() returns a positive IRQ number or 0 if no IRQ is found
but it never returns a negative value. However, on each
irq_find_mapping() call, we verify that the returned value isn't
negative.

Fix the irq_find_mapping() checks to enter error paths when 0 is
returned. Return -EINVAL in such cases.

Fixes: ff319a644829 ("net: dsa: microchip: move interrupt handling logic from lan937x to ksz_common")
Signed-off-by: Bastien Curutchet (Schneider Electric) <bastien.curutchet@bootlin.com>
---
 drivers/net/dsa/microchip/ksz_common.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/dsa/microchip/ksz_common.c b/drivers/net/dsa/microchip/ksz_common.c
index a962055bfdbd8fbfc135b2dec73c222a213985c4..3a4516d32aa5f99109853ed400e64f8f7e2d8016 100644
--- a/drivers/net/dsa/microchip/ksz_common.c
+++ b/drivers/net/dsa/microchip/ksz_common.c
@@ -2583,8 +2583,8 @@ static int ksz_irq_phy_setup(struct ksz_device *dev)
 
 			irq = irq_find_mapping(dev->ports[port].pirq.domain,
 					       PORT_SRC_PHY_INT);
-			if (irq < 0) {
-				ret = irq;
+			if (!irq) {
+				ret = -EINVAL;
 				goto out;
 			}
 			ds->user_mii_bus->irq[phy] = irq;
@@ -2948,8 +2948,8 @@ static int ksz_pirq_setup(struct ksz_device *dev, u8 p)
 	snprintf(pirq->name, sizeof(pirq->name), "port_irq-%d", p);
 
 	pirq->irq_num = irq_find_mapping(dev->girq.domain, p);
-	if (pirq->irq_num < 0)
-		return pirq->irq_num;
+	if (!pirq->irq_num)
+		return -EINVAL;
 
 	return ksz_irq_common_setup(dev, pirq);
 }

-- 
2.51.0


