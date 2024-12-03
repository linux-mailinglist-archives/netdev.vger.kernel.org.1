Return-Path: <netdev+bounces-148468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A8409E1D49
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 14:15:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88B55B3BE98
	for <lists+netdev@lfdr.de>; Tue,  3 Dec 2024 12:44:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 853321EF0A4;
	Tue,  3 Dec 2024 12:43:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="BYanB+no"
X-Original-To: netdev@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 881751EE005;
	Tue,  3 Dec 2024 12:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733229815; cv=none; b=rHXCLVG2gW7k95Qlh6oMZfUjYILL24ltf0FKCAQnmNRVcc6/wxd+SxoK3DhIQqAL+d622dE8FZQBG+wG/MEF+wZXPFpCaCgPp7syiDsi/If7OYSiGP8DXzWLqdVf6hKQtnrXt5zaIFDiknjn7f4FG/+3KchRejtT0dqFngNRUqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733229815; c=relaxed/simple;
	bh=N5R5qhdqwNAek1G1c451xc7iVS/jxMWDYfea8kFJ7Bk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sM5dJcpM/yZhiCunJ2LLCrf+94riEil6v7aGPzwatXp4mZbsxs0UmBkSDLbfpX7MzOpgk6qrJWLkEE6Gb8tS1wtuA5tDU7/XOZUhJ9FT3xAcO+krMMMMx0P6ytgdvZPi0pTHHuuHTfGxRmN/WfbTIKCqehssBHYQw2iYO0TzkOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=BYanB+no; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id D1A57E000A;
	Tue,  3 Dec 2024 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1733229811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Y48dg3gXGpgzyZF5ZkvFdVhp7VJIaTg4ag661mUvv8g=;
	b=BYanB+noQx9zX34A/WMxd5icmD/vBasvKlUR86GUNpSXBGEMnMp0mSVHL8zBUb3WtcRJ5s
	XkGvhv/sDdUFMPOOFys4ibMFapn88OGMq2nnU9nZIXjt9/wV2BR29wlXbXjLTqKPiFyUrX
	rTcwNmID0cuCcYgBJPOgShZ31NI59525FJarHO3ytagYJgQYQCHSYXgjgYTWq7bWwk+3tf
	NwUfd4DzVI2WLs7S8sn/e9LtMSM94496eYT4MmJKoVR5gwG8PQHJ944TzVKMAatxXEvVBC
	06/N78lTx+wkqAp6gHmmLcHUph0qKVTnyYropTRlaCcLSsJNAPMfZ54PANGFNA==
From: Maxime Chevallier <maxime.chevallier@bootlin.com>
To: davem@davemloft.net,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Russell King <linux@armlinux.org.uk>,
	Christophe Leroy <christophe.leroy@csgroup.eu>,
	Heiner Kallweit <hkallweit1@gmail.com>
Cc: Maxime Chevallier <maxime.chevallier@bootlin.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	thomas.petazzoni@bootlin.com,
	Simon Horman <horms@kernel.org>,
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v3 05/10] net: freescale: ucc_geth: Use the correct type to store WoL opts
Date: Tue,  3 Dec 2024 13:43:16 +0100
Message-ID: <20241203124323.155866-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
References: <20241203124323.155866-1-maxime.chevallier@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: maxime.chevallier@bootlin.com

The WoL opts are represented through a bitmask stored in a u32. As this
mask is copied as-is in the driver, make sure we use the exact same type
to store them internally.

Signed-off-by: Maxime Chevallier <maxime.chevallier@bootlin.com>
---
V3: No changes

 drivers/net/ethernet/freescale/ucc_geth.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index e08cfc8d8904..60fd804a616a 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -1216,7 +1216,7 @@ struct ucc_geth_private {
 	int oldspeed;
 	int oldduplex;
 	int oldlink;
-	int wol_en;
+	u32 wol_en;
 	u32 phy_wol_en;
 
 	struct device_node *node;
-- 
2.47.0


