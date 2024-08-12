Return-Path: <netdev+bounces-117655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B391E94EB14
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 12:31:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7645A2827F4
	for <lists+netdev@lfdr.de>; Mon, 12 Aug 2024 10:31:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FA3170A1C;
	Mon, 12 Aug 2024 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="RS5o+YYH"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9136A16F0FE;
	Mon, 12 Aug 2024 10:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723458567; cv=none; b=Bq6pyKYzBfysL1kh4lFiyi3VUUMORlrtD0GPoVH/QlhXpPgLOXaGILPP8LnVd5IyxWjBIy3GM4AXbFbL/yWWTEWHv6PpHNXJOLr6UPnR0Sy04MOKIMSypJ5saG3j8nZlNEJJzCOOaHZnXLaxwJ5UkGGjrBS1wxy+a9k2m83KhvE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723458567; c=relaxed/simple;
	bh=fHNrU+a7gojkjruhSaEoSvNti4RUM1ny2YgI/4nxe68=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d+w2dymh1Rp6bYa9yNMlSlSMKuuNu0i5yqyHC9DPWxt+3rYpJbCLsNYyyIgKAkwgxQ0cVNTEbo6IwIJB2TZu0ZD3szHcPtkCFuT/DP1jCJXiR0HM++HojqEMMCZGuWl3vglQ6G3inUqZQ27voWAlji98FFLpu4FtJYFyveb2gUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=RS5o+YYH; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1723458565; x=1754994565;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=fHNrU+a7gojkjruhSaEoSvNti4RUM1ny2YgI/4nxe68=;
  b=RS5o+YYHoawRqYFIz/vxih4z7xQpg3Q38hRNNdpTLwLBbA8p+xtacM/m
   HDtGdcuTDQE7+szgPf7RzNIk0p8oTG8hmVX6lvh3f+2KBK+tTFj2AP4Al
   cCkp1BkdJbX5W8jEWOg3K0OsMeHwkWwUSrEwcNF/3XnOYVMuejDprmhd6
   hcsFXUGFMVszPfALedKwBenCv7DGoifUKbSySR/6wiMBHRC6ewCsNhq60
   sYB2Q3z4sDvOrXqwiu52MTi3gtR+Juf4WD6fDThFmC0Qi5T9s42/og8tH
   feiZTxlxkrZHD20N2Ys6MSyGhj96M3do6DuxLNZ8GHL06NX8lH6+Ufcun
   Q==;
X-CSE-ConnectionGUID: OEhsVMApSRmU8ygydq7igg==
X-CSE-MsgGUID: 7rgUsN7pSxKX0a7gGctFQw==
X-IronPort-AV: E=Sophos;i="6.09,282,1716274800"; 
   d="scan'208";a="30336599"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 12 Aug 2024 03:29:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Mon, 12 Aug 2024 03:29:03 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Mon, 12 Aug 2024 03:28:52 -0700
From: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <horms@kernel.org>, <saeedm@nvidia.com>,
	<anthony.l.nguyen@intel.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <andrew@lunn.ch>, <corbet@lwn.net>,
	<linux-doc@vger.kernel.org>, <robh+dt@kernel.org>,
	<krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
	<devicetree@vger.kernel.org>, <horatiu.vultur@microchip.com>,
	<ruanjinjie@huawei.com>, <steen.hegelund@microchip.com>,
	<vladimir.oltean@nxp.com>
CC: <parthiban.veerasooran@microchip.com>, <masahiroy@kernel.org>,
	<alexanderduyck@fb.com>, <krzk+dt@kernel.org>, <robh@kernel.org>,
	<rdunlap@infradead.org>, <hkallweit1@gmail.com>, <linux@armlinux.org.uk>,
	<UNGLinuxDriver@microchip.com>, <Thorsten.Kummermehr@microchip.com>,
	<Pier.Beruto@onsemi.com>, <Selvamani.Rajagopal@onsemi.com>,
	<Nicolas.Ferre@microchip.com>, <benjamin.bigler@bernformulastudent.ch>,
	<linux@bigler.io>, <markku.vorne@kempower.com>, Parthiban Veerasooran
	<Parthiban.Veerasooran@microchip.com>
Subject: [PATCH net-next v6 12/14] net: ethernet: oa_tc6: add helper function to enable zero align rx frame
Date: Mon, 12 Aug 2024 15:56:09 +0530
Message-ID: <20240812102611.489550-13-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
References: <20240812102611.489550-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Zero align receive frame feature can be enabled to align all receive
ethernet frames data to start at the beginning of any receive data chunk
payload with a start word offset (SWO) of zero. Receive frames may begin
anywhere within the receive data chunk payload when this feature is not
enabled.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 24 ++++++++++++++++++++++++
 include/linux/oa_tc6.h        |  1 +
 2 files changed, 25 insertions(+)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index b55a3347f58f..fbf9d9ad4175 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -23,6 +23,7 @@
 /* Configuration Register #0 */
 #define OA_TC6_REG_CONFIG0			0x0004
 #define CONFIG0_SYNC				BIT(15)
+#define CONFIG0_ZARFE_ENABLE			BIT(12)
 
 /* Status Register #0 */
 #define OA_TC6_REG_STATUS0			0x0008
@@ -1164,6 +1165,29 @@ static irqreturn_t oa_tc6_macphy_isr(int irq, void *data)
 	return IRQ_HANDLED;
 }
 
+/**
+ * oa_tc6_zero_align_receive_frame_enable - function to enable zero align
+ * receive frame feature.
+ * @tc6: oa_tc6 struct.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6)
+{
+	u32 regval;
+	int ret;
+
+	ret = oa_tc6_read_register(tc6, OA_TC6_REG_CONFIG0, &regval);
+	if (ret)
+		return ret;
+
+	/* Set Zero-Align Receive Frame Enable */
+	regval |= CONFIG0_ZARFE_ENABLE;
+
+	return oa_tc6_write_register(tc6, OA_TC6_REG_CONFIG0, regval);
+}
+EXPORT_SYMBOL_GPL(oa_tc6_zero_align_receive_frame_enable);
+
 /**
  * oa_tc6_start_xmit - function for sending the tx skb which consists ethernet
  * frame.
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 5c7811ac9cbe..15f58e3c56c7 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -21,3 +21,4 @@ int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value);
 int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			  u8 length);
 netdev_tx_t oa_tc6_start_xmit(struct oa_tc6 *tc6, struct sk_buff *skb);
+int oa_tc6_zero_align_receive_frame_enable(struct oa_tc6 *tc6);
-- 
2.34.1


