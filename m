Return-Path: <netdev+bounces-282416-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPq+L4oc8mljnwEAu9opvQ
	(envelope-from <netdev+bounces-282416-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:58:18 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD9D496664
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 16:58:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 714233048F2F
	for <lists+netdev@lfdr.de>; Wed, 29 Apr 2026 14:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC352339B2D;
	Wed, 29 Apr 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K/vNKl2s"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56E030DEB2;
	Wed, 29 Apr 2026 14:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777474613; cv=none; b=KVxlpoQiuO9oyMbCxBYAhAr6PdWFJCd+dn7dXpm/dKcqtSSBoA6UXKbG4KwMSfIW5az0q2graBANSZXro64i6kAb6V61bB/hoR7yvjuaOUYZ/Pt52qeDINyz5TRkqYw70gfx/J5/YMtH0uwjszYy9lf5xtFAnVH3gN8Ie4HBdzM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777474613; c=relaxed/simple;
	bh=10kT5ftFlGaOZWbAJHn1K/qaABh6W29gCocKldM0TV4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Q4ZePWb3epUFYTdjyz4DsJeBVabgGnhtp/P1HQe9SKGYdYmKghzelPBk0jgr6m0xUH5/De+DdCV1Kd5inx60cN7s5XbQek9HLc67BFxBe6vDYhbumBPYvT1oQctjUHPzQtqDrqbFS+ex6Z+MIo3zZ0zykRkMUx9lvMil8FLrwOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K/vNKl2s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20046C2BCC4;
	Wed, 29 Apr 2026 14:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777474613;
	bh=10kT5ftFlGaOZWbAJHn1K/qaABh6W29gCocKldM0TV4=;
	h=From:To:Cc:Subject:Date:From;
	b=K/vNKl2sdoMNmOOl8cXk9S+RNncsYLkdY3OpX0OyjcRB/dG5WFP+swetRYOJ+/xOo
	 Rq9pBNbm3Xxt+TZbqQsA8nSAx5EWFYfoBX4MR5eRRzBByraIKbr1TH88WCIJp5Mmz0
	 GKxBptSc4YGkWi+kAnFJKCm6XKsxy5CmwUjhyAdakQkNO7JXagvCh1H9XuffpjzF6C
	 DIAyl/eUG5wA8rpc+qwpXyjTaKlBMzlrFV/7la6jRh8/07MspjtyTWI98hN4fWGWKh
	 8juM15P2GvaoDe+k9RZgUk06kWv/SdStUlmNy528+FmhNPS9mJ5NsSgSdC80fQVStm
	 vqcKjfBUGqq/w==
From: Arnd Bergmann <arnd@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Jonathan Corbet <corbet@lwn.net>,
	Andrew Lunn <andrew+netdev@lunn.ch>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Mengyuan Lou <mengyuanlou@net-swift.com>,
	netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next 1/2] net: cs89x0: remove ISA bus probing
Date: Wed, 29 Apr 2026 16:55:45 +0200
Message-Id: <20260429145624.2948432-1-arnd@kernel.org>
X-Mailer: git-send-email 2.39.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 3BD9D496664
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-282416-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[arnd@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.995];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux-foundation.org:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,crynwr.com:email,arndb.de:email,cirrus.com:url,cirrus.com:email]

From: Arnd Bergmann <arnd@arndb.de>

The cs89x0 driver is really two in one, and they are mutually exclusive:

 - the ISA driver was used on 486-era PCs. It likely has no remaining
   users, like the other ethernet drivers that got removed in
   linux-7.1. The DMA support in here is the last device driver use of
   the deprecated isa_bus_to_virt() interface, all other users are either
   x86 specific or or got converted to the normal dma-mapping interface.
   The driver was maintained by Andrew Morton at the time, based on
   the linux-2.2 vendor driver from Cirrus Logic.

 - the platform_driver instance was used on some embedded Arm boards
   around the same time, such as the EP7211 Development Kit. This
   is the same chip, but uses modern devicetree based probing and no DMA.
   This was added by Alexander Shiyan.

Remove the ISA driver as a cleanup, including all of the outdated
documentation referring to its configuration.

Cc: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 .../device_drivers/ethernet/cirrus/cs89x0.rst | 647 ------------------
 .../device_drivers/ethernet/index.rst         |   1 -
 drivers/net/Space.c                           |   3 -
 drivers/net/ethernet/cirrus/Kconfig           |  20 +-
 drivers/net/ethernet/cirrus/cs89x0.c          | 636 +----------------
 include/net/Space.h                           |   1 -
 6 files changed, 6 insertions(+), 1302 deletions(-)
 delete mode 100644 Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst

