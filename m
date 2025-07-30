Return-Path: <netdev+bounces-210952-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AD93FB15E9E
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 12:59:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEEE316381D
	for <lists+netdev@lfdr.de>; Wed, 30 Jul 2025 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23BB4298994;
	Wed, 30 Jul 2025 10:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="UBgyxX/q"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6AC22951BA;
	Wed, 30 Jul 2025 10:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753873100; cv=none; b=lYMf10JC1aXAwFUcJxY+rn0qhvEeIJ558U8Yh1qvGDBkd5PIdWk/JerlhEgpBJvzkU2OcjapaUBjdgVFRbGsx9pNLmkGKx2Ofy4J8IScUJIDt8Cq7zeMekN+vur1lR9evy4USe4yJXLF1eAhadI5e+vl6VxZnDpvw5oTioPE4e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753873100; c=relaxed/simple;
	bh=0RRgsriRgSJbDdxDIHJ9I4gjIthbJlbk2t5LFSR7Bik=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dFqv3IBwtGpK84zTfeGmkO1nc6hOY7z2jgz+Yn9WT4saHtc3764Hoh1W9Ma7PjU/O0ETDgLj4V/Se5FncI3OI4+miyYI6ikMD3FSAQg5o1S3xEoP5Pws8ZqR8J70uFFpUaN6hB5pOegSoRIadXFBNVJVXOCBat5NuPoLNvOx52I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=UBgyxX/q; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1753873090;
	bh=0RRgsriRgSJbDdxDIHJ9I4gjIthbJlbk2t5LFSR7Bik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=UBgyxX/q61xgf08IDzfe4TBislZUtVaNnafhUcgY1Nt8x4R7B5szWYXodmVUcfJPO
	 QMb2TyJLq7lVDcAAsupIJjX4Rh2afDucc1++1Hw8IPGLi0bJzRbO3RdMXPyxucBcqY
	 oonA4W4he3X0B7WfzwL+pXJpekcfK21JRkEU6KjDjtiIqf2rbV/S0FN0tVQ7du82aA
	 4vdXx4x3itczjX8oagXHNZfXKOw99s+F+IY3WByct7eM/5mcjS7JbRM2fC83BriOfG
	 VpbeH2c6kHcvuUN1FjJ6WUuJHm0xw2LJrtu2DGp2dO8xXEJFGruf3rAulaNeKrdPP+
	 JHweCsXEisBQg==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:4db2:e926:c82d:3276])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id DFD8C17E1511;
	Wed, 30 Jul 2025 12:58:08 +0200 (CEST)
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
Subject: [PATCH v3 03/27] clk: mediatek: clk-mux: Add ops for mux gates with set/clr/upd and FENC
Date: Wed, 30 Jul 2025 12:56:29 +0200
Message-Id: <20250730105653.64910-4-laura.nao@collabora.com>
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

MT8196 uses set/clr/upd registers for mux gate enable/disable control,
along with a FENC bit to check the status. Add new set of mux gate
clock operations with support for set/clr/upd and FENC status logic.

Reviewed-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 drivers/clk/mediatek/clk-mtk.h |  2 ++
 drivers/clk/mediatek/clk-mux.c | 48 ++++++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-mux.h | 45 +++++++++++++++++++++++++++++++
 3 files changed, 95 insertions(+)

diff --git a/drivers/clk/mediatek/clk-mtk.h b/drivers/clk/mediatek/clk-mtk.h
index c17fe1c2d732..136a4bc6dbe6 100644
--- a/drivers/clk/mediatek/clk-mtk.h
+++ b/drivers/clk/mediatek/clk-mtk.h
@@ -20,6 +20,8 @@
 
 #define MHZ (1000 * 1000)
 
