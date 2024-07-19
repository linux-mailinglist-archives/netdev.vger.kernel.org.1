Return-Path: <netdev+bounces-112211-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 76AF193760F
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 11:46:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6C52B255C8
	for <lists+netdev@lfdr.de>; Fri, 19 Jul 2024 09:46:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D5F586AE3;
	Fri, 19 Jul 2024 09:45:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="yZpwc+xG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 153AC824AF
	for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 09:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721382353; cv=none; b=NUolPu2HtUHPNdycDT4rUNtm8pqkp4OdTNdErY2OmHQX4hcBFm4w5qRmcBWtXzlqyv4vKGyFIbpY/Pjk7yiuIEWdX5+mn3qDndgIkkj3A+0ew6Bn3bPMq5fPwTatZx6381yjwyFkhoLY5fQlZeqKY8pLWpG19OZrJfSQIMuZP6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721382353; c=relaxed/simple;
	bh=eOUi0IeBTEWZ4LJ6rjK5a0xfGZiaGzvCtL140SVme1k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=p2bAkHn5wVYCHxkEJwICzidZ6HH/3Y54zS7igFF46XDq+0kbnb0fhT1Uozc1A0zKn0f6Xe70ntD7RKuwKjrjTQLO17sm6C/WJ5CjGRZP1YOwYHLXVAf33Txi0se1d1slFCRHGwFwZ3/9jpPO6p3ojTXUB5nasiPjBLGQR3jakbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=yZpwc+xG; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1fc49151575so1165865ad.0
        for <netdev@vger.kernel.org>; Fri, 19 Jul 2024 02:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1721382350; x=1721987150; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jyc63DhAsds9my1u5jTRhwrkGNr3acmqIU9G65AUunw=;
        b=yZpwc+xGVLHXdUVsXylH0112wTt6XBUgxQn/VOqmexfhV4FWApxIY6nNuvtfGVq7z+
         ePIIWYaBuWfVS0yLM5GZGg7m3kC5tN26cp2zaWSljLf7D/EJvtggRPhv1oSojqBZbiMc
         kuTdNOP6K6tMlGOx+9Kz87foHQLWFSi+b+g0PTbEdMHeBX3C3LR0wcpYsXU3/naCMP3X
         +KBuCGZ0kkENvWB1btQ7itolb3Bihghb/7doZwAA4ydao5coriW+DODjmpyyXTelkgXm
         eqMeCHYc7EIKFubyy7oI8esV3SNWl1FEXXgkRv2kmwBGe2GH7tJ9NDyHSXwNQX6BqWyn
         ZfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721382350; x=1721987150;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jyc63DhAsds9my1u5jTRhwrkGNr3acmqIU9G65AUunw=;
        b=aeFZR8qeB+GwhWcL+5FPw/43uLIaWTA4Nme/cMF+SwkZCEQlCXQDP5oZXw5ss4BUF6
         FtQ9bDdp33h40qjJxhE1u9ddUmM1gy1jLoEvaQYgpiOe3/u+J4owOuUxmx6zLPvxgPOA
         XUtlLov5zxlOdIGlWsdQHf8lo9AJeYDZ2mAsHQNDu1wOKo+cgi9it0XB9nK+F1YwRGHo
         nS6hKw5uvYxS1DZ4bwEWBWmk/8aHputYSAPznyUU8zNiC5nPSW9Pb94ewb6sS54T1pU5
         WoNB/c5bdd+KLdTbR2fulE3+F2OF5tHrpYZmwkqpUCRv6srBB3jV6G1Mivf7WUjuA+CO
         lX8A==
X-Forwarded-Encrypted: i=1; AJvYcCV7NN8oCHb5XxylxcndzHsYfcvTwqWxXfpNYTNm6cMdrksxTNoH7R1m3eVEaye6/raVj/chiVM852hbxcYlp9Vv8iw6WjJc
X-Gm-Message-State: AOJu0YzMro7JnPhWcWViC6r7LNXUwFKa6Ymr4tuAiVEs6XtLuCLaGTb8
	fo8fL7mOQTVghSAy8u5S5oDfKQpbU2uwHag5ISecXX9nzynP+8mMZ2u/71K8UA==
