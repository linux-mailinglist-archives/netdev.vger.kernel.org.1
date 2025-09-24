Return-Path: <netdev+bounces-226075-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DE99B9BB9B
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 21:34:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9A0727A81AA
	for <lists+netdev@lfdr.de>; Wed, 24 Sep 2025 19:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A53726D4C6;
	Wed, 24 Sep 2025 19:34:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="cQavH0yQ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F726D4DF
	for <netdev@vger.kernel.org>; Wed, 24 Sep 2025 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758742460; cv=none; b=pxIx6lzJDMtn80Ktu06CZpUJtnlxSke9W+UrgglAYcRiXEpXbwnYZZYyZdr21HOQ1j33HhtMWKuAxR89LiE1G3YBql9mdYLg4H059kZd0M4lPvkS3ydvm3C8CrI4sLH1MWvT0L/hkE9jbQuX/nstsPHlhHZD1ZDryGdFs0kSDWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758742460; c=relaxed/simple;
	bh=OQZkpxpeoeidb0N4ZGignANHuxeM1au7IE8DrNG1Rm8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k3mYTpAcY+7xg87VixG8oWwuc0Q+dT2xvipGcoqT7Xp7ou/Oce9/rQRuMvlMYVjV8KwZ7OcBaVcoCAtRKypOA5JrXasAitDyIOKN/DYecAG1eHbNo+r+mRrgXUvZL8zD+Pmawmo1EuyB3FB0kQocoBiH6UO5Q4VrCLKPUr5EuDs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=cQavH0yQ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58OIuCnW002028;
	Wed, 24 Sep 2025 19:34:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=m81IE41gRb+fvCv3Pvhwo5nSPB6TA
	A2+GNoh0QIDkkM=; b=cQavH0yQybtSvGhpFXGBK6FIAIPnOmqJav8Rz+hDC9ZmW
	9DY5rztIQmPmB3HOzEJF7swbIon8JL7YNCGl5LBC1kWIZoL5i4Up6fGV+6Wi/Val
	iuo8MlFe10eQUQmxlXDlzcrD/2Bo01tre5OSx+2bGgO9GhzHjsta8sZdNB+7X0r3
	x8pyihkILvODUEjMgZO3goJvnsJQVvyu+8KzYPTQqKotkeTlPemntcNhgv5i5vtM
	vsUXvfnFs1Vtxx7WaazHIAdosyBp7YbJNCE35ijJlqwr+jW7hWriy4CJTSqpXKgb
	zNApZDd+/Dpg+FKW2TqVsEUQ10NU8oMudhtl523dw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 499k6b0g32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 19:34:08 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58OJ6NWi014991;
	Wed, 24 Sep 2025 19:34:07 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49a9515v7k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 24 Sep 2025 19:34:07 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58OJUH2L003662;
	Wed, 24 Sep 2025 19:34:06 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49a9515v6d-1;
	Wed, 24 Sep 2025 19:34:06 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org, intel-wired-lan@lists.osuosl.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] ixgbe: avoid redundant call to ixgbe_non_sfp_link_config()
Date: Wed, 24 Sep 2025 12:33:54 -0700
Message-ID: <20250924193403.360122-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-24_06,2025-09-24_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 bulkscore=0 phishscore=0 suspectscore=0 spamscore=0 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509240171
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNyBTYWx0ZWRfXxYbteJMbvrFm
 KEVraSYjE6FUVeU7PUpItSF5jv3drqS3Z/bDs7GI21uSSELcfPiXy8Im98SDE9zo+acRKwjtRBu
 s9tFtczxtgyyVmb/m51r8O8mMod9omyG6TzZrcmdCfNzbT2dx0zbgJD1pG+fyD6xYFbhVv7p5ku
 X4vrQNjhfd1uD60ZjyDW2xHWcEcfISQcFgzIfloQUSIIXY4rxJdZsKqr5e8REK/OAlgDvA4OecB
 7zncPM374CNkRF7VP8A8CVObmlcDILdrnBr91dN6kINVjdoFDoCFY0335F1m9bsQYZKnEvOPjS4
 Wgyp3atZSCAEM04FMtSd1lJzrhxitZOXoqGvs0gJgUhi+U5XpyCsJgdlVZQNYMnALMZ4/T/26W7
 08rNqdIB4EAbuiG61o4gMgq1TiH+xw==
X-Proofpoint-GUID: LNQ1Yeaopg5D0hS6J7mifrndKfOruwbJ
X-Authority-Analysis: v=2.4 cv=E47Npbdl c=1 sm=1 tr=0 ts=68d447b0 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=xcvOPl_opqY7jcd9CMoA:9 cc=ntf
 awl=host:12090
X-Proofpoint-ORIG-GUID: LNQ1Yeaopg5D0hS6J7mifrndKfOruwbJ

ixgbe_non_sfp_link_config() is called twice in ixgbe_open()
once to assign its return value to err and again in the
conditional check. This patch uses the stored err value
instead of calling the function a second time. This avoids
redundant work and ensures consistent error reporting.

Also fix a small typo in the ixgbe_remove() comment:
"The could be caused" -> "This could be caused".

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 90d4e57b1c93..39ef604af3eb 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -7449,7 +7449,7 @@ int ixgbe_open(struct net_device *netdev)
 					 adapter->hw.link.link_info.link_cfg_err);
 
 		err = ixgbe_non_sfp_link_config(&adapter->hw);
-		if (ixgbe_non_sfp_link_config(&adapter->hw))
+		if (err)
 			e_dev_err("Link setup failed, err %d.\n", err);
 	}
 
@@ -12046,7 +12046,7 @@ static int ixgbe_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
  * @pdev: PCI device information struct
  *
  * ixgbe_remove is called by the PCI subsystem to alert the driver
- * that it should release a PCI device.  The could be caused by a
+ * that it should release a PCI device.  This could be caused by a
  * Hot-Plug event, or because the driver is going to be removed from
  * memory.
  **/
-- 
2.50.1


