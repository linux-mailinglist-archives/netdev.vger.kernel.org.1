Return-Path: <netdev+bounces-28358-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E00577F2D2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 11:12:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7ABE82816D2
	for <lists+netdev@lfdr.de>; Thu, 17 Aug 2023 09:12:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23D7110950;
	Thu, 17 Aug 2023 09:12:17 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B078EDDAB
	for <netdev@vger.kernel.org>; Thu, 17 Aug 2023 09:12:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49897C433C8;
	Thu, 17 Aug 2023 09:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692263534;
	bh=DLoyjbNkUwEQs6ep3zBlQrrq0CYWr45RAZu4SBmHcbk=;
	h=From:To:Cc:Subject:Date:From;
	b=EpYNUZytcscVjRlQBSwGDHn5tDuv4Q+wvNBjaF4hMmrpoV1VOOVDAk2wow5v2thZ0
	 MqE9HxYHDkVpH1ZGXAF0gYvqqnXlNOr5AbbAKbX7H869/4p/y2oJs7IEJHb6EKmrID
	 S0PkPA1P0QGTsyffPPiB8VLXnZi6d5JYPuo8tQW1k6Xev13rr29+E5NJBIk22Fj8nq
	 ul7ha773CXVYT0t08z4SMIF6U2wuP8tkPK7CFT1ZAJAtmfIqM6LF1Nh1norkG3yyDq
	 fDaNxyZu7FKCjFsJB49AR+U6VNnDdM5SYCeXHuVEiQ8hp8j9wrqjOm7daDVxhabpUY
	 RKZiSwLR1EJ4Q==
From: Leon Romanovsky <leon@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Dima Chumak <dchumak@nvidia.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Jonathan Corbet <corbet@lwn.net>,
	linux-doc@vger.kernel.org,
	netdev@vger.kernel.org,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v3 0/8] devlink: Add port function attributes
Date: Thu, 17 Aug 2023 12:11:22 +0300
Message-ID: <cover.1692262560.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

v3:
 - Changed newly introduced IPsec blocking routine
   and as an outcome of testing already existing one.
   I'm sending them together to avoid merge conflicts.
 - Refactored patches to separate IFC part
 - Simplified 
v2: https://lore.kernel.org/netdev/20230421104901.897946-1-dchumak@nvidia.com/
 - Improve docs of ipsec_crypto vs ipsec_packet devlink attributes
 - also see patches 2,4 for the changelog.

---------------------------------------------------------------------------------
From Dima:

Introduce hypervisor-level control knobs to set the functionality of PCI
VF devices passed through to guests. The administrator of a hypervisor
host may choose to change the settings of a port function from the
defaults configured by the device firmware.

The software stack has two types of IPsec offload - crypto and packet.
Specifically, the ip xfrm command has sub-commands for "state" and
"policy" that have an "offload" parameter. With ip xfrm state, both
crypto and packet offload types are supported, while ip xfrm policy can
only be offloaded in packet mode.

The series introduces two new boolean attributes of a port function:
ipsec_crypto and ipsec_packet. The goal is to provide a similar level of
granularity for controlling VF IPsec offload capabilities, which would
be aligned with the software model. This will allow users to decide if
they want both types of offload enabled for a VF, just one of them, or
none at all (which is the default).

At a high level, the difference between the two knobs is that with
ipsec_crypto, only XFRM state can be offloaded. Specifically, only the
crypto operation (Encrypt/Decrypt) is offloaded. With ipsec_packet, both
XFRM state and policy can be offloaded. Furthermore, in addition to
crypto operation offload, IPsec encapsulation is also offloaded. For
XFRM state, choosing between crypto and packet offload types is
possible. From the HW perspective, different resources may be required
for each offload type.

Examples of when a user prefers to enable IPsec packet offload for a VF
when using switchdev mode:

  $ devlink port show pci/0000:06:00.0/1
      pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
          function:
          hw_addr 00:00:00:00:00:00 roce enable migratable disable ipsec_crypto disable ipsec_packet disable

  $ devlink port function set pci/0000:06:00.0/1 ipsec_packet enable

  $ devlink port show pci/0000:06:00.0/1
      pci/0000:06:00.0/1: type eth netdev enp6s0pf0vf0 flavour pcivf pfnum 0 vfnum 0
          function:
          hw_addr 00:00:00:00:00:00 roce enable migratable disable ipsec_crypto disable ipsec_packet enable

This enables the corresponding IPsec capability of the function before
it's enumerated, so when the driver reads the capability from the device
firmware, it is enabled. The driver is then able to configure
corresponding features and ops of the VF net device to support IPsec
state and policy offloading.

Thanks

Dima Chumak (4):
  devlink: Expose port function commands to control IPsec crypto
    offloads
  devlink: Expose port function commands to control IPsec packet
    offloads
  net/mlx5: Implement devlink port function cmds to control ipsec_crypto
  net/mlx5: Implement devlink port function cmds to control ipsec_packet

Leon Romanovsky (4):
  net/mlx5: Drop extra layer of locks in IPsec
  net/mlx5e: Rewrite IPsec vs. TC block interface
  net/mlx5: Add IFC bits to support IPsec enable/disable
  net/mlx5: Provide an interface to block change of IPsec capabilities

 .../ethernet/mellanox/mlx5/switchdev.rst      |  20 +
 .../networking/devlink/devlink-port.rst       |  55 +++
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |  20 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    |  63 ++-
 .../mellanox/mlx5/core/esw/devlink_port.c     |   6 +
 .../ethernet/mellanox/mlx5/core/esw/ipsec.c   | 369 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |  41 ++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  48 ++-
 .../mellanox/mlx5/core/eswitch_offloads.c     | 259 +++++++++---
 include/linux/mlx5/driver.h                   |   1 +
 include/linux/mlx5/mlx5_ifc.h                 |   3 +
 include/net/devlink.h                         |  30 ++
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/leftover.c                        | 104 +++++
 15 files changed, 917 insertions(+), 108 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c

-- 
2.41.0