X-Google-Smtp-Source: AGHT+IFD+1RXHKvtuvKKKF/QwlGwVg9eb2+NGk8HQJO77F0F9d1lDyN6BKrBBr9122fyEql2L5Y+xA==
X-Received: by 2002:a17:902:d50a:b0:1fc:5b41:bac9 with SMTP id d9443c01a7336-1fd5ecadd1cmr14605685ad.7.1721382350211;
        Fri, 19 Jul 2024 02:45:50 -0700 (PDT)
Received: from [127.0.0.1] ([2401:4900:8899:6437:d031:b9ec:7ff1:6aa1])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1fd6f28f67esm819025ad.96.2024.07.19.02.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 02:45:49 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Fri, 19 Jul 2024 15:15:12 +0530
Subject: [PATCH 3/3] greybus: gb-beagleplay: Add firmware upload API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240719-beagleplay_fw_upgrade-v1-3-8664d4513252@beagleboard.org>
References: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
In-Reply-To: <20240719-beagleplay_fw_upgrade-v1-0-8664d4513252@beagleboard.org>
To: jkridner@beagleboard.org, robertcnelson@beagleboard.org, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=21532;
 i=ayush@beagleboard.org; h=from:subject:message-id;
 bh=eOUi0IeBTEWZ4LJ6rjK5a0xfGZiaGzvCtL140SVme1k=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmmjW2RHOknJtQK3mgmQZ3YNy8KKpPiv5QLGsA8
 p+Vi1E3ciGJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZpo1tgAKCRAFzvXHieVa
 dAK2D/9ao/TkUA+2zVFxh+ewWL10zeq7rbjISlUTfhfbXWnhT39PXHgVuM2RvgGOmNsGF34jJF1
 K6QRZ8UrrJW3eXxnyG//I5zw+Vr3utk7767IYwrsLErVAlrh4VTSZNWWjlTAtO8wBJuUPSIB2Ij
 IXvvOwKt2yuiYUXjqb/h8R202gdIYmZiJIqCDjKtDMBproWkXZ9Mh4vKRog1HKRsazPNLJCVm9D
 0UnEr/Y9DlXP+jSYtKz4Ibz3bW1yDyEja30ggtHvZtNFgxHx+XWciozfXQCBXtJ8meTAc5QVYny
 VQYAwacLoMC1+FbIwYg44qeJV1HuQRYqHMytH+5OMbK8blgqR1UoNiXR7j8PMXzeiAK4TbET+Q0
 nFFTHXmn4jPEgBhBx1jdoSjohPAb1NAfF3b/rpLXk4Gx3wjKW3ep6e7IkwU3ttV88A/h7MleVU1
 Nm2juXftukQnGm4emuQPc1V86bpbm1v8L0dbCtJos8Z5UmZWurQnDeRW1cstVbJyX0b0CSD2n/f
 xj1c4+AovaqerOXD2U8hQHyzptFR9uhPTgBZ4bUOIN4Un5TsWLUUZDJOePGsO7exA5nHhA/ZGcc
 X59QFtKvg0oxDB1/PR44xz1+UG+nDZ/bOTkS4IdiJIkhimQb/pQ8JjFw9HfCVZ2EpQoXYDyWMdU
 IKkzyEOEseguBYw==
X-Developer-Key: i=ayush@beagleboard.org; a=openpgp;
 fpr=DFCC131EF24F2D656FA504D605CEF5C789E55A74

Register with firmware upload API to allow updating firmware on cc1352p7
without resorting to overlay for using the userspace flasher.

Communication with the bootloader can be moved out of gb-beagleplay
driver if required, but I am keeping it here since there are no
immediate plans to use the on-board cc1352p7 for anything other than
greybus (BeagleConnect Technology). Additionally, there do not seem to
any other devices using cc1352p7 or it's cousins as a co-processor.

Boot and Reset GPIOs are used to enable cc1352p7 bootloader backdoor for
flashing. The delays while starting bootloader are taken from the
userspace flasher since the technical specification does not provide
sufficient information regarding it.

Flashing is skipped in case we are trying to flash the same
image as the one that is currently present. This is determined by CRC32
calculation of the supplied firmware and Flash data.

We also do a CRC32 check after flashing to ensure that the firmware was
flashed properly.

Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical Specification
Link: https://openbeagle.org/beagleconnect/cc1352-flasher Userspace
Flasher

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/greybus/Kconfig         |   1 +
 drivers/greybus/gb-beagleplay.c | 625 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 614 insertions(+), 12 deletions(-)

