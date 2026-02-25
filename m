Return-Path: <netdev+bounces-260870-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mLJPLiHPnmnwXQQAu9opvQ
	(envelope-from <netdev+bounces-260870-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:29:53 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 604D9195C57
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 11:29:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BD2853012529
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 10:29:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92BE63921FA;
	Wed, 25 Feb 2026 10:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uv1MWgw6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B982F3164BA
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 10:29:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772015390; cv=none; b=lcr+62OvcpIobJh+BBCYgRs0QhVIkDtMrZym/CA0lZvTAjzzSFRQ7xN/a/ISjnhs+SqUKDktLpztN+XoSqNUGwJzJjMwCK12RSKTxmuM4H9rXCZXy/fxlkcJU3Zo+FIXLbLi6CTy3Q2Gx+CDSsqdt5NoYUiuxjAcFdwa4w5gqF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772015390; c=relaxed/simple;
	bh=jNkOw59N8Us5dFtSQudM9QIIx3ulIMGVE2bPvPZVKuo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lAmxb2LNhQzOzM2SVRkmwai8RpTFZtMCh8wRci7FcUrWdKc0N2wXy1C/w87djwxYM5Tg2osg6t1bmGvtUeOTwclG9ttc+kI6hb4LOp4ctUpUYGhTSjE+eN9ysQWksz8zdaN/mibaU4xHBbuX5fIS+Sd/nMiumlgTbFoY7Vu4Qps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uv1MWgw6; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-483a2338616so42528955e9.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 02:29:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772015387; x=1772620187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=8+i1N9LxeAf/Cr7o1GDGPjPgw2aFYJDIVGcVuPSleg8=;
        b=Uv1MWgw6A79Gwv8tYalcXtpIDVo5jHSYIM0RNLbA3mCboIVnDzmmEPfWlreRXuHQkL
         iAed0jvgNYRhxDVOBjCfxCSBnbnVoGhT7v8i6XkZV9MyWBavNhu/BF7Oj5GaemldxtsO
         rMqLZ5g6KJ3S8POmSeJqL7HyVUIRzUOPJXRJ0QSl7P1BkYHSOc3tW1gt0wDLwQteuiWJ
         yJnnMzJmLWQt+qWUY8tSYHPbGW/dVJM/hscDjr0XCbYD8G01RYRM8zmFh9ABcN3Tx3f3
         OrDByPnJmIc5qmDaP06o4T/Z9rvesfPJa5HS1pgdpqmXvYJfZ7LHc99A2ghc+WcEccAi
         HyUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772015387; x=1772620187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8+i1N9LxeAf/Cr7o1GDGPjPgw2aFYJDIVGcVuPSleg8=;
        b=xLQ8EOewAXMmABJ8m4j7Yiy/PGc36m0b1Y2SwE7j6bK24QCyrY0ilP6N+WBYpBcu/h
         dePKu1nKxf2jeyM7YYaf1PtMjXH0jKzYTU5kUBM5iUBM1wTLDeCDdhoa2QSaqDB/LgBj
         upF6uNYEGEhzS+JbKUceCOaVX2V9XmtRbVuf1P7ExMKi+3Zosxm5J1dNfAM0RWSPiSxg
         Z0+zoZJq23Co3mJSJF09NIHY8fsGRAucLe7k5whHELHfC05VJ2tVo4W0LpWDx2/w/o5E
         sxKHVtiEZ0isv5v6ER3Q1pkUwgWyRzlVD79dVYOJdrkd+WEl/VnMTj9Q+Nr3xbooZF5+
         rHeg==
X-Forwarded-Encrypted: i=1; AJvYcCXyuwhS8D0CV6SWvavbmc4Xx6nD5iFHfh70SnmhdCAU9r/hV48jfrQA9FH7+l4usKy1rHjaHeE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzhs83AU9tNZ2vQutU89d3aNguN1liVl9zngyTE/qq1qDWUEWSC
	xStqAa+J8jo545GUV+NDLNXZnAj70rjjb+JcGAoi1sS9aZhvHSyunZ/3
X-Gm-Gg: ATEYQzwn/OA5c5Fa8NiOK2plv7kLhe/MOHCD1C86BHM5Xa4gg+Ml3jKsLCF3jLVB1BG
	0bkR9TUNXt9Nvlv+wEFN2a74s3xv5DA3L+teMY6Rb62X/ueePJV4kmtNt33w7OXrno7phFnFV6R
	9UrcP453DbZrZ+LkQ/ZhdchIjPTNFdAIm5bSfzxZcUR5oJyVx+kHuW5041GmVO2nqhOC9wzRaW/
	DluXA3LcFx94vz0O3xkUld7kS3pLoLxYayRNrAS8x2hW3pgYM6+d+M3K9lTkqOn0Ze45ynkgc5X
	C/dm5TBaQQ2FYyNJmq25TWqVtn8ssm9b7i/jWUYhTuXrpwIBh9B2Y5pCn0CZn+k+aMhXmkcLl+s
	b+vPRYdEOpi79PvObuJuo7frnvW9N9YmChA1MGbHMPx7FyorLM9qKBhSgY2poj6An0nSFPz8fe8
	2yYYcPgykHW21Dwzwaq0GL7N+GsN7/zOgwqwNFJTa7/AW4su9vpDe2fALZtScF
X-Received: by 2002:a05:600d:8444:20b0:483:afbb:a086 with SMTP id 5b1f17b1804b1-483afbba1e8mr134391655e9.29.1772015386739;
        Wed, 25 Feb 2026 02:29:46 -0800 (PST)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483bfb1afcbsm17896445e9.2.2026.02.25.02.29.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 02:29:46 -0800 (PST)
From: Sagi Maimon <maimon.sagi@gmail.com>
To: jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Sagi Maimon <maimon.sagi@gmail.com>
Subject: [PATCH v1] ptp: ocp: Add support for Xilinx-based Adva TimeCard variant
Date: Wed, 25 Feb 2026 12:29:38 +0200
Message-ID: <20260225102938.4131-1-maimon.sagi@gmail.com>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-260870-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[maimonsagi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 604D9195C57
X-Rspamd-Action: no action

Add support for the Adva TimeCard model built on a Xilinx-based design.
This patch enables detection and integration of the new hardware within
the existing OCP timecard framework.

The Xilinx variant relies on the shared driver infrastructure, requiring
only small, targeted additions to accommodate its specific
characteristics.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 318 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index d88ab2f86b1b..1d0a06f82281 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -35,6 +35,7 @@
 
 #define PCI_VENDOR_ID_ADVA			0xad5a
 #define PCI_DEVICE_ID_ADVA_TIMECARD		0x0400
+#define PCI_DEVICE_ID_ADVA_TIMECARD_X1	0x0410
 
 static struct class timecard_class = {
 	.name		= "timecard",
@@ -420,12 +421,16 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
 static int ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
+static int ptp_ocp_adva_board_x1_init(struct ptp_ocp *bp, struct ocp_resource *r);
+
 static const struct ocp_attr_group fb_timecard_groups[];
 
 static const struct ocp_attr_group art_timecard_groups[];
 
 static const struct ocp_attr_group adva_timecard_groups[];
 
+static const struct ocp_attr_group adva_timecard_x1_groups[];
+
 struct ptp_ocp_eeprom_map {
 	u16	off;
 	u16	len;
@@ -1030,11 +1035,212 @@ static struct ocp_resource ocp_adva_resource[] = {
 	{ }
 };
 
+static struct ocp_resource ocp_adva_x1_resource[] = {
+	{
+		OCP_MEM_RESOURCE(reg),
+		.offset = 0x01000000, .size = 0x10000,
+	},
+	{
+		OCP_EXT_RESOURCE(ts0),
+		.offset = 0x01010000, .size = 0x10000, .irq_vec = 1,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 0,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts1),
+		.offset = 0x01020000, .size = 0x10000, .irq_vec = 2,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts2),
+		.offset = 0x01060000, .size = 0x10000, .irq_vec = 6,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts3),
+		.offset = 0x01110000, .size = 0x10000, .irq_vec = 15,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 3,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(ts4),
+		.offset = 0x01120000, .size = 0x10000, .irq_vec = 16,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 4,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	/* Timestamp for PHC and/or PPS generator */
+	{
+		OCP_EXT_RESOURCE(pps),
+		.offset = 0x010C0000, .size = 0x10000, .irq_vec = 0,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 5,
+			.irq_fcn = ptp_ocp_ts_irq,
+			.enable = ptp_ocp_ts_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[0]),
+		.offset = 0x010D0000, .size = 0x10000, .irq_vec = 11,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 1,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[1]),
+		.offset = 0x010E0000, .size = 0x10000, .irq_vec = 12,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 2,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[2]),
+		.offset = 0x010F0000, .size = 0x10000, .irq_vec = 13,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 3,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_EXT_RESOURCE(signal_out[3]),
+		.offset = 0x01100000, .size = 0x10000, .irq_vec = 14,
+		.extra = &(struct ptp_ocp_ext_info) {
+			.index = 4,
+			.irq_fcn = ptp_ocp_signal_irq,
+			.enable = ptp_ocp_signal_enable,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_ext),
+		.offset = 0x01030000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_to_clk),
+		.offset = 0x01040000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(tod),
+		.offset = 0x01050000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(image),
+		.offset = 0x00020000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(pps_select),
+		.offset = 0x00130000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map1),
+		.offset = 0x00140000, .size = 0x1000,
+	},
+	{
+		OCP_MEM_RESOURCE(sma_map2),
+		.offset = 0x00220000, .size = 0x1000,
+	},
+	{
+		OCP_SERIAL_RESOURCE(port[PORT_GNSS]),
+		.offset = 0x00160000 + 0x1000, .irq_vec = 3,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 9600,
+		},
+	},
+	{
+		OCP_SERIAL_RESOURCE(port[PORT_MAC]),
+		.offset = 0x00180000 + 0x1000, .irq_vec = 5,
+		.extra = &(struct ptp_ocp_serial_port) {
+			.baud = 115200,
+		},
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[0]),
+		.offset = 0x01200000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[1]),
+		.offset = 0x01210000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[2]),
+		.offset = 0x01220000, .size = 0x10000,
+	},
+	{
+		OCP_MEM_RESOURCE(freq_in[3]),
+		.offset = 0x01230000, .size = 0x10000,
+	},
+	{
+		OCP_SPI_RESOURCE(spi_flash),
+		.offset = 0x00310000, .size = 0x10000, .irq_vec = 9,
+		.extra = &(struct ptp_ocp_flash_info) {
+			.name = "xilinx_spi", .pci_offset = 0,
+			.data_size = sizeof(struct xspi_platform_data),
+			.data = &(struct xspi_platform_data) {
+				.num_chipselect = 1,
+				.bits_per_word = 8,
+				.num_devices = 1,
+				.force_irq = true,
+				.devices = &(struct spi_board_info) {
+					.modalias = "spi-nor",
+				},
+			},
+		},
+	},
+	{
+		OCP_I2C_RESOURCE(i2c_ctrl),
+		.offset = 0x00150000, .size = 0x10000, .irq_vec = 7,
+		.extra = &(struct ptp_ocp_i2c_info) {
+			.name = "xiic-i2c",
+			.fixed_rate = 50000000,
+			.data_size = sizeof(struct xiic_i2c_platform_data),
+			.data = &(struct xiic_i2c_platform_data) {
+				.num_devices = 2,
+				.devices = (struct i2c_board_info[]) {
+					{ I2C_BOARD_INFO("24c02", 0x50) },
+					{ I2C_BOARD_INFO("24mac402", 0x58),
+					  .platform_data = "mac" },
+				},
+			},
+		},
+	},
+	{
+		.setup = ptp_ocp_adva_board_x1_init,
+		.extra = &(struct ptp_ocp_servo_conf) {
+			.servo_offset_p = 0xc000,
+			.servo_offset_i = 0x1000,
+			.servo_drift_p = 0,
+			.servo_drift_i = 0,
+		},
+	},
+	{ }
+};
+
 static const struct pci_device_id ptp_ocp_pcidev_id[] = {
 	{ PCI_DEVICE_DATA(META, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(CELESTICA, TIMECARD, &ocp_fb_resource) },
 	{ PCI_DEVICE_DATA(OROLIA, ARTCARD, &ocp_art_resource) },
 	{ PCI_DEVICE_DATA(ADVA, TIMECARD, &ocp_adva_resource) },
+	{ PCI_DEVICE_DATA(ADVA, TIMECARD_X1, &ocp_adva_x1_resource) },
 	{ }
 };
 MODULE_DEVICE_TABLE(pci, ptp_ocp_pcidev_id);
@@ -1137,6 +1343,34 @@ static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
 	{ }
 };
 
