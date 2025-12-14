Return-Path: <netdev+bounces-244616-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5400BCBB8EF
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 10:30:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A1AB33006706
	for <lists+netdev@lfdr.de>; Sun, 14 Dec 2025 09:30:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C008156237;
	Sun, 14 Dec 2025 09:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AWeuqQUG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB94B9463
	for <netdev@vger.kernel.org>; Sun, 14 Dec 2025 09:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765704623; cv=none; b=aLztJ1LAWoDlq+zVRstZ2lpwwacw5RyMD8VIINHNK7bShHpXvZdFzXukmb1kFAue2aXLU6CODnQzCaKpep88zhMO0l974jjnGuHNsCqsz9Did8BzWCYHqVy77DzH1xa0ILGYXW2DyRG8T9eCFQgd08XqiXEN9HvOBMjErXIoDpo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765704623; c=relaxed/simple;
	bh=0n3uJxHqX735kn4eG0/+bhoqe1AcToHA7kHImCjcZBc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=RSvp7oVeLwz6f5QRzK6XWoZL32/QELC+IBEyIDcgxh1yrWh+di8SN/4JEnkSD9zoTw5PdQcLe9sCpfI7xcKqjOVzIEXMugqUewGeIycAOmQJ3Ucd/FRUNN3o+UdT6oHlKMHKU7zQNsFUNcphk9Q1aHXJsiSG6fV5s2aElaIZwaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AWeuqQUG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF490C4CEF1;
	Sun, 14 Dec 2025 09:30:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1765704623;
	bh=0n3uJxHqX735kn4eG0/+bhoqe1AcToHA7kHImCjcZBc=;
	h=From:Date:Subject:To:Cc:From;
	b=AWeuqQUGrdXf1eD20KsNuPVWAk1M+Uz4UJ3bcZIkZC2hMm0sXHEXtWUSpQYiDN+LW
	 0UPiBQKHzRk57pddyvYX49WFKWAbO4r+cVh3uU1OMVL4FbNNKy6ASa19pje5JT1tFT
	 71I6xHiTV0z6shx7HOA2hlr7O42h6gDEkBQLHeXBBIwiFKpG4YhdIemc7XSW8ExqDZ
	 lRW83blw5c7k9WoH9WZWAYRQ1Lx+8W47b/YS6pdq+4izV80/vEUlLcaPGzr1pR8cjX
	 Z/8RNT2+pyopdWpB8micIV6ov/mPZlwphR+hxLk5R+TgZ47XGjChGYuFmzsdIr0ghj
	 wsocXbACFp7oQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Sun, 14 Dec 2025 10:30:07 +0100
Subject: [PATCH net] net: airoha: Move net_devs registration in a dedicated
 routine
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251214-airoha-fix-dev-registration-v1-1-860e027ad4c6@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/x2M0QpAQBAAf0X7bMueI/kVedjcYl/QnqTk320ep
 2bmgSymkqEvHjC5NOu+OVBZwLTytghqcoZQhYYCRWS1fWWc9cYkF5osmk/j0zucaiaKqekiteC
 Hw8S9/z6M7/sBdsmVxW0AAAA=
X-Change-ID: 20251214-airoha-fix-dev-registration-c3a114d58416
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Since airoha_probe() is not executed under rtnl lock, there is small race
where a given device is configured by user-space while the remaining ones
are not completely loaded from the dts yet. This condition will allow a
hw device misconfiguration since there are some conditions (e.g. GDM2 check
in airoha_dev_init()) that require all device are properly loaded from the
device tree. Fix the issue moving net_devices registration at the end of
the airoha_probe routine.

Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_eth.c | 39 +++++++++++++++++++++-----------
 1 file changed, 26 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 75893c90a0a17c528c27fc0e986de194e7736637..315d97036ac1d611cc786020cbf2c6df810995a9 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -2924,19 +2924,26 @@ static int airoha_alloc_gdm_port(struct airoha_eth *eth,
 	port->id = id;
 	eth->ports[p] = port;
 
-	err = airoha_metadata_dst_alloc(port);
-	if (err)
-		return err;
+	return airoha_metadata_dst_alloc(port);
+}
 
-	err = register_netdev(dev);
-	if (err)
-		goto free_metadata_dst;
+static int airoha_register_gdm_devices(struct airoha_eth *eth)
+{
+	int i;
 
-	return 0;
+	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
+		struct airoha_gdm_port *port = eth->ports[i];
+		int err;
 
-free_metadata_dst:
-	airoha_metadata_dst_free(port);
-	return err;
+		if (!port)
+			continue;
+
+		err = register_netdev(port->dev);
+		if (err)
+			return err;
+	}
+
+	return 0;
 }
 
 static int airoha_probe(struct platform_device *pdev)
@@ -3027,6 +3034,10 @@ static int airoha_probe(struct platform_device *pdev)
 		}
 	}
 
+	err = airoha_register_gdm_devices(eth);
+	if (err)
+		goto error_napi_stop;
+
 	return 0;
 
 error_napi_stop:
@@ -3040,10 +3051,12 @@ static int airoha_probe(struct platform_device *pdev)
 	for (i = 0; i < ARRAY_SIZE(eth->ports); i++) {
 		struct airoha_gdm_port *port = eth->ports[i];
 
-		if (port && port->dev->reg_state == NETREG_REGISTERED) {
+		if (!port)
+			continue;
+
+		if (port->dev->reg_state == NETREG_REGISTERED)
 			unregister_netdev(port->dev);
-			airoha_metadata_dst_free(port);
-		}
+		airoha_metadata_dst_free(port);
 	}
 	free_netdev(eth->napi_dev);
 	platform_set_drvdata(pdev, NULL);

---
base-commit: 8f7aa3d3c7323f4ca2768a9e74ebbe359c4f8f88
change-id: 20251214-airoha-fix-dev-registration-c3a114d58416

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