diff --git a/drivers/greybus/Kconfig b/drivers/greybus/Kconfig
index ab81ceceb337..d485a99959cb 100644
--- a/drivers/greybus/Kconfig
+++ b/drivers/greybus/Kconfig
@@ -21,6 +21,7 @@ config GREYBUS_BEAGLEPLAY
 	tristate "Greybus BeaglePlay driver"
 	depends on SERIAL_DEV_BUS
 	select CRC_CCITT
+	select FW_UPLOAD
 	help
 	  Select this option if you have a BeaglePlay where CC1352
 	  co-processor acts as Greybus SVC.
diff --git a/drivers/greybus/gb-beagleplay.c b/drivers/greybus/gb-beagleplay.c
index 33f8fad70260..aecbfb5b5eaf 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -6,21 +6,18 @@
  * Copyright (c) 2023 BeagleBoard.org Foundation
  */
 
-#include <linux/gfp.h>
+#include <asm-generic/unaligned.h>
+#include <linux/crc32.h>
+#include <linux/gpio/consumer.h>
+#include <linux/firmware.h>
 #include <linux/greybus.h>
-#include <linux/module.h>
-#include <linux/of.h>
-#include <linux/printk.h>
 #include <linux/serdev.h>
-#include <linux/tty.h>
-#include <linux/tty_driver.h>
-#include <linux/greybus/hd.h>
-#include <linux/init.h>
-#include <linux/device.h>
 #include <linux/crc-ccitt.h>
 #include <linux/circ_buf.h>
-#include <linux/types.h>
-#include <linux/workqueue.h>
+
+#define CC1352_BOOTLOADER_TIMEOUT 2000
+#define CC1352_BOOTLOADER_ACK 0xcc
+#define CC1352_BOOTLOADER_NACK 0x33
 
 #define RX_HDLC_PAYLOAD 256
 #define CRC_LEN 2
@@ -57,6 +54,17 @@
  * @rx_buffer_len: length of receive buffer filled.
  * @rx_buffer: hdlc frame receive buffer
  * @rx_in_esc: hdlc rx flag to indicate ESC frame
