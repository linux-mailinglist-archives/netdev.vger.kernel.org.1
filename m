Return-Path: <netdev+bounces-100262-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3479C8D8544
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:38:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1413B254AE
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885BB12F5A1;
	Mon,  3 Jun 2024 14:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="BKKr2rlC"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296CA12F59B
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425521; cv=none; b=IY6eMizIneW00XlO8FI0k0izBEd4bF0VQEkXUOsnBC2MffUiyxn1MckRczfbHCCeEp7lnylgRQxY9mBURA3URIp4jWVD1oGJm+Hzk7xvVdJO2jnPy57nA8e5sfGQ1ll0oiTNX7oYbGBILNFrAMKYq50S5AIjWFPAp2L7/Gcnxic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425521; c=relaxed/simple;
	bh=Cw4e4BnKX7L9YEl3TkBfINBmvjOGwhz0SK74j0vQPS0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=eHtepgm8Gp6WIT1la2epuyQQ9lZSuui3QVA1S8B/h8s6p3hEXEbjczsEfmegsXaRxkVcN7m3kvsudIqWheILW/cFRwOy8TaatFzgIROTnzwiok3i2ap1ZHdG3daumVpy2XbtGBuPMxxvw9cogTfgg4TX6KRwVcg+3bOxgC10lfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=BKKr2rlC; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425520; x=1748961520;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=PWqYgkHnRGWvpHLeE+UUJyKSFZQLIlRz17nBIKZqxyY=;
  b=BKKr2rlCJJ4IIAdUZgszUEkuAzeOPzJu4BqSUOm1z8vqWoPH/ahZrdp0
   HVPZyzlXSmpM4XykrSc2UsdO0SzKXwHFxYzDaz9Vl59+8n27RPiFDwSOD
   0mrZ9jUcbc202pQ/9TJRQyaoRLJsk+Tcj628DHcN3eF49aKjaeGTWpeRx
   k=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="93797747"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:38:39 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:13175]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.28:2525] with esmtp (Farcaster)
 id c8048c83-2a28-4dc1-b4d2-49ca3218f3f1; Mon, 3 Jun 2024 14:38:39 +0000 (UTC)
X-Farcaster-Flow-ID: c8048c83-2a28-4dc1-b4d2-49ca3218f3f1
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:38:34 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 3 Jun 2024 14:38:32 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 14/15] af_unix: Use skb_queue_len_lockless() in sk_diag_show_rqlen().
Date: Mon, 3 Jun 2024 07:32:30 -0700
Message-ID: <20240603143231.62085-15-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

We can dump the socket queue length via UNIX_DIAG by specifying
UDIAG_SHOW_RQLEN.

If sk->sk_state is TCP_LISTEN, we return the recv queue length,
but here we do not hold recvq lock.

Let's use skb_queue_len_lockless() in sk_diag_show_rqlen().

Fixes: c9da99e6475f ("unix_diag: Fixup RQLEN extension report")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/diag.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/diag.c b/net/unix/diag.c
index 116cf508aea4..321336f91a0a 100644
--- a/net/unix/diag.c
+++ b/net/unix/diag.c
@@ -104,7 +104,7 @@ static int sk_diag_show_rqlen(struct sock *sk, struct sk_buff *nlskb)
 	struct unix_diag_rqlen rql;
 
 	if (READ_ONCE(sk->sk_state) == TCP_LISTEN) {
-		rql.udiag_rqueue = sk->sk_receive_queue.qlen;
+		rql.udiag_rqueue = skb_queue_len_lockless(&sk->sk_receive_queue);
 		rql.udiag_wqueue = sk->sk_max_ack_backlog;
 	} else {
 		rql.udiag_rqueue = (u32) unix_inq_len(sk);
-- 
2.30.2


