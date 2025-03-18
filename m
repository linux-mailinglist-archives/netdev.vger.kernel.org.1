Return-Path: <netdev+bounces-175884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1346EA67DB2
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:06:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD74B19C7E59
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADD2B2139D4;
	Tue, 18 Mar 2025 20:05:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="DMKIPOcR"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 194C62135AD
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328326; cv=none; b=UDg+VJcZJxa9GlF0OPKQleg4dqS24aiVQtw0swY9xLbaMsqlDJODO9f6J6VxWEWWQ23G5kZ2y+5bp/DJC++IxStdrV0+gGZprXgPz/aS73o04BaGNHZUVZOrfd4F3mt9vTyY2AKPHrNcQA0z5IfqLtE4QBpFKfX0uwtrXyl6S6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328326; c=relaxed/simple;
	bh=JE91QTRS9s/PJnY8bLhmfV8ebey4gflG/1BZ7/jTCW0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E9PJzwh2tTnfhgWTW7Iy/+5sxHbFTUyFgaoDmOOeY9tAjoDfXw/v+kOrevzu8DwdZ3e5NVRx2AeBueeqkoO/ylqNz2gn5D5XuqGNBL4ddV40RCRTCG4o7hAxsp4IPNS2cnrkxiGkeqY9I3kBxlseDE++ot7kRVNPHIG38lKFw/g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=DMKIPOcR; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328326; x=1773864326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JE91QTRS9s/PJnY8bLhmfV8ebey4gflG/1BZ7/jTCW0=;
  b=DMKIPOcRzgCJ9JT+EjctEjl5lakj8duDdLyQWtxyH0hBqUiOOb7zKQ+W
   mo+IRi+GfFrpyqhphh3W7NV6S7PW2kJnvUL4TeLrhpybIc9jge3g/VeP8
   Ib7F41ZFsU8s4J/cXbj93cqHnEJJwauPO+oArdnZ913RiR54hcsdzzn6v
   b3kJebjUVYc64g+yajxh8VFMLmBXqEfluURZXGmimxuxheYp5OHmGuM2i
   InIITjiXt7+NfgQux2ZA+zqMRQeD3vnX+DNKmJm03hkUCSTFQmyM90DXo
   noKlVQhPmMVOrE/DkMvP1rX4XNf1+J0JfGV4tQvPvTW0z3XLWlJFSAEO5
   w==;
X-CSE-ConnectionGUID: wcQfon7URpOK50v0D6gDhw==
X-CSE-MsgGUID: rcTZObCXTMa/1MlM32Tn8Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593065"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593065"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:22 -0700
X-CSE-ConnectionGUID: nA8tBwQgTnagsrFySHIrYw==
X-CSE-MsgGUID: lK+EjGbqQ8eitlL52w7jfQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363158"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:21 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Lukasz Czapnik <lukasz.czapnik@intel.com>,
	anthony.l.nguyen@intel.com,
	jiri@resnulli.us,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Simon Horman <horms@kernel.org>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 7/9] ice: fix input validation for virtchnl BW
Date: Tue, 18 Mar 2025 13:04:51 -0700
Message-ID: <20250318200511.2958251-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
References: <20250318200511.2958251-1-anthony.l.nguyen@intel.com>
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
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Co-developed-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 24 ++++++++++++++++---
 1 file changed, 21 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index df13f5110168..1af51469f070 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1862,15 +1862,33 @@ static int ice_vc_cfg_q_bw(struct ice_vf *vf, u8 *msg)
 
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
2.47.1


