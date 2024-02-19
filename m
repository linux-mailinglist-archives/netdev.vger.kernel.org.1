Return-Path: <netdev+bounces-73041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C7A1C85AAE5
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 19:23:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68D801F211CE
	for <lists+netdev@lfdr.de>; Mon, 19 Feb 2024 18:23:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B278F481DC;
	Mon, 19 Feb 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mVor03tx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F758481DB
	for <netdev@vger.kernel.org>; Mon, 19 Feb 2024 18:23:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708367008; cv=none; b=EEy5fiaajSDvopxkwdxiQLOU1OZ7Vci5jTcpQRIy1AtJ942bATqkgbx+2xId6BsyeBUuawI0vYAKc8sTpL90Fa2SeXgS0oDIQbs6MKP8aCgpzfao8gXDqGM3jYAbv5qOEvKYsubCWD+kxGDpaZooWBeNgnmumevBaxhq0gBdRCI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708367008; c=relaxed/simple;
	bh=1ztvZ7bz9kaLqyN7ZnYprSUApns2vWvkf27xrjDrTKM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Nx3JdVeKtN/vXT7AL3+RfFNyJzg123giNPGuX4Sovs5CbiFl4QJVpzzdQdxefrNVIRoWad4mrXY63OTUsxeqkN1CziGSvtMzvfTcc8oyeOoRk8LvaAWmiNP1rxL9il6dym18xl+i2XVlZSEtPlH1V6VNeNftJWlN/spTfQ/2HKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mVor03tx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E81EFC433C7;
	Mon, 19 Feb 2024 18:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708367008;
	bh=1ztvZ7bz9kaLqyN7ZnYprSUApns2vWvkf27xrjDrTKM=;
	h=From:To:Cc:Subject:Date:From;
	b=mVor03tx9mZNEPAb0zivsCYShrxav/Rnfkavm9Xt7bNRgbBDbO/uow5GUwNh8zCV3
	 tsERh/ZrH4qQdDSuRZmxXR/T2Rx6L0KlEynXKE6PJkbNd6eOyk6I+PTQKh9gGBnkMY
	 gV+nq2x64GNPqR8nMxnvW5FeIC7FVuBV3HiJLYDRyBt3jTdRWSXh9W4AjDmJDM/vqL
	 2FqkdO48okAl2f0unc0ErCCkapuf0u7i3j6VaqOK5bmkTMnPbIHbASj/RWOHkDBrgz
	 CWQnhOEFV2v2p+IQS4qPC875htWGJJI7+87VwgHBBjSPrPwlHqUPSXwi0oLrNE9+zw
	 k++/bWlCkp/IA==
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
Subject: [pull request][net 00/10] mlx5 fixes 2024-02-19
Date: Mon, 19 Feb 2024 10:23:10 -0800
Message-ID: <20240219182320.8914-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.2
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

Thanks,
Saeed.


The following changes since commit 40b9385dd8e6a0515e1c9cd06a277483556b7286:

  enic: Avoid false positive under FORTIFY_SOURCE (2024-02-19 10:57:27 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2024-02-19

for you to fetch changes up to 9a51748ccadc27ef38c69d807014a93ed282f3df:

  net/mlx5e: Switch to using _bh variant of of spinlock API in port timestamping NAPI poll context (2024-02-19 10:20:58 -0800)

----------------------------------------------------------------
mlx5-fixes-2024-02-19

----------------------------------------------------------------
Aya Levin (1):
      net/mlx5: Fix fw reporter diagnose output

Carolina Jubran (1):
      net/mlx5e: RSS, Unconfigure RXFH after changing channels number

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
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 18 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c    |  2 +
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c |  2 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c | 46 ++++--------
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c | 22 +++++-
 drivers/net/ethernet/mellanox/mlx5/core/health.c   |  2 +-
 include/linux/mlx5/mlx5_ifc.h                      |  4 +-
 11 files changed, 122 insertions(+), 76 deletions(-)

