Return-Path: <netdev+bounces-33868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C9387A082E
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5C1BAB20A12
	for <lists+netdev@lfdr.de>; Thu, 14 Sep 2023 14:58:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7522026299;
	Thu, 14 Sep 2023 14:40:08 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C56D26288;
	Thu, 14 Sep 2023 14:40:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 658D6C433B8;
	Thu, 14 Sep 2023 14:40:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1694702405;
	bh=uFy0yaIXeuU1WIHiqXjw8Vi32xgRKC9435bq8I2+iF0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=SXIcBOlrAXldRWLG6CkqIVCX4GvN14veWYaBfKe8QpwQbpCu54yffxtvNlL1V2iYA
	 JOu7CuVlqxLF9vHZFcHDZ/b9Vhg1WWjBOYJlgkZFtj8i+p/+J4MjCZO69/g9TWcwyH
	 CvF1pNmQpBaZvgnc8f19Z2goLMpGq7tLhkRTcvXObuSavC8Qvss+HlmjUqj7F3gtPw
	 qyfRdzJBIvkmdoaDtsjTUtx01w+t72yA1I1vkg9yZm/+LpUxovdeCr0LpTBIKfbTp8
	 aXijRLsNk8/0kdTibOuMdgLneCvv3o2ZjU1vQivZx9VQyJvj4j8VqfUgCovKuLFM0p
	 8FFlr4EZeVPpw==
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
	robh+dt@kernel.org,
	krzysztof.kozlowski+dt@linaro.org,
	devicetree@vger.kernel.org
Subject: [PATCH net-next 15/15] net: ethernet: mtk_wed: debugfs: add WED 3.0 debugfs entries
Date: Thu, 14 Sep 2023 16:38:20 +0200
Message-ID: <a387f20ea6032dd74165cdd830f7b945f9e093c7.1694701767.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <cover.1694701767.git.lorenzo@kernel.org>
References: <cover.1694701767.git.lorenzo@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sujuan Chen <sujuan.chen@mediatek.com>

Introduce WED3.0 debugfs entries useful for debugging.

Co-developed-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
---
 .../net/ethernet/mediatek/mtk_wed_debugfs.c   | 371 +++++++++++++++++-
 1 file changed, 369 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
