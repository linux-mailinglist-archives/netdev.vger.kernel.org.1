Return-Path: <netdev+bounces-280695-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDWWLl716WmepQIAu9opvQ
	(envelope-from <netdev+bounces-280695-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BC38450C21
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 12:33:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2A74E3088E02
	for <lists+netdev@lfdr.de>; Thu, 23 Apr 2026 10:23:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F74366DB4;
	Thu, 23 Apr 2026 10:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="rwRTWEV4"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FB4028C2DD
	for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 10:23:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776939787; cv=none; b=PqAKp5lPVPmmgfW/2wc1kUHFNGe6AAwt8BtRho9KGibC+46THPfwx28nvbVrsfPxI8Apfz0j5i/ehGvwxLdyKnZdBf4qODnWk3kbaiMEOMKVL+IBvhybbia9vB/+lbcXzL0u2zftwdT9so9SSQ1aUyjear3OOlGVHg2b3T4EZoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776939787; c=relaxed/simple;
	bh=IlLi9LOjs7FiJQ/h5990TfATV4P8ErDYwbiY7hEJou8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZDSV9xnh4oa7t/UrfT9A/O+KvfRaYHt+9kdZx0azRcamThmsVMWeQ6f/te5WuiFk1xcv1sNuwhgt6aGFngSX8KqItyQvz3FCY+xI4E0WfGgxEZHj3RqYO5xKgPElzMuimig5FHykpTGejhf3iwvlTPnCZwDPcuzDZXgKgQcg5rM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=rwRTWEV4; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-2b24fcc2b5dso41130645ad.1
        for <netdev@vger.kernel.org>; Thu, 23 Apr 2026 03:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776939786; x=1777544586; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3MqLxiWkAIpoVEBx+no0kESZzbIyVFswBNUgIFYcPEU=;
        b=rwRTWEV4VAqMauYjEk0O1FrWpu/6d74YlqsmkuN7Rl1lDEP8yCGEMndDGtL5mIdJ5R
         BRAxYcY7k2TZkeG2SYkONWVnd1MbOeTg+pXjcq6184uM+1QNtcqd/BAT1XZeGftLRlpN
         ofENkYN+U7BvLxkW4U523q9F9VsrOP/xspu++a51mUAG9oFeGsUNmi9Hcr3w491dy30M
         YwipsHhk2ipcBorxH9MoDUVOE8M+cyfEk3E7XjfgCI0BDbVdpNRKC/VaYuURqJyy01wx
         gKDhROEnZwSlDrdxGmWRcVqb98nwX3IbhUyQ+XsUitbmI/r6Nt2Wk9XkfZXrTPWpP8EB
         qWUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776939786; x=1777544586;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3MqLxiWkAIpoVEBx+no0kESZzbIyVFswBNUgIFYcPEU=;
        b=kO0lm6IMc9K9neak+y8QGShXW5mX8XE8BGU6qn7UOSnFQS1XlBylY5xTX0Ardh1iHa
         SpDdjAUzU+3p43+ssdGUiaNjylsTytE6mOoHibN0J8DyS3cOjTPPq8jYNh0zNNjIrDmn
         2UVyoz4bx6wb9T/vHIOQVmSauLHeDMc5DTzWr0ePGkEQaA0ncwlsaJQP+s4YS7+m5HKp
         t4iuMeuuY1LEo23Hd8DjvM/ttmA6mP0Jt89ogZN1QvvW70CZozRgBYs2SFIfxuPVCHDd
         ME1sx9fSkfBZVUl8AEboEE3ndXRInK6tV4R0KHmclMa+K+UnbPlzoSJ9BCG4zENErJaU
         ImsA==
X-Gm-Message-State: AOJu0YxUHF/YAo9A8YXWJpjqYFP3gkPl13PhRmnE39SMW3UWnHRrKb6F
	B0JrbFAw3P6V2rWYGEE6RA+T6YKmnNnyWiPoWGxK9WbA7rlUdaB+gdLl
X-Gm-Gg: AeBDiesqMiHmz4yyCDGrTyCO0+MSMLO3BQvtRy4541HcogdFud+NrruNM/6EFd7UEgB
	m5Bbkbn2KvYgRhi9jYj759bsEc697+PjIF8AidElEmU6rCiYHCYDaKzMHBMIFc3HFxYpTM3Bbs1
	KGjFnzWZcB5yLr2/vSjp9hE/DQnYgKc4HV1ZAHAgsHez6/nzJkJ4LM4K6Xt47Tus6tx8LVlRfgT
	fY6Qws5JzmkruYYZZGbkjmrCalgbLks4P43tudX18D/OUmOOJ/Io6zacR5POr97DQb7/t0q8Psk
	WgUgrn5isP7wJ06j5ki6Ka3iKHz/Wh35fEdmT0TrnjL9IDR8HFDFI7h34n+PtoCy+oT8xqcLDH/
	wug+FY4dkvwtZYLa9xm6yxjWzQt1puHACAzrKFmyF4VN8gy/Xc2gwj7VMYadChtvJ0MXaRj8t17
	XFnt6oZ/0BJdg3S0VHOXA58/rNZPAYRv5CxogrtUyUdZCSRJEfS5Wz
X-Received: by 2002:a17:903:3c47:b0:2b0:afb4:7d41 with SMTP id d9443c01a7336-2b5f9ea4989mr270563355ad.10.1776939785677;
        Thu, 23 Apr 2026 03:23:05 -0700 (PDT)
Received: from teatimelab.tailcd024.ts.net ([148.135.103.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa174c3sm187226305ad.21.2026.04.23.03.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 03:23:05 -0700 (PDT)
From: Qi Tang <tpluszz77@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net v2] ipv6: validate extension header length before copying to cmsg
Date: Thu, 23 Apr 2026 18:22:55 +0800
Message-ID: <20260423102255.3752004-1-tpluszz77@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260419150344.624673-1-tpluszz77@gmail.com>
References: <20260419150344.624673-1-tpluszz77@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-280695-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tpluszz77@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1BC38450C21
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

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

Add ipv6_get_exthdr_len() which computes the extension header length
and validates it against skb_tail_pointer(skb), returning 0 on
failure.  Extension headers are kept in the linear skb area by
pskb_may_pull() during input, so skb_tail_pointer() is the correct
bound.

Use ipv6_get_exthdr_len() at all non-AH call sites: the five
standalone cmsg blocks (HbH, 2292HbH, 2292DSTOPTS x2, 2292RTHDR)
and the three standard cases in the extension-header walk loop
(DSTOPTS, ROUTING, default).  AH retains an inline bounds check
because its length formula differs ((ptr[1]+2)<<2).

When the walk loop detects a corrupted header, return from the
function instead of continuing to process later socket options.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
---
Changes v1 -> v2 (Paolo Abeni):
  - Factor repeated bounds-check + put_cmsg into ipv6_get_exthdr_len()
  - Return from the function on corrupted walk-loop entry instead of
    goto + empty label

v1: https://lore.kernel.org/netdev/20260419150344.624673-1-tpluszz77@gmail.com/

 net/ipv6/datagram.c | 46 +++++++++++++++++++++++++++++++++++++--------
 1 file changed, 38 insertions(+), 8 deletions(-)

diff --git a/net/ipv6/datagram.c b/net/ipv6/datagram.c
index 972bf0426d59..0a7b74d5f402 100644
--- a/net/ipv6/datagram.c
+++ b/net/ipv6/datagram.c
@@ -617,6 +617,13 @@ void ip6_datagram_recv_common_ctl(struct sock *sk, struct msghdr *msg,
 	}
 }
 
+static u16 ipv6_get_exthdr_len(const struct sk_buff *skb, const u8 *ptr)
+{
+	u16 len = (ptr[1] + 1) << 3;
+
+	return (ptr + len <= skb_tail_pointer(skb)) ? len : 0;
+}
+
 void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
 				    struct sk_buff *skb)
 {
@@ -643,7 +650,10 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
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
@@ -667,23 +677,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
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
 
@@ -705,19 +723,31 @@ void ip6_datagram_recv_specific_ctl(struct sock *sk, struct msghdr *msg,
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


