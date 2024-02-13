Return-Path: <netdev+bounces-71203-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA908529C9
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 08:24:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3883DB23B9E
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 07:24:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D8B6C17596;
	Tue, 13 Feb 2024 07:23:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="fBbmB6Jf"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5597117C71
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 07:23:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707809011; cv=none; b=ZyQKJ2hY90JEtVahyakML955zM8yQMMtbjiKJwT8UByiFyEQ9WqzJPdfjO9bXv+d6bb53Q3QTrwnX1nnJihmKQS40zFBmTFjEUgdeH9yyHSwiYk+XFCUKrsPOePxJzxGAC8vX18keDGPu5tuxhbY1zaFaXhKpDqp7fk+0M1ZK3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707809011; c=relaxed/simple;
	bh=VwQvXzNSK0T1FhN/TzTcIWD9hV1h/3p/4JAyNuO9c88=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q46MBfq2nu0ASnQUM7BlWzLNjvLDo+cbhoKIcBzZFcWGE0QrVqotYng2cYzLUSGgjl6PFWRqzSLCIggEnDpGFxsX1Ep+YvYFBIx36M9ynkDd5BcXgwMEvpY5HbH8rLAvWRMnQAYr8epVtM95bLqlmhbK5CHegPOc1zMOrOWNjEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=fBbmB6Jf; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707809010; x=1739345010;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VwQvXzNSK0T1FhN/TzTcIWD9hV1h/3p/4JAyNuO9c88=;
  b=fBbmB6Jf/WXHYB/CwpKFWYjoOZ7kYb5Zcs/ji4sXj7aNNvNTj8yCk6O1
   rFUmREqFuiEAEp+25KUMmdpFva15Yobfk3DKyfxkyPls94JDhylveMMji
   dJzn6YIc81gqjj535xbQPPBpT4brgo7vwGsrjXsRned+sc7k49oXRpNiY
   LanjcsGINpkwroBIBkuHC+FDZDECElGutnqsEjAC4VWmleJ1nv0m2VaAS
   9J2LklZ8Rbm9+todBbgYMzIr41OqiOsruSSNy9nBoOdHY6xqa0FN2Yxa0
   IN06Xvd5jUVZRoN34D6yNLqsrx8VoQ3vH+oL9u/vYRhpQWmBJUUWQgSke
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10982"; a="27247970"
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="27247970"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2024 23:23:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,156,1705392000"; 
   d="scan'208";a="7385312"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa003.fm.intel.com with ESMTP; 12 Feb 2024 23:23:28 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	jacob.e.keller@intel.com,
	michal.kubiak@intel.com,
	maciej.fijalkowski@intel.com,
	sridhar.samudrala@intel.com,
	przemyslaw.kitszel@intel.com,
	wojciech.drewek@intel.com,
	pio.raczynski@gmail.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 08/15] ice: store SF data in VSI struct
Date: Tue, 13 Feb 2024 08:27:17 +0100
Message-ID: <20240213072724.77275-9-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
References: <20240213072724.77275-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Store subfunction pointer in VSI struct. The same is done for VF
pointer. Make union of subfunction and VF pointer as only one of them
can be set with one VSI.

Reviewed-by: Wojciech Drewek <wojciech.drewek@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice.h        | 7 ++++++-
 drivers/net/ethernet/intel/ice/ice_sf_eth.c | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice.h b/drivers/net/ethernet/intel/ice/ice.h
index 767ea80684e7..4d35480178bc 100644
--- a/drivers/net/ethernet/intel/ice/ice.h
+++ b/drivers/net/ethernet/intel/ice/ice.h
@@ -352,7 +352,12 @@ struct ice_vsi {
 	u16 vsi_num;			/* HW (absolute) index of this VSI */
 	u16 idx;			/* software index in pf->vsi[] */
 
-	struct ice_vf *vf;		/* VF associated with this VSI */
+	union {
+		/* VF associated with this VSI */
+		struct ice_vf *vf;
+		/* SF associated with this VSI */
+		struct ice_dynamic_port *sf;
+	};
 
 	u16 num_gfltr;
 	u16 num_bfltr;
diff --git a/drivers/net/ethernet/intel/ice/ice_sf_eth.c b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
index abee733710a5..55db2e4beb72 100644
--- a/drivers/net/ethernet/intel/ice/ice_sf_eth.c
+++ b/drivers/net/ethernet/intel/ice/ice_sf_eth.c
@@ -117,6 +117,7 @@ static int ice_sf_dev_probe(struct auxiliary_device *adev,
 		dev_err(dev, "Subfunction vsi config failed");
 		return err;
 	}
+	vsi->sf = dyn_port;
 
 	err = ice_devlink_create_sf_dev_port(sf_dev);
 	if (err)
-- 
2.42.0


