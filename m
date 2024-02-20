Return-Path: <netdev+bounces-73253-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 693FC85B9CA
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 12:00:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0AC9B25C24
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8929D65BA1;
	Tue, 20 Feb 2024 11:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EGemfxHt"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B169364CF5
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 11:00:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426824; cv=none; b=IN103RAIbJdhq9ayGxYivnGwoH1Jfd83n/2jCz36O0A8HRVyaSEhzVeTcCBWRm5mvCluMOsboh3EmFjEiYX1pRo5G48h2gd2sSBv2Cn1OjxkwrFnSPkOfBwZET78MhVUoRARnDFyBRfxsXN9EraYY/KagjQP251B3ebVq2Nz0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426824; c=relaxed/simple;
	bh=XsIpv13rz/lT3C5Yk1rY4ipXRcYViObkYE3X8tyh7PA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bcv7m2ghKSJXRMg1y9BQuz66xK3QMvK5rxg1XcU91FwyYmIFGBwaSgxSMtECzA5GS8vMBPjw2eJ+85BWiS0PV7N2STPciSeP/mS8n0XzmPZNHUGNys+Q37q4mjFsNeUI84Ltfu5A/JAxn+qKIecwsPCyMcZL3U4QsDU8GTn+owc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EGemfxHt; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708426821;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=muSp0AC8ZRqk0qQ4C7RjpCavTHloAFHD5hoY2Acwh9o=;
	b=EGemfxHtlqm7WtTqHrwIXljuzXLz8z70fJqDP5spojWx8+iKhshN9fzSp1dVS0lMh2IrqT
	qFSrHod3GAcla0bXqFx/Qlrjg/1b68HBfe7J90oS5+99Kwbjp9TdeVTOEMyC/TKcsfMvap
	Lbd2qYcperLhs6+neqjQdX0c8V3Uz+s=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-GEPawzbhNMm8bIsoFzeYEw-1; Tue,
 20 Feb 2024 06:00:12 -0500
X-MC-Unique: GEPawzbhNMm8bIsoFzeYEw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 068DA3CBD509;
	Tue, 20 Feb 2024 11:00:12 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.74])
	by smtp.corp.redhat.com (Postfix) with ESMTP id B4E3A492BC6;
	Tue, 20 Feb 2024 11:00:10 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	"David S. Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] udp: add local "peek offset enabled" flag
Date: Tue, 20 Feb 2024 12:00:01 +0100
Message-ID: <67ab679c15fbf49fa05b3ffe05d91c47ab84f147.1708426665.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

We want to re-organize the struct sock layout. The sk_peek_off
field location is problematic, as most protocols want it in the
RX read area, while UDP wants it on a cacheline different from
sk_receive_queue.

Create a local (inside udp_sock) copy of the 'peek offset is enabled'
flag and place it inside the same cacheline of reader_queue.

Check such flag before reading sk_peek_off. This will save potential
false sharing and cache misses in the fast-path.

Tested under UDP flood with small packets. The struct sock layout
update causes a 4% performance drop, and this patch restores completely
the original tput.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/linux/udp.h | 10 ++++++++++
 net/ipv4/af_inet.c  |  2 +-
 net/ipv4/udp.c      |  2 +-
 net/ipv6/af_inet6.c |  2 +-
 4 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/include/linux/udp.h b/include/linux/udp.h
index d04188714dca..3748e82b627b 100644
--- a/include/linux/udp.h
+++ b/include/linux/udp.h
@@ -92,6 +92,9 @@ struct udp_sock {
 
 	/* This fields follows rcvbuf value, and is touched by udp_recvmsg */
 	int		forward_threshold;
+
+	/* Cache friendly copy of sk->sk_peek_off >= 0 */
+	bool		peeking_with_offset;
 };
 
 #define udp_test_bit(nr, sk)			\
@@ -109,6 +112,13 @@ struct udp_sock {
 
 #define udp_sk(ptr) container_of_const(ptr, struct udp_sock, inet.sk)
 
+static inline int udp_set_peek_off(struct sock *sk, int val)
+{
+	sk_set_peek_off(sk, val);
+	WRITE_ONCE(udp_sk(sk)->peeking_with_offset, val >= 0);
+	return 0;
+}
+
 static inline void udp_set_no_check6_tx(struct sock *sk, bool val)
 {
 	udp_assign_bit(NO_CHECK6_TX, sk, val);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index ad278009e469..5daebdcbca32 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1103,7 +1103,7 @@ const struct proto_ops inet_dgram_ops = {
 	.recvmsg	   = inet_recvmsg,
 	.mmap		   = sock_no_mmap,
 	.splice_eof	   = inet_splice_eof,
-	.set_peek_off	   = sk_set_peek_off,
+	.set_peek_off	   = udp_set_peek_off,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet_compat_ioctl,
 #endif
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index f631b0a21af4..38cce7cc51f6 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1589,7 +1589,7 @@ int udp_init_sock(struct sock *sk)
 
 void skb_consume_udp(struct sock *sk, struct sk_buff *skb, int len)
 {
-	if (unlikely(READ_ONCE(sk->sk_peek_off) >= 0)) {
+	if (unlikely(READ_ONCE(udp_sk(sk)->peeking_with_offset))) {
 		bool slow = lock_sock_fast(sk);
 
 		sk_peek_offset_bwd(sk, len);
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 959bfd9f6344..b90d46533cdc 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -736,7 +736,7 @@ const struct proto_ops inet6_dgram_ops = {
 	.recvmsg	   = inet6_recvmsg,		/* retpoline's sake */
 	.read_skb	   = udp_read_skb,
 	.mmap		   = sock_no_mmap,
-	.set_peek_off	   = sk_set_peek_off,
+	.set_peek_off	   = udp_set_peek_off,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	   = inet6_compat_ioctl,
 #endif
-- 
2.43.0


