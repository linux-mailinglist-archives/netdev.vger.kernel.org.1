Return-Path: <netdev+bounces-158902-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04524A13B65
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 14:56:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 804B8188719B
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 13:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8023522A81B;
	Thu, 16 Jan 2025 13:55:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LECfM7Xo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 575E922A7FE;
	Thu, 16 Jan 2025 13:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737035704; cv=none; b=mAVH6ud98mzEAccdRCfNTdBWWvxGzYGzrRqrwIVtzLvvgT1NT885w/j4MBlOZF0mvX0R+K1Agslu0bWR+zVT0C7ov3YnSjg90jpzf/E/yK/I4cIS+pdXaGp2KMWuQTkaXlwSKIJBrEvo4LZd07vQk2guzUgCraeFpSL7nCY8TTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737035704; c=relaxed/simple;
	bh=7YyaAJeLvCjPoXkFQ+N/Qnf8eZ1Mngdi9TENnBCJttA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=rVO0oO51dhmWc3WYrKdnz7Z00KaEgeQHKB5B8pqpD/xmkpC6d6m5Qlv+4BAURRp2srJ0lzXK4xp1KQPoTpSvcTinXAhcg+/9T9gsNHxD09aGxv741UHdc9AR4hVVXMly5tMw4/3hvCxB5j09ov8UpPgN2owslEJHHS7TV1cCuRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LECfM7Xo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F91C4CED6;
	Thu, 16 Jan 2025 13:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737035703;
	bh=7YyaAJeLvCjPoXkFQ+N/Qnf8eZ1Mngdi9TENnBCJttA=;
	h=From:Date:Subject:To:Cc:From;
	b=LECfM7XomfoctY7bnNNmNo2hJcatJd1OzpD7CN1l5W/LYa5qEF3VqazVd2fUe8Ug+
	 Mr/E4RffSjAtfFLc1rhHpK/BYG6NZrSsJ9yf46zILy+cLpVlgVpVGC6kKIPAkyYvPK
	 JfNuKqqwK1UZ9ggy43T4hB/YU3BbnSsYdGElm3MWURJddaYn0iDwmrly8EDKmvgoc3
	 4sqJqjQZryQUTnlRNHaVFK56BmFDo4AOzYZjTCxnaZOuAspVLuqGoWmDonVAk3iVDI
	 x0nJO9G7Pppm/LoK5BR9DGKkISq2+PiBnFobbWSodN1/KvZYrbaUlSLXebyBwx2DaD
	 gCsHTWS3uJyhA==
From: Roger Quadros <rogerq@kernel.org>
Date: Thu, 16 Jan 2025 15:54:49 +0200
Subject: [PATCH net v2] net: ethernet: ti: am65-cpsw: fix freeing IRQ in
 am65_cpsw_nuss_remove_tx_chns()
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250116-am65-cpsw-fix-tx-irq-free-v2-1-ada49409a45f@kernel.org>
X-B4-Tracking: v=1; b=H4sIAKgPiWcC/42NTQ6CMBCFr0Jm7RimoQ268h6GRYUBJmqBKUEM4
 e42nMDl+/veBpFVOMI120B5kShDSMKcMqh7HzpGaZIGkxubExXo385iPcYPtrLivKLohK0yY1k
 4X1vL7Jgg7UflVDnYdwg8Q5XMXuI86Pf4W+iI/kAvhIQPk7tLgjdU2tuTNfDrPGgH1b7vP1KoY
 JXIAAAA
