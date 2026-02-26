Return-Path: <netdev+bounces-261263-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id xhclJSgXoGmzfgQAu9opvQ
	(envelope-from <netdev+bounces-261263-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:49:28 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 021AE1A3BB3
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 10:49:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3FD373143F9E
	for <lists+netdev@lfdr.de>; Thu, 26 Feb 2026 09:40:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8A0A315D21;
	Thu, 26 Feb 2026 09:40:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="i/oIbMCl"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yx1-f73.google.com (mail-yx1-f73.google.com [74.125.224.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3EAE314D15
	for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 09:40:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772098841; cv=none; b=c//vto9tUsAoJNyYLDW34Zp0UVdzk/b8ctAoyC6V5wCRrmU5qrySFF99BubdMEYMFc4XED7q2d8+4P7PpU4w901m270xOGS05SgroZAfy1om7AaOIgLxbXgBTXIKGaXYvt0YcrEopkb9Ozb2Ijv+cqzMryHoo4FIBtHsn+fPp2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772098841; c=relaxed/simple;
	bh=6Y2r1m4ktKYWJZA5fuQy2TxAyWNeR/WGqtQQWHR9Lqw=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=hXh/roWJGkinqJJ5/qWjNRvNXInQ4ToDKqe0XJT0q3TBHiBfGXpOCabae85Dsw9qF0yJ7w7WZcGZtO/Rz0Y2CwC+HqHElp+HGep6bOL3WySg3pMq5eA5dOKPToUyfazD+EFyugjztrE6IJl0RomFJOpHFJ9GCZMn7Udiz4o0/Rk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=i/oIbMCl; arc=none smtp.client-ip=74.125.224.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yx1-f73.google.com with SMTP id 956f58d0204a3-644548b1d9aso551001d50.1
        for <netdev@vger.kernel.org>; Thu, 26 Feb 2026 01:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1772098838; x=1772703638; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=htXESGH862/A++yJsW09A3WDgNddAXJDDbqtkvvU8IY=;
        b=i/oIbMClBJPPvq2s1erUSnfRCG9hRXTaLVrM3nqIib+I0STC79jYAiG1nLecCDfq91
         OuyfKJnScJu2618/L+Yo8l3NQ7yxi4jDHAXN/vmQCWejDp779oHiY466nhxKFz24e/S2
         gV/3EUuZHYXdMbeY8MEx5uFZzPuLviDFdcFfhiTABOoP0BXHUHnytXgFXXV4RUI4w7vs
         KiRVW4Sp8FBjxE7l8QCFaDCSgo0+PN66G1MP2HXg/isml1UWOmkCk4wZRg8bbf496ZSc
         aolPrb4mJWBz8oGZnU+1MXjRXtZNTnleolCWpRHUTZh10slk7TOwZDxCEILIcUuifYy0
         aiUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772098838; x=1772703638;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htXESGH862/A++yJsW09A3WDgNddAXJDDbqtkvvU8IY=;
        b=Tn7bdLCq1LEWA27fknW6Kj8Ii02Mjj2y/6HfIKqwchlH9Fy0xm/GSYW6ePWWO0Y4Ch
         3gStf1mmyRGKN1trjspXKtH62UaK1jPSeLbAhlLUho5rhLe7L8tMuSZshz/8Meew7JYi
         hApQozIVgvpXKxDg65EzrK/JmRDysQzs4tGo0OPWuYK9cKF+p4QDgxveINzWcuUnrSNE
         Z4va61jo0hg0vwH/e5cdeX1lPq/w5LrCPCxHu8QUTovkFbcjmA62FSLRQuDYmafaIWib
         My5B/WoGToo+Y8wNz9JTU+fHQs00jNZRdw3HUALImXxFAiGiU3hN7IJb6goTmGOeljx4
         PoqA==
X-Gm-Message-State: AOJu0YwZK9HI+F0aNFdBnlwSsrrdIezsZwiE9NI9G4Gd8hQP3LZI9vOQ
	7dlrbqLcxfBW8BJJgiv0Kp3vzJSTPe/KtPI+ik46sE7uZvxjx6ZUfptX6BLoOan4Ab7WAcCsPGK
	DmYsJTLeYpjgsqg==
X-Received: from yxww8.prod.google.com ([2002:a05:690e:42c8:b0:646:e5d7:6a3a])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:690e:14c6:b0:64a:d9b3:6ef3 with SMTP id 956f58d0204a3-64cb7bf5638mr1041583d50.6.1772098838386;
 Thu, 26 Feb 2026 01:40:38 -0800 (PST)
Date: Thu, 26 Feb 2026 09:40:36 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.414.gf7e9f6c205-goog
Message-ID: <20260226094036.2309604-1-edumazet@google.com>
Subject: [PATCH nf-next] netfilter: nfnetlink_queue: no longer acquire sk_callback_lock
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
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,google.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-261263-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.965];
	TAGGED_RCPT(0.00)[netdev];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 021AE1A3BB3
X-Rspamd-Action: no action

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in
nfqnl_put_sk_uidgid() to avoid touching sk->sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netfilter/nfnetlink_queue.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/net/netfilter/nfnetlink_queue.c b/net/netfilter/nfnetlink_queue.c
index f1c8049861a6b7c91c2d1fd0aa1ddb2db9a31d8f..fbe5a8d7143358906d8e77d3e7a62152fdac337b 100644
--- a/net/netfilter/nfnetlink_queue.c
+++ b/net/netfilter/nfnetlink_queue.c
@@ -545,14 +545,23 @@ nfqnl_put_packet_info(struct sk_buff *nlskb, struct sk_buff *packet,
 
 static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 {
+	const struct socket *sock;
+	const struct file *file;
 	const struct cred *cred;
 
 	if (!sk_fullsock(sk))
 		return 0;
 
-	read_lock_bh(&sk->sk_callback_lock);
-	if (sk->sk_socket && sk->sk_socket->file) {
-		cred = sk->sk_socket->file->f_cred;
+	/* The sk pointer remains valid as long as the skb is.
+	 * The sk_socket and file pointer may become NULL
+	 * if the socket is closed.
+	 * Both structures (including file->cred) are RCU freed
+	 * which means they can be accessed within a RCU read section.
+	 */
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (file) {
+		cred = file->f_cred;
 		if (nla_put_be32(skb, NFQA_UID,
 		    htonl(from_kuid_munged(&init_user_ns, cred->fsuid))))
 			goto nla_put_failure;
@@ -560,11 +569,9 @@ static int nfqnl_put_sk_uidgid(struct sk_buff *skb, struct sock *sk)
 		    htonl(from_kgid_munged(&init_user_ns, cred->fsgid))))
 			goto nla_put_failure;
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
 	return 0;
 
 nla_put_failure:
-	read_unlock_bh(&sk->sk_callback_lock);
 	return -1;
 }
 
-- 
2.53.0.414.gf7e9f6c205-goog


