Return-Path: <netdev+bounces-116332-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E5F4894A123
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 08:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4801DB25C96
	for <lists+netdev@lfdr.de>; Wed,  7 Aug 2024 06:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EEFD1B4C4E;
	Wed,  7 Aug 2024 06:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b="la85EUG2"
X-Original-To: netdev@vger.kernel.org
Received: from mail.katalix.com (mail.katalix.com [3.9.82.81])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF38D1AE873
	for <netdev@vger.kernel.org>; Wed,  7 Aug 2024 06:54:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=3.9.82.81
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723013696; cv=none; b=M2aexWqCDM7AP9KC5ZErioNJ6Gm56sbvw8wERJckOlYjQ6c7e4HB5b2HatSPTXRtc3RfpJa+RuuCGw89JGJ095GI9ECQ2oMdnRLQVR61cuFVXu0Qun3DUDOE2Oas6F69Yg1aOyaNyaLpJH+/tT8GKrNOZ7t/Jpb7SdSkvcZ9uL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723013696; c=relaxed/simple;
	bh=eP6RZl4zPjUWSF4WyYRk0D92OQDG6lCZ7Xu0N/nf2zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=i/X2YK/GwCLt+WpjGCd7d6Asos7Y6RkB3Blcs7wDuLF4qA+5vO2dMSYZDO2dqG7sqXr7+HDDMocQOcDA9oLnaDxPIs33znexoUUyDWfvq14CJBlX2z2W/xzKIt1dCCWwyI8Er5surQOKYpbeFiwdjW5TDuCpOAoswJEKYF4dHNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com; spf=pass smtp.mailfrom=katalix.com; dkim=pass (2048-bit key) header.d=katalix.com header.i=@katalix.com header.b=la85EUG2; arc=none smtp.client-ip=3.9.82.81
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=katalix.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=katalix.com
Received: from katalix.com (unknown [IPv6:2a02:8010:6359:1:9ea4:d72e:1b25:b4bf])
	(Authenticated sender: james)
	by mail.katalix.com (Postfix) with ESMTPSA id E3ADC7DCC3;
	Wed,  7 Aug 2024 07:54:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=katalix.com; s=mail;
	t=1723013694; bh=eP6RZl4zPjUWSF4WyYRk0D92OQDG6lCZ7Xu0N/nf2zw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:From;
	z=From:=20James=20Chapman=20<jchapman@katalix.com>|To:=20netdev@vge
	 r.kernel.org|Cc:=20davem@davemloft.net,=0D=0A=09edumazet@google.co
	 m,=0D=0A=09kuba@kernel.org,=0D=0A=09pabeni@redhat.com,=0D=0A=09dsa
	 hern@kernel.org,=0D=0A=09tparkin@katalix.com,=0D=0A=09horms@kernel
	 .org|Subject:=20[PATCH=20v2=20net-next=202/9]=20l2tp:=20remove=20i
	 nline=20from=20functions=20in=20c=20sources|Date:=20Wed,=20=207=20
	 Aug=202024=2007:54:45=20+0100|Message-Id:=20<0d9023e1cbc4b04836ba1
	 acb8bbd05225264c62d.1723011569.git.jchapman@katalix.com>|In-Reply-
	 To:=20<cover.1723011569.git.jchapman@katalix.com>|References:=20<c
	 over.1723011569.git.jchapman@katalix.com>|MIME-Version:=201.0;
	b=la85EUG2v9f5g2XXZILHaCmScHiF7hqazJLo14eLAic7pW63OOrR7/zW8EEqi1Sc0
	 mlFQ7gyS/Pq0felO6FXlcxst87AkvjgotSvWyUhSeQo880ND3Xa5qZPqp8wsZ7fXn8
	 zI5eGdJUvbmTkjFZ8qwHFicC2NPEs1vKPvSG8GigU++a0g4B0fnGZrkcB8nCKpuhdb
	 oeqhumz/DF6j6FPqDP5pwYinpO7BYS8jxYPOjsTWMj9DAu7mmaaAjkxD+4nRVOaoBm
	 xLG3F+H5E7P4Hfp0km8isQm87BO8SdWnx4z8NWfs5QvyGv/l9Zss3FMQaNXsBvT0Xj
	 L//h1AvYF3I/g==
From: James Chapman <jchapman@katalix.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	tparkin@katalix.com,
	horms@kernel.org
