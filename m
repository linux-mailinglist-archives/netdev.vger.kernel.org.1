Return-Path: <netdev+bounces-52945-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EC24C800DB0
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 15:50:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB4B281B69
	for <lists+netdev@lfdr.de>; Fri,  1 Dec 2023 14:50:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 347383C6BC;
	Fri,  1 Dec 2023 14:50:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y8Owmfjk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABAAA103
	for <netdev@vger.kernel.org>; Fri,  1 Dec 2023 06:50:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701442199;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=MFxiErpaIoJuz/X7W4hULVShqCJalKyhBma8Mw+Lipg=;
	b=Y8OwmfjkGmPICm8qmFjos0K+q83NalkbgR0WDYLaHXra2RUNkrnh/L/c5ic2ye2AeCa9nc
	bhjQuw27Hy0jKYQD9XvPv6zL2tyZwFXZ6KLx5hZyVYNwW6pdG7aA98+5oca4U1pQxHIn4P
	nINTRhbycNjItUJIUDYpFyygX1kN0cc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-197-hIJ8Yi4qP9KAIM7kA95osg-1; Fri, 01 Dec 2023 09:49:57 -0500
X-MC-Unique: hIJ8Yi4qP9KAIM7kA95osg-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-40b443d698eso14349555e9.2
        for <netdev@vger.kernel.org>; Fri, 01 Dec 2023 06:49:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701442196; x=1702046996;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MFxiErpaIoJuz/X7W4hULVShqCJalKyhBma8Mw+Lipg=;
        b=Jsrt0pK7fU9lsbpzygvgfqSd4aOILJxJChGhLOYlxQPgDDB1DrpWNrm3SGfwq/oYz9
         kvUJYXMW/wtotMKudxGzTCIauza5SWBAhQ+fYAEX7UpHbwEsMbMWbD5S+DruY7URCdIl
         IC6W7v+CYs1O0IViIa0Wno0WKVQAhgO67YrtwlqlqIwU6pTHvv35BJXjZBp1J7/5NWdW
         HzSb0ZjD8Y+cJTepJtdoh08qqra7mBgPcRHoqaO50H1PaVe1447v+AFMHZjcs3pbgvFi
         xlu1jzniJsghMRAIpsiX6iasO2fKKscfm19eDw0VFeoYhgYsmpWj452rAjNOF1tm1Jdp
         fI5g==
X-Gm-Message-State: AOJu0Ywh66tcID39EjjBheV30hudO7tcruOPC5Vhc0Koi2D4NfzZzsTG
	g0NvQaKXtxQOh5D4YPgbeXqg/ugBDjpaY/xzV28M18iLVJkhNHlMeGByZDnix7Nke/P0u1iaFK4
	T+1BBPI+Bn0f9Of2mrpTftmS6
X-Received: by 2002:a1c:6a12:0:b0:40b:5e21:d351 with SMTP id f18-20020a1c6a12000000b0040b5e21d351mr446052wmc.90.1701442196198;
        Fri, 01 Dec 2023 06:49:56 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGJt6lKOZIb4ypZ7uOccAAhfAVu22/XmSVDvqZ7KWO0xGVH3VseaZ85mvsMGGAxOaP5cEG/Kg==
X-Received: by 2002:a1c:6a12:0:b0:40b:5e21:d351 with SMTP id f18-20020a1c6a12000000b0040b5e21d351mr446043wmc.90.1701442195808;
        Fri, 01 Dec 2023 06:49:55 -0800 (PST)
Received: from debian (2a01cb058918ce00625b5a780ee7a26d.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:625b:5a78:ee7:a26d])
        by smtp.gmail.com with ESMTPSA id l15-20020a05600c4f0f00b0040b33222a39sm9381076wmq.45.2023.12.01.06.49.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Dec 2023 06:49:55 -0800 (PST)
Date: Fri, 1 Dec 2023 15:49:52 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v4] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <b3a84ae61e19c06806eea9c602b3b66e8f0cfc81.1701362867.git.gnault@redhat.com>
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

Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Guillaume Nault <gnault@redhat.com>
---

v4:
  * Use plain sock_put() instead of sock_gen_put() (Eric Dumazet).

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
index 7d0e7aaa71e0..46b13962ad02 100644
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
+				sock_put(sk_arr[idx]);
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


