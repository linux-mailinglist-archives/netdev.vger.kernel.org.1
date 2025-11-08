Return-Path: <netdev+bounces-236965-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ED526C42877
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 07:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 89C9C188E93B
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 06:42:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E47E2E54DA;
	Sat,  8 Nov 2025 06:42:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="cocOQ4XY"
X-Original-To: netdev@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2FC92E2850;
	Sat,  8 Nov 2025 06:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762584124; cv=none; b=U4zccApZftgATG4jkCFbsI1SK2FDY3avLYV0EEafXExNG6W5ZXriPq6qACF/sKd12etsUaH2quzELbTKsU7aS2a4AwAmgR8OPcV56JGi9bkzaMc2qwAnHw7Nr5OXy6Ieg2HoyGj1PRIpNDUU4psphhcXNwhFnYJkXUsnFI39mYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762584124; c=relaxed/simple;
	bh=W03MVaCod/egkrZoM36hVftqdXI/TP1LV4SbqfsKzHE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=B6VSUzqACH8+T60ggqC9qLvWzhAFxMZa4Iney6NHEXVShgzV8l5N9UTE6cPvMgm8v8CrchbA9EfOuW2uch8R3RRdX/I7my3csvQXmpuYCVSlLou9TVTH0wCXkeCjXFWHeSDvj48dgT3Iu9IVNeN2xpANWrteP+KkXSP3kwMUvxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=cocOQ4XY; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from canpmsgout02.his.huawei.com (unknown [172.19.92.185])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4d3R6w6STBzTh5p;
	Sat,  8 Nov 2025 14:37:12 +0800 (CST)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=+fOm3C0unkFKPLBnkWKRK3m+9dBgYHsIc3T1X7eLMFI=;
	b=cocOQ4XYP4Q7Tx+PLNwJpuUBPDZB/kT9SfyYQmeieg2U2N9ZkhMF9EdjajB9Y/sQwwosNkRSK
	c0Ozux9/TM5BOvHXoCZRgcO7Jv//fHPpsvCjzZjW6TRjEd9BjaciNab1yyM5QCDA/UvXTieKBPc
	7/+9g2PjxfDyhv2Xmz5g9Eg=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4d3RBH05KZzcb3S;
	Sat,  8 Nov 2025 14:40:07 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id E340C180B65;
	Sat,  8 Nov 2025 14:41:48 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 8 Nov 2025 14:41:47 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, Markus Elfring <Markus.Elfring@web.de>, Pavan Chebbi
	<pavan.chebbi@broadcom.com>, ALOK TIWARI <alok.a.tiwari@oracle.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v06 0/5] net: hinic3: PF initialization
Date: Sat, 8 Nov 2025 14:41:35 +0800
Message-ID: <cover.1762581665.git.zhuyikai1@h-partners.com>
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

This is [1/3] part of hinic3 Ethernet driver second submission.
With this patch hinic3 becomes a complete Ethernet driver with
pf and vf.

The driver parts contained in this patch:
Add support for PF framework based on the VF code.
Add PF management interfaces to communicate with HW.
Add ops to configure NIC features.
Support mac filter to unicast and multicast.
Add netdev notifier.

Changes:

PATCH 01 V01: https://lore.kernel.org/netdev/cover.1760502478.git.zhuyikai1@h-partners.com/

PATCH 01 V02: https://lore.kernel.org/netdev/cover.1760685059.git.zhuyikai1@h-partners.com/
* Change the order of hinic3_netdev_event (Jakub Kicinski)
* Use netdev_hold/put instead of dev_hold/put (Jakub Kicinski)
* Remove the semicolon at the end of switch case (Jakub Kicinski)
* Remove redundant PF judgement in hinic3_rx_tx_flush (Paven Chebbi)
* change hinic3_send_mbox_to_mgmt errcode to EFAULT (Paven Chebbi)
* Optimize hinic3_set_bdf_ctxt parameters (Paven Chebbi)
* Modify main and CC recipients (Markus Elfring)

PATCH 01 V03: https://lore.kernel.org/netdev/cover.1761362580.git.zhuyikai1@h-partners.com/
* Use disable_delayed_work_sync instead of cancel_delayed_work_sync (Paolo Abeni)
* Fill in the missing hinic3_sync_time & hinic3_free_ppf_work (Paolo Abeni)
* Refactor hinic3_mac_filter_sync to implement linux coding style(err label)
  and improve readability (Paolo Abeni & Markus Elfring)

PATCH 01 V04: https://lore.kernel.org/netdev/cover.1761711549.git.zhuyikai1@h-partners.com/
* Use linux error value(EADDRINUSE) instead of custom value in set_mac (Simon Horman)
* Use "hinic3_check_pf_set_vf_already" function instead of macro (Simon Horman)

PATCH 01 V05: https://lore.kernel.org/netdev/cover.1762414088.git.zhuyikai1@h-partners.com/
* Code format fixes: wrap the code at 80 characters (Jakub Kicinski)
* Use str_up_down instead of ternary expression (Simon Horman)
* Remove needless override of error value (Simon Horman)

PATCH 01 V06:
* Update dev_err messages (ALOK TIWARI)
* Remove redundant codes "message from vf" in get_mbox_msg_desc (ALOK TIWARI)
* Code spell fix (ALOK TIWARI)
* Modfiy hinic3_uc_sync/unsync to hinic3_filter_mac_sync/unsync (ALOK TIWARI)
* Modify hinic3_mac_filter_sync_hw to return error code (ALOK TIWARI)

Fan Gong (5):
  hinic3: Add PF framework
  hinic3: Add PF management interfaces
  hinic3: Add NIC configuration ops
  hinic3: Add mac filter ops
  hinic3: Add netdev register interfaces

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 416 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 115 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  97 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  90 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  23 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 138 +++++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  53 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 263 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  47 +-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 311 ++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  69 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 380 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 284 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  84 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  18 +
 24 files changed, 2535 insertions(+), 33 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: 16a2206354d169bfd13552ad577e07ce66e439ab
-- 
2.43.0


