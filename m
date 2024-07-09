Return-Path: <netdev+bounces-110185-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E1BF092B3F0
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 11:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 984781F22E62
	for <lists+netdev@lfdr.de>; Tue,  9 Jul 2024 09:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 302C6155725;
	Tue,  9 Jul 2024 09:34:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D74E154458
	for <netdev@vger.kernel.org>; Tue,  9 Jul 2024 09:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720517672; cv=none; b=KSsK/xftnhfCjay6VTJ2tsFcDmUbC561tcNo3UlIClmGd69OH4i5QZkMaP/yDDQ0R9bgjvcE9nmj8+yQY+hoxpJ/180jaDKXxe2T4Scxo0eFYng10IDfb7tppkT1ptjSFHhCdKofJtjYOo26ms7f3FcZf843eAzyeerk60OY9XE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720517672; c=relaxed/simple;
	bh=jYO+19WxoVSkZosRtb+A77kUnix5xJl9uPJXHMfCI44=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=KNnSdiH292SWwyA3ZiHyQ5G7ws6raEUAdHqAd9e/7GbFxWhK14gAEB80jxYW1JHZQI5OfadFaqaqkzmoQFiDyInJMEY94W55TenuFZTH6wWFd3zYDgL1VOWH48g6ghj1sY59C3+N00FJ2xyZ0IcemQ/7sHAmu1qJLyRPX6qFnzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [223.64.68.130])
	by gateway (Coremail) with SMTP id _____8Bx3+skBI1mHF4CAA--.7034S3;
	Tue, 09 Jul 2024 17:34:28 +0800 (CST)
Received: from localhost.localdomain (unknown [223.64.68.130])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxZcUdBI1m7tZAAA--.7469S5;
	Tue, 09 Jul 2024 17:34:26 +0800 (CST)
From: Yanteng Si <siyanteng@loongson.cn>
To: andrew@lunn.ch,
	hkallweit1@gmail.com,
	peppe.cavallaro@st.com,
	alexandre.torgue@foss.st.com,
	joabreu@synopsys.com,
	fancer.lancer@gmail.com
Cc: Yanteng Si <siyanteng@loongson.cn>,
	Jose.Abreu@synopsys.com,
	chenhuacai@kernel.org,
	linux@armlinux.org.uk,
	guyinggang@loongson.cn,
	netdev@vger.kernel.org,
	chris.chenfeiyang@gmail.com,
	si.yanteng@linux.dev
Subject: [PATCH net-next v14 03/14] net: stmmac: Export dwmac1000_dma_ops
Date: Tue,  9 Jul 2024 17:34:10 +0800
Message-Id: <2bc95440f7af17a827cfbeae991454c7f7f86001.1720512634.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1720512634.git.siyanteng@loongson.cn>
References: <cover.1720512634.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxZcUdBI1m7tZAAA--.7469S5
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj9xXoW7Gr4fZryUAw47Jw15ur4fXrc_yoWkZFb_uF
	12vrn3Ww4ktr4ayw1jyw45ZryFvrykur1fKF47XFWfA3Wvvr95Xa4kurn5Xr15u398ZFn8
	Grn7XFyIyryxtosvyTuYvTs0mTUanT9S1TB71UUUUjJqnTZGkaVYY2UrUUUUj1kv1TuYvT
	s0mT0YCTnIWjqI5I8CrVACY4xI64kE6c02F40Ex7xfYxn0WfASr-VFAUDa7-sFnT9fnUUI
	cSsGvfJTRUUUbSkYFVCjjxCrM7AC8VAFwI0_Jr0_Gr1l1xkIjI8I6I8E6xAIw20EY4v20x
	vaj40_Wr0E3s1l1IIY67AEw4v_Jrv_JF1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0rcxS
	w2x7M28EF7xvwVC0I7IYx2IY67AKxVW7JVWDJwA2z4x0Y4vE2Ix0cI8IcVCY1x0267AKxV
	WxJVW8Jr1l84ACjcxK6I8E87Iv67AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVCY1x0267AK
	xVW8Jr0_Cr1UM2kKe7AKxVWUAVWUtwAS0I0E0xvYzxvE52x082IY62kv0487Mc804VCY07
	AIYIkI8VC2zVCFFI0UMc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2IY67AKxVWr
	XVW3AwAv7VC2z280aVAFwI0_Gr0_Cr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0Y48IcxkI7V
	AKI48JMxkF7I0En4kS14v26r126r1DMxAIw28IcxkI7VAKI48JMxC20s026xCaFVCjc4AY
	6r1j6r4UMxCIbckI1I0E14v26r126r1DMI8I3I0E5I8CrVAFwI0_Jr0_Jr4lx2IqxVCjr7
	xvwVAFwI0_JrI_JrWlx4CE17CEb7AF67AKxVWUtVW8ZwCIc40Y0x0EwIxGrwCI42IY6xII
	jxv20xvE14v26ryj6F1UMIIF0xvE2Ix0cI8IcVCY1x0267AKxVW8JVWxJwCI42IY6xAIw2
	0EY4v20xvaj40_Jr0_JF4lIxAIcVC2z280aVAFwI0_Gr0_Cr1lIxAIcVC2z280aVCY1x02
	67AKxVW8JVW8JrUvcSsGvfC2KfnxnUUI43ZEXa7IU0_WrPUUUUU==

Export the DW GMAC DMA-ops descriptor so one could be available in
the low-level platform drivers. It will be utilized to override some
callbacks in order to handle the LS2K2000 GNET device specifics. The
GNET controller support is being added in one of the following up
commits.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
index b3d7eff53b18..118a22406a2e 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac1000_dma.c
@@ -296,3 +296,4 @@ const struct stmmac_dma_ops dwmac1000_dma_ops = {
 	.get_hw_feature = dwmac1000_get_hw_feature,
 	.rx_watchdog = dwmac1000_rx_watchdog,
 };
+EXPORT_SYMBOL_GPL(dwmac1000_dma_ops);
-- 
2.31.4


