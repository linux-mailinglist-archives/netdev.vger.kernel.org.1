Return-Path: <netdev+bounces-251311-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B4F9FD3B928
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 22:13:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 742B4305F83D
	for <lists+netdev@lfdr.de>; Mon, 19 Jan 2026 21:12:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB3E5296BBF;
	Mon, 19 Jan 2026 21:12:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="TXdJ4g8y"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com [74.125.82.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91F092EA47C
	for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 21:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768857175; cv=none; b=SKBzN5JDG7bTxBdarpoGlLIzrD1jmIR5v7MGo+BtaRiL2bAzthnHfikPYlY7TzhB8Xgn788OIXEEj5RuzfNbcIw2Nh252Dl47Rkh3LkQdU6n5U5G1mZahcGll2zonTI40gGhuC7SRavhhmDU0aS5RM5cSeE0bOsS5pkGOfqjCAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768857175; c=relaxed/simple;
	bh=PSuODDHvT2Zsv8gqUfVoORui5QbVXVyyCSTIOoG5Rcc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JQa7cvg+gLEqlvEJgzjBwIfKPIqCK+7BPyi6W6q47R9VgJmjohZMQuQIjzj4x2T3fCVV8223ugtfNk+E14949JCg54Y/bsA/h7P8c5x6yBCz1iac8MQMrPr1pJQV/BGxvGvtWSu8k8KOZXttQzh0KVTWNyCCKHPKa4Hc5T+ZT1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=TXdJ4g8y; arc=none smtp.client-ip=74.125.82.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f175.google.com with SMTP id 5a478bee46e88-2ad70765db9so4962860eec.1
        for <netdev@vger.kernel.org>; Mon, 19 Jan 2026 13:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1768857174; x=1769461974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oD0sSvT/HdtRWqvc5jR48ncmfqM0sJr9NZ9n/O3DtpA=;
        b=TXdJ4g8yJL+LHGx8OYV61aeGaTlsPZcAM8fpm9q0ryXdX+gAZSjqcIG6YMkImwBPKZ
         hRAMtplrYkaeCYfWRnC9f3T1Z5kvTb0Dwv7r0qI23ft38sWwK6LAYV7C1/q+R+8IXH6B
         ILpznPPKUTS3q37zW8LpJafwD/UCV74uN3yM7bNyzL56BBCW7dv5PERUQhQe7dBUY2iI
         Ab1CS4M/Er8zKAaxAZdDD3YV5U/u4pCC6LtBUAzOKSoubuWbKZoBk7LoGaEfIzL2MEZp
         TH/QuUKYdydZVmYjjxuWwMNZVhxJ5bkRXUAepzTC1OpC3dn6IyalcRt+45RemffvM/Wp
         ++Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768857174; x=1769461974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=oD0sSvT/HdtRWqvc5jR48ncmfqM0sJr9NZ9n/O3DtpA=;
        b=wkViIateHRhxexdUK3i1xlO96sYHAZ0wJIxNBU4QfjvhSrd3wWqhBr9zeLJBPARpaM
         WrVdtOK7WCz7C8MPuOIEod2wUmqn3j4FZqDS1XWB4QCIOSQeRGS3679KB1IfIk8BvvXv
         Ds0WNgRmVxWNYcjfQU4wLmvLkXC17c80iosMUYgpErL1gGgknFsN5yoE3VPyfIk9RWtw
         Ib/5pXtStRNk0bjciNw9/hwt1ymRSZYM00Chs3Xq0jfIhUU8VE1Ivt8SfrGjaVspRu4b
         HpCvdj/9m/7N38XycGM3OzAN8ZNjbOPiws1+1yDtqjrd9lO7vcETQ0Jqt58nR6x1wDSs
         YyDQ==
X-Forwarded-Encrypted: i=1; AJvYcCWQPiTdi9VCLpK99Lg4joZBB0RwXCzMB/26KjisG1wj1Vl5G08c7+KMNgcaX19W5G+HdG+eM8Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyUW5IEfvSpqs+Zjfjm1dxCS52QsmzYqAmF1tu+yIpmUiyKeuKG
	WVHvgANfzy7ddOKICzJek5SwhJALnmyFPNnyL3e9KQab6SHSUQTFG0+hENxnDa4QKXp9W+6mHAq
	ynS0=
X-Gm-Gg: AZuq6aKv0nBuQyDEzgQ66Np/lUC7fo2Ec6bCLm0GkfBO/fJ4Sb04YtwlXck0iC+a1NA
	ybFrc9CzAG2Ls/6JVQj6JhgoEooc29t+owXG9qihOivIT0sFmOF1eJ9UoKWVpHIjv6c0LM4lxX2
	vpCDm4h1S0lxCbukxzBjH9IdaUgEnITnTLSrMeHRAleNNk8manIiZMWGtn82xXxJWcsUhHzgcav
	N1YzjFxQoWkWZkeIIuPbPkjkA1Xa+73UyKdYX6ikykvkYBjy2fhWql7QY7QeeRngZg5HnFASChH
	LMdio0o6nRFuQxBS2PxJ9VU6zEL5tSPd4KmqUBILKyTvrxbiSeAbtwN/fPGPjUIZcZiuR+WHXG/
	mJw6qqpYgqW7hoxE4ETmzMeb6FJf+wHvqMmFfl5RWM32KDDiqMTJpdOffDB78nOIewApmWc39qe
	IEm5JEzgQABqhXITFzHAlJSN9QulgsdZsVD09z0S3lMlKyskotQV4f49cE
X-Received: by 2002:a05:7300:f18f:b0:2ae:6118:dbce with SMTP id 5a478bee46e88-2b6b4e59a89mr7093827eec.10.1768857173664;
        Mon, 19 Jan 2026 13:12:53 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:850a:22d6:79cd:2abe])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b6b351e38bsm14348137eec.14.2026.01.19.13.12.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Jan 2026 13:12:53 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v3 3/7] ipv6: Cleanup IPv6 TLV definitions
