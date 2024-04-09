Return-Path: <netdev+bounces-86308-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3022A89E5CD
	for <lists+netdev@lfdr.de>; Wed, 10 Apr 2024 00:53:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C7AF51F216A0
	for <lists+netdev@lfdr.de>; Tue,  9 Apr 2024 22:53:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34294158D86;
	Tue,  9 Apr 2024 22:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="lATJ68EL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-80006.amazon.com (smtp-fw-80006.amazon.com [99.78.197.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ADA3757F6
	for <netdev@vger.kernel.org>; Tue,  9 Apr 2024 22:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.217
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712703229; cv=none; b=epxZ24ktv0sRCsU5r5S4W2QHBdcetCeRkzBa2WiM0XyYwJ16cu5yGT47YYLoXWBTv3TTcc5teJ91luuIDty8Lwp3/X8O3Tpqx52nqZp9zttKBuj9W0flmwb/ua3qsPxPLLMkyARtwnJT9ZN02kKTBJJHwIEB37x/jYzSpNiofj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712703229; c=relaxed/simple;
	bh=4HmgNfMh8fuok6hn09TbuBodW1FzUfufzUZUTjC65xw=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=uEndCJeYgU4nF0bt77z7diC4IcHhh5U1ya+xNoOPYVfGsiJTCCvHaEUWfc769AEPalyH3bpL3TGMgSP8tYujIh5mLi/fySps/a8A8Ke/mcxRdeEow9eFSWpK9qs0zQQYdHQWLaKoreEQusK1b5HFRagdBs4fOwM3GNT5kWiooEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=lATJ68EL; arc=none smtp.client-ip=99.78.197.217
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1712703228; x=1744239228;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=sQeDHEHqLBFN8588bgL2rXw+BYg4fC2ZXoFvUPuAa3I=;
  b=lATJ68ELFR6Q4JH4MI5YZA5BRIOVLRfzMkd5r+0uBub26D8Fc+eJvt1U
   DlaIxMWQ8Us5aXtgGbAdNR1GT6YJlQPmCS29b7dtTeXvhAhjfvOdCbAqt
   CpvJp4pJUm3Dz2o1vs7dr0XfcN7j2ZjxSYCiWFnqkHLEjSaEmtOhsfuID
   M=;
X-IronPort-AV: E=Sophos;i="6.07,190,1708387200"; 
   d="scan'208";a="286468105"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80006.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Apr 2024 22:53:45 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.38.20:35717]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.12.255:2525] with esmtp (Farcaster)
 id 912aca76-2cda-4a36-b647-12315ee3860b; Tue, 9 Apr 2024 22:53:44 +0000 (UTC)
X-Farcaster-Flow-ID: 912aca76-2cda-4a36-b647-12315ee3860b
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:53:44 +0000
Received: from 88665a182662.ant.amazon.com (10.106.100.45) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.28; Tue, 9 Apr 2024 22:53:41 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Rao shoaib <rao.shoaib@oracle.com>, Kuniyuki Iwashima <kuniyu@amazon.com>,
	Kuniyuki Iwashima <kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net 3/3] af_unix: Prepare MSG_OOB deprecation.
Date: Tue, 9 Apr 2024 15:52:09 -0700
Message-ID: <20240409225209.58102-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20240409225209.58102-1-kuniyu@amazon.com>
References: <20240409225209.58102-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWB004.ant.amazon.com (10.13.139.143) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 314001f0bf92 ("af_unix: Add OOB support") introduced MSG_OOB
support for AF_UNIX, and it's about 3 years ago.  Since then, MSG_OOB
is the playground for syzbot.

MSG_OOB support is guarded with CONFIG_AF_UNIX_OOB, but it's enabled
by default and cannot be disabled without editing .config manually
because of the lack of prompt.

We recently found 3 wrong behaviours with basic functionality that
no one have noticed for 3 years, so it seems there is no real user
and even the author is not using OOB feature.  [0]

This is a good opportunity to drop MSG_OOB support.

Let's switch the default config to n and add warning so that someone
using MSG_OOB in a real workload can notice it before MSG_OOB support
is removed completely.

Link: https://lore.kernel.org/netdev/472044aa-4427-40f0-9b9a-bce75d5c8aac@oracle.com/ [0]
Fixes: 314001f0bf92 ("af_unix: Add OOB support")
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
Added Fixes tag so that it can be backported to corresponding stable
kernels.
---
 net/unix/Kconfig   | 4 ++--
 net/unix/af_unix.c | 2 ++
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/unix/Kconfig b/net/unix/Kconfig
index 8b5d04210d7c..9d9270fdc1fe 100644
--- a/net/unix/Kconfig
+++ b/net/unix/Kconfig
@@ -17,9 +17,9 @@ config UNIX
 	  Say Y unless you know what you are doing.
 
 config	AF_UNIX_OOB
-	bool
+	bool "Unix MSG_OOB support"
 	depends on UNIX
-	default y
+	default n
 
 config UNIX_DIAG
 	tristate "UNIX: socket monitoring interface"
diff --git a/net/unix/af_unix.c b/net/unix/af_unix.c
index 9a6ad5974dff..fecca27aa77f 100644
--- a/net/unix/af_unix.c
+++ b/net/unix/af_unix.c
@@ -2253,6 +2253,8 @@ static int unix_stream_sendmsg(struct socket *sock, struct msghdr *msg,
 	err = -EOPNOTSUPP;
 	if (msg->msg_flags & MSG_OOB) {
 #if IS_ENABLED(CONFIG_AF_UNIX_OOB)
+		pr_warn_once("MSG_OOB support will be removed in 2025.\n");
+
 		if (len)
 			len--;
 		else
-- 
2.30.2


