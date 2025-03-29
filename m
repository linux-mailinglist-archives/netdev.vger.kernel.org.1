Return-Path: <netdev+bounces-178190-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 93250A7575E
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 28B383AD21E
	for <lists+netdev@lfdr.de>; Sat, 29 Mar 2025 18:05:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2A714D70E;
	Sat, 29 Mar 2025 18:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="a+g7Hoqo"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04211BF58
	for <netdev@vger.kernel.org>; Sat, 29 Mar 2025 18:05:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743271558; cv=none; b=b4ghfAdk0fXRpsI+D8BHSLwGmud8Le0ghdCmYAnQRi4WKlC6ypX1oChawIPggMgkJcbChYtK+C4Cjm1J8CKEZa/+0HzWmP+j3all2lXcwNYL/3e2ZndPYMSlm2pGsegfdT8apzKbpWgfMcAOdvWAkdIaUCxfBsw9Ngvi0lh02UQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743271558; c=relaxed/simple;
	bh=lgRgmUa5U8cPcgDG1KroH650+YRxvTCJ4y9oW+TsfLY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rWJ3YDZW+RSFrBvaF7o3s9Zwccy9o2dXHHaaE9dk3WNWR2oRMkPrIilpcaySXrJz5L2dwL3ekTafVB1KFswwC0O5KgiVd+Sv3hy0VWsyXTqM2TiBLOIhRp44ThCU8ESOOkDG/bFf5/648hoswqHJ09iZtuG0/gSPs4V0SIzzmbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=a+g7Hoqo; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743271556; x=1774807556;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=vVi2tyrzNIRfFA1Z/zCWGci3tgun8MrV2NsPa6W8Iyc=;
  b=a+g7Hoqo8MUTuItWAS5ai2RfO0FuedUmgno6kr4xf2pvPa0WYnsyFWTn
   TH5WSP8/NFLaFJXUB6gSM2Xkd8M9PibDILzNo0ed23gMv9mbLjCoar66b
   IYtCkF6eCAivOHVsx5YOJcuGBC5Ef8biKHqd19x1sVbnrSJNGjY7oFwVE
   s=;
X-IronPort-AV: E=Sophos;i="6.14,286,1736812800"; 
   d="scan'208";a="36285020"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Mar 2025 18:05:55 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:11468]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.22.232:2525] with esmtp (Farcaster)
 id 1ea2619e-345a-466d-ad79-9c3d0fdef437; Sat, 29 Mar 2025 18:05:54 +0000 (UTC)
X-Farcaster-Flow-ID: 1ea2619e-345a-466d-ad79-9c3d0fdef437
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 29 Mar 2025 18:05:54 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sat, 29 Mar 2025 18:05:51 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v4 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Sat, 29 Mar 2025 11:05:10 -0700
Message-ID: <20250329180541.34968-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D040UWB004.ant.amazon.com (10.13.138.91) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

I got a report that UDP mem usage in /proc/net/sockstat did not
drop even after an application was terminated.

The issue could happen if sk->sk_rmem_alloc wraps around due
to a large sk->sk_rcvbuf, which was INT_MAX in our case.

The patch 2 fixes the issue, and the patch 1 fixes yet another
overflow I found while investigating the issue.


v4:
  * Patch 4
    * Wait RCU for at most 30 sec

v3: https://lore.kernel.org/netdev/20250327202722.63756-1-kuniyu@amazon.com/
  * Rebase
  * Add Willem's tags

v2: https://lore.kernel.org/netdev/20250325195826.52385-1-kuniyu@amazon.com/
  * Patch 1
    * Define rmem and rcvbuf as unsigned int (Eric)
    * Take skb->truesize into account for sk with large rcvbuf (Willem)

  * Patch 3
    * Add a comment

v1: https://lore.kernel.org/netdev/20250323231016.74813-1-kuniyu@amazon.com/


Kuniyuki Iwashima (3):
  udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
  udp: Fix memory accounting leak.
  selftest: net: Check wraparounds for sk->sk_rmem_alloc.

 net/ipv4/udp.c                          |  40 ++---
 tools/testing/selftests/net/.gitignore  |   3 +-
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 188 ++++++++++++++++++++++++
 4 files changed, 214 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_rcvbuf.c

-- 
2.48.1