diff --git a/Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst b/Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst
deleted file mode 100644
index e5c283940ac5..000000000000
--- a/Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst
+++ /dev/null
@@ -1,647 +0,0 @@
-.. SPDX-License-Identifier: GPL-2.0
-
-================================================
-Cirrus Logic LAN CS8900/CS8920 Ethernet Adapters
-================================================
-
-.. note::
-
-   This document was contributed by Cirrus Logic for kernel 2.2.5.  This version
-   has been updated for 2.3.48 by Andrew Morton.
-
-   Still, this is too outdated! A major cleanup is needed here.
-
-Cirrus make a copy of this driver available at their website, as
-described below.  In general, you should use the driver version which
-comes with your Linux distribution.
-
-
-Linux Network Interface Driver ver. 2.00 <kernel 2.3.48>
-
-
-.. TABLE OF CONTENTS
-
-   1.0 CIRRUS LOGIC LAN CS8900/CS8920 ETHERNET ADAPTERS
-	1.1 Product Overview
-	1.2 Driver Description
-	    1.2.1 Driver Name
-	    1.2.2 File in the Driver Package
-	1.3 System Requirements
-	1.4 Licensing Information
-
-   2.0 ADAPTER INSTALLATION and CONFIGURATION
-	2.1 CS8900-based Adapter Configuration
-	2.2 CS8920-based Adapter Configuration
-
-   3.0 LOADING THE DRIVER AS A MODULE
-
-   4.0 COMPILING THE DRIVER
-	4.1 Compiling the Driver as a Loadable Module
-	4.2 Compiling the driver to support memory mode
-	4.3 Compiling the driver to support Rx DMA
-
-   5.0 TESTING AND TROUBLESHOOTING
-	5.1 Known Defects and Limitations
-	5.2 Testing the Adapter
-	    5.2.1 Diagnostic Self-Test
-	    5.2.2 Diagnostic Network Test
-	5.3 Using the Adapter's LEDs
-	5.4 Resolving I/O Conflicts
-
-   6.0 TECHNICAL SUPPORT
-	6.1 Contacting Cirrus Logic's Technical Support
-	6.2 Information Required Before Contacting Technical Support
-	6.3 Obtaining the Latest Driver Version
-	6.4 Current maintainer
-	6.5 Kernel boot parameters
-
-
-1. Cirrus Logic LAN CS8900/CS8920 Ethernet Adapters
-===================================================
-
-
-1.1. Product Overview
-=====================
-
-The CS8900-based ISA Ethernet Adapters from Cirrus Logic follow
-IEEE 802.3 standards and support half or full-duplex operation in ISA bus
-computers on 10 Mbps Ethernet networks.  The adapters are designed for operation
-in 16-bit ISA or EISA bus expansion slots and are available in
-10BaseT-only or 3-media configurations (10BaseT, 10Base2, and AUI for 10Base-5
-or fiber networks).
-
-CS8920-based adapters are similar to the CS8900-based adapter with additional
-features for Plug and Play (PnP) support and Wakeup Frame recognition.  As
-such, the configuration procedures differ somewhat between the two types of
-adapters.  Refer to the "Adapter Configuration" section for details on
-configuring both types of adapters.
-
-
-1.2. Driver Description
-=======================
-
-The CS8900/CS8920 Ethernet Adapter driver for Linux supports the Linux
-v2.3.48 or greater kernel.  It can be compiled directly into the kernel
-or loaded at run-time as a device driver module.
-
-1.2.1 Driver Name: cs89x0
-
-1.2.2 Files in the Driver Archive:
-
-The files in the driver at Cirrus' website include:
-
-  ===================  ====================================================
-  readme.txt           this file
-  build                batch file to compile cs89x0.c.
-  cs89x0.c             driver C code
-  cs89x0.h             driver header file
-  cs89x0.o             pre-compiled module (for v2.2.5 kernel)
-  config/Config.in     sample file to include cs89x0 driver in the kernel.
-  config/Makefile      sample file to include cs89x0 driver in the kernel.
-  config/Space.c       sample file to include cs89x0 driver in the kernel.
-  ===================  ====================================================
-
-
-
-1.3. System Requirements
-------------------------
-
-The following hardware is required:
-
-   * Cirrus Logic LAN (CS8900/20-based) Ethernet ISA Adapter
-
-   * IBM or IBM-compatible PC with:
-     * An 80386 or higher processor
-     * 16 bytes of contiguous IO space available between 210h - 370h
-     * One available IRQ (5,10,11,or 12 for the CS8900, 3-7,9-15 for CS8920).
-
-   * Appropriate cable (and connector for AUI, 10BASE-2) for your network
-     topology.
-
-The following software is required:
-
-* LINUX kernel version 2.3.48 or higher
-
-   * CS8900/20 Setup Utility (DOS-based)
-
-   * LINUX kernel sources for your kernel (if compiling into kernel)
-
-   * GNU Toolkit (gcc and make) v2.6 or above (if compiling into kernel
-     or a module)
-
-
-
-1.4. Licensing Information
---------------------------
-
-This program is free software; you can redistribute it and/or modify it under
-the terms of the GNU General Public License as published by the Free Software
-Foundation, version 1.
-
-This program is distributed in the hope that it will be useful, but WITHOUT
-ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
-FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
-more details.
-
-For a full copy of the GNU General Public License, write to the Free Software
-Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
-
-
-
-2. Adapter Installation and Configuration
-=========================================
-
-Both the CS8900 and CS8920-based adapters can be configured using parameters
-stored in an on-board EEPROM. You must use the DOS-based CS8900/20 Setup
-Utility if you want to change the adapter's configuration in EEPROM.
-
-When loading the driver as a module, you can specify many of the adapter's
-configuration parameters on the command-line to override the EEPROM's settings
-or for interface configuration when an EEPROM is not used. (CS8920-based
-adapters must use an EEPROM.) See Section 3.0 LOADING THE DRIVER AS A MODULE.
-
-Since the CS8900/20 Setup Utility is a DOS-based application, you must install
-and configure the adapter in a DOS-based system using the CS8900/20 Setup
-Utility before installation in the target LINUX system.  (Not required if
-installing a CS8900-based adapter and the default configuration is acceptable.)
-
-
-2.1. CS8900-based Adapter Configuration
----------------------------------------
-
-CS8900-based adapters shipped from Cirrus Logic have been configured
-with the following "default" settings::
-
-  Operation Mode:      Memory Mode
-  IRQ:                 10
-  Base I/O Address:    300
-  Memory Base Address: D0000
-  Optimization:	       DOS Client
-  Transmission Mode:   Half-duplex
-  BootProm:            None
-  Media Type:	       Autodetect (3-media cards) or
-		       10BASE-T (10BASE-T only adapter)
-
-You should only change the default configuration settings if conflicts with
-another adapter exists. To change the adapter's configuration, run the
-CS8900/20 Setup Utility.
-
-
-2.2. CS8920-based Adapter Configuration
----------------------------------------
-
-CS8920-based adapters are shipped from Cirrus Logic configured as Plug
-and Play (PnP) enabled.  However, since the cs89x0 driver does NOT
-support PnP, you must install the CS8920 adapter in a DOS-based PC and
-run the CS8900/20 Setup Utility to disable PnP and configure the
-adapter before installation in the target Linux system.  Failure to do
-this will leave the adapter inactive and the driver will be unable to
-communicate with the adapter.
-
-::
-
-	****************************************************************
-	*                    CS8920-BASED ADAPTERS:                    *
-	*                                                              *
-	* CS8920-BASED ADAPTERS ARE PLUG and PLAY ENABLED BY DEFAULT.  *
-	* THE CS89X0 DRIVER DOES NOT SUPPORT PnP. THEREFORE, YOU MUST  *
-	* RUN THE CS8900/20 SETUP UTILITY TO DISABLE PnP SUPPORT AND   *
-	* TO ACTIVATE THE ADAPTER.                                     *
-	****************************************************************
-
-
-
-
-3. Loading the Driver as a Module
-=================================
-
-If the driver is compiled as a loadable module, you can load the driver module
-with the 'modprobe' command.  Many of the adapter's configuration parameters can
-be specified as command-line arguments to the load command.  This facility
-provides a means to override the EEPROM's settings or for interface
-configuration when an EEPROM is not used.
-
-Example::
-
-    insmod cs89x0.o io=0x200 irq=0xA media=aui
-
-This example loads the module and configures the adapter to use an IO port base
-address of 200h, interrupt 10, and use the AUI media connection.  The following
-configuration options are available on the command line::
-
-  io=###               - specify IO address (200h-360h)
-  irq=##               - specify interrupt level
-  use_dma=1            - Enable DMA
-  dma=#                - specify dma channel (Driver is compiled to support
-			 Rx DMA only)
-  dmasize=# (16 or 64) - DMA size 16K or 64K.  Default value is set to 16.
-  media=rj45           - specify media type
-   or media=bnc
-   or media=aui
-   or media=auto
-  duplex=full          - specify forced half/full/autonegotiate duplex
-   or duplex=half
-   or duplex=auto
-  debug=#              - debug level (only available if the driver was compiled
-			 for debugging)
-
-**Notes:**
-
-a) If an EEPROM is present, any specified command-line parameter
-   will override the corresponding configuration value stored in
-   EEPROM.
-
-b) The "io" parameter must be specified on the command-line.
-
-c) The driver's hardware probe routine is designed to avoid
-   writing to I/O space until it knows that there is a cs89x0
-   card at the written addresses.  This could cause problems
-   with device probing.  To avoid this behaviour, add one
-   to the ``io=`` module parameter.  This doesn't actually change
-   the I/O address, but it is a flag to tell the driver
-   to partially initialise the hardware before trying to
-   identify the card.  This could be dangerous if you are
-   not sure that there is a cs89x0 card at the provided address.
-
-   For example, to scan for an adapter located at IO base 0x300,
-   specify an IO address of 0x301.
-
-d) The "duplex=auto" parameter is only supported for the CS8920.
-
-e) The minimum command-line configuration required if an EEPROM is
-   not present is:
-
-   io
-   irq
-   media type (no autodetect)
-
-f) The following additional parameters are CS89XX defaults (values
-   used with no EEPROM or command-line argument).
-
-   * DMA Burst = enabled
-   * IOCHRDY Enabled = enabled
-   * UseSA = enabled
-   * CS8900 defaults to half-duplex if not specified on command-line
-   * CS8920 defaults to autoneg if not specified on command-line
-   * Use reset defaults for other config parameters
-   * dma_mode = 0
-
-g) You can use ifconfig to set the adapter's Ethernet address.
-
-h) Many Linux distributions use the 'modprobe' command to load
-   modules.  This program uses the '/etc/conf.modules' file to
-   determine configuration information which is passed to a driver
-   module when it is loaded.  All the configuration options which are
-   described above may be placed within /etc/conf.modules.
-
-   For example::
-
-     > cat /etc/conf.modules
-     ...
-     alias eth0 cs89x0
-     options cs89x0 io=0x0200 dma=5 use_dma=1
-     ...
-
-   In this example we are telling the module system that the
-   ethernet driver for this machine should use the cs89x0 driver.  We
-   are asking 'modprobe' to pass the 'io', 'dma' and 'use_dma'
-   arguments to the driver when it is loaded.
-
-i) Cirrus recommend that the cs89x0 use the ISA DMA channels 5, 6 or
-   7.  You will probably find that other DMA channels will not work.
-
-j) The cs89x0 supports DMA for receiving only.  DMA mode is
-   significantly more efficient.  Flooding a 400 MHz Celeron machine
-   with large ping packets consumes 82% of its CPU capacity in non-DMA
-   mode.  With DMA this is reduced to 45%.
-
-k) If your Linux kernel was compiled with inbuilt plug-and-play
-   support you will be able to find information about the cs89x0 card
-   with the command::
-
-     cat /proc/isapnp
-
-l) If during DMA operation you find erratic behavior or network data
-   corruption you should use your PC's BIOS to slow the EISA bus clock.
-
-m) If the cs89x0 driver is compiled directly into the kernel
-   (non-modular) then its I/O address is automatically determined by
-   ISA bus probing.  The IRQ number, media options, etc are determined
-   from the card's EEPROM.
-
-n) If the cs89x0 driver is compiled directly into the kernel, DMA
-   mode may be selected by providing the kernel with a boot option
-   'cs89x0_dma=N' where 'N' is the desired DMA channel number (5, 6 or 7).
-
-   Kernel boot options may be provided on the LILO command line::
-
-	LILO boot: linux cs89x0_dma=5
-
-   or they may be placed in /etc/lilo.conf::
-
-	image=/boot/bzImage-2.3.48
-	  append="cs89x0_dma=5"
-	  label=linux
-	  root=/dev/hda5
-	  read-only
-
-   The DMA Rx buffer size is hardwired to 16 kbytes in this mode.
-   (64k mode is not available).
-
-
-4. Compiling the Driver
-=======================
-
-The cs89x0 driver can be compiled directly into the kernel or compiled into
-a loadable device driver module.
-
-Just use the standard way to configure the driver and compile the Kernel.
-
-
-4.1. Compiling the Driver to Support Rx DMA
--------------------------------------------
-
-The compile-time optionality for DMA was removed in the 2.3 kernel
-series.  DMA support is now unconditionally part of the driver.  It is
-enabled by the 'use_dma=1' module option.
-
-
-5. Testing and Troubleshooting
-==============================
-
-5.1. Known Defects and Limitations
-----------------------------------
-
-Refer to the RELEASE.TXT file distributed as part of this archive for a list of
-known defects, driver limitations, and work arounds.
-
-
-5.2. Testing the Adapter
-------------------------
-
-Once the adapter has been installed and configured, the diagnostic option of
-the CS8900/20 Setup Utility can be used to test the functionality of the
-adapter and its network connection.  Use the diagnostics 'Self Test' option to
-test the functionality of the adapter with the hardware configuration you have
-assigned. You can use the diagnostics 'Network Test' to test the ability of the
-adapter to communicate across the Ethernet with another PC equipped with a
-CS8900/20-based adapter card (it must also be running the CS8900/20 Setup
-Utility).
-
-.. note::
-
-	 The Setup Utility's diagnostics are designed to run in a
-	 DOS-only operating system environment.  DO NOT run the diagnostics
-	 from a DOS or command prompt session under Windows 95, Windows NT,
-	 OS/2, or other operating system.
-
-To run the diagnostics tests on the CS8900/20 adapter:
-
-   1.  Boot DOS on the PC and start the CS8900/20 Setup Utility.
-
-   2.  The adapter's current configuration is displayed.  Hit the ENTER key to
-       get to the main menu.
-
-   4.  Select 'Diagnostics' (ALT-G) from the main menu.
-       * Select 'Self-Test' to test the adapter's basic functionality.
-       * Select 'Network Test' to test the network connection and cabling.
-
-
-5.2.1. Diagnostic Self-test
-^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The diagnostic self-test checks the adapter's basic functionality as well as
-its ability to communicate across the ISA bus based on the system resources
-assigned during hardware configuration.  The following tests are performed:
-
-   * IO Register Read/Write Test
-
-     The IO Register Read/Write test insures that the CS8900/20 can be
-     accessed in IO mode, and that the IO base address is correct.
-
-   * Shared Memory Test
-
-     The Shared Memory test insures the CS8900/20 can be accessed in memory
-     mode and that the range of memory addresses assigned does not conflict
-     with other devices in the system.
-
-   * Interrupt Test
-
-     The Interrupt test insures there are no conflicts with the assigned IRQ
-     signal.
-
-   * EEPROM Test
-
-     The EEPROM test insures the EEPROM can be read.
-
-   * Chip RAM Test
-
-     The Chip RAM test insures the 4K of memory internal to the CS8900/20 is
-     working properly.
-
-   * Internal Loop-back Test
-
-     The Internal Loop Back test insures the adapter's transmitter and
-     receiver are operating properly.  If this test fails, make sure the
-     adapter's cable is connected to the network (check for LED activity for
-     example).
-
-   * Boot PROM Test
-
-     The Boot PROM  test insures the Boot PROM is present, and can be read.
-     Failure indicates the Boot PROM  was not successfully read due to a
-     hardware problem or due to a conflicts on the Boot PROM address
-     assignment. (Test only applies if the adapter is configured to use the
-     Boot PROM option.)
-
-Failure of a test item indicates a possible system resource conflict with
-another device on the ISA bus.  In this case, you should use the Manual Setup
-option to reconfigure the adapter by selecting a different value for the system
-resource that failed.
-
-
-5.2.2. Diagnostic Network Test
-^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
-
-The Diagnostic Network Test verifies a working network connection by
-transferring data between two CS8900/20 adapters installed in different PCs
-on the same network. (Note: the diagnostic network test should not be run
-between two nodes across a router.)
-
-This test requires that each of the two PCs have a CS8900/20-based adapter
-installed and have the CS8900/20 Setup Utility running.  The first PC is
-configured as a Responder and the other PC is configured as an Initiator.
-Once the Initiator is started, it sends data frames to the Responder which
-returns the frames to the Initiator.
-
-The total number of frames received and transmitted are displayed on the
-Initiator's display, along with a count of the number of frames received and
-transmitted OK or in error.  The test can be terminated anytime by the user at
-either PC.
-
-To setup the Diagnostic Network Test:
-
-    1.  Select a PC with a CS8900/20-based adapter and a known working network
-	connection to act as the Responder.  Run the CS8900/20 Setup Utility
-	and select 'Diagnostics -> Network Test -> Responder' from the main
-	menu.  Hit ENTER to start the Responder.
-
-    2.  Return to the PC with the CS8900/20-based adapter you want to test and
-	start the CS8900/20 Setup Utility.
-
-    3.  From the main menu, Select 'Diagnostic -> Network Test -> Initiator'.
-	Hit ENTER to start the test.
-
-You may stop the test on the Initiator at any time while allowing the Responder
-to continue running.  In this manner, you can move to additional PCs and test
-them by starting the Initiator on another PC without having to stop/start the
-Responder.
-
-
-
-5.3. Using the Adapter's LEDs
------------------------------
-
-The 2 and 3-media adapters have two LEDs visible on the back end of the board
-located near the 10Base-T connector.
-
-Link Integrity LED: A "steady" ON of the green LED indicates a valid 10Base-T
-connection.  (Only applies to 10Base-T.  The green LED has no significance for
-a 10Base-2 or AUI connection.)
-
-TX/RX LED: The yellow LED lights briefly each time the adapter transmits or
-receives data. (The yellow LED will appear to "flicker" on a typical network.)
-
-
-5.4. Resolving I/O Conflicts
-----------------------------
-
-An IO conflict occurs when two or more adapter use the same ISA resource (IO
-address, memory address or IRQ).  You can usually detect an IO conflict in one
-of four ways after installing and or configuring the CS8900/20-based adapter:
-
-    1.  The system does not boot properly (or at all).
-
-    2.  The driver cannot communicate with the adapter, reporting an "Adapter
-	not found" error message.
-
-    3.  You cannot connect to the network or the driver will not load.
-
-    4.  If you have configured the adapter to run in memory mode but the driver
-	reports it is using IO mode when loading, this is an indication of a
-	memory address conflict.
-
-If an IO conflict occurs, run the CS8900/20 Setup Utility and perform a
-diagnostic self-test.  Normally, the ISA resource in conflict will fail the
-self-test.  If so, reconfigure the adapter selecting another choice for the
-resource in conflict.  Run the diagnostics again to check for further IO
-conflicts.
-
-In some cases, such as when the PC will not boot, it may be necessary to remove
-the adapter and reconfigure it by installing it in another PC to run the
-CS8900/20 Setup Utility.  Once reinstalled in the target system, run the
-diagnostics self-test to ensure the new configuration is free of conflicts
-before loading the driver again.
-
-When manually configuring the adapter, keep in mind the typical ISA system
-resource usage as indicated in the tables below.
-
-::
-
-  I/O Address    	Device                        IRQ      Device
-  -----------    	--------                      ---      --------
-     200-20F       	Game I/O adapter               3       COM2, Bus Mouse
-     230-23F       	Bus Mouse                      4       COM1
-     270-27F       	LPT3: third parallel port      5       LPT2
-     2F0-2FF       	COM2: second serial port       6       Floppy Disk controller
-     320-32F       	Fixed disk controller          7       LPT1
-							 8       Real-time Clock
-						     9       EGA/VGA display adapter
-						    12       Mouse (PS/2)
-  Memory Address  Device                          13       Math Coprocessor
-  --------------  ---------------------           14       Hard Disk controller
-  A000-BFFF	EGA Graphics Adapter
-  A000-C7FF	VGA Graphics Adapter
-  B000-BFFF	Mono Graphics Adapter
-  B800-BFFF	Color Graphics Adapter
-  E000-FFFF	AT BIOS
-
-
-
-
-6. Technical Support
-====================
-
-6.1. Contacting Cirrus Logic's Technical Support
-------------------------------------------------
-
-Cirrus Logic's CS89XX Technical Application Support can be reached at::
-
-  Telephone  :(800) 888-5016 (from inside U.S. and Canada)
-	     :(512) 442-7555 (from outside the U.S. and Canada)
-  Fax        :(512) 912-3871
-  Email      :ethernet@crystal.cirrus.com
-  WWW        :http://www.cirrus.com
-
-
-6.2. Information Required before Contacting Technical Support
--------------------------------------------------------------
-
-Before contacting Cirrus Logic for technical support, be prepared to provide as
-Much of the following information as possible.
-
-1.) Adapter type (CRD8900, CDB8900, CDB8920, etc.)
-
-2.) Adapter configuration
-
-    * IO Base, Memory Base, IO or memory mode enabled, IRQ, DMA channel
-    * Plug and Play enabled/disabled (CS8920-based adapters only)
-    * Configured for media auto-detect or specific media type (which type).
-
-3.) PC System's Configuration
-
-    * Plug and Play system (yes/no)
-    * BIOS (make and version)
-    * System make and model
-    * CPU (type and speed)
-    * System RAM
-    * SCSI Adapter
-
-4.) Software
-
-    * CS89XX driver and version
-    * Your network operating system and version
-    * Your system's OS version
-    * Version of all protocol support files
-
-5.) Any Error Message displayed.
-
-
-
-6.3 Obtaining the Latest Driver Version
----------------------------------------
-
-You can obtain the latest CS89XX drivers and support software from Cirrus Logic's
-Web site.  You can also contact Cirrus Logic's Technical Support (email:
-ethernet@crystal.cirrus.com) and request that you be registered for automatic
-software-update notification.
-
-Cirrus Logic maintains a web page at http://www.cirrus.com with the
-latest drivers and technical publications.
-
-
-6.4. Current maintainer
------------------------
-
-In February 2000 the maintenance of this driver was assumed by Andrew
-Morton.
-
-6.5 Kernel module parameters
-----------------------------
-
-For use in embedded environments with no cs89x0 EEPROM, the kernel boot
-parameter ``cs89x0_media=`` has been implemented.  Usage is::
-
-	cs89x0_media=rj45    or
-	cs89x0_media=aui     or
-	cs89x0_media=bnc
diff --git a/Documentation/networking/device_drivers/ethernet/index.rst b/Documentation/networking/device_drivers/ethernet/index.rst
index 64621c21fd78..fd3be5d20397 100644
--- a/Documentation/networking/device_drivers/ethernet/index.rst
+++ b/Documentation/networking/device_drivers/ethernet/index.rst
@@ -18,7 +18,6 @@ Contents:
    amd/pds_vfio_pci
    aquantia/atlantic
    chelsio/cxgb
