Return-Path: <netdev+bounces-169359-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EE2CBA4392A
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 10:19:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 573C219E12A3
	for <lists+netdev@lfdr.de>; Tue, 25 Feb 2025 09:13:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC47A263F26;
	Tue, 25 Feb 2025 09:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fekiE170"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42948263C80
	for <netdev@vger.kernel.org>; Tue, 25 Feb 2025 09:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740474573; cv=none; b=VrtVGZIRhTyc0A+nbtDWHF2T+3RfBtEsue1WWEv9eYpcchh5FIza1KJPQdX6/u+9pmkWV4CgQermBSIVLeZEL8uuVvGF9Hs2TKpRbuMlKydmks6FtXxR13CkZCyXgFb5Y3nAW7MVSDi2CojEf1i4tJwoyck8ARQxZl3z5nKRmVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740474573; c=relaxed/simple;
	bh=3SyF92afDOn91GOA4VLtpi+hktql8pF4fEirFHsgAHk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=P8XeG9BDOfntT4M+iMFi3MlojaiOreNsbseaazO6M14GLQQpqK3VLDs78L9r7GgTkDWuqt5V2+dQi41+sdzg6np7rCpH3Y18lUBZGJh+TzADgjelcVA98MwhJa9siE/R70jCsk/TiA+P6yo/ZDWM5cSLZrGNIF6zuwn9n1y/yyE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fekiE170; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1740474572; x=1772010572;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3SyF92afDOn91GOA4VLtpi+hktql8pF4fEirFHsgAHk=;
  b=fekiE170yRLz8xugvxyIK3KPqZKD/aPhNd8TxEPrfOtt/FKC66orFzLS
   haeOwJ6TEGJl2E09F3zBpmOIHQ8bcTACfhDEXudSThGpFJzvrlS0x1Lbn
   0+NfC6HRuW4v3mylfSqkuz7GVLKCWEfS1Xsu1YTWODYM2Tov4nuHTK0xF
   KObY5BAeOxbhIccTXVb3JxgQVFZkhkmFmYwl1mcZn1gsCkivQFSbujvxY
   WawezPEVHBpVI7vTfB3fFSIvWm2enBW2dpb6rurTdwD0rh2u/7NsqXtAJ
   MMd6nXBCrUWfLhsZWOb9v/DSV//eQew4sVghjPqglNPmWaGvd/MRVZn98
   Q==;
X-CSE-ConnectionGUID: BghO6v1/Roe22nVpc/KIAg==
X-CSE-MsgGUID: OpFaxZPEQ7miir3FTY0xIA==
X-IronPort-AV: E=McAfee;i="6700,10204,11355"; a="58810344"
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="58810344"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2025 01:09:32 -0800
X-CSE-ConnectionGUID: JM7sHMX5TJCt7JwJyi1paw==
X-CSE-MsgGUID: aPU30UIzQ8K6hHdTzEw2sQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,313,1732608000"; 
   d="scan'208";a="121275685"
Received: from enterprise.igk.intel.com ([10.102.20.175])
  by orviesa003.jf.intel.com with ESMTP; 25 Feb 2025 01:09:30 -0800
From: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Subject: [iwl-net v2 4/5] ice: fix input validation for virtchnl BW
Date: Tue, 25 Feb 2025 10:08:48 +0100
Message-ID: <20250225090847.513849-7-martyna.szapar-mudlaw@linux.intel.com>
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

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

Add missing validation of tc and queue id values sent by a VF in
ice_vc_cfg_q_bw().
Additionally fixed logged value in the warning message,
where max_tx_rate was incorrectly referenced instead of min_tx_rate.
Also correct error handling in this function by properly exiting
when invalid configuration is detected.

Fixes: 015307754a19 ("ice: Support VF queue rate limit and quanta size configuration")
Reviewed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Co-developed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index adb1bf12542f..824ef849b0ea 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1865,15 +1865,33 @@ static int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 
 	for (i = 0; i < qbw->num_queues; i++) {
 		if (qbw->cfg[i].shaper.peak != 0 && vf->max_tx_rate != 0 &&
-		    qbw->cfg[i].shaper.peak > vf->max_tx_rate)
+		    qbw->cfg[i].shaper.peak > vf->max_tx_rate) {
 			dev_warn(ice_pf_to_dev(vf->pf), "The maximum queue %d rate limit configuration may not take effect because the maximum TX rate for VF-%d is %d\n",
 				 qbw->cfg[i].queue_id, vf->vf_id,
 				 vf->max_tx_rate);
+			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+			goto err;
+		}
 		if (qbw->cfg[i].shaper.committed != 0 && vf->min_tx_rate != 0 &&
-		    qbw->cfg[i].shaper.committed < vf->min_tx_rate)
+		    qbw->cfg[i].shaper.committed < vf->min_tx_rate) {
 			dev_warn(ice_pf_to_dev(vf->pf), "The minimum queue %d rate limit configuration may not take effect because the minimum TX rate for VF-%d is %d\n",
 				 qbw->cfg[i].queue_id, vf->vf_id,
-				 vf->max_tx_rate);
+				 vf->min_tx_rate);
+			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+			goto err;
+		}
+		if (qbw->cfg[i].queue_id > vf->num_vf_qs) {
+			dev_warn(ice_pf_to_dev(vf->pf), "VF-%d trying to configure invalid queue_id\n",
+				 vf->vf_id);
+			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+			goto err;
+		}
+		if (qbw->cfg[i].tc >= ICE_MAX_TRAFFIC_CLASS) {
+			dev_warn(ice_pf_to_dev(vf->pf), "VF-%d trying to configure a traffic class higher than allowed\n",
+				 vf->vf_id);
+			v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+			goto err;
+		}
 	}
 
 	for (i = 0; i < qbw->num_queues; i++) {
-- 
2.47.0


