Return-Path: <netdev+bounces-215648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EB17B2FC68
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 16:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD8C7623D68
	for <lists+netdev@lfdr.de>; Thu, 21 Aug 2025 14:20:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CEBD28134C;
	Thu, 21 Aug 2025 14:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mPUEsUZ9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF51624A069
	for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 14:19:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755785947; cv=none; b=SAE+8Vtm5Lkg3N8z0WrI+QiVd9zPIJnegeWVDYRU3qkXdhMCUs/MBR7zEAo5xQIkFVDd4tvXLOmtEcBNUoZqYb3InoZdR6u3RNRfBSLkrzbKbCR0VZ0c7mmc+1YYSIl+xJms2XXgWtNxMmZIiGzwSImHPs9p2GF4vBVr97L/VF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755785947; c=relaxed/simple;
	bh=Navi/mFN5lsTQiPFz9rs7NKI+ibw3H+0LjTjLfjfqnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=TBwTJ3KU23ar11qMysoPid9tSgkxfIDEr7/cF2pZb6X2gEQhXM2/REy3A2zYY9A/O9kbCnRfrVU6e1CJhQ6rnDb2JQf+XcXkV2UMBKuy/WGc1F08mbvmXGMySKoTPIwv9PuErQGqIXsgNhxnYnfU3xSzn0/TxlyS6LlKykwHpBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mPUEsUZ9; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-71f9ee9670eso16118837b3.2
        for <netdev@vger.kernel.org>; Thu, 21 Aug 2025 07:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755785944; x=1756390744; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=3MSN2vI6dd+LemR8Sce+80XQijc/NiAQ4EP5LcAjf6Q=;
        b=mPUEsUZ9F8MXHAa630M138HujsVyaaApu9ufU6eqmlt1l/fwkS3f5tmcguHqMa907t
         WmbQx06R2KqlKpitPThrFGSV/PbFPKGpIZmgBwcFI29U2MefUM4rbAdRIbRlLpsVS8fU
         eXSl5jwSiQHepBnleHfyBjdKEroSsWR8cb+jX7HBWmxffpLxYFUOzwS0OVgQqapZKLIJ
         IfDM0gNm0tb0ClLF1ZWXVNqroajaMjUHpQfxO3DXVRQWxvAtwjlXeq11/QKUutMCsu2f
         CiGjbpvkeFwItPaZzXdfnpxpwYBc2ngcIF14e/4lvZO42Qm/3EtWyhp8xeuYRsOEBIBx
         GbGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755785944; x=1756390744;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3MSN2vI6dd+LemR8Sce+80XQijc/NiAQ4EP5LcAjf6Q=;
        b=XPiSuZ3HppeUDMVllRyndETiOs9neuPqUkQwkpFMxgR0rsrnSKTys/k4wlVVUWDRlj
         jvkSkRDqj6OKG52NYHdULckHR8+KSyFSDAhiiuIopujYdewl3Z2Y1JNWtQ4phHD21+tO
         YnVnx0NAh7wgM2B/uuF/5nsEGMZDbTIlmxPEU2sv+WacpPDY2ZPr1gDLCfrQez6YQ3cb
         ynMfjQ368O5UPr5o8jhnTf9pN/8RMi2GVloKfy8F6WEbKQsUwg0uBph5cc58JJN/bQVN
         CLLnR2ADmG/ab1SGT5kdyNrJuaARROuoF+q/FNcmIRwwVbF2zcWS5/vPmlTMj4hVgig0
         eCiQ==
X-Forwarded-Encrypted: i=1; AJvYcCUEshsOgV04c8dxszzty4Fxh6AX/GThHtNvVurRgLpDDCPx6EErlRrv0sGrCfboia4H/azn4KM=@vger.kernel.org
X-Gm-Message-State: AOJu0YzKgSKEqo+UZEvej77Jy+6oLv0pBBTce+nZP2xoeos1N5GXle3X
	OKcq6ozAyT08CGgCjzM/zG7ShpZELsSsuC28Xi6okw8rJhiTbpxY6UzSwNSJOErNuMa5BnPL/Eu
	nNW88JgbQ6z2LPQ==
