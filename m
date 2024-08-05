Return-Path: <netdev+bounces-115696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F3579947936
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 12:19:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 745B71F21B74
	for <lists+netdev@lfdr.de>; Mon,  5 Aug 2024 10:19:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD1E13B5B4;
	Mon,  5 Aug 2024 10:19:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SqPukR5k"
X-Original-To: netdev@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8056A18040;
	Mon,  5 Aug 2024 10:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722853187; cv=none; b=LI3UktKz8JZ7BUYI/5BdEm77ClRrgsSaVJ6LsZaA0Yd7l4migidfZiXtatkrS2TsgB7+WdU8x8ZXTZkeGAgDfnIj0wnouFwWq8uA39EROiw3v3J4nQKIQ5R5UwNNxYS8hi2CFUj8H0sqIHloFyZzyF9lG8rTbFUEXMGCoSmWiXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722853187; c=relaxed/simple;
	bh=KS1fj3okvNndPiRZTwj3NC0qVtclqS5u7nEvy6wyOgk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QeH0kvD+lDw+trLkNrMLWqZATnlDeMaOdyQGgcjKKUENtj5Q5xXXBEqpcodmlv12YyATd5RyCAVvnQupsrETjoL86k8WEK+Ns9fqJZ/DqEJgoOHZ0FdrPfr/LQZW44HGq4mvcfGirbSbaDeyYCtr5nAxWMayJ6cpb8RovZOikG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SqPukR5k; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPA id A957020004;
	Mon,  5 Aug 2024 10:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1722853177;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=a7FpLhLwQbPwDHrWC4uG11zBWmLxtfgBdO6pflNVoqQ=;
	b=SqPukR5kfyPrnybNnem43jpJchAC/1SH9x5BjEBwQmwHXbuPdEH9uSBYguyapqze/4U23l
	TnHiS9/FQLI1yHvV7mRdbjgcbm2jdlu8ZIx3e7Q/D0RuPmkyI3PvSutXKh7lU3XarIk6Dt
	MeotR0tTQ1835mCq85decJyOBoJ+mL9atJRHO9geAFh0KipdEpL65W/IobVPlMDytHtrfb
	COI9zFhjlOFVoCMY+xnh4aSsDYYS5Z77Y5UdWOAkZmfvEdzv5iBnBodSL57SR8YdZsW2zq
	34HNKLfNu1FhmSenU7mRneB3uNUsAW0GwTpcRg0yV8nIonOpydrbAxzs4SXVQg==
From: Herve Codina <herve.codina@bootlin.com>
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	Andy Shevchenko <andy.shevchenko@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Lee Jones <lee@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Derek Kiernan <derek.kiernan@amd.com>,
	Dragan Cvetic <dragan.cvetic@amd.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Herve Codina <herve.codina@bootlin.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Philipp Zabel <p.zabel@pengutronix.de>,
	Lars Povlsen <lars.povlsen@microchip.com>,
	Steen Hegelund <Steen.Hegelund@microchip.com>,
	Daniel Machon <daniel.machon@microchip.com>,
	UNGLinuxDriver@microchip.com,
	Rob Herring <robh@kernel.org>,
	Saravana Kannan <saravanak@google.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Andrew Lunn <andrew@lunn.ch>,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	devicetree@vger.kernel.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Luca Ceresoli <luca.ceresoli@bootlin.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH v4 0/8] Add support for the LAN966x PCI device using a DT overlay
Date: Mon,  5 Aug 2024 12:17:16 +0200
Message-ID: <20240805101725.93947-1-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com

Hi,

This series adds support for the LAN966x chip when used as a PCI
device.

For reference, the LAN996x chip is a System-on-chip that integrates an
Ethernet switch and a number of other traditional hardware blocks such
as a GPIO controller, I2C controllers, SPI controllers, etc. The
LAN996x can be used in two different modes:

- With Linux running on its Linux built-in ARM cores.
  This mode is already supported by the upstream Linux kernel, with the
  LAN996x described as a standard ARM Device Tree in
  arch/arm/boot/dts/microchip/lan966x.dtsi. Thanks to this support,
  all hardware blocks in the LAN996x already have drivers in the
  upstream Linux kernel.

- As a PCI device, thanks to its built-in PCI endpoint controller.
  In this case, the LAN996x ARM cores are not used, but all peripherals
  of the LAN996x can be accessed by the PCI host using memory-mapped
  I/O through the PCI BARs.

This series aims at supporting this second use-case. As all peripherals
of the LAN996x already have drivers in the Linux kernel, our goal is to
re-use them as-is to support this second use-case.

Therefore, this patch series introduces a PCI driver that binds on the
LAN996x PCI VID/PID, and when probed, instantiates all devices that are
accessible through the PCI BAR. As the list and characteristics of such
devices are non-discoverable, this PCI driver loads a Device Tree
overlay that allows to teach the kernel about which devices are
available, and allows to probe the relevant drivers in kernel, re-using
all existing drivers with no change.

This patch series for now adds a Device Tree overlay that describes an
initial subset of the devices available over PCI in the LAN996x, and
follow-up patch series will add support for more once this initial
support has landed.

