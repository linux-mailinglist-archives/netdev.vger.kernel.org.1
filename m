Return-Path: <netdev+bounces-223301-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D0D5B58B28
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 03:28:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A95C91B201E7
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 01:29:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C7B11FA178;
	Tue, 16 Sep 2025 01:28:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b="J98MyLcb"
X-Original-To: netdev@vger.kernel.org
Received: from smtpbgau1.qq.com (smtpbgau1.qq.com [54.206.16.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7484F13B293;
	Tue, 16 Sep 2025 01:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.16.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757986130; cv=none; b=LYBEQSXtIKsVCYfiUlMfaVxcL582Z04DXlBnJCVinp87EdKds0sCGaiEKgX+mSnbiTXD5GFD548cUqaJJKk0+Sh4LXWMokBEMWUW/i3CdztDwlwKpQQvHSjUfAYIfMSVP04go/RVd72C+ZkJmz9bT5UyIeGS3Nwmu0Zz6Lh6C/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757986130; c=relaxed/simple;
	bh=dOrtMow+yygUOhhXu/PCIEqWa9NtW5uvhs7mmCFFDXg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FYjhOyknzXgA7+kT2MIZ/CkLHIpEpX5xkFAtl1EAU6ndBVlujaBqjZ9ZE9fwrWoSIGlbOxdb2VzqMCT0ZzUd+e+aHiEDnusEkNECG8nSkFfpVAM35kyZdjPJZc1sjHSmnFtX6j6YuHWKllCzkGw98IvCOl7jmRaEmJfZEe8Vtr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com; spf=pass smtp.mailfrom=airkyi.com; dkim=pass (1024-bit key) header.d=airkyi.com header.i=@airkyi.com header.b=J98MyLcb; arc=none smtp.client-ip=54.206.16.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=airkyi.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=airkyi.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=airkyi.com;
	s=altu2504; t=1757986002;
	bh=r40/9/byFQ5Kdho5bSZgFzvBLnr6GNZb9hi7qVjYjLk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=J98MyLcbMRG94NEiVPEjeSXACyzHlGMhioQe+AoZz+U5Pl5VQ3tvrizeCPZchXSH0
	 d2rMdEy5H/PcgpFTo13OzEfrZ4GonSnL1tUb0wvZGI64BXUf/kaItCe4zy6dRa1XJM
	 oVipO6zCRqLqhivuCR8IJ8o6LMSpaqpg8K/p6Q98=
X-QQ-mid: esmtpgz16t1757985994tb691f01f
X-QQ-Originating-IP: 9WqvNV5m81o9OAQGGCKKLjLtxMwpN1LWrrj43UnBIq8=
Received: from DESKTOP-8BT1A2O.localdomain ( [58.22.7.114])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 16 Sep 2025 09:26:31 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13026834714890684059
From: Chaoyi Chen <kernel@airkyi.com>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Jonas Karlman <jonas@kwiboo.se>,
	David Wu <david.wu@rock-chips.com>
Cc: sebastian.reichel@collabora.com,
	ziyao@disroot.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-rockchip@lists.infradead.org,
	Chaoyi Chen <chaoyi.chen@rock-chips.com>
Subject: [PATCH net-next] Revert "net: ethernet: stmmac: dwmac-rk: Make the clk_phy could be used for external phy"
Date: Tue, 16 Sep 2025 09:26:28 +0800
Message-ID: <0A3F1D1604FEE424+20250916012628.1819-1-kernel@airkyi.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:airkyi.com:qybglogicsvrsz:qybglogicsvrsz4a-0
X-QQ-XMAILINFO: NpSUeF22LnzDaMKYiEuFqevqeK1MYzf4iSkkCu3fQqOjrNgyfGsywGra
	GMwsWfxhO5M0UlGrG374jH3Xa17Hadfevx69JtfBFyquyr68EHvK2gqjtNyOyGoN5N/9Ypm
	kv2vOCH1CMFRpEpIgjYRQ4sSB5udtTSTunJKOV7T8qxujPtCch7tkg2wkeh3aY97izqA7zs
	fNXf6auP3iTDII0WIJKE9Vltww++i4bLigltiLAncAP7lsgqPay9ChFGa2sxFMpXFSxkRUY
	IwLGia11ARql5Ns2AvaY2uG+nPJpXN/KnzHaVl2+I5OI0r6qtg7kXLjJN1i0dPSHDedKhUd
	T+PdR1TWVAMpVmesdSinSeyyZDWVmffXSDAgV88zwpKYQ8Gq6yuQr+VyVwoSM8+h96Tm+z+
	2KutP7P6l+B5dU/6fULMPT4BnM+MQr7iNsYP19RJm79bjmiepNqfxbjs6b21AsjrcnsLrnJ
	EAKuVCXTj5X7ze5uXsIQBXeYa2SDOSrXiUEFiE50dqj5xOV9znX4FbpLeCNQXvnFBkRelAB
	FsVObfsXPkF0WkkL+619MIYdebgIOFIBx3c2t5Xe2VjtDokOc4Xitf2eprN8YvgcVULfnLa
	OlnhGfIoX2E9URDE+Lrbj7S/f8plgVl/ok2vV/W0LOcD3WCS3S3ez6xM0rfr2A/QCpPuBex
	8XGoTFjaDSUilnJkOizFTOeG2SavuAvNPlzPjAB0DYksyIVmUE9Om69N8nL9S0zyVez7No1
	XQU4G9/uczKgpSlwBVZqiM2LIaucy41R4WKSeefH/4j+mu1JCf+n2horpNVZCsaNmG3QQWC
	zo5Bu9MIFGZxBHe3foojnFqdZ02SDzWGyEdxAcdwwNmhG6SfD5zwaND74VHf5UzjvZpFty+
	AhYAiM9/If3Q55L+HCWcd5BbrrCEb9ZMzW8zlvJ0wcflYp8sT3LiBQwYwAx4fDtI4IdkAys
	xRiJLq952WEZ+uDHpDt5/KlbJma6R/bcVeWasD1XDg7yJeg==
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
X-QQ-RECHKSPAM: 0

From: Chaoyi Chen <chaoyi.chen@rock-chips.com>

This reverts commit da114122b83149d1f1db0586b1d67947b651aa20.

As discussed, the PHY clock should be managed by PHY driver instead
of other driver like dwmac-rk.

Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 266c53379236..49f92cd79aa8 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1410,15 +1410,12 @@ static int rk_gmac_clk_init(struct plat_stmmacenet_data *plat)
 		clk_set_rate(plat->stmmac_clk, 50000000);
 	}
 
-	if (plat->phy_node) {
+	if (plat->phy_node && bsp_priv->integrated_phy) {
 		bsp_priv->clk_phy = of_clk_get(plat->phy_node, 0);
 		ret = PTR_ERR_OR_ZERO(bsp_priv->clk_phy);
-		/* If it is not integrated_phy, clk_phy is optional */
-		if (bsp_priv->integrated_phy) {
-			if (ret)
-				return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
-			clk_set_rate(bsp_priv->clk_phy, 50000000);
-		}
+		if (ret)
+			return dev_err_probe(dev, ret, "Cannot get PHY clock\n");
+		clk_set_rate(bsp_priv->clk_phy, 50000000);
 	}
 
 	return 0;
-- 
2.49.0