X-Google-Smtp-Source: AGHT+IHBxLRe67XXXqn7gj1R3BfVwOkse2dIFKEp43pnDaoWL/sS7AsmOTZLJROuKQClfUMYQqJlBb7z5uGs0g==
X-Received: from ybjh19.prod.google.com ([2002:a25:b193:0:b0:e93:4435:f0ae])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6902:6d14:b0:e94:dd5e:5af4 with SMTP id 3f1490d57ef6-e9509840257mr2550525276.30.1755785944660;
 Thu, 21 Aug 2025 07:19:04 -0700 (PDT)
Date: Thu, 21 Aug 2025 14:19:00 +0000
In-Reply-To: <20250821141901.18839-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20250821141901.18839-1-edumazet@google.com>
X-Mailer: git-send-email 2.51.0.rc1.193.gad69d77794-goog
Message-ID: <20250821141901.18839-2-edumazet@google.com>
Subject: [PATCH net-next 1/2] tcp: annotate data-races around tp->rx_opt.user_mss
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Neal Cardwell <ncardwell@google.com>
Cc: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@google.com>, 
	Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

This field is already read locklessly for listeners,
next patch will make setsockopt(TCP_MAXSEG) lockless.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c   | 6 ++++--
 .../net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h   | 2 +-
 net/ipv4/tcp.c                                            | 8 +++++---
 net/ipv4/tcp_input.c                                      | 8 ++++----
 net/ipv4/tcp_output.c                                     | 6 ++++--
 5 files changed, 18 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
