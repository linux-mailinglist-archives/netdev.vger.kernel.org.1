Return-Path: <netdev+bounces-59385-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9E881ABE7
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 01:57:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D8FD4B22D11
	for <lists+netdev@lfdr.de>; Thu, 21 Dec 2023 00:57:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B1E64A;
	Thu, 21 Dec 2023 00:57:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hdSC5rkU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1C42589
	for <netdev@vger.kernel.org>; Thu, 21 Dec 2023 00:57:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56ACC433C8;
	Thu, 21 Dec 2023 00:57:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703120247;
	bh=kxW35Ullo1uS+z8Qsop3CWvE5kVlZi9XkqcBGBX+AXQ=;
	h=From:To:Cc:Subject:Date:From;
	b=hdSC5rkUwE8IxjP03LSSI2zydIuBtkEZBhr6uaKENz8Z/cF0AP6RZkk7bLFyg4QiH
	 WUQfqodHzc9Nl7jETVbf8+/0N56MLj+hpY99Zx4oA+Y2r2Kcs5l7+wxDvzBC1hcSH8
	 4/k1nnpcbT8QkTm0dJid/jvxf7enhFhi6UEvFxbEdyicr1PxZce2iyks2GTCuCC0LM
	 4y9miliMV7hJfV+exhqz75yQir2yW8ram+6abnD6qxNfBJhXK9C3pFyC7p0MDi8d7W
	 ItqbVg6SOOE/VmMi9qoDQaCo2qCKbobGXAIeCBNZMgRK4VF9euLurgt45Q3NmkSGLO
	 Mq50FKlygg+sg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-12-20
Date: Wed, 20 Dec 2023 16:57:06 -0800
Message-ID: <20231221005721.186607-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series adds support for Socket Direct and Embedded management PF
ethernet netdev support.

For more information please see tag log below.

Please pull and let me know if there is any problem.

Happy holidays.

Thanks,
Saeed.


The following changes since commit bee9705c679d0df8ee099e3c5312ac76f447848a:

  Merge branch 'net-sched-tc-drop-reason' (2023-12-20 11:50:13 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-12-20

for you to fetch changes up to 22c4640698a1d47606b5a4264a584e8046641784:

  net/mlx5: Implement management PF Ethernet profile (2023-12-20 16:54:27 -0800)

----------------------------------------------------------------
mlx5-updates-2023-12-20

mlx5 Socket direct support and management PF profile.

Tariq Says:
===========
Support Socket-Direct multi-dev netdev

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

===========

Armen Says:
===========
Management PF support and module integration

This patch rolls out comprehensive support for the Management Physical
Function (MGMT PF) within the mlx5 driver. It involves updating the
mlx5 interface header to introduce necessary definitions for MGMT PF
and adding a new management PF netdev profile, which will allow the host
side to communicate with the embedded linux on Blue-field devices.

===========

----------------------------------------------------------------
Armen Ratner (1):
      net/mlx5: Implement management PF Ethernet profile

Saeed Mahameed (1):
      net/mlx5e: Use the correct lag ports number when creating TISes

Tariq Toukan (13):
      net/mlx5: Fix query of sd_group field
      net/mlx5: SD, Introduce SD lib
      net/mlx5: SD, Implement basic query and instantiation
      net/mlx5: SD, Implement devcom communication and primary election
      net/mlx5: SD, Implement steering for primary and secondaries
      net/mlx5: SD, Add informative prints in kernel log
      net/mlx5e: Create single netdev per SD group
      net/mlx5e: Create EN core HW resources for all secondary devices
      net/mlx5e: Let channels be SD-aware
      net/mlx5e: Support cross-vhca RSS
      net/mlx5e: Support per-mdev queue counter
      net/mlx5e: Block TLS device offload on combined SD netdev
      net/mlx5: Enable SD feature

 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      |   3 +
 drivers/net/ethernet/mellanox/mlx5/core/ecpf.c     |   6 +
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |  15 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/mgmt_pf.c   | 268 ++++++++++++
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.c |  48 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   3 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |   8 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   | 123 +++++-
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
 .../net/ethernet/mellanox/mlx5/core/en_common.c    |  21 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 200 +++++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   4 +-
 drivers/net/ethernet/mellanox/mlx5/core/eswitch.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |  12 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   | 487 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |  38 ++
 drivers/net/ethernet/mellanox/mlx5/core/vport.c    |  21 +
 include/linux/mlx5/driver.h                        |  10 +
 include/linux/mlx5/mlx5_ifc.h                      |  24 +-
 include/linux/mlx5/vport.h                         |   1 +
 40 files changed, 1320 insertions(+), 192 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en/mgmt_pf.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h

