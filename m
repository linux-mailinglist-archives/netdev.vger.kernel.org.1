Return-Path: <netdev+bounces-117321-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E973E94D94E
	for <lists+netdev@lfdr.de>; Sat, 10 Aug 2024 01:54:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A1A6F2815F0
	for <lists+netdev@lfdr.de>; Fri,  9 Aug 2024 23:54:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF75016C872;
	Fri,  9 Aug 2024 23:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="O991TokH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5EA1684BB
	for <netdev@vger.kernel.org>; Fri,  9 Aug 2024 23:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723247665; cv=none; b=Cui647z+sVD75vgG+z3lQ07WMDA8Iv43vxySyjQiub6xqB9Li2HeZtWpCszmIx+vt4uhkPww90mfUni5qtCd+qoKZAMvMTbmYdsyDiApDSsyJwXEAQc5efXJQSLyKKtqxkv8Qvbt7ymkI/C6sDgogh4tP/B0INR921yOGbrele4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723247665; c=relaxed/simple;
	bh=+OtvW9lF7JP2Hxlfg1iQObw0eCNuFm0KYYGl8xG5m5o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VX35GLfsxuSg4Ovy00FWrr5bTLT5ctUp5QIAYwAx/UzcYkPnN0IGLfdMmvPB+xLNdBlXR0sAzjMz/uN9UCQN1kX9eW/H9vLWCONrbP4KqClkA38iw6BDdtsU1YHp05BaKd6Rw4LXgTJ6HDrgHAvbXYAdISbNNmWcoINoOYAZw0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=O991TokH; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1723247664; x=1754783664;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=wHpO89d5mdsDG6n3tokFYT0/Itf9zVPIjc3GXpSb/fQ=;
  b=O991TokHlaM8pBmFuJIGXfVC9YSpAxEY0lzzzg4woQpI3kyGab8PGH7K
   ytmXE4U4dD4VLW2ZAZMz344r2KM5VnMqa4x2i+hGQFoniBUaxP/NhrpXN
   Xpe7mEqe/gndudKgLxYdkGmMIS1o56XBb6o0rdvh5jEgCOMAW53wt+mGd
   k=;
X-IronPort-AV: E=Sophos;i="6.09,277,1716249600"; 
   d="scan'208";a="426094026"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2024 23:54:21 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:47245]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.17.82:2525] with esmtp (Farcaster)
 id 0d9e5ad8-15d6-4a86-ba23-6cb45f62b42a; Fri, 9 Aug 2024 23:54:20 +0000 (UTC)
X-Farcaster-Flow-ID: 0d9e5ad8-15d6-4a86-ba23-6cb45f62b42a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:54:20 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.20) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Fri, 9 Aug 2024 23:54:17 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/5] ip: Random cleanup for devinet.c
Date: Fri, 9 Aug 2024 16:54:01 -0700
Message-ID: <20240809235406.50187-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB001.ant.amazon.com (10.13.139.148) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

patch 1 ~ 3 remove defensive !ifa->ifa_dev tests.
patch 4 & 5 deduplicate common code.


Kuniyuki Iwashima (5):
  ipv4: Check !in_dev earlier for ioctl(SIOCSIFADDR).
  ipv4: Set ifa->ifa_dev in inet_alloc_ifa().
  ipv4: Remove redundant !ifa->ifa_dev check.
  ipv4: Initialise ifa->hash in inet_alloc_ifa().
  ip: Move INFINITY_LIFE_TIME to addrconf.h.

 .../ethernet/qlogic/netxen/netxen_nic_main.c  |  5 +-
 .../net/ethernet/qlogic/qlcnic/qlcnic_main.c  |  2 +-
 include/net/addrconf.h                        |  4 +-
 net/ipv4/devinet.c                            | 47 +++++++++----------
 net/ipv6/addrconf.c                           |  2 -
 5 files changed, 27 insertions(+), 33 deletions(-)

-- 
2.30.2