+#define MTK_WAIT_FENC_DONE_US	30
+
 struct platform_device;
 
 /*
diff --git a/drivers/clk/mediatek/clk-mux.c b/drivers/clk/mediatek/clk-mux.c
index 60990296450b..b1b8eeb0b501 100644
--- a/drivers/clk/mediatek/clk-mux.c
+++ b/drivers/clk/mediatek/clk-mux.c
@@ -15,6 +15,7 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 
+#include "clk-mtk.h"
 #include "clk-mux.h"
 
 struct mtk_clk_mux {
@@ -30,6 +31,33 @@ static inline struct mtk_clk_mux *to_mtk_clk_mux(struct clk_hw *hw)
 	return container_of(hw, struct mtk_clk_mux, hw);
 }
 
+static int mtk_clk_mux_fenc_enable_setclr(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	unsigned long flags;
+	u32 val;
+	int ret;
+
+	if (mux->lock)
+		spin_lock_irqsave(mux->lock, flags);
+	else
+		__acquire(mux->lock);
+
+	regmap_write(mux->regmap, mux->data->clr_ofs,
+		     BIT(mux->data->gate_shift));
+
+	ret = regmap_read_poll_timeout_atomic(mux->regmap, mux->data->fenc_sta_mon_ofs,
+					      val, val & BIT(mux->data->fenc_shift), 1,
+					      MTK_WAIT_FENC_DONE_US);
+
+	if (mux->lock)
+		spin_unlock_irqrestore(mux->lock, flags);
+	else
+		__release(mux->lock);
+
+	return ret;
+}
+
 static int mtk_clk_mux_enable_setclr(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
@@ -70,6 +98,16 @@ static void mtk_clk_mux_disable_setclr(struct clk_hw *hw)
 			BIT(mux->data->gate_shift));
 }
 
+static int mtk_clk_mux_fenc_is_enabled(struct clk_hw *hw)
+{
+	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
+	u32 val;
+
+	regmap_read(mux->regmap, mux->data->fenc_sta_mon_ofs, &val);
+
+	return val & BIT(mux->data->fenc_shift);
+}
+
 static int mtk_clk_mux_is_enabled(struct clk_hw *hw)
 {
 	struct mtk_clk_mux *mux = to_mtk_clk_mux(hw);
@@ -168,6 +206,16 @@ const struct clk_ops mtk_mux_gate_clr_set_upd_ops  = {
 };
 EXPORT_SYMBOL_GPL(mtk_mux_gate_clr_set_upd_ops);
 
+const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops = {
+	.enable = mtk_clk_mux_fenc_enable_setclr,
+	.disable = mtk_clk_mux_disable_setclr,
+	.is_enabled = mtk_clk_mux_fenc_is_enabled,
+	.get_parent = mtk_clk_mux_get_parent,
+	.set_parent = mtk_clk_mux_set_parent_setclr_lock,
+	.determine_rate = mtk_clk_mux_determine_rate,
+};
+EXPORT_SYMBOL_GPL(mtk_mux_gate_fenc_clr_set_upd_ops);
+
 static struct clk_hw *mtk_clk_register_mux(struct device *dev,
 					   const struct mtk_mux *mux,
 					   struct regmap *regmap,
diff --git a/drivers/clk/mediatek/clk-mux.h b/drivers/clk/mediatek/clk-mux.h
index 943ad1d7ce4b..c65cfb7f8fc3 100644
--- a/drivers/clk/mediatek/clk-mux.h
+++ b/drivers/clk/mediatek/clk-mux.h
@@ -28,11 +28,13 @@ struct mtk_mux {
 	u32 set_ofs;
 	u32 clr_ofs;
 	u32 upd_ofs;
+	u32 fenc_sta_mon_ofs;
 
 	u8 mux_shift;
 	u8 mux_width;
 	u8 gate_shift;
 	s8 upd_shift;
+	u8 fenc_shift;
 
 	const struct clk_ops *ops;
 	signed char num_parents;
@@ -77,6 +79,7 @@ struct mtk_mux {
 
 extern const struct clk_ops mtk_mux_clr_set_upd_ops;
 extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
+extern const struct clk_ops mtk_mux_gate_fenc_clr_set_upd_ops;
 
 #define MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
 			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
@@ -118,6 +121,48 @@ extern const struct clk_ops mtk_mux_gate_clr_set_upd_ops;
 			0, _upd_ofs, _upd, CLK_SET_RATE_PARENT,		\
 			mtk_mux_clr_set_upd_ops)
 
+#define MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents, _paridx,		\
+			_num_parents, _mux_ofs, _mux_set_ofs, _mux_clr_ofs,	\
+			_shift, _width, _gate, _upd_ofs, _upd,			\
+			_fenc_sta_mon_ofs, _fenc, _flags) {			\
+		.id = _id,							\
+		.name = _name,							\
+		.mux_ofs = _mux_ofs,						\
+		.set_ofs = _mux_set_ofs,					\
+		.clr_ofs = _mux_clr_ofs,					\
+		.upd_ofs = _upd_ofs,						\
+		.fenc_sta_mon_ofs = _fenc_sta_mon_ofs,				\
+		.mux_shift = _shift,						\
+		.mux_width = _width,						\
+		.gate_shift = _gate,						\
+		.upd_shift = _upd,						\
+		.fenc_shift = _fenc,						\
+		.parent_names = _parents,					\
+		.parent_index = _paridx,					\
+		.num_parents = _num_parents,					\
+		.flags = _flags,						\
+		.ops = &mtk_mux_gate_fenc_clr_set_upd_ops,			\
+	}
+
+#define MUX_GATE_FENC_CLR_SET_UPD(_id, _name, _parents,			\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs,		\
+			_shift, _width, _gate, _upd_ofs, _upd,		\
+			_fenc_sta_mon_ofs, _fenc)			\
+		MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents,	\
+			NULL, ARRAY_SIZE(_parents), _mux_ofs,		\
+			_mux_set_ofs, _mux_clr_ofs, _shift,		\
+			_width, _gate, _upd_ofs, _upd,			\
+			_fenc_sta_mon_ofs, _fenc, 0)
+
+#define MUX_GATE_FENC_CLR_SET_UPD_INDEXED(_id, _name, _parents,	_paridx,	\
+			_mux_ofs, _mux_set_ofs, _mux_clr_ofs,			\
+			_shift, _width, _gate, _upd_ofs, _upd,			\
+			_fenc_sta_mon_ofs, _fenc)				\
+		MUX_GATE_FENC_CLR_SET_UPD_FLAGS(_id, _name, _parents, _paridx,	\
+			ARRAY_SIZE(_paridx), _mux_ofs, _mux_set_ofs,		\
+			_mux_clr_ofs, _shift, _width, _gate, _upd_ofs, _upd,	\
+			_fenc_sta_mon_ofs, _fenc, 0)
+
 int mtk_clk_register_muxes(struct device *dev,
 			   const struct mtk_mux *muxes,
 			   int num, struct device_node *node,
-- 
2.39.5