+ *
+ * @fwl: underlying firmware upload device
+ * @boot_gpio: cc1352p7 boot gpio
+ * @rst_gpio: cc1352p7 reset gpio
+ * @flashing_mode: flag to indicate that flashing is currently in progress
+ * @fwl_ack_com: completion to signal an Ack/Nack
+ * @fwl_ack: Ack/Nack byte received
+ * @fwl_cmd_response_com: completion to signal a bootloader command response
+ * @fwl_cmd_response: bootloader command response data
+ * @fwl_crc32: crc32 of firmware to flash
+ * @fwl_reset_addr: flag to indicate if we need to send COMMAND_DOWNLOAD again
  */
 struct gb_beagleplay {
 	struct serdev_device *sd;
@@ -72,6 +80,17 @@ struct gb_beagleplay {
 	u16 rx_buffer_len;
 	bool rx_in_esc;
 	u8 rx_buffer[MAX_RX_HDLC];
+
+	struct fw_upload *fwl;
+	struct gpio_desc *boot_gpio;
+	struct gpio_desc *rst_gpio;
+	bool flashing_mode;
+	struct completion fwl_ack_com;
+	u8 fwl_ack;
+	struct completion fwl_cmd_response_com;
+	u32 fwl_cmd_response;
+	u32 fwl_crc32;
+	bool fwl_reset_addr;
 };
 
 /**
@@ -100,6 +119,69 @@ struct hdlc_greybus_frame {
 	u8 payload[];
 } __packed;
 
+/**
+ * enum cc1352_bootloader_cmd: CC1352 Bootloader Commands
+ */
+enum cc1352_bootloader_cmd {
+	COMMAND_DOWNLOAD = 0x21,
+	COMMAND_GET_STATUS = 0x23,
+	COMMAND_SEND_DATA = 0x24,
+	COMMAND_RESET = 0x25,
+	COMMAND_CRC32 = 0x27,
+	COMMAND_BANK_ERASE = 0x2c,
+};
+
+/**
+ * enum cc1352_bootloader_status: CC1352 Bootloader COMMAND_GET_STATUS response
+ */
+enum cc1352_bootloader_status {
+	COMMAND_RET_SUCCESS = 0x40,
+	COMMAND_RET_UNKNOWN_CMD = 0x41,
+	COMMAND_RET_INVALID_CMD = 0x42,
+	COMMAND_RET_INVALID_ADR = 0x43,
+	COMMAND_RET_FLASH_FAIL = 0x44,
+};
+
+/**
+ * struct cc1352_bootloader_packet: CC1352 Bootloader Request Packet
+ *
+ * @len: length of packet + optional request data
+ * @checksum: 8-bit checksum excluding len
+ * @cmd: bootloader command
+ */
+struct cc1352_bootloader_packet {
+	u8 len;
+	u8 checksum;
+	u8 cmd;
+} __packed;
+
+#define CC1352_BOOTLOADER_PKT_MAX_SIZE \
+	(U8_MAX - sizeof(struct cc1352_bootloader_packet))
+
+/**
+ * struct cc1352_bootloader_download_cmd_data: CC1352 Bootloader COMMAND_DOWNLOAD request data
+ *
+ * @addr: address to start programming data into
+ * @size: size of data that will be sent
+ */
+struct cc1352_bootloader_download_cmd_data {
+	__be32 addr;
+	__be32 size;
+} __packed;
+
+/**
+ * struct cc1352_bootloader_crc32_cmd_data: CC1352 Bootloader COMMAND_CRC32 request data
+ *
+ * @addr: address where crc32 calculation starts
+ * @size: number of bytes comprised by crc32 calculation
+ * @read_repeat: number of read repeats for each data location
+ */
+struct cc1352_bootloader_crc32_cmd_data {
+	__be32 addr;
+	__be32 size;
+	__be32 read_repeat;
+} __packed;
+
 static void hdlc_rx_greybus_frame(struct gb_beagleplay *bg, u8 *buf, u16 len)
 {
 	struct hdlc_greybus_frame *gb_frame = (struct hdlc_greybus_frame *)buf;
@@ -331,11 +413,131 @@ static void hdlc_deinit(struct gb_beagleplay *bg)
 	flush_work(&bg->tx_work);
 }
 
+/**
+ * csum8: Calculate 8-bit checksum on data
+ */
+static u8 csum8(const u8 *data, size_t size, u8 base)
+{
+	size_t i;
+	u8 sum = base;
+
+	for (i = 0; i < size; ++i)
+		sum += data[i];
+
+	return sum;
+}
+
+static void cc1352_bootloader_send_ack(struct gb_beagleplay *bg)
+{
+	static const u8 ack[] = { 0x00, CC1352_BOOTLOADER_ACK };
+
+	serdev_device_write_buf(bg->sd, ack, sizeof(ack));
+}
+
+static void cc1352_bootloader_send_nack(struct gb_beagleplay *bg)
+{
+	static const u8 nack[] = { 0x00, CC1352_BOOTLOADER_NACK };
+
+	serdev_device_write_buf(bg->sd, nack, sizeof(nack));
+}
+
+/**
+ * cc1352_bootloader_pkt_rx: Process a CC1352 Bootloader Packet
+ *
+ * @bg: beagleplay greybus driver
+ * @data: packet buffer
+ * @count: packet buffer size
+ *
+ * @return: number of bytes processed
+ *
+ * Here are the steps to successfully receive a packet from cc1352 bootloader
+ * according to the docs:
+ * 1. Wait for nonzero data to be returned from the device. This is important
+ *    as the device may send zero bytes between a sent and a received data
+ *    packet. The first nonzero byte received is the size of the packet that is
+ *    being received.
+ * 2. Read the next byte, which is the checksum for the packet.
+ * 3. Read the data bytes from the device. During the data phase, packet size
+ *    minus 2 bytes is sent.
+ * 4. Calculate the checksum of the data bytes and verify it matches the
+ *    checksum received in the packet.
+ * 5. Send an acknowledge byte or a not-acknowledge byte to the device to
+ *    indicate the successful or unsuccessful reception of the packet.
+ */
+static int cc1352_bootloader_pkt_rx(struct gb_beagleplay *bg, const u8 *data,
+				    size_t count)
+{
+	bool is_valid = false;
+
+	switch (data[0]) {
+	/* Skip 0x00 bytes.  */
+	case 0x00:
+		return 1;
+	case CC1352_BOOTLOADER_ACK:
+	case CC1352_BOOTLOADER_NACK:
+		WRITE_ONCE(bg->fwl_ack, data[0]);
+		complete(&bg->fwl_ack_com);
+		return 1;
+	case 3:
+		if (count < 3)
+			return 0;
+		is_valid = data[1] == data[2];
+		WRITE_ONCE(bg->fwl_cmd_response, (u32)data[2]);
+		break;
+	case 6:
+		if (count < 6)
+			return 0;
+		is_valid = csum8(&data[2], sizeof(__be32), 0) == data[1];
+		WRITE_ONCE(bg->fwl_cmd_response, get_unaligned_be32(&data[2]));
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	if (is_valid) {
+		cc1352_bootloader_send_ack(bg);
+		complete(&bg->fwl_cmd_response_com);
+	} else {
+		dev_warn(&bg->sd->dev,
+			 "Dropping bootloader packet with invalid checksum");
+		cc1352_bootloader_send_nack(bg);
+	}
+
+	return data[0];
+}
+
+static size_t cc1352_bootloader_rx(struct gb_beagleplay *bg, const u8 *data,
+				   size_t count)
+{
+	int ret;
+	size_t off = 0;
+
+	memcpy(bg->rx_buffer + bg->rx_buffer_len, data, count);
+	bg->rx_buffer_len += count;
+
+	do {
+		ret = cc1352_bootloader_pkt_rx(bg, bg->rx_buffer + off,
+					       bg->rx_buffer_len - off);
+		if (ret < 0)
+			return dev_err_probe(&bg->sd->dev, ret,
+					     "Invalid Packet");
+		off += ret;
+	} while (ret > 0 && off < count);
+
+	bg->rx_buffer_len -= off;
+	memmove(bg->rx_buffer, bg->rx_buffer + off, bg->rx_buffer_len);
+
+	return count;
+}
+
 static size_t gb_tty_receive(struct serdev_device *sd, const u8 *data,
 			     size_t count)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(sd);
 
+	if (READ_ONCE(bg->flashing_mode))
+		return cc1352_bootloader_rx(bg, data, count);
+
 	return hdlc_rx(bg, data, count);
 }
 
@@ -343,7 +545,8 @@ static void gb_tty_wakeup(struct serdev_device *serdev)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
 
-	schedule_work(&bg->tx_work);
+	if (!READ_ONCE(bg->flashing_mode))
+		schedule_work(&bg->tx_work);
 }
 
 static struct serdev_device_ops gb_beagleplay_ops = {
@@ -412,6 +615,192 @@ static void gb_beagleplay_stop_svc(struct gb_beagleplay *bg)
 	hdlc_tx_frames(bg, ADDRESS_CONTROL, 0x03, &payload, 1);
 }
 
