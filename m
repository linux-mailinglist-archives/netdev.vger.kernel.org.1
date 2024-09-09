Return-Path: <netdev+bounces-126671-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5BB69722F7
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 21:45:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0443C1C21797
	for <lists+netdev@lfdr.de>; Mon,  9 Sep 2024 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4EE61531F2;
	Mon,  9 Sep 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BvuvlxfN"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7ED3818C31
	for <netdev@vger.kernel.org>; Mon,  9 Sep 2024 19:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725911135; cv=none; b=UXSbkSMwFeEkvM+pnevAzTlLLWEZynuYMVwM82F1L45C/Ys8G1rhfeYwDJttadiKQJpSXwihOXittXxkDYu9M00HY+d6dqfbZQWc1shPeW2iYNQ8QDlc81pxLx1y4N4fc92IqOzG+Rx8Tw/oiEsC3iGYZHU7ftggpbLyFkMVzOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725911135; c=relaxed/simple;
	bh=RVxr60bIMEmaIeWl/he9+8xlcootSPvL6nkav4Ei5bk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=hlBzghV7WhMRSI8LKnKyg8jSEEgYX55v2XuLZIOr97hnStxUKylazTUWrYKDunqTiDhap2JyEesepmT+amsNNwrJfH6IoF1l6ZoFZ/Eubx7o8PlKWr4n7vUxjQ5aNASY9xYkRetZxRg8Ev1DiX81yOCiSVSQ1EArtj8g4YqwyJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BvuvlxfN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 044DEC4CEC5;
	Mon,  9 Sep 2024 19:45:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725911135;
	bh=RVxr60bIMEmaIeWl/he9+8xlcootSPvL6nkav4Ei5bk=;
	h=From:To:Cc:Subject:Date:From;
	b=BvuvlxfNVDHLadLjmjjEvWyMXK4ndRVlhS9P//Y5qdN4Edkt0DlZ2mA+jntQxgk5a
	 ws80aQsXpfnJenhYKJiCtm3Kj80Bvlru5aZHflzhAmkuGSYWMH/61W3d4Ffvv+HY8k
	 rsY/VfX9D1XSSaIKdDmqj0LcVijKa0XbmN9WN5+H25RhCBh7h/zQZQiUMA/J4OMP1p
	 3wIJ64DNvMe6ZRaHENtqkMrDRWODBGrxG8Kf7oii2RBBePxHafb3SOQidt8aGyUayg
	 VaeTQ0reyGC4Lc6gn0+Fbm5ES6czCpKc3SUoXHHDQ/UbTWLVgusA7QP3NbJQ6CFCE4
	 S0NQIDVcHmtfw==
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
Subject: [pull request][net 0/7] mlx5 fixes 2024-09-09
Date: Mon,  9 Sep 2024 12:44:58 -0700
Message-ID: <20240909194505.69715-1-saeed@kernel.org>
X-Mailer: git-send-email 2.46.0
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


The following changes since commit b3c9e65eb227269ed72a115ba22f4f51b4e62b4d:

  net: hsr: remove seqnr_lock (2024-09-09 10:25:01 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2024-09-09

for you to fetch changes up to b1d305abef4640af1b4f1b4774d513cd81b10cfc:

  net/mlx5: Fix bridge mode operations when there are no VFs (2024-09-09 12:39:57 -0700)

----------------------------------------------------------------
mlx5-fixes-2024-09-09

----------------------------------------------------------------
Benjamin Poirier (1):
      net/mlx5: Fix bridge mode operations when there are no VFs

Carolina Jubran (3):
      net/mlx5: Explicitly set scheduling element and TSAR type
      net/mlx5: Add missing masks and QoS bit masks for scheduling elements
      net/mlx5: Verify support for scheduling element and TSAR type

Maher Sanalla (1):
      net/mlx5: Update the list of the PCI supported devices

Shahar Shitrit (2):
      net/mlx5e: Add missing link modes to ptys2ethtool_map
      net/mlx5e: Add missing link mode to ptys2ext_ethtool_map

 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   | 10 +++++
 .../net/ethernet/mellanox/mlx5/core/esw/legacy.c   |  4 +-
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  | 51 +++++++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  1 +
 drivers/net/ethernet/mellanox/mlx5/core/qos.c      |  7 +++
 include/linux/mlx5/mlx5_ifc.h                      | 10 ++++-
 6 files changed, 60 insertions(+), 23 deletions(-)

