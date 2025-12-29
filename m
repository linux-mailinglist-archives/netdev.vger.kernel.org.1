Return-Path: <netdev+bounces-246278-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 18782CE808E
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 20:19:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DD6A3038F65
	for <lists+netdev@lfdr.de>; Mon, 29 Dec 2025 19:17:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EB8E2BE7D1;
	Mon, 29 Dec 2025 19:17:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CkLAQgp8"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 411922BE622;
	Mon, 29 Dec 2025 19:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767035872; cv=none; b=brxGvuTfBsbX5mKOPFUmjyP+z0uVAeU8Sob191narQObUI4yOnit49rKDDb8vYSmSmKPBsxO70tYJllmf8LGryTv++JMiRL0a4J5FiXXPj6C/amnPiSm1FBbI1b5JqhAUoz9Iop/GYVuUXqLeYFH15761p5kXcg8HmhKDOr6U/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767035872; c=relaxed/simple;
	bh=P4TDnNk14F9PHiB/aO/B1Q6sB0FOFxIs5TdMoRAoLHs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jvLBUD9S+GTBYfWghuDdUuGPRB6bCu4IRykIJjBYeBCKDke7KTdN4opm73nHvZI8R62HLkk0SO5N+BjQ7gyxRPi0HlCaNQssDwvuZf8ThXLS3hraowkDg3sQBNwxpyogf3GgknktNI+snXO2uJQ4R7kdLDL6EzQtsiEjiW+SSVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CkLAQgp8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 63C83C19423;
	Mon, 29 Dec 2025 19:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767035871;
	bh=P4TDnNk14F9PHiB/aO/B1Q6sB0FOFxIs5TdMoRAoLHs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=CkLAQgp8JVSDw+levfEh/+99v/n5tBInf8dxR1N1QqBnNaydcPDsXEJBfHxcYBqb/
	 Gea9WKt0+bKw4JLmSUIw7VgvGawkg5SkpgBIr1xR+FZn2zKdz9Bq2Obq5ZAfk02pac
	 Qau/Kfzr65vdkKVjkz+M3tu35gaTAY9nMH9g7klWinh9P1fzyAOj40KaTiB7QT5wTM
	 o3B8xjcKNL2BUXzLMiR/+mgrTvqJ8+Ysccntso6IzbwLKuZv8rz9gAPxyJtu/mHPGT
	 2cpPDUl5p0xEpmcA3lF3qjninqMZ6j+tPoGaj2yE/0I26X8jgE72KDTawCj1qNEMAP
	 7dIb08vj/JXtA==
From: Dinh Nguyen <dinguyen@kernel.org>
Date: Mon, 29 Dec 2025 13:17:18 -0600
Subject: [PATCH 1/2] net: stmmac: socfpga: add call to assert/deassert ahb
 reset line
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251229-remove_ocp-v1-1-594294e04bd4@kernel.org>
References: <20251229-remove_ocp-v1-0-594294e04bd4@kernel.org>
In-Reply-To: <20251229-remove_ocp-v1-0-594294e04bd4@kernel.org>
To: Maxime Chevallier <maxime.chevallier@bootlin.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, 
 Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, 
 Mamta Shukla <mamta.shukla@leica-geosystems.com>, 
 Ahmad Fatoum <a.fatoum@pengutronix.de>
