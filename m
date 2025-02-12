Return-Path: <netdev+bounces-165357-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B0E9A31BC2
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 03:12:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468553A2F30
	for <lists+netdev@lfdr.de>; Wed, 12 Feb 2025 02:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35E031C5D76;
	Wed, 12 Feb 2025 02:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CPCkxN6f"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 728F118D643
	for <netdev@vger.kernel.org>; Wed, 12 Feb 2025 02:11:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739326312; cv=none; b=bgLVYHqHX2P5dmQU01HxXOJYIhUNVCVqJfHNYvBNSoCSh0RLlQSdssAWNa3LeeGRLeYPtck+iYFIpNTFqDCin13fk1A3+WDIqeC9ZLAreBG4ABq1KNkaHirU1zlfhWXCLCPHkdUDU7cbxj0DKEfkRp31X2+e+w6smAf9fL8oLN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739326312; c=relaxed/simple;
	bh=+Z3nqKTJAcjez/+GWwupNGGqQLscqTK+z/YZWz2IfOM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=O/ZgYNbeCNueLcEgXaL4vVo1X8dG8WvOr5PaYpNhhB45ui9xdKb68JCCiuWdh2yhAlCx8VQMfm6vTXW9BY+mqXuJg3fjevGAXV7oWV+IBHZfbltHySuHsNe66D4dxcOhtzeCY/SsME7ugesv+3CHQ4n70SMrTZHl7cHJh6YSBos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CPCkxN6f; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-6dcd4f1aaccso95932656d6.2
        for <netdev@vger.kernel.org>; Tue, 11 Feb 2025 18:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739326309; x=1739931109; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUsNq58HlE/263yhCAnC53H+mDgC/Z+T8PEBGsXfJVE=;
        b=CPCkxN6f4zGK0lmOmR/6X/Qsa4nNFBDh75WjZIXeo5Fg9vrPAssuTotFu/0PXJqSIV
         GibP6sUEsl4b4T7Wl3lZxPxMTRrZ0AO8eUM+xjbl+h4FRaJUlCH/SGknWBYF56zoePnV
         rKMb0y340X0l17MQCjrYpDFkv7JY/NP7IBZXyywIAobbYf2AGHnWOf3Iyaaui/lG+cIw
         NXHt5Rh1hVw0iYKnvcTGj4pHFiD8Yum/ah9ubrVFmb3gevMKcE0h5NjNwZhQ5XGV+Rsk
         ZcU5Kmz2Nl0MNTBqovmY1XpJjb/7pcIy+em8R5Ndt2aAmLlzQJZe4gADy+SCdLVyHtxJ
         iOFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739326309; x=1739931109;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUsNq58HlE/263yhCAnC53H+mDgC/Z+T8PEBGsXfJVE=;
        b=oLiozfwiG2YmzSZlxyro4spvYquw5bKO4ktPiQt0NsiNm1FvxIhscqDMtZnEldE73J
         M/e+UPmiUDeqkZTmGxodoK53n8KCUy4gff9lPrd/AKbYfCxRXhsngtVqXzxVwOez5vJH
         HMk5XEG2W1KOMgX0vsk6wAWRfafAyT4er76l1mRz/ziMG38F0x4EdW4zVS9AKTYi+T59
         +UHcJQa735vjOkTbBmt/l6YEiWqKUofzV7Z/Y8tcbqcdaGla5yBq/QquYvtlmJAUJArS
         0l/yutNKXnxE6/AKxSxlZ9YK4BEEy6+Ye2GGJionuW8hXgfNlD8cmD6zXBKjtcfkTz8y
         Pdeg==
X-Gm-Message-State: AOJu0YwTL6ahYjRtTroPQwPXQ6+TOUxFjkvUcmdWeRlj+FfYm+aZ/PA9
	rp95TMC4/3t7xpoF0XNSF4tQTSXXvc24Jv3pBCbxTAQd6UwEVs5ExwIm5Q==
X-Gm-Gg: ASbGncsIHloOHj8j1APg2cFbxQ5/0xTYVcLnyQTn3q8yfEiP1Spl0NYJs/A3U3KCrYr
	lPV/xxRFcOzwEBTqQV57EEObakQgpfY9r7pb/nvKl/eKxS/K5ukP2nsj6Q5UFkqEIt0YfZ6AD6z
	bxYL1PpEEDOlKt/vb4EkGhl/rKX4iY/XJuBKvFiF5Ik8qnNX/lkz2E6siIQ9rZsvkALHQnxoAtQ
	otyuQX7CaQZOCL2myVGv4scn1bslOuHsWvdAwpDmTY6i0mPkj21G2f4+OWFh9PaDjVrdBUKZODX
	w91Q7KloSxroJgDDYwRexSJhE4n4Ufno0GsbRzDMKioe253KPyLONIC3+G+fzO9uYn3ABodEaGM
	SR+4wD3s4eg==
X-Google-Smtp-Source: AGHT+IG4wia817+8BlAsvvEJo7Fbtbq/WEA/+hQcKkePMR9GQUSrNxNTxFbBb64DOOwS2IVuQ9cmdg==
X-Received: by 2002:a05:6214:cc9:b0:6d8:aba8:8393 with SMTP id 6a1803df08f44-6e46edb548cmr24060886d6.44.1739326309264;
        Tue, 11 Feb 2025 18:11:49 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6e44a9a524esm58256126d6.5.2025.02.11.18.11.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 18:11:48 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	dsahern@kernel.org,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v2 4/7] ipv4: remove get_rttos
Date: Tue, 11 Feb 2025 21:09:50 -0500
Message-ID: <20250212021142.1497449-5-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.48.1.502.g6dc24dfdaf-goog
In-Reply-To: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
References: <20250212021142.1497449-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Willem de Bruijn <willemb@google.com>

