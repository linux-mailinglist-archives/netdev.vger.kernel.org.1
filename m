Return-Path: <netdev+bounces-158535-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8251DA12662
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C1BED188D980
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:44:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7E3986351;
	Wed, 15 Jan 2025 14:43:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from pidgin.makrotopia.org (pidgin.makrotopia.org [185.142.180.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 468EC86350;
	Wed, 15 Jan 2025 14:43:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.142.180.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736952230; cv=none; b=d1n6GJSIjEZ8xqOIasKvoRpgOoTwMbgkhnFwvt3qDvD4pG7UFSdInhVP6tCIWDqKKkCeoik4j4pEP4yNgfXb4MFUKES7fdf3LlcKqiuPee1TbVhWMvvrJT0LA4UyJfN/f2d0e5v0ZhNRTPsXp33Sqs1nMLerEpRsRjewri4RVAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736952230; c=relaxed/simple;
	bh=iO0i1fBXKLOrW0HnLcOBoKNmSDGv4+52sNOaJSWfMfM=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pqJLmIxVDVdwxSEyU8V1qz0f9Z4bxhU7EY6kxGSXMbQ5VdTpwU9MUFXPsPpSiLGEWNBwL5iVdKiuopGTxZrwLv6iFudjz8WQL9KmsaJ12ZCXwEHwgULiJEbgd/KsnouuWbCvoqjKwOT0pQKokVUDuDw21j9uiY8XqKzJDVnwp/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org; spf=pass smtp.mailfrom=makrotopia.org; arc=none smtp.client-ip=185.142.180.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=makrotopia.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=makrotopia.org
Received: from local
	by pidgin.makrotopia.org with esmtpsa (TLS1.3:TLS_AES_256_GCM_SHA384:256)
	 (Exim 4.98)
	(envelope-from <daniel@makrotopia.org>)
	id 1tY4cU-0000000022P-1tx2;
	Wed, 15 Jan 2025 14:43:46 +0000
Date: Wed, 15 Jan 2025 14:43:43 +0000
From: Daniel Golle <daniel@makrotopia.org>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Daniel Golle <daniel@makrotopia.org>,
	"Russell King (Oracle)" <linux@armlinux.org.uk>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH net 2/3] net: phy: realtek: clear master_slave_state if link
 is down
Message-ID: <2155887c3a665e4132a034df1e9cfdeec0ae48c9.1736951652.git.daniel@makrotopia.org>
References: <cover.1736951652.git.daniel@makrotopia.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1736951652.git.daniel@makrotopia.org>

rtlgen_decode_physr() which sets master_slave_state isn't called in case
the link is down and other than rtlgen_read_status(),
rtl822x_c45_read_status() doesn't implicitely clear master_slave_state.

Avoid stale master_slave_state by always setting it to
MASTER_SLAVE_STATE_UNKNOWN in rtl822x_c45_read_status() in case the link
is down.

Fixes: 081c9c0265c9 ("net: phy: realtek: read duplex and gbit master from PHYSR register")
Signed-off-by: Daniel Golle <daniel@makrotopia.org>
---
 drivers/net/phy/realtek.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/realtek.c b/drivers/net/phy/realtek.c
index 26b324ab0f90..93704abb6787 100644
--- a/drivers/net/phy/realtek.c
+++ b/drivers/net/phy/realtek.c
@@ -1038,8 +1038,10 @@ static int rtl822x_c45_read_status(struct phy_device *phydev)
 	if (ret < 0)
 		return ret;
 
-	if (!phydev->link)
+	if (!phydev->link) {
+		phydev->master_slave_state = MASTER_SLAVE_STATE_UNKNOWN;
 		return 0;
+	}
 
 	/* Read actual speed from vendor register. */
 	val = phy_read_mmd(phydev, MDIO_MMD_VEND2, RTL_VND2_PHYSR);
-- 
2.47.1

