Return-Path: <netdev+bounces-225964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EB926B99F97
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 15:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CBD0D1B215F8
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 13:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D102FE060;
	Wed, 24 Sep 2025 13:07:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTt/PIDx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A6CE2FD1A8
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 13:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758719268; cv=none; b=vAqMUJCQvULtA7dGoHjEfG42rRIj9wm+U/p4SpQWCJi/NR7LmFeutrGqBrxNqHAXpO6Szgyk3g3NsgPXT42gH9zXbkdFOKjzKzAWLPUabKkPmR33fpXnF3Tyr5SMQqExaCWu1jAINDYAply2yiq1WTLFofGm1v8pUur2uCuP+Oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758719268; c=relaxed/simple;
	bh=j1HerbvfSDHT5jOm2n8S0eSIbsbBrcgfsInzOudsH8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZhM0KjfBLs1x46zdlziKYFUdKmP/dqul0G9GJcduavBQ9NFf3YFhX9ObM6nsEha7sOeAaAi8GQF+RxKsusYHbmXE+GhcJO9avIriaZGbh4U/GK0NJs++dT8KznJ5PqUVMql1QIVu/K6p1PMQpFU3N5fRDO+N3oFsHyLTQGv1hG8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTt/PIDx; arc=none smtp.client-ip=209.85.215.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-b551b040930so3342112a12.2
        for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 06:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758719265; x=1759324065; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4HXMorKXoJ830Su8TdABPr27nkY+/vpjs962BAcE8yw=;
        b=CTt/PIDxGjUr6fNCjZEOT3857JweALEa4EbBA4fXdLflprqOsO3zgazTdKyAoThkgI
         ucjAdqeIwcFDtdAtlCkR8Zz2d248YkVc6tBNXpzx5Qx9zFNbYb+q/hS+H6OtGjujhhxW
         lF0obA6jGjKaPJxwbI6Tdv0L+xKjrETY1FL3U/EMe97ciZJ39xyfVef1KzHFY1kL0Is/
         KTnq1osZNxddjgYFGFaLZz7+86V7ag1dbJ/Bvh729WN1kCdSewPUa4AWFHZJgKBeailZ
         CfAYt2LzvNKC2RKki5yd8bQrvKLwBaldBxv1bdJhhtKIJ/yIeqASA/PCtHeciwpGRtkk
         QPJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758719265; x=1759324065;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4HXMorKXoJ830Su8TdABPr27nkY+/vpjs962BAcE8yw=;
        b=uR+eZL6foSDfLzZEhqcD1PBrbz6lDhiKsEB/UjZjzu1HXIlO7XuJFg642D2yOmUq7g
         mpDxjl25B0wlOkpCp8Zt4F7FR5Q756qksscRqp+XbqpbgIjNGMUqcuvu5ZHX/5Syxu67
         iynOAe+Vww8Kmzl/YOiQI0IyqH5RAat77JXZXr2RE1OejJYAMhGlp22j+bzXakC+3pzM
         3C5aSZN6E4aPRpzXRvv66uIIhcvc9v2SQgKC/p7EGzsEAf9KWsKqDoNKEWIFI77wJaEI
         r2xmpj70zrUUnah6QGBkFJ5M1HxlnhFLD8mhQoBdbtxhqDgYh+6sPllpkeIh64Ovr+tG
         kd3w==
X-Forwarded-Encrypted: i=1; AJvYcCUbUZ0CGbraDgsqJDx13LrYM4ydEmcnOrRuHjBGtjViCI7nSYQhLM7tnMyGUTL0XRXbBTIXpCM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyzpmbka4/6NmNSG13xxdIRcgqVKiZTZgyqpCvCc9CyJbnloiOg
	1oT+K4J7nbP8ZzT5Cgv8bLwTfD2JekYEAmi37HRxFpqSm/jknbw0YPlY
X-Gm-Gg: ASbGncuPhmN/gRRj97cP3By0iaiY2D6ssSqUzCOMnLKN6xmCgVfTGcGPLVXmNqhBpTg
	+OAWZ8CdwVsQsJwBzXv2MTpEVs+GNX+afJfGcXc3sRpS34ax/k2cpkJYT+weHnoXqqZZvJUUy/w
	gRISAAkRHtKRSNsHthtuN80CegiBoICLEqTPyYHrk9iOgW4m84ZTjXewT2bKABEs92S368z+O8y
	NBA8Zpjz5mwrJDUwp9pOkTOvtS89hBlAwwth8faQkuFThvcHq9LWZC0z4z74zO1DTNa1aneSQnK
	nFNrnSMNcmLRYupNX6wqyr0h4u6bNUmMm5EFinmRSSJLEsHU86h/cILR6CpzjbRZ1qXOb0NPi17
	d4tt6Q2+gXSVg5V/A17vTN0qaizsaMhVqRXlnzstlKtoEz3EXtnH13ltYkjc6C0ynkekbLK6HNF
	vdKSLrwJLOVGWka1XsBb1FL1s=
X-Google-Smtp-Source: AGHT+IG40tEKVfNiGz20PBS8/HG8czxb9rKZpkgIg22E1VhntUn88kkRCpVDyFHqJ6MQL1nnOTBGEg==
X-Received: by 2002:a17:902:ced2:b0:24c:e3bf:b456 with SMTP id d9443c01a7336-27cc1b38bfbmr72025665ad.15.1758719264183;
        Wed, 24 Sep 2025 06:07:44 -0700 (PDT)
