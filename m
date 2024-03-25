Return-Path: <netdev+bounces-81719-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5582B88AE8C
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:38:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 876991C39825
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:38:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 784625D731;
	Mon, 25 Mar 2024 18:20:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="mZIksQsG"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D811C54279
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390823; cv=none; b=A8Fzsr2F2DHFJfdwus4x75MqviWt/AA6UJ+52pyJ/6vTcA53+DAu5r029yLkLpizHOpjwEEakTBy9PB6+ofNL4nTpFKoMGncHHL4jdO/shW5gLTASBFiXjl2szez1RtbuzxjaZD8GTS5GhTOBeKBoMNjQZcdp95PrhiViThVyqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390823; c=relaxed/simple;
	bh=tnqKUn5qFHLNJ7y/BfcfjT3M/zmAWC6SZMnr4P4ivps=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qpftsN0sr4Fzkz7G/G7P6ZqyXG9o3uGpVkYhdGyhguNj6RO2BYhKkhjaCPGc9k2TIb0l3dmgQPIjjzE/oYJ2+JjYaDmhwebLMzKtwefaRmiIrZxiezR49ylsOGZ/m2gkwoFi8kUQDMBUfdkC/dD5r4ce2ccFbKaOo/KtppAB79E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=mZIksQsG; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390822; x=1742926822;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=+ovGYrlxBR+OEZs2Ok2SOGjoWdKn0yi+MjmL930xUns=;
  b=mZIksQsGFcA+OPUxc1sa+/EOuKtDMhPsDjVp/8CWhOqWUpHmPhadfwwp
   shCiYj01F1B1vs3zsD5rGw2wUea2IwbmnbmrQ3YO5clsqQcdGBnwx9oNc
   T0VHyArb6N3gB2/y0QxyZILeg+HM8XaN/dp8Fx7MK4cmHVVir+cRl/nyv
   I=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="406603422"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:20:15 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.7.35:63408]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.34.125:2525] with esmtp (Farcaster)
 id 9c29ceeb-1d86-4020-9d68-4a4194a9d517; Mon, 25 Mar 2024 18:20:14 +0000 (UTC)
X-Farcaster-Flow-ID: 9c29ceeb-1d86-4020-9d68-4a4194a9d517
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:20:13 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:20:11 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 1/8] tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6 non-wildcard addresses.
Date: Mon, 25 Mar 2024 11:19:16 -0700
Message-ID: <20240325181923.48769-2-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240325181923.48769-1-kuniyu@amazon.com>
References: <20240325181923.48769-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 5e07e672412b ("tcp: Use bhash2 for v4-mapped-v6 non-wildcard
address.") introduced bind() regression for v4-mapped-v6 address.

When we bind() the following two addresses on the same port, the 2nd
bind() should succeed but fails now.

  1. [::] w/ IPV6_ONLY
  2. ::ffff:127.0.0.1

After the chagne, v4-mapped-v6 uses bhash2 instead of bhash to
detect conflict faster, but I forgot to add a necessary change.

During the 2nd bind(), inet_bind2_bucket_match_addr_any() returns
the tb2 bucket of [::], and inet_bhash2_conflict() finally calls
inet_bind_conflict(), which returns true, meaning conflict.

  inet_bhash2_addr_any_conflict
  |- inet_bind2_bucket_match_addr_any  <-- return [::] bucket
  `- inet_bhash2_conflict
     `- __inet_bhash2_conflict <-- checks IPV6_ONLY for AF_INET
        |                          but not for v4-mapped-v6 address
        `- inet_bind_conflict  <-- does not check address

inet_bind_conflict() does not check socket addresses because
__inet_bhash2_conflict() is expected to do so.

However, it checks IPV6_V6ONLY attribute only against AF_INET
socket, and not for v4-mapped-v6 address.

As a result, v4-mapped-v6 address conflicts with v6-only wildcard
address.

To avoid that, let's add the missing test to use bhash2 for
v4-mapped-v6 address.

Fixes: 5e07e672412b ("tcp: Use bhash2 for v4-mapped-v6 non-wildcard address.")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/ipv4/inet_connection_sock.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ipv4/inet_connection_sock.c b/net/ipv4/inet_connection_sock.c
index 7d8090f109ef..612aa1d2eff7 100644
--- a/net/ipv4/inet_connection_sock.c
+++ b/net/ipv4/inet_connection_sock.c
@@ -203,7 +203,8 @@ static bool __inet_bhash2_conflict(const struct sock *sk, struct sock *sk2,
 				   kuid_t sk_uid, bool relax,
 				   bool reuseport_cb_ok, bool reuseport_ok)
 {
-	if (sk->sk_family == AF_INET && ipv6_only_sock(sk2))
+	if (ipv6_only_sock(sk2) &&
+	    (sk->sk_family == AF_INET || ipv6_addr_v4mapped(&sk->sk_v6_rcv_saddr)))
 		return false;
 
 	return inet_bind_conflict(sk, sk2, sk_uid, relax,
-- 
2.30.2


