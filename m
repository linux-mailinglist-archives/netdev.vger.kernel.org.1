Return-Path: <netdev+bounces-51844-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55AD07FC67D
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 21:58:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 736BF1C23AA0
	for <lists+netdev@lfdr.de>; Tue, 28 Nov 2023 20:58:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0DFFC42AB8;
	Tue, 28 Nov 2023 20:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="MO7xJVuT"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA04219B6
	for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:07 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-40b472f99a0so19577215e9.3
        for <netdev@vger.kernel.org>; Tue, 28 Nov 2023 12:58:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1701205086; x=1701809886; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gU+yhXqKVHhVs+IYT9IgohYNUQjtqLoZ0jYqAIsCX6s=;
        b=MO7xJVuT8lA7/8O0ozrsoah9ij51r3B0sf8vjErFxYlh+H+eQwrEWb79q4+lXIQQDF
         hLFCngZ9Zp3mgsBkrtGrY26NA3AdvqPrZjTCwX9eXSolZPuwx9Frcgsm2kHSnvJfHwtK
         O05BwcYFOEWn9BL7/bgSTE27NCWVHaJ/BUfWp/DezJaFsoG8oVWymGNfp5G6rF2RrRuA
         mLGGz66zdoTg6XRPgfLnkAtA9IR4BquAoG1EQ2yMwbdwpQ7FgeRAovi0Zz/iP7ejhjZO
         JU2auAf4e8+Rc419S0tUtmaNdhDkEwqtOneVZDVQRORNvfTdB2l+GHbtkcm9JtUkjSYL
         Z4+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701205086; x=1701809886;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gU+yhXqKVHhVs+IYT9IgohYNUQjtqLoZ0jYqAIsCX6s=;
        b=QIFu6kM5wNBHlwJDtYcVaQDDhuysXsexPPI+S7f2DwKFEu9F8su/L5ck+I3iq+K9fa
         CMt5M9podkfEduddfPqVxVoJizgh/oMScoUYIpDc7vk+kBwhakuj8eV1Rz4DxsD30f3E
         54iOuI3pyPeCW6D3Lmj9S3yjRuIHbvQO1ANQIZgi4zMrqwTnCPU/DF0IXuMx55ogjTkn
         dtP0AseDigw1n9wOpRxGjZTIOOF8y03cmQ3yuX41I00gNe9Eeer54lq6GDk7NcY6pdyF
         cf0OWisDkTarfUfPqwCR4M4YdrrwaFrmA4Mgnz8/fB0WUfxgMjJrbPP4RDcp2t608c0j
         x3Bw==
X-Gm-Message-State: AOJu0Yyt8I/gVfb7r3w7jnD0lGK/NoYt4A1Xd/Gt7vH+D8o8sgUwIq5Z
	TlCvqFUcK2RH5KgKBI4WgDq+XA==
X-Google-Smtp-Source: AGHT+IGRJhLOz68CyWt+uWxEHQ1q/wUZS65xplXhlbYz3N9MMinyCYfBaknNbx91xDrhSUGW8liVIg==
X-Received: by 2002:a05:600c:46d3:b0:405:1bbd:aa9c with SMTP id q19-20020a05600c46d300b004051bbdaa9cmr11148170wmo.34.1701205086447;
        Tue, 28 Nov 2023 12:58:06 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id o19-20020a05600c4fd300b0040b45356b72sm9247423wmq.33.2023.11.28.12.58.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Nov 2023 12:58:05 -0800 (PST)
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
Subject: [PATCH v3 7/7] net/tcp: Don't store TCP-AO maclen on reqsk
Date: Tue, 28 Nov 2023 20:57:49 +0000
Message-ID: <20231128205749.312759-8-dima@arista.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231128205749.312759-1-dima@arista.com>
References: <20231128205749.312759-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This extra check doesn't work for a handshake when SYN segment has
(current_key.maclen != rnext_key.maclen). It could be amended to
preserve rnext_key.maclen instead of current_key.maclen, but that
requires a lookup on listen socket.

Originally, this extra maclen check was introduced just because it was
cheap. Drop it and convert tcp_request_sock::maclen into boolean
tcp_request_sock::used_tcp_ao.

Fixes: 06b22ef29591 ("net/tcp: Wire TCP-AO to request sockets")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/linux/tcp.h   | 8 ++------
 net/ipv4/tcp_ao.c     | 4 ++--
 net/ipv4/tcp_input.c  | 5 +++--
 net/ipv4/tcp_output.c | 9 +++------
 4 files changed, 10 insertions(+), 16 deletions(-)

