Return-Path: <netdev+bounces-135934-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA6699FD32
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 02:33:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 75263281E4C
	for <lists+netdev@lfdr.de>; Wed, 16 Oct 2024 00:33:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27EF22E40B;
	Wed, 16 Oct 2024 00:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/ZDfg4Z"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F102F27442;
	Wed, 16 Oct 2024 00:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729038807; cv=none; b=BV9hKqMXVQekXSQ6wN4d2R5J75jRH2G9qDc53goeOfXrR5y1SB38ZdyydXdp3rV0onQZo1lYrHgXT20j+dnO7DADKUbZaZGyUmbAD1r4rK9YGW40rQzB25Wm6a8yndfDUh6c6sUgippFqXCmOhxyM+ce1N+LRQTgBA/jgguGuEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729038807; c=relaxed/simple;
	bh=oCHAROvOfTrDd21uZhMKFN0mvX2Z8eFLJfvyvCryopU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=azqludNCkBQk41Q8U6BHZk/Q3G6jO6gixvuDE9Ww5tL/6XDLS8blL6nl2XeWIXhngEOWrXl2z06RyvPXeVTLkI0bbiDv8LnJlvIqgcjS/J/CskLBG3uL00G6kgvxrBtXFzTZNXI45NOt8q3F2pTp/Vc73CX2R9MTisobs0DXC0E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/ZDfg4Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E06BCC4CEC6;
	Wed, 16 Oct 2024 00:33:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729038806;
	bh=oCHAROvOfTrDd21uZhMKFN0mvX2Z8eFLJfvyvCryopU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=U/ZDfg4ZW2jJhzFvezkTW3RHesXKCzaGqIvjexwiCVMrOjWzzqnv67ehbWf3En/wa
	 qhxzPQbZt4DFL8gdb8NeSm90FjkqcU3wYrsNHtJi6KJzN95p7xQmCJPrkoIofBSTS5
	 I2PfpxVSjuYL/mqCMq83YrRRF8A/ThQQ69PgAwRbvWR5LEv6++gqYwtNDJJkwG7QXn
	 0lUug0BEYdzOJWu/9k11HfbNCXasJArkbbMy/UDFo6drSaqhsA8b9tKRWJGzq0Mj0j
	 WZQiYkTIw7uKgdEkOyfqThn5TtH+4o1Ge2OUFsTWBbDe7/CN59ObHOhPlW693lz2KI
	 dBeizE1bd/s0A==
Date: Tue, 15 Oct 2024 18:33:23 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH 5/5][next] uapi: net: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <d64af418459145b7d8eb94cd300fb4b7d2659a3c.1729037131.git.gustavoars@kernel.org>
References: <cover.1729037131.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729037131.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in a couple of composite structs, which are currently causing
trouble, from `struct sockaddr` to `struct sockaddr_legacy`. Note that
the latter struct doesn't contain a flexible-array member.

include/uapi/linux/route.h:33:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/uapi/linux/route.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end
include/net/compat.h:34:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
include/net/compat.h:35:25: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]

Also, update some related code, accordingly.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
 include/net/compat.h       | 30 +++++++++++++++---------------
 include/uapi/linux/route.h | 28 ++++++++++++++--------------
 net/appletalk/ddp.c        |  2 +-
 net/ipv4/af_inet.c         |  2 +-
 net/ipv4/fib_frontend.c    |  2 +-
 5 files changed, 32 insertions(+), 32 deletions(-)

