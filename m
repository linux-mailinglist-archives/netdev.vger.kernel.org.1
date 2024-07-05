Return-Path: <netdev+bounces-109328-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 172F9927FE7
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 03:52:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42C651C21FD1
	for <lists+netdev@lfdr.de>; Fri,  5 Jul 2024 01:52:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFAC4848A;
	Fri,  5 Jul 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KyqQV7WI"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A84D107A9
	for <netdev@vger.kernel.org>; Fri,  5 Jul 2024 01:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720144349; cv=none; b=ZEfIxXkRE/zd3qoFStRFCw6juj4Rl0YwbOYMXO6UjXyKFYEcgEFqYzDT53VdzrpvoN46bg7fqXbxwcZ9m54/ECXQAomqtlzSL7OPaRoJahPfwzjzgU04zfCzd3O1I/mYOi0oQqSfCRS1gg5dSeVSfOMcPyBctDhPBAi+fg/RW6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720144349; c=relaxed/simple;
	bh=1SUZIImLdAeO2m8NLSwX9Fvd20q7PWF60q3K0tzKOPE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PtFhHPDVG8sLlhdWE0ZMQKlKmdTXkXyFWJ/nyVA5sJmMunhVCQZiskhuHn7ojoJUgg6q15IKxo+WlZqqO9wKA+r13faOSEq3gSn4Lnxa95D+a6KHBljHRe5ZtsmDrZlNCmJ5s0ORW03KOqGt3ciLbKw7MD1TDDgKHu3zVZv/jco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KyqQV7WI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0DB7C3277B;
	Fri,  5 Jul 2024 01:52:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720144349;
	bh=1SUZIImLdAeO2m8NLSwX9Fvd20q7PWF60q3K0tzKOPE=;
	h=From:To:Cc:Subject:Date:From;
	b=KyqQV7WIHpQqDgMUuzRngLU9Scvel0+ELji9r5q05itPg9cP+fKwccn93914BoucS
	 E7XXDZWls/s61LyxKX6Y+qlJx0L0kbIztAuK3epmrI7X37mHI9L2rI4Qc6ECjshYFc
	 vIjc7trfFIY8h9Xn5QtypoLNWJRoYrYy5Lsa4yPWp4dLBOyvUtcUyS29Rs7ffkzp96
	 2Eu9G1oW7W49iYOFkURoc0madKislBBBtDzXI0clvoVZHAseSkFFaBoYe4XfUwqwff
	 EsAReRdl66sytK8fqElF5CXzfwBCO/VBjovv3E7JHGPQ1VCnMKEYhIONAcUi5pSrPC
	 1sVG10nme1Bkw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	petrm@nvidia.com,
	przemyslaw.kitszel@intel.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next] selftests: net: ksft: interrupt cleanly on KeyboardInterrupt
Date: Thu,  4 Jul 2024 18:52:22 -0700
Message-ID: <20240705015222.675840-1-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

It's very useful to be able to interrupt the tests during development.
Detect KeyboardInterrupt, run the cleanups and exit.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 3aaa2748a58e..f26c20df9db4 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -146,6 +146,7 @@ KSFT_RESULT_ALL = True
 
     global KSFT_RESULT
     cnt = 0
+    stop = False
     for case in cases:
         KSFT_RESULT = True
         cnt += 1
@@ -160,10 +161,13 @@ KSFT_RESULT_ALL = True
         except KsftXfailEx as e:
             comment = "XFAIL " + str(e)
             cnt_key = 'xfail'
-        except Exception as e:
+        except BaseException as e:
+            stop |= isinstance(e, KeyboardInterrupt)
             tb = traceback.format_exc()
             for line in tb.strip().split('\n'):
                 ksft_pr("Exception|", line)
+            if stop:
+                ksft_pr("Stopping tests due to KeyboardInterrupt.")
             KSFT_RESULT = False
             cnt_key = 'fail'
 
@@ -175,6 +179,9 @@ KSFT_RESULT_ALL = True
         ktap_result(KSFT_RESULT, cnt, case, comment=comment)
         totals[cnt_key] += 1
 
+        if stop:
+            break
+
     print(
         f"# Totals: pass:{totals['pass']} fail:{totals['fail']} xfail:{totals['xfail']} xpass:0 skip:{totals['skip']} error:0"
     )
-- 
2.45.2


