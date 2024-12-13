Return-Path: <netdev+bounces-151708-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 124CE9F0A84
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:12:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FE8516017E
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:12:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E741CEADF;
	Fri, 13 Dec 2024 11:12:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="e8RE6t0o"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0AF81C4A17
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:12:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088332; cv=none; b=ipKHaMleUzaNUJxgUUqmvI9sCepJtSVzlz9wmgKp+hs3nPshbTqYea0dfDqVPZq/1vvAjykbdUCbbRlQJvPXgrzSmeX+Lo82BaXq7epMk1eSgKoahTfzEqNxSh1rDJoZaVColl4HYFyM2k8T02Qwb48eib0fMvPROJcExc1AC3E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088332; c=relaxed/simple;
	bh=8+Torv7ERHwa4e365yxKQCtdVtJICfFho9xb8Fot3DM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=GrTsx8HwRdsY7lLSLx2w3wckX6TYh70rEQquCSrzgJg6gTkjs6Kv9oMUWCFRAYLLiiM0G6J84In9BojFkQ63THbselTku8h9kSAipO+D0Yxe+wr6ywOMQwxmwp2S7kgPxuH5nzH3kWXAa9+Ri0cux5lFn9Sk4bnwpdGg0MWok4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=e8RE6t0o; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088253; x=1765624253;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9bysGw94J8T39hGRAct4Xpnd1NtLR0WaLRZ6MzjVFlw=;
  b=e8RE6t0oYNGFWES6w8mDLUe0dxqDfNCJTZxUpKU8roPXCSayCfavKXFU
   L4+0Fq6Nxs7iciRYzIzXyoQn3eO37XZB5ILUd6mE5NH6XTMh5CTVEPm9h
   4a411nz0WtgD5ueKFn4aoGtQ3phAABvL76xZOjRetcyD44H/U5UCMCWS2
   8=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="5700688"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:10:52 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:62286]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id 2367eab7-658d-477c-b78c-3ec99fa68039; Fri, 13 Dec 2024 11:12:09 +0000 (UTC)
X-Farcaster-Flow-ID: 2367eab7-658d-477c-b78c-3ec99fa68039
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:12:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:12:05 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 09/12] af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().
Date: Fri, 13 Dec 2024 20:08:47 +0900
Message-ID: <20241213110850.25453-10-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241213110850.25453-1-kuniyu@amazon.com>
References: <20241213110850.25453-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB004.ant.amazon.com (10.13.139.177) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

When other has SOCK_DEAD in unix_dgram_sendmsg(), we call sock_put() for
it first and then set NULL to other before jumping to the error path.

This is to skip sock_put() in the error path.

Let's not set NULL to other and defer the sock_put() to the error path
to clean up the labels later.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 513d0fd12e6a..b8adfb41d11b 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2075,7 +2075,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 		 *	datagram error
 		 */
 		unix_state_unlock(other);
-		sock_put(other);
 
 		if (!sk_locked)
 			unix_state_lock(sk);
@@ -2104,7 +2103,6 @@ static int unix_dgram_sendmsg(struct socket *sock, struct msghdr *msg,
 				err = -ECONNRESET;
 		}
 
-		other = NULL;
 		if (err)
 			goto out_free;
 
-- 
2.39.5 (Apple Git-154)


