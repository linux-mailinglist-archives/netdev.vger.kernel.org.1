Return-Path: <netdev+bounces-158474-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A44A11F47
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 11:26:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 95FFB3A378C
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 10:25:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 863E123F27F;
	Wed, 15 Jan 2025 10:25:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="f1SSw3C4"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-56.ptr.blmpb.com (va-2-56.ptr.blmpb.com [209.127.231.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FB481ADC64
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 10:25:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736936746; cv=none; b=f733T+IV6YSaOrlxe2WlrFWhuoyJL5e8CvMuPfEPStq/vTNDyip66EVz6VsR6EPdZMNLL6oyXCeApOSfSnpNUIRJrry4UpIY/0k8///ojQ6GcVJPdM0rgwBdxNufgi+isUrdMJvwxM9HfKFwKLJyFffaumH45Zusqeq2acbSI/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736936746; c=relaxed/simple;
	bh=BvedamTubGi6nGXQOyrr30HhX6hRfRAogxUeC9OVvRA=;
	h=From:Mime-Version:Date:Content-Type:To:Cc:Subject:Message-Id; b=iTQaewFsaVB+fMCTc/U5MLeJHk8ogxyWeMFAmFhfqjoDOxTSbs5++dFbFUsh8dcOGrsYuncDL/e82BKDhYMqbNKh5rMZe/B0yDLKkN0XPXf5LQv+ugLub9d8GziCShpyUM3uQXNon40ZqQGvJz8gHmpwclXctz6XiRyS3twpRW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=f1SSw3C4; arc=none smtp.client-ip=209.127.231.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1736936600; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=pOsk0vixPMXs6RL+YCGx8fSHix8/X+zDtdSJFPIUzCg=;
 b=f1SSw3C4Sh3SjXXVSSgEUKIyDRogTmAjA5emSvDjYEbXBjEA0JX7zdRIQZE5fkKkDbMAm1
 JneIUYhemaTRsFd6EZQFjwdAUrD4sAIWg7nFyqdxXU9mNGvvaLamNmijnPYJ1D5OHW+LNB
 fgdEdgua7wkSxsbRvMKfgcKCzeeN/R4mpc6Pffn11U8nnJRMumpITB8L48rncacV6jvf11
 TF09vzsIIQpmd4eOI0Oc4/qQMQOrIfWkYOZ4BIJSc4ETaXHZkan4Tj73JaaNuzXRhxJZvD
 2ZFWhHbCbNbEV9j3HFbLmTBj5feHbgB2PBcimFoz6zQ7HHRPXHWZvLYvwVD1Rw==
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Date: Wed, 15 Jan 2025 18:23:17 +0800
Content-Type: text/plain; charset=UTF-8
X-Mailer: git-send-email 2.25.1
Content-Transfer-Encoding: 7bit
To: <netdev@vger.kernel.org>
Cc: <leon@kernel.org>, <andrew+netdev@lunn.ch>, <kuba@kernel.org>, 
	<pabeni@redhat.com>, <edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Subject: [PATCH v3 00/14] net-next/yunsilicon: ADD Yunsilicon XSC Ethernet Driver
Message-Id: <20250115102242.3541496-1-tianx@yunsilicon.com>
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 15 Jan 2025 18:23:17 +0800
X-Lms-Return-Path: <lba+267878c96+4ad673+vger.kernel.org+tianx@yunsilicon.com>
X-Original-From: Xin Tian <tianx@yunsilicon.com>

The patch series adds the xsc driver, which will support the YunSilicon
MS/MC/MV series of network cards. These network cards offer support for
high-speed Ethernet and RDMA networking, with speeds of up to 200Gbps.

The Ethernet functionality is implemented by two modules. One is a
PCI driver(xsc_pci), which provides PCIe configuration,
CMDQ service (communication with firmware), interrupt handling,
hardware resource management, and other services, while offering
common interfaces for Ethernet and future InfiniBand drivers to
utilize hardware resources. The other is an Ethernet driver(xsc_eth),
which handles Ethernet interface configuration and data
transmission/reception.

- Patches 1-7 implement the PCI driver
- Patches 8-14 implement the Ethernet driver

This submission is the first phase, which includes the PF-based Ethernet
transmit and receive functionality. Once this is merged, we will submit
additional patches to implement support for other features, such as SR-IOV,
ethtool support, and a new RDMA driver.

Changes v2->v3:
Link to v2: https://lore.kernel.org/netdev/20241230101513.3836531-1-tianx@yunsilicon.com/
1. Use auxiliary bus for ethernet functionality.
- Leon Romanovsky comments
2. Remove netdev from struct xsc_core_device, as it can be accessed via eth_priv.
- Andrew Lunn comments

Changes v1->v2:
Link to v1: https://lore.kernel.org/netdev/20241218105023.2237645-1-tianx@yunsilicon.com/
1. Remove the last two patches to reduce the total code submitted.
- Jakub Kicinski comments
2. Remove the custom logging interfaces and switch to using
   pci_xxx/netdev_xxx logging interfaces. Delete the related
   module parameters.
3. No use of inline functions in .c files.
4. Remove unnecessary license information.
5. Remove unnecessary void casts.
- Andrew Lunn comments
6. Use double underscore (__) for header file macros.
7. Fix the depend field in Kconfig.
8. Add sign-off for co-developers.
9. use string directly in MODULE_DESCRIPTION
10. Fix poor formatting issues in the code.
11. Modify some macros that don't use the XSC_ prefix.
12. Remove unused code from xsc_cmd.h that is not part of this patch series.
13. No comma after items in a complete enum.
14. Use the BIT() macro to define constants related to bit operations.
15. Add comments to clarify names like ver, cqe, eqn, pas, etc.
- Przemek Kitszel comments

Changes v0->v1:
1. name xsc_core_device as xdev instead of dev
2. modify Signed-off-by tag to Co-developed-by
3. remove some obvious comments
4. remove unnecessary zero-init and NULL-init
5. modify bad-named goto labels
6. reordered variable declarations according to the RCT rule
- Przemek Kitszel comments
7. add MODULE_DESCRIPTION()
- Jeff Johnson comments
8. remove unnecessary dev_info logs
9. replace these magic numbers with #defines in xsc_eth_common.h
10. move code to right place
11. delete unlikely() used in probe
12. remove unnecessary reboot callbacks
- Andrew Lunn comments

Xin Tian (14):
  net-next/yunsilicon: Add xsc driver basic framework
  net-next/yunsilicon: Enable CMDQ
  net-next/yunsilicon: Add hardware setup APIs
  net-next/yunsilicon: Add qp and cq management
  net-next/yunsilicon: Add eq and alloc
  net-next/yunsilicon: Add pci irq
  net-next/yunsilicon: Init auxiliary device
  net-next/yunsilicon: Add ethernet interface
  net-next/yunsilicon: Init net device
  net-next/yunsilicon: Add eth needed qp and cq apis
  net-next/yunsilicon: ndo_open and ndo_stop
  net-next/yunsilicon: Add ndo_start_xmit
  net-next/yunsilicon: Add eth rx
  net-next/yunsilicon: add ndo_get_stats64

 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/yunsilicon/Kconfig       |   26 +
 drivers/net/ethernet/yunsilicon/Makefile      |    8 +
 .../yunsilicon/xsc/common/xsc_auto_hw.h       |   94 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  |  632 ++++++
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  215 ++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  529 +++++
 .../yunsilicon/xsc/common/xsc_device.h        |   77 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   25 +
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |   38 +
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   17 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 1929 +++++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   56 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  239 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  557 +++++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        |   42 +
 .../yunsilicon/xsc/net/xsc_eth_stats.h        |   33 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  295 +++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  185 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   90 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |   80 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  179 ++
 .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h |  176 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  203 ++
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   16 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.c    |  109 +
 .../net/ethernet/yunsilicon/xsc/pci/adev.h    |   14 +
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  221 ++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 1555 +++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  151 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  334 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  266 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  384 ++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  419 ++++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  189 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |   30 +
 45 files changed, 9556 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_common.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_rx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_stats.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_tx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_txrx.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_eth_wq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_pph.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/net/xsc_queue.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/adev.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c

--
2.43.0

