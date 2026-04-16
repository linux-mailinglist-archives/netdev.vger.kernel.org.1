Return-Path: <netdev+bounces-279154-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MCrTE2JC4WmaqgAAu9opvQ
	(envelope-from <netdev+bounces-279154-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:11:14 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C833D4147C6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 22:11:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D05CC3188BE6
	for <lists+netdev@lfdr.de>; Thu, 16 Apr 2026 20:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17903EE1F1;
	Thu, 16 Apr 2026 20:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="o3CgsJoR"
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f202.google.com (mail-qk1-f202.google.com [209.85.222.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87683AE6E5
	for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 20:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776369830; cv=none; b=bFKFUiEGTJvj9DzCDQ6Pcu4xzc5YApt40NFy9VqCUa8wuVPoxSAsNmTEy6GO131IhCqeUs1t/k0562p/0VbEgNlUVtibFk2V5Y1CpD3abC/F15+Peyo2aJyn6v72CQRTJUiAZDlX2cABeXbRaKaRyDHpGWMGfyfSe0ZYCEaFo3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776369830; c=relaxed/simple;
	bh=AkpilK1YUlvfrMk47epkUAG4ZyX4o96AVIbIGKG84vw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=B4i6rjipyIfFUDZXk6IV3nHq5AVQYrvPdcL7QvTAQFnbH9s5hWhWGyCzh57YNSbhb7QFGYW1Xp71uo9m7vY0LjJ3Z3of46mCDAK4W07zNPKvEgTpxjv6/WgphkDoCB3oUmtChCuXPd6LN5ftCf9mf57gO0Tg4SsqIL201ftU+II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=o3CgsJoR; arc=none smtp.client-ip=209.85.222.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-qk1-f202.google.com with SMTP id af79cd13be357-8cfc648b036so2287808285a.3
        for <netdev@vger.kernel.org>; Thu, 16 Apr 2026 13:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1776369819; x=1776974619; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=ta8uL1X7B7AUOaD2NN/Zk5Kkw/ZbqDpyduQaPW+6yag=;
        b=o3CgsJoRcBVnLoApcrJCRP7TD7I7VllcQuX8aTKbEw4DPrKz7UyXOkc+KVrvdCYUxO
         3aGf+MCVnGorAbn4SndJy7xHl/TqPJXoUKYW+KILzg402cRMlkDeFQJK9kQl0Ms/nbN9
         XYd5ekLp59BUf7SOaWI7Cd5pRbgFXJc/IHNiQsOcvrURFAItXqipxeV6vbFZt0Ojrj7X
         up/a142rCZDsPWLeGutFEamkAiGRpZSKqBwDbx5MGxyiyG9LO/LsccigiluDVXXe0yH2
         amR2IlkM5n3uxBQzFNsI0xdg7NSJBk3Hk/jY3bYtmr8HR93EiOMhTvhxfH1mCAgdGiXx
         uPvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776369819; x=1776974619;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ta8uL1X7B7AUOaD2NN/Zk5Kkw/ZbqDpyduQaPW+6yag=;
        b=mQGqz64jmokok76g5PUaC0ce0Ft5akDD/HueUiHn3HWjruzeW6w2vFeyj7VR9oal/h
         cTF8qMsfUPpTadrNr5lu45e1XiDJmEbKqNDUE7fKQcg2xZCjIg9kzgBmjs2ojUAzrKtp
         EMDTV/si1BzGlPsOGs8fHYyo+/O5VEzmXTGvEsE04qi4YqFp9ntcFwTsGzCquQaTb2ON
         OgdM1HveDyj8+6XWXeLzZI06niOHO9y3OVb6MgtjfxBY+CrQ5EtkyhWEtH2CgEeT2C53
         U0tj+eQ4SMi2OmcpdbhuXjn+eNkRqPawaXBrwzNefOOAdk1C6DIK8hd5Fimi0FObaVQp
         VIig==
X-Forwarded-Encrypted: i=1; AFNElJ/6bejJ8jJEQVe1hTyUlmlj+e9xE2IDeN/c2zOR2/spk/3Dq44Xqd5Jg3hFpgBku8e3ZKfKXbs=@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRcCqqA0/E3egjO7Icgl5FTU7e/TvPHn6lNLzL1nwqDNGVVfc
	m8h4+xbGoRrfmZ4bsmkjEeyR3IHjN7JHMb9IZfrr0XTFW2TwkdRTvTmbhcYL9RPTeNhA9f0vrCl
	ZX6q9C28JQ9Vt9w==
X-Received: from qkbd19.prod.google.com ([2002:a05:620a:31f3:b0:8c7:d9b:8846])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:7084:b0:8c6:a539:55d4 with SMTP id af79cd13be357-8e74b7c3abamr125931385a.48.1776369818502;
 Thu, 16 Apr 2026 13:03:38 -0700 (PDT)
Date: Thu, 16 Apr 2026 20:03:16 +0000
In-Reply-To: <20260416200319.3608680-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260416200319.3608680-1-edumazet@google.com>
X-Mailer: git-send-email 2.54.0.rc1.513.gad8abe7a5a-goog
Message-ID: <20260416200319.3608680-12-edumazet@google.com>
Subject: [PATCH net 11/14] tcp: annotate data-races around tp->srtt_us
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, Neal Cardwell <ncardwell@google.com>, 
	Kuniyuki Iwashima <kuniyu@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,google.com,vger.kernel.org,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-279154-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[edumazet@google.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C833D4147C6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

tcp_get_timestamping_opt_stats() intentionally runs lockless, we must
add READ_ONCE() and WRITE_ONCE() annotations to keep KCSAN happy.

Fixes: e8bd8fca6773 ("tcp: add SRTT to SCM_TIMESTAMPING_OPT_STATS")
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/ipv4/tcp.c       | 5 +++--
 net/ipv4/tcp_input.c | 2 +-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 39a4b06e36bbc63b8bc334c8f568c5a2046573b6..541bd0d2d8c4ed24934fd047dd46e532b30021be 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3623,7 +3623,8 @@ static void tcp_enable_tx_delay(struct sock *sk, int val)
 	if (delta && sk->sk_state == TCP_ESTABLISHED) {
 		s64 srtt = (s64)tp->srtt_us + delta;
 
-		tp->srtt_us = clamp_t(s64, srtt, 1, ~0U);
+		WRITE_ONCE(tp->srtt_us,
+			   clamp_t(s64, srtt, 1, ~0U));
 
 		/* Note: does not deal with non zero icsk_backoff */
 		tcp_set_rto(sk);
@@ -4467,7 +4468,7 @@ struct sk_buff *tcp_get_timestamping_opt_stats(const struct sock *sk,
 			  READ_ONCE(tp->bytes_retrans), TCP_NLA_PAD);
 	nla_put_u32(stats, TCP_NLA_DSACK_DUPS, READ_ONCE(tp->dsack_dups));
 	nla_put_u32(stats, TCP_NLA_REORD_SEEN, READ_ONCE(tp->reord_seen));
-	nla_put_u32(stats, TCP_NLA_SRTT, tp->srtt_us >> 3);
+	nla_put_u32(stats, TCP_NLA_SRTT, READ_ONCE(tp->srtt_us) >> 3);
 	nla_put_u16(stats, TCP_NLA_TIMEOUT_REHASH, tp->timeout_rehash);
 	nla_put_u32(stats, TCP_NLA_BYTES_NOTSENT,
 		    max_t(int, 0, tp->write_seq - tp->snd_nxt));
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 896a5a5a6b1a9a678e5321dd802554ab343f7835..e04ae105893c2bf234e593b1529748283bb2176c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -1132,7 +1132,7 @@ static void tcp_rtt_estimator(struct sock *sk, long mrtt_us)
 
 		tcp_bpf_rtt(sk, mrtt_us, srtt);
 	}
-	tp->srtt_us = max(1U, srtt);
+	WRITE_ONCE(tp->srtt_us, max(1U, srtt));
 }
 
 void tcp_update_pacing_rate(struct sock *sk)
-- 
2.54.0.rc1.513.gad8abe7a5a-goog


