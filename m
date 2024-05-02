Return-Path: <netdev+bounces-92883-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D3FE08B937A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 04:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 240D0B2244A
	for <lists+netdev@lfdr.de>; Thu,  2 May 2024 02:53:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DFAF917C6C;
	Thu,  2 May 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H+uNbO+4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B94BD17997
	for <netdev@vger.kernel.org>; Thu,  2 May 2024 02:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714618411; cv=none; b=E/CQaoqJxC8zPt5BV5p2Go7TAYyGBIcb0tY3mqM20/OnGshetitQKIPY4nLTw3M5iroP75ev3AtW3biJH6j6O5+/t7H9187a2ic+ESrfoQlUiSyYwIoJIto/BY2+wZz2ebcgwFGehwx47wrHHkMJ5E858JiSvVO5wvlCdRXkN4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714618411; c=relaxed/simple;
	bh=scmHOqGHqJ0UAas7fEBIoFdx+2tecWJvsMXP0AqyPFY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=X4jGiTDP6XXXcSp9wicheIqU+MLpJ+y1UXk8an3ZoGNQC8T13T12M7sf3aNfdwqv6rETwqc0CS0v9hQes1yd9qXKlFXx7otZXGMVLk0WB9bSrH5G2vXndqRHdutrbW3sf3SghS+fmWWtZiKWgEc5yUNUeQpcVYetMlv7eSyLe4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H+uNbO+4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D29C072AA;
	Thu,  2 May 2024 02:53:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714618411;
	bh=scmHOqGHqJ0UAas7fEBIoFdx+2tecWJvsMXP0AqyPFY=;
	h=From:To:Cc:Subject:Date:From;
	b=H+uNbO+46tPPKZvkZcdx3EiXsgbxc8fPS80/9nfG8BRKZnXtfWDUEq3lHXQDcWDV6
	 GBBwdNBNwLg2juQ6Q6dejvuZcf48lk1Z184Jt+0QLqo2xmcRlamC8XmpR1qspN554W
	 khIOLiWRh7Kpps5B2zMNwzW2mSiWxNWpTqe6dGFJe0s60Ka4inDjR68QAXJkB6kCR+
	 gaxIYzcQX6Z4d7w7spuZJHKe5abUdbvy+Bt3bCmrpMU1UOigSVSZgWs45FNq1HDjSl
	 SnoZ7uJWN5ktvq9VO3a6lHpPG74gG7S/LXJAqGDTJBlwtd3/pIvB/DWXeiCyLUUFuz
	 dO0/Rz+1AljtQ==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	Jakub Kicinski <kuba@kernel.org>,
	Willem de Bruijn <willemb@google.com>
Subject: [PATCH net-next] selftests: net: py: check process exit code in bkg() and background cmd()
Date: Wed,  1 May 2024 19:53:25 -0700
Message-ID: <20240502025325.1924923-1-kuba@kernel.org>
X-Mailer: git-send-email 2.44.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We're a bit too loose with error checking for background
processes. cmd() completely ignores the fail argument
passed to the constructor if background is True.
Default to checking for errors if process is not terminated
explicitly. Caller can override with True / False.

For bkg() the processing step is called magically by __exit__
so record the value passed in the constructor.

Reported-by: Willem de Bruijn <willemb@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index b57d467afd0f..ec8b086b4fcb 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -26,6 +26,9 @@ import time
             self.process(terminate=False, fail=fail)
 
     def process(self, terminate=True, fail=None):
+        if fail is None:
+            fail = not terminate
+
         if terminate:
             self.proc.terminate()
         stdout, stderr = self.proc.communicate(timeout=5)
@@ -43,17 +46,18 @@ import time
 
 
 class bkg(cmd):
-    def __init__(self, comm, shell=True, fail=True, ns=None, host=None,
+    def __init__(self, comm, shell=True, fail=None, ns=None, host=None,
                  exit_wait=False):
         super().__init__(comm, background=True,
                          shell=shell, fail=fail, ns=ns, host=host)
         self.terminate = not exit_wait
+        self.check_fail = fail
 
     def __enter__(self):
         return self
 
     def __exit__(self, ex_type, ex_value, ex_tb):
-        return self.process(terminate=self.terminate)
+        return self.process(terminate=self.terminate, fail=self.check_fail)
 
 
 def tool(name, args, json=None, ns=None, host=None):
-- 
2.44.0


