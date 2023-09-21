Return-Path: <netdev+bounces-35383-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EA39C7A940E
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 14:10:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 29F01281231
	for <lists+netdev@lfdr.de>; Thu, 21 Sep 2023 12:10:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F44FAD2C;
	Thu, 21 Sep 2023 12:10:44 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 386A9A956
	for <netdev@vger.kernel.org>; Thu, 21 Sep 2023 12:10:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14856C4E663;
	Thu, 21 Sep 2023 12:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695298243;
	bh=3zUerJob8LTaLhGfDXM3f8fNe7+0Vp+OP7wcaT6sgF0=;
	h=From:To:Cc:Subject:Date:From;
	b=UEI4nhusOGx2X/DJ36lARYRKoo5KvubaseFamdvlR+YELv35D+Ps9pJ9pbXkq3OnP
	 JoWgE04zwdU7oP0s1PH2F+4xjsh3PiJjUsrq95W2FniU4N4yefFdfCebjBlm14j656
	 u5G9eI+SBC/Z/r6nu7TAKyJVraOnhpQqFHa2g08OpZVzghOvPdRAYMRzYaah/SWASA
	 wTzkxCMPIWzbW08MAYVWW7qLf7qia5RLSpKl5wGXbsRprALAgoP09lmURY8WzuWeXb
	 IW6qZpd0km/CXSqxWbJAPFHsjCt6yXB5Xg37vLYeukeIHr4Y/8Hr9Sr/D9cV8hLYPc
	 6tE4GxhLaR64w==
From: Leon Romanovsky <leon@kernel.org>
To: Jason Gunthorpe <jgg@nvidia.com>
Cc: Leon Romanovsky <leonro@nvidia.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	linux-rdma@vger.kernel.org,
	Mark Bloch <mbloch@nvidia.com>,
	netdev@vger.kernel.org,
	Paolo Abeni <pabeni@redhat.com>,
	Patrisious Haddad <phaddad@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH mlx5-next 0/9] Support IPsec packet offload in multiport RoCE devices
Date: Thu, 21 Sep 2023 15:10:26 +0300
Message-ID: <cover.1695296682.git.leon@kernel.org>
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

This series from Patrisious extends mlx5 to support IPsec packet offload
in multiport devices (MPV, see [1] for more details).

These devices have single flow steering logic and two netdev interfaces,
which require extra logic to manage IPsec configurations as they performed
on netdevs.

Thanks

[1] https://lore.kernel.org/linux-rdma/20180104152544.28919-1-leon@kernel.org/

Thanks

Patrisious Haddad (9):
  RDMA/mlx5: Send events from IB driver about device affiliation state
  net/mlx5: Register mlx5e priv to devcom in MPV mode
  net/mlx5: Store devcom pointer inside IPsec RoCE
  net/mlx5: Add alias flow table bits
  net/mlx5: Implement alias object allow and create functions
  net/mlx5: Add create alias flow table function to ipsec roce
  net/mlx5: Configure IPsec steering for egress RoCEv2 MPV traffic
  net/mlx5: Configure IPsec steering for ingress RoCEv2 MPV traffic
  net/mlx5: Handle IPsec steering upon master unbind/bind

 drivers/infiniband/hw/mlx5/main.c             |  17 +
 drivers/net/ethernet/mellanox/mlx5/core/cmd.c |  70 +++
 drivers/net/ethernet/mellanox/mlx5/core/en.h  |   8 +
 .../mellanox/mlx5/core/en_accel/ipsec.c       |   3 +-
 .../mellanox/mlx5/core/en_accel/ipsec.h       |  25 +-
 .../mellanox/mlx5/core/en_accel/ipsec_fs.c    | 122 +++-
 .../mlx5/core/en_accel/ipsec_offload.c        |   3 +-
 .../net/ethernet/mellanox/mlx5/core/en_main.c |  63 ++
 .../net/ethernet/mellanox/mlx5/core/fs_core.c |  10 +-
 .../ethernet/mellanox/mlx5/core/lib/devcom.h  |   1 +
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.c    | 542 +++++++++++++++++-
 .../mellanox/mlx5/core/lib/ipsec_fs_roce.h    |  14 +-
 .../net/ethernet/mellanox/mlx5/core/main.c    |   6 +
 .../ethernet/mellanox/mlx5/core/mlx5_core.h   |  22 +
 include/linux/mlx5/device.h                   |   2 +
 include/linux/mlx5/driver.h                   |   2 +
 include/linux/mlx5/mlx5_ifc.h                 |  56 +-
 17 files changed, 925 insertions(+), 41 deletions(-)

-- 
2.41.0


