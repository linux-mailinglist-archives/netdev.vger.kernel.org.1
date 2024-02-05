Return-Path: <netdev+bounces-69140-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F023849B6A
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 14:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 218D8B2960C
	for <lists+netdev@lfdr.de>; Mon,  5 Feb 2024 13:06:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2FE1BDD0;
	Mon,  5 Feb 2024 13:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNNrO17Z"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45491CAB1
	for <netdev@vger.kernel.org>; Mon,  5 Feb 2024 13:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707138358; cv=none; b=d1CJVosTds0tKSkw8K1JFRwplU/agQlaKxgGh5aNctqzXOwAA7QG+eweSAdpDcm5+rQIGJOQd/MP3MdEVaI08YNudsb9rRYwoswak8LJ/21FZ/5h9TJUWkSNSY+Z8N7KMnbFf3i1U4ASr7eKSvZOx1/W8XpxH0YI3n338jF8uKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707138358; c=relaxed/simple;
	bh=2rdPzuLvOoTXCtTQfHVwbzCqv+wEyRos/fJhSWXzhz4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=SJ2rCHJO9eS2GT/CgUkXxHqolvshS84R/fiAkGVoTB31u6VnYnKSwNy8kEfwbuO1B3gtMJPRTO8jx8B89DCVZxinoZl8/CXTPD/wV/hbh5LBM+U1ljr2duIRBuGdggCIzSUc4w2OT8SXNmAiXuTLPWX5TDpRhthzQbQjJ5EkIk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNNrO17Z; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707138356; x=1738674356;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2rdPzuLvOoTXCtTQfHVwbzCqv+wEyRos/fJhSWXzhz4=;
  b=gNNrO17ZDXQJSbqcU/meCl9InGeD/Oxr7e0ZisW5P4TYG9+p1BdPRHGm
   X+JHoEOobY1uirOaJN080lkuP54GQzs/PgscgYx9SSz01anybHfGvGt6r
   K8FXXVzwsFk56KijSAQzQt4nmMVNW3Zv99+3MM+lpSlwKNT+v0OREkKik
   110iLKKHU9OOIfUHsno3IiIknVhHLzQV+weWzToG5Ub6MIAzKic9cnPRe
   q/G6r7UyrtqgTCjJliOAwIp6Tjt50sMsDqmSn2bTcQ3CPM/j5ACR3Q1Mc
   8a5sFjxifbQqteH4TgROn0goaNzbarbSesnY/3xRT1hewTNBMuLiNCROG
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="407536"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="407536"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Feb 2024 05:05:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10974"; a="933151690"
X-IronPort-AV: E=Sophos;i="6.05,245,1701158400"; 
   d="scan'208";a="933151690"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmsmga001.fm.intel.com with ESMTP; 05 Feb 2024 05:05:52 -0800
Received: from rozewie.igk.intel.com (unknown [10.211.8.69])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CA89227BB5;
	Mon,  5 Feb 2024 13:05:51 +0000 (GMT)
From: Wojciech Drewek <wojciech.drewek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jiri@resnulli.us,
	przemyslaw.kitszel@intel.com,
	vadim.fedorenko@linux.dev,
	paul.m.stillwell.jr@intel.com,
	bcreeley@amd.com
Subject: [PATCH iwl-next v5 0/2] ice devlink reload refactor
Date: Mon,  5 Feb 2024 14:03:55 +0100
Message-Id: <20240205130357.106665-1-wojciech.drewek@intel.com>
X-Mailer: git-send-email 2.40.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Adjust ice driver to the recent devlink changes (commit 9b2348e2d6c9
("devlink: warn about existing entities during reload-reinit")).
According to the discussion[1], ice driver needs to remove and readd
netdev during devlink reload.

Patch 1: Refactor of ice init and deinit paths
Patch 2: Adjust debugfs to the previous changes

[1] https://lore.kernel.org/netdev/ZWdNm5pnmZsrO874@nanopsycho/

v5: Introduce the second patch.

Wojciech Drewek (2):
  ice: Remove and readd netdev during devlink reload
  ice: Fix debugfs with devlink reload

 drivers/net/ethernet/intel/ice/ice.h         |   3 +
 drivers/net/ethernet/intel/ice/ice_debugfs.c |  10 +
 drivers/net/ethernet/intel/ice/ice_devlink.c |  68 ++++++-
 drivers/net/ethernet/intel/ice/ice_fwlog.c   |   2 +
 drivers/net/ethernet/intel/ice/ice_main.c    | 189 ++++++-------------
 5 files changed, 139 insertions(+), 133 deletions(-)

-- 
2.40.1


