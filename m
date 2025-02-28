Return-Path: <netdev+bounces-170502-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6359FA48E58
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 03:13:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6EE5816DE8D
	for <lists+netdev@lfdr.de>; Fri, 28 Feb 2025 02:13:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C2AD457C93;
	Fri, 28 Feb 2025 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aKsXwdtP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F316125B2
	for <netdev@vger.kernel.org>; Fri, 28 Feb 2025 02:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740708805; cv=none; b=B2HOkvX3YoifC7RSu6ABUgtlagVYIc6NPwGien/K2CfnhIRlZNwb3Y7lTWShEMqYfZcwDkPtx6yem3hXCLdlFap7tqz3JlwhfXTLVPWeToAPN+3mAsikA3ca4zEAnpB4GRrzpuRxhKkpMUJfvO5DcPKsLRpxptadMpgaEVz88QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740708805; c=relaxed/simple;
	bh=lzn+mL+BZsADTYp5RGr6lGD0ewwELQ2WyLSixbX1Cmg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Pkv1FS3XhvaaaewXYCAPILPuBnRD/vI1thlgCwZxCj2719YPUoI+XGl/5QtoM/s8dZUikhBTULDJPYiSrj/U0b1DzqCyGtkIck9ZIdxJzWbkIK30Lt1EoJ4bhsosCGfPArAXArjBGA9DE9vA/pjfBpBVJ0KTdMtiq7FMnU/BB1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aKsXwdtP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1674BC4CEDD;
	Fri, 28 Feb 2025 02:13:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740708805;
	bh=lzn+mL+BZsADTYp5RGr6lGD0ewwELQ2WyLSixbX1Cmg=;
	h=From:To:Cc:Subject:Date:From;
	b=aKsXwdtPx8Za9Ctxy7zZF4V1czKmGj3BPIhuOQLgn6I51gJU6vV6y89C6rEDjJUYI
	 Qj87Oa88Vfk5mR5rxgL+zl9RlQyztb5wKEUh8Utxo+GNpSWn4RVyCxoxTuH38YD4yK
	 I2TlYshoLSSr9xu/aA/B5k9ZZ3cb+tGV6OT7PtwK9d6fykjqfmsYuaNOCgdrvD5FVa
	 NoIRhdnlEXSFabzUJBIsUVBn3oqqVPQ3m0PxpcAFi0HIkp4qz+1lIDCdqirkkdMzHx
	 rvnhyaV3Sb62qwo/Ow7C4mEezvV2TOtNARGH1uiyP9T2EzecWBTATEp3Pwt1+xtOWi
	 NYcMdxiWOHwNA==
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
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 00/14] devlink, mlx5: Add new parameters for link management and SRIOV/eSwitch configurations
Date: Thu, 27 Feb 2025 18:12:13 -0800
Message-ID: <20250228021227.871993-1-saeed@kernel.org>
X-Mailer: git-send-email 2.48.1
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

 Documentation/netlink/specs/devlink.yaml      |  45 +-
 .../networking/devlink/devlink-params.rst     |   7 +
 Documentation/networking/devlink/mlx5.rst     |  65 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |   2 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   9 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |   3 +
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |  16 +-
 .../ethernet/mellanox/mlx5/core/en/devlink.h  |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |   4 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 944 ++++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |  16 +
 include/linux/mlx5/driver.h                   |   1 +
 include/net/devlink.h                         |  30 +
 include/uapi/linux/devlink.h                  |  18 +
 net/devlink/health.c                          |  17 +-
 net/devlink/netlink_gen.c                     |  23 +-
 net/devlink/param.c                           | 437 ++++++--
 net/devlink/port.c                            |   3 +
 18 files changed, 1536 insertions(+), 107 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h

-- 
2.48.1