-   cirrus/cs89x0
    dlink/dl2k
    davicom/dm9000
    dec/dmfe
diff --git a/drivers/net/Space.c b/drivers/net/Space.c
index 305f0a712a64..c3ce960110b9 100644
--- a/drivers/net/Space.c
+++ b/drivers/net/Space.c
@@ -202,9 +202,6 @@ static int __init probe_list2(int unit, struct devprobe2 *p, int autoprobe)
 static struct devprobe2 isa_probes[] __initdata = {
 #if defined(CONFIG_NE2000) /* ISA (use ne2k-pci for PCI cards) */
 	{ne_probe, 0},
-#endif
-#ifdef CONFIG_CS89x0_ISA
-	{cs89x0_probe, 0},
 #endif
 	{NULL, 0},
 };
diff --git a/drivers/net/ethernet/cirrus/Kconfig b/drivers/net/ethernet/cirrus/Kconfig
index 5bdf731d9503..d76f9cd6bc2d 100644
--- a/drivers/net/ethernet/cirrus/Kconfig
+++ b/drivers/net/ethernet/cirrus/Kconfig
@@ -6,7 +6,7 @@
 config NET_VENDOR_CIRRUS
 	bool "Cirrus devices"
 	default y
-	depends on ISA || EISA || ARM || MAC || COMPILE_TEST
+	depends on ARM || MAC || COMPILE_TEST
 	help
 	  If you have a network (Ethernet) card belonging to this class, say Y.
 
