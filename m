Return-Path: <netdev+bounces-199282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99FBAADFA21
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 02:32:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 519813ADC05
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 00:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4771B2AEE1;
	Thu, 19 Jun 2025 00:32:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="bBXXrDhT"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4146512B94
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 00:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750293135; cv=none; b=nb93YmcxlB5LE6ItdfnrcXaekpBs8yEyNTsedt58xoS9AWQtu/50B2DBLQByFsMKV0E7C4UhuSuTK69ghxklFpMkWGjR0q6/whfgkbeTCJyo+1i1pFIikhIO8F8+V8Uouv3UjmSavXl5XLJpnmTNQ1+1gPVPAifn/UfrVEIy9TY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750293135; c=relaxed/simple;
	bh=F7x0HNyjYicv4KCzM9qo1NQ+W7FbXW2eCfkuBbo+L4Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=F4UaR+BzY1iLM6P/DMzF+yxRQU/3eTiFdbjTEwJohP3hDkh8uODi7OLYZPw3MFV7iXqSecNOlTmU9E9d3hol9+Sb6zXh/AZ9zmkJ5/df+4XvJPUUQlpFNjZ8/A11dmfNF9RgPyLU66lnzhstdCqCWRVL/mNTvR9ZTpR6xYSuh9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=bBXXrDhT; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 55I3ohpD013922;
	Thu, 19 Jun 2025 00:13:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=jan2016.eng; bh=xftjUoJfo
	nllZwARc+X9z5CJk3MztJkX7vq6oIi0dkY=; b=bBXXrDhTxzt/w06eUj8grGKgX
	KN1kiLzzUa/a0/JjSYpBW8bdiexyP8jJjb6R8vE+JSbG0XQXT2uzzQHpemZ3SoAQ
	SR8qecU/EoAqb2IxIgevvr4TWKpSlP23ZjU/sbCwOe/rST+QOwMjNzmPXj70MHlB
	Ryo+HuQftskvEHOmFjWThJZYbROZ20lajuiij759DUWmabKcjEs9RqC1siLS1xM0
	W+VA9QAx7MPgYfCsQmg/LBJ2mTZjQcAYLK3jl1pmezAK6DsYFSCpKJaxiWI0/KLd
	kWtnCqDiuN00JQQb7sC0S+HZCZSh+FxcO+06SCOsSCbeZW+0PzbrGSnI73A1g==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61] (may be forged))
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 479ywx4k9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 19 Jun 2025 00:13:47 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 55IKDjHV014241;
	Wed, 18 Jun 2025 19:13:47 -0400
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 47bt18uhm3-1;
	Wed, 18 Jun 2025 19:13:46 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id B528333B2C;
	Wed, 18 Jun 2025 23:13:46 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: [PATCH net-next v2 3/3] netlink: Fix wraparound of sk->sk_rmem_alloc
Date: Wed, 18 Jun 2025 19:13:23 -0400
Message-Id: <2ead6fd79411342e29710859db0f1f8520092f1f.1750285100.git.jbaron@akamai.com>
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
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2505160000
 definitions=main-2506180198
X-Authority-Analysis: v=2.4 cv=QrJe3Uyd c=1 sm=1 tr=0 ts=6853482b cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=6IFa9wvqVegA:10 a=X7Ea-ya5AAAA:8 a=z0bhhujUbeS484nQw1MA:9
X-Proofpoint-GUID: uRxRxyAVbDJZkPDyjkwEDlNOuPbwphJg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE4MDIwMCBTYWx0ZWRfX81jzzhDDl8+t
 xgAVz3bdwgs20DJx1g72p4VMQLcDWbB/MrRwa8BlAJQtpaWltHZjVWhmsdchebJgcvYn29ZNIsb
 si2DI2KcsjM+gf+ri6KSTE9lsFC/oUXFACO5MF1Lcln//+plAFt4/Cd0gDt+0M/g7HFjn05a75n
 hvsvFKfU1hqkdXsSj3jUGYtexCB9sbmpE7X64+f2I8vT+7olI16VbFGA43/DSVQhxm80tS5wNd4
 4GkMbcbxx3a8RgLNEPU0Q3CXliQDxIcqIUzQK01k6I01HosRo4B6DdKtQmLwWLPiXpJyi6BcPJQ
 CgHnQiTlitelHcbub7H0h8FWk3Zhgeeng+A7s5oaMqDTGj1MzfPoxpyxH1YMKP0EFGavAUxQynM
 t4oz3X6shva6jD5TrNW3ljOWhAQHq+QifwwItWivXOjxG9yY8EFicnY5arNuC5Mo3AwGmVXp
