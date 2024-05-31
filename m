Return-Path: <netdev+bounces-99779-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A8AE8D6605
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 17:46:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDBF7B21B06
	for <lists+netdev@lfdr.de>; Fri, 31 May 2024 15:46:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30BDE78289;
	Fri, 31 May 2024 15:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gX6SPO7+"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3D8745016
	for <netdev@vger.kernel.org>; Fri, 31 May 2024 15:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717170406; cv=none; b=aWm9zgUyjnncfssmks0zvMFnaAz03h7A/rnbIWh4MUCZ32Y8beNaevn2eePPBxbVYB6kR8fBRY8xPfFgDC9mQonE5f/XFOS+oLae/Ky9lXDoQ+m9YzDT1+PnyhDIjDqgOyiJDJBksClHLY/ka6exbEc7YM5eW6/QuZmV40ox3tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717170406; c=relaxed/simple;
	bh=dsm9suGPGdjMa4Oy2NM/nhLqFguuaLJ2F+9vNall36Y=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=gi42kNjnqL7bQoa40xFP8PF6YirLL7DJU6GO3fi0thdBD3AweyNckMbmPSn/BlV/QiYge5sr9OCpb6YRMp4HYpoTIY1yZv4Hl2y2d3SM4KJGfAefxosUmJ0/XH/93U87elwvqBPMlzsxOu5HIlp+RPhdOriEVZSdY5Bei5QM0nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gX6SPO7+; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1f60a502bb2so16639725ad.3
        for <netdev@vger.kernel.org>; Fri, 31 May 2024 08:46:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1717170404; x=1717775204; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=leggRgse3hmv9KkHIOWtum9XztxDs26M1jxgPARCgWo=;
        b=gX6SPO7+nI5+Dnt/TMaS3+oz0++FiRGoERlrGtt7Z9VZXF2+nmQlmMLltAVwbu+UuV
         wfzjYivI+KArHMu3KILlKsZp1qE3XbFSd2TsYGKRTN92C6Kb1XOxwGR0pwxBaXj8tQk2
         4FG4qv5hxlKDOq3ledRVVbJj40lZxyhEmBMB0A94uaqwn0XbjgZc3+bs1rDoQDzgYoHK
         saK+bkfrd/K3uoolmX3xNBWf1bThcr8v2sfNjJezUvQhP1+Sd0hCCdB6OJcFxYYdsAaF
         lkkl1VCigt5mEoQkFJtBfBy3s0vqkxBCwPOxVrQbqzg00F57CiX7tvHZZv2jTziXlT2n
         rmwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717170404; x=1717775204;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=leggRgse3hmv9KkHIOWtum9XztxDs26M1jxgPARCgWo=;
        b=YZevRITcLicIRwjH4WZnheIKGpjZRnU3lIwxu3u1vTyQqYKqNQzV1SV8Yxt8uJ68p8
         b/eHfUNqrNS1fDjawKXKBzE00L3QAi7O3eUBPD7RFLHB8VZXjZb9in+xuk3PZQ9KsMK3
         iQCOXSU840qkGZrZX5SU9K6MUZs22p7AoXe+JPKw4nltJU1zeZDUi69GuPj3/FM7ODy9
         rhzWSBrh5OBZ9OTEXNzLwmJ4PkIkgjSlMVB87cLzh6QpoXdyhc92BjKgdL7sNhkYjEBd
         o+CvCTLb7wCUc9iVHX+GrQBwZVfnT/CFaB9azr2shAZyQkxbKIVIjV3TKr7/vruNtRjd
         37/w==
X-Gm-Message-State: AOJu0YzvJ1w90cUHWoxwLSVlFiXOwOSyDRt6y3jdIz5nzDzQIiFN+f7p
	PYaOEmRI8Gnf9ZaEgRdzEMP8JjBVR0+hIlsG6sKtgnkyzMfRlPjW87jvVoEe
X-Google-Smtp-Source: AGHT+IHUl+qYWxCG8QAJnlpo3Y9nl0w9E2hL3yMkz0AjlAJMH4aK70OUJAxTJUzBox0XEPEOJUJJZQ==
X-Received: by 2002:a17:903:120b:b0:1e3:dfdc:6972 with SMTP id d9443c01a7336-1f636ffed28mr26110615ad.9.1717170403797;
        Fri, 31 May 2024 08:46:43 -0700 (PDT)
Received: from KERNELXING-MB0.tencent.com ([111.201.28.17])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f632416d90sm18225865ad.285.2024.05.31.08.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 May 2024 08:46:43 -0700 (PDT)
From: Jason Xing <kerneljasonxing@gmail.com>
To: edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	davem@davemloft.net,
	dsahern@kernel.org
