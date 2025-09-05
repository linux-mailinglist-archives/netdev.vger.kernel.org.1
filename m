Return-Path: <netdev+bounces-220368-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72052B459EB
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 15:59:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 53F061CC37E4
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 13:59:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6B5535E4F0;
	Fri,  5 Sep 2025 13:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="QULIUEOP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 45B0335E4CA
	for <netdev@vger.kernel.org>; Fri,  5 Sep 2025 13:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757080669; cv=none; b=MFFud05YSct+3uveWpAizRF2rOaeY0wJ8B3twwYjvYGo55fwKXM2ZHv4E6pEGQOkg6q/4rKMIqzVaJng6q/BkeJlmKWEVa8P0DlsA4mlrgMQGBi4TrNObkMED2SA6LjrljUM02fZMd2YcEBWHgyjl2uUh21/ct4N7hHVfyyy1Yo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757080669; c=relaxed/simple;
	bh=+QXjeDVhfGVrjU2VDmV5AiFXqpEcPzd/wt5cWA+3b9k=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suGx0kS46uScJgiphW5VTKbI3ZhUv1ao67Qprbpsa5j6C0iYHEtGCKeY5xR8XDUSrpeV15mouyjiVGXmuoNsPbLxBDFajywnC769Ng0PeR3pKxau2mBB4rQYF9W1QDX6vo8P76bHI8CLxNrLMHSjDVQYqRJtov1gY6jJgbWaesM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=QULIUEOP; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333520.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 585Du1lG030274;
	Fri, 5 Sep 2025 13:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=YUqqfi7GGLUii7GTXIZTIDEOeiyfT
	/8myi9XvWIW154=; b=QULIUEOP1DWq0oFrj1R46j8uUnBjzmAItUnlK9o+umAaZ
	cNYWZqmKL7njSowdbszbqxuJcgApTXSGBEK2L3wyDIKQ+ffOM+Jj39R6yL0BX2u3
	ZeBVQOYUlLHtb4IJweSBYJ2sIUNe4WU3QZfXME+xYLHATjiPO7lGZOVwnBQuY1PI
	SNBbvGadGSULbzUUKNV/jhZvJ9Cnn2DtCA7+dhQ+s5Zzm/lC6su9L4UrKhIGKK95
	WK3wDjLtsRsAcCqeEf0ZwBmVWwlretozsMUV5JRwkLZieH2Vutv/ou9lrKYrD5D2
	2ttcKFN21giI2kLPYrjUfAAKmX2KSKf5+sK903WMQ==
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.appoci.oracle.com [130.35.103.27])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 4900gf82wt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 13:57:36 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 585DfQpQ031836;
	Fri, 5 Sep 2025 13:57:36 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 48uqrk92ur-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 05 Sep 2025 13:57:35 +0000
Received: from iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 585DvZ8D008517;
	Fri, 5 Sep 2025 13:57:35 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta03.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 48uqrk92u3-1;
	Fri, 05 Sep 2025 13:57:35 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: jiri@nvidia.com, stanislaw.gruszka@linux.intel.com, andrew+netdev@lunn.ch,
        davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH v2 net] genetlink: fix genl_bind() invoking bind() after -EPERM
Date: Fri,  5 Sep 2025 06:57:27 -0700
Message-ID: <20250905135731.3026965-1-alok.a.tiwari@oracle.com>
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
 definitions=2025-09-05_04,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 adultscore=0
 suspectscore=0 malwarescore=0 spamscore=0 mlxscore=0 bulkscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509050136
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA1MDEyOSBTYWx0ZWRfX3o8aHKpeKldE
 tDbSYLyj8Xl8KW9Hx8pKo8+eIcTppAI6qApbu36+b7VLv0MSDdNUrZjVCO4HySTbXt6+DWmbrII
 9wmPykXaJHGrmbDmmyHx2JOosLNkiKv4xA9Cnx7kFv0yuFed3TWYS2ry5KPdkNv911zch7Ge4dq
 Ayn846isjCZpZVoUGCBuMx6gNd6rfIVZRHP3xfjo+8PxJd14ccbVPfCfyN0LqZONEqoP1wnQ0eF
 hV4Mh1jg9qpUO1lJyALrQ9E547gq9XPnsJVLnL4kySLbYFIf0QqFDh4CuZlwZPDAh8DSczAuRAW
 f55l8MOtsgeU3cw9j71jIZC4qMKaWBZrveVJN+CpcL7MYAHa3B9Cn5bD6h4cqNQsTZ1W3jDfyEZ
 oCzARnLF2TbZnzRliOd2xibAjqwuQw==
X-Proofpoint-GUID: FZPrY4xZrSmwE6gkPk4qwngW6F0h8Ztq
X-Authority-Analysis: v=2.4 cv=GKEIEvNK c=1 sm=1 tr=0 ts=68baec50 b=1 cx=c_pps
 a=qoll8+KPOyaMroiJ2sR5sw==:117 a=qoll8+KPOyaMroiJ2sR5sw==:17
 a=yJojWOMRYYMA:10 a=VwQbUJbxAAAA:8 a=yPCof4ZbAAAA:8 a=IQN_B5fLJMZ4uxNOhSQA:9
 cc=ntf awl=host:12069
X-Proofpoint-ORIG-GUID: FZPrY4xZrSmwE6gkPk4qwngW6F0h8Ztq

Per family bind/unbind callbacks were introduced to allow families
to track multicast group consumer presence, e.g. to start or stop
producing events depending on listeners.

However, in genl_bind() the bind() callback was invoked even if
capability checks failed and ret was set to -EPERM. This means that
callbacks could run on behalf of unauthorized callers while the
syscall still returned failure to user space.

Fix this by only invoking bind() after "if (ret) break;" check
i.e. after permission checks have succeeded.

Fixes: 3de21a8990d3 ("genetlink: Add per family bind/unbind callbacks")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
v1 -> v2
replace if (!ret && family->bind) with separate
"if (ret) break;" as suggested by Jabuk.
https://lore.kernel.org/all/20250831190315.1280502-1-alok.a.tiwari@oracle.com/
---
 net/netlink/genetlink.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/netlink/genetlink.c b/net/netlink/genetlink.c
index 104732d34543..978c129c6095 100644
--- a/net/netlink/genetlink.c
+++ b/net/netlink/genetlink.c
@@ -1836,6 +1836,9 @@ static int genl_bind(struct net *net, int group)
 		    !ns_capable(net->user_ns, CAP_SYS_ADMIN))
 			ret = -EPERM;
 
+		if (ret)
+			break;
+
 		if (family->bind)
 			family->bind(i);
 
-- 
2.50.1


