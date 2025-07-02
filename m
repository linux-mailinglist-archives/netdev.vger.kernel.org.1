Return-Path: <netdev+bounces-203195-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CA22AF0B82
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 08:21:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D650F4A3EA8
	for <lists+netdev@lfdr.de>; Wed,  2 Jul 2025 06:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3FFB2253A9;
	Wed,  2 Jul 2025 06:20:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="csCDtZ0E"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C9B2223714
	for <netdev@vger.kernel.org>; Wed,  2 Jul 2025 06:20:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751437222; cv=none; b=pFt0fW5ep0SvFmYKXr8cBc6Lf6cDmC4S3Z7gW+1wQLUp4R1Hsw2H8cPh0VXH2ueeVzGcGyuHTeqGrh5LNfDD8Cp40LJhUU04XbT1Ypf8am69WQl+t1h2l/DywP3qv51PI/Y8Zvg+gymeyvoI78v71pT/p87CWa8Rw6iVvMzVJs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751437222; c=relaxed/simple;
	bh=Amw0PqR5Isd4b113XfXtqV7pEB/MPGGEeSph9UKgcOM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=QlCA2nbl1faARthFgxJxjlSvKoDEqr7xi5i3+1OS6aT2huZwym/NX0jKDgg5coYlxFdHqaXYHw9oaiMquuQOV3JKkyAruo3AFFfO06KIyEoRrg9Z/BnpCq+5VPr2G8AhLqsty+rEBgwpiOOoOZm3qY+NFlUXjRlIB7lVKfssdFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=csCDtZ0E; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751437217;
	bh=Qy3ifS83h7dXY25PPKU7pao4sLv1rSgHCtBSfhmTeNY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=csCDtZ0Ev7KeTq0rlDwRhuJWazaT/bQCWJhQzfytzhEf0fOmogqOJT2IGFNwFR7Ku
	 LOGhil+eMC8qmz/ppEIxkAGJ+biMwZb8nEigJgJ4OID02mrs9KggtvLorEZGPW7B+m
	 2P+crM89db4SoIZXtMXA9hkbMx6lDdnF3JjZ1/wXTcvIDdLkaQ7tNy+Fitk4DSqHm4
	 aPC2ps0kXJs6VuVhCrSAH7SSOMX4IHhPkUQm5vV4V8kRJWRrhUFIDUyLWhOQ3dNlcc
	 aeC0jP0bFLOIsfqdYVZgUstUq1YCHMYOuR5MxXhOy5ZPwVbOMvTNUzEGPJzYh5NyDz
	 2FsKVryq4R0WQ==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 641A66A70F; Wed,  2 Jul 2025 14:20:17 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 02 Jul 2025 14:20:08 +0800
Subject: [PATCH net-next v5 08/14] net: mctp: test: add sock test
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250702-dev-forwarding-v5-8-1468191da8a4@codeconstruct.com.au>
References: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
In-Reply-To: <20250702-dev-forwarding-v5-0-1468191da8a4@codeconstruct.com.au>
To: Matt Johnston <matt@codeconstruct.com.au>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>
Cc: netdev@vger.kernel.org
X-Mailer: b4 0.14.2

Add a new test object, for use with the af_mctp socket code. This is
intially empty, but we'll start populating actual tests in an upcoming
change.

Signed-off-by: Jeremy Kerr <jk@codeconstruct.com.au>
---
 net/mctp/af_mctp.c         |  4 ++++
 net/mctp/test/route-test.c |  2 +-
 net/mctp/test/sock-test.c  | 16 ++++++++++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/net/mctp/af_mctp.c b/net/mctp/af_mctp.c
index e2570d9755eac75c1384a4d576f1c7c3cc5d5b31..aef74308c18e3273008cb84aabe23ff700d0f842 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -775,3 +775,7 @@ MODULE_DESCRIPTION("MCTP core");
 MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
 
 MODULE_ALIAS_NETPROTO(PF_MCTP);
+
+#if IS_ENABLED(CONFIG_MCTP_TEST)
+#include "test/sock-test.c"
+#endif
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index bbee22d33d6d3bb89cc61a0e010b8c4f07c68eae..36dd5e9ba27a0cfc6247ff321e884a9e128ee535 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1204,7 +1204,7 @@ static struct kunit_case mctp_test_cases[] = {
 };
 
 static struct kunit_suite mctp_test_suite = {
-	.name = "mctp",
+	.name = "mctp-route",
 	.test_cases = mctp_test_cases,
 };
 
diff --git a/net/mctp/test/sock-test.c b/net/mctp/test/sock-test.c
new file mode 100644
index 0000000000000000000000000000000000000000..abaad82b4e256bead6c0a6ab0698bfa4f75f8473
--- /dev/null
+++ b/net/mctp/test/sock-test.c
@@ -0,0 +1,16 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <kunit/test.h>
+
+#include "utils.h"
+
+static struct kunit_case mctp_test_cases[] = {
+	{}
+};
+
+static struct kunit_suite mctp_test_suite = {
+	.name = "mctp-sock",
+	.test_cases = mctp_test_cases,
+};
+
+kunit_test_suite(mctp_test_suite);

-- 
2.39.5


