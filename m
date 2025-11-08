Return-Path: <netdev+bounces-236969-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D4E6C428AB
	for <lists+netdev@lfdr.de>; Sat, 08 Nov 2025 08:04:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 526E83ADD75
	for <lists+netdev@lfdr.de>; Sat,  8 Nov 2025 07:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D810427877D;
	Sat,  8 Nov 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n+A6YENe"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0FA13D6F
	for <netdev@vger.kernel.org>; Sat,  8 Nov 2025 07:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762585470; cv=none; b=aFbAGGaOU6oZsPFR5W3EToKz4YJ4Yb3QLoTxawWNsKE+wy3ReuYpR0smK24EFdXTwt1gg7ta3vY+Ktll6YQjBWIaVm9YW1RqPCBM9BGfC+Mfp0qJVFKcnZggfJobDJVSOC8OY7z29mLb0uVQb+k/QTi2ZzV72ocpDAT0wUfUx8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762585470; c=relaxed/simple;
	bh=FDld2LClMpbOOLMGgiOdO+XthaJfZu3U3U52gVVDz/k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Zm17TxUmzQrxuSl4AazRHU9aFodefXi7UcQrFKmSj6KbD+Z027ptEvb/22SJVl1QQAk6D1i6Auzrbpkk5wlRWxthBmN/ZCippvICVrZprEaSjvS400x+0dre1YQdCMkghJwYBkCIDmfHOkiExemKAEY6enY1cfhvwBHDgXNaFEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n+A6YENe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 209CEC4CEF7;
	Sat,  8 Nov 2025 07:04:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762585470;
	bh=FDld2LClMpbOOLMGgiOdO+XthaJfZu3U3U52gVVDz/k=;
	h=From:To:Cc:Subject:Date:From;
	b=n+A6YENetwRG2JdeTuLkbnymIyjKAdSieQJYvS/WwdkFF6QeKLQnTmz4s078pRxWl
	 iyFcM1LvT9cBKz34LRmlm5LdD2tlrN7qY/u+Qlf1fOxgAS068VG53H3XMBLwr/+QA6
	 nSCkJURqYhC0vA8Pdg73qBUBLB1G4NiIBJ2LNGcJQ6IrF3jVjMWPq0qF0K7jYXqzXp
	 E+vWEUUAn3od8FsjKpkfcFolgZSEVZhnWXxOLS6WiTYQIQHFGhPpBPePqEVvFzNZQ9
	 dAyXdnbmsuQHrXw8hG7wlWOa/lLRdMiB8n9SR9wclLWMkoIIWth2MGL35EGnt96+lf
	 TPL13lMLKqwQw==
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
Subject: [PATCH net-next V3 0/3] devlink eswitch inactive mode
Date: Fri,  7 Nov 2025 23:04:01 -0800
Message-ID: <20251108070404.1551708-1-saeed@kernel.org>
X-Mailer: git-send-email 2.51.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

v2->v3:
  - Fix cocci check %pe
  - minor improvement: create FDB drop counter once.

v1->v2:
  - Introduce new devlink mode instead of state, Jiri's suggestion.
  - Address kernel robot issues reported in v1.
      no previous prototype for 'mlx5_mpfs_enable'

v2: https://lore.kernel.org/all/20251107000831.157375-1-saeed@kernel.org/
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
 .../mellanox/mlx5/core/eswitch_offloads.c     | 207 +++++++++++++++++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |   5 +
 .../ethernet/mellanox/mlx5/core/lib/mpfs.c    | 116 ++++++++--
 .../ethernet/mellanox/mlx5/core/lib/mpfs.h    |   9 +
 include/linux/mlx5/fs.h                       |   1 +
 include/uapi/linux/devlink.h                  |   1 +
 net/devlink/netlink_gen.c                     |   2 +-
 11 files changed, 338 insertions(+), 39 deletions(-)

-- 
2.51.1


