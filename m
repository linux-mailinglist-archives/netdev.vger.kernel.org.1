Return-Path: <netdev+bounces-116128-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F79A949329
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 16:34:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 531D01C20B58
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 14:34:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8E6834545;
	Tue,  6 Aug 2024 14:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bi7s8MfP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C3818D659
	for <netdev@vger.kernel.org>; Tue,  6 Aug 2024 14:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722954891; cv=none; b=iJY6917bkPy7XMe43Xdk6LmpzdcOH1km9Sz4twRo7o3Rc0VEb8/OQygMMlYUy63GzJZ/7RD0VpsoJhneGzE/86jechlBqSfdOuk5KlLMla9bd5v1eC+E/fUGlI3ADoFFtn5vYrxYcqCgy9CoHckW8sv73EE17+gzwslsbEDuauY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722954891; c=relaxed/simple;
	bh=7RLW7qFpZJTHqlFoGNvHT2tSj2OoA2P8Fx64aVGN18I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=KwtCKVbdmpbWXzhMpylrtboroT0jT+aggTGUCJwfBAw1feBjtqRwyGiXdo4FbXxJpPpVcNxsBsJt0Le/XXhTkcHVBETsA7vlc3XfLqb3aaxsh3eOiVTaXoV2h1JvUqYmc+VGxoh7PK/BBdFLi8CMdvPZvw6ihYVGwPhK601AGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bi7s8MfP; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722954891; x=1754490891;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7RLW7qFpZJTHqlFoGNvHT2tSj2OoA2P8Fx64aVGN18I=;
  b=bi7s8MfP9oLH2MKIfK6KpWs0N1GgTt8JtABAgIgpsYiOuQmPQAr0csR5
   IoL+IOy7XiD2DUemBvCh9hPUeBpMPt03iCHsewVVlrG1ycXf6Wws0v+HX
   Sad6Nw7CWLBxolL+zVxy96KnN4hdwKJCv3Yb68TyxPVT0cvmlx+Ft5JhU
   sN3IU35V8buG34o5YG1EWjCLB2cgwIb1J2tuuR16Y6dTtSHfhOhSeSpGK
   42svoUdLrj20jKn4MiPrXS19hKM3a1SWd0LjcOBR32dpE58copEKxF8Mi
   9qPYD2xeYn4gYYxhYpMgZSjKpC6MRf88ikaEHJBsHqe9HEpynJDs02uqL
   A==;
X-CSE-ConnectionGUID: eT21cIuVTR+8WkNIRAXRTQ==
X-CSE-MsgGUID: zQ7r/vapTa+baJGqpdNdzg==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="38428559"
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="38428559"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 07:34:50 -0700
X-CSE-ConnectionGUID: 7kgU3QunQbm/3Bn0wiRu0A==
X-CSE-MsgGUID: ayUlDcN1S2C+hMDmVJDDHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,268,1716274800"; 
   d="scan'208";a="56502639"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 07:34:46 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 0D1852878D;
	Tue,  6 Aug 2024 15:34:43 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: netdev@vger.kernel.org,
	Ido Schimmel <idosch@nvidia.com>,
	Petr Machata <petrm@nvidia.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Jiri Pirko <jiri@resnulli.us>,
	Andrew Lunn <andrew@lunn.ch>,
	Florian Fainelli <f.fainelli@gmail.com>,
	Vladimir Oltean <olteanv@gmail.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Saeed Mahameed <saeedm@nvidia.com>,
	Leon Romanovsky <leon@kernel.org>,
	Tariq Toukan <tariqt@nvidia.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH net-next 0/5] devlink: embed driver's priv data callback param into devlink_resource
Date: Tue,  6 Aug 2024 16:33:02 +0200
Message-Id: <20240806143307.14839-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

(Patch 1)
Convert dsa to use devl_* variants of devlink resource related
calls, so we could remove devlink_* variants in next 2 patches.

(Patches 2,3)
Remove some unused functions that would otherwise need an update.

(Patch 4, the main one)
Then extend devlink resource to embed driver's priv data callback,
instead just storing a pointer (so drivers could put more context for
similar resource getters, to handle them via simple single function
instead of dumb duplication).

(Patch 5)
Make use of the new possibility from patch 4, I've picked the most
repetitive case.

Motivation: current API was to distracting for me to focus on adding my
new resources :)

I'm fine with it going through mlxsw or just netdev tree.

Przemek Kitszel (5):
  net: dsa: replace devlink resource registration calls by devl_
    variants
  devlink: remove unused devlink_resource_occ_get_register() and
    _unregister()
  devlink: remove unused devlink_resource_register()
  devlink: embed driver's priv data callback param into devlink_resource
  mlxsw: spectrum_kvdl: combine devlink resource occupation getters

 .../net/ethernet/mellanox/mlxsw/spectrum.h    |  5 +
 include/net/devlink.h                         | 18 +---
 .../ethernet/mellanox/mlx5/core/sf/hw_table.c |  5 +-
 drivers/net/ethernet/mellanox/mlxsw/core.c    |  5 +-
 .../net/ethernet/mellanox/mlxsw/spectrum.c    | 19 ++--
 .../ethernet/mellanox/mlxsw/spectrum1_kvdl.c  | 80 +++++++--------
 .../ethernet/mellanox/mlxsw/spectrum_cnt.c    |  9 +-
 .../mellanox/mlxsw/spectrum_policer.c         |  6 +-
 .../mellanox/mlxsw/spectrum_port_range.c      |  2 +-
 .../ethernet/mellanox/mlxsw/spectrum_router.c |  4 +-
 .../ethernet/mellanox/mlxsw/spectrum_span.c   |  3 +-
 drivers/net/netdevsim/dev.c                   | 14 +--
 drivers/net/netdevsim/fib.c                   | 10 +-
 net/devlink/resource.c                        | 97 +++----------------
 net/dsa/devlink.c                             | 23 +++--
 15 files changed, 115 insertions(+), 185 deletions(-)


base-commit: 10a6545f0bdcbb920c6a8a033fe342111d204915
-- 
2.39.3


