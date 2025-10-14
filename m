Return-Path: <netdev+bounces-229398-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C6FF7BDBB29
	for <lists+netdev@lfdr.de>; Wed, 15 Oct 2025 00:48:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 78B8D4FDECC
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 22:46:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC1622DD60F;
	Tue, 14 Oct 2025 22:44:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="de+88Uec"
X-Original-To: netdev@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E47CC23373D
	for <netdev@vger.kernel.org>; Tue, 14 Oct 2025 22:44:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760481881; cv=none; b=Qb65xJEXrY9fgfM1LtSluAVvLeoroxpCpVOaJ1yPrP4RsnbeL5xYicq8pZDIvzoB136Eq1+wj28/WoaTdqnNfQHmcthrGFiR/Tr7AVGMK3Uug79qN1IOBReuKwuP9kbA9YbjM0ncl4lxP290f+hlwBky3FTrpiV61Afq8wXA+BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760481881; c=relaxed/simple;
	bh=zHsgcirQ3hJPe4cOierAdbG+OvVam/Rz0POuOUnCfII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tNAgytHsLRAVQoVK75jiTmqbyMyx0Px1dZKERIq+4feYc8/Xw30IVq5H+tKydKqBqSYfJoqLFNn7ARJFXPdmcLRIaedYCExrbVhf4s+6Sq37TzwsuJTV4OrCrFEGpWmKom76MrM+BoIlqAFuMHQSmcgBm+HOZWuEZOtabiU1Ta4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=de+88Uec; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1760481877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DOQhJNApP637yKZOlWq+admvYqYUfORtGKxHlSzHZjs=;
	b=de+88UecqJr/NJzrc8CQVTx/9w2OtRREGt9KIN/+cpd9XOw2IEpP6quirWFOUVbQEOX1PY
	BLKzUAk/F8FCQfOsfnHNNi15mRPGMs8FYSdkE0jbAWd/9016hSSdNdbigMlq4F76gjUbHv
	rQYQZH7o4BMfFSdbKkik/6tGKrrnJnI=
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
Subject: [PATCH net-next v2 0/7] convert net drivers to ndo_hwtstamp API part 1
Date: Tue, 14 Oct 2025 22:42:09 +0000
Message-ID: <20251014224216.8163-1-vadim.fedorenko@linux.dev>
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

