Return-Path: <netdev+bounces-260184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KI07Dye4nGkqKAQAu9opvQ
	(envelope-from <netdev+bounces-260184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:27:19 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id D922D17CE53
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 21:27:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 89336305C320
	for <lists+netdev@lfdr.de>; Mon, 23 Feb 2026 20:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D18903783AF;
	Mon, 23 Feb 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oASH/iOE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2A3377559;
	Mon, 23 Feb 2026 20:27:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771878420; cv=none; b=SFlLaCrYZPfHSeaXlIMUH1N3iFgqvlBiM+PXx2Lbm8i3oKFpekT6oxI710Ki4qDeAOC5PvN/RCZDwkLs5R1xl0XZLj5is0MBjuKdSEtEjeaT0Q+mxlvI3hgCd4oOsRxPwUoFBnXf1JG/xYIiw7AKC/osZhs1+yGqT5D+YbuyMeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771878420; c=relaxed/simple;
	bh=G3U9BdKgArmchpFnK8wJ2/DfL5QW5pdAHrflPy8ADYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LM8A3nWXhOzIiCr8YRz/RHF5xWj4Tioa26mP0gIgndmR11KrZR2RVobl3W71iXgsiDf34IW3nm4ryR5w4DKEbvGbc4yEfHXUqATwiFSNDeyDzrfjsnZiz/Y5Kbs8lOf3B+97TrIMky++OEYAhPWs2gvutFtrz9VQvgbqyNT1e78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oASH/iOE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C657FC116C6;
	Mon, 23 Feb 2026 20:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771878420;
	bh=G3U9BdKgArmchpFnK8wJ2/DfL5QW5pdAHrflPy8ADYE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oASH/iOEhg5nBm1ngt/qjx3p4orL6uPjYNkadIcDaUFKw7E7rG1ebDdcczcDCcpzP
	 FFZUwN/kw7bafhoI5e0PQCwtZA+UX3E4kgUlMQJPNTCooUjTxZdN3KSVD+GhD5iW/6
	 m4/S0780T9rFy6HfXLjjujUc0lezvDta5+Vr0gM3YmpiIli76XcTk2QjUtwYgDiG37
	 WEYpFV26bvM6wzXfKT6+Ec3MLbWMNPlHQIAPBmNwgYumyjZlmjguQotZ9rjRV7N1LS
	 x2WQyOGifA+0VtOhv4380prkfEhZP0frl1BGKvLjz3RXV5K6fDRnvRUVbH1aM8YDQL
	 I2YCU0dzSD2DQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	petrm@nvidia.com,
	gal@nvidia.com,
	leitao@debian.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 1/3] selftests: net: py: avoid masking exceptions in bkg() failures
Date: Mon, 23 Feb 2026 12:26:31 -0800
Message-ID: <20260223202633.4126087-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260223202633.4126087-1-kuba@kernel.org>
References: <20260223202633.4126087-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-260184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D922D17CE53
X-Rspamd-Action: no action

bkg() failures are currently quite hard to debug and spot.
Often we have code along the lines of:

  with bkg("./cmd_rx_something -p PORT"):
       wait_port_listen(PORT)
       cmd("./cmd_tx_something", host=remote)

When wait_port_listen() fails we don't get to see the exit status
of bkg(). Even tho very often it's a failure in the bkg() command
that's actually to blame. Try not to interfere with the bkg()
command error checking.

With:

   with bkg("false", exit_wait=True):
        time.sleep(0.01)  # let the 'false' cmd run
        raise Exception("bla")

Before:

  .. stack trace ..
  # Exception| Exception: bla

After:

  .. stack trace ..
  # Exception| Exception: bla
  # Exception|
  # Exception| During handling of the above exception, another exception occurred:
  .. stack trace ..
  # Exception| lib.py.utils.CmdExitFailure: Command failed: false
  # Exception| STDOUT: b''
  # Exception| STDERR: b''

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 85884f3e827b..8fa1c2fabfc2 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -159,8 +159,11 @@ import time
         return self
 
     def __exit__(self, ex_type, ex_value, ex_tb):
-        # Force termination on exception
-        terminate = self.terminate or (self._exit_wait and ex_type is not None)
+        terminate = self.terminate
+        # Force termination on exception, but only if bkg() didn't already exit
+        # since forcing termination silences failures with fail=None
+        if self.proc.poll() is None:
+            terminate = terminate or (self._exit_wait and ex_type is not None)
         return self.process(terminate=terminate, fail=self.check_fail)
 
 
-- 
2.53.0


