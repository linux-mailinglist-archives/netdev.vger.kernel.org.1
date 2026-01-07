Return-Path: <netdev+bounces-247619-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DFCBCFC612
	for <lists+netdev@lfdr.de>; Wed, 07 Jan 2026 08:34:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6FFDA3053BD1
	for <lists+netdev@lfdr.de>; Wed,  7 Jan 2026 07:30:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70E3E27FB1B;
	Wed,  7 Jan 2026 07:30:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QRdDEDFm"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f67.google.com (mail-dl1-f67.google.com [74.125.82.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8A8257830
	for <netdev@vger.kernel.org>; Wed,  7 Jan 2026 07:29:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767771003; cv=none; b=on2vD0v4LpvVlgyJtE2fqa3RBq4VSjk4F/YZwvQHzUhY7TBmWOaP4JoWfS51yuiUPx9TiVr5NrIcbFavYitBJzmRW1xWThj1x7XlGrsXCS9+csNSDs+bkmhgUM76RY8OZ1jsb1pzqcUbRDeOHOK1GBZS5lii4IDPsC9B35gDRIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767771003; c=relaxed/simple;
	bh=Z41w/wYe6JXXQq+V+ctVAb3iYYeXmloHoQi/il3xhbA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SzGqi2iZI9qpmTglkAPAf0m6IKHesy+lezKZkRr0NVHFPEykL52UyleX8WnsNyHfANpXjMreDOW6mHDppMZJEuZCpv2zMTWwtxoCIRVHjvXU5jbWH7/6awLk64gbNb44ltDU3MI2OpxP38F1g3IBo0qUTY0uOZKey5H23xxS9js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QRdDEDFm; arc=none smtp.client-ip=74.125.82.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f67.google.com with SMTP id a92af1059eb24-121a0bcd376so2497230c88.0
        for <netdev@vger.kernel.org>; Tue, 06 Jan 2026 23:29:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767770997; x=1768375797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q3oV6xKlBvGUbAk6b1XX3I2Woab9/is7ZIO7Dr/rv30=;
        b=QRdDEDFmP5HJKbvMQO8P8EW0KV9ybB17JpBXoKEYkTjL7qO1Go2h0vxCvrBONR6Yv6
         n9kz7KD7HkqTfp4sYyMrra2r44V8V1Q2kKQ8Y4UZKP6CmZ1QtsrzmrwetRbMBuZBOT81
         C6ddGT1xEGK+oqwybSxMDZM1191p7+nrvG1Jl7HoLUbv7Uhk4PWHOn3LK+2g7EhC5N19
         YCm8pw6ms1XzJQD36lwQrOX/Rd9gu3EnNqDAP5QFgOdmLEwWaM1XMD+xUA1YkvdC+4AB
         HlDE2Fes+cx/Jvql177AU6851WTPsWTclZ/F1x8jCbZIAUWE/ertwYnN/kH5uqVQR6Gt
         F7hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767770997; x=1768375797;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q3oV6xKlBvGUbAk6b1XX3I2Woab9/is7ZIO7Dr/rv30=;
        b=AwZ3tWe4aJzbY9tORJB8Oq7gxh8tUIIR8qX4AdJh/fAnIeFXnLcVeQ5+GGN8blgLuN
         Q4X4Q+Ibpa6gzf48v0DY+6YGTZgnGRLzNC32fdH7IQhbE+hMU5dWemLHWiYmlLgzsrF3
         NkBTxXZjf6tPIcTx9dkSzN44VhubXu98JWgAEHtqVYmd90OQXAf2MlqjreVLdC3J/Jqa
         BkdXntTBA2P4wlXKexNtkb9Qh2n50D5xaC+e5VC4bRgfwK4h8X20sGDUM3XGbc0TDINk
         x1NvvDFr602edpnY2sbJm/OGUZ8vUB7lr8I/4hpgWevQBiZ2mIuvs/O5WW02ACxBviOM
         3B8Q==
X-Gm-Message-State: AOJu0YwLMVIgJ2gVWWrbIUL2LCawmlDOxAKV+wKaAPHuFVC+X0jTESoV
	M+ofyxEaIYPRAen1/Lp5jjisc9UWAzP6oMGoj3YKDJTrVapB4vlk/D6q2TKnhWWy
X-Gm-Gg: AY/fxX6pvY4Nn2MkxeCj7pJC2T571B6sbXc2WbPjhqmbW/JYm6SBPyo+6nGfZ7LPtMZ
	zkG4zDiiLGbxDM4HHf1gB57rGWhN8PN8RjXVTdmqhXahPIAzcCOEK2rTHJykfmRFB8HckUywtR1
	3gCVga82XkQFxJzz4JjZN7iF1JiPbQb88mDqqofVhetmwTDBkJaY4l0hSzZQ3cxE9WBA+FyYmTb
	bkQOG4Lg/OC4+5XryUpC83HmkdUlcclpEH/PPZ5vsun0GYHP6CyP5s3ysedYIxqd91j5CcCwp0p
	sO2KKfQNGXrQmgPrA0sL9RxEi3A60MjCL1AWI8/sLnIH8KlhreCE9Vc9fBGUE+Ts0oF7Vwy58rb
	QAGh0fwpgyFFsdmG2jjbNZkPjRaItpLtO2325nXxeXfn687csGwRoxSL909aYTHOwiyOtT8/bJr
	bHDYE3gNEzUMwOFxwnwcPx6F9xLPrTEOXKHpqki2Yo4DOsSG5XAHR3QHbXgGw71dyjoq+xZm0iF
	mZ/4yEQ/q9EA/Y0nCfvZOmMjux9D9tfeC3xO5rPdwkP+d/aJVKimuMS4gRDFp5TmMIHA2V2+MrI
	Lru3
X-Google-Smtp-Source: AGHT+IGk1b0KnPspj60EfkuYSZ35t+ZO/vt5t/bzMovsv4du6T7ZtXudC2bNgp3oSNR0DI56KApYxg==
X-Received: by 2002:a05:7300:3242:b0:2ae:506b:4b05 with SMTP id 5a478bee46e88-2b17d2951ecmr1238701eec.27.1767770996719;
        Tue, 06 Jan 2026 23:29:56 -0800 (PST)
Received: from ethan-latitude5420.. (host-127-24.cafrjco.fresno.ca.us.clients.pavlovmedia.net. [68.180.127.24])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b1706a53f0sm6118711eec.10.2026.01.06.23.29.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Jan 2026 23:29:56 -0800 (PST)
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
To: netdev@vger.kernel.org
Cc: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Subject: [PATCH RFC net-next] atp: drop ancient parallel port Ethernet driver
Date: Tue,  6 Jan 2026 23:29:49 -0800
Message-ID: <20260107072949.37990-1-enelsonmoore@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This driver is old and almost certainly entirely unused. The two other
parallel port Ethernet drivers (de600/de620) were removed by Paul
Gortmaker in commit 168e06ae26dd327df347e70b7244218ff1766a1f,
but this driver remained. Drop it - Paul's reasoning applies here as
well. To quote him:

