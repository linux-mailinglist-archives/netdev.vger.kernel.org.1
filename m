Return-Path: <netdev+bounces-173373-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A724A58894
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 22:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EBC06188D28D
	for <lists+netdev@lfdr.de>; Sun,  9 Mar 2025 21:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBAD321B185;
	Sun,  9 Mar 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SaZBQtiL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CD671EF368;
	Sun,  9 Mar 2025 21:42:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741556571; cv=none; b=N9W8guXDs0VL51R4cSfl4zP4aCtYyoKbAkv+GEuTSHWyTPgawalgbgr7/KTzL/AZ6OcA0j5jmccwHY4h656NTlqlYU+AtPRJq9DtcZtcUvyE+5OZEW3ac1jZF8Lw8xFcm50qwmZChZZMq86Calkx4FvIMpXWkFBxToUKLpfKtcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741556571; c=relaxed/simple;
	bh=P7D0bYg10uRLSa6f/4tmaqDLf07szRFGfnMnXg/qoc4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Hj346ejpyzNujRTJyX+68sGuZ3BkPUNrpoGqBPR17uW365nLpnIXmKwbF9O7BK9Gt6zGZSuSansuMxGyajrgn4xXBqG+vxGwpBU/hcs89Kb/c/VrJB2MyOD9prg5URJV7HsBSdDHkUPAW7ZIR8ZJDLDAsWyenWs7ro2RzZqnd7k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SaZBQtiL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00E5DC4CEE3;
	Sun,  9 Mar 2025 21:42:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741556571;
	bh=P7D0bYg10uRLSa6f/4tmaqDLf07szRFGfnMnXg/qoc4=;
	h=From:To:Cc:Subject:Date:From;
	b=SaZBQtiLdcW+X6TZScV5/ZrKcpohHgKkbVoK1MVdBmCbJHpcGdBiysUnDppe2bxGC
	 VmnRsBLCXrKe/kIcQGRvnbxm99ie66FLugrb5JPsRr8SGht3mb1QObNjAIvIQ/oSFz
	 Bni+o6QqQ8aTFTMIHUwW0LAetwfktJAS1Txr6K4xxgC9buoiW9Hjy89vmy8zKBtkjY
	 sx/EaVs2q6MFUrfcxaQyLxFgcApg3xJMPXyGFYM+76wCnNLLQ/UY8hoVezsBonQovN
	 SPO0vOV3hTuFBudH+zwYDeZK1Q3fHi11LmlyLIZN6sLSMJ79Zw88sxh8h7hKCLipkf
	 pfyy++kwMvNaw==
From: deller@kernel.org
To: netdev@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Helge Deller <deller@gmx.de>
Subject: [PATCH] net: tulip: avoid unused variable warning
Date: Sun,  9 Mar 2025 22:42:38 +0100
Message-ID: <20250309214238.66155-1-deller@kernel.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Helge Deller <deller@gmx.de>

When compiling with W=1 and CONFIG_TULIP_MWI=n one gets this warning:
 drivers/net/ethernet/dec/tulip/tulip_core.c: In function ‘tulip_init_one’:
 drivers/net/ethernet/dec/tulip/tulip_core.c:1309:22: warning: variable ‘force_csr0’ set but not used

Avoid it by annotating the variable __maybe_unused, which seems to be
the easiest solution.

Signed-off-by: Helge Deller <deller@gmx.de>
---
 drivers/net/ethernet/dec/tulip/tulip_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/dec/tulip/tulip_core.c b/drivers/net/ethernet/dec/tulip/tulip_core.c
index 27e01d780cd0..1ab65deb280c 100644
--- a/drivers/net/ethernet/dec/tulip/tulip_core.c
+++ b/drivers/net/ethernet/dec/tulip/tulip_core.c
@@ -1306,7 +1306,7 @@ static int tulip_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	const char *chip_name = tulip_tbl[chip_idx].chip_name;
 	unsigned int eeprom_missing = 0;
 	u8 addr[ETH_ALEN] __aligned(2);
-	unsigned int force_csr0 = 0;
+	unsigned int force_csr0 __maybe_unused = 0;
 
 	board_idx++;
 
-- 
2.47.0


