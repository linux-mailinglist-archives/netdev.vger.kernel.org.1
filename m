Return-Path: <netdev+bounces-70166-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9496084DE68
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 11:35:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC3781C20992
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 10:35:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12E1322065;
	Thu,  8 Feb 2024 10:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i1R6VbZa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rVNmJZso"
X-Original-To: netdev@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542611DFCE
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 10:35:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707388555; cv=none; b=kUw8wobte3nlk+weP2xd597+wVirCQVzkh6xYx/40Y8koVGq1abtKFOjM3nf1SGOHYGOp3+LFU/xBNvQi8zFtRVDQ0YT12x4EIClxF7miX1ZakC0r8zrLkdV1xp6gi+qn7qWYiZjMvVZinG663OxNcFV2N/zKurbmP1a92UONic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707388555; c=relaxed/simple;
	bh=XYU8UThxyVM/BmRkaWbkfJ/UUWs7MkJRNJWR7CTFe+g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=pGMWhbWPHSAGTqOazSFKZ6AngM8oA86HCxt/BjyyF5ClerKXc9/j5DmnApIxcQYPhHMG3/pmgQwFsLmYN5re8Q2SgrayHmPz+uox4dqxW5M6TmKj0SjT4LpvmoK+w5fAzmre79twgx2GYM2nOM2gbbkN54rSH+u+YS6P6vQIHKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i1R6VbZa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rVNmJZso; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Kurt Kanzenbach <kurt@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1707388545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O8FbyMLRAf0MPPkiZw7u/45AM7lfLrYJ9PmRTbq1LVE=;
	b=i1R6VbZadJXN4evezJU3+AfnzMNV8Ufv037Ye1lMlAU9W4BqV73Bl3olyJhF/UfVyyYm6i
	AzvxBaW9KTA23MIUOn/NPVJwTv6qyNIbM5GkDnOZN58ZDzhFka16o0mD6quoKyJddMEwr5
	EgLxYUwWxj9BZJ5nunC0tC8jxNuyUFEM+iAhE/CKiQBBxy07+/B3iID+Q5OEeufDLVljee
	pIJv8Z0FU08xpDSjfABqFuCITnCZpwrSo1/F81WPlK69tYSnmTKbnGXSrZisfwSrLXSnDc
	JGFzfsjYKIOdYEcjBPWcDb+BlK0elp9oqI44Mfl/f3grZAVn2a6ImzpVb8rRrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1707388545;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O8FbyMLRAf0MPPkiZw7u/45AM7lfLrYJ9PmRTbq1LVE=;
	b=rVNmJZsoRL/7zc5amA+WEs/jUMej37PPpGOnmELL1OLBfqFWEzbFhYOwpGRrZZ/G8yTA83
	nLpKpS9US8okTlAQ==
Date: Thu, 08 Feb 2024 11:35:25 +0100
Subject: [PATCH net-next] net: stmmac: Simplify mtl IRQ status checking
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240208-stmmac_irq-v1-1-8bab236026d4@linutronix.de>
X-B4-Tracking: v=1; b=H4sIAGyuxGUC/x2N0QrCMAwAf2Xk2UItzlZ/RUSymrk8NGpSZDD27
 +t8PI7jFjBSJoNrt4DSj43f0uB46CBPKC9y/GwMwYeTDz45q6VgfrB+XR/PKYwYY8oXaMGARm5
 QlDztSUGrpLv4KI08/y83EKpOaK5wX9cNWvkro38AAAA=
To: Alexandre Torgue <alexandre.torgue@foss.st.com>, 
 Jose Abreu <joabreu@synopsys.com>, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, 
 Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: Yannick Vignon <yannick.vignon@nxp.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, netdev@vger.kernel.org, 
 linux-stm32@st-md-mailman.stormreply.com, 
 linux-arm-kernel@lists.infradead.org, Kurt Kanzenbach <kurt@linutronix.de>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1321; i=kurt@linutronix.de;
 h=from:subject:message-id; bh=XYU8UThxyVM/BmRkaWbkfJ/UUWs7MkJRNJWR7CTFe+g=;
 b=owEBbQKS/ZANAwAKAcGT0fKqRnOCAcsmYgBlxK6Atb08JaTdEHu7F+d5W5Op9N65/uLVyQhBt
 IlsR7kKKRaJAjMEAAEKAB0WIQS8ub+yyMN909/bWZLBk9HyqkZzggUCZcSugAAKCRDBk9HyqkZz
 gm5XD/43iUUdoU4KgOL+dc14oqp3MKYJwu278fwqFSQWR8q9etX6XukXKnNp3QFfDet2+nwrCk/
 vjO93JpRiaL3UBsxrw6pljF1hAPwdfPHFOsk1WAXFRXvc4V5/RSjskdxOTbuBOexmPhvTph+gpg
 p19k8FVIEwnao1Zw/MVpslZNGW5DbLCwNIxnqVvoKjXkd/3WUrMEvWdCj/Lg3gIYjewXJbx9jxB
 9SnDFqMHN8diP4ybcS7xsnt3drAOiKaLsdhu8O8ID7VaMyj2j8UfJSZ/lUgAr6TgmFN/dJ1w3Q/
 PVWOH2blV0Md9Pf45U0Hivc632odzpInvaMOv1eHtrGeIHWM/7vVsNZXWW3BgYZDjAqrH1emM/Q
 8s7IzXLytvKO2DOMxCjgewx5OXOo5UW5KGQHN5XDXmqGGmpT/RiowcQBZUHrob6sbbl0je/x4T/
 VMKeZk97xA4z7xI03rEvsobCWDuSe67eTBA8W9+9PfN3xqTom8f2ImjasCQ0GRj/ZswRyEP70Om
 qBDrd6+Ss1mXosZu9kNYNkX1jtZ9PTaMnVGEgBSYoV2Rg7TcwjByMMDZGLC9qQkGwfbHKYrZXhZ
 kTSBuR8RTMpi1CLXy9MuJTPSf8+pU5XJPqtUkN1O4qekO+WwtZYY4HWnmjKWGeYCqITAtCNQoI1
 BlWB4xJLbkdMK0g==
X-Developer-Key: i=kurt@linutronix.de; a=openpgp;
 fpr=BCB9BFB2C8C37DD3DFDB5992C193D1F2AA467382

Commit 8a7cb245cf28 ("net: stmmac: Do not enable RX FIFO overflow
interrupts") disabled the RX FIFO overflow interrupts. However, it left the
status variable around, but never checks it.

As stmmac_host_mtl_irq_status() returns only 0 now, the code can be
simplified.

Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_main.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index 04d817dc5899..10ce2f272b62 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -6036,10 +6036,8 @@ static void stmmac_common_interrupt(struct stmmac_priv *priv)
 				priv->tx_path_in_lpi_mode = false;
 		}
 
-		for (queue = 0; queue < queues_count; queue++) {
-			status = stmmac_host_mtl_irq_status(priv, priv->hw,
-							    queue);
-		}
+		for (queue = 0; queue < queues_count; queue++)
+			stmmac_host_mtl_irq_status(priv, priv->hw, queue);
 
 		/* PCS link status */
 		if (priv->hw->pcs &&

---
base-commit: 006e89649fa913e285b931f1b8dfd6485d153ca7
change-id: 20240208-stmmac_irq-57682fa778c9

Best regards,
-- 
Kurt Kanzenbach <kurt@linutronix.de>