Cc: netdev@vger.kernel.org,
	kerneljasonxing@gmail.com,
	Jason Xing <kernelxing@tencent.com>
Subject: [PATCH net-next] net: remove NULL-pointer net parameter in ip_metrics_convert
Date: Fri, 31 May 2024 23:46:34 +0800
Message-Id: <20240531154634.3891-1-kerneljasonxing@gmail.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jason Xing <kernelxing@tencent.com>

When I was doing some experiments, I found that when using the first
parameter, namely, struct net, in ip_metrics_convert() always triggers NULL
pointer crash. Then I digged into this part, realizing that we can remove
this one due to its uselessness.

Signed-off-by: Jason Xing <kernelxing@tencent.com>
---
 include/net/ip.h         |  3 +--
 include/net/tcp.h        |  2 +-
 net/ipv4/fib_semantics.c |  5 ++---
 net/ipv4/metrics.c       |  8 ++++----
 net/ipv4/tcp_cong.c      | 11 +++++------
 net/ipv6/route.c         |  2 +-
 6 files changed, 14 insertions(+), 17 deletions(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 6d735e00d3f3..c5606cadb1a5 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -506,8 +506,7 @@ static inline unsigned int ip_skb_dst_mtu(struct sock *sk,
 	return mtu - lwtunnel_headroom(skb_dst(skb)->lwtstate, mtu);
 }
 
-struct dst_metrics *ip_fib_metrics_init(struct net *net, struct nlattr *fc_mx,
-					int fc_mx_len,
+struct dst_metrics *ip_fib_metrics_init(struct nlattr *fc_mx, int fc_mx_len,
 					struct netlink_ext_ack *extack);
 static inline void ip_fib_metrics_put(struct dst_metrics *fib_metrics)
 {
diff --git a/include/net/tcp.h b/include/net/tcp.h
index 32815a40dea1..45bbb54e42e8 100644
--- a/include/net/tcp.h
+++ b/include/net/tcp.h
@@ -1216,7 +1216,7 @@ extern struct tcp_congestion_ops tcp_reno;
 
 struct tcp_congestion_ops *tcp_ca_find(const char *name);
 struct tcp_congestion_ops *tcp_ca_find_key(u32 key);
-u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool *ecn_ca);
+u32 tcp_ca_get_key_by_name(const char *name, bool *ecn_ca);
 #ifdef CONFIG_INET
 char *tcp_ca_get_name_by_key(u32 key, char *buffer);
 #else
diff --git a/net/ipv4/fib_semantics.c b/net/ipv4/fib_semantics.c
index f669da98d11d..7b6b042208bd 100644
--- a/net/ipv4/fib_semantics.c
+++ b/net/ipv4/fib_semantics.c
@@ -1030,7 +1030,7 @@ bool fib_metrics_match(struct fib_config *cfg, struct fib_info *fi)
 			bool ecn_ca = false;
 
 			nla_strscpy(tmp, nla, sizeof(tmp));
-			val = tcp_ca_get_key_by_name(fi->fib_net, tmp, &ecn_ca);
+			val = tcp_ca_get_key_by_name(tmp, &ecn_ca);
 		} else {
 			if (nla_len(nla) != sizeof(u32))
 				return false;
@@ -1459,8 +1459,7 @@ struct fib_info *fib_create_info(struct fib_config *cfg,
 	fi = kzalloc(struct_size(fi, fib_nh, nhs), GFP_KERNEL);
 	if (!fi)
 		goto failure;
-	fi->fib_metrics = ip_fib_metrics_init(fi->fib_net, cfg->fc_mx,
-					      cfg->fc_mx_len, extack);
+	fi->fib_metrics = ip_fib_metrics_init(cfg->fc_mx, cfg->fc_mx_len, extack);
 	if (IS_ERR(fi->fib_metrics)) {
 		err = PTR_ERR(fi->fib_metrics);
 		kfree(fi);
diff --git a/net/ipv4/metrics.c b/net/ipv4/metrics.c
index 0e3ee1532848..8ddac1f595ed 100644
--- a/net/ipv4/metrics.c
+++ b/net/ipv4/metrics.c
@@ -7,7 +7,7 @@
 #include <net/net_namespace.h>
 #include <net/tcp.h>
 
-static int ip_metrics_convert(struct net *net, struct nlattr *fc_mx,
+static int ip_metrics_convert(struct nlattr *fc_mx,
 			      int fc_mx_len, u32 *metrics,
 			      struct netlink_ext_ack *extack)
 {
@@ -31,7 +31,7 @@ static int ip_metrics_convert(struct net *net, struct nlattr *fc_mx,
 			char tmp[TCP_CA_NAME_MAX];
 
 			nla_strscpy(tmp, nla, sizeof(tmp));
-			val = tcp_ca_get_key_by_name(net, tmp, &ecn_ca);
+			val = tcp_ca_get_key_by_name(tmp, &ecn_ca);
 			if (val == TCP_CA_UNSPEC) {
 				NL_SET_ERR_MSG(extack, "Unknown tcp congestion algorithm");
 				return -EINVAL;
@@ -63,7 +63,7 @@ static int ip_metrics_convert(struct net *net, struct nlattr *fc_mx,
 	return 0;
 }
 
-struct dst_metrics *ip_fib_metrics_init(struct net *net, struct nlattr *fc_mx,
+struct dst_metrics *ip_fib_metrics_init(struct nlattr *fc_mx,
 					int fc_mx_len,
 					struct netlink_ext_ack *extack)
 {
@@ -77,7 +77,7 @@ struct dst_metrics *ip_fib_metrics_init(struct net *net, struct nlattr *fc_mx,
 	if (unlikely(!fib_metrics))
 		return ERR_PTR(-ENOMEM);
 
-	err = ip_metrics_convert(net, fc_mx, fc_mx_len, fib_metrics->metrics,
+	err = ip_metrics_convert(fc_mx, fc_mx_len, fib_metrics->metrics,
 				 extack);
 	if (!err) {
 		refcount_set(&fib_metrics->refcnt, 1);
diff --git a/net/ipv4/tcp_cong.c b/net/ipv4/tcp_cong.c
index 28ffcfbeef14..48617d99abb0 100644
--- a/net/ipv4/tcp_cong.c
+++ b/net/ipv4/tcp_cong.c
@@ -46,8 +46,7 @@ void tcp_set_ca_state(struct sock *sk, const u8 ca_state)
 }
 
 /* Must be called with rcu lock held */
-static struct tcp_congestion_ops *tcp_ca_find_autoload(struct net *net,
-						       const char *name)
+static struct tcp_congestion_ops *tcp_ca_find_autoload(const char *name)
 {
 	struct tcp_congestion_ops *ca = tcp_ca_find(name);
 
@@ -178,7 +177,7 @@ int tcp_update_congestion_control(struct tcp_congestion_ops *ca, struct tcp_cong
 	return ret;
 }
 
-u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool *ecn_ca)
+u32 tcp_ca_get_key_by_name(const char *name, bool *ecn_ca)
 {
 	const struct tcp_congestion_ops *ca;
 	u32 key = TCP_CA_UNSPEC;
@@ -186,7 +185,7 @@ u32 tcp_ca_get_key_by_name(struct net *net, const char *name, bool *ecn_ca)
 	might_sleep();
 
 	rcu_read_lock();
-	ca = tcp_ca_find_autoload(net, name);
+	ca = tcp_ca_find_autoload(name);
 	if (ca) {
 		key = ca->key;
 		*ecn_ca = ca->flags & TCP_CONG_NEEDS_ECN;
@@ -283,7 +282,7 @@ int tcp_set_default_congestion_control(struct net *net, const char *name)
 	int ret;
 
 	rcu_read_lock();
-	ca = tcp_ca_find_autoload(net, name);
+	ca = tcp_ca_find_autoload(name);
 	if (!ca) {
 		ret = -ENOENT;
 	} else if (!bpf_try_module_get(ca, ca->owner)) {
@@ -421,7 +420,7 @@ int tcp_set_congestion_control(struct sock *sk, const char *name, bool load,
 	if (!load)
 		ca = tcp_ca_find(name);
 	else
-		ca = tcp_ca_find_autoload(sock_net(sk), name);
+		ca = tcp_ca_find_autoload(name);
 
 	/* No change asking for existing value */
 	if (ca == icsk->icsk_ca_ops) {
diff --git a/net/ipv6/route.c b/net/ipv6/route.c
index bbc2a0dd9314..d3dce7ee4741 100644
--- a/net/ipv6/route.c
+++ b/net/ipv6/route.c
@@ -3760,7 +3760,7 @@ static struct fib6_info *ip6_route_info_create(struct fib6_config *cfg,
 	if (!rt)
 		goto out;
 
-	rt->fib6_metrics = ip_fib_metrics_init(net, cfg->fc_mx, cfg->fc_mx_len,
+	rt->fib6_metrics = ip_fib_metrics_init(cfg->fc_mx, cfg->fc_mx_len,
 					       extack);
 	if (IS_ERR(rt->fib6_metrics)) {
 		err = PTR_ERR(rt->fib6_metrics);
-- 
2.37.3


