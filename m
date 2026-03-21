Return-Path: <netdev+bounces-270164-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OPHHMewQvmnFFwMAu9opvQ
	(envelope-from <netdev+bounces-270164-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:30:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 8EA062E31BA
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 04:30:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DB7BF301EBF7
	for <lists+netdev@lfdr.de>; Sat, 21 Mar 2026 03:30:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 229B82F260F;
	Sat, 21 Mar 2026 03:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Up2rsatx"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5CB2BA34
	for <netdev@vger.kernel.org>; Sat, 21 Mar 2026 03:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774063844; cv=none; b=fpTtVSFnJui/IjhW6VvWZd9nsMMYqzRJ5Sg/FXHr6z1EvNcnkq93LDJSoRlX0thinC3omkSr0766hZs9uc9xzbyoPhNYhXEggDcTbj6jDhyyBpDnojgayY2Pzw6wuTvGnMWu3r4CNz7yL9b9fBaZ7kBxKMgekHm0uN8KZgGsq2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774063844; c=relaxed/simple;
	bh=VreEpcz8CM8rugIkotpy01O4QxBusLIwuBT7TDffv3M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LwTy22HPsdhvirWkJ1c3URYbwgK8B1d4QN3dLCK978q7DoRHnPZcDKUWrOxecZXjGYVHYwhugzfy+wQAWFRZNCtRqQftFALj4mfkKaShN1k0cMRlwsPncHIAyMgCIkpKGQ1uMCDwuvaVhTFTraS1QvqlfRgQDgtM3VhtwI/1brk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Up2rsatx; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2ab46931cf1so30444575ad.0
        for <netdev@vger.kernel.org>; Fri, 20 Mar 2026 20:30:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774063842; x=1774668642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=RSTnS2CNzOtgpi/5KarHxhU2fHa8t3c2ByPYxsFVFuQ=;
        b=Up2rsatxErmKR33pWJkucAdc2eeglZQ6UbaHSw9d5LYEY2G42sZyBx5j3o0WyaBJ69
         NRpnHH95Gvu29ahQYCdnDnPgf+n4YTg/8L6NgKFlsFRhp9EKme8BbUMKCshJhDERFme1
         Gu6LADYRq41ZjeYK23awphM9BFnpz538tNHSAdqT6TG4NjZ/m9IGvUFisQIuzxxRGu5d
         /TZBOBZCOQtXRPLmPqL7pBd8ieferD1N1mIBnTOdZqkCpFV8QwngM8tA+W6oJJxvxFSZ
         2cwtPu0m+rlWgb6ZZ1f3zZ4SuxK8zcSxMEuozmmVBZSEp6N/KUUWPAkqGu706H+TdM9H
         z76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774063842; x=1774668642;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RSTnS2CNzOtgpi/5KarHxhU2fHa8t3c2ByPYxsFVFuQ=;
        b=Gef3oHB2NL4k720xFdlQA6LtIkcdAmSb7zk/a2GnBnUwLvhZGRPxSh0SchC8tsa+bW
         18e2DdyzdZpob2d5tQdPpU/ckmzY0GoXWCW+rnYxRrEA4AHH/aCjROHck/CNU3bshYDT
         BWYNgDoGmbOlD/dJrVYb14ytwCg3F3594bjXGXeIqiCOVpiNUhouvnOKufBA7gPTcM/2
         yOA9rDASCDDxG+0CaMoiZfzoAgPwxX5++WY3cQkW1NEC73OLr5xL3SjydxOttDUhJDxC
         XibFiH75KNWGvY+ocMcSYH12786kYlXbkHtfKiW4M3hcHJZVLADU5vtz3ZDgbwDJlp98
         EJ1w==
X-Forwarded-Encrypted: i=1; AJvYcCW/pvg5sEnL8Ueq6vF0MKLEdHDhAAeCGlAjYncYIxO1g3aXqMiYNDwfcz4jAUbMpVlUCHJagGU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyazv4oOWnAf09qt/6Gu0W4ql491OOqCNkbMtJJlV03YNWiBDfT
	ZWE7m8CkDEjHGi4bxK1ZKiOj3uXrgd0U0aOwKbMEtr7gmSiYnNITD82mWyRwQr3jIh5H7p+V
X-Gm-Gg: ATEYQzyOsJnm5UxmD2ivvP0xHnZcJPz/k2j0zKH+Zo012AIettYby33mAbWQjhsD3Ne
	pwjUc6mbn6PFsmKTO91Iow1OQsrRemFURR8p64cE+hIyj2pvGJqp4fXTpS2jDrRKwkA+dZ6AogT
	nREJH9v2hrufYycVDzdi8oYPeTBn+5DosFq0oNxW40W4pofIEemHi8sW32j9f+7ktf6D0tjysZG
	ct4zzqX2b/GIeiNlVLyJ0HZGIkcD2HuqbvjOYZ+VMdZ0ZqwH7Z62AhFZP3k66/jJIk6KWCnhY/f
	zBFVGzR881+UCnUxIgIRaKZbnHJR/N97bJ0Eb30rmPimigeLCCUgRFGtEnu81zegEBLxAxKMdx7
	iCoEPI1s5AHdp4WbBedKInlTbP4rEhErbQIBQdLA9jzIxeiWTNuaeFsgq7Kmum2knGRUMctcEeb
	ldssefvqJ/jKPQB7lMy6A=
X-Received: by 2002:a17:902:c94b:b0:2ae:7edd:c86f with SMTP id d9443c01a7336-2b077127329mr83526885ad.4.1774063842162;
        Fri, 20 Mar 2026 20:30:42 -0700 (PDT)
Received: from fedora ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b0836556desm52025255ad.47.2026.03.20.20.30.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Mar 2026 20:30:41 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com
Cc: kuba@kernel.org,
	jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH] tls: reject attaching TLS to sockets already in sockmap
