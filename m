Return-Path: <netdev+bounces-78003-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0083873B7D
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 17:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 651C82887B1
	for <lists+netdev@lfdr.de>; Wed,  6 Mar 2024 16:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEBA13BAF1;
	Wed,  6 Mar 2024 16:01:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YtZ1LN15"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8848D13BAFC
	for <netdev@vger.kernel.org>; Wed,  6 Mar 2024 16:01:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709740863; cv=none; b=HLA903ix7S815bVuDETFNooq//ljXjj52cad6PhTPRKT5jqBxIQEKdRJnI07QCErDulsOAvq65pLWmKPCCrq5rX9vS6FQGHh4LLnVkMfq8JXhEC2mRM7lRmFc1SKD/eEkHVHoUxN0HS6NdJrRLmOvjcN9vBBjvyAu+SQIUcX568=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709740863; c=relaxed/simple;
	bh=SxvSc5S4M2aTghYlZe1x6o2vP5OkMe3Bg91v4hjdbW0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=GZizrvt9kLOxPWWss5vOS/R0eHA2F97gj0KAjkkk1Sx8lyEUf9/vx736qWLsOfoUFzNgnLJHskIcRer7s9FKqIUzUPFMhFttwGQr8dXJWmx2adRZRMPbpct+U9g972yTcGWtgFDe8mUtllC+BWIFUZbG57BOdvi7xQ57hD54qAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YtZ1LN15; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc647f65573so12321107276.2
        for <netdev@vger.kernel.org>; Wed, 06 Mar 2024 08:01:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709740860; x=1710345660; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=VD7Qrzoy5OwZBAl3bKy1hcgCDrneG/RPcheXFXFrsPg=;
        b=YtZ1LN15zFS35Oytib0a2s8VYqqayKsyvRosdbyfGnnP3eRrR6vX6axa1iIcpkXfrw
         6Owai7NrfR0jqDKK5gCswBqUwLSEKx0LYIWDw+op5z2tA+W1CAi1IaUWjOSy9FYQ2Ngh
         NWBEJ+30WQlRt4kNsunVnVD0a7aKKirqDjx6tHEyhZXRLPL4EuWGbTre/CtdBYjsjQ6l
         3RgqRQtgXAwuHl5saMtBGXPJc6ES3GMITJMQ5IRiGEAv+9fnikUw4upO4kLTZjqq9cy/
         4pr1gbzQ/81Vev8aPPCAoLx94m8Userrg8pikPbv+TqlnNK6blh1bnqXJ8sSurqSCW/8
         fIGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709740860; x=1710345660;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VD7Qrzoy5OwZBAl3bKy1hcgCDrneG/RPcheXFXFrsPg=;
        b=PnLnW2e/7wWEJif1NkyWS+vhLxZKBr65NfktIRdt8HM2iXQLcsaFDFZ9vRzj4snjFJ
         Ta22GgoDX5pZ1dKPikRrxs7ddzwqTw8BTWEpipCAfr4wpMXx+ixJ1iAZFvn6ADrWvJTq
         eYL84T5eSuV8PBaj+fTHAeu3iLrDAsD3lg60glxn2xM0bPZtQ+I27/IUAgUPL9IwD1Bh
         XPScCwFoUmnfYyb6jjSrDmZLXgCX0bwloyzpJPDH4zWVRKDpPy/DApaLr9+x/em2VFym
         nYsVmcav/SoxcDazjm+81ak5mN8PlStRhzNIw8TCypgwurPtAcGliBXNcbeHMQSJFrVw
         KNRQ==
X-Forwarded-Encrypted: i=1; AJvYcCV3bikyQ6XMmwQ9oJlf211MBLArNJay5aPZzWyh5TAUcXoU+yCU1H9hMMAI0H0UZ2cEyQ6Y/Pelf0mYy/iWetKvN09Mzfkg
X-Gm-Message-State: AOJu0Yw792CwUgXFgb4jnnkKqu9sZRHZseDB89kT27eH1Oe89n18dD6g
	1G65T0SKXvk+BKV/A129uirXmOE54Q4dnBlVIR0kp7U/NNJAezcvwJKMZWrXdHgUsms1ceiivRO
	rjAC/tPJjJA==
X-Google-Smtp-Source: AGHT+IF1CCUvyz603godRcCYOaZh6QOV1bRfIkwXgljeJO1mYaYlvB1HCjKULTZe+V7nKsTpuTgZKLALuZtrtQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:154d:b0:dcf:411d:67b9 with SMTP
 id r13-20020a056902154d00b00dcf411d67b9mr3899565ybu.5.1709740860714; Wed, 06
 Mar 2024 08:01:00 -0800 (PST)
Date: Wed,  6 Mar 2024 16:00:25 +0000
In-Reply-To: <20240306160031.874438-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240306160031.874438-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240306160031.874438-13-edumazet@google.com>
Subject: [PATCH v2 net-next 12/18] ipv6: move tcpv6_protocol and
 udpv6_protocol to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Soheil Hassas Yeganeh <soheil@google.com>, Neal Cardwell <ncardwell@google.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are read in rx path, move them to net_hotdata
