Return-Path: <netdev+bounces-92568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 323C28B7F31
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 19:47:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5294BB213AA
	for <lists+netdev@lfdr.de>; Tue, 30 Apr 2024 17:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2119B18133E;
	Tue, 30 Apr 2024 17:46:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dn9Y2c3s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01B4181323
	for <netdev@vger.kernel.org>; Tue, 30 Apr 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714499213; cv=none; b=ofMjlzyLvBKEYUH/nlEJYZAjWCN42EZo99JzOTN6OfCQK+K1g7R0OmuVG4IsvCsoevpd3VIxT1h64h2FkJhpOBsfosNFErDJzJYFrBO4KRI8M0qM3gjxDAXbdj9wfPYrgmv0Ndxk/VN6mAvF2ZICQRV7j/Ry93rKJyk2j0mB+NU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714499213; c=relaxed/simple;
	bh=qBWIJ1R+gXj07Y3xxb9pLl+9tfzkhh5DsfIjDtieuGU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ajvG8L9jRglmz9h+IMkxQPZ7dJli2KORwcf/otlK9jsKFWZ8kLxVgMicWY55MbZFRgi8jv+Q6psd7JaYPjVXCow+XGGImbmHutexEX15hKWCmWThWmARe/EDArwTtuoQ5guMn6Q3atyenNZ2UHbijmEnlMWrmFUJMxlXgFYm4xQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dn9Y2c3s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8273C4AF17;
	Tue, 30 Apr 2024 17:46:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714499212;
	bh=qBWIJ1R+gXj07Y3xxb9pLl+9tfzkhh5DsfIjDtieuGU=;
	h=From:Date:Subject:To:Cc:From;
	b=dn9Y2c3spusGeruosyuBfbpz5ezHdkz5A7CJToSSkkWRzsycbw/5LsNzshUvIgMBP
	 Gcyrd9FDQ9k8VSPx3sRD8d9lysGnNi06gLncbg28f9EHZmmrDxu3TsRgDUKQdw1IiW
	 HwM8zOcF7sciREkPOyVQ2bkTwNaCMaESZ/SmV0l6jMVxAveYxEtIvZHzdTH0DLYW9d
	 oLkCe1b9NtqjJ1XU80yEAhPgIT3ZnfTxFkDIIVUK0UBP+d/KCRcI/XBz1gPjovxD7j
	 HPWHuvfxPDFyilExkMpFHmJHeruyn+TA9qbmRTP5PO+SRGtdztKKr3EinHrCK7pPR7
	 BYoHl92IvfxRw==
From: Simon Horman <horms@kernel.org>
Date: Tue, 30 Apr 2024 18:46:45 +0100
Subject: [PATCH net-next v3] net: dsa: mv88e6xxx: Correct check for empty
 list
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-mv88e6xx-list_empty-v3-1-c35c69d88d2e@kernel.org>
X-B4-Tracking: v=1; b=H4sIAIQuMWYC/33NTQqDMBAF4KtI1k3JX4121XuUUjQZNVSjJBIi4
 t0bsmqhdPl4877ZkQdnwKNrsSMHwXgz2xT4qUBqaGwP2OiUESNMEEFrPIWqgjJGPBq/PmFa1g1
 ryYngdbppOUrLxUFnYlbvyMKKLcQVPVIzpNHstvwu0Nz/lQPFFJei06Wm5FI31e0FzsJ4nl2fw
 cA+ECZ/IywhrVQgpJKyVfILOY7jDbJRVWUGAQAA
To: Andrew Lunn <andrew@lunn.ch>, Florian Fainelli <f.fainelli@gmail.com>, 
 Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Dan Carpenter <dan.carpenter@linaro.org>, 
 netdev@vger.kernel.org
X-Mailer: b4 0.12.3

Since commit a3c53be55c95 ("net: dsa: mv88e6xxx: Support multiple MDIO
busses") mv88e6xxx_default_mdio_bus() has checked that the
return value of list_first_entry() is non-NULL.

This appears to be intended to guard against the list chip->mdios being
empty.  However, it is not the correct check as the implementation of
list_first_entry is not designed to return NULL for empty lists.

Instead, use list_first_entry_or_null() which does return NULL if the
list is empty.

Flagged by Smatch.
Compile tested only.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Simon Horman <horms@kernel.org>
---
Changes in v3:
- Drop RFC designation, which should have been done for v2
- Refer to fix being to use list_first_entry_or_null().
  Thanks to Dan Carpenter.
- Link to v2: https://lore.kernel.org/r/20240427-mv88e6xx-list_empty-v2-1-b7ce47c77bc7@kernel.org

Changes in v2:
- Use list_first_entry_or_null() instead of open-coding
  a condition on list_empty().
  Suggested by Dan Carpenter.
- Update commit message.
- Link to v1: https://lore.kernel.org/r/20240419-mv88e6xx-list_empty-v1-1-64fd6d1059a8@kernel.org
---
As discussed in v1, this is not being considered a fix
as it has been like this for a long time without any
reported problems.
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index f29ef72a2f1d..fc6e2e3ab0f0 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -131,8 +131,8 @@ struct mii_bus *mv88e6xxx_default_mdio_bus(struct mv88e6xxx_chip *chip)
 {
 	struct mv88e6xxx_mdio_bus *mdio_bus;
 
-	mdio_bus = list_first_entry(&chip->mdios, struct mv88e6xxx_mdio_bus,
-				    list);
+	mdio_bus = list_first_entry_or_null(&chip->mdios,
+					    struct mv88e6xxx_mdio_bus, list);
 	if (!mdio_bus)
 		return NULL;
 


