Return-Path: <netdev+bounces-121282-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 20E7295C86C
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 10:53:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 84D39B24092
	for <lists+netdev@lfdr.de>; Fri, 23 Aug 2024 08:53:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81AD41494A2;
	Fri, 23 Aug 2024 08:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="SUMuf+H/"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C393013E04C
	for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 08:53:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724403208; cv=none; b=AR4H2OMt5CeZkCws3uRXyiLq8WXIRnhGNf9VmHDATbAi5tWWDXIdylquQbi0aRm2fATp0tvQr1LvABKW3nQDRuq+nuFWubndVpvGwp8uvwkjhSl1V476rjMz0o9dGdb5siyaMYOrfD1hlImqrpErjiCPE2yKjhm7ZLMElKcfWH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724403208; c=relaxed/simple;
	bh=Czg/K8OYgGDUZKZ32LDsFwF1lH6BFPUIGzT9yRSBDJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=OufILy5hq4rTw8RpodRvTUCW1m56UhihPpFbFHiLCMDe0wWDFD1RTn68IsD/FcjZLK1/5YfPlySi1ReGpqwt9V0U4GowjJdbkvC3335U5NtNpK0gVSELo6v0tcGIJAnXtBcI25BW9Doe6Kst5kqgHNQrwNx10Vvnn0RkFBqB0Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=SUMuf+H/; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-2d3ce556df9so1274082a91.0
        for <netdev@vger.kernel.org>; Fri, 23 Aug 2024 01:53:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1724403206; x=1725008006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=ezFQroxpGkaUsSdMcah57ZHaQ9w5KjbUOSox/PwRH50=;
        b=SUMuf+H/LY7unKIiQ3uFyTTubrpi0/t7bx/ytZuaDRyZFqkf9E2tiBMh31X9H5NYZ0
         qBnee29k7Th69WqQKu5Ev9nKraQ0BInB/QZJIMpR9WZwRuPfC24DL+1ge8NJdyN/SdhK
         UtXZIO8KH579RCdKWOstRNNb9+XqB+5Oep+TRFeC78cOeDbMzBCB34DL63DB7ETrv4fw
         aG6AD3/c6/a5QH5ZrHF4S+tkdTEkO14B1MkDJ7ngCyIiy6ZjA1Vf9eOkMi8GomOlPV15
         pXlBu2yArknbGKrZAinhdyfLU0bjEPPJwNEZzWjGkCw4rKujChMVT60eSYEEPQ6rGWPW
         ZYkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724403206; x=1725008006;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ezFQroxpGkaUsSdMcah57ZHaQ9w5KjbUOSox/PwRH50=;
        b=m+Vb8EK9OBSSuHX9zM7Y5ersOe9oZTPxQW1hBsQSlPRxcSBSwwvt7Nd19TwPks6YeF
         hGg4RxYVwk+fh3rdSSDKAIEmo19Aa3umk6z1w6RzTsMoklyYRuos1CSkeMQlmsoCHE9K
         pdRxZKdkGftVZRQfIzV2nX+y4pBmCLgENGIiR0SoAJFuA5w/WzKp8Eii549NhFmZwbmd
         NnjfgAdLhSnfS359GIPO7rrtLWCj3gWF79GeX56JGOt6aA/l5r3HmS0k36xQ6psgj3f3
         /DG8nf8XrqcTpjM/w1hEy2ZjVDLCvYhkTcG0nE1ufQEM54zsMW/GFP9nAfW/5DABQxj5
         AnhA==
X-Gm-Message-State: AOJu0YyV6QdvTWwwLKvlINi7izV9M88ZDHP9CCKg1Vb8LAqTquSpq3kC
	3gfvcvsxhsFL0PIIWmi86Si2U9/uJ88nsF30Ayqt0T1NQzHAYvxrMSAa1K+X82k=
X-Google-Smtp-Source: AGHT+IFaylOAd/toGYXIX2p8c9dCa2PThSma27XXT7LPRvz9cAudRL9wgkqY+ZW7DLfNiPVNny90yw==
X-Received: by 2002:a17:90a:2ce2:b0:2cb:4b88:2aaf with SMTP id 98e67ed59e1d1-2d646bb512amr1410015a91.12.1724403205819;
        Fri, 23 Aug 2024 01:53:25 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2d613b2048fsm3430129a91.54.2024.08.23.01.53.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:53:25 -0700 (PDT)
From: Feng zhou <zhoufeng.zf@bytedance.com>
To: edumazet@google.com,
	davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	andrii@kernel.org,
	martin.lau@linux.dev,
	eddyz87@gmail.com,
	song@kernel.org,
	yonghong.song@linux.dev,
	john.fastabend@gmail.com,
	kpsingh@kernel.org,
	sdf@fomichev.me,
	haoluo@google.com,
	jolsa@kernel.org,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	bpf@vger.kernel.org,
	yangzhenze@bytedance.com,
	wangdongdong.6@bytedance.com,
	zhoufeng.zf@bytedance.com
Subject: [PATCH bpf-next v2] bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
Date: Fri, 23 Aug 2024 16:53:13 +0800
Message-Id: <20240823085313.75419-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

when TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
use ip_queue_xmit, inet_sk(sk)->tos.

So bpf_get/setsockopt needs add the judgment of this case. Just check
"inet_csk(sk)->icsk_af_ops == &ipv6_mapped".

| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202408152034.lw9Ilsj6-lkp@intel.com/
Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
Changelog:
v1->v2: Addressed comments from kernel test robot
- Fix compilation error
Details in here:
https://lore.kernel.org/bpf/202408152058.YXAnhLgZ-lkp@intel.com/T/

 include/net/tcp.h   | 2 ++
 net/core/filter.c   | 6 +++++-
 net/ipv6/tcp_ipv6.c | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/net/tcp.h b/include/net/tcp.h
index 2aac11e7e1cc..ea673f88c900 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -493,6 +493,8 @@ struct request_sock *cookie_tcp_reqsk_alloc(const struct request_sock_ops *ops,
 					    struct tcp_options_received *tcp_opt,
 					    int mss, u32 tsoff);
 
+bool is_tcp_sock_ipv6_mapped(struct sock *sk);
+
 #if IS_ENABLED(CONFIG_BPF)
 struct bpf_tcp_req_attrs {
 	u32 rcv_tsval;
diff --git a/net/core/filter.c b/net/core/filter.c
index ecf2ddf633bf..02a825e35c4d 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5399,7 +5399,11 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 			  char *optval, int *optlen,
 			  bool getopt)
 {
-	if (sk->sk_family != AF_INET)
+	if (sk->sk_family != AF_INET
+#if IS_BUILTIN(CONFIG_IPV6)
+	    && !is_tcp_sock_ipv6_mapped(sk)
+#endif
+	    )
 		return -EINVAL;
 
 	switch (optname) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 200fea92f12f..125c69f1d085 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -92,6 +92,12 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
 #define tcp_inet6_sk(sk) (&container_of_const(tcp_sk(sk), \
 					      struct tcp6_sock, tcp)->inet6)
 
+bool is_tcp_sock_ipv6_mapped(struct sock *sk)
+{
+	return (inet_csk(sk)->icsk_af_ops == &ipv6_mapped);
+}
+EXPORT_SYMBOL_GPL(is_tcp_sock_ipv6_mapped);
+
 static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-- 
2.30.2


