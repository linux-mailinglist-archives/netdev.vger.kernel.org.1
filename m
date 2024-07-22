Return-Path: <netdev+bounces-112401-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 152B3938DCD
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 13:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 449001C214A2
	for <lists+netdev@lfdr.de>; Mon, 22 Jul 2024 11:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 58C2B16CD1B;
	Mon, 22 Jul 2024 11:00:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9A31161936
	for <netdev@vger.kernel.org>; Mon, 22 Jul 2024 11:00:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721646051; cv=none; b=MnY0Rc7fD+rfk3jfz9XKnfFGhDTQtUYhQ8+qDe3xXQhGx1j2EJl2TIZ5eACVyWasoQ2ETUsoq6WzlO6hY2QFoOF/L6PDujOWlwnSZsy9fgSbbGZQzRYB8V5u6ApH0HjKdYjrZo+hMnLm1i9KFG+zwkJ9jphlcRtiNI5vzaniV9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721646051; c=relaxed/simple;
	bh=l7qYAtiMJ0p4BiD84YOQzfSBWEjR5MicEJYJ1ij43Ms=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=JNRHP8N1983Swg9s5pQhd2K7wmQ/3hUqBxOtOVWDfr42F9xnMQTqxhEADxtFoBLGYgDIEJRggSw4cuzXD2uhTizjyi39ZBboIS6iQnz+FUBgeofCu4f7NfGKrYzP9HLCYqTIK7LMzsPDc4piDGaZ3VTRSV6cO14hgX3i6aisqNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from localhost.localdomain (unknown [223.64.68.124])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8AxDMfUO55mcBtUAA--.55713S4;
	Mon, 22 Jul 2024 19:00:40 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com,
	diasyzhang@tencent.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev,
	Huacai Chen <chenhuacai@loongson.cn>
Subject: [PATCH net-next RFC v15 09/14] net: stmmac: dwmac-loongson: Add phy_interface for Loongson GMAC
Date: Mon, 22 Jul 2024 19:00:31 +0800
Message-Id: <fb819622607cb836c92604a90025133336fb71a8.1721645682.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1721645682.git.siyanteng@loongson.cn>
References: <cover.1721645682.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8AxDMfUO55mcBtUAA--.55713S4
X-Coremail-Antispam: 1UD129KBjvdXoW7GrW7Jw1DJr1Utw47GFW7urg_yoWkCFg_W3
	WSvFn5W3WDJrsak3s0qw13XryS93yDX3WfuFsrtFZ3Z3yvv3s8Jr95urn3JF43u3yrZF13
	uw1fKF10kw18JjkaLaAFLSUrUUUUUb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUIcSsGvfJTRUUUbyAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k26cxKx2IYs7xG
	6rWj6s0DM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUXwA2048vs2IY02
	0Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxSw2x7M28EF7xv
	wVC0I7IYx2IY67AKxVW5JVW7JwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxVW8Jr0_Cr1UM2
	8EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E14v26rxl6s0DM2AI
	xVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20x
	vE14v26r126r1DMcIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xv
	r2IYc2Ij64vIr41lF7I21c0EjII2zVCS5cI20VAGYxC7M4IIrI8v6xkF7I0E8cxan2IY04
	v7MxkIecxEwVAFwVW8KwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC2
	0s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI
	0_GFv_WrylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv2
	0xvEc7CjxVAFwI0_Gr1j6F4UJwCI42IY6xAIw20EY4v20xvaj40_Jr0_JF4lIxAIcVC2z2
	80aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvjDU
	0xZFpf9x0JUqtCwUUUUU=
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/

PHY-interface of the Loongson GMAC device is RGMII with no internal
delays added to the data lines signal. So to comply with that let's
pre-initialize the platform-data field with the respective enum
constant.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Acked-by: Huacai Chen <chenhuacai@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index 327275b28dc2..7d3f284b9176 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -52,6 +52,8 @@ static int loongson_gmac_data(struct plat_stmmacenet_data *plat)
 	plat->tx_queues_to_use = 1;
 	plat->rx_queues_to_use = 1;
 
+	plat->phy_interface = PHY_INTERFACE_MODE_RGMII_ID;
+
 	return 0;
 }
 
-- 
2.31.4