+static int cc1352_bootloader_wait_for_ack(struct gb_beagleplay *bg)
+{
+	int ret;
+
+	ret = wait_for_completion_timeout(
+		&bg->fwl_ack_com, msecs_to_jiffies(CC1352_BOOTLOADER_TIMEOUT));
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, ret,
+				     "Failed to acquire ack semaphore");
+
+	switch (READ_ONCE(bg->fwl_ack)) {
+	case CC1352_BOOTLOADER_ACK:
+		return 0;
+	case CC1352_BOOTLOADER_NACK:
+		return -EAGAIN;
+	default:
+		return -EINVAL;
+	}
+}
+
+static int cc1352_bootloader_sync(struct gb_beagleplay *bg)
+{
+	static const u8 sync_bytes[] = { 0x55, 0x55 };
+
+	serdev_device_write_buf(bg->sd, sync_bytes, sizeof(sync_bytes));
+	return cc1352_bootloader_wait_for_ack(bg);
+}
+
+static int cc1352_bootloader_get_status(struct gb_beagleplay *bg)
+{
+	int ret;
+	static const struct cc1352_bootloader_packet pkt = {
+		.len = sizeof(pkt),
+		.checksum = COMMAND_GET_STATUS,
+		.cmd = COMMAND_GET_STATUS
+	};
+
+	serdev_device_write_buf(bg->sd, (const u8 *)&pkt, sizeof(pkt));
+	ret = cc1352_bootloader_wait_for_ack(bg);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_timeout(
+		&bg->fwl_cmd_response_com,
+		msecs_to_jiffies(CC1352_BOOTLOADER_TIMEOUT));
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, ret,
+				     "Failed to acquire last status semaphore");
+
+	switch (READ_ONCE(bg->fwl_cmd_response)) {
+	case COMMAND_RET_SUCCESS:
+		return 0;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int cc1352_bootloader_erase(struct gb_beagleplay *bg)
+{
+	int ret;
+	static const struct cc1352_bootloader_packet pkt = {
+		.len = sizeof(pkt),
+		.checksum = COMMAND_BANK_ERASE,
+		.cmd = COMMAND_BANK_ERASE
+	};
+
+	serdev_device_write_buf(bg->sd, (const u8 *)&pkt, sizeof(pkt));
+
+	ret = cc1352_bootloader_wait_for_ack(bg);
+	if (ret < 0)
+		return ret;
+
+	return cc1352_bootloader_get_status(bg);
+}
+
+static int cc1352_bootloader_reset(struct gb_beagleplay *bg)
+{
+	static const struct cc1352_bootloader_packet pkt = {
+		.len = sizeof(pkt),
+		.checksum = COMMAND_RESET,
+		.cmd = COMMAND_RESET
+	};
+
+	serdev_device_write_buf(bg->sd, (const u8 *)&pkt, sizeof(pkt));
+
+	return cc1352_bootloader_wait_for_ack(bg);
+}
+
+/**
+ * cc1352_bootloader_empty_pkt: Calculate the number of empty bytes in the current packet
+ */
+static size_t cc1352_bootloader_empty_pkt(const u8 *data, size_t size)
+{
+	size_t i;
+
+	for (i = 0; i < size && data[i] == 0xff; ++i)
+		continue;
+
+	return i;
+}
+
+static int cc1352_bootloader_crc32(struct gb_beagleplay *bg, u32 *crc32)
+{
+	int ret;
+	static const struct cc1352_bootloader_crc32_cmd_data cmd_data = {
+		.addr = 0, .size = cpu_to_be32(704 * 1024), .read_repeat = 0
+	};
+	const struct cc1352_bootloader_packet pkt = {
+		.len = sizeof(pkt) + sizeof(cmd_data),
+		.checksum = csum8((const void *)&cmd_data, sizeof(cmd_data),
+				  COMMAND_CRC32),
+		.cmd = COMMAND_CRC32
+	};
+
+	serdev_device_write_buf(bg->sd, (const u8 *)&pkt, sizeof(pkt));
+	serdev_device_write_buf(bg->sd, (const u8 *)&cmd_data,
+				sizeof(cmd_data));
+
+	ret = cc1352_bootloader_wait_for_ack(bg);
+	if (ret < 0)
+		return ret;
+
+	ret = wait_for_completion_timeout(
+		&bg->fwl_cmd_response_com,
+		msecs_to_jiffies(CC1352_BOOTLOADER_TIMEOUT));
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, ret,
+				     "Failed to acquire last status semaphore");
+
+	*crc32 = READ_ONCE(bg->fwl_cmd_response);
+
+	return 0;
+}
+
+static int cc1352_bootloader_download(struct gb_beagleplay *bg, u32 size,
+				      u32 addr)
+{
+	int ret;
+	const struct cc1352_bootloader_download_cmd_data cmd_data = {
+		.addr = cpu_to_be32(addr),
+		.size = cpu_to_be32(size),
+	};
+	const struct cc1352_bootloader_packet pkt = {
+		.len = sizeof(pkt) + sizeof(cmd_data),
+		.checksum = csum8((const void *)&cmd_data, sizeof(cmd_data),
+				  COMMAND_DOWNLOAD),
+		.cmd = COMMAND_DOWNLOAD
+	};
+
+	serdev_device_write_buf(bg->sd, (const u8 *)&pkt, sizeof(pkt));
+	serdev_device_write_buf(bg->sd, (const u8 *)&cmd_data,
+				sizeof(cmd_data));
+
+	ret = cc1352_bootloader_wait_for_ack(bg);
+	if (ret < 0)
+		return ret;
+
+	return cc1352_bootloader_get_status(bg);
+}
+
+static int cc1352_bootloader_send_data(struct gb_beagleplay *bg, const u8 *data,
+				       size_t size)
+{
+	int ret, rem = min(size, CC1352_BOOTLOADER_PKT_MAX_SIZE);
+	const struct cc1352_bootloader_packet pkt = {
+		.len = sizeof(pkt) + rem,
+		.checksum = csum8(data, rem, COMMAND_SEND_DATA),
+		.cmd = COMMAND_SEND_DATA
+	};
+
+	serdev_device_write_buf(bg->sd, (const u8 *)&pkt, sizeof(pkt));
+	serdev_device_write_buf(bg->sd, data, rem);
+
+	ret = cc1352_bootloader_wait_for_ack(bg);
+	if (ret < 0)
+		return ret;
+
+	ret = cc1352_bootloader_get_status(bg);
+	if (ret < 0)
+		return ret;
+
+	return rem;
+}
+
 static void gb_greybus_deinit(struct gb_beagleplay *bg)
 {
 	gb_hd_del(bg->gb_hd);
@@ -442,6 +831,154 @@ static int gb_greybus_init(struct gb_beagleplay *bg)
 	return ret;
 }
 
