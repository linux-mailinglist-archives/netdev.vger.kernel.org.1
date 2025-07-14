Return-Path: <netdev+bounces-206741-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 51B97B04411
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 17:35:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C8FAF189129A
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 15:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7AA026CE14;
	Mon, 14 Jul 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="g01BXMwr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE49A26CE08;
	Mon, 14 Jul 2025 15:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752506753; cv=none; b=OBLMGQFr56HgodKR14j56v7fsYsQl2S8W+4ntS53h7FTmX7XBjTMq7fcrt+T9PoCGNxXzFZiiGe4WxkMQd5PSRjTFoCDi3plR3+8fyx+C9CAVDmBAlD6+3mf9DKg43DyZy4cXMGe+Sl1/HSang1mvdn6hsmD/byQTKioX+l7oII=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752506753; c=relaxed/simple;
	bh=bbMe/p4KUpOOmlbJ3xxcrOUiZhOzHwySeN2cBLuyzhA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=lau8aAr2TcFUEQFH/jtpNxfHJlQ/n5O4pSX1udPodyS9WZ5v9nR+ru/nyCTo2PLMSV4L6WlyTLcpULV5D5U6IxSBhLDAsCLnIvadbfFgYtNXuX8VF3FAOghGaPvP3BqQY69+ZOYfEQGEBDwNmj9X1kj/aG7D4WBvDS6mbFKj24M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=g01BXMwr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4513C4CEF0;
	Mon, 14 Jul 2025 15:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752506753;
	bh=bbMe/p4KUpOOmlbJ3xxcrOUiZhOzHwySeN2cBLuyzhA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=g01BXMwrgQd6mwhI73riHLWSc+SE96+kW2siwLWnsVQPymldCYCyWecINtcyQbI4L
	 Vl+k+cMMDb6tO1AOO0BhTh0XoNeULmgo2mcGnUVn/GMjykkw+HT7N5XWHdQBBoKtTY
	 T49m3w9MwixbdIr0dQ63QjRWr8VK2UyrxytSSjyodYTUm/27rkdYkpEcjBrW3sreg2
	 HeCrBZo1YWfh9d0X7Ri4fbEm8WANxSpyYm/YFc1HFdrRh4Ah5ueeHFTMmX+a+XPQEM
	 cZWDoN0TzyxxBJniZYkFf30bQzbmvoeRRLa+jHKRMZ/NRBQI6mzq+BVQeOeBCKAa5x
	 2qpowKKEGi3Rw==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Mon, 14 Jul 2025 17:25:19 +0200
Subject: [PATCH net-next v3 6/7] net: airoha: npu: Enable core 3 for WiFi
 offloading
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250714-airoha-en7581-wlan-offlaod-v3-6-80abf6aae9e4@kernel.org>
References: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
In-Reply-To: <20250714-airoha-en7581-wlan-offlaod-v3-0-80abf6aae9e4@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lorenzo Bianconi <lorenzo@kernel.org>
Cc: Simon Horman <horms@kernel.org>, linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org
X-Mailer: b4 0.14.2

NPU core 3 is responsible for WiFi offloading so enable it during NPU
probe.

Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/ethernet/airoha/airoha_npu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/airoha/airoha_npu.c b/drivers/net/ethernet/airoha/airoha_npu.c
index 68ddc940f675b42599bd2c0245dc715bb56edb32..90000496b6a234897d4f208ab78d54af14be4aac 100644
--- a/drivers/net/ethernet/airoha/airoha_npu.c
+++ b/drivers/net/ethernet/airoha/airoha_npu.c
@@ -724,8 +724,7 @@ static int airoha_npu_probe(struct platform_device *pdev)
 	usleep_range(1000, 2000);
 
 	/* enable NPU cores */
-	/* do not start core3 since it is used for WiFi offloading */
-	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xf7);
+	regmap_write(npu->regmap, REG_CR_BOOT_CONFIG, 0xff);
 	regmap_write(npu->regmap, REG_CR_BOOT_TRIGGER, 0x1);
 	msleep(100);
 

-- 
2.50.1