@@ -20,25 +20,9 @@ if NET_VENDOR_CIRRUS
 config CS89x0
 	tristate
 
-config CS89x0_ISA
-	tristate "CS89x0 ISA driver support"
-	depends on HAS_IOPORT_MAP
-	depends on ISA
-	depends on !PPC32
-	depends on CS89x0_PLATFORM=n
-	select NETDEV_LEGACY_INIT
-	select CS89x0
-	help
-	  Support for CS89x0 chipset based Ethernet cards. If you have a
-	  network (Ethernet) card of this type, say Y and read the file
-	  <file:Documentation/networking/device_drivers/ethernet/cirrus/cs89x0.rst>.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called cs89x0.
-
 config CS89x0_PLATFORM
 	tristate "CS89x0 platform driver support"
-	depends on ARM || (COMPILE_TEST && !PPC)
+	depends on ARM || COMPILE_TEST
 	select CS89x0
 	help
 	  Say Y to compile the cs89x0 platform driver. This makes this driver
diff --git a/drivers/net/ethernet/cirrus/cs89x0.c b/drivers/net/ethernet/cirrus/cs89x0.c
index fa5857923db4..8ab4b899d0ca 100644
--- a/drivers/net/ethernet/cirrus/cs89x0.c
+++ b/drivers/net/ethernet/cirrus/cs89x0.c
@@ -22,19 +22,6 @@
  * Domenico Andreoli : cavokz@gmail.com
  */
 
