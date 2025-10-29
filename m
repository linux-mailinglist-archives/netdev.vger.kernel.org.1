Return-Path: <netdev+bounces-233787-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 07C96C18670
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 07:16:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79EAF1A6570C
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 06:17:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B40992F6912;
	Wed, 29 Oct 2025 06:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="JOUdQo6g"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4EA13AD26;
	Wed, 29 Oct 2025 06:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761718602; cv=none; b=dU9Uw/KqoVU5GS7vHZjYgj+Ywtp8QYdPe28Hdpz/FNbV5jjnCvhURlCQ42RU8M7Q8OKR8J8Bn80rq4ELhvIo9f3FEWCZaiaFdbubBTzjS80dX3d9HaFwUj+7COgDPE7eOiBfMhPuxdVEpr7Znz1wI2+tlQqgePRPVxvzuRkMLoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761718602; c=relaxed/simple;
	bh=Cswn/ODB/iilmA5fctmmzI7NG2iSTcFYCVrhUBYBM5s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EDosKnuAW/Mf25M8ddbeJyArYGCtpYgspYeMkyUEp3PWjKopl18hFNB7lhEte76leS5R2nTht8UONrAv7o/e13K7JThqx32QsGrGCGsbl1FV97qs0ytGIQBM5kJA547hB9b78uHTSevxFv/bfdnJrE4Y/FHNsduabdks3YcobUA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=JOUdQo6g; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Igz6711lV9ZY2n386/l3Sd0NFW+W1fdFastr6bYAwgQ=;
	b=JOUdQo6gnLrD9smX3bZyl4jS5t3GZrEM7NUrI1FQqbg7F0BlHYp0Bj2lWSkDoM9pQ6r9Ttfmm
	xox6mxIbBs+K+oM3moVeDIFI9rr3cXMUXiw6cQ+izR9014dMJZ/DTogyiZ3xRuRknQ1MW7MqCwZ
	pc+syDFzbZEx1KM/LAmj1so=
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4cxH722QLJznTXs;
	Wed, 29 Oct 2025 14:15:58 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 977271402C3;
	Wed, 29 Oct 2025 14:16:35 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 29 Oct 2025 14:16:34 +0800
From: Fan Gong <gongfan1@huawei.com>
To: Fan Gong <gongfan1@huawei.com>, Zhu Yikai <zhuyikai1@h-partners.com>,
	<netdev@vger.kernel.org>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>, Andrew Lunn
	<andrew+netdev@lunn.ch>, <Markus.Elfring@web.de>, <pavan.chebbi@broadcom.com>
CC: <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>, luosifu
	<luosifu@huawei.com>, Xin Guo <guoxin09@huawei.com>, Shen Chenyang
	<shenchenyang1@hisilicon.com>, Zhou Shuai <zhoushuai28@huawei.com>, Wu Like
	<wulike1@huawei.com>, Shi Jing <shijing34@huawei.com>, Luo Yang
	<luoyang82@h-partners.com>, Meny Yossefi <meny.yossefi@huawei.com>, Gur Stavi
	<gur.stavi@huawei.com>
Subject: [PATCH net-next v04 0/5] net: hinic3: PF initialization
Date: Wed, 29 Oct 2025 14:16:24 +0800
Message-ID: <cover.1761711549.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
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

PATCH 01 V04:
* Use linux error value(EADDRINUSE) instead of custom value in set_mac (Simon Horman)
* Use "hinic3_check_pf_set_vf_already" function instead of macro (Simon Horman)

Fan Gong (5):
  hinic3: Add PF framework
  hinic3: Add PF management interfaces
  hinic3: Add NIC configuration ops
  hinic3: Add mac filter ops
  hinic3: Add netdev register interfaces

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 412 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 115 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  97 ++++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  21 +
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  89 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  23 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 138 +++++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  52 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 261 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  55 ++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 309 ++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  69 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 380 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 283 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  84 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  18 +
 24 files changed, 2534 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: 16a2206354d169bfd13552ad577e07ce66e439ab
-- 
2.43.0