diff --git a/include/net/compat.h b/include/net/compat.h
index 84c163f40f38..89e891d8dcf3 100644
--- a/include/net/compat.h
+++ b/include/net/compat.h
@@ -29,21 +29,21 @@ struct compat_cmsghdr {
 };
 
 struct compat_rtentry {
-	u32		rt_pad1;
-	struct sockaddr rt_dst;         /* target address               */
-	struct sockaddr rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
-	struct sockaddr rt_genmask;     /* target network mask (IP)     */
-	unsigned short	rt_flags;
-	short		rt_pad2;
-	u32		rt_pad3;
-	unsigned char	rt_tos;
-	unsigned char	rt_class;
-	short		rt_pad4;
-	short		rt_metric;      /* +1 for binary compatibility! */
-	compat_uptr_t	rt_dev;         /* forcing the device at add    */
-	u32		rt_mtu;         /* per route MTU/Window         */
-	u32		rt_window;      /* Window clamping              */
-	unsigned short  rt_irtt;        /* Initial RTT                  */
+	u32			rt_pad1;
+	struct sockaddr_legacy	rt_dst;         /* target address               */
+	struct sockaddr_legacy	rt_gateway;     /* gateway addr (RTF_GATEWAY)   */
+	struct sockaddr_legacy	rt_genmask;     /* target network mask (IP)     */
+	unsigned short		rt_flags;
+	short			rt_pad2;
+	u32			rt_pad3;
+	unsigned char		rt_tos;
+	unsigned char		rt_class;
+	short			rt_pad4;
+	short			rt_metric;      /* +1 for binary compatibility! */
+	compat_uptr_t		rt_dev;         /* forcing the device at add    */
+	u32			rt_mtu;         /* per route MTU/Window         */
+	u32			rt_window;      /* Window clamping              */
+	unsigned short		rt_irtt;        /* Initial RTT                  */
 };
 
 int __get_compat_msghdr(struct msghdr *kmsg, struct compat_msghdr *msg,
diff --git a/include/uapi/linux/route.h b/include/uapi/linux/route.h
index a0de9a7331a2..7e43765e03dd 100644
--- a/include/uapi/linux/route.h
+++ b/include/uapi/linux/route.h
@@ -29,22 +29,22 @@
 
 /* This structure gets passed by the SIOCADDRT and SIOCDELRT calls. */
 struct rtentry {
-	unsigned long	rt_pad1;
-	struct sockaddr	rt_dst;		/* target address		*/
-	struct sockaddr	rt_gateway;	/* gateway addr (RTF_GATEWAY)	*/
-	struct sockaddr	rt_genmask;	/* target network mask (IP)	*/
-	unsigned short	rt_flags;
-	short		rt_pad2;
-	unsigned long	rt_pad3;
-	void		*rt_pad4;
-	short		rt_metric;	/* +1 for binary compatibility!	*/
-	char __user	*rt_dev;	/* forcing the device at add	*/
-	unsigned long	rt_mtu;		/* per route MTU/Window 	*/
+	unsigned long		rt_pad1;
+	struct sockaddr_legacy	rt_dst;		/* target address		*/
+	struct sockaddr_legacy	rt_gateway;	/* gateway addr (RTF_GATEWAY)	*/
+	struct sockaddr_legacy	rt_genmask;	/* target network mask (IP)	*/
+	unsigned short		rt_flags;
+	short			rt_pad2;
+	unsigned long		rt_pad3;
+	void			*rt_pad4;
+	short			rt_metric;	/* +1 for binary compatibility!	*/
+	char __user		*rt_dev;	/* forcing the device at add	*/
+	unsigned long		rt_mtu;		/* per route MTU/Window		*/
 #ifndef __KERNEL__
-#define rt_mss	rt_mtu			/* Compatibility :-(            */
+#define rt_mss	rt_mtu				/* Compatibility :-(            */
 #endif
-	unsigned long	rt_window;	/* Window clamping 		*/
-	unsigned short	rt_irtt;	/* Initial RTT			*/
+	unsigned long		rt_window;	/* Window clamping		*/
+	unsigned short		rt_irtt;	/* Initial RTT			*/
 };
 
 
diff --git a/net/appletalk/ddp.c b/net/appletalk/ddp.c
index b068651984fe..aac82a4af36f 100644
--- a/net/appletalk/ddp.c
+++ b/net/appletalk/ddp.c
@@ -1832,7 +1832,7 @@ static int atalk_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 	struct rtentry rt;
 
 	if (copy_from_user(&rt.rt_dst, &ur->rt_dst,
-			3 * sizeof(struct sockaddr)) ||
+			3 * sizeof(struct sockaddr_legacy)) ||
 	    get_user(rt.rt_flags, &ur->rt_flags) ||
 	    get_user(rt.rt_metric, &ur->rt_metric) ||
 	    get_user(rt.rt_mtu, &ur->rt_mtu) ||
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b24d74616637..75bd15d884e3 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1021,7 +1021,7 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 	struct rtentry rt;
 
 	if (copy_from_user(&rt.rt_dst, &ur->rt_dst,
-			3 * sizeof(struct sockaddr)) ||
+			3 * sizeof(struct sockaddr_legacy)) ||
 	    get_user(rt.rt_flags, &ur->rt_flags) ||
 	    get_user(rt.rt_metric, &ur->rt_metric) ||
 	    get_user(rt.rt_mtu, &ur->rt_mtu) ||
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 8353518b110a..595b9ac58e92 100644
--- a/net/ipv4/fib_frontend.c
+++ b/net/ipv4/fib_frontend.c
@@ -452,7 +452,7 @@ int fib_validate_source(struct sk_buff *skb, __be32 src, __be32 dst,
 				     itag);
 }
 
-static inline __be32 sk_extract_addr(struct sockaddr *addr)
+static inline __be32 sk_extract_addr(struct sockaddr_legacy *addr)
 {
 	return ((struct sockaddr_in *) addr)->sin_addr.s_addr;
 }
-- 
2.34.1