-
-/*
- * Set this to zero to disable DMA code
- *
- * Note that even if DMA is turned off we still support the 'dma' and  'use_dma'
- * module options so we don't break any startup scripts.
- */
-#ifndef CONFIG_ISA_DMA_API
-#define ALLOW_DMA	0
-#else
-#define ALLOW_DMA	1
-#endif
-
 /*
  * Set this to zero to remove all the debug statements via
  * dead code elimination
@@ -71,13 +58,8 @@
 #include <linux/gfp.h>
 #include <linux/io.h>
 
-#include <net/Space.h>
-
 #include <asm/irq.h>
 #include <linux/atomic.h>
-#if ALLOW_DMA
-#include <asm/dma.h>
-#endif
 
 #include "cs89x0.h"
 
@@ -91,30 +73,6 @@ static char version[] __initdata =
 	"v2.4.3-pre1 Russell Nelson <nelson@crynwr.com>, Andrew Morton";
 
 #define DRV_NAME "cs89x0"
-
-/* First, a few definitions that the brave might change.
- * A zero-terminated list of I/O addresses to be probed. Some special flags..
- * Addr & 1 = Read back the address port, look for signature and reset
- * the page window before probing
- * Addr & 3 = Reset the page window and probe
- * The CLPS eval board has the Cirrus chip at 0x80090300, in ARM IO space,
- * but it is possible that a Cirrus board could be plugged into the ISA
- * slots.
- */
-/* The cs8900 has 4 IRQ pins, software selectable. cs8900_irq_map maps
- * them to system IRQ numbers. This mapping is card specific and is set to
- * the configuration of the Cirrus Eval board for this chip.
- */
-#if IS_ENABLED(CONFIG_CS89x0_ISA)
-static unsigned int netcard_portlist[] __used __initdata = {
-	0x300, 0x320, 0x340, 0x360, 0x200, 0x220, 0x240,
-	0x260, 0x280, 0x2a0, 0x2c0, 0x2e0, 0
-};
-static unsigned int cs8900_irq_map[] = {
-	10, 11, 12, 5
-};
-#endif
-
 #if DEBUGGING
 static unsigned int net_debug = DEBUGGING;
 #else
@@ -149,14 +107,6 @@ struct net_local {
 	int force;		/* force various values; see FORCE* above. */
 	spinlock_t lock;
 	void __iomem *virt_addr;/* CS89x0 virtual address. */
-#if ALLOW_DMA
-	int use_dma;		/* Flag: we're using dma */
-	int dma;		/* DMA channel */
-	int dmasize;		/* 16 or 64 */
-	unsigned char *dma_buff;	/* points to the beginning of the buffer */
-	unsigned char *end_dma_buff;	/* points to the end of the buffer */
-	unsigned char *rx_dma_ptr;	/* points to the next packet  */
-#endif
 };
 
 /* Example routines you must write ;->. */
