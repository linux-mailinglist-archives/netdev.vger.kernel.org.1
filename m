Return-Path: <netdev+bounces-190505-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 12D64AB71F5
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 18:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 34C0F7AA1A9
	for <lists+netdev@lfdr.de>; Wed, 14 May 2025 16:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FE2A2749EA;
	Wed, 14 May 2025 16:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="gcC4aI6M"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-2101.amazon.com (smtp-fw-2101.amazon.com [72.21.196.25])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E993E27A137
	for <netdev@vger.kernel.org>; Wed, 14 May 2025 16:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=72.21.196.25
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747241659; cv=none; b=mE8g+ZFOO7yjKtUQDkPzaxIurM21e74ByC9Kb3nxVIw1wZObVr51fmptm3nSHKh/N5GBO8Y1hu0qQnEk1iEyWzjf4Zl+I/FMNkitmu2F1JPY6vnyfvmcWwn7m1BFVYG1lLkPPex4mCWYziodY0kuxI+0joUVNcEokxnhym2q6IA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747241659; c=relaxed/simple;
	bh=dm6/XNPGaBztgguI3cbV0ssIk6qVhgDGAgblfWgHfD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qBk6psWE31Z8rK8K7+WWtTUaIaZ/yyazR3e8y8tiE8CLZ9+Rxz9jvl0iaw7JfFAE+l7fCys4HVlMFNeJ1TQL3qDltMU7nNKbdLs+I8BCML5SEnCQMY9hA6bU0kc4IkjijTEDYZFiX8XHNbekZOkPXHll2bKp1vjC48DPfu/+2H0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=gcC4aI6M; arc=none smtp.client-ip=72.21.196.25
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747241659; x=1778777659;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i2F1lHeGUuAPZelDTlQ5nGhANIq9zWLJNAwCBqF9XOg=;
  b=gcC4aI6Mxq3Ve8+da4y0uy+/1WUlrsigDXXyRKbnC4JjaFejV8VdFRtp
   uTLWgX9ZoLCOJtkZ2XP33XXRTEpNRhYujwS6yaL+bwelBdzNMusoiFO/m
   NeMVdy8XyS/kxz1byREBCxDNqu6kc05P/g5J+uIfluCb8X5jW9pp0lxop
   Tp+cVH7fOTCvGpvvgU6T4296jyf8VH7RSYTIV4uC8sozqmgE1e2n/22Pc
   724K8oT1z93r8ORAeA1ip9D9AENPy5ytZ+LaNNyVV23+NesfdzNC5amMW
   3G/6F67UTCVFZcL4XKI9TvqTNqvThB9IEThsEVmy/IN2ZVCjKI96d7loF
   A==;
X-IronPort-AV: E=Sophos;i="6.15,288,1739836800"; 
   d="scan'208";a="492264972"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-2101.iad2.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 May 2025 16:54:17 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:13389]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.31.11:2525] with esmtp (Farcaster)
 id 92ae176a-228c-497e-9c56-fbebecb65f1b; Wed, 14 May 2025 16:54:15 +0000 (UTC)
X-Farcaster-Flow-ID: 92ae176a-228c-497e-9c56-fbebecb65f1b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:54:15 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.38) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Wed, 14 May 2025 16:54:12 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
Date: Wed, 14 May 2025 09:51:47 -0700
Message-ID: <20250514165226.40410-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250514165226.40410-1-kuniyu@amazon.com>
References: <20250514165226.40410-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D032UWB004.ant.amazon.com (10.13.139.136) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk->sk_txrehash is only used for TCP.

Let's restrict SO_TXREHASH to TCP to reflect this.

Later, we will make sk_txrehash a part of the union for other
protocol families.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
v3: Return -EOPNOTSUPP for getsockopt() too
---
 net/core/sock.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/net/core/sock.c b/net/core/sock.c
index 347ce75482f5..d7d6d3a8efe5 100644
--- a/net/core/sock.c
+++ b/net/core/sock.c
@@ -1276,6 +1276,8 @@ int sk_setsockopt(struct sock *sk, int level, int optname,
 		return 0;
 		}
 	case SO_TXREHASH:
+		if (!sk_is_tcp(sk))
+			return -EOPNOTSUPP;
 		if (val < -1 || val > 1)
 			return -EINVAL;
 		if ((u8)val == SOCK_TXREHASH_DEFAULT)
@@ -2102,6 +2104,9 @@ int sk_getsockopt(struct sock *sk, int level, int optname,
 		break;
 
 	case SO_TXREHASH:
+		if (!sk_is_tcp(sk))
+			return -EOPNOTSUPP;
+
 		/* Paired with WRITE_ONCE() in sk_setsockopt() */
 		v.val = READ_ONCE(sk->sk_txrehash);
 		break;
-- 
2.49.0


