Return-Path: <netdev+bounces-98977-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CF6898D3474
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 12:22:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3D2A71F25A2F
	for <lists+netdev@lfdr.de>; Wed, 29 May 2024 10:22:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2B4E17A938;
	Wed, 29 May 2024 10:20:46 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C92517A91B
	for <netdev@vger.kernel.org>; Wed, 29 May 2024 10:20:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=114.242.206.163
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716978046; cv=none; b=owzcqIHIOdCypJfzldxL9WxfQJ+ia9R7rNa6vG93h9vr9cP+TbzmhoV+a9AaouuMrlMzLxCJcBaeMUfLEPEdiZ/VzJBQvPHLz0sWswZDhYRsFx3uUEYKkvin8kyakIixAanNl338xw5biPsFdcgEZQejaGp0Jy/UWC5Hr7KYsi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716978046; c=relaxed/simple;
	bh=uMIHRyARjfkuoaV6rSzEM8Xdi8jgHK7O/VaQSPxnuwk=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=nxrAAxK38mACg2OyS+IGC1tF7neQWxiK4l1i8Jba2ooN35L9gaSn//+3FC+uwBAqvArTAYRVK8B2ELst+WRmyXInMma4KFMnKlweD33l9QCQY1jKO0L9VoHab5teldN+2eT1lnTcvaGhmEvv9mPm/OnxCj6SX7BS3zSfLQ5Vi5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn; spf=pass smtp.mailfrom=loongson.cn; arc=none smtp.client-ip=114.242.206.163
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=loongson.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=loongson.cn
Received: from loongson.cn (unknown [112.20.112.247])
	by gateway (Coremail) with SMTP id _____8AxW+p8AVdmMxkBAA--.4557S3;
	Wed, 29 May 2024 18:20:44 +0800 (CST)
Received: from localhost.localdomain (unknown [112.20.112.247])
	by localhost.localdomain (Coremail) with SMTP id AQAAf8CxqsZ2AVdmwt4MAA--.33803S4;
	Wed, 29 May 2024 18:20:43 +0800 (CST)
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
Subject: [PATCH net-next v13 12/15] net: stmmac: Fixed failure to set network speed to 1000.
Date: Wed, 29 May 2024 18:20:28 +0800
Message-Id: <e7ae2409f68a2f953ba7c823e248de7d67dfd4e9.1716973237.git.siyanteng@loongson.cn>
X-Mailer: git-send-email 2.31.4
In-Reply-To: <cover.1716973237.git.siyanteng@loongson.cn>
References: <cover.1716973237.git.siyanteng@loongson.cn>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:AQAAf8CxqsZ2AVdmwt4MAA--.33803S4
X-CM-SenderInfo: pvl1t0pwhqwqxorr0wxvrqhubq/
X-Coremail-Antispam: 1Uk129KBj93XoW7tr1DAF15ur1xJF4rZF4DZFc_yoW8Ww4Dpa
	nrCa4UuF1UKF1xJw4kAw18XFW5WayDKFW2g3y2kwsI9FZ7KrZaqryaqFWjyFy7CF4kuFW3
	tr4DCr1UCa4DCrgCm3ZEXasCq-sJn29KB7ZKAUJUUUUf529EdanIXcx71UUUUU7KY7ZEXa
	sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
	0xBIdaVrnRJUUUm2b4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
	IYs7xG6rWj6s0DM7CIcVAFz4kK6r1a6r1DM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
	e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
	0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
	14v26F4UJVW0owAaw2AFwI0_JF0_Jw1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2
	xF0cIa020Ex4CE44I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_
	ZF0_GryDMcIj6I8E87Iv67AKxVW8Jr0_Cr1UMcvjeVCFs4IE7xkEbVWUJVW8JwACjcxG0x
	vY0x0EwIxGrwACjcxG6xCI17CEII8vrVW3JVW8Jr1lc7CjxVAaw2AFwI0_JF0_Jw1l42xK
	82IYc2Ij64vIr41l4I8I3I0E4IkC6x0Yz7v_Jr0_Gr1l4IxYO2xFxVAFwI0_JF0_Jw1lx2
	IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGVWUWwC2zVAF1VAY17CE14v2
	6r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_tr0E3s1lIxAIcVC0I7IYx2
	IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2
	jsIE14v26r4UJVWxJr1lIxAIcVC2z280aVCY1x0267AKxVW8Jr0_Cr1UYxBIdaVFxhVjvj
	DU0xZFpf9x07bUnmiUUUUU=

Loongson GNET devices with dev revision 0x00 do not
support manually setting the speed to 1000, When the
bug is triggered, let's return -EOPNOTSUPP, which
will be flag in later gnet support patches.

Signed-off-by: Feiyang Chen <chenfeiyang@loongson.cn>
Signed-off-by: Yinggang Gu <guyinggang@loongson.cn>
Signed-off-by: Yanteng Si <siyanteng@loongson.cn>
---
 drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c | 6 ++++++
 include/linux/stmmac.h                               | 1 +
 2 files changed, 7 insertions(+)

diff --git a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
index 542e2633a6f5..eb4b3eaf9e17 100644
--- a/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
+++ b/drivers/net/ethernet/stmicro/stmmac/stmmac_ethtool.c
@@ -422,6 +422,12 @@ stmmac_ethtool_set_link_ksettings(struct net_device *dev,
 		return 0;
 	}
 
+	if (priv->plat->flags & STMMAC_FLAG_DISABLE_FORCE_1000) {
+		if (cmd->base.speed == SPEED_1000 &&
+		    cmd->base.autoneg != AUTONEG_ENABLE)
+			return -EOPNOTSUPP;
+	}
+
 	return phylink_ethtool_ksettings_set(priv->phylink, cmd);
 }
 
diff --git a/include/linux/stmmac.h b/include/linux/stmmac.h
index 1536455f9052..3e4f7e8d73fb 100644
--- a/include/linux/stmmac.h
+++ b/include/linux/stmmac.h
@@ -208,6 +208,7 @@ struct dwmac4_addrs {
 #define STMMAC_FLAG_RX_CLK_RUNS_IN_LPI		BIT(10)
 #define STMMAC_FLAG_EN_TX_LPI_CLOCKGATING	BIT(11)
 #define STMMAC_FLAG_HWTSTAMP_CORRECT_LATENCY	BIT(12)
+#define STMMAC_FLAG_DISABLE_FORCE_1000		BIT(13)
 
 struct plat_stmmacenet_data {
 	int bus_id;
-- 
2.31.4


