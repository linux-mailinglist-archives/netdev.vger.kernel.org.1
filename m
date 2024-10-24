Return-Path: <netdev+bounces-138878-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 351629AF490
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 23:14:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 58B041C21F2D
	for <lists+netdev@lfdr.de>; Thu, 24 Oct 2024 21:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56A1F218303;
	Thu, 24 Oct 2024 21:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I+EJiAOG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27138217916;
	Thu, 24 Oct 2024 21:14:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729804475; cv=none; b=uuGyawTuCn7fOPPzdoftQuut5thF/p+6394ir9tR0c/hoP110P26OR4kqpAoaIrx0kOOsaxCEc7nUUKnZZG2utcS6OzogYrZ/Fxfk3qHBmJBz322IO7iARw/TMIaEEpBxDaR1GXwUD4qJqstzBSOV6kn3+Ih1eJB3z5NMnuzhoE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729804475; c=relaxed/simple;
	bh=RPrXxToPed4P2qJ+35T7mOSrAPsKyzWjCEbw6Myhtug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gjeoYLrRjmeXHs+4hKadWKsffcCk+YnQJg3T/vR9sNrHwfGsJ+C7udtSg9aEXhLVYaIzcNRRTkWyIb41dO82S/Oynx4Cc/Um2gbhe9kdqXdIpmL9pELCVOyA4byqJ2On75zVeN9RSgdgM2R4gh5t2s36nimXWBsn6QaPIME0KIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I+EJiAOG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71E4AC4CEC7;
	Thu, 24 Oct 2024 21:14:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729804474;
	bh=RPrXxToPed4P2qJ+35T7mOSrAPsKyzWjCEbw6Myhtug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+EJiAOGA8nDEX1APRxBItQ26lqqHozHlZlKG+URE0XbdSp2SKozjdFYWQlaabPho
	 hJywnb/DsdCog5/XE5CtCySGmzikp5p6cnjqBOEF70YR1sr0aAhax4FKaciHjDBF/N
	 Wd+1C6FHb4b1jumPp/Qks7mTzPPwIf66lYWJzYf92ce+9xM2VKXC0UE9QE9DncA0+t
	 JQY5iKJ8BQOkltMyeHu8E5qFmlMYsR4naQhNBL2Th6lONjoRykC7Uc3yEqAeUVa955
	 nL5IwuV/PUHOmjS1kz3uYpbTLCiXzBpzC6/IuO1hn+DpioRMqA1ee5Cxzp3+UHywaf
	 qDdVDfqJn6XZw==
Date: Thu, 24 Oct 2024 15:14:31 -0600
From: "Gustavo A. R. Silva" <gustavoars@kernel.org>
To: Andrew Lunn <andrew+netdev@lunn.ch>,
	Johannes Berg <johannes@sipsolutions.net>,
	David Ahern <dsahern@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-hardening@vger.kernel.org, Kees Cook <kees@kernel.org>
Subject: [PATCH v2 4/4][next] uapi: net: Avoid -Wflex-array-member-not-at-end
 warnings
Message-ID: <cc80c778ce791f3f0a873b01aecb90934d6fd17a.1729802213.git.gustavoars@kernel.org>
References: <cover.1729802213.git.gustavoars@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1729802213.git.gustavoars@kernel.org>

-Wflex-array-member-not-at-end was introduced in GCC-14, and we are
getting ready to enable it, globally.

Address the following warnings by changing the type of the middle struct
members in a couple of composite structs, which are currently causing
trouble, from `struct sockaddr` to `struct __kernel_sockaddr_legacy` in 
UAPI, and `struct sockaddr_legacy` for the rest of the kernel code.

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
index a0de9a7331a2..43fd79f90a47 100644
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
+	unsigned long			rt_pad1;
+	struct __kernel_sockaddr_legacy	rt_dst;		/* target address		*/
+	struct __kernel_sockaddr_legacy	rt_gateway;	/* gateway addr (RTF_GATEWAY)	*/
+	struct __kernel_sockaddr_legacy	rt_genmask;	/* target network mask (IP)	*/
+	unsigned short			rt_flags;
+	short				rt_pad2;
+	unsigned long			rt_pad3;
+	void				*rt_pad4;
+	short				rt_metric;	/* +1 for binary compatibility!	*/
+	char __user			*rt_dev;	/* forcing the device at add	*/
+	unsigned long			rt_mtu;		/* per route MTU/Window		*/
 #ifndef __KERNEL__
-#define rt_mss	rt_mtu			/* Compatibility :-(            */
+#define rt_mss	rt_mtu					/* Compatibility :-(            */
 #endif
-	unsigned long	rt_window;	/* Window clamping 		*/
-	unsigned short	rt_irtt;	/* Initial RTT			*/
+	unsigned long			rt_window;	/* Window clamping		*/
+	unsigned short			rt_irtt;	/* Initial RTT			*/
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
index 8095e82de808..3beb52261b4b 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1019,7 +1019,7 @@ static int inet_compat_routing_ioctl(struct sock *sk, unsigned int cmd,
 	struct rtentry rt;
 
 	if (copy_from_user(&rt.rt_dst, &ur->rt_dst,
-			3 * sizeof(struct sockaddr)) ||
+			3 * sizeof(struct sockaddr_legacy)) ||
 	    get_user(rt.rt_flags, &ur->rt_flags) ||
 	    get_user(rt.rt_metric, &ur->rt_metric) ||
 	    get_user(rt.rt_mtu, &ur->rt_mtu) ||
diff --git a/net/ipv4/fib_frontend.c b/net/ipv4/fib_frontend.c
index 53bd26315df5..88c7a79946f2 100644
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


