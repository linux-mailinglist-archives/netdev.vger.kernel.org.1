Return-Path: <netdev+bounces-200687-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A76EAE68A6
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 585DD5A62A4
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:23:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3686F2D23AD;
	Tue, 24 Jun 2025 14:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ODbWwKuU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8082D1925;
	Tue, 24 Jun 2025 14:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774667; cv=none; b=Jpp9Pew265XBT9Z9gVNlbTiVdBIu10wd/FnGfsodwIS+JJhVdtypKvuEtvWSa2xPWDbKEILPm+vefuiIdxYAMfRBCLVZjO1eSj6uHPWM91EPv8a8Ie+tAyw7KE3epCIDFYBCwPOCeAkJ5+e14P7saJlD/4am3i1K8W2i1JaMvT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774667; c=relaxed/simple;
	bh=iPXrS0IxOWIB10FUvXWR3mcxb3hxp86Xzx4nj+som+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=lg3MI/swQUXKTZVVZu2GLNkoW5qQicwB2rXIEQWnba31/4Yv41oHnoc+eCkDXCe/dIhgKubzbCRxPb7pk0BkOcXTKEsIB5k5aHnnjhyH3JNfdior7KEM7CKrqB7ZJe/+GfeGja5n4eSQLoJMsgXxJwUKMxMXtIckJ6Vd4YhrhFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ODbWwKuU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 75116C4CEE3;
	Tue, 24 Jun 2025 14:17:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750774666;
	bh=iPXrS0IxOWIB10FUvXWR3mcxb3hxp86Xzx4nj+som+g=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ODbWwKuUGhsXKUHDJ5o8DqmBSYfSwD3FH71Qtm5vzP0hchj3mU5VTlieGMnWf8M+7
	 RM5mTCSAYHngTyUc24iDUesqGKzTBglp4nyw2KTmKkYIczor56fIO5ZiaECpfuvEv6
	 32SlJUaY0XQ+H+egJ2TEUYN/gfZ2HNWFy584syv3QV7vqxpDcMug8rD/x7odtM/cts
	 ScpwVEa/tlhx60UbQfSbPMs8255Xp0cZxrUPwkIY+ThqMemzxWnYg+hDG2Z/+CQevX
	 c8yPCm3ofNF23gJf8PsIoV32QnYXw/0YpZbhH5oAlRilX5FETsqg5P8lrg026yaZqf
	 IMN0KAL2HhXGQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 632BDC77B7F;
	Tue, 24 Jun 2025 14:17:46 +0000 (UTC)
From: Daniel Braunwarth via B4 Relay <devnull+daniel.braunwarth.kuka.com@kernel.org>
Date: Tue, 24 Jun 2025 16:17:33 +0200
Subject: [PATCH net-next] net: phy: realtek: add error handling to
 rtl8211f_get_wol
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250624-realtek_fixes-v1-1-02a0b7c369bc@kuka.com>
X-B4-Tracking: v=1; b=H4sIAHyzWmgC/x3L4QpAMBSG4VvR+W3FCeFWJK35xolG25KSe7f8f
 Hp7HwrwgkB99pDHJUEOl1DmGZlVuwVK5mTiguui4Up56D1im6zcCKqtLXdsrCl1Rek5Pf6QloE
 conK4I43v+wGPmEg6aQAAAA==
X-Change-ID: 20250624-realtek_fixes-85f292cfc1a4
To: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>, 
 Russell King <linux@armlinux.org.uk>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jon Hunter <jonathanh@nvidia.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Daniel Braunwarth <daniel.braunwarth@kuka.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1750774665; l=1492;
 i=daniel.braunwarth@kuka.com; s=20250425; h=from:subject:message-id;
 bh=OKIaJlj0nrfTAYstQqag45KapLdQ8tvdEWLzdWiNk5s=;
 b=7mNj/l+AW+0zCELuRDjTpfWfouZu6Wbewt+QQyclvcPC1asqXnBlDWqj8uWlZ3xrwwHxkyl6X
 715ddpihqjzCJzZ2pU7DE+OnVKEePScwM2ToCPlTdccU66o9FwZwQOW
X-Developer-Key: i=daniel.braunwarth@kuka.com; a=ed25519;
 pk=fTSYKvKU5SCGGLHVz5NaznQ2MbXNWUZzdqPihgCfYms=
X-Endpoint-Received: by B4 Relay for daniel.braunwarth@kuka.com/20250425
 with auth_id=388
X-Original-From: Daniel Braunwarth <daniel.braunwarth@kuka.com>
Reply-To: daniel.braunwarth@kuka.com

From: Daniel Braunwarth <daniel.braunwarth@kuka.com>

We should check if the WOL settings was successfully read from the PHY.

In case this fails we cannot just use the error code and proceed.

Signed-off-by: Daniel Braunwarth <daniel.braunwarth@kuka.com>
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Closes: https://lore.kernel.org/baaa083b-9a69-460f-ab35-2a7cb3246ffd@nvidia.com
---
 drivers/net/phy/realtek/realtek_main.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/net/phy/realtek/realtek_main.c b/drivers/net/phy/realtek/realtek_main.c
index c3dcb62574303374666b46a454cd4e10de455d24..dd0d675149ad7f9730f04ba1aea82e02b15dfb2c 100644
--- a/drivers/net/phy/realtek/realtek_main.c
+++ b/drivers/net/phy/realtek/realtek_main.c
@@ -436,9 +436,15 @@ static irqreturn_t rtl8211f_handle_interrupt(struct phy_device *phydev)
 
 static void rtl8211f_get_wol(struct phy_device *dev, struct ethtool_wolinfo *wol)
 {
+	int wol_events;
+
 	wol->supported = WAKE_MAGIC;
-	if (phy_read_paged(dev, RTL8211F_WOL_SETTINGS_PAGE, RTL8211F_WOL_SETTINGS_EVENTS)
-	    & RTL8211F_WOL_EVENT_MAGIC)
+
+	wol_events = phy_read_paged(dev, RTL8211F_WOL_SETTINGS_PAGE, RTL8211F_WOL_SETTINGS_EVENTS);
+	if (wol_events < 0)
+		return;
+
+	if (wol_events & RTL8211F_WOL_EVENT_MAGIC)
 		wol->wolopts = WAKE_MAGIC;
 }
 

---
base-commit: f817b6dd2b62d921a6cdc0a3ac599cd1851f343c
change-id: 20250624-realtek_fixes-85f292cfc1a4

Best regards,
-- 
Daniel Braunwarth <daniel.braunwarth@kuka.com>



