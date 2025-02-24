Return-Path: <netdev+bounces-169026-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C198A4223E
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 15:02:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9A38E3BCA7B
	for <lists+netdev@lfdr.de>; Mon, 24 Feb 2025 13:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAC242561BA;
	Mon, 24 Feb 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UgtfwNWw"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8374C252904;
	Mon, 24 Feb 2025 13:53:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740405221; cv=none; b=csDfzHSGmDBZAUh4187i1G7z2r0Xk02MdHtUbpAVP1kCE9jXDg4ermQZdvxjeRRS7xoRbcN5RSJXnTZasshfErZFnubJjxty74Z2xpkxPjZikfsIFCrVEARZEakXr5PxQpJAWP1HF45jSb4/jwnZs5bsR7YE07cVEWtwcVbQ7X4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740405221; c=relaxed/simple;
	bh=5xrxXhAp1q9xlycoc9AVu+owuxCr14/GLlxmzUJC94w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ou4mwRylVfLCZcQeqhR5MPqAuNMm8DDfyK/f6q9RbhT30rM9ej7FKzXfJAs+lKx+BlT1hF5+/wBpKG39C3IreQ/jXSW5ZDeNaT1J3zigzXSMVVA01RoufDvwFYCIB+sdQDT+XTHXYtb+GSsNHHTYwf+b3P9E/p9ZwSIL8F6vK8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UgtfwNWw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5A54C4CEEA;
	Mon, 24 Feb 2025 13:53:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740405221;
	bh=5xrxXhAp1q9xlycoc9AVu+owuxCr14/GLlxmzUJC94w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UgtfwNWwofNITGYl9SNjVj8FFLk0w7GNMLyFzybfZUfSDEgV5GJ/1eZXQ+4xM0gp6
	 XVC1dsBHnsqw8JH5rRcwprEF362Ltz+bm7pM8v95eXOhnrzpg7a7xSIdjgVnHs82LG
	 QqoVv6/WCVSCClunFpIjuS5hn1bhxMe+Iun5qjin8w6mBLXf17Mw4I2Dc/Z/elx5we
	 CMK/EtvSgAd82kpUyUdA5c+fPrgFKI13OPuAfeA29I3kWwZbEAnXtPveJvr1uMuP/3
	 e6F9UFH7TgLKAiitci/oIX738FEn5x4wZIwBfVU9w2mKB9874f7DYhQRj2xKjX42iS
	 qg+LP545S/HxQ==
From: Philipp Stanner <phasta@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	Yanteng Si <si.yanteng@linux.dev>,
	Yinggang Gu <guyinggang@loongson.cn>,
	Feiyang Chen <chenfeiyang@loongson.cn>,
	Philipp Stanner <pstanner@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Qing Zhang <zhangqing@loongson.cn>
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Philipp Stanner <phasta@kernel.org>
Subject: [PATCH net-next v3 2/4] stmmac: loongson: Remove surplus loop
Date: Mon, 24 Feb 2025 14:53:20 +0100
Message-ID: <20250224135321.36603-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250224135321.36603-2-phasta@kernel.org>
References: <20250224135321.36603-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

loongson_dwmac_probe() contains a loop which doesn't have an effect,
because it tries to call pcim_iomap_regions() with the same parameters
several times. The break statement at the loop's end furthermore ensures
that the loop only runs once anyways.

Remove the surplus loop.

Signed-off-by: Philipp Stanner <phasta@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 11 +++--------
 1 file changed, 3 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 73a6715a93e6..e3cacd085b3f 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -554,14 +554,9 @@ static int loongson_dwmac_probe(struct pci_dev *pdev, const struct pci_device_id
 	pci_set_master(pdev);
 
 	/* Get the base address of device */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i) == 0)
-			continue;
-		ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
-		if (ret)
-			goto err_disable_device;
-		break;
-	}
+	ret = pcim_iomap_regions(pdev, BIT(0), DRIVER_NAME);
+	if (ret)
+		goto err_disable_device;
 
 	memset(&res, 0, sizeof(res));
 	res.addr = pcim_iomap_table(pdev)[0];
-- 
2.48.1


