Return-Path: <netdev+bounces-78276-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A23138749EA
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 09:42:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD73C1C210AC
	for <lists+netdev@lfdr.de>; Thu,  7 Mar 2024 08:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3D2C82880;
	Thu,  7 Mar 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O+4gX0pl"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFDD46350B
	for <netdev@vger.kernel.org>; Thu,  7 Mar 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709800956; cv=none; b=WZUJAQ9nFSB4MLqZ2P8CNyNHqNHXbaZxDp5IuEqv/CtifWhvHLMn7xrDRzrOvmzTxdX7I7oczuGGsZFxbQN+89cJwiPyRI1UWHPoA+nqq8vzBbYXnE5rVOjiX06D7Ry+r42YjegigBvzhvMLAUdffoe4kgBx/Tsl583ij//asN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709800956; c=relaxed/simple;
	bh=3cWmWtmCimOSev/Te+FQdJngcOhKMHLDmIv6DPLCPWA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oUKpz6JCStyXPRFBIhLEzqnYRvmBhqVGd6W2HyEhM9jHNQ3bWCBCJ0Xq/cNiSh1oleujmDz2yJs3BzrGLSvIG8aMYMtVItkf6kPI9604t3k71YJO6tF4jNTqUIljDXBFTxua30ZUTmQaS+rCXl9Jk1mkSqxFELPysYVjS5pAJtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O+4gX0pl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FF47C433C7;
	Thu,  7 Mar 2024 08:42:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709800956;
	bh=3cWmWtmCimOSev/Te+FQdJngcOhKMHLDmIv6DPLCPWA=;
	h=From:To:Cc:Subject:Date:From;
	b=O+4gX0plSrXNS02q2OLxtQuYxJxuP8D/+owIMAQoRUXhdhAVATlqosvEjkSyMmJGq
	 uFcWtRGbwvjpAZOrrgD872KdOf1z4C/uTo2rG7e+Dh+85mwLv9ERGCyTZZK2Uqy9ZK
	 TDvVV32lMU2+sIH3oy7l44oY9wNKDKF28qA7T8lHHAmoB96JZG4Ae5lG/TX1WP/Gpo
	 xF7LL2hZ1xpO1wXpN+n+68a/LaFs9SPcotaX+2gr4WpDvT0y864KmJupBfw3SpPdAO
	 Nd0A4eBGrXaZ0pUlp79BQifl2vSzrN9IWfODJuV8y5A2XTT0IiKQyrn3zl4Dze44Gi
	 QkwgDVih/qn8w==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [pull request][net-next V6 00/15] mlx5 socket direct (Multi-PF) 
Date: Thu,  7 Mar 2024 00:42:14 -0800
Message-ID: <20240307084229.500776-1-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Support Socket-Direct multi-dev netdev.

V6:
- Address documentation comments from Jakub.

V5:
 - Address documentation comments from Przemek Kitszel.

V4:
- Improve documentation for better user observability and understanding
  of the feature, in terms of queues and their expected NUMA/CPU/IRQ
  affinity.

V3:
- Fix documentation per Jakubs feedback.
- Fix typos
- Link new documentation in the networking index.rst

V2:
- Add documentation in a new patch.
- Add debugfs in a new patch.
- Add mlx5_ifc bit for MPIR cap check and use it before query.

For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.

The following changes since commit d7933a2c7f87667a87a2c0d0c5a1617c414c6024:

  ethtool: remove ethtool_eee_use_linkmodes (2024-03-06 20:40:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-socket-direct-v3

for you to fetch changes up to 77d9ec3f6c8cc592c7e2a1a741f39512198555af:

  Documentation: networking: Add description for multi-pf netdev (2024-03-07 00:40:40 -0800)

----------------------------------------------------------------
Support Multi-PF netdev (Socket Direct)

This series adds support for combining multiple devices (PFs) of the
same port under one netdev instance. Passing traffic through different
devices belonging to different NUMA sockets saves cross-numa traffic and
allows apps running on the same netdev from different numas to still
feel a sense of proximity to the device and achieve improved
performance.

We achieve this by grouping PFs together, and creating the netdev only
once all group members are probed. Symmetrically, we destroy the netdev
once any of the PFs is removed.

The channels are distributed between all devices, a proper configuration
would utilize the correct close numa when working on a certain app/cpu.

We pick one device to be a primary (leader), and it fills a special
role.  The other devices (secondaries) are disconnected from the network
in the chip level (set to silent mode). All RX/TX traffic is steered
through the primary to/from the secondaries.

Currently, we limit the support to PFs only, and up to two devices
(sockets).

V6:
- Address documentation comments from Jakub.

V5:
 - Address documentation comments from Przemek Kitszel.

V4:
 - Improve documentation for better user observability and understanding
   of the feature, in terms of queues and their expected NUMA/CPU/IRQ
   affinity.

V3:
 - Fix documentation per Jakubs feedback.
 - Fix typos
 - Link new documentation in the networking index.rst

V2:
 - Add documentation in a new patch.
 - Add debugfs in a new patch.
 - Add mlx5_ifc bit for MPIR cap check and use it before query.

----------------------------------------------------------------
Tariq Toukan (15):
      net/mlx5: Add MPIR bit in mcam_access_reg
      net/mlx5: SD, Introduce SD lib
      net/mlx5: SD, Implement basic query and instantiation
      net/mlx5: SD, Implement devcom communication and primary election
      net/mlx5: SD, Implement steering for primary and secondaries
      net/mlx5: SD, Add informative prints in kernel log
      net/mlx5: SD, Add debugfs
      net/mlx5e: Create single netdev per SD group
      net/mlx5e: Create EN core HW resources for all secondary devices
      net/mlx5e: Let channels be SD-aware
      net/mlx5e: Support cross-vhca RSS
      net/mlx5e: Support per-mdev queue counter
      net/mlx5e: Block TLS device offload on combined SD netdev
      net/mlx5: Enable SD feature
      Documentation: networking: Add description for multi-pf netdev

 Documentation/networking/index.rst                 |   1 +
 Documentation/networking/multi-pf-netdev.rst       | 174 +++++++
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.c |  48 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   3 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |   8 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   | 123 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |  62 ++-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/pool.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |   8 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 176 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |  12 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   | 524 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |  38 ++
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 34 files changed, 1168 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/networking/multi-pf-netdev.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h

