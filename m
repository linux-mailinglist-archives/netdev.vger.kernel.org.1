Return-Path: <netdev+bounces-260937-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sMPBEBv3nmm+YAQAu9opvQ
	(envelope-from <netdev+bounces-260937-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:20:27 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C239C197F8E
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 14:20:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8EF2A302925C
	for <lists+netdev@lfdr.de>; Wed, 25 Feb 2026 13:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 341613B8BC4;
	Wed, 25 Feb 2026 13:20:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cO6MYkoO"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2E283AE701
	for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 13:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772025625; cv=none; b=oWActFM8IZrPU4ghTh9c0hL4x3oJrXlaqBwfIG5HB0ZNQ9OPOUXCCu3AdulDE34xG2kowMZSHqoTWr1TYirAaOkYWCY7a0YpJ4hCHJe4sm+z5IzexsFGCOQdFrmDPvfQtUS2SPZ9ybmQL2gSYkAh5S2iSdIi10u3UtSZHjlbNeI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772025625; c=relaxed/simple;
	bh=dWkOdHUNZY084evNatRVHBp93SP9Ud6vhumdrqM0qYw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZprPvHcOxbzP+qUtpUMkq6OcqavJ+GIu+HVdrKwX1JzZdtQBbO3cUKOcqmhSuGPiFox4l+hqJxO9MCabkYS2jRfp6Ueq5XcbaiuHrQqtcoSC6pUJI+//9sqbZCNLLqDRmRMNFylUzXM4eeXBC6Dg4vkpUhM1Scz0HdvHMMIMB28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=cO6MYkoO; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-64956932a51so8321472d50.0
        for <netdev@vger.kernel.org>; Wed, 25 Feb 2026 05:20:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772025623; x=1772630423; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=+IhwFnC60BkZSlrOC/ALdUxYIAf2cwE+9LjagsdzVp8=;
        b=cO6MYkoOXx2KGXSjTTP9BEAAz8ELdZtwu3Z8UGIcGqZytlou56ifqnnFs7zeNBFw79
         R5rsrTit5M5QP9ycOEOECgePI96le9IKADfkqWq6AMsGXeR1WYkCVxWgYgk4aHUwwt1q
         A7a4xsVY1t6p4icBCp5r3IOIU7TltZ68XKYDxG9Jw9byvwywdUUdaGZ/wxzZHAT3ZqaX
         tMR1/7MX5XX7Ms/7tHqOvS0cHnH1HPkEuMtBqgTsx0xAhdQXaxkSvp9Fz5buVQYmP9Cp
         0MMIscL0P7vgHgbhmhQFCSEXyU2M/eM4zB3GvtERZKAyy4blAffTAlRKrYCRmJXVxLzb
         U2qQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772025623; x=1772630423;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+IhwFnC60BkZSlrOC/ALdUxYIAf2cwE+9LjagsdzVp8=;
        b=EfKUrKPxtBlZX7PUpGGkO6lAZ1q7hajLU2ZoCBhswHsz6CMZjCGl8vaY+uA2my/Vts
         2QRLmfy0/uICBAFOV05UHNmPgha9wJSJhljEtJGvpW23QGtC3jy1zMNEJ2uYFPvAGVDl
         kNSuRdi43iBGyy87tNjbkTPcOpO92dGiRrf2RoMh6dQhqJYtjWWyhZMwJP0FoYDOaFlV
         UVwhJZnrXcwaV6v5E5JE8QGWoi6gtJGT9IBGnLqA4LKJe8+omvQ10czYKZd4z6rjOL7H
         Qki7t7eHIKDjjL9HZ63qUcOc9EJ4UX0UVPzyVRvZTh/POqw41MYXjtF8eIlYS8umWefD
         Ppzw==
X-Gm-Message-State: AOJu0YwGLE7ApuNTt+GJmXntgGjcGdFW2RdK5OCG3TYOIGrFOubfOd9g
	5qoxBTL2dST6cfhNuLKT3hYtdYrjmfWSqN69DStNkt9FLjo/EAE9+388ITyt+viiB8ustQo3k6y
	WaE0fAGuhAd/kFw==
X-Received: from yxyb18.prod.google.com ([2002:a05:690e:1d2:b0:646:e5d7:6a2a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a53:cd86:0:b0:64a:d9b3:6ef3 with SMTP id 956f58d0204a3-64c787d6ed6mr10402222d50.6.1772025622596;
 Wed, 25 Feb 2026 05:20:22 -0800 (PST)
Date: Wed, 25 Feb 2026 13:20:19 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260225132019.1103701-1-edumazet@google.com>
Subject: [PATCH v2 nf-next] netfilter: nf_log_syslog: no longer acquire
 sk_callback_lock in nf_log_dump_sk_uid_gid()
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Pablo Neira Ayuso <pablo@netfilter.org>, Florian Westphal <fw@strlen.de>
Cc: netdev@vger.kernel.org, netfilter-devel@vger.kernel.org, 
	coreteam@netfilter.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260937-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C239C197F8E
X-Rspamd-Action: no action

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in nf_log_dump_sk_uid_gid()
to avoid touching sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
---
 net/netfilter/nf_log_syslog.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 41503847d9d7fb21824fabb1b57b45f2622b9310..0507d67cad27530dd814aabaf806fdcd3583fe01 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -165,18 +165,26 @@ static struct nf_logger nf_arp_logger __read_mostly = {
 static void nf_log_dump_sk_uid_gid(struct net *net, struct nf_log_buf *m,
 				   struct sock *sk)
 {
+	const struct socket *sock;
+	const struct file *file;
+
 	if (!sk || !sk_fullsock(sk) || !net_eq(net, sock_net(sk)))
 		return;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	if (sk->sk_socket && sk->sk_socket->file) {
-		const struct cred *cred = sk->sk_socket->file->f_cred;
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (file) {
+		const struct cred *cred = file->f_cred;
 
 		nf_log_buf_add(m, "UID=%u GID=%u ",
 			       from_kuid_munged(&init_user_ns, cred->fsuid),
 			       from_kgid_munged(&init_user_ns, cred->fsgid));
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
 }
 
 static noinline_for_stack int
-- 
2.53.0.414.gf7e9f6c205-goog


