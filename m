Return-Path: <netdev+bounces-283971-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MM7ECkHa+GnG2QIAu9opvQ
	(envelope-from <netdev+bounces-283971-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:21 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 24ADB4C202B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 19:41:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E9A69300A67F
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 17:41:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A9CE3E4C97;
	Mon,  4 May 2026 17:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iSq8SzfP"
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f171.google.com (mail-yw1-f171.google.com [209.85.128.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 955723E0C76
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 17:41:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777916468; cv=none; b=cg7zCqh3Knsjay4g/N2oZ6PZvFUWfjTPKI/etrh4zS0JvuYipprI3wuPcISn8T6F2wFnPXflXpiNyOgd1N8idC3uJ73wcvSgaphXGmCwgYJoowmzftZ1R71DwNU4tiJA5ZKfCW6dUOB4aq8uvN24gjARtN4tlaKkwY0Z3zCKVhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777916468; c=relaxed/simple;
	bh=yq71j9wctcNGytKHj/p59ys2+HWuYWPLuioDe7KxcfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q9f4WRIGGO/h399GiKI9BpBybw28lPD0q9Kbc3fH1B82GkFiEGU7/fK4rNiTNVogCsNsM4DOLwakOljy50uEFDCIzO8gMnDZjCVR4Xh/ZU9tXhH2C+FLWtAY5zfhhZAYvm/WwLbBBUx/imJ5FY/n+KuwlQ2f6mpFVyFOzAWFHeU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iSq8SzfP; arc=none smtp.client-ip=209.85.128.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f171.google.com with SMTP id 00721157ae682-794719afcd4so39700167b3.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 10:41:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777916466; x=1778521266; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eUIUmXE0+wLRQ6+GiVrpuUgnRpPQKDTF515rzrT7DLA=;
        b=iSq8SzfPKz0mX9YyftW9gtPz8BfmQzNheWMZIFgwq5nZjGUKEPccDtZQLss+xOo5QN
         vSWYynvrr6Je2RGD4wVLOM/haSA7OSaNlo/L2uJoqYIgtteNEcbgulf8ztZI7DDJfLUt
         cc6io303Ooz/FRQK7Mbz2NzPC15JGwDwgQKbKCTZYqWCjRlxiJyABisx8gEIqVrZzWDb
         Z1ckWWn9sMZnKT6VdP/mVknn9VO627zZxrjng2dGHZxh0V1vBfa1ANwsWijyrvR6RD9/
         wPdk9LnRvmuRiiLaxnLTYPCEvZJEgYb/EXQ/7RVQPGG/FJqqel8p2MLAGnmkCN2E+Jyc
         a/VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777916466; x=1778521266;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=eUIUmXE0+wLRQ6+GiVrpuUgnRpPQKDTF515rzrT7DLA=;
        b=Z8sANEPxdGetNXi6o3zINxTb4mLwbEWsO0Ag/Fm0sRGI6r05Uw2F5UfZkCyKYCM0tY
         GaNWGYAgLkM4NTV5Bxh2CYXnQZu/n/OwLeQbHoe2QAfncMujUprbRzO+leG7KKwCTxsZ
         ZI07LTa2aFJzIqVB8qnZzo/EX8hgk/9EL17szTlC5PerOdGTZyun0pSGj0owi8n4R0ZE
         IHJYbgRpRVB6yBFOnsvWQUjfKyI9jk9lrA3GOdE5mafiiBeGpjh1TBOHIyHvDuKMkcm6
         ChlGGlqyCgmqtuqVJF7jNpdci4ceaIpeXmAyQcdlgebvQYboUHpVpM2oFH/ss65dq7Se
         pppQ==
X-Gm-Message-State: AOJu0YyqY3Igxdg1t3vpzib0RP+7M4p0lXEEFt/9lVI0As56AZK7wAa+
	0kniX705wH4Bjw2RqLz0tohHpwFBwpuModzABw7WaE+S4rQSqOuM5ux03G7Xtg==
X-Gm-Gg: AeBDiesDM/bKUcEFA+vKL5aRM0Q/TWnP3ktXGMv97DeIWMlSefLwqgqRpf/iFBMlNK4
	rRUFtwnJqTBnoBbf6vBXdDAh/1YOjdFvHm2pj8ZwugFCw3ThHWdP+ucELK5ZqabM79ajJv94Vu5
	Q5IIbGSW8U2EOmhMa1cX8WPVDJIVHu/LeLBHMKHm9VtUV1F4zq05sXnz03aS1fBE/q+zpowWH+x
	uUPCBGDBgZLw5iEdmYoI32UgOH4O8mX9OO0K1NeJ7ldEgcy9IAD94hVqi+hDjk/EcsXF1MeYhUZ
	+PpvWbE60lZP7O7V/3mq77dyfm5KQevPBSD5wGJbyuwloby6RT/KHh5FyBP5Z90AwpXA6OFvbun
	G47GWh7Hr/XZe7rmda4J0LRuHomDZ9OQha84h900DOYvD4etFBT0H2jSSN4kSlXDaJY6UaoQ/ID
	b56yW/Es6ilfwRqAq8DswGaDZKRDGp0FMCjeW2TXP/fH3Yj695/00q/kJmpvFsddCMnqfK6PnrX
	iCJPb+32DeQhqFG4B8JnHWhfFwSHjj0FXG1dZv3owKxLL5n
X-Received: by 2002:a05:690c:c6cb:b0:7ba:f414:cd18 with SMTP id 00721157ae682-7bd7712f9f6mr78850767b3.41.1777916465601;
        Mon, 04 May 2026 10:41:05 -0700 (PDT)
Received: from willemb.c.googlers.com.com (172.235.85.34.bc.googleusercontent.com. [34.85.235.172])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6685d0cbsm51551767b3.35.2026.05.04.10.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 10:41:04 -0700 (PDT)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	horms@kernel.org,
	linux-kselftest@vger.kernel.org,
	shuah@kernel.org,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next v7 1/3] selftests: net: py: support cmd verifying expected failure
Date: Mon,  4 May 2026 13:38:32 -0400
Message-ID: <20260504174056.565319-2-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.54.0.545.g6539524ca2-goog
In-Reply-To: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
References: <20260504174056.565319-1-willemdebruijn.kernel@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 24ADB4C202B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-283971-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[willemdebruijnkernel@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

From: Willem de Bruijn <willemb@google.com>

Support negative tests, where cmd raises an exception if the command
succeeded.

Add optional argument expect_fail to cmd and bkg. Where fail fails the
test on unexpected error, expect_fail fails it on unexpected success.

Both fail on negative return code. Python subprocess may set a
negative return code on process crash or timeout. Those are never
anticipated failures.

Signed-off-by: Willem de Bruijn <willemb@google.com>

---

In this design fail and expect_fail are two complementary tests.
If both are set to true, an exception would always be raised.

This is contrast to the previous approach, where fail enables
fail_on_unexpected_returncode and expect_fail modifies what that
unexpected_returncode value range is.

---

v6 -> v7
  - convert from 'verify_failed' value for fail, to separate variable

v4 -> v5
  - initial version of standalone patch
---
 tools/testing/selftests/net/lib/py/utils.py | 39 +++++++++++++++------
 1 file changed, 29 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 6c44a3d2bbf7..b68d4607114d 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -23,6 +23,10 @@ class CmdExitFailure(Exception):
         self.cmd = cmd_obj
 
 
+class CmdExitZeroFailure(CmdExitFailure):
+    """ Command succeeded (returned zero exit code), but expected failure. """
+
+
 def fd_read_timeout(fd, timeout):
     rlist, _, _ = select.select([fd], [], [], timeout)
     if rlist:
@@ -39,8 +43,9 @@ class cmd:
 
     Use bkg() instead to run a command in the background.
     """
-    def __init__(self, comm, shell=None, fail=True, ns=None, background=False,
-                 host=None, timeout=5, ksft_ready=None, ksft_wait=None):
+    def __init__(self, comm, shell=None, fail=True, expect_fail=False, ns=None,
+                 background=False, host=None, timeout=5, ksft_ready=None,
+                 ksft_wait=None):
         if ns:
             comm = f'ip netns exec {ns} ' + comm
 
@@ -88,7 +93,8 @@ class cmd:
                     self._process_terminate(terminate=terminate, timeout=1)
                     raise CmdInitFailure("Did not receive ready message", self)
         if not background:
-            self.process(terminate=False, fail=fail, timeout=timeout)
+            self.process(terminate=False, fail=fail, expect_fail=expect_fail,
+                         timeout=timeout)
 
     def _process_terminate(self, terminate, timeout):
         if terminate:
@@ -102,7 +108,7 @@ class cmd:
 
         return stdout, stderr
 
-    def process(self, terminate=True, fail=None, timeout=5):
+    def process(self, terminate=True, fail=None, expect_fail=False, timeout=5):
         if fail is None:
             fail = not terminate
 
@@ -111,10 +117,19 @@ class cmd:
 
         stdout, stderr = self._process_terminate(terminate=terminate,
                                                  timeout=timeout)
-        if self.proc.returncode != 0 and fail:
+
+        # Fail on unexpected test failure if fail.
+        # Fail on unexpected test success if expect_fail.
+        # Fail on negative returncode if either:
+        # Set by subprocess on crash or signal, this is never expected failure.
+        if (self.proc.returncode != 0 and fail or
+            (self.proc.returncode < 0 and expect_fail)):
             if len(stderr) > 0 and stderr[-1] == "\n":
                 stderr = stderr[:-1]
             raise CmdExitFailure("Command failed", self)
+        elif self.proc.returncode == 0 and expect_fail:
+            raise CmdExitZeroFailure("Command succeeded (expected fail)", self)
+
 
     def __repr__(self):
         def str_fmt(name, s):
@@ -157,14 +172,17 @@ class bkg(cmd):
 
         with bkg("my_binary", ksft_wait=5):
     """
-    def __init__(self, comm, shell=None, fail=None, ns=None, host=None,
-                 exit_wait=False, ksft_ready=None, ksft_wait=None):
+    def __init__(self, comm, shell=None, fail=None, expect_fail=None,
+                 ns=None, host=None, exit_wait=False, ksft_ready=None,
+                 ksft_wait=None):
         super().__init__(comm, background=True,
-                         shell=shell, fail=fail, ns=ns, host=host,
-                         ksft_ready=ksft_ready, ksft_wait=ksft_wait)
+                         shell=shell, fail=fail, expect_fail=expect_fail,
+                         ns=ns, host=host, ksft_ready=ksft_ready,
+                         ksft_wait=ksft_wait)
         self.terminate = not exit_wait and not ksft_wait
         self._exit_wait = exit_wait
         self.check_fail = fail
+        self.expect_fail = expect_fail
 
         if shell and self.terminate:
             print("# Warning: combining shell and terminate is risky!")
@@ -179,7 +197,8 @@ class bkg(cmd):
         # since forcing termination silences failures with fail=None
         if self.proc.poll() is None:
             terminate = terminate or (self._exit_wait and ex_type is not None)
-        return self.process(terminate=terminate, fail=self.check_fail)
+        return self.process(terminate=terminate, fail=self.check_fail,
+                            expect_fail=self.expect_fail)
 
 
 GLOBAL_DEFER_QUEUE = []
-- 
2.54.0.545.g6539524ca2-goog


