Return-Path: <netdev+bounces-248284-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2470ED067AB
	for <lists+netdev@lfdr.de>; Thu, 08 Jan 2026 23:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5361E30248AB
	for <lists+netdev@lfdr.de>; Thu,  8 Jan 2026 22:53:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A39332EB2;
	Thu,  8 Jan 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Fkft/Ia+"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93D5632F740
	for <netdev@vger.kernel.org>; Thu,  8 Jan 2026 22:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767912787; cv=none; b=ti6oGD3QCN/Jr05d2QX24lvCdaU6tV/OyWtxprpf7BY5LHCrLOoo2HBDes0zAR0Jw3/uCeI3X1t/Xf1sObr1IV3MPYWYyljckiqGtGDP/0ebKjykIR+TyWfpsmDbKN/LAfZ7oklR1fIdKHGDZpL19PhPs1R0sfE0P29vYc2aGB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767912787; c=relaxed/simple;
	bh=pZIqx6e/0qiarS6/pcqu/rSvkw+gAU3dI45bC4s71FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q4tsYRuRf/LJlNgViObs6KWoSAWCyFIR4KQ9vHtG2+E4s/Fx936hIjnxnCDfasuZ2xwehCAZzOqm+Qvmyd8NnTKX+Xfju8JM6KNCP1qcAA4xG7Ez4qdrQgRpxEmhT2OZNXFscxCoDsn1wabi/EYLO1p7nwO31wj+it4U1RJeFz4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Fkft/Ia+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEBF5C19422;
	Thu,  8 Jan 2026 22:53:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767912787;
	bh=pZIqx6e/0qiarS6/pcqu/rSvkw+gAU3dI45bC4s71FA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Fkft/Ia+9rMxx3yfgERblL4Gt4QPmVpiEZWU76yPaOBOobCzyPGgL9WWs4Kxu5X+w
	 KoepNh4jWqVdVMkHyS2j/XWo0odEHcqQnDEfcT5iKoeHjSXBk9hg9eKCwTYwnkrQCW
	 WVbupJmINwtpWWW0lC8Nhaqk258tknzwGtxcZScgegtg89vqfDtzOqFdFaqgqkCUqq
	 VtYuL5udLQGuFppfCm410+yRmlw72urOPm9802ZYaV/Gwt6IkOCwvKUfkCL/C5oRnB
	 3kiVqPT68iDC8pZlnjG2WawSwHevAMkW3rHglwj1n6KD5pt8c5NysjZzKBvPZlyjqA
	 eu+oJQEwxe46Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	petrm@nvidia.com,
	leitao@debian.org,
	jdamato@fastly.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: py: ensure defer() is only used within a test case
Date: Thu,  8 Jan 2026 14:52:57 -0800
Message-ID: <20260108225257.2684238-2-kuba@kernel.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108225257.2684238-1-kuba@kernel.org>
References: <20260108225257.2684238-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I wasted a couple of hours recently after accidentally adding
a defer() from within a function which itself was called as
part of defer(). This leads to an infinite loop of defer().
Make sure this cannot happen and raise a helpful exception.

I understand that the pair of _ksft_defer_arm() calls may
not be the most Pythonic way to implement this, but it's
easy enough to understand.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/ksft.py  | 7 +++++++
 tools/testing/selftests/net/lib/py/utils.py | 3 +++
 2 files changed, 10 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 248cd1a723a3..0a96f88bb60a 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -153,6 +153,11 @@ KSFT_DISRUPTIVE = True
     print(res, flush=True)
 
 
+def _ksft_defer_arm(state):
+    """ Allow or disallow the use of defer() """
+    utils.GLOBAL_DEFER_ARMED = state
+
+
 def ksft_flush_defer():
     global KSFT_RESULT
 
@@ -315,6 +320,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
         comment = ""
         cnt_key = ""
 
+        _ksft_defer_arm(True)
         try:
             func(*args)
         except KsftSkipEx as e:
@@ -332,6 +338,7 @@ KsftCaseFunction = namedtuple("KsftCaseFunction",
                 ksft_pr(f"Stopping tests due to {type(e).__name__}.")
             KSFT_RESULT = False
             cnt_key = 'fail'
+        _ksft_defer_arm(False)
 
         try:
             ksft_flush_defer()
diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 2dde34560d65..824f039d384c 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -142,6 +142,7 @@ import time
 
 
 GLOBAL_DEFER_QUEUE = []
+GLOBAL_DEFER_ARMED = False
 
 
 class defer:
@@ -153,6 +154,8 @@ GLOBAL_DEFER_QUEUE = []
         self.args = args
         self.kwargs = kwargs
 
+        if not GLOBAL_DEFER_ARMED:
+            raise Exception("defer queue not armed, did you use defer() outside of a test case?")
         self._queue = GLOBAL_DEFER_QUEUE
         self._queue.append(self)
 
-- 
2.52.0


