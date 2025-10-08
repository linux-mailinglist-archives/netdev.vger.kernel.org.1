Return-Path: <netdev+bounces-228188-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6234DBC4276
	for <lists+netdev@lfdr.de>; Wed, 08 Oct 2025 11:28:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 30F4A189B940
	for <lists+netdev@lfdr.de>; Wed,  8 Oct 2025 09:28:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F19F2BEC52;
	Wed,  8 Oct 2025 09:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="j3MA+Gp5"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B2E1339A4
	for <netdev@vger.kernel.org>; Wed,  8 Oct 2025 09:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759915682; cv=none; b=BHTWROuQaLdNtFEc5k38ayZLxyIldneFfuGPeD3NR/mu/lhs6UnrrTA4twaODQVFASlUZKk6f/vT2R2CVNgRDTa3yq5cWRBgnMDbfqgrWYDpHCt3NL7K0NK8Bbmz0esFiuRVYDjH4KRsRhMA3CtIObfzB6yL5HhxMLWpzKvAs94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759915682; c=relaxed/simple;
	bh=RC03KKut/tFuLMRGV1rLueDM9whbJfJ/nYBgSVrijaI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=HcBfHMyWXCEbDUM2qJUHCZNBVuwaqbQFkMIFASnnnW00kzkK69tDg8e9i0B+MXCTknjGYz4NTFxTSttgdWnwJdwTtUL+UKk5JGnz769X8E0EOfeSInb8TzlOcpSySStCT+wJxpaYuaLyAO/+BT+dX3yeG0OFrOrM5OcIwIV3Mmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j3MA+Gp5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49B0CC4CEF4;
	Wed,  8 Oct 2025 09:28:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759915680;
	bh=RC03KKut/tFuLMRGV1rLueDM9whbJfJ/nYBgSVrijaI=;
	h=From:Date:Subject:To:Cc:From;
	b=j3MA+Gp5znabotZ8h7cH079Ei8Vdc0RhbxL2qLaP5EttGXqQc+G7DmIhYPpIn31ps
	 55NF8WFaLMgpFlMROe0Tl9DGKDB49pSRQ6OZa0sr50ScTM3aMTFXO/PcT2fGubkK6t
	 g0x4MgUdE4Y1phFhBDrkIcBj75BLk6Kzxle1Ci14PqRfx0gj18NQrHOJjSoUtc0SuG
	 M7pKeFyTKEpM9DEqJkrnGAdXxhACMpkhworVSE0g8GyDOHSJ2weQ0ubGmEznTpBB+i
	 XZ3UGgtMGg0Eta5iEh01cfc7cpR7qCUH3IKbulXniVLqpMHF1+UErv4gTzA8tjL8QQ
	 F6CfjkFcqk0zQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
Date: Wed, 08 Oct 2025 11:27:43 +0200
Subject: [PATCH net v2] net: airoha: Fix loopback mode configuration for
 GDM2 port
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251008-airoha-loopback-mode-fix-v2-1-045694fe7f60@kernel.org>
X-B4-Tracking: v=1; b=H4sIAI4u5mgC/4WNQQ6DMAwEv4J8rqsEBLQ98Y+KQxoMWNAYOQi1Q
 vy9ER/ocWe1sztEUqYIj2wHpY0jS0ghv2TgRxcGQu5ShtzkpTWmRMcqo8NZZHk5P+FbOsKeP1i
 4uzemqIytCdJ8UUr4VD8h0AptgiPHVfR73m32rP6bN4sWu+Tt65vzfV01E2mg+So6QHscxw9Sm
 pBdxgAAAA==
X-Change-ID: 20251005-airoha-loopback-mode-fix-3a9c0036017e
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-arm-kernel@lists.infradead.org, 
 linux-mediatek@lists.infradead.org, netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Add missing configuration for loopback mode in airhoha_set_gdm2_loopback
routine.

Fixes: 9cd451d414f6e ("net: airoha: Add loopback support for GDM2")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes in v2:
- Use human readable marcos to configure loopback mode register
- Link to v1: https://lore.kernel.org/r/20251005-airoha-loopback-mode-fix-v1-1-d017f78acf76@kernel.org
---
 drivers/net/ethernet/airoha/airoha_eth.c  | 4 +++-
 drivers/net/ethernet/airoha/airoha_regs.h | 3 +++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/airoha/airoha_eth.c b/drivers/net/ethernet/airoha/airoha_eth.c
index 81ea01a652b9c545c348ad6390af8be873a4997f..833dd911980b3f698bd7e5f9fd9e2ce131dd5222 100644
--- a/drivers/net/ethernet/airoha/airoha_eth.c
+++ b/drivers/net/ethernet/airoha/airoha_eth.c
@@ -1710,7 +1710,9 @@ static void airhoha_set_gdm2_loopback(struct airoha_gdm_port *port)
 	airoha_fe_wr(eth, REG_GDM_RXCHN_EN(2), 0xffff);
 	airoha_fe_rmw(eth, REG_GDM_LPBK_CFG(2),
 		      LPBK_CHAN_MASK | LPBK_MODE_MASK | LPBK_EN_MASK,
-		      FIELD_PREP(LPBK_CHAN_MASK, chan) | LPBK_EN_MASK);
+		      FIELD_PREP(LPBK_CHAN_MASK, chan) |
+		      LBK_GAP_MODE_MASK | LBK_LEN_MODE_MASK |
+		      LBK_CHAN_MODE_MASK | LPBK_EN_MASK);
 	airoha_fe_rmw(eth, REG_GDM_LEN_CFG(2),
 		      GDM_SHORT_LEN_MASK | GDM_LONG_LEN_MASK,
 		      FIELD_PREP(GDM_SHORT_LEN_MASK, 60) |
diff --git a/drivers/net/ethernet/airoha/airoha_regs.h b/drivers/net/ethernet/airoha/airoha_regs.h
index e1c15c20be8e13197de743d9b590dc80058560a5..69c5a143db8c079be0a6ecf41081cd3f5048c090 100644
--- a/drivers/net/ethernet/airoha/airoha_regs.h
+++ b/drivers/net/ethernet/airoha/airoha_regs.h
@@ -151,6 +151,9 @@
 #define LPBK_LEN_MASK			GENMASK(23, 10)
 #define LPBK_CHAN_MASK			GENMASK(8, 4)
 #define LPBK_MODE_MASK			GENMASK(3, 1)
+#define LBK_GAP_MODE_MASK		BIT(3)
+#define LBK_LEN_MODE_MASK		BIT(2)
+#define LBK_CHAN_MODE_MASK		BIT(1)
 #define LPBK_EN_MASK			BIT(0)
 
 #define REG_GDM_TXCHN_EN(_n)		(GDM_BASE(_n) + 0x24)

---
base-commit: 1b54b0756f051c11f5a5d0fbc1581e0b9a18e2bc
change-id: 20251005-airoha-loopback-mode-fix-3a9c0036017e

Best regards,
-- 
Lorenzo Bianconi <lorenzo@kernel.org>


