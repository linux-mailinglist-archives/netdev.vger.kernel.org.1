Return-Path: <netdev+bounces-182449-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CAD22A88C91
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 22:00:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EB7603B2F9F
	for <lists+netdev@lfdr.de>; Mon, 14 Apr 2025 20:00:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DEB9A1DB346;
	Mon, 14 Apr 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RF3rXCJb"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8FE21DACB8
	for <netdev@vger.kernel.org>; Mon, 14 Apr 2025 20:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744660815; cv=none; b=YBF8cGmPMtBotoGfOli7EqULXOq3qGG0lPzzhdpGRUl4o81nesT9GPgVwQ4BoJKCoybcH3m92OE07P40sb8LScn4FeCGDBqghRRQ2lGBtno/9BjGF9pzgCtURF8ntLqeSZ1aHlqVid42r6208tkSMjdlo/PbKICPfwSfxE5Hn7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744660815; c=relaxed/simple;
	bh=Mek1INWRZS3vo5B2ZViU4WxNw24o63BRc7kH/MxYkdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cW62fD+OaotshcG5ya7c2zVXWrrmOhLkpFQQELAmQBu5JEEppjxfPwdDAcefkb+u3xJ+p5GCEXz3EUiaCEeLGHMKYQL8OEmsuWG+DDyJfyTbpy3VAtZ5yqciC7Yc0sFvXWQohKnOrfaWQAjPr/TiOyUJP5zmifzp6Drk6NHpC9o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RF3rXCJb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B81CC4CEE2;
	Mon, 14 Apr 2025 20:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744660815;
	bh=Mek1INWRZS3vo5B2ZViU4WxNw24o63BRc7kH/MxYkdc=;
	h=From:To:Cc:Subject:Date:From;
	b=RF3rXCJbQUjzpdaN3+ny2PTnxtjj9M4fhIlvz+hn5bCponGdJtUsR41waTMqpUt0R
	 hqaQrDHFFoPxX/ClEFRYXOFjzvEuzVY2S0z71FfAGcvfy3qJWabbFVxxf9Xr/FQL3W
	 YhH/KHF9L9gNgW2whKvtqcQUMmXH7+C9VFYmdIQcbNM/aYBbYHX18umTTybj1tBp9m
	 r+HrMrBgjAKG3YS9kvwpy4jIiJRBXaHMNia+/AcwffHptycGNNX/fs2HhEAdFwXjKq
	 IdSCouW3lbdhwRTVi6nIjsNoEkIvWXCFKt8rWUjfRagDJReShZCuANYQlgnuP/CKNz
	 bt+xRTNG9KYjQ==
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
Subject: [PATCH net-next V2 00/14] devlink, mlx5: Add new parameters for link management and SRIOV/eSwitch configurations
Date: Mon, 14 Apr 2025 12:59:45 -0700
Message-ID: <20250414195959.1375031-1-saeed@kernel.org>
X-Mailer: git-send-email 2.49.0
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

Userspace: https://patchwork.kernel.org/project/netdevbpf/cover/20250228021837.880041-1-saeed@kernel.org/

v1->v2:
 - Fix ynl-regen issue reported by Simon.
 - Fix smatch "could be null" warning reported by Dan Carpenter
 - Fix double include reported by Kernel test robot
 - Only allow per PF sriov setting - by Jiri
 - Add Reviewd-by Jiri and Tested-by Kamal.

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

Jiri Pirko (2):
  devlink: define enum for attr types of dynamic attributes
  devlink: pass struct devlink_port * as arg to devlink_nl_param_fill()

Saeed Mahameed (9):
  net/mlx5: Implement cqe_compress_type via devlink params
  devlink: Implement port params registration
  devlink: Implement get/dump netlink commands for port params
  devlink: Implement set netlink command for port params
  devlink: Add 'keep_link_up' generic devlink device param
  net/mlx5: Implement devlink keep_link_up port parameter
  devlink: Throw extack messages on param value validation error
  devlink: Implement devlink param multi attribute nested data values
  net/mlx5: Implement eSwitch hairpin per prio buffers devlink params

Vlad Dumitrescu (3):
  devlink: Add 'total_vfs' generic device param
  net/mlx5: Implement devlink enable_sriov parameter
  net/mlx5: Implement devlink total_vfs parameter

 Documentation/netlink/specs/devlink.yaml      |  44 +-
 .../networking/devlink/devlink-params.rst     |   7 +
 Documentation/networking/devlink/mlx5.rst     |  65 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   8 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |  16 +-
 .../ethernet/mellanox/mlx5/core/en/devlink.h  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 956 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |  16 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  30 +
 include/uapi/linux/devlink.h                  |  18 +
 net/devlink/health.c                          |  17 +-
 net/devlink/netlink_gen.c                     |  23 +-
 net/devlink/param.c                           | 444 ++++++--
 net/devlink/port.c                            |   3 +
 18 files changed, 1553 insertions(+), 107 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h

-- 
2.49.0


