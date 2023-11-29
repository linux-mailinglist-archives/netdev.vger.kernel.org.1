Return-Path: <netdev+bounces-52198-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CBC17FDDBC
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 17:57:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 43EDF28299F
	for <lists+netdev@lfdr.de>; Wed, 29 Nov 2023 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A553B3B79B;
	Wed, 29 Nov 2023 16:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="iVFWG8Dp"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F39E6
	for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:33 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-40b2ddab817so50796135e9.3
        for <netdev@vger.kernel.org>; Wed, 29 Nov 2023 08:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701277051; x=1701881851; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRr0rFRhIAja+Gljgch1Q8003LvnsWZV0PahHhgXGlI=;
        b=iVFWG8DpihDlTH9F531C+DC9jMEnzuolNei2Be/SprkKwz5MNbVlObNlDnxHpUlEXl
         h3inQBmVvkczVX+emm5Hubp8DxvyYjR0/Cjvaywyfa8V54bnFcNNXJnZhfTvLkr4bTEM
         /n6Lm20nzJJuZ3o0agks3M8eW6Be+6z+fgGWXsncLP9TnmUShAtuBxdLVI8r8qoigx4n
         QVdPOMJy3JDzrfot+oba1HFqTg/8d9KG+vsNzxTi/IarXQGKGBPeTtZ21PaLZrBWzhhW
         4/shYei+jck7qpswDshLLmN03xs1i9yaSs4b8PAmmyUs6ln3ukgQJ+JqWug4KjQ/rYT0
         ibXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701277051; x=1701881851;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRr0rFRhIAja+Gljgch1Q8003LvnsWZV0PahHhgXGlI=;
        b=Bjgwk5bOYK0R/qiDCSbWBzVbXPxtJlEYPRromcAXoLvq2V8g4F6Bg4OhH8BdCcj/lG
         KJ5sUMngoXeVGRBvQmlP/vUHYnQL2Z94AhFe0AMggcegeVH1Yn+r2qCU6o4k73j3jxzh
         oLclytG3eWPrrZqStxNVAlaqDpbFxedZFrt8x3CTv5hyJ5vjSNLFMtitpuGIb1coKFuj
         1MbUuvUt6yeTx4mGF9a/sOw2bmP1SSmpQdcYqzhGTmwwu1BrV4hmkbmx5dxA7XfLDCmo
         JnTD/NXUy2nnf9ZXjieTVUnUXTxpNNtSPx7jRiM+2QArsHTYM/DzCotXA0U9M38bsZB/
         xhbQ==
X-Gm-Message-State: AOJu0Yx9nKtU4nc5xGIxU9LXViGpNlhixCpox8zQr9m6EPsxDP0SqvL8
	GXbud8pO7WSJsJXG364fKkr0TA==
X-Google-Smtp-Source: AGHT+IGM0QkYqeGxKXo3pm1Yl1kOXGGz8lTPb97hSGB/Hm4pijFn2omG8mm3Mh5qmVl5MbhGKpHiig==
X-Received: by 2002:a05:600c:4ec7:b0:40b:4b69:b189 with SMTP id g7-20020a05600c4ec700b0040b4b69b189mr4399137wmq.26.1701277051518;
        Wed, 29 Nov 2023 08:57:31 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id s20-20020a05600c45d400b003fe1fe56202sm2876823wmo.33.2023.11.29.08.57.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Nov 2023 08:57:30 -0800 (PST)
From: Dmitry Safonov <dima@arista.com>
To: David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Cc: linux-kernel@vger.kernel.org,
	Dmitry Safonov <dima@arista.com>,
	Dmitry Safonov <0x7f454c46@gmail.com>,
	Francesco Ruggeri <fruggeri05@gmail.com>,
	Salam Noureddine <noureddine@arista.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org
Subject: [PATCH v4 2/7] net/tcp: Consistently align TCP-AO option in the header
Date: Wed, 29 Nov 2023 16:57:16 +0000
Message-ID: <20231129165721.337302-3-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231129165721.337302-1-dima@arista.com>
References: <20231129165721.337302-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently functions that pre-calculate TCP header options length use
unaligned TCP-AO header + MAC-length for skb reservation.
And the functions that actually write TCP-AO options into skb do align
the header. Nothing good can come out of this for ((maclen % 4) != 0).

Provide tcp_ao_len_aligned() helper and use it everywhere for TCP
header options space calculations.

Fixes: 1e03d32bea8e ("net/tcp: Add TCP-AO sign to outgoing packets")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h     | 6 ++++++
 net/ipv4/tcp_ao.c        | 4 ++--
 net/ipv4/tcp_ipv4.c      | 4 ++--
 net/ipv4/tcp_minisocks.c | 2 +-
 net/ipv4/tcp_output.c    | 6 +++---
 net/ipv6/tcp_ipv6.c      | 2 +-
 6 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index b56be10838f0..647781080613 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -62,11 +62,17 @@ static inline int tcp_ao_maclen(const struct tcp_ao_key *key)
 	return key->maclen;
 }
 
+/* Use tcp_ao_len_aligned() for TCP header calculations */
 static inline int tcp_ao_len(const struct tcp_ao_key *key)
 {
 	return tcp_ao_maclen(key) + sizeof(struct tcp_ao_hdr);
 }
 
