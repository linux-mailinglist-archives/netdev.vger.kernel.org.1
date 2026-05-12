Return-Path: <netdev+bounces-287333-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8D76EvOhA2qw8QEAu9opvQ
	(envelope-from <netdev+bounces-287333-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:56:03 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F61C52AAB4
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 23:56:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3BAFB3024394
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 21:55:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E3B2397E85;
	Tue, 12 May 2026 21:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dp5/9DON"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10C61396D1A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 21:55:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778622940; cv=none; b=V6nvnd3d9Dj20ZZsfpFzRzxx8P5jsvgTtSNtFPosr2hoRIqlGizL7IAAQNvJq+oJQwMZcRHhYLKuNz9mBUR2bkyBLDmsdV91JsBqXhkKklnXQ7DNZbnkJpxFMF5Bmmf7aW+crgpCKywBeCicNpq90uHZBJWpW29eiqJ97UdPaQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778622940; c=relaxed/simple;
	bh=TfUOE0sRmfRl4WaBLqCiwhevWqhrNiAtWeKBAdeEEFw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j8Snt1m2y+QuwdwZppacemejsCCZ3AO+i9BSAUT+oOw26rnzVAYWux58TN3K2BrIEqbB0zd0qKZb8VXqI0TVsnc0lZ5talsfsedxb+sEh3RL0LKGL0uiSM/+3OdNsQObckUJyFy6FAccimhBBBG0w1D5SgZlaMthlnoNLvjsyds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dp5/9DON; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-8353ca0f1f1so3163032b3a.1
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 14:55:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778622938; x=1779227738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ya6QFCZNOXzUKI88H0bBRc+s+eKBTyGQU2y8sYXv9o=;
        b=dp5/9DONYIGw6HZi07IarNl/mwDilc192b7C+fJZs+cdloEuuscOfTbOZjGVXaJ460
         s7EnWBQU+oqsFOOQjGkPnocf8mN17mhzmC193yr1h1h78aAGLzQzNiCKZZIN4dZVJJwY
         8SBSJVd7GqWNt1ENIVMi0ak7KeQkoKOaW1ccD9T0ZeT7LcfwnUqwcSq/u5DdZTuZDUzc
         qLjoIBEP2zOMT2ZenNfwwMdNHnjyWmMdsgaKMKMM5n2g5phSNnl2zvWeTKEZG7AM1Gfw
         QWgIhB6RlvROZSEItKVDEBZaRe3i8LLvEy8bLvhISz6lo6SMuWoWmmKWq4JUvLLuFHR2
         iMyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778622938; x=1779227738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9Ya6QFCZNOXzUKI88H0bBRc+s+eKBTyGQU2y8sYXv9o=;
        b=YYj7c4OwaKcYeMG3V3wt2SHUF++UxXd5a5gRZO/sfOYOw9NKnhOLF50RX0xUkVgsAB
         mYAPXOOBZWTtLpiXeDSU5V7WU0DbrucCBnAWLOl0fETOJ3gsBtkwy4A3lI4dA0tNaFEI
         oUM25M5m8cPWxBhBuitHAao2h/0kcxyiO3JtNO6t5NWpY/5dT5l0Nkj7gFOpRW/mR2Dy
         szxSN+d4+pNsHbpgWY/tnOOD1EFg8VLRx0FQdzPDdi7yBn5Mop+q30xy8uU+3nm/Q+HL
         ZhAzrUCELhf50f/KAzWXhfuDkpgVbkFkfZrGrqWIplOWHZTJLPj56jWBOeHQB0orQu7z
         XPDw==
X-Gm-Message-State: AOJu0YzpJcIwlthaNPqeOHDZoacqUCnzhrnPPk46cwBvq10jsLjEnjRL
	4NZvFyY8Q70z2DqL2RuaBfstXEuaPxCLaaFwVISyFt9YGNElrZFB4vL64Y7ko+bH
X-Gm-Gg: Acq92OFcDk0kRkiqyfcd7OnZK4MjPLAKGNQlYNFxZbT+5U/xqVxftVV/Nf11JzgU+Bl
	23EpcWXOX0soUZy7D4L79Uu3bYim6QN+44TpEWlML61yASo5r7oc+fehAmcXVN+yWr4S6viNkn5
	/hWKHdCD7pK3zr9VgbbDRbNRzFPkPw1dQEm10RptDEzLj11QQHisyoM5GTnshE7aHiB+Xvzwjh4
	9hmitoO2rInd+JfhRVMl+IsdOmo4cYpCoTEqYukfgdRFG1/zaZVvPoo6JiJnn7DcqUh1PuNUKL8
	uEcyB7E07T6hImZDEBuCt+kTY4nVbmwkFQ9CJCA83rxeQhqIlQ1L0P+p1kpARzsZD1SgeQzvzk/
	22NrsyCFsSj73wbY6vpxNZ5KMfkBfluhi7KRjWIi3gfWKeJ+4DLg6L1j4bHtihzJYVyQw3NatbU
	Qjm92tEr+Vow2QBAERl5d6xmjtvqQpMxTyRYh5oHQ0Kq8eyNyg4oaO7tEWocTPh4EdKb5IpBKA
X-Received: by 2002:a05:6a00:3a14:b0:835:447b:a2ac with SMTP id d2e1a72fcca58-83ee82d6237mr5485143b3a.5.1778622937778;
        Tue, 12 May 2026 14:55:37 -0700 (PDT)
Received: from r912.lan.4v1.in ([182.70.116.80])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-839682abd39sm25100038b3a.52.2026.05.12.14.55.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 14:55:37 -0700 (PDT)
From: Avinash Duduskar <avinash.duduskar@gmail.com>
To: netdev@vger.kernel.org
Cc: achender@kernel.org,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	horms@kernel.org,
	linux-rdma@vger.kernel.org,
	rds-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next] rds: tcp_listen: fix typos in comments
