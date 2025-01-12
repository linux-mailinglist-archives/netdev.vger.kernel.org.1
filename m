Return-Path: <netdev+bounces-157497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D72C3A0A727
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 05:12:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D8D6518865AE
	for <lists+netdev@lfdr.de>; Sun, 12 Jan 2025 04:12:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5063125761;
	Sun, 12 Jan 2025 04:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CfQC0RPu"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903D26FB0
	for <netdev@vger.kernel.org>; Sun, 12 Jan 2025 04:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736655150; cv=none; b=ufNS1tab1KzdrT23I7VkCV6gJY01w0wRBgsYietriA32AUxdNjrfTxgF71ZF3w4sAj9RK6DB7gglVhOGWls3+D+G8BflGjpqfzijvim4Mx18goHBAYsP3/5QE85S6f5Cat6A+c5KTKvx3wtxAh1MMGVl8UQj7OHh+unouZc7m6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736655150; c=relaxed/simple;
	bh=AccllP+Cpxs4Imcd4zXg2JkBsTq1fRBvhGakV8IIqow=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JOxbdNwcKcPS5S2Nm8uGcdywBXBuuLAYnZWaqd06X7tS2wREfmLiGFJZoEJbIdMAfwA/+r3XI2JikgBPMfjiCDaB93luqp18Y6uocg1AyfgXBpnuLgiUEuttdq5WOoUvlxPoBHn/UiFMoYVSDjr5AFHdEYUaz7E94FZqigViseU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CfQC0RPu; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736655149; x=1768191149;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=QqGe80cPio8XAhljA/c8PqPGeu0wHcGL5mCeCIYDaKs=;
  b=CfQC0RPu1yYKQu2yHjljvnr90CCWPZeZ2E35wop7X7w2SZ/6l9hehhGh
   3QJN/vtfb50pB4Dz4oa3d6p3tLQbm/NChgtTg231IcNNPGoDSKkONtG+f
   TkD0hPi45hsGp6jUNKgF0sdk9FCwTS9f7Ve5c9NQrnoEj4X0fxTKbJ7dR
   4=;
X-IronPort-AV: E=Sophos;i="6.12,308,1728950400"; 
   d="scan'208";a="262419357"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jan 2025 04:12:26 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:59593]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.42.134:2525] with esmtp (Farcaster)
 id 033d6d6d-ca15-4baf-9af6-78e428b4b728; Sun, 12 Jan 2025 04:12:24 +0000 (UTC)
X-Farcaster-Flow-ID: 033d6d6d-ca15-4baf-9af6-78e428b4b728
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:12:24 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.156) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Sun, 12 Jan 2025 04:12:20 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/11] af_unix: Set drop reason in unix_stream_read_skb().
Date: Sun, 12 Jan 2025 13:08:08 +0900
Message-ID: <20250112040810.14145-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250112040810.14145-1-kuniyu@amazon.com>
References: <20250112040810.14145-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA002.ant.amazon.com (10.13.139.81) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

unix_stream_read_skb() is called when BPF SOCKMAP reads some data
from a socket in the map.

SOCKMAP does not support MSG_OOB, and reading OOB results in a drop.

Let's set drop reasons respectively.

  * SOCKET_CLOSE  : the socket in SOCKMAP was close()d
  * UNIX_SKIP_OOB : OOB was read from the socket in SOCKMAP

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index efd1b83b152a..ed577276bd27 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2777,7 +2777,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 		if (sock_flag(sk, SOCK_DEAD)) {
 			unix_state_unlock(sk);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 			return -ECONNRESET;
 		}
 
@@ -2791,7 +2791,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		unix_state_unlock(sk);
 
 		if (drop) {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 			return -EAGAIN;
 		}
 	}
-- 
2.39.5 (Apple Git-154)


