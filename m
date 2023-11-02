Return-Path: <netdev+bounces-45782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F10557DF8A8
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 18:25:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7F27DB213FA
	for <lists+netdev@lfdr.de>; Thu,  2 Nov 2023 17:25:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E1ED208A4;
	Thu,  2 Nov 2023 17:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="FNmbrpb0"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 963351DFE8
	for <netdev@vger.kernel.org>; Thu,  2 Nov 2023 17:25:34 +0000 (UTC)
Received: from mx1.spacex.com (mx1.spacex.com [192.31.242.181])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C24B8186;
	Thu,  2 Nov 2023 10:25:28 -0700 (PDT)
Received: from pps.filterd (mx1.spacex.com [127.0.0.1])
	by mx1.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A2FpdVM024140;
	Thu, 2 Nov 2023 10:25:27 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=u5nTFczinMbKC419gGXDYXffxQCYXXRjYzsEU4unQ0k=;
 b=FNmbrpb07laHEXAFNbjH0N5QJN5rNBJiXT+iS1CfZhHC+3KA7IvxxrykZnApU6HbsfAx
 2H6t3MNmcs4vfdgMjLQC8tIX/q3idnuIgYFJJ4l0Cs0dUXgd8z095VAGpcUZrYmJzQIM
 cJ5H0dxn29U8XkSdYGwt7TdVSASXpAA8HqUeBlziYVGOBcdY6EciFvKfQcFcbumcti41
 +QLVLPzuv2whhb0Kq7O3cQbRCdAA8XkLuS1jDZVTjjsxheFADHLBJzXA2I/0gLSmaJ7j
 HxvY7HfoXmyyfZl0xwLDV810+D/QFpMyNQgD5khvZn6F2MT3dSd+/RRwnYGsNiwgZ6PK ww== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx1.spacex.com (PPS) with ESMTPS id 3u0yqhja34-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Thu, 02 Nov 2023 10:25:26 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Thu, 2 Nov 2023 10:25:26 -0700
From: <alexey.pakhunov@spacex.com>
To: <mchan@broadcom.com>
CC: <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <siva.kallam@broadcom.com>,
        <prashant@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH v2 1/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Thu, 2 Nov 2023 10:25:02 -0700
Message-ID: <20231102172503.3413318-2-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231102172503.3413318-1-alexey.pakhunov@spacex.com>
References: <20231102172503.3413318-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: HT-DC-EX-D2-N1.spacex.corp (10.34.3.233) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-GUID: IehV9YORpeDyNv2Cqoen79_rvluU8GBt
X-Proofpoint-ORIG-GUID: IehV9YORpeDyNv2Cqoen79_rvluU8GBt
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 malwarescore=0 impostorscore=0 spamscore=0 bulkscore=0
 phishscore=0 mlxscore=0 suspectscore=0 lowpriorityscore=0 adultscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311020143

From: Alex Pakhunov <alexey.pakhunov@spacex.com>

tg3_tso_bug() drops a packet if it cannot be segmented for any reason.
The number of discarded frames should be incremeneted accordingly.

Signed-off-by: Alex Pakhunov <alexey.pakhunov@spacex.com>
Signed-off-by: Vincent Wong <vincent.wong2@spacex.com>
---
 drivers/net/ethernet/broadcom/tg3.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/broadcom/tg3.c b/drivers/net/ethernet/broadcom/tg3.c
index 14b311196b8f..99638e6c9e16 100644
--- a/drivers/net/ethernet/broadcom/tg3.c
+++ b/drivers/net/ethernet/broadcom/tg3.c
@@ -7874,8 +7874,10 @@ static int tg3_tso_bug(struct tg3 *tp, struct tg3_napi *tnapi,
 
 	segs = skb_gso_segment(skb, tp->dev->features &
 				    ~(NETIF_F_TSO | NETIF_F_TSO6));
-	if (IS_ERR(segs) || !segs)
+	if (IS_ERR(segs) || !segs) {
+		tp->tx_dropped++;
 		goto tg3_tso_bug_end;
+	}
 
 	skb_list_walk_safe(segs, seg, next) {
 		skb_mark_not_on_list(seg);
-- 
2.39.3


