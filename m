Return-Path: <netdev+bounces-199277-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FA8ADF9C3
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 01:31:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2D38F17FCEC
	for <lists+netdev@lfdr.de>; Wed, 18 Jun 2025 23:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23372212B38;
	Wed, 18 Jun 2025 23:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="Fh0ouM0G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADEB3085A6
	for <netdev@vger.kernel.org>; Wed, 18 Jun 2025 23:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750289462; cv=none; b=arMkwaIsPI+D36c7PvTSIA1J1GHA+gOGXLhBDAdG/XrLNKPLZS/X+1luwV/hX42Lmyb06uagEkxlOtTxO5RLFrXSD5JNLPwO9W2nV2wEiTdFIHUPC7yKfUshLBiqBUECZR2jN0S6VbWfoR9qWwbc3ycAdGt1GVir8W3+3p2hi68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750289462; c=relaxed/simple;
	bh=asOF6ipxfung4gv2k8p+JIy17qomlLiKINNOr6msEIA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=kf4ieaX6BmdVxZwYYUtWSWaRSm/nOmCy1fNBbaox5s2wCIGzSzbDbfQ6FdWsdLDDRcgS6mm5K82Gn5M3lZmXiUzJTfINWuJEHWALxYx3UhTmdPBCbFUXJvIPEMp1VT8fPoK/vJzYvGGKKmSNljCHXmcrKlvtuIaT7/ZOgApoy1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=Fh0ouM0G; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0122331.ppops.net [127.0.0.1])
	by mx0b-00190b01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55I4t2rN010217;
	Thu, 19 Jun 2025 00:13:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=u1aCRo15v
	sT3gJ2RMtMmzA0zmKnYdO4yx3qRoHzBYKY=; b=Fh0ouM0GYY9E//KzQ/sfp1plV
	cwpKuyL8d/Sk/RK+wbzYQhbXcIV5q85uJRdfYe8kqve6jJliQ/jbEWoaFWw8EGTT
	XL+7Xv1syMP6VW8yulpYtiEScufn244jo7qEvx8lhyVwXpCmqpmMgWBFl7hfXfCR
	39C7S8YWov4nvNg9J7i/d1VOjMGSH0frT1rQvOZapn8K1/2Uo5O1Wn75MCv2hnTV
	FXG+RmX8Hu65VCSRhltJ54lQUnXUYh7i2tAK0QFBEAzmQG+ZtUhiLOOvq7kPeFNq
	KcPOoHpAkQHPgTd1SMOaatATRiLslMUN8p9Lt5AtyZ3Fk9RLn9R2jfWILi2jQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by mx0b-00190b01.pphosted.com (PPS) with ESMTPS id 4791jwq2fq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 00:13:46 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 55IIoOZD027498;
	Wed, 18 Jun 2025 16:13:45 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 47bt2tuk1y-1;
	Wed, 18 Jun 2025 16:13:45 -0700
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 2D79B33B2C;
	Wed, 18 Jun 2025 23:13:45 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: [PATCH net-next v2 1/3] net: add sock_rcvbuf_has_space() helper
Date: Wed, 18 Jun 2025 19:13:21 -0400
Message-Id: <8ceedaa19fb64010ada1db183f7a6ad5a297835b.1750285100.git.jbaron@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 malwarescore=0
 spamscore=0 mlxlogscore=935 adultscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180198
X-Authority-Analysis: v=2.4 cv=N70pF39B c=1 sm=1 tr=0 ts=6853482a cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=6IFa9wvqVegA:10 a=X7Ea-ya5AAAA:8 a=inUz9VF5o64L-tkKYzoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDIwMCBTYWx0ZWRfX0TaER9zgo7yC
 XabFegG9GGt1d0daSiHUOA3RVjsG/l9+a2b4pENMrmygm4GvCIU5Wj6jjHDSNFdxjd+G8deYKTq
 5xdYQUh46WDnVW666U9+I9Qvg9sJPEoHh5YcbQSTvMrbFbP+/fBTLrC9jeIdpHAmCPrCOsEuOUd
 y8bVqoToWUjZ5XSskYQnZg1bPEan/hDKPQszUXgawJWOrEIxLnm9pEO7m/ChewKN+iJ+7uLYIzy
 VgkikZYBOEvK4yNomtuTYPPZH30MpT9hNPWzuNvM2jRPHT+jGfFOy9k4BrNcjMNFH4uwQmGr08f
 DnrNJAxw4oONYllJ/p+ud+8ambIhooipB+UfpzTdfhs4dsw5jv5YIC5y6y3O0VipDOtRkHnku4h
 7D2XYxOJpugEW2dayR9tabODluujIc5sEnugSMpRIX3O/RwaDPRkWfi8C4yukH4r2ZG/MDrk
X-Proofpoint-GUID: JxJLKCMq9HHiLciN-b3uspVBgT-2mBfn
X-Proofpoint-ORIG-GUID: JxJLKCMq9HHiLciN-b3uspVBgT-2mBfn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 malwarescore=0 mlxlogscore=695 suspectscore=0 spamscore=0 adultscore=0
 mlxscore=0 clxscore=1015 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180200

Let's add helper function that abstract the sk->sk_rcvbuf limits check
for wraparound that Kuniyuki Iwashima introduce for udp receive path:

commit 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")

Note that I copied Kuniyuki Iwashima's comments into
sock_rcvbuf_has_space(). Subsequent patches will use this for udp and
netlink sockets.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 include/net/sock.h | 38 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/include/net/sock.h b/include/net/sock.h
index 70c0b570a21f..5f4fdf96bba6 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2484,6 +2484,44 @@ static inline unsigned long sock_wspace(struct sock *sk)
 	return amt;
 }
 
+static inline bool __sock_rcvbuf_has_space(unsigned int rmem,
+					   unsigned int rcvbuf,
+					   unsigned int size)
+{
+	/* Immediately drop when the receive queue is full. */
+	if (rmem + size > rcvbuf) {
+		if (rcvbuf > INT_MAX >> 1)
+			return false;
+
+		/* Always allow at least one packet for small buffer. */
+		if (rmem > rcvbuf)
+			return false;
+	}
+	return true;
+}
+
+/**
+ * sock_rcvbuf_has_space - check if sk->sk_rcvbuf has space
+ * @sk: socket
+ * @skb: socket buffer
+ *
+ * Can skb->truesize bytes be added to the socket receive buffer
+ * while respecting the sk->sk_rcvbuf limit. Note that rcvbuf and
+ * rmem are assigned to unsigned int to avoid wraparound.
+ *
+ * Return: true if there is space, false otherwise
+ */
+static inline bool sock_rcvbuf_has_space(struct sock *sk, struct sk_buff *skb)
+{
+	unsigned int rmem, rcvbuf;
+
+	/* Cast to unsigned int performs the boundary check for INT_MAX. */
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	return __sock_rcvbuf_has_space(rmem, rcvbuf, skb->truesize);
+}
+
 /* Note:
  *  We use sk->sk_wq_raw, from contexts knowing this
  *  pointer is not NULL and cannot disappear/change.
-- 
2.25.1