Date: Mon, 19 Jan 2026 13:12:08 -0800
Message-ID: <20260119211212.55026-4-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260119211212.55026-1-tom@herbertland.com>
References: <20260119211212.55026-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move IPV6_TLV_TNL_ENCAP_LIMIT to uapi/linux/in6.h to be with the rest
of the TLV definitions. Label each of the TLV definitions as to whether
they are a Hop-by-Hop option, Destination option, or both.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 include/uapi/linux/in6.h        | 21 ++++++++++++++-------
 include/uapi/linux/ip6_tunnel.h |  1 -
 2 files changed, 14 insertions(+), 8 deletions(-)

diff --git a/include/uapi/linux/in6.h b/include/uapi/linux/in6.h
index 5a47339ef7d7..c2f873c98d20 100644
--- a/include/uapi/linux/in6.h
+++ b/include/uapi/linux/in6.h
@@ -140,14 +140,21 @@ struct in6_flowlabel_req {
 
 /*
  *	IPv6 TLV options.
+ *
+ *	Hop-by-Hop and Destination options share the same number space.
+ *	For each option below whether it is a Hop-by-Hop option or
+ *	a Destination option is indicated by HBH or DestOpt.
  */
-#define IPV6_TLV_PAD1		0
-#define IPV6_TLV_PADN		1
-#define IPV6_TLV_ROUTERALERT	5
-#define IPV6_TLV_CALIPSO	7	/* RFC 5570 */
-#define IPV6_TLV_IOAM		49	/* RFC 9486 */
-#define IPV6_TLV_JUMBO		194
-#define IPV6_TLV_HAO		201	/* home address option */
+#define IPV6_TLV_PAD1		0	/* HBH or DestOpt */
+#define IPV6_TLV_PADN		1	/* HBH or DestOpt */
+#define IPV6_TLV_ROUTERALERT	5	/* HBH */
+#define IPV6_TLV_TNL_ENCAP_LIMIT 4	/* RFC 2473, DestOpt */
+#define IPV6_TLV_CALIPSO	7	/* RFC 5570, HBH */
+#define IPV6_TLV_IOAM		49	/* RFC 9486, HBH or Destopt
+					 * IOAM sent and rcvd as HBH
+					 */
+#define IPV6_TLV_JUMBO		194	/* HBH */
+#define IPV6_TLV_HAO		201	/* home address option, DestOpt */
 
 /*
  *	IPV6 socket options
diff --git a/include/uapi/linux/ip6_tunnel.h b/include/uapi/linux/ip6_tunnel.h
index 85182a839d42..35af4d9c35fb 100644
--- a/include/uapi/linux/ip6_tunnel.h
+++ b/include/uapi/linux/ip6_tunnel.h
@@ -6,7 +6,6 @@
 #include <linux/if.h>		/* For IFNAMSIZ. */
 #include <linux/in6.h>		/* For struct in6_addr. */
 
-#define IPV6_TLV_TNL_ENCAP_LIMIT 4
 #define IPV6_DEFAULT_TNL_ENCAP_LIMIT 4
 
 /* don't add encapsulation limit if one isn't present in inner packet */
-- 
2.43.0


