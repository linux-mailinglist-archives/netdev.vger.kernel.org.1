Return-Path: <netdev+bounces-220639-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BBEEB47887
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 03:30:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1F96A201107
	for <lists+netdev@lfdr.de>; Sun,  7 Sep 2025 01:30:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A85A18DB2A;
	Sun,  7 Sep 2025 01:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bzrCcYt7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E07186284
	for <netdev@vger.kernel.org>; Sun,  7 Sep 2025 01:30:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757208616; cv=none; b=N7WlIQruqXGu7phe8U5tgp0q13AkCnIhOrvTK9+38b/Zd0i3TlgNQ2Rl0dKU5vmFQIYC+l3xzl8CisbKem9K7qHSsVp273cOxiWsF9I3nR8FFAGFHthb1bGLhprXfBDqU7IizIc8wdm6Ju5bBK41KpsuEIjZ/y49lMN3yOW8Ewk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757208616; c=relaxed/simple;
	bh=7ZhvTC1+B5Ys8I+6hUx9liKNLXA3bKtQmpvVlm9OQg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SI6vnwnO7bH2zoI0A51Nzhut/KXSmOTTYiP49smMI1OFRm7xnn8wNb+KnLxf5AkP8ZhapzAQQTpJbm0v8Vk5E8OU33JBIKQnMLVoZjYu19nqhMMTlyJ3ipXVhX47V1MBuFZ+F7J3GYosX/tOXUSNGTcIxjNszT0+k8NrWH69Gyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bzrCcYt7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91C2CC4CEE7;
	Sun,  7 Sep 2025 01:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1757208614;
	bh=7ZhvTC1+B5Ys8I+6hUx9liKNLXA3bKtQmpvVlm9OQg0=;
	h=From:To:Cc:Subject:Date:From;
	b=bzrCcYt7tU7oPzCysr7uEWj0ElRYR6uYKTc4/9ILUJe+ISDxVLWA1G5Pl4KmINOZ/
	 08zw9ACUO54WyIcIlnwyKAMK4zf/UDrI+VULSeFgrypd2AnquF+voKa8NravxXa9pR
	 paQZrBKaGygV9/8Y4c7IuJRbiifWioEQuIHIKZAxlNPcdmUGZazrLtd6AzreLowanC
	 GGLqR80Yfovwv4aB8jqBER6DVaABYVaBvO67sh+z6XIygUAjEHQREebOWCcDMdV7sV
	 tuyi+1FC4rkFla/2IXRKkLj6Y+CNsZJ58/hxiVv1R/556Q6cgItNyl49dDF6ZIfOjd
	 JBwLz3YRAIHng==
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
	Jiri Pirko <jiri@nvidia.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH V7 net-next 00/11] *devlink, mlx5: Add new parameters for link management and SRIOV/eSwitch configurations
Date: Sat,  6 Sep 2025 18:29:42 -0700
Message-ID: <20250907012953.301746-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This patch series introduces several devlink parameters improving device
configuration capabilities, link management, and SRIOV/eSwitch, by adding
NV config boot time parameters.

Userspace(v2): https://lore.kernel.org/netdev/20250704045427.1558605-1-saeed@kernel.org/

v6->v7:
 - Improve Documentation for patch #1 and #2, Jakub/JacobK.
 - Toss "Add 'keep_link_up' generic devlink device param" patch, Jakub.

v5->v6:
  - rebase was required - Simon.

v4->v5:
  - ./tools/net/ynl/ynl-regen.sh for patch #12
  - checkpatch issues

v3->v4:
  - Rebase and adapted to new enum variable typed attributes from Jiri:
    https://lore.kernel.org/netdev/20250505114513.53370-1-jiri@resnulli.us/

v2->v3:
 - ynl-gen: allow noncontiguous enums, Jakub
 - devlink.yaml: var-attr-type enum, Jakub

v1->v2:
 - Fix ynl-regen issue reported by Simon.
 - Fix smatch "could be null" warning reported by Dan Carpenter
 - Fix double include reported by Kernel test robot
 - Only allow per PF sriov setting - by Jiri
 - Add Reviewed-by Jiri and Tested-by Kamal.

Below is a summary of the key changes:

1) Enable support for devlink port parameters

2) Implement multi attribute devlink param value data, for u32 array
   type parameters

3) Implement the following parameters:

   3.a) total_vfs Parameter:
   -------------------------

Adds support for managing the number of VFs (total_vfs) and enabling
SR-IOV (enable_sriov for mlx5) through devlink. These additions enhance
user control over virtualization features directly from standard kernel
interfaces without relying on additional external tools. total_vfs
functionality is critical for environments that require flexible num VF
configuration.

   3.b) devlink keep_link_up Parameter:
   ------------------------------------

Introduces a new devlink parameter 'keep_link_up', allowing devices to
keep the link active even when the driver is not loaded. This
functionality is especially useful for maintaining link stability during
driver upgrades or reboots without dropping connectivity.

   3.c) eSwitch Hairpin per Priority Buffers:
   ------------------------------------------

Implements new devlink parameters to configure eSwitch hairpin per
priority buffers. These parameters provide granular control over how
packets are buffered for IEEE802.1p priorities, offering improved traffic
management and efficiency for specific priority levels.

   3.d) CQE Compression Type:
   --------------------------

Introduces a new devlink parameter, cqe_compress_type, to configure the
rate of CQE compression based on PCIe bus conditions. This setting
provides a balance between compression efficiency and overall NIC
performance under different traffic loads.

Detailed examples of usage for each parameter have been included in the
respective commits.

Thanks,
Saeed


Jiri Pirko (1):
  devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()

Saeed Mahameed (7):
  net/mlx5: Implement cqe_compress_type via devlink params
  devlink: Implement port params registration
  devlink: Implement get/dump netlink commands for port params
  devlink: Implement set netlink command for port params
  devlink: Throw extack messages on param value validation error
  devlink: Implement devlink param multi attribute nested data values
  net/mlx5: Implement eSwitch hairpin per prio buffers devlink params

Vlad Dumitrescu (3):
  devlink: Add 'total_vfs' generic device param
  net/mlx5: Implement devlink enable_sriov parameter
  net/mlx5: Implement devlink total_vfs parameter

 Documentation/netlink/specs/devlink.yaml      |  25 +-
 .../networking/devlink/devlink-params.rst     |   5 +
 Documentation/networking/devlink/mlx5.rst     |  61 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   8 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +
 .../mellanox/mlx5/core/lib/nv_param.c         | 859 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |  14 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  25 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |  25 +-
 net/devlink/param.c                           | 416 +++++++--
 net/devlink/port.c                            |   3 +
 14 files changed, 1362 insertions(+), 86 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h

-- 
2.51.0


