Return-Path: <netdev+bounces-245886-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DF70ECD9FB9
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 17:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 31F7430155EB
	for <lists+netdev@lfdr.de>; Tue, 23 Dec 2025 16:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B21A288517;
	Tue, 23 Dec 2025 16:33:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b="0KpOrhnH"
X-Original-To: netdev@vger.kernel.org
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A98F4086A;
	Tue, 23 Dec 2025 16:33:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.194.8.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766507626; cv=none; b=EHQyB++zQepF3iOmsLyzkmjA7a+KYYSk8JlknyeXtF0Ak6VIg+qzMt4nT793Oi5C/cYqbkgMtAS10zef7eeP/NB6nznMHYb5rbiGqZi9DhmeTl8/EkfiCYq0eXI7CRVY0haBPAL8Z2BafQWboFIRWN6iFuc7he0uqoBpfReLtBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766507626; c=relaxed/simple;
	bh=tRR9j249ftycqdIn+VY4uKILXS+oM/lIyWqwPbCv5vE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W5la5Wbt2pCZyRKmIa+ZDIXGGNNYaVLGdbyXhnNp7Lf3U8Fd8egTI56GK14VjYmPmlaM36S8SmiRp4ZJchVx/4s7271RAR5TNKZ09Xfw+uwplwSRUBT2h8tZKT3bHoLKFjtmoBjUyr7TCFh+tGJo7KCil0XrTrRDl63bQYBZSNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it; spf=pass smtp.mailfrom=dolcini.it; dkim=pass (2048-bit key) header.d=dolcini.it header.i=@dolcini.it header.b=0KpOrhnH; arc=none smtp.client-ip=217.194.8.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=dolcini.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dolcini.it
Received: from localhost.localdomain (xcpe-178-82-120-96.dyn.res.sunrise.net [178.82.120.96])
	by mail11.truemail.it (Postfix) with ESMTPA id 47D7D1FB64;
	Tue, 23 Dec 2025 17:33:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
	s=default; t=1766507622;
	bh=Z3mW0ZoJl+E1eseS/kHD3Epd60uiqDZZV8DxmOZz43I=; h=From:To:Subject;
	b=0KpOrhnHySqlVAQ79LtRU8HKegj7RpZ3cdBAkeZqjMq/25Ppo78DTLcVc9+G7lZL6
	 OUzwi//pez/wb1b35Y9JvwfLi6U2j4mRpnEfld/SkssR13X3NBzZRHSzNncehbmuBY
	 l5rraezaH2wnqPOR8Sp+FFv4wCOfugeWyHDx/k2OKZqFEo7ahLn22P9YjddrwJMs/L
	 X+5wGM5Vpu0zs2p8dPUUS3OfDOTcQuXZsvNJMMAAYQ+kMCx1N9A0/Lo/DRR4Qr/8P0
	 KEv8BvpfTd1o8LWsL6IRjGlmqGw0Amf565ui6mP6pUR8gEYSxwTcnnrqrzvL4Poosn
	 aVZEI9FWKcnvA==
From: Francesco Dolcini <francesco@dolcini.it>
To: Wei Fang <wei.fang@nxp.com>,
	Shenwei Wang <shenwei.wang@nxp.com>,
	Clark Wang <xiaoning.wang@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
	imx@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v1] net: fec: Add stop mode support on i.MX8DX/i.MX8QP
Date: Tue, 23 Dec 2025 17:33:27 +0100
Message-ID: <20251223163328.139734-1-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Francesco Dolcini <francesco.dolcini@toradex.com>

Add additional machines that requires communication to the SC firmware
to set the GPR bit required for stop mode support.

NXP i.MX8DX (fsl,imx8dx) is a low end version of i.MX8QXP (fsl,imx8qxp),
while NXP i.MX8QP (fsl,imx8qp) is a low end version of i.MX8QM
(fsl,imx8qp).

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/net/ethernet/freescale/fec_main.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/freescale/fec_main.c b/drivers/net/ethernet/freescale/fec_main.c
index c685a5c0cc51..2eacc35e0b8a 100644
--- a/drivers/net/ethernet/freescale/fec_main.c
+++ b/drivers/net/ethernet/freescale/fec_main.c
@@ -1334,7 +1334,9 @@ fec_restart(struct net_device *ndev)
 static int fec_enet_ipc_handle_init(struct fec_enet_private *fep)
 {
 	if (!(of_machine_is_compatible("fsl,imx8qm") ||
+	      of_machine_is_compatible("fsl,imx8qp") ||
 	      of_machine_is_compatible("fsl,imx8qxp") ||
+	      of_machine_is_compatible("fsl,imx8dx") ||
 	      of_machine_is_compatible("fsl,imx8dxl")))
 		return 0;
 
-- 
2.47.3


