Return-Path: <netdev+bounces-34522-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 601047A4746
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 12:38:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E72E282DC4
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 10:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F81120B0B;
	Mon, 18 Sep 2023 10:30:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7130FA2;
	Mon, 18 Sep 2023 10:30:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F9CDC433C8;
	Mon, 18 Sep 2023 10:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695033050;
	bh=H1Y7Lku2iwyhO5rgpqu7MyjoFTetMe1zN/nVR4VhRB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rrXbkBBqXY1URyvMvkAMSqiRQfDXOzp6R0p4nvXl0xhCL0hj4nDjyyUyhjq6ZNUnx
	 h728rD3T3llJ1lH75pxQgLhBTMnIj4gyaUhELluhVo297Ytpzil7XpjtkYwg3SROtO
	 B811j/34LlhaOEwNM59Ee7Qib+VIc9usLa3lttuQubb9iIlpxdacpj5EKestv6di9Z
	 YOFnkCG5QiODlIKb/dTtZLkq0CpzXtCuFljHsXaE2PWGq+o5MnRkf9E8mQXTzgRBM6
	 sEVTqUKeM1k3plISkk4nDjLS+KDw1uz0wGDrofD20ELte9IHEHPQkZ4hxpyUJqKWgr
	 aYCr2LZn7Vaww==
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
	daniel@makrotopia.org,
	linux-mediatek@lists.infradead.org,
	sujuan.chen@mediatek.com,
	horms@kernel.org,
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 net-next 15/17] net: ethernet: mtk_wed: debugfs: move wed_v2 specific regs out of regs array
Date: Mon, 18 Sep 2023 12:29:17 +0200
Message-ID: <8573eee3b97741a942a554786c3d3f830b629571.1695032291.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1695032290.git.lorenzo@kernel.org>
References: <cover.1695032290.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move specific WED2.0 debugfs entries out of regs array. This is a
preliminary patch to introduce WED 3.0 debugfs info.

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   | 33 ++++++++++---------
 1 file changed, 18 insertions(+), 15 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
index 674e919d0d3a..8999d0c743f3 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -151,7 +151,7 @@ DEFINE_SHOW_ATTRIBUTE(wed_txinfo);
 static int
 wed_rxinfo_show(struct seq_file *s, void *data)
 {
-	static const struct reg_dump regs[] = {
+	static const struct reg_dump regs_common[] = {
 		DUMP_STR("WPDMA RX"),
 		DUMP_WPDMA_RX_RING(0),
 		DUMP_WPDMA_RX_RING(1),
@@ -169,7 +169,7 @@ wed_rxinfo_show(struct seq_file *s, void *data)
 		DUMP_WED_RING(WED_RING_RX_DATA(0)),
 		DUMP_WED_RING(WED_RING_RX_DATA(1)),
 
-		DUMP_STR("WED RRO"),
+		DUMP_STR("WED WO RRO"),
 		DUMP_WED_RRO_RING(WED_RROQM_MIOD_CTRL0),
 		DUMP_WED(WED_RROQM_MID_MIB),
 		DUMP_WED(WED_RROQM_MOD_MIB),
@@ -180,17 +180,6 @@ wed_rxinfo_show(struct seq_file *s, void *data)
 		DUMP_WED(WED_RROQM_FDBK_ANC_MIB),
 		DUMP_WED(WED_RROQM_FDBK_ANC2H_MIB),
 
-		DUMP_STR("WED Route QM"),
-		DUMP_WED(WED_RTQM_R2H_MIB(0)),
-		DUMP_WED(WED_RTQM_R2Q_MIB(0)),
-		DUMP_WED(WED_RTQM_Q2H_MIB(0)),
-		DUMP_WED(WED_RTQM_R2H_MIB(1)),
-		DUMP_WED(WED_RTQM_R2Q_MIB(1)),
-		DUMP_WED(WED_RTQM_Q2H_MIB(1)),
-		DUMP_WED(WED_RTQM_Q2N_MIB),
-		DUMP_WED(WED_RTQM_Q2B_MIB),
-		DUMP_WED(WED_RTQM_PFDBK_MIB),
-
 		DUMP_STR("WED WDMA TX"),
 		DUMP_WED(WED_WDMA_TX_MIB),
 		DUMP_WED_RING(WED_WDMA_RING_TX),
@@ -211,11 +200,25 @@ wed_rxinfo_show(struct seq_file *s, void *data)
 		DUMP_WED(WED_RX_BM_INTF),
 		DUMP_WED(WED_RX_BM_ERR_STS),
 	};
+	static const struct reg_dump regs_wed_v2[] = {
+		DUMP_STR("WED Route QM"),
+		DUMP_WED(WED_RTQM_R2H_MIB(0)),
+		DUMP_WED(WED_RTQM_R2Q_MIB(0)),
+		DUMP_WED(WED_RTQM_Q2H_MIB(0)),
+		DUMP_WED(WED_RTQM_R2H_MIB(1)),
+		DUMP_WED(WED_RTQM_R2Q_MIB(1)),
+		DUMP_WED(WED_RTQM_Q2H_MIB(1)),
+		DUMP_WED(WED_RTQM_Q2N_MIB),
+		DUMP_WED(WED_RTQM_Q2B_MIB),
+		DUMP_WED(WED_RTQM_PFDBK_MIB),
+	};
 	struct mtk_wed_hw *hw = s->private;
 	struct mtk_wed_device *dev = hw->wed_dev;
 
-	if (dev)
-		dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+	if (dev) {
+		dump_wed_regs(s, dev, regs_common, ARRAY_SIZE(regs_common));
+		dump_wed_regs(s, dev, regs_wed_v2, ARRAY_SIZE(regs_wed_v2));
+	}
 
 	return 0;
 }
-- 
2.41.0


