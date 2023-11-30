Return-Path: <netdev+bounces-52573-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1FEC7FF3C3
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 16:41:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BEC261C20CC8
	for <lists+netdev@lfdr.de>; Thu, 30 Nov 2023 15:41:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 500B3524DA;
	Thu, 30 Nov 2023 15:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Yr7C0GzE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE8351B3
	for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:40:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701358855;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=5t/ndvn3ey5CVVXUeU5kICJf1rp7IQWCXwkTj4sCuBo=;
	b=Yr7C0GzETgoS3pSpwmxHI/Fwi/pRAUkOCuz7BkI+gsxd73Urgr14uwYvQx2D+MOK/w49tc
	c5dQaUNsQAwiOfteN7JorDgHXNy/t8jI/oGq2AzIb6YgvzjYpKHHp2z39NGL+DHNnD7Lrw
	Pypg9JV6X5tVkvzUSm8cgzeRFDihm/8=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-NrvJekxpOP2gQ4gpSN0ZAg-1; Thu, 30 Nov 2023 10:40:51 -0500
X-MC-Unique: NrvJekxpOP2gQ4gpSN0ZAg-1
Received: by mail-lf1-f69.google.com with SMTP id 2adb3069b0e04-50bc4fcc347so1188287e87.2
        for <netdev@vger.kernel.org>; Thu, 30 Nov 2023 07:40:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701358850; x=1701963650;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5t/ndvn3ey5CVVXUeU5kICJf1rp7IQWCXwkTj4sCuBo=;
        b=TjeWpGlS3owwB7FvDV8FGXFLEDhdZdmwp51hk7NnN3N9/nyzdZz/6Tms+CjzYk6mI6
         3fxYVz+ayRcALjQ92mkB7ZP21idIU2097ddOba/Z7l7V5ec7D/sf8l3Ltwcx3HNOinbl
         Q2ZUx3oIzta3QRyBwb2H9apykQZvQRVKZyHGrIsCzVXWj5ottWAc2+TaVmBveYOu6gVp
         c+LmCyrBktyV/TMjJk2C4h/FYjNi5HEKEhmxbp+aAbVz2dM7LD4SLjUSQwHGZnEwdSGk
         +l9Wc9vJooKtfG8Vt2rmqYExS1Bp5awfvMAydwuOmHP8CipXT2nFc/oJkSN/evQ+yd4k
         r1wg==
X-Gm-Message-State: AOJu0YyT9w91VCpFIbUejGqtJXAxZnimqwu5txfv4ef1k7YDZOgyg1n3
	VwSdO7sDc3cqgJhefjiXPTesXzJrVs5Tjs6mSxrdGnzjOuoFCpFhN6JKILxQBI/mMQnIVnJjUCH
	rChshP6BBTpPk2a94WE+oKZg9
X-Received: by 2002:ac2:4a79:0:b0:50b:d42c:94cf with SMTP id q25-20020ac24a79000000b0050bd42c94cfmr754212lfp.5.1701358849973;
        Thu, 30 Nov 2023 07:40:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/C+uog5+IH41/dL68uUAcr0iiqWfCTP5DLWy3RXGZSPXvYz6L0rZQac7/1PxBFAOnqoc6dw==
X-Received: by 2002:ac2:4a79:0:b0:50b:d42c:94cf with SMTP id q25-20020ac24a79000000b0050bd42c94cfmr754204lfp.5.1701358849627;
        Thu, 30 Nov 2023 07:40:49 -0800 (PST)
Received: from debian (2a01cb058918ce00f1553101655f9ec6.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:f155:3101:655f:9ec6])
        by smtp.gmail.com with ESMTPSA id o17-20020a05600c4fd100b0040b32edf626sm2386584wmq.31.2023.11.30.07.40.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Nov 2023 07:40:48 -0800 (PST)
Date: Thu, 30 Nov 2023 16:40:46 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v3] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <49a05d612fc8968b17780ed82ecb1b96dcf78e5a.1701358163.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Walk the hashinfo->bhash2 table so that inet_diag can dump TCP sockets
that are bound but haven't yet called connect() or listen().

The code is inspired by the ->lhash2 loop. However there's no manual
test of the source port, since this kind of filtering is already
handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
at a time, to avoid running with bh disabled for too long.

There's no TCP state for bound but otherwise inactive sockets. Such
sockets normally map to TCP_CLOSE. However, "ss -l", which is supposed
to only dump listening sockets, actually requests the kernel to dump
sockets in either the TCP_LISTEN or TCP_CLOSE states. To avoid dumping
bound-only sockets with "ss -l", we therefore need to define a new
pseudo-state (TCP_BOUND_INACTIVE) that user space will be able to set
explicitly.

With an IPv4, an IPv6 and an IPv6-only socket, bound respectively to
40000, 64000, 60000, an updated version of iproute2 could work as
follow:

  $ ss -t state bound-inactive
  Recv-Q   Send-Q     Local Address:Port       Peer Address:Port   Process
  0        0                0.0.0.0:40000           0.0.0.0:*
  0        0                   [::]:60000              [::]:*
  0        0                      *:64000                 *:*

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---

v3:
  * Grab sockets with sock_hold(), instead of refcount_inc_not_zero()
    (Kuniyuki Iwashima).
  * Use a new TCP pseudo-state (TCP_BOUND_INACTIVE), to dump bound-only
    sockets, so that "ss -l" won't print them (Eric Dumazet).

v2:
  * Use ->bhash2 instead of ->bhash (Kuniyuki Iwashima).
  * Process no more than 16 sockets at a time (Kuniyuki Iwashima).

 include/net/tcp_states.h |  2 +
 include/uapi/linux/bpf.h |  1 +
 net/ipv4/inet_diag.c     | 86 +++++++++++++++++++++++++++++++++++++++-
 net/ipv4/tcp.c           |  1 +
 4 files changed, 89 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp_states.h b/include/net/tcp_states.h
