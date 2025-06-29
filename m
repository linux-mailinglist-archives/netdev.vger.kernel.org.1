Return-Path: <netdev+bounces-202216-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E50EAAECC0C
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 12:01:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28C3C7A288E
	for <lists+netdev@lfdr.de>; Sun, 29 Jun 2025 10:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BF0920ADF8;
	Sun, 29 Jun 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cQjUOkTK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1180117A30F;
	Sun, 29 Jun 2025 10:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751191279; cv=none; b=l801pOpUhnl0hfzeu0oVugejZf12CBdo6JTZ8VwKx6i/ugcUHkbQFw2Osc6tGUvqmqC37I8vm8LdAhFG0fX0ntMxYej3HKP4qG0Nic+GCeHK27XZZUiGP3j+efCEElnOX+fOoH2AO+AttopIzWfqDbinoDGcbT+m6wBlznYuGls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751191279; c=relaxed/simple;
	bh=K7nid7pX0MchgdtwTmBOugLK+wyPztiQQ+cOV64xZJM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mVNFM5bucYDoMot9NZwVCArA0ihcTTU4hbhoWP4+BG7n2PgKz2gNLHwgIfgBOJerXELXtWi5cIRMKmq6ncYlpuUVENKAybEaPur1L+rBdNT/iMT+AdguKUXMbALmV9GAsLNA396c7Z11szG77If+Yv5RnIyO7ic4byS+PmhmLEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cQjUOkTK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6E7CC4CEEB;
	Sun, 29 Jun 2025 10:01:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751191278;
	bh=K7nid7pX0MchgdtwTmBOugLK+wyPztiQQ+cOV64xZJM=;
	h=From:To:Cc:Subject:Date:From;
	b=cQjUOkTKt80zjHWs/9616cRbQVAIzS0CSZtyKxtV2ed2MiCMnY8mqzfyLyiiNx8SA
	 FJg1U5CqoLxiMgjlBerRWaJD4k3MgJz1npTzly9NU0l4J7ixbwB9/cMlH8q8YIqTAu
	 F2WR3CFGWdjdJBIGxBwID9ZiExMEr+yY2h7DuoOQwIsQ7s4RhWmeLwfgNP8fp91mzk
	 Xb0bmoxiqTY9kT7ttefcxVjntZ1Z7C9QXyoMrXOe/0e0Bum9xD0mVyr+KM93UDp2OT
	 CVArBQArCJLElbqFYBQgqBDYnJ01Cm67c49q6Tw+i+kp62GIlPUIXFJs3Z8yXa7lX0
	 uCLO/3Re25jIQ==
From: Jisheng Zhang <jszhang@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] net: stmmac: add support for dwmac 5.20
Date: Sun, 29 Jun 2025 17:44:25 +0800
Message-ID: <20250629094425.718-1-jszhang@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The dwmac 5.20 IP can be found on some synaptics SoCs. Add a
compatibility flag, and extend coverage of the dwmac-generic driver
for the 5.20 IP.

Signed-off-by: Jisheng Zhang <jszhang@kernel.org>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
index b9218c07eb6b..cecce6ed9aa6 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-generic.c
@@ -59,6 +59,7 @@ static const struct of_device_id dwmac_generic_match[] = {
 	{ .compatible = "snps,dwmac-3.72a"},
 	{ .compatible = "snps,dwmac-4.00"},
 	{ .compatible = "snps,dwmac-4.10a"},
+	{ .compatible = "snps,dwmac-5.20"},
 	{ .compatible = "snps,dwmac"},
 	{ .compatible = "snps,dwxgmac-2.10"},
 	{ .compatible = "snps,dwxgmac"},
-- 
2.49.0


