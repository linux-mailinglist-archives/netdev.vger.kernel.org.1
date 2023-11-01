Return-Path: <netdev+bounces-45571-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18DC67DE668
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 20:34:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 46E541C20B0A
	for <lists+netdev@lfdr.de>; Wed,  1 Nov 2023 19:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 887166130;
	Wed,  1 Nov 2023 19:34:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=spacex.com header.i=@spacex.com header.b="NvmSdSR5"
X-Original-To: netdev@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7997119BAE
	for <netdev@vger.kernel.org>; Wed,  1 Nov 2023 19:34:15 +0000 (UTC)
Received: from mx5.spacex.com (mx5.spacex.com [192.31.242.32])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7581E1A4;
	Wed,  1 Nov 2023 12:33:58 -0700 (PDT)
Received: from pps.filterd (mx5.spacex.com [127.0.0.1])
	by mx5.spacex.com (8.17.1.19/8.17.1.19) with ESMTP id 3A1Hu1q0017139;
	Wed, 1 Nov 2023 12:19:20 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=spacex.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=dkim;
 bh=u5nTFczinMbKC419gGXDYXffxQCYXXRjYzsEU4unQ0k=;
 b=NvmSdSR5ABbSrmavaorKKMYNLxlpyZiRkOehW7qqkPQIevR9BBQh8pxfAQIG1SDXZ5hM
 SrCDyZe+Ce+96TAUaC9vOb8MvSomI4VSJR82CdjRxQ+NLMqoUWhpWv731FzwwGu17IzJ
 TPqeaOe4aw3joLcKFiGThnFh35jR7zCPdKvOrVXLQPxLiUVcJsZnv1ZfCjA3briCcJF0
 Ywh0PR4PpAaXwk4jjiBZbzNq/nJi1Z9ycWdnWnH+DRm+gMEJNxhIE7jauqgkDM6m/qxv
 ESOLDMkI8kpFP+zbmHu7FFUwMlbyHcdvxbPR7ZRq66YBofy/YDTnFT9M7q8CDGZdBXjc yA== 
Received: from smtp.spacex.corp ([10.34.3.234])
	by mx5.spacex.com (PPS) with ESMTPS id 3u0yqn5n2d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 01 Nov 2023 12:19:19 -0700
Received: from apakhunov-z4.spacex.corp (10.1.32.161) by
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.34; Wed, 1 Nov 2023 12:19:19 -0700
From: <alexey.pakhunov@spacex.com>
To: <siva.kallam@broadcom.com>
CC: <vincent.wong2@spacex.com>, <netdev@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <prashant@broadcom.com>,
        <mchan@broadcom.com>, Alex Pakhunov <alexey.pakhunov@spacex.com>
Subject: [PATCH 1/2] tg3: Increment tx_dropped in tg3_tso_bug()
Date: Wed, 1 Nov 2023 12:18:57 -0700
Message-ID: <20231101191858.2611154-2-alexey.pakhunov@spacex.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20231101191858.2611154-1-alexey.pakhunov@spacex.com>
References: <20231101191858.2611154-1-alexey.pakhunov@spacex.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: ht-dc-ex-d3-n1.spacex.corp (10.34.3.236) To
 HT-DC-EX-D2-N2.spacex.corp (10.34.3.234)
X-Proofpoint-ORIG-GUID: _FrkX1jLAm5N8w2rcLZE7T7uOHpH8E4K
X-Proofpoint-GUID: _FrkX1jLAm5N8w2rcLZE7T7uOHpH8E4K
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 suspectscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501
 adultscore=0 mlxscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2310240000 definitions=main-2311010142

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


