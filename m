Return-Path: <netdev+bounces-257635-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CGyBJagnhmmLKAQAu9opvQ
	(envelope-from <netdev+bounces-257635-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:40:56 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E57A7101383
	for <lists+netdev@lfdr.de>; Fri, 06 Feb 2026 18:40:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91FAF309677F
	for <lists+netdev@lfdr.de>; Fri,  6 Feb 2026 17:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98FD6425CC2;
	Fri,  6 Feb 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b+HnfQC8"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 523C3425CC5
	for <netdev@vger.kernel.org>; Fri,  6 Feb 2026 17:34:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770399293; cv=none; b=pGccuKFih9ajpRihneH1mkiN3pYpbqmwG6wImnldQ3siih/Lg8pLwwpqEUtjIXhX01OYFhXexVD+8+Ekesk8YQybr6wgGhJMKcBW4QAXt4JyP1K0tqly6jiw5lD3j+eqej31FgcLS0BevMWVzf8r/txBCHCgrikV9a/L9syBnMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770399293; c=relaxed/simple;
	bh=2Lzd4Hvvg/gORCFhLjrKV0IdkvA9nbpYbXi0RGOuLXo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nMlQfj+7tTEeL0pSEFrep4lrhikoDWdIgxnRIQem4mEzHzYjx5iBLdqBNZqEPrhm0iXhDb1QXQ1V0qyF/joRJyiWwTaLzlhBb2JIpLqKiUW/h+46rrsVU8d+ly108vlsIyAZ2heMg5nzFL7EWc/DYOr4eOAGShaNBrP+BdRpI4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=b+HnfQC8; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c52f07fbd0so368688485a.2
        for <netdev@vger.kernel.org>; Fri, 06 Feb 2026 09:34:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770399292; x=1771004092; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2ptvpb4/Pned5Uh7jvqgn0Z+kPFOklc+P65LRzOeQD4=;
        b=b+HnfQC8EWo8UR0PGOpdDLXD8I03D2XtOAqg2Q99/ipDrS5taySE/OlgwI6WeByz25
         22hwSt888vmINASB7uhHMamECKvLp6GqJHRP3dukkDuf4AxStsObfbmUVrSYKb+Gsvlc
         ajVkI8fQ087mVBUP0grbOIsQyEp0wuRIKz+e9qrGL5uL/UiC06UPRRFDWKHwsUJqwjIk
         SlgfxX4uehf7UU3SlItmoYHJAHjou7M5Uvbh8ArkSAEQ4H8LNDIf+H49khZHDE02GdU2
         T46LzwKcZmVLahCQI3BK5R4CybM9ejUEU47h8vdG5WAKvUfyML5HLCWzLQ3z65e76sOn
         WG+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770399292; x=1771004092;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2ptvpb4/Pned5Uh7jvqgn0Z+kPFOklc+P65LRzOeQD4=;
        b=oArH9TfU589HVMnk4uBPTYnohsbS52M06kFz+BGaUSPYfEUANFaaU4IWlNd/telvYF
         6uS0Hc2/voMKdoY0whEG+r/qMYb+MS2oT+LI7zN/dktG1hK8Fn7+mKIzZBdEs7DqC1uv
         qK+1KsYwg8Su+mwgMWbnsdKiwKT1RC50OnMp7iK4fDYh4gQ0XjH81qktEFUfLjktBKOn
         NWhQtdUoj8R7RSg+li4EnkZgCHD4hEZYApyNNUsNGiXU/iLUGygYOdMy+2FyIpzZWYiv
         3XaEPw4Uj/Pl/IS/2e3HLd4dozb/OnqeRVQwmMgczN4iqzWZ6I8t9pyHqj5KninR7/DV
         6iEQ==
X-Forwarded-Encrypted: i=1; AJvYcCUIJatpqh1XYbrF0QnUWoL6mUPRY2gTKCTXZrqTSAeRK9i4EsP/MV/ANZm6AltX+maWCHSRdgQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzh4JC7ugmL27w3ecl5Fp/xsSNFKbF9R6p1vGjxn1kbmzaUHATo
	ke01WPKZqRwTfj2SGNhk2q5i5RD7BU5sfqoa+Vw23BQjyrlYrqY27IBIaIP5gsw2DDZlMOgeGJF
	kx2vLacZU/T8TUw==
X-Received: from qkbee5.prod.google.com ([2002:a05:620a:8005:b0:8ca:30dd:e12c])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4113:b0:8c7:6d9:4ff5 with SMTP id af79cd13be357-8caef7e71e7mr469057785a.26.1770399292172;
 Fri, 06 Feb 2026 09:34:52 -0800 (PST)
Date: Fri,  6 Feb 2026 17:34:26 +0000
In-Reply-To: <20260206173426.1638518-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260206173426.1638518-1-edumazet@google.com>
X-Mailer: git-send-email 2.53.0.rc2.204.g2597b5adb4-goog
Message-ID: <20260206173426.1638518-8-edumazet@google.com>
Subject: [PATCH net-next 7/7] tcp: inet6_csk_xmit() optimization
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, David Ahern <dsahern@kernel.org>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
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
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-257635-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E57A7101383
X-Rspamd-Action: no action

After prior patches, inet6_csk_xmit() can reuse inet->cork.fl.u.ip6
if __sk_dst_check() returns a valid dst.

Otherwise call inet6_csk_route_socket() to refresh inet->cork.fl.u.ip6
content and get a new dst.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv6/inet6_connection_sock.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index b6c4123aa0aeb803afdf807d8683156b710df2f6..11fc2f7de2fe981ddb48dc008bf7fd4ae1e4e2f6 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -81,13 +81,11 @@ static struct dst_entry *inet6_csk_route_socket(struct sock *sk,
 	final_p = fl6_update_dst(fl6, rcu_dereference(np->opt), &np->final);
 	rcu_read_unlock();
 
-	dst = __sk_dst_check(sk, np->dst_cookie);
-	if (!dst) {
-		dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
+	dst = ip6_dst_lookup_flow(sock_net(sk), sk, fl6, final_p);
+
+	if (!IS_ERR(dst))
+		ip6_dst_store(sk, dst, false, false);
 
-		if (!IS_ERR(dst))
-			ip6_dst_store(sk, dst, false, false);
-	}
 	return dst;
 }
 
@@ -98,20 +96,22 @@ int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused
 	struct dst_entry *dst;
 	int res;
 
-	dst = inet6_csk_route_socket(sk, fl6);
-	if (IS_ERR(dst)) {
-		WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
-		sk->sk_route_caps = 0;
-		kfree_skb(skb);
-		return PTR_ERR(dst);
+	dst = __sk_dst_check(sk, np->dst_cookie);
+	if (unlikely(!dst)) {
+		dst = inet6_csk_route_socket(sk, fl6);
+		if (IS_ERR(dst)) {
+			WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
+			sk->sk_route_caps = 0;
+			kfree_skb(skb);
+			return PTR_ERR(dst);
+		}
+		/* Restore final destination back after routing done */
+		fl6->daddr = sk->sk_v6_daddr;
 	}
 
 	rcu_read_lock();
 	skb_dst_set_noref(skb, dst);
 
-	/* Restore final destination back after routing done */
-	fl6->daddr = sk->sk_v6_daddr;
-
 	res = ip6_xmit(sk, skb, fl6, sk->sk_mark, rcu_dereference(np->opt),
 		       np->tclass, READ_ONCE(sk->sk_priority));
 	rcu_read_unlock();
-- 
2.53.0.rc2.204.g2597b5adb4-goog