Received: from debian.domain.name ([223.181.105.88])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-269802debfcsm192099115ad.86.2025.09.24.06.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Sep 2025 06:07:43 -0700 (PDT)
From: I Viswanath <viswanathiyyappan@gmail.com>
To: kuba@kernel.org
Cc: viswanathiyyappan@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	david.hunter.linux@gmail.com,
	edumazet@google.com,
	linux-kernel-mentees@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	linux-usb@vger.kernel.org,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	petkan@nucleusys.com,
	skhan@linuxfoundation.org
Subject: [PATCH net v2] net: usb: remove rtl8150 driver
Date: Wed, 24 Sep 2025 18:37:22 +0530
Message-ID: <20250924130722.260004-1-viswanathiyyappan@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <CAPrAcgOzf4XYGA8X6TneRrmVwYVYgF=KvnpmRbT6XA+D9HR6jQ@mail.gmail.com>
References: <CAPrAcgOzf4XYGA8X6TneRrmVwYVYgF=KvnpmRbT6XA+D9HR6jQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Remove the rtl8150 driver, as the most recent device ID was added
on 2006-12-04

Signed-off-by: I Viswanath <viswanathiyyappan@gmail.com>
---
 Link to the relevant conversation: https://lore.kernel.org/netdev/20250922180742.6ef6e2d5@kernel.org/
 
 MAINTAINERS               |   9 -
 drivers/net/usb/Kconfig   |  11 -
 drivers/net/usb/Makefile  |   1 -
 drivers/net/usb/rtl8150.c | 980 --------------------------------------
 4 files changed, 1001 deletions(-)
 delete mode 100644 drivers/net/usb/rtl8150.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 520fb4e379a3..32fc364c57f5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -26163,15 +26163,6 @@ F:	Documentation/usb/raw-gadget.rst
 F:	drivers/usb/gadget/legacy/raw_gadget.c
 F:	include/uapi/linux/usb/raw_gadget.h
 
-USB RTL8150 DRIVER
-M:	Petko Manolov <petkan@nucleusys.com>
-L:	linux-usb@vger.kernel.org
-L:	netdev@vger.kernel.org
-S:	Maintained
-W:	https://github.com/petkan/rtl8150
-T:	git https://github.com/petkan/rtl8150.git
-F:	drivers/net/usb/rtl8150.c
-
 USB SERIAL SUBSYSTEM
 M:	Johan Hovold <johan@kernel.org>
 L:	linux-usb@vger.kernel.org
diff --git a/drivers/net/usb/Kconfig b/drivers/net/usb/Kconfig
index 0a678e31cfaa..6354953be279 100644
--- a/drivers/net/usb/Kconfig
+++ b/drivers/net/usb/Kconfig
@@ -85,17 +85,6 @@ config USB_PEGASUS
 	  To compile this driver as a module, choose M here: the
 	  module will be called pegasus.
 
-config USB_RTL8150
-	tristate "USB RTL8150 based ethernet device support"
-	select MII
-	help
-	  Say Y here if you have RTL8150 based usb-ethernet adapter.
-	  Send me <petkan@users.sourceforge.net> any comments you may have.
-	  You can also check for updates at <http://pegasus2.sourceforge.net/>.
-
-	  To compile this driver as a module, choose M here: the
-	  module will be called rtl8150.
-
 config USB_RTL8152
 	tristate "Realtek RTL8152/RTL8153 Based USB Ethernet Adapters"
 	select MII
diff --git a/drivers/net/usb/Makefile b/drivers/net/usb/Makefile
index 4964f7b326fb..d0f50ed1179e 100644
--- a/drivers/net/usb/Makefile
+++ b/drivers/net/usb/Makefile
@@ -6,7 +6,6 @@
 obj-$(CONFIG_USB_CATC)		+= catc.o
 obj-$(CONFIG_USB_KAWETH)	+= kaweth.o
 obj-$(CONFIG_USB_PEGASUS)	+= pegasus.o
-obj-$(CONFIG_USB_RTL8150)	+= rtl8150.o
 obj-$(CONFIG_USB_RTL8152)	+= r8152.o
 obj-$(CONFIG_USB_HSO)		+= hso.o
 obj-$(CONFIG_USB_LAN78XX)	+= lan78xx.o