index 2e7c2691a1933e5c8d9dc71ec99a5d92970ad7cd..000116e47e38d90802c5dd676c0659fab19bcff3 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.c
@@ -951,6 +951,7 @@ static unsigned int chtls_select_mss(const struct chtls_sock *csk,
 	struct tcp_sock *tp;
 	unsigned int mss;
 	struct sock *sk;
+	u16 user_mss;
 
 	mss = ntohs(req->tcpopt.mss);
 	sk = csk->sk;
@@ -969,8 +970,9 @@ static unsigned int chtls_select_mss(const struct chtls_sock *csk,
 		tcpoptsz += round_up(TCPOLEN_TIMESTAMP, 4);
 
 	tp->advmss = dst_metric_advmss(dst);
-	if (USER_MSS(tp) && tp->advmss > USER_MSS(tp))
-		tp->advmss = USER_MSS(tp);
+	user_mss = USER_MSS(tp);
+	if (user_mss && tp->advmss > user_mss)
+		tp->advmss = user_mss;
 	if (tp->advmss > pmtu - iphdrsz)
 		tp->advmss = pmtu - iphdrsz;
 	if (mss && tp->advmss > mss)
diff --git a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
index 2285cf2df251db9ec84d305d5ffa012279f6c43f..667effc2a23cb78901d65da2712a7e8a66ec81b4 100644
--- a/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
+++ b/drivers/net/ethernet/chelsio/inline_crypto/chtls/chtls_cm.h
@@ -90,7 +90,7 @@ struct deferred_skb_cb {
 
 #define SND_WSCALE(tp) ((tp)->rx_opt.snd_wscale)
 #define RCV_WSCALE(tp) ((tp)->rx_opt.rcv_wscale)
-#define USER_MSS(tp) ((tp)->rx_opt.user_mss)
+#define USER_MSS(tp) (READ_ONCE((tp)->rx_opt.user_mss))
 #define TS_RECENT_STAMP(tp) ((tp)->rx_opt.ts_recent_stamp)
 #define WSCALE_OK(tp) ((tp)->rx_opt.wscale_ok)
 #define TSTAMP_OK(tp) ((tp)->rx_opt.tstamp_ok)
diff --git a/net/ipv4/tcp.c b/net/ipv4/tcp.c
index 71a956fbfc5533224ee00e792de2cfdccd4d40aa..a12d81e01b3f2fb964227881c2f779741cc06e58 100644
--- a/net/ipv4/tcp.c
+++ b/net/ipv4/tcp.c
@@ -3760,7 +3760,7 @@ int tcp_sock_set_maxseg(struct sock *sk, int val)
 	if (val && (val < TCP_MIN_MSS || val > MAX_TCP_WINDOW))
 		return -EINVAL;
 
-	tcp_sk(sk)->rx_opt.user_mss = val;
+	WRITE_ONCE(tcp_sk(sk)->rx_opt.user_mss, val);
 	return 0;
 }
 
@@ -4383,6 +4383,7 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	struct inet_connection_sock *icsk = inet_csk(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
+	int user_mss;
 	int val, len;
 
 	if (copy_from_sockptr(&len, optlen, sizeof(int)))
@@ -4396,9 +4397,10 @@ int do_tcp_getsockopt(struct sock *sk, int level,
 	switch (optname) {
 	case TCP_MAXSEG:
 		val = tp->mss_cache;
-		if (tp->rx_opt.user_mss &&
+		user_mss = READ_ONCE(tp->rx_opt.user_mss);
+		if (user_mss &&
 		    ((1 << sk->sk_state) & (TCPF_CLOSE | TCPF_LISTEN)))
-			val = tp->rx_opt.user_mss;
+			val = user_mss;
 		if (tp->repair)
 			val = tp->rx_opt.mss_clamp;
 		break;
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 71b76e98371a667b6e8263b32c242363672d7c5a..7b537978dfe6b436c723815f1ce64f05f9c1ae61 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -6297,7 +6297,7 @@ static bool tcp_rcv_fastopen_synack(struct sock *sk, struct sk_buff *synack,
 	u16 mss = tp->rx_opt.mss_clamp, try_exp = 0;
 	bool syn_drop = false;
 
-	if (mss == tp->rx_opt.user_mss) {
+	if (mss == READ_ONCE(tp->rx_opt.user_mss)) {
 		struct tcp_options_received opt;
 
 		/* Get original SYNACK MSS value if user MSS sets mss_clamp */
@@ -7117,7 +7117,7 @@ u16 tcp_get_syncookie_mss(struct request_sock_ops *rsk_ops,
 		return 0;
 	}
 
-	mss = tcp_parse_mss_option(th, tp->rx_opt.user_mss);
+	mss = tcp_parse_mss_option(th, READ_ONCE(tp->rx_opt.user_mss));
 	if (!mss)
 		mss = af_ops->mss_clamp;
 
@@ -7131,7 +7131,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 {
 	struct tcp_fastopen_cookie foc = { .len = -1 };
 	struct tcp_options_received tmp_opt;
-	struct tcp_sock *tp = tcp_sk(sk);
+	const struct tcp_sock *tp = tcp_sk(sk);
 	struct net *net = sock_net(sk);
 	struct sock *fastopen_sk = NULL;
 	struct request_sock *req;
@@ -7182,7 +7182,7 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 
 	tcp_clear_options(&tmp_opt);
 	tmp_opt.mss_clamp = af_ops->mss_clamp;
-	tmp_opt.user_mss  = tp->rx_opt.user_mss;
+	tmp_opt.user_mss  = READ_ONCE(tp->rx_opt.user_mss);
 	tcp_parse_options(sock_net(sk), skb, &tmp_opt, 0,
 			  want_cookie ? NULL : &foc);
 
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index dfbac0876d96ee6b556fff5b6c9ec8fe2e04aa05..86892c8672ed49a49b85530b648d695ed171a3c8 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3890,6 +3890,7 @@ static void tcp_connect_init(struct sock *sk)
 	const struct dst_entry *dst = __sk_dst_get(sk);
 	struct tcp_sock *tp = tcp_sk(sk);
 	__u8 rcv_wscale;
+	u16 user_mss;
 	u32 rcv_wnd;
 
 	/* We'll fix this up when we get a response from the other end.
@@ -3902,8 +3903,9 @@ static void tcp_connect_init(struct sock *sk)
 	tcp_ao_connect_init(sk);
 
 	/* If user gave his TCP_MAXSEG, record it to clamp */
-	if (tp->rx_opt.user_mss)
-		tp->rx_opt.mss_clamp = tp->rx_opt.user_mss;
+	user_mss = READ_ONCE(tp->rx_opt.user_mss);
+	if (user_mss)
+		tp->rx_opt.mss_clamp = user_mss;
 	tp->max_window = 0;
 	tcp_mtup_init(sk);
 	tcp_sync_mss(sk, dst_mtu(dst));
-- 
2.51.0.rc1.193.gad69d77794-goog


