Return-Path: <netdev+bounces-229495-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 285ECBDCDCC
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 09:16:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E46094F7931
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 07:16:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A625731355F;
	Wed, 15 Oct 2025 07:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Xl/2n/qp"
X-Original-To: netdev@vger.kernel.org
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B93A6314A6C;
	Wed, 15 Oct 2025 07:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512555; cv=none; b=GoMNvrng+gLpbS4TYxy9fH5xgqtijTxz9iy+xIwLvrssrli287/9BV0jEW2u+VFnW8i6i6BKzuWpfPehqliFVe8ScQMwSp+O5qVjBl9xIYW1HW1T+QZPTrnEORI0LdSP4VaBTRQMVlMKgOAMaJBZ0LGXQAo+ZW5Si9h7cLTUhoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512555; c=relaxed/simple;
	bh=JahIIfalA1s9dMii7lI7exDte35e0yZh1iOAamcZHig=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sth25U1jAyfZ+pYfkfMYeR79RmViZ6+DGqElDZYQObUHM92osjxr3M+Zk9gxR/B3dNI8ZJvJ6Ck3/fyqAI3GF/zeAdu+zeJKKgN4ot+YW24knDXqFB3sNZEsY0bmEFFv4xa+AyuHa2e9v8BvnWrPvPW/mIWgXJONgPaaKxZg53U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Xl/2n/qp; arc=none smtp.client-ip=113.46.200.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=JGaQwrlo/OIvfU1n9jaauJWGaYGV3R/V1tDdTk378WU=;
	b=Xl/2n/qpOCz1Q1/RQnkgcDXWqBFgUNQUDc2Gpyu8tT6JaWY/rmG2HXE0+XlDPlOQH9Sa05fp0
	M+YfY9QH23IN+z0skPxu2VdIvOKy+pEPAoB0kgmcgKHOBNCdX8Go06pQRatsnebS6S58lGCbMDK
	hSPYpOEnFfDh3Fo6jKUE/1M=
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4cmj5L1mBNzcZyT;
	Wed, 15 Oct 2025 15:14:46 +0800 (CST)
Received: from kwepemf100013.china.huawei.com (unknown [7.202.181.12])
	by mail.maildlp.com (Postfix) with ESMTPS id 6BB6214027A;
	Wed, 15 Oct 2025 15:15:44 +0800 (CST)
Received: from DESKTOP-62GVMTR.china.huawei.com (10.174.188.120) by
 kwepemf100013.china.huawei.com (7.202.181.12) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 15 Oct 2025 15:15:42 +0800
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
Subject: [PATCH net-next v01 0/9] net: hinic3: Add a driver for Huawei 3rd gen NIC - PF initialization
Date: Wed, 15 Oct 2025 15:15:26 +0800
Message-ID: <cover.1760502478.git.zhuyikai1@h-partners.com>
X-Mailer: git-send-email 2.51.0.windows.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
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
Fix code style of merged codes according to previous comments.

Changes:

PATCH 03 V01:

Fan Gong (9):
  hinic3: Add PF framework
  hinic3: Add PF management interfaces
  hinic3: Add NIC configuration ops
  hinic3: Add mac filter ops
  hinic3: Add netdev register interfaces
  hinic3: Fix netif_queue_set_napi queue_index parameter passing error
  hinic3: Fix code Style(remove empty lines between error handling)
  hinic3: Remove redundant defensive code
  hinic3: Use array_size instead of multiplying

 drivers/net/ethernet/huawei/hinic3/Makefile   |   1 +
 .../net/ethernet/huawei/hinic3/hinic3_cmdq.c  |   3 -
 .../net/ethernet/huawei/hinic3/hinic3_csr.h   |   6 +
 .../net/ethernet/huawei/hinic3/hinic3_eqs.c   |   1 -
 .../ethernet/huawei/hinic3/hinic3_filter.c    | 420 ++++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.c   | 105 +++++
 .../ethernet/huawei/hinic3/hinic3_hw_comm.h   |   6 +
 .../ethernet/huawei/hinic3/hinic3_hw_intf.h   |  24 +
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.c |  93 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwdev.h |  55 ++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.c  |  89 +++-
 .../net/ethernet/huawei/hinic3/hinic3_hwif.h  |  23 +
 .../net/ethernet/huawei/hinic3/hinic3_irq.c   | 157 ++++++-
 .../net/ethernet/huawei/hinic3/hinic3_lld.c   |  70 ++-
 .../net/ethernet/huawei/hinic3/hinic3_main.c  | 266 ++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.c  |  57 ++-
 .../net/ethernet/huawei/hinic3/hinic3_mbox.h  |   2 +
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.c  | 308 ++++++++++++-
 .../net/ethernet/huawei/hinic3/hinic3_mgmt.h  |  53 +++
 .../huawei/hinic3/hinic3_mgmt_interface.h     |  69 +++
 .../huawei/hinic3/hinic3_netdev_ops.c         | 380 ++++++++++++++++
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.c   | 286 +++++++++++-
 .../ethernet/huawei/hinic3/hinic3_nic_cfg.h   |  47 ++
 .../ethernet/huawei/hinic3/hinic3_nic_dev.h   |  82 +++-
 .../net/ethernet/huawei/hinic3/hinic3_rx.h    |  20 +
 .../net/ethernet/huawei/hinic3/hinic3_tx.c    |   7 -
 .../net/ethernet/huawei/hinic3/hinic3_tx.h    |  18 +
 27 files changed, 2566 insertions(+), 82 deletions(-)
 create mode 100644 drivers/net/ethernet/huawei/hinic3/hinic3_filter.c


base-commit: 16a2206354d169bfd13552ad577e07ce66e439ab
-- 
2.43.0


