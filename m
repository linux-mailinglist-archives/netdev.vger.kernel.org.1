Return-Path: <netdev+bounces-288747-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIseCi7YCWossQQAu9opvQ
	(envelope-from <netdev+bounces-288747-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:01:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9896B561D3F
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 17:01:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EFE823049713
	for <lists+netdev@lfdr.de>; Sun, 17 May 2026 14:56:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4BCB39023B;
	Sun, 17 May 2026 14:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THJx1t0p"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 248FA2F8EBC
	for <netdev@vger.kernel.org>; Sun, 17 May 2026 14:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779029808; cv=none; b=TJfugHNRSooZ9IAU6CeU60TcBikfxPm1cfQ1jbGhu3B5rN0yNdPHuIkQAUqXGdazDOG78cRh59FUMj5HTETLFXK7BJNEGgG4p8Ls1nSK3ReATO/PF5ZoHNrCry1vH8rtjSF5/IDaO4AaIyZd9bVaZ0vVhYangM9Ia2fgPFt/7x4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779029808; c=relaxed/simple;
	bh=Rycoo0KXcrIGy0V6K13A51qgqDSsTtrcvUpgWndy/lw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a0QXqMjdAEiLIqLduYGWIwZrRUy+CVP75QV8ttJ2dlf8zoAOUVil6eTehHn3hXRVRgU0rVDdb4tjEuh5rUxH/zZP2T0eOUwrIt5nNCLgqYK3w0jBbNEdmkLpTjo5Aw/GxRDQ3WXhh84viTvj1SBMhdxHPivPNfBNDVqnSV8Ai1M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THJx1t0p; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-366330b6751so1164333a91.1
        for <netdev@vger.kernel.org>; Sun, 17 May 2026 07:56:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779029804; x=1779634604; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Cv623DRABOPMrYJwnAldTbL6HQ8FVgC1eRszl+kDjzM=;
        b=THJx1t0podhPnwZ32/8k+6Ifwo91Z+re8AJJdoO2aYIbsleN7lHBq1jPygdWLDO/JK
         /IZzCBnXbE3AFGezoERPoqbBZRQekvcBhSw5Jj4vwxvjSa+p93oDWtvuS6sL4ustWkzz
         aTVTkSgBXKJn/94g+79SRoqUdkL+e9JnEM6iGCfZz11dOv1WR37CRvynH3IpFmjZ4v8f
         hvnPyYzhVUPIUr+XiAd+1D3jKvAnX0crVWY1UWsWinCQLV0v+lOhhTWMoDaWb8bBSiqb
         dSB126Le+kDaGv/xtG0U7aeFNZ9SKtA/7Rl9TmAZOjkAeL1c2kzAYCvVSbAIcpQyPfen
         jgIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779029804; x=1779634604;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Cv623DRABOPMrYJwnAldTbL6HQ8FVgC1eRszl+kDjzM=;
        b=rufKF3vi0jGRYKuCaU9bs0V/GSzvrhGMs8oMiPLcjuNANKGgxB7MHscYVFDuRnWrA4
         6Cneexjkspzwe4caEqCNQc21iocg/gKsyTkDlxFvMM7YwkbDHXbMa4/+y8vn71HLP3kI
         d3D+aRJCzFTtFTcAdEsN4x4TuAXLKfeRq6mxksri+u9QkF2hbRSdPwzD+l2ZPFcO5gai
         ZcwVZTACn1osay3vSGo7eUzDWPgyzaSzNARyQygeE0wRAvfqtnFk+Ps+3XDbRLTPE0xA
         CFFTphOOyhSxHBPuNt1pZ5usiyWvOg0Z1GZaAJGwRH/M3k/NpMsNpO9HvbqPV488JHZ7
         y1aA==
X-Forwarded-Encrypted: i=1; AFNElJ+SvQ+q5CilcVMvtomtJh7g+rASPxZFlmooD9QYo36uJAaVe/myE0EDMoVtv1lVGHUYnknEdwE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwoS6Tq2xuKR7fcR+cy4/NTYxeZ7akvNLL8TEvZCnaEZy0jPCCz
	4VA2xE8g7VgJAtLeJNh8bGPcp9dz83fV9v9ORrBfQym0aUZFsOIZlxy0
X-Gm-Gg: Acq92OH+IhBe2xxFOWCuY4FlNMWSO2w7jmLaKZQ0qDDOkiJoLM19SH0mYWQNDrfgwdm
	xK7I3V9fSYoDs3oakKMQ6VIffguuZm2Fk5KaRIZzy2GGpDEKXwFkc8BkwOibyA3l7xrw2nmwVu2
	+UMVYVsVVWZ1rJ7T93b/YHp6D6PcfmpHGbYjlL9wVVIA9LDQLzMPHrWi9Y2RYitkU0mZIUfkneC
	C855Z8HAumQ6twfS/M+K03pJXX9qvMwDwPaa7oFYV+P6pOpL3uKta4MkSqBqAcU5NwI7Pd7MOA9
	iHEQ3w7F/ziN0Z08dsuInuGCa6UXtw+lqIsZrtl6GWI6l3oaoCmcB0Qljr6SEPqtIE22xSGuU30
	MfQ+dlIT8vAc6XrfHRCCRqEhz4vDMmrA7yBkiEJ8kOJIFuLMAbkadM9GEsOPTYDPKfAzhproNGj
	a3TsY4/HKO+dsthEAQmtNUIt3/j16E4qmzDaevjce9hIXb6g==
X-Received: by 2002:a17:90b:5904:b0:369:1dcf:4a56 with SMTP id 98e67ed59e1d1-36951ca8d1amr11826037a91.21.1779029804514;
        Sun, 17 May 2026 07:56:44 -0700 (PDT)
Received: from fedora.localdomain ([222.20.193.20])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c82bb1006fbsm10392522a12.21.2026.05.17.07.56.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 07:56:44 -0700 (PDT)
From: Xingwang Xiang <v3rdant.xiang@gmail.com>
To: john.fastabend@gmail.com,
	kuba@kernel.org,
	mrpre@163.com
Cc: jakub@cloudflare.com,
	sd@queasysnail.net,
	davem@davemloft.net,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	daniel@iogearbox.net,
	bpf@vger.kernel.org,
	Xingwang Xiang <v3rdant.xiang@gmail.com>
Subject: [PATCH net v5 1/2] bpf, skmsg: fix verdict sk_data_ready racing with ktls rx
Date: Sun, 17 May 2026 23:56:26 +0900
Message-ID: <20260517145630.20521-2-v3rdant.xiang@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
References: <20260517145630.20521-1-v3rdant.xiang@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9896B561D3F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-288747-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[cloudflare.com,queasysnail.net,davemloft.net,redhat.com,kernel.org,vger.kernel.org,iogearbox.net,gmail.com];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,163.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FROM_NEQ_ENVFROM(0.00)[v3rdantxiang@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

sk_psock_strp_data_ready() already checks tls_sw_has_ctx_rx() and
defers to psock->saved_data_ready when a TLS RX context is present,
avoiding a conflict with the TLS strparser's ownership of the receive
queue (commit e91de6afa81c, "bpf: Fix running sk_skb program types
with ktls").

sk_psock_verdict_data_ready() has no equivalent guard.  When a socket
is inserted into a sockmap (BPF_SK_SKB_VERDICT) before TLS RX is
configured, tls_sw_strparser_arm() saves sk_psock_verdict_data_ready
as rx_ctx->saved_data_ready.  On data arrival:

  tls_data_ready -> tls_strp_data_ready -> tls_rx_msg_ready
    -> saved_data_ready() = sk_psock_verdict_data_ready()
      -> tcp_read_skb() drains sk_receive_queue via __skb_unlink()
         without calling tcp_eat_skb(), so copied_seq is not advanced.

tls_strp_msg_load() then finds tcp_inq() >= full_len (stale), calls
tcp_recv_skb() on the now-empty queue, hits WARN_ON_ONCE(!first), and
returns with rx_ctx->strp.anchor.frag_list pointing at a psock-owned
(potentially freed) skb.  tls_decrypt_sg() subsequently walks that
frag_list: use-after-free.

Apply the same fix as sk_psock_strp_data_ready(): if a TLS RX context
is present, call psock->saved_data_ready (sock_def_readable) to wake
recv() waiters and return immediately, leaving the receive queue
untouched.  TLS retains sole ownership of the queue and decrypts the
record normally through tls_sw_recvmsg().

Signed-off-by: Xingwang Xiang <v3rdant.xiang@gmail.com>
---
 net/core/skmsg.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/net/core/skmsg.c b/net/core/skmsg.c
index 6187a83bd..e1850caf1 100644
--- a/net/core/skmsg.c
+++ b/net/core/skmsg.c
@@ -1268,12 +1268,19 @@ static int sk_psock_verdict_recv(struct sock *sk, struct sk_buff *skb)
 static void sk_psock_verdict_data_ready(struct sock *sk)
 {
 	const struct proto_ops *ops = NULL;
+	struct sk_psock *psock;
 	struct socket *sock;
 	int copied;
 
 	trace_sk_data_ready(sk);
 
 	rcu_read_lock();
+	psock = sk_psock(sk);
+	if (psock && tls_sw_has_ctx_rx(sk)) {
+		psock->saved_data_ready(sk);
+		rcu_read_unlock();
+		return;
+	}
 	sock = READ_ONCE(sk->sk_socket);
 	if (likely(sock))
 		ops = READ_ONCE(sock->ops);
@@ -1283,8 +1290,6 @@ static void sk_psock_verdict_data_ready(struct sock *sk)
 
 	copied = ops->read_skb(sk, sk_psock_verdict_recv);
 	if (copied >= 0) {
-		struct sk_psock *psock;
-
 		rcu_read_lock();
 		psock = sk_psock(sk);
 		if (psock)

