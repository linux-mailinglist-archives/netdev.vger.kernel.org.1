Return-Path: <netdev+bounces-42851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4700C7D06B0
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 05:04:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 73CDBB21290
	for <lists+netdev@lfdr.de>; Fri, 20 Oct 2023 03:04:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00063818;
	Fri, 20 Oct 2023 03:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WCH/qYpr"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC9F765E
	for <netdev@vger.kernel.org>; Fri, 20 Oct 2023 03:04:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE6DC433C8;
	Fri, 20 Oct 2023 03:04:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697771071;
	bh=EZxZlVXf72kjxTHlCvrG4TM/VXJli7RgC/6uAFh3GHM=;
	h=From:To:Cc:Subject:Date:From;
	b=WCH/qYpr5sewxm14b5ZQuiSQqPUWpMFVd4N7jWKRs3x7pXgRt5dzG+pmtG8hzxpc0
	 68S0CeYoptJEMioh8YiXg3IwutZO/6GCPZOLmpC3gkjExd4p6EIJHJ36I1qWBoIZt6
	 1siNGXVDYZAqDDCqs4GaauTqcc1/l0VsaikoWwE6ACB0u3Y1AXOGPbnht+/y7Jv56n
	 Hb1+Dpn177MeXo4nGAu4b3ex5iMcThhmY7GNz2EqjeCqEuXo7sVYbLYTJhRBw91hnH
	 k3xxs56ac+xu1JYqt5q5lhS4k5pw3/dLSdE9VyFzmvNo9WLudo8sBoqc2k7hs0V3qd
	 hkNZ36NQxK1Nw==
From: Saeed Mahameed <saeed@kernel.org>
To: "David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>
Cc: Saeed Mahameed <saeedm@nvidia.com>,
	netdev@vger.kernel.org,
	Tariq Toukan <tariqt@nvidia.com>,
	Leon Romanovsky <leonro@nvidia.com>
Subject: [pull request][net-next 00/15] mlx5 updates 2023-10-19
Date: Thu, 19 Oct 2023 20:04:07 -0700
Message-ID: <20231020030422.67049-1-saeed@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Saeed Mahameed <saeedm@nvidia.com>

This series provides ipsec and misc updates for mlx5 driver.
For more information please see tag log below.

CC'd Steffen Klassert for the first two xfrm patches,
He already approved sending them via net-next
https://lore.kernel.org/all/ZTDszYAuNv16bGBO@gauss3.secunet.de/

Please pull and let me know if there is any problem.

Thanks,
Saeed.


The following changes since commit 7ce6936045ba395f97e5feb54cd023afb8db9c0b:

  Merge branch 'tools-ynl-gen-support-full-range-of-min-max-checks' (2023-10-19 15:54:58 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/saeed/linux.git tags/mlx5-updates-2023-10-19

for you to fetch changes up to 8b413a98887a66bdd01da8c3cad7b77a1671b1c8:

  net/mlx5: Allow sync reset flow when BF MGT interface device is present (2023-10-19 20:01:41 -0700)

----------------------------------------------------------------
mlx5-updates-2023-10-19

1) Patches 1-9 from Leon and Patrisious:

Leon Says:
==========

This series does two things at the same time, but they are connected together:
 * Rewrite and fix mlx5 IPsec replay window implementation.
 * Connect XFRM statistics with offloaded counters to report replay window
   reason statistics.

First two patches are XFRM core changes to allow reuse of already existing
callback to fill all statistics.

Next two patches are fixes to replay window and sequence packet number
misconfiguration. They are not urgent and can go to -next.

Rest of the patches are rewrite of mlx5 replay window implementation.

As an example, the end result, after simulating replay window attack with 5 packets:
[leonro@c ~]$ grep XfrmInStateSeqError /proc/net/xfrm_stat
XfrmInStateSeqError     	5
[leonro@c ~]$ sudo ip -s x s
<...>
	stats:
	  replay-window 0 replay 5 failed 0

==========

2) Moshe Shemesh improves sync reset flow when BF MGT
   interface device is  present

3) Build warning cleanups for snprintf

----------------------------------------------------------------
Leon Romanovsky (7):
      xfrm: generalize xdo_dev_state_update_curlft to allow statistics update
      xfrm: get global statistics from the offloaded device
      net/mlx5e: Honor user choice of IPsec replay window size
      net/mlx5e: Ensure that IPsec sequence packet number starts from 1
      net/mlx5e: Remove exposure of IPsec RX flow steering struct
      net/mlx5e: Connect mlx5 IPsec statistics with XFRM core
      net/mlx5e: Delete obsolete IPsec code

Moshe Shemesh (2):
      net/mlx5: print change on SW reset semaphore returns busy
      net/mlx5: Allow sync reset flow when BF MGT interface device is present

Patrisious Haddad (2):
      net/mlx5e: Unify esw and normal IPsec status table creation/destruction
      net/mlx5e: Add IPsec and ASO syndromes check in HW

Rahul Rameshbabu (3):
      net/mlx5: Increase size of irq name buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer
      net/mlx5e: Check return value of snprintf writing to fw_version buffer for representors

Saeed Mahameed (1):
      net/mlx5e: Reduce the size of icosq_str

 Documentation/networking/xfrm_device.rst           |   4 +-
 .../net/ethernet/mellanox/mlx5/core/diag/crdump.c  |   5 +-
 .../ethernet/mellanox/mlx5/core/en/reporter_rx.c   |   4 +-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.c   |  57 ++-
 .../ethernet/mellanox/mlx5/core/en_accel/ipsec.h   |  23 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c         | 410 ++++++++++++++++++---
 .../mellanox/mlx5/core/en_accel/ipsec_offload.c    |   2 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c       |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h       |   1 -
 .../mellanox/mlx5/core/en_accel/ipsec_stats.c      |   1 -
 .../net/ethernet/mellanox/mlx5/core/en_ethtool.c   |  13 +-
 drivers/net/ethernet/mellanox/mlx5/core/en_rep.c   |  12 +-
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c | 160 +-------
 .../net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h |  15 -
 drivers/net/ethernet/mellanox/mlx5/core/fw_reset.c |  32 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.c  |   6 +-
 drivers/net/ethernet/mellanox/mlx5/core/pci_irq.h  |   3 +
 include/linux/mlx5/mlx5_ifc.h                      |   7 +
 include/linux/netdevice.h                          |   2 +-
 include/net/xfrm.h                                 |  14 +-
 net/xfrm/xfrm_proc.c                               |   1 +
 net/xfrm/xfrm_state.c                              |  17 +-
 net/xfrm/xfrm_user.c                               |   2 +-
 23 files changed, 516 insertions(+), 300 deletions(-)

