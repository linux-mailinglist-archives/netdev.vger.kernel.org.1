Return-Path: <netdev+bounces-217761-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EBC1B39C89
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 14:13:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 88DFC7B83F5
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 12:10:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFD5F31159A;
	Thu, 28 Aug 2025 12:10:33 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61D95311580;
	Thu, 28 Aug 2025 12:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756383033; cv=none; b=BWfqwOfypDf4tLTGv6vKfEiI4u5QaEVQnaRAYkigifikLaQpxaZC+aFCnHw7+/kbxc7MyWihlAMGtht5DomhEwuEgjXbcbYN81jTwa9m+hb8jDqcoMarGh9gcgWhe9fm/JDvgmoBj7rL+lpRRm1MU2orKTaPU9zadpRNv9Rlh/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756383033; c=relaxed/simple;
	bh=V7RgHdNDHBYxAhY2+IsyX4PfcM+1bA9spprKsdjVpKE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GOnZIyi3MWlp06G01PFcFTzQAsht7BSOjlFDYg2fthrFU7eTO/d2KUiMWLNjrWaYMhhKUqQ4mVMhKWTBc2aGXmyL9aXm+EXxGuKuF9Y5y8L6zuNH6X9SpjrJyeUlU1IC+CDwA1IfZPTCMjsuMZvgbbXx9yOHE46q+a6Kgmpuqh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.174])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4cCKwX3TZpz14MNw;
	Thu, 28 Aug 2025 20:10:20 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id CEE3A14011A;
	Thu, 28 Aug 2025 20:10:27 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.189.55) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 28 Aug 2025 20:10:26 +0800
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
	<shijing34@huawei.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>, Lee Trager <lee@trager.us>, Michael Ellerman
	<mpe@ellerman.id.au>, Vadim Fedorenko <vadim.fedorenko@linux.dev>, Suman
 Ghosh <sumang@marvell.com>, Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Joe Damato <jdamato@fastly.com>, Christophe JAILLET
	<christophe.jaillet@wanadoo.fr>
Subject: [PATCH net-next v02 00/14] net: hinic3: Add a driver for Huawei 3rd gen NIC - sw and hw initialization
Date: Thu, 28 Aug 2025 20:10:06 +0800
Message-ID: <cover.1756378721.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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
* Remove extra memset 0 after kzalloc (Vadim Fedorenko)
* Remove another init function in hinic3_init_hwdev/hwif/nic_io (Vadim Fedorenko)
* Create a new separate patch of fixing code style (Vadim Fedorenko)
* Use bitmap_free instead of kfree (ALOK TIWARI)
* Add prefix "hinic3" to non-static functions and parse_* functions (Vadim Fedorenko)
* Init func_tbl_cfg to {} (Vadim Fedorenko)
* Move endinass-improvements to a separate patch (Vadim Fedorenko)
* Use kmalloc_array before overwrite rss_hkey on the very next line (Vadim Fedorenko)
* Remove extra key copy about hinic3_rss_set_hash_key (Vadim Fedorenko)
* Use netdev_rss_key_fill instead of static rss hash key for safety (Eric Dumazet)

PATCH 03 V02:

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
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.c    | 195 ++++
 .../ethernet/huawei/hinic3/hinic3_hw_cfg.h    |   4 +
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 364 ++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |  21 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   | 121 +++
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c | 547 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  | 253 +++++
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  16 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   |   2 +-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |   9 +-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  |   9 +-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |   2 +
 .../huawei/hinic3/hinic3_mgmt_interface.h     | 119 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 432 ++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 152 +++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  20 +
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |   5 +
 .../ethernet/huawei/hinic3/hinic3_nic_io.c    | 874 +++++++++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_io.h    |  39 +-
 .../huawei/hinic3/hinic3_pci_id_tbl.h         |   9 +
 .../net/ethernet/huawei/hinic3/hinic3_rss.c   | 352 +++++++
 .../net/ethernet/huawei/hinic3/hinic3_rss.h   |  14 +
 .../net/ethernet/huawei/hinic3/hinic3_rx.c    | 232 ++++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  38 +-
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    | 184 +++-
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  30 +-
 28 files changed, 3980 insertions(+), 86 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_mgmt.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_pci_id_tbl.h
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.c
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_rss.h


base-commit: b1c92cdf5af3198e8fbc1345a80e2a1dff386c02
-- 
2.43.0


