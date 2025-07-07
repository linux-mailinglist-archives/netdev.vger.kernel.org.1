Return-Path: <netdev+bounces-204669-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57A55AFBAE8
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 20:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E034D1888BEE
	for <lists+netdev@lfdr.de>; Mon,  7 Jul 2025 18:41:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 576B3264623;
	Mon,  7 Jul 2025 18:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcPofv/v"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31E63264618
	for <netdev@vger.kernel.org>; Mon,  7 Jul 2025 18:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751913682; cv=none; b=cPfO/V/0/h4Ll7EJZ+L3wsZcnKt2Uxi8cGorSJXnnK0lpKfaQsFLdt2woR/OuQu3TkhATGBpp0HpGeQc1VU9XfgIfp73R1hUshnJQfCrARJp7bfo464ipv5ntZ5Z85qcJYe+816aM5YhC9zd3gmRodhcve2rEZx71v7j/Plp14Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751913682; c=relaxed/simple;
	bh=2GbA+xN6HwAa/DxC/EjLZARQQWIX5njv+MLC8yGnJV8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lyJBK4rCz78JsWOW0LN3o3bvfasNc+sZWTllv87gc1j2QFZz52X4aqdurwZnFL+y7wq5FnLZN+fttw5iLKDWlryvbtf5NkxB0nQOBkK0tXwIlNrH+tLg115vpMRTzI8qBSJH4oE0rxDVC4cet0JtT07QXn3odAb7lFBTj8vzXzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcPofv/v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2026CC4CEE3;
	Mon,  7 Jul 2025 18:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751913681;
	bh=2GbA+xN6HwAa/DxC/EjLZARQQWIX5njv+MLC8yGnJV8=;
	h=From:To:Cc:Subject:Date:From;
	b=PcPofv/v9GP7TkG295g4miy4dw5ngqprTWas+skXktoF4zmsxHGudOPqq94hjcUoB
	 1yVykAKjBh8dTGX2WRAVWYoPDlD2+TJcPIa+PW6eixBe/+HwZzWmJ1ja3s2QHcGXFb
	 OvE4x1kXQFMK8sFiyQHFoNraqCO/hoTSAR7TJ+RNgTYuR/R6rV0xSLICJBmuYKPf01
	 28yJxJU364SvBv4MsY0MV92zRr2ME8oahND34wNLeTM15btx3VCDJXP5Cee7EDCOTp
	 TNuE5TfSh1Mt38WCqjYmMFxw1ANwHuASLT+Npi5Ta5d1iX8U50wY/UHubogEokQfxU
	 rwIweBCiTd00g==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	andrew@lunn.ch,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	sgoutham@marvell.com,
	gakula@marvell.com,
	sbhatta@marvell.com,
	bbhushan2@marvell.com,
	tariqt@nvidia.com,
	mbloch@nvidia.com,
	leon@kernel.org,
	gal@nvidia.com,
	ecree.xilinx@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 0/5] net: migrate remaining drivers to dedicated _rxfh_context ops
Date: Mon,  7 Jul 2025 11:41:10 -0700
Message-ID: <20250707184115.2285277-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Around a year ago Ed added dedicated ops for managing RSS contexts.
This significantly improved the clarity of the driver facing API.
Migrate the remaining 3 drivers and remove the old way of muxing
the RSS context operations via .set_rxfh().

v3:
 - [mlx5] fix compilation
 - [patch 4] remove more branches
 - [patch 5] reformat
v2: https://lore.kernel.org/20250702030606.1776293-1-kuba@kernel.org
 - [mlx5] remove hfunc local var in mlx5e_rxfh_hfunc_check()
 - [mlx5] make the get functions void and add WARN_ON_ONCE()
 - [patch 4] remove rxfh struct in netdev_rss_contexts_free()
v1: https://lore.kernel.org/20250630160953.1093267-1-kuba@kernel.org

Jakub Kicinski (5):
  eth: otx2: migrate to the *_rxfh_context ops
  eth: ice: drop the dead code related to rss_contexts
  eth: mlx5: migrate to the *_rxfh_context ops
  net: ethtool: remove the compat code for _rxfh_context ops
  net: ethtool: reduce indent for _rxfh_context ops

 .../marvell/octeontx2/nic/otx2_common.h       |   8 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.h  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   7 +-
 include/linux/ethtool.h                       |   4 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  28 +---
 .../marvell/octeontx2/nic/otx2_common.c       |  27 ++--
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 137 +++++++++--------
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |   5 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  30 ++--
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 145 ++++++++++++++----
 net/core/dev.c                                |  15 +-
 net/ethtool/ioctl.c                           |  93 +++--------
 net/ethtool/rss.c                             |   3 +-
 15 files changed, 250 insertions(+), 265 deletions(-)

-- 
2.50.0


