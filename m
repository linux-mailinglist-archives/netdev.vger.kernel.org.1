Return-Path: <netdev+bounces-81718-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 507B288AE83
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 19:37:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E11BB1F62D55
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 18:37:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5EAD4AEEF;
	Mon, 25 Mar 2024 18:20:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="kehs/q75"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 161F6804
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711390802; cv=none; b=GsCm7F5LeLZnTPu7IR6kJwKrrHB8oNMfJQaUFCtub56DF7s5EiDtFlOZ9QLbceuW4/T4tVRYwOVMt8VVhrw2kjKQIeXUoCaVUkIyb2A2QziFvu8wsLardRhFo32wxIa8kT1bCW4PiCL620k6T/UBA/7KBiHT9cV276j6oJNSSlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711390802; c=relaxed/simple;
	bh=PFC9ZLK4FnT1EMmd6G3nx+4CemO7fR9rHNubgE+aLz8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=sQQQO7pO4B1LjG6/J9jHE6HflhtqrCu7gnrsyqfiWOumB59LWmisjPTBzFEA/u1UihUfZsNFnbrhfWghsT3gPl7RuHDoMUBoiFzrXC1iVmiw6aqC94cS2O1B238wK8iwIg0MF1KehKPwXzcTYkj8X8GiSfwao9L+9SbLfxcEdgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=kehs/q75; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1711390802; x=1742926802;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=uHhlIrcbjgGugVrnULqKo79hOAeKgkuRQs1mlZIeYWs=;
  b=kehs/q75m/6qErL71bCz/ABQGlMY6IG1MEwkhUtqHZpy/8FZMB4nrvoW
   X8IjBhLtyO7OG1UEJUbbb46ie2+5b7YSzoCsxzk9w1GuHvxKTx/Z17Jdq
   7TFDjJQt4JPpfI/lKPfR8CPZuEtGvJQyKYB0GpvHNjkYG9GEjwKWqy0iY
   w=;
X-IronPort-AV: E=Sophos;i="6.07,153,1708387200"; 
   d="scan'208";a="713639837"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 18:19:51 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.7.35:59981]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.85:2525] with esmtp (Farcaster)
 id 2a48eecb-5f6f-4265-83fe-bc1c6aeb733a; Mon, 25 Mar 2024 18:19:49 +0000 (UTC)
X-Farcaster-Flow-ID: 2a48eecb-5f6f-4265-83fe-bc1c6aeb733a
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:19:49 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.62) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Mon, 25 Mar 2024 18:19:46 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Joanne Koong <joannelkoong@gmail.com>, Jianguo Wu <wujianguo106@163.com>,
	Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 0/8] tcp: Fix bind() regression and more tests.
Date: Mon, 25 Mar 2024 11:19:15 -0700
Message-ID: <20240325181923.48769-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D046UWB004.ant.amazon.com (10.13.139.164) To
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

 net/ipv4/inet_connection_sock.c             |  22 +-
 tools/testing/selftests/net/bind_wildcard.c | 783 ++++++++++++++++++--
 2 files changed, 729 insertions(+), 76 deletions(-)

-- 
2.30.2


