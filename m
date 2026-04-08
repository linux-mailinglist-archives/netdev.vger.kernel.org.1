Return-Path: <netdev+bounces-276727-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALnqAZLU1mkoJAgAu9opvQ
	(envelope-from <netdev+bounces-276727-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:20:02 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A9723C46DD
	for <lists+netdev@lfdr.de>; Thu, 09 Apr 2026 00:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id DAA473008443
	for <lists+netdev@lfdr.de>; Wed,  8 Apr 2026 22:19:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42CF530FF37;
	Wed,  8 Apr 2026 22:19:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fq+W0+QP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE242192FA;
	Wed,  8 Apr 2026 22:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775686796; cv=none; b=CDg9NA1CDKWzDuKVmcYLhpv9kPdOEqaPNHxTI/XqwGXi+sdSS9vhLFGIlcd9nGg1VmQeXKNoh7uFWJt9kjrlfPyVxATDbJFt/GKHxQeJMBNi9/jeA5tZf4OtmOGp1+EhJj1Le9IflloGZynZckkrQueTof7LmwucQUfdLxDtN/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775686796; c=relaxed/simple;
	bh=UR236EGNu8Ks2fR6RvDlw4evNRmSK8xkRco1KYHAqq8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IqFv4my+JmGf6aikCd/5NKQ68fBzwHqoILaITm6LocJupXwafZe9un9+y2ZI0M2nED9GN8Uz1s5ZFX/iqFV7wHioa9TbDy/80so1pzUwj6mzPOyq8meltro4bdazlu2N2T3z8Pes0OTufX1txlIkniJIyzzFGXiQblJJFw8z5mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fq+W0+QP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 483AEC19421;
	Wed,  8 Apr 2026 22:19:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775686795;
	bh=UR236EGNu8Ks2fR6RvDlw4evNRmSK8xkRco1KYHAqq8=;
	h=From:To:Cc:Subject:Date:From;
	b=Fq+W0+QPq+MlOrEK6nqDKg0/wxbNYBkHujbS9IgGNHm8RGb0WPDuU7Qo3kwcUi+Oi
	 dT075NLvMDOyzpmh08++bc863DalpmjBVGSXpuZPGtNcYl4uWWcZGj6lD373HSlDNw
	 xCFSDyC1zE7WI4I5396F2q5HsE2xQ0S+/vwq2xE8v4IH0y+gIR9TxykpYYvpoWBuzQ
	 JHPrUNdiOW1LGXh83SyrjeO3A/3qXMpccbLCmqbJL06EePdWR1y4HTSwpGcW8t3wY2
	 Kf2je5rtaJP/vxunq8y9Z839skY0xM1OUwntHtGHFX1Y5f9FBREZUIZAuXmdZFUQlj
	 Dxe4/U6Q6+KCQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	petrm@nvidia.com,
	willemb@google.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next] selftests: net: py: explicitly forbid multiple ksft_run() calls
Date: Wed,  8 Apr 2026 15:19:52 -0700
Message-ID: <20260408221952.819822-1-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-276727-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A9723C46DD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

People (do people still write code or is it all AI?) seem to not
get that ksft_run() can only be called once. If we call it
multiple times KTAP parsers will likely cut off after the first
batch has finished.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: willemb@google.com
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/lib/py/ksft.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 7b8af463e35d..7083c99c9444 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -341,10 +341,13 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
+    global KSFT_RESULT
+    if KSFT_RESULT is not None:
+        raise RuntimeError("ksft_run() can't be called multiple times.")
+
     print("TAP version 13", flush=True)
     print("1.." + str(len(test_cases)), flush=True)
 
-    global KSFT_RESULT
     cnt = 0
     stop = False
     for func, args, name in test_cases:
-- 
2.53.0


