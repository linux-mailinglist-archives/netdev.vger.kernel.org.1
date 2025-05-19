Return-Path: <netdev+bounces-191586-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B62ABC53C
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 19:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9A24A0769
	for <lists+netdev@lfdr.de>; Mon, 19 May 2025 17:09:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD887284B5F;
	Mon, 19 May 2025 17:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="SdfjQdFP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 268A11E9B21
	for <netdev@vger.kernel.org>; Mon, 19 May 2025 17:09:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747674579; cv=none; b=LogBDE8boq5+Ap4DbeFlFwoo1IuAIAxTWYHwaUq2S4Q2apfL2MDAqrLdhpPEsAvADDdwCI8GJ9F8mQoJ2Q/hwrxvt5D4Fzewj2Ipkhh1NAO8Belak3VAqzGMLH4h8Q/FTgU+KJOJl9RnuvdZ0bglmjmyuzOQQcDYLNawMysC8a4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747674579; c=relaxed/simple;
	bh=lLJ7k0sC/97vNkshvYL8xy39LkyaMSUK1qY+oTI+qd8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j5Soh+tik/oOulu3onteK81FYXs19swuz1xzINp5YrP9XM8iDjbszaDU483z2snCsGTpY0+IF5nuUWmtKuOsSFH6ixXHzxKaR2I1hx8iHKE7NLaDnt6aDqLgoMpReSB/qrToZztCCI+GidKkU4o0P/01pDbNppuZn5vSTNFp9k4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=SdfjQdFP; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747674578; x=1779210578;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T4PUVDdAW0s5RgawTd6dhNfOxaxIE3Stt24SxFqGARs=;
  b=SdfjQdFPUVzww4LP7f5lpbfkK0xdUBWtGy5dhhpaf8Vtg71+OY8lBGod
   KigOgmTtC017cFC3PYBx4ShSoTkRASYllt7P/NhyjvmZBhOOxPr1yEW8/
   hjw7LteM/pec2Qm8nbOuFspWQIKut+ISb2IskzZE7hV2XjYxiEkPlmbJP
   sOWW3sNzukSE03jh+7fGT3Yxn7XoQ0+8kiKfH1BrWFjMF9XU5/Yh2hiU9
   iCSrPd6L7Hhgi5DhWfIfG7EBBC7ah2Ln3tigrQDkHpXfuFPPH/1Tbwv68
   7juEZ1YWX5ht3K5j1kA2AMz727wD4GuCNVfliJXUH7BDCR1wiFxZGGbRj
   g==;
X-IronPort-AV: E=Sophos;i="6.15,301,1739836800"; 
   d="scan'208";a="406871712"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 May 2025 17:09:36 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:15933]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.193:2525] with esmtp (Farcaster)
 id c264c3e0-2d36-42a0-b536-40ebc6b86e2c; Mon, 19 May 2025 17:09:35 +0000 (UTC)
X-Farcaster-Flow-ID: c264c3e0-2d36-42a0-b536-40ebc6b86e2c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 17:09:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.142.169.18) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Mon, 19 May 2025 17:09:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <kuba@kernel.org>
CC: <brauner@kernel.org>, <davem@davemloft.net>, <edumazet@google.com>,
	<horms@kernel.org>, <kuni1840@gmail.com>, <kuniyu@amazon.com>,
	<netdev@vger.kernel.org>, <pabeni@redhat.com>, <willemb@google.com>
Subject: Re: [PATCH v4 net-next 0/9] af_unix: Introduce SO_PASSRIGHTS.
Date: Mon, 19 May 2025 10:09:10 -0700
Message-ID: <20250519170923.37916-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250519070042.662fceb6@kernel.org>
References: <20250519070042.662fceb6@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB004.ant.amazon.com (10.13.138.57) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Jakub Kicinski <kuba@kernel.org>
Date: Mon, 19 May 2025 07:00:42 -0700
> On Thu, 15 May 2025 15:49:08 -0700 Kuniyuki Iwashima wrote:
> > The v2 of the BPF LSM extension part will be posted later, once
> > this series is merged into net-next and has landed in bpf-next.
> 
> This breaks existing BPF selftests ever so slightly, I think:
> 
> Error: #358 setget_sockopt
>   Error: #358 setget_sockopt
> ...
>   test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: actual 0 < expected 1
>   test_udp:PASS:nr_bind 0 nsec
>   test_udp:PASS:start_server 0 nsec
>   test_udp:FAIL:nr_socket_post_create unexpected nr_socket_post_create: actual 0 < expected 1
> 
> https://github.com/kernel-patches/bpf/actions/runs/15112428845/job/42475218987

Thanks for catching!

The test needs to avoid applying SO_TXREHASH to non-TCP sockets,
so I'll fold this into patch 4.

---8<---
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
---8<---

