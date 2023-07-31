Return-Path: <netdev+bounces-22789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D848B7694C8
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 13:28:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 889912815F3
	for <lists+netdev@lfdr.de>; Mon, 31 Jul 2023 11:28:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40661800D;
	Mon, 31 Jul 2023 11:28:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B1E517AAB
	for <netdev@vger.kernel.org>; Mon, 31 Jul 2023 11:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F4ABC433C9;
	Mon, 31 Jul 2023 11:28:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1690802910;
	bh=yWa0dDcwG6Nbgl6nLQjO5+oOccBSbimQN1Vs1Yz9KVc=;
	h=From:To:Cc:Subject:Date:From;
	b=XCEm4TD5qk/2EQMtpcWH7fxVBrvhjAKXoJPNoHzM6CEgsfsMuwgZIrq+K+jh6FxV8
	 HNZ/D3BZ7o1xn20XDNNi9UgeWbVjjiYUa7sNHQV0TRKxl26uI417g+1qOoAmU5x/03
	 NswuRQJF+St3RVsEDBqvS7JdAVVoy1gzlts0p0nz7aoQNtACUsP7OkEFwM/zqtDlG7
	 xKvVeaUrKR6zDYLHoad+ybIf86El1VBAvk2iUkzjdrGrTzS/FqUPAKkEhoay+bodMQ
	 veibgu6yz9F3X7uCFqGRxUpP/30oeSbT+g6lyBzFNv6TOywbP3jV45eQRAiEHZem2b
	 sRwoftFafyxWQ==
From: Leon Romanovsky <leon@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Eric Dumazet <edumazet@google.com>,
	Jianbo Liu <jianbol@nvidia.com>,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	"David S . Miller" <davem@davemloft.net>,
	Simon Horman <simon.horman@corigine.com>
Subject: [PATCH net-next v1 00/13] mlx5 IPsec packet offload support in eswitch mode
Date: Mon, 31 Jul 2023 14:28:11 +0300
Message-ID: <cover.1690802064.git.leon@kernel.org>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Leon Romanovsky <leonro@nvidia.com>

Changelog:
v1:
 * Fixed ipv6 flow steering table destination in IPsec initialization routine.
 * Removed Fixes line from "net/mlx5: Compare with..." patch as this fix
   is required for this series only.
 * Added patch to enforce same order for HW and SW IPsec flows when TC
   is involved, which is "host <-> IPsec <-> TC <-> "wire"/switch".
v0: https://lore.kernel.org/all/cover.1689064922.git.leonro@nvidia.com

-------------------------------------------------------------------------
Hi,

This series from Jianbo adds mlx5 IPsec packet offload support in eswitch
offloaded mode.

It works exactly like "regular" IPsec, nothing special, except
now users can switch to switchdev before adding IPsec rules.

 devlink dev eswitch set pci/0000:06:00.0 mode switchdev

Same configurations as here:
https://lore.kernel.org/netdev/cover.1670005543.git.leonro@nvidia.com/
Packet offload mode:
  ip xfrm state offload packet dev <if-name> dir <in|out>
  ip xfrm policy .... offload packet dev <if-name>
Crypto offload mode:
  ip xfrm state offload crypto dev <if-name> dir <in|out>
or (backward compatibility)
  ip xfrm state offload dev <if-name> dir <in|out>

Thanks

Jianbo Liu (13):
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
  net/mlx5e: Make TC and IPsec offloads mutually exclusive on a netdev

 .../net/ethernet/mellanox/mlx5/core/Makefile  |   4 +
 .../ethernet/mellanox/mlx5/core/en/rep/tc.c   |  17 +-
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   2 +
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  65 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 708 +++++++++++++-----
 .../mlx5/core/en_accel/ipsec_offload.c        |   5 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.c  |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_rxtx.h  |   6 +-
 .../net/ethernet/mellanox/mlx5/core/en_rep.c  |   1 +
 .../net/ethernet/mellanox/mlx5/core/en_rx.c   |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_tc.c   |  47 ++
 .../mellanox/mlx5/core/esw/ipsec_fs.c         | 325 ++++++++
 .../mellanox/mlx5/core/esw/ipsec_fs.h         |  67 ++
 .../net/ethernet/mellanox/mlx5/core/eswitch.h |  17 +
 .../mellanox/mlx5/core/eswitch_offloads.c     | 174 ++++-
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  14 +-
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/eswitch.h                  |   3 +
 include/linux/mlx5/fs.h                       |   2 +
 19 files changed, 1270 insertions(+), 217 deletions(-)
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.c
 create mode 100644 drivers/net/ethernet/mellanox/mlx5/core/esw/ipsec_fs.h

-- 
2.41.0


