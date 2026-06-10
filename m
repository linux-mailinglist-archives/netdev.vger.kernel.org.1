Return-Path: <netdev+bounces-297751-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gjCTL76RKWoiZwMAu9opvQ
	(envelope-from <netdev+bounces-297751-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:33:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F8D566B816
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 18:33:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=NKP9dFHU;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297751-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-297751-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD45135F022C
	for <lists+netdev@lfdr.de>; Wed, 10 Jun 2026 16:00:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80E884192EA;
	Wed, 10 Jun 2026 16:00:03 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pg1-f173.google.com (mail-pg1-f173.google.com [209.85.215.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29D8941166E
	for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 16:00:01 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781107203; cv=none; b=P+J4Bipn+zGapq0FDUA/OHzhSBQaddfSUB0X0hxM+xkqXw4VggsMy9U6wRTeusA5tj61wXcKoYMix0Ky9nl+YSCv3RHAp5fVwCzs44fc+KDViaZUDMFOgROTNM9EBprAMCIbYmCGW8avTESyevCh6E/Eb1WYlevkmfyKd8FJ0kM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781107203; c=relaxed/simple;
	bh=WtF70tSYlfV59u8ccX/fbGSpFKSEEQD6mNZHUVlKfVc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=fM1GnFBgpjhdXw4kZleu/Pb2CnpneWVe9O07Uad7W0nnmSDIScacdkDzfn1tbc3rRlXa2p18gPMz5Itqozc+94mBvE4fvJemHazdspYYIWTNO1sFcYk0pWXC9cCIdZIz0QnO3b3yvHIgrkwLPR/ilnVfXJ/XQRbhHFqg/Gti6/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NKP9dFHU; arc=none smtp.client-ip=209.85.215.173
Received: by mail-pg1-f173.google.com with SMTP id 41be03b00d2f7-c855599a77aso3527624a12.0
        for <netdev@vger.kernel.org>; Wed, 10 Jun 2026 09:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781107201; x=1781712001; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tvEcYgkrIYlG7OjV31xLPt6UwG/Rf1sskqXVnMDutYA=;
        b=NKP9dFHUeNChZ6wKKaWkIsUekZ4OyV3k1qgZILAea4yOXogtKaHUKN3zTSSC3yfucl
         ohDdUpFXr+GT0FaT/QiVVwd+AcNDZv9MnzBZQ+9lLmR5dtHodxUots0aAhtcQI+gsofn
         r9FMqobw3Mf+6OTbTecE1xUFvhbJFfjt1xdwEkHztokY4YeFNnf5TKR0Bf2ZQWs/c0Oa
         ADqM43zCzNspxNHebdhoMztDTvzIqQVdo7MQTNA9Zf4Yf8tH7FH0UmtJzldqN/f5h9F+
         WRWuXK4BJCNOUg0OuKPg8TVB50uOe7qw7wfckWQO6Qqx5Yz2IL2y09Btd3eV97wA65+e
         SFog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781107201; x=1781712001;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tvEcYgkrIYlG7OjV31xLPt6UwG/Rf1sskqXVnMDutYA=;
        b=L1+syanRienFODsUvi49MKdFCMDF+g022LvkAuWNaPcjmqn+/TgUiQZZvEMfRBNE5C
         IylkqZxy7my0joFuqUr+9EE5JUJa8rRv7wWrnLJt9aEiA8vH/eox+Vy5vlpBXyFEqOlO
         OY4jJR7OwZlNAgb/HRSXuT7wj5E9boYiXauMP11uc9Kz9XUOjo8BNP0tjdnVt0tF+oTR
         0kPNXDUt37fFmip0V8Q+85aDA5KRnx9yjxAw7pEHzfd0C0bgGeNFGAx/+yOlo0Wxzrq3
         ovzs1aUoQS87xGGx/Wr0ZuYqjDGEk38CpIbUr1jRWSrSkBcOFArMFeEqNtCPcHakbNqS
         YpOA==
X-Forwarded-Encrypted: i=1; AFNElJ+xbGKnzvpRN9JP/rpx8GvRzHZndiV8q+H2WBcbS2IwNTGVuBC99UPNZ1/vFIvDJclFIKVCdhE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzsnR8f3xzCHW+RN+6BLqeyZFdTsqTABZTLNzLcn8YB/ta8Gecf
	9GRh1zKPgEcVvyEPz+hozKgt9h3FIHaaA6Ahw5JEiSNNvOPQq1/hnep/
X-Gm-Gg: Acq92OEZul/X6iLWDKf/quN8OPLFSh8lEQmWnK9TAWu/iShxNAZljxBVdPACI0LaKRp
	XD3kHvxEyygcmAYKtrNlhU6ca+WKyafjwt5BWu2tTJ/LnMlyEMSrgIii3ni14JTqeRveOgw9OhQ
	n/aZRMRS0tjrp4EBPCNZyTOYZjnrgx57B65x5Jr4af2zG7l5RFhf8363B7lgUp6sB0pXz9Q24vN
	nObqnHiqF8QtcyRE59IWi20zgdGIpe3fEMHz1CefZck3RHWKcsj4CDvRvQVpwcg+WWkijtqIq7r
	Wfj2fXjecwHoJdmn0FqTqPH78uMlKgg39ipmKui4b1+dkYW5WogdH5pkNAMRaBX+Q+IrIgBDYB9
	H/9hIFE9SxHj4urJtFC/MGlljyzz3FrqZatEYnLHnOsSKHYc/LZwsi8fLGu2Yg8EbSSNc/JRlzT
	t6pqB7wG0uUq8i4tA746g2qj0Xy2loXpUwJcs2pInL3nlmYv+3sKqLwZxgSnNojk03dqB4bbUJ
X-Received: by 2002:a05:6a21:6e04:b0:3b3:2703:110 with SMTP id adf61e73a8af0-3b4ccd1b49cmr31578364637.4.1781107201346;
        Wed, 10 Jun 2026 09:00:01 -0700 (PDT)
Received: from cps-manycore-1.. ([147.46.174.222])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c85df043ce0sm21362076a12.11.2026.06.10.08.59.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2026 09:00:00 -0700 (PDT)
From: Sechang Lim <rhkrqnwk98@gmail.com>
To: Eric Dumazet <edumazet@google.com>,
	Neal Cardwell <ncardwell@google.com>,
	"David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Kuniyuki Iwashima <kuniyu@google.com>,
	Simon Horman <horms@kernel.org>,
	Alexei Starovoitov <ast@kernel.org>,
	Lawrence Brakmo <brakmo@fb.com>,
	Jiayuan Chen <jiayuan.chen@linux.dev>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org
Subject: [PATCH net v2] tcp: clear sock_ops cb flags before force-closing a child socket
Date: Wed, 10 Jun 2026 15:59:44 +0000
Message-ID: <20260610155946.894878-1-rhkrqnwk98@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297751-lists,netdev=lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:edumazet@google.com,m:ncardwell@google.com,m:davem@davemloft.net,m:kuba@kernel.org,m:pabeni@redhat.com,m:kuniyu@google.com,m:horms@kernel.org,m:ast@kernel.org,m:brakmo@fb.com,m:jiayuan.chen@linux.dev,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:bpf@vger.kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rhkrqnwk98@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,linux.dev:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1F8D566B816

A child socket inherits the listener's bpf_sock_ops_cb_flags via
sk_clone_lock(). If its setup fails in tcp_v4_syn_recv_sock() /
tcp_v6_syn_recv_sock(), the child is freed through put_and_exit, where
inet_csk_prepare_forced_close() drops the socket lock and tcp_done() runs
without it.

If BPF_SOCK_OPS_STATE_CB_FLAG was inherited, tcp_done() -> tcp_set_state()
calls tcp_call_bpf(), which expects the lock and trips sock_owned_by_me():

  WARNING: include/net/sock.h:1799 at tcp_set_state+0x433/0x550
  RIP: 0010:tcp_set_state+0x433/0x550 include/net/sock.h:1799
  Call Trace:
   <IRQ>
   tcp_done+0xba/0x250 net/ipv4/tcp.c:5095
   tcp_v4_syn_recv_sock+0x850/0xa50 net/ipv4/tcp_ipv4.c:1787
   tcp_check_req+0xf30/0x1360 net/ipv4/tcp_minisocks.c:926
   tcp_v4_rcv+0x1047/0x1b50 net/ipv4/tcp_ipv4.c:2164
   </IRQ>

The child is freed before it is ever established, so it should run no
sock_ops callback. Clear its cb flags in inet_csk_prepare_forced_close(),
which covers all forced-close callers.

Suggested-by: Jiayuan Chen <jiayuan.chen@linux.dev>
Fixes: d44874910a26 ("bpf: Add BPF_SOCK_OPS_STATE_CB")
Signed-off-by: Sechang Lim <rhkrqnwk98@gmail.com>
---
v2:
 - move the clearing into inet_csk_prepare_forced_close() (Jiayuan Chen,
   Simon Horman)

v1:
 - https://lore.kernel.org/all/20260605094954.1374489-1-rhkrqnwk98@gmail.com/

 include/net/tcp.h               | 7 +++++++
 net/ipv4/inet_connection_sock.c | 1 +
 2 files changed, 8 insertions(+)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 98848db62894..97eac5fa341c 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -2942,6 +2942,11 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return tcp_call_bpf(sk, op, 3, args);
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk)
+{
+	tcp_sk(sk)->bpf_sock_ops_cb_flags = 0;
+}
+
 #else
 static inline int tcp_call_bpf(struct sock *sk, int op, u32 nargs, u32 *args)
 {
@@ -2959,6 +2964,8 @@ static inline int tcp_call_bpf_3arg(struct sock *sk, int op, u32 arg1, u32 arg2,
 	return -EPERM;
 }
 
+static inline void tcp_clear_sock_ops_cb_flags(struct sock *sk) {}
+
 #endif
 
 static inline u32 tcp_timeout_init(struct sock *sk)
diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index dbcd37dfdc15..209f73a61a1d 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -1290,6 +1290,7 @@ void inet_csk_prepare_forced_close(struct sock *sk)
 	__releases(&sk->sk_lock.slock)
 {
 	/* sk_clone_lock locked the socket and set refcnt to 2 */
+	tcp_clear_sock_ops_cb_flags(sk);
 	bh_unlock_sock(sk);
 	sock_put(sk);
 	inet_csk_prepare_for_destroy_sock(sk);
-- 
2.43.0


