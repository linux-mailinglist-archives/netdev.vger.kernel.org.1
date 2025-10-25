Return-Path: <netdev+bounces-232771-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 214B6C08BEC
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 08:19:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 431D51C25AFA
	for <lists+netdev@lfdr.de>; Sat, 25 Oct 2025 06:19:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3001E2D8DB9;
	Sat, 25 Oct 2025 06:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ol04oaNa"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B1A2D77E2;
	Sat, 25 Oct 2025 06:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761373139; cv=none; b=nCDdExQ8mC5HxzQTsLGxHjMPWVDAMJpZAqXKY75x/KwtT6wVCJxKWA/3sMTki7o7Y+YsIc10bZQWPgQ29eaxxH61eoTj0Y0S7wg1earuhDnh0Ohhwa3xhAF5H2OUCuJT52sQrSdG5wc6GG/Z7ZTc4gyiKx+7VvWzgMwdi0QxUVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761373139; c=relaxed/simple;
	bh=0TsJFfcvFlFXuxBIyNm7rgseOY6FSG+SodZ1xqOiyus=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=J9H37vphQ+b8bC0fVhLU7D+eX1r5ddEWaOdcjpbyh4R2nINMftSvMYctxxK7tAqqitUxkvxZm63j/ao6LNZ/eU5dtGYzqQtQRup9doVYIzfbpU8hQRCb838XB45ZYMB/1taEkaNZanEUhLCkSUJsI4ZOscLsvmCCuuMZVuVdyMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ol04oaNa; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=d3eVBxR4BUb7+w5NFdwHFuhF0UPg0SYD5nLLfDs7Ltw=;
	b=Ol04oaNaG0ZjSHVo0mz7jmPads301eM1yhGSiLW31WU6c3OdBMzZXeoAuKdOwJeTGRholthRH
	89D9n0a3vq+IQLgHbHo67MK43Wdh/RaClpNX2tx5Jy+ryfnDAfCwuWY/Jv4oPrvjU9aNjEgA4E8
	W0yaDVke2P2MCoudZMJfGZQ=
Received: from mail.maildlp.com (unknown [172.19.163.252])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4ctqLh05yrzcb1C;
	Sat, 25 Oct 2025 14:17:32 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 559A4180B73;
	Sat, 25 Oct 2025 14:18:48 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Sat, 25 Oct 2025 14:18:47 +0800
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
Subject: [PATCH net-next v03 0/5] net: hinic3: PF initialization
Date: Sat, 25 Oct 2025 14:18:31 +0800
Message-ID: <cover.1761362580.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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

PATCH 01 V03:
* Use disable_delayed_work_sync instead of cancel_delayed_work_sync (Paolo Abeni)
* Fill in the missing hinic3_sync_time & hinic3_free_ppf_work (Paolo Abeni)
* Refactor hinic3_mac_filter_sync to implement linux coding style(err label)
  and improve readability (Paolo Abeni & Markus Elfring)

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
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 280 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  84 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  18 +
 24 files changed, 2531 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: 16a2206354d169bfd13552ad577e07ce66e439ab
-- 
2.43.0


