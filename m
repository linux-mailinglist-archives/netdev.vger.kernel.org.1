Return-Path: <netdev+bounces-76786-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19FB86EF02
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 08:03:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DEB531C213D7
	for <lists+netdev@lfdr.de>; Sat,  2 Mar 2024 07:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8E9111711;
	Sat,  2 Mar 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lb90LWoS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C308111BB
	for <netdev@vger.kernel.org>; Sat,  2 Mar 2024 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709363007; cv=none; b=iaYze3NGjz/2Atm8e9UHYsw5ymGLBfPDXaK1JWbmT2CerOvENQ70e0I2JtofK/kOd6Ok6pZV+iy7wQWorp975QIP5oRE0B1wubZUUhc07L05iRQc3VkaibjgeyC/4IWLeIPINyFLNp8SkaGoaai59dwlNdQXDLIYLNpULgvWAdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709363007; c=relaxed/simple;
	bh=7nNyu8TLhNHh1zO6879lqXo36oHrsm10TkNgUL7IowE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BCjlJxWAjxbGFa4TyelzQyXFzKctnC6RxAflFLOIoHL3iNmRONPvXjkyuMOS1WTHxPmMYfX+nc23IZOhqdwt9tO9VlPGFQC5s/Jk5jjanTZtGtqczETIC8L5FnoUSZ4g+fZbq2BdjEvdogTVh1A6ByeFO7JzJ6N6k1Ybn3r8B4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lb90LWoS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB95C433F1;
	Sat,  2 Mar 2024 07:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709363007;
	bh=7nNyu8TLhNHh1zO6879lqXo36oHrsm10TkNgUL7IowE=;
	h=From:To:Cc:Subject:Date:From;
	b=Lb90LWoSORxLwJKyISgV01wTWEw2+H0JO9mW/w/sxH4AQAY4+jxchXMoM/cEO6HFI
	 byaIQxFhjQxJ+mVOGa8kEJjqf7393f+IJABqyQbG/+msXAQSVi3haC4nTUlx3O25Iz
	 Ho/FfyiQ5aAEnt+KqW/P6L3FaS035Mgcq5KwL/pdSLfCm6nUEwTUpkvj+m/aUnDs3r
	 RL8KPIhs1INEvi3dAZumn/s9MvCcNZXOJYLelNh2YTGecdk8TQO8GXi0tZjH9qg33d
	 rmTbFpCXHpHaoatNHT2Kf/8aTSEBC+aCeVh5oRtNIzGkXmPcHEnpiSc6ej9EVBhJrT
	 ERWjxwImlnizQ==
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
Subject: [pull request][net V2 0/9] mlx5 fixes 2024-03-01
Date: Fri,  1 Mar 2024 23:03:09 -0800
Message-ID: <20240302070318.62997-1-saeed@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides bug fixes to mlx5 driver.
Please pull and let me know if there is any problem.

V2:
 - Drop patch #8, it needs some more work, comment by Jakub

Thanks,
Saeed.


The following changes since commit 1c61728be22c1cb49c1be88693e72d8c06b1c81e:

  MAINTAINERS: net: netsec: add myself as co-maintainer (2024-03-01 10:33:20 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2024-03-01

for you to fetch changes up to 90502d433c0e7e5483745a574cb719dd5d05b10c:

  net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context (2024-03-01 23:02:27 -0800)

----------------------------------------------------------------
mlx5-fixes-2024-03-01

----------------------------------------------------------------
Aya Levin (1):
      net/mlx5: Fix fw reporter diagnose output

Emeel Hakim (1):
      net/mlx5e: Fix MACsec state loss upon state update in offload path

Gavin Li (1):
      Revert "net/mlx5: Block entering switchdev mode with ns inconsistency"

Jianbo Liu (2):
      net/mlx5: E-switch, Change flow rule destination checking
      net/mlx5e: Change the warning when ignore_flow_level is not supported

Moshe Shemesh (1):
      net/mlx5: Check capability for fw_reset

Rahul Rameshbabu (2):
      net/mlx5e: Use a memory barrier to enforce PTP WQ xmit submission tracking occurs after populating the metadata_map
      net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context

Saeed Mahameed (1):
      Revert "net/mlx5e: Check the number of elements before walk TC rhashtable"

 drivers/net/ethernet/mellanox/mlx5/core/devlink.c  |  6 ++
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   | 12 ++--
 .../ethernet/mellanox/mlx5/core/en/tc/post_act.c   |  2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/macsec.c  | 82 ++++++++++++++--------
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  2 +
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 46 ++++--------
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 22 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  2 +-
 include/linux/mlx5/mlx5_ifc.h                      |  4 +-
 10 files changed, 105 insertions(+), 75 deletions(-)

