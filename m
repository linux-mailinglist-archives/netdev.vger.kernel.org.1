Return-Path: <netdev+bounces-200708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F20B7AE6940
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 16:43:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0C3D91C23F69
	for <lists+netdev@lfdr.de>; Tue, 24 Jun 2025 14:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E00E2E1731;
	Tue, 24 Jun 2025 14:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="kCGVLLUZ"
X-Original-To: netdev@vger.kernel.org
Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0A2E11C2;
	Tue, 24 Jun 2025 14:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750775627; cv=none; b=EzLa00ZU1wcsZfhusgMXvvt17HlhsE1cNUO02trT7i9j5sBSiSnp7CXhroM7iUgym+gBYWfUag6X/Ye9ivouq1TutnoC2wT5BuNVv7jjl8NrLxaVTEf6BevS5Y8ar8LyW2aJcTKhQVaN7Od3owk84EaM8uYlXwEg3wiA3Ftgba4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750775627; c=relaxed/simple;
	bh=bf++AAMVsRdlK8ZXZIEoCdT5vXCmrXzvterr8licGP4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qRxhrIejPREYxOqSvL5m2sKHG2cOwmm5na8aE7e/1pxFKvAGbuVy6IYOuHyimE9RyaKtw/ybd1KbzUvuart2tALgzpvzvmaABmCcZzrruZFwPpBxzLADeFYME96lLNDrNSPkTJNCwXk4cca4xerFC6QUq8uK/2w/eNEyZw2gU1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=kCGVLLUZ; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1750775624;
	bh=bf++AAMVsRdlK8ZXZIEoCdT5vXCmrXzvterr8licGP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kCGVLLUZPg6n83RiJw/QUn1WmQlLddpQMsa6yq9QG+f5fV/C5cN1DWLBwaOonmXKl
	 KNeefaUGGC8JkLlIJJxIo/cYj0NzjDj4QTWXNw/BD3qOU++bQNadvcR4+qhdtFqrbh
	 iXjuPgUZILvITrwnLO0pFMB+i9L4Q+prR5gw5vs7gGlBtx0KbU72VyOyxauwPiX4A6
	 rGeEs9tdeSJU+dPqQ90Yd86/y9RN5IGBES1N9asHZqFiF+sHUDiHgcrJP/vPEv5lak
	 Cipgpyk4fzltEeFaSnUOfu1gKpFwVif8HTh7CTMGOdtMVjd72ldszZ021gq0/pumzE
	 3tToasGptiOzA==
Received: from laura.lan (unknown [IPv6:2001:b07:646b:e2:d2c7:2075:2c3c:38e5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: laura.nao)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 3114C17E088B;
	Tue, 24 Jun 2025 16:33:43 +0200 (CEST)
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
	Laura Nao <laura.nao@collabora.com>
Subject: [PATCH v2 10/29] dt-bindings: reset: Add MediaTek MT8196 Reset Controller binding
Date: Tue, 24 Jun 2025 16:32:01 +0200
Message-Id: <20250624143220.244549-11-laura.nao@collabora.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250624143220.244549-1-laura.nao@collabora.com>
References: <20250624143220.244549-1-laura.nao@collabora.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Add a binding for the PEXTP0/1 and UFS reset controllers found in
the MediaTek MT8196 Chromebook SoC.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Signed-off-by: Laura Nao <laura.nao@collabora.com>
---
 .../reset/mediatek,mt8196-resets.h            | 26 +++++++++++++++++++
 1 file changed, 26 insertions(+)
 create mode 100644 include/dt-bindings/reset/mediatek,mt8196-resets.h

diff --git a/include/dt-bindings/reset/mediatek,mt8196-resets.h b/include/dt-bindings/reset/mediatek,mt8196-resets.h
new file mode 100644
index 000000000000..46ced0850d91
--- /dev/null
+++ b/include/dt-bindings/reset/mediatek,mt8196-resets.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause) */
+/*
+ * Copyright (c) 2025 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef _DT_BINDINGS_RESET_CONTROLLER_MT8196
+#define _DT_BINDINGS_RESET_CONTROLLER_MT8196
+
+/* PEXTP0 resets */
+#define MT8196_PEXTP0_RST0_PCIE0_MAC		0
+#define MT8196_PEXTP0_RST0_PCIE0_PHY		1
+
+/* PEXTP1 resets */
+#define MT8196_PEXTP1_RST0_PCIE1_MAC		0
+#define MT8196_PEXTP1_RST0_PCIE1_PHY		1
+#define MT8196_PEXTP1_RST0_PCIE2_MAC		2
+#define MT8196_PEXTP1_RST0_PCIE2_PHY		3
+
+/* UFS resets */
+#define MT8196_UFSAO_RST0_UFS_MPHY		0
+#define MT8196_UFSAO_RST1_UFS_UNIPRO		1
+#define MT8196_UFSAO_RST1_UFS_CRYPTO		2
+#define MT8196_UFSAO_RST1_UFSHCI		3
+
+#endif  /* _DT_BINDINGS_RESET_CONTROLLER_MT8196 */
-- 
2.39.5


