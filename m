Return-Path: <netdev+bounces-149601-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F9DE9E66E2
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:30:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 560CA18845B0
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:30:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD71974F4;
	Fri,  6 Dec 2024 05:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="XVPsxwr9"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FB8558A5
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733463012; cv=none; b=nLuAO9+JtJJBa2WZEMx0hD+fOWOBIuR45jt+OTwDVxQcFBMQxwoyUSemsk6b/zfsw9D0TNNhC1r/BLFWMKc99++Wd4SGcGmTgy9UZSgEvbEEcjOAzaeWYo1ALxFlr7q3O0wveto5Pefkfr3U/NqMOT9IYb52Fxlxx4htenITn+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733463012; c=relaxed/simple;
	bh=ijV/cdOUF2VqJeA9MQJ05gaxswSj1YUbamzXmk/RmEc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CURe2OtSlYkZ50B5GWKn7dLP4dFNEf002IGZX/aLVyIJxqH/SNFKvS5oGIG2kMorh+bqwbPJpGF3jLBDWtTD6nC63TXCWo3vvfyYUYkUTOBA7aZt4uPiYKUVsihtXRmW6SaBkNfbvOIn1CNbc4/cB61LVn6t6Fp7DU3/Ix4N688=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=XVPsxwr9; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733463011; x=1764999011;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=XFLo3FllJuZXjLPZFObev1yZdbhdsL2RvP4FMwZwNuo=;
  b=XVPsxwr9qoU5fR1JcNPbVaJQqNwc8seuCzYP+lvgriB7tvoTqNZBPIhT
   aM8QiUD+yXGg/dUE8DKcBR1ySNPL1fM+TBqqfwwdVqVLTJhgZAn4iv1Z8
   PTOVPpi7ZvfFp79eO1ttC3zl3WibJBRXU7rGQnuTlOC4MvIMgcVx/wofz
   w=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="443570478"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.124.125.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:30:07 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:64214]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.38.94:2525] with esmtp (Farcaster)
 id ab24f156-155a-46d9-bbc6-4c4c0eb2b0bb; Fri, 6 Dec 2024 05:30:06 +0000 (UTC)
X-Farcaster-Flow-ID: ab24f156-155a-46d9-bbc6-4c4c0eb2b0bb
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:30:05 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:30:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 11/15] af_unix: Defer sock_put() to clean up path in unix_dgram_sendmsg().
Date: Fri, 6 Dec 2024 14:26:03 +0900
Message-ID: <20241206052607.1197-12-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241206052607.1197-1-kuniyu@amazon.com>
References: <20241206052607.1197-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB002.ant.amazon.com (10.13.139.188) To
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
index b23d36b049da..2ea5f8ec5ec4 100644
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


