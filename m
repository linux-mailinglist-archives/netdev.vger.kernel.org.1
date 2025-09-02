Return-Path: <netdev+bounces-218996-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 96048B3F4E8
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 08:00:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5157A3A7F56
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 06:00:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D587A2DF120;
	Tue,  2 Sep 2025 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MefpEwNl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF64C2E264D;
	Tue,  2 Sep 2025 06:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756792805; cv=none; b=JfICCn4TLm+s/F75OMsYhn7LvN0WNuijj/r4pJawAp4S5jiTDrej+AjFOwr/0XBT1p9JvTMRwLt175q6VagMaDhprY+yfvI0r4T72ROQwiQ2zTCPb1WqxAFXF07t6ss2Qw4vFtrmEKoV1/wOnobykQokeM0bHEp9Wph+XQbES9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756792805; c=relaxed/simple;
	bh=b7omN1BWe25O8EiNt+XfatAiHy9vm6h6D0V38Wn/hc0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=ZSbjHDDpfx6w1iRlqWjFEpjHZb3fH+gNieNjAlf3/tZdTo8O9lj1c2HUxUI5GXQGtJh8nqgf9W5zJGgkByK7677MeqCpAK6+pHoZdIvXqNlW8e1tBTkZaqu9FFYEw1QLHGDtM7VgRz+MhYpO/yWrInwWgb9g9DotxMlE0YWrWwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MefpEwNl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 38AC8C4CEED;
	Tue,  2 Sep 2025 06:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756792805;
	bh=b7omN1BWe25O8EiNt+XfatAiHy9vm6h6D0V38Wn/hc0=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=MefpEwNlVyxBkzK5wTHcDkKI+ZoIeiqWxZBLTFSN+4mXmIKZ2BdT+JYiafZL5OGrN
	 gusRVeLnzLcEnPX7OaQyiw7Iic/c0ZaN0/w2PRJmf/57hF4AkNUJbUEff/0hEyczw4
	 cki8mQKLHccEylevFxP2CQj9JaWA6vgS8nQiLy8p1CnaqUbiJvOTdbZ/eyawdoCrs2
	 jIGc95qhh4JpTZDvFFOEkvQsdgSrWR+LW3UDc45XoCB4QZoa7NiZjOmlJWTrCzwX3+
	 X4KfOFnp9Jc0hLTmAUW9FjBDw1xfCuvkjzg8DNHOzFu8tZV7IaY7VpaAzbvF13M7ob
	 JbJBYcXLqEM7w==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AE0CCA1005;
	Tue,  2 Sep 2025 06:00:05 +0000 (UTC)
From: Rohan G Thomas via B4 Relay <devnull+rohan.g.thomas.altera.com@kernel.org>
Date: Tue, 02 Sep 2025 13:59:57 +0800
Subject: [PATCH net-next] net: phy: marvell: Fix 88e1510 downshift counter
 errata
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250902-marvell_fix-v1-1-9fba7a6147dd@altera.com>
X-B4-Tracking: v=1; b=H4sIAN2HtmgC/x2MQQqAIBQFrxJ/nWBKi7pKRIg960NZqIgQ3T1pO
 QMzD0UERqSxeSggc+TLV+jahuxu/AbBa2VSUvVykEqcJmQcx+K4CO2U0WsP6ayhWtwBVf+3iTy
 S8CiJ5vf9AOhgeoRnAAAA
X-Change-ID: 20250902-marvell_fix-3f2a3d5e0fca
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rohan G Thomas <rohan.g.thomas@altera.com>, 
 Matthew Gerlach <matthew.gerlach@altera.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1756792803; l=2646;
 i=rohan.g.thomas@altera.com; s=20250815; h=from:subject:message-id;
 bh=/9cNSJY6gnJZYFo+nEpuOiNNB+K1eP0M3YiSlb3Nkvo=;
 b=JSG/f/wctkfekTnyLxeAFMxREMqyGGGJJr0B2r/e64+6r5sDWh33vmccuzRuN57rKuD/JFdTV
 bnhnwGOb/CBAiQs+7PnrQozE5tPfptL0MXcM5H8ZEnOHZ613RSErQY/
X-Developer-Key: i=rohan.g.thomas@altera.com; a=ed25519;
 pk=5yZXkXswhfUILKAQwoIn7m6uSblwgV5oppxqde4g4TY=
X-Endpoint-Received: by B4 Relay for rohan.g.thomas@altera.com/20250815
 with auth_id=494
X-Original-From: Rohan G Thomas <rohan.g.thomas@altera.com>
Reply-To: rohan.g.thomas@altera.com

From: Rohan G Thomas <rohan.g.thomas@altera.com>

The 88e1510 PHY has an erratum where the phy downshift counter is not
cleared on a link power down/up. This can cause the gigabit link to
intermittently downshift to a lower speed.

Disabling and re-enabling the downshift feature clears the counter,
allowing the PHY to retry gigabit link negotiation up to the programmed
retry count times before downshifting. This behavior has been observed
on copper links.

Signed-off-by: Rohan G Thomas <rohan.g.thomas@altera.com>
Reviewed-by: Matthew Gerlach <matthew.gerlach@altera.com>
---
 drivers/net/phy/marvell.c | 39 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/phy/marvell.c b/drivers/net/phy/marvell.c
index 623292948fa706a2b0d8b98919ead8b609bbd949..4c3d5fbcfda0a960f6c1284f07f16061d9fa0229 100644
--- a/drivers/net/phy/marvell.c
+++ b/drivers/net/phy/marvell.c
@@ -1902,6 +1902,43 @@ static int marvell_resume(struct phy_device *phydev)
 	return err;
 }
 
+/* m88e1510_resume
+ *
+ * The 88e1510 PHY has an erratum where the phy downshift counter is not cleared
+ * during a link power down/up. This can cause the link to intermittently
+ * downshift to a lower speed.
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



