Return-Path: <netdev+bounces-279451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAPTODzy4mmrAQEAu9opvQ
	(envelope-from <netdev+bounces-279451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:53:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FE6941FCD9
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 04:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A78A4300D970
	for <lists+netdev@lfdr.de>; Sat, 18 Apr 2026 02:50:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5FD2285C89;
	Sat, 18 Apr 2026 02:50:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="B2D7TSj2"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f201.google.com (mail-pf1-f201.google.com [209.85.210.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F714274B28
	for <netdev@vger.kernel.org>; Sat, 18 Apr 2026 02:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776480601; cv=none; b=actCHWgUN3TS6dNJ43E+srB3QE1F3BP0fUm1W9VKVDJUr2MUJtIup4SzchrbXJqRpmCkKa+lXBcP6VS+QZCaAtBZGFhs/FW5cdJNXuYCQIwbo78YTABblSh+9a2SYeFx2PHQ3BA5Zc2gi/t3LVTks8Gom5ldNiyuGA/DUB+/54M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776480601; c=relaxed/simple;
	bh=dasLaDYleEaQWWm6M/BWN7u99AHezt7M2uOeb25bMxs=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=aw7UMNjVGItu9Htt32bkEZ1yyg3yS34Wx7gFwFq3R00oHi8Zadpaql9ZGWE9WMxVIt9NUtTm9zGmp5JInHmOQ7M6zZOQCZ9JWdSYUDAp8oLSokYyqso//M+jmOOhR4zKu3eo5pqe98RQNc1irPQJGNozLg2rwb9syBTju/hGH1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=B2D7TSj2; arc=none smtp.client-ip=209.85.210.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--kuniyu.bounces.google.com
Received: by mail-pf1-f201.google.com with SMTP id d2e1a72fcca58-82f803658d5so1730835b3a.1
        for <netdev@vger.kernel.org>; Fri, 17 Apr 2026 19:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776480600; x=1777085400; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=7PaSoLPmQ8erSUN2DkmqOMZOW7vLFhm4t10Mk47UyRk=;
        b=B2D7TSj2kvJc/nmSm+DmwgdfuhSRmX6q/mTpUp6aVQ/bEcVvNM9vHY7YV1pKd2bFkc
         v8bE/hmSQenqEBEtzol8+y9Fr4OBdsuVWUkQQ8MhmlNOPQY5tiNzXgWnJ66NtK2nbWlZ
         0JQ0Uzij3sglWgpwzLfJL7sWdQVASXCLTrlPvjlpeKfF515J4NV1W9F0OcWgeDR+tS2D
         L315KKN0zuz4q4xXaQczrY/iip2DaNrnWyIpnJBx4siLJH4s/6+DzbP0cU9KUtdAFlfK
         lDo2pN7N6xNMaKcGw1AwKKU5eJVHVP/yEdr1+HMs6cfSPH0FcMPAPmPaYlaUEFzCfSO9
         fcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776480600; x=1777085400;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7PaSoLPmQ8erSUN2DkmqOMZOW7vLFhm4t10Mk47UyRk=;
        b=brdOAe9zUdbmjpUYSNhepdYl/dpfDiv+3n5Msb2fv3x99JWK4pGNxgXxTyYrnrIwr6
         HycUyvuRiEVYAYYwtEmkcb3AmBGL4L8IinQqrDdVl1WBbYfyj5zLCn2b4kGYzvwQdjNi
         CF6MvT3G4PaQR5lnvrGEnkESQh0YEPZA3N/OvL/mTGCg7BsMTmf8buXF0pL25kooj+1x
         6t9vJt8j23nsSgEMH5fjR2+xakV62vrYzI81yRuyL9Kt+JY4HkNopljfAeVSsU/EFY9S
         bDBuSGQgEj1yrAbre8/0PSHK6aL+Jh0u7Upc+Z3QP0DZM0jTbm1O6XP+vQXOQMH9/Iqr
         obdg==
X-Forwarded-Encrypted: i=1; AFNElJ/+AuSIUMco0L1FR8wUVuxgBAl5cAQI17l5p8yhFjJqRmUEP4//jUCwNfwY8oegzkyPn50VPys=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfSkgvrgJFWxEHukJV3u6pL5NTA8V2MMYRhYfR1O90Lm+YSUQv
	X5HuSQihLMZP2yLApG5Kzz4+l2MbAzoc5YbSIVK5bws3saclaGPDW8/sHnkUSFJlIEk/v9PcSfR
	4uhCcVA==
X-Received: from pfqz17.prod.google.com ([2002:aa7:9e51:0:b0:82f:2cac:686a])
 (user=kuniyu job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:cc5:b0:82f:3ecc:c42f
 with SMTP id d2e1a72fcca58-82f8c90d307mr5746954b3a.40.1776480599499; Fri, 17
 Apr 2026 19:49:59 -0700 (PDT)
Date: Sat, 18 Apr 2026 02:49:55 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260418024957.2669737-1-kuniyu@google.com>
Subject: [PATCH v1 net] tcp: Disable usec TS for SYN Cookie.
From: Kuniyuki Iwashima <kuniyu@google.com>
To: Eric Dumazet <edumazet@google.com>, Neal Cardwell <ncardwell@google.com>, 
	"David S. Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Kuniyuki Iwashima <kuni1840@gmail.com>, netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-279451-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,google.com,gmail.com,vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuniyu@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4FE6941FCD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

cookie_tcp_reqsk_alloc() sets tcp_rsk(req)->req_usec_ts to false
unconditionally.

If want_cookie is true in tcp_conn_request(), we should not set
tcp_rsk(req)->req_usec_ts.

Let's not call dst_tcp_usec_ts() for SYN Cookie.

Fixes: 614e8316aa4c ("tcp: add support for usec resolution in TCP TS values")
Signed-off-by: Kuniyuki Iwashima <kuniyu@google.com>
---
 net/ipv4/syncookies.c | 3 ---
 net/ipv4/tcp_input.c  | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/net/ipv4/syncookies.c b/net/ipv4/syncookies.c
index b5f0a65c6786..f5cd9e325d01 100644
--- a/net/ipv4/syncookies.c
+++ b/net/ipv4/syncookies.c
@@ -76,12 +76,9 @@ u64 cookie_init_timestamp(struct request_sock *req, u64 now)
 	if (ts > ts_now)
 		ts -= (1UL << TSBITS);
 
-	if (tcp_rsk(req)->req_usec_ts)
-		return ts * NSEC_PER_USEC;
 	return ts * NSEC_PER_MSEC;
 }
 
-
 static __u32 secure_tcp_syn_cookie(__be32 saddr, __be32 daddr, __be16 sport,
 				   __be16 dport, __u32 sseq, __u32 data)
 {
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index cba89733d121..8bf202b95c68 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7720,7 +7720,8 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 		st = af_ops->init_seq_and_ts_off(net, skb);
 
 	if (tmp_opt.tstamp_ok) {
-		tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
+		if (!want_cookie)
+			tcp_rsk(req)->req_usec_ts = dst_tcp_usec_ts(dst);
 		tcp_rsk(req)->ts_off = st.ts_off;
 	}
 	if (!want_cookie && !isn) {
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