Date: Wed, 13 May 2026 03:25:31 +0530
Message-ID: <20260512215531.1988662-1-avinash.duduskar@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4F61C52AAB4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[avinashduduskar@gmail.com,netdev@vger.kernel.org];
	TO_DN_NONE(0.00)[];
	TAGGED_FROM(0.00)[bounces-287333-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_RCPT(0.00)[netdev];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Two typos in comments:

- "reconneect" -> "reconnect" (block comment above
  rds_tcp_accept_one_path()).
- "acccepted" -> "accepted" (block comment inside
  rds_tcp_conn_slots_available()).

Signed-off-by: Avinash Duduskar <avinash.duduskar@gmail.com>
---
 net/rds/tcp_listen.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/rds/tcp_listen.c b/net/rds/tcp_listen.c
index 08a506aa7ce7..a3db9b057084 100644
--- a/net/rds/tcp_listen.c
+++ b/net/rds/tcp_listen.c
@@ -69,7 +69,7 @@ rds_tcp_get_peer_sport(struct socket *sock)
 
 /* rds_tcp_accept_one_path(): if accepting on cp_index > 0, make sure the
  * client's ipaddr < server's ipaddr. Otherwise, close the accepted
- * socket and force a reconneect from smaller -> larger ip addr. The reason
+ * socket and force a reconnect from smaller -> larger ip addr. The reason
  * we special case cp_index 0 is to allow the rds probe ping itself to itself
  * get through efficiently.
  */
@@ -143,7 +143,7 @@ void rds_tcp_conn_slots_available(struct rds_connection *conn, bool fan_out)
 	 *
 	 * Doing so is necessary to address the case where an
 	 * incoming connection on "rds_tcp_listen_sock" is ready
-	 * to be acccepted prior to a free slot being available:
+	 * to be accepted prior to a free slot being available:
 	 * the -ENOBUFS case in "rds_tcp_accept_one".
 	 */
 	rds_tcp_accept_work(rtn);

base-commit: 73d587ae684d176fac9db94173f77d78a794ea4f
-- 
2.54.0


