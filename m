Return-Path: <netdev+bounces-200962-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 876BCAE78BC
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 09:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 914C61899DD2
	for <lists+netdev@lfdr.de>; Wed, 25 Jun 2025 07:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B69DB218ABA;
	Wed, 25 Jun 2025 07:35:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="EufUU0nn"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16D2A217716
	for <netdev@vger.kernel.org>; Wed, 25 Jun 2025 07:35:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750836912; cv=none; b=YK+ZFMBFRRVqDDWgVfHX6CSMrt5xdp5T0thz+xT2WA/qo8AlA2Rheqft6yYQU30x/w0WDsrAJNU0aGqrkVeSpF2fuCsf+Dvb0bvElYU9y5+l3U2Le9RC2uDkgIZ7JYlNIYwD5wiQ1cBMSMfCaYEp/HSmixKLyILmboZlR7KXV+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750836912; c=relaxed/simple;
	bh=l+6d3dB0tYKHUC8REx0GVsifFo2/szZ/qFt6G+jWuT4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UWjfmfXPgZHlUbOMnKJ9FV35+eplWEqRm9J6qj/tY8eQa+KJ9iDjoXeW/eBIIGY0qx63EJZWNI8JaGVpFCIUnSQDUr2AeRA4mRKUogMv9qEC4xkubg9lkrvcaX5L5eRK/KlIcKCOKnRuCfJHqEtOn+bxz9mlgGXA7Cvv8t//YVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=EufUU0nn; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750836906;
	bh=ThKJIVxP34FutBJiFA5vhQ+upG7t/ewW3aeRSKsTlvc=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=EufUU0nnVQgTvHIOZJa5J/VYUitNxh7LNR/96CZgVT/djUiq/XbCi5YbTqqc+ipWS
	 QghHcPrTFbS1Rh5LXo9iPmwLB72VicSIfhN1OHM+3/pGFdLRyr4G5wqhBBz0tsYpgU
	 qNe6VIegecoauXgv9OFw1TRCG51OvFfJj6D9esK9mpMw1KC149wsTcWI7r3nFU8UFv
	 bfMBRQFklV70BVw/yT2iMxN5EInurUAApcR2K7er5gBINEyADKfitKh1AHktO5nkxs
	 5b8LKgewO/Pl9jxbZeNL5NPG86kViXdQF7QVBaKvCG0wh1sGitrSxWmflrsTQeGgT/
	 FrIqwI5k6nf5g==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id E238E69A3E; Wed, 25 Jun 2025 15:35:06 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 25 Jun 2025 15:34:46 +0800
Subject: [PATCH net-next v3 08/14] net: mctp: test: add sock test
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250625-dev-forwarding-v3-8-2061bd3013b3@codeconstruct.com.au>
References: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
In-Reply-To: <20250625-dev-forwarding-v3-0-2061bd3013b3@codeconstruct.com.au>
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
index 1141a4e33aaaabef4b58a5942dbe2847f2b7fcdd..a8f0fd473325f2fb0b196f21ae33dd863cbdf195 100644
--- a/net/mctp/af_mctp.c
+++ b/net/mctp/af_mctp.c
@@ -777,3 +777,7 @@ MODULE_DESCRIPTION("MCTP core");
 MODULE_AUTHOR("Jeremy Kerr <jk@codeconstruct.com.au>");
 
 MODULE_ALIAS_NETPROTO(PF_MCTP);
+
+#if IS_ENABLED(CONFIG_MCTP_TEST)
+#include "test/sock-test.c"
+#endif
diff --git a/net/mctp/test/route-test.c b/net/mctp/test/route-test.c
index bb3f454525c1b8e3133de2fe3bc3d139f6acd962..7cd2e3c60364c36f5f1251c25bea7d9617836106 100644
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


