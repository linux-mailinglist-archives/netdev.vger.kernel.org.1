Return-Path: <netdev+bounces-70577-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A0A8E84F9F4
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 17:49:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C481A1C28F97
	for <lists+netdev@lfdr.de>; Fri,  9 Feb 2024 16:49:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 587847BAF5;
	Fri,  9 Feb 2024 16:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d5vfYz5I"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899A07B3D9
	for <netdev@vger.kernel.org>; Fri,  9 Feb 2024 16:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707497026; cv=none; b=fVX//8ige40Vq9SqFkmpS1Udsu0dpkG+ZTX0u1lG7aUpGOcO8J2wzAbhDqc1JE+ouq63z5iWaVkubTvVp7jTQrR0HEG7kZVtliUl80NmNnlykJm+9KyKONPwgJcgEObqyPMbZID3+2H3Eo5nRMULe9i8jWnUT4J2juAou/P58BE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707497026; c=relaxed/simple;
	bh=Lo62xmsLU9S8XAhqwi8wEBzEsAGqvbZk9Mj8vGcbDm8=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=CyqwTDpE1LAy5z9QwBn9IQ+Bqzgv4vXWdJH1pXvHL+w2ccdURqiuOCHABPnJArQaKHjqWiyeOBkC5NxvhtyRZxwzQ3Ka/IlFNJtPCQ9p20d9XSHaPh98G6OBkYPzIK6AVAdn28f428aIGxjw/HdkpmGDA9jkhdm0dIhQZ/1lTrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d5vfYz5I; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707497023;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=wxHsoB/MMaNQaBWOjli6zWvtt/OihGH7HhQ5Yk2FsWM=;
	b=d5vfYz5ILrLFCEhanRkRQgv5zMgN2SntbSHoEMuvwshk+EVwNMDzmJSA037ZXnwAElG3je
	CXnXjO9K3KatFu92Aa9fGWwHxE40BcRdOCdPc1/txz8hvAajSKbo49IGQbuK5YbaHAO/4z
	oTsvf55CbG+wWQOrsipZiTzK48oIpu0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-481-2ogF6BtEOoq6RdVX2st_ig-1; Fri, 09 Feb 2024 11:43:42 -0500
X-MC-Unique: 2ogF6BtEOoq6RdVX2st_ig-1
Received: by mail-qv1-f72.google.com with SMTP id 6a1803df08f44-68ca5f30b20so11434536d6.2
        for <netdev@vger.kernel.org>; Fri, 09 Feb 2024 08:43:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707497021; x=1708101821;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wxHsoB/MMaNQaBWOjli6zWvtt/OihGH7HhQ5Yk2FsWM=;
        b=dC14YiG5N7kSR3D00+NaLTcWIwWPFUUicnbctY737taJMk64PLcFn5jCsuqb41VkpL
         vwJp91DMq5NdPNlUc1SlJMY5jFMX4oNt/c//vPQygRgOeg0h9ikBHX5bJoPd8Q78DWu4
         bh8QDXopzpal5IoL2gzu4N5pCohovnfL09H45wKWStVrX4i1Ujpe4CI9oMIxu0hYTgaX
         /apxR+5hzmqN6EvyRTZFTKijAn1Rk+Ta5+xqKMtc7Rhs2BIOFCcd510Qn08NjsJ3HPfB
         IX9GXswqN0ZZh+DkPEKjbmtycb2ppfqW9TLCo3zJ/oh496AHpmopspd2ov1CqKQ/gdk+
         Bp1Q==
X-Gm-Message-State: AOJu0YxRC/87LcFZDdval4mhBNSo7sqnj20Jl8l0PnYJ4bWACql9ean8
	XMJbvrVAKJ4/+6WBYB2X1PEcRBKasdOKA4H7CNO08mCnVDVKkVg9ARJPvZnnmqHswmFFnzLnzkZ
	5UxMw09/FNPAzd+JL9VEr4ToeQbm6c4olImceLXduI34M+4CocbRdPA==
X-Received: by 2002:a0c:f54a:0:b0:68c:c3db:b26e with SMTP id p10-20020a0cf54a000000b0068cc3dbb26emr2110666qvm.42.1707497021491;
        Fri, 09 Feb 2024 08:43:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6QL54arNCnBXuAZ5eA5td4VEhZDIa/pPz1e294DJkxBTC5Ol51UPENklVI4HAmsUV4+JX5g==
