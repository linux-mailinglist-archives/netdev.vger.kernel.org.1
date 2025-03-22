Return-Path: <netdev+bounces-176865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B619A6C9CA
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 11:47:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8511E1B65AF5
	for <lists+netdev@lfdr.de>; Sat, 22 Mar 2025 10:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93010221548;
	Sat, 22 Mar 2025 10:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="r//i78nL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 625181FBE8B;
	Sat, 22 Mar 2025 10:46:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742640369; cv=none; b=AdhbqLJR2gaFchy9kSsbGuuDi/+XUrm5dmrDC6fJ0Y9K8/J0uqvIjeVv066YeWj2JHe8lXQTh9q5bqZ1RWf0xMWw0Qu7cG2631S8RMYDQf+1JBQU/MvKrmLjOWj/s3PgZ5Ci52eHHr27T+ksR6mmsnIWs/PTpSbMJ83MbJeOzio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742640369; c=relaxed/simple;
	bh=6YmQj1YxsDITToMqOPzQOdN+VpCzBrmn95W+WlkB1JU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SF3O8TdsWewQxEFxN4Cmn/qbxxo6Tg3xMbdmGbOXBIhozjLqoXiyLEq/f5J0Zm2GP5nT+edKP+FMWzJDsFAsZAaLT8Os+b+D4MVX2vbrymtpJY6Simt0LUNLAHyw1saoUAkSW2T9yaPaAw2neT40bkpu62V8T8agiThb+ydlzOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=r//i78nL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id D4918C4CEF5;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742640368;
	bh=6YmQj1YxsDITToMqOPzQOdN+VpCzBrmn95W+WlkB1JU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To:From;
	b=r//i78nLRLP52eGf7cJZlS1UvMff4Fx3rE6dkR8/iOkO26v5EjhbUK5iy2ZnvaPaP
	 63wHYavXuOelBVcqpfsDCFcEQieHl5ApdWOqIvVa/3b57TLs1q/Xqjfn60rewS3QMB
	 EtXeCkChXZKEYCz1zkrm8Ae1NEoDV7xvNh+EtumjqGhUBPJrvjrcLIATiVPViIzkJx
	 /U/MS7JzLQU55cMNE1wnWuEbpJfT/+Jg9VGNjyf+xwuln1bKiVQpBE+MCG1IcTtnoc
	 9LbYx2eACAt9imzkVpzG5wVMDz14NlervZxf1sKiSn9Ulr6T+qrV7uzoGly5/XPuGv
	 MyR2ZxUmNI2Lg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCB5AC3600A;
	Sat, 22 Mar 2025 10:46:08 +0000 (UTC)
From: Hans-Frieder Vogt via B4 Relay <devnull+hfdevel.gmx.net@kernel.org>
Date: Sat, 22 Mar 2025 11:45:57 +0100
Subject: [PATCH net-next v7 6/7] net: tn40xx: prepare tn40xx driver to find
 phy of the TN9510 card
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250322-tn9510-v3a-v7-6-672a9a3d8628@gmx.net>
References: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
In-Reply-To: <20250322-tn9510-v3a-v7-0-672a9a3d8628@gmx.net>
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 FUJITA Tomonori <fujita.tomonori@gmail.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Hans-Frieder Vogt <hfdevel@gmx.net>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1742640367; l=1514;
 i=hfdevel@gmx.net; s=20240915; h=from:subject:message-id;
 bh=FHzhMDcYn0WJzfuyGOmQtKpwwoxyjDmyIphfAS+vBhs=;
 b=uQlQ8T5Hbx7d/6MmwN7+kijl2U1ZplgP0Ix453kZ3ck22Exwb2uSxqye1AQ/iR4p3qmBK4/nv
 xf5gH6Iw3AeDNco0sJqm5h/4IqjcWAALHkBQThKwFssRU1kAWis0GD1
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
index 5bb0cbc87d064e3f697a88f5b96bc9a38a2ffd12..fb1a4a2e4dbc552a90934ab92300fcd98ef903c4 100644
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



