Return-Path: <netdev+bounces-212369-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DB0ECB1FB34
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 19:01:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 838E83BB5D2
	for <lists+netdev@lfdr.de>; Sun, 10 Aug 2025 17:01:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365452EAE5;
	Sun, 10 Aug 2025 17:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DtTuW4vE"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 905F5A29
	for <netdev@vger.kernel.org>; Sun, 10 Aug 2025 17:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754845304; cv=none; b=Q2aZGZ4YYR7i5KvUFYabxJPoWTfTLjObIGxPlK13HAWsSuDi3k5d7Usiwvu1txQnog2IeXaCmu57oOqxIAxWLBbTf7lVpOqmhq445Qen7cvXTUcttaqJWL7J3QWh60uDgWk4E/80VNoHNb1czE1dBBlZ2odh626pXGLbA9Ouy3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754845304; c=relaxed/simple;
	bh=weuBBAVzYx5DyGrCXmGG3nyS0NGCGgXxOLSbuoutDb4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qS7jijwHIwtGVVP0k1kL3jwK4EGcrRo+chWM0w0uCZkizcCPN0NEDn1+8xZNq/JvqoixXeMzjPkyN+1PRjNbyThEu6+fzhfJbNjQdxUJP9vzUKsWBYCGooE/7yDWx4StK9Y3iPHyzeWA+nEWdAYNwp32s0hYeHUTkdGY32obryQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DtTuW4vE; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57AGcojI000959;
	Sun, 10 Aug 2025 17:01:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=JEEs/WXZSr2jxbEeUZJMjc8Ylm+M2
	pqjK649cPvZ/8g=; b=DtTuW4vEhRwkgDnw9r4qhnwy5eH4D9Uz/rP+h8PAoJnPy
	wLLjUz2d5PUv9W/+KgYGziouHWax6Ntk7S8ETzycriDvvx+IXyHJl8eczCmWAgAy
	+fDgG3hmXRv/BnkE6cc/zD2goLBkDVbe/oXIZQ3/5ibJm75der7B07zQ5EhYb0KC
	1GdZ2mxelPvK0uO1Y+6LGRu1ix+TkcHUoQHofzFK+Z+04FnYwnTBK4DUHgP1S+w/
	0W5EpFeSuoxcdc5r+lu+qQ1wJgrREeXuWk1BE98WAlR10IswbsUIVJmMfD0K1WP9
	praGK56WV6ieEzC2CDp0A1CWvKMVi4sX+MVlNfjWQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 48dxcf19b8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 17:01:23 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 57AFhwVi038546;
	Sun, 10 Aug 2025 17:01:23 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48dvsebp9v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 10 Aug 2025 17:01:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 57AH1Mlk025629;
	Sun, 10 Aug 2025 17:01:22 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48dvsebp8b-1;
	Sun, 10 Aug 2025 17:01:22 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com, intel-wired-lan@lists.osuosl.org
Subject: [PATCH net] ixgbe: fix incorrect map used in eee linkmode
Date: Sun, 10 Aug 2025 10:01:14 -0700
Message-ID: <20250810170118.1967090-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-10_05,2025-08-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 phishscore=0
 spamscore=0 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2507300000
 definitions=main-2508100123
X-Proofpoint-GUID: KNSXnn_-usSM9SrCUyZ7hdpwkds2lVag
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODEwMDEyNCBTYWx0ZWRfX37p3ZD43Bamh
 JL0nfhVmPX/JgRaO8tyDGtQQ9xz5LwM06H4swE29pC/n+ZbOSN8Qhcn6f5rbq9sR2taLQsd6/EM
 G0MZH1h0pus5ifXbNWCCEzSBV/8jO0ZUxbJzmsHe/uN/UgG8vQoBKLw/qIx8dCUMtn9TI2fv04k
 u76xXX8TZAzFbA5i5jGoxR7lDOAjD40QRSeea/UuQQmSGtfolyyk0Q4FDnMzJtT7SC1VbrWVvMK
 SjCQPfFHhAAqwgyzeA00h7VN/0HS8Pg7sC7vLTQftRmspcsGzbGlF2JNI/CqERdI2my9izOvlQW
 yWpDCC1vCBOxkyRIFG6svl64IHUj5M7TvDwy5VLBeQPgXPkrULFkhD2bDAM3GEXxGdQp8iE5BU4
 eM7pjS2djls52ijEugqrSGFmcLXe04uTECiHsql+DRF6pYPrPl2syYXBnmqxAL9PkMj2hEDL
X-Authority-Analysis: v=2.4 cv=W8M4VQWk c=1 sm=1 tr=0 ts=6898d063 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=2OwXVqhp2XgA:10 a=yPCof4ZbAAAA:8 a=IAEjdJ3BLuIAbGQATbkA:9 cc=ntf
 awl=host:12070
X-Proofpoint-ORIG-GUID: KNSXnn_-usSM9SrCUyZ7hdpwkds2lVag

incorrectly used ixgbe_lp_map in loops intended to populate the
supported and advertised EEE linkmode bitmaps based on ixgbe_ls_map.
This results in incorrect bit setting and potential out-of-bounds
access, since ixgbe_lp_map and ixgbe_ls_map have different sizes
and purposes.

ixgbe_lp_map[i] -> ixgbe_ls_map[i]

Use ixgbe_ls_map for supported and advertised linkmodes, and keep
ixgbe_lp_map usage only for link partner (lp_advertised) mapping.

Fixes: 9356b6db9d05 ("net: ethernet: ixgbe: Convert EEE to use linkmodes")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
index 25c3a09ad7f1..1a2f1bdb91aa 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ethtool.c
@@ -3571,13 +3571,13 @@ ixgbe_get_eee_fw(struct ixgbe_adapter *adapter, struct ethtool_keee *edata)
 
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_supported & ixgbe_ls_map[i].mac_speed)
-			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
 					 edata->supported);
 	}
 
 	for (i = 0; i < ARRAY_SIZE(ixgbe_ls_map); ++i) {
 		if (hw->phy.eee_speeds_advertised & ixgbe_ls_map[i].mac_speed)
-			linkmode_set_bit(ixgbe_lp_map[i].link_mode,
+			linkmode_set_bit(ixgbe_ls_map[i].link_mode,
 					 edata->advertised);
 	}
 
-- 
2.47.1


