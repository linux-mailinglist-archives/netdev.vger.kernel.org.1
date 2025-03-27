Return-Path: <netdev+bounces-178007-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B541A73F51
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 21:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 547A53BD6D7
	for <lists+netdev@lfdr.de>; Thu, 27 Mar 2025 20:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A6221D63CF;
	Thu, 27 Mar 2025 20:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="tq66W4tZ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2F191D54E9
	for <netdev@vger.kernel.org>; Thu, 27 Mar 2025 20:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743107257; cv=none; b=jvrvP43WWBqenxuvbVZCUJgMlkFJ5o08hMjeaihdSlwXwPcRpGcGrEiPVwSOGA7EU5yVizdy1tnw1/WUTrJBBEfylb4Yo6osTl5dxLWh3UCXoD+r/O2xwf5ZOcEhV49OyEH1uRWNYaXldLY1Kjwl6asg+EhjYFKQtEybQFrTsCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743107257; c=relaxed/simple;
	bh=gyF8Ng7BxVXWG+i1PE7qfu/suwtB4FOKF3WOZAuCoqY=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=RPATZUHP/vycZMw4+J42Oed+jxMpQhBgCR7nY95S53iNARuBYswXG1RtZaQK3SFvUYrIX0h70uCzMKmyW6MNgT+unO6BFp+hrXdEKy5L6qu+/E2cnhbz4dL97EeZn9K+Cn2adJW9mSXoBpzekyY9mAEMYHb3EL0TgEQyT7/lj7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=tq66W4tZ; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743107256; x=1774643256;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=V4LbF0zqRmwEjcLiqLVkkbWnORZaDXHIN/dSIB/PdSk=;
  b=tq66W4tZSxD8Zmmd/ngNdFp7OiRrJM98SYOZC5zTctZMDF3ruZOq6s69
   kzY4xz6DzWhfrtEKS/I1RB8Hxr1+H5pybFYEPqehRU0n3P0kOGwb4MCQg
   VdUP4JeeZnCOsYcVlCr26whOEOqY8C8HLXPOtiHPxJhPmkHCo/omKfHFS
   k=;
X-IronPort-AV: E=Sophos;i="6.14,281,1736812800"; 
   d="scan'208";a="35813891"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Mar 2025 20:27:35 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:24055]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.51:2525] with esmtp (Farcaster)
 id 16b54b7c-f99f-4d56-866d-f2e6e4a85372; Thu, 27 Mar 2025 20:27:34 +0000 (UTC)
X-Farcaster-Flow-ID: 16b54b7c-f99f-4d56-866d-f2e6e4a85372
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 20:27:34 +0000
Received: from 6c7e67bfbae3.amazon.com (10.187.171.29) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Thu, 27 Mar 2025 20:27:31 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v3 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Thu, 27 Mar 2025 13:26:52 -0700
Message-ID: <20250327202722.63756-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
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

I got a report that UDP mem usage in /proc/net/sockstat did not
drop even after an application was terminated.

The issue could happen if sk->sk_rmem_alloc wraps around due
to a large sk->sk_rcvbuf, which was INT_MAX in our case.

The patch 2 fixes the issue, and the patch 1 fixes yet another
overflow I found while investigating the issue.


v3:
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

 net/ipv4/udp.c                          |  40 +++---
 tools/testing/selftests/net/.gitignore  |   3 +-
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 181 ++++++++++++++++++++++++
 4 files changed, 207 insertions(+), 19 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_rcvbuf.c

-- 
2.48.1


