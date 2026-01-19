Return-Path: <netdev+bounces-251164-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4508FD3AF1A
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 16:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2D0B6301E690
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 15:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BDCE35C18A;
	Mon, 19 Jan 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PkBDwgdv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 587E1275AE3;
	Mon, 19 Jan 2026 15:33:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768836790; cv=none; b=RxzaIvOJ+Zaou/VRgASkfQBl7DHmQnKfQJatxcYd+nmdNqfBTmy+6sba3Ti82uATrMIwejUep+HdEW97lm3kLa4q1puhzIJBLkXbgG9JEcNyUalyO2uYkK487ebVk/dibCzdGMNMZj9SZPZI8z3/L5wgiMHwPdnUG3x4o0sOQ9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768836790; c=relaxed/simple;
	bh=g4EMvivv1KvxIoB75VdK85k1/A241u1GrwJWdxivwio=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OARwoqlvjV+jU8hAnhaX/oM4NktKGXlgLrF+GQD8tZPWtqp587Ri4JmzU1IoSaffVQCJD7UmdgtVx6n4jb4DFUwI4N7x/gnCaboHLfTk3R+tp1EPAznl9agchMmWZxlpRfVy8JdPXgi2PRfFr9KEujmzSogsNYW9VSUsIw0zCIM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PkBDwgdv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A73F6C116C6;
	Mon, 19 Jan 2026 15:33:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768836790;
	bh=g4EMvivv1KvxIoB75VdK85k1/A241u1GrwJWdxivwio=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PkBDwgdv9OERseTv1EYRgeE2MbMydxZQgg7xGqK4FmbBRI3iVPeQXP5jgZt5693UW
	 BKZOdNtfxs5K/k/rDSUpDMhxmfdlITbCDRulDATWEOTulisaNVgRpOhnBF88C9S0GP
	 S+RZD2MYhMQlgNLEdDooww8IvivnW+Ff6UD3ADk35+mGhCTgv3/wjKR+Jsat6TIefy
	 0U6lEhH+V4gH2ODPVXIDnh+bMaXNykrQUPV4edwtgMuq9VSwH9KAuuPtzszmspHA5t
	 c4qJV+Gc3wjCWSgvYqMDhr0PfrJdcV70geOOKTvciwWGpO4uzmjAjOssqLvPE6WrhQ
	 gzfisnPOMuMaQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 19 Jan 2026 16:32:41 +0100
Subject: [PATCH net-next v3 2/2] net: airoha: npu: Add the capability to
 read firmware names from dts
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260119-airoha-npu-firmware-name-v3-2-cba88eed96cc@kernel.org>
References: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
In-Reply-To: <20260119-airoha-npu-firmware-name-v3-0-cba88eed96cc@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: netdev@vger.kernel.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
X-Mailer: b4 0.14.2

Introduce the capability to read the firmware binary names from device-tree
using the firmware-name property if available.
This patch is needed because NPU firmware binaries are board specific since
they depend on the MediaTek WiFi chip used on the board (e.g. MT7996 or
MT7992) and the WiFi chip version info is not available in the NPU driver.
This is a preliminary patch to enable MT76 NPU offloading if the Airoha SoC
is equipped with MT7996 (Eagle) WiFi chipset.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 42 +++++++++++++++++++++++++++-----
 1 file changed, 36 insertions(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index a56b3780bb627cc393b94210b6b5c72cc95baea3..d684e5cc8af2fbde3e274c6fa22c4336474092b5 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -195,18 +195,18 @@ static int airoha_npu_send_msg(struct airoha_npu *npu, int func_id,
 }
 
 static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
-				    const struct airoha_npu_fw *fw_info)
+				    const char *fw_name, int fw_max_size)
 {
 	const struct firmware *fw;
 	int ret;
 
-	ret = request_firmware(&fw, fw_info->name, dev);
+	ret = request_firmware(&fw, fw_name, dev);
 	if (ret)
 		return ret == -ENOENT ? -EPROBE_DEFER : ret;
 
-	if (fw->size > fw_info->max_size) {
+	if (fw->size > fw_max_size) {
 		dev_err(dev, "%s: fw size too overlimit (%zu)\n",
-			fw_info->name, fw->size);
+			fw_name, fw->size);
 		ret = -E2BIG;
 		goto out;
 	}
@@ -218,6 +218,28 @@ static int airoha_npu_load_firmware(struct device *dev, void __iomem *addr,
 	return ret;
 }
 
+static int
+airoha_npu_load_firmware_from_dts(struct device *dev, void __iomem *addr,
+				  void __iomem *base)
+{
+	const char *fw_names[2];
+	int ret;
+
+	ret = of_property_read_string_array(dev->of_node, "firmware-name",
+					    fw_names, ARRAY_SIZE(fw_names));
+	if (ret != ARRAY_SIZE(fw_names))
+		return -EINVAL;
+
+	ret = airoha_npu_load_firmware(dev, addr, fw_names[0],
+				       NPU_EN7581_FIRMWARE_RV32_MAX_SIZE);
+	if (ret)
+		return ret;
+
+	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
+					fw_names[1],
+					NPU_EN7581_FIRMWARE_DATA_MAX_SIZE);
+}
+
 static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 				   struct resource *res)
 {
@@ -233,14 +255,22 @@ static int airoha_npu_run_firmware(struct device *dev, void __iomem *base,
 	if (IS_ERR(addr))
 		return PTR_ERR(addr);
 
+	/* Try to load firmware images using the firmware names provided via
+	 * dts if available.
+	 */
+	if (of_find_property(dev->of_node, "firmware-name", NULL))
+		return airoha_npu_load_firmware_from_dts(dev, addr, base);
+
 	/* Load rv32 npu firmware */
-	ret = airoha_npu_load_firmware(dev, addr, &soc->fw_rv32);
+	ret = airoha_npu_load_firmware(dev, addr, soc->fw_rv32.name,
+				       soc->fw_rv32.max_size);
 	if (ret)
 		return ret;
 
 	/* Load data npu firmware */
 	return airoha_npu_load_firmware(dev, base + REG_NPU_LOCAL_SRAM,
-					&soc->fw_data);
+					soc->fw_data.name,
+					soc->fw_data.max_size);
 }
 
 static irqreturn_t airoha_npu_mbox_handler(int irq, void *npu_instance)

-- 
2.52.0


