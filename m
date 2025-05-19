Return-Path: <netdev+bounces-191582-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3E57ABC4E6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 18:50:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E4783AE447
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 16:50:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79AF328641D;
	Mon, 19 May 2025 16:50:39 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E9091E573F;
	Mon, 19 May 2025 16:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.233.101.22
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747673439; cv=none; b=bRVE3oB1LE/78RrrqGGq51P0mSnX1rfLDBQvVLho7gDll/QEQr1xCDBDbEs5PIzCqoG5AE5Oqhu61KtnPCNXUgHltPnPne2AYQEommlhqKFZKTHFrYrdZpXnrVW4ZNGO+ODmNBg8Z3hXuZpuvkjLJjx8eNULE7LoBBp278Tt0iM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747673439; c=relaxed/simple;
	bh=DhnCSKYnCcHJP7adP7B7aiXP352DFFSnM0q4AZoM1Bg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rlP7kL54GUAiy+FAo1WFFqTKK+Eqev612tSlh7B3FRsQ/rmxCUgxRR3EhKCbC7xiGDOsMgpLpbC2pmkSaKtgWcfMRSh/1Gnv1obwOFk2Jodjn7wQLk+LB2xhYfV5EgBvDGNSu6i6mmycR0nXhpRysWaKJ1RMlcJq0rYWI1z7cyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io; spf=pass smtp.mailfrom=sys-base.io; arc=none smtp.client-ip=185.233.101.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sys-base.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sys-base.io
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
	by leonov.paulk.fr (Postfix) with ESMTPS id CB8071F00050;
	Mon, 19 May 2025 16:50:32 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
	id 495AFAC2ABA; Mon, 19 May 2025 16:50:31 +0000 (UTC)
X-Spam-Level: *
Received: from localhost.localdomain (unknown [192.168.1.64])
	by laika.paulk.fr (Postfix) with ESMTP id 4EB52AC2ABA;
	Mon, 19 May 2025 16:49:43 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-sunxi@lists.linux.dev,
	linux-kernel@vger.kernel.org
Cc: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Chen-Yu Tsai <wens@csie.org>,
	Jernej Skrabec <jernej.skrabec@gmail.com>,
	Samuel Holland <samuel@sholland.org>,
	Corentin Labbe <clabbe.montjoie@gmail.com>,
	Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH] net: dwmac-sun8i: Use parsed internal PHY address instead of 1
Date: Mon, 19 May 2025 18:49:36 +0200
Message-ID: <20250519164936.4172658-1-paulk@sys-base.io>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While the MDIO address of the internal PHY on Allwinner sun8i chips is
generally 1, of_mdio_parse_addr is used to cleanly parse the address
from the device-tree instead of hardcoding it.

A commit reworking the code ditched the parsed value and hardcoded the
value 1 instead, which didn't really break anything but is more fragile
and not future-proof.

Restore the initial behavior using the parsed address returned from the
helper.

Fixes: 634db83b8265 ("net: stmmac: dwmac-sun8i: Handle integrated/external MDIOs")
Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
index 85723a78793a..6c7e8655a7eb 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-sun8i.c
@@ -964,7 +964,7 @@ static int sun8i_dwmac_set_syscon(struct device *dev,
 		/* of_mdio_parse_addr returns a valid (0 ~ 31) PHY
 		 * address. No need to mask it again.
 		 */
-		reg |= 1 << H3_EPHY_ADDR_SHIFT;
+		reg |= ret << H3_EPHY_ADDR_SHIFT;
 	} else {
 		/* For SoCs without internal PHY the PHY selection bit should be
 		 * set to 0 (external PHY).
-- 
2.49.0


