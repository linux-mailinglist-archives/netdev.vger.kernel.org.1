Return-Path: <netdev+bounces-204056-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DE34AAF8B47
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 10:24:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F776169014
	for <lists+netdev@lfdr.de>; Fri,  4 Jul 2025 08:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E36E7301135;
	Fri,  4 Jul 2025 08:05:54 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-0064b401.pphosted.com (mx0a-0064b401.pphosted.com [205.220.166.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15C301130;
	Fri,  4 Jul 2025 08:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.166.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751616354; cv=none; b=lHYCgZfSv47z4qt73gx6nXFwsoyehhT923szmFZAmeOBBiXa2vraZA7+IXBI/f5MD5saLJGvAPOCYFOkaEL12BfjyokXgQnrbBrlzjUFgPK6MiS2Lc8uckY9SJ+Hteqb751r8K8lgbcIIgxf0D4rR9t1VQ6flb5bclEVeECxkps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751616354; c=relaxed/simple;
	bh=66+rZOMFX/JcRue99xR27yAypXqHnvTsX0nMl9jnu/A=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TpleUo7hlgR6xeVa3LscyPxqpxHJrD/Dno9UUKzgj5w0sXtD2gu2DO3xdtI69O2PBxrKIcv5/TIrpHwKmI+Kt8e7seLdaQx2pvblc5Mz+IvDgywHI7cVgLfEI32l4u2HVnLLNmOqvhWlZrBfBt0ToHB4GC8f+/oaKn3th6lH4zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.166.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250809.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5644wnuj030729;
	Fri, 4 Jul 2025 01:05:24 -0700
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 47jfwm6ak0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Fri, 04 Jul 2025 01:05:24 -0700 (PDT)
Received: from ala-exchng01.corp.ad.wrs.com (147.11.82.252) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.57; Fri, 4 Jul 2025 01:04:24 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ala-exchng01.corp.ad.wrs.com (147.11.82.252) with Microsoft SMTP Server id
 15.1.2507.57 via Frontend Transport; Fri, 4 Jul 2025 01:04:23 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <horms@kernel.org>,
        <jhs@mojatatu.com>, <jiri@resnulli.us>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>,
        <xiyou.wangcong@gmail.com>
Subject: [PATCH] net/sched: Prevent notify to parent who unsupport class ops
Date: Fri, 4 Jul 2025 16:04:21 +0800
Message-ID: <20250704080421.4046239-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <686764a5.a00a0220.c7b3.0013.GAE@google.com>
References: <686764a5.a00a0220.c7b3.0013.GAE@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=LPRmQIW9 c=1 sm=1 tr=0 ts=68678b44 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=Wb1JkmetP80A:10 a=edf1wS77AAAA:8 a=hSkVLCK3AAAA:8 a=t7CeM3EgAAAA:8 a=ia4idYVxgj-SMl71MLAA:9 a=DcSpbTIhAlouE1Uv7lRv:22
 a=cQPPKAXgyycSBL8etih5:22 a=FdTzh2GWekK77mhwV6Dw:22
X-Proofpoint-GUID: COJsIVlI7UyqPx1xo9fmzUHm1Nut5_Qn
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzA0MDA2MiBTYWx0ZWRfX/vAzfW37OFdO kThEVwlgPsFGWOzhC3w9cNGQJtaDs/4dge6WHNPExQKPOZvbnpvGn4qlGwLtb6ACygP2BenF2IW 6zUxy+LNscIwcSg8h2oNt2CeX9Uq8AkJNgCNGwiMPrm28eRAQiFAyQeKgjQut3vLCv/sr+Reohi
 hknUsomUJOewzlL0szroTsHSDnb8q46Oon1xfpEOktPmg5hLg4CR3J8iME22lgiXj4m5XPtP7LJ D7N2/ayXIeWqTH7qr/OcrexRgDeAxwW8XXPgJHMyx8QcyuMzDqGC9uPFbKM6Sg8Y/mFRBE+kJTg toJd8dQVGAa3acbXDkpTuEZKw5t1eNrthdc3NfxHKdw7N9fyc1fngAxEr2aWwcU6cIEI2Cttf/4
 8qDze22Xe4l2hQCtBnay6p9uqIarAd8cOhNfI27busJ6c5kSEa75k27CiqqH96Wil+7zhuiD
X-Proofpoint-ORIG-GUID: COJsIVlI7UyqPx1xo9fmzUHm1Nut5_Qn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-04_03,2025-07-02_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1011 mlxlogscore=718
 phishscore=0 impostorscore=0 bulkscore=0 spamscore=0 suspectscore=0
 mlxscore=0 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.21.0-2505280000
 definitions=main-2507040062

If the parent qdisc does not support class operations then exit notify.

In addition, the validity of the cl value is judged before executing the
notify. Similarly, the notify is exited when the address represented by
its value is invalid.

Reported-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1261670bbdefc5485a06
Tested-by: syzbot+1261670bbdefc5485a06@syzkaller.appspotmail.com
Signed-off-by: Lizhi Xu <lizhi.xu@windriver.com>
---
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
+		if (cops && notify && cops->qlen_notify) {
 			/* Note that qlen_notify must be idempotent as it may get called
 			 * multiple times.
 			 */
 			cl = cops->find(sch, parentid);
-			cops->qlen_notify(sch, cl);
+			if (virt_addr_valid(cl))
+				cops->qlen_notify(sch, cl);
 		}
 		sch->q.qlen -= n;
 		sch->qstats.backlog -= len;
-- 
2.43.0


