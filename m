Return-Path: <netdev+bounces-252248-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPT4ELXpcWkONAAAu9opvQ
	(envelope-from <netdev+bounces-252248-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:11:17 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 8994364484
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 10:11:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 3EF41568CD2
	for <lists+netdev@lfdr.de>; Thu, 22 Jan 2026 09:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D5C5D35EDBA;
	Thu, 22 Jan 2026 09:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4iqzBTj+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63E2634D3A5
	for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 09:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769072553; cv=none; b=MHxOa00gysUjAfJllrU6SOI5IBrRSL2s9y3U9rlMMPLn6p02mRd2qhOEV53iNLCvSmetJmk+RtotbvSfibXcTxNmMByhzXLRgzU15rc0nLm6yhhlL8GFzWX6tJInpjI/zsUxuEGyabY74PPkeuIhpcyZnwn7/7JlbLh+CK6K5IU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769072553; c=relaxed/simple;
	bh=34K+76eFg41xT/KBVhWBeQtEBZHFL83MhAy05mpJ7Cc=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=ZKreeAD1Q5BEBNtaHMCgl9OCUPQm8mI/ZFYdvrwndiL/wZA1I89+LJUZ19vnAATsayLrYa+KPDv0xu/aAwmzIp80CnvMzUXFXm4p8LbwcSr1V2EVnsD7H+GYTksPjPJ9Sq3r5tOFpxWlWYqVTy31b8voNstjDi8YknzCSTBohPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4iqzBTj+; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8c52af6855fso94965485a.1
        for <netdev@vger.kernel.org>; Thu, 22 Jan 2026 01:02:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1769072550; x=1769677350; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WxzUokCDYjO/+PBrEc2hFD8BwQnRcCSzk8Bn8EqGldQ=;
        b=4iqzBTj+KnD8OZTDZTErzM2/XNjJ85kVw6BnrVnS8YXLrPDxObnA1ZhS0vu28KMdbU
         V7O+ZuUfY+2cUIBGnhNN1P9eJiuxQLNeOpVkrH6IESVFau7+g3LzGmDUMdQ6Gc1qDjmZ
         H4rVTFHdsIW+Shecatv0fyfoxXG0EsbkORZ8ivarRynrpxH610knNg5BuSlQcSV/ckWx
         3sKTLtDu+67DrKE86gM5N0ly71FgS8mJXZjPLcaLPMNcN0cI7VSslCMaMzICXIWNA3zw
         R858hafKPH1yp/9flzyIoipfiwX8f55CEW0QL8WJzgCutAvirKBBfLT0ShzAk9DCxPu2
         RKkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769072550; x=1769677350;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WxzUokCDYjO/+PBrEc2hFD8BwQnRcCSzk8Bn8EqGldQ=;
        b=lcsbViQAzS2ikwg4JruKBH0obUVEqgGfxhlR8sgoxobQ900o4LYOjpMAYZV785oUGf
         u2T+3gs4QWEcif2QAm1+SdfvjGqER5MkpL4YIquEevRFqT86ZSmrcpk7LcLyA8CigH48
         BOYRhr4MoylLTKwNPlZ13CvJVN+fdyj4OKGgUTahdIEypG4WwuOWyMivlgUFNaru78WR
         BGJ4DPD6H1BmUmtFmGThKjjmv7l90nxP+sNBqD3Fsx4xfK46SjhE/L/2raT1nQLz148x
         El3+J2gktpzApp1ypzCLznkNSCc8oFJh+ENXOghVROV//+Ra93TwdGhpGsWf+ZbC8cwJ
         8X1Q==
X-Forwarded-Encrypted: i=1; AJvYcCV7VedTk5pTL4VsNuBvM2BhSjqgisZ+rRTRl/vWA07GoeisJ2Rx/HwnSzCUXVZMuFGDXQGejio=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKc65PAN/0RYqgT3al5IV58KQUTztOHUK1nOAQ9dvVS5d8uJus
	mWwIHEyKJHCS/EQ9oKNtmGIkLvuyHBKgcjaAlvmD8MjqUs1QkP+KRiJdci0STY/V4y/eHYjEZHr
	ZiE/HXlG+hjNeag==
X-Received: from qvcu8.prod.google.com ([2002:a05:6214:1c08:b0:88f:ca76:451b])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4116:b0:8c6:a92c:5fff with SMTP id af79cd13be357-8c6cce94da9mr997522385a.25.1769072550091;
 Thu, 22 Jan 2026 01:02:30 -0800 (PST)
Date: Thu, 22 Jan 2026 09:02:27 +0000
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.52.0.457.g6b5491de43-goog
Message-ID: <20260122090228.1678207-1-edumazet@google.com>
Subject: [PATCH net-next] tcp: move tcp_stream_memory_free() to tcp.c
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	MV_CASE(0.50)[];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252248-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[google.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[google.com,reject];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,vmlinux.new:url]
X-Rspamd-Queue-Id: 8994364484
X-Rspamd-Action: no action

Moving tcp_stream_memory_free() to tcp.c allows the compiler
to (auto)inline it from tcp_poll() and tcp_sendmsg_locked()
for better performance.

$ scripts/bloat-o-meter -t vmlinux.old vmlinux.new
add/remove: 0/0 grow/shrink: 2/0 up/down: 118/0 (118)
Function                                     old     new   delta
tcp_poll                                     840     923     +83
tcp_sendmsg_locked                          4217    4252     +35
Total: Before=22573095, After=22573213, chg +0.00%

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c      | 13 +++++++++++++
 net/ipv4/tcp_ipv4.c | 14 --------------
 2 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index d5319ebe24525ef9c1f0ea0297eb6c70878e0b29..e4c7cc19de3d9eb45c176ff7e2f71ac5b4f6cd5f 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -517,6 +517,19 @@ static void tcp_tx_timestamp(struct sock *sk, struct sockcm_cookie *sockc)
 		bpf_skops_tx_timestamping(sk, skb, BPF_SOCK_OPS_TSTAMP_SENDMSG_CB);
 }
 
