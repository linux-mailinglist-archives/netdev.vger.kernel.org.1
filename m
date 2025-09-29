Return-Path: <netdev+bounces-227111-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA71BA8796
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 10:54:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B8652189D297
	for <lists+netdev@lfdr.de>; Mon, 29 Sep 2025 08:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 808EA27A900;
	Mon, 29 Sep 2025 08:54:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="fLzKwbiJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E089227C150
	for <netdev@vger.kernel.org>; Mon, 29 Sep 2025 08:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759136079; cv=none; b=ZjQ3uYpFwyZ+lxV1TQlXwatv6fhiPX0Oe+nHHKKUbx13ypMr9XSmX1bc5WoAbTm42NkGyiwyI3R+q/mkMTfTN4RzazV6EpKLF2HGr+AB8NqvalRrsCo3bt+3msLwivdlOZRa64DIbN/W8aDGHVGLcn6RgA55AcUw8yleXkfn4lk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759136079; c=relaxed/simple;
	bh=Zqp95AP5FuY0HO263rujhdXBmN6MJWaosQoBJxJweLc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FtaDBbmJdXw2mA3yJuY6gRuouSqu3NnphaGwk/JgbdhD+5QiaL6W/J6I3x3FKNL/PsFZDwLCZF+2oa2OVzDzgmm0l2rDSgbvfTYmgKIUz7MFUtN1Pe8UYkVtc1ThYfPfQM1hzp1UP/kmVgQRtDfYsAYh55zw0lIeHG8zFsII1AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=fLzKwbiJ; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58T8JQbF004934;
	Mon, 29 Sep 2025 08:54:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=HJ4BAeArtSthrSkhbCoYegCpynWwL
	UqgJr3scPxRVho=; b=fLzKwbiJ8bb9oRD/svukc1Jaee0ReN8HVuiInl0RNaaBW
	x45JSrBMMC6p09M3kp5rbgWB1WJlweOEhF9tyS+VERIDcrHE6y2lAHvThxcG8uqq
	UUuCeLp62tlE9x2xMgTmb9va11pZ+VQRL2tkJiFl85KnAlTrnXJ3dx2JLnTlsZQE
	OKxg+yXNczHhFSXPOdyNw6umuw6bf1Kmn2vJEKJ+WR46lFOjrDsFGm/Ox++c069M
	NGVqv2PWC2L6Qh6XN+16BX302+PNaKas8DB4KK/RJsqlW2Mny6VE1WD4/i9ICGZi
	5pVzzt2FJW3QysNLXqQgEcSExqbHw5GOEEoMBOPPw==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49fpge02au-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 08:54:22 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58T8XqNk000643;
	Mon, 29 Sep 2025 08:54:22 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 49e6c658ad-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 29 Sep 2025 08:54:22 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58T8s6CT026011;
	Mon, 29 Sep 2025 08:54:21 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 49e6c6589w-1;
	Mon, 29 Sep 2025 08:54:21 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: kuniyu@google.com, sdf@fomichev.me, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net-next] net: rtnetlink: fix typo in rtnl_unregister_all() comment
Date: Mon, 29 Sep 2025 01:54:12 -0700
Message-ID: <20250929085418.49200-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-29_03,2025-09-29_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2509150000 definitions=main-2509290086
X-Authority-Analysis: v=2.4 cv=SqmdKfO0 c=1 sm=1 tr=0 ts=68da493e b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=bxyK71KjYNt0ltEmN1AA:9
 cc=ntf awl=host:12090
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI5MDA4MCBTYWx0ZWRfX1AMWHHXVrHWw
 fB0UCCfAS3CLKxfneofVQZDMWZAJiAMp2ox6GQ2jmdmWi6Sy6b0M/3oUOF4DFOR/kIgRI1Y8xE6
 /aIvjySMxJBAoj8hZZ6qqtz7RBYF4ly8BozjAnSUqLT45pobUaqVgfkt38HFrE7dcBGDkMeLL1z
 KqzgAilkdfcusZx3/KtUdTv8SETLAkBVDao7hpZ4rlmFYu/HYa89Q/6YulIBvUclnZLz5lSHxcB
 Jx2QpbmCp4Fe8Qy6MjRXI3PGF4u47R/CWHPM258xSSkUz62u+y2KCv2MKsl6az1mIJLMUrO4ESi
 voSNPk8btnQMMM2jbVWXHmbZP0USaOzazEBunmZ7uv74JvfA/VrjiJphrsOFVccWebbrikNcm3O
 5z+E6CevXGOChck+0LcTVOBrP3pMqmBbzjXmIgHb8tTKi732YfU=
X-Proofpoint-GUID: ZtsOS9jO_Y6bvyfrnnqwnZ_KbLy08j-w
X-Proofpoint-ORIG-GUID: ZtsOS9jO_Y6bvyfrnnqwnZ_KbLy08j-w

Corrected "rtnl_unregster()" -> "rtnl_unregister()" in the
  documentation comment of "rtnl_unregister_all()"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v1 -> v2
Drop change for "bugwards compatibility" as Jakub comment. 
Added Reviewed-by: Simon Horman
Rephrase commit subject
https://lore.kernel.org/all/20250913105728.3988422-1-alok.a.tiwari@oracle.com/
---
 net/core/rtnetlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/rtnetlink.c b/net/core/rtnetlink.c
index d9e68ca84926..8040ff7c356e 100644
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
-- 
2.50.1


