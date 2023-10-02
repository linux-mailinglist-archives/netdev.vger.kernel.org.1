Return-Path: <netdev+bounces-37326-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B53CE7B4D5A
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 10:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by ny.mirrors.kernel.org (Postfix) with ESMTP id 837EC1C204E8
	for <lists+netdev@lfdr.de>; Mon,  2 Oct 2023 08:38:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9C9F1361;
	Mon,  2 Oct 2023 08:38:42 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7600A20
	for <netdev@vger.kernel.org>; Mon,  2 Oct 2023 08:38:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C461C433C8;
	Mon,  2 Oct 2023 08:38:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1696235922;
	bh=QKQIHWTbgfLpyj+Ika035PQ5df3XDSAH9fgVzXKccQk=;
	h=From:To:Cc:Subject:Date:From;
	b=JPgX4GRrUTebAwufvkvpxXJeH4R2XA+mmWd4wcWmZCFqY1MniCoL+Qewm+pIuscUZ
	 li5sl2E8Ebl5mrcaEzI6+e8syPHPdFmdvZGcJvX7F+fTeaNdJLDujKLtjT37IpxetY
	 LJKk/QLvyeMmuWH4vTiogJo9B8MsGlYGQCqYaxQuSElNjByjdVZqN953VN9rQ/LUbQ
	 Yda0uWWIWxJVf8tICq/toqFEUbThXtXib4hNsMcy4g111MzWkGZHllhZ41JPH0j5lg
	 yKBtDQ/U0/MU09Z/jIgtxbpsp0GyogG37dyAU4HrfTrXJ+pvDrENeLTGF7RQEmYMe2
	 N9u2qVranXAPw==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <horms@kernel.org>
Subject: [GIT PULL] Please pull IPsec packet offload support in multiport RoCE devices
Date: Mon,  2 Oct 2023 11:38:31 +0300
Message-ID: <20231002083832.19746-1-leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

This PR is collected from https://lore.kernel.org/all/cover.1695296682.git.leon@kernel.org

This series from Patrisious extends mlx5 to support IPsec packet offload
in multiport devices (MPV, see [1] for more details).

These devices have single flow steering logic and two netdev interfaces,
which require extra logic to manage IPsec configurations as they performed
on netdevs.

Thanks

[1] https://lore.kernel.org/linux-rdma/20180104152544.28919-1-leon@kernel.org/

----------------------------------------------------------------
Conflict notice:
when merged into net-next, this series will cause a conflict in file:
include/linux/mlx5/device.h

diff --cc include/linux/mlx5/device.h
index 8fbe22de16ef,26333d602a50..000000000000
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@@ -366,7 -366,8 +366,12 @@@ enum mlx5_driver_event
        MLX5_DRIVER_EVENT_UPLINK_NETDEV,
        MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
        MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
++<<<<<<< HEAD
 +      MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
++=======
+       MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+       MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
++>>>>>>> mlx5-next
  };

as a resolution, please take both chunks:

diff --cc include/linux/mlx5/device.h
index 8fbe22de16ef,26333d602a50..000000000000
--- a/include/linux/mlx5/device.h
+++ b/include/linux/mlx5/device.h
@@@ -366,7 -366,8 +366,12 @@@ enum mlx5_driver_event 
        MLX5_DRIVER_EVENT_UPLINK_NETDEV,
        MLX5_DRIVER_EVENT_MACSEC_SA_ADDED,
        MLX5_DRIVER_EVENT_MACSEC_SA_DELETED,
 +      MLX5_DRIVER_EVENT_SF_PEER_DEVLINK,
+       MLX5_DRIVER_EVENT_AFFILIATION_DONE,
+       MLX5_DRIVER_EVENT_AFFILIATION_REMOVED,
  };
  
Thanks

----------------------------------------------------------------
The following changes since commit 6581da706473073066e45b8fc4913f61c2bf6e05:

  Merge branch 'mlx5-vfio' into mlx5-next (2023-09-28 21:43:11 +0300)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mellanox/linux.git mlx5-next

for you to fetch changes up to 82f9378c443c206d3f9e45844306e5270e7e4109:

  net/mlx5: Handle IPsec steering upon master unbind/bind (2023-10-02 11:22:22 +0300)

----------------------------------------------------------------
Patrisious Haddad (9):
      RDMA/mlx5: Send events from IB driver about device affiliation state
      net/mlx5: Register mlx5e priv to devcom in MPV mode
      net/mlx5: Store devcom pointer inside IPsec RoCE
      net/mlx5: Add alias flow table bits
      net/mlx5: Implement alias object allow and create functions
      net/mlx5: Add create alias flow table function to ipsec roce
      net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
      net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
      net/mlx5: Handle IPsec steering upon master unbind/bind

 drivers/infiniband/hw/mlx5/main.c                  |  17 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c      |  70 +++
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   8 +
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |   3 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 122 ++++-
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  63 +++
 drivers/net/ethernet/mellanox/mlx5/core/fs_core.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 +
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c         | 542 ++++++++++++++++++++-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h         |  14 +-
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |   6 +
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  22 +
 include/linux/mlx5/device.h                        |   2 +
 include/linux/mlx5/driver.h                        |   2 +
 include/linux/mlx5/mlx5_ifc.h                      |  56 ++-
 17 files changed, 925 insertions(+), 41 deletions(-)

