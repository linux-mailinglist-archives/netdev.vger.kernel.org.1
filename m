Return-Path: <netdev+bounces-118378-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AEBF9516E4
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 10:45:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8DF901C2259C
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 08:45:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9784F142904;
	Wed, 14 Aug 2024 08:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b="hg5UqsW6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E3A9137772
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 08:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723625122; cv=none; b=lZ8Sw/WUa32rLpoz2nMrd/wZ+ZMhtFplJGUSrNtGPswuCJD0WHd6gSVAJvfAVrCsbXAeUnfGIr2GfKMUs9pyf3Y3i6weami7hocRCZtqikgWfIJzDhWERXpf4sBOCjH+03e7fmyodnRxr/rBeO/zXcoUNnq999DMWOQchFlhAjc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723625122; c=relaxed/simple;
	bh=rP0BJSU43YUuU9/R8Fx0nn/NVCzVpX9I9QY7RttkZh4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=YXIjmrouvwZVydlPe7+huf4tfbcliKwKpjQhkm163stE5+yZjMSPfOfipvWlWJU1ZagT3YhhRN18g3VcgTFge999/jnd1O7cVVqw/F9ytNM97lHjchT/Gin1pG8qsnM6hfKC6RcLcUZ7HfWZyXgxvdVBMNqrlP5aPgoc5LGv040=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com; spf=pass smtp.mailfrom=bytedance.com; dkim=pass (2048-bit key) header.d=bytedance.com header.i=@bytedance.com header.b=hg5UqsW6; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=bytedance.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bytedance.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1fc60c3ead4so43161585ad.0
        for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 01:45:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1723625119; x=1724229919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=TH1M4v3WVE7mB9RLKtgXX+m2D/YPKIYBQHunV/cYH4Y=;
        b=hg5UqsW6IsFbRosFffN4LvKAELoXaTvCfXyJOAdpMzq7g0U4nEtsbyDGNNFW6ylPYZ
         jC7A47Uvy8eBoztewlm6JaHf9yuLfQBoD5iULAaLnUcS3igg/TbMGdfymwWMLcJ5ixmA
         E/VbOh5ckbjgglidHDgHCVOcnZLPY5aF1jYOB5MoEioSQNcNftZusFkk0cbmzFNpShD7
         430ajNK0ImEvudbLQGh49IR/wAe5mDj8eMJMTVhVdxjIkr4fULp7k1/bhklV5guepmdf
         sxb9Q52rkfp8wDMgyGFolQfWwvfIlakc+rr6Y2M/rYIYhjvoIh18eRiCvJqt2ErJAcbz
         p0XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723625119; x=1724229919;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TH1M4v3WVE7mB9RLKtgXX+m2D/YPKIYBQHunV/cYH4Y=;
        b=CEcMIhJ+RvFmlt8keI71SG8+zjXJk2tY40jUaGamkiAwjqPuwqWnFj5dVTfiX28B1L
         aficxGGTkFwGWs6AwJ4dlPKZHvICshqmTvaBKCxKSOVC1lkhf4woEu0tOuEmULjMUQzh
         Kw+GVPN5IJtFsiQnjJGfEYRAEW50tO3C3PGa25cgVVVoDP5jmpfQFYzRYv5LF/E7b5Cn
         p2Fc/nsFGtbLwkG1IyoOE/vq2YkAnhKpI1vAZb0pmyZiEazFufOH+SEsEAAG2Nvj9uGh
         ik1NQGUhG0OFN+y9WxrrJKNVJizHIFa+uqp305CVpP+m+Tj5rLloVks+XE8vlQheYX6H
         7+Gg==
X-Gm-Message-State: AOJu0YxVGAD18Ji7V2mChP4IVS2bp1AAnN5ZTJKQ1bHIiH08dLD3v627
	+oNi6rhRO5WB0yzqi1XMzttrKytXgb4Z5gIKUKd34WTC7z5Pp4xp5UjcTS2Buek=
X-Google-Smtp-Source: AGHT+IF6U/jKHy8IrZmFjWfX+RHKB/V6pImruUUL82Kvd3FD/Ry4bV66gBZEGB2/4lRsfrz+jjEL7Q==
X-Received: by 2002:a17:903:41c9:b0:201:e634:d84f with SMTP id d9443c01a7336-201e634db7fmr189975ad.59.1723625119315;
        Wed, 14 Aug 2024 01:45:19 -0700 (PDT)
Received: from C02F52LSML85.bytedance.net ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-201cd1a940esm25151785ad.159.2024.08.14.01.45.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Aug 2024 01:45:17 -0700 (PDT)
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
Subject: [PATCH] bpf: Fix bpf_get/setsockopt to tos not take effect when TCP over IPv4 via INET6 API
Date: Wed, 14 Aug 2024 16:45:04 +0800
Message-Id: <20240814084504.22172-1-zhoufeng.zf@bytedance.com>
X-Mailer: git-send-email 2.39.3 (Apple Git-146)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Feng Zhou <zhoufeng.zf@bytedance.com>

When TCP over IPv4 via INET6 API, bpf_get/setsockopt with ipv4 will
fail, because sk->sk_family is AF_INET6. With ipv6 will success, not
take effect, because inet_csk(sk)->icsk_af_ops is ipv6_mapped and
use ip_queue_xmit, inet_sk(sk)->tos.

So bpf_get/setsockopt needs add the judgment of this case. Just check
"inet_csk(sk)->icsk_af_ops == &ipv6_mapped".

Signed-off-by: Feng Zhou <zhoufeng.zf@bytedance.com>
---
 include/net/tcp.h   | 2 ++
 net/core/filter.c   | 2 +-
 net/ipv6/tcp_ipv6.c | 5 +++++
 3 files changed, 8 insertions(+), 1 deletion(-)

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
index 78a6f746ea0b..9798537044be 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -5399,7 +5399,7 @@ static int sol_ip_sockopt(struct sock *sk, int optname,
 			  char *optval, int *optlen,
 			  bool getopt)
 {
-	if (sk->sk_family != AF_INET)
+	if (sk->sk_family != AF_INET && !is_tcp_sock_ipv6_mapped(sk))
 		return -EINVAL;
 
 	switch (optname) {
diff --git a/net/ipv6/tcp_ipv6.c b/net/ipv6/tcp_ipv6.c
index 200fea92f12f..84651d630c89 100644
--- a/net/ipv6/tcp_ipv6.c
+++ b/net/ipv6/tcp_ipv6.c
@@ -92,6 +92,11 @@ static const struct tcp_sock_af_ops tcp_sock_ipv6_mapped_specific;
 #define tcp_inet6_sk(sk) (&container_of_const(tcp_sk(sk), \
 					      struct tcp6_sock, tcp)->inet6)
 
+bool is_tcp_sock_ipv6_mapped(struct sock *sk)
+{
+	return (inet_csk(sk)->icsk_af_ops == &ipv6_mapped);
+}
+
 static void inet6_sk_rx_dst_set(struct sock *sk, const struct sk_buff *skb)
 {
 	struct dst_entry *dst = skb_dst(skb);
-- 
2.30.2


