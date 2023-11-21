Return-Path: <netdev+bounces-49501-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C07A7F2373
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 03:01:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC70C1F26042
	for <lists+netdev@lfdr.de>; Tue, 21 Nov 2023 02:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BBEF511736;
	Tue, 21 Nov 2023 02:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="ULYOegoU"
X-Original-To: netdev@vger.kernel.org
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A02110
	for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:26 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id 5b1f17b1804b1-40839652b97so19540175e9.3
        for <netdev@vger.kernel.org>; Mon, 20 Nov 2023 18:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700532084; x=1701136884; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ig/YC8MojIs+gaKRoOQN47DED/hcFn6cM8MDHgjia40=;
        b=ULYOegoUtmLrixADn3fPF85w6jcWSsLHj8iyJJtr5d3dER7Y2N3ABdo5RaWu1bXGl0
         njWrQI8sNEb+8Mlwb1F00H780kw7C7k1HwDM8f3u2saXg7ajX4ClwZsRZqQsupib5ljO
         OD031rHf020Iau1GdVibAder1J7jDUxdXJvmxBdViwIAlOuY7lsKQSeWQ/L2nbSKxNp8
         8wzWI41FHzX3Y/L+NChoLQjh2/9EggiW5fJSFJGoWMUDuoIICKnDeE2a16oR/qUQcoGq
         6hx5OGdq36zph1NHuFCGfBt4sPP4ABWU/mAMraNGANQbBV1IIsB0Miix6ZbqUjVrz+Ql
         esdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700532084; x=1701136884;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ig/YC8MojIs+gaKRoOQN47DED/hcFn6cM8MDHgjia40=;
        b=t+Ri7ARhGuI8pcGMiLxBrET9NexNC9lBqvctUrfXRrR8VOMPK9taIgK5W4VwU9NpZ5
         W3QS9L1MBLWWYBFREDCKeEgxsY1CZrDVyltFj7EeDMClGlSiVd/G/utT3RNMHiep1oVL
         j29xPNg43CzmpcRWTHHXuKSOFJLq4UVSH0k1ZOQQMZc1y9tlrma5YNu8JbMvu+ZtI1W2
         4q8pP2Neb5IsVRSbSMbyWogZt+dMewqoiTVfuivBzDjb6j0P6pCeDj4zz5BSivQwTq1x
         XmkBBO1TpdJaCoeHQDuDcMNm4+ZevI8UwauMzcSW9zBoQ63vS97bnglhsUG/lE3U0KtS
         t4Rw==
X-Gm-Message-State: AOJu0YwI2sUOiOQTlOaXJu5JYuyJup4Bufuc8+cQ1RABG/3BrHET3m0B
	r1hpI0+mcSGa09Rq3+LNBhVmCw==
X-Google-Smtp-Source: AGHT+IGTE0K1/edXTf0O51i9Tw3EvycRAYv6DgDyjQ4Bsdh3s32+/vUzUMqBl4qVDwqoTTeEuFgr1Q==
X-Received: by 2002:a05:600c:4510:b0:409:6f6e:d257 with SMTP id t16-20020a05600c451000b004096f6ed257mr8196932wmo.17.1700532084385;
        Mon, 20 Nov 2023 18:01:24 -0800 (PST)
Received: from Mindolluin.ire.aristanetworks.com ([217.173.96.166])
        by smtp.gmail.com with ESMTPSA id c13-20020a056000184d00b00332cb846f21sm2617105wri.27.2023.11.20.18.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Nov 2023 18:01:23 -0800 (PST)
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
Subject: [PATCH 4/7] net/tcp: Reset TCP-AO cached keys on listen() syscall
Date: Tue, 21 Nov 2023 02:01:08 +0000
Message-ID: <20231121020111.1143180-5-dima@arista.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231121020111.1143180-1-dima@arista.com>
References: <20231121020111.1143180-1-dima@arista.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

TCP_LISTEN sockets are not connected to any peer, so having
current_key/rnext_key doesn't make sense.

The userspace may falter over this issue by setting current or rnext
TCP-AO key before listen() syscall. setsockopt(TCP_AO_DEL_KEY) doesn't
allow removing a key that is in use (in accordance to RFC 5925), so
it might be inconvenient to have keys that can be destroyed only with
listener socket.

Fixes: 4954f17ddefc ("net/tcp: Introduce TCP_AO setsockopt()s")
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 include/net/tcp_ao.h |  5 +++++
 net/ipv4/af_inet.c   |  1 +
 net/ipv4/tcp_ao.c    | 14 ++++++++++++++
 3 files changed, 20 insertions(+)

diff --git a/include/net/tcp_ao.h b/include/net/tcp_ao.h
index 647781080613..e36057ca5ed8 100644
--- a/include/net/tcp_ao.h
+++ b/include/net/tcp_ao.h
@@ -270,6 +270,7 @@ int tcp_v6_ao_synack_hash(char *ao_hash, struct tcp_ao_key *ao_key,
 void tcp_ao_established(struct sock *sk);
 void tcp_ao_finish_connect(struct sock *sk, struct sk_buff *skb);
 void tcp_ao_connect_init(struct sock *sk);
+void tcp_ao_listen(struct sock *sk);
 void tcp_ao_syncookie(struct sock *sk, const struct sk_buff *skb,
 		      struct tcp_request_sock *treq,
 		      unsigned short int family, int l3index);
@@ -330,6 +331,10 @@ static inline void tcp_ao_connect_init(struct sock *sk)
 {
 }
 
+static inline void tcp_ao_listen(struct sock *sk)
+{
+}
+
 static inline int tcp_ao_get_mkts(struct sock *sk, sockptr_t optval, sockptr_t optlen)
 {
 	return -ENOPROTOOPT;
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index fb81de10d332..a08d1266344f 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -200,6 +200,7 @@ int __inet_listen_sk(struct sock *sk, int backlog)
 	 * we can only allow the backlog to be adjusted.
 	 */
 	if (old_state != TCP_LISTEN) {
+		tcp_ao_listen(sk);
 		/* Enable TFO w/o requiring TCP_FASTOPEN socket option.
 		 * Note that only TCP sockets (SOCK_STREAM) will reach here.
 		 * Also fastopen backlog may already been set via the option
diff --git a/net/ipv4/tcp_ao.c b/net/ipv4/tcp_ao.c
index c8be1d526eac..71c8c9c59642 100644
--- a/net/ipv4/tcp_ao.c
+++ b/net/ipv4/tcp_ao.c
@@ -1052,6 +1052,20 @@ static int tcp_ao_cache_traffic_keys(const struct sock *sk,
 	return ret;
 }
 
+void tcp_ao_listen(struct sock *sk)
+{
+	struct tcp_sock *tp = tcp_sk(sk);
+	struct tcp_ao_info *ao_info;
+
+	ao_info = rcu_dereference_protected(tp->ao_info,
+					    lockdep_sock_is_held(sk));
+	if (!ao_info)
+		return;
+
+	WRITE_ONCE(ao_info->current_key, NULL);
+	WRITE_ONCE(ao_info->rnext_key, NULL);
+}
+
 void tcp_ao_connect_init(struct sock *sk)
 {
 	struct tcp_sock *tp = tcp_sk(sk);
-- 
2.42.0


