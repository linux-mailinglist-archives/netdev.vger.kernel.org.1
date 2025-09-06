Return-Path: <netdev+bounces-220548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E656FB46878
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 04:33:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F6FDA07A25
	for <lists+netdev@lfdr.de>; Sat,  6 Sep 2025 02:33:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B1BF19539F;
	Sat,  6 Sep 2025 02:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Txu/5q/A"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2314E86344;
	Sat,  6 Sep 2025 02:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757126016; cv=none; b=lBIL4qcKhVuFrj/m5RJCtJ1//UNTyOnfcnfP4I3PrEYpWXHB5JYWBSrEJkNsZslDq4g4tbpCDzPt0O8k5c5KUaWU1XFaJbNsfyuIq4GKlbtN8AiCgu2+P/Lnucli2AXq+FWQriH2LEhlV+ZZW3QJDUOoGOSR3ZSNV8aPse/nOGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757126016; c=relaxed/simple;
	bh=CjjGp5mFgs4o3zElKsOPJs9kqVayuia7Wq0hfC2LnOg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=WGhKjidQGWS7yKt/h7aYBOaA0kEzA/E/tej8CKlu+JqLF+f8fdxnmM1ADEuvzU5BuFKtEmqi1rlxUfU9g+G44FvIASBJ2JTbRri4TvPSMe4gUvncoBMIF1swlGuDwuEhfsRBQSxa639xeqJxMqkHNr6bGoP86F/Uhh7sv3xg52o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Txu/5q/A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 91867C4CEF1;
	Sat,  6 Sep 2025 02:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757126015;
	bh=CjjGp5mFgs4o3zElKsOPJs9kqVayuia7Wq0hfC2LnOg=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=Txu/5q/AjgXJ5y2txBWMUMmu4eBrWrQYTm1cHd12xapRloQ/5/angQJh2Xy+42rJD
	 v5qJ3st1CY6igKSaIioojA7XFfYIms82uCHyiYxfwrGIXZfCRSrT6jcZ2N63TklGnv
	 PQaulmrOc8Q4M++C7+eXaY5eMftuOEfpNWYixy9MsPb8InxQAIed3OZ+oMLg56QYhP
	 cS2p5+PJL/giEwXESuZP1amN/RVUs2s+hFLr0WHb8qnjPbik0IIrCVKdDPT2vTv8D5
	 dZLVxs2Mj8tlEGvqdMxYAWu9LotoocNPFxFxq2YB7aKYE7A+13vzZp8x9sHdwoLLyB
	 B3Ylno9oniQ2w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CF75CA1016;
	Sat,  6 Sep 2025 02:33:35 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Sat, 06 Sep 2025 10:33:31 +0800
Subject: [PATCH net-next v2] net: phy: marvell: Fix 88e1510 downshift
 counter errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250906-marvell_fix-v2-1-f6efb286937f@altera.com>
X-B4-Tracking: v=1; b=H4sIAHudu2gC/22NQQrDIBRErxL+uhY1TUO66j1KKL/6bQSjRUVSg
 nevZN3lzGPe7JAoWkpw63aIVGyywbcgTx2oBf2bmNUtg+Ry4BOXbMVYyLmnsRvrjcReD8SNQmi
 LT6RWH7YHeMrM05ZhbmSxKYf4PW6KOPhfYxFMsMm8cMSruIxa39FlinhWYYW51voDH7YhJLEAA
 AA=
X-Change-ID: 20250902-marvell_fix-3f2a3d5e0fca
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1757126014; l=2972;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=F3FOWm0NbZN4sKFf4+eqpl1A14nM44VDQbAr1h+E1Bg=;
 b=unzfDhLUk4l296CnIJxfXm9dEr3kmLtzND7dWHQ6lCv6fJDgJR9lmfN192y2t+cZSYV28iRcC
 m7sr92qYlkIDmbhEkBJOo2XQztbk2t6/2+nHDuuYKCHDsvxlGjEOI/U
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

The 88e1510 PHY has an erratum where the phy downshift counter is not
cleared after phy being suspended(BMCR_PDOWN set) and then later
resumed(BMCR_PDOWN cleared). This can cause the gigabit link to
intermittently downshift to a lower speed.

Disabling and re-enabling the downshift feature clears the counter,
allowing the PHY to retry gigabit link negotiation up to the programmed
retry count times before downshifting. This behavior has been observed
on copper links.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
---
Changes in v2:
- Updated commit message and function description.
- Link to v1: https://lore.kernel.org/r/20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com
---
 drivers/net/phy/marvell.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 623292948fa706a2b0d8b98919ead8b609bbd949..0ea366c1217eb3a6ddc26a8333280c211bd9545c 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1902,6 +1902,43 @@ static int marvell_resume(struct phy_device *phydev)
 	return err;
 }
 
+/* m88e1510_resume
+ *
+ * The 88e1510 PHY has an erratum where the phy downshift counter is not cleared
+ * after phy being suspended(BMCR_PDOWN set) and then later resumed(BMCR_PDOWN
+ * cleared). This can cause the link to intermittently downshift to a lower speed.
+ *
+ * Disabling and re-enabling the downshift feature clears the counter, allowing
+ * the PHY to retry gigabit link negotiation up to the programmed retry count
+ * before downshifting. This behavior has been observed on copper links.
+ */
+static int m88e1510_resume(struct phy_device *phydev)
+{
+	int err;
+	u8 cnt = 0;
+
+	err = marvell_resume(phydev);
+	if (err < 0)
+		return err;
+
+	/* read downshift counter value */
+	err = m88e1011_get_downshift(phydev, &cnt);
+	if (err < 0)
+		return err;
+
+	if (cnt) {
+		/* downshift disabled */
+		err = m88e1011_set_downshift(phydev, 0);
+		if (err < 0)
+			return err;
+
+		/* downshift enabled, with previous counter value */
+		err = m88e1011_set_downshift(phydev, cnt);
+	}
+
+	return err;
+}
+
 static int marvell_aneg_done(struct phy_device *phydev)
 {
 	int retval = phy_read(phydev, MII_M1011_PHY_STATUS);
@@ -3923,7 +3960,7 @@ static struct phy_driver marvell_drivers[] = {
 		.handle_interrupt = marvell_handle_interrupt,
 		.get_wol = m88e1318_get_wol,
 		.set_wol = m88e1318_set_wol,
-		.resume = marvell_resume,
+		.resume = m88e1510_resume,
 		.suspend = marvell_suspend,
 		.read_page = marvell_read_page,
 		.write_page = marvell_write_page,

---
base-commit: 2fd4161d0d2547650d9559d57fc67b4e0a26a9e3
change-id: 20250902-marvell_fix-3f2a3d5e0fca

Best regards,
-- 
Rohan G Thomas <rohan.g.thomas@altera.com>