@@ -166,18 +116,6 @@ struct net_local {
  * Permit 'cs89x0_dma=N' in the kernel boot environment
  */
 #if !defined(MODULE)
-#if ALLOW_DMA
-static int g_cs89x0_dma;
-
-static int __init dma_fn(char *str)
-{
-	g_cs89x0_dma = simple_strtol(str, NULL, 0);
-	return 1;
-}
-
-__setup("cs89x0_dma=", dma_fn);
-#endif	/* ALLOW_DMA */
-
 static int g_cs89x0_media__force;
 
 static int __init media_fn(char *str)
@@ -290,22 +228,9 @@ get_eeprom_cksum(int off, int len, int *buffer)
 static void
 write_irq(struct net_device *dev, int chip_type, int irq)
 {
-	int i;
-
 	if (chip_type == CS8900) {
-#if IS_ENABLED(CONFIG_CS89x0_ISA)
-		/* Search the mapping table for the corresponding IRQ pin. */
-		for (i = 0; i != ARRAY_SIZE(cs8900_irq_map); i++)
-			if (cs8900_irq_map[i] == irq)
-				break;
-		/* Not found */
-		if (i == ARRAY_SIZE(cs8900_irq_map))
-			i = 3;
-#else
 		/* INTRQ0 pin is used for interrupt generation. */
-		i = 0;
-#endif
-		writereg(dev, PP_CS8900_ISAINT, i);
+		writereg(dev, PP_CS8900_ISAINT, 0);
 	} else {
 		writereg(dev, PP_CS8920_ISAINT, irq);
 	}
@@ -326,163 +251,6 @@ count_rx_errors(int status, struct net_device *dev)
 		dev->stats.rx_frame_errors++;
 }
 
-/*********************************
- * This page contains DMA routines
- *********************************/
-
-#if ALLOW_DMA
-
-#define dma_page_eq(ptr1, ptr2) ((long)(ptr1) >> 17 == (long)(ptr2) >> 17)
-
-static void
-get_dma_channel(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-
-	if (lp->dma) {
-		dev->dma = lp->dma;
-		lp->isa_config |= ISA_RxDMA;
-	} else {
-		if ((lp->isa_config & ANY_ISA_DMA) == 0)
-			return;
-		dev->dma = lp->isa_config & DMA_NO_MASK;
-		if (lp->chip_type == CS8900)
-			dev->dma += 5;
-		if (dev->dma < 5 || dev->dma > 7) {
-			lp->isa_config &= ~ANY_ISA_DMA;
-			return;
-		}
-	}
-}
-
-static void
-write_dma(struct net_device *dev, int chip_type, int dma)
-{
-	struct net_local *lp = netdev_priv(dev);
-	if ((lp->isa_config & ANY_ISA_DMA) == 0)
-		return;
-	if (chip_type == CS8900)
-		writereg(dev, PP_CS8900_ISADMA, dma - 5);
-	else
-		writereg(dev, PP_CS8920_ISADMA, dma);
-}
-
-static void
-set_dma_cfg(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-
-	if (lp->use_dma) {
-		if ((lp->isa_config & ANY_ISA_DMA) == 0) {
-			cs89_dbg(3, err, "set_dma_cfg(): no DMA\n");
-			return;
-		}
-		if (lp->isa_config & ISA_RxDMA) {
-			lp->curr_rx_cfg |= RX_DMA_ONLY;
-			cs89_dbg(3, info, "set_dma_cfg(): RX_DMA_ONLY\n");
-		} else {
-			lp->curr_rx_cfg |= AUTO_RX_DMA;	/* not that we support it... */
-			cs89_dbg(3, info, "set_dma_cfg(): AUTO_RX_DMA\n");
-		}
-	}
-}
-
-static int
-dma_bufcfg(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	if (lp->use_dma)
-		return (lp->isa_config & ANY_ISA_DMA) ? RX_DMA_ENBL : 0;
-	else
-		return 0;
-}
-
-static int
-dma_busctl(struct net_device *dev)
-{
-	int retval = 0;
-	struct net_local *lp = netdev_priv(dev);
-	if (lp->use_dma) {
-		if (lp->isa_config & ANY_ISA_DMA)
-			retval |= RESET_RX_DMA; /* Reset the DMA pointer */
-		if (lp->isa_config & DMA_BURST)
-			retval |= DMA_BURST_MODE; /* Does ISA config specify DMA burst ? */
-		if (lp->dmasize == 64)
-			retval |= RX_DMA_SIZE_64K; /* did they ask for 64K? */
-		retval |= MEMORY_ON;	/* we need memory enabled to use DMA. */
-	}
-	return retval;
-}
-
-static void
-dma_rx(struct net_device *dev)
-{
-	struct net_local *lp = netdev_priv(dev);
-	struct sk_buff *skb;
-	int status, length;
-	unsigned char *bp = lp->rx_dma_ptr;
-
-	status = bp[0] + (bp[1] << 8);
-	length = bp[2] + (bp[3] << 8);
-	bp += 4;
-
-	cs89_dbg(5, debug, "%s: receiving DMA packet at %lx, status %x, length %x\n",
-		 dev->name, (unsigned long)bp, status, length);
-
-	if ((status & RX_OK) == 0) {
-		count_rx_errors(status, dev);
-		goto skip_this_frame;
-	}
-
-	/* Malloc up new buffer. */
-	skb = netdev_alloc_skb(dev, length + 2);
-	if (skb == NULL) {
-		dev->stats.rx_dropped++;
-
-		/* AKPM: advance bp to the next frame */
-skip_this_frame:
-		bp += (length + 3) & ~3;
-		if (bp >= lp->end_dma_buff)
-			bp -= lp->dmasize * 1024;
-		lp->rx_dma_ptr = bp;
-		return;
-	}
-	skb_reserve(skb, 2);	/* longword align L3 header */
-
-	if (bp + length > lp->end_dma_buff) {
-		int semi_cnt = lp->end_dma_buff - bp;
-		skb_put_data(skb, bp, semi_cnt);
-		skb_put_data(skb, lp->dma_buff, length - semi_cnt);
-	} else {
-		skb_put_data(skb, bp, length);
-	}
-	bp += (length + 3) & ~3;
-	if (bp >= lp->end_dma_buff)
-		bp -= lp->dmasize*1024;
-	lp->rx_dma_ptr = bp;
-
-	cs89_dbg(3, info, "%s: received %d byte DMA packet of type %x\n",
-		 dev->name, length,
-		 ((skb->data[ETH_ALEN + ETH_ALEN] << 8) |
-		  skb->data[ETH_ALEN + ETH_ALEN + 1]));
-
-	skb->protocol = eth_type_trans(skb, dev);
-	netif_rx(skb);
-	dev->stats.rx_packets++;
-	dev->stats.rx_bytes += length;
-}
-
-static void release_dma_buff(struct net_local *lp)
-{
-	if (lp->dma_buff) {
-		free_pages((unsigned long)(lp->dma_buff),
-			   get_order(lp->dmasize * 1024));
-		lp->dma_buff = NULL;
-	}
-}
-
-#endif	/* ALLOW_DMA */
-
 static void
 control_dc_dc(struct net_device *dev, int on_not_off)
 {
@@ -781,27 +549,6 @@ static irqreturn_t net_interrupt(int irq, void *dev_id)
 				 */
 				netif_wake_queue(dev);	/* Inform upper layers. */
 			}
-#if ALLOW_DMA
-			if (lp->use_dma && (status & RX_DMA)) {
-				int count = readreg(dev, PP_DmaFrameCnt);
-				while (count) {
-					cs89_dbg(5, debug,
-						 "%s: receiving %d DMA frames\n",
-						 dev->name, count);
-					if (count > 1)
-						cs89_dbg(2, debug,
-							 "%s: receiving %d DMA frames\n",
-							 dev->name, count);
-					dma_rx(dev);
-					if (--count == 0)
-						count = readreg(dev, PP_DmaFrameCnt);
-					if (count > 0)
-						cs89_dbg(2, debug,
-							 "%s: continuing with %d DMA frames\n",
-							 dev->name, count);
-				}
-			}
-#endif
 			break;
 		case ISQ_RX_MISS_EVENT:
 			dev->stats.rx_missed_errors += (status >> 6);
@@ -860,14 +607,6 @@ net_open(struct net_device *dev)
 			goto bad_out;
 		}
 	} else {
-#if IS_ENABLED(CONFIG_CS89x0_ISA)
-		if (((1 << dev->irq) & lp->irq_map) == 0) {
-			pr_err("%s: IRQ %d is not in our map of allowable IRQs, which is %x\n",
-			       dev->name, dev->irq, lp->irq_map);
-			ret = -EAGAIN;
-			goto bad_out;
-		}
-#endif
 /* FIXME: Cirrus' release had this: */
 		writereg(dev, PP_BusCTL, readreg(dev, PP_BusCTL)|ENABLE_IRQ);
 /* And 2.3.47 had this: */
@@ -882,46 +621,6 @@ net_open(struct net_device *dev)
 		}
 	}
 
