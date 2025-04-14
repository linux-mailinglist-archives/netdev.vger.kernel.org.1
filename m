Return-Path: <netdev+bounces-182070-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 03719A87AD8
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 10:46:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 20D861883C7F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 08:46:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33F7226A089;
	Mon, 14 Apr 2025 08:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMaaZInp"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09CF5269D1D;
	Mon, 14 Apr 2025 08:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744620237; cv=none; b=oIkGMggqNIrvDkweZFPh72RuZ1wQ/Jso0ofWP375YV5GAVO4jODxgAcTICo9PCazVYj0D0QDXh1OI/BKSpeo4MJVcF6E3WuywwOjVmQiMentV0dhZxqjuF7O3LzAmKzI+HoJvcWb6xERnd2wf15t+b5ca2ecPDAjJdsC/wMORQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744620237; c=relaxed/simple;
	bh=eUd5GxwszVXXzpuC1+ozLa4oZQpxUDf8OIF6/2qk9Ho=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=CWYPXfubCNqbOaXOYU3I+1fucp2jWJ22hs5CmHn/QbBMm2jui+MHsgonEDakEuJ2u/5zVa3twrkp4mZrfav2YzA2heTKpqSldbKKZe26LvNKz2aqLH4Tg+FXnjimmAF444VTn7WJAcH636w95my/3slWGpWrkIdHj9a60xskKs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMaaZInp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E0BEC4CEEC;
	Mon, 14 Apr 2025 08:43:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744620236;
	bh=eUd5GxwszVXXzpuC1+ozLa4oZQpxUDf8OIF6/2qk9Ho=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMaaZInpYv91Z0K+UTSGxHcfCYpKA001Mh0LT58uFmgEBS7yNsE8y0wmXIakIm8qh
	 A2FpWGTbbqX7VYBXIdHQhK5+ctAt7oVFygD5USlZSXL9RAQQwgp94Nos2jZr5bUfi2
	 Z8Cc1YrDv6oFiHHVQ26a1DvpKVVSwZ2+S+YgOTsppjKiUwVfDKrOC8sTIsmggmRaly
	 Y8Iv9FNtlTuZ+LWOKkRLxApeYCS2pWB/Mond34KJS3Ui+lNjq75E5zjZ4VSB73KjmI
	 o77fpA+FWsNRMtOn3j/44u74tyOWZjzg0uCjCjIPmKA+PMHgh46b04gVjVoZpRNUyF
	 r49Pc8F1Nhi9w==
From: Michael Walle <mwalle@kernel.org>
To: Saravana Kannan <saravanak@google.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Michael Walle <mwalle@kernel.org>
Subject: [PATCH net-next v2 2/2] net: ethernet: ti: am65-cpsw: handle -EPROBE_DEFER
Date: Mon, 14 Apr 2025 10:43:36 +0200
Message-Id: <20250414084336.4017237-3-mwalle@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414084336.4017237-1-mwalle@kernel.org>
References: <20250414084336.4017237-1-mwalle@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

of_get_mac_address() might fetch the MAC address from NVMEM and that
driver might not have been loaded. In that case, -EPROBE_DEFER is
returned. Right now, this will trigger an immediate fallback to
am65_cpsw_am654_get_efuse_macid() possibly resulting in a random MAC
address although the MAC address is stored in the referenced NVMEM.

Fix it by handling the -EPROBE_DEFER return code correctly. This also
means that the creation of the MDIO device has to be moved to a later
stage as -EPROBE_DEFER must not be returned after child devices are
created.

Signed-off-by: Michael Walle <mwalle@kernel.org>
---

v2:
 - none

 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 55a0c37da54c..988ce9119306 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2679,7 +2679,9 @@ static int am65_cpsw_nuss_init_slave_ports(struct am65_cpsw_common *common)
 			goto of_node_put;
 
 		ret = of_get_mac_address(port_np, port->slave.mac_addr);
-		if (ret) {
+		if (ret == -EPROBE_DEFER) {
+			goto of_node_put;
+		} else if (ret) {
 			am65_cpsw_am654_get_efuse_macid(port_np,
 							port->port_id,
 							port->slave.mac_addr);
@@ -3561,6 +3563,16 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	am65_cpsw_nuss_get_ver(common);
+
+	ret = am65_cpsw_nuss_init_host_p(common);
+	if (ret)
+		goto err_pm_clear;
+
+	ret = am65_cpsw_nuss_init_slave_ports(common);
+	if (ret)
+		goto err_pm_clear;
+
 	node = of_get_child_by_name(dev->of_node, "mdio");
 	if (!node) {
 		dev_warn(dev, "MDIO node not found\n");
@@ -3577,16 +3589,6 @@ static int am65_cpsw_nuss_probe(struct platform_device *pdev)
 	}
 	of_node_put(node);
 
-	am65_cpsw_nuss_get_ver(common);
-
-	ret = am65_cpsw_nuss_init_host_p(common);
-	if (ret)
-		goto err_of_clear;
-
-	ret = am65_cpsw_nuss_init_slave_ports(common);
-	if (ret)
-		goto err_of_clear;
-
 	/* init common data */
 	ale_params.dev = dev;
 	ale_params.ale_ageout = AM65_CPSW_ALE_AGEOUT_DEFAULT;
-- 
2.39.5