Date: Sat, 21 Mar 2026 11:30:27 +0800
Message-ID: <20260321033027.4044119-1-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-270164-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,cloudflare.com,queasysnail.net,davemloft.net,redhat.com,vger.kernel.org,gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[netdev];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8EA062E31BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

When a socket is first inserted into a sockmap with a verdict program,
then TLS is enabled on that socket, the TLS strparser's saved_data_ready
callback becomes sk_psock_verdict_data_ready(). This function calls
tcp_read_skb() which drains ALL skbs from sk_receive_queue without
updating tp->copied_seq when the BPF verdict is SK_PASS. This leaves
tcp_inq() returning stale values, causing the TLS strparser to think
data exists in the receive queue when it doesn't.

The result is a WARN_ON_ONCE(!first) in tls_strp_load_anchor_with_queue()
when tcp_recv_skb() returns NULL, and Use-After-Free when
the strparser's frag_list points to skbs that have been unlinked and
are now owned by the sockmap subsystem.

While sk_psock_init() correctly checks inet_csk_has_ulp() to prevent
inserting TLS sockets into sockmaps (blocking "forward order"), tls_init()
does not check for an existing psock, allowing "reverse order" setup.

Fix this by adding a check in tls_init() to reject sockets that already
have a psock attached (i.e., are in a sockmap). This mirrors the
existing guard in sk_psock_init() and ensures mutual exclusion between
TLS and sockmap attachments regardless of the order of operations.

Signed-off-by: Xingwang Xiang <v3rdant.xiang@gmail.com>
---
 net/tls/tls_main.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/net/tls/tls_main.c b/net/tls/tls_main.c
index fd39acf41..d4ac91c50 100644
--- a/net/tls/tls_main.c
+++ b/net/tls/tls_main.c
@@ -1047,6 +1047,8 @@ static void build_protos(struct proto prot[TLS_NUM_CONFIG][TLS_NUM_CONFIG],
 static int tls_init(struct sock *sk)
 {
 	struct tls_context *ctx;
+	struct sk_psock *psock;
+
 	int rc = 0;
 
 	tls_build_proto(sk);
@@ -1056,6 +1058,20 @@ static int tls_init(struct sock *sk)
 		return 0;
 #endif
 
+	/* Reject sockets that are already attached to a sockmap.
+	 * The sockmap verdict path (sk_psock_verdict_data_ready) is
+	 * incompatible with TLS: it drains the receive queue via
+	 * tcp_read_skb() without updating copied_seq, causing the
+	 * TLS strparser to operate on stale queue state.
+	 * This mirrors the check in sk_psock_init() that rejects
+	 * sockets with ULP (TLS) from being inserted into sockmaps.
+	 */
+	rcu_read_lock();
+	psock = sk_psock(sk);
+	rcu_read_unlock();
+	if (psock)
+		return -EBUSY;
+
 	/* The TLS ulp is currently supported only for TCP sockets
 	 * in ESTABLISHED state.
 	 * Supporting sockets in LISTEN state will require us
-- 
2.52.0