+static enum fw_upload_err cc1352_prepare(struct fw_upload *fw_upload,
+					 const u8 *data, u32 size)
+{
+	int ret;
+	u32 curr_crc32;
+	struct gb_beagleplay *bg = fw_upload->dd_handle;
+
+	dev_info(&bg->sd->dev, "CC1352 Start Flashing...");
+
+	/* Might involve network calls */
+	gb_greybus_deinit(bg);
+	msleep(5 * MSEC_PER_SEC);
+
+	gb_beagleplay_stop_svc(bg);
+	msleep(200);
+	flush_work(&bg->tx_work);
+
+	serdev_device_wait_until_sent(bg->sd, CC1352_BOOTLOADER_TIMEOUT);
+
+	WRITE_ONCE(bg->flashing_mode, true);
+
+	gpiod_direction_output(bg->boot_gpio, 0);
+	gpiod_direction_output(bg->rst_gpio, 0);
+	msleep(200);
+
+	gpiod_set_value(bg->rst_gpio, 1);
+	msleep(200);
+
+	gpiod_set_value(bg->boot_gpio, 1);
+	msleep(200);
+
+	gpiod_direction_input(bg->boot_gpio);
+	gpiod_direction_input(bg->rst_gpio);
+
+	ret = cc1352_bootloader_sync(bg);
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_HW_ERROR,
+				     "Failed to sync");
+
+	ret = cc1352_bootloader_crc32(bg, &curr_crc32);
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_HW_ERROR,
+				     "Failed to fetch crc32");
+
+	bg->fwl_crc32 = crc32(0xffffffff, data, size) ^ 0xffffffff;
+
+	/* Check if attempting to reflash same firmware */
+	if (bg->fwl_crc32 == curr_crc32) {
+		dev_warn(&bg->sd->dev, "Skipping reflashing same image");
+		cc1352_bootloader_reset(bg);
+		WRITE_ONCE(bg->flashing_mode, false);
+		msleep(200);
+		gb_greybus_init(bg);
+		gb_beagleplay_start_svc(bg);
+		return FW_UPLOAD_ERR_FW_INVALID;
+	}
+
+	ret = cc1352_bootloader_erase(bg);
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_HW_ERROR,
+				     "Failed to erase");
+
+	bg->fwl_reset_addr = true;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void cc1352_cleanup(struct fw_upload *fw_upload)
+{
+	struct gb_beagleplay *bg = fw_upload->dd_handle;
+
+	WRITE_ONCE(bg->flashing_mode, false);
+}
+
+static enum fw_upload_err cc1352_write(struct fw_upload *fw_upload,
+				       const u8 *data, u32 offset, u32 size,
+				       u32 *written)
+{
+	int ret;
+	size_t empty_bytes;
+	struct gb_beagleplay *bg = fw_upload->dd_handle;
+
+	/* Skip 0xff packets. Significant performance improvement */
+	empty_bytes = cc1352_bootloader_empty_pkt(data + offset, size);
+	if (empty_bytes >= CC1352_BOOTLOADER_PKT_MAX_SIZE) {
+		bg->fwl_reset_addr = true;
+		*written = empty_bytes;
+		return FW_UPLOAD_ERR_NONE;
+	}
+
+	if (bg->fwl_reset_addr) {
+		ret = cc1352_bootloader_download(bg, size, offset);
+		if (ret < 0)
+			return dev_err_probe(&bg->sd->dev,
+					     FW_UPLOAD_ERR_HW_ERROR,
+					     "Failed to send download cmd");
+
+		bg->fwl_reset_addr = false;
+	}
+
+	ret = cc1352_bootloader_send_data(bg, data + offset, size);
+	if (ret < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_HW_ERROR,
+				     "Failed to flash firmware");
+	*written = ret;
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static enum fw_upload_err cc1352_poll_complete(struct fw_upload *fw_upload)
+{
+	u32 curr_crc32;
+	struct gb_beagleplay *bg = fw_upload->dd_handle;
+
+	if (cc1352_bootloader_crc32(bg, &curr_crc32) < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_HW_ERROR,
+				     "Failed to fetch crc32");
+
+	if (bg->fwl_crc32 != curr_crc32)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_FW_INVALID,
+				     "Invalid CRC32");
+
+	if (cc1352_bootloader_reset(bg) < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_HW_ERROR,
+				     "Failed to reset");
+
+	dev_info(&bg->sd->dev, "CC1352 Flashing Successful");
+	WRITE_ONCE(bg->flashing_mode, false);
+	msleep(200);
+
+	if (gb_greybus_init(bg) < 0)
+		return dev_err_probe(&bg->sd->dev, FW_UPLOAD_ERR_RW_ERROR,
+				     "Failed to initialize greybus");
+
+	gb_beagleplay_start_svc(bg);
+
+	return FW_UPLOAD_ERR_NONE;
+}
+
+static void cc1352_cancel(struct fw_upload *fw_upload)
+{
+	struct gb_beagleplay *bg = fw_upload->dd_handle;
+
+	dev_info(&bg->sd->dev, "CC1352 Bootloader Cancel");
+
+	cc1352_bootloader_reset(bg);
+}
+
 static void gb_serdev_deinit(struct gb_beagleplay *bg)
 {
 	serdev_device_close(bg->sd);
@@ -463,6 +1000,65 @@ static int gb_serdev_init(struct gb_beagleplay *bg)
 	return 0;
 }
 
