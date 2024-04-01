Return-Path: <netdev+bounces-83789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 78BC589444C
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 19:24:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9E5F1C21B09
	for <lists+netdev@lfdr.de>; Mon,  1 Apr 2024 17:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A6115024E;
	Mon,  1 Apr 2024 17:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DPnXo1lQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66E264DA0F
	for <netdev@vger.kernel.org>; Mon,  1 Apr 2024 17:24:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711992273; cv=none; b=X8MySd4cnDhW+IRr3+L39DX2gXAvmNA7sJnJ7fkbYdctQuVOM4XJJFYwVSd6HAQVAdiFzbWbnM9sTnKe6T2Ym+2i+DX02FVKcmT+JklYiMxT2FDJZ20K0RkZHuvUXl0hRMaIGBNX8lIBvuVfpdshwhJ3a1nbZ3U+4c2+ogIzCJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711992273; c=relaxed/simple;
	bh=YUPqIRMzJLRToXsWN+e/Ea6X8HeHV1yv1HHJgqJJ3kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PXs78m+af9yP88Sm4U85ukL08PmnS6gpS6MG5aOT8PwQBAxp+IEkBkN4EJ0MBgJbitf5tRliyn6Pc9DufFoVWyIT9eCz9Un5b6Bh+pQW/IyNcBg1RDMQicl07+zQaLMRUMtzgTcaet3iDKEhFKnxWkNEvSUBXZnAgXmDMVc7diY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DPnXo1lQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711992272; x=1743528272;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=YUPqIRMzJLRToXsWN+e/Ea6X8HeHV1yv1HHJgqJJ3kA=;
  b=DPnXo1lQRP3IR0KBcI30c/sbUEEZOzJOhbizkoC4AUzypP+SLIHbbgPL
   kj3cvK475TJT+GsJt1bKA/eVdVWlhIQaPpMiNl2AK7JNd+iBibLLlnDWd
   XcPOIZS05O/+LadqOW1OqIje8p+q9KjglUvH+Ui4yzWERcVZT0ODCVoYp
   cpAzXxXzB+kv/eCoD4/HITkZWmOfsIqAKgqBCAW3iqbHDiFNGi2cjd3n9
   UZM/5HSgyYOgiWYPK/kutru+83rwaQKLNn6+wWgqZurnoZi0FNIlYftWz
   jSzutuCJxyj7d67ix5EUS/s2zcwhM4QF+oPvIvm8tJxAwQuKg8AVTYgst
   A==;
X-CSE-ConnectionGUID: RyCDxmabQX2AW4Ewkqx93Q==
X-CSE-MsgGUID: YAWUratmTn+dEjebBqWwRw==
X-IronPort-AV: E=McAfee;i="6600,9927,11031"; a="29606169"
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="29606169"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2024 10:24:28 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,172,1708416000"; 
   d="scan'208";a="55235093"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa001.jf.intel.com with ESMTP; 01 Apr 2024 10:24:27 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Thorsten Blum <thorsten.blum@toblux.com>,
	anthony.l.nguyen@intel.com
Subject: [PATCH net-next 5/8] ice: Remove newlines in NL_SET_ERR_MSG_MOD
Date: Mon,  1 Apr 2024 10:24:15 -0700
Message-ID: <20240401172421.1401696-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
References: <20240401172421.1401696-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Thorsten Blum <thorsten.blum@toblux.com>

Fixes Coccinelle/coccicheck warnings reported by newline_in_nl_msg.cocci.

Signed-off-by: Thorsten Blum <thorsten.blum@toblux.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_devlink.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_devlink.c b/drivers/net/ethernet/intel/ice/ice_devlink.c
index b516e42b41f0..3c3616f0f811 100644
--- a/drivers/net/ethernet/intel/ice/ice_devlink.c
+++ b/drivers/net/ethernet/intel/ice/ice_devlink.c
@@ -478,17 +478,17 @@ ice_devlink_reload_down(struct devlink *devlink, bool netns_change,
 	case DEVLINK_RELOAD_ACTION_DRIVER_REINIT:
 		if (ice_is_eswitch_mode_switchdev(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Go to legacy mode before doing reinit\n");
+					   "Go to legacy mode before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		if (ice_is_adq_active(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Turn off ADQ before doing reinit\n");
+					   "Turn off ADQ before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		if (ice_has_vfs(pf)) {
 			NL_SET_ERR_MSG_MOD(extack,
-					   "Remove all VFs before doing reinit\n");
+					   "Remove all VFs before doing reinit");
 			return -EOPNOTSUPP;
 		}
 		ice_devlink_reinit_down(pf);
-- 
2.41.0


