Return-Path: <netdev+bounces-257306-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AM65E1EJhWmj7gMAu9opvQ
	(envelope-from <netdev+bounces-257306-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:19:13 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E5216F78CF
	for <lists+netdev@lfdr.de>; Thu, 05 Feb 2026 22:19:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 539F43003346
	for <lists+netdev@lfdr.de>; Thu,  5 Feb 2026 21:19:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D2B632AAC7;
	Thu,  5 Feb 2026 21:19:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cIZ8XITM"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E381F5858
	for <netdev@vger.kernel.org>; Thu,  5 Feb 2026 21:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770326351; cv=none; b=HQuvZ5KO+OoDPAswYIMa7D2XItHnyReR2zd6ce6AU3yuTU6RiRucn72dw4Hmv4Rny9c4hLnYCn9sFzwFa6Tp7jZAhIWjd4StRciIg2gfOYN4MLjQoVCuiETpwXU9lvzArLK4WVnaidrVaZ4UvChMAg3rCEn/eurCkPtyEkH9wdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770326351; c=relaxed/simple;
	bh=J2ko4X9z2DZJzYwQDhffd5vnVXbKe1+M1QXJED1b8PE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ODIF7DUHlDWz5sJZWMUTWhXiGfnQy5HJ1alSSyzBsgplBenY7Xs/FgxgDbiITaIWhJcbzcYt7r+ynVN8qUU5LwEUxln5Nj9WI/2Pq7JJIyZa5TEdD9XVHgkJiVPdd3JMPNRLSufXn77I0EpNNy0Jseqo+VGxUykierX4fCepqxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cIZ8XITM; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c70ab7f67fso566856885a.3
        for <netdev@vger.kernel.org>; Thu, 05 Feb 2026 13:19:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770326350; x=1770931150; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7myZG3j2CU7LaFpg4p0P2j0Ms0MQemPHTxkEePH7mSM=;
        b=cIZ8XITMukmzC4dOws6GoA0Zy71DrahOb95kuSjp17qm6PZWebTztxqZ1iKbEHnY5I
         FPE13G89pO+Pfx2NYBbHpsGh/+/VOXZ2R4s1zSuTZQQF/RKfkSagTPOvHlYaZw1+s/pa
         u7m+3uSX/dcVoYyaxv/RGp9s0h7cysirH8RbfYXTz5c0efyBFv8zWTnu9GXg+p6OgZCU
         XvgloKqSvg4wfxmQ5btfzP2R577P82z028pbDTO5ssey5YVarzYyVP28cHFqTd9lqLj1
         yk6ciAX98khyDBIbuQHG3eoxO9SVsu76Ly8dJloPZWrW4gSXRSVtXaTD7vpEHBsUXjIf
         2NJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770326350; x=1770931150;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7myZG3j2CU7LaFpg4p0P2j0Ms0MQemPHTxkEePH7mSM=;
        b=U5aMZ8qzgA9EvvPTyHqfqvyapoOsSeDLejs7hlqLQeT7rogHN6PhvUTvGX5KznMMeJ
         EcoaVELknhpGxjBp+c8oYa5O9Hgu+ZY0rZiOU7WZzCfhv8e21RJdKw4FR6PvMVWMFuRK
         HyyLDxKa1ADsu3HNu4lVwewzei/JTgMBn+QDn7Spue2uZ1I36Qx6DevuqvZ/lQmcKgaj
         tHIYPTn+Ftp/nhx15bgLmpAlsiU0YpGG35vh3k8s/mAc1+oY+aRjbjgj1f1b5yXmR57F
         CJhDUaWr7CjPNUqFgy0u5gYgALabTtoDsvvp+Kz7NI8GAKMtZqVNVY/iNXjpk0kolezD
         QyHQ==
X-Forwarded-Encrypted: i=1; AJvYcCU5E2kWCeKmcowQhVowThJZ4fzmCsOendQDYno74o2WLW7GbbSJSKnebmpIdHT1bELX3JSN2kk=@vger.kernel.org
X-Gm-Message-State: AOJu0YwyxoLnQjT2YjrQE0UykRvZGqkiJT8q68TKffr87UgGH8xUVcm7
	FfPH2tiSOmviTAUsa98/30ctTX1pRCSFV9rYCFjgh+vxh19uR7WM+aBr7eyIAE3DziY5VdphatM
	Bsukf/D2AUPovWg==
X-Received: from qkbbl7.prod.google.com ([2002:a05:620a:1a87:b0:8b2:e8b8:3d8a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:3942:b0:8ca:4438:b8ef with SMTP id af79cd13be357-8caf16ec4f4mr66153085a.69.1770326349893;
 Thu, 05 Feb 2026 13:19:09 -0800 (PST)
Date: Thu,  5 Feb 2026 21:19:09 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260205211909.4115285-1-edumazet@google.com>
Subject: [PATCH net-next] ipv6: do not use skb_header_pointer() in icmpv6_filter()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257306-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: E5216F78CF
X-Rspamd-Action: no action

Prefer pskb_may_pull() to avoid a stack canary in raw6_local_deliver().

Note: skb->head can change, hence we reload ip6h pointer in
ipv6_raw_deliver()

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 0/1 up/down: 0/-86 (-86)
Function                                     old     new   delta
raw6_local_deliver                           780     694     -86
Total: Before=24889784, After=24889698, chg -0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/raw.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/net/ipv6/raw.c b/net/ipv6/raw.c
index ee6beba03e9b498c8ea5b9e5834e26251f81e958..27a2680591684eb2cad011e63cdaf396e79c0d77 100644
--- a/net/ipv6/raw.c
+++ b/net/ipv6/raw.c
@@ -90,23 +90,24 @@ EXPORT_SYMBOL_GPL(raw_v6_match);
  *	0 - deliver
  *	1 - block
  */
-static int icmpv6_filter(const struct sock *sk, const struct sk_buff *skb)
+static int icmpv6_filter(const struct sock *sk, struct sk_buff *skb)
 {
-	struct icmp6hdr _hdr;
 	const struct icmp6hdr *hdr;
+	const __u32 *data;
+	unsigned int type;
 
 	/* We require only the four bytes of the ICMPv6 header, not any
 	 * additional bytes of message body in "struct icmp6hdr".
 	 */
-	hdr = skb_header_pointer(skb, skb_transport_offset(skb),
-				 ICMPV6_HDRLEN, &_hdr);
-	if (hdr) {
-		const __u32 *data = &raw6_sk(sk)->filter.data[0];
-		unsigned int type = hdr->icmp6_type;
+	if (!pskb_may_pull(skb, ICMPV6_HDRLEN))
+		return 1;
 
-		return (data[type >> 5] & (1U << (type & 31))) != 0;
-	}
-	return 1;
+	hdr = (struct icmp6hdr *)skb->data;
+	type = hdr->icmp6_type;
+
+	data = &raw6_sk(sk)->filter.data[0];
+
+	return (data[type >> 5] & (1U << (type & 31))) != 0;
 }
 
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
@@ -141,15 +142,13 @@ EXPORT_SYMBOL(rawv6_mh_filter_unregister);
 static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 {
 	struct net *net = dev_net(skb->dev);
-	const struct in6_addr *saddr;
-	const struct in6_addr *daddr;
+	const struct ipv6hdr *ip6h;
 	struct hlist_head *hlist;
-	struct sock *sk;
 	bool delivered = false;
+	struct sock *sk;
 	__u8 hash;
 
-	saddr = &ipv6_hdr(skb)->saddr;
-	daddr = saddr + 1;
+	ip6h = ipv6_hdr(skb);
 
 	hash = raw_hashfunc(net, nexthdr);
 	hlist = &raw_v6_hashinfo.ht[hash];
@@ -157,7 +156,7 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 	sk_for_each_rcu(sk, hlist) {
 		int filtered;
 
-		if (!raw_v6_match(net, sk, nexthdr, daddr, saddr,
+		if (!raw_v6_match(net, sk, nexthdr, &ip6h->daddr, &ip6h->saddr,
 				  inet6_iif(skb), inet6_sdif(skb)))
 			continue;
 
@@ -171,6 +170,7 @@ static bool ipv6_raw_deliver(struct sk_buff *skb, int nexthdr)
 		switch (nexthdr) {
 		case IPPROTO_ICMPV6:
 			filtered = icmpv6_filter(sk, skb);
+			ip6h = ipv6_hdr(skb);
 			break;
 
 #if IS_ENABLED(CONFIG_IPV6_MIP6)
-- 
2.53.0.rc2.204.g2597b5adb4-goog


