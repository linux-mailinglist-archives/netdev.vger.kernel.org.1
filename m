Return-Path: <netdev+bounces-164072-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBA93A2C8AA
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 17:25:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B2ACD163E84
	for <lists+netdev@lfdr.de>; Fri,  7 Feb 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 725C818DB15;
	Fri,  7 Feb 2025 16:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cn8vNbRO"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69C118BC20
	for <netdev@vger.kernel.org>; Fri,  7 Feb 2025 16:24:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738945453; cv=none; b=NZD4cEdZUCRNFYrXXaQ3d/pd/qzT8iZcq5bhz2G9YHPejxY7YSBkr8t0eGMnJvfcCpxg6QVWLT9tTfrQ4zYwjjK/egjEWBdMcKvwePbIosDCcHXBoV4FEsBg0lfvjkZ8ztkywUQ6a8i/jRJgek8EAu7ly2wnbldvAxzmBNVcw14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738945453; c=relaxed/simple;
	bh=Fv2fuQjXq49uDGLE6JxKb/y6cJspOaPx/h8OPfSc/s8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIMm31W8mOLPWtrgW4b8dLl7TtqalGBF3yBXF2wD3ApyNC291bge/Tr6YukxEkRgexaaHcN1xEh2IZbtDvPRBiKL/q0Sd2ldPXsn59AorwrGRDYA49et3aCMdOsNeipSRJI+2iy8lnLnQfXhcUP+x4UG8F3Bn7vSGrLEMcCwymQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cn8vNbRO; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1738945450;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0bLfkDEj2E+amlN32Zmy1NdkYfixAmKCV79M3Gjc66Q=;
	b=cn8vNbRO+i2rAJsTIwHDATd32hYnym/ovp5YjzbcsvzI38JVG4c1rIPUR6QpckXDDpfBwh
	CLNEpbxka4iioPrsqkhDHH2ynVB7Rq+PQKogOHItsGJZ403ETfIsUComtrME/BuvUcfS/L
	3W9BHX2vamgbDBzElgWTkomQSOHYlbk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-661-LxWGqNVXMC-hWAV7l7PkZw-1; Fri,
 07 Feb 2025 11:24:07 -0500
X-MC-Unique: LxWGqNVXMC-hWAV7l7PkZw-1
X-Mimecast-MFC-AGG-ID: LxWGqNVXMC-hWAV7l7PkZw
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 5C4FA180087B;
	Fri,  7 Feb 2025 16:24:05 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.205])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 4894E3001D12;
	Fri,  7 Feb 2025 16:24:02 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Neal Cardwell <ncardwell@google.com>,
	David Ahern <dsahern@kernel.org>
Subject: [RFC PATCH 2/2] udp: avoid false sharing via protocol specific set_tsflags
Date: Fri,  7 Feb 2025 17:23:45 +0100
Message-ID: <e7942894834908523a65147c2cce026537059f87.1738940816.git.pabeni@redhat.com>
In-Reply-To: <cover.1738940816.git.pabeni@redhat.com>
References: <cover.1738940816.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

After commit 5d4cc87414c5 ("net: reorganize "struct sock" fields"),
the sk_tsflags field shares the same cacheline with sk_forward_alloc.

The UDP protocol does not acquire the sock lock in the RX path;
forward allocations are protected via the receive queue spinlock.

Due to the above, under high packet rate traffic, when the BH and the
user-space process run on different CPUs, UDP packet reception will
experience a cache miss while accessing sk_tsflags.

Similarly to commit f796feabb9f5 ("udp: add local "peek offset enabled"
flag"), add a new field in the udp_sock struct to store a copy of the
ts_flags value in a cache friendly manner.

Use the newly introduced protocol op to sync-up the new field at every
sk_tsflags update.

With this patch applied, on an AMD epic server with i40e NICs, I
measured a 10% performance improvement for small packets UDP flood
performance tests - possibly a larger delta could be observed with more
recent H/W.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/udp.h | 12 ++++++++++++
 include/net/sock.h  | 14 ++++++++++----
 net/ipv4/udp.c      |  3 ++-
 net/ipv6/udp.c      |  3 ++-
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index 0807e21cfec9..b186ac20fd38 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -101,6 +101,9 @@ struct udp_sock {
 
 	/* Cache friendly copy of sk->sk_peek_off >= 0 */
 	bool		peeking_with_offset;
+
+	/* Cache friendly copy of sk_tsflags & TSFLAGS_ANY */
+	bool		tsflags_any;
 };
 
 #define udp_test_bit(nr, sk)			\
@@ -125,6 +128,15 @@ static inline int udp_set_peek_off(struct sock *sk, int val)
 	return 0;
 }
 
