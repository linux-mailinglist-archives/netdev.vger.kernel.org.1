Return-Path: <netdev+bounces-33663-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCAC379F150
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 20:43:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7196028197F
	for <lists+netdev@lfdr.de>; Wed, 13 Sep 2023 18:43:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AC52397;
	Wed, 13 Sep 2023 18:43:09 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23C3737F
	for <netdev@vger.kernel.org>; Wed, 13 Sep 2023 18:43:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16FFAC433C7;
	Wed, 13 Sep 2023 18:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694630587;
	bh=7FcZwAM95itDalwh77CG0mSbMJnWAWBg6VcokuEfUoo=;
	h=From:To:Cc:Subject:Date:From;
	b=g0exjdI931D8a05RLkyumqqhOxCl1GnGBA53q6qg+Ru98auE5YOrMwiYNtF3SlG9G
	 ZM5vUFDOCnEPd/+hp1DwW6Z4pT1aPlVWVJ9EpOUOEcZO3EnVDCbMfeQT03KqlD+1cx
	 sdAatq+0GUG29kAI1Zt8qxydF9zuiwzegUo7Ph4AT/CQE/eJQNH2wF8PQT1Ob93dAV
	 8ASvGUalI3YuIV5mTslaRcjLQa5j1PjGhnYcoMMiupNpx/6/bTlvIiRgew2mp4GCVz
	 CQ7MH0cxs/jLO9sJWlVNZRLUfwf0R2O1XHEoaKK5XGEEjGebAMDM59G57Zucroa6T3
	 uy/UIUTeIdgpQ==
From: Lorenzo Bianconi <lorenzo@kernel.org>
To: netdev@vger.kernel.org
Cc: lorenzo.bianconi@redhat.com,
	nbd@nbd.name,
	john@phrozen.org,
	sean.wang@mediatek.com,
	Mark-MC.Lee@mediatek.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org
Subject: [PATCH v2 net-next] net: ethernet: mtk_wed: do not assume offload callbacks are always set
Date: Wed, 13 Sep 2023 20:42:47 +0200
Message-ID: <ea9e1313e01f7925b9fc4040f3776070447f261d.1694630374.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check if wlan.offload_enable and wlan.offload_disable callbacks are set
in mtk_wed_flow_add/mtk_wed_flow_remove since mt7996 will not rely
on them.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
Changes since v1:
- move offload check inside hw_lock critical section
---
 drivers/net/ethernet/mediatek/mtk_wed.c | 32 +++++++++++++------------
 1 file changed, 17 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed.c b/drivers/net/ethernet/mediatek/mtk_wed.c
index 94376aa2b34c..e7d3525d2e30 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed.c
@@ -1713,19 +1713,20 @@ mtk_wed_irq_set_mask(struct mtk_wed_device *dev, u32 mask)
 int mtk_wed_flow_add(int index)
 {
 	struct mtk_wed_hw *hw = hw_list[index];
-	int ret;
+	int ret = 0;
 
-	if (!hw || !hw->wed_dev)
-		return -ENODEV;
+	mutex_lock(&hw_lock);
 
-	if (hw->num_flows) {
-		hw->num_flows++;
-		return 0;
+	if (!hw || !hw->wed_dev) {
+		ret = -ENODEV;
+		goto out;
 	}
 
-	mutex_lock(&hw_lock);
-	if (!hw->wed_dev) {
-		ret = -ENODEV;
+	if (!hw->wed_dev->wlan.offload_enable)
+		goto out;
+
+	if (hw->num_flows) {
+		hw->num_flows++;
 		goto out;
 	}
 
@@ -1744,14 +1745,15 @@ void mtk_wed_flow_remove(int index)
 {
 	struct mtk_wed_hw *hw = hw_list[index];
 
-	if (!hw)
-		return;
+	mutex_lock(&hw_lock);
 
-	if (--hw->num_flows)
-		return;
+	if (!hw || !hw->wed_dev)
+		goto out;
 
-	mutex_lock(&hw_lock);
-	if (!hw->wed_dev)
+	if (!hw->wed_dev->wlan.offload_disable)
+		goto out;
+
+	if (--hw->num_flows)
 		goto out;
 
 	hw->wed_dev->wlan.offload_disable(hw->wed_dev);
-- 
2.41.0


