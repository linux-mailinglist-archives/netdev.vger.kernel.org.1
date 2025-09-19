Return-Path: <netdev+bounces-224745-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 02141B891B3
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 12:42:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5BD80563ED6
	for <lists+netdev@lfdr.de>; Fri, 19 Sep 2025 10:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 172D23093A6;
	Fri, 19 Sep 2025 10:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QFuTWF2W"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FA1309DA5
	for <netdev@vger.kernel.org>; Fri, 19 Sep 2025 10:41:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758278479; cv=none; b=KWQCvQx8kEdh/8MYGCa+Vz7FMnCCuUmrHAnB8tWHf9mzQGMcX7ixfZeMIHIV+RBxX2Zn8amnaTqGzPZFtKgz5X8tO35sh8a6vd7M9csp1SPSYxd16oRxq/nJSOpwM8VtyIVUr+yjDwWxGkRuYtEV7ZWaIQ5PwFkAhZqu/4W2Ek0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758278479; c=relaxed/simple;
	bh=uTAtD7aODE7uH6D0FhShlFBL8jc3OOJR20yLHHGiljM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dwT+RvEM8OrFaxWZuqoqF6JIIMwsoV0xtVioA2V/cJxFVZsPK3FEE0VFbZwUZcn0NmYmmefP7IdLCRpWuoYQhg900F5KT17+rgsrrmCzPawL8tR52QX5vtPYbNWfJbDbONPF9iJ2ee9S/0lhQm/eFV7wYImfRrXLCm6CISgIKB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QFuTWF2W; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1758278460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=EJcrZ/vktQibDcGUoo61PJNxuvOdWBLOHz357ldlpGs=;
	b=QFuTWF2W1BUrPRgN1d6xtZ+kZsxZrosgMY46eVYeZkI/vry5/4TkE0CAuThVVej5YiDwd8
	bzqwos3bWD6PLUSCdJwzgURIDlybEy6in11ifi16zSkFuC/rx/jkPYc4bM/xqyWFXWdCcd
	+QNpblXh5peiewzeCfjwaS7lWKWCwSU=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] net: phy: ax88796b: Replace hard-coded values with PHY_ID_MATCH_MODEL()
Date: Fri, 19 Sep 2025 12:39:45 +0200
Message-ID: <20250919103944.854845-2-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Use the PHY_ID_MATCH_MODEL() macro instead of hardcoding the values in
asix_driver[] and asix_tbl[].

In asix_tbl[], the macro also uses designated initializers instead of
positional initializers, which allows the struct fields to be reordered.

Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/net/phy/ax88796b.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/phy/ax88796b.c b/drivers/net/phy/ax88796b.c
index 694df1401aa2..f20ddf649149 100644
--- a/drivers/net/phy/ax88796b.c
+++ b/drivers/net/phy/ax88796b.c
@@ -112,9 +112,8 @@ static struct phy_driver asix_driver[] = {
 	.resume		= genphy_resume,
 	.soft_reset	= asix_soft_reset,
 }, {
-	.phy_id		= PHY_ID_ASIX_AX88796B,
+	PHY_ID_MATCH_MODEL(PHY_ID_ASIX_AX88796B),
 	.name		= "Asix Electronics AX88796B",
-	.phy_id_mask	= 0xfffffff0,
 	/* PHY_BASIC_FEATURES */
 	.soft_reset	= asix_soft_reset,
 } };
@@ -124,7 +123,7 @@ module_phy_driver(asix_driver);
 static const struct mdio_device_id __maybe_unused asix_tbl[] = {
 	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772A) },
 	{ PHY_ID_MATCH_EXACT(PHY_ID_ASIX_AX88772C) },
-	{ PHY_ID_ASIX_AX88796B, 0xfffffff0 },
+	{ PHY_ID_MATCH_MODEL(PHY_ID_ASIX_AX88796B) },
 	{ }
 };
 
-- 
2.51.0


