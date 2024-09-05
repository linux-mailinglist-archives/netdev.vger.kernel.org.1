Return-Path: <netdev+bounces-125662-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A02E596E340
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 21:33:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3A100B2168B
	for <lists+netdev@lfdr.de>; Thu,  5 Sep 2024 19:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE67417BEC2;
	Thu,  5 Sep 2024 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="YyFalRPL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9102.amazon.com (smtp-fw-9102.amazon.com [207.171.184.29])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395174400
	for <netdev@vger.kernel.org>; Thu,  5 Sep 2024 19:33:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.184.29
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725564785; cv=none; b=cWb8rK8yqIHmjuCX5gmAWV4e8qPvOTIV16QRK6CvX8YMSXVNSi2idml2TnKnURZJh5p4L+IUYaCGMJamCMK1Ud02TlnnQshZ5oXut5CKu+7GEAixkkaGDIqjLkDXvr7BefzrXjaNr8P6hkYvQIG77tucKPSbuqHF+NVjcG0/LJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725564785; c=relaxed/simple;
	bh=2vmUpg2nF4PsLOpmmAoEdy4GMTVD0/gc/0tUatEt49c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=YsRC/L87A8EB2SclgWfEzY5LmrXDdXcYehPzHrkGu4ErPdTmQpaA6m5LjSDiSUtxQejmLDe8HLI1vghd3r4jL0wLuydarww2zI5Td0F9GZIs587KjMqVWYmmadTxHWCmBCefYQA1Q4tQoCYAXUPL0g9yIcfaF1m78/lw3BQOaqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=YyFalRPL; arc=none smtp.client-ip=207.171.184.29
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1725564785; x=1757100785;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7Xu0mfcb2Jf1oidlRbaswSLZy2ssikqlWsS46GSSplI=;
  b=YyFalRPLTL6l8vzpiPZtI3ocJ0Du+jOYBuPpIT1E0nv4mDoYwDvuUIKI
   PX7vIJ30uFsPVRD3dhs4KVGxNkbVZmNUzFAt5Hpn87XO9ctKYuYkvpHuN
   iW8hVLUjojMys7ambs2RAQ6HPuXUoxZvz787EYBW9wF6bup4ViTXtPpNc
   8=;
X-IronPort-AV: E=Sophos;i="6.10,205,1719878400"; 
   d="scan'208";a="451065443"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-9102.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Sep 2024 19:32:57 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:2045]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.41.110:2525] with esmtp (Farcaster)
 id 27601f2c-8a7a-4349-85e6-5e1acc533773; Thu, 5 Sep 2024 19:32:56 +0000 (UTC)
X-Farcaster-Flow-ID: 27601f2c-8a7a-4349-85e6-5e1acc533773
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Thu, 5 Sep 2024 19:32:56 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Thu, 5 Sep 2024 19:32:53 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net-next 0/4] af_unix: Correct manage_oob() when OOB follows a consumed OOB.
Date: Thu, 5 Sep 2024 12:32:36 -0700
Message-ID: <20240905193240.17565-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB003.ant.amazon.com (10.13.139.157) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Recently syzkaller reported UAF of OOB skb.

The bug was introduced by commit 93c99f21db36 ("af_unix: Don't stop
recv(MSG_DONTWAIT) if consumed OOB skb is at the head.") but uncovered
by another recent commit 8594d9b85c07 ("af_unix: Don't call skb_get()
for OOB skb.").

This should be targeted for net.git, but it will introduce conflicts.
Given it's now rc6, I'll target this for net-next and later send
8594d9b85c07 and this series for stable.

[0]: https://lore.kernel.org/netdev/00000000000083b05a06214c9ddc@google.com/


Kuniyuki Iwashima (4):
  af_unix: Remove single nest in manage_oob().
  af_unix: Rename unlinked_skb in manage_oob().
  af_unix: Move spin_lock() in manage_oob().
  af_unix: Don't return OOB skb in manage_oob().

 net/unix/af_unix.c                            | 61 ++++++++++---------
 tools/testing/selftests/net/af_unix/msg_oob.c | 23 +++++++
 2 files changed, 56 insertions(+), 28 deletions(-)

-- 
2.30.2


