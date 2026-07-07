Return-Path: <netdev+bounces-305248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WD7WBAhQTGrXiwEAu9opvQ
	(envelope-from <netdev+bounces-305248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:02:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 56D98716877
	for <lists+netdev@lfdr.de>; Tue, 07 Jul 2026 03:01:59 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=etsalapatis-com.20251104.gappssmtp.com header.s=20251104 header.b=HqKoV3ra;
	dmarc=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-305248-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-305248-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EAA4430177AA
	for <lists+netdev@lfdr.de>; Tue,  7 Jul 2026 01:01:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD6A7175A75;
	Tue,  7 Jul 2026 01:01:57 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BA4442088E
	for <netdev@vger.kernel.org>; Tue,  7 Jul 2026 01:01:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783386117; cv=none; b=E5wlY/9Uqmhjt9/G41JurEKGxSZeLaWta+aUyCJcmG1VMtX+zgHzmTkXtpGW05FXqfM9HP7qX3Jt0eG01nNXEzJ82WkUCvY9uKZGy1GrGiCZWJ+5pz1Gj+qelrBomaFAlSqERQL+oAFBedelgAR1lgrJSND8rQ6yU/eLXzLWUCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783386117; c=relaxed/simple;
	bh=Cl4hxMwrRdfbEdaST7P89yCfniPHJVHCdUtxmwWGDBE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tdv86evSgjwePTiaiZEKHzdtS0zCY9RVrm/d2R20Hoq7vxxsgzkvOUMTjKUsYE8tRHKMbP9JxNF5Gg6zX4Qlpf1CDyOD54Bj6kNnPm3hCz0t66jpOgfqX4SPw1axy0LLu1TtGmoLRQKHHNHbjLq0d+8rNO9XKcZecltqj2s6haI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=etsalapatis.com; spf=pass smtp.mailfrom=etsalapatis.com; dkim=pass (2048-bit key) header.d=etsalapatis-com.20251104.gappssmtp.com header.i=@etsalapatis-com.20251104.gappssmtp.com header.b=HqKoV3ra; arc=none smtp.client-ip=209.85.216.54
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-3817f800c8bso2649135a91.1
        for <netdev@vger.kernel.org>; Mon, 06 Jul 2026 18:01:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=etsalapatis-com.20251104.gappssmtp.com; s=20251104; t=1783386114; x=1783990914; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Mn7lUDGZ7NP4xadPAgx4FMS5SBwqLelhcDxZx9BPNhU=;
        b=HqKoV3raJ7kpmysTanWbcn97V7rF8ucR/Y+BaLEIwYMqeozY6njDiwntwi0r4Pu+2F
         d0yZ9PUgb71PIM89EuGcjIYkRkuLJGnw8qlKfBUZgId2EXo67viDkTxsG9GB93igBghg
         JCBP8Ngzn+N5I4nDaKedz6s5B+GSN2CJOERMpFw/1wjBnNn6Q0cQ38TISjXQ2i+NsiQt
         imTZGuQGmdMF9IeaQz87c6i61B1Gq1hOfUoDnL7/MLssV6Q1UXiM7RtT7la4D+7Q18oH
         1UjtXoejd4PTwdKcMBtgBLYzGOcGDEu7ucVr3zvw/jY7r8UCCR2QnSM2WwnpHRErLzcG
         UzuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783386114; x=1783990914;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mn7lUDGZ7NP4xadPAgx4FMS5SBwqLelhcDxZx9BPNhU=;
        b=mRywltBD6TaReJ8uK4ILVvdkJxRJUp1TYuf0TYAN8bmChBTe2gd0gyHLoCiuFLKUg7
         U++ScRkbJcSkri044zJ/QjjeEUMF9M1lmJffUUZoLI35GcCnAysHUqUWeiTuuMUFZ9C8
         wq2J5q8nHVR7IUJmFtjzTWP695qk4vW9H+snPV73yWWJwwWCbvlcva3l8GK/fJkoqYv4
         iOhtcx0gv7sObQ/MGhLXG+i1mVSP/MJJInbPJSHK0fzCDm//0t+WktHjJbgXiiHRmkDx
         g+2xJ4fS3aIlU4hmpUVleEWY5VaGmqUWmyY9pEsGWcEh4xJbXb5b08lmVv+TQtzPB6Qv
         EUjA==
X-Gm-Message-State: AOJu0Yz3OkM7QWJx30QN/ZHqPx1YTP0tPSpiLETGy8Obm8e+O06I5tPJ
	ZulGWE4TilLiDXgpjYIibRnpAcn1iPxejJjYM5yLar682UFsUYbWvhLZBsY/8NkzcUWOiBZE5dQ
	C1SvBXrU=
X-Gm-Gg: AfdE7cnVrjyimRfLwit1ja90JMETOSf1d3BkFt+PYsZll4TGXnUF4erB85yFbXwBBGf
	i61KqfW0NgBM9wiGfAz6FnJxAXbYOHTUnsJVnxGQxG5BhTsHqhAj/OrmLzPv4EiiKIeBsfw/tOa
	Ajmxj1JMza9fIy9EJcZDL+TIKFr7ecwftMWyAFb9+U3FgPJUUzM557DfpINjJDNTKjDtY1uqsLY
	ls2goKUI5YZhsmcUjQbOZ0SSqejcZaEzCSH99cB/xqh+KaGgAcZd1vjDD+PUDFGHUiagJCXZQ6M
	Of6Fn35+0g4F9QP/Iau/8Kr9whJSljHji2WLUzYMvdRaSVHRdafckenWz9MtCF8jvck2FXVVZ3O
	9koayAxW9aurSLVwvVGEBpwG3ZCCtxtDD/3OUY/AoTu8d+LswMbI0zz1nrDDn6WyN61NVmiE0yH
	ZcLhf1YhbWoaP193OJ71GaX8rgcb9YDRhmpcxa+qBzVLVmnWCpjdkYQlUAWA==
X-Received: by 2002:a17:90b:2801:b0:380:71eb:4014 with SMTP id 98e67ed59e1d1-3875621eb68mr3220612a91.15.1783386114234;
        Mon, 06 Jul 2026 18:01:54 -0700 (PDT)
Received: from krios.ht.home (107-190-31-17.cpe.teksavvy.com. [107.190.31.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ccc9bdb56fsm2567785ad.15.2026.07.06.18.01.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jul 2026 18:01:53 -0700 (PDT)
From: Emil Tsalapatis <emil@etsalapatis.com>
To: netdev@vger.kernel.org,
	linux-trace-kernel@vger.kernel.org
Cc: edumazet@google.com,
	ncardwell@google.com,
	kuniyu@google.com,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	Emil Tsalapatis <emil@etsalapatis.com>
Subject: [PATCH net-next] net/tcp: Add explicit tracepoint for tcp_syn_ack_timeout()
Date: Mon,  6 Jul 2026 21:01:51 -0400
Message-ID: <20260707010151.43976-1-emil@etsalapatis.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[etsalapatis-com.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_FROM(0.00)[bounces-305248-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:linux-trace-kernel@vger.kernel.org,m:edumazet@google.com,m:ncardwell@google.com,m:kuniyu@google.com,m:rostedt@goodmis.org,m:mhiramat@kernel.org,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:emil@etsalapatis.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DMARC_NA(0.00)[etsalapatis.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[etsalapatis-com.20251104.gappssmtp.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[emil@etsalapatis.com,netdev@vger.kernel.org];
	ALIAS_RESOLVED(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_FORWARDING(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[11];
	TAGGED_RCPT(0.00)[netdev];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[etsalapatis.com:from_mime,etsalapatis.com:email,etsalapatis.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,etsalapatis-com.20251104.gappssmtp.com:dkim]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 56D98716877

Clang can inline the tcp_syn_ack_timeout() function during compilation,
making it impossible to use kprobes for tracing without preventing
inlining. Add an explicit tracepoint to it instead.

Signed-off-by: Emil Tsalapatis <emil@etsalapatis.com>
---
 include/trace/events/tcp.h | 72 ++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_timer.c       |  3 ++
 2 files changed, 75 insertions(+)

diff --git a/include/trace/events/tcp.h b/include/trace/events/tcp.h
index f155f95cdb6e..37ffaa50faad 100644
--- a/include/trace/events/tcp.h
+++ b/include/trace/events/tcp.h
@@ -332,6 +332,78 @@ TRACE_EVENT(tcp_retransmit_synack,
 		  __entry->saddr_v6, __entry->daddr_v6)
 );
 
+TRACE_EVENT(tcp_syn_ack_timeout,
+
+	TP_PROTO(const struct request_sock *req),
+
+	TP_ARGS(req),
+
+	TP_STRUCT__entry(
+		__field(const void *, req)
+		__field(__u16, sport)
+		__field(__u16, dport)
+		__field(__u16, family)
+		__array(__u8, saddr, 4)
+		__array(__u8, daddr, 4)
+		__array(__u8, saddr_v6, 16)
+		__array(__u8, daddr_v6, 16)
+		__field(u8, state)
+		__field(u8, num_timeout)
+		__field(bool, acked)
+	),
+
+
+	TP_fast_assign(
+		const struct inet_request_sock *ireq = inet_rsk(req);
+		__be32 *p32;
+
+		__entry->req = req;
+
+		__entry->sport = ireq->ir_num;
+		__entry->dport = ntohs(ireq->ir_rmt_port);
+		__entry->family = req->__req_common.skc_family;
+
+		p32 = (__be32 *) __entry->saddr;
+		*p32 = ireq->ir_loc_addr;
+
+		p32 = (__be32 *) __entry->daddr;
+		*p32 = ireq->ir_rmt_addr;
+
+#if IS_ENABLED(CONFIG_IPV6)
+		/*
+		 * Cannot use TP_STORE_ADDRS directly because it assumes
+		 * there is an sk available.
+		 */
+		if (__entry->family == AF_INET6) {
+			struct in6_addr *pin6;
+
+			pin6 = (struct in6_addr *)__entry->saddr_v6;
+			*pin6 = ireq->ir_v6_loc_addr;
+			pin6 = (struct in6_addr *)__entry->daddr_v6;
+			*pin6 = ireq->ir_v6_rmt_addr;
+		} else {
+			TP_STORE_V4MAPPED(__entry, ireq->ir_loc_addr, ireq->ir_rmt_addr);
+		}
+#else
+		TP_STORE_V4MAPPED(__entry, ireq->ir_loc_addr, ireq->ir_rmt_addr);
+#endif
+
+		__entry->state		= ireq->ireq_state;
+		__entry->num_timeout	= req->num_timeout;
+		__entry->acked		= ireq->acked;
+	),
+
+	TP_printk("family=%s sport=%hu dport=%hu saddr=%pI4 "
+		"daddr=%pI4 saddrv6=%pI6c daddrv6=%pI6c "
+		"ireq_state=%s num_timeout=%u acked=%d",
+		  show_family_name(__entry->family),
+		  __entry->sport, __entry->dport,
+		  __entry->saddr, __entry->daddr,
+		  __entry->saddr_v6, __entry->daddr_v6,
+		  show_tcp_state_name(__entry->state),
+		  __entry->num_timeout, __entry->acked)
+);
+
 TRACE_EVENT(tcp_sendmsg_locked,
 	TP_PROTO(const struct sock *sk, const struct msghdr *msg,
 		 const struct sk_buff *skb, int size_goal),
diff --git a/net/ipv4/tcp_timer.c b/net/ipv4/tcp_timer.c
index bf171b5e1eb3..8f482a6b43e3 100644
--- a/net/ipv4/tcp_timer.c
+++ b/net/ipv4/tcp_timer.c
@@ -24,6 +24,7 @@
 #include <net/tcp.h>
 #include <net/tcp_ecn.h>
 #include <net/rstreason.h>
+#include <trace/events/tcp.h>
 
 static u32 tcp_clamp_rto_to_user_timeout(const struct sock *sk)
 {
@@ -753,6 +754,8 @@ void tcp_syn_ack_timeout(const struct request_sock *req)
 	struct net *net = read_pnet(&inet_rsk(req)->ireq_net);
 
 	__NET_INC_STATS(net, LINUX_MIB_TCPTIMEOUTS);
+
+	trace_tcp_syn_ack_timeout(req);
 }
 
 void tcp_reset_keepalive_timer(struct sock *sk, unsigned long len)
-- 
2.54.0


