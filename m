Return-Path: <netdev+bounces-230170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 80714BE500F
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 20:09:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F14BD5E2751
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 18:09:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC087219319;
	Thu, 16 Oct 2025 18:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KXQzuECg"
X-Original-To: netdev@vger.kernel.org
Received: from out-185.mta0.migadu.com (out-185.mta0.migadu.com [91.218.175.185])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C91962309B0
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 18:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.185
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760638147; cv=none; b=AT3DCGqe/0WCia9HC/9t6wPFWEVNqKC8m8eu2qWmNdwKCutz6xnAJVRFOFy8BZ/VlDXVnNRsYoGh8cLA+Xq1TjEzCwsmrh6ZmlWKufyRidkMlbRQ4R6OOqa7Zv84TbNcItuFfHmjkAHu+p4rB1NtdKcOp2MT8yEz3swkfdxlcDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760638147; c=relaxed/simple;
	bh=yA7AchHan8xO5vsM23dG4iEWl7z5agKUi/yd98rTb/A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XzLMP/8ebJkOrs6jFDYQbcHwFFGGKf4DyM7j4Tu2HeUXrjv2/kNIEhT2Gyddpn1q75VGcX2GMemym4EUwrE1+x+aOa89PohK/vUrkusF82We98bETZ0uFTsF89+1zJ4zux8jcfuXozFoaOdsfnUsFp5VO7EZ0J+7vrHAVSz3GDU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KXQzuECg; arc=none smtp.client-ip=91.218.175.185
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760638133;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=hFBd9bxcjbtzo6z2yQHweJ9Rici2HCjRryD2GsZrQtE=;
	b=KXQzuECg23W3bcjKTdm0vHXqn67r3zH881eTsSrAsNucpWHVRHD6SEZGioEX7O1b1SdEGz
	bt2EJrKFGdScZXORSqxJTKD9F6TxP7h24XbgwqiHHI78wts4pyskyX4s3vW3mM8kGvTb7o
	k58l+Riv4SHKLZnVUeqBWc4CDda5KcE=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Jian Shen <shenjian15@huawei.com>,
	Salil Mehta <salil.mehta@huawei.com>,
	Jijie Shao <shaojijie@huawei.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Tariq Toukan <tariqt@nvidia.com>,
	Brett Creeley <brett.creeley@amd.com>,
	=?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
	Paul Barker <paul@pbarker.dev>,
	Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Cc: linux-renesas-soc@vger.kernel.org,
	Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next 0/6] convert net drivers to ndo_hwtstamp API part 2
Date: Thu, 16 Oct 2025 18:07:21 +0000
Message-ID: <20251016180727.3511399-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is part 2 of patchset to convert drivers which support HW 
timestamping to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
The new API uses netlink to communicate with user-space and have some
test coverage.

Vadim Fedorenko (6):
  octeontx2: convert to ndo_hwtstamp API
  mlx4: convert to ndo_hwtstamp API
  ionic: convert to ndo_hwtstamp API
  net: ravb: convert to ndo_hwtstamp API
  net: renesas: rswitch: convert to ndo_hwtstamp API
  net: hns3: add hwtstamp_get/hwtstamp_set ops

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  5 ++
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 29 +++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 13 ++--
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         | 32 +++++-----
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  9 ++-
 .../marvell/octeontx2/nic/otx2_common.h       |  9 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 56 ++++++++---------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  3 +-
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 61 ++++++++-----------
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  6 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 17 +-----
 .../net/ethernet/pensando/ionic/ionic_lif.h   | 11 ++--
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 59 +++++++++++-------
 drivers/net/ethernet/renesas/ravb_main.c      | 61 ++++++-------------
 drivers/net/ethernet/renesas/rswitch_main.c   | 53 ++++++----------
 15 files changed, 206 insertions(+), 218 deletions(-)

-- 
2.47.3


