Return-Path: <netdev+bounces-202548-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3FAEE411
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 18:17:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D04E317E919
	for <lists+netdev@lfdr.de>; Mon, 30 Jun 2025 16:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5A43291C13;
	Mon, 30 Jun 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DxOZGF5q"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990AF28ECDA
	for <netdev@vger.kernel.org>; Mon, 30 Jun 2025 16:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751299801; cv=none; b=KZQupBN9eF0o80wS7WBqPrjRj6yUPjFwoW2j6DyiP9eGtEsTEZi8Rmj4GYDVGF7JbLyK7nOes9KfoGn5JdUZ/CQkU5seprPVhQYA1uQue5oeETWM2INupIu3SFYmF3K3iszwbLlHyqBKaymi2Wd4OsmvXmSYFiPP4aQFFrILBj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751299801; c=relaxed/simple;
	bh=O84BcNYLyv1cldTJzUuGKt0/uBw2/l73tQF2YsdcWn0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ke1ZoqKNtUT+klxb/q+L/aSJ6E71rSgb8ToiBNGUc3cE08XtJVqUGzbmc0lGYCYXagDTCm/hnXg0PQ8Zr9sXhJajaR9qmp1+1vKiWJRlyZrSM3yEOUwVU5d406vSYE8NsbuNTe5S1/Lws3cbuoFCZdg7UCeeLYoEclHYmo+O4Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DxOZGF5q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DEBC4CEE3;
	Mon, 30 Jun 2025 16:10:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751299801;
	bh=O84BcNYLyv1cldTJzUuGKt0/uBw2/l73tQF2YsdcWn0=;
	h=From:To:Cc:Subject:Date:From;
	b=DxOZGF5qPGHuY78K3aTMKqaWZnWKAfXDBVI4DFt7Hd6NrKLEKeWbsL4jxnXMzySVJ
	 d07+U7e644Ki4s8GQqN2lMYpYUuUdRhNkHn/eexF1UQyNhSsjFFZ/yB7GDUuiv5vg+
	 O3CJvXFNNHkmmBTN9u35rDY013M36v73621h63nCtwxHHfgtTrAhpPduya9qTn6ZC5
	 r3nv2Y/F2IZ/v2WRwm2XSocWRvgLhbOED2NByMXZrJkYznFHCANx0hr7lYjtdESAtH
	 /NS2CwEhZfNXM5brI7qH3jXzEZrStTRyNIw3IRAAG+hLS+tsvrQezzqKxAuzP35KHk
	 zfmBNRyPPUqIw==
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
Subject: [PATCH net-next 0/5] net: migrate remaining drivers to dedicated _rxfh_context ops
Date: Mon, 30 Jun 2025 09:09:48 -0700
Message-ID: <20250630160953.1093267-1-kuba@kernel.org>
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

Jakub Kicinski (5):
  eth: otx2: migrate to the *_rxfh_context ops
  eth: ice: drop the dead code related to rss_contexts
  eth: mlx5: migrate to the *_rxfh_context ops
  net: ethtool: remove the compat code for _rxfh_context ops
  net: ethtool: reduce indent for _rxfh_context ops

 .../marvell/octeontx2/nic/otx2_common.h       |   8 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.h   |   2 +-
 include/linux/ethtool.h                       |   4 -
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  28 +---
 .../marvell/octeontx2/nic/otx2_common.c       |  27 ++--
 .../marvell/octeontx2/nic/otx2_ethtool.c      | 137 ++++++++++--------
 .../ethernet/marvell/octeontx2/nic/otx2_pf.c  |   6 +-
 .../ethernet/marvell/octeontx2/nic/otx2_xsk.c |   4 +-
 .../ethernet/mellanox/mlx5/core/en/rx_res.c   |  12 +-
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  | 125 +++++++++++++---
 net/core/dev.c                                |   6 +-
 net/ethtool/ioctl.c                           |  68 ++-------
 net/ethtool/rss.c                             |   3 +-
 13 files changed, 218 insertions(+), 212 deletions(-)

-- 
2.50.0


