Return-Path: <netdev+bounces-230117-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C571BE4378
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 17:27:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 798BA35989E
	for <lists+netdev@lfdr.de>; Thu, 16 Oct 2025 15:27:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F389F34AAE9;
	Thu, 16 Oct 2025 15:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="lirt4YTg"
X-Original-To: netdev@vger.kernel.org
Received: from out-182.mta1.migadu.com (out-182.mta1.migadu.com [95.215.58.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C51F532D452
	for <netdev@vger.kernel.org>; Thu, 16 Oct 2025 15:27:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760628427; cv=none; b=cF584lZg1z0tlLVUYJXRAqxSMstPSel9WYsCwdDxyvkm5fq150dyCCrsZmuqoK6v3JTxoE1XMxGCm2xjZe2nxaJhyhmRbTsbnzeYihOTGOx9APk90PepLy4CBjWPw+n8PVTZ2hlXEv21NozWk5TbMxPf5KfnzYCJ1lc052zjQsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760628427; c=relaxed/simple;
	bh=vrNZEK6wgZQycZvmRhs/7wiGfSORKwBTfJEbe977b2k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Os9NxCHVIbT6N5pglTGCCh4CpWHNWq9ApNwQqq76I2VDbqYeE3SmjIyqBdsvyQmRnCZMTtoxnJjDBzm1CemlZIuQkRRxOnoNgYXC/zvdWQmAaRnmtBIzNfbNiJ24K/tsbTKmylwgYesuPc82IMT3Oo8IpCE6fe19dFSJaqhcuFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=lirt4YTg; arc=none smtp.client-ip=95.215.58.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760628420;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=Aw++Wiv1mlai/8OtVPJlJEqH72SkIbF7KJE6GjsQsMQ=;
	b=lirt4YTgqmQx9Myrd02fYfOxAt5B4bbl/4jbcMJkwR07UUZrA+sk3s6LV9uV9wmuXH0OZ2
	wim3BdK02Y4VgVunmJFsA7yZYNf671u2mmsIQwP2vuneJZ50ECWx/yg5g84S+61dFsvumO
	6L0aEWD1NrLrXDZazbzgdZ5pKm+kjkk=
From: Vadim Fedorenko <vadim.fedorenko@linux.dev>
To: Shyam Sundar S K <Shyam-sundar.S-k@amd.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Egor Pomozov <epomozov@marvell.com>,
	Potnuri Bharat Teja <bharat@chelsio.com>,
	Dimitris Michailidis <dmichail@fungible.com>,
	MD Danish Anwar <danishanwar@ti.com>,
	Roger Quadros <rogerq@kernel.org>
Cc: Richard Cochran <richardcochran@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	Vadim Fedorenko <vadim.fedorenko@linux.dev>
Subject: [PATCH net-next v3 0/7] convert net drivers to ndo_hwtstamp API part 1
Date: Thu, 16 Oct 2025 15:25:08 +0000
Message-ID: <20251016152515.3510991-1-vadim.fedorenko@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

This is part 1 of patchset to convert drivers which support HW 
timestamping to use .ndo_hwtstamp_get()/.ndo_hwtstamp_set() callbacks.
The new API uses netlink to communicate with user-space and have some
test coverage. Part 2 will contain another 6 patches from v1 of the
series.
There are some drivers left with old ioctl interface after this series:
- mlx5 driver be shortly converted by nVidia folks
- TI netcp ethss driver which needs separate series which I'll post
  after this one. 

v1 -> v2:
- split series into 2 to avoid spamming a lot of maintainers
v2 -> v3:
- patch 5 cxgb4: add explanation of the change in the logic of this
  driver as it's behaviour was inconsistent
- collect tags from Jacob and Simon

Vadim Fedorenko (7):
  net: ti: am65-cpsw: move hw timestamping to ndo callback
  ti: icssg: convert to ndo_hwtstamp API
  amd-xgbe: convert to ndo_hwtstamp callbacks
  net: atlantic: convert to ndo_hwtstamp API
  cxgb4: convert to ndo_hwtstamp API
  tsnep: convert to ndo_hwtstatmp API
  funeth: convert to ndo_hwtstamp API

 drivers/net/ethernet/amd/xgbe/xgbe-drv.c      |  24 +--
 drivers/net/ethernet/amd/xgbe/xgbe-hwtstamp.c |  28 ++--
 drivers/net/ethernet/amd/xgbe/xgbe.h          |  11 +-
 .../net/ethernet/aquantia/atlantic/aq_main.c  |  66 ++------
 .../net/ethernet/aquantia/atlantic/aq_ptp.c   |   6 +-
 .../net/ethernet/aquantia/atlantic/aq_ptp.h   |   8 +-
 drivers/net/ethernet/chelsio/cxgb4/cxgb4.h    |   2 +-
 .../net/ethernet/chelsio/cxgb4/cxgb4_main.c   | 154 +++++++++---------
 drivers/net/ethernet/engleder/tsnep.h         |   8 +-
 drivers/net/ethernet/engleder/tsnep_main.c    |  14 +-
 drivers/net/ethernet/engleder/tsnep_ptp.c     |  88 +++++-----
 drivers/net/ethernet/fungible/funeth/funeth.h |   4 +-
 .../ethernet/fungible/funeth/funeth_main.c    |  40 ++---
 drivers/net/ethernet/ti/am65-cpsw-nuss.c      |  44 +++--
 drivers/net/ethernet/ti/icssg/icssg_common.c  |  47 ++----
 drivers/net/ethernet/ti/icssg/icssg_prueth.c  |   4 +-
 drivers/net/ethernet/ti/icssg/icssg_prueth.h  |   6 +-
 .../net/ethernet/ti/icssg/icssg_prueth_sr1.c  |   4 +-
 18 files changed, 235 insertions(+), 323 deletions(-)

-- 
2.47.3

