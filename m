Return-Path: <netdev+bounces-165234-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4E23A31297
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 18:17:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 140947A05F6
	for <lists+netdev@lfdr.de>; Tue, 11 Feb 2025 17:16:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE54E25A32A;
	Tue, 11 Feb 2025 17:17:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MHMub65e"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406E12505A8
	for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 17:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739294266; cv=none; b=iXU7z7bXGg2WFxz9e1tSVYS3C6DiFHr75URZn/J99kQYzCtaW+x7Vp7HaXYHn2kAFh3aGv1AcAx5okhtXTGhfFzADhDAbkrpax/71EKMfmTR8nFcUBWXoVCS7X9LXUyhOVTlqmqJIye389HOQT+f9IQOM1gkJvaO2WTVKIxP63E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739294266; c=relaxed/simple;
	bh=GPUBYess/ADr8yS7WfA+9yKN4czd57QhYm2khJ/KPJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RZkWNYmFUpQffacbz97HokzUjXkvymIu5UNoJhcMt1Y5CMqSrllMTVILL/Oj+7dJhwVSiCF28kQ2/ptU+vzx5iKq/uuDBall/UkJdTWTRIHhgiwZ1neGFhYU3hr8o57GeSYuzZrTrNWcx939Ts3XhfRSwzpODQnsKiPjYcq8KbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MHMub65e; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739294264;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=6muESH3q8Mi9wJHH40vU4b7FtZv0wal2Ba7btMta4GI=;
	b=MHMub65eOGOBY0ob5/FApvSgRKXRh5r6iV63CKhfr27l5zrz1YOVpUwOXpjZ8TihJqbGrD
	e/a0+qY1nA3bTThERT4zAgi1GZNMrh8ejX2AGXwPkZvn7AsmKooCPSqjuW5PETkJQeNAUu
	audbe9l7tG+Tihlyc0xWO8vlw/oz5Tw=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-649-mPGAhkYgOGqrfW802UqF1w-1; Tue,
 11 Feb 2025 12:17:42 -0500
X-MC-Unique: mPGAhkYgOGqrfW802UqF1w-1
X-Mimecast-MFC-AGG-ID: mPGAhkYgOGqrfW802UqF1w
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8C82D1801A10;
	Tue, 11 Feb 2025 17:17:40 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.226.167])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 01D0D19560A3;
	Tue, 11 Feb 2025 17:17:37 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Willem de Bruijn <willemb@google.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>
Subject: [PATCH net-next] net: avoid unconditionally touching sk_tsflags on RX
Date: Tue, 11 Feb 2025 18:17:31 +0100
Message-ID: <dbd18c8a1171549f8249ac5a8b30b1b5ec88a425.1739294057.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

After commit 5d4cc87414c5 ("net: reorganize "struct sock" fields"),
the sk_tsflags field shares the same cacheline with sk_forward_alloc.

The UDP protocol does not acquire the sock lock in the RX path;
forward allocations are protected via the receive queue spinlock;
additionally udp_recvmsg() calls sock_recv_cmsgs() unconditionally
touching sk_tsflags on each packet reception.

Due to the above, under high packet rate traffic, when the BH and the
user-space process run on different CPUs, UDP packet reception
experiences a cache miss while accessing sk_tsflags.

The receive path doesn't strictly need to access the problematic field;
change sock_set_timestamping() to maintain the relevant information
in a newly allocated sk_flags bit, so that sock_recv_cmsgs() can
take decisions accessing the latter field only.

With this patch applied, on an AMD epic server with i40e NICs, I
measured a 10% performance improvement for small packets UDP flood
performance tests - possibly a larger delta could be observed with more
recent H/W.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
 include/net/sock.h | 9 +++++----
 net/core/sock.c    | 1 +
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8036b3b79cd8..60ebf3c7b229 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -954,6 +954,7 @@ enum sock_flags {
 	SOCK_TSTAMP_NEW, /* Indicates 64 bit timestamps always */
 	SOCK_RCVMARK, /* Receive SO_MARK  ancillary data with packet */
 	SOCK_RCVPRIORITY, /* Receive SO_PRIORITY ancillary data with packet */
+	SOCK_TIMESTAMPING_ANY, /* Copy of sk_tsflags & TSFLAGS_ANY */
 };
 
 #define SK_FLAGS_TIMESTAMP ((1UL << SOCK_TIMESTAMP) | (1UL << SOCK_TIMESTAMPING_RX_SOFTWARE))
@@ -2664,13 +2665,13 @@ static inline void sock_recv_cmsgs(struct msghdr *msg, struct sock *sk,
 {
 #define FLAGS_RECV_CMSGS ((1UL << SOCK_RXQ_OVFL)			| \
 			   (1UL << SOCK_RCVTSTAMP)			| \
-			   (1UL << SOCK_RCVMARK)			|\
-			   (1UL << SOCK_RCVPRIORITY))
+			   (1UL << SOCK_RCVMARK)			| \
+			   (1UL << SOCK_RCVPRIORITY)			| \
+			   (1UL << SOCK_TIMESTAMPING_ANY))
 #define TSFLAGS_ANY	  (SOF_TIMESTAMPING_SOFTWARE			| \
 			   SOF_TIMESTAMPING_RAW_HARDWARE)
 
-	if (sk->sk_flags & FLAGS_RECV_CMSGS ||
-	    READ_ONCE(sk->sk_tsflags) & TSFLAGS_ANY)
+	if (READ_ONCE(sk->sk_flags) & FLAGS_RECV_CMSGS)
 		__sock_recv_cmsgs(msg, sk, skb);
 	else if (unlikely(sock_flag(sk, SOCK_TIMESTAMP)))
 		sock_write_timestamp(sk, skb->tstamp);
diff --git a/net/core/sock.c b/net/core/sock.c
index eae2ae70a2e0..a197f0a0b878 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -938,6 +938,7 @@ int sock_set_timestamping(struct sock *sk, int optname,
 
 	WRITE_ONCE(sk->sk_tsflags, val);
 	sock_valbool_flag(sk, SOCK_TSTAMP_NEW, optname == SO_TIMESTAMPING_NEW);
+	sock_valbool_flag(sk, SOCK_TIMESTAMPING_ANY, !!(val & TSFLAGS_ANY));
 
 	if (val & SOF_TIMESTAMPING_RX_SOFTWARE)
 		sock_enable_timestamp(sk,
-- 
2.48.1