+/* @wake is one when sk_stream_write_space() calls us.
+ * This sends EPOLLOUT only if notsent_bytes is half the limit.
+ * This mimics the strategy used in sock_def_write_space().
+ */
+bool tcp_stream_memory_free(const struct sock *sk, int wake)
+{
+	const struct tcp_sock *tp = tcp_sk(sk);
+	u32 notsent_bytes = READ_ONCE(tp->write_seq) - READ_ONCE(tp->snd_nxt);
+
+	return (notsent_bytes << wake) < tcp_notsent_lowat(tp);
+}
+EXPORT_SYMBOL(tcp_stream_memory_free);
+
 static bool tcp_stream_is_readable(struct sock *sk, int target)
 {
 	if (tcp_epollin_ready(sk, target))
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index f8a9596e8f4d41563896f02329d20b731fe7961f..ffdf52fbf6463b41d7c712f3710b681ecdf6e2d7 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -3418,20 +3418,6 @@ void tcp4_proc_exit(void)
 }
 #endif /* CONFIG_PROC_FS */
 
-/* @wake is one when sk_stream_write_space() calls us.
- * This sends EPOLLOUT only if notsent_bytes is half the limit.
- * This mimics the strategy used in sock_def_write_space().
- */
-bool tcp_stream_memory_free(const struct sock *sk, int wake)
-{
-	const struct tcp_sock *tp = tcp_sk(sk);
-	u32 notsent_bytes = READ_ONCE(tp->write_seq) -
-			    READ_ONCE(tp->snd_nxt);
-
-	return (notsent_bytes << wake) < tcp_notsent_lowat(tp);
-}
-EXPORT_SYMBOL(tcp_stream_memory_free);
-
 struct proto tcp_prot = {
 	.name			= "TCP",
 	.owner			= THIS_MODULE,
-- 
2.52.0.457.g6b5491de43-goog


