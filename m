Return-Path: <netdev+bounces-27086-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB9177A526
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 08:48:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E1531C2088D
	for <lists+netdev@lfdr.de>; Sun, 13 Aug 2023 06:48:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93AFC17CA;
	Sun, 13 Aug 2023 06:48:18 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 465061CCDE
	for <netdev@vger.kernel.org>; Sun, 13 Aug 2023 06:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE72C433C8;
	Sun, 13 Aug 2023 06:48:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691909296;
	bh=uX9muo9eioloiBiJllRvsD3ZrmxKmdYL1irOWHKtj5M=;
	h=From:To:Cc:Subject:Date:From;
	b=qJnlNnNboafrW1p0Alv9Vu4CmUupCbSJnpjslwShCgb7xz4UOJskrTe5mHRKQqeY8
	 AF0W8E4eXJdYg7/fa34zDddozuCFC3GUW1wk7YxB1DdmF9EZeICLHuYrm9bre35Qp2
	 iv4iGjBvPqyd0qZWn4JwFAPQAdhwaoOk7W9TQhDzDpVXQv8IDLYX5oNyP3a3OMO45p
	 xQ6La7qBMKYxRk5OJJe6N93FwjAd5NgE8rhBEPolArZ11fLl4egnPyHptxknFX+VRC
	 82zVwoGjzzfzI225NHnHryNCTi4yciskDq2uQSDFr8xq8XiM5uBvcE03D5LWje4ytZ
	 ii0ahF/MdhViw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-rdma@vger.kernel.org,
	Maor Gottlieb <maorg@nvidia.com>,
	Mark Zhang <markzhang@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Raed Salem <raeds@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Simon Horman <horms@kernel.org>
Subject: [GIT PULL] Please pull mlx5 MACsec RoCEv2 support
Date: Sun, 13 Aug 2023 09:47:03 +0300
Message-ID: <20230813064703.574082-1-leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This PR is collected from https://lore.kernel.org/all/cover.1691569414.git.leon@kernel.org
and contains patches to support mlx5 MACsec RoCEv2.

It is based on -rc4 and such has minor conflict with net-next due to existance of IPsec packet offlosd
in eswitch code and the resolution is to take both hunks.

diff --cc include/linux/mlx5/driver.h
index 25d0528f9219,3ec8155c405d..000000000000
--- a/include/linux/mlx5/driver.h
+++ b/include/linux/mlx5/driver.h
@@@ -805,6 -806,11 +805,14 @@@ struct mlx5_core_dev 
  	u32                      vsc_addr;
  	struct mlx5_hv_vhca	*hv_vhca;
  	struct mlx5_thermal	*thermal;
+ 	u64			num_block_tc;
+ 	u64			num_block_ipsec;
+ #ifdef CONFIG_MLX5_MACSEC
+ 	struct mlx5_macsec_fs *macsec_fs;
+ #endif
  };
  
  struct mlx5_db {

----------------------------------------------------------------

From Patrisious:

This series extends previously added MACsec offload support
to cover RoCE traffic either.

In order to achieve that, we need configure MACsec with offload between
the two endpoints, like below:

REMOTE_MAC=10:70:fd:43:71:c0

* ip addr add 1.1.1.1/16 dev eth2
* ip link set dev eth2 up
* ip link add link eth2 macsec0 type macsec encrypt on
* ip macsec offload macsec0 mac
* ip macsec add macsec0 tx sa 0 pn 1 on key 00 dffafc8d7b9a43d5b9a3dfbbf6a30c16
* ip macsec add macsec0 rx port 1 address $REMOTE_MAC
* ip macsec add macsec0 rx port 1 address $REMOTE_MAC sa 0 pn 1 on key 01 ead3664f508eb06c40ac7104cdae4ce5
* ip addr add 10.1.0.1/16 dev macsec0
* ip link set dev macsec0 up

And in a similar manner on the other machine, while noting the keys order
would be reversed and the MAC address of the other machine.

RDMA traffic is separated through relevant GID entries and in case of IP ambiguity
issue - meaning we have a physical GIDs and a MACsec GIDs with the same IP/GID, we
disable our physical GID in order to force the user to only use the MACsec GID.

Thanks

----------------------------------------------------------------
The following changes since commit 5d0c230f1de8c7515b6567d9afba1f196fb4e2f4:

  Linux 6.5-rc4 (2023-07-30 13:23:47 -0700)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 2d297d20ace8c544bcc74a2ed5f3536add3a7a69:

  RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion (2023-08-13 09:25:10 +0300)

----------------------------------------------------------------
Patrisious Haddad (14):
      macsec: add functions to get macsec real netdevice and check offload
      net/mlx5e: Move MACsec flow steering operations to be used as core library
      net/mlx5: Remove dependency of macsec flow steering on ethernet
      net/mlx5e: Rename MACsec flow steering functions/parameters to suit core naming style
      net/mlx5e: Move MACsec flow steering and statistics database from ethernet to core
      net/mlx5: Remove netdevice from MACsec steering
      net/mlx5: Maintain fs_id xarray per MACsec device inside macsec steering
      RDMA/mlx5: Implement MACsec gid addition and deletion
      net/mlx5: Add MACsec priorities in RDMA namespaces
      IB/core: Reorder GID delete code for RoCE
      net/mlx5: Configure MACsec steering for egress RoCEv2 traffic
      net/mlx5: Configure MACsec steering for ingress RoCEv2 traffic
      net/mlx5: Add RoCE MACsec steering infrastructure in core
      RDMA/mlx5: Handles RoCE MACsec steering rules addition and deletion

 drivers/infiniband/core/cache.c                    |    6 +-
 drivers/infiniband/hw/mlx5/Makefile                |    1 +
 drivers/infiniband/hw/mlx5/macsec.c                |  364 +++
 drivers/infiniband/hw/mlx5/macsec.h                |   29 +
 drivers/infiniband/hw/mlx5/main.c                  |   41 +-
 drivers/infiniband/hw/mlx5/mlx5_ib.h               |   17 +
 drivers/net/ethernet/mellanox/mlx5/core/Kconfig    |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |    2 +-
 .../mellanox/mlx5/core/en_accel/en_accel.h         |    4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  |  176 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.h  |   26 +-
 .../mellanox/mlx5/core/en_accel/macsec_fs.c        | 1393 -----------
 .../mellanox/mlx5/core/en_accel/macsec_fs.h        |   47 -
 .../mellanox/mlx5/core/en_accel/macsec_stats.c     |   22 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |    2 +-
 drivers/net/ethernet/mellanox/mlx5/core/fs_cmd.c   |    1 +
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |   37 +-
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.c    | 2410 ++++++++++++++++++++
 .../ethernet/mellanox/mlx5/core/lib/macsec_fs.h    |   64 +
 drivers/net/macsec.c                               |   15 +
 include/linux/mlx5/device.h                        |    2 +
 include/linux/mlx5/driver.h                        |   51 +
 include/linux/mlx5/fs.h                            |    2 +
 include/linux/mlx5/macsec.h                        |   32 +
 include/net/macsec.h                               |    2 +
 26 files changed, 3121 insertions(+), 1629 deletions(-)
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.c
 create mode 100644 drivers/infiniband/hw/mlx5/macsec.h
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.c
 delete mode 100644 drivers/net/ethernet/mellanox/mlx5/core/en_accel/macsec_fs.h
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/macsec_fs.h
 create mode 100644 include/linux/mlx5/macsec.h

