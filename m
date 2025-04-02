Return-Path: <netdev+bounces-178814-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8D52A7903D
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 15:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BDF3E1898875
	for <lists+netdev@lfdr.de>; Wed,  2 Apr 2025 13:48:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DC3F23F26B;
	Wed,  2 Apr 2025 13:46:13 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga07-in.huawei.com (szxga07-in.huawei.com [45.249.212.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C818F23E321;
	Wed,  2 Apr 2025 13:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743601573; cv=none; b=OmG2iLZnCpSWTOmU+KZwhIvRpE0lG5TqpBiXbpLdyr38UHtKxJY3EAVwWZ/jOM0Xsj0TE/iDYH/OmJDk8PdqmmHCogg1vFXvot//1bgGJLl6iFwzPo+fzJAxjVspztIqAajCOh2EtmqT80Lshc3s9A7w9DzwfO849fSicjqsvLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743601573; c=relaxed/simple;
	bh=yWQgH7ApFMZf5ObyEv92ELyomVJTsdwjvQl3F4z7H5o=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mifKLPOfHjMxF8zW39uYn2RxVn7yn7aGTjvhEhh+S5gcu26/4icdjKQRSh11rqqXCkpbb3yiUMd/KTwbDFfHoTDvra+qvXC4c3K+d+m4I7KFFz3K8sH9Avu1ieUOs/t5q9QdtPJ3AMfo1r0zQ3jHrRzha1mtScbNl9LFoBzQkuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.112])
	by szxga07-in.huawei.com (SkyGuard) with ESMTP id 4ZSQxj1hWRz1f1NR;
	Wed,  2 Apr 2025 21:41:13 +0800 (CST)
Received: from kwepemk100013.china.huawei.com (unknown [7.202.194.61])
	by mail.maildlp.com (Postfix) with ESMTPS id 5446F140109;
	Wed,  2 Apr 2025 21:46:02 +0800 (CST)
Received: from localhost.localdomain (10.90.30.45) by
 kwepemk100013.china.huawei.com (7.202.194.61) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 2 Apr 2025 21:46:01 +0800
From: Jijie Shao <shaojijie@huawei.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <andrew+netdev@lunn.ch>, <horms@kernel.org>
CC: <shenjian15@huawei.com>, <wangpeiyang1@huawei.com>,
	<liuyonglong@huawei.com>, <chenhao418@huawei.com>,
	<jonathan.cameron@huawei.com>, <shameerali.kolothum.thodi@huawei.com>,
	<salil.mehta@huawei.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <shaojijie@huawei.com>
Subject: [PATCH net 2/7] net: hibmcge: fix incorrect multicast filtering issue
Date: Wed, 2 Apr 2025 21:39:00 +0800
Message-ID: <20250402133905.895421-3-shaojijie@huawei.com>
X-Mailer: git-send-email 2.30.0
In-Reply-To: <20250402133905.895421-1-shaojijie@huawei.com>
References: <20250402133905.895421-1-shaojijie@huawei.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemk100013.china.huawei.com (7.202.194.61)

The driver does not support multicast filtering,
the mask must be set to 0xFFFFFFFF. Otherwise,
incorrect filtering occurs.

This patch fixes this problem.

Fixes: 37b367d60d0f ("net: hibmcge: Add unicast frame filter supported in this module")
Signed-off-by: Jijie Shao <shaojijie@huawei.com>
---
 drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c  | 4 ++++
 drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
index 7d3bbd3e2adc..9b65eef62b3f 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_hw.c
@@ -234,6 +234,10 @@ void hbg_hw_set_mac_filter_enable(struct hbg_priv *priv, u32 enable)
 {
 	hbg_reg_write_field(priv, HBG_REG_REC_FILT_CTRL_ADDR,
 			    HBG_REG_REC_FILT_CTRL_UC_MATCH_EN_B, enable);
+
+	/* only uc filter is supported, so set all bits of mc mask reg to 1 */
+	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_MSK_0, U64_MAX);
+	hbg_reg_write64(priv, HBG_REG_STATION_ADDR_LOW_MSK_1, U64_MAX);
 }
 
 void hbg_hw_set_pause_enable(struct hbg_priv *priv, u32 tx_en, u32 rx_en)
diff --git a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
index fd623cfd13de..a6e7f5e62b48 100644
--- a/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
+++ b/drivers/net/ethernet/hisilicon/hibmcge/hbg_reg.h
@@ -135,6 +135,8 @@
 #define HBG_REG_STATION_ADDR_HIGH_4_ADDR	(HBG_REG_SGMII_BASE + 0x0224)
 #define HBG_REG_STATION_ADDR_LOW_5_ADDR		(HBG_REG_SGMII_BASE + 0x0228)
 #define HBG_REG_STATION_ADDR_HIGH_5_ADDR	(HBG_REG_SGMII_BASE + 0x022C)
+#define HBG_REG_STATION_ADDR_LOW_MSK_0		(HBG_REG_SGMII_BASE + 0x0230)
+#define HBG_REG_STATION_ADDR_LOW_MSK_1		(HBG_REG_SGMII_BASE + 0x0238)
 
 /* PCU */
 #define HBG_REG_TX_FIFO_THRSLD_ADDR		(HBG_REG_SGMII_BASE + 0x0420)
-- 
2.33.0


