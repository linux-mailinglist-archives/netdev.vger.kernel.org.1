Return-Path: <netdev+bounces-193479-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 693C0AC42E0
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 18:18:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18F0318949C5
	for <lists+netdev@lfdr.de>; Mon, 26 May 2025 16:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21BF2226CF6;
	Mon, 26 May 2025 16:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="cOo+iE3d"
X-Original-To: netdev@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.4])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F10525569;
	Mon, 26 May 2025 16:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748276287; cv=none; b=Kte9JzLbs7PSaS4VOVSvCzDMXBxVeNlSAKzLzXjh9g+jbaS6rhGEoqMxtASt2etp2qZePZwo+VVK116aCiUoG6/xjQhQbxXfimzhpWR7H6ActqkG0VWW7SNbmb/SWPMYyCY6gJzNoOrBFUUWFe4irjCZr3RxeGuaU4Knj912+Lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748276287; c=relaxed/simple;
	bh=Km/T0v33ODIbbWge+lZQgvBrYDZpQ9YKa95weK0TeIc=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=s/zoTBkDtDWCz6qNrHau/UGoHwIsE/GL+G/HniD2pxUWMy8SCx99uzUHnfMKpjbX/IcoG/IECGB65ol/OqgZVra5eR3P7W7QHmhMluPaPXtbm5CfDtAWo8mzmnt8qNoqawtFpdNgBU/y8r9fe5j7scwrJSedCQHDNLMaLECKK5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=cOo+iE3d; arc=none smtp.client-ip=117.135.210.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-Id:MIME-Version:
	Content-Type; bh=/08m4WiVs71pwfy4afzILVd589TmeFYKjVShkpd/6Xk=;
	b=cOo+iE3dQ+XGIYC67LTJgRXrsxVcskrIamUspAxWNOfw8IHx5/c/BsJdxWpP0b
	hFyZpPd4mGHUNdODYM2R7dnnA+06xICpaWTakAoVHN5KaXSKJFTROQ7AKmYU9Qbk
	Hl+uhPbipikJOoBURZqbbS4fCK0F9+F8oUyWvbCVXLpUU=
Received: from localhost.localdomain (unknown [])
	by gzga-smtp-mtada-g1-4 (Coremail) with SMTP id _____wD3v1DYkzRowdzVEA--.46087S2;
	Tue, 27 May 2025 00:16:36 +0800 (CST)
From: =?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	mcoquelin.stm32@gmail.com,
	alexandre.torgue@foss.st.com,
	jonas@kwiboo.se,
	rmk+kernel@armlinux.org.uk,
	david.wu@rock-chips.com,
	wens@csie.org,
	jan.petrous@oss.nxp.com
Cc: netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	=?UTF-8?q?=E6=9D=8E=E5=93=B2?= <sensor1010@163.com>
Subject: [PATCH] net: dwmac-rk: No need to check the return value of the phy_power_on()
Date: Mon, 26 May 2025 09:16:21 -0700
Message-Id: <20250526161621.3549-1-sensor1010@163.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3v1DYkzRowdzVEA--.46087S2
X-Coremail-Antispam: 1Uf129KBjvdXoWrKw13Wr1rCFWfAryUKF43GFg_yoWfXwcEga
	17ZFsaqa15GF4jyF98Cw45ZrWSvF4DWrs3ZFsxKayfCF47Xwn8XryDursxArnrur45AF9r
	Gr1fJFyxZ34xGjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
	9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRtCJPDUUUUU==
X-CM-SenderInfo: 5vhq20jurqiii6rwjhhfrp/xtbBMR5Xq2gyA7BOhAADsz

since the return value of the phy_power_on() function is always 0,
checking its return value is redundant.

Signed-off-by: 李哲 <sensor1010@163.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
index 700858ff6f7c..6e8b10fda24d 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-rk.c
@@ -1839,11 +1839,7 @@ static int rk_gmac_powerup(struct rk_priv_data *bsp_priv)
 		dev_err(dev, "NO interface defined!\n");
 	}
 
-	ret = phy_power_on(bsp_priv, true);
-	if (ret) {
-		gmac_clk_enable(bsp_priv, false);
-		return ret;
-	}
+	phy_power_on(bsp_priv, true);
 
 	pm_runtime_get_sync(dev);
 
-- 
2.17.1


