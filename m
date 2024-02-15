Return-Path: <netdev+bounces-71924-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E06C855946
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 04:09:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 82E4E1C29E05
	for <lists+netdev@lfdr.de>; Thu, 15 Feb 2024 03:09:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10D66BA38;
	Thu, 15 Feb 2024 03:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aMJ/l9Ep"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB3D3BA37
	for <netdev@vger.kernel.org>; Thu, 15 Feb 2024 03:08:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707966499; cv=none; b=pqv7aeyHzI0PgBuk6oBKR18wBcyUHW6spb9mSva2xgMsHe1eZVW//077fTlmmqSXDVxLme6MjK6z+aSNml55AZ0FSQScyAWp588c0WWQHpbJ9DdeUowGvIevzsG+MF/9o5zfTI+Tj7L/mzgWeCDmL/Fc0dKraX+hMrsLgdZwWS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707966499; c=relaxed/simple;
	bh=im/TLVCppu8Q6qHJTPW/QrTuJ8FsjW0YuFHuvDWO0VI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TCDwgigJqjDjzRpPMaH4FzerKGNZAk2dRDD/LxPgn/kTMaPtv0sa4HACWvt4RBNH73IcUhlZJ2aGRBoHQoLNTQ+yN+tLqjn6OoF5gXifnj8ZEvgU81wX/QyYtNgdlyXSJEUuM1sjg7aOdGhULUGSW26yk7VzXGWtnOVznQb0YlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aMJ/l9Ep; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68C46C433C7;
	Thu, 15 Feb 2024 03:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707966499;
	bh=im/TLVCppu8Q6qHJTPW/QrTuJ8FsjW0YuFHuvDWO0VI=;
	h=From:To:Cc:Subject:Date:From;
	b=aMJ/l9EpSovhZyjCBv0JvHMzGURfRyihxz7+J/pNabEDisr875RH1cx6D57wIVV01
	 XVOyg3Igh3bTaZsF3SbFrtqrXNmebKYySSLgIdf2YDn2ROVcVj4dz6CGQMlXhqdf2V
	 xyY6e2xde3RS4z1Hd/QLUF11SAbbiMkt8TUspu6ExaT97Vh8tonch4IUVAPSb9Y3wK
	 tyZx2l/0k6tKW8+lQbnkOa8oMgEhX66mBgkze08sRo5UZsmuJKPm3eHMyTkshSRRxp
	 6STgr760Mq78FwOhV5KBbsSkd18fKa6OKkH7PweHmvzHugcVMT0ve9d9dy4+yuYsQS
	 U+vWjIGfLKdDA==
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
Subject: [pull request][net-next V3 00/15] mlx5 socket direct (Multi-PF)
Date: Wed, 14 Feb 2024 19:07:59 -0800
Message-ID: <20240215030814.451812-1-saeed@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

Support Socket-Direct multi-dev netdev.

V3:
- Fix documentation per Jakubs feedback
- Fix typos
- Link new documentation in the networking index.rst

V2:
- Add documentation in a new patch.
- Add debugfs in a new patch.
- Add mlx5_ifc bit for MPIR cap check and use it before query.

V1:
- https://lore.kernel.org/netdev/20231221005721.186607-1-saeed@kernel.org/


For more information please see tag log below.

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit d1d77120bc2867b3e449e07ee656a26b2fb03d1e:

  net: phy: dp83826: support TX data voltage tuning (2024-02-14 12:06:10 +0000)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-socket-direct-v3

for you to fetch changes up to 0684f46f6e4ed5070a2ef6b32b3bd368d5387227:

  Documentation: networking: Add description for multi-pf netdev (2024-02-14 19:01:59 -0800)

----------------------------------------------------------------
Support Multi-PF netdev (Socket Direct)

This series adds support for combining multiple devices (PFs) of the
same port under one netdev instance. Passing traffic through different
devices belonging to different NUMA sockets saves cross-numa traffic and
allows apps running on the same netdev from different numas to still
feel a sense of proximity to the device and achieve improved
performance.

We achieve this by grouping PFs together, and creating the netdev only
once all group members are probed. Symmetrically, we destroy the netdev
once any of the PFs is removed.

The channels are distributed between all devices, a proper configuration
would utilize the correct close numa when working on a certain app/cpu.

We pick one device to be a primary (leader), and it fills a special
role.  The other devices (secondaries) are disconnected from the network
in the chip level (set to silent mode). All RX/TX traffic is steered
through the primary to/from the secondaries.

Currently, we limit the support to PFs only, and up to two devices
(sockets).

V3:
- Fix documentation per Jakubs feedback.
- Fix typos
- Link new documentation in the networking index.rst

V2:
- Add documentation in a new patch.
- Add debugfs in a new patch.
- Add mlx5_ifc bit for MPIR cap check and use it before query.

----------------------------------------------------------------
Tariq Toukan (15):
      net/mlx5: Add MPIR bit in mcam_access_reg
      net/mlx5: SD, Introduce SD lib
      net/mlx5: SD, Implement basic query and instantiation
      net/mlx5: SD, Implement devcom communication and primary election
      net/mlx5: SD, Implement steering for primary and secondaries
      net/mlx5: SD, Add informative prints in kernel log
      net/mlx5: SD, Add debugfs
      net/mlx5e: Create single netdev per SD group
      net/mlx5e: Create EN core HW resources for all secondary devices
      net/mlx5e: Let channels be SD-aware
      net/mlx5e: Support cross-vhca RSS
      net/mlx5e: Support per-mdev queue counter
      net/mlx5e: Block TLS device offload on combined SD netdev
      net/mlx5: Enable SD feature
      Documentation: networking: Add description for multi-pf netdev

 Documentation/networking/index.rst                 |   1 +
 Documentation/networking/multi-pf-netdev.rst       | 157 ++++++
 drivers/net/ethernet/mellanox/mlx5/core/Makefile   |   2 +-
 drivers/net/ethernet/mellanox/mlx5/core/en.h       |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.c  |  10 +-
 .../net/ethernet/mellanox/mlx5/core/en/channels.h  |   6 +-
 .../ethernet/mellanox/mlx5/core/en/monitor_stats.c |  48 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.c    |   9 +-
 .../net/ethernet/mellanox/mlx5/core/en/params.h    |   3 -
 drivers/net/ethernet/mellanox/mlx5/core/en/ptp.c   |  12 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/qos.c   |   8 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_tx.c   |   3 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.c   | 123 ++++-
 drivers/net/ethernet/mellanox/mlx5/core/en/rqt.h   |   9 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.c   |  17 +-
 drivers/net/ethernet/mellanox/mlx5/core/en/rss.h   |   4 +-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.c    |  62 ++-
 .../net/ethernet/mellanox/mlx5/core/en/rx_res.h    |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/en/trap.c  |  11 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/pool.c  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en/xsk/setup.c |   8 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.c    |   2 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls.h    |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ktls_rx.c |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_main.c  | 176 +++++--
 drivers/net/ethernet/mellanox/mlx5/core/en_stats.c |  39 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_tc.c    |   4 +-
 .../net/ethernet/mellanox/mlx5/core/lib/devcom.h   |   1 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/mlx5.h |  12 +
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c   | 524 +++++++++++++++++++++
 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h   |  38 ++
 include/linux/mlx5/driver.h                        |   1 +
 include/linux/mlx5/mlx5_ifc.h                      |   4 +-
 34 files changed, 1151 insertions(+), 173 deletions(-)
 create mode 100644 Documentation/networking/multi-pf-netdev.rst
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/lib/sd.h

