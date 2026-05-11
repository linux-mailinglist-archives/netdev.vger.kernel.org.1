Return-Path: <netdev+bounces-286485-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBv5MT6EAWoFcAEAu9opvQ
	(envelope-from <netdev+bounces-286485-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:24:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 472B65091B0
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 09:24:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5893302F9B1
	for <lists+netdev@lfdr.de>; Mon, 11 May 2026 07:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 381F037D103;
	Mon, 11 May 2026 07:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nukXE/Kt"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qt1-f201.google.com (mail-qt1-f201.google.com [209.85.160.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3586379EFE
	for <netdev@vger.kernel.org>; Mon, 11 May 2026 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778484199; cv=none; b=b1OOzcGfwhKmcOsG6Ffu+Kh1wvSRuulvkfeGI8DdZPCZIMDuGQHywryky3Pblq0yKabJUMSIJMa7ULqidbN1JDYonz9GJ0gZYRA8gLQuGUv+1KyLkNUQLIx2bwn6fdZJT6GjlGUNCAkeXDtIpYDEwvrtmnacge06lYsW3Sj3BMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778484199; c=relaxed/simple;
	bh=SlPiywE9oP+373lgZkMih/CbPc0StHFjba2YFrhexgM=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=n1GTEwqpRQhWU50pLHGAfNaw4kKFAPmZG4ZRb2RVKaMkzZVIJTUoqZQQdFGm4LKKtoDIio0anyILu5McD79liXZa40MP915t0TfSeUC75Irzrn+CNb3glG+3JyVrOX0ihNW1bn+R9Qf7CMHxCFZdT7mAGC2l0zVt6HhwXdJ2HZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=nukXE/Kt; arc=none smtp.client-ip=209.85.160.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qt1-f201.google.com with SMTP id d75a77b69052e-50e2592ea3bso13068841cf.2
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 00:23:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1778484197; x=1779088997; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=DtM0IuQu1tVCiMQlaS7DuJFeWUv3S1qzexoLfam8uyM=;
        b=nukXE/KtMpgF409R7jpWjAar0tMAO7DNw3i+U8E24PqKmZKF3+0qIPuePSvR+jFKgy
         A+K6iNcPQyF3BMsfiB/Birttw0Ho02CWMK2K9HdeLY+UBbn3U7DmcDIOH8Ml42PefVkP
         rSIqcOEzHrTURjhovN8N3902FJ26q6QK/vECFs5EMkKN5aQjWMUpP2NO/rgbHh3OrfEg
         4Jx8TYcD1/Bclj7urgSPCnhm5P4zIL2lJpaDmmyDs6BMSQQTis0OFWNNFK3RffBOvLtP
         9DQ1WYWEaBh+/EUURLqo1xE7d/J/Om5auVk9hp8jwUbRKLKcCbAjbq1EsxVFB6fSH+iH
         L16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778484197; x=1779088997;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DtM0IuQu1tVCiMQlaS7DuJFeWUv3S1qzexoLfam8uyM=;
        b=U4SnEi8mhK18TkOcZcJxZur7uEdOmfHR7JwdPuNraga1STNMmgru7Zeud8olaGKuXi
         jPF6rQxiTuzdFCbLscy/eSeu6FxqsucRub2TuNreA4j2P7X/8NPDWcEvs5d7RGIWMFNo
         BQxdkXgmC3gy2PADpOAyWULTi1CwZLiK4guxAlG+F7b1o5KY7pdzk/3JZ5p2KDJ7NE1k
         UJrTlW/2Zfw7lmflQD7nE/NQxU41dyCUwDY0R2l0PLJ2ZBOCp5OddqGx2quXl8PwAcQH
         ovwpxV/xuCjtVsWZbl25ant4O0/7x2itmg5GmozmwfP2iGD+gS4t6VfqmlTNJ5qjHkTz
         8BPg==
X-Forwarded-Encrypted: i=1; AFNElJ8h/tulvbYX7lh2qNH9xF0cezLfGqhX6/SXxGHJAmKjb9a6Gukd9nKHoN2uP4TKDGMxhNamEqQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YzACF6r6UbPIfbx7aYzyN8tENrON8AQhIXMjyZjdTCLss3J1pnY
	T8yNJcaCGyP9roxsHEzTCrRILiwUoZrEH/+1sGEC2EO/gAj9CMOtndsi6he5quAr/YnGnZ5wkp/
	0EtlbqyXMS4QBLg==
X-Received: from qtxa11.prod.google.com ([2002:a05:622a:2cb:b0:510:4492:53])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ac8:6f1b:0:b0:50f:ec27:5d05 with SMTP id d75a77b69052e-51461bea660mr366640651cf.10.1778484196688;
 Mon, 11 May 2026 00:23:16 -0700 (PDT)
Date: Mon, 11 May 2026 07:23:10 +0000
In-Reply-To: <20260511072310.1094859-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260511072310.1094859-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.563.g4f69b47b94-goog
Message-ID: <20260511072310.1094859-4-edumazet@google.com>
Subject: [PATCH v2 net-next 3/3] ipv6: use SKB_DROP_REASON_IP_OUTNOROUTES in inet6_csk_xmit()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, David Ahern <dsahern@kernel.org>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 472B65091B0
X-Rspamd-Server: lfdr
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
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286485-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Replace a bare kfree_skb() with a modern sk_skb_reason_drop() call,
and provide IP_OUTNOROUTES drop reason.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv6/inet6_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv6/inet6_connection_sock.c b/net/ipv6/inet6_connection_sock.c
index 37534e1168992c44e1400dacab87e79d04c64a41..4665d84a7380d90b7d180a429017f577fcb6936a 100644
--- a/net/ipv6/inet6_connection_sock.c
+++ b/net/ipv6/inet6_connection_sock.c
@@ -102,7 +102,8 @@ int inet6_csk_xmit(struct sock *sk, struct sk_buff *skb, struct flowi *fl_unused
 		if (IS_ERR(dst)) {
 			WRITE_ONCE(sk->sk_err_soft, -PTR_ERR(dst));
 			sk->sk_route_caps = 0;
-			kfree_skb(skb);
+			sk_skb_reason_drop(sk, skb,
+					   SKB_DROP_REASON_IP_OUTNOROUTES);
 			return PTR_ERR(dst);
 		}
 		/* Restore final destination back after routing done */
-- 
2.54.0.563.g4f69b47b94-goog


