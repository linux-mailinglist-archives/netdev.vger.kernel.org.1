Return-Path: <netdev+bounces-151702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E7CE9F0A77
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 12:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9116D1889DF2
	for <lists+netdev@lfdr.de>; Fri, 13 Dec 2024 11:10:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4781CD1EA;
	Fri, 13 Dec 2024 11:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="sDKMwitU"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52005.amazon.com (smtp-fw-52005.amazon.com [52.119.213.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 233F61C07F0
	for <netdev@vger.kernel.org>; Fri, 13 Dec 2024 11:10:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734088224; cv=none; b=E8JLprhaP6nXIUfuKnhJOOJoyemP4V5dOqCCunYZhAtNieGaP0vYo4wG/TUxu/5GmeG8GmIsJZG2/BBPHF/pyoDzL3BDxiwQWyy4p0xroME1E4ChhdTxY9O77nFiKH4fNCJDI5rJcq17PyL4TceajfTOw3lH5go73HgeNykFHQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734088224; c=relaxed/simple;
	bh=bo6hKWIEtBLm7+y+nuarW3MGxRDSmgFZbYnhVWrvFts=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UnCBkh9Vmc/w7hfDBGvR0NxQf+RbRQBagtdz7H6PejrIOGQ3iVR7ETtNGVnMl+DO5Uc29GaZ+ZJly6vxIPHk6iwlrbkwgSeMgR9MsntFLWei/KjSLm+s/8xJ5UR/SjyE8lCkVMltIFgZfD/BBZ1YAKIsy91ot6vhu2lfATMe+rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=sDKMwitU; arc=none smtp.client-ip=52.119.213.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734088223; x=1765624223;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=UNIp1YwQwswaAcicKhpiZ5KduXpd0LX93Y27h3KHzPg=;
  b=sDKMwitU/d6TmSjXwo050g480DMDTaoLldgkrlZyD80lTYmDUgZPIC4k
   nRMdOK/oiMOljK7LfgJcyNoabPL6CNEGQHWMOcFxkpPDgFDACyybPY3FZ
   BYSREuwG4ZRjVHZVa9Az5t1VEeKimEC9t2j7sCb71Br3afOKb2Mhh3eg3
   g=;
X-IronPort-AV: E=Sophos;i="6.12,231,1728950400"; 
   d="scan'208";a="702731385"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-52005.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 11:10:04 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.38.20:9080]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id cfd90581-d03d-4e91-b7d9-58b7be4382a6; Fri, 13 Dec 2024 11:10:03 +0000 (UTC)
X-Farcaster-Flow-ID: cfd90581-d03d-4e91-b7d9-58b7be4382a6
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:10:01 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 11:09:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 03/12] af_unix: Set error only when needed in unix_stream_sendmsg().
Date: Fri, 13 Dec 2024 20:08:41 +0900
Message-ID: <20241213110850.25453-4-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D039UWB001.ant.amazon.com (10.13.138.119) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce skb drop reason for AF_UNIX, then we need to
set an errno and a drop reason for each path.

Let's set an error only when it's needed in unix_stream_sendmsg().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 21e17e739f88..660d8b8130ca 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2254,8 +2254,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 
 	wait_for_unix_gc(scm.fp);
 
-	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
+		err = -EOPNOTSUPP;
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
 		if (len)
 			len--;
@@ -2268,10 +2268,11 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 		err = READ_ONCE(sk->sk_state) == TCP_ESTABLISHED ? -EISCONN : -EOPNOTSUPP;
 		goto out_err;
 	} else {
-		err = -ENOTCONN;
 		other = unix_peer(sk);
-		if (!other)
+		if (!other) {
+			err = -ENOTCONN;
 			goto out_err;
+		}
 	}
 
 	if (READ_ONCE(sk->sk_shutdown) & SEND_SHUTDOWN)
-- 
2.39.5 (Apple Git-154)


