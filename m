Return-Path: <netdev+bounces-195789-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E7551AD23C2
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 18:25:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B35EA7A17F4
	for <lists+netdev@lfdr.de>; Mon,  9 Jun 2025 16:23:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879E4211A2A;
	Mon,  9 Jun 2025 16:25:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="ZFVjFFww"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAA53199939
	for <netdev@vger.kernel.org>; Mon,  9 Jun 2025 16:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749486302; cv=none; b=mhNNahjUF3/0nORcgFA4O+FUfxQNm+FqSRCjoIZa2H04eHqNe1eeBFMxMtEpXFIjSNn89GGGW2Z+QFJCbSI2N6JLKw49V9Fa/CLKZdNnbOWb3LFjwcB8d8ShyeiIRwHks47ve+BRnB31k/VcxB26xsmbarJhELFLgJAMKPw1wSk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749486302; c=relaxed/simple;
	bh=BCts238fw86cRl/doLIV7qPA4CGyAdFhQhzYizTmO0g=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=f7gpFq034JUIVWM8qyewdLKqmQxl5KGWHhm/T+NB2F4fBZ+llemnZLV5b7nNfSK0rpzfxGGFART+CM8fjbb4HWtcwg33b548PDLLl+7XJ2mOG6wecF9GvBnV4JxJKOgnkKHodPALzDsx2T7SVqvqYdNLKdWH9b5A5aIle551gos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=ZFVjFFww; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050102.ppops.net [127.0.0.1])
	by m0050102.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 559ETcKq008929;
	Mon, 9 Jun 2025 17:13:02 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=GZV5WabxiyC56sOeBumt4vSyXxKvdvH+X
	3wP8+I+ZYw=; b=ZFVjFFwwTXViiRV58TPnXf3z1JQddyYEk0Y5p3G54DjTHBMIa
	e2R+P71j6ofUODUNNHTuzc5bWNZfA5Q8p6Wjm2r7uAAD5BUCJjy3VrKOq7IWygfj
	H7G3GUgqVJvRCuRk1xSHl5jcgqmbhVvT8ucBcuhSLOzGnprtdln1Ok0MtOq2DSTA
	LhmRrcGl9hpfBkt5uCeoWg8+A+36FRJkoEghTlHbB0Z8T0e7T/tlm/SpX0+XGZoc
	Apz8WHh/dl2DDPigbEVZvnoZua9z9vaVoRuCd2JdmE+YFtFpwsr29CoCvjBt3/t2
	Vf+wY6ml1ct/LVcGGvCGfm5EmliYXhpAFlmNQ==
Received: from prod-mail-ppoint5 (prod-mail-ppoint5.akamai.com [184.51.33.60] (may be forged))
	by m0050102.ppops.net-00190b01. (PPS) with ESMTPS id 474agn5qk6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 09 Jun 2025 17:13:02 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint5.akamai.com [127.0.0.1])
	by prod-mail-ppoint5.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 559ESiQN009211;
	Mon, 9 Jun 2025 09:13:01 -0700
Received: from prod-mail-relay11.akamai.com ([172.27.118.250])
	by prod-mail-ppoint5.akamai.com (PPS) with ESMTP id 474kdb01qk-1;
	Mon, 09 Jun 2025 09:13:01 -0700
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay11.akamai.com (Postfix) with ESMTP id 4581B33970;
	Mon,  9 Jun 2025 16:13:01 +0000 (GMT)
From: Jason Baron <jbaron@akamai.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com, horms@kernel.org, kuniyu@amazon.com
Subject: [PATCH net-next] netlink: Fix wraparounds of sk->sk_rmem_alloc
Date: Mon,  9 Jun 2025 12:12:44 -0400
Message-Id: <20250609161244.3591029-1-jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 malwarescore=0 adultscore=0 mlxscore=0 spamscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2505160000 definitions=main-2506090119
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA5MDEyMSBTYWx0ZWRfX97VvPFq5xovD
 Vum24GG19wbQj+wSVAmlshUJiYHos1plw08IABOz+Iv7ki9qNRE1kViynLN2GpR+NTSqr9bp9aQ
 SpCxd8nfBFfVpehqJcd/3WyKkQpNKL9ohUfbj5QY5cK/gpeLJYQU8eFUNtfNJ4hlRd5mM/AmlS2
 bdT/CuorB1pLBS2JAS+mgzke5JpbDylmHedaqT0wq6sXFfDqbltzR6NPwi3YQ7qEsPtiG5pp9AF
 u96i4YOgFhcyALoOXqIT93gycoQeHDkBCMrgL96V1fhei/7JYZ7OqI5x336m8NxrO5Uq3QIY1WK
 xBANUsi44uGgsSQuM1bHRD+OHdV0jhlhT+E5KzFsphNntRoCqQYTLHOCHHLbR7pwR/UmKjB7o/C
 VScck8rbVYm01Vj4KFs3uG7bAoNk1TSycNhQIKykkACtKQZZySNmaqmUvU05qHRYFDKECOfY
