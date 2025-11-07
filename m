Return-Path: <netdev+bounces-236550-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFC1C3DF23
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 01:09:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA50A3AF2D8
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 00:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD96C1DDC33;
	Fri,  7 Nov 2025 00:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qPVy953p"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89AB71DA61B
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 00:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762474147; cv=none; b=E1KmGse54Wfl0NnvR/qxYWIr4O21la5vXjFunc6SX1tTUSoSLkBpCOTh7kQ77yqsywEc0FGd67yXfe3q/xD+hwgqW2sTbXQgS1G1DNQ0F33gavu9nBxRHRpEbWs37mVMvkIoKpCyFBPvTAjIxvMbeeig4YW402wm4SYOTHIMzuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762474147; c=relaxed/simple;
	bh=7Lf1HKuzM8jTLEwL0wDVgoNMHjOWjp4U41beFLcA96E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EYqflIZJslJYDjeKttKcdKn040erRDBIc4ApxFYsUBZjtLhiX4LnHs6xkYCxsnWWJxVhJEx4Opv4WOfUYEaZXmyk3VCQfWB5VSE1f8Wa+hFzBC8jfmb/MNliO8zxL/wjDYk2/WsZrbvtNHXInzAeTMI0VAIpHym6BYDagBwlISk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qPVy953p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076E5C4CEFB;
	Fri,  7 Nov 2025 00:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762474146;
	bh=7Lf1HKuzM8jTLEwL0wDVgoNMHjOWjp4U41beFLcA96E=;
	h=From:To:Cc:Subject:Date:From;
	b=qPVy953pFw+TmHdYhDc/aDhG1fhsU0pzMBRI+ynW3IK7R4CgbMnH3TyqMr37VyKNx
	 nqbCZYmhk00tBqqoGWsAfELbPzRL/odw7HfJhSrRV1qfwfbv73vnGEsdy+U8vFgyI7
	 p5oQ/RJMqQsdzQCuS3JwbvnnM25F8MtE2KVC6t0TFaHUi4gpkeAA3lyE7BSdr8qTuA
	 VQIh33zOpOMZEFkB+sb5vVp6JmIvMsi7LJxKteGjHOo2d/t0tlH3vSsBgNAyZEBAJE
	 QcphhABl85e1baV+ZIag5n5wfqfSDYCbvg/R3OVSOmmzoJEXGUu2dXjrlv0gvAiJ7Q
	 KTchw9rpWzw8A==
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
	mbloch@nvidia.com
Subject: [PATCH net-next V2 0/3] devlink eswitch inactive mode
Date: Thu,  6 Nov 2025 16:08:28 -0800
Message-ID: <20251107000831.157375-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v1->v2:
  - Introduce new devlink mode instead of state, Jiri's suggestion.
  - Address kernel robot issues reported in v1.
      no previous prototype for 'mlx5_mpfs_enable'

v1: https://lore.kernel.org/all/20251016013618.2030940-1-saeed@kernel.org/

Before having traffic flow through an eswitch, a user may want to have the
ability to block traffic towards the FDB until FDB is fully programmed and the
user is ready to send traffic to it. For example: when two eswitches are present
for vports in a multi-PF setup, one eswitch may take over the traffic from the
other when the user chooses. Before this take over, a user may want to first
program the inactive eswitch and then once ready redirect traffic to this new
eswitch.

This series introduces a user-configurable mode for an eswitch that allows
dynamically switching between active and inactive modes. When inactive, traffic
does not flow through the eswitch. While inactive, steering pipeline
configuration can be done (e.g. adding TC rules, discovering representors,
enabling the desired SDN modes such as bridge/OVS/DPDK/etc). Once configuration
is completed, a user can set the eswitch mode to active and have traffic flow
through. This allows admins to upgrade forwarding pipeline rules with very
minimal downtime and packet drops.

A user can start the eswitch in switchdev or switchdev_inactive mode.

Active: Traffic is enabled on this eswitch FDB.
Inactive: Traffic is ignored/dropped on this eswitch FDB.

An example use case:
$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev_inactive
Setup FDB pipeline and netdev representors
...
Once ready to start receiving traffic
$ devlink dev eswitch set pci/0000:08:00.1 mode switchdev

Saeed Mahameed (3):
  devlink: Introduce switchdev_inactive eswitch mode
  net/mlx5: MPFS, add support for dynamic enable/disable
  net/mlx5: E-Switch, support eswitch inactive mode

 Documentation/netlink/specs/devlink.yaml      |   2 +
 .../devlink/devlink-eswitch-attr.rst          |  13 ++
 .../mellanox/mlx5/core/esw/adj_vport.c        |  15 +-
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |   6 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 194 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   5 +
 .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 115 +++++++++--
 .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 +
 include/linux/mlx5/fs.h                       |   1 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |   2 +-
 11 files changed, 325 insertions(+), 38 deletions(-)

-- 
2.51.1


