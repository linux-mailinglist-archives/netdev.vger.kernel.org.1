Return-Path: <netdev+bounces-82252-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C0EE88CF45
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:44:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27792B2427B
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F911745ED;
	Tue, 26 Mar 2024 20:43:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="nmJhYk05"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279E123CB
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485820; cv=none; b=XNNz9qdKshDvCAqZCxswuJ6NyhmBTCerjzW8PB5SbZO02ycQ9v+zVAycuNeGLjxDs9WSPC1bIOFe0MkGSTbWaLdT1FU9FMF/zlB4Q8lpbapx2/JFVtYEALSvja3krBUKXPaQvrmiwXnVl3jToOwrhy0fCK9xWQBkp79bvERlcSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485820; c=relaxed/simple;
	bh=b+N9AUX9x3YVQVFZB0x1WgHu+L5xPgrSMYHsOlOOq1k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fD0h3166WoruvFI7G9eHbNFmJCWcf7vAtrCv3Ri4p3FgLvNjRJM5r+ubRG/FF2bTlEy7mF+sBO7ZCTlAurzCRZCYZwLnqOx4iokq8aLuowJDBySmSNmnpwkDGtBNfHXwvfnRJuT0O/8XvTl126zRaMOaLuWnwzmdVOxXYVdM8vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=nmJhYk05; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485819; x=1743021819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=y4b7k3SWbgROvNmT7ZllvQPxaFP+GMwI6PG7dhAuI+o=;
  b=nmJhYk05a0V2R8fLW/E7AO3hR5Kd097RdQ5LUUcZXG1GsE1ur5QPKb4U
   Ia3LO6P3b0Y0Z8D8lUP7GOqx95lotnAEDoItSrpjalURmvS9JS+RyVJvt
   9xcvLN/TaLnqGgdrvv/fs7sakoUOWEJj4fNCK6GRE8VYm+lIKflM565Xg
   0=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="390726967"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:43:34 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.7.35:61916]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.11.19:2525] with esmtp (Farcaster)
 id 8eb0bb3d-9150-4ffe-ad40-2c2d938db4b7; Tue, 26 Mar 2024 20:43:33 +0000 (UTC)
X-Farcaster-Flow-ID: 8eb0bb3d-9150-4ffe-ad40-2c2d938db4b7
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:43:31 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:43:28 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 1/8] tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
Date: Tue, 26 Mar 2024 13:42:44 -0700
Message-ID: <20240326204251.51301-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240326204251.51301-1-kuniyu@amazon.com>
References: <20240326204251.51301-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D042UWB001.ant.amazon.com (10.13.139.160) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 5e07e672412b ("tcp: Use bhash2 for v4-mapped-v6 non-wildcard
address.") introduced bind() regression for v4-mapped-v6 address.

When we bind() the following two addresses on the same port, the 2nd
bind() should succeed but fails now.

  1. [::] w/ IPV6_ONLY
  2. ::ffff:127.0.0.1

After the chagne, v4-mapped-v6 uses bhash2 instead of bhash to
detect conflict faster, but I forgot to add a necessary change.

During the 2nd bind(), inet_bind2_bucket_match_addr_any() returns
the tb2 bucket of [::], and inet_bhash2_conflict() finally calls
inet_bind_conflict(), which returns true, meaning conflict.

  inet_bhash2_addr_any_conflict
  |- inet_bind2_bucket_match_addr_any  <-- return [::] bucket
  `- inet_bhash2_conflict
     `- __inet_bhash2_conflict <-- checks IPV6_ONLY for AF_INET
        |                          but not for v4-mapped-v6 address
        `- inet_bind_conflict  <-- does not check address

inet_bind_conflict() does not check socket addresses because
__inet_bhash2_conflict() is expected to do so.

However, it checks IPV6_V6ONLY attribute only against AF_INET
socket, and not for v4-mapped-v6 address.

As a result, v4-mapped-v6 address conflicts with v6-only wildcard
address.

To avoid that, let's add the missing test to use bhash2 for
v4-mapped-v6 address.

Fixes: 5e07e672412b ("tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7d8090f109ef..c365fe9dbacd 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -203,8 +203,15 @@ static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *sk2,
 				   kuid_t sk_uid, bool relax,
 				   bool reuseport_cb_ok, bool reuseport_ok)
 {
-	if (sk->sk_family == AF_INET && ipv6_only_sock(sk2))
-		return false;
+	if (ipv6_only_sock(sk2)) {
+		if (sk->sk_family == AF_INET)
+			return false;
+
+#if IS_ENABLED(CONFIG_IPV6)
+		if (ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr))
+			return false;
+#endif
+	}
 
 	return inet_bind_conflict(sk, sk2, sk_uid, relax,
 				  reuseport_cb_ok, reuseport_ok);
-- 
2.30.2


