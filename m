Return-Path: <netdev+bounces-236273-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 86DB4C3A82C
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 12:20:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D8504FD702
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 11:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DA7A30CD82;
	Thu,  6 Nov 2025 11:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="mN//bWVx"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout07.his.huawei.com (canpmsgout07.his.huawei.com [113.46.200.222])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A28F30DD20;
	Thu,  6 Nov 2025 11:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.222
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762427790; cv=none; b=gnIRkgSybKMoM/51F76oWoeAxLWINN792BX7AKxhRWQUmH3FoJv5JqVfM5OKWqdryFoMNtca6Jk9ftfxg4JUwj2lMTTToS1Ry1vtWL9gT2eF+swanP70BEOmRBRZ0Owha8e7+bONTdu5tKYTKh4D8zTg6PVohslmvaHs7NfpICY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762427790; c=relaxed/simple;
	bh=2/id/VRNdAESqM7Xs/sXc8Ff0Tm2zROdfLId4mPu+9Q=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YnbIGDOdaM2M0+6tXglgpd/GwmH/G7XmwUjPTkl/mxY9Brb+Vy+abElzEXm+wu5JVg/9cIVmhPx+dGpetT70++DF0+nVB5k8hxpVYKsMoCPoStys67kksquiR/CFrSiY1eBhpGjM+vd28EuVvvYYa0bGIvB9VbGQqdslZiBZuX8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=mN//bWVx; arc=none smtp.client-ip=113.46.200.222
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=KMoCDTNxPReZy/vhtkeISGANvyXpsOiedx4glBSIbos=;
	b=mN//bWVxoXZUShLVYzx1xozI2yEm1/KT4m2BH0tDLhyX1CjNc2eK79GV0h+JG2KQsVsKlxcn7
	1AO30tBf34NcnULV33t2kJDTBCEIOr50NMDdNnyi5W0odC+TkSePwdrizTWKWGzf6QXxeQLuJ54
	aLfrmkt/MWZb8J2Dl9w3MY4=
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by canpmsgout07.his.huawei.com (SkyGuard) with ESMTPS id 4d2KN22g8SzLlSd;
	Thu,  6 Nov 2025 19:14:42 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id DDB0C140279;
	Thu,  6 Nov 2025 19:16:17 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 6 Nov 2025 19:16:16 +0800
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
Subject: [PATCH net-next v05 0/5] net: hinic3: PF initialization
Date: Thu, 6 Nov 2025 19:15:50 +0800
Message-ID: <cover.1762414088.git.zhuyikai1@h-partners.com>
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

PATCH 01 V04:
* Code format fixes: wrap the code at 80 characters (Jakub Kicinski)
* Use str_up_down instead of ternary expression (Simon Horman)
* Remove needless override of error value (Simon Horman)

Fan Gong (5):
  hinic3: Add PF framework
  hinic3: Add PF management interfaces
  hinic3: Add NIC configuration ops
  hinic3: Add mac filter ops
  hinic3: Add netdev register interfaces

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 418 ++++++++++++++++++
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
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  55 ++-
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
 24 files changed, 2547 insertions(+), 31 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: 16a2206354d169bfd13552ad577e07ce66e439ab
-- 
2.43.0