+static inline int udp_set_tsflags(struct sock *sk, int val)
+{
+	WRITE_ONCE(udp_sk(sk)->tsflags_any, !!(val & TSFLAGS_ANY));
+	if (val & SOF_TIMESTAMPING_OPT_ID &&
+	    !(sk->sk_tsflags & SOF_TIMESTAMPING_OPT_ID))
+		atomic_set(&sk->sk_tskey, 0);
+	return 0;
+}
+
 static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 {
 	udp_assign_bit(NO_CHECK6_TX, sk, val);
diff --git a/include/net/sock.h b/include/net/sock.h
index 282dd23b90dc..5767c2dace2a 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -2660,8 +2660,8 @@ void __sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		       struct sk_buff *skb);
 
 #define SK_DEFAULT_STAMP (-1L * NSEC_PER_SEC)
-static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
-				   struct sk_buff *skb)
+static inline void sock_do_recv_cmsgs(struct msghdr *msg, struct sock *sk,
+				      struct sk_buff *skb, bool tsflags_any)
 {
 #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)			| \
 			   (1UL << SOCK_RCVTSTAMP)			| \
@@ -2670,8 +2670,7 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
-	if (sk->sk_flags & FLAGS_RECV_CMSGS ||
-	    READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
+	if (sk->sk_flags & FLAGS_RECV_CMSGS || tsflags_any)
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
@@ -2679,6 +2678,13 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 		sock_write_timestamp(sk, 0);
 }
 
+static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
+				   struct sk_buff *skb)
+{
+	return sock_do_recv_cmsgs(msg, sk, skb,
+				  READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY);
+}
+
 void __sock_tx_timestamp(__u32 tsflags, __u8 *tx_flags);
 
 /**
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438e..001bb4579330 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -2084,7 +2084,7 @@ int udp_recvmsg(struct sock *sk, struct msghdr *msg, size_t len, int flags,
 		UDP_INC_STATS(sock_net(sk),
 			      UDP_MIB_INDATAGRAMS, is_udplite);
 
-	sock_recv_cmsgs(msg, sk, skb);
+	sock_do_recv_cmsgs(msg, sk, skb, udp_sk(sk)->tsflags_any);
 
 	/* Copy the address. */
 	if (sin) {
@@ -3191,6 +3191,7 @@ struct proto udp_prot = {
 	.destroy		= udp_destroy_sock,
 	.setsockopt		= udp_setsockopt,
 	.getsockopt		= udp_getsockopt,
+	.tsflags		= udp_set_tsflags,
 	.sendmsg		= udp_sendmsg,
 	.recvmsg		= udp_recvmsg,
 	.splice_eof		= udp_splice_eof,
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index c6ea438b5c75..28e2eb331ceb 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -532,7 +532,7 @@ int udpv6_recvmsg(struct sock *sk, struct msghdr *msg, size_t len,
 	if (!peeking)
 		SNMP_INC_STATS(mib, UDP_MIB_INDATAGRAMS);
 
-	sock_recv_cmsgs(msg, sk, skb);
+	sock_do_recv_cmsgs(msg, sk, skb, udp_sk(sk)->tsflags_any);
 
 	/* Copy the address. */
 	if (msg->msg_name) {
@@ -1917,6 +1917,7 @@ struct proto udpv6_prot = {
 	.destroy		= udpv6_destroy_sock,
 	.setsockopt		= udpv6_setsockopt,
 	.getsockopt		= udpv6_getsockopt,
+	.tsflags		= udp_set_tsflags,
 	.sendmsg		= udpv6_sendmsg,
 	.recvmsg		= udpv6_recvmsg,
 	.splice_eof		= udpv6_splice_eof,
-- 
2.48.1


