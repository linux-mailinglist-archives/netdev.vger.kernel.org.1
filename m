Return-Path: <netdev+bounces-169357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 892E2A4390E
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:16:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9866316EF45
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17498262D1B;
	Tue, 25 Feb 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YjrG206e"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E637262819
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474569; cv=none; b=C27Z+pNE7vQr3EUWrBjOtTJwMpB+fRdrrA534jD/iknMJAUqMjXesTuQCAfTbtljQFia8CHWBWzbtNjyQXG93W4JAorFj6x0ynX7Dw1deeIeJaxwVOMBhyTMmoVvU8ig/AwNm/g2CkfHu2XddN5QSzzW5pgkLsMe0mEzdORq1RE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474569; c=relaxed/simple;
	bh=67Gu1RmjPR1JY++tARVEZch0cjxi0tgthD21eX8Tu5U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=g9jdpLXsZwa7SNd3tlQ8HMMRWBEvfgBHk/zpw3yCetZiRjkF+a1vS+ajmZxUBA9XoBQOiheZ4et3lDbDr32xMj5ZfRw7navbXkgnuK3zg6rF+RMvX0KXnNWZ1HrtulpqO+N5co9Xdi9OUklHBRa+q9Gmj/UfUbdrBgbf4t7aoAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YjrG206e; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474567; x=1772010567;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=67Gu1RmjPR1JY++tARVEZch0cjxi0tgthD21eX8Tu5U=;
  b=YjrG206eEAlZj3352pTBywXcwQU0ASfxDPjTawjJhIBxZInCIGSGwMqi
   wd0cWw8l1OsOPnmCUVxQoyhRfIdJotTDo/jX71byQ3/1jKxPmHQrJ8mfg
   M1ECWwSrm+1OiYWpY5dJNco5iTxoihqwKqEjOjIjwOxHg1YocYyZesOeG
   FGW7O5uzp7pq5A7/oucLD4jtxsX+OgS4UFCJkImHbLarsMv4NX7Hce/jS
   FKyTYXrmjy/Xu1udHZrQoh+POBvFbiHCVarVMAz+jvuB9hOMVRaEceQgs
   DDlRjrcvuZWzGGpWUbfzSTiXXECB3jym6Zfb8RPm5sOJe2azLP453Fui3
   w==;
X-CSE-ConnectionGUID: K5dBJ+cnSSmobwzJz+Oazg==
X-CSE-MsgGUID: M0/muae6TTqozgAiAdlDXg==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58810337"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58810337"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:09:27 -0800
X-CSE-ConnectionGUID: P0tmYXlQSvaWoPO4+gfNRA==
X-CSE-MsgGUID: /QTdNHudQZ6SfJ9Mtb3TFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121275634"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 01:09:26 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Jan Glaza <jan.glaza@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v2 2/5] ice: stop truncating queue ids when checking
Date: Tue, 25 Feb 2025 10:08:46 +0100
Message-ID: <20250225090847.513849-5-martyna.szapar-mudlaw@linux.intel.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
References: <20250225090847.513849-2-martyna.szapar-mudlaw@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Glaza <jan.glaza@intel.com>

Queue IDs can be up to 4096, fix invalid check to stop
truncating IDs to 8 bits.

Fixes: bf93bf791cec8 ("ice: introduce ice_virtchnl.c and ice_virtchnl.h")
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Jan Glaza <jan.glaza@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index b6285433307c..343f2b4b0dc5 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -565,7 +565,7 @@ bool ice_vc_isvalid_vsi_id(struct ice_vf *vf, u16 vsi_id)
  *
  * check for the valid queue ID
  */
-static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u8 qid)
+static bool ice_vc_isvalid_q_id(struct ice_vsi *vsi, u16 qid)
 {
 	/* allocated Tx and Rx queues should be always equal for VF VSI */
 	return qid < vsi->alloc_txq;
-- 
2.47.0


