Return-Path: <netdev+bounces-178670-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E6B9A78267
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 20:45:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7CE4F3A956D
	for <lists+netdev@lfdr.de>; Tue,  1 Apr 2025 18:45:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 43E7220D4F8;
	Tue,  1 Apr 2025 18:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gpf8ReWj"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AD91E51E7
	for <netdev@vger.kernel.org>; Tue,  1 Apr 2025 18:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743533117; cv=none; b=Y6ZMBGhwASOWhYdLRY4hTwAxvhjYYMPRLjFUy0rLZYLyrObR6kc3kA9B8gtB3Ur0a4FkhbfGTO+Iq9TDrtDgmnM+oHteNgxvj4MGQ0thxVCxQDtroemRCD+qH9bed4CwQyujO1ZLrxxjVsOei/keVIPtdTpl8J/OOxz3oefGoP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743533117; c=relaxed/simple;
	bh=xOVqZ+nJXeZOQuITWltxXb99G3fYzOrq7XQL7DhQvWs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QFC+JfKKQJJM6gLLatShEPlV6kXteiOBT3D0p4khRFV08NbYvSuf+f4FtwTUzcwRx6WPEXlBB+Kns/gbQKZjkqpd7D3dp1dx0J+VPTpim1DCM5+z/57oAs+MyodIO4N8stA2GnZlt0UzDDNNG/un8/mcGeHbtvzEZyKhPs3AfiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gpf8ReWj; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1743533116; x=1775069116;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BHT/9heyeFhnFyKOaD6CMpWhkB8QevCcvCss119shks=;
  b=gpf8ReWjLsROWd1rDumIHt60sU87mTIfHiElV81YCS5jI08iap7zfdYu
   AALsuQ6gjQyNvB6fvq/dvgMkISjENMb4XcjT7R0Un31sjddNnsvHb+EKI
   TKct6jlfF9JYsD2BZ+pPadNFj+T2t2iZ5yOMf930YrxGT0HFaYL2ZOGAP
   U=;
X-IronPort-AV: E=Sophos;i="6.14,294,1736812800"; 
   d="scan'208";a="37129379"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2025 18:45:14 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:52872]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.55.83:2525] with esmtp (Farcaster)
 id b2a5c2f0-ce2a-4982-bb3f-97081286fb3d; Tue, 1 Apr 2025 18:45:13 +0000 (UTC)
X-Farcaster-Flow-ID: b2a5c2f0-ce2a-4982-bb3f-97081286fb3d
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 18:45:12 +0000
Received: from 6c7e67bfbae3.amazon.com (10.94.43.60) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Tue, 1 Apr 2025 18:45:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v5 net 0/2] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Tue, 1 Apr 2025 11:44:41 -0700
Message-ID: <20250401184501.67377-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
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

I got a report that UDP mem usage in /proc/net/sockstat did not
drop even after an application was terminated.

The issue could happen if sk->sk_rmem_alloc wraps around due
to a large sk->sk_rcvbuf, which was INT_MAX in our case.

The patch 2 fixes the issue, and the patch 1 fixes yet another
overflow I found while investigating the issue.


v5:
  * Drop flaky test
  * Patch 1
    * Update size after skb_condense()

v4:
  * Patch 3
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


Kuniyuki Iwashima (2):
  udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
  udp: Fix memory accounting leak.

 net/ipv4/udp.c | 42 ++++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 18 deletions(-)

-- 
2.48.1


