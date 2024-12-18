Return-Path: <netdev+bounces-152889-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FAE19F63D6
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 11:52:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E80E1166F22
	for <lists+netdev@lfdr.de>; Wed, 18 Dec 2024 10:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5397B19C54B;
	Wed, 18 Dec 2024 10:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="J+TLRNPy"
X-Original-To: netdev@vger.kernel.org
Received: from va-2-55.ptr.blmpb.com (va-2-55.ptr.blmpb.com [209.127.231.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F40E419D07A
	for <netdev@vger.kernel.org>; Wed, 18 Dec 2024 10:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.127.231.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734519071; cv=none; b=f44oNmKpqk7bw4RgXTSYlc4adZt3mO6991zlXYtWTNWoi8IdA+vwYAIT3M8VKIs2uEs+Bo4KgCUquLGtBOZ6127+qZUB+yPbqoLgOU2DAJiFtFM5xebVQWeQ0VzSeiBXDCLl8IKickis92eBdaa97VC07sqNahtVI7VNxKI8y0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734519071; c=relaxed/simple;
	bh=0l3AAZLVj5xWQk6J0pQ9ySLPrExPsHKO1y5f/t11ZvY=;
	h=Subject:Message-Id:Content-Type:From:Mime-Version:To:Cc:Date; b=Fp8D/P7fMpNm1cEBlKmHdcaxyxLnhCwQol8jMi9hjmhuEox4+yzzvdy4cQDW0cF0rmOBz0D416VYPfiQVts698qlE1TuYDf+Eqm3nO15zoGJnQuWZmYEycOy/LN3o/AnRNeKiiQHJFakzVkF+nld8BJ2NldRktRD+1PfqTcjK6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=J+TLRNPy; arc=none smtp.client-ip=209.127.231.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1734519064; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=FyuX+a3nlckv214je0Sg+p6w2lmUyuXh+qQCNIT3w3U=;
 b=J+TLRNPyzq5ir2cgH75sUWEU3jEfRiXFKFgfn5IGm0chhfERofOEM8X7o9bkP4o1mNaYVO
 KOK79e4uL3WEEnRAaCVG9N+o1QJDeiUP7U8obk5yMsqRCxzgApZHqHly6FaIwCluymczTC
 mi3IYANJNFL4R9+fDUFHpVlF5RsmZfbQA1x0cmLzyS44Rp/HN0HUq33h7ZdEJTBmxfhnic
 pXmBBmmi5Nuuc8Xt9RBfHXXXfrTkw8gr8Blln9H/JhafwahXWnh7sKTPtmcPzCOqjuqxhc
 t2mWyr+/iNOnz3wZxKgLIUky3I1ZE+yGaI9bxO4QmfMcXKCPeuoZNBUNB2E4Bw==
Subject: [PATCH v1 00/16] net-next/yunsilicon: ADD Yunsilicon XSC Ethernet Driver
Message-Id: <20241218105023.2237645-1-tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
From: "Xin Tian" <tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTPS; Wed, 18 Dec 2024 18:51:01 +0800
To: <netdev@vger.kernel.org>
X-Original-From: Xin Tian <tianx@yunsilicon.com>
Cc: <andrew+netdev@lunn.ch>, <kuba@kernel.org>, <pabeni@redhat.com>, 
	<edumazet@google.com>, <davem@davemloft.net>, 
	<jeff.johnson@oss.qualcomm.com>, <przemyslaw.kitszel@intel.com>, 
	<weihg@yunsilicon.com>, <wanry@yunsilicon.com>
Date: Wed, 18 Dec 2024 18:51:01 +0800
X-Lms-Return-Path: <lba+26762a916+c43950+vger.kernel.org+tianx@yunsilicon.com>
Content-Transfer-Encoding: 7bit

The patch series adds the xsc driver, which will support the Yuncilicon
MS/MC/MV series of network devices.

The Yunsilicon MS/MC/MV series network cards provide support for both
Ethernet and RDMA functionalities.

This submission is the first phase, which includes the PF-based Ethernet
transmit and receive functionality. Once this is merged, we will submit
additional patches to implement support for other features, such as SR-IOV,
ethtool support, and a new RDMA driver.

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


Xin Tian (16):
  net-next/yunsilicon: Add yunsilicon xsc driver basic framework
  net-next/yunsilicon: Enable CMDQ
  net-next/yunsilicon: Add hardware setup APIs
  net-next/yunsilicon: Add qp and cq management
  net-next/yunsilicon: Add eq and alloc
  net-next/yunsilicon: Add pci irq
  net-next/yunsilicon: Device and interface management
  net-next/yunsilicon: Add ethernet interface
  net-next/yunsilicon: Init net device
  net-next/yunsilicon: Add eth needed qp and cq apis
  net-next/yunsilicon: ndo_open and ndo_stop
  net-next/yunsilicon: Add ndo_start_xmit
  net-next/yunsilicon: Add eth rx
  net-next/yunsilicon: add ndo_get_stats64
  net-next/yunsilicon: Add ndo_set_mac_address
  net-next/yunsilicon: Add change mtu

 drivers/net/ethernet/Kconfig                  |    1 +
 drivers/net/ethernet/Makefile                 |    1 +
 drivers/net/ethernet/yunsilicon/Kconfig       |   26 +
 drivers/net/ethernet/yunsilicon/Makefile      |    8 +
 .../yunsilicon/xsc/common/xsc_auto_hw.h       |   94 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  | 2513 +++++++++++++++++
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  218 ++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  647 +++++
 .../yunsilicon/xsc/common/xsc_device.h        |   77 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   25 +
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |   38 +
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   16 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 2180 ++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   58 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  239 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  608 ++++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        |   42 +
 .../yunsilicon/xsc/net/xsc_eth_stats.h        |   33 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  310 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  185 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   90 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |  109 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  207 ++
 .../net/ethernet/yunsilicon/xsc/net/xsc_pph.h |  176 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  230 ++
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   16 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  225 ++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 2000 +++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  151 +
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  345 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  269 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
 .../net/ethernet/yunsilicon/xsc/pci/intf.c    |  279 ++
 .../net/ethernet/yunsilicon/xsc/pci/intf.h    |   22 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  426 +++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  427 +++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  189 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |  102 +
 45 files changed, 12723 insertions(+)
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
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/alloc.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cmdq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/intf.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/intf.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/main.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/pci_irq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/pci/vport.c

-- 
2.43.0

