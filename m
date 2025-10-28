Return-Path: <netdev+bounces-233568-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id D5C50C1591F
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 16:46:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7C8533553E0
	for <lists+netdev@lfdr.de>; Tue, 28 Oct 2025 15:46:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0790A34166C;
	Tue, 28 Oct 2025 15:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b="ROL3YOtq"
X-Original-To: netdev@vger.kernel.org
Received: from layka.disroot.org (layka.disroot.org [178.21.23.139])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9AE343D9E;
	Tue, 28 Oct 2025 15:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.21.23.139
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761666264; cv=none; b=PHL4vUmr/Ng+Nry7pdcBbL928ErC0Db6zZ0+G3l5GkB+hup9mr36kM2GpFBS+s5Rg7Dw5HlW+jGCUrgD64fjPM2lP+IDXWFET28v8znmLvEXkMnu58P/TfADzbzSBBAGSQl3LhSWvBX4zqqqMzMYQs9pvr/rXpHzsshaIZLCI40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761666264; c=relaxed/simple;
	bh=VqxT8ZvTz5pYoplWj4px0Qp14OrM/a50t4vdKLPH1pk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rWiUj1cXhslnAPDDHfx+Y0QozMkuSFIhbMHd0Um+oXujUUu4FCYN6SqqUT8FYXajlLIizoZBF7vPzjp7q5+3i3HBsVSHYvCLrsfWAHQXuzLahTwCvOWWRpLo/SeC1eKKUAPTbt6ZlYiyBNdSNJVbN3Bn3YH09P9odq6oUGjCx4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org; spf=pass smtp.mailfrom=disroot.org; dkim=pass (2048-bit key) header.d=disroot.org header.i=@disroot.org header.b=ROL3YOtq; arc=none smtp.client-ip=178.21.23.139
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=disroot.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=disroot.org
Received: from mail01.disroot.lan (localhost [127.0.0.1])
	by disroot.org (Postfix) with ESMTP id A5B4B25DAF;
	Tue, 28 Oct 2025 16:44:21 +0100 (CET)
X-Virus-Scanned: SPAM Filter at disroot.org
Received: from layka.disroot.org ([127.0.0.1])
 by localhost (disroot.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id oKNUI2u2njrw; Tue, 28 Oct 2025 16:44:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=disroot.org; s=mail;
	t=1761666261; bh=VqxT8ZvTz5pYoplWj4px0Qp14OrM/a50t4vdKLPH1pk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ROL3YOtqT8kEkVlDRph2Mz0+d6MngXrV3D2HDanm3i/eV7bEqiZ9Z3sCll9rL/Om6
	 6X6hHIH9JHVsnLIELy7aKUKV/uCNz6pt87RrtTHhaBqEtzDNpTFRN+v87wr1aqo/ta
	 +TMEdLhO79Rhye2QwOph+xDbD2hxPk8dLGzizfQUrxzP5OjDWdMce8+rtyjAuDX6QP
	 U0cFt3+9I3+F2K64yj8GKn8eMiJk02zgd6kwbxTa0WmJXdH5Vc1bQfZlN3XcIJ+R3m
	 pZDDZzmH9WQ2ZV26TJw066MWpGdBY8863tpXy6TBrtt49Pv+p2Wzcl5+IujmDLS0qJ
	 p+mJq9k9TvgNQ==
From: Yao Zi <ziyao@disroot.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Yanteng Si <si.yanteng@linux.dev>,
	Huacai Chen <chenhuacai@kernel.org>,
	"Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
	Philipp Stanner <phasta@kernel.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>,
	Qunqin Zhao <zhaoqunqin@loongson.cn>,
	Yao Zi <ziyao@disroot.org>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Furong Xu <0x1207@gmail.com>,
	Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
	Jacob Keller <jacob.e.keller@intel.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/3] net: stmmac: Add generic suspend/resume helper for PCI-based controllers
Date: Tue, 28 Oct 2025 15:43:30 +0000
Message-ID: <20251028154332.59118-2-ziyao@disroot.org>
In-Reply-To: <20251028154332.59118-1-ziyao@disroot.org>
References: <20251028154332.59118-1-ziyao@disroot.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most glue driver for PCI-based DWMAC controllers utilize similar
platform suspend/resume routines. Add a generic implementation to reduce
duplicated code.

Signed-off-by: Yao Zi <ziyao@disroot.org>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac.h  |  2 +
 .../net/ethernet/stmicro/stmmac/stmmac_main.c | 37 +++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac.h b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
index d5af9344dfb0..baa4ff14bdfe 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac.h
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac.h
@@ -395,6 +395,8 @@ int stmmac_xdp_open(struct net_device *dev);
 void stmmac_xdp_release(struct net_device *dev);
 int stmmac_resume(struct device *dev);
 int stmmac_suspend(struct device *dev);
+int stmmac_pci_plat_suspend(struct device *dev, void *bsp_priv);
+int stmmac_pci_plat_resume(struct device *dev, void *bsp_priv);
 void stmmac_dvr_remove(struct device *dev);
 int stmmac_dvr_probe(struct device *device,
 		     struct plat_stmmacenet_data *plat_dat,
diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
index fd5106880192..3bd284019ca7 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_main.c
@@ -28,6 +28,7 @@
 #include <linux/if_vlan.h>
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
+#include <linux/pci.h>
 #include <linux/pm_runtime.h>
 #include <linux/pm_wakeirq.h>
 #include <linux/prefetch.h>
@@ -7938,6 +7939,42 @@ EXPORT_SYMBOL_GPL(stmmac_resume);
 DEFINE_SIMPLE_DEV_PM_OPS(stmmac_simple_pm_ops, stmmac_suspend, stmmac_resume);
 EXPORT_SYMBOL_GPL(stmmac_simple_pm_ops);
 
+#ifdef CONFIG_PCI
+int stmmac_pci_plat_suspend(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	ret = pci_save_state(pdev);
+	if (ret)
+		return ret;
+
+	pci_disable_device(pdev);
+	pci_wake_from_d3(pdev, true);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stmmac_pci_plat_suspend);
+
+int stmmac_pci_plat_resume(struct device *dev, void *bsp_priv)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+	int ret;
+
+	pci_restore_state(pdev);
+	pci_set_power_state(pdev, PCI_D0);
+
+	ret = pci_enable_device(pdev);
+	if (ret)
+		return ret;
+
+	pci_set_master(pdev);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(stmmac_pci_plat_resume);
+#endif /* CONFIG_PCI */
+
 #ifndef MODULE
 static int __init stmmac_cmdline_opt(char *str)
 {
-- 
2.50.1


