Return-Path: <netdev+bounces-121736-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3E8F95E476
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 18:48:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DCC4EB21449
	for <lists+netdev@lfdr.de>; Sun, 25 Aug 2024 16:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CE6D16F0EC;
	Sun, 25 Aug 2024 16:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b="Qt4kRR8d"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF29E16EC0E
	for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 16:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724604470; cv=none; b=YgTYASnx71qigmxLXTQpmSltrvSOgygxlI9biVtkA7YMYKaynqK7Jy3oB/ZpGYNoKH5qcxQCPJNTnoLU/+howXnI+d4InVS8FIoCZadvxb4QE8jw97UNqJ3cx42I/1oOJJdw23fmrS8HMmdRZLuYRjFnYsKWaa5ua3cmv0pZMbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724604470; c=relaxed/simple;
	bh=0I67kHfHcP6Y+hwrYr20Lj8j7TKIjwMeA4v2DVoqZwg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KWFaGIi7u0kuC1LoE9zD6kHoqUayaJIKbvmCt3JQaPo2lP34nFU+YF58Vk+fah3Biv61sSuCmk07nGr1L3LvyVja6HTd6IMhQR6RG+5StG6V0nD/8GhgxmKXmhVf3kugjXCT4QuL+Sb1zHPkC6ZmFmjagsdTF/GQgG5lTFY9UHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org; spf=fail smtp.mailfrom=beagleboard.org; dkim=pass (2048-bit key) header.d=beagleboard-org.20230601.gappssmtp.com header.i=@beagleboard-org.20230601.gappssmtp.com header.b=Qt4kRR8d; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=beagleboard.org
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=beagleboard.org
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-7106cf5771bso2831896b3a.2
        for <netdev@vger.kernel.org>; Sun, 25 Aug 2024 09:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=beagleboard-org.20230601.gappssmtp.com; s=20230601; t=1724604468; x=1725209268; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HqKJOoYh+6QDm3mjDAuqJ+dWyDs9Vqx8ITMW9/hp9Qo=;
        b=Qt4kRR8diTjjRYpBT4u5RV1ifbEezEzM0DrfeIUO+EQK7MN5hKKI2SuawEOY90+++t
         K1Q3civRLpLBDLvn749crBuSGzSzII43PunwYHX4e2A5snMHhktyIb/9vomFAGPcpdBO
         XQYSKAcKee+m34AABzNWOiSTwJY/KPwlf/LpiSNIiuGrXfx3UU4naFAlC8Kk+kWSlRmC
         Y1ulQ5gC3FFd1+T2n6DIaddHPmD+fI5TLiy4e4Yy0toOMYsw+eAz6jwEFdH8Un8Qy7Yn
         2ZFnVCszAyF+r9d8YCSa4Io/HL6f3LndAlCTX0MPlmstLSxKfaNggEtTJYm6Dq2Ks8K9
         VFqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724604468; x=1725209268;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqKJOoYh+6QDm3mjDAuqJ+dWyDs9Vqx8ITMW9/hp9Qo=;
        b=NJZfBo9Q/KC7hqMdyZZQ5HqT/Khv66OMjRoyuq57AjVwPgHO07pZsSWuxjjIigLLFQ
         8ECSouoUvR4uQX3kPFRndgJoHfy5/qOel1iDfndR1vxTGThLQw0Lp9ZLNYPhblwFLad3
         0DJnnhxBpEVYEJEiCQzz/OYrM6MieSR3zcFaXCYhBhvRY4fLKDSTB1tCDYmeGBi1rwD2
         JkAM+Q0pfsJnVuHazVQzhscwnl2F6qujyrNkgHTEDmDPK+bM68S94/1ofyOLzCIkTD7+
         dyQlZsOHVJ06rdlsOD5i/Y7M5tNLkO7izKHAnH2HGLJH4iLy5kANe3UTwBQ9ip4PLh5U
         qQUA==
X-Forwarded-Encrypted: i=1; AJvYcCXp+z2T0R/24pFBP+iBCYImFQfTir90Aw4z6pUAjmvhd4ajT/51U5hTW0A5L8qpHOWnjxOHCh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxETqV2DT3Uw8qMSAxft45qoFJKYhUAL0gqvq/nnSjVNw4daud8
	KMvbdGfrf7/W574lAB1waPDRbO+hybDp487qmCPBRyOMK3RBjt/Ciqmh1rbhJQ==
X-Google-Smtp-Source: AGHT+IHSE2nbY33FtwmcxzqEXHO1j70tS4H6m0teS2r/RePG63LhRbQ/xr/Q7F8+QVgIarEkK7LAsw==
X-Received: by 2002:a05:6a20:9c93:b0:1c8:fdc7:8813 with SMTP id adf61e73a8af0-1cc89dbac1bmr8408747637.23.1724604467986;
        Sun, 25 Aug 2024 09:47:47 -0700 (PDT)
