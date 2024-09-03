Return-Path: <netdev+bounces-124485-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8841C969A9E
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 12:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 413BF28591F
	for <lists+netdev@lfdr.de>; Tue,  3 Sep 2024 10:49:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C5E01D0955;
	Tue,  3 Sep 2024 10:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b="z3ludKtT"
X-Original-To: netdev@vger.kernel.org
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 384401D0492;
	Tue,  3 Sep 2024 10:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=68.232.154.123
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360497; cv=none; b=W+WhmUTX2PzBCrx9u/r5V+ZFwmB//Ks++OY/Sm7tMMS+kODzS5l4ha1SLYQS16LwsfkTyHD8k5VbgOTpfsEzRTrwsvNG35cuiPs6BT8IfYD45zXYlXadWnxTfWafPrrnSyptgRPbulOyFK1/5rKJjI46FhfHGZYhic04M9RX8uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360497; c=relaxed/simple;
	bh=5Ze3ak7szOHjF+pnjdFZp69ShAxNT7Poi5W3RGkCbyY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jCNTFj9KlG8m5wJw5WnBIWCSX/dXu7sWhbVkCqzNv4PqmNoFdqV7H5Ez3B+hNswDn7zCRYJX2Ulc1Jx+YVoQ7fg+Gmp6MYWSXbFyJ+/uCLele4xHBh52ubeJvxkplZ0RNuVRW908xqBYZXBoPU4brGMM/OmH0emFQW6UvW+bA5s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com; spf=pass smtp.mailfrom=microchip.com; dkim=pass (2048-bit key) header.d=microchip.com header.i=@microchip.com header.b=z3ludKtT; arc=none smtp.client-ip=68.232.154.123
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=microchip.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=microchip.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1725360495; x=1756896495;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5Ze3ak7szOHjF+pnjdFZp69ShAxNT7Poi5W3RGkCbyY=;
  b=z3ludKtTG5uKtj3k96s0/PVeS69uWC+7QW3VwIUzl2/pQelnRa8bWjFX
   pXkE0Pw1wtJpazwAOoejnfFrz4Tn0NTXGyvVUMTjiP2bjH1yNQsTIrwLL
   IynztlpETJfD1mV+NnhCjwTOIyw9TC6bEDD36HrdGnXy/D+9Uqk091Gx3
   GsXqNSYbsdOd/BLeIn0S/oEF7vdAV4SbwMN+4a/EyP91ar2Tgte6pvfZX
   P6VSziZxxtUOvBcT9Drv+py+xHHZs8+QTP+62KABhLI5mG7hjo95QLaV6
   8p2A9nqHVjp7qXCuwurz3kIxMlfAJyyEVouDFZ2GZxgGoe9BZCS3P/KiC
   Q==;
X-CSE-ConnectionGUID: uWF8VejiRc+1iXeLOwOhUQ==
X-CSE-MsgGUID: WWd3XpCOT46f8ZDR9PzjFQ==
X-IronPort-AV: E=Sophos;i="6.10,198,1719903600"; 
   d="scan'208";a="198670083"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256; 03 Sep 2024 03:48:13 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.35; Tue, 3 Sep 2024 03:47:55 -0700
Received: from che-ll-i17164.microchip.com (10.10.85.11) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.35 via Frontend Transport; Tue, 3 Sep 2024 03:47:45 -0700
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
Subject: [PATCH net-next v7 03/14] net: ethernet: oa_tc6: implement register read operation
Date: Tue, 3 Sep 2024 16:16:54 +0530
Message-ID: <20240903104705.378684-4-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
References: <20240903104705.378684-1-Parthiban.Veerasooran@microchip.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

Implement register read operation according to the control communication
specified in the OPEN Alliance 10BASE-T1x MACPHY Serial Interface
document. Control read commands are used by the SPI host to read
registers within the MAC-PHY. Each control read commands are composed of
a 32 bits control command header.

The MAC-PHY ignores all data from the SPI host following the control
header for the remainder of the control read command. Control read
commands can read either a single register or multiple consecutive
registers. When multiple consecutive registers are read, the address is
automatically post-incremented by the MAC-PHY. Reading any unimplemented
or undefined registers shall return zero.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 drivers/net/ethernet/oa_tc6.c | 84 ++++++++++++++++++++++++++++++++++-
 include/linux/oa_tc6.h        |  3 ++
 2 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/oa_tc6.c b/drivers/net/ethernet/oa_tc6.c
index 24e9fd92d717..72bab9234436 100644
--- a/drivers/net/ethernet/oa_tc6.c
+++ b/drivers/net/ethernet/oa_tc6.c
@@ -38,6 +38,7 @@ enum oa_tc6_header_type {
 };
 
 enum oa_tc6_register_op {
+	OA_TC6_CTRL_REG_READ = 0,
 	OA_TC6_CTRL_REG_WRITE = 1,
 };
 
