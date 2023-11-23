Return-Path: <netdev+bounces-50667-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CC1F7F6975
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:11:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 664531C209E3
	for <lists+netdev@lfdr.de>; Thu, 23 Nov 2023 23:11:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B822922F12;
	Thu, 23 Nov 2023 23:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hHjbyV4r"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39ED10C2
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 15:11:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700781108;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=P9UNCPaxva3mocGAduryLu7lxBwmZU5AYOzYsOMnmXM=;
	b=hHjbyV4rUUzLUGBx3J+slaMZCUVBJQcDF6FlS3jvxrq0P6IkK4QSZKkb0LqDlVI2L0zvha
	dfwyODGEk/AxcSGJ8xZBuCMoUDNCVtty1qO/OOF9t1WhtpKq19QlC0osgexA+41gbqe/+r
	UGMUSIOjB4yNBcLRQmk+v1qp9gMbFq0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-387-mh9ZsBUhOxePyhtqRGsNwA-1; Thu, 23 Nov 2023 18:11:47 -0500
X-MC-Unique: mh9ZsBUhOxePyhtqRGsNwA-1
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-77d7a162255so33683685a.2
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 15:11:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700781107; x=1701385907;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P9UNCPaxva3mocGAduryLu7lxBwmZU5AYOzYsOMnmXM=;
        b=dZFsuV48ahr7Qjl7exA7tgi78BQ6F6Djxf9ehopkLIDex0kCq3Hg/cawxbkEQNxoWq
         yT8ThEX093sbFNadGbFyt6swzHcT7xhivksnEpmjOhyUgyZ36HAcb+z4pccmsxjFH1+g
         rIotDGdUzO9HEoFG/5E7TUQWmG1/+/hpO4FsD74Fxh0PC7CiY73H36ZBman36gG9K18f
         098yFaBmquJFvBVWtM2zR69JFiquR5Huqfk0YczyHaxeWkzb6zx4NE92D6wE4l01Dvb2
         jdkw1vhBx9DkZ23WbI7P7z3SQYUfUQvhELWb8632gn2ajQzna5oA5kKt3in2NKPgBgWw
         wxng==
X-Gm-Message-State: AOJu0Yzpn/bK/RWEH4Bgn5fkLlEtjjGbRzeB7PxbabxOcND8d1HyG/pt
	KmZTx8PQVpXK23o08ncpZJ8j8K8yiSCdP3vRvrbpru+Drf2DaU1ALvz2u3yIxEAiq0YAVrtLPK7
	ckYu7TLuerZMLY3r3aQYGEbyL
X-Received: by 2002:a37:ef0a:0:b0:774:3963:41a5 with SMTP id j10-20020a37ef0a000000b00774396341a5mr861407qkk.13.1700781106745;
        Thu, 23 Nov 2023 15:11:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFMxrwVWCHJx6/IYascYOtLDxEUb/y//Q86zmYh7bcYiqRQIb8m9qm8tKsWhmR/1kPe48ZGdA==
X-Received: by 2002:a37:ef0a:0:b0:774:3963:41a5 with SMTP id j10-20020a37ef0a000000b00774396341a5mr861389qkk.13.1700781106433;
        Thu, 23 Nov 2023 15:11:46 -0800 (PST)
Received: from debian (2a01cb058d23d6009e5da12aee20e435.ipv6.abo.wanadoo.fr. [2a01:cb05:8d23:d600:9e5d:a12a:ee20:e435])
        by smtp.gmail.com with ESMTPSA id k18-20020a05620a143200b007743671a41fsm786078qkj.72.2023.11.23.15.11.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 15:11:45 -0800 (PST)
Date: Fri, 24 Nov 2023 00:11:42 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>,
	Michal Kubecek <mkubecek@suse.cz>
Subject: [PATCH net-next v2] tcp: Dump bound-only sockets in inet_diag.
Message-ID: <bfb52b5103de808cda022e2d16bac6cf3ef747d6.1700780828.git.gnault@redhat.com>
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

This allows ss to dump bound-only TCP sockets, together with listening
sockets (as there's no specific state for bound-only sockets). This is
similar to the UDP behaviour for which bound-only sockets are already
dumped by ss -lu.

The code is inspired by the ->lhash2 loop. However there's no manual
test of the source port, since this kind of filtering is already
handled by inet_diag_bc_sk(). Also, a maximum of 16 sockets are dumped
at a time, to avoid running with bh disabled for too long.

No change is needed for ss. With an IPv4, an IPv6 and an IPv6-only
socket, bound respectively to 40000, 64000, 60000, the result is:

  $ ss -lt
  State  Recv-Q Send-Q Local Address:Port  Peer Address:PortProcess
  UNCONN 0      0            0.0.0.0:40000      0.0.0.0:*
  UNCONN 0      0               [::]:60000         [::]:*
  UNCONN 0      0                  *:64000            *:*

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---

v2:
  * Use ->bhash2 instead of ->bhash (Kuniyuki Iwashima).
  * Process no more than 16 sockets at a time (Kuniyuki Iwashima).

 net/ipv4/inet_diag.c | 88 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 87 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index 7d0e7aaa71e0..d7fb6a625cb7 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1077,10 +1077,96 @@ void inet_diag_dump_icsk(struct inet_hashinfo *hashinfo, struct sk_buff *skb,
 		s_i = num = s_num = 0;
 	}
 
+/* Process a maximum of SKARR_SZ sockets at a time when walking hash buckets
+ * with bh disabled.
+ */
+#define SKARR_SZ 16
+
+	/* Dump bound-only sockets */
+	if (cb->args[0] == 1) {
+		if (!(idiag_states & TCPF_CLOSE))
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
+					if (!refcount_inc_not_zero(&sk->sk_refcnt))
+						goto next_bind;
+
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
-- 
2.39.2


