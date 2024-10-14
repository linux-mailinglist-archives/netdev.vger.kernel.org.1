Return-Path: <netdev+bounces-135374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D3999DA57
	for <lists+netdev@lfdr.de>; Tue, 15 Oct 2024 01:53:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B456281E1C
	for <lists+netdev@lfdr.de>; Mon, 14 Oct 2024 23:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B177D1A4E9D;
	Mon, 14 Oct 2024 23:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qtsbLgqz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB00D1E4A6
	for <netdev@vger.kernel.org>; Mon, 14 Oct 2024 23:52:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728949979; cv=none; b=S6kjvuAy2+efwlobALj0MxxXc3Zq+t+r1aNYrKYDkAd71XLOkBcJ5FNGH6o3ATQD0PNOkMXoLaj+Owdz1kCRXwzDUjVBVkIoqO85Ioum6QIb9xQ5ngCkES24kUb2LZ0UwAsAJfrkUKP7MuE7Xz+/NWu+2BFaR/FXN+USFPyg+O4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728949979; c=relaxed/simple;
	bh=wQZbWozopGyU060iMif4sIqcu4V3V2DOZtNXEx/ktu0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=bN04vMP3USx+WFxXUE9fFhPJ+ISJH48JAsvdjD5OS+d9VqTIXRtb7OYcSRax9jhQpIaxLkfRYBqL7soV8oeMKquYh54r2rBakgdlJrP3Dzt/dvZLbsZpc1jbzo+Q9ajdbqmIFSfriII5tKJyThO4+cqsIhY32G+8G1qaUik42XU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qtsbLgqz; arc=none smtp.client-ip=99.78.197.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728949978; x=1760485978;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Wz3y9Gk2WHoiisL+s/5eOq2a5dO4FZ0GltFXEV6EMzw=;
  b=qtsbLgqzIM9JlmPpkQRo3QY0ZfvVYTcZDiMCoMYl30JsVoB51VaggUCO
   RjgLT6bZL6JjR/gNkaYPD+yCQexI2axyxDcD6gG1K5D6nKH8/dcfo0vvP
   XL9xJ6HjO2fJf57XfjJh9JVRtNw8BMmOGbfvPc+/5uFnzddyj5vxoVAu6
   U=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="343063872"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 23:52:57 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.7.35:53939]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.24.95:2525] with esmtp (Farcaster)
 id 8ae9135c-28d9-446f-aa47-c46ee22ea071; Mon, 14 Oct 2024 23:52:56 +0000 (UTC)
X-Farcaster-Flow-ID: 8ae9135c-28d9-446f-aa47-c46ee22ea071
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 23:52:55 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 23:52:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next] neighbour: Remove NEIGH_DN_TABLE.
Date: Mon, 14 Oct 2024 16:52:16 -0700
Message-ID: <20241014235216.10785-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWA004.ant.amazon.com (10.13.139.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Since commit 1202cdd66531 ("Remove DECnet support from kernel"),
NEIGH_DN_TABLE is no longer used.

MPLS has implicit dependency on it in nla_put_via(), but nla_get_via()
does not support DECnet.

Let's remove NEIGH_DN_TABLE.

Now, neigh_tables[] has only 2 elements and no extra iteration
for DECnet in many places.

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/neighbour.h | 1 -
 net/mpls/af_mpls.c      | 2 +-
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/include/net/neighbour.h b/include/net/neighbour.h
index a44f262a7384..3887ed9e5026 100644
--- a/include/net/neighbour.h
+++ b/include/net/neighbour.h
@@ -239,7 +239,6 @@ struct neigh_table {
 enum {
 	NEIGH_ARP_TABLE = 0,
 	NEIGH_ND_TABLE = 1,
-	NEIGH_DN_TABLE = 2,
 	NEIGH_NR_TABLES,
 	NEIGH_LINK_TABLE = NEIGH_NR_TABLES /* Pseudo table for neigh_xmit */
 };
diff --git a/net/mpls/af_mpls.c b/net/mpls/af_mpls.c
index df62638b6498..a0573847bc55 100644
--- a/net/mpls/af_mpls.c
+++ b/net/mpls/af_mpls.c
@@ -1664,7 +1664,7 @@ static int nla_put_via(struct sk_buff *skb,
 		       u8 table, const void *addr, int alen)
 {
 	static const int table_to_family[NEIGH_NR_TABLES + 1] = {
-		AF_INET, AF_INET6, AF_DECnet, AF_PACKET,
+		AF_INET, AF_INET6, AF_PACKET,
 	};
 	struct nlattr *nla;
 	struct rtvia *via;
-- 
2.39.5 (Apple Git-154)


