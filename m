Return-Path: <netdev+bounces-277035-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BnWA4W+12mdSQgAu9opvQ
	(envelope-from <netdev+bounces-277035-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:58:13 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E0343CC481
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 16:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 27E5E303DD6D
	for <lists+netdev@lfdr.de>; Thu,  9 Apr 2026 14:56:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011E339023C;
	Thu,  9 Apr 2026 14:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YPwyHUwg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987C53B584F
	for <netdev@vger.kernel.org>; Thu,  9 Apr 2026 14:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775746595; cv=none; b=dOUTTAQOtpKHuDMcRNfKAJpZOXGzKeMThJxiGDs0Ya2QCitrXYeiKcy87y/ebvJ14wOSki/Dwp6QY8ymZnHibGckU9PTs/dKhlTWDPqvrfYp2mpRaGQpQt8Zh8Qi35AeXPuh9WAo3LIV09O5ewWlCvShgzG0EG3HDn1jZDVHbSU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775746595; c=relaxed/simple;
	bh=lG4+CAA4kPiSksRGBrNHvzs7rdVVX8d4AtW01uh1WLs=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=jkHzHkS7yWDedoWuQ1ROsj1W0neC0T9fm7zPONSR0z0nZ/LD89iTLZuuv7hHaK22dHiCC3KNX79jLcK5uhxdGoPStT8+MHSFX5JN+A8P7yGWOcugzBAkrkZ0C/F4QjK9JTSS84AlMP+/C1PqssKGpRAu572mDDl5vXYisQoa8W0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YPwyHUwg; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cfcf23c0e1so184947585a.2
        for <netdev@vger.kernel.org>; Thu, 09 Apr 2026 07:56:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1775746594; x=1776351394; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uSaUmuiAYTgmW4wPAe8gQD7v1iqcpsuzJmxVkzVBO0w=;
        b=YPwyHUwg21w8Q6DptjoELN/xvUBuKyn3nfxALhr8h8UqwlNRJ0DtEDv6cYm+2iWsJC
         ctLnowfsmUP115i9NpFaMnMiPxB18W2cGogmOj1FqPmoplt676TeKArAFcWbw/nbX1Oo
         NpXIXp45T0ztK5Kr3MFHhhCCy0jqlMLMALS7C6xQBbw8eMACJYI59u8sVw05KrtV4UCR
         w+eh1btLBTNTjPnSO8xulLW7LniRwJmV8V5SZJvnQg/qNKlT3E/tS32YldYe7H8K3zf7
         J0ItO1sXMITEtBaMUyebH2UChjsaVjl6LaQv+3PRREWlbh1Zy3CQbYhOlaZ2XtI3Jzyk
         ffGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775746594; x=1776351394;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uSaUmuiAYTgmW4wPAe8gQD7v1iqcpsuzJmxVkzVBO0w=;
        b=eUX8G2v2gdn3DaUVWBZk573SQoGBWNmO1GJ50q50+YADm/upjRXih92CPtWF+OfyR9
         zOFIwOsnJ9pa/PbiD52Qp80tJW2nOpDiLE9ZrLMNhWrGhR5Ds3eX6Hk+UijWVkw6JPpS
         +LknILgORA3G6uiiJUYkwAGeWVbm0QpGgMzpe3WFIg8zO4eMI384QVPCdANKuoOW2UxU
         gpgF5B1eihcdyPF5Uaz5Rl6UxM3iw2Ish5REO/UYKXKpCylBVJUqzhgzeVj06pAXDpKV
         f9gIAFJ45GtiqB4lkgLcPrU8UfREEiMqizaLP2p4SiPeDth+2+VnwHMywNz9a7DrvS86
         ffhw==
X-Forwarded-Encrypted: i=1; AJvYcCW2wWlAk7IZN+TB0YK24K4n1kaDRwSPt4K2g160tFaskVG+ppUORe5uZXNXNHtqjdEJ9/5CGCg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwszHbbGdJLpXxQRRSPH8aL5j9bA4iE1b7a56CEG4UmyJxaV/f0
	49mm+tUIjS3eWLc6gChdLmWg3bJ2poIzj/N9N0RfFdQW5BZTtiGLwOYJSP1TG472hAyxFKjOSu3
	2qo/tfBhUihlQpw==
X-Received: from qkmg18.prod.google.com ([2002:ae9:e112:0:b0:8cd:7d21:ea78])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:489b:b0:8cd:972d:335 with SMTP id af79cd13be357-8d41d954f94mr3462012985a.43.1775746593373;
 Thu, 09 Apr 2026 07:56:33 -0700 (PDT)
Date: Thu,  9 Apr 2026 14:56:23 +0000
In-Reply-To: <20260409145625.2306224-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260409145625.2306224-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.1213.gd9a14994de-goog
Message-ID: <20260409145625.2306224-5-edumazet@google.com>
Subject: [PATCH net-next 4/5] tcp: change tcp_filter() to return the reason by value
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-277035-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7E0343CC481
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

sk_filter_trim_cap() will soon return the reason by value,
do the same for tcp_filter().

Note:

tcp_filter() is no longer inlined. Following patch will inline it again.

$ scripts/bloat-o-meter -t vmlinux.4 vmlinux.5
add/remove: 2/0 grow/shrink: 0/2 up/down: 186/-43 (143)
Function                                     old     new   delta
tcp_filter                                     -     154    +154
__pfx_tcp_filter                               -      32     +32
tcp_v4_rcv                                  3152    3143      -9
tcp_v6_rcv                                  3169    3135     -34
Total: Before=29722640, After=29722783, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/net/tcp.h   | 8 +++++---
 net/ipv4/tcp_ipv4.c | 6 ++++--
 net/ipv6/tcp_ipv6.c | 6 ++++--
 3 files changed, 13 insertions(+), 7 deletions(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 6156d1d068e142f696ec9dfff63e3aaebb0171bc..098e52269a04cb8938812a8f43caf11f9d5c68a3 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1683,12 +1683,14 @@ static inline bool tcp_checksum_complete(struct sk_buff *skb)
 bool tcp_add_backlog(struct sock *sk, struct sk_buff *skb,
 		     enum skb_drop_reason *reason);
 
-static inline int tcp_filter(struct sock *sk, struct sk_buff *skb,
-			     enum skb_drop_reason *reason)
+static inline enum skb_drop_reason
+tcp_filter(struct sock *sk, struct sk_buff *skb)
 {
 	const struct tcphdr *th = (const struct tcphdr *)skb->data;
+	enum skb_drop_reason reason;
 
-	return sk_filter_trim_cap(sk, skb, __tcp_hdrlen(th), reason);
+	sk_filter_trim_cap(sk, skb, __tcp_hdrlen(th), &reason);
+	return reason;
 }
 
 void tcp_set_state(struct sock *sk, int state);
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 69ab236072e7142d5ca9d0703d99f02c1e17c738..e2da3246a641e24328985cf558c322211df02b84 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -2164,7 +2164,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 		}
 		refcounted = true;
 		nsk = NULL;
-		if (!tcp_filter(sk, skb, &drop_reason)) {
+		drop_reason = tcp_filter(sk, skb);
+		if (!drop_reason) {
 			th = (const struct tcphdr *)skb->data;
 			iph = ip_hdr(skb);
 			tcp_v4_fill_cb(skb, iph, th);
@@ -2225,7 +2226,8 @@ int tcp_v4_rcv(struct sk_buff *skb)
 
 	nf_reset_ct(skb);
 
-	if (tcp_filter(sk, skb, &drop_reason))
+	drop_reason = tcp_filter(sk, skb);
+	if (drop_reason)
 		goto discard_and_relse;
 
 	th = (const struct tcphdr *)skb->data;
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 8dc3874e8b9252da60f21ad77a5ca834532e650a..d64d28e9842f7db69389034ac2ecdc76f405d379 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -1794,7 +1794,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 		}
 		refcounted = true;
 		nsk = NULL;
-		if (!tcp_filter(sk, skb, &drop_reason)) {
+		drop_reason = tcp_filter(sk, skb);
+		if (!drop_reason) {
 			th = (const struct tcphdr *)skb->data;
 			hdr = ipv6_hdr(skb);
 			tcp_v6_fill_cb(skb, hdr, th);
@@ -1855,7 +1856,8 @@ INDIRECT_CALLABLE_SCOPE int tcp_v6_rcv(struct sk_buff *skb)
 
 	nf_reset_ct(skb);
 
-	if (tcp_filter(sk, skb, &drop_reason))
+	drop_reason = tcp_filter(sk, skb);
+	if (drop_reason)
 		goto discard_and_relse;
 
 	th = (const struct tcphdr *)skb->data;
-- 
2.53.0.1213.gd9a14994de-goog


