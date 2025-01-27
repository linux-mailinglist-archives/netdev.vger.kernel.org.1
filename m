Return-Path: <netdev+bounces-161076-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D6547A1D345
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 10:25:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3E011885809
	for <lists+netdev@lfdr.de>; Mon, 27 Jan 2025 09:25:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83BCD1FDA96;
	Mon, 27 Jan 2025 09:25:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx.socionext.com (mx.socionext.com [202.248.49.38])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC091FCFC5;
	Mon, 27 Jan 2025 09:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.248.49.38
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737969903; cv=none; b=LHMAnaP7FsBzkhdybu5HRzpQP3Zy3stK2zAIa5kcRkFvELU7gR3GTwF1pXcRxbNlYqHybTRDJfTHfIVA4oeM0qr0YwnYGzxNxrpt7LgvuwSA8F8Fh6OXBs2hGJKGKto4AB20LXumoH9V0R6UU7ueOkmdN5a6I70iDKUjD3B31+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737969903; c=relaxed/simple;
	bh=NL1KOGzHFnM7vRC/AL3GHdK7FWSKGHiUE5U8IFAELYI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=GFhAAJ6UOOwRhqKmFNpswf0JZEd+T0L4O0F37o5X3/2KfPbE2MfVnwVj2xB/e96NeFNCnWCMBsaeb9UJOAvA/UdZ50NNp2oAtul7MXEotJX1J6X5BijCHja0L5C1Mjoh3iv+4hUSZlClL+pa+nSIjVfsmmOpvlu6cfT5Umy6aoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com; spf=pass smtp.mailfrom=socionext.com; arc=none smtp.client-ip=202.248.49.38
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=socionext.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=socionext.com
Received: from unknown (HELO kinkan2-ex.css.socionext.com) ([172.31.9.52])
  by mx.socionext.com with ESMTP; 27 Jan 2025 18:24:59 +0900
Received: from mail.mfilter.local (mail-arc01.css.socionext.com [10.213.46.36])
	by kinkan2-ex.css.socionext.com (Postfix) with ESMTP id 246AC200B5D4;
	Mon, 27 Jan 2025 18:24:59 +0900 (JST)
Received: from kinkan2.css.socionext.com ([172.31.9.51]) by m-FILTER with ESMTP; Mon, 27 Jan 2025 18:24:59 +0900
Received: from plum.e01.socionext.com (unknown [10.212.245.39])
	by kinkan2.css.socionext.com (Postfix) with ESMTP id 87E16661;
	Mon, 27 Jan 2025 18:24:58 +0900 (JST)
From: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To: Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH net 1/3] net: stmmac: Fix use of queue max macros for Rx interrupt name
Date: Mon, 27 Jan 2025 18:24:48 +0900
Message-Id: <20250127092450.2945611-2-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
References: <20250127092450.2945611-1-hayashi.kunihiko@socionext.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix macros for maximum queue number to keep consistency.

Fixes: 8532f613bc78 ("net: stmmac: introduce MSI Interrupt routines for mac, safety, RX & TX")
Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index ea135203ff2e..86c071baedf2 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -354,7 +354,7 @@ struct stmmac_priv {
 	char int_name_sfty[IFNAMSIZ + 10];
 	char int_name_sfty_ce[IFNAMSIZ + 10];
 	char int_name_sfty_ue[IFNAMSIZ + 10];
-	char int_name_rx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 14];
+	char int_name_rx_irq[MTL_MAX_RX_QUEUES][IFNAMSIZ + 14];
 	char int_name_tx_irq[MTL_MAX_TX_QUEUES][IFNAMSIZ + 18];
 
 #ifdef CONFIG_DEBUG_FS
-- 
2.25.1


