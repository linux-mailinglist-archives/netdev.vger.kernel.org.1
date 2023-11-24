Return-Path: <netdev+bounces-50674-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C0647F69CC
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 01:27:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1E02F1F20F36
	for <lists+netdev@lfdr.de>; Fri, 24 Nov 2023 00:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BD7B370;
	Fri, 24 Nov 2023 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="IG3NDI+0"
X-Original-To: netdev@vger.kernel.org
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424DA10DC
	for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:33 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2c5b7764016so15661741fa.1
        for <netdev@vger.kernel.org>; Thu, 23 Nov 2023 16:27:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700785651; x=1701390451; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zRr0rFRhIAja+Gljgch1Q8003LvnsWZV0PahHhgXGlI=;
        b=IG3NDI+09K6XuaAP1IfjO+/qnmy/2RtNg73oPRyn1lou9p8f+7IpSPDy3ZvxMFkrbX
         /JqLgsZDhrK5F6WASpeXpItO+GzMaWGRrN9JdLPS6kZl/gQG9mGtTGtZHuPypei7dEla
         xWfsGARdMmD2yDjX95Xg8eK7SSVrF/RLsES1Epp/gk8d0+YRIk4Va55DnwJcsFaoSavJ
         ru0JO97OVDfwq19izDgfmKcV2+pc5dcJI4tlNiqdHRpvRxWtt7rGAFnXqjDd7e0QWeoy
         l9mbKI3SBlQi1y8BJgDa3TT6kp7c2cLqzNMyVHBk5+u7JnVqp1LmqBEM6/4epag+8Ew3
         HccQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700785651; x=1701390451;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zRr0rFRhIAja+Gljgch1Q8003LvnsWZV0PahHhgXGlI=;
        b=SJfEiUIT13Y7k2A9a1t9VBpALDjAHXJFIB26C+0k6vfyvNcRJyFh0hUDRgJMmIGor+
         yRNoeOsV7XzvV29DcC0zuevQBXCFakfz69ggqgb21FzcbxifFn5R8xKNSADYYGo9CUCg
         PpAO8ESrH8+L2kib0UWvEP0iT6MmoiKt9B40KNuM97wmpKUco0t4SL41WY+w+ORES82g
         geAjucXvko37JsrKzGi9AsZutXCs59HhpcTCLsyH/6hKQ7sfuIcTcAekM0cttEbsdclD
         doZoXqY3pZbOLTKnefemY0QFLu2GLFao6ax/D+5KY8SwUtGANKRWmt9blrOWqVAd5pHF
         NzNA==
X-Gm-Message-State: AOJu0YyQwdPATfnzlyzqgxJSvSJsElR7xBJD9QYRf4SQlfM0vihn0Hrm
	D1GQ8irTitUBMmZSNpQSb1ZbUQ==
X-Google-Smtp-Source: AGHT+IECNSLVVGbdrioLI0SEhRdQ/Bu8ddJ4oMGkht/Q/SYm0am/9reyIFf79jCbTgCBwH7mtPYWpA==
X-Received: by 2002:a2e:7d18:0:b0:2c8:330b:7181 with SMTP id y24-20020a2e7d18000000b002c8330b7181mr632580ljc.38.1700785651438;
        Thu, 23 Nov 2023 16:27:31 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id g9-20020a05600c310900b004094e565e71sm3453230wmo.23.2023.11.23.16.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Nov 2023 16:27:30 -0800 (PST)
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
Subject: [PATCH v2 2/7] net/tcp: Consistently align TCP-AO option in the header
Date: Fri, 24 Nov 2023 00:27:15 +0000
Message-ID: <20231124002720.102537-3-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124002720.102537-1-dima@arista.com>
References: <20231124002720.102537-1-dima@arista.com>
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