"The parallel port is largely replaced by USB [...] Let us not pretend
that anyone cares about these drivers anymore, or worse - pretend that
anyone is using them on a modern kernel."

Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
---
 drivers/net/ethernet/realtek/Kconfig  |  16 +-
 drivers/net/ethernet/realtek/Makefile |   1 -
 drivers/net/ethernet/realtek/atp.c    | 886 --------------------------
 drivers/net/ethernet/realtek/atp.h    | 262 --------
 4 files changed, 1 insertion(+), 1164 deletions(-)
 delete mode 100644 drivers/net/ethernet/realtek/atp.c
 delete mode 100644 drivers/net/ethernet/realtek/atp.h

diff --git a/drivers/net/ethernet/realtek/Kconfig b/drivers/net/ethernet/realtek/Kconfig
index 272c83bfdc6c..9b0f4f9631db 100644
--- a/drivers/net/ethernet/realtek/Kconfig
+++ b/drivers/net/ethernet/realtek/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_REALTEK
 	bool "Realtek devices"
 	default y
-	depends on PCI || (PARPORT && X86)
+	depends on PCI
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -17,20 +17,6 @@ config NET_VENDOR_REALTEK
 
 if NET_VENDOR_REALTEK
 
-config ATP
-	tristate "AT-LAN-TEC/RealTek pocket adapter support"
-	depends on PARPORT && X86
-	select CRC32
-	help
-	  This is a network (Ethernet) device which attaches to your parallel
-	  port. Read the file <file:drivers/net/ethernet/realtek/atp.c>
-	  if you want to use this.  If you intend to use this driver, you
-	  should have said N to the "Parallel printer support", because the two
-	  drivers don't like each other.
-
-	  To compile this driver as a module, choose M here: the module
-	  will be called atp.
-
 config 8139CP
 	tristate "RealTek RTL-8139 C+ PCI Fast Ethernet Adapter support"
 	depends on PCI
diff --git a/drivers/net/ethernet/realtek/Makefile b/drivers/net/ethernet/realtek/Makefile
index 046adf503ff4..12a9c399f40c 100644
--- a/drivers/net/ethernet/realtek/Makefile
+++ b/drivers/net/ethernet/realtek/Makefile
@@ -5,7 +5,6 @@
 
 obj-$(CONFIG_8139CP) += 8139cp.o
 obj-$(CONFIG_8139TOO) += 8139too.o
-obj-$(CONFIG_ATP) += atp.o
 r8169-y += r8169_main.o r8169_firmware.o r8169_phy_config.o
 r8169-$(CONFIG_R8169_LEDS) += r8169_leds.o
 obj-$(CONFIG_R8169) += r8169.o