diff --git a/include/linux/tcp.h b/include/linux/tcp.h
index 68f3d315d2e1..b646b574b060 100644
--- a/include/linux/tcp.h
+++ b/include/linux/tcp.h
@@ -169,7 +169,7 @@ struct tcp_request_sock {
 #ifdef CONFIG_TCP_AO
 	u8				ao_keyid;
 	u8				ao_rcv_next;
-	u8				maclen;
+	bool				used_tcp_ao;
 #endif
 };
 
@@ -180,14 +180,10 @@ static inline struct tcp_request_sock *tcp_rsk(const struct request_sock *req)
 
 static inline bool tcp_rsk_used_ao(const struct request_sock *req)
 {
-	/* The real length of MAC is saved in the request socket,
-	 * signing anything with zero-length makes no sense, so here is
-	 * a little hack..
-	 */
 #ifndef CONFIG_TCP_AO
 	return false;
 #else
-	return tcp_rsk(req)->maclen != 0;
+	return tcp_rsk(req)->used_tcp_ao;
 #endif
 }
 
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index fe68983fcf26..88c0a858534e 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -846,7 +846,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 	const struct tcp_ao_hdr *aoh;
 	struct tcp_ao_key *key;
 
-	treq->maclen = 0;
+	treq->used_tcp_ao = false;
 
 	if (tcp_parse_auth_options(th, NULL, &aoh) || !aoh)
 		return;
@@ -858,7 +858,7 @@ void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 
 	treq->ao_rcv_next = aoh->keyid;
 	treq->ao_keyid = aoh->rnext_keyid;
-	treq->maclen = tcp_ao_maclen(key);
+	treq->used_tcp_ao = true;
 }
 
 static enum skb_drop_reason
diff --git a/net/ipv4/tcp_input.c b/net/ipv4/tcp_input.c
index 0a58447c33b1..9bcbde89ab5c 100644
--- a/net/ipv4/tcp_input.c
+++ b/net/ipv4/tcp_input.c
@@ -7187,11 +7187,12 @@ int tcp_conn_request(struct request_sock_ops *rsk_ops,
 	if (tcp_parse_auth_options(tcp_hdr(skb), NULL, &aoh))
 		goto drop_and_release; /* Invalid TCP options */
 	if (aoh) {
-		tcp_rsk(req)->maclen = aoh->length - sizeof(struct tcp_ao_hdr);
+		tcp_rsk(req)->used_tcp_ao = true;
 		tcp_rsk(req)->ao_rcv_next = aoh->keyid;
 		tcp_rsk(req)->ao_keyid = aoh->rnext_keyid;
+
 	} else {
-		tcp_rsk(req)->maclen = 0;
+		tcp_rsk(req)->used_tcp_ao = false;
 	}
 #endif
 	tcp_rsk(req)->snt_isn = isn;
diff --git a/net/ipv4/tcp_output.c b/net/ipv4/tcp_output.c
index 3ddd057fb6f7..335ab90afe65 100644
--- a/net/ipv4/tcp_output.c
+++ b/net/ipv4/tcp_output.c
@@ -3720,7 +3720,6 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 	if (tcp_rsk_used_ao(req)) {
 #ifdef CONFIG_TCP_AO
 		struct tcp_ao_key *ao_key = NULL;
-		u8 maclen = tcp_rsk(req)->maclen;
 		u8 keyid = tcp_rsk(req)->ao_keyid;
 
 		ao_key = tcp_sk(sk)->af_specific->ao_lookup(sk, req_to_sk(req),
@@ -3730,13 +3729,11 @@ struct sk_buff *tcp_make_synack(const struct sock *sk, struct dst_entry *dst,
 		 * for another peer-matching key, but the peer has requested
 		 * ao_keyid (RFC5925 RNextKeyID), so let's keep it simple here.
 		 */
-		if (unlikely(!ao_key || tcp_ao_maclen(ao_key) != maclen)) {
-			u8 key_maclen = ao_key ? tcp_ao_maclen(ao_key) : 0;
-
+		if (unlikely(!ao_key)) {
 			rcu_read_unlock();
 			kfree_skb(skb);
-			net_warn_ratelimited("TCP-AO: the keyid %u with maclen %u|%u from SYN packet is not present - not sending SYNACK\n",
-					     keyid, maclen, key_maclen);
+			net_warn_ratelimited("TCP-AO: the keyid %u from SYN packet is not present - not sending SYNACK\n",
+					     keyid);
 			return NULL;
 		}
 		key.ao_key = ao_key;
-- 
2.43.0


