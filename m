Return-Path: <netdev+bounces-149594-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B19799E66D3
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8F081169CA7
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB73819644B;
	Fri,  6 Dec 2024 05:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="HDyx5oM7"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DED3183098
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462863; cv=none; b=so91o/g/szv0/6Uc8/f7+xu8ykLYna+BfovdvU9RzAW4EGw0FnTQKtUAn569u9CR/G8O2T/KS2WQhZJrF0Q4anCT8Lz5DVYjlsTdGmpPGgIScKViXGNa6/9rcgXXB4xpVcXj71vu8GyjPFja3om+sVmsNpB1QMwbgOd6PPSchtY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462863; c=relaxed/simple;
	bh=wcXLCLROnULzp9og+l8E4YIMb2d5sJ/B0CeuVU97l0E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0ArrDnHNkzy619buTA/X6TiswQtHGPITS65QGNARRckECqeieOqpId4e1TtuR9ShHHQHuyiYJqGSrv/aex90QMbLezMg9SpP5ayMtoaeQwmY0F8DoN7ZUb94BelvP+JobxxFl/YQNv1oXZ0nglRqTznuWCjn3DwA9MhLAUWMcc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=HDyx5oM7; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462863; x=1764998863;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ZLG5h3nUGvzEqMzVGwiWJiGAs/nWhGpOarkQJrcKt/I=;
  b=HDyx5oM7TAW4TZP0JmduvGg3g9o0F8YYFJE7OexyhtRbrjQnMxK2NdUS
   ZCYww7evqXybVmBDGUK66xgEM+XHEzRKQeH2WJaoyDyCp02ZKDVHyHjKW
   35D8DdEfBqRCHRalO3zh2RGVERjk7Jy4TlK2gcwv3mZRAgWaqn5iAPE85
   s=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="475956196"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:27:42 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.7.35:50294]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.181:2525] with esmtp (Farcaster)
 id d3bf729d-4d01-4ec3-9737-21a8ec490e2c; Fri, 6 Dec 2024 05:27:41 +0000 (UTC)
X-Farcaster-Flow-ID: d3bf729d-4d01-4ec3-9737-21a8ec490e2c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:27:40 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:27:37 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 04/15] af_unix: Remove redundant SEND_SHUTDOWN check in unix_stream_sendmsg().
Date: Fri, 6 Dec 2024 14:25:56 +0900
Message-ID: <20241206052607.1197-5-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sock_alloc_send_pskb() in the following while loop checks if
SEND_SHUTDOWN is set to sk->sk_shutdown.

Let's remove the redundant check in unix_stream_sendmsg().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 8d13b580731c..db00afe84ce9 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2275,9 +2275,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		}
 	}
 
-	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
-		goto pipe_err;
-
 	while (sent < len) {
 		size = len - sent;
 
@@ -2361,7 +2358,6 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 pipe_err_free:
 	unix_state_unlock(other);
 	kfree_skb(skb);
-pipe_err:
 	if (sent == 0 && !(msg->msg_flags&MSG_NOSIGNAL))
 		send_sig(SIGPIPE, current, 0);
 	err = -EPIPE;
-- 
2.39.5 (Apple Git-154)


