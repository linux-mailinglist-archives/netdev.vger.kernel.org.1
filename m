Return-Path: <netdev+bounces-203128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18656AF08F5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 05:06:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 817741C041B5
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 03:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6013F1B4242;
	Wed,  2 Jul 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hPWHWiQF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B367145FE8
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 03:06:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751425610; cv=none; b=Gore4/ufNUzM+PhUKdFdOLnkFL3a9n8lEGi1mm6ztJO5nHnLHJnDDKNBJKov3KTrZZWiWLIZBWaGe8vrkOxyjpVgccK/YtKiZ58qfbb4kJYdIyGcZmhrULDUNtjndwUxtrSGHKhvOzxNW8FmX2DRz+QD38XcHbGim1TIcpHff4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751425610; c=relaxed/simple;
	bh=5SHo2pEIKSMMHMzMK2Bu+jTZkWdOx3jPFxCawTRKL+E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tVnOwBiqQU+DEF6yN/0G0h9lwxj5G/nSSVIWGS1BJ+rgL0bvzFWishdvZynFDsWPW6o8rkZDUnVQT0i8aAPCDZHhCM+vsPF0r7D3rxm1farjHWppb+sggG6BRId4wnPvZHD+uMpuhHLsuShB6mRfVT9s7NXlylzt7dmd77g4Tek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hPWHWiQF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9008CC4CEEB;
	Wed,  2 Jul 2025 03:06:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751425610;
	bh=5SHo2pEIKSMMHMzMK2Bu+jTZkWdOx3jPFxCawTRKL+E=;
	h=From:To:Cc:Subject:Date:From;
	b=hPWHWiQFCZoKqwRWVBfAr64BVZEZ7nG6JuOxDL5gwRjgxF5aA1n+06IZ6dpDwKdii
	 vKqJYDrtuLlU3rKgYohP/djmNSQWdLkncmGtEVZIPrUSNYCE2Q3IwXdI3GN0rfd/Bv
	 klbSQTMI5smhBeBl2c1MHu7gTcEE2vMMEMXm1+0ZNa4ESdPvc2bZqEIeOu5NPSW/DF
	 2/eZk8slU+lqKYMQiRRLQZ6WHcUXGias3NTxPP/L6JnAvM1mRubnFD4RWFFmqqNhzZ
	 0GU9nCZb7OfDMgLb48ytTbNVfu3bRG/KYFxN9noC0W4iSW4297rWeAHLzzt1h+WjtV
	 PzpXwA9xLdSJw==
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
Subject: [PATCH net-next v2 0/5] net: migrate remaining drivers to dedicated _rxfh_context ops
Date: Tue,  1 Jul 2025 20:06:01 -0700
Message-ID: <20250702030606.1776293-1-kuba@kernel.org>
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

v2:
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
 .../net/ethernet/mellanox/mlx5/core/en/rss.c  |   3 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  29 ++--
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 145 ++++++++++++++----
 net/core/dev.c                                |  15 +-
 net/ethtool/ioctl.c                           |  68 ++------
 net/ethtool/rss.c                             |   3 +-
 15 files changed, 240 insertions(+), 247 deletions(-)

-- 
2.50.0


