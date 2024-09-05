Return-Path: <netdev+bounces-125361-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 67B1196CE6D
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 07:26:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 60F7E1C21FBE
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 05:26:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E579E158D9C;
	Thu,  5 Sep 2024 05:25:50 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0064b401.pphosted.com (mx0b-0064b401.pphosted.com [205.220.178.238])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27EDB156C49;
	Thu,  5 Sep 2024 05:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.178.238
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725513950; cv=none; b=ZrW3OuW4EUjA3zD3UW85W+2ZE/4PS7PbmJQQo8+faUQpC+FRwJoC3M7JeILTnEnB3QpfrUcMChi3jAMjwTYa//U4ZgPA5e4m3EJDpbkbag7FmFtCxz2C4lGprxMUcX3SM6IFzilNKumjVwV//3oUfC9KdK7Cc4JWXj9jW51ZXtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725513950; c=relaxed/simple;
	bh=hlYt5y+YzZQggi2kZoyJ/OqFeXVYBlKr5525tcgx9NI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ipGenHQkcXMjKbvKQaJb7iVHY9Hu21faoWpKX2IOcG48FdHMAiCbAKBfRy7euOS8ugohuaI2YTZpIUISxxPlYhmY4n83BYOh9ik4UTG2/6jFNCHNev/iqCJFYWJkMNxj9nQIxO7laHNtGUNjeiOPhDCoIb4CHax3DRqNO5Oq/8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com; spf=pass smtp.mailfrom=windriver.com; arc=none smtp.client-ip=205.220.178.238
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=windriver.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=windriver.com
Received: from pps.filterd (m0250812.ppops.net [127.0.0.1])
	by mx0a-0064b401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 485404jj003435;
	Thu, 5 Sep 2024 05:25:36 GMT
Received: from ala-exchng02.corp.ad.wrs.com (ala-exchng02.wrs.com [147.11.82.254])
	by mx0a-0064b401.pphosted.com (PPS) with ESMTPS id 41edxkhg7e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 05 Sep 2024 05:25:36 +0000 (GMT)
Received: from ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.39; Wed, 4 Sep 2024 22:25:35 -0700
Received: from pek-lpd-ccm6.wrs.com (147.11.136.210) by
 ALA-EXCHNG02.corp.ad.wrs.com (147.11.82.254) with Microsoft SMTP Server id
 15.1.2507.39 via Frontend Transport; Wed, 4 Sep 2024 22:25:33 -0700
From: Lizhi Xu <lizhi.xu@windriver.com>
To: <syzbot+8811381d455e3e9ec788@syzkaller.appspotmail.com>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
        <linux-kernel@vger.kernel.org>, <netdev@vger.kernel.org>,
        <pabeni@redhat.com>, <syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [net?] KASAN: slab-use-after-free Read in unix_stream_read_actor (2)
Date: Thu, 5 Sep 2024 13:25:32 +0800
Message-ID: <20240905052532.533159-1-lizhi.xu@windriver.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <00000000000083b05a06214c9ddc@google.com>
References: <00000000000083b05a06214c9ddc@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: ebVJYRI61V4fMB7BaIvaFXlnxYI_NA0r
X-Authority-Analysis: v=2.4 cv=UfsDS7SN c=1 sm=1 tr=0 ts=66d940d0 cx=c_pps a=K4BcnWQioVPsTJd46EJO2w==:117 a=K4BcnWQioVPsTJd46EJO2w==:17 a=EaEq8P2WXUwA:10 a=30vq9JD7qsVYvUCMjDUA:9
X-Proofpoint-GUID: ebVJYRI61V4fMB7BaIvaFXlnxYI_NA0r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-05_04,2024-09-04_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1011
 priorityscore=1501 malwarescore=0 suspectscore=0 phishscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxlogscore=701
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.21.0-2407110000
 definitions=main-2409050037

The sock queue oob twice, the first manage_oob (in unix_stream_read_generic) peek next skb only,
and the next skb is the oob skb, so if skb is oob skb we need use manage_oob dealwith it.

#syz test

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 0be0dcb07f7b..2821a8b5dea9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2918,6 +2918,14 @@ static int unix_stream_read_generic(struct unix_stream_read_state *state,
 
 		/* Mark read part of skb as used */
 		if (!(flags & MSG_PEEK)) {
+#if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+			if (skb == u->oob_skb) {
+				skb = manage_oob(skb, sk, flags, copied);
+				if (!skb && copied) {
+					break;
+				}
+			}
+#endif
 			UNIXCB(skb).consumed += chunk;
 
 			sk_peek_offset_bwd(sk, chunk);

