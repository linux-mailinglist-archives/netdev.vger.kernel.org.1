Return-Path: <netdev+bounces-129846-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E55986784
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 22:20:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5B8A42846CB
	for <lists+netdev@lfdr.de>; Wed, 25 Sep 2024 20:20:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03CA146A6B;
	Wed, 25 Sep 2024 20:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aiXUQBnM"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B734E14884D
	for <netdev@vger.kernel.org>; Wed, 25 Sep 2024 20:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727295619; cv=none; b=uUevCPLCVQF/pOXDpR2ArygycR7C7/PWLQEwNQQo/5cq6YBDLjgwqnnqntrvnNFAPtlATIeQqQlmCnLoS0FYyo2udNHuwSHPQ31CbxNdfxPkIjzaaWvUqOo6Svgk7z/FUw3T7Lsw9HjN8fkctuu1P93KmZL3hQSDN/HVRJnzjgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727295619; c=relaxed/simple;
	bh=3wiHkn+rN6F3lGAuE2IG3DjJoqloqfti5FqqrmbiUZw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YW21zWEFTXs0tc3xlfgBBdyPL+asZv2tkNp9vZwbnPWrq/vjU22JWfQHH690W5eepSw+Amwi4TO8B5KNBxp59X/Thu/pS0vddgplrarvgV0JN8GISEN03k6GHdjxAXvYq9uzDRAc1w2SFaZxYsnKm8+cyj67oQFtoG2syGKyVWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aiXUQBnM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D074C4CEC3;
	Wed, 25 Sep 2024 20:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727295618;
	bh=3wiHkn+rN6F3lGAuE2IG3DjJoqloqfti5FqqrmbiUZw=;
	h=From:To:Cc:Subject:Date:From;
	b=aiXUQBnM/NajEpb3nbG/OjjJLbdC4JaT2TDtxKpOjN8QE/21RsALl3NozTsyiGrIb
	 i9lGPHHxIDuJoPKpgFArmbviVj6H65Y/NAVDFD6b0+PzPHrtADi5libMq66ynciJsj
	 BnveL79+hAGpKyxE01KJsppLuWze65afZtkhm0ZzqP3EqAg4hjeMibqI1Nz2vrdyWk
	 kTTuXCyN8riy7ETWNy4c1yxJD8ngUTn+PWO0/IZLJvmoQh1JeX/WMZV9pBEQGhSK0p
	 OWsifLVY4p1HXswTlO2sZoL8aQGMUaAHaNLYf5Ooc6jGEJMe02Q5/pjxBA++EIHenJ
	 EPeeluSOVXj3A==
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
Subject: [pull request][net 0/8] mlx5 fixes 2024-09-25
Date: Wed, 25 Sep 2024 13:20:05 -0700
Message-ID: <20240925202013.45374-1-saeed@kernel.org>
X-Mailer: git-send-email 2.46.1
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


The following changes since commit 0cbfd45fbcf0cb26d85c981b91c62fe73cdee01c:

  bonding: Fix unnecessary warnings and logs from bond_xdp_get_xmit_slave() (2024-09-24 15:19:50 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-fixes-2024-09-25

for you to fetch changes up to 7b124695db40d5c9c5295a94ae928a8d67a01c3d:

  net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice (2024-09-25 13:15:46 -0700)

----------------------------------------------------------------
mlx5-fixes-2024-09-25

----------------------------------------------------------------
Dragos Tatulea (1):
      net/mlx5e: SHAMPO, Fix overflow of hd_per_wq

Elena Salomatkina (1):
      net/mlx5e: Fix NULL deref in mlx5e_tir_builder_alloc()

Gerd Bayer (1):
      net/mlx5: Fix error path in multi-packet WQE transmit

Jianbo Liu (1):
      net/mlx5e: Fix crash caused by calling __xfrm_state_delete() twice

Mohamed Khalfella (1):
      net/mlx5: Added cond_resched() to crdump collection

Yevgeny Kliteynik (3):
      net/mlx5: Fix wrong reserved field in hca_cap_2 in mlx5_ifc
      net/mlx5: HWS, fixed double-free in error flow of creating SQ
      net/mlx5: HWS, changed E2BIG error to a negative return code

 drivers/net/ethernet/mellanox/mlx5/core/en.h                   |  2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/tir.c               |  3 +++
 drivers/net/ethernet/mellanox/mlx5/core/en_accel/ipsec.c       |  8 +++++++-
 drivers/net/ethernet/mellanox/mlx5/core/en_tx.c                |  1 -
 drivers/net/ethernet/mellanox/mlx5/core/lib/pci_vsc.c          | 10 ++++++++++
 .../mellanox/mlx5/core/steering/hws/mlx5hws_bwc_complex.c      |  2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_definer.c |  4 ++--
 .../ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_matcher.c |  2 +-
 .../ethernet/mellanox/mlx5/core/steering/hws/mlx5hws_send.c    |  8 +++++++-
 include/linux/mlx5/mlx5_ifc.h                                  |  2 +-
 10 files changed, 33 insertions(+), 9 deletions(-)

