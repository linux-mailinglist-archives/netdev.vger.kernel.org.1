Return-Path: <netdev+bounces-203985-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FE05AF870C
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 06:59:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6ABF3AE716
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 04:59:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 973F31EF391;
	Fri,  4 Jul 2025 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hVhGcLNY"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70FD472612
	for <netdev@vger.kernel.org>; Fri,  4 Jul 2025 04:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751605193; cv=none; b=KP2U5XeHpKQj9xd6viQIdjj2bUdeqB25aW+cWfux3jQ3QnA5OwmvWtJEoUlv8QOHyGCb68gbRL1fzZZtAqiCrP2HN9jKIs9wvuh4l+tHnktIo0jnAQAmEFi2Ta/uUuL+JrFemsiIf7VfWQ1PodaysaWPjQzu5ATJco8M0xYt9Y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751605193; c=relaxed/simple;
	bh=08LeVO3Q6/omJ69SdBcth2KNVcCeZnVcjlEMNmU5hAs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Mf8aSFUE8jwrpTG/GAJjfNXv7CLMTYYoKbzZsy/20oe6688lp1kH3wv6W/uryzJmRKsbf2vDzJ9NlvBApACwFmtY9vKURD/ER65tvwHF3ErLGtSKjCJGk3+9ZjjWSOWElclt7DeonwzLeYh4OMDjFkJkOgIc3G+ZmDuQhjpk5DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hVhGcLNY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA3C6C4CEE3;
	Fri,  4 Jul 2025 04:59:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751605193;
	bh=08LeVO3Q6/omJ69SdBcth2KNVcCeZnVcjlEMNmU5hAs=;
	h=From:To:Cc:Subject:Date:From;
	b=hVhGcLNYee7F1ATjg0LsltCA4M5fnf6RVOQS7/zQDA9WyOELCyEofmVPxe0h3v7d3
	 UcESsBeE6aoJ1xthPsLHpI4OI/l4IxTdNMb9RMSsxfKbU+g0ulIyWq3jAiSkRFh2BX
	 ZJ8rJBZ77w6Fev8qKbaV255/9PReBQ6PmaUr6pUUxRd5PwU0TvnM/SIUI4B19scAux
	 87JngsO8tJ0BmTEpv3GayS0J8bbAdb8JT5iP2dH/vXoQdjlhAMYDQGLoQvQ9l8l3Vl
	 7svBxg9DunobUv9Y+FRSnAj85+kA16TgUsEpFwQ2c2InO8bEFO2sXkcD6Sq76v0lrv
	 H2WYJGr3dJ9Eg==
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
Subject: [PATCH net-next V4 00/13] devlink, mlx5: Add new parameters for link management and SRIOV/eSwitch configurations
Date: Thu,  3 Jul 2025 21:59:32 -0700
Message-ID: <20250704045945.1564138-1-saeed@kernel.org>
X-Mailer: git-send-email 2.50.0
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

Jiri Pirko (1):
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

 Documentation/netlink/specs/devlink.yaml      |   22 +-
 .../networking/devlink/devlink-params.rst     |    7 +
 Documentation/networking/devlink/mlx5.rst     |   65 +-
 .../net/ethernet/mellanox/mlx5/core/Makefile  |    2 +-
 .../net/ethernet/mellanox/mlx5/core/devlink.c |    8 +
 .../net/ethernet/mellanox/mlx5/core/devlink.h |    3 +
 .../ethernet/mellanox/mlx5/core/en/devlink.c  |   17 +-
 .../ethernet/mellanox/mlx5/core/en/devlink.h  |    3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |    4 +-
 .../mellanox/mlx5/core/lib/nv_param.c         | 1001 +++++++++++++++++
 .../mellanox/mlx5/core/lib/nv_param.h         |   18 +
 include/linux/mlx5/driver.h                   |    1 +
 include/net/devlink.h                         |   30 +
 include/uapi/linux/devlink.h                  |    1 +
 net/devlink/netlink_gen.c                     |   25 +-
 net/devlink/param.c                           |  412 +++++--
 net/devlink/port.c                            |    3 +
 17 files changed, 1532 insertions(+), 90 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/nv_param.h

-- 
2.50.0


