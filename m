Return-Path: <netdev+bounces-222422-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB62B542D8
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 08:28:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AD8A5565854
	for <lists+netdev@lfdr.de>; Fri, 12 Sep 2025 06:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD35281530;
	Fri, 12 Sep 2025 06:28:51 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31F4E134BD;
	Fri, 12 Sep 2025 06:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757658531; cv=none; b=R5/MPQgv70XPq58RFAOnrMEVlltx6QnnaUtmE0v0G1qnJp0rGk27Ix1M/glwrfVX5B+z6M2wdvkfaIpADtABm3+iQUCbZwn2pvpK7m24pjPztwQhe0z7fo+YohdLQ66XLJcjqDFhq0r9s+SMvfPtQ4EMBmlCOUOE0YRvbKUr1hM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757658531; c=relaxed/simple;
	bh=n9uh+eUbq1plCIfJHPx2hvfSEm+aoHjwv2aI0EWbXII=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tYJZtOCh/9yi9UXNg8XmsEiaX+mNgxUQlGCVzGZZB4AvcU7xLcP+8aBVcRjLbToQsoy8qL9AVpdChHBtcGr4WEW8vK8iNKGejp60QSNhLlmZsVCpH/AOM5MZu7Vxj1/vYtKg2uLO7oZZ6/R3HBRr3nrAA8Ls5mnXJ++rXbKynTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cNPXh1ZDYz13Ms5;
	Fri, 12 Sep 2025 14:24:36 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 099D11400C8;
	Fri, 12 Sep 2025 14:28:39 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 12 Sep 2025 14:28:37 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>
CC: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>, "David S.
 Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman
	<horms@kernel.org>, Andrew Lunn <andrew+netdev@lunn.ch>,
	<linux-doc@vger.kernel.org>, Jonathan Corbet <corbet@lwn.net>, Bjorn Helgaas
	<helgaas@kernel.org>, luosifu <luosifu@huawei.com>, Xin Guo
	<guoxin09@huawei.com>, Shen Chenyang <shenchenyang1@hisilicon.com>, Zhou
 Shuai <zhoushuai28@huawei.com>, Wu Like <wulike1@huawei.com>, Shi Jing
	<shijing34@huawei.com>, Luo Yang <luoyang82@h-partners.com>, Meny Yossefi
	<meny.yossefi@huawei.com>, Gur Stavi <gur.stavi@huawei.com>, Lee Trager
	<lee@trager.us>, Michael Ellerman <mpe@ellerman.id.au>, Vadim Fedorenko
	<vadim.fedorenko@linux.dev>, Suman Ghosh <sumang@marvell.com>, Przemek
 Kitszel <przemyslaw.kitszel@intel.com>, Joe Damato <jdamato@fastly.com>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v06 00/14] net: hinic3: Add a driver for Huawei 3rd gen NIC - sw and hw initialization
Date: Fri, 12 Sep 2025 14:28:17 +0800
Message-ID: <cover.1757653621.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100001.china.huawei.com (7.221.188.238) To
 kwepemf100013.china.huawei.com (7.202.181.12)

This is [3/3] part of hinic3 Ethernet driver initial submission.
With this patch hinic3 becomes a functional Ethernet driver.

The driver parts contained in this patch:
Memory allocation and initialization of the driver structures.
Management interfaces initialization.
HW capabilities probing, initialization and setup using management
interfaces.
Net device open/stop implementation and data queues initialization.
Register VID:DID in PCI id_table.
Fix netif_queue_set_napi usage.

Changes:

PATCH 03 V01: https://lore.kernel.org/netdev/cover.1756195078.git.zhuyikai1@h-partners.com

PATCH 03 V02: https://lore.kernel.org/netdev/cover.1756378721.git.zhuyikai1@h-partners.com
* Remove extra memset 0 after kzalloc (Vadim Fedorenko)
* Remove another init function in hinic3_init_hwdev/hwif/nic_io (Vadim Fedorenko)
* Create a new separate patch of fixing code style (Vadim Fedorenko)
* Use bitmap_free instead of kfree (ALOK TIWARI)
* Add prefix "hinic3" to non-static functions and parse_* functions (Vadim Fedorenko)
* Init func_tbl_cfg to {} (Vadim Fedorenko)
* Extract endianess improvement from queue pair resource initialization (Vadim Fedorenko)
* Use kmalloc_array before overwrite rss_hkey on the very next line (Vadim Fedorenko)
* Remove extra key copy about hinic3_rss_set_hash_key (Vadim Fedorenko)
* Use netdev_rss_key_fill instead of static rss hash key for safety (Eric Dumazet)

PATCH 03 V03: https://lore.kernel.org/netdev/cover.1756524443.git.zhuyikai1@h-partners.com
* Modify get_hwif_attr function for improving readability (Vadim Fedorenko)
* Add HINIC3_PCIE_LINK_DOWN errorcode to init_hwif_attr error handling (Vadim Fedorenko)

PATCH 03 V04: https://lore.kernel.org/netdev/cover.1757057860.git.zhuyikai1@h-partners.com
* Use pci_enable_msix_range instead of pci_alloc_irq_vectors (Jakub Kicinski)
* Move defensive codes to place that they are set/loaded (Jakub Kicinski)
* Code format fixes: remove empty lines between error handling path (Jakub Kicinski)
* Remove redundant waiting sleep in hinic3_rx_tx_flush (Jakub Kicinski)
* Use ethtool_rxfh_indir_default for standalizing codes (Jakub Kicinski)
* Use netif_get_num_default_rss_queues instead of driver-local logic (Jakub Kicinski)
* Use netif_set_real_num_queues to set both TX and RX queues (Jakub Kicinski)

PATCH 03 V05: https://lore.kernel.org/netdev/cover.1757401320.git.zhuyikai1@h-partners.com
* Merge comm_cmd_clear_doorbell & comm_cmd_clear_resource (Vadim Fedorenko)
* Merge hinic3_enable/disable_doorbell to hinic3_toggle_doorbel (Vadim Fedorenko)
* Update hinic3_Nic_io initialization commit message (Vadim Fedorenko)

PATCH 03 V06:
* Use array_size() instead of multipling directly (Simon Horman)
* Modify comment in hinic3_config_num_qps to improve readability (Simon Horman)

Fan Gong (14):
  hinic3: HW initialization
  hinic3: HW management interfaces
  hinic3: HW common function initialization
  hinic3: HW capability initialization
  hinic3: Command Queue flush interfaces
  hinic3: Nic_io initialization
  hinic3: Queue pair endianness improvements
  hinic3: Queue pair resource initialization
  hinic3: Queue pair context initialization
  hinic3: Tx & Rx configuration
  hinic3: Add Rss function
  hinic3: Add port management
  hinic3: Fix missing napi->dev in netif_queue_set_napi
  hinic3: Fix code style (Missing a blank line before return)

 drivers/net/ethernet/huawei/hinic3/Makefile   |   2 +
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 168 ++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   4 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 363 ++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  21 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 115 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 541 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 269 ++++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   2 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   9 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   8 +-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   2 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 119 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 426 ++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 152 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  20 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   5 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 870 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  39 +-
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 336 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  14 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 226 ++++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  38 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 184 +++-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  30 +-
 28 files changed, 3923 insertions(+), 86 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.h


base-commit: b1c92cdf5af3198e8fbc1345a80e2a1dff386c02
-- 
2.43.0


