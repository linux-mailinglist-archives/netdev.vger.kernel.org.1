Return-Path: <netdev+bounces-76796-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBF186EF14
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B9E3D1F225D7
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 262C91171D;
	Sat,  2 Mar 2024 07:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JV1ysydK"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0291C749F
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709364196; cv=none; b=Ef8pPYArBlN9lm2VKjJKfqQs5+lrnx1KgcFQYBdN25gWQijuUSTU1C2LB+DkFK5VHGKFiYBwWF/7T6/H3vAcV44NDGiBy6J5Scr/eEOVWEQCE71HVzluJuAEFRbFsNdZNsUt9MUTWMgEcKXJiPl83rAvuk8jqQfiYXoOWti7D9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709364196; c=relaxed/simple;
	bh=PmzYu8WLjpFuzH+FjJLfxa0LUyWc2VkNyRvipjUskv0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jSuxi7C7J2oZRxXFCXTjggDdy9uDWgD1eegvouLkkUU8fW/+NUHpVmbWW+IfupTKFtZU8/aWqAExLUo7QRiy4aepzQ55LgojJZB7uGlzH3o6eaPtjxkZ1a7zuoeRC41AF+PJ/zVxMwr+OqK0lZzqmNrVNVyochiM3/k2qDMn5mg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JV1ysydK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F38EC433C7;
	Sat,  2 Mar 2024 07:23:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709364195;
	bh=PmzYu8WLjpFuzH+FjJLfxa0LUyWc2VkNyRvipjUskv0=;
	h=From:To:Cc:Subject:Date:From;
	b=JV1ysydKDfax0tAuGVLqHNn7D0oxcxDh05u8oqehVN0633pU8kZouiKxeLwOs9noG
	 b+PmE619moaaS1egYL0nXaDbREuLdIBEfkTC83D658TXl0y/ottrr3vr8qcAJWeaIS
	 qe1zfqHI58/SN1Cn9Kma3VtFBROfAUteiYhinzVrRsTJhEWYG1C6X9P2AnZZSX8zLU
	 7Y0/eN819Ys7fwJkcx655LBK80S0fek0f+SA22hIcU5A5gStMjw0AQu02tc8gEJ5kB
	 WsFJ8vsE+rikRWD3KSeXfDPmwRVgJjEU7yRA9sYRgJz1QF53rwcB9O+r1LZt82Kw7o
	 e3vtp97uFW19Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Gal Pressman <gal@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>,
	sridhar.samudrala@intel.com,
	Jay Vosburgh <jay.vosburgh@canonical.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [pull request][net-next V4 00/15] mlx5 socket direct (Multi-PF)
Date: Fri,  1 Mar 2024 23:22:30 -0800
Message-ID: <20240302072246.67920-1-saeed@kernel.org>
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


The following changes since commit e960825709330cb199d209740326cec37e8c419d:

  Merge branch 'inet_dump_ifaddr-no-rtnl' (2024-03-01 11:09:40 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-socket-direct-v3

for you to fetch changes up to 63b64788540b36113c80b2718a8ca6cb40d2201a:

  Documentation: networking: Add description for multi-pf netdev (2024-03-01 23:19:34 -0800)

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
 Documentation/networking/multi-pf-netdev.rst       | 177 +++++++
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
 34 files changed, 1171 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/networking/multi-pf-netdev.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h