+static inline int tcp_ao_len_aligned(const struct tcp_ao_key *key)
+{
+	return round_up(tcp_ao_len(key), 4);
+}
+
 static inline unsigned int tcp_ao_digest_size(struct tcp_ao_key *key)
 {
 	return key->digest_size;
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index 7696417d0640..c8be1d526eac 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1100,7 +1100,7 @@ void tcp_ao_connect_init(struct sock *sk)
 			ao_info->current_key = key;
 		if (!ao_info->rnext_key)
 			ao_info->rnext_key = key;
-		tp->tcp_header_len += tcp_ao_len(key);
+		tp->tcp_header_len += tcp_ao_len_aligned(key);
 
 		ao_info->lisn = htonl(tp->write_seq);
 		ao_info->snd_sne = 0;
@@ -1346,7 +1346,7 @@ static int tcp_ao_parse_crypto(struct tcp_ao_add *cmd, struct tcp_ao_key *key)
 	syn_tcp_option_space -= TCPOLEN_MSS_ALIGNED;
 	syn_tcp_option_space -= TCPOLEN_TSTAMP_ALIGNED;
 	syn_tcp_option_space -= TCPOLEN_WSCALE_ALIGNED;
-	if (tcp_ao_len(key) > syn_tcp_option_space) {
+	if (tcp_ao_len_aligned(key) > syn_tcp_option_space) {
 		err = -EMSGSIZE;
 		goto err_kfree;
 	}
diff --git a/net/ipv4/tcp_ipv4.c b/net/ipv4/tcp_ipv4.c
index 5f693bbd578d..0c50c5a32b84 100644
--- a/net/ipv4/tcp_ipv4.c
+++ b/net/ipv4/tcp_ipv4.c
@@ -690,7 +690,7 @@ static bool tcp_v4_ao_sign_reset(const struct sock *sk, struct sk_buff *skb,
 
 	reply_options[0] = htonl((TCPOPT_AO << 24) | (tcp_ao_len(key) << 16) |
 				 (aoh->rnext_keyid << 8) | keyid);
-	arg->iov[0].iov_len += round_up(tcp_ao_len(key), 4);
+	arg->iov[0].iov_len += tcp_ao_len_aligned(key);
 	reply->doff = arg->iov[0].iov_len / 4;
 
 	if (tcp_ao_hash_hdr(AF_INET, (char *)&reply_options[1],
@@ -978,7 +978,7 @@ static void tcp_v4_send_ack(const struct sock *sk,
 					  (tcp_ao_len(key->ao_key) << 16) |
 					  (key->ao_key->sndid << 8) |
 					  key->rcv_next);
-		arg.iov[0].iov_len += round_up(tcp_ao_len(key->ao_key), 4);
+		arg.iov[0].iov_len += tcp_ao_len_aligned(key->ao_key);
 		rep.th.doff = arg.iov[0].iov_len / 4;
 
 		tcp_ao_hash_hdr(AF_INET, (char *)&rep.opt[offset],
diff --git a/net/ipv4/tcp_minisocks.c b/net/ipv4/tcp_minisocks.c
index a9807eeb311c..9e85f2a0bddd 100644
--- a/net/ipv4/tcp_minisocks.c
+++ b/net/ipv4/tcp_minisocks.c
@@ -615,7 +615,7 @@ struct sock *tcp_create_openreq_child(const struct sock *sk,
 	ao_key = treq->af_specific->ao_lookup(sk, req,
 				tcp_rsk(req)->ao_keyid, -1);
 	if (ao_key)
-		newtp->tcp_header_len += tcp_ao_len(ao_key);
+		newtp->tcp_header_len += tcp_ao_len_aligned(ao_key);
  #endif
 	if (skb->len >= TCP_MSS_DEFAULT + newtp->tcp_header_len)
 		newicsk->icsk_ack.last_seg_size = skb->len - newtp->tcp_header_len;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index eb13a55d660c..93eef1dbbc55 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -825,7 +825,7 @@ static unsigned int tcp_syn_options(struct sock *sk, struct sk_buff *skb,
 		timestamps = READ_ONCE(sock_net(sk)->ipv4.sysctl_tcp_timestamps);
 		if (tcp_key_is_ao(key)) {
 			opts->options |= OPTION_AO;
-			remaining -= tcp_ao_len(key->ao_key);
+			remaining -= tcp_ao_len_aligned(key->ao_key);
 		}
 	}
 
@@ -915,7 +915,7 @@ static unsigned int tcp_synack_options(const struct sock *sk,
 			ireq->tstamp_ok &= !ireq->sack_ok;
 	} else if (tcp_key_is_ao(key)) {
 		opts->options |= OPTION_AO;
-		remaining -= tcp_ao_len(key->ao_key);
+		remaining -= tcp_ao_len_aligned(key->ao_key);
 		ireq->tstamp_ok &= !ireq->sack_ok;
 	}
 
@@ -982,7 +982,7 @@ static unsigned int tcp_established_options(struct sock *sk, struct sk_buff *skb
 		size += TCPOLEN_MD5SIG_ALIGNED;
 	} else if (tcp_key_is_ao(key)) {
 		opts->options |= OPTION_AO;
-		size += tcp_ao_len(key->ao_key);
+		size += tcp_ao_len_aligned(key->ao_key);
 	}
 
 	if (likely(tp->rx_opt.tstamp_ok)) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 937a02c2e534..8c6623496dd7 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -881,7 +881,7 @@ static void tcp_v6_send_response(const struct sock *sk, struct sk_buff *skb, u32
 	if (tcp_key_is_md5(key))
 		tot_len += TCPOLEN_MD5SIG_ALIGNED;
 	if (tcp_key_is_ao(key))
-		tot_len += tcp_ao_len(key->ao_key);
+		tot_len += tcp_ao_len_aligned(key->ao_key);
 
 #ifdef CONFIG_MPTCP
 	if (rst && !tcp_key_is_md5(key)) {
-- 
2.43.0