X-Received: by 2002:a0c:f54a:0:b0:68c:c3db:b26e with SMTP id p10-20020a0cf54a000000b0068cc3dbb26emr2110653qvm.42.1707497021210;
        Fri, 09 Feb 2024 08:43:41 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCW2OtMOC2CJqZlIOpLtUkNnVYXVr3ZM4/8suVdOJJ+cQM04rns46sKFD4q9FI72J7OkAxnzfbgJImXHgjoeF08q38a2kROEx3hKGhKuqSpqNqez1NCxv958kabjbFdr486ckkTSyyHVG+qJSJlfwDMfDRbTr9xf/AntB+blmV5wwc6BHNqsVf3zcWwE6oSIArLvR+qSHfLonNa759DNsAJqjB0a29Q=
Received: from debian (2a01cb058918ce00eae3bc4587939b97.ipv6.abo.wanadoo.fr. [2a01:cb05:8918:ce00:eae3:bc45:8793:9b97])
        by smtp.gmail.com with ESMTPSA id lv7-20020a056214578700b0068c3b1bcf6bsm962587qvb.95.2024.02.09.08.43.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Feb 2024 08:43:40 -0800 (PST)
Date: Fri, 9 Feb 2024 17:43:37 +0100
From: Guillaume Nault <gnault@redhat.com>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>, Eric Dumazet <edumazet@google.com>
Cc: netdev@vger.kernel.org, David Ahern <dsahern@kernel.org>,
	James Chapman <jchapman@katalix.com>,
	Taehee Yoo <ap420073@gmail.com>
Subject: [PATCH net-next] ipv4: Set the routing scope properly in
 ip_route_output_ports().
Message-ID: <dacfd2ab40685e20959ab7b53c427595ba229e7d.1707496938.git.gnault@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Set scope automatically in ip_route_output_ports() (using the socket
SOCK_LOCALROUTE flag). This way, callers don't have to overload the
tos with the RTO_ONLINK flag, like RT_CONN_FLAGS() does.

For callers that don't pass a struct sock, this doesn't change anything
as the scope is still set to RT_SCOPE_UNIVERSE when sk is NULL.

Callers that passed a struct sock and used RT_CONN_FLAGS(sk) or
RT_CONN_FLAGS_TOS(sk, tos) for the tos are modified to use
ip_sock_tos(sk) and RT_TOS(tos) respectively, as overloading tos with
the RTO_ONLINK flag now becomes unnecessary.

In drivers/net/amt.c, all ip_route_output_ports() calls use a 0 tos
parameter, ignoring the SOCK_LOCALROUTE flag of the socket. But the sk
parameter is a kernel socket, which doesn't have any configuration path
for setting SOCK_LOCALROUTE anyway. Therefore, ip_route_output_ports()
will continue to initialise scope with RT_SCOPE_UNIVERSE and amt.c
doesn't need to be modified.

Also, remove RT_CONN_FLAGS() and RT_CONN_FLAGS_TOS() from route.h as
these macros are now unused.

The objective is to eventually remove RTO_ONLINK entirely to allow
converting ->flowi4_tos to dscp_t. This will ensure proper isolation
between the DSCP and ECN bits, thus minimising the risk of introducing
bugs where TOS values interfere with ECN.

Signed-off-by: Guillaume Nault <gnault@redhat.com>
---
 include/net/route.h             | 7 ++-----
 net/ipv4/af_inet.c              | 2 +-
 net/ipv4/datagram.c             | 2 +-
 net/ipv4/inet_connection_sock.c | 2 +-
 net/ipv4/ip_output.c            | 2 +-
 net/l2tp/l2tp_ip.c              | 2 +-
 6 files changed, 7 insertions(+), 10 deletions(-)

diff --git a/include/net/route.h b/include/net/route.h
index 980ab474eabd..d4a0147942f1 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -37,9 +37,6 @@
 
 #define RTO_ONLINK	0x01
 
