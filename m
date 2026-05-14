Return-Path: <netdev+bounces-287798-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mO6TIXJIBWpDUAIAu9opvQ
	(envelope-from <netdev+bounces-287798-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:58:42 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id CD81C53D73F
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 05:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 19BE23028576
	for <lists+netdev@lfdr.de>; Thu, 14 May 2026 03:58:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4840F3A7F6E;
	Thu, 14 May 2026 03:58:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lS779JGr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94E73AB272
	for <netdev@vger.kernel.org>; Thu, 14 May 2026 03:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778731097; cv=none; b=DzN8xgz0nHOPOqd+Jg+jGzLEtCsUwKUvjhekrev0ArhepzuepLW+FLV/JXK6725rgv/nmg7mCGARZeS3NHt33f5SE2c0fcdKIdrafAzgMtEFHge8fR0K97GJL3D+eJjm4LwSYWXqf6pKJsX/VqD8iiIQHrOHnh+iotpDaZ4ouug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778731097; c=relaxed/simple;
	bh=coekK17fYyFQEYpGbo+Musnb6/dAiz5wpaxRkMrEsh8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Jt/zlsVlDKVEEnJoW6uwT4jb+57vcgTPdJDechxML7MxGJs+xj+bYekZkqM+eUqKc0X6TjTpL7E+3lOWRgtYbptkTUcUzsRa/IpL496YTVFse1lnk4oJh1EAbMCJ2mhOlx6BtCVO25gvXC7GzqXoJwGNOIjXRRwW88yxMSnIhKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lS779JGr; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-365e20fe3b8so4442100a91.3
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 20:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778731094; x=1779335894; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PUN0viP5wA0q6pOqmw8CcjVUtMwMQUNpWa64PqNzQKw=;
        b=lS779JGrd8JT6CEywhvWpHr+a99HSCgp8cLM4r4O/B9sd20fseIsPSmK7tCWKvXs8L
         cun2kbNccU92q6IpTmmlmfeWMq3V+fK/puj/YV60/QKvXPepONy3zJgyhYuZCY5xGHlr
         a0oVS6GlAXqCcCOrS7KPiB2IdUNycq6/MaNQWVm2I54+vbXR17RDj1vYizidv0XOQDZz
         tmr6Nx6j2viYQJ31icD5arxR09DysYXmFcTykaeEUm9CutnjdoOciHHSTGKS6ug9nEoL
         x3SpcuQf+mcgiIPhInK1X5g5Bzgl1AIJDORXJ1rOOIkofmrJN8grXAldQn4sXnqvvxNL
         6S+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778731094; x=1779335894;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUN0viP5wA0q6pOqmw8CcjVUtMwMQUNpWa64PqNzQKw=;
        b=KMZP9qw6IR381ALvMiuRADgHF0zNuntsJLA33fOJL3J+65fndn2SK8OYs2vVaP8TRg
         crBKyiqjlt3TM6BC7a4S0honYiYZOmEPEvUEmSwjGWGy+NtyT8GtOIrnY7vqcpIA+hy6
         8gCV9kSnl/L4SAwzEZRN2XPwEI28/HcYEAeG16w8YACXIH1V8o1EUnYHWIIsoVFg4d4a
         XFkrP07mLIWmRZO+X7t70PKK8BbEpD3y4Qy+8uHnmSk4IunaE9qmoo49wF1mIGkcabej
         UehxCGVll+jVVxuDHJ0Y6xX4QcfslFep5Ipm1VbBP2Bd5qnoamGQdnyN/xzR1oCPFQUT
         Sh7Q==
X-Gm-Message-State: AOJu0YzxTHUgO+2EoFcBIppk7Vv5f6kiTLJwI26KBhaMgwXC+w1bfPBq
	1LI0jvp866QT+K+MDb6esncyGmUrR3Zb2ymsFT7W0p+UQqftz4SoCwHZ
X-Gm-Gg: Acq92OF0kVeKAMNfwmkt6m+GZcT18VkCQxbMxs2bq0vhyOdnM9HjFHmnrDCm1A8PgnS
	jdEnSUcWg8kUDLk0mWGamjDjngNFd6hh6Bu8VBw+sFWtoU7ta4m3t4WNWtkCNcN+glSHEl8ORZS
	F+9oulDf57ditlIMC7ZzsCDtVEZ0xR8poKbpShe3D2ruC27ELD82IssxnJABE9XozJUhby3Uyir
	3nOox46e8djHlNEjXVc1P+qBspFdaHc7Q3LspFtES/igl34T1Hv9eDgzSbiQdF2ihn90QcDt816
	frMOTLxw5WEWFMq5NBWO7SrvEjxeLrYOXPiv5j9YNI4/hChepkb6gKQGMUUuYNYiKJRfYBckt9R
	u+fH+s+YwR30PnT9ds3+2hzW0/nMYKWoHBbTxoLSoVbZkrlbkecAd50k4RxnRt6f5VKQPJHq5qR
	Ja1Q59XnvchXwqZgC+2g0VzyY5gxetv9Sa+XLCP0T7sf6NTA1udvOE
X-Received: by 2002:a17:90b:4c85:b0:366:3517:1a95 with SMTP id 98e67ed59e1d1-368f2e34281mr6498633a91.0.1778731093910;
        Wed, 13 May 2026 20:58:13 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-368ee6280d0sm4680596a91.16.2026.05.13.20.58.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 20:58:13 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Qi Tang <tpluszz77@gmail.com>
Subject: [PATCH net v4] ipv6: validate extension header length before copying to cmsg
Date: Thu, 14 May 2026 11:58:02 +0800
Message-ID: <20260514035802.1540395-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD81C53D73F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-287798-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

ip6_datagram_recv_specific_ctl() builds IPV6_{HOPOPTS,DSTOPTS,RTHDR}
cmsgs (and their IPV6_2292* legacy counterparts) by trusting the
on-wire hdrlen byte (ptr[1]) when computing the put_cmsg() length.
The length was validated only at parse time (ipv6_parse_hopopts(),
etc.).  An nftables payload-write expression can rewrite hdrlen after
parsing and before the skb reaches recvmsg; the write itself is
in-bounds but put_cmsg() then reads up to ((hdrlen+1) << 3) = 2040
bytes from an 8-byte header.  nftables is reachable from an
unprivileged user namespace, so this is an unprivileged
slab-out-of-bounds read:

  BUG: KASAN: slab-out-of-bounds in put_cmsg+0x3ac/0x540
   put_cmsg+0x3ac/0x540
   udpv6_recvmsg+0xca0/0x1250
   sock_recvmsg+0xdf/0x190
   ____sys_recvmsg+0x1b1/0x620

Add ipv6_get_exthdr_len() which validates that at least two bytes
are accessible before reading the hdrlen field, then checks the
computed length against skb_tail_pointer(skb), returning 0 on
failure.  Extension headers are kept in the linear skb area by
pskb_may_pull() during input, so skb_tail_pointer() is the correct
bound.

Use ipv6_get_exthdr_len() at all non-AH call sites: the five
standalone cmsg blocks (HbH, 2292HbH, 2292DSTOPTS x2, 2292RTHDR)
and the three standard cases in the extension-header walk loop
(DSTOPTS, ROUTING, default).  AH retains an inline bounds check
because its length formula differs ((ptr[1]+2)<<2).

The walk loop also gets a pre-read bounds check at the top to
validate ptr before any case accesses ptr[0] or ptr[1].

When the walk loop detects a corrupted header, return from the
function instead of continuing to process later socket options.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
Changes v3 -> v4 (Paolo Abeni / Sashiko):
  - Validate ptr + 2 <= skb_tail_pointer(skb) before reading ptr[1]
    in ipv6_get_exthdr_len()
  - Add matching pre-read bounds check at the top of the walk loop

Changes v2 -> v3:
  - Resend as new thread (v2 was incorrectly sent as reply to v1)

Changes v1 -> v2 (Paolo Abeni):
  - Factor repeated bounds-check + put_cmsg into ipv6_get_exthdr_len()
  - Return from the function on corrupted walk-loop entry instead of
    goto + empty label

v3: https://lore.kernel.org/netdev/20260423103238.3987364-1-tpluszz77@gmail.com/
v2: https://lore.kernel.org/netdev/20260423102255.3752004-1-tpluszz77@gmail.com/
v1: https://lore.kernel.org/netdev/20260419150344.624673-1-tpluszz77@gmail.com/
 net/ipv6/datagram.c | 54 ++++++++++++++++++++++++++++++++++++++-------
 1 file changed, 46 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 972bf0426d599..f9ee1bf97f206 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -617,6 +617,18 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
 	}
 }
 
