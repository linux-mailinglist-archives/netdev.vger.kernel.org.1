Return-Path: <netdev+bounces-71080-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55BCE851F3C
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 22:12:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DF4B5B20E75
	for <lists+netdev@lfdr.de>; Mon, 12 Feb 2024 21:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A5C4B5CD;
	Mon, 12 Feb 2024 21:12:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="W2qjlo/H"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.55.52.88])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5286C4C601
	for <netdev@vger.kernel.org>; Mon, 12 Feb 2024 21:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.55.52.88
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707772331; cv=none; b=HVfiyQ/ugqLwNTQhfWqDFwxwYIwxeXkt2kMWRstOYjmt6QAeNB3i8uiQidRZUewEvOTIw1QiVy1YUpjJQwiyZ8BOxCTlbtYTw91uiRFQQ/KmXeBp2K8kEbVLqR3w61Jxj1w3RHgrCxQYCGTbk5WG2afrbsWTchYnE7SLcwSY1Io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707772331; c=relaxed/simple;
	bh=le4doQl7XUShkIH93blc8YeYAX2UsO2mp/sk0RcAZjA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=u0ZyDt4nqlEigdKbD+bkmA0Mxq9tyciiJgyVwcG63JREX332fMnMtphVurbCgcD/aZP7L/i/wPYDa3ieFXAVwXSpgO6fJNdoxdKQSnpMCd8uVcqBC8NhUl27yZcNdiZW2n65JCcHShkKRtq5KXF+yaemHiXckTfOyqCXdBzmiEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=W2qjlo/H; arc=none smtp.client-ip=192.55.52.88
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707772329; x=1739308329;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=le4doQl7XUShkIH93blc8YeYAX2UsO2mp/sk0RcAZjA=;
  b=W2qjlo/HMeH4vH6vPI5qx8aVopIKMHDf5QmypH2WRToP6OTFxauvuswx
   w3c8OeIUsis2BR5zc5ALt8xL+L/DPweswS9zt1Wjcc1UCQoqrVZN6VEh0
   gDBgsXQNvODlCuInDq0YwHflnAPhvbXt45vZmLtdiBhlBRyBKS5Lm+m5F
   3U42C0ylnxAT6Jzu/quz9mKrQ+63DyACcsHLFJnKW6QuCH/6UbF/xLa8K
   3JBl8Tl7Xv2Xvzblv0Oi53qBHNyJTd/bOjP0vyhZ6z4slnVwzgGEVkKWM
   OGs/8C1iU+Td+H714sMQIAQZfkMKowMv9xQohOjC0PgbFZ4dIq4bjYYXL
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="436910901"
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="436910901"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 13:12:07 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,155,1705392000"; 
   d="scan'208";a="7335608"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 12 Feb 2024 13:12:07 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net-next 0/5][pull request] Intel Wired LAN Driver Updates 2024-02-12 (ice)
Date: Mon, 12 Feb 2024 13:11:54 -0800
Message-ID: <20240212211202.1051990-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This series contains updates to ice driver only.

Grzegorz adds support for E825-C devices.

Wojciech reworks devlink reload to fulfill expected conditions (remove
and readd).

The following are changes since commit 0f37666d87d2dea42ec21776c3d562b7cbd71612:
  Merge branch 'net-avoid-slow-rcu'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 100GbE

Grzegorz Nitka (3):
  ice: introduce new E825C devices family
  ice: Add helper function ice_is_generic_mac
  ice: add support for 3k signing DDP sections for E825C

Wojciech Drewek (2):
  ice: Remove and readd netdev during devlink reload
  ice: Fix debugfs with devlink reload

 drivers/net/ethernet/intel/ice/ice.h          |   3 +
 drivers/net/ethernet/intel/ice/ice_common.c   |  37 ++++
 drivers/net/ethernet/intel/ice/ice_common.h   |   2 +
 drivers/net/ethernet/intel/ice/ice_controlq.c |   2 +-
 drivers/net/ethernet/intel/ice/ice_ddp.c      |   4 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c  |  10 +
 drivers/net/ethernet/intel/ice/ice_devids.h   |   8 +
 drivers/net/ethernet/intel/ice/ice_devlink.c  |  68 +++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.c    |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c     | 199 ++++++------------
 drivers/net/ethernet/intel/ice/ice_type.h     |   1 +
 11 files changed, 200 insertions(+), 136 deletions(-)

-- 
2.41.0


