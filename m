Return-Path: <netdev+bounces-151664-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3969F07D9
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 10:26:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 46D6718806A7
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 09:26:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 688EA1B0F1B;
	Fri, 13 Dec 2024 09:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gx8ZElIW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B38AC1B0103
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 09:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734081981; cv=none; b=AbWfabQQsaJdKUkZEhxO7aTug139jLCz6uhJcrkYNZxy96wPb3Ov5nY/JTIcAz+74tkB7eztcqdCVoDJOjBYvy/FWSABZbpDSaNCLWgr6XC907gyIfHmdGgzYlDsxAhlt+66TrnrrNr+nj9Q/S36sYeBIt6ztToy8m9C2JKsAUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734081981; c=relaxed/simple;
	bh=1COAxqj0ILy9v/XmiJWnXbrPTVu+DWd/LVl3q0yK3KQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QP8pMqtt2ZNuHSYxQs10abxGDl8vDircLGtoDkbsaiOvN+EdAr+MvJe6EcpxjMDIN+6Q0FI50889XFudLhVmbtpWuv1t/RjKaMtFylGVK6NjWPETzCL2XR9Wn+6JIMc6aIQROtwREIZ3wziOsLnywvOj+okLyINoJ4EoR/rngqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gx8ZElIW; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734081979; x=1765617979;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ebuc6FkZQoBH01DxzY6jcdmxO8Mq5yhN4RIvPO00t1E=;
  b=gx8ZElIW1nRAkEx0ffShps8BaV7pX2yGHw+9710L5EvtF/V4fxZcq2yb
   Z3U0oZuNOwtuz/8zc748jhZEeuelioILZ8EHZqwuepESl/F9eDP6Xn+Gl
   TfVlwZf/QI4bDe5ue7FxmeicE3ukefJalkQ8SnCR2v7Pt2S+/FvWGJsnn
   E=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="254688521"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 09:26:17 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:17725]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.28.119:2525] with esmtp (Farcaster)
 id ef61d405-a803-464e-8d24-3df6bda333a1; Fri, 13 Dec 2024 09:26:17 +0000 (UTC)
X-Farcaster-Flow-ID: ef61d405-a803-464e-8d24-3df6bda333a1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:26:17 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 09:26:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 12/15] socket: Move sock_inuse_add() to sock.c.
Date: Fri, 13 Dec 2024 18:21:49 +0900
Message-ID: <20241213092152.14057-13-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213092152.14057-1-kuniyu@amazon.com>
References: <20241213092152.14057-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA004.ant.amazon.com (10.13.139.56) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_inuse_add() is used only in net/core/sock.c.

Let's move sock_inuse_add() there.

This is mostly revert of commit d477eb900484 ("net: make
sock_inuse_add() available").

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/sock.h |  9 ---------
 net/core/sock.c    | 10 ++++++++++
 2 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/include/net/sock.h b/include/net/sock.h
index 8de415fefe3b..845efc3c5568 100644
--- a/include/net/sock.h
+++ b/include/net/sock.h
@@ -1433,11 +1433,6 @@ static inline void sock_prot_inuse_add(const struct net *net,
 	this_cpu_add(net->core.prot_inuse->val[prot->inuse_idx], val);
 }
 
-static inline void sock_inuse_add(const struct net *net, int val)
-{
-	this_cpu_add(net->core.prot_inuse->all, val);
-}
-
 int sock_prot_inuse_get(struct net *net, struct proto *proto);
 int sock_inuse_get(struct net *net);
 #else
@@ -1445,10 +1440,6 @@ static inline void sock_prot_inuse_add(const struct net *net,
 				       const struct proto *prot, int val)
 {
 }
-
-static inline void sock_inuse_add(const struct net *net, int val)
-{
-}
 #endif
 
 
diff --git a/net/core/sock.c b/net/core/sock.c
index 9fb57afe6848..78c812205e35 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -153,6 +153,7 @@
 static DEFINE_MUTEX(proto_list_mutex);
 static LIST_HEAD(proto_list);
 
+static void sock_inuse_add(const struct net *net, int val);
 static void sock_def_write_space_wfree(struct sock *sk);
 static void sock_def_write_space(struct sock *sk);
 
@@ -3885,6 +3886,11 @@ int sock_prot_inuse_get(struct net *net, struct proto *prot)
 }
 EXPORT_SYMBOL_GPL(sock_prot_inuse_get);
 
+static void sock_inuse_add(const struct net *net, int val)
+{
+	this_cpu_add(net->core.prot_inuse->all, val);
+}
+
 int sock_inuse_get(struct net *net)
 {
 	int cpu, res = 0;
@@ -3944,6 +3950,10 @@ static void release_proto_idx(struct proto *prot)
 		clear_bit(prot->inuse_idx, proto_inuse_idx);
 }
 #else
+static void sock_inuse_add(const struct net *net, int val)
+{
+}
+
 static inline int assign_proto_idx(struct proto *prot)
 {
 	return 0;
-- 
2.39.5 (Apple Git-154)


