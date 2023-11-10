Return-Path: <netdev+bounces-46959-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 604827E75E6
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 01:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5DAB72816F4
	for <lists+netdev@lfdr.de>; Fri, 10 Nov 2023 00:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42036380;
	Fri, 10 Nov 2023 00:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="BTgLkuDZ"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 770D07F
	for <netdev@vger.kernel.org>; Fri, 10 Nov 2023 00:24:05 +0000 (UTC)
Received: from mx3.spacex.com (mx3.spacex.com [192.31.242.183])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E226919A3;
	Thu,  9 Nov 2023 16:24:04 -0800 (PST)
Received: from pps.filterd (mx3.spacex.com [127.0.0.1])
	by mx3.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A9MI1G8020504;
	Thu, 9 Nov 2023 16:24:00 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=7ARjb0H0V1+gqRZmJ2lnINAr1r3Hw3d3Dut0iIkSMc0=;
 b=BTgLkuDZm9Kb1uZo8PZAViA7RgeJLBLaVCgBdNlpN6XGHOgZB4vJwjMN9NM/hlpGHcB3
 UnFs8tqnwc2bb5NJuWV0oonjUoydWyOW71KERSnPdz5fs6VLUGh5xznL5aAzAZHch5xp
 dQHpRsx7T3tP1VjWGCdBwV9vPOKGwEiXHtxHbFuEB3ole+psh03lvORS76Luk0zmuHRE
 Nk/7dCj5W0YcHqK08fCvzp3Ia0jeE9vyh8oq3PP8Wtl3nJc5Tqm3UfqF39xu/6ByUf69
 L9V2RYP7orzH8sIEBCFiguIbJ3WQtzS1PsoOEf6HeBOX7hHiMfCePE+gbeKhHXmYAiQa bQ== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx3.spacex.com (PPS) with ESMTPS id 3u7w32c827-2
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 09 Nov 2023 16:24:00 -0800
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 9 Nov 2023 16:23:59 -0800
From: <alexey.pakhunov@spacex.com>
To: <mchan@broadcom.com>
CC: <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <siva.kallam@broadcom.com>,
        <prashant@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH v2 2/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Thu, 9 Nov 2023 16:23:40 -0800
Message-ID: <20231110002340.3612515-2-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
References: <20231110002340.3612515-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d1-n2.spacex.corp (10.34.3.231) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: ZB38W4N60XbL3D5K3i5o_uB4RFMENRMo
X-Proofpoint-GUID: ZB38W4N60XbL3D5K3i5o_uB4RFMENRMo
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxlogscore=999
 mlxscore=0 malwarescore=0 phishscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 suspectscore=0 clxscore=1011
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2311100001

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremented accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index de74a63a02dd..a71df37d78bf 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7874,8 +7874,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tnapi->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.39.3