diff --git a/drivers/net/usb/rtl8150.c b/drivers/net/usb/rtl8150.c
deleted file mode 100644
index ddff6f19ff98..000000000000
--- a/drivers/net/usb/rtl8150.c
+++ /dev/null
@@ -1,980 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- *  Copyright (c) 2002 Petko Manolov (petkan@users.sourceforge.net)
- */
-
-#include <linux/signal.h>
-#include <linux/slab.h>
-#include <linux/module.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/mii.h>
-#include <linux/ethtool.h>
-#include <linux/usb.h>
-#include <linux/uaccess.h>
-
-/* Version Information */
-#define DRIVER_VERSION "v0.6.2 (2004/08/27)"
-#define DRIVER_AUTHOR "Petko Manolov <petkan@users.sourceforge.net>"
-#define DRIVER_DESC "rtl8150 based usb-ethernet driver"
-
-#define	IDR			0x0120
-#define	MAR			0x0126
-#define	CR			0x012e
-#define	TCR			0x012f
-#define	RCR			0x0130
-#define	TSR			0x0132
-#define	RSR			0x0133
-#define	CON0			0x0135
-#define	CON1			0x0136
-#define	MSR			0x0137
-#define	PHYADD			0x0138
-#define	PHYDAT			0x0139
-#define	PHYCNT			0x013b
-#define	GPPC			0x013d
-#define	BMCR			0x0140
-#define	BMSR			0x0142
-#define	ANAR			0x0144
-#define	ANLP			0x0146
-#define	AER			0x0148
-#define CSCR			0x014C  /* This one has the link status */
-#define CSCR_LINK_STATUS	(1 << 3)
-
-#define	IDR_EEPROM		0x1202
-
-#define	PHY_READ		0
-#define	PHY_WRITE		0x20
-#define	PHY_GO			0x40
-
-#define	MII_TIMEOUT		10
-#define	INTBUFSIZE		8
-
-#define	RTL8150_REQT_READ	0xc0
-#define	RTL8150_REQT_WRITE	0x40
-#define	RTL8150_REQ_GET_REGS	0x05
-#define	RTL8150_REQ_SET_REGS	0x05
-
-
-/* Transmit status register errors */
-#define TSR_ECOL		(1<<5)
-#define TSR_LCOL		(1<<4)
-#define TSR_LOSS_CRS		(1<<3)
-#define TSR_JBR			(1<<2)
-#define TSR_ERRORS		(TSR_ECOL | TSR_LCOL | TSR_LOSS_CRS | TSR_JBR)
-/* Receive status register errors */
-#define RSR_CRC			(1<<2)
-#define RSR_FAE			(1<<1)
-#define RSR_ERRORS		(RSR_CRC | RSR_FAE)
-
-/* Media status register definitions */
-#define MSR_DUPLEX		(1<<4)
-#define MSR_SPEED		(1<<3)
-#define MSR_LINK		(1<<2)
-
-/* USB endpoints */
-enum rtl8150_usb_ep {
-	RTL8150_USB_EP_CONTROL = 0,
-	RTL8150_USB_EP_BULK_IN = 1,
-	RTL8150_USB_EP_BULK_OUT = 2,
-	RTL8150_USB_EP_INT_IN = 3,
-};
-
-/* Interrupt pipe data */
-#define INT_TSR			0x00
-#define INT_RSR			0x01
-#define INT_MSR			0x02
-#define INT_WAKSR		0x03
-#define INT_TXOK_CNT		0x04
-#define INT_RXLOST_CNT		0x05
-#define INT_CRERR_CNT		0x06
-#define INT_COL_CNT		0x07
-
-
-#define	RTL8150_MTU		1540
-#define	RTL8150_TX_TIMEOUT	(HZ)
-#define	RX_SKB_POOL_SIZE	4
-
-/* rtl8150 flags */
-#define	RTL8150_HW_CRC		0
-#define	RX_REG_SET		1
-#define	RTL8150_UNPLUG		2
-#define	RX_URB_FAIL		3
-
-/* Define these values to match your device */
-#define	VENDOR_ID_REALTEK		0x0bda
-#define	VENDOR_ID_MELCO			0x0411
-#define	VENDOR_ID_MICRONET		0x3980
-#define	VENDOR_ID_LONGSHINE		0x07b8
-#define	VENDOR_ID_OQO			0x1557
-#define	VENDOR_ID_ZYXEL			0x0586
-
-#define PRODUCT_ID_RTL8150		0x8150
-#define	PRODUCT_ID_LUAKTX		0x0012
-#define	PRODUCT_ID_LCS8138TX		0x401a
-#define PRODUCT_ID_SP128AR		0x0003
-#define	PRODUCT_ID_PRESTIGE		0x401a
-
-#undef	EEPROM_WRITE
-
-/* table of devices that work with this driver */
-static const struct usb_device_id rtl8150_table[] = {
-	{USB_DEVICE(VENDOR_ID_REALTEK, PRODUCT_ID_RTL8150)},
-	{USB_DEVICE(VENDOR_ID_MELCO, PRODUCT_ID_LUAKTX)},
-	{USB_DEVICE(VENDOR_ID_MICRONET, PRODUCT_ID_SP128AR)},
-	{USB_DEVICE(VENDOR_ID_LONGSHINE, PRODUCT_ID_LCS8138TX)},
-	{USB_DEVICE(VENDOR_ID_OQO, PRODUCT_ID_RTL8150)},
-	{USB_DEVICE(VENDOR_ID_ZYXEL, PRODUCT_ID_PRESTIGE)},
-	{}
-};
-
-MODULE_DEVICE_TABLE(usb, rtl8150_table);
-
-struct rtl8150 {
-	unsigned long flags;
-	struct usb_device *udev;
-	struct tasklet_struct tl;
-	struct net_device *netdev;
-	struct urb *rx_urb, *tx_urb, *intr_urb;
-	struct sk_buff *tx_skb, *rx_skb;
-	struct sk_buff *rx_skb_pool[RX_SKB_POOL_SIZE];
-	spinlock_t rx_pool_lock;
-	struct usb_ctrlrequest dr;
-	int intr_interval;
-	u8 *intr_buff;
-	u8 phy;
-};
-
-typedef struct rtl8150 rtl8150_t;
-
-struct async_req {
-	struct usb_ctrlrequest dr;
-	u16 rx_creg;
-};
-
-static const char driver_name [] = "rtl8150";
-
-/*
-**
-**	device related part of the code
-**
-*/
-static int get_registers(rtl8150_t * dev, u16 indx, u16 size, void *data)
-{
-	return usb_control_msg_recv(dev->udev, 0, RTL8150_REQ_GET_REGS,
-				    RTL8150_REQT_READ, indx, 0, data, size,
-				    1000, GFP_NOIO);
-}
-
-static int set_registers(rtl8150_t * dev, u16 indx, u16 size, const void *data)
-{
-	return usb_control_msg_send(dev->udev, 0, RTL8150_REQ_SET_REGS,
-				    RTL8150_REQT_WRITE, indx, 0, data, size,
-				    1000, GFP_NOIO);
-}
-
-static void async_set_reg_cb(struct urb *urb)
-{
-	struct async_req *req = (struct async_req *)urb->context;
-	int status = urb->status;
-
-	if (status < 0)
-		dev_dbg(&urb->dev->dev, "%s failed with %d", __func__, status);
-	kfree(req);
-	usb_free_urb(urb);
-}
-
-static int async_set_registers(rtl8150_t *dev, u16 indx, u16 size, u16 reg)
-{
-	int res = -ENOMEM;
-	struct urb *async_urb;
-	struct async_req *req;
-
-	req = kmalloc(sizeof(struct async_req), GFP_ATOMIC);
-	if (req == NULL)
-		return res;
-	async_urb = usb_alloc_urb(0, GFP_ATOMIC);
-	if (async_urb == NULL) {
-		kfree(req);
-		return res;
-	}
-	req->rx_creg = cpu_to_le16(reg);
-	req->dr.bRequestType = RTL8150_REQT_WRITE;
-	req->dr.bRequest = RTL8150_REQ_SET_REGS;
-	req->dr.wIndex = 0;
-	req->dr.wValue = cpu_to_le16(indx);
-	req->dr.wLength = cpu_to_le16(size);
-	usb_fill_control_urb(async_urb, dev->udev,
-	                     usb_sndctrlpipe(dev->udev, 0), (void *)&req->dr,
-			     &req->rx_creg, size, async_set_reg_cb, req);
-	res = usb_submit_urb(async_urb, GFP_ATOMIC);
-	if (res) {
-		if (res == -ENODEV)
-			netif_device_detach(dev->netdev);
-		dev_err(&dev->udev->dev, "%s failed with %d\n", __func__, res);
-	}
-	return res;
-}
-
-static int read_mii_word(rtl8150_t * dev, u8 phy, __u8 indx, u16 * reg)
-{
-	int i;
-	u8 data[3], tmp;
-
-	data[0] = phy;
-	data[1] = data[2] = 0;
-	tmp = indx | PHY_READ | PHY_GO;
-	i = 0;
-
-	set_registers(dev, PHYADD, sizeof(data), data);
-	set_registers(dev, PHYCNT, 1, &tmp);
-	do {
-		get_registers(dev, PHYCNT, 1, data);
-	} while ((data[0] & PHY_GO) && (i++ < MII_TIMEOUT));
-
-	if (i <= MII_TIMEOUT) {
-		get_registers(dev, PHYDAT, 2, data);
-		*reg = data[0] | (data[1] << 8);
-		return 0;
-	} else
-		return 1;
-}
-
-static int write_mii_word(rtl8150_t * dev, u8 phy, __u8 indx, u16 reg)
-{
-	int i;
-	u8 data[3], tmp;
-
-	data[0] = phy;
-	data[1] = reg & 0xff;
-	data[2] = (reg >> 8) & 0xff;
-	tmp = indx | PHY_WRITE | PHY_GO;
-	i = 0;
-
-	set_registers(dev, PHYADD, sizeof(data), data);
-	set_registers(dev, PHYCNT, 1, &tmp);
-	do {
-		get_registers(dev, PHYCNT, 1, data);
-	} while ((data[0] & PHY_GO) && (i++ < MII_TIMEOUT));
-
-	if (i <= MII_TIMEOUT)
-		return 0;
-	else
-		return 1;
-}
-
-static void set_ethernet_addr(rtl8150_t *dev)
-{
-	u8 node_id[ETH_ALEN];
-	int ret;
-
-	ret = get_registers(dev, IDR, sizeof(node_id), node_id);
-
-	if (!ret) {
-		eth_hw_addr_set(dev->netdev, node_id);
-	} else {
-		eth_hw_addr_random(dev->netdev);
-		netdev_notice(dev->netdev, "Assigned a random MAC address: %pM\n",
-			      dev->netdev->dev_addr);
-	}
-}
-
-static int rtl8150_set_mac_address(struct net_device *netdev, void *p)
-{
-	struct sockaddr *addr = p;
-	rtl8150_t *dev = netdev_priv(netdev);
-
-	if (netif_running(netdev))
-		return -EBUSY;
-
-	eth_hw_addr_set(netdev, addr->sa_data);
-	netdev_dbg(netdev, "Setting MAC address to %pM\n", netdev->dev_addr);
-	/* Set the IDR registers. */
-	set_registers(dev, IDR, netdev->addr_len, netdev->dev_addr);
-#ifdef EEPROM_WRITE
-	{
-	int i;
-	u8 cr;
-	/* Get the CR contents. */
-	get_registers(dev, CR, 1, &cr);
-	/* Set the WEPROM bit (eeprom write enable). */
-	cr |= 0x20;
-	set_registers(dev, CR, 1, &cr);
-	/* Write the MAC address into eeprom. Eeprom writes must be word-sized,
-	   so we need to split them up. */
-	for (i = 0; i * 2 < netdev->addr_len; i++) {
-		set_registers(dev, IDR_EEPROM + (i * 2), 2,
-		netdev->dev_addr + (i * 2));
-	}
-	/* Clear the WEPROM bit (preventing accidental eeprom writes). */
-	cr &= 0xdf;
-	set_registers(dev, CR, 1, &cr);
-	}
-#endif
-	return 0;
-}
-
-static int rtl8150_reset(rtl8150_t * dev)
-{
-	u8 data = 0x10;
-	int i = HZ;
-
-	set_registers(dev, CR, 1, &data);
-	do {
-		get_registers(dev, CR, 1, &data);
-	} while ((data & 0x10) && --i);
-
-	return (i > 0) ? 1 : 0;
-}
-
-static int alloc_all_urbs(rtl8150_t * dev)
-{
-	dev->rx_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->rx_urb)
-		return 0;
-	dev->tx_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->tx_urb) {
-		usb_free_urb(dev->rx_urb);
-		return 0;
-	}
-	dev->intr_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!dev->intr_urb) {
-		usb_free_urb(dev->rx_urb);
-		usb_free_urb(dev->tx_urb);
-		return 0;
-	}
-
-	return 1;
-}
-
-static void free_all_urbs(rtl8150_t * dev)
-{
-	usb_free_urb(dev->rx_urb);
-	usb_free_urb(dev->tx_urb);
-	usb_free_urb(dev->intr_urb);
-}
-
-static void unlink_all_urbs(rtl8150_t * dev)
-{
-	usb_kill_urb(dev->rx_urb);
-	usb_kill_urb(dev->tx_urb);
-	usb_kill_urb(dev->intr_urb);
-}
-
-static inline struct sk_buff *pull_skb(rtl8150_t *dev)
-{
-	struct sk_buff *skb;
-	int i;
-
-	for (i = 0; i < RX_SKB_POOL_SIZE; i++) {
-		if (dev->rx_skb_pool[i]) {
-			skb = dev->rx_skb_pool[i];
-			dev->rx_skb_pool[i] = NULL;
-			return skb;
-		}
-	}
-	return NULL;
-}
-
-static void read_bulk_callback(struct urb *urb)
-{
-	rtl8150_t *dev;
-	unsigned pkt_len, res;
-	struct sk_buff *skb;
-	struct net_device *netdev;
-	int status = urb->status;
-	int result;
-	unsigned long flags;
-
-	dev = urb->context;
-	if (!dev)
-		return;
-	if (test_bit(RTL8150_UNPLUG, &dev->flags))
-		return;
-	netdev = dev->netdev;
-	if (!netif_device_present(netdev))
-		return;
-
-	switch (status) {
-	case 0:
-		break;
-	case -ENOENT:
-		return;	/* the urb is in unlink state */
-	case -ETIME:
-		if (printk_ratelimit())
-			dev_warn(&urb->dev->dev, "may be reset is needed?..\n");
-		goto goon;
-	default:
-		if (printk_ratelimit())
-			dev_warn(&urb->dev->dev, "Rx status %d\n", status);
-		goto goon;
-	}
-
-	if (!dev->rx_skb)
-		goto resched;
-	/* protect against short packets (tell me why we got some?!?) */
-	if (urb->actual_length < 4)
-		goto goon;
-
-	res = urb->actual_length;
-	pkt_len = res - 4;
-
-	skb_put(dev->rx_skb, pkt_len);
-	dev->rx_skb->protocol = eth_type_trans(dev->rx_skb, netdev);
-	netif_rx(dev->rx_skb);
-	netdev->stats.rx_packets++;
-	netdev->stats.rx_bytes += pkt_len;
-
-	spin_lock_irqsave(&dev->rx_pool_lock, flags);
-	skb = pull_skb(dev);
-	spin_unlock_irqrestore(&dev->rx_pool_lock, flags);
-	if (!skb)
-		goto resched;
-
-	dev->rx_skb = skb;
-goon:
-	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
-		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
-	result = usb_submit_urb(dev->rx_urb, GFP_ATOMIC);
-	if (result == -ENODEV)
-		netif_device_detach(dev->netdev);
-	else if (result) {
-		set_bit(RX_URB_FAIL, &dev->flags);
-		goto resched;
-	} else {
-		clear_bit(RX_URB_FAIL, &dev->flags);
-	}
-
-	return;
-resched:
-	tasklet_schedule(&dev->tl);
-}
-
-static void write_bulk_callback(struct urb *urb)
-{
-	rtl8150_t *dev;
-	int status = urb->status;
-
-	dev = urb->context;
-	if (!dev)
-		return;
-	dev_kfree_skb_irq(dev->tx_skb);
-	if (!netif_device_present(dev->netdev))
-		return;
-	if (status)
-		dev_info(&urb->dev->dev, "%s: Tx status %d\n",
-			 dev->netdev->name, status);
-	netif_trans_update(dev->netdev);
-	netif_wake_queue(dev->netdev);
-}
-
-static void intr_callback(struct urb *urb)
-{
-	rtl8150_t *dev;
-	__u8 *d;
-	int status = urb->status;
-	int res;
-
-	dev = urb->context;
-	if (!dev)
-		return;
-	switch (status) {
-	case 0:			/* success */
-		break;
-	case -ECONNRESET:	/* unlink */
-	case -ENOENT:
-	case -ESHUTDOWN:
-		return;
-	/* -EPIPE:  should clear the halt */
-	default:
-		dev_info(&urb->dev->dev, "%s: intr status %d\n",
-			 dev->netdev->name, status);
-		goto resubmit;
-	}
-
-	d = urb->transfer_buffer;
-	if (d[0] & TSR_ERRORS) {
-		dev->netdev->stats.tx_errors++;
-		if (d[INT_TSR] & (TSR_ECOL | TSR_JBR))
-			dev->netdev->stats.tx_aborted_errors++;
-		if (d[INT_TSR] & TSR_LCOL)
-			dev->netdev->stats.tx_window_errors++;
-		if (d[INT_TSR] & TSR_LOSS_CRS)
-			dev->netdev->stats.tx_carrier_errors++;
-	}
-	/* Report link status changes to the network stack */
-	if ((d[INT_MSR] & MSR_LINK) == 0) {
-		if (netif_carrier_ok(dev->netdev)) {
-			netif_carrier_off(dev->netdev);
-			netdev_dbg(dev->netdev, "%s: LINK LOST\n", __func__);
-		}
-	} else {
-		if (!netif_carrier_ok(dev->netdev)) {
-			netif_carrier_on(dev->netdev);
-			netdev_dbg(dev->netdev, "%s: LINK CAME BACK\n", __func__);
-		}
-	}
-
-resubmit:
-	res = usb_submit_urb (urb, GFP_ATOMIC);
-	if (res == -ENODEV)
-		netif_device_detach(dev->netdev);
-	else if (res)
-		dev_err(&dev->udev->dev,
-			"can't resubmit intr, %s-%s/input0, status %d\n",
-			dev->udev->bus->bus_name, dev->udev->devpath, res);
-}
-
-static int rtl8150_suspend(struct usb_interface *intf, pm_message_t message)
-{
-	rtl8150_t *dev = usb_get_intfdata(intf);
-
-	netif_device_detach(dev->netdev);
-
-	if (netif_running(dev->netdev)) {
-		usb_kill_urb(dev->rx_urb);
-		usb_kill_urb(dev->intr_urb);
-	}
-	return 0;
-}
-
-static int rtl8150_resume(struct usb_interface *intf)
-{
-	rtl8150_t *dev = usb_get_intfdata(intf);
-
-	netif_device_attach(dev->netdev);
-	if (netif_running(dev->netdev)) {
-		dev->rx_urb->status = 0;
-		dev->rx_urb->actual_length = 0;
-		read_bulk_callback(dev->rx_urb);
-
-		dev->intr_urb->status = 0;
-		dev->intr_urb->actual_length = 0;
-		intr_callback(dev->intr_urb);
-	}
-	return 0;
-}
-
-/*
-**
-**	network related part of the code
-**
-*/
-
-static void fill_skb_pool(rtl8150_t *dev)
-{
-	struct sk_buff *skb;
-	int i;
-
-	for (i = 0; i < RX_SKB_POOL_SIZE; i++) {
-		if (dev->rx_skb_pool[i])
-			continue;
-		skb = dev_alloc_skb(RTL8150_MTU + 2);
-		if (!skb) {
-			return;
-		}
-		skb_reserve(skb, 2);
-		dev->rx_skb_pool[i] = skb;
-	}
-}
-
-static void free_skb_pool(rtl8150_t *dev)
-{
-	int i;
-
-	for (i = 0; i < RX_SKB_POOL_SIZE; i++)
-		dev_kfree_skb(dev->rx_skb_pool[i]);
-}
-
-static void rx_fixup(struct tasklet_struct *t)
-{
-	struct rtl8150 *dev = from_tasklet(dev, t, tl);
-	struct sk_buff *skb;
-	int status;
-
-	spin_lock_irq(&dev->rx_pool_lock);
-	fill_skb_pool(dev);
-	spin_unlock_irq(&dev->rx_pool_lock);
-	if (test_bit(RX_URB_FAIL, &dev->flags))
-		if (dev->rx_skb)
-			goto try_again;
-	spin_lock_irq(&dev->rx_pool_lock);
-	skb = pull_skb(dev);
-	spin_unlock_irq(&dev->rx_pool_lock);
-	if (skb == NULL)
-		goto tlsched;
-	dev->rx_skb = skb;
-	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
-		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
-try_again:
-	status = usb_submit_urb(dev->rx_urb, GFP_ATOMIC);
-	if (status == -ENODEV) {
-		netif_device_detach(dev->netdev);
-	} else if (status) {
-		set_bit(RX_URB_FAIL, &dev->flags);
-		goto tlsched;
-	} else {
-		clear_bit(RX_URB_FAIL, &dev->flags);
-	}
-
-	return;
-tlsched:
-	tasklet_schedule(&dev->tl);
-}
-
-static int enable_net_traffic(rtl8150_t * dev)
-{
-	u8 cr, tcr, rcr, msr;
-
-	if (!rtl8150_reset(dev)) {
-		dev_warn(&dev->udev->dev, "device reset failed\n");
-	}
-	/* RCR bit7=1 attach Rx info at the end;  =0 HW CRC (which is broken) */
-	rcr = 0x9e;
-	tcr = 0xd8;
-	cr = 0x0c;
-	if (!(rcr & 0x80))
-		set_bit(RTL8150_HW_CRC, &dev->flags);
-	set_registers(dev, RCR, 1, &rcr);
-	set_registers(dev, TCR, 1, &tcr);
-	set_registers(dev, CR, 1, &cr);
-	get_registers(dev, MSR, 1, &msr);
-
-	return 0;
-}
-
-static void disable_net_traffic(rtl8150_t * dev)
-{
-	u8 cr;
-
-	get_registers(dev, CR, 1, &cr);
-	cr &= 0xf3;
-	set_registers(dev, CR, 1, &cr);
-}
-
-static void rtl8150_tx_timeout(struct net_device *netdev, unsigned int txqueue)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	dev_warn(&netdev->dev, "Tx timeout.\n");
-	usb_unlink_urb(dev->tx_urb);
-	netdev->stats.tx_errors++;
-}
-
-static void rtl8150_set_multicast(struct net_device *netdev)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	u16 rx_creg = 0x9e;
-
-	netif_stop_queue(netdev);
-	if (netdev->flags & IFF_PROMISC) {
-		rx_creg |= 0x0001;
-		dev_info(&netdev->dev, "%s: promiscuous mode\n", netdev->name);
-	} else if (!netdev_mc_empty(netdev) ||
-		   (netdev->flags & IFF_ALLMULTI)) {
-		rx_creg &= 0xfffe;
-		rx_creg |= 0x0002;
-		dev_dbg(&netdev->dev, "%s: allmulti set\n", netdev->name);
-	} else {
-		/* ~RX_MULTICAST, ~RX_PROMISCUOUS */
-		rx_creg &= 0x00fc;
-	}
-	async_set_registers(dev, RCR, sizeof(rx_creg), rx_creg);
-	netif_wake_queue(netdev);
-}
-
-static netdev_tx_t rtl8150_start_xmit(struct sk_buff *skb,
-					    struct net_device *netdev)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	int count, res;
-
-	netif_stop_queue(netdev);
-	count = (skb->len < 60) ? 60 : skb->len;
-	count = (count & 0x3f) ? count : count + 1;
-	dev->tx_skb = skb;
-	usb_fill_bulk_urb(dev->tx_urb, dev->udev, usb_sndbulkpipe(dev->udev, 2),
-		      skb->data, count, write_bulk_callback, dev);
-	if ((res = usb_submit_urb(dev->tx_urb, GFP_ATOMIC))) {
-		/* Can we get/handle EPIPE here? */
-		if (res == -ENODEV)
-			netif_device_detach(dev->netdev);
-		else {
-			dev_warn(&netdev->dev, "failed tx_urb %d\n", res);
-			netdev->stats.tx_errors++;
-			netif_start_queue(netdev);
-		}
-	} else {
-		netdev->stats.tx_packets++;
-		netdev->stats.tx_bytes += skb->len;
-		netif_trans_update(netdev);
-	}
-
-	return NETDEV_TX_OK;
-}
-
-
-static void set_carrier(struct net_device *netdev)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	short tmp;
-
-	get_registers(dev, CSCR, 2, &tmp);
-	if (tmp & CSCR_LINK_STATUS)
-		netif_carrier_on(netdev);
-	else
-		netif_carrier_off(netdev);
-}
-
-static int rtl8150_open(struct net_device *netdev)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	int res;
-
-	if (dev->rx_skb == NULL)
-		dev->rx_skb = pull_skb(dev);
-	if (!dev->rx_skb)
-		return -ENOMEM;
-
-	set_registers(dev, IDR, 6, netdev->dev_addr);
-
-	usb_fill_bulk_urb(dev->rx_urb, dev->udev, usb_rcvbulkpipe(dev->udev, 1),
-		      dev->rx_skb->data, RTL8150_MTU, read_bulk_callback, dev);
-	if ((res = usb_submit_urb(dev->rx_urb, GFP_KERNEL))) {
-		if (res == -ENODEV)
-			netif_device_detach(dev->netdev);
-		dev_warn(&netdev->dev, "rx_urb submit failed: %d\n", res);
-		return res;
-	}
-	usb_fill_int_urb(dev->intr_urb, dev->udev, usb_rcvintpipe(dev->udev, 3),
-		     dev->intr_buff, INTBUFSIZE, intr_callback,
-		     dev, dev->intr_interval);
-	if ((res = usb_submit_urb(dev->intr_urb, GFP_KERNEL))) {
-		if (res == -ENODEV)
-			netif_device_detach(dev->netdev);
-		dev_warn(&netdev->dev, "intr_urb submit failed: %d\n", res);
-		usb_kill_urb(dev->rx_urb);
-		return res;
-	}
-	enable_net_traffic(dev);
-	set_carrier(netdev);
-	netif_start_queue(netdev);
-
-	return res;
-}
-
-static int rtl8150_close(struct net_device *netdev)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-
-	netif_stop_queue(netdev);
-	if (!test_bit(RTL8150_UNPLUG, &dev->flags))
-		disable_net_traffic(dev);
-	unlink_all_urbs(dev);
-
-	return 0;
-}
-
-static void rtl8150_get_drvinfo(struct net_device *netdev, struct ethtool_drvinfo *info)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-
-	strscpy(info->driver, driver_name, sizeof(info->driver));
-	strscpy(info->version, DRIVER_VERSION, sizeof(info->version));
-	usb_make_path(dev->udev, info->bus_info, sizeof(info->bus_info));
-}
-
-static int rtl8150_get_link_ksettings(struct net_device *netdev,
-				      struct ethtool_link_ksettings *ecmd)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	short lpa = 0;
-	short bmcr = 0;
-	u32 supported;
-
-	supported = (SUPPORTED_10baseT_Half |
-			  SUPPORTED_10baseT_Full |
-			  SUPPORTED_100baseT_Half |
-			  SUPPORTED_100baseT_Full |
-			  SUPPORTED_Autoneg |
-			  SUPPORTED_TP | SUPPORTED_MII);
-	ecmd->base.port = PORT_TP;
-	ecmd->base.phy_address = dev->phy;
-	get_registers(dev, BMCR, 2, &bmcr);
-	get_registers(dev, ANLP, 2, &lpa);
-	if (bmcr & BMCR_ANENABLE) {
-		u32 speed = ((lpa & (LPA_100HALF | LPA_100FULL)) ?
-			     SPEED_100 : SPEED_10);
-		ecmd->base.speed = speed;
-		ecmd->base.autoneg = AUTONEG_ENABLE;
-		if (speed == SPEED_100)
-			ecmd->base.duplex = (lpa & LPA_100FULL) ?
-			    DUPLEX_FULL : DUPLEX_HALF;
-		else
-			ecmd->base.duplex = (lpa & LPA_10FULL) ?
-			    DUPLEX_FULL : DUPLEX_HALF;
-	} else {
-		ecmd->base.autoneg = AUTONEG_DISABLE;
-		ecmd->base.speed = ((bmcr & BMCR_SPEED100) ?
-					     SPEED_100 : SPEED_10);
-		ecmd->base.duplex = (bmcr & BMCR_FULLDPLX) ?
-		    DUPLEX_FULL : DUPLEX_HALF;
-	}
-
-	ethtool_convert_legacy_u32_to_link_mode(ecmd->link_modes.supported,
-						supported);
-
-	return 0;
-}
-
-static const struct ethtool_ops ops = {
-	.get_drvinfo = rtl8150_get_drvinfo,
-	.get_link = ethtool_op_get_link,
-	.get_link_ksettings = rtl8150_get_link_ksettings,
-};
-
-static int rtl8150_siocdevprivate(struct net_device *netdev, struct ifreq *rq,
-				  void __user *udata, int cmd)
-{
-	rtl8150_t *dev = netdev_priv(netdev);
-	u16 *data = (u16 *) & rq->ifr_ifru;
-	int res = 0;
-
-	switch (cmd) {
-	case SIOCDEVPRIVATE:
-		data[0] = dev->phy;
-		fallthrough;
-	case SIOCDEVPRIVATE + 1:
-		read_mii_word(dev, dev->phy, (data[1] & 0x1f), &data[3]);
-		break;
-	case SIOCDEVPRIVATE + 2:
-		if (!capable(CAP_NET_ADMIN))
-			return -EPERM;
-		write_mii_word(dev, dev->phy, (data[1] & 0x1f), data[2]);
-		break;
-	default:
-		res = -EOPNOTSUPP;
-	}
-
-	return res;
-}
-
-static const struct net_device_ops rtl8150_netdev_ops = {
-	.ndo_open		= rtl8150_open,
-	.ndo_stop		= rtl8150_close,
-	.ndo_siocdevprivate	= rtl8150_siocdevprivate,
-	.ndo_start_xmit		= rtl8150_start_xmit,
-	.ndo_tx_timeout		= rtl8150_tx_timeout,
-	.ndo_set_rx_mode	= rtl8150_set_multicast,
-	.ndo_set_mac_address	= rtl8150_set_mac_address,
-
-	.ndo_validate_addr	= eth_validate_addr,
-};
-
-static int rtl8150_probe(struct usb_interface *intf,
-			 const struct usb_device_id *id)
-{
-	struct usb_device *udev = interface_to_usbdev(intf);
-	rtl8150_t *dev;
-	struct net_device *netdev;
-	static const u8 bulk_ep_addr[] = {
-		RTL8150_USB_EP_BULK_IN | USB_DIR_IN,
-		RTL8150_USB_EP_BULK_OUT | USB_DIR_OUT,
-		0};
-	static const u8 int_ep_addr[] = {
-		RTL8150_USB_EP_INT_IN | USB_DIR_IN,
-		0};
-
-	netdev = alloc_etherdev(sizeof(rtl8150_t));
-	if (!netdev)
-		return -ENOMEM;
-
-	dev = netdev_priv(netdev);
-
-	dev->intr_buff = kmalloc(INTBUFSIZE, GFP_KERNEL);
-	if (!dev->intr_buff) {
-		free_netdev(netdev);
-		return -ENOMEM;
-	}
-
-	/* Verify that all required endpoints are present */
-	if (!usb_check_bulk_endpoints(intf, bulk_ep_addr) ||
-	    !usb_check_int_endpoints(intf, int_ep_addr)) {
-		dev_err(&intf->dev, "couldn't find required endpoints\n");
-		goto out;
-	}
-
-	tasklet_setup(&dev->tl, rx_fixup);
-	spin_lock_init(&dev->rx_pool_lock);
-
-	dev->udev = udev;
-	dev->netdev = netdev;
-	netdev->netdev_ops = &rtl8150_netdev_ops;
-	netdev->watchdog_timeo = RTL8150_TX_TIMEOUT;
-	netdev->ethtool_ops = &ops;
-	dev->intr_interval = 100;	/* 100ms */
-
-	if (!alloc_all_urbs(dev)) {
-		dev_err(&intf->dev, "out of memory\n");
-		goto out;
-	}
-	if (!rtl8150_reset(dev)) {
-		dev_err(&intf->dev, "couldn't reset the device\n");
-		goto out1;
-	}
-	fill_skb_pool(dev);
-	set_ethernet_addr(dev);
-
-	usb_set_intfdata(intf, dev);
-	SET_NETDEV_DEV(netdev, &intf->dev);
-	if (register_netdev(netdev) != 0) {
-		dev_err(&intf->dev, "couldn't register the device\n");
-		goto out2;
-	}
-
-	dev_info(&intf->dev, "%s: rtl8150 is detected\n", netdev->name);
-
-	return 0;
-
-out2:
-	usb_set_intfdata(intf, NULL);
-	free_skb_pool(dev);
-out1:
-	free_all_urbs(dev);
-out:
-	kfree(dev->intr_buff);
-	free_netdev(netdev);
-	return -EIO;
-}
-
-static void rtl8150_disconnect(struct usb_interface *intf)
-{
-	rtl8150_t *dev = usb_get_intfdata(intf);
-
-	usb_set_intfdata(intf, NULL);
-	if (dev) {
-		set_bit(RTL8150_UNPLUG, &dev->flags);
-		tasklet_kill(&dev->tl);
-		unregister_netdev(dev->netdev);
-		unlink_all_urbs(dev);
-		free_all_urbs(dev);
-		free_skb_pool(dev);
-		dev_kfree_skb(dev->rx_skb);
-		kfree(dev->intr_buff);
-		free_netdev(dev->netdev);
-	}
-}
-
-static struct usb_driver rtl8150_driver = {
-	.name		= driver_name,
-	.probe		= rtl8150_probe,
-	.disconnect	= rtl8150_disconnect,
-	.id_table	= rtl8150_table,
-	.suspend	= rtl8150_suspend,
-	.resume		= rtl8150_resume,
-	.disable_hub_initiated_lpm = 1,
-};
-
-module_usb_driver(rtl8150_driver);
-
-MODULE_AUTHOR(DRIVER_AUTHOR);
-MODULE_DESCRIPTION(DRIVER_DESC);
-MODULE_LICENSE("GPL");
-- 
2.47.3


