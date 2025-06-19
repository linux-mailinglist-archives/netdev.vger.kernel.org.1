Return-Path: <netdev+bounces-199367-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8788ADFF56
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 10:01:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98FC15A03E8
	for <lists+netdev@lfdr.de>; Thu, 19 Jun 2025 08:01:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4413B25EFBF;
	Thu, 19 Jun 2025 08:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="MqXrC6jI"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61CE825E822
	for <netdev@vger.kernel.org>; Thu, 19 Jun 2025 08:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750320074; cv=none; b=f/7S4pZ88jCWu7VQgd4/XZKwSrE6liN1gsarRadoTZS5+kuQxAIoxeXCrSK88R00F166CL53MQ7DBRADRXNoqdSAncaZbkdNlJpoYRmi7PMEphGrHIvP5lAWV9hEhPQaRaDIrVcwrokasmhWwDAKUSBkKAy17gai4DoxS58CXf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750320074; c=relaxed/simple;
	bh=HOofvqO2hKVdW5nfL95G3IL7DkiPMbizyZyVgvv7BjI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Yv/pvFC+gS/OKEEQ/vO2OEfDlDXX9MTts0sStSda6+gSUD0CTOuVIfHerwBCYEUSbkytoOpKgYWVfVIrOxAX5ph3qql+IeEpCJolXQBl3VuU9GT0z7v3L5IWrE2muajxNtiSqf4bLdcDwBkkzpnfmqDPzintWXDeGOZWe8Ht9XY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=MqXrC6jI; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1750320062;
	bh=RfSzqkTGihnHbKLFbMoRJ0Y2D72xCCcqp/hRgUWiJMo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=MqXrC6jIjdMcrppzOf3e5NyaRUjXXNJa6QKJLsGptR+4L6JK5tssNTBddyayhS3qh
	 MaTR1Gpf3hb8O9Uni/XRK+FSud3e27qAOE6Y7aF+k0JS3ezvEeb4WtCfPw+6eqNewl
	 SHzmbCT9GM7l6q6gCFV8nYI9vQOZ31KyQQ4hd31kxXAah9St+lVnpr5sM57PyMDav1
	 QFhmuKX/OMJ2Z6iDeSARFDBIlr2BErzQCHP35eW7H0fqHEHMfnzml4BkiIKyGO9Pk+
	 674TjrKvm1Ocqzd2rFrXbMs9w/MD1D1wrjEPSAlXT3E2PLaG2UQa8KXJeViFQu9Tbq
	 SwJHVN2ZI6mpg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 52F9968EC5; Thu, 19 Jun 2025 16:01:02 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Thu, 19 Jun 2025 16:00:42 +0800
Subject: [PATCH net-next v2 07/13] net: mctp: test: add sock test
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250619-dev-forwarding-v2-7-3f81801b06c2@codeconstruct.com.au>
References: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
In-Reply-To: <20250619-dev-forwarding-v2-0-3f81801b06c2@codeconstruct.com.au>
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


