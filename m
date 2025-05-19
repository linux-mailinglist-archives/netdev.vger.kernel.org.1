Return-Path: <netdev+bounces-191648-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D2F12ABC8CA
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 23:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5D0A83B3FB6
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 21:00:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28B611A704B;
	Mon, 19 May 2025 21:00:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="EiEvnZEq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9684E126BFA
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 21:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747688419; cv=none; b=SoCtguHVV7dT7lLx7TeawTzOEamC7HtLu/WGUnJo8arb1FgTepQyjp8lEYOtrJfTguJH4fybrxuMI8yMVmN/r4pLcEiJNy4CpHrvoHz9Zmv+Yp9ICbZIesxIRdhrHewNiny+nSew3ws0Oq6mpfeWmf5aMCerO+2eh2ThRtLvXyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747688419; c=relaxed/simple;
	bh=AJgCtCCIXEBKJu+1mMsy9onHSzkPXFhPeGcLgkYr9Gg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=f8CU0rSS4dsy1zdAB6LnK0eLiH8LSYO6U8KtBOHN7iTHr5qO9DbWwl1vHwRJe8GEcc7Wk5UhGatTMt3T9qtaWpgxmJdEL+9Url/aQBEV+d4ooYuJJjHLCBRkB1hF35WjlluTWiS3iGFCHDNQhz2wTiLNnqRFgrYb9dYTaNTnThA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=EiEvnZEq; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747688417; x=1779224417;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Xiod+1D1GOIkt5f2ZHSjQWUiFNIl73TirSFCnMGEQVQ=;
  b=EiEvnZEqG8gKa0xfmoZlZ2ilINZ08qpXd/s69N+U0q62eHV/gcqFz4Z1
   xBXi2uapBSlZPNni4XWPXPBjxR0GfMx5wx78GXgxgvZs1LHSknzGxy3w2
   cWOE992aHYP6luT5bqGP6ZPnrKiUesBmEcfvj5YBYBPwqOvuuUPGHppdy
   J9/TkDJB8x6nk7/WsIe+GacYvHQef4Skgt/WZDMsZzi8YaaXHFFx79WoN
   PYcitXqqatDWj5EWe1In6XYc5dO+II7q7GbPTBV4TUH9ryPADI2/AfY9w
   or3+AgI0q3XuR37wuyZWJEWNcdXpvF5J4YLSRg4P36KoyljhQkTn0sKy4
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="202261711"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 21:00:15 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:25447]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.47:2525] with esmtp (Farcaster)
 id 7ea7c564-9a16-4c7c-b08a-fe46e63fa84c; Mon, 19 May 2025 21:00:14 +0000 (UTC)
X-Farcaster-Flow-ID: 7ea7c564-9a16-4c7c-b08a-fe46e63fa84c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:00:14 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 21:00:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
Date: Mon, 19 May 2025 13:57:55 -0700
Message-ID: <20250519205820.66184-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519205820.66184-1-kuniyu@amazon.com>
References: <20250519205820.66184-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB003.ant.amazon.com (10.13.139.165) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk->sk_txrehash is only used for TCP.

Let's restrict SO_TXREHASH to TCP to reflect this.

Later, we will make sk_txrehash a part of the union for other
protocol families.

Note that we need to modify BPF selftest not to get/set
SO_TEREHASH for non-TCP sockets.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
---
v5: Modify BPF selftest not to set SO_TEREHASH for UDP socket
v3: Return -EOPNOTSUPP for getsockopt() too
---
 net/core/sock.c                                    |  5 +++++
 tools/testing/selftests/bpf/progs/setget_sockopt.c | 11 +++++++++++
 2 files changed, 16 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 347ce75482f5..d7d6d3a8efe5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 		}
 	case SO_TXREHASH:
+		if (!sk_is_tcp(sk))
+			return -EOPNOTSUPP;
 		if (val < -1 || val > 1)
 			return -EINVAL;
 		if ((u8)val == SOCK_TXREHASH_DEFAULT)
@@ -2102,6 +2104,9 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TXREHASH:
+		if (!sk_is_tcp(sk))
+			return -EOPNOTSUPP;
+
 		/* Paired with WRITE_ONCE() in sk_setsockopt() */
 		v.val = READ_ONCE(sk->sk_txrehash);
 		break;
diff --git a/tools/testing/selftests/bpf/progs/setget_sockopt.c b/tools/testing/selftests/bpf/progs/setget_sockopt.c
index 0107a24b7522..d330b1511979 100644
--- a/tools/testing/selftests/bpf/progs/setget_sockopt.c
+++ b/tools/testing/selftests/bpf/progs/setget_sockopt.c
@@ -83,6 +83,14 @@ struct loop_ctx {
 	struct sock *sk;
 };
 
+static bool sk_is_tcp(struct sock *sk)
+{
+	return (sk->__sk_common.skc_family == AF_INET ||
+		sk->__sk_common.skc_family == AF_INET6) &&
+		sk->sk_type == SOCK_STREAM &&
+		sk->sk_protocol == IPPROTO_TCP;
+}
+
 static int bpf_test_sockopt_flip(void *ctx, struct sock *sk,
 				 const struct sockopt_test *t,
 				 int level)
@@ -91,6 +99,9 @@ static int bpf_test_sockopt_flip(void *ctx, struct sock *sk,
 
 	opt = t->opt;
 
+	if (opt == SO_TXREHASH && !sk_is_tcp(sk))
+		return 0;
+
 	if (bpf_getsockopt(ctx, level, opt, &old, sizeof(old)))
 		return 1;
 	/* kernel initialized txrehash to 255 */
-- 
2.49.0


