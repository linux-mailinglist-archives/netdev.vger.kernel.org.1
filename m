Return-Path: <netdev+bounces-34599-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C927A4D4D
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 17:48:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 89E9C1C21409
	for <lists+netdev@lfdr.de>; Mon, 18 Sep 2023 15:48:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D00F1D6BF;
	Mon, 18 Sep 2023 15:46:49 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD79F1F5F0
	for <netdev@vger.kernel.org>; Mon, 18 Sep 2023 15:46:47 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB7291BF4;
	Mon, 18 Sep 2023 08:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1695051881; x=1726587881;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Um9SQvE/5HeieZqdelS3qtLTo5NsX9iapqTm1J+iScg=;
  b=GJ8nrjEmnxdovECeHs3LHsHcSAU2aiX4tkUMkhSkj7EZQqp0sTA+HHtK
   NB1YgSLPI5+bp6BuTn5+OIwNLjSfh981g7Y6nD7EOdNROChOUJBpRfdAG
   gZQQuXTzO+seA1GCfLzG4nu0QTaq52pTaP81QIfZ40iv6tGIAyk/MNP7m
   xTgFAUgj/QEpgehwjM1nHBAqHmIZdunoeW/R9I6isu0r2jTmabkPy7xPH
   SAsh+/AdsCeyF5PLzz2D1TWVIei/i40s8jZ3C8zh+F7aQvs8rwh237wMV
   Wlcspx6St0NT4wTTX30lU3uWnQNw8NaNRTsi66Z35MUwTPIr7CVLYAaMW
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="446112585"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="446112585"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:11:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10837"; a="811341354"
X-IronPort-AV: E=Sophos;i="6.02,156,1688454000"; 
   d="scan'208";a="811341354"
Received: from nprotaso-mobl1.ccr.corp.intel.com (HELO ijarvine-mobl2.ger.corp.intel.com) ([10.252.49.156])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Sep 2023 06:11:23 -0700
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: linux-pci@vger.kernel.org,
	Bjorn Helgaas <helgaas@kernel.org>,
	Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
	Rob Herring <robh@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Lukas Wunner <lukas@wunner.de>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	linux-kernel@vger.kernel.org
Cc: ath10k@lists.infradead.org,
	ath11k@lists.infradead.org,
	ath12k@lists.infradead.org,
	intel-wired-lan@lists.osuosl.org,
	linux-arm-kernel@lists.infradead.org,
	linux-bluetooth@vger.kernel.org,
	linux-mediatek@lists.infradead.org,
	linux-rdma@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	netdev@vger.kernel.org,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v2 00/13] PCI/ASPM: Make ASPM in core robust and remove driver workarounds
Date: Mon, 18 Sep 2023 16:10:50 +0300
Message-Id: <20230918131103.24119-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
	SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Previously, ASPM service driver has ignored link state management
requests when OS is not authorized to touch LNKCTL (or ASPM is not
configured at all). Because the core interface has not been reliable,
drivers have create workarounds to force ASPM state by directly
writing into LNKCTL themselves.

A second problem is lack of symmetric pair for
pci_disable_link_state(). Any link state disable is permanent (NOTE:
pci_enable_link_state() despite its name is not a symmetric pair for
pci_disable_link_state()). The lack of way to re-enable ASPM prevents
drivers from using pci_disable_link_state() to disabling ASPM for
certain phases of driver operation and re-enabling it later.

Both cases are problematic because when ASPM is working normally
through the service driver, it is not aware of the extra link state
changes drivers perform directly causing the service driver to have
incorrect view about the ASPM state.

Address these problems by making pci_disable_link_state() reliable and
by providing proper pci_enable_link_state() pair for it (the function
currently on the way is renamed first to a more descriptive name).
After core improvements, convert drivers to use the new interface and
drop the workarounds.

v2:
- Rebased the series
- Reorder patches (rename patch first)

Ilpo Järvinen (13):
  PCI/ASPM: Rename pci_enable_link_state() to
    pci_set_default_link_state()
  PCI/ASPM: Improve pci_set_default_link_state() kerneldoc
  PCI/ASPM: Disable ASPM when driver requests it
  PCI/ASPM: Move L0S/L1/sub states mask calculation into a helper
  PCI/ASPM: Add pci_enable_link_state()
  Bluetooth: hci_bcm4377: Convert aspm disable to quirk
  mt76: Remove unreliable pci_disable_link_state() workaround
  e1000e: Remove unreliable pci_disable_link_state{,_locked}()
    workaround
  wifi: ath10k: Use pci_disable/enable_link_state()
  wifi: ath11k: Use pci_disable/enable_link_state()
  wifi: ath12k: Use pci_disable/enable_link_state()
  RDMA/hfi1: Use pci_disable/enable_link_state()
  misc: rtsx: Use pci_disable/enable_link_state()

 drivers/bluetooth/hci_bcm4377.c               |  20 ---
 drivers/infiniband/hw/hfi1/aspm.c             |  38 +-----
 drivers/infiniband/hw/hfi1/pcie.c             |   2 +-
 drivers/misc/cardreader/rts5228.c             |   6 +-
 drivers/misc/cardreader/rts5261.c             |   6 +-
 drivers/misc/cardreader/rtsx_pcr.c            |   8 +-
 drivers/net/ethernet/intel/e1000e/netdev.c    |  77 +----------
 drivers/net/wireless/ath/ath10k/pci.c         |   8 +-
 drivers/net/wireless/ath/ath11k/pci.c         |  10 +-
 drivers/net/wireless/ath/ath12k/pci.c         |  10 +-
 drivers/net/wireless/mediatek/mt76/Makefile   |   1 -
 drivers/net/wireless/mediatek/mt76/mt76.h     |   1 -
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt76x2/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |   2 +-
 .../net/wireless/mediatek/mt76/mt7996/pci.c   |   2 +-
 drivers/net/wireless/mediatek/mt76/pci.c      |  47 -------
 drivers/pci/controller/vmd.c                  |   2 +-
 drivers/pci/pcie/Makefile                     |   1 +
 drivers/pci/pcie/aspm.c                       | 126 +++++++++++++-----
 drivers/pci/pcie/aspm_minimal.c               |  66 +++++++++
 drivers/pci/quirks.c                          |   3 +
 include/linux/pci.h                           |  10 +-
 25 files changed, 199 insertions(+), 255 deletions(-)
 delete mode 100644 drivers/net/wireless/mediatek/mt76/pci.c
 create mode 100644 drivers/pci/pcie/aspm_minimal.c

-- 
2.30.2