Subject: [PATCH v2 net-next 2/9] l2tp: remove inline from functions in c sources
Date: Wed,  7 Aug 2024 07:54:45 +0100
Message-Id: <0d9023e1cbc4b04836ba1acb8bbd05225264c62d.1723011569.git.jchapman@katalix.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1723011569.git.jchapman@katalix.com>
References: <cover.1723011569.git.jchapman@katalix.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update l2tp to remove the inline keyword from several functions in C
sources, since this is now discouraged.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Tom Parkin <tparkin@katalix.com>
---
 net/l2tp/l2tp_core.c | 6 +++---
 net/l2tp/l2tp_ip.c   | 2 +-
 net/l2tp/l2tp_ip6.c  | 2 +-
 net/l2tp/l2tp_ppp.c  | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/net/l2tp/l2tp_core.c b/net/l2tp/l2tp_core.c
index 5d2068b6c778..608a7beda9d5 100644
--- a/net/l2tp/l2tp_core.c
+++ b/net/l2tp/l2tp_core.c
@@ -112,12 +112,12 @@ struct l2tp_net {
 	struct hlist_head l2tp_v3_session_htable[16];
 };
 
-static inline u32 l2tp_v2_session_key(u16 tunnel_id, u16 session_id)
+static u32 l2tp_v2_session_key(u16 tunnel_id, u16 session_id)
 {
 	return ((u32)tunnel_id) << 16 | session_id;
 }
 
-static inline unsigned long l2tp_v3_session_hashkey(struct sock *sk, u32 session_id)
+static unsigned long l2tp_v3_session_hashkey(struct sock *sk, u32 session_id)
 {
 	return ((unsigned long)sk) + session_id;
 }
@@ -130,7 +130,7 @@ static bool l2tp_sk_is_v6(struct sock *sk)
 }
 #endif
 
-static inline struct l2tp_net *l2tp_pernet(const struct net *net)
+static struct l2tp_net *l2tp_pernet(const struct net *net)
 {
 	return net_generic(net, l2tp_net_id);
 }
diff --git a/net/l2tp/l2tp_ip.c b/net/l2tp/l2tp_ip.c
index f21dcbf3efd5..9bd29667ae34 100644
--- a/net/l2tp/l2tp_ip.c
+++ b/net/l2tp/l2tp_ip.c
@@ -37,7 +37,7 @@ static DEFINE_RWLOCK(l2tp_ip_lock);
 static struct hlist_head l2tp_ip_table;
 static struct hlist_head l2tp_ip_bind_table;
 
-static inline struct l2tp_ip_sock *l2tp_ip_sk(const struct sock *sk)
+static struct l2tp_ip_sock *l2tp_ip_sk(const struct sock *sk)
 {
 	return (struct l2tp_ip_sock *)sk;
 }
diff --git a/net/l2tp/l2tp_ip6.c b/net/l2tp/l2tp_ip6.c
index 3b0465f2d60d..a7b7626ca2c6 100644
--- a/net/l2tp/l2tp_ip6.c
+++ b/net/l2tp/l2tp_ip6.c
@@ -43,7 +43,7 @@ static DEFINE_RWLOCK(l2tp_ip6_lock);
 static struct hlist_head l2tp_ip6_table;
 static struct hlist_head l2tp_ip6_bind_table;
 
-static inline struct l2tp_ip6_sock *l2tp_ip6_sk(const struct sock *sk)
+static struct l2tp_ip6_sock *l2tp_ip6_sk(const struct sock *sk)
 {
 	return (struct l2tp_ip6_sock *)sk;
 }
diff --git a/net/l2tp/l2tp_ppp.c b/net/l2tp/l2tp_ppp.c
index 9b4273fd518a..c25dd8e36074 100644
--- a/net/l2tp/l2tp_ppp.c
+++ b/net/l2tp/l2tp_ppp.c
@@ -149,7 +149,7 @@ static struct sock *pppol2tp_session_get_sock(struct l2tp_session *session)
 
 /* Helpers to obtain tunnel/session contexts from sockets.
  */
-static inline struct l2tp_session *pppol2tp_sock_to_session(struct sock *sk)
+static struct l2tp_session *pppol2tp_sock_to_session(struct sock *sk)
 {
 	struct l2tp_session *session;
 
-- 
2.34.1


