Return-Path: <netdev+bounces-109964-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B298C92A8B9
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 20:09:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DB1AA1C213FA
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 18:09:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD4E4149C4A;
	Mon,  8 Jul 2024 18:09:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="Bx92I1Ge"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-33001.amazon.com (smtp-fw-33001.amazon.com [207.171.190.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BD3A149C6A
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 18:09:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.190.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720462155; cv=none; b=bmDUdOoa+yfhBjiEjQ3ICCuwbDdRcj4wHkm0kArDBdzo1qOna+TJ2Qn22FcPIxkrTbPbVCYo4FHmebnkfrOhKcQsxNQEab/Vfqgc1ga/Z/tF/+8a3Q6YEypSbg40M5q5k/6hGHynM0pBaqx8162kf7hznMigG8fUNOF0scqL5yE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720462155; c=relaxed/simple;
	bh=F8eqGLOzZUg06FeI0jKLhEV14MNAK93N7lQdkqux2No=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=NuPf8ZSxyAfBHuTqtT4nOO/McSIGerh+Jv/azxQhnMhL2/nr7/yVL1EE/absJ5+Iubsei8DFrbXz5FSlkIjXjp9Out0ALl5oyyqv9ZcXH40sHOkzJfyylvuUIb2Hur7uE48yRoVckk4FL/VxoC5AfjfuWqpP6IOzuA+ZZOM1xxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=Bx92I1Ge; arc=none smtp.client-ip=207.171.190.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1720462154; x=1751998154;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=H4sj8c1mPnWUC9hKT35iCh+HgmfcF3uQjfb7xI8WWD4=;
  b=Bx92I1GeBjSVLDmKCMg2vTxJhPGUtfFRLYZlakjkAF7FpHp11Nlz3CWr
   QfRkzIdmw72YbAkTY3b75of3l85Nm5Qspcr5m53m+NdZCuLtVMYljCL6g
   3bFAr1ivhAYe1ZK7Mgm7o9XfArxjcy8BwwE+szv5dzwisdQsEJLiY3N4S
   c=;
X-IronPort-AV: E=Sophos;i="6.09,192,1716249600"; 
   d="scan'208";a="354931284"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-33001.sea14.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jul 2024 18:09:08 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.21.151:48357]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.36.52:2525] with esmtp (Farcaster)
 id 5c3f6622-7ce0-4ff3-bae8-c10b17a4829f; Mon, 8 Jul 2024 18:09:06 +0000 (UTC)
X-Farcaster-Flow-ID: 5c3f6622-7ce0-4ff3-bae8-c10b17a4829f
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:09:06 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.51) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 8 Jul 2024 18:09:03 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>, David Ahern <dsahern@kernel.org>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, Dmitry Safonov <dima@arista.com>,
	<netdev@vger.kernel.org>
Subject: [PATCH v2 net-next 0/2] tcp: Make simultaneous connect() RFC-compliant.
Date: Mon, 8 Jul 2024 11:08:50 -0700
Message-ID: <20240708180852.92919-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Patch 1 fixes an issue that BPF TCP option parser is triggered for ACK
instead of SYN+ACK in the case of simultaneous connect().

Patch 2 removes an wrong assumption in tcp_ao/self-connnect tests.

v2:
  * Target net-next and remove Fixes: tag
  * Don't skip bpf_skops_parse_hdr() to centralise sk_state check
  * Remove unnecessary ACK after SYN+ACK
  * Add patch 2

v1: https://lore.kernel.org/netdev/20240704035703.95065-1-kuniyu@amazon.com/


Kuniyuki Iwashima (2):
  tcp: Don't drop SYN+ACK for simultaneous connect().
  selftests: tcp: Remove broken SNMP assumptions for TCP AO self-connect
    tests.

 net/ipv4/tcp_input.c                           |  9 +++++++++
 .../selftests/net/tcp_ao/self-connect.c        | 18 ------------------
 2 files changed, 9 insertions(+), 18 deletions(-)

-- 
2.30.2


