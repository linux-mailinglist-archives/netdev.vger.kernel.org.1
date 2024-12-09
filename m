Return-Path: <netdev+bounces-150063-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6EF709E8BF6
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 08:14:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4525D1884EBA
	for <lists+netdev@lfdr.de>; Mon,  9 Dec 2024 07:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76C05214A88;
	Mon,  9 Dec 2024 07:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b="GFioUy5n"
X-Original-To: netdev@vger.kernel.org
Received: from lf-2-14.ptr.blmpb.com (lf-2-14.ptr.blmpb.com [101.36.218.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D913A214A77
	for <netdev@vger.kernel.org>; Mon,  9 Dec 2024 07:14:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.36.218.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733728486; cv=none; b=kysw+oMwo2wZG1OIhQ1XIJC+pQOXNi7cHYlKDG/haQHWJcP5bSnlnjOvZuodzA/C3/XgIXR/CLiNdqHsXhz3H7ADcULxHPUJUgAsfQQT7LcMfBg4D2FkZO5UqhE21x3nu9Y+fpUwMujzRPw8A6Y4ipop6rbaNoAsHpnCA1DtoQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733728486; c=relaxed/simple;
	bh=cHQiY8gHFbUBGx3T0MGuWejCxTwSm2ZLrlAaEVhvHa4=;
	h=From:Content-Type:Cc:Subject:Date:To:Message-Id:Mime-Version; b=RshZqTZNDrZxIACN1leSS0sfgLuxjwtqFJOPgFAaVUM8OJFUst8Obyu7bMwDBBp64SRKQrB0+GpYv9rTN1GzTZQjwG51PlP5GrepF2DsGlw07vPoOq7Q84h4jrbpMzZJ2LcJRNzUBlOXEPn1EKeKMiX9nAwa6DaqyELyT11XXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com; spf=pass smtp.mailfrom=yunsilicon.com; dkim=pass (2048-bit key) header.d=yunsilicon.com header.i=@yunsilicon.com header.b=GFioUy5n; arc=none smtp.client-ip=101.36.218.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=yunsilicon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yunsilicon.com
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 s=feishu2403070942; d=yunsilicon.com; t=1733728265; h=from:subject:
 mime-version:from:date:message-id:subject:to:cc:reply-to:content-type:
 mime-version:in-reply-to:message-id;
 bh=hBXLKHXsmjpFLXzkrsgF3rYoceZ5L3+4r3u9qAGFkCw=;
 b=GFioUy5nOdbFzT+DdynkDGhZQtvoE/7AsLHRXBgQqNFv1AOoK0yegy66C3NwCymn/BfeTA
 9kkdPG6h5sJa1y5Kt2xI+EAaL8nTz0Qs8RTLoZSqh4Qb7c7h3s7t+9NDvXUbdHlIfISAej
 lwoA3sQOVSFFsIuR7Lro6Nkv8iEOkOZeyWRczjr82t6dKGfxVeapkcOoPX99W+YAX0GpJc
 9MUPbwS44lo6iF3yJIzYcn346TbfiDgS9GQg1aOKBGYmGdV7XfqlhaCpsuLLjwpuBgz9Ji
 YP2ykEJSc7rdOd/PcGYt++91Q/foWerhTysGNdMFMFZFj98/dLaHR1gY0X4uCg==
From: "Tian Xin" <tianx@yunsilicon.com>
X-Original-From: Tian Xin <tianx@yunsilicon.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Lms-Return-Path: <lba+267569807+3beeb7+vger.kernel.org+tianx@yunsilicon.com>
Cc: <weihg@yunsilicon.com>, <tianx@yunsilicon.com>
Subject: [PATCH 00/16] net-next/yunsilicon: ADD Yunsilicon XSC Ethernet Driver
Date: Mon,  9 Dec 2024 15:10:45 +0800
Received: from ubuntu-liun.yunsilicon.com ([58.34.192.114]) by smtp.feishu.cn with ESMTP; Mon, 09 Dec 2024 15:11:02 +0800
X-Mailer: git-send-email 2.25.1
To: <netdev@vger.kernel.org>, <davem@davemloft.net>
Message-Id: <20241209071101.3392590-1-tianx@yunsilicon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0

From: Xin Tian <tianx@yunsilicon.com>

The patch series adds the xsc driver, which will support the Yuncilicon
MS/MC/MV series of network devices.

The Yunsilicon MS/MC/MV series network cards provide support for both
Ethernet and RDMA functionalities.

This submission is the first phase, which includes the PF-based Ethernet
transmit and receive functionality. Once this is merged, we will submit
additional patches to implement support for other features, such as SR-IOV,
ethtool support, and a new RDMA driver.


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
 .../yunsilicon/xsc/common/xsc_auto_hw.h       |   97 +
 .../ethernet/yunsilicon/xsc/common/xsc_cmd.h  | 2513 +++++++++++++++++
 .../ethernet/yunsilicon/xsc/common/xsc_cmdq.h |  218 ++
 .../ethernet/yunsilicon/xsc/common/xsc_core.h |  659 +++++
 .../yunsilicon/xsc/common/xsc_device.h        |   77 +
 .../yunsilicon/xsc/common/xsc_driver.h        |   25 +
 .../ethernet/yunsilicon/xsc/common/xsc_pp.h   |   38 +
 .../ethernet/yunsilicon/xsc/common/xsc_pph.h  |  176 ++
 .../net/ethernet/yunsilicon/xsc/net/Kconfig   |   16 +
 .../net/ethernet/yunsilicon/xsc/net/Makefile  |    9 +
 .../net/ethernet/yunsilicon/xsc/net/main.c    | 2195 ++++++++++++++
 .../net/ethernet/yunsilicon/xsc/net/xsc_eth.h |   58 +
 .../yunsilicon/xsc/net/xsc_eth_common.h       |  237 ++
 .../ethernet/yunsilicon/xsc/net/xsc_eth_rx.c  |  651 +++++
 .../yunsilicon/xsc/net/xsc_eth_stats.c        |   42 +
 .../yunsilicon/xsc/net/xsc_eth_stats.h        |   33 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_tx.c  |  310 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.c         |  185 ++
 .../yunsilicon/xsc/net/xsc_eth_txrx.h         |   90 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.c  |  109 +
 .../ethernet/yunsilicon/xsc/net/xsc_eth_wq.h  |  207 ++
 .../ethernet/yunsilicon/xsc/net/xsc_queue.h   |  230 ++
 .../net/ethernet/yunsilicon/xsc/pci/Kconfig   |   17 +
 .../net/ethernet/yunsilicon/xsc/pci/Makefile  |   10 +
 .../net/ethernet/yunsilicon/xsc/pci/alloc.c   |  225 ++
 .../net/ethernet/yunsilicon/xsc/pci/alloc.h   |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/cmdq.c    | 2162 ++++++++++++++
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.c  |  151 +
 drivers/net/ethernet/yunsilicon/xsc/pci/cq.h  |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.c  |  356 +++
 drivers/net/ethernet/yunsilicon/xsc/pci/eq.h  |   46 +
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.c  |  269 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/hw.h  |   18 +
 .../net/ethernet/yunsilicon/xsc/pci/intf.c    |  279 ++
 .../net/ethernet/yunsilicon/xsc/pci/intf.h    |   22 +
 .../net/ethernet/yunsilicon/xsc/pci/main.c    |  432 +++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.c |  429 +++
 .../net/ethernet/yunsilicon/xsc/pci/pci_irq.h |   14 +
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.c  |  189 ++
 drivers/net/ethernet/yunsilicon/xsc/pci/qp.h  |   15 +
 .../net/ethernet/yunsilicon/xsc/pci/vport.c   |  102 +
 45 files changed, 12976 insertions(+)
 create mode 100644 drivers/net/ethernet/yunsilicon/Kconfig
 create mode 100644 drivers/net/ethernet/yunsilicon/Makefile
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_auto_hw.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmd.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_cmdq.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_core.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_device.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_driver.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pp.h
 create mode 100644 drivers/net/ethernet/yunsilicon/xsc/common/xsc_pph.h
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