In order to add this PCI driver, a number of preparation changes are
needed:
 - Patches 1, 2 introduce the LAN996x PCI driver itself, together with
   its DT overlay and the related MAINTAINTER entry.

 - Patches 3 to 8 allow the reset driver used for the LAN996x to be
   built as a module. Indeed, in the case where Linux runs on the ARM
   cores, it is common to have the reset driver built-in. However, when
   the LAN996x is used as a PCI device, it makes sense that all its
   drivers can be loaded as modules.

Compare to the previous iteration:
  https://lore.kernel.org/lkml/20240627091137.370572-1-herve.codina@bootlin.com/
this v4 series mainly:
  - Add a dependency between the reset controller and the LAN966x PCI
    driver. Reorder commits as the reset controller now depends on the
    LAN666x PCI device.
  - Move the LAN966x PCI driver from drivers/mfd to drivers/misc

Best regards,
Hervé

Changes v3 -> v4
  - Patch 1 and 2 (v3 patch 6 and 7)
    Move the driver from drivers/mfd to drivers/misc

  - Patch 4 and 5 (v3 patch 2)
    Rework reset driver dependencies and module building support.
    Split v3 patch into two distinct patches:
      - patch 4, as suggested by Geert, add a dependency on the
        LAN966x PCI device
      - patch 5, allows to build the reset controller driver as a module

  - Other patches
    Except reordering, no changes

Changes v2 -> v3
  - Patches 1 and 5
    No changes

  - Patch 6 (v2 patch 18)
    Add a blank line in the commit log to split paragraphs
    Remove unneeded header file inclusion
    Use IRQ_RETVAL()
    Remove blank line
    Use dev_of_node()
    Use pci_{set,get}_drvdata()
    Remove unneeded pci_clear_master() call
    Move { 0, } to { }
    Remove the unneeded pci_dev member from the lan966x_pci structure
    Use PCI_VENDOR_ID_EFAR instead of the hardcoded 0x1055 PCI Vendor ID
    Add a comment related to the of_node check.

  - Patch 7 (v2 patch 19)
    No changes

  Patches removed in v3
    - Patches 6 and 7
      Extracted and sent separately
      https://lore.kernel.org/lkml/20240620120126.412323-1-herve.codina@bootlin.com/

    - Patches 9
      Already applied

    - Patches 8, 10 to 12
      Extracted, reworked and sent separately
      https://lore.kernel.org/lkml/20240614173232.1184015-1-herve.codina@bootlin.com/

    - Patches 13 to 14
      Already applied

Changes v1 -> v2
  - Patch 1
    Fix a typo in syscon.h (s/intline/inline/)

  - Patches 2..5
    No changes

  - Patch 6
    Improve the reset property description

  - Patch 7
    Fix a wrong reverse x-mass tree declaration

  - Patch 8 removed (sent alone to net)
    https://lore.kernel.org/lkml/20240513111853.58668-1-herve.codina@bootlin.com/

  - Patch 8 (v1 patch 9)
    Add 'Reviewed-by: Rob Herring (Arm) <robh@kernel.org>'

  - Patch 9 (v1 patch 10)
    Rephrase and ident parameters descriptions

  - Patch 10 (v1 patch 11)
    No changes

  - Patch 11 (v1 patch 12)
    Fix a missing ret value assignment before a goto in .probe()
    Limit lines to 80 columns
    Use indices in register offset definitions

  - Patch 13 and 14 (new patches in v2)
    Add new test cases for existing of_changeset_add_prop_*()

  - Patch 15 (v1 patch 14)
    No changes

  - Patch 16 (new patches in v2)
    Add tests for of_changeset_add_prop_bool()

  - Patch 17 (v1 patch 15)
    Update commit subject
    Rewrap a paragraph in commit log

  - Patch 18 (v1 patch 16)
    Use PCI_IRQ_INTX instead of PCI_IRQ_LEGACY

  - Patch 19 (v1 patch 17)
    No changes

Clément Léger (5):
  mfd: syscon: Add reference counting and device managed support
  reset: mchp: sparx5: Allow building as a module
  reset: mchp: sparx5: Release syscon when not use anymore
  reset: core: add get_device()/put_device on rcdev
  reset: mchp: sparx5: set the dev member of the reset controller

Herve Codina (3):
  misc: Add support for LAN966x PCI device
  MAINTAINERS: Add the Microchip LAN966x PCI driver entry
  reset: mchp: sparx5: Add MCHP_LAN966X_PCI dependency

 MAINTAINERS                            |   6 +
 drivers/mfd/syscon.c                   | 145 +++++++++++++++-
 drivers/misc/Kconfig                   |  24 +++
 drivers/misc/Makefile                  |   3 +
 drivers/misc/lan966x_pci.c             | 229 +++++++++++++++++++++++++
 drivers/misc/lan966x_pci.dtso          | 167 ++++++++++++++++++
 drivers/pci/quirks.c                   |   1 +
 drivers/reset/Kconfig                  |   4 +-
 drivers/reset/core.c                   |   2 +
 drivers/reset/reset-microchip-sparx5.c |  11 +-
 include/linux/mfd/syscon.h             |  16 ++
 11 files changed, 591 insertions(+), 17 deletions(-)
 create mode 100644 drivers/misc/lan966x_pci.c
 create mode 100644 drivers/misc/lan966x_pci.dtso

-- 
2.45.0


