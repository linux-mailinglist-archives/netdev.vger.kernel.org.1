Return-Path: <netdev+bounces-261233-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI0/OHMEoGl/fQQAu9opvQ
	(envelope-from <netdev+bounces-261233-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:29:39 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3D01A2905
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:29:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B4FCA3014A0C
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 08:29:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23787394469;
	Thu, 26 Feb 2026 08:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="obNBBClo"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f201.google.com (mail-qk1-f201.google.com [209.85.222.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DCD438E5CA
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 08:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772094575; cv=none; b=cdpM6GumWs8AB+v4m0QkSQCBfuoQB2MNZa6kDYf5VWxfKBZHqzSpK32EAvFM7h1TDCvEbhKA1cdjhOPfSfK1RpHwGSIuozyl0lYH020hAjduYlqV9SThIUVJdvzVO0GwNprVnzOUO8l0lSN4XJR1zSiAPExgDW8Ul6eKBCkJH9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772094575; c=relaxed/simple;
	bh=HSNHNWilE0WePK9+G9tgFk2R/X9oV5NWXBly4avELcc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=PUMMjSm/wPRD0XPj6uj9l8vFWzUZRQjC90M2quLu3pMo0VCAWbJn+nM3T1YZ6ls74HMF/YzSAH7hfRsxOQEFXQIK2ahLXvhnRaWxsrf5zFHl9fbQQkLndY5vrkqocIr0hM90wMejGfFYtTnSeIwIR6x3Vv3yj5bMzRub6GtgFbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=obNBBClo; arc=none smtp.client-ip=209.85.222.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f201.google.com with SMTP id af79cd13be357-8cb5359e9d3so513911185a.2
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 00:29:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772094568; x=1772699368; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=iCsbJfC3CsgwU4dZ0i+L360fn2q0VpoL/Uu/WwKuSu8=;
        b=obNBBCloCk2YQLv6LA72CHHEJa8rOY863a94oJ32kSt6Z126kAprYX7pgoKbcGvC06
         t+w+7vRan3FG+xsJgiyNfQ10tILXGlJso/8H8JBVVzx3Svxa/2Q0ZqDPxdwj4UdG3Rzn
         J5i1hnOfmj/c0gUKU8aErNLhJ/rrm6XdOINZsjbm8tjyu4eZSb9wDsoU5FfVoVZ2PEYx
         0yYBKPrFF38fhZwIdlnDORVSaGrrFxEvacpJ/Spi1RBmZOLnl/ImzUejrzm+ceT7RQTP
         O9mQKgMjHuyD7v1Jk7z4hqxgz7g88ADqerB46onDsI8hWJD7vdDubYnhNoyXj/d6LXmK
         q0lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772094568; x=1772699368;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=iCsbJfC3CsgwU4dZ0i+L360fn2q0VpoL/Uu/WwKuSu8=;
        b=i/q/tDziO7mdUy86biGTRF7E6IKTtk9+1zKWMgrKr11FNjefhzcE2Y6H22bFsF7b5P
         XN9vpuowz5LPjS9lpAAzXZDK2EdlFfHGVIgqdRWyr3jcnJ0vZZ1mbSgpUag9Bk/VRNUu
         UU0XfiVC+d6+q5Pt8AjzvIerOua6vUIZlcOzbd0UfO0hc4Bo3RGahj4lBLQMaQb+pDes
         EDls8Gf/oC5NPjYmMBXyBYlOpIqfF1/2a0Y7D0nuGXLyUpcUnJYHHFcgngvZet/GiZY/
         U0/Re0zlSHwMvbAqEww/yAJU9rpIIW744qUrYoi2b8rmmxXw6AOMeewbl/R8ElCUWv1v
         zg5w==
X-Gm-Message-State: AOJu0YylRpw52P4+F7zWioKxXy84VTjAA5o7zA8JTZajwV+6hwZoieyh
	+AaC9aUOIubwYbv4c26U0pxjSb9Q1ZfgZV3K0n4KjyIOWmbB0i9MCDaUsXN+F/KkKei/4X6gSIp
	LLSiXI8EvddUFMw==
X-Received: from qkbc19.prod.google.com ([2002:a05:620a:31d3:b0:8c7:cb6:2f03])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:2947:b0:8c6:abc5:f169 with SMTP id af79cd13be357-8cbc11db1d9mr133441985a.73.1772094567693;
 Thu, 26 Feb 2026 00:29:27 -0800 (PST)
Date: Thu, 26 Feb 2026 08:29:22 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226082922.2246271-1-edumazet@google.com>
Subject: [PATCH nf-next] netfilter: nft_meta: no longer acquire
 sk_callback_lock in nft_meta_get_eval_skugid()
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261233-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.953];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8D3D01A2905
X-Rspamd-Action: no action

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in
nft_meta_get_eval_skugid() to avoid touching sk->sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netfilter/nft_meta.c | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/net/netfilter/nft_meta.c b/net/netfilter/nft_meta.c
index 983158274c68dc6626032e6f55afc452c4be443f..d0df6cf374d1abe83ce2a02d93fb366e12b3d8d2 100644
--- a/net/netfilter/nft_meta.c
+++ b/net/netfilter/nft_meta.c
@@ -131,33 +131,36 @@ nft_meta_get_eval_skugid(enum nft_meta_keys key,
 			 u32 *dest,
 			 const struct nft_pktinfo *pkt)
 {
-	struct sock *sk = skb_to_full_sk(pkt->skb);
-	struct socket *sock;
+	const struct sock *sk = skb_to_full_sk(pkt->skb);
+	const struct socket *sock;
+	const struct file *file;
 
 	if (!sk || !sk_fullsock(sk) || !net_eq(nft_net(pkt), sock_net(sk)))
 		return false;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	sock = sk->sk_socket;
-	if (!sock || !sock->file) {
-		read_unlock_bh(&sk->sk_callback_lock);
+	/* The sk pointer remains valid as long as the skb is. The sk_socket and
+	 * file pointer may become NULL if the socket is closed. Both structures
+	 * (including file->cred) are RCU freed which means they can be accessed
+	 * within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (!file)
 		return false;
-	}
 
 	switch (key) {
 	case NFT_META_SKUID:
 		*dest = from_kuid_munged(sock_net(sk)->user_ns,
-					 sock->file->f_cred->fsuid);
+					 file->f_cred->fsuid);
 		break;
 	case NFT_META_SKGID:
 		*dest =	from_kgid_munged(sock_net(sk)->user_ns,
-					 sock->file->f_cred->fsgid);
+					 file->f_cred->fsgid);
 		break;
 	default:
 		break;
 	}
 
-	read_unlock_bh(&sk->sk_callback_lock);
 	return true;
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog


