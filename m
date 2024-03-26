Return-Path: <netdev+bounces-82251-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A3AA088CF3D
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 21:43:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 31DE8B225C7
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 20:43:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75D881E522;
	Tue, 26 Mar 2024 20:43:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="rM62lRO/"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F81DEDF
	for <netdev@vger.kernel.org>; Tue, 26 Mar 2024 20:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711485792; cv=none; b=lshsWZ5LKImbxUrmb5VYQmOQElnURYgWzPMuSmfODYfc0j4Bv0pc2l9wHMGbMHgOEQQ0A5EU4GY74QmUBrValHF3cn7bN7a5W1syi2z2JDN2uk2oGz7oZV1ioFNFxMZFA90ioHQe6BzBniWrkgHT1y+FapBHQsy/8EIU6vPMyVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711485792; c=relaxed/simple;
	bh=cO5npRTjxSni+vG7jkUWLzxK0vrjACXN9jmPWrblvqk=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WEDhpr3B0+okNcca7wouN71g6xQpWpj6oYlv1ZRgldB4Mjl+pDrvXkw5m8+4BWFVVupYda+rjakX63BKHLPiviCDszpuK32oMyH5Lmu4G/H/hVp//lnuQ8GgPdoI4FOqVC5NgMnIT4k+fUQcYgaOIFmMMByE9Ah+v0d2IVE6lh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=rM62lRO/; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711485791; x=1743021791;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=RmNzMvdqiKlfqlgd14LaOyTopyE0JdRqcI16V6dkS7A=;
  b=rM62lRO/u+TKF4qWtNxciJzI+HtB2VdaZQaQzww9YDYt64jUlmcpdDjq
   XqzUz5TRDvkGnSaqgEjhhGS62OYihD2/WwLjwOFkYU060UfQEyvkmFbME
   ysfs9I2eQyFAxYMFGlmz1WMS0L3bqsSPdPLvXSn9hK5CjpL5B/v0+/BiN
   8=;
X-IronPort-AV: E=Sophos;i="6.07,157,1708387200"; 
   d="scan'208";a="396259562"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Mar 2024 20:43:07 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:64765]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.3.112:2525] with esmtp (Farcaster)
 id 31ea8ce7-7844-4f9a-b903-3981a5b9b4e9; Tue, 26 Mar 2024 20:43:06 +0000 (UTC)
X-Farcaster-Flow-ID: 31ea8ce7-7844-4f9a-b903-3981a5b9b4e9
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 26 Mar 2024 20:43:05 +0000
Received: from 88665a182662.ant.amazon.com (10.106.101.23) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.28;
 Tue, 26 Mar 2024 20:43:02 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v2 net 0/8] tcp: Fix bind() regression and more tests.
Date: Tue, 26 Mar 2024 13:42:43 -0700
Message-ID: <20240326204251.51301-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC003.ant.amazon.com (10.13.139.198) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

bhash2 has not been well tested for IPV6_V6ONLY option.

This series fixes two regression around IPV6_V6ONLY, one of which
has been there since bhash2 introduction, and another is introduced
by a recent change.

Also, this series adds as many tests as possible to catch regression
easily.  The baseline is 28044fc1d495~ which is pre-bhash2 commit.

 Tested on 28044fc1d495~:
  # PASSED: 132 / 132 tests passed.
  # Totals: pass:132 fail:0 xfail:0 xpass:0 skip:0 error:0

 net.git:
  # FAILED: 125 / 132 tests passed.
  # Totals: pass:125 fail:7 xfail:0 xpass:0 skip:0 error:0

 With this series:
  # PASSED: 132 / 132 tests passed.
  # Totals: pass:132 fail:0 xfail:0 xpass:0 skip:0 error:0


Changes:
  v2:
    * Patch 1: Fix build error when IPV6=n

  v1: https://lore.kernel.org/netdev/20240325181923.48769-1-kuniyu@amazon.com/


Kuniyuki Iwashima (8):
  tcp: Fix bind() regression for v6-only wildcard and v4-mapped-v6
    non-wildcard addresses.
  tcp: Fix bind() regression for v6-only wildcard and v4(-mapped-v6)
    non-wildcard addresses.
  selftest: tcp: Make bind() selftest flexible.
  selftest: tcp: Define the reverse order bind() tests explicitly.
  selftest: tcp: Add v4-v4 and v6-v6 bind() conflict tests.
  selftest: tcp: Add more bind() calls.
  selftest: tcp: Add bind() tests for IPV6_V6ONLY.
  selftest: tcp: Add bind() tests for SO_REUSEADDR/SO_REUSEPORT.

 net/ipv4/inet_connection_sock.c             |  30 +-
 tools/testing/selftests/net/bind_wildcard.c | 783 ++++++++++++++++++--
 2 files changed, 736 insertions(+), 77 deletions(-)

-- 
2.30.2


