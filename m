Return-Path: <netdev+bounces-228843-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 287CCBD5188
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 18:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C804F34E2BB
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 16:36:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 550312D23AD;
	Mon, 13 Oct 2025 16:36:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="s7zh0XDF"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7152D2949E0
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 16:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760373368; cv=none; b=iGVU12NW6/6jdevAjUpu3IR0i8C4NlF+9Cql98w298Oa17gFzbW0fnyirA/6c2fZ++P830lvyUWF2YDomg6yTKgpUShRWRi2CxJfT5iRG15ouFunYuSwnVMS9Q+On8KJLFYvQsuQXX+BvpZ6kzbIKW46GKIXvnni8VTnju1OTK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760373368; c=relaxed/simple;
	bh=kfFy/xwFbRX75KS4DeBBL40T3AGe2KOlcKsVvlby4SE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iJDzXKWxzWBbIJPTU5OL4if0PKRuaLKJ8iFiFuOhnFZVhkhb19zbdFct6xFLOQhcAYBmpy7a/XpHW2YryxFl6S4gzqgoZHBWeRjCAyBCPVFgLBnMK4BuD+YNnNQW15EkvoIha3032aG5Gm5Uvi+ZC2EE4nyH1LwD4KVyCHIA7wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=s7zh0XDF; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760373363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=xft6FnP3M7lgS82tMmSoqJUtpE/xTspDflOwthoAG68=;
	b=s7zh0XDFuUTh6yk/7bjkHoivnVZPZhgoaF1ZdocTfO8TNqWlTlC9FiHT46+N3wrthl66PF
	D5Hpr3aMxTJbr8hT/QYqZ8+jDiCw3cZEcE1ifhb+64Lv+vSOdBMY1VperSHQxwDkGtDeKM
	NVsRcoDXMrrmVCJz8BcPJIuEQQeXIPM=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Igor Russkikh <irusskikh@marvell.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	netdev@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 00/14] convert net drivers to ndo_hwtstamp API
Date: Mon, 13 Oct 2025 16:34:15 +0000
Message-ID: <20251013163429.4984-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Convert drivers which support HW timestamping to use
.ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks. The new API uses
netlink to communicate with user-space and have some test coverage.
There are some drivers left with old ioctl interface after this series:
- mlx5 driver be shortly converted by nVidia folks
- TI netcp ethss driver which needs separate series which I'll post
  after this one. 

Vadim Fedorenko (14):
  net: ti: am65-cpsw: move hw timestamping to ndo callback
  ti: icssg: convert to ndo_hwtstamp API
  amd-xgbe: convert to ndo_hwtstamp callbacks
  net: atlantic: convert to ndo_hwtstamp API
  cxgb4: convert to ndo_hwtstamp API
  tsnep: convert to ndo_hwtstatmp API
  funeth: convert to ndo_hwtstamp API
  octeontx2: convert to ndo_hwtstamp API
  mlx4: convert to ndo_hwtstamp API
  ionic: convert to ndo_hwtstamp API
  net: ravb: convert to ndo_hwtstamp API
  net: renesas: rswitch: convert to ndo_hwtstamp API
  net: hns3: add hwtstamp_get/hwtstamp_set ops
  net: hns3: move hns3pf to use hwtstamp callbacks

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      |  24 +--
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c |  28 ++--
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  11 +-
 .../net/ethernet/aquantia/atlantic/aq_main.c  |  66 ++------
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |   6 +-
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |   8 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 154 +++++++++---------
 drivers/net/ethernet/engleder/tsnep.h         |   8 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |  14 +-
 drivers/net/ethernet/engleder/tsnep_ptp.c     |  88 +++++-----
 drivers/net/ethernet/fungible/funeth/funeth.h |   4 +-
 .../ethernet/fungible/funeth/funeth_main.c    |  40 ++---
 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   5 +
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   |  29 ++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        |  13 +-
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         |  32 ++--
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |   9 +-
 .../marvell/octeontx2/nic/otx2_common.h       |   9 +-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |  56 +++----
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |   3 +-
 .../net/ethernet/mellanox/mlx4/en_netdev.c    |  61 +++----
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |   6 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   |  17 +-
 .../net/ethernet/pensando/ionic/ionic_lif.h   |  11 +-
 .../net/ethernet/pensando/ionic/ionic_phc.c   |  59 ++++---
 drivers/net/ethernet/renesas/ravb_main.c      |  61 +++----
 drivers/net/ethernet/renesas/rswitch_main.c   |  53 +++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  44 +++--
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  47 ++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   4 +-
 33 files changed, 441 insertions(+), 541 deletions(-)

-- 
2.47.3


