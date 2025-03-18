Return-Path: <netdev+bounces-175885-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32E61A67DAD
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 21:06:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 591523B6945
	for <lists+netdev@lfdr.de>; Tue, 18 Mar 2025 20:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 667CF213E6F;
	Tue, 18 Mar 2025 20:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="iFenCfie"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9982139AC
	for <netdev@vger.kernel.org>; Tue, 18 Mar 2025 20:05:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742328327; cv=none; b=qCrXhUC/qvqL0Ug/45FmUroaCMhZpqTuzqzb6ETEU8UC/DIyMt8B3q/q9z6mxCxhsqQhbDFEtsRtShcFNdfSntmOUD7dRqWmFOcCvEbeujKQEyCNa0mKT8IAbnEqCst5BkTlhTCiuKvmS0tN0c9hXJfrIiKFLKhsTnWNOjU/N40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742328327; c=relaxed/simple;
	bh=QXoCQ4KeDDpNKZbXJWuDrsuf6m/+SyL0NPSYb0gyuCw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QsTmAo4yFcT4LUDMaA3p8YHdg5FTU3ZarBsyZeMa0xSrq592ooMz8ZrNC/69jrADLOwQOlAc0+0U9f0JBgfWNZ621dcKOMZAF2ha6QJe5xRs4rQfoCEemkyuQS1aPMGCw+CCbhZ22TFmavW1H2lzS6gP+J6G7FkT5nD04XBI7Jo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=iFenCfie; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1742328326; x=1773864326;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QXoCQ4KeDDpNKZbXJWuDrsuf6m/+SyL0NPSYb0gyuCw=;
  b=iFenCfielIlf57oFkwq4p7UPgjUCp08bFQoeaFskMPUUcTW4IFlOjOPq
   qJGrxwI0MObDsbh4kQmDZlY2WPVtfDWLXJfsOL3DHphW4Ah2X8+CaoE9m
   ZdxaRkF8iTqaEOpyngrPUUs7+jXfOJxQWR0G8T2u5X8Jp+UEJSWPFGGhy
   vpwlyTZvUlZqkQZ7x0HKl2rXHmiaA/++8fKR6eaTCbY8JBrj2eFJQZaPQ
   gagQxUuRSSkWRvX78ktqpZBbPX7DmvhpSdGf0mtdYhxahCyev0peVkRAA
   /e/RofeKglJ5ADytF5tIxT6/t8hGlXnreSOkw0gA2tN3XwoLgpnE1lTZZ
   Q==;
X-CSE-ConnectionGUID: 19lTjNPCQ+mihkrIvKczqw==
X-CSE-MsgGUID: bVn4zvCYTii1TEfy5qVF5g==
X-IronPort-AV: E=McAfee;i="6700,10204,11377"; a="43593074"
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="43593074"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Mar 2025 13:05:23 -0700
X-CSE-ConnectionGUID: 1ihvsMspR6qk26c4sy53+A==
X-CSE-MsgGUID: t0FDG6QhSiCEG6ESDxxLaA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,257,1736841600"; 
   d="scan'208";a="153363164"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 18 Mar 2025 13:05:22 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Mateusz Polchlopek <mateusz.polchlopek@intel.com>,
	anthony.l.nguyen@intel.com,
	horms@kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>,
	Rafal Romanowski <rafal.romanowski@intel.com>
Subject: [PATCH net 8/9] ice: fix using untrusted value of pkt_len in ice_vc_fdir_parse_raw()
Date: Tue, 18 Mar 2025 13:04:52 -0700
Message-ID: <20250318200511.2958251-9-anthony.l.nguyen@intel.com>
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

From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>

Fix using the untrusted value of proto->raw.pkt_len in function
ice_vc_fdir_parse_raw() by verifying if it does not exceed the
VIRTCHNL_MAX_SIZE_RAW_PACKET value.

Fixes: 99f419df8a5c ("ice: enable FDIR filters from raw binary patterns for VFs")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Signed-off-by: Martyna Szapar-Mudlaw <martyna.szapar-mudlaw@linux.intel.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 .../ethernet/intel/ice/ice_virtchnl_fdir.c    | 24 ++++++++++++-------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 14e3f0f89c78..9be4bd717512 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -832,21 +832,27 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		      struct virtchnl_proto_hdrs *proto,
 		      struct virtchnl_fdir_fltr_conf *conf)
 {
-	u8 *pkt_buf, *msk_buf __free(kfree);
+	u8 *pkt_buf, *msk_buf __free(kfree) = NULL;
 	struct ice_parser_result rslt;
 	struct ice_pf *pf = vf->pf;
+	u16 pkt_len, udp_port = 0;
 	struct ice_parser *psr;
 	int status = -ENOMEM;
 	struct ice_hw *hw;
-	u16 udp_port = 0;
 
-	pkt_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
-	msk_buf = kzalloc(proto->raw.pkt_len, GFP_KERNEL);
+	pkt_len = proto->raw.pkt_len;
+
+	if (!pkt_len || pkt_len > VIRTCHNL_MAX_SIZE_RAW_PACKET)
+		return -EINVAL;
+
+	pkt_buf = kzalloc(pkt_len, GFP_KERNEL);
+	msk_buf = kzalloc(pkt_len, GFP_KERNEL);
+
 	if (!pkt_buf || !msk_buf)
 		goto err_mem_alloc;
 
-	memcpy(pkt_buf, proto->raw.spec, proto->raw.pkt_len);
-	memcpy(msk_buf, proto->raw.mask, proto->raw.pkt_len);
+	memcpy(pkt_buf, proto->raw.spec, pkt_len);
+	memcpy(msk_buf, proto->raw.mask, pkt_len);
 
 	hw = &pf->hw;
 
@@ -862,7 +868,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	if (ice_get_open_tunnel_port(hw, &udp_port, TNL_VXLAN))
 		ice_parser_vxlan_tunnel_set(psr, udp_port, true);
 
-	status = ice_parser_run(psr, pkt_buf, proto->raw.pkt_len, &rslt);
+	status = ice_parser_run(psr, pkt_buf, pkt_len, &rslt);
 	if (status)
 		goto err_parser_destroy;
 
@@ -876,7 +882,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 	}
 
 	status = ice_parser_profile_init(&rslt, pkt_buf, msk_buf,
-					 proto->raw.pkt_len, ICE_BLK_FD,
+					 pkt_len, ICE_BLK_FD,
 					 conf->prof);
 	if (status)
 		goto err_parser_profile_init;
@@ -885,7 +891,7 @@ ice_vc_fdir_parse_raw(struct ice_vf *vf,
 		ice_parser_profile_dump(hw, conf->prof);
 
 	/* Store raw flow info into @conf */
-	conf->pkt_len = proto->raw.pkt_len;
+	conf->pkt_len = pkt_len;
 	conf->pkt_buf = pkt_buf;
 	conf->parser_ena = true;
 
-- 
2.47.1


