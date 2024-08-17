Return-Path: <netdev+bounces-119394-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 667019556C6
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 11:33:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C36F1C20F34
	for <lists+netdev@lfdr.de>; Sat, 17 Aug 2024 09:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A6941373;
	Sat, 17 Aug 2024 09:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b="HMgVXdZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtpdh17-su.aruba.it (smtpdh17-su.aruba.it [62.149.155.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9FE13D516
	for <netdev@vger.kernel.org>; Sat, 17 Aug 2024 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.149.155.128
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723887205; cv=none; b=fvEOXGyiCScEJX1QxBfzE53uxbNME5kVw2aNeiKLmgH+ws6456jVITqmGUlBaFd1oYidNLm9oMEJJ7Zr50VgXOdrFCi/bFcI9XzsDXzRsJB6140KC+gKNpfMIdBqL04Ct2R7OAJlU04M914hWEfrVVV0lOAHO8aplVE70UXAS2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723887205; c=relaxed/simple;
	bh=Hc4DoZLyhAjjIbslLvcxHfnpBKqbhWvOkYenMdW8zQs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YyWGspTwQxfAL9WJDZPy5LsPy7QNXQ/1Y83NNBuGHh61RGhj1IDT9Vbbm7EuUzC+hh7vqFwe6tuJokyZz3/raJks5BuhOHdZ+2+WgpvLUG5sKYWg2SKeyPGPAuTM/49C8daVgnbIcOamFOSyylsSPktqYPLLP/PwxABI2mQJX7Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org; spf=pass smtp.mailfrom=xhero.org; dkim=pass (2048-bit key) header.d=aruba.it header.i=@aruba.it header.b=HMgVXdZK; arc=none smtp.client-ip=62.149.155.128
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=xhero.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xhero.org
Received: from xhero.org ([84.74.245.127])
	by Aruba Outgoing Smtp  with ESMTPSA
	id fFoDstWOmJLbHfFoEsuMZ4; Sat, 17 Aug 2024 11:33:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=aruba.it; s=a1;
	t=1723887200; bh=Hc4DoZLyhAjjIbslLvcxHfnpBKqbhWvOkYenMdW8zQs=;
	h=From:To:Subject:Date:MIME-Version;
	b=HMgVXdZKJR7NwOou5htvUaJvcdpAxf7mVyl9Jzf9Gtog+y2CnRdxA53nNJ1rpxSPa
	 Wgz2VPbOojnRWpmrT3BakPdjTaXM31kE7r5Wl4SG3T5XYHfPmgP7oo+yecJOWxxtY4
	 cwtEbMUNZAjWBVQbR61Y22wk9Qxak3jOjLCR25HaV5h+L4pBWOg/mm69bphQ9C5ypf
	 5XtNLvYlr9NpoN+/GbE3fIPj5e59FMHmr+T6xDiW9YoN6L8mElroKO3GgROJMq0zgh
	 5nX8liJ93CqIlrIiMQ1Afexcch+gFuPPVaK5aQSIx8Ep0Znz4Cu9OUywl8jYou+vq+
	 IKmnnUOBbZ3ow==
From: Rodolfo Zitellini <rwz@xhero.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Arnd Bergmann <arnd@arndb.de>,
	Doug Brown <doug@schmorgal.com>,
	Rodolfo Zitellini <rwz@xhero.org>
Subject: [PATCH net-next 2/2] appletalk: tashtalk: Add LocalTalk line discipline driver for AppleTalk using a TashTalk adapter
Date: Sat, 17 Aug 2024 11:33:16 +0200
Message-Id: <20240817093316.9239-1-rwz@xhero.org>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfDiJY6M0raggPw+zPg1WCVFMbQZCXKZh7x0N+lLSyE3U76tnkNTYKbMzAWE746yQTOUCvUn2XXd5/XrQ5DbERMCc+zbBNKM/oFZVdCD+hUKly44i84yp
 3R1eJWDqCcdzMDHXO2dcJdaqv5egaaYPKG2gooT28XBhOUJ0+87PVs9TFLrtVtamnJPPiLo7MAgGqF/JmDR1bJh7pF6mmRwrN28SHoAF0jGgokE7YuZrR0JY
 RRSsvrvCaLqXiV2RT+LDSNFNSbR2YVBbVpcAKhtTg0y2yPaWwlW9HERqKuyk34chpmWWMClnoDtlEMUVXTDl9x8lLegINyjn0fw1dLJVtnCwmxyaB6CIsWM0
 +W7ObGaGw0h1YOMmU4J8EyVfNvmGquvbK19hkUHzFGzokLQq7yrlBVoADEDaol9968aO5vXGCDrFYWAAQNlfQNhwrV+AiVVfSuDpO7BZ+9OaP+fvfM1qhrOZ
 BSl6eXjHm8u07TeK5Ij/YvwijCmBVTIzo5nP+pMgHPk83FH/kzW/+zfLWD01pM8/iSbQx2NDSafnI4slLvh7KjynRQCq3HKvBdOoFAvU62XdOGb0u+r7lEz0
 eI8=

This is the TashTalk driver, it perits for a modern machine to
participate in a Apple LocalTalk network and is compatibile with
Netatalk.

Please see the included documentation for details:
Documentation/networking/device_drivers/appletalk/index.rst

Signed-off-by: Rodolfo Zitellini <rwz@xhero.org>

---
 .../device_drivers/appletalk/index.rst        |   18 +
 .../device_drivers/appletalk/tashtalk.rst     |  139 +++
 .../networking/device_drivers/index.rst       |    1 +
 MAINTAINERS                                   |    7 +
 drivers/net/Kconfig                           |    2 +
 drivers/net/Makefile                          |    1 +
 drivers/net/appletalk/Kconfig                 |   33 +
 drivers/net/appletalk/Makefile                |    6 +
 drivers/net/appletalk/tashtalk.c              | 1003 +++++++++++++++++
 9 files changed, 1210 insertions(+)
 create mode 100644 Documentation/networking/device_drivers/appletalk/index.rst
 create mode 100644 Documentation/networking/device_drivers/appletalk/tashtalk.rst
 create mode 100644 drivers/net/appletalk/Kconfig
 create mode 100644 drivers/net/appletalk/Makefile
 create mode 100644 drivers/net/appletalk/tashtalk.c

