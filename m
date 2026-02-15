Return-Path: <netdev+bounces-258776-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oNdNOpTakWlpnQEAu9opvQ
	(envelope-from <netdev+bounces-258776-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:16 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7826913EE12
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 15:39:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 875A0301DAE8
	for <lists+netdev@lfdr.de>; Sun, 15 Feb 2026 14:38:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 637C42DF13B;
	Sun, 15 Feb 2026 14:38:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MA6ZjF+D"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1443A2EB840
	for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 14:38:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771166311; cv=none; b=O8D58Uy5RgXdUYgKALR7RA3yDOEfL1Vp2myjUAJ0yC82ZuIccklrT4tDxkUZUx2oGKocI7zQhYMlCce+c15biL10KRyUlQ3eC52GB0icr1+FAn7fgEM1wZjH/shyjRPyVXOCMKY7Y/W1qnGgtL0AoWkVvMXKAdUbbhYcA8xTh0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771166311; c=relaxed/simple;
	bh=6ijWXrXfqS//1sS3WMCrBKNewjb0J/Yupo7S4GISYEI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jdDVqd79kXsZS7FYgBCiDPP91XsvjWRr+S8i2vPYRQobOMNjY4FghHjpj1fn6SvcSVlz5mfoZI3dpNhHcV2s/clnLckWuiMWIihPhSUnLJowWvjEL95v12PX6AKRdinViWAPXZOQcHupe07zlcV1gXdXuu07iDiGAEDewdHqCII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MA6ZjF+D; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cb4e37a796so688880185a.2
        for <netdev@vger.kernel.org>; Sun, 15 Feb 2026 06:38:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771166309; x=1771771109; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=d62hv78RuB1hSsJrj6HRCW8/kJsvk2Yyoh5UAMN1Tpg=;
        b=MA6ZjF+DSYIqrW5tWQayID4hMVQndvskEAjahGW4xY08N9B0rZtLulthVTs7XfcF5a
         JA5WR/ctD0e0qwsBiP3qMx4Hfbga5k8zpamku1aayJ52Pd03l/xNdgJ5McayKBM37XJt
         imGV0dhEvzhW3I6C6lN3iE2/TlDDancg1JKlzMjG8fFo9N1oeZfd71yIS3ujhoFfMpZb
         yrHu4MrIqOGO2G6m89jxP0EqpCXXvLuYRaHIF6lQ6xmTW62u+Ep0K4e1g/6SOVouT3hU
         J2+mDpXXNzabULMEZuVO3ph0gfVVXWblw2hzd62DPGWgoRLR0AmmyKeICIAaiNvHnJcW
         T8Rg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771166309; x=1771771109;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=d62hv78RuB1hSsJrj6HRCW8/kJsvk2Yyoh5UAMN1Tpg=;
        b=ZGv5Qz45uvGBs8XngwRqdTPWV6Stb9hii6Z/tsPRQQRfCBQ6fBMNdkTImwMBVzOlyT
         K5cMn9fZOTIbHue96kyAvdJtid/Gy1PZ1l9rGVUp2dBhY1JV2dIuJulbcuUt5R6zvBuj
         eGyU5In7U+uskMMzlgG/2EfjRSnweoQUn1t75vyaM1R7NhohZi1TAqMbbYQbWGcfNns0
         tybNhaL5VewGxl40VLctFd8HvIP8HPEBrSnryRAIpNOqWjkJIPf0OZjqbLbkOcm7GqU0
         AmBGkkih+iUNz0iI9f8xdlr82HRiud8Ua0GxMDyPpfEh6xB/r/kZe/fOb9LUwuQKpX53
         ZBhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUrVq8QFObL1u2DJxqqECDfe7RZjt9cw0l4h9QHHMnfO1thShbl2/6AsHjtgfqNPCM9Y8M8hEk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwGsZ+5T5n52n9GoMkGfZFo/7vm8kRW3U/NKMCJR11jWpp3aMhr
	tqgRHVavvjHTIUQoERn4lWSpF2v/HqK7tXuuVV9L3z5g4NXFXpEEZZctEnb1rnZRJHx+/Wo/Fgt
	Mx9WJB6zxOzW5gA==
X-Received: from qknpi15.prod.google.com ([2002:a05:620a:378f:b0:8c5:2e20:48c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4629:b0:8c6:ec8f:c8a1 with SMTP id af79cd13be357-8cb4245feccmr921139485a.44.1771166308760;
 Sun, 15 Feb 2026 06:38:28 -0800 (PST)
Date: Sun, 15 Feb 2026 14:38:19 +0000
In-Reply-To: <20260215143821.2330791-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260215143821.2330791-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260215143821.2330791-4-edumazet@google.com>
Subject: [PATCH net 3/5] ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Willem de Bruijn <willemb@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, 
	Martin KaFai Lau <martin.lau@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-258776-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 7826913EE12
X-Rspamd-Action: no action

Following part was needed before the blamed commit, because
inet_getpeer_v6() second argument was the prefix.

	/* Give more bandwidth to wider prefixes. */
	if (rt->rt6i_dst.plen < 128)
		tmo >>= ((128 - rt->rt6i_dst.plen)>>5);

Now inet_getpeer_v6() retrieves hosts, we need to remove
@tmo adjustement or wider prefixes likes /24 allow 8x
more ICMP to be sent for a given ratelimit.

As we had this issue for a while, this patch changes net.ipv6.icmp.ratelimit
default value from 1000ms to 100ms to avoid potential regressions.

Also add a READ_ONCE() when reading net->ipv6.sysctl.icmpv6_time.

Fixes: fd0273d7939f ("ipv6: Remove external dependency on rt6i_dst and rt6i_src")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Cc: Martin KaFai Lau <martin.lau@kernel.org>
---
 Documentation/networking/ip-sysctl.rst | 7 ++++---
 net/ipv6/af_inet6.c                    | 2 +-
 net/ipv6/icmp.c                        | 7 +------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/Documentation/networking/ip-sysctl.rst b/Documentation/networking/ip-sysctl.rst
index 28c7e4f5ecf9e6b7519659e4e3eee7da508ded29..6921d8594b8493a25d62ffd586d0b9f6527409cb 100644
--- a/Documentation/networking/ip-sysctl.rst
+++ b/Documentation/networking/ip-sysctl.rst
@@ -3234,12 +3234,13 @@ enhanced_dad - BOOLEAN
 ===========
 
 ratelimit - INTEGER
-	Limit the maximal rates for sending ICMPv6 messages.
+	Limit the maximal rates for sending ICMPv6 messages to a particular
+	peer.
 
 	0 to disable any limiting,
-	otherwise the minimal space between responses in milliseconds.
+	otherwise the space between responses in milliseconds.
 
-	Default: 1000
+	Default: 100
 
 ratemask - list of comma separated ranges
 	For ICMPv6 message types matching the ranges in the ratemask, limit
diff --git a/net/ipv6/af_inet6.c b/net/ipv6/af_inet6.c
index 31ba677d0442a861fc87e163b43a0aa1df88d8d4..69be0a67a14009771b8662328fff9de7bb98101b 100644
--- a/net/ipv6/af_inet6.c
+++ b/net/ipv6/af_inet6.c
@@ -952,7 +952,7 @@ static int __net_init inet6_net_init(struct net *net)
 	int err = 0;
 
 	net->ipv6.sysctl.bindv6only = 0;
-	net->ipv6.sysctl.icmpv6_time = 1*HZ;
+	net->ipv6.sysctl.icmpv6_time = HZ / 10;
 	net->ipv6.sysctl.icmpv6_echo_ignore_all = 0;
 	net->ipv6.sysctl.icmpv6_echo_ignore_multicast = 0;
 	net->ipv6.sysctl.icmpv6_echo_ignore_anycast = 0;
diff --git a/net/ipv6/icmp.c b/net/ipv6/icmp.c
index 375ecd779fda5e323841c3d664ded6aadd653dfd..0f41ca6f3d83e86ce97ce5a30613f58f4dc22dad 100644
--- a/net/ipv6/icmp.c
+++ b/net/ipv6/icmp.c
@@ -217,14 +217,9 @@ static bool icmpv6_xrlim_allow(struct sock *sk, u8 type,
 	} else if (dev && (dev->flags & IFF_LOOPBACK)) {
 		res = true;
 	} else {
-		struct rt6_info *rt = dst_rt6_info(dst);
-		int tmo = net->ipv6.sysctl.icmpv6_time;
+		int tmo = READ_ONCE(net->ipv6.sysctl.icmpv6_time);
 		struct inet_peer *peer;
 
-		/* Give more bandwidth to wider prefixes. */
-		if (rt->rt6i_dst.plen < 128)
-			tmo >>= ((128 - rt->rt6i_dst.plen)>>5);
-
 		peer = inet_getpeer_v6(net->ipv6.peers, &fl6->daddr);
 		res = inet_peer_xrlim_allow(peer, tmo);
 	}
-- 
2.53.0.310.g728cabbaf7-goog


