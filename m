Return-Path: <netdev+bounces-212544-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50055B212DE
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 19:09:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F39F620CA0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 17:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF5212C21E0;
	Mon, 11 Aug 2025 17:09:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="T87r1Esh"
X-Original-To: netdev@vger.kernel.org
Received: from relay.smtp-ext.broadcom.com (relay.smtp-ext.broadcom.com [192.19.144.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 663B029BDAA;
	Mon, 11 Aug 2025 17:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.19.144.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754932148; cv=none; b=BD5qoz9s44xSrY1GPtxRltmNyXe4i22fbCTRZQS0PPMTiNVwRYkMNNuSqhPPbV7NwEUapcn5Zs7gUNedUACC+B2qNGU3maD9Vuu5PY5HnT6342GLssU+Qjs1a3C5W4iht7Di+oxyB+h8Iq+mfdtwqLyW9qBYZITmy1umEUA7hL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754932148; c=relaxed/simple;
	bh=xYofdvRO7j1Ase2qXJ0tdVFtD+PZbY32/7zmF+57inc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J+jnb2HdtPDQ4+qFXmZtxJlwZwQj2zaq1PmabngTVv2chYn6XRdkaIskJrTsbTXrFW/I6w301yhCXUSR7csfq43NKiX9ETJ0MnciDZCn2RXflOc7GKdr68BGw/cApe1Fgo/XqWcXB2mKhbii7pu5wRihGcNm6gsdZw3s3m5GWIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=T87r1Esh; arc=none smtp.client-ip=192.19.144.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: from mail-lvn-it-01.broadcom.com (mail-lvn-it-01.lvn.broadcom.net [10.36.132.253])
	by relay.smtp-ext.broadcom.com (Postfix) with ESMTP id 37CAAC0005CB;
	Mon, 11 Aug 2025 09:59:54 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 37CAAC0005CB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
	s=dkimrelay; t=1754931594;
	bh=xYofdvRO7j1Ase2qXJ0tdVFtD+PZbY32/7zmF+57inc=;
	h=From:To:Cc:Subject:Date:From;
	b=T87r1Eshs7/fCvDSzxx3dSIQSKQ2JWNa63ipEz1BPorQTizrxV0T+b7QhWF4sukHx
	 oYOf4PIoe6GCI6tqLfZ3YzD9bwdbu9rzh7sFOkMJyJrl9Pd8kLgDdBuWN3CXkj5qIr
	 FC2t66abBZGHgQyY6p+ElOf0LPuJ24jimlufjLls=
Received: from fainelli-desktop.igp.broadcom.net (fainelli-desktop.dhcp.broadcom.net [10.67.48.245])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail-lvn-it-01.broadcom.com (Postfix) with ESMTPSA id C1BBD18000A5F;
	Mon, 11 Aug 2025 09:59:23 -0700 (PDT)
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
	linux-kernel@vger.kernel.org (open list)
Subject: [PATCH net-next] net: mdio: mdio-bcm-unimac: Refine incorrect clock message
Date: Mon, 11 Aug 2025 09:59:21 -0700
Message-ID: <20250811165921.392030-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In light of a81649a4efd3 ("net: mdio: mdio-bcm-unimac: Correct rate
fallback logic"), it became clear that the warning should be specific to
the MDIO controller instance, and there should be further information
provided to indicate what is wrong, whether the requested clock
frequency or the rate calculation. Clarify the message accordingly.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
 drivers/net/mdio/mdio-bcm-unimac.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/mdio/mdio-bcm-unimac.c b/drivers/net/mdio/mdio-bcm-unimac.c
index 7baab230008a..37e35f282d9a 100644
--- a/drivers/net/mdio/mdio-bcm-unimac.c
+++ b/drivers/net/mdio/mdio-bcm-unimac.c
@@ -215,7 +215,9 @@ static int unimac_mdio_clk_set(struct unimac_mdio_priv *priv)
 
 	div = (rate / (2 * priv->clk_freq)) - 1;
 	if (div & ~MDIO_CLK_DIV_MASK) {
-		pr_warn("Incorrect MDIO clock frequency, ignoring\n");
+		dev_warn(priv->mii_bus->parent,
+			 "Ignoring MDIO clock frequency request: %d vs. rate: %ld\n",
+			 priv->clk_freq, rate);
 		ret = 0;
 		goto out;
 	}
-- 
2.43.0