-#define RT_CONN_FLAGS(sk)   (RT_TOS(READ_ONCE(inet_sk(sk)->tos)) | sock_flag(sk, SOCK_LOCALROUTE))
-#define RT_CONN_FLAGS_TOS(sk,tos)   (RT_TOS(tos) | sock_flag(sk, SOCK_LOCALROUTE))
-
 static inline __u8 ip_sock_rt_scope(const struct sock *sk)
 {
 	if (sock_flag(sk, SOCK_LOCALROUTE))
@@ -163,8 +160,8 @@ static inline struct rtable *ip_route_output_ports(struct net *net, struct flowi
 						   __u8 proto, __u8 tos, int oif)
 {
 	flowi4_init_output(fl4, oif, sk ? READ_ONCE(sk->sk_mark) : 0, tos,
-			   RT_SCOPE_UNIVERSE, proto,
-			   sk ? inet_sk_flowi_flags(sk) : 0,
+			   sk ? ip_sock_rt_scope(sk) : RT_SCOPE_UNIVERSE,
+			   proto, sk ? inet_sk_flowi_flags(sk) : 0,
 			   daddr, saddr, dport, sport, sock_net_uid(net, sk));
 	if (sk)
 		security_sk_classify_flow(sk, flowi4_to_flowi_common(fl4));
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index a5a820ee2026..ad278009e469 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1326,7 +1326,7 @@ int inet_sk_rebuild_header(struct sock *sk)
 	fl4 = &inet->cork.fl.u.ip4;
 	rt = ip_route_output_ports(sock_net(sk), fl4, sk, daddr, inet->inet_saddr,
 				   inet->inet_dport, inet->inet_sport,
-				   sk->sk_protocol, RT_CONN_FLAGS(sk),
+				   sk->sk_protocol, ip_sock_rt_tos(sk),
 				   sk->sk_bound_dev_if);
 	if (!IS_ERR(rt)) {
 		err = 0;
diff --git a/net/ipv4/datagram.c b/net/ipv4/datagram.c
index 2cc50cbfc2a3..cc6d0bd7b0a9 100644
--- a/net/ipv4/datagram.c
+++ b/net/ipv4/datagram.c
@@ -119,7 +119,7 @@ void ip4_datagram_release_cb(struct sock *sk)
 	rt = ip_route_output_ports(sock_net(sk), &fl4, sk, daddr,
 				   inet->inet_saddr, inet->inet_dport,
 				   inet->inet_sport, sk->sk_protocol,
-				   RT_CONN_FLAGS(sk), sk->sk_bound_dev_if);
+				   ip_sock_rt_tos(sk), sk->sk_bound_dev_if);
 
 	dst = !IS_ERR(rt) ? &rt->dst : NULL;
 	sk_dst_set(sk, dst);
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 459af1f89739..747ed7344cbe 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1467,7 +1467,7 @@ static struct dst_entry *inet_csk_rebuild_route(struct sock *sk, struct flowi *f
 	rt = ip_route_output_ports(sock_net(sk), fl4, sk, daddr,
 				   inet->inet_saddr, inet->inet_dport,
 				   inet->inet_sport, sk->sk_protocol,
-				   RT_CONN_FLAGS(sk), sk->sk_bound_dev_if);
+				   ip_sock_rt_tos(sk), sk->sk_bound_dev_if);
 	if (IS_ERR(rt))
 		rt = NULL;
 	if (rt)
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 41537d18eecf..5b5a0adb927f 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -493,7 +493,7 @@ int __ip_queue_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl,
 					   inet->inet_dport,
 					   inet->inet_sport,
 					   sk->sk_protocol,
-					   RT_CONN_FLAGS_TOS(sk, tos),
+					   RT_TOS(tos),
 					   sk->sk_bound_dev_if);
 		if (IS_ERR(rt))
 			goto no_route;
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index 9a2a9ed3ba47..970af3983d11 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -478,7 +478,7 @@ static int l2tp_ip_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		rt = ip_route_output_ports(sock_net(sk), fl4, sk,
 					   daddr, inet->inet_saddr,
 					   inet->inet_dport, inet->inet_sport,
-					   sk->sk_protocol, RT_CONN_FLAGS(sk),
+					   sk->sk_protocol, ip_sock_rt_tos(sk),
 					   sk->sk_bound_dev_if);
 		if (IS_ERR(rt))
 			goto no_route;
-- 
2.39.2