+static const struct ocp_selector ptp_ocp_adva_x1_sma_in[] = {
+	{ .name = "PPS1",	.value = 0x0001,      .frequency = 1 },
+	{ .name = "TS1",	.value = 0x0004,      .frequency = 0 },
+	{ .name = "TS2",	.value = 0x0008,      .frequency = 0 },
+	{ .name = "TS3",    .value = 0x0040,      .frequency = 0 },
+	{ .name = "TS4",    .value = 0x0080,      .frequency = 0 },
+	{ .name = "FREQ1",	.value = 0x0100,      .frequency = 0 },
+	{ .name = "FREQ2",	.value = 0x0200,      .frequency = 0 },
+	{ .name = "FREQ3",  .value = 0x0400,      .frequency = 0 },
+	{ .name = "FREQ4",  .value = 0x0800,      .frequency = 0 },
+	{ .name = "None",	.value = SMA_DISABLE, .frequency = 0 },
+	{ }
+};
+
+static const struct ocp_selector ptp_ocp_adva_x1_sma_out[] = {
+	{ .name = "10Mhz",	.value = 0x0000,  .frequency = 10000000},
+	{ .name = "PHC",	.value = 0x0001,  .frequency = 1 },
+	{ .name = "MAC",	.value = 0x0002,  .frequency = 1 },
+	{ .name = "GNSS1",	.value = 0x0004,  .frequency = 1 },
+	{ .name = "GEN1",	.value = 0x0040 },
+	{ .name = "GEN2",	.value = 0x0080 },
+	{ .name = "GEN3",	.value = 0x0100 },
+	{ .name = "GEN4",	.value = 0x0200 },
+	{ .name = "GND",	.value = 0x2000 },
+	{ .name = "VCC",	.value = 0x4000 },
+	{ }
+};
+
 struct ocp_sma_op {
 	const struct ocp_selector *tbl[2];
 	void (*init)(struct ptp_ocp *bp);
@@ -2639,6 +2873,14 @@ static const struct ocp_sma_op ocp_adva_sma_op = {
 	.set_output	= ptp_ocp_sma_adva_set_output,
 };
 
+static const struct ocp_sma_op ocp_adva_x1_sma_op = {
+	.tbl		= { ptp_ocp_adva_x1_sma_in, ptp_ocp_adva_x1_sma_out },
+	.init		= ptp_ocp_sma_fb_init,
+	.get		= ptp_ocp_sma_fb_get,
+	.set_inputs	= ptp_ocp_sma_adva_set_inputs,
+	.set_output	= ptp_ocp_sma_adva_set_output,
+};
+
 static int
 ptp_ocp_set_pins(struct ptp_ocp *bp)
 {
@@ -2926,6 +3168,45 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
 	return ptp_ocp_init_clock(bp, r->extra);
 }
 
+/* ADVA specific board X initializers; last "resource" registered. */
+static int
+ptp_ocp_adva_board_x1_init(struct ptp_ocp *bp, struct ocp_resource *r)
+{
+	int err;
+	u32 version;
+
+	bp->flash_start = 0x1000000;
+	bp->eeprom_map = fb_eeprom_map;
+	bp->sma_op = &ocp_adva_x1_sma_op;
+	bp->signals_nr = 4;
+	bp->freq_in_nr = 4;
+
+	version = ioread32(&bp->image->version);
+	/* if lower 16 bits are empty, this is the fw loader. */
+	if ((version & 0xffff) == 0) {
+		version = version >> 16;
+		bp->fw_loader = true;
+	}
+	bp->fw_tag = 3;
+	bp->fw_version = version & 0xffff;
+	bp->fw_cap = OCP_CAP_BASIC | OCP_CAP_SIGNAL | OCP_CAP_FREQ;
+
+	ptp_ocp_tod_init(bp);
+	ptp_ocp_nmea_out_init(bp);
+	ptp_ocp_signal_init(bp);
+
+	err = ptp_ocp_attr_group_add(bp, adva_timecard_x1_groups);
+	if (err)
+		return err;
+
+	err = ptp_ocp_set_pins(bp);
+	if (err)
+		return err;
+	ptp_ocp_sma_init(bp);
+
+	return ptp_ocp_init_clock(bp, r->extra);
+}
+
 static ssize_t
 ptp_ocp_show_output(const struct ocp_selector *tbl, u32 val, char *buf,
 		    int def_val)
@@ -3982,6 +4263,43 @@ static const struct ocp_attr_group adva_timecard_groups[] = {
 	{ },
 };
 
+static struct attribute *adva_timecard_x1_attrs[] = {
+	&dev_attr_serialnum.attr,
+	&dev_attr_gnss_sync.attr,
+	&dev_attr_clock_source.attr,
+	&dev_attr_available_clock_sources.attr,
+	&dev_attr_sma1.attr,
+	&dev_attr_sma2.attr,
+	&dev_attr_sma3.attr,
+	&dev_attr_sma4.attr,
+	&dev_attr_available_sma_inputs.attr,
+	&dev_attr_available_sma_outputs.attr,
+	&dev_attr_clock_status_drift.attr,
+	&dev_attr_clock_status_offset.attr,
+	&dev_attr_ts_window_adjust.attr,
+	&dev_attr_utc_tai_offset.attr,
+	&dev_attr_tod_correction.attr,
+	NULL,
+};
+
+static const struct attribute_group adva_timecard_x1_group = {
+	.attrs = adva_timecard_x1_attrs,
+};
+
+static const struct ocp_attr_group adva_timecard_x1_groups[] = {
+	{ .cap = OCP_CAP_BASIC,	    .group = &adva_timecard_x1_group },
+	{ .cap = OCP_CAP_BASIC,	    .group = &ptp_ocp_timecard_tty_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal0_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal1_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal2_group },
+	{ .cap = OCP_CAP_SIGNAL,    .group = &fb_timecard_signal3_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq0_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq1_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq2_group },
+	{ .cap = OCP_CAP_FREQ,	    .group = &fb_timecard_freq3_group },
+	{ },
+};
+
 static void
 gpio_input_map(char *buf, struct ptp_ocp *bp, u16 map[][2], u16 bit,
 	       const char *def)
-- 
2.47.0


