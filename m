Return-Path: <netdev+bounces-236772-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CEA8C3FF5B
	for <lists+netdev@lfdr.de>; Fri, 07 Nov 2025 13:43:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C472189A95E
	for <lists+netdev@lfdr.de>; Fri,  7 Nov 2025 12:42:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABE244691;
	Fri,  7 Nov 2025 12:40:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="ojqohzya"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DC85221294
	for <netdev@vger.kernel.org>; Fri,  7 Nov 2025 12:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762519244; cv=none; b=eIr8Yo9ux6H1NzNQoDkn1zPLGioJ06TzROfso0EfLKG1YuZNom+bJmGDvRo0bSzmdExbkpfqeryDxNfAWK1C2CSeUmtcIrI8EAmtyt8/7MQNN0nDGit+nmPBUTwPX4A5QhL/yTkuQj3Rwce1WmB6ueH/Te46PlyGlRytjRTd++0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762519244; c=relaxed/simple;
	bh=yiO4zmlXl/JS4+/5pfenaSwhIEXN8TsZ0bJb6jdcmBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=W+u3rNtpvNq5gwd75QNkZ+Lf1mu9t+73qsWsIQyGrnkoSMgKdfSyoH7gjXRDHHjfjcxvW6kIf7fZxjA4cnDZ6XgBTRO7dj4kMcMPXU0kLc016DeTgQNqSTsGZc6x1Uxy9qAsqxNOK2fTE+6Q7EF4N5ERPHmgutp1x16Yt2RRgG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=ojqohzya; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A78uOjH029896;
	Fri, 7 Nov 2025 12:40:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=/0VLNF0XkFoex+vaPitGJVE8wC0bF
	6xQJKj8eU4gdQw=; b=ojqohzyaWfWnk09WMS0ExCXmNPqW210zoAH7sThXNon0B
	tcjIYWW5tAb9NK+yq9l9mhG9N4yhBoW1noZTNoRtRkK7hDRQQV/0zAq6WIfWyMk5
	gf+/LGcRcEQiqBwMancmuK3vx/vr8E7JGm9gLqicEjsHq26397y4mtDADJpcAzUe
	0t17GOF7hV3r6Pt3yy3+22szUKwej5h8UJMQOxFMJuBN6H+LJ1RWVxoCM9DuDoLW
	CHGhaVIFzS8FBcqBtiW8y+smwN/fxAM6izLNE0KNoo2GFQ/PPGPCe9vV+CEAQo70
	T41eidbrjMJ5Vzjpg1QMyXwUPcf5ygiXv1ODfWS3g==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4a8yhj1tp8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 12:40:28 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 5A7BR2PV039780;
	Fri, 7 Nov 2025 12:40:27 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 4a58ndf1xs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 07 Nov 2025 12:40:27 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 5A7CYtQS010259;
	Fri, 7 Nov 2025 12:40:26 GMT
Received: from ca-dev110.us.oracle.com (ca-dev110.us.oracle.com [10.129.136.45])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 4a58ndf1wc-1;
	Fri, 07 Nov 2025 12:40:26 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: przemyslaw.kitszel@intel.com, aleksander.lobakin@intel.com,
        anthony.l.nguyen@intel.com, andrew+netdev@lunn.ch, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ice: fix comment typo and correct module format string
Date: Fri,  7 Nov 2025 04:39:41 -0800
Message-ID: <20251107123956.1125342-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-07_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 suspectscore=0
 mlxlogscore=999 malwarescore=0 spamscore=0 adultscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511070103
X-Authority-Analysis: v=2.4 cv=BdrVE7t2 c=1 sm=1 tr=0 ts=690de8bc cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=q7LjOxSivl45Mpgk1VYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEzMyBTYWx0ZWRfX4rRXsLvQ6glp
 vLtyIJ09HHf/hjkFmBjbdfJzPAGulz25wvY7STW/SVBxNMnX4cpiVnhjJ5MKkGL+L5MbZWD1cZl
 wrL1awaKLhaSfyRcmjC2mBSva5NiUMFAHpf+3v4LAjpSBF81vC7hg6YYj4g748T5oJLH9NUrN4H
 SqqPKmvHOXyPo8NH+5Z1q3x4qmNT2T16ByJaurLFg+gs/FYv4xpk3zeth5Cf0Spr5qZ6ItDVjoJ
 PXgcecK5/wxmYrf37ym24H4xD6RywF3+87LusmW5vpkvnT/j3tINkKREgXCCgmkdSwlL/FHgSrW
 UcYP3+G817/gMm66Yy8Pyi1/X27V2TVamBY9DR/Iu7hnUr/Oa9YwEd9o3vovn0r/wBEghznRFAN
 FfiPYekPpPSBdNin8cGus7YVSy8h3w==
X-Proofpoint-ORIG-GUID: -JigYjdm-M1TYjLkrH15ltF9tuy99P6m
X-Proofpoint-GUID: -JigYjdm-M1TYjLkrH15ltF9tuy99P6m

- Fix a typo in the ice_fdir_has_frag() kernel-doc comment ("is" -> "if")

- Correct the NVM erase error message format string from "0x02%x" to
  "0x%02x" so the module value is printed correctly.

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ice/ice_fdir.c      | 2 +-
 drivers/net/ethernet/intel/ice/ice_fw_update.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_fdir.c b/drivers/net/ethernet/intel/ice/ice_fdir.c
index 26b357c0ae15..ec73088ef37b 100644
--- a/drivers/net/ethernet/intel/ice/ice_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_fdir.c
@@ -1121,7 +1121,7 @@ ice_fdir_get_gen_prgm_pkt(struct ice_hw *hw, struct ice_fdir_fltr *input,
  * ice_fdir_has_frag - does flow type have 2 ptypes
  * @flow: flow ptype
  *
- * returns true is there is a fragment packet for this ptype
+ * returns true if there is a fragment packet for this ptype
  */
 bool ice_fdir_has_frag(enum ice_fltr_ptype flow)
 {
diff --git a/drivers/net/ethernet/intel/ice/ice_fw_update.c b/drivers/net/ethernet/intel/ice/ice_fw_update.c
index d86db081579f..973a13d3d92a 100644
--- a/drivers/net/ethernet/intel/ice/ice_fw_update.c
+++ b/drivers/net/ethernet/intel/ice/ice_fw_update.c
@@ -534,7 +534,7 @@ ice_erase_nvm_module(struct ice_pf *pf, u16 module, const char *component,
 	}
 
 	if (completion_retval) {
-		dev_err(dev, "Firmware failed to erase %s (module 0x02%x), aq_err %s\n",
+		dev_err(dev, "Firmware failed to erase %s (module 0x%02x), aq_err %s\n",
 			component, module,
 			libie_aq_str((enum libie_aq_err)completion_retval));
 		NL_SET_ERR_MSG_MOD(extack, "Firmware failed to erase flash");
-- 
2.50.1


