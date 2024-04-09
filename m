Return-Path: <netdev+bounces-86207-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46B8489DF7E
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 17:45:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BDAC3282AF8
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 15:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0061C136994;
	Tue,  9 Apr 2024 15:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="doiYMy1h"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DE64AED6
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 15:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712677502; cv=none; b=i6IoL3flnKLQ5h9iSnd3tHsI8+VG007Urrqz/yWgNxJTlOSE+QJTQhtWPm/3APfAkYhEgOSEzsYTNnEPkqb8UIr0LnBWUKQXhsMBHZm4Ba7Ldod6x89pfHeUgIlQ/wxXrtDQSoNJAqApK1YVxJxOPM7g8iphgXDeBSMAoMoujUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712677502; c=relaxed/simple;
	bh=K7xBs4xpIv+5qSMwNv/cpdYuxUrRNfSRUXsK1NN2ZDY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lh8MT89a5dO5PK8HSdGKRLzVSjwDZ3S/4Hx/laXFpYyrau+XIFtUyGOCjUkA70EECVLMnMtaXo1elaOGgMX05cQyaXot0AP+ugSw2rJnyQCW98Xg7iWB3ABvLnzYhko1RE6SjFZye5T4I/0IQU5VxQ7C3RdJhU5pSLDCapRUw0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=doiYMy1h; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712677501; x=1744213501;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=K7xBs4xpIv+5qSMwNv/cpdYuxUrRNfSRUXsK1NN2ZDY=;
  b=doiYMy1hJS9He9rFgVYGYU+hE/4FMtv3Up6f++Mz5O9JDg17MHrFz3vz
   +mNpCHpXA1WaoI1Sblx37UHeX7Iqq85RwSWRB5u9mTtSSM3ESI/7CsRmp
   ZQ8LsUeGIu5jp5JIFj73vFazvWfehBWV0lk0fmrg/KJyjyIVmZHY+kuEG
   z6SJraYxnvo40fWee+A0Z/7HfNRlXjLJpT/oxMWRTOjiOC9ugzA0fb+CG
   E8zJMF92x4WWngumnU/JmdWbB/+a8RKb+44tP+aTLCt8wgAlIj869SRWp
   pe9hAZtsREIJKoz05pQJBS99M7ewE3oCq0xFwCk3BSDjrQMFMcVhXHT0w
   w==;
X-CSE-ConnectionGUID: QOVOetePRoqpd/PvW6uR0g==
X-CSE-MsgGUID: EyvTYF04QcmGO9UYgp3PjA==
X-IronPort-AV: E=McAfee;i="6600,9927,11039"; a="19427720"
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="19427720"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 08:44:29 -0700
X-CSE-ConnectionGUID: mGOUQNrFQPSC6FcLlUWIeg==
X-CSE-MsgGUID: 74zR2XfmQz+G2ZnCNS+ogQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,189,1708416000"; 
   d="scan'208";a="20303003"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa009.fm.intel.com with ESMTP; 09 Apr 2024 08:44:28 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9E9F428199;
	Tue,  9 Apr 2024 16:44:20 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH iwl-net] ice: Fix checking for unsupported keys on non-tunnel device
Date: Tue,  9 Apr 2024 17:45:44 +0200
Message-ID: <20240409154543.8181-2-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing FLOW_DISSECTOR_KEY_ENC_* checks to TC flower filter parsing.
Without these checks, it would be possible to add filters with tunnel
options on non-tunnel devices. enc_* options are only valid for tunnel
devices.

Example:
  devlink dev eswitch set $PF1_PCI mode switchdev
  echo 1 > /sys/class/net/$PF1/device/sriov_numvfs
  tc qdisc add dev $VF1_PR ingress
  ethtool -K $PF1 hw-tc-offload on
  tc filter add dev $VF1_PR ingress flower enc_ttl 12 skip_sw action drop

Fixes: 9e300987d4a8 ("ice: VXLAN and Geneve TC support")
Reviewed-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_tc_lib.c b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
index f8df93e1a9de..b49aa6554024 100644
--- a/drivers/net/ethernet/intel/ice/ice_tc_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_tc_lib.c
@@ -1489,7 +1489,10 @@ ice_parse_cls_flower(struct net_device *filter_dev, struct ice_vsi *vsi,
 		  (BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV4_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IPV6_ADDRS) |
 		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_KEYID) |
-		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS))) {
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_PORTS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_IP) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_OPTS) |
+		   BIT_ULL(FLOW_DISSECTOR_KEY_ENC_CONTROL))) {
 		NL_SET_ERR_MSG_MOD(fltr->extack, "Tunnel key used, but device isn't a tunnel");
 		return -EOPNOTSUPP;
 	} else {
-- 
2.41.0


