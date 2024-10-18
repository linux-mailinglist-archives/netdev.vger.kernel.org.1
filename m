Return-Path: <netdev+bounces-136798-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 380579A3227
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 03:41:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A0D8CB23161
	for <lists+netdev@lfdr.de>; Fri, 18 Oct 2024 01:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC586558BC;
	Fri, 18 Oct 2024 01:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="VpNqYCug"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FBC84E18
	for <netdev@vger.kernel.org>; Fri, 18 Oct 2024 01:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729215668; cv=none; b=DXy9S2DBC0Pzk1L6SpQ2xtRqAMmgHIXiXWmxsE02BAvzJps/4vwtuEerHm8jb0QOWEEoF2WOu4xR7B6ITyL/TLlEhWQOvJXzzugYcGlZ9xJvhewE5lgSiBS5xpQKxZ08jeGIJDLFA4r/fvI3sYIQaNb3lzmUawn7R04jTPT5cvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729215668; c=relaxed/simple;
	bh=jaNNZeavt8JCl60GG4LR7H8xG4rN20/3GkopeLF/Tik=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=tnEgaj/tVBq4yqBBG0Ii2s2G58lR6CM59pAeOQKEA6gKo2ny3DtZrNxOOtw/uS3UYuU7h3dNNxchFijq/BkN0KR6dnyyGl72VAH+/F/kQK9z+fYTTUkCMW+Fl7OWayfgFza3wo/VtuDxOsbFCBJf9GPgv1ZyJhdbcSjen7O8gJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=VpNqYCug; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1729215667; x=1760751667;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kskRLfcMNlqeD+PLGq1Yfn4XnhLy5srWIF5lp+UiLuo=;
  b=VpNqYCugRluxZMUJINl94IAan3Ctztk3p2xsUv+aFXI/JghhpXfvX9Zv
   yuENJMn7SjvCgxNVurLkkQe+tgmEE/1Lhys63D5bUzvyZcgYOPhcuWr7A
   xnQfhvjYv2ct43LcyOtim1/cIrg/DoFEj5ZwmVk2jXECO5B/nMnJ6/qwG
   o=;
X-IronPort-AV: E=Sophos;i="6.11,212,1725321600"; 
   d="scan'208";a="344040027"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2024 01:41:07 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.38.20:32591]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 5a13b5b9-c318-4d94-aa0a-aa44c706a885; Fri, 18 Oct 2024 01:41:06 +0000 (UTC)
X-Farcaster-Flow-ID: 5a13b5b9-c318-4d94-aa0a-aa44c706a885
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 18 Oct 2024 01:41:06 +0000
Received: from 6c7e67c6786f.amazon.com (10.187.171.30) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Fri, 18 Oct 2024 01:41:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] ipv4: Switch inet_addr_hash() to less predictable hash.
Date: Thu, 17 Oct 2024 18:41:00 -0700
Message-ID: <20241018014100.93776-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA003.ant.amazon.com (10.13.139.86) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Recently, commit 4a0ec2aa0704 ("ipv6: switch inet6_addr_hash()
to less predictable hash") and commit 4daf4dc275f1 ("ipv6: switch
inet6_acaddr_hash() to less predictable hash") hardened IPv6
address hash functions.

inet_addr_hash() is also highly predictable, and a malicious use
could abuse a specific bucket.

Let's follow the change on IPv4 by using jhash_1word().

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/ip.h   | 5 +++++
 net/ipv4/devinet.c | 2 +-
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/net/ip.h b/include/net/ip.h
index 4be0a6a603b2..0e548c1f2a0e 100644
--- a/include/net/ip.h
+++ b/include/net/ip.h
@@ -690,6 +690,11 @@ static inline unsigned int ipv4_addr_hash(__be32 ip)
 	return (__force unsigned int) ip;
 }
 
+static inline u32 __ipv4_addr_hash(const __be32 ip, const u32 initval)
+{
+	return jhash_1word((__force u32)ip, initval);
+}
+
 static inline u32 ipv4_portaddr_hash(const struct net *net,
 				     __be32 saddr,
 				     unsigned int port)
diff --git a/net/ipv4/devinet.c b/net/ipv4/devinet.c
index d81fff93d208..3e5e3b5e78c4 100644
--- a/net/ipv4/devinet.c
+++ b/net/ipv4/devinet.c
@@ -121,7 +121,7 @@ struct inet_fill_args {
 
 static u32 inet_addr_hash(const struct net *net, __be32 addr)
 {
-	u32 val = (__force u32) addr ^ net_hash_mix(net);
+	u32 val = __ipv4_addr_hash(addr, net_hash_mix(net));
 
 	return hash_32(val, IN4_ADDR_HSIZE_SHIFT);
 }
-- 
2.39.5 (Apple Git-154)