X-Authority-Analysis: v=2.4 cv=LI5mQIW9 c=1 sm=1 tr=0 ts=6847080e cx=c_pps
 a=NpDlK6FjLPvvy7XAFEyJFw==:117 a=NpDlK6FjLPvvy7XAFEyJFw==:17
 a=6IFa9wvqVegA:10 a=X7Ea-ya5AAAA:8 a=2p7L7b79wo0mKIl_s0IA:9
X-Proofpoint-ORIG-GUID: J1RcJ5Ih8vgSB1IdebK0NPAP5DiNiNc8
X-Proofpoint-GUID: J1RcJ5Ih8vgSB1IdebK0NPAP5DiNiNc8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-09_06,2025-06-09_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 malwarescore=0 phishscore=0 mlxscore=0 lowpriorityscore=0
 spamscore=0 mlxlogscore=759 adultscore=0 bulkscore=0 suspectscore=0
 clxscore=1011 impostorscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506090121

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
5a465a0da13e ("udp: Fix multiple wraparounds of sk->sk_rmem_alloc.")

As noted in that fix, if there are multiple threads writing to a
netlink socket it's possible to slightly exceed rcvbuf value. But as
noted this avoids an expensive 'atomic_add_return()' for the common
case. I've confirmed that with the fix the modified program from
SOCK_DIAG(7) can no longer fill memory and the sk->sk_rcvbuf limit
is enforced.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 net/netlink/af_netlink.c | 47 ++++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/net/netlink/af_netlink.c b/net/netlink/af_netlink.c
index e8972a857e51..607e5d72de39 100644
--- a/net/netlink/af_netlink.c
+++ b/net/netlink/af_netlink.c
@@ -1213,11 +1213,15 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		      long *timeo, struct sock *ssk)
 {
 	struct netlink_sock *nlk;
+	unsigned int rmem, rcvbuf, size;
 
 	nlk = nlk_sk(sk);
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	size = skb->truesize;
 
-	if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
-	     test_bit(NETLINK_S_CONGESTED, &nlk->state))) {
+	if (((rmem + size) > rcvbuf) ||
+	     test_bit(NETLINK_S_CONGESTED, &nlk->state)) {
 		DECLARE_WAITQUEUE(wait, current);
 		if (!*timeo) {
 			if (!ssk || netlink_is_kernel(ssk))
@@ -1230,7 +1234,9 @@ int netlink_attachskb(struct sock *sk, struct sk_buff *skb,
 		__set_current_state(TASK_INTERRUPTIBLE);
 		add_wait_queue(&nlk->wait, &wait);
 
-		if ((atomic_read(&sk->sk_rmem_alloc) > sk->sk_rcvbuf ||
+		rmem = atomic_read(&sk->sk_rmem_alloc);
+		rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+		if ((((rmem + size) > rcvbuf) ||
 		     test_bit(NETLINK_S_CONGESTED, &nlk->state)) &&
 		    !sock_flag(sk, SOCK_DEAD))
 			*timeo = schedule_timeout(*timeo);
@@ -1383,12 +1389,18 @@ EXPORT_SYMBOL_GPL(netlink_strict_get_check);
 static int netlink_broadcast_deliver(struct sock *sk, struct sk_buff *skb)
 {
 	struct netlink_sock *nlk = nlk_sk(sk);
+	unsigned int rmem, rcvbuf;
 
-	if (atomic_read(&sk->sk_rmem_alloc) <= sk->sk_rcvbuf &&
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+
+	if (((rmem + skb->truesize) <= rcvbuf) &&
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
@@ -1896,6 +1908,7 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 	size_t copied, max_recvmsg_len;
 	struct sk_buff *skb, *data_skb;
 	int err, ret;
+	unsigned int rmem, rcvbuf;
 
 	if (flags & MSG_OOB)
 		return -EOPNOTSUPP;
@@ -1960,12 +1973,15 @@ static int netlink_recvmsg(struct socket *sock, struct msghdr *msg, size_t len,
 
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
 
@@ -2250,6 +2266,7 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	int err = -ENOBUFS;
 	int alloc_min_size;
 	int alloc_size;
+	unsigned int rmem, rcvbuf;
 
 	if (!lock_taken)
 		mutex_lock(&nlk->nl_cb_mutex);
@@ -2258,9 +2275,6 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 		goto errout_skb;
 	}
 
-	if (atomic_read(&sk->sk_rmem_alloc) >= sk->sk_rcvbuf)
-		goto errout_skb;
-
 	/* NLMSG_GOODSIZE is small to avoid high order allocations being
 	 * required, but it makes sense to _attempt_ a 32KiB allocation
 	 * to reduce number of system calls on dump operations, if user
@@ -2283,6 +2297,11 @@ static int netlink_dump(struct sock *sk, bool lock_taken)
 	if (!skb)
 		goto errout_skb;
 
+	rmem = atomic_read(&sk->sk_rmem_alloc);
+	rcvbuf = READ_ONCE(sk->sk_rcvbuf);
+	if ((rmem + skb->truesize) > rcvbuf)
+		goto errout_skb;
+
 	/* Trim skb to allocated size. User is expected to provide buffer as
 	 * large as max(min_dump_alloc, 32KiB (max_recvmsg_len capped at
 	 * netlink_recvmsg())). dump will pack as many smaller messages as
-- 
2.25.1


