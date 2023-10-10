Return-Path: <netdev+bounces-39504-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DD7357BF904
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 12:51:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 971B4281B6E
	for <lists+netdev@lfdr.de>; Tue, 10 Oct 2023 10:51:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6E0DF69;
	Tue, 10 Oct 2023 10:51:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C/Lx9EWz"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356AB4C6E
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 10:51:25 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [134.134.136.100])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F0C894
	for <netdev@vger.kernel.org>; Tue, 10 Oct 2023 03:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1696935083; x=1728471083;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XNwKCGLEkAPwZNEdnyhmp4mx8a2HTWHdOZOU7jyB6wA=;
  b=C/Lx9EWzOCUlQGkZMXpgARy+97SzvwrQX9l9teW063hlOAnv2hT3mJC6
   qIi82Amn3vVEkuEwETEUT3EEIFFz0fqOT/8pq71pZh7s8e/+Lhz5o3hLV
   JQwkSi9LSZ2PF68UAcdCHBUr8XUDrZG/MBag9LfvUJw92b5BrQGzdwdxK
   JRn4gM1GQjdzO8/KmvePH6yqByVg9M75nfbrN7YbGcT+4eD/Dsqoob1QL
   RZDP15nRguTDcQpn+6UxEiCTonskHzx8iC58ER3j89JB9gg56TH8rt4R2
   Vx8amqP40appdUnnc+g+pXep2pt2lwWVDwaHQoyMzOJP0ed82eSDYtfv9
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="450859568"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="450859568"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2023 03:50:56 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10858"; a="1084726147"
X-IronPort-AV: E=Sophos;i="6.03,212,1694761200"; 
   d="scan'208";a="1084726147"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2023 03:50:49 -0700
Received: from pelor.igk.intel.com (pelor.igk.intel.com [10.123.220.13])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id C5E6F386C1;
	Tue, 10 Oct 2023 11:50:46 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Jiri Pirko <jiri@resnulli.us>,
	netdev@vger.kernel.org,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Michael Chan <michael.chan@broadcom.com>,
	Edwin Peer <edwin.peer@broadcom.com>,
	Cai Huoqing <cai.huoqing@linux.dev>,
	Luo bin <luobin9@huawei.com>,
	George Cherian <george.cherian@marvell.com>,
	Danielle Ratson <danieller@nvidia.com>,
	Moshe Shemesh <moshe@nvidia.com>,
	Saeed Mahameed <saeedm@nvidia.com>
Cc: Brett Creeley <brett.creeley@amd.com>,
	Vasundhara Volam <vasundhara-v.volam@broadcom.com>,
	Sunil Goutham <sgoutham@marvell.com>,
	Linu Cherian <lcherian@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Jerin Jacob <jerinj@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Eran Ben Elisha <eranbe@nvidia.com>,
	Aya Levin <ayal@mellanox.com>,
	Leon Romanovsky <leon@kernel.org>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next v1 0/8] devlink: retain error in struct devlink_fmsg
Date: Tue, 10 Oct 2023 12:43:10 +0200
Message-Id: <20231010104318.3571791-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
	lindbergh.monkeyblade.net

Extend devlink fmsg to retain error, and return it at each subsequent call
(patch 1), so drivers could omit all but last error checks (the rest of
the patches).

I would be happy to re-send patches 3-8 as separate to their vendors
maintainers, to don't block merge of 1st one (as they are kind of
illustration here).

Especially mlx5 is massive thanks to custom fmsg API wrappers,
thus it's last.

Przemek Kitszel (8):
  devlink: retain error in struct devlink_fmsg
  netdevsim: devlink health: use retained error fmsg API
  pds_core: devlink health: use retained error fmsg API
  bnxt_en: devlink health: use retained error fmsg API
  hinic: devlink health: use retained error fmsg API
  octeontx2-af: devlink health: use retained error fmsg API
  mlxsw: core: devlink health: use retained error fmsg API
  net/mlx5: devlink health: use retained error fmsg API

 drivers/net/ethernet/amd/pds_core/devlink.c   |  27 +-
 .../net/ethernet/broadcom/bnxt/bnxt_devlink.c |  59 +--
 .../net/ethernet/huawei/hinic/hinic_devlink.c | 181 ++-----
 .../marvell/octeontx2/af/rvu_devlink.c        | 462 +++++-------------
 .../mellanox/mlx5/core/diag/fw_tracer.c       |  32 +-
 .../mellanox/mlx5/core/diag/reporter_vnic.c   | 108 ++--
 .../ethernet/mellanox/mlx5/core/en/health.c   | 144 +-----
 .../mellanox/mlx5/core/en/reporter_rx.c       | 357 +++-----------
 .../mellanox/mlx5/core/en/reporter_tx.c       | 275 +++--------
 .../net/ethernet/mellanox/mlx5/core/health.c  |  85 +---
 drivers/net/ethernet/mellanox/mlxsw/core.c    | 140 ++----
 drivers/net/netdevsim/health.c                | 103 +---
 net/devlink/health.c                          | 255 ++++------
 13 files changed, 561 insertions(+), 1667 deletions(-)

-- 
2.40.1


