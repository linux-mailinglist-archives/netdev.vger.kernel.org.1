Return-Path: <netdev+bounces-258899-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4KE1L6Apk2kI2AEAu9opvQ
	(envelope-from <netdev+bounces-258899-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:28:48 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A2CE6144AA1
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 15:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A96CB300824E
	for <lists+netdev@lfdr.de>; Mon, 16 Feb 2026 14:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68A09310774;
	Mon, 16 Feb 2026 14:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JKErVwHY"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13F053112BC
	for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 14:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771252125; cv=none; b=EeBHgTlD9bssWzNRKQGIm8aK8VVJ0K2TeBNlCBYwObJhzo8kWykUJF+paBi7M+hcI7WLYGRfm1Bk+QM1wDN0QVwsLIu4q3HW4up1YkmZG+u1kQrUhfUl8kRRQbyfc6f3y14HRYA/tPvNgSkRKnobXECxtwuxnjjxA8EXjEjCrzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771252125; c=relaxed/simple;
	bh=cYg9oGM9M9PPw6Ds3AMCWiv7eBZ5h1Ugbg8UUUm45tE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=k8VHtw0nn9Z+mJtk0HTVCO6SufKx9YFzKKB0w47jWvk+nTOw+fn8CvRcXMz0NYAuBNnP6wnW7RzCsMLhRTrkTpHHOhCiRhPk+4cBXaPqAdwSCGFKSaPmyAvIf8RY3BooI/VoSXwHs2lmzas3VPG8yLGZ0qly7du6VRhqi81UANs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JKErVwHY; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-797a47ee354so41089847b3.1
        for <netdev@vger.kernel.org>; Mon, 16 Feb 2026 06:28:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771252123; x=1771856923; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=lcVh1dn4lH+XFgy2aWFDh/Ta/CqUiXLWNssPFQD/xu4=;
        b=JKErVwHYlRu6c7FQ0RPZEZvgm+jSkSLwvrNPziz01Yj4XBzY1GmBSk2LBXY9ft6505
         rw4DJeancsM9FXc2GKf2J62AHcL+VAlGeopPM7cAlAtJ9xqmviaBhfjE9K13jQcLDfXQ
         eX0HiRkkKWk1K4q90e8M5egWMqcPKY4FtCBk/lIdt0QwhrBJfXcgfju4BSGZe0QAOWge
         apKkrEt6uGmVGG6KSzwWCYJqfCiz+nU5bbvFxpnEb0AzDcBWvjt75+dMI5aqVNQB7ZD4
         IGiKmZXNCggaod3pkrTtDT2L2R3wWz74tsGU4o+tusq0ax5y3MsiVPLqBUhLIL0oSfyz
         8Ebg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771252123; x=1771856923;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lcVh1dn4lH+XFgy2aWFDh/Ta/CqUiXLWNssPFQD/xu4=;
        b=LwirCaAijHPbTR9b317rn5XJaWjz/e0q03V4wJQpqZ6xd693gm8kSSjPCZA2Ll6N9r
         gA6QSg5m7Hrtu6tWj4M80yLM8sEMhJ1BaOmiGL3rFQloX3KkwRKthFMRKZEMJpGlZG2u
         sJy7uQ2SAQKpWhPpQJE3yPW7DzD7rN2kIQLBHArgOCOyfXtoN4s14DBbFMuRJTUGQUmf
         7+VtOW+dqLA/755MXXWdhW0Wbpvb0cHV7je8f7Ole3Us/KEIdXw3oqbEZaNIQWrsejb5
         p3SstJNmBVwzBifRFQAa8VjM5XJuDulmFivSdsR8zCxKapBVEVrSWlSLvwOuqxH5MNyr
         D+rQ==
X-Forwarded-Encrypted: i=1; AJvYcCW5BKxZqDvb9sRn8dYMsbKI0ZW4Vow+TlwqflDGBfH+knfBjTX0JrTaW4s1NHkCWFsFhmdQgh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxKxI0lnYXg5eXBUjUqpAIZUfTRkQXH+YeNrGACF4/6lPIpsRu+
	Isp1ddAsOQvUckz274D6b+j+5CFNhrpe2w2LBr/U+bq+xWros4xqUmoJmia+cTewsu2YrRZlsur
	sVV0PdIMfxUKJnA==
X-Received: from ywbdc21.prod.google.com ([2002:a05:690c:f15:b0:797:d3c9:d45f])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690c:c510:b0:796:3917:72ab with SMTP id 00721157ae682-797ac654e25mr55575407b3.61.1771252122905;
 Mon, 16 Feb 2026 06:28:42 -0800 (PST)
Date: Mon, 16 Feb 2026 14:28:30 +0000
In-Reply-To: <20260216142832.3834174-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260216142832.3834174-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.310.g728cabbaf7-goog
Message-ID: <20260216142832.3834174-4-edumazet@google.com>
Subject: [PATCH v2 net 3/5] ipv6: icmp: remove obsolete code in icmpv6_xrlim_allow()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	Martin KaFai Lau <martin.lau@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-258899-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[11];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A2CE6144AA1
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
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
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


