Return-Path: <netdev+bounces-64640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 42F7C8361E4
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 12:36:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B75E01F26BBF
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 11:36:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05713F8D9;
	Mon, 22 Jan 2024 11:26:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h6FAXYo6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 581563F8CD
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 11:26:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705922775; cv=none; b=PRdG9IQD0JixWKiWfttJG4qViUSNSpFexjEZ1YZspX0710KahmEEc26NsE6IpKzyjgrOwfQZRbtY2dMekFs4bZfbcv6j1mbDcjkHuNsKSIg4brgLWK0af4c9hHRYABAR8NmrsGTdzLAixUMeHCfYa0iVX4X1g/Q8YFytFCxvmd0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705922775; c=relaxed/simple;
	bh=l9SA8v+4TFZQ8N657F5G0BhsOUUZ5R9fIn1eoQw8wnI=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=cZM6eycZkyKHJ3gb8n2gr9rEsuN9xDp6Ge1Pteu+rpKaZOEHGbDqrmMExAqlJOOEQGbUJgqzi1k+T4FUw1cClQ+winfSgknqbbot+u5+OWvzLwcaAywt1l6xSQ0zSiUfxX3NuybTUZzhSi/xGGQiV+Tvc4W18qK/fyHhssazU60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=h6FAXYo6; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5f874219ff9so41218417b3.0
        for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 03:26:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1705922773; x=1706527573; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iGPEMQJW5dCocp4lvGLpK54zbiitNAk237d0lz5qykk=;
        b=h6FAXYo6H0ZB/Y+PvaXWk1joUUVrqbtD1SFSv6I9zYwbcqJRoic+sH0wSh1oAFhYx3
         oi0xjhxwohhydPgqM51FYtSroiG7p6KCeluB9KW/my7ZhlExfQ2BoY4ZKcPdrRrqT0y2
         Uxw1S/tj+d6HwZ179xF2knmRQlMfEiGor9gYs60hBLAuD8Hn42wbJb4/PGMiCeTvHPUz
         QCEl0Sq3aFv9vfxwlzJK7i1eGbxfic4mjg9HWuAJwZzZ0iHs0p9ZW7rFIVIzUpGRMXl4
         kdH3468Bxc2wDoiD3O7oM9L5Rpydl2hLXm4knGL8IvyDoiz6ShiabI/R2qdTx0pDP0Kp
         aa6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705922773; x=1706527573;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iGPEMQJW5dCocp4lvGLpK54zbiitNAk237d0lz5qykk=;
        b=gDT96LX2o3qT2HODdSKQ+PVuzw/Te6zojxoPrKRCBR9ul1gJHJYX36767is+4mJOiL
         fgZ5Q1RagrLi6T1Kvr5SpCEbK776iD5Y2V6xwet612Wwl9IFMIubireN/dVWKiAnh72i
         6R7IjXKjGG94r2wgCEtXy6qxVUVQ9RZqmVnzt3YYzAG3uKe8TaycVXb15I5F+bh7eAG9
         l6Kl5b95Hw1fUjYu5Oe3+M5JPgEE7BuUuPMKl9BfJwv5ytobYLIAZFD65HISJV+PVD+H
         /Aw4zl0GVkwTqmNFhEpyZqypFQ/goGn6k0bjresC8uBZ/NGRWKBRGUaQUbrKR5fpMs33
         ka0Q==
X-Gm-Message-State: AOJu0YzP8zqQexS1RgHDQgUGjXd4Ss6978IHXWhuvB1JxWDbQQ1PxLo2
	jc2uFG+t0IVYCHFYrSnqeydPm+wknc6t6T1VCGih68VkL3FEbzI9EhCdr6gRy+3GYD13SA4iXZl
	UPXlIAyYMfg==
X-Google-Smtp-Source: AGHT+IGXrU8Q1Ag+YJ0UYXKXfdKeM1SUjMWriMtXzIilF0I/ArJ13HiUG52EYkWHet08bJxi6iPB8zjyufpjfg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a81:4c86:0:b0:5ff:6ec3:b8da with SMTP id
 z128-20020a814c86000000b005ff6ec3b8damr1728834ywa.1.1705922773405; Mon, 22
 Jan 2024 03:26:13 -0800 (PST)
Date: Mon, 22 Jan 2024 11:25:59 +0000
In-Reply-To: <20240122112603.3270097-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20240122112603.3270097-1-edumazet@google.com>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
Message-ID: <20240122112603.3270097-6-edumazet@google.com>
Subject: [PATCH net-next 5/9] sock_diag: add module pointer to "struct sock_diag_handler"
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: David Ahern <dsahern@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>, 
	Martin KaFai Lau <kafai@fb.com>, Guillaume Nault <gnault@redhat.com>, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Content-Type: text/plain; charset="UTF-8"

Following patch is going to use RCU instead of
sock_diag_table_mutex acquisition.

This patch is a preparation, no change of behavior yet.

Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 include/linux/sock_diag.h | 1 +
 net/ipv4/inet_diag.c      | 2 ++
 net/netlink/diag.c        | 1 +
 net/packet/diag.c         | 1 +
 net/smc/smc_diag.c        | 1 +
 net/tipc/diag.c           | 1 +
 net/unix/diag.c           | 1 +
 net/vmw_vsock/diag.c      | 1 +
 net/xdp/xsk_diag.c        | 1 +
 9 files changed, 10 insertions(+)

