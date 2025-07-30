Return-Path: <netdev+bounces-210953-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C0E2B15EA5
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4817018C455F
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 10:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E9182989BD;
	Wed, 30 Jul 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="TSr91ChH"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D95642951C8;
	Wed, 30 Jul 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873100; cv=none; b=RyJcSkmKdQyYoJY7ClxXfprMlDkQu7aoajkYVK7ICESNPrQY+6R9RmzxK32jYpa9nuxB7cqoxRazYpTDjslp7kkAyTQZXpmBws4z+Z9UTNTyx7a1F9ZGLqcCBKojKAx0f5VqJNlZNpffdiPV52Yhd9L1qt+pWI6SdcwiqLwEAfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873100; c=relaxed/simple;
	bh=MtvAWY4edAUWDIjpLH4PcDFwr3aPXMmt4ioFbsIgduI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XJYqe3DmVTo1553/SDv99LCKB2CZKruMVozykyPqHu5NOsbG8LILO81LrCa9UVnRRn+0nMmA47W15HiK83/WVGL9gstzZe8gjVp4FybCMf1CoRADlAUWITcjL0n57w+tG0qgSWxELVqv0BJ5Vqu31xB9pmnWoCKR18NcL/ArBMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=TSr91ChH; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873093;
	bh=MtvAWY4edAUWDIjpLH4PcDFwr3aPXMmt4ioFbsIgduI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TSr91ChHKT4S7Jok1ey2x0ubOhtMtODaO7px6DCOYYZObEjzQvt65GZh/3YMWxmFO
	 jeJyIlCYAnLJhg6TeBA/iFX3ygHzF7usmEdnfWuLorsFnlDOtjpivgE3tVIoGnr8D5
	 5b2tbjzK7+f/PQ5IsTbnSXB0XIZN03d9uDanD+yeOfXTVVzmAa2mOmj63akPWQSU2f
	 kQNM5TdaW3t59QPAVbbV6rLIcLi6SyVHvHsDhIxaaoMl94qlhe2uI3iCAYef8x5EKw
	 2V88OG2WfavmU995XgBLfoUTqO87syLfR3ROBFQdpEVHxt2zOz19ro0SaJnDTA5JYv
	 A90rWiVk2QFCA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 91B6F17E15A8;
	Wed, 30 Jul 2025 12:58:11 +0200 (CEST)
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
Subject: [PATCH v3 05/27] clk: mediatek: clk-mux: Add ops for mux gates with HW voter and FENC
Date: Wed, 30 Jul 2025 12:56:31 +0200
Message-Id: <20250730105653.64910-6-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250730105653.64910-1-laura.nao@collabora.com>
References: <20250730105653.64910-1-laura.nao@collabora.com>
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
 drivers/clk/mediatek/clk-mtk.h |  1 +
 drivers/clk/mediatek/clk-mux.c | 71 +++++++++++++++++++++++++++++++++-
 drivers/clk/mediatek/clk-mux.h | 42 ++++++++++++++++++++
 3 files changed, 113 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index 8ed2c9208b1f..e2cefd9bc5b8 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -20,6 +20,7 @@
 
 #define MHZ (1000 * 1000)
 
+#define MTK_WAIT_HWV_DONE_US	30
 #define MTK_WAIT_FENC_DONE_US	30
 
 struct platform_device;
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index b1b8eeb0b501..65889fc6a3e5 100644
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
@@ -21,6 +22,7 @@
 struct mtk_clk_mux {
 	struct clk_hw hw;
 	struct regmap *regmap;
+	struct regmap *regmap_hwv;
 	const struct mtk_mux *data;
 	spinlock_t *lock;
 	bool reparent;
@@ -118,6 +120,41 @@ static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
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
@@ -189,6 +226,14 @@ static int mtk_clk_mux_determine_rate(struct clk_hw *hw,
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
@@ -216,9 +261,20 @@ const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops = {
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
@@ -234,8 +290,13 @@ static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 	init.parent_names = mux->parent_names;
 	init.num_parents = mux->num_parents;
 	init.ops = mux->ops;
+	if (mtk_clk_mux_uses_hwv(init.ops) && !regmap_hwv) {
+		dev_err(dev, "regmap not found for hardware voter clocks\n");
+		return ERR_PTR(-ENXIO);
+	}
 
 	clk_mux->regmap = regmap;
+	clk_mux->regmap_hwv = regmap_hwv;
 	clk_mux->data = mux;
 	clk_mux->lock = lock;
 	clk_mux->hw.init = &init;
@@ -268,6 +329,7 @@ int mtk_clk_register_muxes(struct device *dev,
 			   struct clk_hw_onecell_data *clk_data)
 {
 	struct regmap *regmap;
+	struct regmap *regmap_hwv;
 	struct clk_hw *hw;
 	int i;
 
@@ -277,6 +339,13 @@ int mtk_clk_register_muxes(struct device *dev,
 		return PTR_ERR(regmap);
 	}
 
+	regmap_hwv = mtk_clk_get_hwv_regmap(node);
+	if (IS_ERR(regmap_hwv)) {
+		pr_err("Cannot find hardware voter regmap for %pOF: %pe\n",
+		       node, regmap_hwv);
+		return PTR_ERR(regmap_hwv);
+	}
+
 	for (i = 0; i < num; i++) {
 		const struct mtk_mux *mux = &muxes[i];
 
@@ -286,7 +355,7 @@ int mtk_clk_register_muxes(struct device *dev,
 			continue;
 		}
 
-		hw = mtk_clk_register_mux(dev, mux, regmap, lock);
+		hw = mtk_clk_register_mux(dev, mux, regmap, regmap_hwv, lock);
 
 		if (IS_ERR(hw)) {
 			pr_err("Failed to register clk %s: %pe\n", mux->name,
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index c65cfb7f8fc3..fb6f7951379c 100644
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


