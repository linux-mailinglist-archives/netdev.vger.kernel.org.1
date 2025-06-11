Return-Path: <netdev+bounces-196427-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D0F3AD4BC2
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 08:31:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB65C174044
	for <lists+netdev@lfdr.de>; Wed, 11 Jun 2025 06:31:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03B35230BC7;
	Wed, 11 Jun 2025 06:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="CHJ75+4V"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478CF22F743
	for <netdev@vger.kernel.org>; Wed, 11 Jun 2025 06:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749623465; cv=none; b=V52cB9V2ICeRbWu9JdHx0YeFeAWOm7Q2xuRYVdUevM43kBDg7LxXy5HTFC28sR1MNMsX2xP1Z3oY+4TnFovU1cWbHLIKZWviYJ/PxDlGVYm/VedmAoT3GNkOXP17KtUVSG7L/Ur4fYC0apxUo4TWaYaDm7i2in6pFGmoHvmyy4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749623465; c=relaxed/simple;
	bh=HOofvqO2hKVdW5nfL95G3IL7DkiPMbizyZyVgvv7BjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NmTKfWlHlZ9xKk1OQb7nMf2oqDwfZHh1KcjJQQSoMY9hn6pleJWN6s5YFN/TtDzDjGTTbwwLJG6PjNc60x//BD9fee9D0x0WEv0TCyNS1TbMgKL8BC+NiHCLpiRn/MzBXI/sSH4k93RaPvyeXYPDtcxAmZ1Sz+JkfdHcaZvZ2eo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=CHJ75+4V; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1749623459;
	bh=RfSzqkTGihnHbKLFbMoRJ0Y2D72xCCcqp/hRgUWiJMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=CHJ75+4VWj5pSoKRgkb2QlwZlYtdcyti7ixamHBOm2RPjyxCtLS6WQkWcrBgrzdSs
	 2etUICZUifjITtiMnh/hSv0Jzp+iiVrskBgBaGbJoYmjsNfK6m096YUEW/nAz4BYjt
	 imtcuPPqmoZgFbnOJo5VId9CHGT25e9ylx6aORdhDJLP3FLFUrkDE/tqnXNXquUwvf
	 K+GUKK+EPbUDWbrWDzW9Xxne/NaVcKH0KC0CPLNwKFAHgDKGU73kI5ZUTIrrI4tWuY
	 +FJQGqWr0J7zISBvFfIdoEFRpEAm0uE6IQubC1iumlKzS+sylUI38RKFrtaV496ngA
	 62yMWL6dEov8w==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id DA2D067DE3; Wed, 11 Jun 2025 14:30:59 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Wed, 11 Jun 2025 14:30:34 +0800
Subject: [PATCH net-next 07/13] net: mctp: test: add sock test
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250611-dev-forwarding-v1-7-6b69b1feb37f@codeconstruct.com.au>
References: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
In-Reply-To: <20250611-dev-forwarding-v1-0-6b69b1feb37f@codeconstruct.com.au>
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
index 6309290e60155f0407cec77996ce01022474f43e..76f6ad450d46dd2682e34bebd6c833c052d9a25e 100644
--- a/net/mctp/test/route-test.c
+++ b/net/mctp/test/route-test.c
@@ -1206,7 +1206,7 @@ static struct kunit_case mctp_test_cases[] = {
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


