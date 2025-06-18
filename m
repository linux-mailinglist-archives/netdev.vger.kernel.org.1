Return-Path: <netdev+bounces-199280-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FCC0ADFA0C
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05FB1899EFE
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:12:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 655527464;
	Thu, 19 Jun 2025 00:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="fQKmqOLU"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C352184F
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 00:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750291938; cv=none; b=TLj1fBp0NBZQVO/GKfMg/diULqZxQZJl4uf80QARKw9dc5NhWNRGUgYoWnqvjZjbiIVAR9eKMGzGCaDsYe6tGf0fyY+GnHosqoyBbu5LsgNmzXpG+bkAzeS+/EEvl+UDUDn0XADTclE9mcugKZn/UyY1FT/lA+G/WQZu66Ffzjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750291938; c=relaxed/simple;
	bh=Znhl+XTYXIA9gVuw2Csztz6Obua1PSDQMCyYO2uTjEI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=t1HguDiSaWPfF4VIvqwnP3ghUjZSv7giq5N2LQkFr4llVxpJU8J2MdwuoFBXbgncrY5wwYsaPqxm2V/CrjpkQ4QuuDlQt8R7YVu6lQ3VLxEfGoDWCo+p55EWpKhOBU9sv3+ANksnAuVdrygjLhHLJ3hkTA5UjPs5R5zcGVWWGnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=fQKmqOLU; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 55ILU5BE001765;
	Thu, 19 Jun 2025 00:13:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=fM70JcWK1
	O6OoLDKK/sqxGDGA7bzJGB3MmPO3OUXsK0=; b=fQKmqOLU+djPQLtxWDW2VrfFc
	KCOG74CV+r2ARfhCXv6qRfryKcO8qVTFwOLRm7X5tMUiMjp1N9N6VfZyBgPP1kp0
	VOboCp0F9ak3OvjKDn0/6+HYsxs2CBcWuIx2aNw8LC32kOFBPOE6K2erYNv1KClF
	aCOTdni2brHAY6b/WpSpAZKAD3Q2sLcwNS/ARgmeCot+FwjwJVw+Ch5lOfY+fwO2
	Nr2E7DsFBeJ7d3l4q2IS4EXSqBxSSIr/K7wCN3nngwCxEIr0NekOqT4WaKirqekJ
	0mJn3kDsPgaw16jlO+0igy0MKiL3bMGt1oaliR/nYW0QLk+RaK30nmU2ygmXg==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 4791gfyy2c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 00:13:47 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 55IMgdkn014221;
	Wed, 18 Jun 2025 19:13:46 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 47bt18uhm2-1;
	Wed, 18 Jun 2025 19:13:46 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 1028A33B2C;
	Wed, 18 Jun 2025 23:13:46 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: [PATCH net-next v2 2/3] udp: use __sock_rcvbuf_has_space() helper
Date: Wed, 18 Jun 2025 19:13:22 -0400
Message-Id: <c4b522bbcc0bef99a917c331949b0a6840fcab4c.1750285100.git.jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1750285100.git.jbaron@akamai.com>
References: <cover.1750285100.git.jbaron@akamai.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=777 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180198
X-Proofpoint-ORIG-GUID: _phhKwRTTG_vWgabL5Ag0mGAa12caTek
X-Proofpoint-GUID: _phhKwRTTG_vWgabL5Ag0mGAa12caTek
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDIwMCBTYWx0ZWRfX7sNu3jNSna5u
 smoHrJUVCrhnKSUXpJ7+NQm2njItvshcTeS7k1ijI1+sSs9uY69b4eiiADx5NF1Oxt3//r5g98C
 WvZmf8pPWnlcse6YYkoCv8NDXWBjg+WVIDlibIS5Un8kpoZ3O3+ZLiZ+0lryWw9tH0NfbVl6yvU
 Puzhui6QnAkl3kJNTQrY319z5LIzjW42GKuDpBze/8bOZx6JplHcKAPQcrFL3khwUeSS24pwxxL
 1BX/s0v6fAyC4vT1TOrE2T39udZAmy1CakWvxIASP3nQJ37FtLvCcZbiDEC/mKS2oc6wQh6ciPa
 Jt1K235NfPblc59EKaWn0ZATVGjjKcFawl4+ungDWL3AC9TVA79FWJVa6qghSwscElzd3n7qb00
 PtsCPKPFsqkP562Q/Q+TvdVLmL7pV9aXZuizndNfjMroWviblz/N1JyBUCOHK4flzIq05xmt
X-Authority-Analysis: v=2.4 cv=Qc1mvtbv c=1 sm=1 tr=0 ts=6853482b cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=6IFa9wvqVegA:10 a=X7Ea-ya5AAAA:8 a=4e7UgTkSTAAOCcoRnsgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 bulkscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 impostorscore=0 priorityscore=1501
 clxscore=1015 mlxlogscore=547 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180200

Make use of __sock_rcvbuf_has_space() in __udp_enqueue_schedule_skb().

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 net/ipv4/udp.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index dde52b8050b8..64e6c34a8fb8 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1733,17 +1733,8 @@ int __udp_enqueue_schedule_skb(struct sock *sk, struct sk_buff *skb)
 	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
 	size = skb->truesize;
 
-	/* Immediately drop when the receive queue is full.
-	 * Cast to unsigned int performs the boundary check for INT_MAX.
-	 */
-	if (rmem + size > rcvbuf) {
-		if (rcvbuf > INT_MAX >> 1)
-			goto drop;
-
-		/* Always allow at least one packet for small buffer. */
-		if (rmem > rcvbuf)
-			goto drop;
-	}
+	if (!__sock_rcvbuf_has_space(rmem, rcvbuf, size))
+		goto drop;
 
 	/* Under mem pressure, it might be helpful to help udp_recvmsg()
 	 * having linear skbs :
-- 
2.25.1


