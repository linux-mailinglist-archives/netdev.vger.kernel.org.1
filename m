Return-Path: <netdev+bounces-201810-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3503FAEB1B8
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 10:53:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A50E917B151
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 08:53:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 771BF2820DC;
	Fri, 27 Jun 2025 08:52:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b="WHhxojKV"
X-Original-To: netdev@vger.kernel.org
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B134128152F
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 08:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.29.241.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751014373; cv=none; b=Z7Vn4tH010QBen/cjD6sv4/aRPNLQ0bUPiP++nogeQuR1rqaKkRNOfcumVQKjX/eCa71jkbIenUDAPB6+rJY3jQb6Ctrh72ZsW7WGllfKoazYf0jTGZ9f30f9u+flwu6qBj+Dsiqy7cuBOPXLlNDAwuBS/8sZXZNhn4NGxegoLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751014373; c=relaxed/simple;
	bh=x0fJ6cfQRkGG+E9BFIluEj2jQII5H/JkoqOIhzd7THo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=byU7Eyy/mxyUKcVS3pOQRB68h4opCjIkVvIoqc06tvBaOEW62Exl6KazqUVBL9VpvnmDYjOFl2z7zmhB/LN3A0rZjpIhWE/lzu4gv7UbVOiluTAfR4BP96D2CpJMd0Yo13Br2IZ3DyhXWvPOZzbaxWFgdExe0bCrikdOxqxFqTk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au; spf=pass smtp.mailfrom=codeconstruct.com.au; dkim=pass (2048-bit key) header.d=codeconstruct.com.au header.i=@codeconstruct.com.au header.b=WHhxojKV; arc=none smtp.client-ip=203.29.241.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=codeconstruct.com.au
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=codeconstruct.com.au
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=codeconstruct.com.au; s=2022a; t=1751014368;
	bh=UPfJ1GWfJE9MkDDvXTa8nOMaYvNqDJDNgyr/OriId1I=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=WHhxojKVhGP972fN99qgBFdypfcfZ2+6slLsSZN0j6zF/SAiMbsvGaaGEjjjDnJXF
	 HsDVNtthatclbk0hEsKLFRtYfo9PR9+mAFmz6/rqPSoV6FlebWD+pmInvQQmdub0sY
	 5P/Ha7LxwsQpW95QCmDmnlvWCI1116VZZj2ze6u3Ja2+AeqzPq5XXyGpTW2BoL9umq
	 LDHwM8aTMWOtb1OUkqiooPwku0M0kpdMV9art+ojsEeKFGNHyN0xich6dJ6do4etKa
	 A2kn7jPbDNyuz25wcYS+prlxmqoJadLej7luVxmbUWri8GWSw9EyKbS4zjxAyYoHfB
	 peiLR6kx+7/Pg==
Received: by codeconstruct.com.au (Postfix, from userid 10000)
	id 0644D69E24; Fri, 27 Jun 2025 16:52:48 +0800 (AWST)
From: Jeremy Kerr <jk@codeconstruct.com.au>
Date: Fri, 27 Jun 2025 16:52:24 +0800
Subject: [PATCH net-next v4 08/14] net: mctp: test: add sock test
 infrastructure
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20250627-dev-forwarding-v4-8-72bb3cabc97c@codeconstruct.com.au>
References: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
In-Reply-To: <20250627-dev-forwarding-v4-0-72bb3cabc97c@codeconstruct.com.au>
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


