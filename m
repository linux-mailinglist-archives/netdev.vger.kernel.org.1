Return-Path: <netdev+bounces-57176-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21A1D8124FE
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 03:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3B7601C20EAC
	for <lists+netdev@lfdr.de>; Thu, 14 Dec 2023 02:08:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48404656;
	Thu, 14 Dec 2023 02:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N0kU+CZK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DEFF7EE
	for <netdev@vger.kernel.org>; Thu, 14 Dec 2023 02:08:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DFF9C433C7;
	Thu, 14 Dec 2023 02:08:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702519720;
	bh=cGB7bdjyKdOa7CURLdMk+DwBIiJzWSfKAY25RRCNdvM=;
	h=From:To:Cc:Subject:Date:From;
	b=N0kU+CZKUyzhL72r5iVf1I7gR+ejRsTXONcZlsY0FOGgAOi7oya99D7waSaqTpq8Q
	 3dQKY6efYYN9+tLckRNPGJs6d3zQ7Dggf/ZZiveaZDqDLtvdB7DANhHqt3gySMjO+Y
	 FaBYGEgwjnh1KGDJBtOIddu7xCAJq9RbgPc72fYGeB9x/wdDEgQEXort9qwtELIEaX
	 C39+8p8HzC/khUMcbCsF+5vfj31MkkF5sUF+OYVBWyUGRNrfMlA6glEY/HsLGy0Q0h
	 KqfiL9sfmLi8rPiKpiR5bXkpByWevNw1QvL1JoYC56TcXQQXN43n0kLLO+DmJgRCbX
	 544Qm+FBoe2Yw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/11] mlx5 updates 2023-12-13
Date: Wed, 13 Dec 2023 18:08:21 -0800
Message-ID: <20231214020832.50703-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series is in preparation for mlx5 netdev Socket Direct feature.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 604ca8ee7bdc62488af1da1231026d3b71f17725:

  Merge branch 'virtio-net-dynamic-coalescing-moderation' (2023-12-13 12:49:05 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-12-13

for you to fetch changes up to 952f9a5f4b0904255ef3dfa58f325fa3e5f045fb:

  net/mlx5: DR, Use swap() instead of open coding it (2023-12-13 18:03:32 -0800)

----------------------------------------------------------------
mlx5-updates-2023-12-13

Preparation for mlx5e socket direct feature.

Socket direct will allow multiple PF devices attached to different
NUMA nodes but sharing the same physical port.

The following series is a small refactoring series in preparation
to support socket direct in the following submission.

Highlights:
 - Define required device registers and bits related to socket direct
 - Flow steering re-arrangements
 - Generalize TX objects (TISs) and store them in a common object, will
   be useful in the next series for per function object management.
 - Decouple raw CQ objects from their parent netdev priv
 - Prepare devcom for Socket Direct device group discovery.

Please see the individual patches for more information.

----------------------------------------------------------------
Jiapeng Chong (1):
      net/mlx5: DR, Use swap() instead of open coding it

Tariq Toukan (10):
      net/mlx5: Add mlx5_ifc bits used for supporting single netdev Socket-Direct
      net/mlx5: Expose Management PCIe Index Register (MPIR)
      net/mlx5: fs, Command to control L2TABLE entry silent mode
      net/mlx5: fs, Command to control TX flow table root
      net/mlx5e: Remove TLS-specific logic in generic create TIS API
      net/mlx5: Move TISes from priv to mdev HW resources
      net/mlx5e: Statify function mlx5e_monitor_counter_arm
      net/mlx5e: Add wrapping for auxiliary_driver ops and remove unused args
      net/mlx5e: Decouple CQ from priv
      net/mlx5: devcom, Add component size getter

 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  25 ++--
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.c |   2 +-
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.h |   1 -
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   2 +
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  16 ++-
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.h   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  74 ++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 159 +++++++--------------
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rx.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |  34 +++++
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.h   |   2 +
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  19 ++-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.h  |   2 +
 .../ethernet/mellanox/mlx5/core/ipoib/ipoib_vlan.c |   7 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |   7 +
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/port.c     |  10 ++
 .../mellanox/mlx5/core/steering/dr_action.c        |   8 +-
 include/linux/mlx5/driver.h                        |   3 +
 include/linux/mlx5/mlx5_ifc.h                      |  45 +++++-
 26 files changed, 290 insertions(+), 161 deletions(-)

