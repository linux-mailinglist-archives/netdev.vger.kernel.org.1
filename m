Return-Path: <netdev+bounces-259901-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPleCApem2nyygMAu9opvQ
	(envelope-from <netdev+bounces-259901-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:50:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A75AC170382
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 20:50:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 558993009897
	for <lists+netdev@lfdr.de>; Sun, 22 Feb 2026 19:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA46B35C185;
	Sun, 22 Feb 2026 19:50:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0F5+1h9j"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f201.google.com (mail-pg1-f201.google.com [209.85.215.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A2EA35C182
	for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 19:50:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771789824; cv=none; b=PGfltjyJRgh66WAZ99C+AJ5iogegTAQb46a4qEB9CnCC00vXnoTxbwUYJQVhlpCRCOVsaS3TOwd6WnR61cuMxkpdaW4XKyp98uy5I8qqmwzOaejeebywM6QOjlRlHm2V02OJQSDGD3Ud2zVyyJDF2gaKa2vy60NqGzwOFXMckBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771789824; c=relaxed/simple;
	bh=bw7cHK5nN5bBdOVPzNIhQTQlFDdU4LLOBvhwHvy+Sek=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=l0yNrE7sZEm5v4DM1oMQ0ePTsoHDHC7K3k7F5jxOgf5DVLWAAn/hlbWwxJxC4BrWUpDoe5BH22HZcEL2EUMARZdiY++CAOhlq35xWQgAHypedSCcol7X/MhsygCh/9ofKVilhbP41WUauq2IgWMqnztOn4CrESSoBxcCTVY1pnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0F5+1h9j; arc=none smtp.client-ip=209.85.215.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pg1-f201.google.com with SMTP id 41be03b00d2f7-c6e1dab2235so2234698a12.3
        for <netdev@vger.kernel.org>; Sun, 22 Feb 2026 11:50:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771789823; x=1772394623; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=na4axJXt/cUr1mORRW5n0O7My4YPvC1XtbGZHus3pls=;
        b=0F5+1h9jqaupf4/Ej+8lqyw0Xh8xci6ZN2oePo38Y+pSsQbVYMOhlUo/l7YX80WsRA
         3FT/jTux45Jvx8J6JCvyNTGdfag89MgXNe3I3pgIp8NigwBXGtRCmcek9tcbSlNGwF5e
         OwIwER9v3iqpF+k1cwlYwl70BtcnxUSETtNMhBNW6tNFU5YBSl5yWVjIxI/W5cx4NMZx
         vrmJ+ssr0Gxtki14Wm491N835gZIG8FfPuPmNauRMaobC+FD0rZHwXA2lrIpqYYjiVug
         VMj80yO5CTQCghz2akQZ0AL4yI6lrZW39Ln+T2Jko/Pyxaud/KjbBQxiq/cmK1RFmZ7E
         phvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771789823; x=1772394623;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=na4axJXt/cUr1mORRW5n0O7My4YPvC1XtbGZHus3pls=;
        b=n5oI731DlJlnTYcMVzOPHxqCv+VI+Pdh0GN6APtD1psQrOxRevM+gdTyMcsD3Di909
         HD/VMBnrtpM/TiN8OURopD3J9Y1jp5gJoIOPKOqTtVNgF1bkW5oIxm5bpnGdXhI3Wx/g
         AYOZhJGymW3rsRkc+IYDBSa40URVJR7lrLJiFGdswQFsViidVlrhbLb3OCHhSCRi+m2P
         Cahscq/uYS1XNfl2s/HR0pzQqN748X8Qg+OJ7Z8Ldl/YkSchijAAnTtpqC0p4DcRWDkD
         s55yWcnRMUhqaGsP0Z2HrmSnGeFDIxu1Z1D+v/kGfNvPLA93vEnhiZo40kgnc85495Bo
         +JJg==
X-Forwarded-Encrypted: i=1; AJvYcCWF4ii34QKLXqOmI/fFzL2BvWHee02YFyLndG1PT+/A1oHxsT3msEnXpYK6wrgk8LiQW3lVFNo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyq5EejZOBvnQNuwJ95sYDLFRrB2MLPvvqgC0FfkNLXiJg+xBNV
	CFx2NEKrY4U7ua5Vspa6zLKh0GNEwsfsGC1S6kJhAhmNybKqNJlfx1rWMZbX4H9VRc5AHeuZvpT
	/eurYDw==
X-Received: from pgbfp12.prod.google.com ([2002:a05:6a02:2cec:b0:c52:a841:c79d])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a20:748b:b0:38b:e55a:97c9
 with SMTP id adf61e73a8af0-39545ebb1b9mr5333025637.28.1771789822447; Sun, 22
 Feb 2026 11:50:22 -0800 (PST)
Date: Sun, 22 Feb 2026 19:50:04 +0000
In-Reply-To: <20260222195016.705157-1-kuniyu@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260222195016.705157-1-kuniyu@google.com>
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260222195016.705157-3-kuniyu@google.com>
Subject: [PATCH v1 net 2/2] ip6mr: Fix mr_mfc.unres.unresolved corruption in  ip6mr_cache_resolve().
From: Kuniyuki Iwashima <kuniyu@google.com>
To: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259901-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: A75AC170382
X-Rspamd-Action: no action

mr_mfc.unres.unresolved is filled by skb_queue_tail() under
spin_lock_bh(&mfc_unres_lock) in ip6mr_cache_unresolved().

ip6mr_cache_resolve() is called from ip6mr_mfc_add() after
releasing the spinlock, so nothing protects the queue.

Let's use skb_dequeue() instead.

Fixes: 7bc570c8b4f7 ("[IPV6] MROUTE: Support multicast forwarding.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/ip6mr.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ipv6/ip6mr.c b/net/ipv6/ip6mr.c
index e047a4680ab0..97c406e58b39 100644
--- a/net/ipv6/ip6mr.c
+++ b/net/ipv6/ip6mr.c
@@ -1031,7 +1031,7 @@ static void ip6mr_cache_resolve(struct net *net, struct mr_table *mrt,
 	 *	Play the pending entries through our router
 	 */
 
-	while ((skb = __skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
+	while ((skb = skb_dequeue(&uc->_c.mfc_un.unres.unresolved))) {
 		if (ipv6_hdr(skb)->version == 0) {
 			struct nlmsghdr *nlh = skb_pull(skb,
 							sizeof(struct ipv6hdr));
-- 
2.53.0.371.g1d285c8824-goog


