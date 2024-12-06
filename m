Return-Path: <netdev+bounces-149591-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C58F19E66CE
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 06:26:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9371E169B25
	for <lists+netdev@lfdr.de>; Fri,  6 Dec 2024 05:26:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEA99194C6F;
	Fri,  6 Dec 2024 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="dmcEZY6/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AA86194120
	for <netdev@vger.kernel.org>; Fri,  6 Dec 2024 05:26:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733462803; cv=none; b=R4SXOz+iQSOM5uv3cS8xlB8cRmQnIGAxcnC/EAeIDYwwzXccm1VQRhLGtSCI6lRrM1mvUeb6KRqcDCfiomPzkIT2zvyYpfFxINOLeK8Ny0OPb2+0S1zKs0SIkwl2rB00PQG8eE5uJRzieeZllwwb4wN+em7++zrhkbtwYFiyHs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733462803; c=relaxed/simple;
	bh=GeXJUy4iP3rM/2ldcApNdBpBTEl16YlgklvbQ2f03Vs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i0bRh/pQnJRf6aW3YeJbLb3UWK501jSHeHNwXm+673MaGgENmmLXMQaStEZ/HrydkGzHcmTmbLi12rgDkmK5AHBckELd0WhiTF7bLamBsnp/yLUbnzKtjQO8jcqrhMw748R35edvluX65pru53YEQ9glgZikVzaXsuXk0yaMmBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=dmcEZY6/; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1733462802; x=1764998802;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JMu66G5QmNB26Vx+pLWyhKn8wrrsyK5jBDg0q4UQ71s=;
  b=dmcEZY6/NguVSGVo0hYlDiNkt88BQu493OUthLNHOnuHOZXF2KGceDLY
   trfgg/2F38VnK2/w427ZbpjUsqWXMCpMWIELiJ3Z6ZSoWmVVj+ealKP3S
   Uph9weagwGT+Tk2lcZycLX/LZkl//yZ9YT1MvfAWOejWUNu0saCC+7l2T
   4=;
X-IronPort-AV: E=Sophos;i="6.12,212,1728950400"; 
   d="scan'208";a="150829028"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Dec 2024 05:26:39 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.38.20:63946]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.2:2525] with esmtp (Farcaster)
 id ecd7c654-7ece-43ea-8593-01a9fc36a2c9; Fri, 6 Dec 2024 05:26:39 +0000 (UTC)
X-Farcaster-Flow-ID: ecd7c654-7ece-43ea-8593-01a9fc36a2c9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 6 Dec 2024 05:26:39 +0000
Received: from 6c7e67c6786f.amazon.com (10.118.244.93) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 6 Dec 2024 05:26:35 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 01/15] af_unix: Set error only when needed in unix_stream_connect().
Date: Fri, 6 Dec 2024 14:25:53 +0900
Message-ID: <20241206052607.1197-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D041UWB003.ant.amazon.com (10.13.139.176) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We will introduce skb drop reason for AF_UNIX, then we need to
set an errno and a drop reason for each path.

Let's set an error only when it's needed in unix_stream_connect().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 001ccc55ef0f..6435ce699289 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1575,12 +1575,12 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto out;
 	}
 
-	err = -ENOMEM;
-
 	/* Allocate skb for sending to listening sock */
 	skb = sock_wmalloc(newsk, 1, 0, GFP_KERNEL);
-	if (skb == NULL)
+	if (!skb) {
+		err = -ENOMEM;
 		goto out;
+	}
 
 restart:
 	/*  Find listening sock. */
@@ -1600,16 +1600,17 @@ static int unix_stream_connect(struct socket *sock, struct sockaddr *uaddr,
 		goto restart;
 	}
 
-	err = -ECONNREFUSED;
-	if (other->sk_state != TCP_LISTEN)
-		goto out_unlock;
-	if (other->sk_shutdown & RCV_SHUTDOWN)
+	if (other->sk_state != TCP_LISTEN ||
+	    other->sk_shutdown & RCV_SHUTDOWN) {
+		err = -ECONNREFUSED;
 		goto out_unlock;
+	}
 
 	if (unix_recvq_full_lockless(other)) {
-		err = -EAGAIN;
-		if (!timeo)
+		if (!timeo) {
+			err = -EAGAIN;
 			goto out_unlock;
+		}
 
 		timeo = unix_wait_for_peer(other, timeo);
 
-- 
2.39.5 (Apple Git-154)


