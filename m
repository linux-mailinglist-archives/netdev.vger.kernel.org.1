Return-Path: <netdev+bounces-218194-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7C03B3B71E
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 11:22:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBC69580453
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 09:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF003081BD;
	Fri, 29 Aug 2025 09:21:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UY6NRDGR"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BBCF30505B;
	Fri, 29 Aug 2025 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756459268; cv=none; b=b7q6dkG99dWvoswx2xmx10nY/x+mqR2EDAfeojjBiNslVbYwHZGSYDH4GByY3z59R/LtAyMSs1bL8VIs3tgkNSm/FvPxGbmcL4dXQIukKnVtJTtIx8RztkxeWz+jh8Bwz1NvHO48ou+kd4fEX/uitZOCeWn1L24XTqbH02IDqpA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756459268; c=relaxed/simple;
	bh=2+Kmg7VA1dXJ/AtLWsgBGePSqntWk4nm68tSfAz+t2E=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GWz1zHITrk1L6ZR1AklY06siwO92YuBY19aZS9eQNBIFaRjvlOpgrm2+VAz63WN4VZw2Dx3bBk+oBaETRW5aNMu/OF9SAII6xTk1JixNjvUQZD61NK1VBjD3coHnsgCrasbPyAJD9DLNCb9Oi2lQSw+SA5/5NwpvORnnoTLbHEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UY6NRDGR; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1756459260;
	bh=2+Kmg7VA1dXJ/AtLWsgBGePSqntWk4nm68tSfAz+t2E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UY6NRDGRCzSdNLtF5HBi0dLt1Z6dxkqr+5Ule1UAbRzswuxcRK/Vjog3nO6pP/iLi
	 Vp50DI5QMLooPbxRRcHiZlGwiIP06Kg7Zm9CibmW2J4yEzXz6gDQNgDLMWuRlsg1a9
	 vLsdpv2EXBP2dYc/1/UOVOH7cvMijWk+NiSgO/aJNFy+0Kso6XkYoulgdtZEI0AP7K
	 LOHrOsnloGSlFY4L4ss+A2gFC4Ar0ts30bD+o4isPsqBPEY9FeNFKd+9qOkVJtK+YM
	 ZOw6tvRnTuKSUIwUIT5Hdue/EEvMXppa88cWLV1qFMNSiJ5JBcx4vuvcz5D/DQwpIl
	 2ymngBlfBLVjA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:f5b1:db54:a11a:c333])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91DA017E12B9;
	Fri, 29 Aug 2025 11:20:59 +0200 (CEST)
From: Laura Nao <laura.nao@collabora.com>
To: mturquette@baylibre.com,
	sboyd@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	matthias.bgg@gmail.com,
	angelogioacchino.delregno@collabora.com,
	p.zabel@pengutronix.de,
	richardcochran@gmail.com
Cc: guangjie.song@mediatek.com,
	wenst@chromium.org,
	linux-clk@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-mediatek@lists.infradead.org,
	netdev@vger.kernel.org,
	kernel@collabora.com,
	Laura Nao <laura.nao@collabora.com>,
	=?UTF-8?q?N=C3=ADcolas=20F=20=2E=20R=20=2E=20A=20=2E=20Prado?= <nfraprado@collabora.com>
Subject: [PATCH v5 05/27] clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
Date: Fri, 29 Aug 2025 11:18:51 +0200
Message-Id: <20250829091913.131528-6-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250829091913.131528-1-laura.nao@collabora.com>
References: <20250829091913.131528-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

MT8196 use a HW voter for mux gate enable/disable control, along with a
FENC status bit to check the status. Voting is performed using
set/clr/upd registers, with a status bit used to verify the vote state.
Add new set of mux gate clock operations with support for voting via
set/clr/upd regs and FENC status logic.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.h |  2 +
 drivers/clk/mediatek/clk-mux.c | 73 +++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-mux.h | 42 +++++++++++++++++++
 3 files changed, 116 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 11962fac43ea..c381d6a6d908 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -20,6 +20,8 @@
 
 #define MHZ (1000 * 1000)
 
