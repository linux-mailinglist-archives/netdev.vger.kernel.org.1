Return-Path: <netdev+bounces-199222-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5795ADF7D3
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 22:39:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D605164DE5
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 20:39:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0EDA21B9F0;
	Wed, 18 Jun 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qneuOEFx"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C824188006
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 20:39:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750279141; cv=none; b=KJvEm5UNgt9oSnl37dEWHFKcwak9RzA6l8tMmG2N0gYrVoc0aAyP3L3whlplz71mnACUzrLWCUZJm/vQm5dc8OYH3mpki1R4ixb9VLVcbjcvr2e4CAFXL4wY47L9STvOX6Xt091Irk206FDLPWAZcxiuX4ak71y0IxKHXlLW3pk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750279141; c=relaxed/simple;
	bh=Z1Kesft2KmeKXaJXdvQmIir0e5I0Q7Bat/zqr9NXxSA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RgmjFZsxMYI10LrEpLdZCrp1DMkjVtWOcV4mn6ylpumGR3/On8mU/9Z6TP5vnzSbjnPr+Riz+FgdO/3IaddKBBDOq08tdvOheVYO2xYnWAE+RXehYy8dIY8MpBqPVSUk+SJspWxRyxI4bN0YdfQrJQjft8R+CPR6tS/sAA7HhoQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qneuOEFx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76852C4CEE7;
	Wed, 18 Jun 2025 20:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750279141;
	bh=Z1Kesft2KmeKXaJXdvQmIir0e5I0Q7Bat/zqr9NXxSA=;
	h=From:To:Cc:Subject:Date:From;
	b=qneuOEFxwJMrPlp71MuWjtWcm+sjzPU432wi+/vRaGpGsBKUP8VLjeHd7CgK5ViM/
	 FL4ih+uXNRJUJjtfUoVkgpxhsbx7gucDV+J5UNvH0JqSeqc9bgnYlpg+v6mYZ3egLp
	 y8B+PMpZi4YN/oOffXWOwesTbNc8mjYiIvPp+PSH/nYIjThZa55JxLBy0NziVvAeO5
	 IqsfLwT9NnMVj6l41K18ki12OssBsyyfhDv15szUIVDk1PXyXRZyhtFRN5izR3hOpy
	 Ntiwm+QlgdgykmJ4BrLQacZgQi1TiYPOhn5xX+Pp+c4USet4BdfVsZ2qfCoS6NYJ26
	 hFlKhq6e3qv+A==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	ajit.khaparde@broadcom.com,
	sriharsha.basavapatna@broadcom.com,
	somnath.kotur@broadcom.com,
	shenjian15@huawei.com,
	salil.mehta@huawei.com,
	shaojijie@huawei.com,
	cai.huoqing@linux.dev,
	saeedm@nvidia.com,
	tariqt@nvidia.com,
	louis.peens@corigine.com,
	mbloch@nvidia.com,
	manishc@marvell.com,
	ecree.xilinx@gmail.com,
	joe@dama.to,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 00/10] eth: finish migration to the new RXFH callbacks
Date: Wed, 18 Jun 2025 13:38:13 -0700
Message-ID: <20250618203823.1336156-1-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Finish drivers conversions to callbacks added by
commit 9bb00786fc61 ("net: ethtool: add dedicated callbacks for
getting and setting rxfh fields"). Remove the conditional calling
in the core, rxnfc callbacks are no longer used for RXFH.

Jakub Kicinski (10):
  eth: sfc: falcon: migrate to new RXFH callbacks
  eth: sfc: siena: migrate to new RXFH callbacks
  eth: sfc: migrate to new RXFH callbacks
  eth: benet: migrate to new RXFH callbacks
  eth: qede: migrate to new RXFH callbacks
  eth: mlx5: migrate to new RXFH callbacks
  eth: nfp: migrate to new RXFH callbacks
  eth: hinic: migrate to new RXFH callbacks
  eth: hns3: migrate to new RXFH callbacks
  net: ethtool: don't mux RXFH via rxnfc callbacks

 drivers/net/ethernet/hisilicon/hns3/hnae3.h   |   4 +-
 .../hns3/hns3_common/hclge_comm_rss.h         |   4 +-
 .../mellanox/mlx5/core/en/fs_ethtool.h        |  14 +++
 drivers/net/ethernet/sfc/ethtool_common.h     |   2 +
 .../net/ethernet/sfc/siena/ethtool_common.h   |   2 +
 .../net/ethernet/emulex/benet/be_ethtool.c    |  57 +++++-----
 .../hns3/hns3_common/hclge_comm_rss.c         |   6 +-
 .../ethernet/hisilicon/hns3/hns3_ethtool.c    |  33 ++++--
 .../hisilicon/hns3/hns3pf/hclge_main.c        |   4 +-
 .../hisilicon/hns3/hns3vf/hclgevf_main.c      |   4 +-
 .../net/ethernet/huawei/hinic/hinic_ethtool.c |  47 +++-----
 .../ethernet/mellanox/mlx5/core/en_ethtool.c  |  19 ++++
 .../mellanox/mlx5/core/en_fs_ethtool.c        |  25 ++---
 .../mellanox/mlx5/core/ipoib/ethtool.c        |  19 ++++
 .../ethernet/netronome/nfp/nfp_net_ethtool.c  |  17 +--
 .../net/ethernet/qlogic/qede/qede_ethtool.c   |  22 ++--
 drivers/net/ethernet/sfc/ethtool.c            |   1 +
 drivers/net/ethernet/sfc/ethtool_common.c     | 104 +++++++++---------
 drivers/net/ethernet/sfc/falcon/ethtool.c     |  51 +++++----
 drivers/net/ethernet/sfc/siena/ethtool.c      |   1 +
 .../net/ethernet/sfc/siena/ethtool_common.c   |  77 ++++++-------
 net/ethtool/ioctl.c                           |  59 +++-------
 22 files changed, 308 insertions(+), 264 deletions(-)

-- 
2.49.0


