Return-Path: <netdev+bounces-258464-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GCv1A2/rjWnG8gAAu9opvQ
	(envelope-from <netdev+bounces-258464-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:02:07 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64A8912EB90
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 16:02:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F1DA23077212
	for <lists+netdev@lfdr.de>; Thu, 12 Feb 2026 15:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7297835CB8F;
	Thu, 12 Feb 2026 15:00:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RCbTKVLW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8F3717C220
	for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 15:00:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770908420; cv=none; b=T0Ct+TlS4KAbN64FuXbJ2pjXjYQGQheRzCfBbu39whdZWRKx+WaPa8ePU8Sj83gDaUNI0eIwXC9q2HBD1nGHhuKjPzBzvHXoza8KFtZ9TT7VKc2IqZBqQU6p+X4ULR7NawgmYdIkR9aLCaOvXu9IjWmPG93YvOwPZ33VnoPiE9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770908420; c=relaxed/simple;
	bh=Gg1yRjRA/eUBpU9/Krqz2Cdk0QEo9yoYCCfWG7WPwAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iLcuLNVuqJZRjy9oGxKTW1yjzVn2CWyj3dH7Ux+fspZvyesyOrQ+qpmK5V2JQll4PcSrQd4J7NFx9msVTjdhoZ71Xnr9Z4nB8fRSzyg1pKg5JrYgY7XdBETHAfLvW0XJwzHGfBN+4nXNoGk1E0WsvdVuEMmRkb2dzZF6Fid8o9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RCbTKVLW; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-436e87589e8so4408834f8f.3
        for <netdev@vger.kernel.org>; Thu, 12 Feb 2026 07:00:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770908417; x=1771513217; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=An+1kJUAIGNhzzmZlVTiy8K8oJ6z4LO1tolxkdeyVeo=;
        b=RCbTKVLW9VgdS/pNhuWqrT9mLYPOzbSBoDZVC6DsKS3D8DDGveOstDJl6rXxnn2nHQ
         yBezwyEvir39nyuLL0haDuOPhISv93e7eDp8yXQOXhbtdQH5jHveVTvyrFjuCMvVabVd
         juT/J/xZ1ZBacI7KbMzY1B5XeoVrlTI8DBsQvqhf9of+io3QIovFT7UStX3v45Vsw4sd
         vT+IwDq1QZK5aNkC/hrRggrnjZyEmhb0vjyEOKRBLUC4lMIyeODwkXM4pelmR4/RXrhb
         MI5MPmyXHvWllsOpLu6BY2uA3xq3ZMOJTEOIOm3D/BrX94AizMDdqWzuT1r9Y2aowjRi
         GfQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770908417; x=1771513217;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=An+1kJUAIGNhzzmZlVTiy8K8oJ6z4LO1tolxkdeyVeo=;
        b=YGHCUiZv7RtUfi37BsR6QFft8fwO6OLGYJp7Tt+GPR56TGbFCoPyuugOiecICzbhNK
         sKcWT9/LJNBxsERb2cEL7Wnr/KXalvC2q9qcgVqu9kWSiRQeTnBVbMUMxFGQ9imFNfmD
         K2xjjRGXfxOzPsts3nZryi7WvtmkI1xQ8EJFVnHxfIlA31GXCQRSCKAVhEu/Y6jR+hw0
         hSgSjhjMoRrPuRrQm7ihFoNX2528qkiAp3QO7rkX22ZvqwCCTMrPOQhRhB9j1x2WHbs0
         E99Mg7EC2Ow63wiG0sIEqpKuwSwVQvSXJfMG/EgXsdisTfnUQkiKIT/sekeSdlZKrORA
         V6Hw==
X-Forwarded-Encrypted: i=1; AJvYcCXm4d9t3Lm/usCsiq2XW/YRpObpCmVm5dS0KqZoUv+Fhk2rEhUgud+7rQc1iI6dRI7QxGiiBP0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPln1gtazgOxKm+MF+0kDZG93g7PbT+8BhDLZVeGENYBbSFQc8
	0euO6eJ40aw/yGRnjgIuOCGI88mH6CxrjkrgfaBJWENW/uETFuQvbALQ
X-Gm-Gg: AZuq6aJLZNmaAkoDyMgKMyF7HlkRmFti6pG/dV7nN4+Kzw2lWn6RuMtGfwpkzqQ9nxj
	FxM4wIfKKrwdjEw31YZfRI4Jl5+QP2iMikXi5w6Gj/+a5/VIE5XO8SroUlSJ+W2Qna0CTNDQY1f
	Wc0H7otk4qSNRnN4jh+3cEfHHjgl24LnBD28zbNtfC71lkOyaBzKxeXIdQUebiiu/0pOOfxEEPq
	afQ+FJy4nSW9HGVbAltc/ewWtwzzZ7fOoP9NiBALSK+zvsYel1cELXMYWOe3QfvCwzphZcxCX2m
	faEGzEq8fSD7AWom2N2zxFQ0gTCwsI0NKMc9GeZcjxLaC/yvD7X60Th2dpixf10/6/KRmiwFtnh
	TUCy0fz7d0Jj4NvaRB/jOL8hXDyviOf/w46FRjLvRPmMQCPxGDVvBh6KRDhqm2uY/z/zE0sR1Ny
	eZzw4ANw0VRQ7zL7oBsYRSjjyQOdsl/c1ssTO881BiJwsGKw==
X-Received: by 2002:a05:6000:2903:b0:431:35a:4a8f with SMTP id ffacd0b85a97d-4378ada9afdmr5737341f8f.47.1770908416644;
        Thu, 12 Feb 2026 07:00:16 -0800 (PST)
Received: from fedora.advaoptical.com ([82.166.23.19])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43783dfc8b9sm12573651f8f.24.2026.02.12.07.00.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 07:00:16 -0800 (PST)
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
Subject: [PATCH v1] ptp: ocp: Add Xilinx-based Adva Timecard support
Date: Thu, 12 Feb 2026 17:00:07 +0200
Message-ID: <20260212150007.6628-1-maimon.sagi@gmail.com>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-258464-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,linux.dev,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maimonsagi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 64A8912EB90
X-Rspamd-Action: no action

Add support for the Adva TimeCard variant that uses a Xilinx-based
design. This patch introduces the necessary handling to identify and
integrate this hardware into the existing OCP timecard framework.

The new variant reuses the common code paths already present in the
driver, requiring only minimal additions.

Signed-off-by: Sagi Maimon <maimon.sagi@gmail.com>
---
 drivers/ptp/ptp_ocp.c | 318 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 318 insertions(+)

diff --git a/drivers/ptp/ptp_ocp.c b/drivers/ptp/ptp_ocp.c
index 65fe05cac8c4..d436380442c6 100644
--- a/drivers/ptp/ptp_ocp.c
+++ b/drivers/ptp/ptp_ocp.c
@@ -35,6 +35,7 @@
 
 #define PCI_VENDOR_ID_ADVA			0xad5a
 #define PCI_DEVICE_ID_ADVA_TIMECARD		0x0400
+#define PCI_DEVICE_ID_ADVA_TIMECARD_X1	0x0410
 
 static struct class timecard_class = {
 	.name		= "timecard",
@@ -418,12 +419,16 @@ static int ptp_ocp_art_board_init(struct ptp_ocp *bp, struct ocp_resource *r);
 
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
@@ -1028,11 +1033,212 @@ static struct ocp_resource ocp_adva_resource[] = {
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
@@ -1135,6 +1341,34 @@ static const struct ocp_selector ptp_ocp_adva_sma_out[] = {
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
@@ -2638,6 +2872,14 @@ static const struct ocp_sma_op ocp_adva_sma_op = {
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
@@ -2925,6 +3167,45 @@ ptp_ocp_adva_board_init(struct ptp_ocp *bp, struct ocp_resource *r)
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
@@ -3981,6 +4262,43 @@ static const struct ocp_attr_group adva_timecard_groups[] = {
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


