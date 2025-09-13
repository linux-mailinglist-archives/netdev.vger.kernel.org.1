Return-Path: <netdev+bounces-222785-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E866B5605A
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 12:57:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CA7FD1B2143B
	for <lists+netdev@lfdr.de>; Sat, 13 Sep 2025 10:58:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 964062EC0AB;
	Sat, 13 Sep 2025 10:57:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="DoAkqMFO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDFEC1DE4E0
	for <netdev@vger.kernel.org>; Sat, 13 Sep 2025 10:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757761062; cv=none; b=rzWFibKBSHW17G0nh02ciKWEiQqQzCh6BO319GMNRWVcZt0/RRKBe3GBPneZfNNNbUyBI9NwJDbeDtOoc1RTIBlm68ZSxRJmu7T+UZn9HFfuQpTB9VhYkBOQAnCCk1KY0hWnlK9Su+6dOHsxxVBWF8YjsIMD3TAqWZliZ/2VISU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757761062; c=relaxed/simple;
	bh=upQPXGsB+Lqds9bK49tblzNE68vNfRic6U/rijoXc8I=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5alprpMDmeBQilU0Mc3nsNpd2eVBQas8IFucW2ELgOPF4Rv84Nld9eWwI/wUbkKckBG8uDJUFR2+7kNWJX3dF4R5VW0Sbv/CEyIyXMxWqNa7HbSD5Pqqvw/dvf8rSnNU/E4ELrdGRufSgmPOV2Y8tk0F4y+0yjgq4FfBxt5ekw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=DoAkqMFO; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58D6ww0J028203;
	Sat, 13 Sep 2025 10:57:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=iSlUeSHRmJUsrdQpHMnv5iGSFPvE/
	krIjkCy3aJEPAE=; b=DoAkqMFOJqvOmu/qLElXVbmgXIxPdsolvVEmfacPB77Ou
	H197AsglO7/kc8BRTwS67fTeXG5CuRjom8+5DeaHwmMkE8oxVqVyeZdVIlMVMjV3
	fg9eMc+Ux0VTUcieZBaDCuGC7nSUM0OyOKg2Sb9cgc4yetbEdmEqWkSY/se/+Zf8
	0qEk+L7UVXO0FclbskIjCLslC5tVQCAujmmuofJ9fN+hdXc5PFCq3d1nNtZfK0yY
	/Z1KzTNd8zKfXmiLwONd/Cg1qtiuJkByoPy7CXqLuWuSDwJSsf8Ua5r/sCFKA7Ni
	4XL0oCW0R64TfgsBACBXBWtCM1f8jxH3TlrxqOruw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49507w07we-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 10:57:33 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58D77cli015291;
	Sat, 13 Sep 2025 10:57:32 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2frex1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 13 Sep 2025 10:57:32 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58DAvVNn011414;
	Sat, 13 Sep 2025 10:57:31 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y2frewn-1;
	Sat, 13 Sep 2025 10:57:31 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kuniyu@google.com, sdf@fomichev.me, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net-next] net: rtnetlink: fix typos in comments
Date: Sat, 13 Sep 2025 03:57:26 -0700
Message-ID: <20250913105728.3988422-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-13_03,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509130103
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTEzMDAyNSBTYWx0ZWRfX7yi+63aasqi5
 00eefPl5bYNsEpl9OTt9KhwctOh0ZmoNa7gR7IKIzqzFFZI/XUvUwALi6ry1ut4IxxaE+d3RYyp
 F2RMb3LTiAMSv4vilR3a3VKpKYockA4/ovD1X/BwhmHxuXVT9qd90+p/uUeW0MOZS1jubtU5Z7S
 GOQQN6Zaycc+Yt4qaG7VrK5/atlotEhCewTJV77yvu2q2w50j6af+jO/mQo2kBZeJpNBpwIjV80
 PWXNXeIFKGp9grlDaYPJzsnb4IjPSMwB7FsoTwG1cUAjTAifDEvdSM+8qACcb4xMBMHtyGd6NYs
 TqE2MeBXhGkwZGfysqIL3P0nys4hbdm5ZUeWZSyWyfvSazwFXN1V74PG6rN1mkS/fg92/GPq5vr
 H7b/XnXl0X7xL+NV8hJ4vD97wjdLmQ==
X-Proofpoint-ORIG-GUID: nTBoHdMPY50ra26t-Pv7Vv-aJBxEBUEK
X-Authority-Analysis: v=2.4 cv=RtPFLDmK c=1 sm=1 tr=0 ts=68c54e1d b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=wYRIItBDcXS1zaOhxGIA:9 cc=ntf
 awl=host:13614
X-Proofpoint-GUID: nTBoHdMPY50ra26t-Pv7Vv-aJBxEBUEK

- Corrected "rtnl_unregster()" -> "rtnl_unregister()" in the
 documentation comment of "rtnl_unregister_all()"
- Fixed typo "bugwards compatibility" -> "backwards compatibility"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 net/core/rtnetlink.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index 094b085cff20..37a9594c8144 100644
--- a/net/core/rtnetlink.c
+++ b/net/core/rtnetlink.c
@@ -478,7 +478,7 @@ static int rtnl_unregister(int protocol, int msgtype)
  * rtnl_unregister_all - Unregister all rtnetlink message type of a protocol
  * @protocol : Protocol family or PF_UNSPEC
  *
- * Identical to calling rtnl_unregster() for all registered message types
+ * Identical to calling rtnl_unregister() for all registered message types
  * of a certain protocol family.
  */
 void rtnl_unregister_all(int protocol)
@@ -1096,7 +1096,7 @@ static unsigned int rtnl_dev_combine_flags(const struct net_device *dev,
 {
 	unsigned int flags = ifm->ifi_flags;
 
-	/* bugwards compatibility: ifi_change == 0 is treated as ~0 */
+	/* backwards compatibility: ifi_change == 0 is treated as ~0 */
 	if (ifm->ifi_change)
 		flags = (flags & ifm->ifi_change) |
 			(rtnl_dev_get_flags(dev) & ~ifm->ifi_change);
-- 
2.50.1