Received: from [192.168.41.46] ([2401:4900:5ae1:9eb1:890a:6b80:a16d:5ab4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20385609dddsm55411465ad.196.2024.08.25.09.47.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Aug 2024 09:47:47 -0700 (PDT)
From: Ayush Singh <ayush@beagleboard.org>
Date: Sun, 25 Aug 2024 22:17:07 +0530
Subject: [PATCH v3 3/3] greybus: gb-beagleplay: Add firmware upload API
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240825-beagleplay_fw_upgrade-v3-3-8f424a9de9f6@beagleboard.org>
References: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
In-Reply-To: <20240825-beagleplay_fw_upgrade-v3-0-8f424a9de9f6@beagleboard.org>
To: lorforlinux@beagleboard.org, jkridner@beagleboard.org, 
 robertcnelson@beagleboard.org, "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Tero Kristo <kristo@kernel.org>, 
 Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: greybus-dev@lists.linaro.org, netdev@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, Ayush Singh <ayush@beagleboard.org>
X-Mailer: b4 0.14.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=23155;
 i=ayush@beagleboard.org; h=from:subject:message-id;
 bh=0I67kHfHcP6Y+hwrYr20Lj8j7TKIjwMeA4v2DVoqZwg=;
 b=owEBbQKS/ZANAwAIAQXO9ceJ5Vp0AcsmYgBmy2ARQ9eU4YWDUcXKkzSx9jLn5Fy95jW0R+k40
 HX/zBUJKrGJAjMEAAEIAB0WIQTfzBMe8k8tZW+lBNYFzvXHieVadAUCZstgEQAKCRAFzvXHieVa
 dH+eD/wMJBEKBLrbodHl7EEq26YlwYObCZqMQ85ZOA5jSrPlktbZG2am2xzjm1Rcyh7mZRkbj+1
 nRE0w2iUKMvAGzQQ2ZnL/HgH1Kdl62Tv3oGfrYINqQLo5rRIH0UxVjff2KTMsEIm2GMREwnJx0T
 7hCKQ/vasX7+uW2uSsjfcelmI6595uO3NxDPExclRKc0QL88LeIXt3gQjUPd4+H3PBDuBUcKiz5
 SxLFrNpE8CYZty2n3Z1WJHr6r3hW0w4Bv736dTFAOJJg70CzWFGYv3VRIOur7k9dBBWhYhplJUi
 vJNrGTZakdRQLfwuAjiFmhQzo68+1mfWZbuogOHKIWhtdZbDnmced3zVMLgaz6JJ+OnULWDt7Gc
 2dr7x/0EpgM4MlcCHc2gkX6nkNRAs8LeFeLP1hyKRcuStfs4frVOezvI8ol2aOVsbJ+3AYXHlJz
 gT3KJeRvUqaY9wXK9GDr3pZ+GrUQuEJAQJTjYEyFLaaysz5p7OfXUBlz4IqJfApfrnW7NFcZPaX
 dkPU/+I/6+rqXHimnBP7nYT2M3IJXkrrktzIsQCibgyBgnqPWmh8QN+natfdRWeTd564OBbJuXC
 LINjuvi1yDWUSwLcwddZJBBWR4TJoRyGv/PjhgPmUhMRjawUK/yAVFPnEpFM1457TKzQweHWCVC
 5xQAhyvp6kf/KnA==
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

Firmware size should be 704 KB.

Link: https://www.ti.com/lit/ug/swcu192/swcu192.pdf Ti CC1352p7 Tecnical Specification
Link: https://openbeagle.org/beagleconnect/cc1352-flasher Userspace
Flasher

Signed-off-by: Ayush Singh <ayush@beagleboard.org>
---
 drivers/greybus/Kconfig         |   1 +
 drivers/greybus/gb-beagleplay.c | 658 +++++++++++++++++++++++++++++++++++++++-
 2 files changed, 646 insertions(+), 13 deletions(-)

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
index 33f8fad70260..3a1ade84737c 100644
--- a/drivers/greybus/gb-beagleplay.c
+++ b/drivers/greybus/gb-beagleplay.c
@@ -6,21 +6,19 @@
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
+#define CC1352_FIRMWARE_SIZE (704 * 1024)
+#define CC1352_BOOTLOADER_TIMEOUT 2000
+#define CC1352_BOOTLOADER_ACK 0xcc
+#define CC1352_BOOTLOADER_NACK 0x33
 
 #define RX_HDLC_PAYLOAD 256
 #define CRC_LEN 2
@@ -57,6 +55,17 @@
  * @rx_buffer_len: length of receive buffer filled.
  * @rx_buffer: hdlc frame receive buffer
  * @rx_in_esc: hdlc rx flag to indicate ESC frame
+ *
+ * @fwl: underlying firmware upload device
+ * @bootloader_backdoor_gpio: cc1352p7 boot gpio
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
@@ -72,6 +81,17 @@ struct gb_beagleplay {
 	u16 rx_buffer_len;
 	bool rx_in_esc;
 	u8 rx_buffer[MAX_RX_HDLC];
+
+	struct fw_upload *fwl;
+	struct gpio_desc *bootloader_backdoor_gpio;
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
@@ -100,6 +120,87 @@ struct hdlc_greybus_frame {
 	u8 payload[];
 } __packed;
 
+/**
+ * enum cc1352_bootloader_cmd: CC1352 Bootloader Commands
+ *
+ * @COMMAND_DOWNLOAD: Prepares flash programming
+ * @COMMAND_GET_STATUS: Returns the status of the last command that was  issued
+ * @COMMAND_SEND_DATA: Transfers data and programs flash
+ * @COMMAND_RESET: Performs a system reset
+ * @COMMAND_CRC32: Calculates CRC32 over a specified memory area
+ * @COMMAND_BANK_ERASE: Performs an erase of all of the customer-accessible
+ *                      flash sectors not protected by FCFG1 and CCFG
+ *                      writeprotect bits.
+ *
+ * CC1352 Bootloader serial bus commands
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
+ *
+ * @COMMAND_RET_SUCCESS: Status for successful command
+ * @COMMAND_RET_UNKNOWN_CMD: Status for unknown command
+ * @COMMAND_RET_INVALID_CMD: Status for invalid command (in other words,
+ *                           incorrect packet size)
+ * @COMMAND_RET_INVALID_ADR: Status for invalid input address
+ * @COMMAND_RET_FLASH_FAIL: Status for failing flash erase or program operation
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
@@ -331,11 +432,135 @@ static void hdlc_deinit(struct gb_beagleplay *bg)
 	flush_work(&bg->tx_work);
 }
 
+/**
+ * csum8: Calculate 8-bit checksum on data
+ *
+ * @data: bytes to calculate 8-bit checksum of
+ * @size: number of bytes
+ * @base: starting value for checksum
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
 
@@ -343,7 +568,8 @@ static void gb_tty_wakeup(struct serdev_device *serdev)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
 
-	schedule_work(&bg->tx_work);
+	if (!READ_ONCE(bg->flashing_mode))
+		schedule_work(&bg->tx_work);
 }
 
 static struct serdev_device_ops gb_beagleplay_ops = {
@@ -412,6 +638,195 @@ static void gb_beagleplay_stop_svc(struct gb_beagleplay *bg)
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
+ *
+ * @data: packet bytes array to check
+ * @size: number of bytes in array
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
@@ -442,6 +857,157 @@ static int gb_greybus_init(struct gb_beagleplay *bg)
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
+	if (size != CC1352_FIRMWARE_SIZE)
+		return FW_UPLOAD_ERR_INVALID_SIZE;
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
+	gpiod_direction_output(bg->bootloader_backdoor_gpio, 0);
+	gpiod_direction_output(bg->rst_gpio, 0);
+	msleep(200);
+
+	gpiod_set_value(bg->rst_gpio, 1);
+	msleep(200);
+
+	gpiod_set_value(bg->bootloader_backdoor_gpio, 1);
+	msleep(200);
+
+	gpiod_direction_input(bg->bootloader_backdoor_gpio);
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
@@ -463,6 +1029,65 @@ static int gb_serdev_init(struct gb_beagleplay *bg)
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
+	bg->bootloader_backdoor_gpio = NULL;
+	bg->rst_gpio = NULL;
+	bg->flashing_mode = false;
+	bg->fwl_cmd_response = 0;
+	bg->fwl_ack = 0;
+	init_completion(&bg->fwl_ack_com);
+	init_completion(&bg->fwl_cmd_response_com);
+
+	desc = devm_gpiod_get(&bg->sd->dev, "bootloader-backdoor", GPIOD_IN);
+	if (IS_ERR(desc))
+		return PTR_ERR(desc);
+	bg->bootloader_backdoor_gpio = desc;
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
+	devm_gpiod_put(&bg->sd->dev, bg->bootloader_backdoor_gpio);
+	bg->bootloader_backdoor_gpio = NULL;
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
@@ -481,14 +1106,20 @@ static int gb_beagleplay_probe(struct serdev_device *serdev)
 	if (ret)
 		goto free_serdev;
 
-	ret = gb_greybus_init(bg);
+	ret = gb_fw_init(bg);
 	if (ret)
 		goto free_hdlc;
 
+	ret = gb_greybus_init(bg);
+	if (ret)
+		goto free_fw;
+
 	gb_beagleplay_start_svc(bg);
 
 	return 0;
 
+free_fw:
+	gb_fw_deinit(bg);
 free_hdlc:
 	hdlc_deinit(bg);
 free_serdev:
@@ -500,6 +1131,7 @@ static void gb_beagleplay_remove(struct serdev_device *serdev)
 {
 	struct gb_beagleplay *bg = serdev_device_get_drvdata(serdev);
 
+	gb_fw_deinit(bg);
 	gb_greybus_deinit(bg);
 	gb_beagleplay_stop_svc(bg);
 	hdlc_deinit(bg);

-- 
2.46.0


