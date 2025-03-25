Return-Path: <netdev+bounces-177274-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 823BDA6E838
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 03:02:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 428D718969B0
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 02:02:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8246C63CB;
	Tue, 25 Mar 2025 02:02:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LINj1/ek"
X-Original-To: netdev@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36E332E3382
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 02:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742868156; cv=none; b=N6KkLI2srIxdK802U32V9442BVqyVjXHRsy2MLGSoabNvBfapPrfKtu/J9ySrtGQkrCLx8dOhXeGmESEDzF/VEqFzPEGoe4oqzYOFNuHghwe+Kd7I8m3DjSnA1aPmvouV9s0gdRksMtLniTSF5hGVY8pJyQq6b6sD6A+RUZ9WSI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742868156; c=relaxed/simple;
	bh=ugLLV2M6HnTRfy45Hy/1xah8hksBf4lHjAqS8fqaQPk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Vv6rO9BeeLCkZa0VhtObB7ORZs7GB9kXh/8PQiwJvecKTW0+Y+A8xJXRLenOBjX6fas+SQpoKW8wmWYPx9ESdQ9YulDQo517v930uBqUOxMk1EfPkAxF1MEVVFxgJ9CZxHoBsv4Q+HeL2M2rrZ3Haid7lZ73ZFxLzWhoDCfQXv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LINj1/ek; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1742868152;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=PoPeXcnAj1MXkZ7sd5wxpK63DqmefzbwH7HjvQ9UcCE=;
	b=LINj1/ek64hEO/x33uHxwLIGJy5oSelQhW66VB1kPB852I2rxWFFWv2vSqHcBb1BZOcfPZ
	selz3aElmCS6XHwWWoR1/RTxZAyiH/cqCeIIA7gXcUhgUmwAM4/CE+2x4botaPZxeXCAvG
	F4mXLcKPfEIM0EeVKPuGmcnbaCPoNjg=
From: Xuanqiang Luo <xuanqiang.luo@linux.dev>
To: przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com
Cc: davem@davemloft.net,
	edumazet@google.com,
	netdev@vger.kernel.org,
	intel-wired-lan@lists.osuosl.org,
	Xuanqiang Luo <xuanqiang.luo@linux.dev>,
	Xuanqiang Luo <luoxuanqiang@kylinos.cn>
Subject: [PATCH iwl-net v2] ice: Check VF VSI Pointer Value in ice_vc_add_fdir_fltr()
Date: Tue, 25 Mar 2025 10:01:49 +0800
Message-Id: <20250325020149.2041648-1-xuanqiang.luo@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Xuanqiang Luo <luoxuanqiang@kylinos.cn>

As mentioned in the commit baeb705fd6a7 ("ice: always check VF VSI
pointer values"), we need to perform a null pointer check on the return
value of ice_get_vf_vsi() before using it.

v2: Add "iwl-net" to the subject and modify the name format.

Fixes: 6ebbe97a4881 ("ice: Add a per-VF limit on number of FDIR filters")
Signed-off-by: Xuanqiang Luo <luoxuanqiang@kylinos.cn>
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