-#if ALLOW_DMA
-	if (lp->use_dma && (lp->isa_config & ANY_ISA_DMA)) {
-		unsigned long flags;
-		lp->dma_buff = (unsigned char *)__get_dma_pages(GFP_KERNEL,
-								get_order(lp->dmasize * 1024));
-		if (!lp->dma_buff) {
-			pr_err("%s: cannot get %dK memory for DMA\n",
-			       dev->name, lp->dmasize);
-			goto release_irq;
-		}
-		cs89_dbg(1, debug, "%s: dma %lx %lx\n",
-			 dev->name,
-			 (unsigned long)lp->dma_buff,
-			 (unsigned long)isa_virt_to_bus(lp->dma_buff));
-		if ((unsigned long)lp->dma_buff >= MAX_DMA_ADDRESS ||
-		    !dma_page_eq(lp->dma_buff,
-				 lp->dma_buff + lp->dmasize * 1024 - 1)) {
-			pr_err("%s: not usable as DMA buffer\n", dev->name);
-			goto release_irq;
-		}
-		memset(lp->dma_buff, 0, lp->dmasize * 1024);	/* Why? */
-		if (request_dma(dev->dma, dev->name)) {
-			pr_err("%s: cannot get dma channel %d\n",
-			       dev->name, dev->dma);
-			goto release_irq;
-		}
-		write_dma(dev, lp->chip_type, dev->dma);
-		lp->rx_dma_ptr = lp->dma_buff;
-		lp->end_dma_buff = lp->dma_buff + lp->dmasize * 1024;
-		spin_lock_irqsave(&lp->lock, flags);
-		disable_dma(dev->dma);
-		clear_dma_ff(dev->dma);
-		set_dma_mode(dev->dma, DMA_RX_MODE); /* auto_init as well */
-		set_dma_addr(dev->dma, isa_virt_to_bus(lp->dma_buff));
-		set_dma_count(dev->dma, lp->dmasize * 1024);
-		enable_dma(dev->dma);
-		spin_unlock_irqrestore(&lp->lock, flags);
-	}
-#endif	/* ALLOW_DMA */
-
 	/* set the Ethernet address */
 	for (i = 0; i < ETH_ALEN / 2; i++)
 		writereg(dev, PP_IA + i * 2,
@@ -958,11 +657,6 @@ net_open(struct net_device *dev)
 		pr_err("%s: EEPROM is configured for unavailable media\n",
 		       dev->name);
 release_dma:
-#if ALLOW_DMA
-		free_dma(dev->dma);
-release_irq:
-		release_dma_buff(lp);
-#endif
 		writereg(dev, PP_LineCTL,
 			 readreg(dev, PP_LineCTL) & ~(SERIAL_TX_ON | SERIAL_RX_ON));
 		free_irq(dev->irq, dev);
@@ -1048,9 +742,6 @@ net_open(struct net_device *dev)
 
 	if (lp->isa_config & STREAM_TRANSFER)
 		lp->curr_rx_cfg |= RX_STREAM_ENBL;
-#if ALLOW_DMA
-	set_dma_cfg(dev);
-#endif
 	writereg(dev, PP_RxCFG, lp->curr_rx_cfg);
 
 	writereg(dev, PP_TxCFG, (TX_LOST_CRS_ENBL |
@@ -1063,19 +754,12 @@ net_open(struct net_device *dev)
 
 	writereg(dev, PP_BufCFG, (READY_FOR_TX_ENBL |
 				  RX_MISS_COUNT_OVRFLOW_ENBL |
-#if ALLOW_DMA
-				  dma_bufcfg(dev) |
-#endif
 				  TX_COL_COUNT_OVRFLOW_ENBL |
 				  TX_UNDERRUN_ENBL));
 
 	/* now that we've got our act together, enable everything */
-	writereg(dev, PP_BusCTL, (ENABLE_IRQ
-				  | (dev->mem_start ? MEMORY_ON : 0) /* turn memory on */
-#if ALLOW_DMA
-				  | dma_busctl(dev)
-#endif
-			 ));
+	writereg(dev, PP_BusCTL,
+		 (ENABLE_IRQ | (dev->mem_start ? MEMORY_ON : 0))); /* turn memory on */
 	netif_start_queue(dev);
 	cs89_dbg(1, debug, "net_open() succeeded\n");
 	return 0;
@@ -1087,10 +771,6 @@ net_open(struct net_device *dev)
 static int
 net_close(struct net_device *dev)
 {
-#if ALLOW_DMA
-	struct net_local *lp = netdev_priv(dev);
-#endif
-
 	netif_stop_queue(dev);
 
 	writereg(dev, PP_RxCFG, 0);
@@ -1100,13 +780,6 @@ net_close(struct net_device *dev)
 
 	free_irq(dev->irq, dev);
 
-#if ALLOW_DMA
-	if (lp->use_dma && lp->dma) {
-		free_dma(dev->dma);
-		release_dma_buff(lp);
-	}
-#endif
-
 	/* Update the statistics here. */
 	return 0;
 }
@@ -1323,13 +996,6 @@ cs89x0_probe1(struct net_device *dev, void __iomem *ioaddr, int modular)
 		memset(lp, 0, sizeof(*lp));
 		spin_lock_init(&lp->lock);
 #ifndef MODULE
-#if ALLOW_DMA
-		if (g_cs89x0_dma) {
-			lp->use_dma = 1;
-			lp->dma = g_cs89x0_dma;
-			lp->dmasize = 16;	/* Could make this an option... */
-		}
-#endif
 		lp->force = g_cs89x0_media__force;
 #endif
 	}
@@ -1527,40 +1193,12 @@ cs89x0_probe1(struct net_device *dev, void __iomem *ioaddr, int modular)
 			dev->irq = i;
 	} else {
 		i = lp->isa_config & INT_NO_MASK;
-#if IS_ENABLED(CONFIG_CS89x0_ISA)
-		if (lp->chip_type == CS8900) {
-			/* Translate the IRQ using the IRQ mapping table. */
-			if (i >= ARRAY_SIZE(cs8900_irq_map))
-				pr_err("invalid ISA interrupt number %d\n", i);
-			else
-				i = cs8900_irq_map[i];
-
-			lp->irq_map = CS8900_IRQ_MAP; /* fixed IRQ map for CS8900 */
-		} else {
-			int irq_map_buff[IRQ_MAP_LEN/2];
-
-			if (get_eeprom_data(dev, IRQ_MAP_EEPROM_DATA,
-					    IRQ_MAP_LEN / 2,
-					    irq_map_buff) >= 0) {
-				if ((irq_map_buff[0] & 0xff) == PNP_IRQ_FRMT)
-					lp->irq_map = ((irq_map_buff[0] >> 8) |
-						       (irq_map_buff[1] << 8));
-			}
-		}
-#endif
 		if (!dev->irq)
 			dev->irq = i;
 	}
 
 	pr_cont(" IRQ %d", dev->irq);
-
-#if ALLOW_DMA
-	if (lp->use_dma) {
-		get_dma_channel(dev);
-		pr_cont(", DMA %d", dev->dma);
-	} else
-#endif
-		pr_cont(", programmed I/O");
+	pr_cont(", programmed I/O");
 
 	/* print the ethernet address. */
 	pr_cont(", MAC %pM\n", dev->dev_addr);
@@ -1580,270 +1218,6 @@ cs89x0_probe1(struct net_device *dev, void __iomem *ioaddr, int modular)
 	return retval;
 }
 
