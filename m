Return-Path: <netdev+bounces-77589-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 245878723A2
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 17:05:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5211AB23AD8
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 16:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 753B912837B;
	Tue,  5 Mar 2024 16:04:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RuOjrpGA"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E305012A16C
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 16:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709654690; cv=none; b=USE0P5Qv9sAiEfpIQKs7KGDdrbzp75n94eqsTilN6rMtX8iJPrfEUd2MbMCULeT7956Ociw7k+Fetx5lGPMqKnI7DXvOH4tv4QD7CslscYuJNg5Iiz+YdZ1+nAe5FYukDIDFtv87a7uvxEDHN/CpGuCDnPPYvRoAIHj0FS7HzRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709654690; c=relaxed/simple;
	bh=r+JAa2ZCZuzUlZ5+j7doFlqH2VLOA5hH0qAehVbTY/I=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=smiyx4MuuaA1u8AwP+T2v+ooGvLKJ2IsaR+iv4+8vSknLQGCJpnJVEChNjlVjF381PAkmGlSGwDfDToie778dl0cSMSgfB7X7KwZUKyRm0oqu9luDx6U3ZOJOATVg1L7eZ0qJsed/URfk4PZYdCsTI+lR21hS5UuyzRdeVfk2ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RuOjrpGA; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6b269686aso8633254276.1
        for <netdev@vger.kernel.org>; Tue, 05 Mar 2024 08:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709654674; x=1710259474; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BP/NiSx0xOGEgpLnrjFAiBUOlZjPqz/JsAge1tk5TKI=;
        b=RuOjrpGAj+G3ERObc3q/T2cjELp0hDqeYVTcicsRAQmnQwEOo7ncu5ueuAhMh9dgd3
         R2IGa9ZIjd0lS2zZC9QmRJxuzlmfG2JxCCAkonN2Gc9CSho6cMVAV/vNmfSI3zYjVt00
         daMPrBq8q+ZmZJIlCmbYDRkA4Evy9sIzoc2JrC+Fy6NNypLMPi1Br6O9+F9RARQ0br5u
         MoA9NOy4NWA0JcghzVnOvZGmn23z9auzVxAAw/73cpMrMEINK7jnt4ZJP0VhpHEjDnly
         80mzhlnAudyanuTJhylmatukG/npnUbXq7ihNaYmq5e9OV9ga4t7rya4fRI1RBPMCccz
         9VoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709654674; x=1710259474;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BP/NiSx0xOGEgpLnrjFAiBUOlZjPqz/JsAge1tk5TKI=;
        b=Tz+0uNra08Wf9OJ8P5mFYSeHtzQxU0JJwtPzyPyFmw2/CDrimHycqfD0qy3vhGwFE5
         vxyI/g/1Unb3zaTVOhmUiJ5wZHJRzRY4gDr6uSKhguCixvEO7u/2LgYrvcKXRMeK22Np
         Gncx0/mHhB+YVfkRayIP+MR4RODxu9E6aaCHZia8Sv9lqUj8+waQxfr8TVVL7ITTNSTK
         wPZkTvd6yZW6fX8xnOhZz97tygKeV+ecRHKEMj5tuWeVlBY0JVw9a2ymqLEwtWpkoiRJ
         IM9U8Wp+MzQmAROl86QNDGq0Xb4PLogYPP0ZK4EpcGojXKamnH6w+TmulcxaA077pU8W
         kjmQ==
X-Gm-Message-State: AOJu0YwG6s4QTnVS42KR4NW+T2AtpOwBGx3mJHxyo4eIoluCxaJ+EtSo
	H15vwB6XIL0BAQ7GYybINW61yuvSvyMPBjc7ajIXWv6DicGFiLkF1rXSkGCcKPm+3L20qnTQvYm
	bMamLHrt4Pg==
X-Google-Smtp-Source: AGHT+IE3AbpGzdM17tI9UVSEIDUauX16zYWFGTSlS7ldhfccc8dKfWKhtqDDt6eGB8SCf/QUl2twx2epeiL7DQ==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a05:6902:124b:b0:dc6:dfd9:d423 with SMTP
 id t11-20020a056902124b00b00dc6dfd9d423mr526001ybu.3.1709654673966; Tue, 05
 Mar 2024 08:04:33 -0800 (PST)
Date: Tue,  5 Mar 2024 16:04:07 +0000
In-Reply-To: <20240305160413.2231423-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240305160413.2231423-1-edumazet@google.com>
X-Mailer: git-send-email 2.44.0.278.ge034bb2e1d-goog
Message-ID: <20240305160413.2231423-13-edumazet@google.com>
Subject: [PATCH net-next 12/18] ipv6: move tcpv6_protocol and udpv6_protocol
 to net_hotdata
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>, 
	Willem de Bruijn <willemb@google.com>, Soheil Hassas Yeganeh <soheil@google.com>, 
	Neal Cardwell <ncardwell@google.com>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

These structures are read in rx path, move them to net_hotdata
for better cache locality.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/hotdata.h |  2 ++
 net/ipv6/tcp_ipv6.c   | 17 +++++++++--------
 net/ipv6/udp.c        | 16 ++++++++--------
 3 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/include/net/hotdata.h b/include/net/hotdata.h
index 086114e4d3bcc9184304b024ed93c9024888fcf1..97617acb75e1f2141fe7170d93c06f9813c725a3 100644
--- a/include/net/hotdata.h
+++ b/include/net/hotdata.h
@@ -16,7 +16,9 @@ struct net_hotdata {
 #if IS_ENABLED(CONFIG_IPV6)
 	struct packet_offload	ipv6_packet_offload;
 	struct net_offload	tcpv6_offload;
+	struct inet6_protocol	tcpv6_protocol;
 	struct net_offload	udpv6_offload;
+	struct inet6_protocol	udpv6_protocol;
 #endif
 	struct list_head	offload_base;
 	struct list_head	ptype_all;
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