+#define MTK_WAIT_HWV_DONE_US	30
+
 struct platform_device;
 
 /*
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 3931d157b262..2c2679e158e7 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -8,6 +8,7 @@
 #include <linux/clk-provider.h>
 #include <linux/compiler_types.h>
 #include <linux/container_of.h>
+#include <linux/dev_printk.h>
 #include <linux/err.h>
 #include <linux/mfd/syscon.h>
 #include <linux/module.h>
@@ -15,6 +16,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
+#include "clk-mtk.h"
 #include "clk-mux.h"
 
 #define MTK_WAIT_FENC_DONE_US	30
@@ -22,6 +24,7 @@
 struct mtk_clk_mux {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct regmap *regmap_hwv;
 	const struct mtk_mux *data;
 	spinlock_t *lock;
 	bool reparent;
@@ -119,6 +122,41 @@ static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
 	return (val & BIT(mux->data->gate_shift)) == 0;
 }
 
+static int mtk_clk_mux_hwv_fenc_enable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+	int ret;
+
+	regmap_write(mux->regmap_hwv, mux->data->hwv_set_ofs,
+		     BIT(mux->data->gate_shift));
+
+	ret = regmap_read_poll_timeout_atomic(mux->regmap_hwv, mux->data->hwv_sta_ofs,
+					      val, val & BIT(mux->data->gate_shift), 0,
+					      MTK_WAIT_HWV_DONE_US);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout_atomic(mux->regmap, mux->data->fenc_sta_mon_ofs,
+					      val, val & BIT(mux->data->fenc_shift), 1,
+					      MTK_WAIT_FENC_DONE_US);
+
+	return ret;
+}
+
+static void mtk_clk_mux_hwv_disable(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+
+	regmap_write(mux->regmap_hwv, mux->data->hwv_clr_ofs,
+		     BIT(mux->data->gate_shift));
+
+	regmap_read_poll_timeout_atomic(mux->regmap_hwv, mux->data->hwv_sta_ofs,
+					val, (val & BIT(mux->data->gate_shift)),
+					0, MTK_WAIT_HWV_DONE_US);
+}
+
 static u8 mtk_clk_mux_get_parent(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
@@ -190,6 +228,14 @@ static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
 	return clk_mux_determine_rate_flags(hw, req, mux->data->flags);
 }
 
+static bool mtk_clk_mux_uses_hwv(const struct clk_ops *ops)
+{
+	if (ops == &mtk_mux_gate_hwv_fenc_clr_set_upd_ops)
+		return true;
+
+	return false;
+}
+
 const struct clk_ops mtk_mux_clr_set_upd_ops = {
 	.get_parent = mtk_clk_mux_get_parent,
 	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
@@ -217,9 +263,20 @@ const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops = {
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_fenc_clr_set_upd_ops);
 
+const struct clk_ops mtk_mux_gate_hwv_fenc_clr_set_upd_ops = {
+	.enable = mtk_clk_mux_hwv_fenc_enable,
+	.disable = mtk_clk_mux_hwv_disable,
+	.is_enabled = mtk_clk_mux_fenc_is_enabled,
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+	.determine_rate = mtk_clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(mtk_mux_gate_hwv_fenc_clr_set_upd_ops);
+
 static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 					   const struct mtk_mux *mux,
 					   struct regmap *regmap,
+					   struct regmap *regmap_hwv,
 					   spinlock_t *lock)
 {
 	struct mtk_clk_mux *clk_mux;
@@ -235,8 +292,14 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 	init.parent_names = mux->parent_names;
 	init.num_parents = mux->num_parents;
 	init.ops = mux->ops;
+	if (mtk_clk_mux_uses_hwv(init.ops) && !regmap_hwv) {
+		return dev_err_ptr_probe(
+			dev, -ENXIO,
+			"regmap not found for hardware voter clocks\n");
+	}
 
 	clk_mux->regmap = regmap;
+	clk_mux->regmap_hwv = regmap_hwv;
 	clk_mux->data = mux;
 	clk_mux->lock = lock;
 	clk_mux->hw.init = &init;
@@ -269,6 +332,7 @@ int mtk_clk_register_muxes(struct device *dev,
 			   struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *regmap;
+	struct regmap *regmap_hwv;
 	struct clk_hw *hw;
 	int i;
 
@@ -278,6 +342,13 @@ int mtk_clk_register_muxes(struct device *dev,
 		return PTR_ERR(regmap);
 	}
 
+	regmap_hwv = mtk_clk_get_hwv_regmap(node);
+	if (IS_ERR(regmap_hwv)) {
+		return dev_err_probe(
+			dev, PTR_ERR(regmap_hwv),
+			"Cannot find hardware voter regmap for %pOF\n", node);
+	}
+
 	for (i = 0; i < num; i++) {
 		const struct mtk_mux *mux = &muxes[i];
 
@@ -287,7 +358,7 @@ int mtk_clk_register_muxes(struct device *dev,
 			continue;
 		}
 
-		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
+		hw = mtk_clk_register_mux(dev, mux, regmap, regmap_hwv, lock);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index a4fd17a18532..151e56dcf884 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -28,6 +28,10 @@ struct mtk_mux {
 	u32 set_ofs;
 	u32 clr_ofs;
 	u32 upd_ofs;
+
+	u32 hwv_set_ofs;
+	u32 hwv_clr_ofs;
+	u32 hwv_sta_ofs;
 	u32 fenc_sta_mon_ofs;
 
 	u8 mux_shift;
@@ -80,6 +84,7 @@ struct mtk_mux {
 extern const struct clk_ops mtk_mux_clr_set_upd_ops;
 extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 extern const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops;
+extern const struct clk_ops mtk_mux_gate_hwv_fenc_clr_set_upd_ops;
 
 #define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
 			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
@@ -121,6 +126,43 @@ extern const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops;
 			0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,		\
 			mtk_mux_clr_set_upd_ops)
 
+#define MUX_GATE_HWV_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,			\
+				_mux_ofs, _mux_set_ofs, _mux_clr_ofs,			\
+				_hwv_sta_ofs, _hwv_set_ofs, _hwv_clr_ofs,		\
+				_shift, _width, _gate, _upd_ofs, _upd,			\
+				_fenc_sta_mon_ofs, _fenc, _flags) {			\
+			.id = _id,							\
+			.name = _name,							\
+			.mux_ofs = _mux_ofs,						\
+			.set_ofs = _mux_set_ofs,					\
+			.clr_ofs = _mux_clr_ofs,					\
+			.hwv_sta_ofs = _hwv_sta_ofs,					\
+			.hwv_set_ofs = _hwv_set_ofs,					\
+			.hwv_clr_ofs = _hwv_clr_ofs,					\
+			.upd_ofs = _upd_ofs,						\
+			.fenc_sta_mon_ofs = _fenc_sta_mon_ofs,				\
+			.mux_shift = _shift,						\
+			.mux_width = _width,						\
+			.gate_shift = _gate,						\
+			.upd_shift = _upd,						\
+			.fenc_shift = _fenc,						\
+			.parent_names = _parents,					\
+			.num_parents = ARRAY_SIZE(_parents),				\
+			.flags =  _flags,						\
+			.ops = &mtk_mux_gate_hwv_fenc_clr_set_upd_ops,			\
+		}
+
+#define MUX_GATE_HWV_FENC_CLR_SET_UPD(_id, _name, _parents,				\
+				_mux_ofs, _mux_set_ofs, _mux_clr_ofs,			\
+				_hwv_sta_ofs, _hwv_set_ofs, _hwv_clr_ofs,		\
+				_shift, _width, _gate, _upd_ofs, _upd,			\
+				_fenc_sta_mon_ofs, _fenc)				\
+			MUX_GATE_HWV_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,	\
+				_mux_ofs, _mux_set_ofs, _mux_clr_ofs,			\
+				_hwv_sta_ofs, _hwv_set_ofs, _hwv_clr_ofs,		\
+				_shift, _width, _gate, _upd_ofs, _upd,			\
+				_fenc_sta_mon_ofs, _fenc, 0)
+
 #define MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents, _paridx,		\
 			_num_parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,	\
 			_shift, _width, _gate, _upd_ofs, _upd,			\
-- 
2.39.5


