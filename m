Return-Path: <netdev+bounces-108860-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A276292617D
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:12:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BFEE28E96C
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:12:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 164FA178CF1;
	Wed,  3 Jul 2024 13:12:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LBtVEfda"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAE0178CEE;
	Wed,  3 Jul 2024 13:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012345; cv=none; b=kneq7HTJV3Lb/irjuZ1y+j5J59vsUEFkPs9dhsXnAdlxqqHBCpsXy9jTfQiwxqI28yRZGxojcXYBczrsJ1jtKtLrWxcjmYEshALJTqMWuqNXcr3MyR3ratASsW/O4HN5B4hW8VTAfDbSnE8YDx+cfzfUomKAS9gekutXpyXZlSo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012345; c=relaxed/simple;
	bh=TgQuOL8SI7Nc9fdOtjuyx541WCdNgM8oiZbIvEF6n1Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Ekh4ZRp0udvrXs5Mb7kgz8CH8NgVRnTyxXmVp1sfMOwUda7Smb3wKYQuWB98XkeUV0EiM5xlHPitw8FMbvKDY5oHWQ267yH58FqZqqrAqmvRZS19ziQNItlVg/H8ShWE3ZhEWmczUDI7nbYx2xjPz//37nFgw0RkJBVyLwNmwO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LBtVEfda; arc=none smtp.client-ip=192.198.163.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012343; x=1751548343;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=TgQuOL8SI7Nc9fdOtjuyx541WCdNgM8oiZbIvEF6n1Y=;
  b=LBtVEfdalMAaC0N33deH7V21banARdyOaKjNEdfiamemQlhiR4ufei2B
   NPaxGJ/Xi33VcOHDiWK1lgr2FZGvC6frp0yEq6Am2pLNylvOS8rcLC2wg
   JkzjXeExIYTOrejzOyhwWh8N+rbTSum3I4ZPR/6Q29m5+Vdr1oVuSeq93
   pCdiUsi52NPryFj5aYJ0556+2ArOTOJ1ntNoB7z4DtFkceqjqjx4mRiM9
   k0AEXb6QrN78+BEHipnOPSNsXalM41UunPc/CoGYNWuKgtpRoaQ98JuwB
   j5Nk521kiKUkJEWy6z+4UIDzk5K3wZYnk5U60yvbk9YZtt573EBph7NBQ
   w==;
X-CSE-ConnectionGUID: fyt6E6XjR/KwqmyGxvxOaw==
X-CSE-MsgGUID: s+31pviuRPivgi0nr0wwOw==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="27857006"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="27857006"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by fmvoesa105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:12:14 -0700
X-CSE-ConnectionGUID: FCjh+Tf5TgCx7agfVAZgtA==
X-CSE-MsgGUID: R3ZN7De1TiaiUMnBA+0gYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="46321487"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa010.fm.intel.com with ESMTP; 03 Jul 2024 06:12:11 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id D45D828778;
	Wed,  3 Jul 2024 14:12:09 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v1 0/6] Add support for devlink health events
Date: Wed,  3 Jul 2024 08:59:16 -0400
Message-Id: <20240703125922.5625-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reports for two kinds of events are implemented, Malicious Driver
Detection (MDD) and Tx hang.

Patches 1, 2: minor core improvements (checkpatch.pl and devlink extension)
Patches 3, 4, 5: ice devlink health infra + straightforward status reports
Patch 6: extension to dump also skb on Tx hang, this patch have much of
 copy-paste from:
 - net/core/skbuff.c (function skb_dump() - modified to dump into buffer)
 - lib/hexdump.c (function print_hex_dump() - adjusted)

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Przemek Kitszel (5):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: add Tx hang devlink health reporter
  ice: print ethtool stats as part of Tx hang devlink health reporter
  ice: devlink health: dump also skb on Tx hang

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../intel/ice/devlink/devlink_health.c        | 485 ++++++++++++++++++
 .../intel/ice/devlink/devlink_health.h        |  45 ++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   |  19 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  17 +-
 include/net/devlink.h                         |  11 +
 scripts/checkpatch.pl                         |   2 +
 10 files changed, 586 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h

-- 
2.38.1