-#if IS_ENABLED(CONFIG_CS89x0_ISA)
-/*
- * This function converts the I/O port address used by the cs89x0_probe() and
- * init_module() functions to the I/O memory address used by the
- * cs89x0_probe1() function.
- */
-static int __init
-cs89x0_ioport_probe(struct net_device *dev, unsigned long ioport, int modular)
-{
-	struct net_local *lp = netdev_priv(dev);
-	int ret;
-	void __iomem *io_mem;
-
-	if (!lp)
-		return -ENOMEM;
-
-	dev->base_addr = ioport;
-
-	if (!request_region(ioport, NETCARD_IO_EXTENT, DRV_NAME)) {
-		ret = -EBUSY;
-		goto out;
-	}
-
-	io_mem = ioport_map(ioport & ~3, NETCARD_IO_EXTENT);
-	if (!io_mem) {
-		ret = -ENOMEM;
-		goto release;
-	}
-
-	/* if they give us an odd I/O address, then do ONE write to
-	 * the address port, to get it back to address zero, where we
-	 * expect to find the EISA signature word. An IO with a base of 0x3
-	 * will skip the test for the ADD_PORT.
-	 */
-	if (ioport & 1) {
-		cs89_dbg(1, info, "%s: odd ioaddr 0x%lx\n", dev->name, ioport);
-		if ((ioport & 2) != 2) {
-			if ((ioread16(io_mem + ADD_PORT) & ADD_MASK) !=
-			    ADD_SIG) {
-				pr_err("%s: bad signature 0x%x\n",
-				       dev->name, ioread16(io_mem + ADD_PORT));
-				ret = -ENODEV;
-				goto unmap;
-			}
-		}
-	}
-
-	ret = cs89x0_probe1(dev, io_mem, modular);
-	if (!ret)
-		goto out;
-unmap:
-	ioport_unmap(io_mem);
-release:
-	release_region(ioport, NETCARD_IO_EXTENT);
-out:
-	return ret;
-}
-
-#ifndef MODULE
-/* Check for a network adaptor of this type, and return '0' iff one exists.
- * If dev->base_addr == 0, probe all likely locations.
- * If dev->base_addr == 1, always return failure.
- * If dev->base_addr == 2, allocate space for the device and return success
- * (detachable devices only).
- * Return 0 on success.
- */
-
-struct net_device * __init cs89x0_probe(int unit)
-{
-	struct net_device *dev = alloc_etherdev(sizeof(struct net_local));
-	unsigned *port;
-	int err = 0;
-	int irq;
-	int io;
-
-	if (!dev)
-		return ERR_PTR(-ENODEV);
-
-	sprintf(dev->name, "eth%d", unit);
-	netdev_boot_setup_check(dev);
-	io = dev->base_addr;
-	irq = dev->irq;
-
-	cs89_dbg(0, info, "cs89x0_probe(0x%x)\n", io);
-
-	if (io > 0x1ff)	{	/* Check a single specified location. */
-		err = cs89x0_ioport_probe(dev, io, 0);
-	} else if (io != 0) {	/* Don't probe at all. */
-		err = -ENXIO;
-	} else {
-		for (port = netcard_portlist; *port; port++) {
-			if (cs89x0_ioport_probe(dev, *port, 0) == 0)
-				break;
-			dev->irq = irq;
-		}
-		if (!*port)
-			err = -ENODEV;
-	}
-	if (err)
-		goto out;
-	return dev;
-out:
-	free_netdev(dev);
-	pr_warn("no cs8900 or cs8920 detected.  Be sure to disable PnP with SETUP\n");
-	return ERR_PTR(err);
-}
-#else
-static struct net_device *dev_cs89x0;
-
-/* Support the 'debug' module parm even if we're compiled for non-debug to
- * avoid breaking someone's startup scripts
- */
-
-static int io;
-static int irq;
-static int debug;
-static char media[8];
-static int duplex = -1;
-
-static int use_dma;			/* These generate unused var warnings if ALLOW_DMA = 0 */
-static int dma;
-static int dmasize = 16;		/* or 64 */
-
-module_param_hw(io, int, ioport, 0);
-module_param_hw(irq, int, irq, 0);
-module_param(debug, int, 0);
-module_param_string(media, media, sizeof(media), 0);
-module_param(duplex, int, 0);
-module_param_hw(dma , int, dma, 0);
-module_param(dmasize , int, 0);
-module_param(use_dma , int, 0);
-MODULE_PARM_DESC(io, "cs89x0 I/O base address");
-MODULE_PARM_DESC(irq, "cs89x0 IRQ number");
-#if DEBUGGING
-MODULE_PARM_DESC(debug, "cs89x0 debug level (0-6)");
-#else
-MODULE_PARM_DESC(debug, "(ignored)");
-#endif
-MODULE_PARM_DESC(media, "Set cs89x0 adapter(s) media type(s) (rj45,bnc,aui)");
-/* No other value than -1 for duplex seems to be currently interpreted */
-MODULE_PARM_DESC(duplex, "(ignored)");
-#if ALLOW_DMA
-MODULE_PARM_DESC(dma , "cs89x0 ISA DMA channel; ignored if use_dma=0");
-MODULE_PARM_DESC(dmasize , "cs89x0 DMA size in kB (16,64); ignored if use_dma=0");
-MODULE_PARM_DESC(use_dma , "cs89x0 using DMA (0-1)");
-#else
-MODULE_PARM_DESC(dma , "(ignored)");
-MODULE_PARM_DESC(dmasize , "(ignored)");
-MODULE_PARM_DESC(use_dma , "(ignored)");
-#endif
-
-MODULE_AUTHOR("Mike Cruse, Russwll Nelson <nelson@crynwr.com>, Andrew Morton");
-MODULE_LICENSE("GPL");
-
-/*
- * media=t             - specify media type
- * or media=2
- * or media=aui
- * or medai=auto
- * duplex=0            - specify forced half/full/autonegotiate duplex
- * debug=#             - debug level
- *
- * Default Chip Configuration:
- * DMA Burst = enabled
- * IOCHRDY Enabled = enabled
- * UseSA = enabled
- * CS8900 defaults to half-duplex if not specified on command-line
- * CS8920 defaults to autoneg if not specified on command-line
- * Use reset defaults for other config parameters
- *
- * Assumptions:
- * media type specified is supported (circuitry is present)
- * if memory address is > 1MB, then required mem decode hw is present
- * if 10B-2, then agent other than driver will enable DC/DC converter
- * (hw or software util)
- */
-
-static int __init cs89x0_isa_init_module(void)
-{
-	struct net_device *dev;
-	struct net_local *lp;
-	int ret = 0;
-
-#if DEBUGGING
-	net_debug = debug;
-#else
-	debug = 0;
-#endif
-	dev = alloc_etherdev(sizeof(struct net_local));
-	if (!dev)
-		return -ENOMEM;
-
-	dev->irq = irq;
-	dev->base_addr = io;
-	lp = netdev_priv(dev);
-
-#if ALLOW_DMA
-	if (use_dma) {
-		lp->use_dma = use_dma;
-		lp->dma = dma;
-		lp->dmasize = dmasize;
-	}
-#endif
-
-	spin_lock_init(&lp->lock);
-
-	/* boy, they'd better get these right */
-	if (!strcmp(media, "rj45"))
-		lp->adapter_cnf = A_CNF_MEDIA_10B_T | A_CNF_10B_T;
-	else if (!strcmp(media, "aui"))
-		lp->adapter_cnf = A_CNF_MEDIA_AUI   | A_CNF_AUI;
-	else if (!strcmp(media, "bnc"))
-		lp->adapter_cnf = A_CNF_MEDIA_10B_2 | A_CNF_10B_2;
-	else
-		lp->adapter_cnf = A_CNF_MEDIA_10B_T | A_CNF_10B_T;
-
-	if (duplex == -1)
-		lp->auto_neg_cnf = AUTO_NEG_ENABLE;
-
-	if (io == 0) {
-		pr_err("Module autoprobing not allowed\n");
-		pr_err("Append io=0xNNN\n");
-		ret = -EPERM;
-		goto out;
-	} else if (io <= 0x1ff) {
-		ret = -ENXIO;
-		goto out;
-	}
-
-#if ALLOW_DMA
-	if (use_dma && dmasize != 16 && dmasize != 64) {
-		pr_err("dma size must be either 16K or 64K, not %dK\n",
-		       dmasize);
-		ret = -EPERM;
-		goto out;
-	}
-#endif
-	ret = cs89x0_ioport_probe(dev, io, 1);
-	if (ret)
-		goto out;
-
-	dev_cs89x0 = dev;
-	return 0;
-out:
-	free_netdev(dev);
-	return ret;
-}
-module_init(cs89x0_isa_init_module);
-
-static void __exit cs89x0_isa_cleanup_module(void)
-{
-	struct net_local *lp = netdev_priv(dev_cs89x0);
-
-	unregister_netdev(dev_cs89x0);
-	iowrite16(PP_ChipID, lp->virt_addr + ADD_PORT);
-	ioport_unmap(lp->virt_addr);
-	release_region(dev_cs89x0->base_addr, NETCARD_IO_EXTENT);
-	free_netdev(dev_cs89x0);
-}
-module_exit(cs89x0_isa_cleanup_module);
-#endif /* MODULE */
-#endif /* CONFIG_CS89x0_ISA */
-
-#if IS_ENABLED(CONFIG_CS89x0_PLATFORM)
 static int __init cs89x0_platform_probe(struct platform_device *pdev)
 {
 	struct net_device *dev = alloc_etherdev(sizeof(struct net_local));
@@ -1908,8 +1282,6 @@ static struct platform_driver cs89x0_driver = {
 
 module_platform_driver_probe(cs89x0_driver, cs89x0_platform_probe);
 
-#endif /* CONFIG_CS89x0_PLATFORM */
-
 MODULE_LICENSE("GPL");
 MODULE_DESCRIPTION("Crystal Semiconductor (Now Cirrus Logic) CS89[02]0 network driver");
 MODULE_AUTHOR("Russell Nelson <nelson@crynwr.com>");
diff --git a/include/net/Space.h b/include/net/Space.h
index 6a0b6674d930..1b9ab0da5a03 100644
--- a/include/net/Space.h
+++ b/include/net/Space.h
@@ -4,4 +4,3 @@
  */
 
 struct net_device *ne_probe(int unit);
-struct net_device *cs89x0_probe(int unit);
-- 
2.39.5


