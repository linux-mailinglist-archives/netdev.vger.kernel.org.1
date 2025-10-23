Return-Path: <netdev+bounces-232270-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5B9EC03A2E
	for <lists+netdev@lfdr.de>; Fri, 24 Oct 2025 00:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7E4023B692C
	for <lists+netdev@lfdr.de>; Thu, 23 Oct 2025 22:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C3DA263899;
	Thu, 23 Oct 2025 22:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="P0kF10TU"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D661299A9E
	for <netdev@vger.kernel.org>; Thu, 23 Oct 2025 22:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761257121; cv=none; b=cMWCgF73NKyH/vZ6yf5M5XhsQGtGqELrvDs5lpZDRk74aQ0Z50kEJCiEUQUsVixmyPw6JxzsCfznsUVLk8X6Oyurw9I9Xm2ms8W954DDKQRSrJI+8GkP5QBCZyMdW8m6CR6E71rWVKTKZSBFvdDCujiSbL53NDX019NgIZgV5vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761257121; c=relaxed/simple;
	bh=ioTHWtZyicX1PYcq8lbYFsuMxeiqnC8bmB5v9dSqr9c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=AeUU/PWVi7MyRY1IslxZBhtqhHQAK+AeOWyLHvH3ntZly9bke9a8p1G3eIn5XY4cfUlWhHAzhmyqxERf/nVbgB9srC8HyEa9+aw094nR+gEUMv+Dxty9XUckNZxtbGccYVMzTILBiZZnBWCqpf8BD5X4vmHsmVqasx8IaZbkQTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=P0kF10TU; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1761257108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jUraxx9cStQCMPeHEMKbx7/f+zLUBLbKTBMMk1wDwRw=;
	b=P0kF10TUMP487hqqvuMRpxhEGqSHb5jDZ6kYceRYufBnYypsGJo43Xl1yrIB/iEkzPrdaB
	QOpMo2TrA1H1dOAbf6fFd0H3YNgEYZkU5qlVt8QKn+2XPXRzWnqfOnZqJ1akgPRBhjkH9U
	EPOgsPXp79HjmtuTesnNxcmPwS4haa8=
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
Subject: [PATCH net-next v5 0/6] convert net drivers to ndo_hwtstamp API part 2
Date: Thu, 23 Oct 2025 22:04:51 +0000
Message-ID: <20251023220457.3201122-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is part 2 of patchset to convert drivers which support HW 
timestamping to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
The new API uses netlink to communicate with user-space and have some
test coverage.

v4 -> v5:
 fix ionic dirver build with CONFIG_PTP_1588_CLOCK=n
v3 -> v4:
 fix commit message in patch 6
v2 -> v3:
 use NL_SET_ERR_MSG_MOD() variant to report errors back to user-space
v1 -> v2: 
 hns3: actually set up new ndo callbacks
 ionic: remove _lif_ portion from name to align with other ndo callbacks


Vadim Fedorenko (6):
  octeontx2: convert to ndo_hwtstamp API
  mlx4: convert to ndo_hwtstamp API
  ionic: convert to ndo_hwtstamp API
  net: ravb: convert to ndo_hwtstamp API
  net: renesas: rswitch: convert to ndo_hwtstamp API
  net: hns3: add hwtstamp_get/hwtstamp_set ops

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |  5 ++
 .../net/ethernet/hisilicon/hns3/hns3_enet.c   | 31 ++++++++++
 .../hisilicon/hns3/hns3pf/hclge_main.c        | 13 ++--
 .../hisilicon/hns3/hns3pf/hclge_ptp.c         | 32 +++++-----
 .../hisilicon/hns3/hns3pf/hclge_ptp.h         |  9 ++-
 .../marvell/octeontx2/nic/otx2_common.h       |  9 ++-
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  | 56 ++++++++---------
 .../ethernet/marvell/octeontx2/nic/otx2_vf.c  |  3 +-
 .../net/ethernet/mellanox/mlx4/en_netdev.c    | 62 ++++++++-----------
 drivers/net/ethernet/mellanox/mlx4/mlx4_en.h  |  6 +-
 .../net/ethernet/pensando/ionic/ionic_lif.c   | 17 +----
 .../net/ethernet/pensando/ionic/ionic_lif.h   | 18 ++++--
 .../net/ethernet/pensando/ionic/ionic_phc.c   | 61 +++++++++++-------
 drivers/net/ethernet/renesas/ravb_main.c      | 61 ++++++------------
 drivers/net/ethernet/renesas/rswitch_main.c   | 53 ++++++----------
 15 files changed, 216 insertions(+), 220 deletions(-)

-- 
2.47.3