@@ -113,7 +114,8 @@ static void oa_tc6_prepare_ctrl_spi_buf(struct oa_tc6 *tc6, u32 address,
 
 	*tx_buf = oa_tc6_prepare_ctrl_header(address, length, reg_op);
 
-	oa_tc6_update_ctrl_write_data(tc6, value, length);
+	if (reg_op == OA_TC6_CTRL_REG_WRITE)
+		oa_tc6_update_ctrl_write_data(tc6, value, length);
 }
 
 static int oa_tc6_check_ctrl_write_reply(struct oa_tc6 *tc6, u8 size)
@@ -132,6 +134,30 @@ static int oa_tc6_check_ctrl_write_reply(struct oa_tc6 *tc6, u8 size)
 	return 0;
 }
 
+static int oa_tc6_check_ctrl_read_reply(struct oa_tc6 *tc6, u8 size)
+{
+	u32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE;
+	u32 *tx_buf = tc6->spi_ctrl_tx_buf;
+
+	/* The echoed control read header must match with the one that was
+	 * transmitted.
+	 */
+	if (*tx_buf != *rx_buf)
+		return -EPROTO;
+
+	return 0;
+}
+
+static void oa_tc6_copy_ctrl_read_data(struct oa_tc6 *tc6, u32 value[],
+				       u8 length)
+{
+	__be32 *rx_buf = tc6->spi_ctrl_rx_buf + OA_TC6_CTRL_IGNORED_SIZE +
+			 OA_TC6_CTRL_HEADER_SIZE;
+
+	for (int i = 0; i < length; i++)
+		value[i] = be32_to_cpu(*rx_buf++);
+}
+
 static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 			       u8 length, enum oa_tc6_register_op reg_op)
 {
@@ -152,8 +178,62 @@ static int oa_tc6_perform_ctrl(struct oa_tc6 *tc6, u32 address, u32 value[],
 	}
 
 	/* Check echoed/received control write command reply for errors */
-	return oa_tc6_check_ctrl_write_reply(tc6, size);
+	if (reg_op == OA_TC6_CTRL_REG_WRITE)
+		return oa_tc6_check_ctrl_write_reply(tc6, size);
+
+	/* Check echoed/received control read command reply for errors */
+	ret = oa_tc6_check_ctrl_read_reply(tc6, size);
+	if (ret)
+		return ret;
+
+	oa_tc6_copy_ctrl_read_data(tc6, value, length);
+
+	return 0;
+}
+
+/**
+ * oa_tc6_read_registers - function for reading multiple consecutive registers.
+ * @tc6: oa_tc6 struct.
+ * @address: address of the first register to be read in the MAC-PHY.
+ * @value: values to be read from the starting register address @address.
+ * @length: number of consecutive registers to be read from @address.
+ *
+ * Maximum of 128 consecutive registers can be read starting at @address.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
+			  u8 length)
+{
+	int ret;
+
+	if (!length || length > OA_TC6_CTRL_MAX_REGISTERS) {
+		dev_err(&tc6->spi->dev, "Invalid register length parameter\n");
+		return -EINVAL;
+	}
+
+	mutex_lock(&tc6->spi_ctrl_lock);
+	ret = oa_tc6_perform_ctrl(tc6, address, value, length,
+				  OA_TC6_CTRL_REG_READ);
+	mutex_unlock(&tc6->spi_ctrl_lock);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(oa_tc6_read_registers);
+
+/**
+ * oa_tc6_read_register - function for reading a MAC-PHY register.
+ * @tc6: oa_tc6 struct.
+ * @address: register address of the MAC-PHY to be read.
+ * @value: value read from the @address register address of the MAC-PHY.
+ *
+ * Return: 0 on success otherwise failed.
+ */
+int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value)
+{
+	return oa_tc6_read_registers(tc6, address, value, 1);
 }
+EXPORT_SYMBOL_GPL(oa_tc6_read_register);
 
 /**
  * oa_tc6_write_registers - function for writing multiple consecutive registers.
diff --git a/include/linux/oa_tc6.h b/include/linux/oa_tc6.h
index 99c490f1c8a8..85aeecf87306 100644
--- a/include/linux/oa_tc6.h
+++ b/include/linux/oa_tc6.h
@@ -15,3 +15,6 @@ struct oa_tc6 *oa_tc6_init(struct spi_device *spi);
 int oa_tc6_write_register(struct oa_tc6 *tc6, u32 address, u32 value);
 int oa_tc6_write_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
 			   u8 length);
+int oa_tc6_read_register(struct oa_tc6 *tc6, u32 address, u32 *value);
+int oa_tc6_read_registers(struct oa_tc6 *tc6, u32 address, u32 value[],
+			  u8 length);
-- 
2.34.1


