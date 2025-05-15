Return-Path: <netdev+bounces-190871-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C60AB9267
	for <lists+netdev@lfdr.de>; Fri, 16 May 2025 00:51:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BAAC87B4B6C
	for <lists+netdev@lfdr.de>; Thu, 15 May 2025 22:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF4128C2C2;
	Thu, 15 May 2025 22:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b="I0Ln2l1C"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAAAC28B4FE
	for <netdev@vger.kernel.org>; Thu, 15 May 2025 22:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747349498; cv=none; b=D3AINN06Z8bE5lYANasNxx1KzmgBgzEklXwEZIWVqPk5z26TsgiJ+XnR/LKJVcynhcSO0zAGFMVd9ZOIIgnfT7v1wtGGOm7X4cd9A+XN9U0ZR7hBOsmhjmrBe5zH2QwjEZzkq+1ipNCAWwLCohu8Fiq6e1aP8reQ7DXAIaB50EU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747349498; c=relaxed/simple;
	bh=P5oAQlSK3i8m08Uguo2ISLyhvkisiBa1uWCvyVLYZ3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p+Y5upxufBQDXKjU+Z93fzKorjwxb8cMLc7eH+g0CPxAOTYP20xYu8r5W0YYhK/t2xj1YJmS4llNgllxZy/6NiakH502m2LjG6o1iwNb0glkUUy25ikBtUdR2z12CMG+Z1jaPqwBwNKIulnlrRy+Yhs1jWISp6z1dtQoNf9PH+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (2048-bit key) header.d=amazon.com header.i=@amazon.com header.b=I0Ln2l1C; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazoncorp2;
  t=1747349496; x=1778885496;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=MU489E+7TIP24CwvVN41FJM/5bgHQL56ksWvuWkrclM=;
  b=I0Ln2l1CwzO+pqu8WqWZPST9QjDsR5YvvWjBOss2Fi/CzlfJHDykG/ng
   Z8SnOk/NFOnUrw2iPSJrsvKXZI2giwIheLGlIFJz6Zc7Ht9t8qGJps0Yt
   HaD1OrMoUKE0dPtbFCphNObFFpJ9kMZ9KKx060M/ds5aVaXJithv5pjY3
   /Nvr0NmS+wX2tqX89OGf2mQK0cL4mI6/4oicQeHYka2cduOJ+aiaaLZI8
   QxgsWVfl8IifPmyC5WVNFnjcY3NESZrNtDM0RRlUKSJlMsA3ZhDhF0X0S
   vLMpGTxTv8ziAufRJjnBd3J1Kf/7IcWC45IoFuTXEpyrPd43ARmpjJJsO
   Q==;
X-IronPort-AV: E=Sophos;i="6.15,292,1739836800"; 
   d="scan'208";a="201027634"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 May 2025 22:51:35 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:7067]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.29.53:2525] with esmtp (Farcaster)
 id 2c943f5d-e0f0-4b27-ab20-1a319f2a370a; Thu, 15 May 2025 22:51:34 +0000 (UTC)
X-Farcaster-Flow-ID: 2c943f5d-e0f0-4b27-ab20-1a319f2a370a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.217) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:51:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.170.35) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 15 May 2025 22:51:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, Willem de Bruijn <willemb@google.com>
CC: Simon Horman <horms@kernel.org>, Christian Brauner <brauner@kernel.org>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net-next 4/9] tcp: Restrict SO_TXREHASH to TCP socket.
Date: Thu, 15 May 2025 15:49:12 -0700
Message-ID: <20250515224946.6931-5-kuniyu@amazon.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250515224946.6931-1-kuniyu@amazon.com>
References: <20250515224946.6931-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D037UWC001.ant.amazon.com (10.13.139.197) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

sk->sk_txrehash is only used for TCP.

Let's restrict SO_TXREHASH to TCP to reflect this.

Later, we will make sk_txrehash a part of the union for other
protocol families.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
Reviewed-by: Willem de Bruijn <willemb@google.com>
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