Cc: bsp-development.geo@leica-geosystems.com, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Dinh Nguyen <dinguyen@kernel.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2818; i=dinguyen@kernel.org;
 h=from:subject:message-id; bh=P4TDnNk14F9PHiB/aO/B1Q6sB0FOFxIs5TdMoRAoLHs=;
 b=owEBbQKS/ZANAwAKARmUBAuBoyj0AcsmYgBpUtPbqXk/Yw9UdSOyLmXm8ZWv+eUnK6pQDTyNC
 YUmv9imar+JAjMEAAEKAB0WIQSgeEx6LKTlWbBUzA0ZlAQLgaMo9AUCaVLT2wAKCRAZlAQLgaMo
 9KK8D/4hqNU4cTNOQyotM99zfD/zz6svCjL5f6T681rTo5pnz3KekYAqQ03O4Gqku+Nm1bm22S+
 U3IeyArqIgmpIX78aVOAoX9Bju4JDAoqYjDraM+TGOl+6SOK6GcJK3hvo61kqO1RIPaNjcYr4WU
 6B4LgkKsnv6uUTDkUopFo5O0NTyEFU+V7Gy5/Ip8rEj+PjD4EK4GCIyBz9GiHJr60smcjgxwIoD
 nChCAWPNLC8RFPDRIEBx7dC6soR2P8CcQ0VRQIO/EcbIfXXSAn0VIOSyPRQZB0xxktqJmrwJqW3
 UT10/+2qabmUdFwtkfWfNXyB3tAfevCTReMxe2Y5u1BrAWBMVEQ4ookLfZAaWV0X5HgNHxq5B3B
 ixORAJvYFo37xOMeD1LPe6RQHWAcmddoL+K8ATLyNswy3a/YqTIupgbQPjjM44SjSbQJOde1dqq
 dVYF/k822pbL508qO49HzfcSjRwky7MIJIRoVVRroWXF1RJ8BpbpJ1ZUvdJStsNltCPi/Rne8N/
 BfVDuJ8LVIp9Un2s2IcIGTEzYnCNh/i8aqnibK5PTtENys6Qsx+Mkd1krDdfvUFuGlnpHBwX6gs
 AwqCF5cUDhsUZanfiaYa2dxS66CW2bDNVqTFnWq2VNNiJms5TSfw7DipX+lmLoZccBecNogITvu
 K/QLZmcl69LU0Gw==
X-Developer-Key: i=dinguyen@kernel.org; a=openpgp;
 fpr=A0784C7A2CA4E559B054CC0D1994040B81A328F4

The "stmmaceth-ocp" reset line of stmmac controller on the SoCFPGA
platform is essentially the "ahb" reset on the standard stmmac
controller. But since stmmaceth-ocp has already been introduced into
the wild, we cannot just remove support for it. But what we can do is
to support both "stmmaceth-ocp" and "ahb" reset names. Going forward we
will be using "ahb", but in order to not break ABI, we will be call reset
assert/de-assert both ahb and stmmaceth-ocp.

The ethernet hardware on SoCFPGA requires either the stmmaceth-ocp or
ahb reset to be asserted every time before changing the phy mode, then
de-asserted when the phy mode has been set.

With this change, we should be able to revert patch:
commit 62a40a0d5634 ("arm: dts: socfpga: use reset-name "stmmaceth-ocp"
instead of "ahb"")

Signed-off-by: Dinh Nguyen <dinguyen@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
index a2b52d2c4eb6..79df55515c71 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-socfpga.c
@@ -407,6 +407,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 
 	/* Assert reset to the enet controller before changing the phy mode */
 	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
@@ -436,6 +437,7 @@ static int socfpga_gen5_set_phy_mode(struct socfpga_dwmac *dwmac)
 	 * the enet controller, and operation to start in requested mode
 	 */
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII)
 		socfpga_sgmii_config(dwmac, true);
@@ -463,6 +465,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 
 	/* Assert reset to the enet controller before changing the phy mode */
 	reset_control_assert(dwmac->stmmac_ocp_rst);
+	reset_control_assert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_assert(dwmac->stmmac_rst);
 
 	regmap_read(sys_mgr_base_addr, reg_offset, &ctrl);
@@ -489,6 +492,7 @@ static int socfpga_gen10_set_phy_mode(struct socfpga_dwmac *dwmac)
 	 * the enet controller, and operation to start in requested mode
 	 */
 	reset_control_deassert(dwmac->stmmac_ocp_rst);
+	reset_control_deassert(dwmac->plat_dat->stmmac_ahb_rst);
 	reset_control_deassert(dwmac->stmmac_rst);
 	if (phymode == PHY_INTERFACE_MODE_SGMII)
 		socfpga_sgmii_config(dwmac, true);

-- 
2.42.0.411.g813d9a9188


