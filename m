Return-Path: <netdev+bounces-210888-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E037FB154C0
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 23:39:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F53018C092D
	for <lists+netdev@lfdr.de>; Tue, 29 Jul 2025 21:39:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E1D1279359;
	Tue, 29 Jul 2025 21:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="kRUTofvp"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0E8922539D;
	Tue, 29 Jul 2025 21:38:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753825134; cv=none; b=SYPbx5RMOtjzesgjdoxhjrcbi8KBX6IgtoeS0WhgexnpJzgh2cIKCyNz553+K60zvZf9DmOVW8k6KDLGbn86UxwB9jgj0sNkeHJVYn1eczAC04V31eifpfmGf+/JGZLxpu5Ty3qiFovLfCgroga2Ucgt7+6KsyF7OfukyrJPd5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753825134; c=relaxed/simple;
	bh=FKU6fQ4V7zP9CTK7la8Fetri5NOAexlnnfvH3zdAzEY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=W/FZ+kA0hl7oJ9ffrCyTRRdlbr9/krYVuEUV6Bam/lunbRTtXCFHE1UT/HjWrfvu9MRc7bBUzVHMTOjWvO1uo4eBz+jPtlt8P+EWTK8i7vSzOZ+JmdjWm1/VZCszLBTTYc+Tg8qqqlJEN4mNvxR/ZiXikRcyrRyHT/mF1dh7VhE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=kRUTofvp; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 84467C0003DD;
	Tue, 29 Jul 2025 14:31:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 84467C0003DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1753824716;
	bh=FKU6fQ4V7zP9CTK7la8Fetri5NOAexlnnfvH3zdAzEY=;
	h=From:To:Cc:Subject:Date:From;
	b=kRUTofvplBDYLEV1fLLX5w72S1kr4Kdny7htQJLuPQGub1Qtbx1h5mnb3arSZxDcv
	 AOmrv2KO0mVEIpgWe2iLdpZTfG9qfQlhJDY4yrW/sR0mE4ht+pgltPkPb/NRLRXC+X
	 WBCLx3sR5trgbdxLXIewbJ0hlxllLU1L7YKhEIMY=
Received: from stbirv-lnx-1.igp.broadcom.net (stbirv-lnx-1.igp.broadcom.net [10.67.48.32])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id 2D2AE18000530;
	Tue, 29 Jul 2025 14:31:56 -0700 (PDT)
From: Florian Fainelli <florian.fainelli@broadcom.com>
To: netdev@vger.kernel.org
Cc: Florian Fainelli <florian.fainelli@broadcom.com>,
	Doug Berger <opendmb@gmail.com>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net] net: mdio: mdio-bcm-unimac: Correct rate fallback logic
Date: Tue, 29 Jul 2025 14:31:48 -0700
Message-Id: <20250729213148.3403882-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case the rate for the parent clock is zero, make sure that we still
fallback to using a fixed rate for the divider calculation, otherwise we
simply ignore the desired MDIO bus clock frequency which can prevent us
from interfacing with Ethernet PHYs properly.

Fixes: ee975351cf0c ("net: mdio: mdio-bcm-unimac: Manage clock around I/O accesses")
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index b6e30bdf5325..9c0a11316cfd 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -209,10 +209,9 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 	if (ret)
 		return ret;
 
-	if (!priv->clk)
+	rate = clk_get_rate(priv->clk);
+	if (!priv->clk || !rate)
 		rate = 250000000;
-	else
-		rate = clk_get_rate(priv->clk);
 
 	div = (rate / (2 * priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
-- 
2.34.1


