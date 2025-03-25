Return-Path: <netdev+bounces-177585-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BC9B7A70ADA
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 20:58:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4203B16D86C
	for <lists+netdev@lfdr.de>; Tue, 25 Mar 2025 19:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50F61F1913;
	Tue, 25 Mar 2025 19:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="EgQmpPdB"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09BDB19F42C
	for <netdev@vger.kernel.org>; Tue, 25 Mar 2025 19:58:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742932729; cv=none; b=fJWZza9nMgSvD7r+sWaP0c6ru1vuW8FyZo8ElgEB+Kvimp8bGhQTaqfsPkd8ZtXO6Kb/+JUUYDrC8XQqIz4hqhA3is/ic9/X7t190MAFCRlCWEMayO9AqaWj7tcBu0MMKU/CgMe0xBAjYr4y8QWdVAK38fyZQ+ibXAGaJhjfWd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742932729; c=relaxed/simple;
	bh=W8p7OwgXAZp3YkCmGND4xFL/B0wyDusKCNrchEASDrw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RRBcqrWD38Qh6Gvw8sK7zwwRVgQK5B4IaihUdsx50YKUHzDOkzZtHGlzhExYqRRSu9QGJZZM2zC6pWDRlkt8lLWRUDYOKOMg/tr5VWYCl2y4zgIpSnBKNtmgl8AIxgE/3O43f31OxrMNNBOpTfZRuhrRrvUlvTGCXE2RKbkbouo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=EgQmpPdB; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742932725; x=1774468725;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=D5W2ZvFVCJ2olIjgczhwBZtBLeRSu58K3lfmo9cxIfs=;
  b=EgQmpPdBVxiKCx7QU7Qp/6WHCgN3mWVGGGEnsK6Sy1pLLtM8aIUzCOQG
   KvuEVkLTpN5CZySfIdHBCpu/Z+7Y4DK+LSgDeSQjjfkg1MpN2wSBJiv0T
   21aDTvM3jYvL3RPvv7FwLeY/0FPAZnSwHgsicC/SwG7vTz/yFGcPXCGWp
   w=;
X-IronPort-AV: E=Sophos;i="6.14,275,1736812800"; 
   d="scan'208";a="282529788"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2025 19:58:41 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:9748]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.27.18:2525] with esmtp (Farcaster)
 id 6693b8d4-5270-4be4-8b95-46775d5f688b; Tue, 25 Mar 2025 19:58:40 +0000 (UTC)
X-Farcaster-Flow-ID: 6693b8d4-5270-4be4-8b95-46775d5f688b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:58:39 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.12) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 25 Mar 2025 19:58:36 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Tue, 25 Mar 2025 12:58:12 -0700
Message-ID: <20250325195826.52385-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D035UWA004.ant.amazon.com (10.13.139.109) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

I got a report that UDP mem usage in /proc/net/sockstat did not
drop even after an application was terminated.

The issue could happen if sk->sk_rmem_alloc wraps around due
to a large sk->sk_rcvbuf, which was INT_MAX in our case.

The patch 2 fixes the issue, and the patch 1 fixes yet another
overflow I found while investigating the issue.


v2:
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

 net/ipv4/udp.c                          |  40 +++---
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 181 ++++++++++++++++++++++++
 4 files changed, 206 insertions(+), 18 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_rcvbuf.c

-- 
2.48.1