+static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
+{
+	u16 len;
+
+	if (ptr + 2 > skb_tail_pointer(skb))
+		return 0;
+
+	len = (ptr[1] + 1) << 3;
+
+	return (ptr + len <= skb_tail_pointer(skb)) ? len : 0;
+}
+
 void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 				    struct sk_buff *skb)
 {
@@ -643,7 +655,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	/* HbH is allowed only once */
 	if (np->rxopt.bits.hopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_HOPOPTS, len, ptr);
 	}
 
 	if (opt->lastopt &&
@@ -664,26 +679,37 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 			unsigned int len;
 			u8 *ptr = nh + off;
 
+			if (ptr + 2 > skb_tail_pointer(skb))
+				return;
+
 			switch (nexthdr) {
 			case IPPROTO_DSTOPTS:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.dstopts)
 					put_cmsg(msg, SOL_IPV6, IPV6_DSTOPTS, len, ptr);
 				break;
 			case IPPROTO_ROUTING:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				if (np->rxopt.bits.srcrt)
 					put_cmsg(msg, SOL_IPV6, IPV6_RTHDR, len, ptr);
 				break;
 			case IPPROTO_AH:
 				nexthdr = ptr[0];
 				len = (ptr[1] + 2) << 2;
+				if (ptr + len > skb_tail_pointer(skb))
+					return;
 				break;
 			default:
 				nexthdr = ptr[0];
-				len = (ptr[1] + 1) << 3;
+				len = ipv6_get_exthdr_len(skb, ptr);
+				if (!len)
+					return;
 				break;
 			}
 
@@ -705,19 +731,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 	}
 	if (np->rxopt.bits.ohopopts && (opt->flags & IP6SKB_HOPBYHOP)) {
 		u8 *ptr = nh + sizeof(struct ipv6hdr);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292HOPOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst0) {
 		u8 *ptr = nh + opt->dst0;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.osrcrt && opt->srcrt) {
 		struct ipv6_rt_hdr *rthdr = (struct ipv6_rt_hdr *)(nh + opt->srcrt);
-		put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, (rthdr->hdrlen+1) << 3, rthdr);
+		u16 len = ipv6_get_exthdr_len(skb, (u8 *)rthdr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292RTHDR, len, rthdr);
 	}
 	if (np->rxopt.bits.odstopts && opt->dst1) {
 		u8 *ptr = nh + opt->dst1;
-		put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, (ptr[1]+1)<<3, ptr);
+		u16 len = ipv6_get_exthdr_len(skb, ptr);
+
+		if (len)
+			put_cmsg(msg, SOL_IPV6, IPV6_2292DSTOPTS, len, ptr);
 	}
 	if (np->rxopt.bits.rxorigdstaddr) {
 		struct sockaddr_in6 sin6;
-- 
2.47.3