diff --git a/include/linux/sock_diag.h b/include/linux/sock_diag.h
index 0b9ecd8cf9793bc26138a0a36474e78773fb4f31..7c07754d711b9bd04bc57f8ed08981849fcadb11 100644
--- a/include/linux/sock_diag.h
+++ b/include/linux/sock_diag.h
@@ -13,6 +13,7 @@ struct nlmsghdr;
 struct sock;
 
 struct sock_diag_handler {
+	struct module *owner;
 	__u8 family;
 	int (*dump)(struct sk_buff *skb, struct nlmsghdr *nlh);
 	int (*get_info)(struct sk_buff *skb, struct sock *sk);
diff --git a/net/ipv4/inet_diag.c b/net/ipv4/inet_diag.c
index abf7dc9827969d7e8061420be8629730ccce5449..52ce20691e4ef1382da94473128e3c14c55bd542 100644
--- a/net/ipv4/inet_diag.c
+++ b/net/ipv4/inet_diag.c
@@ -1488,6 +1488,7 @@ int inet_diag_handler_get_info(struct sk_buff *skb, struct sock *sk)
 }
 
 static const struct sock_diag_handler inet_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_INET,
 	.dump = inet_diag_handler_cmd,
 	.get_info = inet_diag_handler_get_info,
@@ -1495,6 +1496,7 @@ static const struct sock_diag_handler inet_diag_handler = {
 };
 
 static const struct sock_diag_handler inet6_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_INET6,
 	.dump = inet_diag_handler_cmd,
 	.get_info = inet_diag_handler_get_info,
diff --git a/net/netlink/diag.c b/net/netlink/diag.c
index 1eeff9422856eb9006e25b21ef188280b4cff7f6..e12c90d5f6ad29446ea1990c88c19bcb0ee856c3 100644
--- a/net/netlink/diag.c
+++ b/net/netlink/diag.c
@@ -241,6 +241,7 @@ static int netlink_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 }
 
 static const struct sock_diag_handler netlink_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_NETLINK,
 	.dump = netlink_diag_handler_dump,
 };
diff --git a/net/packet/diag.c b/net/packet/diag.c
index 9a7980e3309d6a2950688f8b69b08c15c288f601..b3bd2f6c2bf7be7b1436aa1a7fad6ef3f77217ad 100644
--- a/net/packet/diag.c
+++ b/net/packet/diag.c
@@ -245,6 +245,7 @@ static int packet_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 }
 
 static const struct sock_diag_handler packet_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_PACKET,
 	.dump = packet_diag_handler_dump,
 };
diff --git a/net/smc/smc_diag.c b/net/smc/smc_diag.c
index 52f7c4f1e7670d723a6858614f071f73dbd88dc5..32bad267fa3e2729b833cb711a6bb946bc7229d9 100644
--- a/net/smc/smc_diag.c
+++ b/net/smc/smc_diag.c
@@ -255,6 +255,7 @@ static int smc_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 }
 
 static const struct sock_diag_handler smc_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_SMC,
 	.dump = smc_diag_handler_dump,
 };
diff --git a/net/tipc/diag.c b/net/tipc/diag.c
index 18733451c9e0c23a63d9400d408979aab46ecf19..54dde8c4e4d46d8556b9cc5396c863d24306d547 100644
--- a/net/tipc/diag.c
+++ b/net/tipc/diag.c
@@ -95,6 +95,7 @@ static int tipc_sock_diag_handler_dump(struct sk_buff *skb,
 }
 
 static const struct sock_diag_handler tipc_sock_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_TIPC,
 	.dump = tipc_sock_diag_handler_dump,
 };
diff --git a/net/unix/diag.c b/net/unix/diag.c
index bec09a3a1d44ce56d43e16583fdf3b417cce4033..c3648b706509653480b71ea26ec4f8462f1a3c42 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -322,6 +322,7 @@ static int unix_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 }
 
 static const struct sock_diag_handler unix_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_UNIX,
 	.dump = unix_diag_handler_dump,
 };
diff --git a/net/vmw_vsock/diag.c b/net/vmw_vsock/diag.c
index 2e29994f92ffa2facee45cd53ec791034182508c..ab87ef66c1e88765911a3b6ff89b7fc720b6d692 100644
--- a/net/vmw_vsock/diag.c
+++ b/net/vmw_vsock/diag.c
@@ -157,6 +157,7 @@ static int vsock_diag_handler_dump(struct sk_buff *skb, struct nlmsghdr *h)
 }
 
 static const struct sock_diag_handler vsock_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_VSOCK,
 	.dump = vsock_diag_handler_dump,
 };
diff --git a/net/xdp/xsk_diag.c b/net/xdp/xsk_diag.c
index 9f8955367275e2439d910f978fc3b2b7a1669978..09dcea0cbbed97d9a41e88224994279cfbf8c536 100644
--- a/net/xdp/xsk_diag.c
+++ b/net/xdp/xsk_diag.c
@@ -194,6 +194,7 @@ static int xsk_diag_handler_dump(struct sk_buff *nlskb, struct nlmsghdr *hdr)
 }
 
 static const struct sock_diag_handler xsk_diag_handler = {
+	.owner = THIS_MODULE,
 	.family = AF_XDP,
 	.dump = xsk_diag_handler_dump,
 };
-- 
2.43.0.429.g432eaa2c6b-goog


