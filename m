Return-Path: <netdev+bounces-16744-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 345C974EA7B
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 11:29:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4C3841C20CED
	for <lists+netdev@lfdr.de>; Tue, 11 Jul 2023 09:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18C4717FE0;
	Tue, 11 Jul 2023 09:29:25 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68FD11774A
	for <netdev@vger.kernel.org>; Tue, 11 Jul 2023 09:29:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CFFFC433C8;
	Tue, 11 Jul 2023 09:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1689067762;
	bh=jQ1TCeX8/zLBM+9fKC+1NPw1itXCEB2Cezer3TA/GdA=;
	h=From:To:Cc:Subject:Date:From;
	b=igpCwqpSUDK6bpYphythis9/hRDaJVY4HVLkVONVQjpKpg1JqfT0KRSxk9hAfFw1l
	 UfWCIbwLkHCY/siA3/UJSboaV9jA5wamxJVcvZOGV2BUDBdmiH+kNkRMD3qS1TwtIY
	 NTHsG3ee0kH0DZp7Dy1zGFpg0Q5vnthXq8iu+5NGLn2i8ASV5RLcHs6XwCna281DDy
	 6a2NXMH6QWvTlMjIIZdUD2d1jIy5/Pakqb4EYccnX8WYm2VTHWGnL9yUxBpEFID3l5
	 KLr7yhVgYvMSABpLfjFwu7Nh7zoVmloAiCB8iPWszUNrPlD1QS50UA67L18QZt6Nw/
	 cZ0nEUAKrOslQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>
Subject: [PATCH net-next 00/12] mlx5 IPsec packet offload support in eswitch mode
Date: Tue, 11 Jul 2023 12:28:58 +0300
Message-ID: <cover.1689064922.git.leonro@nvidia.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Hi,

This series from Jianbo adds mlx5 IPsec packet offload support in eswitch
offloaded mode.

Thanks

Jianbo Liu (12):
  net/mlx5e: Add function to get IPsec offload namespace
  net/mlx5e: Change the parameter of IPsec RX skb handle function
  net/mlx5e: Prepare IPsec packet offload for switchdev mode
  net/mlx5e: Refactor IPsec RX tables creation and destruction
  net/mlx5e: Support IPsec packet offload for RX in switchdev mode
  net/mlx5e: Handle IPsec offload for RX datapath in switchdev mode
  net/mlx5e: Refactor IPsec TX tables creation
  net/mlx5e: Support IPsec packet offload for TX in switchdev mode
  net/mlx5: Compare with old_dest param to modify rule destination
  net/mlx5e: Make IPsec offload work together with eswitch and TC
  net/mlx5e: Modify and restore TC rules for IPSec TX rules
  net/mlx5e: Add get IPsec offload stats for uplink representor

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +
 .../ethernet/mellanox/mlx5/core/en/rep/tc.c   |  17 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   2 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  65 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 626 ++++++++++++------
 .../mlx5/core/en_accel/ipsec_offload.c        |   3 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   3 +-
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 325 +++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  67 ++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  17 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 174 ++++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  14 +-
 include/linux/mlx5/eswitch.h                  |   3 +
 include/linux/mlx5/fs.h                       |   2 +
 17 files changed, 1141 insertions(+), 213 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h

-- 
2.41.0


