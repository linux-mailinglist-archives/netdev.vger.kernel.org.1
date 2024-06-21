Return-Path: <netdev+bounces-105500-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA8A791184F
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 04:11:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8758A1F22763
	for <lists+netdev@lfdr.de>; Fri, 21 Jun 2024 02:11:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBC88287D;
	Fri, 21 Jun 2024 02:11:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="H4fVa/em"
X-Original-To: netdev@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3910E537FF
	for <netdev@vger.kernel.org>; Fri, 21 Jun 2024 02:11:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718935875; cv=none; b=T5tmnevY7WgSz8o5hJs0KrR3XJlSXGZIqK4yv6Fn3LeGQfWiS+YZ1YvGFWbpwUecleNywV8na9NS0yhzaeJNZHLxSd5FVSXlqaQl5Dzw+l6s+zXjzHNsO7Wb59w6RF+FV9+UUAOPyATSvVYYS1P56ijCJ/L1TUpqlyW+RbZa1+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718935875; c=relaxed/simple;
	bh=d7GTPID4LNAa9Ts0EYINdsejFk7hvzCgGYvvqJ9EyRs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hO+9f0tX8D6zUVQlH5Q/ylTfBNOfGVrQp4hbp7evJO60afb3+0PN3fS+NdkQqVGsvLlLwYb/y/905pLiZRafTOUTlkj9bpbjMiOICiitN9HX1GczITCAFa+ZUkTfwEKihx221zJNPOsuHyo4hIrRL9aKcDaX19ynIXDoGoPXo9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=H4fVa/em; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1718935874; x=1750471874;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pMawBHNfoZxxPVXvcuDJEJAkjT4wlyyJ9bFL0oWxndg=;
  b=H4fVa/emHuD1De1JUVF0j3nFoeKYdKZGS4drPJWqb3hesZXw0i2e35g/
   2aBrM9inFqnbWu6LpiU3elCkTApqIIjfmtvpNLn7xUTUtXaquAJkmNhJI
   hS2mhILC6ZPPtkZQNEwD7wKmXBZrLG1rUTMXDZZUyfFfAVIUIBi60CglU
   0=;
X-IronPort-AV: E=Sophos;i="6.08,253,1712620800"; 
   d="scan'208";a="734382643"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jun 2024 02:11:08 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.38.20:37361]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.47:2525] with esmtp (Farcaster)
 id f9d14ee6-342f-49c6-8127-fe3d07b81543; Fri, 21 Jun 2024 02:11:07 +0000 (UTC)
X-Farcaster-Flow-ID: f9d14ee6-342f-49c6-8127-fe3d07b81543
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 02:11:07 +0000
Received: from 88665a182662.ant.amazon.com (10.187.171.36) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Fri, 21 Jun 2024 02:11:04 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: "David S. Miller" <davem@davemloft.net>, Eric Dumazet
	<edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
	<pabeni@redhat.com>
CC: Kuniyuki Iwashima <kuniyu@amazon.com>, Kuniyuki Iwashima
	<kuni1840@gmail.com>, <netdev@vger.kernel.org>
Subject: [PATCH v1 net] selftest: af_unix: Add Kconfig file.
Date: Thu, 20 Jun 2024 19:10:51 -0700
Message-ID: <20240621021051.85197-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D041UWA004.ant.amazon.com (10.13.139.9) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

diag_uid selftest failed on NIPA where the received nlmsg_type is
NLMSG_ERROR [0] because CONFIG_UNIX_DIAG is not set [1] by default
and sock_diag_lock_handler() failed to load the module.

  # # Starting 2 tests from 2 test cases.
  # #  RUN           diag_uid.uid.1 ...
  # # diag_uid.c:159:1:Expected nlh->nlmsg_type (2) == SOCK_DIAG_BY_FAMILY (20)
  # # 1: Test terminated by assertion
  # #          FAIL  diag_uid.uid.1
  # not ok 1 diag_uid.uid.1

Let's add all AF_UNIX Kconfig to the config file under af_unix dir
so that NIPA consumes it.

Fixes: ac011361bd4f ("af_unix: Add test for sock_diag and UDIAG_SHOW_UID.")
Link: https://netdev-3.bots.linux.dev/vmksft-net/results/644841/104-diag-uid/stdout [0]
Link: https://netdev-3.bots.linux.dev/vmksft-net/results/644841/config [1]
Reported-by: Jakub Kicinski <kuba@kernel.org>
Closes: https://lore.kernel.org/netdev/20240617073033.0cbb829d@kernel.org/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 tools/testing/selftests/net/af_unix/config | 3 +++
 1 file changed, 3 insertions(+)
 create mode 100644 tools/testing/selftests/net/af_unix/config

diff --git a/tools/testing/selftests/net/af_unix/config b/tools/testing/selftests/net/af_unix/config
new file mode 100644
index 000000000000..37368567768c
--- /dev/null
+++ b/tools/testing/selftests/net/af_unix/config
@@ -0,0 +1,3 @@
+CONFIG_UNIX=y
+CONFIG_AF_UNIX_OOB=y
+CONFIG_UNIX_DIAG=m
-- 
2.30.2


