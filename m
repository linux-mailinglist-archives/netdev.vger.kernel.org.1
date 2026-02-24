Return-Path: <netdev+bounces-260504-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UExYBkObnWnwQgQAu9opvQ
	(envelope-from <netdev+bounces-260504-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:36:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7099F187073
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 13:36:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C471309DC49
	for <lists+netdev@lfdr.de>; Tue, 24 Feb 2026 12:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2D0638BF82;
	Tue, 24 Feb 2026 12:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DRfJcHyZ"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f74.google.com (mail-qv1-f74.google.com [209.85.219.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73F2037D111
	for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 12:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771936430; cv=none; b=ja9atEkUGp6qDlHPJDjiG1en92iaNEM5QAQX+2xKqOehu9VxOSsFAk+qy9WpYAqfLgzdAHVR+bmKOkic8SwQ0VrVltYhJS3GQAJvJRWV+X9m2SpXhU8VOwJ1LhYNj2Qv6DqzmxpGBhx/0kRTa59Z9Hp1JU3g3azo94VQe9B3c1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771936430; c=relaxed/simple;
	bh=clZnONM24nEys84smKGnPS40DZNnvZ0axgHZ537gWa8=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=lrQBr5as2VMkC4dEEaE8dznXjDv83X36WaleWoXY9JeEJ+cAJZs89CXcPEa9TOWYszdxpn7XGXDR9kEbRn3PecztSuRZcgH2NqPP2CDYKtlYtjepLV3T6tONhF9PAkkmiw31uk1VYdcvNxnxpDFsXcNcG6kOlG+F8lcx/RqaO0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=DRfJcHyZ; arc=none smtp.client-ip=209.85.219.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qv1-f74.google.com with SMTP id 6a1803df08f44-8950562d351so85191886d6.3
        for <netdev@vger.kernel.org>; Tue, 24 Feb 2026 04:33:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771936428; x=1772541228; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=fQbu6Cl/paq0E3UGNbm7xLXUbURoFHMRf6FXvlp9cXk=;
        b=DRfJcHyZo/thIw0B82gbRNF0xsmJbkZsu+3/nqihuaJMlQaTepzOdb2cibeNP3/hi4
         qyA2u0XRgeuaNgnPB75K0ZrC7FFudSDP0XZPgx+e8p60RSddUXYai81xEG28HSz1rto5
         k+hBVIKjlAAxFl9ljvIK8bvRNM736Fxxdx2QAf4JpEp9wm0pOFMgGwAKNZWJ/MSDGMsq
         oSmgGWRDf2jklSm95lgjl7fZ2r+SitFxB1MazUFFbo1ZJVvGxumtHdqtbgIG458PotII
         FT7Q4hBTegrALhUy8KFll0N8b3WpmKKWtpTGQsISYzUrGzhh92zwqJ/SguHHNUgjIk7q
         bCGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771936428; x=1772541228;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fQbu6Cl/paq0E3UGNbm7xLXUbURoFHMRf6FXvlp9cXk=;
        b=nUtQhYoCg1TwkvsMn6qacFEmnDj064DAPqTkp7DthcRIhtfX2p9rrrlYwa+S0l7Q7Q
         bSVu8rr9Uv76/Ne1rR28hUwgabUk+E5vLh+/xcLveOohuBCMmgowTdZtGt8OWX2YwpEV
         6y0YdMn67APnsdJEjYv9SGy0fX0BodfLYSep6PDMjHVatXngLJYaVCTuf5AQH5+daKfL
         NTNKbmdh6739/BG1zyJsqxIqtk7KNd78cNDSNnShXJ51dlMdtAwjTu9UM9YmfBI7hfWc
         MpbsTcC+0Teuk6Y4kmYBv3Hu2ct8eAuLJjMwcBkgj484lj+f9tEuSx19jFcWPUze0CKk
         ad0A==
X-Gm-Message-State: AOJu0YxCn68TOlF1rn7y4rm/aoGGBFjlaQQ/xnnEQJP7zZSKX1wV9B50
	SPg0bbLGctdlc2aS0fO7RjWv8Wq3jnnCWsdQ9AYYDxiS6oK4kxBiEOXv11nN0jGy1+9gi83kXao
	agU/AotOfkP1/eQ==
X-Received: from qvbif8.prod.google.com ([2002:a05:6214:1c48:b0:894:2b9f:cc7e])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:ad4:5c8c:0:b0:880:498e:a63e with SMTP id 6a1803df08f44-89979c53d67mr180727396d6.2.1771936428183;
 Tue, 24 Feb 2026 04:33:48 -0800 (PST)
Date: Tue, 24 Feb 2026 12:33:47 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.53.0.371.g1d285c8824-goog
Message-ID: <20260224123347.3163030-1-edumazet@google.com>
Subject: [PATCH nf-next] netfilter: nf_log_syslog: no longer acquire
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,netfilter.org,gmail.com,google.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260504-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-0.971];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7099F187073
X-Rspamd-Action: no action

After commit 983512f3a87f ("net: Drop the lock in skb_may_tx_timestamp()")
from Sebastian Andrzej Siewior, apply the same logic in nf_log_dump_sk_uid_gid()
to avoid touching sk_callback_lock.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/netfilter/nf_log_syslog.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/net/netfilter/nf_log_syslog.c b/net/netfilter/nf_log_syslog.c
index 41503847d9d7fb21824fabb1b57b45f2622b9310..dee6be17440c6c0f202fc2ba67129437879e45a6 100644
--- a/net/netfilter/nf_log_syslog.c
+++ b/net/netfilter/nf_log_syslog.c
@@ -165,18 +165,28 @@ static struct nf_logger nf_arp_logger __read_mostly = {
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
+	rcu_read_lock();
+	sock = READ_ONCE(sk->sk_socket);
+	file = sock ? READ_ONCE(sock->file) : NULL;
+	if (file) {
+		const struct cred *cred = file->f_cred;
 
 		nf_log_buf_add(m, "UID=%u GID=%u ",
 			       from_kuid_munged(&init_user_ns, cred->fsuid),
 			       from_kgid_munged(&init_user_ns, cred->fsgid));
 	}
-	read_unlock_bh(&sk->sk_callback_lock);
+	rcu_read_unlock();
 }
 
 static noinline_for_stack int
-- 
2.53.0.371.g1d285c8824-goog


