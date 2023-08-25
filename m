Return-Path: <netdev+bounces-30550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 16141787FE4
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 08:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2DDF81C20E73
	for <lists+netdev@lfdr.de>; Fri, 25 Aug 2023 06:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B24DC17EC;
	Fri, 25 Aug 2023 06:29:56 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1E417E8
	for <netdev@vger.kernel.org>; Fri, 25 Aug 2023 06:29:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB57C433C8;
	Fri, 25 Aug 2023 06:29:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1692944994;
	bh=6z8yiYVpuB5guW7VkAy41RS3vc2m5q6b+46xAxIi6e0=;
	h=From:To:Cc:Subject:Date:From;
	b=L5WdrroIJPTNmeZjeC6eYSrwagvwT+QUHg/JA7sbzNi8fYNAuh5hArq7KmFNXBvR+
	 QeWfxL9VZh1je7X9zLBQX78tMkB3MRDxu79bY1pgxM00u5g84iKmeQLMwP1GbMYqT5
	 3EEvhmSzTdkYs9H5v+6CaMdIQzJaz9acd/ITBa4/R4xmwzwH20NL0ZZzc5qxKz600f
	 Kd2UQQeTHgoKUP7ny4gcEW/4oyPyIDw6ZQ4wbkWoociH5+HSLFNEXXDrXomSVJWHQf
	 hSXFn6FwtC2Wz8P9GLAm7NQWAtKG4jD2RYaHs6xeOmOYFObEFL18B0CKfAUHE4/Had
	 qyEYrnOuQDDRg==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [PATCH net-next V4 0/8] {devlink,mlx5}: Add port function attributes for ipsec
Date: Thu, 24 Aug 2023 23:28:28 -0700
Message-ID: <20230825062836.103744-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v4:
 - Rebased on top of latest mlx5 changes, align with new code, fix build
   warnings

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
 .../mellanox/mlx5/core/eswitch_offloads.c     | 240 +++++++++---
 include/linux/mlx5/driver.h                   |   1 +
 include/linux/mlx5/mlx5_ifc.h                 |   3 +
 include/net/devlink.h                         |  30 ++
 include/uapi/linux/devlink.h                  |   4 +
 net/devlink/leftover.c                        | 104 +++++
 15 files changed, 898 insertions(+), 108 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec.c

-- 
2.41.0


