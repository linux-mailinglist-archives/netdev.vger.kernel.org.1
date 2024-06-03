Return-Path: <netdev+bounces-100259-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6535B8D853B
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 16:37:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0152E1F212B3
	for <lists+netdev@lfdr.de>; Mon,  3 Jun 2024 14:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B72012F360;
	Mon,  3 Jun 2024 14:37:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="uDPLa72f"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A8A12BEBE
	for <netdev@vger.kernel.org>; Mon,  3 Jun 2024 14:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717425446; cv=none; b=FyN6HIy4XpAaMiwsEes+ElRTwK0wnCMmKOsSmWdxa3lS0ak7BYk3Xy7NdxXC6vjqxlrHc9+9UTVXs8QXjQv9HaSVKRo0LU8zSnDiXGm65vOwVO3o5mzELufPVtvVqEoh1U84IP81/1Oi0GisGBB6583Y7uXS/aL+SSAKK8rWRKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717425446; c=relaxed/simple;
	bh=nTZr3nqtbY/2ddX/PPxVmD0lRqLfk8rwN7nKzu4unfA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PnC1mJ6q1tV/e4R7s4wBu93KvOIbKkvoOo3WDWJJXNGgy2uVYnMOejTxnvMfOfZoynb3KN7Rb6ye83XiWyHhkRo6xDCbr96VUEYdunV+HbC7S6Oz+TTiWCHJN4Ops7Bn2RGYAq+Q0Uo8vs8hEInwrjlkCclIAdNccq7GD+KJRB8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=uDPLa72f; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1717425445; x=1748961445;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/4ELSAaa2P4z4t5gdf38DXbTNnGFyllcOSe+fbkaNdU=;
  b=uDPLa72fiudlFuKmJQmcgSfLN7tpTUpeMaT3YWT1bsLELfucBl50vg/i
   BJCAz825PP19taN5aFj+NYLBSK0dab28NhiDmo2OLjo27gT+6LUHg0H82
   dPebAMuyYGiA+yZdbDZGT5ReZlklXS1yl5usAAcN3qiA4Ao4wBgMWucTK
   s=;
X-IronPort-AV: E=Sophos;i="6.08,211,1712620800"; 
   d="scan'208";a="405258561"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jun 2024 14:37:23 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:12256]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.2.238:2525] with esmtp (Farcaster)
 id 52dc263b-9bcc-4a9a-96bd-823148fc6fd8; Mon, 3 Jun 2024 14:37:22 +0000 (UTC)
X-Farcaster-Flow-ID: 52dc263b-9bcc-4a9a-96bd-823148fc6fd8
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 3 Jun 2024 14:37:21 +0000
Received: from 88665a182662.ant.amazon.com (10.88.143.104) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Mon, 3 Jun 2024 14:37:19 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 11/15] af_unix: Annotate data-race of net->unx.sysctl_max_dgram_qlen.
Date: Mon, 3 Jun 2024 07:32:27 -0700
Message-ID: <20240603143231.62085-12-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

net->unx.sysctl_max_dgram_qlen is exposed as a sysctl knob and can be
changed concurrently.

Let's use READ_ONCE() in unix_create1().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/unix/af_unix.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index e99b94fc80b3..6773f1465e50 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -976,7 +976,7 @@ static struct sock *unix_create1(struct net *net, struct socket *sock, int kern,
 	sk->sk_hash		= unix_unbound_hash(sk);
 	sk->sk_allocation	= GFP_KERNEL_ACCOUNT;
 	sk->sk_write_space	= unix_write_space;
-	sk->sk_max_ack_backlog	= net->unx.sysctl_max_dgram_qlen;
+	sk->sk_max_ack_backlog	= READ_ONCE(net->unx.sysctl_max_dgram_qlen);
 	sk->sk_destruct		= unix_sock_destructor;
 	u = unix_sk(sk);
 	u->listener = NULL;
-- 
2.30.2