index 8999d0c743f3..781c691473e1 100644
--- a/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
+++ b/drivers/net/ethernet/mediatek/mtk_wed_debugfs.c
@@ -11,6 +11,7 @@ struct reg_dump {
 	u16 offset;
 	u8 type;
 	u8 base;
+	u32 mask;
 };
 
 enum {
@@ -25,6 +26,8 @@ enum {
 
 #define DUMP_STR(_str) { _str, 0, DUMP_TYPE_STRING }
 #define DUMP_REG(_reg, ...) { #_reg, MTK_##_reg, __VA_ARGS__ }
+#define DUMP_REG_MASK(_reg, _mask)	\
+	{ #_mask, MTK_##_reg, DUMP_TYPE_WED, 0, MTK_##_mask }
 #define DUMP_RING(_prefix, _base, ...)				\
 	{ _prefix " BASE", _base, __VA_ARGS__ },		\
 	{ _prefix " CNT",  _base + 0x4, __VA_ARGS__ },	\
@@ -32,6 +35,7 @@ enum {
 	{ _prefix " DIDX", _base + 0xc, __VA_ARGS__ }
 
 #define DUMP_WED(_reg) DUMP_REG(_reg, DUMP_TYPE_WED)
+#define DUMP_WED_MASK(_reg, _mask) DUMP_REG_MASK(_reg, _mask)
 #define DUMP_WED_RING(_base) DUMP_RING(#_base, MTK_##_base, DUMP_TYPE_WED)
 
 #define DUMP_WDMA(_reg) DUMP_REG(_reg, DUMP_TYPE_WDMA)
@@ -212,18 +216,372 @@ wed_rxinfo_show(struct seq_file *s, void *data)
 		DUMP_WED(WED_RTQM_Q2B_MIB),
 		DUMP_WED(WED_RTQM_PFDBK_MIB),
 	};
+	static const struct reg_dump regs_wed_v3[] = {
+		DUMP_STR("WED RX RRO DATA"),
+		DUMP_WED_RING(WED_RRO_RX_D_RX(0)),
+		DUMP_WED_RING(WED_RRO_RX_D_RX(1)),
+
+		DUMP_STR("WED RX MSDU PAGE"),
+		DUMP_WED_RING(WED_RRO_MSDU_PG_CTRL0(0)),
+		DUMP_WED_RING(WED_RRO_MSDU_PG_CTRL0(1)),
+		DUMP_WED_RING(WED_RRO_MSDU_PG_CTRL0(2)),
+
+		DUMP_STR("WED RX IND CMD"),
+		DUMP_WED(WED_IND_CMD_RX_CTRL1),
+		DUMP_WED_MASK(WED_IND_CMD_RX_CTRL2, WED_IND_CMD_MAX_CNT),
+		DUMP_WED_MASK(WED_IND_CMD_RX_CTRL0, WED_IND_CMD_PROC_IDX),
+		DUMP_WED_MASK(RRO_IND_CMD_SIGNATURE, RRO_IND_CMD_DMA_IDX),
+		DUMP_WED_MASK(WED_IND_CMD_RX_CTRL0, WED_IND_CMD_MAGIC_CNT),
+		DUMP_WED_MASK(RRO_IND_CMD_SIGNATURE, RRO_IND_CMD_MAGIC_CNT),
+		DUMP_WED_MASK(WED_IND_CMD_RX_CTRL0,
+			      WED_IND_CMD_PREFETCH_FREE_CNT),
+		DUMP_WED_MASK(WED_RRO_CFG1, WED_RRO_CFG1_PARTICL_SE_ID),
+
+		DUMP_STR("WED ADDR ELEM"),
+		DUMP_WED(WED_ADDR_ELEM_CFG0),
+		DUMP_WED_MASK(WED_ADDR_ELEM_CFG1,
+			      WED_ADDR_ELEM_PREFETCH_FREE_CNT),
+
+		DUMP_STR("WED Route QM"),
+		DUMP_WED(WED_RTQM_ENQ_I2Q_DMAD_CNT),
+		DUMP_WED(WED_RTQM_ENQ_I2N_DMAD_CNT),
+		DUMP_WED(WED_RTQM_ENQ_I2Q_PKT_CNT),
+		DUMP_WED(WED_RTQM_ENQ_I2N_PKT_CNT),
+		DUMP_WED(WED_RTQM_ENQ_USED_ENTRY_CNT),
+		DUMP_WED(WED_RTQM_ENQ_ERR_CNT),
+
+		DUMP_WED(WED_RTQM_DEQ_DMAD_CNT),
+		DUMP_WED(WED_RTQM_DEQ_Q2I_DMAD_CNT),
+		DUMP_WED(WED_RTQM_DEQ_PKT_CNT),
+		DUMP_WED(WED_RTQM_DEQ_Q2I_PKT_CNT),
+		DUMP_WED(WED_RTQM_DEQ_USED_PFDBK_CNT),
+		DUMP_WED(WED_RTQM_DEQ_ERR_CNT),
+	};
 	struct mtk_wed_hw *hw = s->private;
 	struct mtk_wed_device *dev = hw->wed_dev;
 
 	if (dev) {
 		dump_wed_regs(s, dev, regs_common, ARRAY_SIZE(regs_common));
-		dump_wed_regs(s, dev, regs_wed_v2, ARRAY_SIZE(regs_wed_v2));
+		if (mtk_wed_is_v2(hw))
+			dump_wed_regs(s, dev,
+				      regs_wed_v2, ARRAY_SIZE(regs_wed_v2));
+		else
+			dump_wed_regs(s, dev,
+				      regs_wed_v3, ARRAY_SIZE(regs_wed_v3));
 	}
 
 	return 0;
 }
 DEFINE_SHOW_ATTRIBUTE(wed_rxinfo);
 
+static int
+wed_amsdu_show(struct seq_file *s, void *data)
+{
+	static const struct reg_dump regs[] = {
+		DUMP_STR("WED AMDSU INFO"),
+		DUMP_WED(WED_MON_AMSDU_FIFO_DMAD),
+
+		DUMP_STR("WED AMDSU ENG0 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(0)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(0)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(0)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(0)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(0)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(0),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(0),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(0),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(0),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(0),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG1 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(1)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(1)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(1)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(1)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(1)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(1),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(1),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(1),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG2 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(2)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(2)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(2)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(2)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(2)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(2),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(2),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(2),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG3 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(3)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(3)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(3)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(3)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(3)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(3),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(3),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(3),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(3),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(3),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG4 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(4)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(4)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(4)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(4)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(4)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(4),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(4),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(4),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(4),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(4),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG5 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(5)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(5)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(5)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(5)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(5)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(5),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(5),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(5),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(5),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(5),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG6 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(6)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(6)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(6)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(6)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(6)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(6),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(6),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(6),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(6),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(6),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG7 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(7)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(7)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(7)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(7)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(7)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(7),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(7),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(7),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(7),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(4),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED AMDSU ENG8 INFO"),
+		DUMP_WED(WED_MON_AMSDU_ENG_DMAD(8)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QFPL(8)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENI(8)),
+		DUMP_WED(WED_MON_AMSDU_ENG_QENO(8)),
+		DUMP_WED(WED_MON_AMSDU_ENG_MERG(8)),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(8),
+			      WED_AMSDU_ENG_MAX_PL_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT8(8),
+			      WED_AMSDU_ENG_MAX_QGPP_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(8),
+			      WED_AMSDU_ENG_CUR_ENTRY),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(8),
+			      WED_AMSDU_ENG_MAX_BUF_MERGED),
+		DUMP_WED_MASK(WED_MON_AMSDU_ENG_CNT9(8),
+			      WED_AMSDU_ENG_MAX_MSDU_MERGED),
+
+		DUMP_STR("WED QMEM INFO"),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(0), WED_AMSDU_QMEM_FQ_CNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(0), WED_AMSDU_QMEM_SP_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(1), WED_AMSDU_QMEM_TID0_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(1), WED_AMSDU_QMEM_TID1_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(2), WED_AMSDU_QMEM_TID2_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(2), WED_AMSDU_QMEM_TID3_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(3), WED_AMSDU_QMEM_TID4_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(3), WED_AMSDU_QMEM_TID5_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(4), WED_AMSDU_QMEM_TID6_QCNT),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_CNT(4), WED_AMSDU_QMEM_TID7_QCNT),
+
+		DUMP_STR("WED QMEM HEAD INFO"),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(0), WED_AMSDU_QMEM_FQ_HEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(0), WED_AMSDU_QMEM_SP_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(1), WED_AMSDU_QMEM_TID0_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(1), WED_AMSDU_QMEM_TID1_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(2), WED_AMSDU_QMEM_TID2_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(2), WED_AMSDU_QMEM_TID3_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(3), WED_AMSDU_QMEM_TID4_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(3), WED_AMSDU_QMEM_TID5_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(4), WED_AMSDU_QMEM_TID6_QHEAD),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(4), WED_AMSDU_QMEM_TID7_QHEAD),
+
+		DUMP_STR("WED QMEM TAIL INFO"),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(5), WED_AMSDU_QMEM_FQ_TAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(5), WED_AMSDU_QMEM_SP_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(6), WED_AMSDU_QMEM_TID0_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(6), WED_AMSDU_QMEM_TID1_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(7), WED_AMSDU_QMEM_TID2_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(7), WED_AMSDU_QMEM_TID3_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(8), WED_AMSDU_QMEM_TID4_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(8), WED_AMSDU_QMEM_TID5_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(9), WED_AMSDU_QMEM_TID6_QTAIL),
+		DUMP_WED_MASK(WED_MON_AMSDU_QMEM_PTR(9), WED_AMSDU_QMEM_TID7_QTAIL),
+
+		DUMP_STR("WED HIFTXD MSDU INFO"),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(1)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(2)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(3)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(4)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(5)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(6)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(7)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(8)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(9)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(10)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(11)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(12)),
+		DUMP_WED(WED_MON_AMSDU_HIFTXD_FETCH_MSDU(13)),
+	};
+	struct mtk_wed_hw *hw = s->private;
+	struct mtk_wed_device *dev = hw->wed_dev;
+
+	if (dev)
+		dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(wed_amsdu);
+
+static int
+wed_rtqm_show(struct seq_file *s, void *data)
+{
+	static const struct reg_dump regs[] = {
+		DUMP_STR("WED Route QM IGRS0(N2H + Recycle)"),
+		DUMP_WED(WED_RTQM_IGRS0_I2HW_DMAD_CNT),
+		DUMP_WED(WED_RTQM_IGRS0_I2H_DMAD_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS0_I2H_DMAD_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS0_I2HW_PKT_CNT),
+		DUMP_WED(WED_RTQM_IGRS0_I2H_PKT_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS0_I2H_PKT_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS0_FDROP_CNT),
+
+		DUMP_STR("WED Route QM IGRS1(Legacy)"),
+		DUMP_WED(WED_RTQM_IGRS1_I2HW_DMAD_CNT),
+		DUMP_WED(WED_RTQM_IGRS1_I2H_DMAD_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS1_I2H_DMAD_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS1_I2HW_PKT_CNT),
+		DUMP_WED(WED_RTQM_IGRS1_I2H_PKT_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS1_I2H_PKT_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS1_FDROP_CNT),
+
+		DUMP_STR("WED Route QM IGRS2(RRO3.0)"),
+		DUMP_WED(WED_RTQM_IGRS2_I2HW_DMAD_CNT),
+		DUMP_WED(WED_RTQM_IGRS2_I2H_DMAD_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS2_I2H_DMAD_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS2_I2HW_PKT_CNT),
+		DUMP_WED(WED_RTQM_IGRS2_I2H_PKT_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS2_I2H_PKT_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS2_FDROP_CNT),
+
+		DUMP_STR("WED Route QM IGRS3(DEBUG)"),
+		DUMP_WED(WED_RTQM_IGRS2_I2HW_DMAD_CNT),
+		DUMP_WED(WED_RTQM_IGRS3_I2H_DMAD_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS3_I2H_DMAD_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS3_I2HW_PKT_CNT),
+		DUMP_WED(WED_RTQM_IGRS3_I2H_PKT_CNT(0)),
+		DUMP_WED(WED_RTQM_IGRS3_I2H_PKT_CNT(1)),
+		DUMP_WED(WED_RTQM_IGRS3_FDROP_CNT),
+	};
+	struct mtk_wed_hw *hw = s->private;
+	struct mtk_wed_device *dev = hw->wed_dev;
+
+	if (dev)
+		dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(wed_rtqm);
+
+static int
+wed_rro_show(struct seq_file *s, void *data)
+{
+	static const struct reg_dump regs[] = {
+		DUMP_STR("RRO/IND CMD CNT"),
+		DUMP_WED(WED_RX_IND_CMD_CNT(1)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(2)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(3)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(4)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(5)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(6)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(7)),
+		DUMP_WED(WED_RX_IND_CMD_CNT(8)),
+		DUMP_WED_MASK(WED_RX_IND_CMD_CNT(9),
+			      WED_IND_CMD_MAGIC_CNT_FAIL_CNT),
+
+		DUMP_WED(WED_RX_ADDR_ELEM_CNT(0)),
+		DUMP_WED_MASK(WED_RX_ADDR_ELEM_CNT(1),
+			      WED_ADDR_ELEM_SIG_FAIL_CNT),
+		DUMP_WED(WED_RX_MSDU_PG_CNT(1)),
+		DUMP_WED(WED_RX_MSDU_PG_CNT(2)),
+		DUMP_WED(WED_RX_MSDU_PG_CNT(3)),
+		DUMP_WED(WED_RX_MSDU_PG_CNT(4)),
+		DUMP_WED(WED_RX_MSDU_PG_CNT(5)),
+		DUMP_WED_MASK(WED_RX_PN_CHK_CNT,
+			      WED_PN_CHK_FAIL_CNT),
+	};
+	struct mtk_wed_hw *hw = s->private;
+	struct mtk_wed_device *dev = hw->wed_dev;
+
+	if (dev)
+		dump_wed_regs(s, dev, regs, ARRAY_SIZE(regs));
+
+	return 0;
+}
+DEFINE_SHOW_ATTRIBUTE(wed_rro);
+
 static int
 mtk_wed_reg_set(void *data, u64 val)
 {
@@ -264,7 +622,16 @@ void mtk_wed_hw_add_debugfs(struct mtk_wed_hw *hw)
 	debugfs_create_u32("regidx", 0600, dir, &hw->debugfs_reg);
 	debugfs_create_file_unsafe("regval", 0600, dir, hw, &fops_regval);
 	debugfs_create_file_unsafe("txinfo", 0400, dir, hw, &wed_txinfo_fops);
-	if (!mtk_wed_is_v1(hw))
+	if (!mtk_wed_is_v1(hw)) {
 		debugfs_create_file_unsafe("rxinfo", 0400, dir, hw,
 					   &wed_rxinfo_fops);
+		if (mtk_wed_is_v3_or_greater(hw)) {
+			debugfs_create_file_unsafe("amsdu", 0400, dir, hw,
+						   &wed_amsdu_fops);
+			debugfs_create_file_unsafe("rtqm", 0400, dir, hw,
+						   &wed_rtqm_fops);
+			debugfs_create_file_unsafe("rro", 0400, dir, hw,
+						   &wed_rro_fops);
+		}
+	}
 }
-- 
2.41.0


