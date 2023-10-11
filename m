Return-Path: <netdev+bounces-39829-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A15497C49AF
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 08:12:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 50B5C281DB0
	for <lists+netdev@lfdr.de>; Wed, 11 Oct 2023 06:12:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC264101CA;
	Wed, 11 Oct 2023 06:12:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dlz0jb/V"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC151354F0
	for <netdev@vger.kernel.org>; Wed, 11 Oct 2023 06:12:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B8A0C433C8;
	Wed, 11 Oct 2023 06:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697004753;
	bh=JE7hCR2HfrbvQd/Ilcjyw7GRVT9mmvqNPuoK98MThj8=;
	h=From:To:Cc:Subject:Date:From;
	b=dlz0jb/VnThlrqjuDo07lt2NobTPxU66i0IwdhjYuhzQqhUZcpFY5pAPOrHKPtzAy
	 r8yag7Ajf9Qyrrsa3SY0iShxEi4auwpACgQPXzktYR4dmuHqTiI2cDK4tw5MT0Uqwa
	 EUGApvaPlEfM7miTCYmH1isjjCXgHwaK7FiA5t62nuDEzZRtWHoZTrp7qsVfZvrEgj
	 u1hxdaSQwRd24zbHRZ+xDDhhSc0FGeIhq7xwc5xOVRGStktD8hWI4hu1KqgDI2U1hY
	 ngUCI3vX77q9A5JhIPhDd26sJbXZbquDCUZBOZsEhvk6wVktgeSsv4kuCzh8Mtq5BI
	 VQXenXntOT3/Q==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-10-10
Date: Tue, 10 Oct 2023 23:12:15 -0700
Message-ID: <20231011061230.11530-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides misc updates to mlx5 driver.
For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit e5f061d5e340fefc663cacfe8f42f149d55bdb53:

  net: dsa: realtek: rtl8365mb: replace deprecated strncpy with ethtool_sprintf (2023-10-10 20:05:23 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-10-10

for you to fetch changes up to f1cb181d05116d7791398e1541f0a12376d78c40:

  net/mlx5e: Allow IPsec soft/hard limits in bytes (2023-10-10 23:10:55 -0700)

----------------------------------------------------------------
mlx5-updates-2023-10-10

1) Adham Faris, Increase max supported channels number to 256

2) Leon Romanovsky, Allow IPsec soft/hard limits in bytes

3) Shay Drory, Replace global mlx5_intf_lock with
   HCA devcom component lock

4) Wei Zhang, Optimize SF creation flow

During SF creation, HCA state gets changed from INVALID to
IN_USE step by step. Accordingly, FW sends vhca event to
driver to inform about this state change asynchronously.
Each vhca event is critical because all related SW/FW
operations are triggered by it.

Currently there is only a single mlx5 general event handler
which not only handles vhca event but many other events.
This incurs huge bottleneck because all events are forced
to be handled in serial manner.

Moreover, all SFs share same table_lock which inevitably
impacts each other when they are created in parallel.

This series will solve this issue by:

1. A dedicated vhca event handler is introduced to eliminate
   the mutual impact with other mlx5 events.
2. Max FW threads work queues are employed in the vhca event
   handler to fully utilize FW capability.
3. Redesign SF active work logic to completely remove
   table_lock.

With above optimization, SF creation time is reduced by 25%,
i.e. from 80s to 60s when creating 100 SFs.

Patches summary:

Patch 1 - implement dedicated vhca event handler with max FW
          cmd threads of work queues.
Patch 2 - remove table_lock by redesigning SF active work
          logic.

----------------------------------------------------------------
Adham Faris (5):
      net/mlx5e: Refactor rx_res_init() and rx_res_free() APIs
      net/mlx5e: Refactor mlx5e_rss_set_rxfh() and mlx5e_rss_get_rxfh()
      net/mlx5e: Refactor mlx5e_rss_init() and mlx5e_rss_free() API's
      net/mlx5e: Preparations for supporting larger number of channels
      net/mlx5e: Increase max supported channels number to 256

Jinjie Ruan (1):
      net/mlx5: Use PTR_ERR_OR_ZERO() to simplify code

Leon Romanovsky (1):
      net/mlx5e: Allow IPsec soft/hard limits in bytes

Lukas Bulwahn (1):
      net/mlx5: fix config name in Kconfig parameter documentation

Shay Drory (3):
      net/mlx5: Avoid false positive lockdep warning by adding lock_class_key
      net/mlx5: Refactor LAG peer device lookout bus logic to mlx5 devcom
      net/mlx5: Replace global mlx5_intf_lock with HCA devcom component lock

Wei Zhang (2):
      net/mlx5: Parallelize vhca event handling
      net/mlx5: Redesign SF active work to remove table_lock

Yu Liao (1):
      net/mlx5e: Use PTR_ERR_OR_ZERO() to simplify code

Yue Haibing (1):
      net/mlx5: Remove unused declaration

 .../ethernet/mellanox/mlx5/kconfig.rst             |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/dev.c      | 105 ++-------------
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   5 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/fs.h    |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   |  32 +++--
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   | 144 ++++++++++++++++-----
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |  20 ++-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    | 105 ++++++++-------
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |  12 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  23 ++--
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         |  24 ++--
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_fs.c    |   8 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  |  32 ++---
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  27 ++--
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |  16 ++-
 drivers/net/ethernet/mellanox/mlx5/core/events.c   |   5 -
 .../net/ethernet/mellanox/mlx5/core/ipoib/ipoib.c  |  24 ++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.c  |  47 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/lag/lag.h  |   1 +
 .../net/ethernet/mellanox/mlx5/core/lag/mpesw.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/lag/port_sel.c |  10 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.c   |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   5 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/eq.h   |   1 -
 drivers/net/ethernet/mellanox/mlx5/core/main.c     |  25 ++++
 .../net/ethernet/mellanox/mlx5/core/mlx5_core.h    |  14 +-
 .../net/ethernet/mellanox/mlx5/core/sf/dev/dev.c   |  85 ++++++++----
 .../ethernet/mellanox/mlx5/core/sf/vhca_event.c    |  69 +++++++++-
 .../ethernet/mellanox/mlx5/core/sf/vhca_event.h    |   3 +
 .../mellanox/mlx5/core/steering/dr_types.h         |   4 -
 include/linux/mlx5/driver.h                        |  16 +--
 34 files changed, 544 insertions(+), 367 deletions(-)

