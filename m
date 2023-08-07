Return-Path: <netdev+bounces-25060-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B340D772D55
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 19:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E45471C20C4C
	for <lists+netdev@lfdr.de>; Mon,  7 Aug 2023 17:56:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CB6156D8;
	Mon,  7 Aug 2023 17:56:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BBF53C2B
	for <netdev@vger.kernel.org>; Mon,  7 Aug 2023 17:56:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A298DC433C8;
	Mon,  7 Aug 2023 17:56:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1691431013;
	bh=22xeyfFdT5yJ++Q7XN67fpO7hobiIuZAYx1j+wFXA1o=;
	h=From:To:Cc:Subject:Date:From;
	b=npa/18hU1a2Rpp7mt2EpYUyIYxbeY+C2jWn2l4au5FpcLfObw/+eMOntGdRiUacHI
	 Nck3wX6OQfbRKTcqx1jgQoq3siYp3FnDtDu5csOOZwAfQ17DGyh4c0v/qwENAthWJ4
	 huPKMaTBwVuc3Lp2S2tDS9/xG2PgiNfjv4EGiXuHqSqwb8FzkNpA/12xmCqtqjIdZx
	 5T3sC+nMzpPq/HPQp7TyZ2mB19pXZqzDgQqWsY3NaYtoACGSXoqSS7PgAXF90jAmZv
	 KHK0LlEiyeHSM0yeaogdOFU3wx/ueZwf64qXhQtYwRWjlCQAW7ufAOXIMjGa7Qj0j6
	 Hb0jS4BRUfbNw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-08-07
Date: Mon,  7 Aug 2023 10:56:27 -0700
Message-ID: <20230807175642.20834-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides some minor cleanup and Dynamic completion EQ
allocation mechanism in the mlx5 driver.

For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit cc97777c80fdfabe12997581131872a03fdcf683:

  udp/udplite: Remove unused function declarations udp{,lite}_get_port() (2023-08-07 08:53:55 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-08-07

for you to fetch changes up to b56fb19c337951fc4daba646fab2c50bb4c41c58:

  net/mlx5: Bridge, Only handle registered netdev bridge events (2023-08-07 10:53:52 -0700)

----------------------------------------------------------------
mlx5-updates-2023-08-07
1) Few cleanups

2) Dynamic completion EQs

The driver creates completion EQs for all vectors directly on driver
load, even if those EQs will not be utilized later on.

To allow more flexibility in managing completion EQs and to reduce the
memory overhead of driver load, this series will adjust completion EQs
creation to be dynamic. Meaning, completion EQs will be created only
when needed.

Patch #1 introduces a counter for tracking the current number of
completion EQs.
Patches #2-6 refactor the existing infrastructure of managing completion
EQs and completion IRQs to be compatible with per-vector
allocation/release requests.
Patches #7-8 modify the CPU-to-IRQ affinity calculation to be resilient
in case the affinity is requested but completion IRQ is not allocated yet.
Patch #9 function rename.
Patch #10 handles the corner case of SF performing an IRQ request when no
SF IRQ pool is found, and no PF IRQ exists for the same vector.
Patch #11 modify driver to use dynamically allocate completion EQs.

----------------------------------------------------------------
Gal Pressman (1):
      net/mlx5: Fix typo reminder -> remainder

Maher Sanalla (11):
      net/mlx5: Track the current number of completion EQs
      net/mlx5: Refactor completion IRQ request/release API
      net/mlx5: Use xarray to store and manage completion IRQs
      net/mlx5: Refactor completion IRQ request/release handlers in EQ layer
      net/mlx5: Use xarray to store and manage completion EQs
      net/mlx5: Implement single completion EQ create/destroy methods
      net/mlx5: Introduce mlx5_cpumask_default_spread
      net/mlx5: Add IRQ vector to CPU lookup function
      net/mlx5: Rename mlx5_comp_vectors_count() to mlx5_comp_vectors_max()
      net/mlx5: Handle SF IRQ request in the absence of SF IRQ pool
      net/mlx5: Allocate completion EQs dynamically

Roi Dayan (2):
      net/mlx5: E-Switch, Remove redundant arg ignore_flow_lvl
      net/mlx5: Bridge, Only handle registered netdev bridge events

Ruan Jinjie (1):
      net/mlx5: remove many unnecessary NULL values

 drivers/infiniband/hw/mlx5/cq.c                    |   2 +-
 drivers/infiniband/hw/mlx5/devx.c                  |   2 +-
 drivers/infiniband/hw/mlx5/main.c                  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   2 +-
 .../ethernet/mellanox/mlx5/core/en/rep/bridge.c    |   4 +
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  10 +-
 drivers/net/ethernet/mellanox/mlx5/core/eq.c       | 360 ++++++++++++---------
 drivers/net/ethernet/mellanox/mlx5/core/esw/qos.c  |   6 +-
 .../ethernet/mellanox/mlx5/core/eswitch_offloads.c |   6 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/conn.c    |   2 +-
 .../net/ethernet/mellanox/mlx5/core/fpga/core.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/irq_affinity.c |  78 ++---
 drivers/net/ethernet/mellanox/mlx5/core/lib/aso.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |   2 +-
 .../net/ethernet/mellanox/mlx5/core/lib/hv_vhca.c  |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/mlx5_irq.h |  26 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |  60 ++--
 .../ethernet/mellanox/mlx5/core/steering/dr_send.c |   4 +-
 drivers/vdpa/mlx5/net/mlx5_vnet.c                  |   2 +-
 drivers/vfio/pci/mlx5/cmd.c                        |   4 +-
 include/linux/mlx5/driver.h                        |   7 +-
 22 files changed, 309 insertions(+), 280 deletions(-)

