Return-Path: <netdev+bounces-176704-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 60324A6B81C
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 10:53:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93261898DCB
	for <lists+netdev@lfdr.de>; Fri, 21 Mar 2025 09:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F271F1319;
	Fri, 21 Mar 2025 09:53:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jPTdD4v/"
X-Original-To: netdev@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D88381F4187
	for <netdev@vger.kernel.org>; Fri, 21 Mar 2025 09:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742550804; cv=none; b=oXjQMajNZDq4VqFKaH8pP8qErt+Ayper+se1pJiD/j9gQANzstKVCsNuLmk67vL2/r+ZZ2uiiKIrbKzAHPncxbeKl2/rR9Nw24nY0ym7BbMb+8uRxdtvaoOfwLPb6tdLuyuQGJNDrcio/Bx9ndQyB4aLh8Ns9eHZyfh0yTeoi/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742550804; c=relaxed/simple;
	bh=Vdh4GODQvr96eWoI5LH2Ypm0BO1OG4hLsZvzIzJvxp4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZFIyLE+dlTMM6LX56nSV7Nlc8GlzRfgIUOzU5FutSOqduxpJLCUCy5M9WvDrY7tQ/ubbY5sijoDr1uVwTnzH0rsJA24p6AuP0j/SUTpAuHnW1k3346qQ05SRwR2VirJg0G3sFRi6ESmfvcTNWLK2NKhyjv47lLt3baZD0t6jxPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jPTdD4v/; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742550798;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ifrZjSRHlzcCDMn8Cq0glVTL8/zZEyK32JGnaaD7ImE=;
	b=jPTdD4v/5qjzhZCexLiauXPKEpuBLSIQJEeWbwG8KwFxlXlmxoCe2yqULg3staTb1Ohtz/
	EcSSK067JgZVRMR4mwxpGhesdZ+774m/0UFddvl/8YfPoK1HVduoRjphZ5uRXrkofj10ft
	ls12jvgjGwFsOWfH2JjbmMGE93QLV3U=
From: luoxuanqiang <xuanqiang.luo@linux.dev>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	luoxuanqiang <xuanqiang.luo@linux.dev>
Subject: [PATCH] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
Date: Fri, 21 Mar 2025 17:52:00 +0800
Message-Id: <20250321095200.1501370-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: luoxuanqiang <luoxuanqiang@kylinos.cn>

As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
pointer values"), we need to perform a null pointer check on the return
value of ice_get_vf_vsi() before using it.

Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
Signed-off-by: luoxuanqiang <xuanqiang.luo@linux.dev>
---
 drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
index 14e3f0f89c78..53bad68e3f38 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_fdir.c
@@ -2092,6 +2092,12 @@ int ice_vc_add_fdir_fltr(struct ice_vf *vf, u8 *msg)
 	dev = ice_pf_to_dev(pf);
 	vf_vsi = ice_get_vf_vsi(vf);
 
+	if (!vf_vsi) {
+		dev_err(dev, "Can not get FDIR vf_vsi for VF %u\n", vf->vf_id);
+		v_ret = VIRTCHNL_STATUS_ERR_PARAM;
+		goto err_exit;
+	}
+
 #define ICE_VF_MAX_FDIR_FILTERS	128
 	if (!ice_fdir_num_avail_fltr(&pf->hw, vf_vsi) ||
 	    vf->fdir.fdir_fltr_cnt_total >= ICE_VF_MAX_FDIR_FILTERS) {
-- 
2.27.0


