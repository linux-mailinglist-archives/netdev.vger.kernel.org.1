Return-Path: <netdev+bounces-204271-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BBA7AF9D95
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 03:22:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED25E6E1C9F
	for <lists+netdev@lfdr.de>; Sat,  5 Jul 2025 01:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE2C0191F7E;
	Sat,  5 Jul 2025 01:19:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE0E113AF2;
	Sat,  5 Jul 2025 01:19:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751678383; cv=none; b=O9W6au46SSSwmsHP2a+pSPcnx9UZGbO3KiHvmN3Bh/MafkgDyB9UbavvN/XidBVVxPUtvJDAEee01yo2ise4okSCuntFf+mg83jiCMys1GlMT2q9I9rjoS7NUGgfHTYnglULvOu+VyQgP/HCb8Eb5BPlGG0GFj5DnW7e9vMR9+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751678383; c=relaxed/simple;
	bh=GUGEXd4EgBCmDuiJWPwUA7rug1859Bt3B+RyGDN28UQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YDPcV6r5ktrRor/6hObQm/hkZQo4TTNtDqSpEx4Go9JeD+XEYorvV3kr6986nPEs5GrHGa1aUAkHVdkJOilkKMMIgKXs3d8dM/nDx7DW3wtNkZLLZXL6jLqLfRdaKjASxpI1DVZOflbJ0pDMvmXy+guUqWYVKGifgDxzArKfuBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250810.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5651A3PZ011649;
	Fri, 4 Jul 2025 18:19:24 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47jbp4f8pj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 04 Jul 2025 18:19:24 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 4 Jul 2025 18:18:26 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Fri, 4 Jul 2025 18:18:23 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <xiyou.wangcong@gmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <jhs@mojatatu.com>, <jiri@resnulli.us>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: [PATCH V2] net/sched: Prevent notify to parent who unsupport class ops
Date: Sat, 5 Jul 2025 09:18:22 +0800
Message-ID: <20250705011823.1443446-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <aGhr2R3vkwBT/uiv@pop-os.localdomain>
References: <aGhr2R3vkwBT/uiv@pop-os.localdomain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: pDMKJWOA6mPpijoe-kZUiBr4rL_mYAv9
X-Proofpoint-ORIG-GUID: pDMKJWOA6mPpijoe-kZUiBr4rL_mYAv9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA1MDAwNiBTYWx0ZWRfXw3C9AdZnA4NH s750zaccsW/pnjcsNzN1RwVbzmMgE1fihikw2n5EV5L/9cHddEfLa2q1lqUPz/QOZWTjr0ejOXX rJh1Gwmsh4koM9FKaNc2I8Q+5+pH2yrM2yUdounedoExKMBgUhbKb6l+wTQtCNBK3x3mtxxo0iZ
 bTSwcu34As4YDecjKNX7N6sVUDerR+1MPamdXzzS9qQGbn2AmXh2M5IBBZHWe2xRBjI50XHwvcU XVqKANfDZT5u5pFD2u6UsthdNNewbensoTP0NOED2ffK8I2Sfm4BULdQLUyAvFfbqFztP0IFu+2 vcB+GuXt8AFrGDW7J6v5uAJ2a9N0NumXvtZ0e0rAUhL7TumCgn0oOp84oG1f8GK5D66jhIXYb96
 DMrsc8mD7ktyYznQBxum7rQuQQ3hUUxB7opAVJoq+7AgoPrnrBbh13xX1OBwyMEJIsE8tKoa
X-Authority-Analysis: v=2.4 cv=JMg7s9Kb c=1 sm=1 tr=0 ts=68687d9c cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=ia4idYVxgj-SMl71MLAA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_07,2025-07-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=676 suspectscore=0 adultscore=0 phishscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 mlxscore=0
 impostorscore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507050006

If the parent qdisc does not support class operations then exit notify.

In addition, the validity of the cl value is judged before executing the
notify. Similarly, the notify is exited when the address represented by
its value is invalid.

Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06
Tested-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
V1 -> V2: movie notify check first and check cl NULL

 net/sched/sch_api.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/sched/sch_api.c b/net/sched/sch_api.c
index d8a33486c51..53fd63af14d 100644
--- a/net/sched/sch_api.c
+++ b/net/sched/sch_api.c
@@ -803,12 +803,13 @@ void qdisc_tree_reduce_backlog(struct Qdisc *sch, int n, int len)
 			break;
 		}
 		cops = sch->ops->cl_ops;
-		if (notify && cops->qlen_notify) {
+		if (notify && cops && cops->qlen_notify) {
 			/* Note that qlen_notify must be idempotent as it may get called
 			 * multiple times.
 			 */
 			cl = cops->find(sch, parentid);
-			cops->qlen_notify(sch, cl);
+			if (cl)
+				cops->qlen_notify(sch, cl);
 		}
 		sch->q.qlen -= n;
 		sch->qstats.backlog -= len;
-- 
2.43.0


