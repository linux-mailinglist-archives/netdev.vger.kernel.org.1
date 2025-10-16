Return-Path: <netdev+bounces-229842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5918BBE12CF
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 03:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DEE373E1DBC
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 01:36:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DCE9126C05;
	Thu, 16 Oct 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KdAHSOc4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AB24A21
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 01:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578616; cv=none; b=S3LCl2gS0jo4o8Tp09uSgggssA6BHEOzSAzklwVfsJ0VPWZ3fPPJV7pZExnPcPmoqxSfXYxDNVhk4tQGV0JntOPqczuBwg35zs2qIvpc6rYpCUkJjwJxVzGgpy1ITuWmUo1F0J7GWLNoOrQBFsa8yl9kZKvNtD5bHGaNwJUw4Ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578616; c=relaxed/simple;
	bh=dYpYXvDhqaAEBX3H3pX558cYiZEZ7Qqdy1cBPHA4Sns=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YzO15jpEzLeo0oFtzXjNJnFTtebYCl1TbnH8BSKMSOFs291Hqr33K4VSxsk1J0kYCXkOgp3MkrLirmC3gJf8g/73gJGpps7EGxTeiL/VO/1iQ444P6njfOM3N1ebWDimuAaSSJyUkhqGZhQsHGrkwrNCq9YTSPce4KcohJKRGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KdAHSOc4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA14C4CEF8;
	Thu, 16 Oct 2025 01:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760578615;
	bh=dYpYXvDhqaAEBX3H3pX558cYiZEZ7Qqdy1cBPHA4Sns=;
	h=From:To:Cc:Subject:Date:From;
	b=KdAHSOc4JmUIY/ib2PSsIQP+o2z8scjmLCiIPQEIzHHQTcLSY5AzNG2Xa4kkgV3Ch
	 OKTGA38oImtop0BtIkVkaXTsIkYSGBRp5fvcW7Ikr231U+YTH1rFu7gksI3n1QQoCl
	 Krh+FczcPMGpX16CgdbOn8RmNy1Tqo5LVml1g2LEhSbPHG9YLJzjtZCyP6MrnOrDV+
	 SHkICGDF4eY0wRIS2TaMB56rnomwQR3Rlqw0yhXdAFGxvJ/ReDUiqmOi4LOZvl7mdF
	 c5BBMOKcDdKrADmwfESkexc/XlcxsbdLgDmxyidfS/HSV6V5Rt/5C6YGXK2B+jERFM
	 8kpE/bocJzaHA==
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
	mbloch@nvidia.com,
	Adithya Jayachandran <ajayachandra@nvidia.com>,
	Jiri Pirko <jiri@nvidia.com>
Subject: [PATCH net-next 0/3] devlink eswitch active/inactive state
Date: Wed, 15 Oct 2025 18:36:15 -0700
Message-ID: <20251016013618.2030940-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Before having traffic flow through an eswitch, a user may want to have the
ability to block traffic towards the FDB until FDB is fully programmed and the
user is ready to send traffic to it. For example: when two eswitches are present
for vports in a multi-PF setup, one eswitch may take over the traffic from the
other when the user chooses. Before this take over, a user may want to first
program the inactive eswitch and then once ready redirect traffic to this new
eswitch.

This series introduces a user-configurable states for an eswitch that allows
dynamically switching between active and inactive states. When inactive, traffic
does not flow through the eswitch. While inactive, steering pipeline
configuration can be done (e.g. adding TC rules, discovering representors,
enabling the desired SDN modes such as bridge/OVS/DPDK/etc). Once configuration
is completed, a user can set the eswitch state to active and have traffic flow
through. This allows admins to upgrade forwarding pipeline rules with very
minimal downtime and packet drops.

A user can start the eswitch in switchdev mode in either active or inactive
state. To preserve backwards compatibility, the default state is active.

Active: Traffic is enabled on this eswitch FDB.
Inactive: Traffic is ignored/dropped on this eswitch FDB.

An example of starting the switch in active state is following.
  1. Default is active (backward compatible)
$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev

  2. Explicitly set the state
$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev state active

To bring up the esw in 'inactive' state:

$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev state inactive

When querying the eswitch, we also see the state of it:

$ devlink dev eswitch show pci/0000:01:01.0
pci/0000:01:01.0: mode switchdev inline-mode none encap-mode basic state inactive

Signed-off-by: Saeed Mahameed <saeedm@nvidia.com>
Signed-off-by: Adithya Jayachandran <ajayachandra@nvidia.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>

Parav Pandit (1):
  devlink: Introduce devlink eswitch state

Saeed Mahameed (2):
  net/mlx5: MPFS, add support for dynamic enable/disable
  net/mlx5: E-Switch, support eswitch state

 Documentation/netlink/specs/devlink.yaml      |  13 ++
 .../devlink/devlink-eswitch-attr.rst          |  15 ++
 .../net/ethernet/mellanox/mlx5/core/devlink.c |   2 +
 .../mellanox/mlx5/core/esw/adj_vport.c        |  15 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.c |   1 +
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  12 ++
 .../mellanox/mlx5/core/eswitch_offloads.c     | 157 ++++++++++++++++++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   5 +
 .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 111 +++++++++++--
 .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 +
 include/linux/mlx5/fs.h                       |   1 +
 include/net/devlink.h                         |   5 +
 include/uapi/linux/devlink.h                  |   7 +
 net/devlink/dev.c                             |  30 ++++
 net/devlink/netlink_gen.c                     |   5 +-
 15 files changed, 358 insertions(+), 30 deletions(-)

-- 
2.51.0