index cc00118acca1..d60e8148ff4c 100644
--- a/include/net/tcp_states.h
+++ b/include/net/tcp_states.h
@@ -22,6 +22,7 @@ enum {
 	TCP_LISTEN,
 	TCP_CLOSING,	/* Now a valid state */
 	TCP_NEW_SYN_RECV,
+	TCP_BOUND_INACTIVE, /* Pseudo-state for inet_diag */
 
 	TCP_MAX_STATES	/* Leave at the end! */
 };
@@ -43,6 +44,7 @@ enum {
 	TCPF_LISTEN	 = (1 << TCP_LISTEN),
 	TCPF_CLOSING	 = (1 << TCP_CLOSING),
 	TCPF_NEW_SYN_RECV = (1 << TCP_NEW_SYN_RECV),
+	TCPF_BOUND_INACTIVE = (1 << TCP_BOUND_INACTIVE),
 };
 
 #endif	/* _LINUX_TCP_STATES_H */
diff --git a/include/uapi/linux/bpf.h b/include/uapi/linux/bpf.h
index 7a5498242eaa..8ee2404d077c 100644
--- a/include/uapi/linux/bpf.h
+++ b/include/uapi/linux/bpf.h
@@ -6892,6 +6892,7 @@ enum {
 	BPF_TCP_LISTEN,
 	BPF_TCP_CLOSING,	/* Now a valid state */
 	BPF_TCP_NEW_SYN_RECV,
+	BPF_TCP_BOUND_INACTIVE,
 
 	BPF_TCP_MAX_STATES	/* Leave at the end! */
 };
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 7d0e7aaa71e0..05fa0edd78b1 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1077,10 +1077,94 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 		s_i = num = s_num = 0;
 	}
 
+/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
+ * with bh disabled.
+ */
+#define SKARR_SZ 16
+
+	/* Dump bound but inactive (not listening, connecting, etc.) sockets */
+	if (cb->args[0] == 1) {
+		if (!(idiag_states & TCPF_BOUND_INACTIVE))
+			goto skip_bind_ht;
+
+		for (i = s_i; i < hashinfo->bhash_size; i++) {
+			struct inet_bind_hashbucket *ibb;
+			struct inet_bind2_bucket *tb2;
+			struct sock *sk_arr[SKARR_SZ];
+			int num_arr[SKARR_SZ];
+			int idx, accum, res;
+
+resume_bind_walk:
+			num = 0;
+			accum = 0;
+			ibb = &hashinfo->bhash2[i];
+
+			spin_lock_bh(&ibb->lock);
+			inet_bind_bucket_for_each(tb2, &ibb->chain) {
+				if (!net_eq(ib2_net(tb2), net))
+					continue;
+
+				sk_for_each_bound_bhash2(sk, &tb2->owners) {
+					struct inet_sock *inet = inet_sk(sk);
+
+					if (num < s_num)
+						goto next_bind;
+
+					if (sk->sk_state != TCP_CLOSE ||
+					    !inet->inet_num)
+						goto next_bind;
+
+					if (r->sdiag_family != AF_UNSPEC &&
+					    r->sdiag_family != sk->sk_family)
+						goto next_bind;
+
+					if (!inet_diag_bc_sk(bc, sk))
+						goto next_bind;
+
+					sock_hold(sk);
+					num_arr[accum] = num;
+					sk_arr[accum] = sk;
+					if (++accum == SKARR_SZ)
+						goto pause_bind_walk;
+next_bind:
+					num++;
+				}
+			}
+pause_bind_walk:
+			spin_unlock_bh(&ibb->lock);
+
+			res = 0;
+			for (idx = 0; idx < accum; idx++) {
+				if (res >= 0) {
+					res = inet_sk_diag_fill(sk_arr[idx],
+								NULL, skb, cb,
+								r, NLM_F_MULTI,
+								net_admin);
+					if (res < 0)
+						num = num_arr[idx];
+				}
+				sock_gen_put(sk_arr[idx]);
+			}
+			if (res < 0)
+				goto done;
+
+			cond_resched();
+
+			if (accum == SKARR_SZ) {
+				s_num = num + 1;
+				goto resume_bind_walk;
+			}
+
+			s_num = 0;
+		}
+skip_bind_ht:
+		cb->args[0] = 2;
+		s_i = num = s_num = 0;
+	}
+
 	if (!(idiag_states & ~TCPF_LISTEN))
 		goto out;
 
-#define SKARR_SZ 16
 	for (i = s_i; i <= hashinfo->ehash_mask; i++) {
 		struct inet_ehash_bucket *head = &hashinfo->ehash[i];
 		spinlock_t *lock = inet_ehash_lockp(hashinfo, i);
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 53bcc17c91e4..a100df07d34a 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -2605,6 +2605,7 @@ void tcp_set_state(struct sock *sk, int state)
 	BUILD_BUG_ON((int)BPF_TCP_LISTEN != (int)TCP_LISTEN);
 	BUILD_BUG_ON((int)BPF_TCP_CLOSING != (int)TCP_CLOSING);
 	BUILD_BUG_ON((int)BPF_TCP_NEW_SYN_RECV != (int)TCP_NEW_SYN_RECV);
+	BUILD_BUG_ON((int)BPF_TCP_BOUND_INACTIVE != (int)TCP_BOUND_INACTIVE);
 	BUILD_BUG_ON((int)BPF_TCP_MAX_STATES != (int)TCP_MAX_STATES);
 
 	/* bpf uapi header bpf.h defines an anonymous enum with values
-- 
2.39.2


