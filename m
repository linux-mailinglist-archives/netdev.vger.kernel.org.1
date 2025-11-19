Return-Path: <netdev+bounces-239983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B064C6EAD0
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 14:05:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C17353A4C62
	for <lists+netdev@lfdr.de>; Wed, 19 Nov 2025 12:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611B734F481;
	Wed, 19 Nov 2025 12:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b="pzAMxA3K"
X-Original-To: netdev@vger.kernel.org
Received: from mail.thorsis.com (mail.thorsis.com [217.92.40.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BE752DC79A;
	Wed, 19 Nov 2025 12:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.92.40.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763557061; cv=none; b=gJjgiWUfBw7+SbfvV0rTfoqeAO2LUyXFoVAJ2nXpti+VhU5Rvl1Awa/W2fDcPH9vaZfWdsX41Tl6IX3CIiGu9JwR//GpcysMezhmZQJhzv3wU2tv60Y1IpQ8fcUPF+YGP32Yzg74VWi2ZzNibsb+3A1qzvensrqOSm9pz/iq1Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763557061; c=relaxed/simple;
	bh=lDpfDZZLzKC/+8YOzOt8G6Q/lq3VVu1m1qnnMWi3BMA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=HPSfj2hn4aMMrU5eTvJWyfJRiCb0zKruRzS/WJyWNus6DNKK/Oiv1+qCzFvT2KzovYLU/3pZ653OKpgTqXTv0fkPdJLdIH8TpbIrv9wbu1DmpYarhGt/zAawcF9S53IA1FthERhMLdEgGePC9/Od0tQJJ2EUOekJAGsMAfCpvus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com; spf=pass smtp.mailfrom=thorsis.com; dkim=pass (2048-bit key) header.d=thorsis.com header.i=@thorsis.com header.b=pzAMxA3K; arc=none smtp.client-ip=217.92.40.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=thorsis.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=thorsis.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 8BF72148417A;
	Wed, 19 Nov 2025 13:47:47 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=thorsis.com; s=dkim;
	t=1763556467; h=from:subject:date:message-id:to:cc:mime-version:
	 content-transfer-encoding:in-reply-to:references;
	bh=4QLcm5qkXXAuRIaVPLg1w01B5zqSyUJCjYnONDVhwi8=;
	b=pzAMxA3KunClD3pc0EolMdlA6knRcGjewgVmOHhHbLFYlcuVZNDe0R2cDtD3X7UOOyVsCW
	/XLhAaNBtfQ/suce1cPIrwZYNqH0zTsCBU414TKk/3YkMXIu4usK3VSSr67tcth1NZAF0p
	uhIBFupIuSLSF4T0kQ+6cbWPh90uNCxnvf3Naw1XFEZAVvrFuk2IULpN2tI9KOAso7+A2f
	5GxwjOwcL8BQRBbaChN/ISmqFReMNE21haqTW4T1WiPKZ8EkACIvzWL1lEOIGkR+D0ARy2
	Re0mjVbXdcnIcqJ/kLmB9+dghoBwt5SDuaNAscpwGSSOmrpf3ce/y9G/Y4INwg==
From: Alexander Dahl <ada@thorsis.com>
To: netdev@vger.kernel.org
Cc: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH 2/2] net: phy: adin1100: Simplify register value passing
Date: Wed, 19 Nov 2025 13:47:37 +0100
Message-Id: <20251119124737.280939-3-ada@thorsis.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20251119124737.280939-1-ada@thorsis.com>
References: <20251119124737.280939-1-ada@thorsis.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

The additional use case for that variable is gone,
the expression is simple enough to pass it inline now.

Signed-off-by: Alexander Dahl <ada@thorsis.com>
---
 drivers/net/phy/adin1100.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/adin1100.c b/drivers/net/phy/adin1100.c
index 10b796c2daee..8f9753d4318c 100644
--- a/drivers/net/phy/adin1100.c
+++ b/drivers/net/phy/adin1100.c
@@ -192,11 +192,10 @@ static irqreturn_t adin_phy_handle_interrupt(struct phy_device *phydev)
 static int adin_set_powerdown_mode(struct phy_device *phydev, bool en)
 {
 	int ret;
-	int val;
 
-	val = en ? ADIN_CRSM_SFT_PD_CNTRL_EN : 0;
 	ret = phy_write_mmd(phydev, MDIO_MMD_VEND1,
-			    ADIN_CRSM_SFT_PD_CNTRL, val);
+			    ADIN_CRSM_SFT_PD_CNTRL,
+			    en ? ADIN_CRSM_SFT_PD_CNTRL_EN : 0);
 	if (ret < 0)
 		return ret;
 
-- 
2.39.5


