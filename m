Return-Path: <netdev+bounces-158765-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 41B08A132AC
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 06:37:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914B31885797
	for <lists+netdev@lfdr.de>; Thu, 16 Jan 2025 05:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DE1A156F41;
	Thu, 16 Jan 2025 05:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tMQgGFaW"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52002.amazon.com (smtp-fw-52002.amazon.com [52.119.213.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9DE814B087
	for <netdev@vger.kernel.org>; Thu, 16 Jan 2025 05:37:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737005873; cv=none; b=F4Xx2XYP2A3z9Pq6xjjhX0Tvi52bLfiKU6kCSf2YIGk2yAVpt56mdtwAD8myPRBYPvRtuT5PiGKrYSojlC55BoRVAqyzOFIP0xJ4Ze3mglO+GGCxeb/MvqvMXllyDS1DQN9vAuFV/lWQtwCPlWLe3Yt2HacHTY6G+B8oUcZ3UpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737005873; c=relaxed/simple;
	bh=5n4QW4cigvEMD45CqkTPZa8QexPNAllzgAVyLTkDftQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=H5hpuGXj3nD2mivFB5t+C7dh2YHqY8xZHMjFw6ICpKfSmeHKkROZhE/etYyyjC7VmTpsUjH2KlKCb52X8/LKEUkWiW5DdD70q0GYxAiGslwjohwOtqFtkO8IUDIbbxjxFxJZ4gRzwq7dGkqRydSTy58vOfaa9h4DKBPN1QjKb8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tMQgGFaW; arc=none smtp.client-ip=52.119.213.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1737005872; x=1768541872;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VBDrjZBeOAr3zX+VRYsBMa9DOZCrSiEvn7oDLJwJMB8=;
  b=tMQgGFaWqyTn4IMFFecIstEhr1O9/8wv+3a74PWSe/b6rB3b4JFZ5KiO
   rW4MyZZgt6d7rGo6+MR3IjI/e9L7cPNx4+dnQT8w0kefuNSSHnzBMODUz
   OQYfaov0hEjhObpKQxsJaF+4S7IZlzUHzBHBRa46UgNTBwdAN4ZAY86bH
   M=;
X-IronPort-AV: E=Sophos;i="6.13,208,1732579200"; 
   d="scan'208";a="689608880"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52002.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2025 05:37:50 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:1806]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.54.33:2525] with esmtp (Farcaster)
 id df48464c-a7fb-4815-9141-899055f8bc9c; Thu, 16 Jan 2025 05:37:49 +0000 (UTC)
X-Farcaster-Flow-ID: df48464c-a7fb-4815-9141-899055f8bc9c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:37:48 +0000
Received: from 6c7e67c6786f.amazon.com (10.143.84.222) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Thu, 16 Jan 2025 05:37:45 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Simon Horman <horms@kernel.org>
CC: Donald Hunter <donald.hunter@redhat.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 6/9] af_unix: Set drop reason in unix_stream_read_skb().
Date: Thu, 16 Jan 2025 14:34:39 +0900
Message-ID: <20250116053441.5758-7-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWC002.ant.amazon.com (10.13.139.242) To
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
index e31fda1d319f..de4966e1b7ff 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2724,7 +2724,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 
 		if (sock_flag(sk, SOCK_DEAD)) {
 			unix_state_unlock(sk);
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_SOCKET_CLOSE);
 			return -ECONNRESET;
 		}
 
@@ -2738,7 +2738,7 @@ static int unix_stream_read_skb(struct sock *sk, skb_read_actor_t recv_actor)
 		unix_state_unlock(sk);
 
 		if (drop) {
-			kfree_skb(skb);
+			kfree_skb_reason(skb, SKB_DROP_REASON_UNIX_SKIP_OOB);
 			return -EAGAIN;
 		}
 	}
-- 
2.39.5 (Apple Git-154)


