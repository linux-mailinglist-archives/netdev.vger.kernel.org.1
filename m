Return-Path: <netdev+bounces-106722-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AA0E91758B
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 03:25:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D06CB282784
	for <lists+netdev@lfdr.de>; Wed, 26 Jun 2024 01:25:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FE1DF4D;
	Wed, 26 Jun 2024 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JMlzFozv"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F92CDDAD
	for <netdev@vger.kernel.org>; Wed, 26 Jun 2024 01:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719365101; cv=none; b=rzCEGhEOCCO3uxn2i38VjFbOCwxpk+pQ9HbSzA4lefqAkfs+GVVx6JAK6/F1PYx2CDbvgyNc2/WQ6TomErOr7OtJQll1O7MrTD1+hCqBPtva49b7TDFPrnlLNRL7XUXXpg38ck3E+2fnpabJIDDrDTE+1cSIyThkeU3lG4vbJSs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719365101; c=relaxed/simple;
	bh=qN3mpio02ZRaVSzTZqkedqx5ILlJEdXOqzuj0CxKCmA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ACsbdX1ZoE6pc6IOP8UCNtx9P3qurzEEdMoW5XnDbprXTAO5XCBc+G3l63XBpo3geSkodUFnCwuAp5ZFWGp63jg/0VF2BU8lIdt4tQANG2J+TMkSxZlwa4/sW7o0nIzrcFJEQEBSQrjqu4lWiV5/oge1mnlAKbKztAbt4ED2VtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JMlzFozv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8317DC4AF07;
	Wed, 26 Jun 2024 01:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719365101;
	bh=qN3mpio02ZRaVSzTZqkedqx5ILlJEdXOqzuj0CxKCmA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JMlzFozvfOyDCfU5rbnhdL7TId5sdCYVF00I9aQw8NHgEvb8ywSCK2i6OeWTgebxN
	 0RrwjkoWuWPIb8dlCi0GBIyQ0LlhoOUCMjtq/lxTsXlqvWKs0BY0NaXOhmi8tcI+Fc
	 j4T34lezPUc96iU3p2D0/eHjOp1fPr7oaTldnEB4tmUZthGE+syM2q+C13GPSmNbUe
	 zYPF2QvmNhHjcyzOTO50C7zxoVbV9BkVfZt5zGOulBc15MdP+piFxGBfOCdREuVz+d
	 NTv702oDQ/oi4QhQXJ52JjtIr6ezkri28oHztM5CIhL7lf4xeoCaOMLpqy/FyIP3RW
	 qebYxlKJYJztw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	willemdebruijn.kernel@gmail.com,
	ecree.xilinx@gmail.com,
	dw@davidwei.uk,
	przemyslaw.kitszel@intel.com,
	michael.chan@broadcom.com,
	andrew.gospodarek@broadcom.com,
	leitao@debian.org,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 1/4] selftests: drv-net: try to check if port is in use
Date: Tue, 25 Jun 2024 18:24:53 -0700
Message-ID: <20240626012456.2326192-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240626012456.2326192-1-kuba@kernel.org>
References: <20240626012456.2326192-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We use random ports for communication. As Willem predicted
this leads to occasional failures. Try to check if port is
already in use by opening a socket and binding to that port.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - use errno.EADDRINUSE (Breno)
v2:
 - remove v4 check (Willem)
 - update comment (David, Przemek)
 - cap the iterations (Przemek)
---
 tools/testing/selftests/net/lib/py/utils.py | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 0540ea24921d..dd9d2b9f2b20 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -1,8 +1,10 @@
 # SPDX-License-Identifier: GPL-2.0
 
+import errno
 import json as _json
 import random
 import re
+import socket
 import subprocess
 import time
 
@@ -79,9 +81,18 @@ import time
 
 def rand_port():
     """
-    Get unprivileged port, for now just random, one day we may decide to check if used.
+    Get a random unprivileged port, try to make sure it's not already used.
     """
-    return random.randint(10000, 65535)
+    for _ in range(1000):
+        port = random.randint(10000, 65535)
+        try:
+            with socket.socket(socket.AF_INET6, socket.SOCK_STREAM) as s:
+                s.bind(("", port))
+            return port
+        except OSError as e:
+            if e.errno != errno.EADDRINUSE:
+                raise
+    raise Exception("Can't find any free unprivileged port")
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.45.2


