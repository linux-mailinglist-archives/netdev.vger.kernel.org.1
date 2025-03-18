Return-Path: <netdev+bounces-175914-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 447B5A67F4C
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 23:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AB55189EBD0
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 22:08:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67C9721423E;
	Tue, 18 Mar 2025 22:07:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fB7wEb3a"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1F60207644;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742335639; cv=none; b=GqEstq0ocxSMBOPmnHvYxlh4aSY75Zfa3W3tvteDVH//MST+ZJ1JdHIJ8me3d4q1iWuqpG780qxc06viyeY2xCeozxqjf0XqiS026JbLgPpbS6Up3Zxw/IX1fZS9smzE0HKePi0IxFMYjBrBgonr6c4A0IsWzkcRnSovfH6zngA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742335639; c=relaxed/simple;
	bh=EM/HTJTYUy4cmOhlXtI75NuIViEmrNIODNKg+zDNqvQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=GeMkExhWXUr5ieLX+Ed0kKBmIug0Mb/3jaqC/Ioyk3saTAB3510ASA+AxC+fpNMBkl32mdtf9nMjFYV3V9OlgTkChYnTv6ECC08D/BY3CsFguFgHfc67L0KRqiGdBngtP6166ljnrNuM63AfFGqoQ8EizJ8R6Dc8YT1ES+kqKgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fB7wEb3a; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 9724CC4CEF8;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742335638;
	bh=EM/HTJTYUy4cmOhlXtI75NuIViEmrNIODNKg+zDNqvQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=fB7wEb3aYoEqtL2O7emmNkWpephKD7eT+WiCz7qvxGpLQT0CXkgX0hGUCbVQtP/KF
	 IhG9Rn5QGclPDiAy1UmHob9X3cxsyUL3hH78wJGWFa42L5V3eHBnQn2lglABrW9s9x
	 b9PXh5kw4mBZbMMKWRhrceSGsn+Iyy5dsXvoQw9SvY5VsRdUIKuRFL4C7aCdtFs208
	 vOZLAkenvF3pUmeVQ2VB7OXYn4FfU0EO43WELtNS5Y0YTYtJwmjWkoKGsaw7zP6bq+
	 wjyDeokmAl/z282IfVj5CjICMi6RpyfIhpO4Or4QNJlXjs/m8OJrNPgJsJq5a0K76U
	 7A+RXEOSYaBSA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FEF6C35FFA;
	Tue, 18 Mar 2025 22:07:18 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Tue, 18 Mar 2025 23:06:57 +0100
Subject: [PATCH net-next v6 6/7] net: tn40xx: prepare tn40xx driver to find
 phy of the TN9510 card
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250318-tn9510-v3a-v6-6-808a9089d24b@gmx.net>
References: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
In-Reply-To: <20250318-tn9510-v3a-v6-0-808a9089d24b@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742335636; l=1514;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=aZl1HKZEv54c7prm4pCHWas0s9cQ/IoY2mjVEEro9Xw=;
 b=eZceaLzia6W8xLw+tUi4NniFa+5xzG2bW7tzjdWK3Iqgk9XWqVtuyhbL0fSpNJccphPWnRf4Z
 jF/6kNd7UAGAPgKeoAK5yfkgqXaS8zFF+ZCF8eZpVfZE2sLwKbvJl3x
X-Developer-Key: i=hfdevel@gmx.net; a=ed25519;
 pk=s3DJ3DFe6BJDRAcnd7VGvvwPXcLgV8mrfbpt8B9coRc=
X-Endpoint-Received: by B4 Relay for hfdevel@gmx.net/20240915 with
 auth_id=209
X-Original-From: Hans-Frieder Vogt <hfdevel@gmx.net>
Reply-To: hfdevel@gmx.net

From: Hans-Frieder Vogt <hfdevel@gmx.net>

Prepare the tn40xx driver to load for Tehuti TN9510 cards, which require
bit 3 in the register TN40_REG_MDIO_CMD_STAT to be set. The function of bit
3 is unclear, but may have something to do with the length of the preamble
in the MDIO communication. If bit 3 is not set, the PHY will not be found
when performing a scan for PHYs. Use the available tn40_mdio_set_speed
function which includes setting bit 3. Just move the function to before the
devm_mdio_register function, which scans the mdio bus for PHYs.

Signed-off-by: Hans-Frieder Vogt <hfdevel@gmx.net>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: FUJITA Tomonori <fujita.tomonori@gmail.com>
---
 drivers/net/ethernet/tehuti/tn40_mdio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/tehuti/tn40_mdio.c b/drivers/net/ethernet/tehuti/tn40_mdio.c
index 342b4a6317021578bbbce1f38ae1b1e909fe9faf..973785cde8ef940b804589c650830f385164402c 100644
--- a/drivers/net/ethernet/tehuti/tn40_mdio.c
+++ b/drivers/net/ethernet/tehuti/tn40_mdio.c
@@ -200,13 +200,13 @@ int tn40_mdiobus_init(struct tn40_priv *priv)
 		}
 	}
 
+	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	ret = devm_mdiobus_register(&pdev->dev, bus);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to register mdiobus %d %u %u\n",
 			ret, bus->state, MDIOBUS_UNREGISTERED);
 		goto err_swnodes_cleanup;
 	}
-	tn40_mdio_set_speed(priv, TN40_MDIO_SPEED_6MHZ);
 	return 0;
 
 err_swnodes_unregister:

-- 
2.47.2



