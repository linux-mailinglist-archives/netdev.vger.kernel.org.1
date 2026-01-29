Return-Path: <netdev+bounces-254836-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMYNL19+e2kQFAIAu9opvQ
	(envelope-from <netdev+bounces-254836-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:35:59 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CCBCB18D9
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 16:35:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACDAD30300E6
	for <lists+netdev@lfdr.de>; Thu, 29 Jan 2026 15:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 622503090C4;
	Thu, 29 Jan 2026 15:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vLoF2S6Y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EBA1261B80
	for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 15:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769700904; cv=none; b=mwmRgSxWjvKZx9ZgdO55gDmkmwKH8Xca8U0xQhSS40Aq1Z8UgTapkg4KOP7CG06s7cDcwdv2zRId9gpfovXxaXdup3264NY3brm625AMWpy96cfyPfz37W4GqEONjIpHZgJ1MVz+2J7Xi16lNDeh4INjluZH7pscTGZNxY9lQpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769700904; c=relaxed/simple;
	bh=ij08zq6j9EtuMjFwV+owD5/nLL0W9tc4MRAbs1JlOk0=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=HKsK84dXx/4A9iEacoz0Qk/v8FK/dglLC0CxQdXj1XX9t9UYJB2fSxoXX4sqTV/G5A7m7dSuv9Nk5T3rBMlv7Ky4nz0LBXI6Xr7YKiZV21QKn7OjSEBIUDMMci+pNMR+z1yLOxyam+riOUX+XrapI0Kp3PwdcUn8ZlP8VPIl8KM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=vLoF2S6Y; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c882774f0dso134428285a.2
        for <netdev@vger.kernel.org>; Thu, 29 Jan 2026 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769700901; x=1770305701; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=n1HKes6juoNEJy7pY9vTUgvUGOKIfEUrq/cMjzlx3zk=;
        b=vLoF2S6YQ8oCd4XWAFC4baI7duY9x6DjOg40AYU8bvCU+85I7tsQKwjrWB4OjIlXqW
         66thxqTxOgLInRECnPS2V+F7+GsxLMwxLi0Nzu6Tsbh+ZgOR6yBiPqHwodb5zjzOMCn+
         pd77i6FeiPg9YlcWjwmh6sZco7tv9vR+tbx1y7wX4Jpren1mE53Yzi6KwnWVxjw/difo
         QruD2VdGfksoxP8Rp91eiWOdcdBlsDMVnsgs/zCAJ17iceYgym/Bc+KaOtKNyw+Ui593
         GhktTFdBDn1DwPu5qxOKpG27m6IYoPB8cQhjyl9fi0bIFm9KkGljoEphIQY08LvpgdFE
         0jrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769700901; x=1770305701;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n1HKes6juoNEJy7pY9vTUgvUGOKIfEUrq/cMjzlx3zk=;
        b=pZLXgHHzI0cRaBdUwy2TVo9FS1MEiDEhbvzrRm4Pynb/5qlq28QY/iKBJ4i1xEuZVw
         cAJXQk5K2A9+njpeN4lGdYIe2PR7aSo4l8VQvCQWwhwQoVVuXBel2eTeRplLRJaSmEuy
         cnRskpgEBKTV4IkYUns7noKcAM6qd38zifK+KKy6cvNWbfD9QTQnsqInlcXbcbvlhknO
         QZXEE4LsIK++5KF5ojX4mJGLOHfQW+beo4eRbySBdITQKxqBM6HCr1B9CfVW1Ev7Lf83
         stbvu522BcY0cv+G+5y5jowYyW8SkUeD1cCWJwxVxj46p2C0iUtCXbh2/twTnZ7Yxo8g
         5kLw==
X-Forwarded-Encrypted: i=1; AJvYcCVhqecV0eIpLRCP3PdkUqgjedgr7/sNUobCD2NzmcvsXNQR9eVwySjIcEFMbmXjKXXR+xwPHhY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzO1xhv08boP7RzyuVj6gH/8buj4Dk3MpLohMYH5m9ouq2aJGdK
	6JwsRu0cAoyMQWgFXXGf/h5fbSxFcyyTodVw+4qCU6tixsRpGDpk3+4nmUV0VryThVlGeIxgECl
	Kzic88d83HgqPhg==
X-Received: from qknvv27.prod.google.com ([2002:a05:620a:563b:b0:8c5:7e66:6c28])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:28d1:b0:8c6:a539:55cd with SMTP id af79cd13be357-8c70b8e6154mr1244164285a.41.1769700900852;
 Thu, 29 Jan 2026 07:35:00 -0800 (PST)
Date: Thu, 29 Jan 2026 15:34:58 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc1.217.geba53bf80e-goog
Message-ID: <20260129153458.4163797-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: reduce tcp sockets size by one cache line
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254836-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7CCBCB18D9
X-Rspamd-Action: no action

By default, when a kmem_cache is created with SLAB_TYPESAFE_BY_RCU,
slub has to use extra storage for the freelist pointer after each
object, because slub assumes that any bit in the object
can be used by RCU readers.

Because proto_register() is also using SLAB_HWCACHE_ALIGN,
this forces slub to use one extra cache line per object.

We can instead put the slub freelist anywhere in the object,
granted the concurrent RCU readers are not supposed to
use the pointer value.

Add a new (struct sock)sk_freeptr field, in an union
with sk_rcu: No RCU readers would need to look at sk_rcu,
which is only used at free phase.

Tested:

grep . /sys/kernel/slab/TCP/{object_size,slab_size,objs_per_slab}
grep . /sys/kernel/slab/TCPv6/{object_size,slab_size,objs_per_slab}

Before:

/sys/kernel/slab/TCP/object_size:2368
/sys/kernel/slab/TCP/slab_size:2432
/sys/kernel/slab/TCP/objs_per_slab:13

/sys/kernel/slab/TCPv6/object_size:2496
/sys/kernel/slab/TCPv6/slab_size:2560
/sys/kernel/slab/TCPv6/objs_per_slab:12

After this patch, we can pack one more TCPv6 object per slab,
and object_size == slab_size.

/sys/kernel/slab/TCP/object_size:2368
/sys/kernel/slab/TCP/slab_size:2368
/sys/kernel/slab/TCP/objs_per_slab:13

/sys/kernel/slab/TCPv6/object_size:2496
/sys/kernel/slab/TCPv6/slab_size:2496
/sys/kernel/slab/TCPv6/objs_per_slab:13

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/sock.h  | 11 ++++++++++-
 net/core/sock.c     | 16 ++++++++++------
 net/ipv4/tcp_ipv4.c |  2 ++
 net/ipv6/tcp_ipv6.c |  2 ++
 4 files changed, 24 insertions(+), 7 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index aafe8bdb2c0f936bc3a179e394c2df6830419997..66b56288c1d3850439b2a0bed00be801d5770efa 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -341,6 +341,7 @@ struct sk_filter;
   *	@sk_reuseport_cb: reuseport group container
   *	@sk_bpf_storage: ptr to cache and control for bpf_sk_storage
   *	@sk_rcu: used during RCU grace period
+  *	@sk_freeptr: used for SLAB_TYPESAFE_BY_RCU managed sockets
   *	@sk_clockid: clockid used by time-based scheduling (SO_TXTIME)
   *	@sk_txtime_deadline_mode: set deadline mode for SO_TXTIME
   *	@sk_txtime_report_errors: set report errors mode for SO_TXTIME
@@ -582,7 +583,14 @@ struct sock {
 	struct bpf_local_storage __rcu	*sk_bpf_storage;
 #endif
 	struct numa_drop_counters *sk_drop_counters;
-	struct rcu_head		sk_rcu;
+	/* sockets using SLAB_TYPESAFE_BY_RCU can use sk_freeptr.
+	 * By the time kfree() is called, sk_rcu can not be in
+	 * use and can be mangled.
+	 */
+	union {
+		struct rcu_head	sk_rcu;
+		freeptr_t	sk_freeptr;
+	};
 	netns_tracker		ns_tracker;
 	struct xarray		sk_user_frags;
 
@@ -1368,6 +1376,7 @@ struct proto {
 
 	struct kmem_cache	*slab;
 	unsigned int		obj_size;
+	unsigned int		freeptr_offset;
 	unsigned int		ipv6_pinfo_offset;
 	slab_flags_t		slab_flags;
 	unsigned int		useroffset;	/* Usercopy region offset */
diff --git a/net/core/sock.c b/net/core/sock.c
index a1c8b47b0d5662b882dc0f9257c54ed312c383b4..693e6d80f501ef552aa58928f28b78a578169536 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -4193,13 +4193,17 @@ int proto_register(struct proto *prot, int alloc_slab)
 		return -EINVAL;
 	}
 	if (alloc_slab) {
-		prot->slab = kmem_cache_create_usercopy(prot->name,
-					prot->obj_size, 0,
-					SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
-					prot->slab_flags,
-					prot->useroffset, prot->usersize,
-					NULL);
+		struct kmem_cache_args args = {
+			.useroffset	= prot->useroffset,
+			.usersize	= prot->usersize,
+			.freeptr_offset = prot->freeptr_offset,
+			.use_freeptr_offset = !!prot->freeptr_offset,
+		};
 
+		prot->slab = kmem_cache_create(prot->name, prot->obj_size,
+					&args,
+					SLAB_HWCACHE_ALIGN | SLAB_ACCOUNT |
+					prot->slab_flags);
 		if (prot->slab == NULL) {
 			pr_crit("%s: Can't create sock SLAB cache!\n",
 				prot->name);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index ffdf52fbf6463b41d7c712f3710b681ecdf6e2d7..0fc8a42921aabac27dcb7c6a9db811498edbb31c 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3460,6 +3460,8 @@ struct proto tcp_prot = {
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp_sock),
+	.freeptr_offset		= offsetof(struct tcp_sock,
+					   inet_conn.icsk_inet.sk.sk_freeptr),
 	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
 	.twsk_prot		= &tcp_timewait_sock_ops,
 	.rsk_prot		= &tcp_request_sock_ops,
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 4ae664b05fa9171ed996bf8f3b6e7b2aaa63d5c9..8bf29186c15f99dd2ab63d2b0b3890ed0c68d514 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -2332,6 +2332,8 @@ struct proto tcpv6_prot = {
 	.sysctl_rmem_offset	= offsetof(struct net, ipv4.sysctl_tcp_rmem),
 	.max_header		= MAX_TCP_HEADER,
 	.obj_size		= sizeof(struct tcp6_sock),
+	.freeptr_offset		= offsetof(struct tcp6_sock,
+					   tcp.inet_conn.icsk_inet.sk.sk_freeptr),
 	.ipv6_pinfo_offset = offsetof(struct tcp6_sock, inet6),
 	.slab_flags		= SLAB_TYPESAFE_BY_RCU,
 	.twsk_prot		= &tcp6_timewait_sock_ops,
-- 
2.53.0.rc1.217.geba53bf80e-goog