diff --git a/drivers/net/ethernet/realtek/atp.c b/drivers/net/ethernet/realtek/atp.c
deleted file mode 100644
index 0d65434982a2..000000000000
--- a/drivers/net/ethernet/realtek/atp.c
+++ /dev/null
@@ -1,886 +0,0 @@
-/* atp.c: Attached (pocket) ethernet adapter driver for linux. */
-/*
-	This is a driver for commonly OEM pocket (parallel port)
-	ethernet adapters based on the Realtek RTL8002 and RTL8012 chips.
-
-	Written 1993-2000 by Donald Becker.
-
-	This software may be used and distributed according to the terms of
-	the GNU General Public License (GPL), incorporated herein by reference.
-	Drivers based on or derived from this code fall under the GPL and must
-	retain the authorship, copyright and license notice.  This file is not
-	a complete program and may only be used when the entire operating
-	system is licensed under the GPL.
-
-	Copyright 1993 United States Government as represented by the Director,
-	National Security Agency.  Copyright 1994-2000 retained by the original
-	author, Donald Becker. The timer-based reset code was supplied in 1995
-	by Bill Carlson, wwc@super.org.
-
-	The author may be reached as becker@scyld.com, or C/O
-	Scyld Computing Corporation
-	410 Severn Ave., Suite 210
-	Annapolis MD 21403
-
-	Support information and updates available at
-	http://www.scyld.com/network/atp.html
-
-
-	Modular support/softnet added by Alan Cox.
-	_bit abuse fixed up by Alan Cox
-
-*/
-
-static const char version[] =
-"atp.c:v1.09=ac 2002/10/01 Donald Becker <becker@scyld.com>\n";
-
-/* The user-configurable values.
-   These may be modified when a driver module is loaded.*/
-
-static int debug = 1; 			/* 1 normal messages, 0 quiet .. 7 verbose. */
-#define net_debug debug
-
-/* Maximum events (Rx packets, etc.) to handle at each interrupt. */
-static int max_interrupt_work = 15;
-
-#define NUM_UNITS 2
-/* The standard set of ISA module parameters. */
-static int io[NUM_UNITS];
-static int irq[NUM_UNITS];
-static int xcvr[NUM_UNITS]; 			/* The data transfer mode. */
-
-/* Operational parameters that are set at compile time. */
-
-/* Time in jiffies before concluding the transmitter is hung. */
-#define TX_TIMEOUT  (400*HZ/1000)
-
-/*
-	This file is a device driver for the RealTek (aka AT-Lan-Tec) pocket
-	ethernet adapter.  This is a common low-cost OEM pocket ethernet
-	adapter, sold under many names.
-
-  Sources:
-	This driver was written from the packet driver assembly code provided by
-	Vincent Bono of AT-Lan-Tec.	 Ever try to figure out how a complicated
-	device works just from the assembly code?  It ain't pretty.  The following
-	description is written based on guesses and writing lots of special-purpose
-	code to test my theorized operation.
-
-	In 1997 Realtek made available the documentation for the second generation
-	RTL8012 chip, which has lead to several driver improvements.
-	  http://www.realtek.com.tw/
-
-					Theory of Operation
-
-	The RTL8002 adapter seems to be built around a custom spin of the SEEQ
-	controller core.  It probably has a 16K or 64K internal packet buffer, of
-	which the first 4K is devoted to transmit and the rest to receive.
-	The controller maintains the queue of received packet and the packet buffer
-	access pointer internally, with only 'reset to beginning' and 'skip to next
-	packet' commands visible.  The transmit packet queue holds two (or more?)
-	packets: both 'retransmit this packet' (due to collision) and 'transmit next
-	packet' commands must be started by hand.
-
-	The station address is stored in a standard bit-serial EEPROM which must be
-	read (ughh) by the device driver.  (Provisions have been made for
-	substituting a 74S288 PROM, but I haven't gotten reports of any models
-	using it.)  Unlike built-in devices, a pocket adapter can temporarily lose
-	power without indication to the device driver.  The major effect is that
-	the station address, receive filter (promiscuous, etc.) and transceiver
-	must be reset.
-
-	The controller itself has 16 registers, some of which use only the lower
-	bits.  The registers are read and written 4 bits at a time.  The four bit
-	register address is presented on the data lines along with a few additional
-	timing and control bits.  The data is then read from status port or written
-	to the data port.
-
-	Correction: the controller has two banks of 16 registers.  The second
-	bank contains only the multicast filter table (now used) and the EEPROM
-	access registers.
-
-	Since the bulk data transfer of the actual packets through the slow
-	parallel port dominates the driver's running time, four distinct data
-	(non-register) transfer modes are provided by the adapter, two in each
-	direction.  In the first mode timing for the nibble transfers is
-	provided through the data port.  In the second mode the same timing is
-	provided through the control port.  In either case the data is read from
-	the status port and written to the data port, just as it is accessing
-	registers.
-
-	In addition to the basic data transfer methods, several more are modes are
-	created by adding some delay by doing multiple reads of the data to allow
-	it to stabilize.  This delay seems to be needed on most machines.
-
-	The data transfer mode is stored in the 'dev->if_port' field.  Its default
-	value is '4'.  It may be overridden at boot-time using the third parameter
-	to the "ether=..." initialization.
-
-	The header file <atp.h> provides inline functions that encapsulate the
-	register and data access methods.  These functions are hand-tuned to
-	generate reasonable object code.  This header file also documents my
-	interpretations of the device registers.
-*/
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/types.h>
-#include <linux/fcntl.h>
-#include <linux/interrupt.h>
-#include <linux/ioport.h>
-#include <linux/in.h>
-#include <linux/string.h>
-#include <linux/errno.h>
-#include <linux/init.h>
-#include <linux/crc32.h>
-#include <linux/netdevice.h>
-#include <linux/etherdevice.h>
-#include <linux/skbuff.h>
-#include <linux/spinlock.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
-
-#include <asm/io.h>
-#include <asm/dma.h>
-
-#include "atp.h"
-
-MODULE_AUTHOR("Donald Becker <becker@scyld.com>");
-MODULE_DESCRIPTION("RealTek RTL8002/8012 parallel port Ethernet driver");
-MODULE_LICENSE("GPL");
-
-module_param(max_interrupt_work, int, 0);
-module_param(debug, int, 0);
-module_param_hw_array(io, int, ioport, NULL, 0);
-module_param_hw_array(irq, int, irq, NULL, 0);
-module_param_array(xcvr, int, NULL, 0);
-MODULE_PARM_DESC(max_interrupt_work, "ATP maximum events handled per interrupt");
-MODULE_PARM_DESC(debug, "ATP debug level (0-7)");
-MODULE_PARM_DESC(io, "ATP I/O base address(es)");
-MODULE_PARM_DESC(irq, "ATP IRQ number(s)");
-MODULE_PARM_DESC(xcvr, "ATP transceiver(s) (0=internal, 1=external)");
-
-/* The number of low I/O ports used by the ethercard. */
-#define ETHERCARD_TOTAL_SIZE	3
-
-/* Sequence to switch an 8012 from printer mux to ethernet mode. */
-static char mux_8012[] = { 0xff, 0xf7, 0xff, 0xfb, 0xf3, 0xfb, 0xff, 0xf7,};
-
-struct net_local {
-    spinlock_t lock;
-    struct net_device *next_module;
-    struct timer_list timer;	/* Media selection timer. */
-    struct net_device *dev;	/* Timer dev. */
-    unsigned long last_rx_time;	/* Last Rx, in jiffies, to handle Rx hang. */
-    int saved_tx_size;
-    unsigned int tx_unit_busy:1;
-    unsigned char re_tx,	/* Number of packet retransmissions. */
-		addr_mode,		/* Current Rx filter e.g. promiscuous, etc. */
-		pac_cnt_in_tx_buf;
-};
-
-/* This code, written by wwc@super.org, resets the adapter every
-   TIMED_CHECKER ticks.  This recovers from an unknown error which
-   hangs the device. */
-#define TIMED_CHECKER (HZ/4)
-#ifdef TIMED_CHECKER
-#include <linux/timer.h>
-static void atp_timed_checker(struct timer_list *t);
-#endif
-
-/* Index to functions, as function prototypes. */
-
-static int atp_probe1(long ioaddr);
-static void get_node_ID(struct net_device *dev);
-static unsigned short eeprom_op(long ioaddr, unsigned int cmd);
-static int net_open(struct net_device *dev);
-static void hardware_init(struct net_device *dev);
-static void write_packet(long ioaddr, int length, unsigned char *packet, int pad, int mode);
-static void trigger_send(long ioaddr, int length);
-static netdev_tx_t atp_send_packet(struct sk_buff *skb,
-				   struct net_device *dev);
-static irqreturn_t atp_interrupt(int irq, void *dev_id);
-static void net_rx(struct net_device *dev);
-static void read_block(long ioaddr, int length, unsigned char *buffer, int data_mode);
-static int net_close(struct net_device *dev);
-static void set_rx_mode(struct net_device *dev);
-static void tx_timeout(struct net_device *dev, unsigned int txqueue);
-
-
-/* A list of all installed ATP devices, for removing the driver module. */
-static struct net_device *root_atp_dev;
-
-/* Check for a network adapter of this type, and return '0' iff one exists.
-   If dev->base_addr == 0, probe all likely locations.
-   If dev->base_addr == 1, always return failure.
-   If dev->base_addr == 2, allocate space for the device and return success
-   (detachable devices only).
-
-   FIXME: we should use the parport layer for this
-   */
-static int __init atp_init(void)
-{
-	int *port, ports[] = {0x378, 0x278, 0x3bc, 0};
-	int base_addr = io[0];
-
-	if (base_addr > 0x1ff)		/* Check a single specified location. */
-		return atp_probe1(base_addr);
-	else if (base_addr == 1)	/* Don't probe at all. */
-		return -ENXIO;
-
-	for (port = ports; *port; port++) {
-		long ioaddr = *port;
-		outb(0x57, ioaddr + PAR_DATA);
-		if (inb(ioaddr + PAR_DATA) != 0x57)
-			continue;
-		if (atp_probe1(ioaddr) == 0)
-			return 0;
-	}
-
-	return -ENODEV;
-}
-
-static const struct net_device_ops atp_netdev_ops = {
-	.ndo_open		= net_open,
-	.ndo_stop		= net_close,
-	.ndo_start_xmit		= atp_send_packet,
-	.ndo_set_rx_mode	= set_rx_mode,
-	.ndo_tx_timeout		= tx_timeout,
-	.ndo_set_mac_address 	= eth_mac_addr,
-	.ndo_validate_addr	= eth_validate_addr,
-};
-
-static int __init atp_probe1(long ioaddr)
-{
-	struct net_device *dev = NULL;
-	struct net_local *lp;
-	int saved_ctrl_reg, status, i;
-	int res;
-
-	outb(0xff, ioaddr + PAR_DATA);
-	/* Save the original value of the Control register, in case we guessed
-	   wrong. */
-	saved_ctrl_reg = inb(ioaddr + PAR_CONTROL);
-	if (net_debug > 3)
-		printk("atp: Control register was %#2.2x.\n", saved_ctrl_reg);
-	/* IRQEN=0, SLCTB=high INITB=high, AUTOFDB=high, STBB=high. */
-	outb(0x04, ioaddr + PAR_CONTROL);
-#ifndef final_version
-	if (net_debug > 3) {
-		/* Turn off the printer multiplexer on the 8012. */
-		for (i = 0; i < 8; i++)
-			outb(mux_8012[i], ioaddr + PAR_DATA);
-		write_reg(ioaddr, MODSEL, 0x00);
-		printk("atp: Registers are ");
-		for (i = 0; i < 32; i++)
-			printk(" %2.2x", read_nibble(ioaddr, i));
-		printk(".\n");
-	}
-#endif
-	/* Turn off the printer multiplexer on the 8012. */
-	for (i = 0; i < 8; i++)
-		outb(mux_8012[i], ioaddr + PAR_DATA);
-	write_reg_high(ioaddr, CMR1, CMR1h_RESET);
-	/* udelay() here? */
-	status = read_nibble(ioaddr, CMR1);
-
-	if (net_debug > 3) {
-		printk(KERN_DEBUG "atp: Status nibble was %#2.2x..", status);
-		for (i = 0; i < 32; i++)
-			printk(" %2.2x", read_nibble(ioaddr, i));
-		printk("\n");
-	}
-
-	if ((status & 0x78) != 0x08) {
-		/* The pocket adapter probe failed, restore the control register. */
-		outb(saved_ctrl_reg, ioaddr + PAR_CONTROL);
-		return -ENODEV;
-	}
-	status = read_nibble(ioaddr, CMR2_h);
-	if ((status & 0x78) != 0x10) {
-		outb(saved_ctrl_reg, ioaddr + PAR_CONTROL);
-		return -ENODEV;
-	}
-
-	dev = alloc_etherdev(sizeof(struct net_local));
-	if (!dev)
-		return -ENOMEM;
-
-	/* Find the IRQ used by triggering an interrupt. */
-	write_reg_byte(ioaddr, CMR2, 0x01);			/* No accept mode, IRQ out. */
-	write_reg_high(ioaddr, CMR1, CMR1h_RxENABLE | CMR1h_TxENABLE);	/* Enable Tx and Rx. */
-
-	/* Omit autoIRQ routine for now. Use "table lookup" instead.  Uhgggh. */
-	if (irq[0])
-		dev->irq = irq[0];
-	else if (ioaddr == 0x378)
-		dev->irq = 7;
-	else
-		dev->irq = 5;
-	write_reg_high(ioaddr, CMR1, CMR1h_TxRxOFF); /* Disable Tx and Rx units. */
-	write_reg(ioaddr, CMR2, CMR2_NULL);
-
-	dev->base_addr = ioaddr;
-
-	/* Read the station address PROM.  */
-	get_node_ID(dev);
-
-#ifndef MODULE
-	if (net_debug)
-		printk(KERN_INFO "%s", version);
-#endif
-
-	printk(KERN_NOTICE "%s: Pocket adapter found at %#3lx, IRQ %d, "
-	       "SAPROM %pM.\n",
-	       dev->name, dev->base_addr, dev->irq, dev->dev_addr);
-
-	/* Reset the ethernet hardware and activate the printer pass-through. */
-	write_reg_high(ioaddr, CMR1, CMR1h_RESET | CMR1h_MUX);
-
-	lp = netdev_priv(dev);
-	lp->addr_mode = CMR2h_Normal;
-	spin_lock_init(&lp->lock);
-
-	/* For the ATP adapter the "if_port" is really the data transfer mode. */
-	if (xcvr[0])
-		dev->if_port = xcvr[0];
-	else
-		dev->if_port = (dev->mem_start & 0xf) ? (dev->mem_start & 0x7) : 4;
-	if (dev->mem_end & 0xf)
-		net_debug = dev->mem_end & 7;
-
-	dev->netdev_ops 	= &atp_netdev_ops;
-	dev->watchdog_timeo	= TX_TIMEOUT;
-
-	res = register_netdev(dev);
-	if (res) {
-		free_netdev(dev);
-		return res;
-	}
-
-	lp->next_module = root_atp_dev;
-	root_atp_dev = dev;
-
-	return 0;
-}
-
-/* Read the station address PROM, usually a word-wide EEPROM. */
-static void __init get_node_ID(struct net_device *dev)
-{
-	long ioaddr = dev->base_addr;
-	__be16 addr[ETH_ALEN / 2];
-	int sa_offset = 0;
-	int i;
-
-	write_reg(ioaddr, CMR2, CMR2_EEPROM);	  /* Point to the EEPROM control registers. */
-
-	/* Some adapters have the station address at offset 15 instead of offset
-	   zero.  Check for it, and fix it if needed. */
-	if (eeprom_op(ioaddr, EE_READ(0)) == 0xffff)
-		sa_offset = 15;
-
-	for (i = 0; i < 3; i++)
-		addr[i] =
-			cpu_to_be16(eeprom_op(ioaddr, EE_READ(sa_offset + i)));
-	eth_hw_addr_set(dev, (u8 *)addr);
-
-	write_reg(ioaddr, CMR2, CMR2_NULL);
-}
-
-/*
-  An EEPROM read command starts by shifting out 0x60+address, and then
-  shifting in the serial data. See the NatSemi databook for details.
- *		   ________________
- * CS : __|
- *			   ___	   ___
- * CLK: ______|	  |___|	  |
- *		 __ _______ _______
- * DI :	 __X_______X_______X
- * DO :	 _________X_______X
- */
-
-static unsigned short __init eeprom_op(long ioaddr, u32 cmd)
-{
-	unsigned eedata_out = 0;
-	int num_bits = EE_CMD_SIZE;
-
-	while (--num_bits >= 0) {
-		char outval = (cmd & (1<<num_bits)) ? EE_DATA_WRITE : 0;
-		write_reg_high(ioaddr, PROM_CMD, outval | EE_CLK_LOW);
-		write_reg_high(ioaddr, PROM_CMD, outval | EE_CLK_HIGH);
-		eedata_out <<= 1;
-		if (read_nibble(ioaddr, PROM_DATA) & EE_DATA_READ)
-			eedata_out++;
-	}
-	write_reg_high(ioaddr, PROM_CMD, EE_CLK_LOW & ~EE_CS);
-	return eedata_out;
-}
-
-
-/* Open/initialize the board.  This is called (in the current kernel)
-   sometime after booting when the 'ifconfig' program is run.
-
-   This routine sets everything up anew at each open, even
-   registers that "should" only need to be set once at boot, so that
-   there is non-reboot way to recover if something goes wrong.
-
-   This is an attachable device: if there is no private entry then it wasn't
-   probed for at boot-time, and we need to probe for it again.
-   */
-static int net_open(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	int ret;
-
-	/* The interrupt line is turned off (tri-stated) when the device isn't in
-	   use.  That's especially important for "attached" interfaces where the
-	   port or interrupt may be shared. */
-	ret = request_irq(dev->irq, atp_interrupt, 0, dev->name, dev);
-	if (ret)
-		return ret;
-
-	hardware_init(dev);
-
-	lp->dev = dev;
-	timer_setup(&lp->timer, atp_timed_checker, 0);
-	lp->timer.expires = jiffies + TIMED_CHECKER;
-	add_timer(&lp->timer);
-
-	netif_start_queue(dev);
-	return 0;
-}
-
-/* This routine resets the hardware.  We initialize everything, assuming that
-   the hardware may have been temporarily detached. */
-static void hardware_init(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	int i;
-
-	/* Turn off the printer multiplexer on the 8012. */
-	for (i = 0; i < 8; i++)
-		outb(mux_8012[i], ioaddr + PAR_DATA);
-	write_reg_high(ioaddr, CMR1, CMR1h_RESET);
-
-	for (i = 0; i < 6; i++)
-		write_reg_byte(ioaddr, PAR0 + i, dev->dev_addr[i]);
-
-	write_reg_high(ioaddr, CMR2, lp->addr_mode);
-
-	if (net_debug > 2) {
-		printk(KERN_DEBUG "%s: Reset: current Rx mode %d.\n", dev->name,
-			   (read_nibble(ioaddr, CMR2_h) >> 3) & 0x0f);
-	}
-
-	write_reg(ioaddr, CMR2, CMR2_IRQOUT);
-	write_reg_high(ioaddr, CMR1, CMR1h_RxENABLE | CMR1h_TxENABLE);
-
-	/* Enable the interrupt line from the serial port. */
-	outb(Ctrl_SelData + Ctrl_IRQEN, ioaddr + PAR_CONTROL);
-
-	/* Unmask the interesting interrupts. */
-	write_reg(ioaddr, IMR, ISR_RxOK | ISR_TxErr | ISR_TxOK);
-	write_reg_high(ioaddr, IMR, ISRh_RxErr);
-
-	lp->tx_unit_busy = 0;
-	lp->pac_cnt_in_tx_buf = 0;
-	lp->saved_tx_size = 0;
-}
-
-static void trigger_send(long ioaddr, int length)
-{
-	write_reg_byte(ioaddr, TxCNT0, length & 0xff);
-	write_reg(ioaddr, TxCNT1, length >> 8);
-	write_reg(ioaddr, CMR1, CMR1_Xmit);
-}
-
-static void write_packet(long ioaddr, int length, unsigned char *packet, int pad_len, int data_mode)
-{
-    if (length & 1)
-    {
-	length++;
-	pad_len++;
-    }
-
-    outb(EOC+MAR, ioaddr + PAR_DATA);
-    if ((data_mode & 1) == 0) {
-		/* Write the packet out, starting with the write addr. */
-		outb(WrAddr+MAR, ioaddr + PAR_DATA);
-		do {
-			write_byte_mode0(ioaddr, *packet++);
-		} while (--length > pad_len) ;
-		do {
-			write_byte_mode0(ioaddr, 0);
-		} while (--length > 0) ;
-    } else {
-		/* Write the packet out in slow mode. */
-		unsigned char outbyte = *packet++;
-
-		outb(Ctrl_LNibWrite + Ctrl_IRQEN, ioaddr + PAR_CONTROL);
-		outb(WrAddr+MAR, ioaddr + PAR_DATA);
-
-		outb((outbyte & 0x0f)|0x40, ioaddr + PAR_DATA);
-		outb(outbyte & 0x0f, ioaddr + PAR_DATA);
-		outbyte >>= 4;
-		outb(outbyte & 0x0f, ioaddr + PAR_DATA);
-		outb(Ctrl_HNibWrite + Ctrl_IRQEN, ioaddr + PAR_CONTROL);
-		while (--length > pad_len)
-			write_byte_mode1(ioaddr, *packet++);
-		while (--length > 0)
-			write_byte_mode1(ioaddr, 0);
-    }
-    /* Terminate the Tx frame.  End of write: ECB. */
-    outb(0xff, ioaddr + PAR_DATA);
-    outb(Ctrl_HNibWrite | Ctrl_SelData | Ctrl_IRQEN, ioaddr + PAR_CONTROL);
-}
-
-static void tx_timeout(struct net_device *dev, unsigned int txqueue)
-{
-	long ioaddr = dev->base_addr;
-
-	printk(KERN_WARNING "%s: Transmit timed out, %s?\n", dev->name,
-		   inb(ioaddr + PAR_CONTROL) & 0x10 ? "network cable problem"
-		   :  "IRQ conflict");
-	dev->stats.tx_errors++;
-	/* Try to restart the adapter. */
-	hardware_init(dev);
-	netif_trans_update(dev); /* prevent tx timeout */
-	netif_wake_queue(dev);
-	dev->stats.tx_errors++;
-}
-
-static netdev_tx_t atp_send_packet(struct sk_buff *skb,
-				   struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	int length;
-	unsigned long flags;
-
-	length = ETH_ZLEN < skb->len ? skb->len : ETH_ZLEN;
-
-	netif_stop_queue(dev);
-
-	/* Disable interrupts by writing 0x00 to the Interrupt Mask Register.
-	   This sequence must not be interrupted by an incoming packet. */
-
-	spin_lock_irqsave(&lp->lock, flags);
-	write_reg(ioaddr, IMR, 0);
-	write_reg_high(ioaddr, IMR, 0);
-	spin_unlock_irqrestore(&lp->lock, flags);
-
-	write_packet(ioaddr, length, skb->data, length-skb->len, dev->if_port);
-
-	lp->pac_cnt_in_tx_buf++;
-	if (lp->tx_unit_busy == 0) {
-		trigger_send(ioaddr, length);
-		lp->saved_tx_size = 0; 				/* Redundant */
-		lp->re_tx = 0;
-		lp->tx_unit_busy = 1;
-	} else
-		lp->saved_tx_size = length;
-	/* Re-enable the LPT interrupts. */
-	write_reg(ioaddr, IMR, ISR_RxOK | ISR_TxErr | ISR_TxOK);
-	write_reg_high(ioaddr, IMR, ISRh_RxErr);
-
-	dev_kfree_skb (skb);
-	return NETDEV_TX_OK;
-}
-
-
-/* The typical workload of the driver:
-   Handle the network interface interrupts. */
-static irqreturn_t atp_interrupt(int irq, void *dev_instance)
-{
-	struct net_device *dev = dev_instance;
-	struct net_local *lp;
-	long ioaddr;
-	static int num_tx_since_rx;
-	int boguscount = max_interrupt_work;
-	int handled = 0;
-
-	ioaddr = dev->base_addr;
-	lp = netdev_priv(dev);
-
-	spin_lock(&lp->lock);
-
-	/* Disable additional spurious interrupts. */
-	outb(Ctrl_SelData, ioaddr + PAR_CONTROL);
-
-	/* The adapter's output is currently the IRQ line, switch it to data. */
-	write_reg(ioaddr, CMR2, CMR2_NULL);
-	write_reg(ioaddr, IMR, 0);
-
-	if (net_debug > 5)
-		printk(KERN_DEBUG "%s: In interrupt ", dev->name);
-	while (--boguscount > 0) {
-		int status = read_nibble(ioaddr, ISR);
-		if (net_debug > 5)
-			printk("loop status %02x..", status);
-
-		if (status & (ISR_RxOK<<3)) {
-			handled = 1;
-			write_reg(ioaddr, ISR, ISR_RxOK); /* Clear the Rx interrupt. */
-			do {
-				int read_status = read_nibble(ioaddr, CMR1);
-				if (net_debug > 6)
-					printk("handling Rx packet %02x..", read_status);
-				/* We acknowledged the normal Rx interrupt, so if the interrupt
-				   is still outstanding we must have a Rx error. */
-				if (read_status & (CMR1_IRQ << 3)) { /* Overrun. */
-					dev->stats.rx_over_errors++;
-					/* Set to no-accept mode long enough to remove a packet. */
-					write_reg_high(ioaddr, CMR2, CMR2h_OFF);
-					net_rx(dev);
-					/* Clear the interrupt and return to normal Rx mode. */
-					write_reg_high(ioaddr, ISR, ISRh_RxErr);
-					write_reg_high(ioaddr, CMR2, lp->addr_mode);
-				} else if ((read_status & (CMR1_BufEnb << 3)) == 0) {
-					net_rx(dev);
-					num_tx_since_rx = 0;
-				} else
-					break;
-			} while (--boguscount > 0);
-		} else if (status & ((ISR_TxErr + ISR_TxOK)<<3)) {
-			handled = 1;
-			if (net_debug > 6)
-				printk("handling Tx done..");
-			/* Clear the Tx interrupt.  We should check for too many failures
-			   and reinitialize the adapter. */
-			write_reg(ioaddr, ISR, ISR_TxErr + ISR_TxOK);
-			if (status & (ISR_TxErr<<3)) {
-				dev->stats.collisions++;
-				if (++lp->re_tx > 15) {
-					dev->stats.tx_aborted_errors++;
-					hardware_init(dev);
-					break;
-				}
-				/* Attempt to retransmit. */
-				if (net_debug > 6)  printk("attempting to ReTx");
-				write_reg(ioaddr, CMR1, CMR1_ReXmit + CMR1_Xmit);
-			} else {
-				/* Finish up the transmit. */
-				dev->stats.tx_packets++;
-				lp->pac_cnt_in_tx_buf--;
-				if ( lp->saved_tx_size) {
-					trigger_send(ioaddr, lp->saved_tx_size);
-					lp->saved_tx_size = 0;
-					lp->re_tx = 0;
-				} else
-					lp->tx_unit_busy = 0;
-				netif_wake_queue(dev);	/* Inform upper layers. */
-			}
-			num_tx_since_rx++;
-		} else if (num_tx_since_rx > 8 &&
-			   time_after(jiffies, lp->last_rx_time + HZ)) {
-			if (net_debug > 2)
-				printk(KERN_DEBUG "%s: Missed packet? No Rx after %d Tx and "
-					   "%ld jiffies status %02x  CMR1 %02x.\n", dev->name,
-					   num_tx_since_rx, jiffies - lp->last_rx_time, status,
-					   (read_nibble(ioaddr, CMR1) >> 3) & 15);
-			dev->stats.rx_missed_errors++;
-			hardware_init(dev);
-			num_tx_since_rx = 0;
-			break;
-		} else
-			break;
-	}
-
-	/* This following code fixes a rare (and very difficult to track down)
-	   problem where the adapter forgets its ethernet address. */
-	{
-		int i;
-		for (i = 0; i < 6; i++)
-			write_reg_byte(ioaddr, PAR0 + i, dev->dev_addr[i]);
-#if 0 && defined(TIMED_CHECKER)
-		mod_timer(&lp->timer, jiffies + TIMED_CHECKER);
-#endif
-	}
-
-	/* Tell the adapter that it can go back to using the output line as IRQ. */
-	write_reg(ioaddr, CMR2, CMR2_IRQOUT);
-	/* Enable the physical interrupt line, which is sure to be low until.. */
-	outb(Ctrl_SelData + Ctrl_IRQEN, ioaddr + PAR_CONTROL);
-	/* .. we enable the interrupt sources. */
-	write_reg(ioaddr, IMR, ISR_RxOK | ISR_TxErr | ISR_TxOK);
-	write_reg_high(ioaddr, IMR, ISRh_RxErr); 			/* Hmmm, really needed? */
-
-	spin_unlock(&lp->lock);
-
-	if (net_debug > 5) printk("exiting interrupt.\n");
-	return IRQ_RETVAL(handled);
-}
-
-#ifdef TIMED_CHECKER
-/* This following code fixes a rare (and very difficult to track down)
-   problem where the adapter forgets its ethernet address. */
-static void atp_timed_checker(struct timer_list *t)
-{
-	struct net_local *lp = timer_container_of(lp, t, timer);
-	struct net_device *dev = lp->dev;
-	long ioaddr = dev->base_addr;
-	int tickssofar = jiffies - lp->last_rx_time;
-	int i;
-
-	spin_lock(&lp->lock);
-	if (tickssofar > 2*HZ) {
-#if 1
-		for (i = 0; i < 6; i++)
-			write_reg_byte(ioaddr, PAR0 + i, dev->dev_addr[i]);
-		lp->last_rx_time = jiffies;
-#else
-		for (i = 0; i < 6; i++)
-			if (read_cmd_byte(ioaddr, PAR0 + i) != atp_timed_dev->dev_addr[i])
-				{
-			struct net_local *lp = netdev_priv(atp_timed_dev);
-			write_reg_byte(ioaddr, PAR0 + i, atp_timed_dev->dev_addr[i]);
-			if (i == 2)
-			  dev->stats.tx_errors++;
-			else if (i == 3)
-			  dev->stats.tx_dropped++;
-			else if (i == 4)
-			  dev->stats.collisions++;
-			else
-			  dev->stats.rx_errors++;
-		  }
-#endif
-	}
-	spin_unlock(&lp->lock);
-	lp->timer.expires = jiffies + TIMED_CHECKER;
-	add_timer(&lp->timer);
-}
-#endif
-
-/* We have a good packet(s), get it/them out of the buffers. */
-static void net_rx(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-	struct rx_header rx_head;
-
-	/* Process the received packet. */
-	outb(EOC+MAR, ioaddr + PAR_DATA);
-	read_block(ioaddr, 8, (unsigned char*)&rx_head, dev->if_port);
-	if (net_debug > 5)
-		printk(KERN_DEBUG " rx_count %04x %04x %04x %04x..", rx_head.pad,
-			   rx_head.rx_count, rx_head.rx_status, rx_head.cur_addr);
-	if ((rx_head.rx_status & 0x77) != 0x01) {
-		dev->stats.rx_errors++;
-		if (rx_head.rx_status & 0x0004) dev->stats.rx_frame_errors++;
-		else if (rx_head.rx_status & 0x0002) dev->stats.rx_crc_errors++;
-		if (net_debug > 3)
-			printk(KERN_DEBUG "%s: Unknown ATP Rx error %04x.\n",
-				   dev->name, rx_head.rx_status);
-		if  (rx_head.rx_status & 0x0020) {
-			dev->stats.rx_fifo_errors++;
-			write_reg_high(ioaddr, CMR1, CMR1h_TxENABLE);
-			write_reg_high(ioaddr, CMR1, CMR1h_RxENABLE | CMR1h_TxENABLE);
-		} else if (rx_head.rx_status & 0x0050)
-			hardware_init(dev);
-		return;
-	} else {
-		/* Malloc up new buffer. The "-4" omits the FCS (CRC). */
-		int pkt_len = (rx_head.rx_count & 0x7ff) - 4;
-		struct sk_buff *skb;
-
-		skb = netdev_alloc_skb(dev, pkt_len + 2);
-		if (skb == NULL) {
-			dev->stats.rx_dropped++;
-			goto done;
-		}
-
-		skb_reserve(skb, 2);	/* Align IP on 16 byte boundaries */
-		read_block(ioaddr, pkt_len, skb_put(skb,pkt_len), dev->if_port);
-		skb->protocol = eth_type_trans(skb, dev);
-		netif_rx(skb);
-		dev->stats.rx_packets++;
-		dev->stats.rx_bytes += pkt_len;
-	}
- done:
-	write_reg(ioaddr, CMR1, CMR1_NextPkt);
-	lp->last_rx_time = jiffies;
-}
-
-static void read_block(long ioaddr, int length, unsigned char *p, int data_mode)
-{
-	if (data_mode <= 3) { /* Mode 0 or 1 */
-		outb(Ctrl_LNibRead, ioaddr + PAR_CONTROL);
-		outb(length == 8  ?  RdAddr | HNib | MAR  :  RdAddr | MAR,
-			 ioaddr + PAR_DATA);
-		if (data_mode <= 1) { /* Mode 0 or 1 */
-			do { *p++ = read_byte_mode0(ioaddr); } while (--length > 0);
-		} else { /* Mode 2 or 3 */
-			do { *p++ = read_byte_mode2(ioaddr); } while (--length > 0);
-		}
-	} else if (data_mode <= 5) {
-		do { *p++ = read_byte_mode4(ioaddr); } while (--length > 0);
-	} else {
-		do { *p++ = read_byte_mode6(ioaddr); } while (--length > 0);
-	}
-
-	outb(EOC+HNib+MAR, ioaddr + PAR_DATA);
-	outb(Ctrl_SelData, ioaddr + PAR_CONTROL);
-}
-
-/* The inverse routine to net_open(). */
-static int
-net_close(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-
-	netif_stop_queue(dev);
-
-	timer_delete_sync(&lp->timer);
-
-	/* Flush the Tx and disable Rx here. */
-	lp->addr_mode = CMR2h_OFF;
-	write_reg_high(ioaddr, CMR2, CMR2h_OFF);
-
-	/* Free the IRQ line. */
-	outb(0x00, ioaddr + PAR_CONTROL);
-	free_irq(dev->irq, dev);
-
-	/* Reset the ethernet hardware and activate the printer pass-through. */
-	write_reg_high(ioaddr, CMR1, CMR1h_RESET | CMR1h_MUX);
-	return 0;
-}
-
-/*
- *	Set or clear the multicast filter for this adapter.
- */
-
-static void set_rx_mode(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	long ioaddr = dev->base_addr;
-
-	if (!netdev_mc_empty(dev) || (dev->flags & (IFF_ALLMULTI|IFF_PROMISC)))
-		lp->addr_mode = CMR2h_PROMISC;
-	else
-		lp->addr_mode = CMR2h_Normal;
-	write_reg_high(ioaddr, CMR2, lp->addr_mode);
-}
-
-static int __init atp_init_module(void) {
-	if (debug)					/* Emit version even if no cards detected. */
-		printk(KERN_INFO "%s", version);
-	return atp_init();
-}
-
-static void __exit atp_cleanup_module(void) {
-	struct net_device *next_dev;
-
-	while (root_atp_dev) {
-		struct net_local *atp_local = netdev_priv(root_atp_dev);
-		next_dev = atp_local->next_module;
-		unregister_netdev(root_atp_dev);
-		/* No need to release_region(), since we never snarf it. */
-		free_netdev(root_atp_dev);
-		root_atp_dev = next_dev;
-	}
-}
-
-module_init(atp_init_module);
-module_exit(atp_cleanup_module);
diff --git a/drivers/net/ethernet/realtek/atp.h b/drivers/net/ethernet/realtek/atp.h
deleted file mode 100644
index b202184eddd4..000000000000
--- a/drivers/net/ethernet/realtek/atp.h
+++ /dev/null
@@ -1,262 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-/* Linux header file for the ATP pocket ethernet adapter. */
-/* v1.09 8/9/2000 becker@scyld.com. */
-
-#include <linux/if_ether.h>
-#include <linux/types.h>
-
-/* The header prepended to received packets. */
-struct rx_header {
-	ushort pad;		/* Pad. */
-	ushort rx_count;
-	ushort rx_status;	/* Unknown bit assignments :-<.  */
-	ushort cur_addr;	/* Apparently the current buffer address(?) */
-};
-
-#define PAR_DATA	0
-#define PAR_STATUS	1
-#define PAR_CONTROL 2
-
-#define Ctrl_LNibRead	0x08	/* LP_PSELECP */
-#define Ctrl_HNibRead	0
-#define Ctrl_LNibWrite	0x08	/* LP_PSELECP */
-#define Ctrl_HNibWrite	0
-#define Ctrl_SelData	0x04	/* LP_PINITP */
-#define Ctrl_IRQEN	0x10	/* LP_PINTEN */
-
-#define EOW	0xE0
-#define EOC	0xE0
-#define WrAddr	0x40	/* Set address of EPLC read, write register. */
-#define RdAddr	0xC0
-#define HNib	0x10
-
-enum page0_regs {
-	/* The first six registers hold
-	 * the ethernet physical station address.
-	 */
-	PAR0 = 0, PAR1 = 1, PAR2 = 2, PAR3 = 3, PAR4 = 4, PAR5 = 5,
-	TxCNT0 = 6, TxCNT1 = 7,		/* The transmit byte count. */
-	TxSTAT = 8, RxSTAT = 9,		/* Tx and Rx status. */
-	ISR = 10, IMR = 11,		/* Interrupt status and mask. */
-	CMR1 = 12,			/* Command register 1. */
-	CMR2 = 13,			/* Command register 2. */
-	MODSEL = 14,		/* Mode select register. */
-	MAR = 14,			/* Memory address register (?). */
-	CMR2_h = 0x1d,
-};
-
-enum eepage_regs {
-	PROM_CMD = 6,
-	PROM_DATA = 7	/* Note that PROM_CMD is in the "high" bits. */
-};
-
-#define ISR_TxOK	0x01
-#define ISR_RxOK	0x04
-#define ISR_TxErr	0x02
-#define ISRh_RxErr	0x11	/* ISR, high nibble */
-
-#define CMR1h_MUX	0x08	/* Select printer multiplexor on 8012. */
-#define CMR1h_RESET	0x04	/* Reset. */
-#define CMR1h_RxENABLE	0x02	/* Rx unit enable.  */
-#define CMR1h_TxENABLE	0x01	/* Tx unit enable.  */
-#define CMR1h_TxRxOFF	0x00
-#define CMR1_ReXmit	0x08	/* Trigger a retransmit. */
-#define CMR1_Xmit	0x04	/* Trigger a transmit. */
-#define	CMR1_IRQ	0x02	/* Interrupt active. */
-#define	CMR1_BufEnb	0x01	/* Enable the buffer(?). */
-#define	CMR1_NextPkt	0x01	/* Enable the buffer(?). */
-
-#define CMR2_NULL	8
-#define CMR2_IRQOUT	9
-#define CMR2_RAMTEST	10
-#define CMR2_EEPROM	12	/* Set to page 1, for reading the EEPROM. */
-
-#define CMR2h_OFF	0	/* No accept mode. */
-#define CMR2h_Physical	1	/* Accept a physical address match only. */
-#define CMR2h_Normal	2	/* Accept physical and broadcast address. */
-#define CMR2h_PROMISC	3	/* Promiscuous mode. */
-
-/* An inline function used below: it differs from inb() by explicitly
- * return an unsigned char, saving a truncation.
- */
-static inline unsigned char inbyte(unsigned short port)
-{
-	unsigned char _v;
-
-	__asm__ __volatile__ ("inb %w1,%b0" : "=a" (_v) : "d" (port));
-	return _v;
-}
-
-/* Read register OFFSET.
- * This command should always be terminated with read_end().
- */
-static inline unsigned char read_nibble(short port, unsigned char offset)
-{
-	unsigned char retval;
-
-	outb(EOC+offset, port + PAR_DATA);
-	outb(RdAddr+offset, port + PAR_DATA);
-	inbyte(port + PAR_STATUS);	/* Settling time delay */
-	retval = inbyte(port + PAR_STATUS);
-	outb(EOC+offset, port + PAR_DATA);
-
-	return retval;
-}
-
-/* Functions for bulk data read.  The interrupt line is always disabled. */
-/* Get a byte using read mode 0, reading data from the control lines. */
-static inline unsigned char read_byte_mode0(short ioaddr)
-{
-	unsigned char low_nib;
-
-	outb(Ctrl_LNibRead, ioaddr + PAR_CONTROL);
-	inbyte(ioaddr + PAR_STATUS);
-	low_nib = (inbyte(ioaddr + PAR_STATUS) >> 3) & 0x0f;
-	outb(Ctrl_HNibRead, ioaddr + PAR_CONTROL);
-	inbyte(ioaddr + PAR_STATUS);	/* Settling time delay -- needed!  */
-	inbyte(ioaddr + PAR_STATUS);	/* Settling time delay -- needed!  */
-	return low_nib | ((inbyte(ioaddr + PAR_STATUS) << 1) & 0xf0);
-}
-
-/* The same as read_byte_mode0(), but does multiple inb()s for stability. */
-static inline unsigned char read_byte_mode2(short ioaddr)
-{
-	unsigned char low_nib;
-
-	outb(Ctrl_LNibRead, ioaddr + PAR_CONTROL);
-	inbyte(ioaddr + PAR_STATUS);
-	low_nib = (inbyte(ioaddr + PAR_STATUS) >> 3) & 0x0f;
-	outb(Ctrl_HNibRead, ioaddr + PAR_CONTROL);
-	inbyte(ioaddr + PAR_STATUS);	/* Settling time delay -- needed!  */
-	return low_nib | ((inbyte(ioaddr + PAR_STATUS) << 1) & 0xf0);
-}
-
-/* Read a byte through the data register. */
-static inline unsigned char read_byte_mode4(short ioaddr)
-{
-	unsigned char low_nib;
-
-	outb(RdAddr | MAR, ioaddr + PAR_DATA);
-	low_nib = (inbyte(ioaddr + PAR_STATUS) >> 3) & 0x0f;
-	outb(RdAddr | HNib | MAR, ioaddr + PAR_DATA);
-	return low_nib | ((inbyte(ioaddr + PAR_STATUS) << 1) & 0xf0);
-}
-
-/* Read a byte through the data register, double reading to allow settling. */
-static inline unsigned char read_byte_mode6(short ioaddr)
-{
-	unsigned char low_nib;
-
-	outb(RdAddr | MAR, ioaddr + PAR_DATA);
-	inbyte(ioaddr + PAR_STATUS);
-	low_nib = (inbyte(ioaddr + PAR_STATUS) >> 3) & 0x0f;
-	outb(RdAddr | HNib | MAR, ioaddr + PAR_DATA);
-	inbyte(ioaddr + PAR_STATUS);
-	return low_nib | ((inbyte(ioaddr + PAR_STATUS) << 1) & 0xf0);
-}
-
-static inline void
-write_reg(short port, unsigned char reg, unsigned char value)
-{
-	unsigned char outval;
-
-	outb(EOC | reg, port + PAR_DATA);
-	outval = WrAddr | reg;
-	outb(outval, port + PAR_DATA);
-	outb(outval, port + PAR_DATA);	/* Double write for PS/2. */
-
-	outval &= 0xf0;
-	outval |= value;
-	outb(outval, port + PAR_DATA);
-	outval &= 0x1f;
-	outb(outval, port + PAR_DATA);
-	outb(outval, port + PAR_DATA);
-
-	outb(EOC | outval, port + PAR_DATA);
-}
-
-static inline void
-write_reg_high(short port, unsigned char reg, unsigned char value)
-{
-	unsigned char outval = EOC | HNib | reg;
-
-	outb(outval, port + PAR_DATA);
-	outval &= WrAddr | HNib | 0x0f;
-	outb(outval, port + PAR_DATA);
-	outb(outval, port + PAR_DATA);	/* Double write for PS/2. */
-
-	outval = WrAddr | HNib | value;
-	outb(outval, port + PAR_DATA);
-	outval &= HNib | 0x0f;		/* HNib | value */
-	outb(outval, port + PAR_DATA);
-	outb(outval, port + PAR_DATA);
-
-	outb(EOC | HNib | outval, port + PAR_DATA);
-}
-
-/* Write a byte out using nibble mode.  The low nibble is written first. */
-static inline void
-write_reg_byte(short port, unsigned char reg, unsigned char value)
-{
-	unsigned char outval;
-
-	outb(EOC | reg, port + PAR_DATA); /* Reset the address register. */
-	outval = WrAddr | reg;
-	outb(outval, port + PAR_DATA);
-	outb(outval, port + PAR_DATA);	/* Double write for PS/2. */
-
-	outb((outval & 0xf0) | (value & 0x0f), port + PAR_DATA);
-	outb(value & 0x0f, port + PAR_DATA);
-	value >>= 4;
-	outb(value, port + PAR_DATA);
-	outb(0x10 | value, port + PAR_DATA);
-	outb(0x10 | value, port + PAR_DATA);
-
-	outb(EOC  | value, port + PAR_DATA); /* Reset the address register. */
-}
-
-/* Bulk data writes to the packet buffer.  The interrupt line remains enabled.
- * The first, faster method uses only the dataport (data modes 0, 2 & 4).
- * The second (backup) method uses data and control regs (modes 1, 3 & 5).
- * It should only be needed when there is skew between the individual data
- * lines.
- */
-static inline void write_byte_mode0(short ioaddr, unsigned char value)
-{
-	outb(value & 0x0f, ioaddr + PAR_DATA);
-	outb((value>>4) | 0x10, ioaddr + PAR_DATA);
-}
-
-static inline void write_byte_mode1(short ioaddr, unsigned char value)
-{
-	outb(value & 0x0f, ioaddr + PAR_DATA);
-	outb(Ctrl_IRQEN | Ctrl_LNibWrite, ioaddr + PAR_CONTROL);
-	outb((value>>4) | 0x10, ioaddr + PAR_DATA);
-	outb(Ctrl_IRQEN | Ctrl_HNibWrite, ioaddr + PAR_CONTROL);
-}
-
-/* Write 16bit VALUE to the packet buffer: the same as above just doubled. */
-static inline void write_word_mode0(short ioaddr, unsigned short value)
-{
-	outb(value & 0x0f, ioaddr + PAR_DATA);
-	value >>= 4;
-	outb((value & 0x0f) | 0x10, ioaddr + PAR_DATA);
-	value >>= 4;
-	outb(value & 0x0f, ioaddr + PAR_DATA);
-	value >>= 4;
-	outb((value & 0x0f) | 0x10, ioaddr + PAR_DATA);
-}
-
-/*  EEPROM_Ctrl bits. */
-#define EE_SHIFT_CLK	0x04	/* EEPROM shift clock. */
-#define EE_CS		0x02	/* EEPROM chip select. */
-#define EE_CLK_HIGH	0x12
-#define EE_CLK_LOW	0x16
-#define EE_DATA_WRITE	0x01	/* EEPROM chip data in. */
-#define EE_DATA_READ	0x08	/* EEPROM chip data out. */
-
-/* The EEPROM commands include the alway-set leading bit. */
-#define EE_WRITE_CMD(offset)	(((5 << 6) + (offset)) << 17)
-#define EE_READ(offset)		(((6 << 6) + (offset)) << 17)
-#define EE_ERASE(offset)	(((7 << 6) + (offset)) << 17)
-#define EE_CMD_SIZE	27	/* The command+address+data size. */
-- 
2.43.0


