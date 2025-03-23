Return-Path: <netdev+bounces-176983-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D9FC8A6D273
	for <lists+netdev@lfdr.de>; Mon, 24 Mar 2025 00:10:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F75F16E6F9
	for <lists+netdev@lfdr.de>; Sun, 23 Mar 2025 23:10:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0598D1A5B8F;
	Sun, 23 Mar 2025 23:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="X2Y93oyt"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CCC01A23A4
	for <netdev@vger.kernel.org>; Sun, 23 Mar 2025 23:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742771434; cv=none; b=NoNFfJLnhfMYCK61hjncf886QonX3Vco6JlJD9Xk7I16tzseo8mdN+PSsM0WdKNQmUa9LPi+LcHr6YTvqSdqd5NTfezkGZtv/Kxv4TTmr6GqoF/pCStKNkIcxDj7PLF/PgpVwzPK4sQZzNXumVZ1FAv00s2vlnIiQOVHyWdWGoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742771434; c=relaxed/simple;
	bh=+yVLqU3m0R7AyLPWp/Dq4rdUNungxwJPVRJlY5SQb7s=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hio1Bdf5ousg8ARXAf7OZdYX2s7ZY0avb4CsASiaDLHqZmIF5CZN0iQqjlPW1zUBDJY7mVeL5jyGYZTXLymH3v3SEBMSyp+Vi+XeF+2si/37KwBzNnt3DDz1dmAe+SMmXGOWdxxZJNmYwE4dNhqgv5y1byyWJ0nbjWMUH4i/0C0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=X2Y93oyt; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1742771433; x=1774307433;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XDjfnW3w9IZhZg7j57Vj0tZy4gm+dBhOWr+ZWGY46hU=;
  b=X2Y93oyt6mQ43iJmKugIn6gnfZz0Yq45yC6cmV4kpyH3ETlmuidRJgE4
   +s9//KJCg96LmZPBnS95esmWNJUPpan6bgROneiTKsQAf21XGRi8IVGKC
   E9CxYcWpnwofZblhcQHCLkcpPcGyzIL5lCq1zjJYOD2M3SDBT/5ibyRCn
   E=;
X-IronPort-AV: E=Sophos;i="6.14,271,1736812800"; 
   d="scan'208";a="34434635"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2025 23:10:32 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:38820]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.43.118:2525] with esmtp (Farcaster)
 id dbf8a6ff-0a28-4a3b-9933-c6ebb7030b18; Sun, 23 Mar 2025 23:10:31 +0000 (UTC)
X-Farcaster-Flow-ID: dbf8a6ff-0a28-4a3b-9933-c6ebb7030b18
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 23 Mar 2025 23:10:31 +0000
Received: from 6c7e67bfbae3.amazon.com (10.106.100.57) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1544.14;
 Sun, 23 Mar 2025 23:10:27 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>, "David S. Miller"
	<davem@davemloft.net>, David Ahern <dsahern@kernel.org>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Simon Horman <horms@kernel.org>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/3] udp: Fix two integer overflows when sk->sk_rcvbuf is close to INT_MAX.
Date: Sun, 23 Mar 2025 16:09:49 -0700
Message-ID: <20250323231016.74813-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWC004.ant.amazon.com (10.13.139.229) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

I got a report that UDP mem usage in /proc/net/sockstat did not
drop even after an application was terminated.

The issue could happen if sk->sk_rmem_alloc wraps around due
to a large sk->sk_rcvbuf, which was INT_MAX in our case.

The patch 2 fixes the issue, and the patch 1 fixes yet another
overflow I found while investigating the issue.


Kuniyuki Iwashima (3):
  udp: Fix multiple wraparounds of sk->sk_rmem_alloc.
  udp: Fix memory accounting leak.
  selftest: net: Check wraparounds for sk->sk_rmem_alloc.

 net/ipv4/udp.c                          |  18 ++-
 tools/testing/selftests/net/.gitignore  |   1 +
 tools/testing/selftests/net/Makefile    |   2 +-
 tools/testing/selftests/net/so_rcvbuf.c | 178 ++++++++++++++++++++++++
 4 files changed, 188 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/net/so_rcvbuf.c

-- 
2.48.1


