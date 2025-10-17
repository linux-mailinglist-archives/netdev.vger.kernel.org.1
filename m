Return-Path: <netdev+bounces-230366-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C21E2BE72C1
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 10:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D96424066CA
	for <lists+netdev@lfdr.de>; Fri, 17 Oct 2025 08:31:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7E0D29ACC3;
	Fri, 17 Oct 2025 08:31:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="hHnQCcSY"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED96B2550CA;
	Fri, 17 Oct 2025 08:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760689872; cv=none; b=lh87Nqh6tSrLS1tgW9tZDOnXyBIV9/TO/QaBnPFldlYpSu6qROuVOZJApCgt/PS4fuZi/KiKcnuyqcXsmNA/zFRH0ss1BlJ52CyRUe7K7Yhj4c2MyOKBhzzbGH6XyVeJWiC4XBtEIBuWz73jQOAIOmg7LFJDfImr6FUfIgcqcHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760689872; c=relaxed/simple;
	bh=DSUs2mbkH8lek0l8MPD34EnQfWqnkl24o4RehNW2FlM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gavsh4MKnfDhBM5bE+4ixYxIG50ulthXdEkHGslOVomWSh8jJ5iJ0wSuWiHQzP0JDmDPZcNksgyQJ6sthVuZ0ONcwRefD6FJkXBkdoo87Ha9iWD1AzScmHI0vR0yJGZHzjU7W1V+ZlB8/o4v6BbKi9Yvy2OOmuqPxal6NUzCr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=hHnQCcSY; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=e7/1EPoR8jyh3eJyTN4+nPLIEdQslkNN274sLaWndFA=;
	b=hHnQCcSYvdb2Z5D7biPb87t3lzzcoTUaN3+eAXrzWJkfTzrbLI9Xw3ObdCFqH+HV7PqTZAOnz
	YZa6hfDyQN0COsPlAhswy8DN2f5PRSAb3yqiSM6IGqJRStpJB2ACPcQkYUySR0hDE9H84Czwk+U
	Ve5sF7YkRqTGKeb3GSyPdA8=
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4cnygY6B9Xz12LKX;
	Fri, 17 Oct 2025 16:30:17 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id D827C140123;
	Fri, 17 Oct 2025 16:31:01 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Fri, 17 Oct 2025 16:31:00 +0800
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
Subject: [PATCH net-next v02 0/6] net: hinic3: PF initialization
Date: Fri, 17 Oct 2025 16:30:45 +0800
Message-ID: <cover.1760685059.git.zhuyikai1@h-partners.com>
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

PATCH 01 V02:
* Change the order of hinic3_netdev_event (Jakub Kicinski)
* Use netdev_hold/put instead of dev_hold/put (Jakub Kicinski)
* Remove the semicolon at the end of switch case (Jakub Kicinski)
* Remove redundant PF judgement in hinic3_rx_tx_flush (Paven Chebbi)
* change hinic3_send_mbox_to_mgmt errcode to EFAULT (Paven Chebbi)
* Optimize hinic3_set_bdf_ctxt parameters (Paven Chebbi)
* Modify main and CC recipients (Markus Elfring)

Fan Gong (6):
  hinic3: Add PF framework
  hinic3: Add PF management interfaces
  hinic3: Add NIC configuration ops
  hinic3: Add mac filter ops
  hinic3: Add netdev register interfaces
  hinic3: Fix netif_queue_set_napi queue_index parameter passing error

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 413 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   |  99 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  93 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  55 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  89 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  23 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 159 ++++++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  69 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 261 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  55 ++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 309 ++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  69 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 380 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 280 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  83 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  18 +
 24 files changed, 2556 insertions(+), 58 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: 16a2206354d169bfd13552ad577e07ce66e439ab
-- 
2.43.0