diff --git a/Documentation/networking/device_drivers/appletalk/index.rst b/Documentation/networking/device_drivers/appletalk/index.rst
new file mode 100644
index 000000000000..9d2d40bd8c8a
--- /dev/null
+++ b/Documentation/networking/device_drivers/appletalk/index.rst
@@ -0,0 +1,18 @@
+.. SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+
+AppleTalk Device Drivers
+========================
+
+Contents:
+
+.. toctree::
+   :maxdepth: 2
+
+   tashtalk
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/networking/device_drivers/appletalk/tashtalk.rst b/Documentation/networking/device_drivers/appletalk/tashtalk.rst
new file mode 100644
index 000000000000..fdf7c58db339
--- /dev/null
+++ b/Documentation/networking/device_drivers/appletalk/tashtalk.rst
@@ -0,0 +1,139 @@
+.. SPDX-License-Identifier: GPL-2.0
+
+tashtalk.c: LocalTalk driver for Linux
+======================================
+
+Authors
+-------
+
+Rodolfo Zitellini <rwz@xhero.org>
+
+Motivation
+----------
+
+The Linux Kernel includes a complete implementation of AppleTalk,
+which can be used with the Netatalk package to share files with older
+classic Macintoshes. The Kernel also contained drivers for LocalTalk,
+the serial LAN found on many early Macs, which was based on older ISA
+cards implementing the same chipset found in Macs. These boards were
+historically very difficult to obtain, making LocalTalk on Linux
+impractical. In recent years, a vibrant community of enthusiasts has
+produced many tools to ease connecting older machines to the modern
+world. One such project is TashTalk, which implements LocalTalk on a
+PIC microcontroller (https://github.com/lampmerchant/tashtalk).
+
+This driver reintroduces LocalTalk support to the Kernel by providing
+an interface to TashTalk, which can be easily used over a serial port.
+It comes handy for use with older machines that have no thernet option,
+since all early Macintoshes had LocalTalk built-in.
+
+Introduction
+------------
+
+The LocalTalk network implemented one of the physical layers for AppleTalk,
+utilizing an RS422 bus with FM0 and SDLC encoding. On Macs, it was managed
+by the built-in Zilog SCC Z8530. In the modern context, this interface is
+provided by TashTalk, which communicates with a PC via a serial port or
+adapter, or through a specialized adapter (https://github.com/xhero/USB2LT)
+that directly connects a LocalTalk network via a USB port.
+
+Since LocalTalk support is still present in the Linux kernel, it is possible
+to use Netatalk 2 (or the upcoming version 4) directly. The interface is also
+compatible with macipgw (https://github.com/jasonking3/macipgw) to provide
+MacIP over LocalTalk.
+
+This driver implements a line discipline that must be attached, after which
+the LocalTalk interface can be brought up and used.
+
+Operation/loading of the driver
+-------------------------------
+
+If the driver is compiled as module, it can be loaded with
+
+    modprobe tashtalk
+
+By default, 32 TashTalk adapters are available, so this means it can use
+up to 32 serial ports. This number can be changed with the tash_maxdev
+parameter.
+
+Once the driver is loaded, the line discipline is used to attach a serial
+port to it:
+
+    sudo stty -F /dev/ttyUSB0 crtscts
+    sudo ldattach -s 1000000 31 /dev/ttyUSB0
+
+The line discipline ID for TashTalk is 31. Use of stty is required for
+hardware flow control (and has to be properly implemented in hardware!)
+Once the line disc is attached, the interface should be brought up:
+
+    sudo ip link set dev lt0 up
+
+or
+
+    sudo ifconfig lt0 up
+
+Any number (up to the specified max devices) of lt interfaces can be
+used, which will be numbered lt0-ltN
+
+Configuring Netatalk
+--------------------
+
+Netatalk natively supports Localtalk networks. Here is a simple
+configuration for one network:
+
+    lt0 -router -phase 2 -net 54321 -addr 54321.129 -zone LocalTalk
+
+This sets the node id to 129, but the node id will still be arbitrated
+on the network following the specifications. Starting Netatalk will then
+make shares and printers available on the Localtalk network.
+Multiple adapters can be used together:
+
+    lt0 -seed -phase 2 -net 1 -addr 1.129 -zone "AirTalk"
+    lt1 -seed -phase 2 -net 2 -addr 2.130 -zone "LocalTalk"
+
+And also different type of adapters (like Ethernet) can be mixed in
+the Netatalk routing.
+
+Addressing
+----------
+
+LocalTalk addresses are dynamically assigned by default. In the Linux
+implementation, a user program must request a preferred address, which
+the driver will attempt to allocate. If the preferred address is unavailable,
+the driver will suggest a new, randomly generated one, as specified by the
+LocalTalk protocol. The user program should then retrieve the assigned address.
+
+In the COPS LocalTalk implementation, this process was handled in a blocking
+manner, and Netatalk continues to expect this behavior. The same approach is
+implemented in this driver. When the user program issues a `SIOCSIFADDR` ioctl,
+it triggers the address arbitration algorithm. The ioctl call will only return
+once the arbitration is complete. Subsequently, a `SIOCGIFADDR` ioctl is required
+to obtain the actual assigned address.
+
+
+Debug
+-----
+
+Despite the name, tcpdump is able to understand DDP and basic AppleTalk packets:
+
+    sudo tcpdump -i lt0 -vvvX
+
+The driver can also be recompiled setting the TASH_DEBUG option, to have a more
+verbose log of what is going on.
+
+`print_hex_dump_bytes` is used to print incoming and outgoing packets
+
+    echo 'file tashtalk.c line 231 +p' > /sys/kernel/debug/dynamic_debug/control
+
+Please consult the current source for the exact line numbers.
+
+Credits
+-------
+
+Many thanks to Tashtari (https://github.com/lampmerchant) for his TashTalk
+implementation of LocalTalk, as well as his invaluable assistance in debugging this
+driver and his unwavering support throughout the project.
+
+Special thanks to Doug Brown for his invaluable help, patience, thorough reviews,
+and insightful comments on my code, as well as his support throughout the
+submission process.
\ No newline at end of file
diff --git a/Documentation/networking/device_drivers/index.rst b/Documentation/networking/device_drivers/index.rst
index 0dd30a84ce25..1ab70c94e1aa 100644
--- a/Documentation/networking/device_drivers/index.rst
+++ b/Documentation/networking/device_drivers/index.rst
@@ -8,6 +8,7 @@ Contents:
 .. toctree::
    :maxdepth: 2
 
+   appletalk/index
    atm/index
    cable/index
    can/index
diff --git a/MAINTAINERS b/MAINTAINERS
index 8766f3e5e87e..7fbde47d00b9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -22237,6 +22237,13 @@ F:	Documentation/filesystems/sysv-fs.rst
 F:	fs/sysv/
 F:	include/linux/sysv_fs.h
 
+TASHTALK APPLETALK DRIVER
+M:	Rodolfo Zitellini <rwz@xhero.org>
+L:	netdev@vger.kernel.org
+S:	Maintained
+F:	Documentation/networking/device_drivers/appletalk/tashtalk.rst
+F:	drivers/net/can/appletalk/tashtalk.c
+
 TASKSTATS STATISTICS INTERFACE
 M:	Balbir Singh <bsingharora@gmail.com>
 S:	Maintained
diff --git a/drivers/net/Kconfig b/drivers/net/Kconfig
index 9920b3a68ed1..2cb47e93ce5a 100644
--- a/drivers/net/Kconfig
+++ b/drivers/net/Kconfig
@@ -668,4 +668,6 @@ config NETDEV_LEGACY_INIT
 	  Drivers that call netdev_boot_setup_check() should select this
 	  symbol, everything else no longer needs it.
 
+source "drivers/net/appletalk/Kconfig"
+
 endif # NETDEVICES
diff --git a/drivers/net/Makefile b/drivers/net/Makefile
index 13743d0e83b5..d232ee2bbd13 100644
--- a/drivers/net/Makefile
+++ b/drivers/net/Makefile
@@ -47,6 +47,7 @@ obj-$(CONFIG_MHI_NET) += mhi_net.o
 # Networking Drivers
 #
 obj-$(CONFIG_ARCNET) += arcnet/
+obj-$(CONFIG_DEV_APPLETALK) += appletalk/
 obj-$(CONFIG_CAIF) += caif/
 obj-$(CONFIG_CAN) += can/
 ifdef CONFIG_NET_DSA
diff --git a/drivers/net/appletalk/Kconfig b/drivers/net/appletalk/Kconfig
new file mode 100644
index 000000000000..96e9f7121de1
--- /dev/null
+++ b/drivers/net/appletalk/Kconfig
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Appletalk driver configuration
+#
+
+config DEV_APPLETALK
+	tristate "Appletalk interfaces support"
+	depends on ATALK
+	help
+	  AppleTalk is a network protocol developed by Apple that allows Apple
+	  computers to communicate with each other over a network. This protocol
+	  is versatile and can operate over various types of physical interfaces.
+	  For instance, if you have a specific physical interface available,
+	  such as a LocalTalk serial adapter, you can enable support for it by
+	  selecting "Y" here. It's important to note that this support is
+	  specifically for non-Ethernet devices, which are natively supported
+	  by the appletalk driver
+
+	  By enabling this option, you ensure that your system can utilize the
+	  AppleTalk protocol over these alternative interfaces, allowing legacy
+	  Apple devices to communicate with your moder machines.
+
+config TASHTALK
+	tristate "TashTalk LocalTalk Interface Support"
+	depends on ATALK && DEV_APPLETALK
+	depends on NETDEVICES
+	help
+	  TashTalk is a serial adapter for LocalTalk interfaces. It permits
+	  to natively connect to a LocalTalk bus via a serial port or USB
+	  adapter. It will then work natively with Netatalk, and it can be
+	  used to communicate with a network of classic Macintoshes or
+	  compatibile systems.
+	  <file:Documentation/networking/device_drivers/appletalk/tashtalk.rst>.
diff --git a/drivers/net/appletalk/Makefile b/drivers/net/appletalk/Makefile
new file mode 100644
index 000000000000..897ecbe65b29
--- /dev/null
+++ b/drivers/net/appletalk/Makefile
@@ -0,0 +1,6 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for drivers/net/appletalk
+#
+
+obj-$(CONFIG_TASHTALK) += tashtalk.o
diff --git a/drivers/net/appletalk/tashtalk.c b/drivers/net/appletalk/tashtalk.c
new file mode 100644
index 000000000000..d7e6aae1e24d
--- /dev/null
+++ b/drivers/net/appletalk/tashtalk.c
@@ -0,0 +1,1003 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/*      tashtalk.c: TashTalk LocalTalk driver for Linux.
+ *
+ *	Authors:
+ *      Rodolfo Zitellini (twelvetone12)
+ *
+ *      Derived from:
+ *      - slip.c: A network driver outline for linux.
+ *        written by Laurence Culhane and Fred N. van Kempen
+ *
+ *      This software may be used and distributed according to the terms
+ *      of the GNU General Public License, incorporated herein by reference.
+ *
+ */
+
+#include <linux/compat.h>
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+
+#include <linux/uaccess.h>
+#include <linux/bitops.h>
+#include <linux/sched/signal.h>
+#include <linux/string.h>
+#include <linux/mm.h>
+#include <linux/interrupt.h>
+#include <linux/in.h>
+#include <linux/tty.h>
+#include <linux/errno.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/rtnetlink.h>
+#include <linux/if_arp.h>
+#include <linux/delay.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <linux/workqueue.h>
+#include <linux/if_ltalk.h>
+#include <linux/atalk.h>
+
+#ifndef TASH_DEBUG
+#define TASH_DEBUG 0
+#endif
+static unsigned int tash_debug = TASH_DEBUG;
+
+/* Max number of channels
+ * override with insmod -otash_maxdev=nnn
+ */
+#define TASH_MAX_CHAN 32
+#define TT_MTU 605
+/* The buffer should be double since potentially
+ * all bytes inside are escaped.
+ */
+#define BUF_LEN (TT_MTU * 2 + 4)
+
+struct tashtalk {
+	int magic;
+
+	struct tty_struct *tty;        /* ptr to TTY structure		*/
+	struct net_device *dev;        /* easy for intr handling	*/
+	spinlock_t lock;
+	wait_queue_head_t addr_wait;
+	struct work_struct tx_work;    /* Flushes transmit buffer	*/
+
+	/* These are pointers to the malloc()ed frame buffers. */
+	unsigned char *rbuff;          /* receiver buffer		*/
+	int rcount;                    /* received chars counter       */
+	unsigned char *xbuff;          /* transmitter buffer		*/
+	unsigned char *xhead;          /* pointer to next byte to XMIT */
+	int xleft;                     /* bytes left in XMIT queue     */
+	int mtu;
+	int buffsize;                  /* Max buffers sizes            */
+
+	unsigned long flags;           /* Flag values/ mode etc	*/
+	unsigned char mode;            /* really not used */
+	pid_t pid;
+
+	struct atalk_addr node_addr;   /* Full node address */
+};
+
+#define TT_FLAG_INUSE       0 /* Channel in use                     */
+#define TT_FLAG_ESCAPE      1 /* ESC received                       */
+#define TT_FLAG_INFRAME     2 /* We did not finish decoding a frame */
+#define TT_FLAG_WAITADDR    3 /* We are waiting for an address      */
+#define TT_FLAG_GOTACK      4 /* Received an ACK for our ENQ        */
+
+#define TT_CMD_NOP	    0x00
+#define TT_CMD_TX	    0x01
+#define TT_CMD_SET_NIDS	    0x02
+#define TT_CMD_SET_FEAT	    0x03
+
+#define TASH_MAGIC          0xFDFA
+#define LLAP_CHECK          0xF0B8
+
+#define LLAP_ENQ            0x81
+#define LLAP_ACK            0x82
+#define LLAP_RTS            0x84
+#define LLAP_CTS            0x85
+
+#define LLAP_DST_POS        0
+#define LLAP_SRC_POS        1
+#define LLAP_TYP_POS        2
+
+static struct net_device **tashtalk_devs;
+
+static int tash_maxdev = TASH_MAX_CHAN;
+module_param(tash_maxdev, int, 0);
+MODULE_PARM_DESC(tash_maxdev, "Maximum number of tashtalk devices");
+
+static void tashtalk_send_ctrl_packet(struct tashtalk *tt, unsigned char dst,
+				      unsigned char src, unsigned char type);
+
+static unsigned char tt_arbitrate_addr_blocking(struct tashtalk *tt, unsigned char addr);
+
+static void tash_setbits(struct tashtalk *tt, unsigned char addr)
+{
+	unsigned char bits[33];
+	unsigned int byte, pos;
+
+	/* 0, 255 and anything else are invalid */
+	if (addr == 0 || addr >= 255)
+		return;
+
+	memset(bits, 0, sizeof(bits));
+
+	/* in theory we can respond to many addresses */
+	byte = addr / 8 + 1; /* skip initial command byte */
+	pos = (addr % 8);
+
+	if (tash_debug)
+		netdev_dbg(tt->dev,
+			   "Setting address %i (byte %i bit %i) for you.",
+			    addr, byte - 1, pos);
+
+	bits[0] = TT_CMD_SET_NIDS;
+	bits[byte] = (1 << pos);
+
+	set_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
+	tt->tty->ops->write(tt->tty, bits, sizeof(bits));
+}
+
+static u16 tt_crc_ccitt_update(u16 crc, u8 data)
+{
+	data ^= (u8)(crc) & (u8)(0xFF);
+	data ^= data << 4;
+	return ((((u16)data << 8) | ((crc & 0xFF00) >> 8)) ^ (u8)(data >> 4) ^
+		((u16)data << 3));
+}
+
+static u16 tash_crc(const unsigned char *data, int len)
+{
+	u16 crc = 0xFFFF;
+
+	for (int i = 0; i < len; i++)
+		crc = tt_crc_ccitt_update(crc, data[i]);
+
+	return crc;
+}
+
+/* Send one completely decapsulated DDP datagram to the DDP layer. */
+static void tt_post_to_netif(struct tashtalk *tt)
+{
+	struct net_device *dev = tt->dev;
+	struct sk_buff *skb;
+
+	/* before doing stuff, we need to make sure it is not a control frame
+	 * Control frames are always 5 bytes long
+	 */
+	if (tt->rcount <= 5)
+		return;
+
+	/* 0xF0B8 is the polynomial used in LLAP */
+	if (tash_crc(tt->rbuff, tt->rcount) != LLAP_CHECK) {
+		netdev_warn(dev, "Invalid CRC, drop packet");
+		return;
+	}
+
+	tt->rcount -= 2; /* Strip away the CRC bytes */
+	dev->stats.rx_bytes += tt->rcount;
+
+	skb = netdev_alloc_skb(dev, tt->rcount);
+	if (!skb) {
+		dev->stats.rx_dropped++;
+		return;
+	}
+
+	/* skip the CRC bytes at the end */
+	skb_put_data(skb, tt->rbuff, tt->rcount);
+	skb->protocol = htons(ETH_P_LOCALTALK);
+
+	/* This is for compatibility with the phase1 to phase2 translation */
+	skb_reset_mac_header(skb); /* Point to entire packet. */
+	skb_pull(skb, 3);
+	skb_reset_transport_header(skb); /* Point to data (Skip header). */
+
+	netif_rx(skb);
+	dev->stats.rx_packets++;
+}
+
+/* Encapsulate one DDP datagram into a TTY queue. */
+static void tt_send_frame(struct tashtalk *tt, unsigned char *icp, int len)
+{
+	int actual;
+	u16 crc;
+
+	/* This should not happen as we check beforehand */
+	if (len + 3 > BUF_LEN) {
+		netdev_err(tt->dev, "Dropping oversized buffer\n");
+		return;
+	}
+
+	crc = tash_crc(icp, len);
+
+	tt->xbuff[0] = TT_CMD_TX; /* First byte is te Tash TRANSMIT command */
+	memcpy(&tt->xbuff[1], icp, len); /* followed by all the bytes */
+	/* Last two bytes are the CRC */
+	tt->xbuff[1 + len] = ~(crc & 0xFF);
+	tt->xbuff[2 + len] = ~(crc >> 8);
+
+	len += 3; /* Account for Tash CMD + CRC */
+	actual = tt->tty->ops->write(tt->tty, tt->xbuff, len);
+
+	tt->xleft = len - actual;
+	/* see you in tash_transmit_worker */
+	tt->xhead = tt->xbuff + actual;
+
+	print_hex_dump_bytes("TashTalk: LLAP OUT frame sans CRC: ",
+			     DUMP_PREFIX_NONE, icp, len);
+
+	if (tash_debug)
+		netdev_dbg(tt->dev, "Transmit actual %i, requested %i",
+			   actual, len);
+
+	if (actual == len) {
+		clear_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
+		netif_wake_queue(tt->dev);
+	} else {
+		set_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
+	}
+}
+
+/* Write out any remaining transmit buffer. Scheduled when tty is writable */
+static void tash_transmit_worker(struct work_struct *work)
+{
+	struct tashtalk *tt = container_of(work, struct tashtalk, tx_work);
+	int actual;
+
+	spin_lock_bh(&tt->lock);
+	/* First make sure we're connected. */
+	if (!tt->tty || tt->magic != TASH_MAGIC || !netif_running(tt->dev)) {
+		spin_unlock_bh(&tt->lock);
+		return;
+	}
+
+	/* We always get here after all transmissions
+	 * No more data?
+	 */
+	if (tt->xleft <= 0) {
+		/* reset the flags for transmission
+		 * and re-wake the netif queue
+		 */
+		tt->dev->stats.tx_packets++;
+		clear_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
+		spin_unlock_bh(&tt->lock);
+		netif_wake_queue(tt->dev);
+
+		return;
+	}
+
+	/* Send whatever is there to send
+	 * This function will be called again if xleft <= 0
+	 */
+	actual = tt->tty->ops->write(tt->tty, tt->xhead, tt->xleft);
+	tt->xleft -= actual;
+	tt->xhead += actual;
+
+	spin_unlock_bh(&tt->lock);
+}
+
+/* Called by the driver when there's room for more data.
+ * Schedule the transmit.
+ */
+static void tashtalk_write_wakeup(struct tty_struct *tty)
+{
+	struct tashtalk *tt;
+
+	rcu_read_lock();
+	tt = rcu_dereference(tty->disc_data);
+	if (tt)
+		schedule_work(&tt->tx_work);
+	rcu_read_unlock();
+}
+
+static void tt_tx_timeout(struct net_device *dev, unsigned int txqueue)
+{
+	struct tashtalk *tt = netdev_priv(dev);
+
+	spin_lock(&tt->lock);
+
+	if (netif_queue_stopped(dev)) {
+		if (!netif_running(dev) || !tt->tty)
+			goto out;
+	}
+out:
+	spin_unlock(&tt->lock);
+}
+
+static netdev_tx_t tt_transmit(struct sk_buff *skb, struct net_device *dev)
+{
+	struct tashtalk *tt = netdev_priv(dev);
+
+	if (skb->len > tt->mtu) {
+		netdev_err(dev, "Dropping oversized transmit packet %i vs %i!\n",
+			   skb->len, tt->mtu);
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+
+	spin_lock(&tt->lock);
+	if (!netif_running(dev)) {
+		spin_unlock(&tt->lock);
+		netdev_err(dev, "Transmit call when iface is down\n");
+		dev_kfree_skb(skb);
+		return NETDEV_TX_OK;
+	}
+	if (!tt->tty) {
+		spin_unlock(&tt->lock);
+		dev_kfree_skb(skb);
+		netdev_err(dev, "TTY not connected\n");
+		return NETDEV_TX_OK;
+	}
+
+	netif_stop_queue(tt->dev);
+	dev->stats.tx_bytes += skb->len;
+	tt_send_frame(tt, skb->data, skb->len);
+	spin_unlock(&tt->lock);
+
+	dev_kfree_skb(skb);
+	return NETDEV_TX_OK;
+}
+
+/******************************************
+ *   Routines looking at netdevice side.
+ ******************************************/
+
+/* Netdevice UP -> DOWN routine */
+
+static int tt_close(struct net_device *dev)
+{
+	struct tashtalk *tt = netdev_priv(dev);
+
+	spin_lock_bh(&tt->lock);
+	if (tt->tty)
+		/* TTY discipline is running. */
+		clear_bit(TTY_DO_WRITE_WAKEUP, &tt->tty->flags);
+	netif_stop_queue(dev);
+	tt->rcount = 0;
+	tt->xleft = 0;
+	spin_unlock_bh(&tt->lock);
+
+	return 0;
+}
+
+/* Netdevice DOWN -> UP routine */
+
+static int tt_open(struct net_device *dev)
+{
+	struct tashtalk *tt = netdev_priv(dev);
+
+	if (!tt->tty) {
+		netdev_err(dev, "TTY not open");
+		return -ENODEV;
+	}
+
+	tt->flags &= (1 << TT_FLAG_INUSE);
+	netif_start_queue(dev);
+	return 0;
+}
+
+/* Netdevice get statistics request */
+static void tt_get_stats64(struct net_device *dev,
+			   struct rtnl_link_stats64 *stats)
+{
+	struct net_device_stats *devstats = &dev->stats;
+
+	stats->rx_packets = devstats->rx_packets;
+	stats->tx_packets = devstats->tx_packets;
+	stats->rx_bytes = devstats->rx_bytes;
+	stats->tx_bytes = devstats->tx_bytes;
+	stats->rx_dropped = devstats->rx_dropped;
+	stats->tx_dropped = devstats->tx_dropped;
+	stats->tx_errors = devstats->tx_errors;
+	stats->rx_errors = devstats->rx_errors;
+	stats->rx_over_errors = devstats->rx_over_errors;
+}
+
+/* This has to be blocking for compatibility with netatalk */
+static unsigned char tt_arbitrate_addr_blocking(struct tashtalk *tt,
+						unsigned char addr)
+{
+	unsigned char min, max;
+	unsigned char rand;
+	int i;
+
+	/* Set the ranges, the new address should stay in the proper one
+	 * I.e. a server should be >= 129 and a client always < 129
+	 */
+	min = (addr < 129) ? 1 : 129;
+	max = (addr < 129) ? 128 : 254;
+
+	if (tash_debug)
+		netdev_dbg(tt->dev,
+			   "Start address arbitration, requested %i", addr);
+
+	/* This works a bit backwards, we send many ENQs
+	 * and are happy not to receive ACKs.
+	 * If we get ACK, we try another addr
+	 */
+
+	set_bit(TT_FLAG_WAITADDR, &tt->flags);
+
+	for (i = 0; i < 10; i++) {
+		clear_bit(TT_FLAG_GOTACK, &tt->flags);
+		tashtalk_send_ctrl_packet(tt, addr, addr, LLAP_ENQ);
+
+		/* Timeout == nobody reclaims our addr */
+		if (wait_event_timeout(tt->addr_wait,
+				       test_bit(TT_FLAG_GOTACK, &tt->flags),
+				       msecs_to_jiffies(1))) {
+			unsigned char newaddr;
+
+			/* Oops! somebody has the same addr as us
+			 * make up a new one and start over
+			 */
+			get_random_bytes(&rand, 1);
+			newaddr = min + rand % (max - min + 1);
+			if (tash_debug)
+				netdev_dbg(tt->dev, "Addr %i is in use, try %i",
+					   addr, newaddr);
+			addr = newaddr;
+		}
+	}
+
+	clear_bit(TT_FLAG_WAITADDR, &tt->flags);
+	clear_bit(TT_FLAG_GOTACK, &tt->flags);
+
+	netdev_info(tt->dev, "Arbitrated address is %i", addr);
+
+	return addr;
+}
+
+static int tt_ioctl(struct net_device *dev, struct ifreq *ifr, int cmd)
+{
+	struct sockaddr_at *sa = (struct sockaddr_at *)&ifr->ifr_addr;
+	struct tashtalk *tt = netdev_priv(dev);
+	struct atalk_addr *aa = &tt->node_addr;
+
+	switch (cmd) {
+	case SIOCSIFADDR:
+
+		sa->sat_addr.s_node =
+			tt_arbitrate_addr_blocking(tt, sa->sat_addr.s_node);
+
+		aa->s_net = sa->sat_addr.s_net;
+		aa->s_node = sa->sat_addr.s_node;
+
+		/* Set broadcast address. */
+		dev->broadcast[0] = 0xFF;
+
+		/* Set hardware address. */
+		dev->addr_len = 1;
+		dev_addr_set(dev, &aa->s_node);
+
+		/* Setup tashtalk to respond to that addr */
+		tash_setbits(tt, aa->s_node);
+
+		return 0;
+
+	case SIOCGIFADDR:
+		sa->sat_addr.s_net = aa->s_net;
+		sa->sat_addr.s_node = aa->s_node;
+
+		return 0;
+
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+/* The destructor */
+static void tt_free_netdev(struct net_device *dev)
+{
+	int i = dev->base_addr;
+
+	tashtalk_devs[i] = NULL;
+}
+
+/* Copied from cops.c, make appletalk happy */
+static void tt_set_multicast(struct net_device *dev)
+{
+	netdev_dbg(dev, "set_multicast_list executed\n");
+}
+
+static const struct net_device_ops tt_netdev_ops = {
+	.ndo_open = tt_open,
+	.ndo_stop = tt_close,
+	.ndo_start_xmit = tt_transmit,
+	.ndo_get_stats64 = tt_get_stats64,
+	.ndo_tx_timeout = tt_tx_timeout,
+	.ndo_do_ioctl = tt_ioctl,
+	.ndo_set_rx_mode = tt_set_multicast,
+};
+
+static void tashtalk_send_ctrl_packet(struct tashtalk *tt, unsigned char dst,
+				      unsigned char src, unsigned char type)
+{
+	unsigned char cmd = TT_CMD_TX;
+	unsigned char buf[5];
+	int actual;
+	u16 crc;
+
+	buf[LLAP_DST_POS] = dst;
+	buf[LLAP_SRC_POS] = src;
+	buf[LLAP_TYP_POS] = type;
+
+	crc = tash_crc(buf, 3);
+	buf[3] = ~(crc & 0xFF);
+	buf[4] = ~(crc >> 8);
+
+	actual = tt->tty->ops->write(tt->tty, &cmd, 1);
+	actual += tt->tty->ops->write(tt->tty, buf, sizeof(buf));
+}
+
+static void tashtalk_manage_control_frame(struct tashtalk *tt)
+{
+	switch (tt->rbuff[LLAP_TYP_POS]) {
+	case LLAP_ENQ:
+
+		if (tt->node_addr.s_node != 0 &&
+		    tt->rbuff[LLAP_SRC_POS] == tt->node_addr.s_node) {
+			if (tash_debug) {
+				netdev_dbg(tt->dev, "Reply ACK to ENQ from %i",
+					   tt->rbuff[LLAP_SRC_POS]);
+			}
+
+			tashtalk_send_ctrl_packet(tt, tt->rbuff[LLAP_SRC_POS],
+						  tt->node_addr.s_node,
+						  LLAP_ACK);
+		}
+
+		break;
+
+	case LLAP_ACK:
+		if (test_bit(TT_FLAG_WAITADDR, &tt->flags)) {
+			set_bit(TT_FLAG_GOTACK, &tt->flags);
+			wake_up(&tt->addr_wait);
+		}
+		break;
+	}
+}
+
+static int tashtalk_is_control_frame(unsigned char *frame)
+{
+	return (frame[LLAP_TYP_POS] >= LLAP_ENQ &&
+		frame[LLAP_TYP_POS] <= LLAP_CTS);
+}
+
+static void tashtalk_manage_valid_frame(struct tashtalk *tt)
+{
+	if (tash_debug)
+		netdev_dbg(tt->dev, "(3) TashTalk done frame, len=%i",
+			   tt->rcount);
+
+	print_hex_dump_bytes("(3a) LLAP IN frame: ", DUMP_PREFIX_NONE,
+			     tt->rbuff, tt->rcount);
+
+	/* Control frames are not sent to the netif */
+	if (tt->rcount == 5 && tashtalk_is_control_frame(tt->rbuff))
+		tashtalk_manage_control_frame(tt);
+	else
+		tt_post_to_netif(tt);
+
+	if (tash_debug)
+		netdev_dbg(tt->dev, "(4) TashTalk next frame");
+}
+
+static void tashtalk_manage_escape(struct tashtalk *tt, unsigned char seq)
+{
+	switch (seq) {
+	case 0xFD:
+		tashtalk_manage_valid_frame(tt);
+		break;
+	case 0xFE:
+		netdev_info(tt->dev, "Frame error");
+		break;
+	case 0xFA:
+		netdev_info(tt->dev, "Frame abort");
+		break;
+	case 0xFC:
+		netdev_info(tt->dev, "Frame crc error");
+		break;
+
+	default:
+		netdev_warn(tt->dev, "Unknown escape sequence %c", seq);
+		break;
+	}
+
+	tt->rcount = 0;
+	clear_bit(TT_FLAG_INFRAME, &tt->flags);
+}
+
+/*********************************************
+ * Routines looking at TTY talking to TashTalk
+ *********************************************/
+
+static void tashtalk_receive_buf(struct tty_struct *tty,
+				 const u8 *cp, const u8 *fp,
+				 size_t count)
+{
+	struct tashtalk *tt = tty->disc_data;
+	int i;
+
+	if (!tt || tt->magic != TASH_MAGIC || !netif_running(tt->dev))
+		return;
+
+	if (tash_debug)
+		netdev_dbg(tt->dev, "(1) TashTalk read %li", count);
+
+	print_hex_dump_bytes("Tash read: ", DUMP_PREFIX_NONE, cp, count);
+
+	if (!test_bit(TT_FLAG_INFRAME, &tt->flags)) {
+		tt->rcount = 0;
+		if (tash_debug)
+			netdev_dbg(tt->dev, "(2) TashTalk start new frame");
+	} else if (tash_debug) {
+		netdev_dbg(tt->dev, "(2) TashTalk continue frame");
+	}
+
+	set_bit(TT_FLAG_INFRAME, &tt->flags);
+
+	for (i = 0; i < count; i++) {
+		set_bit(TT_FLAG_INFRAME, &tt->flags);
+
+		if (cp[i] == 0x00) {
+			set_bit(TT_FLAG_ESCAPE, &tt->flags);
+			continue;
+		}
+
+		if (test_and_clear_bit(TT_FLAG_ESCAPE, &tt->flags)) {
+			if (cp[i] == 0xFF) {
+				tt->rbuff[tt->rcount] = 0x00;
+				tt->rcount++;
+			} else {
+				tashtalk_manage_escape(tt, cp[i]);
+			}
+		} else {
+			tt->rbuff[tt->rcount] = cp[i];
+			tt->rcount++;
+		}
+	}
+
+	if (tash_debug)
+		netdev_dbg(tt->dev, "(5) Done read, pending frame=%i",
+			   test_bit(TT_FLAG_INFRAME, &tt->flags));
+}
+
+/* Free a channel buffers. */
+static void tt_free_bufs(struct tashtalk *tt)
+{
+	kfree(xchg(&tt->rbuff, NULL));
+	kfree(xchg(&tt->xbuff, NULL));
+}
+
+static int tt_alloc_bufs(struct tashtalk *tt, int buf_len)
+{
+	int err = -ENOBUFS;
+	char *rbuff = NULL;
+	char *xbuff = NULL;
+	unsigned long len;
+
+	rbuff = kmalloc(buf_len, GFP_KERNEL);
+	if (!rbuff)
+		goto err_exit;
+
+	xbuff = kmalloc(buf_len, GFP_KERNEL);
+	if (!xbuff)
+		goto err_exit;
+
+	spin_lock_bh(&tt->lock);
+	if (!tt->tty) {
+		spin_unlock_bh(&tt->lock);
+		err = -ENODEV;
+		goto err_exit;
+	}
+
+	tt->buffsize = len;
+	tt->rcount = 0;
+	tt->xleft = 0;
+
+	rbuff = xchg(&tt->rbuff, rbuff);
+	xbuff = xchg(&tt->xbuff, xbuff);
+
+	spin_unlock_bh(&tt->lock);
+	err = 0;
+
+	/* Cleanup */
+err_exit:
+
+	kfree(xbuff);
+	kfree(rbuff);
+	return err;
+}
+
+/* Find a free channel, and link in this `tty' line. */
+static struct tashtalk *tt_alloc(void)
+{
+	struct net_device *dev = NULL;
+	struct tashtalk *tt;
+	int i;
+
+	for (i = 0; i < tash_maxdev; i++) {
+		dev = tashtalk_devs[i];
+		if (!dev)
+			break;
+	}
+
+	if (i >= tash_maxdev) {
+		pr_err("TashTalk: all slots in use");
+		return NULL;
+	}
+
+	/* Also assigns the default lt* name */
+	dev = alloc_ltalkdev(sizeof(*tt));
+
+	if (!dev) {
+		pr_err("TashTalk: could not allocate ltalkdev");
+		return NULL;
+	}
+
+	dev->base_addr = i;
+	tt = netdev_priv(dev);
+
+	/* Initialize channel control data */
+	tt->magic = TASH_MAGIC;
+	tt->dev = dev;
+	tt->mtu = TT_MTU;
+	tt->mode = 0; /*Maybe useful in the future? */
+
+	tt->dev->netdev_ops = &tt_netdev_ops;
+	tt->dev->type = ARPHRD_LOCALTLK;
+	tt->dev->priv_destructor = tt_free_netdev;
+
+	/* Initially we have no address */
+	/* so we do not reply to ENQs */
+	tt->node_addr.s_node = 0;
+	tt->node_addr.s_net = 0;
+
+	spin_lock_init(&tt->lock);
+	init_waitqueue_head(&tt->addr_wait);
+	INIT_WORK(&tt->tx_work, tash_transmit_worker);
+
+	tashtalk_devs[i] = dev;
+	return tt;
+}
+
+/* Open the high-level part of the TashTalk channel.
+ * Generally used with a userspace program:
+ * sudo ldattach -d -s 1000000 PPP /dev/ttyUSB0
+ */
+
+static int tashtalk_open(struct tty_struct *tty)
+{
+	struct tashtalk *tt;
+	int err;
+
+	if (!capable(CAP_NET_ADMIN))
+		return -EPERM;
+
+	if (!tty->ops->write)
+		return -EOPNOTSUPP;
+
+	rtnl_lock();
+
+	tt = tty->disc_data;
+
+	err = -EEXIST;
+	/* First make sure we're not already connected. */
+	if (tt && tt->magic == TASH_MAGIC)
+		goto err_exit;
+
+	err = -ENFILE;
+
+	tt = tt_alloc();
+	if (!tt)
+		goto err_exit;
+
+	tt->tty = tty;
+	tty->disc_data = tt;
+	tt->pid = current->pid;
+
+	if (!test_bit(TT_FLAG_INUSE, &tt->flags)) {
+		set_bit(TT_FLAG_INUSE, &tt->flags);
+
+		err = tt_alloc_bufs(tt, BUF_LEN);
+		if (err)
+			goto err_free_chan;
+
+		err = register_netdevice(tt->dev);
+		if (err)
+			goto err_free_bufs;
+
+	} else {
+		pr_err("TashTalk: Channel is already in use");
+	}
+
+	/* Done.  We have linked the TTY line to a channel. */
+	rtnl_unlock();
+	tty->receive_room = 65536; /* We don't flow control */
+
+	/* TTY layer expects 0 on success */
+	pr_info("TashTalk is on port %s", tty->name);
+	return 0;
+
+err_free_bufs:
+	tt_free_bufs(tt);
+
+err_free_chan:
+	pr_err("TashTalk: could not open device");
+	tt->tty = NULL;
+	tty->disc_data = NULL;
+	clear_bit(TT_FLAG_INUSE, &tt->flags);
+
+	/* do not call free_netdev before rtnl_unlock */
+	rtnl_unlock();
+	free_netdev(tt->dev);
+	return err;
+
+err_exit:
+	rtnl_unlock();
+
+	/* Count references from TTY module */
+	return err;
+}
+
+static void tashtalk_close(struct tty_struct *tty)
+{
+	struct tashtalk *tt = tty->disc_data;
+
+	/* First make sure we're connected. */
+	if (!tt || tt->magic != TASH_MAGIC || tt->tty != tty)
+		return;
+
+	spin_lock_bh(&tt->lock);
+	rcu_assign_pointer(tty->disc_data, NULL);
+	tt->tty = NULL;
+	spin_unlock_bh(&tt->lock);
+
+	synchronize_rcu();
+	flush_work(&tt->tx_work);
+
+	/* Flush network side */
+	unregister_netdev(tt->dev);
+	/* This will complete via tt_free_netdev */
+}
+
+static void tashtalk_hangup(struct tty_struct *tty)
+{
+	tashtalk_close(tty);
+}
+
+static int tashtalk_ioctl(struct tty_struct *tty, unsigned int cmd,
+			  unsigned long arg)
+{
+	struct tashtalk *tt = tty->disc_data;
+	int __user *p = (int __user *)arg;
+	unsigned int tmp;
+
+	/* First make sure we're connected. */
+	if (!tt || tt->magic != TASH_MAGIC)
+		return -EINVAL;
+
+	switch (cmd) {
+	case SIOCGIFNAME:
+		tmp = strlen(tt->dev->name) + 1;
+		if (copy_to_user((void __user *)arg, tt->dev->name, tmp))
+			return -EFAULT;
+		return 0;
+
+	case SIOCGIFENCAP:
+		if (put_user(tt->mode, p))
+			return -EFAULT;
+		return 0;
+
+	case SIOCSIFENCAP:
+		if (get_user(tmp, p))
+			return -EFAULT;
+		tt->mode = tmp;
+		return 0;
+
+	case SIOCSIFHWADDR:
+		return -EINVAL;
+
+	default:
+		return tty_mode_ioctl(tty, cmd, arg);
+	}
+}
+
+static struct tty_ldisc_ops tashtalk_ldisc = {
+	.owner = THIS_MODULE,
+	.num = N_TASHTALK,
+	.name = "tasktalk",
+	.open = tashtalk_open,
+	.close = tashtalk_close,
+	.hangup = tashtalk_hangup,
+	.ioctl = tashtalk_ioctl,
+	.receive_buf = tashtalk_receive_buf,
+	.write_wakeup = tashtalk_write_wakeup,
+};
+
+static int __init tashtalk_init(void)
+{
+	int status;
+
+	if (tash_maxdev < 1)
+		tash_maxdev = 1;
+
+	pr_info("TashTalk Interface (dynamic channels, max=%d)",
+		tash_maxdev);
+
+	tashtalk_devs =
+		kcalloc(tash_maxdev, sizeof(struct net_device *), GFP_KERNEL);
+	if (!tashtalk_devs)
+		return -ENOMEM;
+
+	/* Fill in our line protocol discipline, and register it */
+	status = tty_register_ldisc(&tashtalk_ldisc);
+	if (status != 0) {
+		pr_err("TaskTalk: can't register line discipline (err = %d)\n",
+		       status);
+		kfree(tashtalk_devs);
+	}
+	return status;
+}
+
+static void __exit tashtalk_exit(void)
+{
+	unsigned long timeout = jiffies + HZ;
+	struct net_device *dev;
+	struct tashtalk *tt;
+	int busy = 0;
+	int i;
+
+	if (!tashtalk_devs)
+		return;
+
+	/* First of all: check for active disciplines and hangup them. */
+	do {
+		if (busy)
+			msleep_interruptible(100);
+
+		busy = 0;
+		for (i = 0; i < tash_maxdev; i++) {
+			dev = tashtalk_devs[i];
+			if (!dev)
+				continue;
+			tt = netdev_priv(dev);
+			spin_lock_bh(&tt->lock);
+			if (tt->tty) {
+				busy++;
+				tty_hangup(tt->tty);
+			}
+			spin_unlock_bh(&tt->lock);
+		}
+	} while (busy && time_before(jiffies, timeout));
+
+	for (i = 0; i < tash_maxdev; i++) {
+		dev = tashtalk_devs[i];
+		if (!dev)
+			continue;
+		tashtalk_devs[i] = NULL;
+
+		tt = netdev_priv(dev);
+		if (tt->tty) {
+			pr_err("%s: tty discipline still running\n",
+			       dev->name);
+		}
+
+		unregister_netdev(dev);
+	}
+
+	kfree(tashtalk_devs);
+	tashtalk_devs = NULL;
+
+	tty_unregister_ldisc(&tashtalk_ldisc);
+}
+
+module_init(tashtalk_init);
+module_exit(tashtalk_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_ALIAS_LDISC(N_TASHTALK);
-- 
2.34.1


