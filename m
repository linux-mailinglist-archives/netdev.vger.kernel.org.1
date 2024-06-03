Return-Path: <netdev+bounces-100254-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 064118D852B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:35:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC16A1F221C4
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A44EA12F5BB;
	Mon,  3 Jun 2024 14:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="CXtCi+Fn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBCD812EBE6
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:35:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.48.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425324; cv=none; b=TLyZliCzsbpNNF/50JCnh7lQZZKAQOEi5RFFTE3skxGAQz2Hdo/FPFq9f9PqoC54amCbvAiKCaKSeamagk+mjh3v0xxXUSgBZA4ezgGvR75E1Udg6GkeBGDYlqdSwSBWjCd41Jxea5NG9gLf4Gm8kUnuLRZR4O15U1M2amnE5vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425324; c=relaxed/simple;
	bh=PRd4KoCIz5aQvAiZBcPzE68puoh7mzsA9t0m0vasSY0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rlsOPx3qgW1qXeJ8rmqZ7bbb0oIkRc2N1KPTWJ+gMCwx6FdTScmDjWGFFE4RXQMtndieOEgA8rdRlN/SBjVqNTASzAtcmcgTeq4CnJCVoHZQNZGflAVy1hXDzKCmbOqIXyqwvW929bBHIUtuk78FcYd4oGQ/GLtzHbEnSM/CIwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=CXtCi+Fn; arc=none smtp.client-ip=52.95.48.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425323; x=1748961323;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N2ogacUgpG1y+Es4A4LerfkK8Uenw0+IQC+umvPNnXA=;
  b=CXtCi+FnVEq/hACcYcTrPSADci1B6gF161/+RL9TEygj3rjO88poIBkh
   FN66oImiWVrvsmgdYqcAA5Ug+Za6Ndjrx1DnHgTN6T8C91OMD4m8YTDDE
   44cBvGZHCB7NJJXhmZDwKA9lEx1ah33GvbWtTxXm7zuNhY03I/E9jEyvi
   w=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="400664071"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:35:21 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:18129]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.28:2525] with esmtp (Farcaster)
 id 668fd15f-2f0e-45dc-8bcb-fa7185adaff8; Mon, 3 Jun 2024 14:35:21 +0000 (UTC)
X-Farcaster-Flow-ID: 668fd15f-2f0e-45dc-8bcb-fa7185adaff8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:35:20 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:35:18 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 06/15] af_unix: Annotate data-race of sk->sk_state in unix_accept().
Date: Mon, 3 Jun 2024 07:32:22 -0700
Message-ID: <20240603143231.62085-7-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240603143231.62085-1-kuniyu@amazon.com>
References: <20240603143231.62085-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWA003.ant.amazon.com (10.13.139.37) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Once sk->sk_state is changed to TCP_LISTEN, it never changes.

unix_accept() takes the advantage and reads sk->sk_state without
holding unix_state_lock().

Let's use READ_ONCE() there.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index c01ca584a014..a97f4305b74f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -1710,7 +1710,7 @@ static int unix_accept(struct socket *sock, struct socket *newsock,
 		goto out;
 
 	arg->err = -EINVAL;
-	if (sk->sk_state != TCP_LISTEN)
+	if (READ_ONCE(sk->sk_state) != TCP_LISTEN)
 		goto out;
 
 	/* If socket state is TCP_LISTEN it cannot change (for now...),
-- 
2.30.2


