Return-Path: <netdev+bounces-144969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0AD9C8E93
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 16:45:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 588071F24BE3
	for <lists+netdev@lfdr.de>; Thu, 14 Nov 2024 15:45:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 805D91AE009;
	Thu, 14 Nov 2024 15:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="QYahOLiF"
X-Original-To: netdev@vger.kernel.org
Received: from relay8-d.mail.gandi.net (relay8-d.mail.gandi.net [217.70.183.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1C81AAE0B;
	Thu, 14 Nov 2024 15:36:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731598579; cv=none; b=QCaawJtkLUd977gfpa5xJJvkIQ4JRAnUGK+KkNbSh3K4GwGkqNORYJ4hTGZOqoNWjeeQ/n9cKeaiF6dyhxYfHL/VCTqW4bTd/Sp14fCThPiJvfYipP1WIcKrwZO9eonTh1RYZGzlRCB6IjToXsk6EbUE3N4xRWPRmkjHUGrXbn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731598579; c=relaxed/simple;
	bh=iAIwa8BE5d3uS5cAE2NLdrDK1X6VTuX1FoFv8Iq+npA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ABuIbjgv+IiNphXVsuguh1QRAJvMvVl+SCy7c3lbKDUkvEhR+VP12yn5/MF0Q0HLl5HZwSFx0WmDdKD8z69iTDaBBPhgvQOqRwk8Yc4JylXAjGCSBYGVGWc++LdrwQi4tdbasljVm+rhv8XC/HVwpIeBQZWXoVZ0cOs2mhp8/Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=QYahOLiF; arc=none smtp.client-ip=217.70.183.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 8831D1BF20B;
	Thu, 14 Nov 2024 15:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1731598570;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GX711hqSGvX8B43wBtgMdev5PFTCzhCgQ+es8CQApoM=;
	b=QYahOLiFcVLSUhzjgCAI1G1Nyic5CJH+jyEQOacbF/zwOwRNJwTmk6BiywGOyNptPyp0XB
	HL9bskRPwMaPJFqHvvyR8d4ZWfJAxRN+bEx/Ihsf5h2QjKlcPlFxEYcXdfb3yQtXXxvttw
	/sQy7i0zLdf2AIRLGKidrsiApliygkWFL8uDsy34cZ2a5APN7sq+9S/RemVjH6uPXHUodk
	hcCtMMNJ7PTerj4mCUzhkEgNIqMhBsHBlCoUuh84yvRqsbxo2f9Zn7ISf7Nk3KToGHo3a4
	OLeG2K4xIkZOalQTXG6kYHLxgvU+xUUhtLdTGVHLCpF8IhvP6Lst69AQ5TBSHg==
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
	Herve Codina <herve.codina@bootlin.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	linuxppc-dev@lists.ozlabs.org
Subject: [PATCH net-next v2 05/10] net: freescale: ucc_geth: Use the correct type to store WoL opts
Date: Thu, 14 Nov 2024 16:35:56 +0100
Message-ID: <20241114153603.307872-6-maxime.chevallier@bootlin.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
References: <20241114153603.307872-1-maxime.chevallier@bootlin.com>
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
V2: New patch

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