Initialize the ip cookie tos field when initializing the cookie, in
ipcm_init_sk.

The existing code inverts the standard pattern for initializing cookie
fields. Default is to initialize the field from the sk, then possibly
overwrite that when parsing cmsgs (the unlikely case).

This field inverts that, setting the field to an illegal value and
after cmsg parsing checking whether the value is still illegal and
thus should be overridden.

Be careful to always apply mask INET_DSCP_MASK, as before.

v1->v2
  - limit INET_DSCP_MASK to routing

Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/ip.h | 11 +++--------
 net/ipv4/ping.c  |  6 +++---
 net/ipv4/raw.c   |  6 +++---
 net/ipv4/udp.c   |  6 +++---
 4 files changed, 12 insertions(+), 17 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6af16545b3e3..4798500f3398 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -92,7 +92,9 @@ static inline void ipcm_init(struct ipcm_cookie *ipcm)
 static inline void ipcm_init_sk(struct ipcm_cookie *ipcm,
 				const struct inet_sock *inet)
 {
-	ipcm_init(ipcm);
+	*ipcm = (struct ipcm_cookie) {
+		.tos = READ_ONCE(inet->tos),
+	};
 
 	sockcm_init(&ipcm->sockc, &inet->sk);
 
@@ -256,13 +258,6 @@ static inline u8 ip_sendmsg_scope(const struct inet_sock *inet,
 	return RT_SCOPE_UNIVERSE;
 }
 
-static inline __u8 get_rttos(struct ipcm_cookie* ipc, struct inet_sock *inet)
-{
-	u8 dsfield = ipc->tos != -1 ? ipc->tos : READ_ONCE(inet->tos);
-
-	return dsfield & INET_DSCP_MASK;
-}
-
 /* datagram.c */
 int __ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
 int ip4_datagram_connect(struct sock *sk, struct sockaddr *uaddr, int addr_len);
diff --git a/net/ipv4/ping.c b/net/ipv4/ping.c
index 619ddc087957..85d09f2ecadc 100644
--- a/net/ipv4/ping.c
+++ b/net/ipv4/ping.c
@@ -705,7 +705,7 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	struct ip_options_data opt_copy;
 	int free = 0;
 	__be32 saddr, daddr, faddr;
-	u8 tos, scope;
+	u8 scope;
 	int err;
 
 	pr_debug("ping_v4_sendmsg(sk=%p,sk->num=%u)\n", inet, inet->inet_num);
@@ -768,7 +768,6 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 		faddr = ipc.opt->opt.faddr;
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
 	if (ipv4_is_multicast(daddr)) {
@@ -779,7 +778,8 @@ static int ping_v4_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	} else if (!ipc.oif)
 		ipc.oif = READ_ONCE(inet->uc_index);
 
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos, scope,
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
 			   sk->sk_protocol, inet_sk_flowi_flags(sk), faddr,
 			   saddr, 0, 0, sk->sk_uid);
 
diff --git a/net/ipv4/raw.c b/net/ipv4/raw.c
index 4304a68d1db0..6aace4d55733 100644
--- a/net/ipv4/raw.c
+++ b/net/ipv4/raw.c
@@ -486,7 +486,7 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	struct ipcm_cookie ipc;
 	struct rtable *rt = NULL;
 	struct flowi4 fl4;
-	u8 tos, scope;
+	u8 scope;
 	int free = 0;
 	__be32 daddr;
 	__be32 saddr;
@@ -581,7 +581,6 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 			daddr = ipc.opt->opt.faddr;
 		}
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 
 	uc_index = READ_ONCE(inet->uc_index);
@@ -606,7 +605,8 @@ static int raw_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		}
 	}
 
-	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark, tos, scope,
+	flowi4_init_output(&fl4, ipc.oif, ipc.sockc.mark,
+			   ipc.tos & INET_DSCP_MASK, scope,
 			   hdrincl ? ipc.protocol : sk->sk_protocol,
 			   inet_sk_flowi_flags(sk) |
 			    (hdrincl ? FLOWI_FLAG_KNOWN_NH : 0),
diff --git a/net/ipv4/udp.c b/net/ipv4/udp.c
index a9bb9ce5438e..65519b1a1e67 100644
--- a/net/ipv4/udp.c
+++ b/net/ipv4/udp.c
@@ -1281,7 +1281,7 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 	int free = 0;
 	int connected = 0;
 	__be32 daddr, faddr, saddr;
-	u8 tos, scope;
+	u8 scope;
 	__be16 dport;
 	int err, is_udplite = IS_UDPLITE(sk);
 	int corkreq = udp_test_bit(CORK, sk) || msg->msg_flags & MSG_MORE;
@@ -1405,7 +1405,6 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 		faddr = ipc.opt->opt.faddr;
 		connected = 0;
 	}
-	tos = get_rttos(&ipc, inet);
 	scope = ip_sendmsg_scope(inet, &ipc, msg);
 	if (scope == RT_SCOPE_LINK)
 		connected = 0;
@@ -1442,7 +1441,8 @@ int udp_sendmsg(struct sock *sk, struct msghdr *msg, size_t len)
 
 		fl4 = &fl4_stack;
 
-		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark, tos, scope,
+		flowi4_init_output(fl4, ipc.oif, ipc.sockc.mark,
+				   ipc.tos & INET_DSCP_MASK, scope,
 				   sk->sk_protocol, flow_flags, faddr, saddr,
 				   dport, inet->inet_sport, sk->sk_uid);
 
-- 
2.48.1.502.g6dc24dfdaf-goog