+static const struct fw_upload_ops cc1352_bootloader_ops = {
+	.prepare = cc1352_prepare,
+	.write = cc1352_write,
+	.poll_complete = cc1352_poll_complete,
+	.cancel = cc1352_cancel,
+	.cleanup = cc1352_cleanup
+};
+
+static int gb_fw_init(struct gb_beagleplay *bg)
+{
+	int ret;
+	struct fw_upload *fwl;
+	struct gpio_desc *desc;
+
+	bg->fwl = NULL;
+	bg->boot_gpio = NULL;
+	bg->rst_gpio = NULL;
+	bg->flashing_mode = false;
+	bg->fwl_cmd_response = 0;
+	bg->fwl_ack = 0;
+	init_completion(&bg->fwl_ack_com);
+	init_completion(&bg->fwl_cmd_response_com);
+
+	desc = devm_gpiod_get(&bg->sd->dev, "boot", GPIOD_IN);
+	if (IS_ERR(desc))
+		return PTR_ERR(fwl);
+	bg->boot_gpio = desc;
+
+	desc = devm_gpiod_get(&bg->sd->dev, "reset", GPIOD_IN);
+	if (IS_ERR(desc)) {
+		ret = PTR_ERR(desc);
+		goto free_boot;
+	}
+	bg->rst_gpio = desc;
+
+	fwl = firmware_upload_register(THIS_MODULE, &bg->sd->dev, "cc1352p7",
+				       &cc1352_bootloader_ops, bg);
+	if (IS_ERR(fwl)) {
+		ret = PTR_ERR(fwl);
+		goto free_reset;
+	}
+	bg->fwl = fwl;
+
+	return 0;
+
+free_reset:
+	devm_gpiod_put(&bg->sd->dev, bg->rst_gpio);
+	bg->rst_gpio = NULL;
+free_boot:
+	devm_gpiod_put(&bg->sd->dev, bg->boot_gpio);
+	bg->boot_gpio = NULL;
+	return ret;
+}
+
+static void gb_fw_deinit(struct gb_beagleplay *bg)
+{
+	firmware_upload_unregister(bg->fwl);
+}
+
 static int gb_beagleplay_probe(struct serdev_device *serdev)
 {
 	int ret = 0;
@@ -481,6 +1077,10 @@ static int gb_beagleplay_probe(struct serdev_device *serdev)
 	if (ret)
 		goto free_serdev;
 
+	ret = gb_fw_init(bg);
+	if (ret)
+		goto free_hdlc;
+
 	ret = gb_greybus_init(bg);
 	if (ret)
 		goto free_hdlc;
@@ -500,6 +1100,7 @@ static void gb_beagleplay_remove(struct serdev_device *serdev)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
 
+	gb_fw_deinit(bg);
 	gb_greybus_deinit(bg);
 	gb_beagleplay_stop_svc(bg);
 	hdlc_deinit(bg);

-- 
2.45.2