To: Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Grygorii Strashko <grygorii.strashko@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
Cc: srk@ti.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Roger Quadros <rogerq@kernel.org>, Simon Horman <horms@kernel.org>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2336; i=rogerq@kernel.org;
 h=from:subject:message-id; bh=7YyaAJeLvCjPoXkFQ+N/Qnf8eZ1Mngdi9TENnBCJttA=;
 b=owEBbQKS/ZANAwAIAdJaa9O+djCTAcsmYgBniQ+0AI1SHnLa/2ktV8J/piObDIk1ncrKNsWMW
 0fdQap8bX+JAjMEAAEIAB0WIQRBIWXUTJ9SeA+rEFjSWmvTvnYwkwUCZ4kPtAAKCRDSWmvTvnYw
 k0auD/wPVMnKWi68Ds3qwAflRMYBfHRawrg73okIT/rsp+4GzBpFdaUXqgezo77xz56kt5BMK4v
 pqlmH0O3iJWkk1/cCd8pzgy5ctSpeibomAx1p0HchiYbBS8xZ7L8sjEpHMSYRXRGmjabFTp9BuX
 dCohzxQa8XhNBlVsmhNJq1NmAWU52RPkBzuhOEl6fUrKwRXpBnHzfbZjUN/xdu8awrhNxjY+3v+
 44kfLXqQVTxRx77clYsSXPih1INl13cHS+XzY2l0yy3DlylJ6ABMOeWk/LPWp5RnDjqrsC69hx0
 ynvf/nDYbEBNjvGTql9UQR1GBL3Wi4TopQ4cYLqZQ4FVY2ZD5GcD6ydm59mpDw0fyraTLmHsGhf
 ATXrtdkZg2OifXYqXRngT21gNVZ+Wsn1KUgWzYYwIKN1x5ZbP0k84bLQdDCobBbJlp3cAvgspQF
 lGy9l1ZBtZ88Ui6T+iwsxUJKXLns6vCIrAurydJn4cpxHBvhNynFvbNsMJAMFmcSfe7j4Fp9JoB
 fZycgfdAMVK7UAc+TISXqL7L39hKgRW4Ek0knww3ElzvVNqAR3lpLWo1tsbR9R5Twa5OAR0r+i3
 GpKfnlvplMd5IhTm0G4YUVXmyx2kuy5DS+oJ2xk3Pf9/9c4rx17UAua4A76dYl+8DTOAALfwuF5
 V9lzLMeQRCu9VWA==
X-Developer-Key: i=rogerq@kernel.org; a=openpgp;
 fpr=412165D44C9F52780FAB1058D25A6BD3BE763093

When getting the IRQ we use k3_udma_glue_tx_get_irq() which returns
negative error value on error. So not NULL check is not sufficient
to deteremine if IRQ is valid. Check that IRQ is greater then zero
to ensure it is valid.

There is no issue at probe time but at runtime user can invoke
.set_channels which results in the following call chain.
am65_cpsw_set_channels()
 am65_cpsw_nuss_update_tx_rx_chns()
  am65_cpsw_nuss_remove_tx_chns()
  am65_cpsw_nuss_init_tx_chns()

At this point if am65_cpsw_nuss_init_tx_chns() fails due to
k3_udma_glue_tx_get_irq() then tx_chn->irq will be set to a
negative value.

Then, at subsequent .set_channels with higher channel count we
will attempt to free an invalid IRQ in am65_cpsw_nuss_remove_tx_chns()
leading to a kernel warning.

The issue is present in the original commit that introduced this driver,
although there, am65_cpsw_nuss_update_tx_rx_chns() existed as
am65_cpsw_nuss_update_tx_chns().

Fixes: 93a76530316a ("net: ethernet: ti: introduce am65x/j721e gigabit eth subsystem driver")
Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Simon Horman <horms@kernel.org>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
Changes in v2:
- Fixed typo in commit log k3_udma_glue_rx_get_irq->k3_udma_glue_tx_get_irq
- Added more details to commit log
- Added Reviewed-by tags
- Link to v1: https://lore.kernel.org/r/20250114-am65-cpsw-fix-tx-irq-free-v1-1-b2069e6ed185@kernel.org
---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/ti/am65-cpsw-nuss.c b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
index 5465bf872734..e1de45fb18ae 100644
--- a/drivers/net/ethernet/ti/am65-cpsw-nuss.c
+++ b/drivers/net/ethernet/ti/am65-cpsw-nuss.c
@@ -2248,7 +2248,7 @@ static void am65_cpsw_nuss_remove_tx_chns(struct am65_cpsw_common *common)
 	for (i = 0; i < common->tx_ch_num; i++) {
 		struct am65_cpsw_tx_chn *tx_chn = &common->tx_chns[i];
 
-		if (tx_chn->irq)
+		if (tx_chn->irq > 0)
 			devm_free_irq(dev, tx_chn->irq, tx_chn);
 
 		netif_napi_del(&tx_chn->napi_tx);

---
base-commit: 5bc55a333a2f7316b58edc7573e8e893f7acb532
change-id: 20250114-am65-cpsw-fix-tx-irq-free-846ac55ee6e1

Best regards,
-- 
Roger Quadros <rogerq@kernel.org>


