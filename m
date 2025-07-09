Return-Path: <netdev+bounces-205468-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB05AFEDCC
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 17:32:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 710901887C0B
	for <lists+netdev@lfdr.de>; Wed,  9 Jul 2025 15:32:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 313EB2D2389;
	Wed,  9 Jul 2025 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JWDX3g7w"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09330A920;
	Wed,  9 Jul 2025 15:32:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752075156; cv=none; b=N5xkIXF5glryyznv7USvtOg89gapTAS9y/IJX1nQRyWjjyYr4Az1Q22mfaH0G4OuGhso+5oF7XBPd2UXvC8+r/VxPLLQS6ejKbIl7ooxeK1dBPKEPayl0bJSKWWt6bQn82VRI8Kgwqx7QfjkmJwZs6+vUj0UsWjbzH7u5mVf+aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752075156; c=relaxed/simple;
	bh=kcvivhZy27k1X84bIalCvwMRvuKqZj+zcGFUwVqQar0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=E9unOkWBp616jGXX++heVDd2pDnanrqxE0yqtDoHcrwFesJ6jGaDotdU0CIxXRPF9ZoT2iBjYaWuHQvWp6BU/cknc9VbDGzCSupyGOOkHx3zOB6V8kZos/RetResc0dJB6pvSHSVD/YM0+pbGv9cBQNMn9M67Bt3wHxHJt3lFI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JWDX3g7w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5BA1C4CEEF;
	Wed,  9 Jul 2025 15:32:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752075155;
	bh=kcvivhZy27k1X84bIalCvwMRvuKqZj+zcGFUwVqQar0=;
	h=From:To:Cc:Subject:Date:From;
	b=JWDX3g7wylmHQW3/6AqwqbIM8VhJY2PNbjGM6/7xoXS1Z3s9d+8AFAkfuFoAAG5Hr
	 VtylhNHTumNz/L250F07hrTJH4RBYHx7RPt2QiWCcVZbhR3a0G8wO5yQht5PB/08kz
	 5UlRlFlK4eFF/kqE4T1PdlO8oKE5RNBFIMitd5M+x0RcUGloo8mwoYk6eRW2DfNNx2
	 HlReH+SwhlghrP4Eh8DyyFS3EHjyf38+pihtJEMRF71S2zv+G/ZGG+BBux4GEwzWoY
	 1oeYrgY7T+l4NUuHlSBYxtmzVj/5USDLbeiqADXiqJzWg+ET9aH8/wYmXPnJ4JpBfS
	 0cMoAsge8DMHA==
From: Arnd Bergmann <arnd@kernel.org>
To: Oleksij Rempel <o.rempel@pengutronix.de>,
	Kory Maincent <kory.maincent@bootlin.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Colin Ian King <colin.i.king@gmail.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: pse-pd: pd692x0: reduce stack usage in pd692x0_setup_pi_matrix
Date: Wed,  9 Jul 2025 17:32:04 +0200
Message-Id: <20250709153210.1920125-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Arnd Bergmann <arnd@arndb.de>

The pd692x0_manager array in this function is really too big to fit on the
stack, though this never triggered a warning until a recent patch made
it slightly bigger:

drivers/net/pse-pd/pd692x0.c: In function 'pd692x0_setup_pi_matrix':
drivers/net/pse-pd/pd692x0.c:1210:1: error: the frame size of 1584 bytes is larger than 1536 bytes [-Werror=frame-larger-than=]

Change the function to dynamically allocate the array here.

Fixes: 359754013e6a ("net: pse-pd: pd692x0: Add support for PSE PI priority feature")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/net/pse-pd/pd692x0.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/pse-pd/pd692x0.c b/drivers/net/pse-pd/pd692x0.c
index 4de004813560..399ce9febda4 100644
--- a/drivers/net/pse-pd/pd692x0.c
+++ b/drivers/net/pse-pd/pd692x0.c
@@ -860,7 +860,7 @@ pd692x0_of_get_ports_manager(struct pd692x0_priv *priv,
 
 static int
 pd692x0_of_get_managers(struct pd692x0_priv *priv,
-			struct pd692x0_manager manager[PD692X0_MAX_MANAGERS])
+			struct pd692x0_manager *manager)
 {
 	struct device_node *managers_node, *node;
 	int ret, nmanagers, i, j;
@@ -1164,7 +1164,7 @@ pd692x0_write_ports_matrix(struct pd692x0_priv *priv,
 
 static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 {
-	struct pd692x0_manager manager[PD692X0_MAX_MANAGERS] = {0};
+	struct pd692x0_manager *manager __free(kfree) = NULL;
 	struct pd692x0_priv *priv = to_pd692x0_priv(pcdev);
 	struct pd692x0_matrix port_matrix[PD692X0_MAX_PIS];
 	int ret, i, j, nmanagers;
@@ -1174,6 +1174,10 @@ static int pd692x0_setup_pi_matrix(struct pse_controller_dev *pcdev)
 	    priv->fw_state != PD692X0_FW_COMPLETE)
 		return 0;
 
+	manager = kcalloc(PD692X0_MAX_MANAGERS, sizeof(*manager), GFP_KERNEL);
+	if (!manager)
+		return -ENOMEM;
+
 	ret = pd692x0_of_get_managers(priv, manager);
 	if (ret < 0)
 		return ret;
-- 
2.39.5


