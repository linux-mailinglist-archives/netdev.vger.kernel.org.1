Return-Path: <netdev+bounces-207583-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1751DB07F30
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 22:57:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85ECE1AA5F26
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 20:57:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07AF728937A;
	Wed, 16 Jul 2025 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DfpBbwff"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6C061CD2C
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 20:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752699442; cv=none; b=f+kQeuna4yHe+fcfyTUUst31XHuPYb5Sd0IPS0Wcq9ikO4bOR4z4YgLLDw3zzHCm6wz1E2opc+8gOkH1eWEe3aPduw82drM0cd3gti1/kHp/Q+FcWLyglY3433QGr11+WtBNrNZA4hmmgpaUZQmEuY1gwjm0v/Ng1hxX4ZQn+3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752699442; c=relaxed/simple;
	bh=duW8/0t+xC8DxBkcoJtXpZodJ2+lVqqUm7VZhMHdPfo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=J5hh2AT8iem+/T6jv+D8M41QNA7259b2n3Ydb4VrM1Iz2ou0wigJUYVOK6BAFGFhPY4oXKeGuLGe1va2kMpnA0nombH6zItW5axxBtyheB7Fh4Kypj7ZW9ghEnstOi4aT1+mcM2x2ySpbSWydAsZmK1ftN+hq+dLSOeJPy5fNyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DfpBbwff; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14EDDC4CEE7;
	Wed, 16 Jul 2025 20:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752699442;
	bh=duW8/0t+xC8DxBkcoJtXpZodJ2+lVqqUm7VZhMHdPfo=;
	h=From:To:Cc:Subject:Date:From;
	b=DfpBbwffe/qTpf5tGBMSgMuPX+Fzu4Hunug+3eXG+CwE6kTcd/Z9geP+IoeKE1g4d
	 qsfLrqUcmA59S+WlURIYBgp8nn6XWwXEkMUiaaVIZ9KO+to8FGhJ7v91Swtwuv97nl
	 0SkGvqefTyGjeLKDjXWOauNuOVWfiYKGgbxNVWmSL3LQoFoWSrgfMWVzbJ4p7ylmEe
	 MIsIj5A2XUBw8o7ZsjO4tAmNPHMBKTimBQdLX0Bc1CQ+mJJbArmSgF/0O0cZz9NLiJ
	 PUfAVUVWYLgy62Auk3aV5muE/1xrLjtesG6vcdrknit5iwajW7aiHHSlJFPF9MgcMz
	 pr4oOdL2YQg8Q==
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
	sdf@fomichev.me
Subject: [PATCH net-next] selftests: net: prevent Python from buffering the output
Date: Wed, 16 Jul 2025 13:57:12 -0700
Message-ID: <20250716205712.1787325-1-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure Python doesn't buffer the output, otherwise for some
tests we may see false positive timeouts in NIPA. NIPA thinks that
a machine has hung if the test doesn't print anything for 3min.
This is also nice to heave for running the tests manually,
especially in vng.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: petrm@nvidia.com
CC: sdf@fomichev.me
---
 tools/testing/selftests/net/lib/py/ksft.py | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 61287c203b6e..8e35ed12ed9e 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -32,6 +32,7 @@ KSFT_DISRUPTIVE = True
 
 
 def ksft_pr(*objs, **kwargs):
+    kwargs["flush"] = True
     print("#", *objs, **kwargs)
 
 
@@ -139,7 +140,7 @@ KSFT_DISRUPTIVE = True
         res += "." + str(case.__name__)
     if comment:
         res += " # " + comment
-    print(res)
+    print(res, flush=True)
 
 
 def ksft_flush_defer():
@@ -227,8 +228,8 @@ KSFT_DISRUPTIVE = True
 
     totals = {"pass": 0, "fail": 0, "skip": 0, "xfail": 0}
 
-    print("TAP version 13")
-    print("1.." + str(len(cases)))
+    print("TAP version 13", flush=True)
+    print("1.." + str(len(cases)), flush=True)
 
     global KSFT_RESULT
     cnt = 0
-- 
2.50.1


