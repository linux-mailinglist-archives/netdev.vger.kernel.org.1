Return-Path: <netdev+bounces-157035-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3FD7A08C1D
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 10:33:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9867C1662A3
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 09:32:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFB27207DFC;
	Fri, 10 Jan 2025 09:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="KtvYipWE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2B24209F31
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 09:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736501490; cv=none; b=kdgz4P+5VriYPEv33vdaPvXEJGqWLelEn3/2mXU0A9/rKA969mvze9gt7Hcf4skb/la0uoUMS4NcPBToLa+1aCsfyNHVL1dB9zrLWagmHtqI4dnaF6VqR2t3qdjIGQSIl9f6gBoUaBaEHCGfWP1LyzzyXSQklyvB3j2DFUu4+sI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736501490; c=relaxed/simple;
	bh=Nc9wgKHYkq8sTiPEOynTWTtT7mloaNt70oydqUe0PBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WhU1IiLFPxY70AeCVeh9zl0YKZlU7rK6rhrJbL24Q0olahGcmgOBZfZ60jncNK6dazQe+OYCDnSuFidev2onPLN0Ro3p6q663W9iwVuqCmlgExVmnKvH4c+LALYDLRz6n+avxcFqto3n2ugLNpsvYkCgIPCmeR/+vQkDOzCYgag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=KtvYipWE; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1736501489; x=1768037489;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ir1honBL5vaRXaL2ulf1SyE6LQGBYV1ssL0hzSJK4+M=;
  b=KtvYipWEVyWNI2ZgDtJ8DjHCrHzS6JKLKDYKl366CEdeo/iMdhzdeD1g
   gBDmFG5FpxvgQHgXnoEthtZGiiRG24sUFVGEEpw6liJ1S7Dhrac3RYzRg
   T1wSeb2OfikUwq37kQF8aTNMfm4/KG1MRjGV403wasU4vib2R+DfUVTUt
   c=;
X-IronPort-AV: E=Sophos;i="6.12,303,1728950400"; 
   d="scan'208";a="688274748"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jan 2025 09:31:26 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:53212]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.45.174:2525] with esmtp (Farcaster)
 id d1a24d83-a3e2-443e-aebe-71e2b68b8113; Fri, 10 Jan 2025 09:31:25 +0000 (UTC)
X-Farcaster-Flow-ID: d1a24d83-a3e2-443e-aebe-71e2b68b8113
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:31:25 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.252.101) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 10 Jan 2025 09:31:21 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 10/12] af_unix: Set drop reason in unix_stream_read_skb().
Date: Fri, 10 Jan 2025 18:26:39 +0900
Message-ID: <20250110092641.85905-11-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20250110092641.85905-1-kuniyu@amazon.com>
References: <20250110092641.85905-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
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
index 06d90767040e..80c979266d37 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2773,7 +2773,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 		if (sock_flag(sk, SOCK_DEAD)) {
 			unix_state_unlock(sk);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 			return -ECONNRESET;
 		}
 
@@ -2787,7 +2787,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		unix_state_unlock(sk);
 
 		if (drop) {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 			return -EAGAIN;
 		}
 	}
-- 
2.39.5 (Apple Git-154)


