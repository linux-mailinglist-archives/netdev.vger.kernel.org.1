Return-Path: <netdev+bounces-264015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAf3H4mIqGn2vQAAu9opvQ
	(envelope-from <netdev+bounces-264015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:21 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 10DF6207177
	for <lists+netdev@lfdr.de>; Wed, 04 Mar 2026 20:31:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D5D9C3014422
	for <lists+netdev@lfdr.de>; Wed,  4 Mar 2026 19:30:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 854273CCA05;
	Wed,  4 Mar 2026 19:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="D9wYgfp3"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5982C3DEAD1
	for <netdev@vger.kernel.org>; Wed,  4 Mar 2026 19:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772652644; cv=none; b=SqpH35ppBN/LxMnBdZxdnf3xc5ESHmAP1ugYL/Ger2Y+pf9QNO7y90kbm9AxY3NKZIJU+zLdPauxq2Qyj/nbYj6wyVhawhoUTOjAbHLrVKI9AwidIC8rE6+eWkXSOnQ9p3KT38ZUVHWQ2YK+zamAQbEFosN7/FgrdsOx8N1YOt0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772652644; c=relaxed/simple;
	bh=sTbttXbzhQ8SeibauzUS97ZuzecB0l6osm/l4722OF8=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=msynAm24hugpSIPkyTn+6ZqSyE/agGk7yBxP72nFXbKgGu4dQqb6Vv7gUAv/O2VjCGCT2Z0PMtXnWjh/W5VcveYNzXLmT+jbdslOIdCPo3o9TX13JBVbfCNLyxE9eNTZiX5++pB1PWrIJczta/cocS/yJ5tL+GykLuEJ04SQCD0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=D9wYgfp3; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c70eb4d56fcso4402016a12.1
        for <netdev@vger.kernel.org>; Wed, 04 Mar 2026 11:30:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772652642; x=1773257442; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=H+yf4hKubtN0kELnLVQRsgBNA+dQHKgp72JguUPJ3Iw=;
        b=D9wYgfp3n4BXG8wV57DII9xhZiIb/dec/sShxw7/2itBfn4+ApRi7bgTkiv8WjAUn1
         l6O8ho9yN8EDTJkA5a3Mn8F6fdelg82uc5AnaiKviUfoCeXXwQUAskVR4S+AynwQ2rHF
         m3ZFsHkOAvSRE6iL9kabT/bygt3Z99RlEgaYLG0nYWD34+uyPb/Dic7jW67hqh22pKqW
         SHj6sV6VJSq9yNgRMYHh4QtFcriQU0v9INUP02R16xR70yCL3x8TR9vGGk4ZOV6eTOvT
         V7/zfXRgOmklgkqyCBLtFNW8YNnz//vN1NB2TwnAx9ViC9lg2o64xxPhy7+Eb2hasTfL
         +fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772652642; x=1773257442;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H+yf4hKubtN0kELnLVQRsgBNA+dQHKgp72JguUPJ3Iw=;
        b=YMZl2GQDbifOPlY3DDhQ9qoD//X8B4z3XiWx9CliueM59pQHZKt4hkwqqtZrjFryrF
         bPHV1aeYHPVNM/QU7kwkYSv+d8gcYkKStwgBRyX+z5DQg5v6HNysABXjJI+neH0zRS8w
         3Fn6LgDsbwsC5fu4ej+8Fjk7/R/iN5Cn/3nfR5mp3iQFE/N4ZazKOIjGHJWR97i3p6Vp
         fzof0SVbOM+9Ch0UarMgwSkaEguApNsgycQJJXhvWb4QPodJRG9xXMkDMvcTHRnUSVzd
         xUZk4wtbFCMyICqSDB+F5GA/Xj5YzI4ofFFMq3ZcVy3zp84sTLnRoyrlJ0YLF22vQpeo
         ZoIw==
X-Forwarded-Encrypted: i=1; AJvYcCXiIz5+v9e3x50sgKH+8joso3k6xjb43JB6fpfnDVH4bLzaeN8lT6b0JSJY0YwvmVPYnR8I0f0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxQNFaLmZ+xOrPw8k/UuY/9OPzw301WfFXMRgGqrbeZwi7ljKJQ
	vurCgQNuG51fqdKZkVTevwfEivdksmoxrx/ZMfwUOEnYuVJSgn+rG5AJ18yqF5euVynjjRu2Iwu
	3Dee60Q==
X-Received: from pgbcs14.prod.google.com ([2002:a05:6a02:418e:b0:c63:5306:c11d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a21:696:b0:387:dfb3:cd0a
 with SMTP id adf61e73a8af0-3982e260e1cmr2952091637.63.1772652642246; Wed, 04
 Mar 2026 11:30:42 -0800 (PST)
Date: Wed,  4 Mar 2026 19:28:34 +0000
In-Reply-To: <20260304193034.1870586-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260304193034.1870586-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.473.g4a7958ca14-goog
Message-ID: <20260304193034.1870586-4-kuniyu@google.com>
Subject: [PATCH v1 net-next 03/15] ipv6: Remove UDP-Lite support for IPV6_ADDRFORM.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, David Ahern <dsahern@kernel.org>, 
	"David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 10DF6207177
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-264015-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,davemloft.net,google.com,redhat.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

We cannot create IPv6 UDP-Lite sockets anymore.

Let's remove dead code in IPV6_ADDRFORM.

Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ipv6_sockglue.c | 17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

diff --git a/net/ipv6/ipv6_sockglue.c b/net/ipv6/ipv6_sockglue.c
index 02c4cab60c69..b4c977434c2e 100644
--- a/net/ipv6/ipv6_sockglue.c
+++ b/net/ipv6/ipv6_sockglue.c
@@ -45,7 +45,6 @@
 #include <net/inet_common.h>
 #include <net/tcp.h>
 #include <net/udp.h>
-#include <net/udplite.h>
 #include <net/xfrm.h>
 #include <net/compat.h>
 #include <net/seg6.h>
@@ -563,10 +562,8 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 			if (sk->sk_type == SOCK_RAW)
 				break;
 
-			if (sk->sk_protocol == IPPROTO_UDP ||
-			    sk->sk_protocol == IPPROTO_UDPLITE) {
-				struct udp_sock *up = udp_sk(sk);
-				if (up->pending == AF_INET6) {
+			if (sk->sk_protocol == IPPROTO_UDP) {
+				if (udp_sk(sk)->pending == AF_INET6) {
 					retv = -EBUSY;
 					break;
 				}
@@ -607,16 +604,11 @@ int do_ipv6_setsockopt(struct sock *sk, int level, int optname,
 				WRITE_ONCE(sk->sk_family, PF_INET);
 				tcp_sync_mss(sk, icsk->icsk_pmtu_cookie);
 			} else {
-				struct proto *prot = &udp_prot;
-
-				if (sk->sk_protocol == IPPROTO_UDPLITE)
-					prot = &udplite_prot;
-
 				sock_prot_inuse_add(net, sk->sk_prot, -1);
-				sock_prot_inuse_add(net, prot, 1);
+				sock_prot_inuse_add(net, &udp_prot, 1);
 
 				/* Paired with READ_ONCE(sk->sk_prot) in inet6_dgram_ops */
-				WRITE_ONCE(sk->sk_prot, prot);
+				WRITE_ONCE(sk->sk_prot, &udp_prot);
 				WRITE_ONCE(sk->sk_socket->ops, &inet_dgram_ops);
 				WRITE_ONCE(sk->sk_family, PF_INET);
 			}
@@ -1098,7 +1090,6 @@ int do_ipv6_getsockopt(struct sock *sk, int level, int optname,
 	switch (optname) {
 	case IPV6_ADDRFORM:
 		if (sk->sk_protocol != IPPROTO_UDP &&
-		    sk->sk_protocol != IPPROTO_UDPLITE &&
 		    sk->sk_protocol != IPPROTO_TCP)
 			return -ENOPROTOOPT;
 		if (sk->sk_state != TCP_ESTABLISHED)
-- 
2.53.0.473.g4a7958ca14-goog