X-Proofpoint-ORIG-GUID: uRxRxyAVbDJZkPDyjkwEDlNOuPbwphJg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-18_06,2025-06-18_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0
 mlxlogscore=819 adultscore=0 mlxscore=0 phishscore=0 bulkscore=0 spamscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 malwarescore=0
 priorityscore=1501 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506180200

For netlink sockets, when comparing allocated rmem memory with the
rcvbuf limit, the comparison is done using signed values. This means
that if rcvbuf is near INT_MAX, then sk->sk_rmem_alloc may become
negative in the comparison with rcvbuf which will yield incorrect
results.

This can be reproduced by using the program from SOCK_DIAG(7) with
some slight modifications. First, setting sk->sk_rcvbuf to INT_MAX
using SO_RCVBUFFORCE and then secondly running the "send_query()"
in a loop while not calling "receive_responses()". In this case,
the value of sk->sk_rmem_alloc will continuously wrap around
and thus more memory is allocated than the sk->sk_rcvbuf limit.
This will eventually fill all of memory leading to an out of memory
condition with skbs filling up the slab.

Let's fix this in a similar manner to:
commit 5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")

As noted in that fix, if there are multiple threads writing to a
netlink socket it's possible to slightly exceed rcvbuf value. But as
noted this avoids an expensive 'atomic_add_return()' for the common
case. I've confirmed that with the fix the modified program from
SOCK_DIAG(7) can no longer fill memory and the sk->sk_rcvbuf limit
is enforced.

Signed-off-by: Jason Baron <jbaron@akamai.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
---
 net/netlink/af_netlink.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..a770b90abe7d 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1216,8 +1216,8 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 
 	nlk = nlk_sk(sk);
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
+	if (!sock_rcvbuf_has_space(sk, skb) ||
+	    test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		DECLARE_WAITQUEUE(wait, current);
 		if (!*timeo) {
 			if (!ssk || netlink_is_kernel(ssk))
@@ -1230,7 +1230,7 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		__set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&nlk->wait, &wait);
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
+		if ((!sock_rcvbuf_has_space(sk, skb) ||
 		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
 		    !sock_flag(sk, SOCK_DEAD))
 			*timeo = schedule_timeout(*timeo);
@@ -1383,12 +1383,15 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	if (sock_rcvbuf_has_space(sk, skb) &&
 	    !test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		netlink_skb_set_owner_r(skb, sk);
 		__netlink_sendskb(sk, skb);
-		return atomic_read(&sk->sk_rmem_alloc) > (sk->sk_rcvbuf >> 1);
+		rmem = atomic_read(&sk->sk_rmem_alloc);
+		rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+		return rmem > (rcvbuf >> 1);
 	}
 	return -1;
 }
@@ -1895,6 +1898,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	struct netlink_sock *nlk = nlk_sk(sk);
 	size_t copied, max_recvmsg_len;
 	struct sk_buff *skb, *data_skb;
+	unsigned int rmem, rcvbuf;
 	int err, ret;
 
 	if (flags & MSG_OOB)
@@ -1960,12 +1964,15 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
 	skb_free_datagram(sk, skb);
 
-	if (READ_ONCE(nlk->cb_running) &&
-	    atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf / 2) {
-		ret = netlink_dump(sk, false);
-		if (ret) {
-			WRITE_ONCE(sk->sk_err, -ret);
-			sk_error_report(sk);
+	if (READ_ONCE(nlk->cb_running)) {
+		rmem = atomic_read(&sk->sk_rmem_alloc);
+		rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+		if (rmem <= (rcvbuf >> 1)) {
+			ret = netlink_dump(sk, false);
+			if (ret) {
+				WRITE_ONCE(sk->sk_err, -ret);
+				sk_error_report(sk);
+			}
 		}
 	}
 
@@ -2258,9 +2265,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 32KiB allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2283,6 +2287,9 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	if (!sock_rcvbuf_has_space(sk, skb))
+		goto errout_skb;
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
-- 
2.25.1


