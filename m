Return-Path: <netdev+bounces-158762-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F990A132A8
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:36:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA1B1885532
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E00A114B087;
	Thu, 16 Jan 2025 05:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Om18tGk6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC091804A
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005791; cv=none; b=CE6n/pgknCwSfwipzv8qryexbJxFFyMlzZB4YqU/O9XCPqjUaki/g4T/U9O2m6/muK3CLQr9R+rctrBbMCAmHDRdWXzd23PVEY5Qke6ud5rOpGnrWYonKPuLh/ouGOJ7z7b7qtRJzQynjkKMypeLCgRX6g4G/AWC3q30TuDNx8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005791; c=relaxed/simple;
	bh=ka5tddW9vT2AYR1FOk3xX2fQ2qXzdd6fU4YEbrZOTzI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rsh4dZKoZFZCPR4U2yZOEAg797r6q/7Y1qM8IBHDSdjf4G/UCpvvw7kuoep29Uht5u9XEqf9bk+wQdnNtMhnmpYWtwi2btN7/h0x908n9viS3KbeOzHE6lsmobgNmHgHwLCQPOOfIBz4SFGmleSyCJ7rvzpKHnveJr1YeGb9XQw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Om18tGk6; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005790; x=1768541790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pvTppOl7MKVCY59BRjIRFn5kMxrLpjCsRsywSXQxCDE=;
  b=Om18tGk6WH0W3yoXKoztqSjeQ15Jw1P1cj3gLKePbqnCaIpAzuktxTKg
   pxLGiFeUJyFCokveVruVgDUeJ/Ip/ZYeYyI6rX6sIFu8XG903B5TPRDCG
   PQ8bJD9NGLs5H2RgUhz3bpC5lOIlA2786XKxnnjYhvYJgWer9/RB9UXOg
   Q=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="164573865"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:36:28 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:6880]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.53:2525] with esmtp (Farcaster)
 id 3c860d81-828a-4134-a3ea-9bd5035d6430; Thu, 16 Jan 2025 05:36:28 +0000 (UTC)
X-Farcaster-Flow-ID: 3c860d81-828a-4134-a3ea-9bd5035d6430
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:36:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:36:23 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 3/9] af_unix: Set drop reason in unix_sock_destructor().
Date: Thu, 16 Jan 2025 14:34:36 +0900
Message-ID: <20250116053441.5758-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250116053441.5758-1-kuniyu@amazon.com>
References: <20250116053441.5758-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA001.ant.amazon.com (10.13.139.101) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_sock_destructor() is called as sk->sk_destruct() just before
the socket is actually freed.

Let's use SKB_DROP_REASON_SOCKET_CLOSE for skb_queue_purge().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index a05d25cc5545..41b99984008a 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -640,7 +640,7 @@ static void unix_sock_destructor(struct sock *sk)
 {
 	struct unix_sock *u = unix_sk(sk);
 
-	skb_queue_purge(&sk->sk_receive_queue);
+	skb_queue_purge_reason(&sk->sk_receive_queue, SKB_DROP_REASON_SOCKET_CLOSE);
 
 	DEBUG_NET_WARN_ON_ONCE(refcount_read(&sk->sk_wmem_alloc));
 	DEBUG_NET_WARN_ON_ONCE(!sk_unhashed(sk));
-- 
2.39.5 (Apple Git-154)