for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Acked-by: Soheil Hassas Yeganeh <soheil@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
---
 include/net/hotdata.h |  4 ++++
 net/ipv6/tcp_ipv6.c   | 17 +++++++++--------
 net/ipv6/udp.c        | 16 ++++++++--------
 3 files changed, 21 insertions(+), 16 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index daeee8ce8084e885984716113779750ca7b72147..03d758d25c02864b00e0a557603b64dc9d749b9c 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -14,6 +14,10 @@ struct net_hotdata {
 	struct net_offload 	udpv4_offload;
 	struct packet_offload	ipv6_packet_offload;
 	struct net_offload	tcpv6_offload;
+#if IS_ENABLED(CONFIG_IPV6)
+	struct inet6_protocol	tcpv6_protocol;
+	struct inet6_protocol	udpv6_protocol;
+#endif
 	struct net_offload	udpv6_offload;
 #endif
 	struct list_head	offload_base;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index f677f0fa51968d00c3571d55ae7850742387f2d1..3f4cba49e9ee6520987993dcea082e6065b4688b 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -58,6 +58,7 @@
 #include <net/timewait_sock.h>
 #include <net/inet_common.h>
 #include <net/secure_seq.h>
+#include <net/hotdata.h>
 #include <net/busy_poll.h>
 
 #include <linux/proc_fs.h>
@@ -2367,11 +2368,6 @@ struct proto tcpv6_prot = {
 };
 EXPORT_SYMBOL_GPL(tcpv6_prot);
 
-static const struct inet6_protocol tcpv6_protocol = {
-	.handler	=	tcp_v6_rcv,
-	.err_handler	=	tcp_v6_err,
-	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
-};
 
 static struct inet_protosw tcpv6_protosw = {
 	.type		=	SOCK_STREAM,
@@ -2408,7 +2404,12 @@ int __init tcpv6_init(void)
 {
 	int ret;
 
-	ret = inet6_add_protocol(&tcpv6_protocol, IPPROTO_TCP);
+	net_hotdata.tcpv6_protocol = (struct inet6_protocol) {
+		.handler     = tcp_v6_rcv,
+		.err_handler = tcp_v6_err,
+		.flags	     = INET6_PROTO_NOPOLICY | INET6_PROTO_FINAL,
+	};
+	ret = inet6_add_protocol(&net_hotdata.tcpv6_protocol, IPPROTO_TCP);
 	if (ret)
 		goto out;
 
@@ -2433,7 +2434,7 @@ int __init tcpv6_init(void)
 out_tcpv6_protosw:
 	inet6_unregister_protosw(&tcpv6_protosw);
 out_tcpv6_protocol:
-	inet6_del_protocol(&tcpv6_protocol, IPPROTO_TCP);
+	inet6_del_protocol(&net_hotdata.tcpv6_protocol, IPPROTO_TCP);
 	goto out;
 }
 
@@ -2441,5 +2442,5 @@ void tcpv6_exit(void)
 {
 	unregister_pernet_subsys(&tcpv6_net_ops);
 	inet6_unregister_protosw(&tcpv6_protosw);
-	inet6_del_protocol(&tcpv6_protocol, IPPROTO_TCP);
+	inet6_del_protocol(&net_hotdata.tcpv6_protocol, IPPROTO_TCP);
 }
diff --git a/net/ipv6/udp.c b/net/ipv6/udp.c
index 3f2249b4cd5f6a594dd9768e29f20f0d9a57faed..97d86909aabb6588d0bba901f6df1f23a4f2e561 100644
--- a/net/ipv6/udp.c
+++ b/net/ipv6/udp.c
@@ -1702,11 +1702,6 @@ int udpv6_getsockopt(struct sock *sk, int level, int optname,
 	return ipv6_getsockopt(sk, level, optname, optval, optlen);
 }
 
-static const struct inet6_protocol udpv6_protocol = {
-	.handler	=	udpv6_rcv,
-	.err_handler	=	udpv6_err,
-	.flags		=	INET6_PROTO_NOPOLICY|INET6_PROTO_FINAL,
-};
 
 /* ------------------------------------------------------------------------ */
 #ifdef CONFIG_PROC_FS
@@ -1803,7 +1798,12 @@ int __init udpv6_init(void)
 {
 	int ret;
 
-	ret = inet6_add_protocol(&udpv6_protocol, IPPROTO_UDP);
+	net_hotdata.udpv6_protocol = (struct inet6_protocol) {
+		.handler     = udpv6_rcv,
+		.err_handler = udpv6_err,
+		.flags	     = INET6_PROTO_NOPOLICY | INET6_PROTO_FINAL,
+	};
+	ret = inet6_add_protocol(&net_hotdata.udpv6_protocol, IPPROTO_UDP);
 	if (ret)
 		goto out;
 
@@ -1814,12 +1814,12 @@ int __init udpv6_init(void)
 	return ret;
 
 out_udpv6_protocol:
-	inet6_del_protocol(&udpv6_protocol, IPPROTO_UDP);
+	inet6_del_protocol(&net_hotdata.udpv6_protocol, IPPROTO_UDP);
 	goto out;
 }
 
 void udpv6_exit(void)
 {
 	inet6_unregister_protosw(&udpv6_protosw);
-	inet6_del_protocol(&udpv6_protocol, IPPROTO_UDP);
+	inet6_del_protocol(&net_hotdata.udpv6_protocol, IPPROTO_UDP);
 }
-- 
2.44.0.278.ge034bb2e1d-goog


