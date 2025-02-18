Return-Path: <netdev+bounces-167497-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E3F65A3A803
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 20:51:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 249373B0F13
	for <lists+netdev@lfdr.de>; Tue, 18 Feb 2025 19:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF33F1EFFAB;
	Tue, 18 Feb 2025 19:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Jof+9IZn"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4521E832E
	for <netdev@vger.kernel.org>; Tue, 18 Feb 2025 19:50:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739908253; cv=none; b=nV/ikoo0QfiXLcdVQqZ7hprjeZe2NxjRYXrfyp7VMjta3lJoZKB0J1P5+SgKqzHomK1taTBy1peK7BhmMMN2xVDsDl3294zXamB4WsykctIdNpheElpLb5f+zDASFYHqhvYJM8xGTKnTi89JPpIPKnd8SaWNgwuPA/yRk5LAej0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739908253; c=relaxed/simple;
	bh=ThG0dV5MKZ0gz/xCB2SUcKtAR34/tyzNv6eRpmHVCzc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ckEFQiqiA1ehAs3tedB+hBGbBpX/pvqKxt2+6mShKpOhsu8yo/n577WNsgnfTJH8Y5b9/78JsYKeJLm+PtI+MUUV7PYCV96ana3WocwLG9CDqKs4otypuUdPYoHpw2HSPPgsf7Z+H0ThV/NYvYExbG3X2pCjpTVzd4DfRQz+bIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Jof+9IZn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B41E1C4CEEA;
	Tue, 18 Feb 2025 19:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739908252;
	bh=ThG0dV5MKZ0gz/xCB2SUcKtAR34/tyzNv6eRpmHVCzc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Jof+9IZnpuxsYrHIxPN6Wk6lxcQ16Y6bXNijGXmcHIKdfYbLoOkeYmVZ8pNEf9qkB
	 ZSYOcf4jmXKR1aqjyKvCccEUUGFj9EoXnG+5wY8PPI098Ime1eA8QCKno7/GYMD69s
	 4htZ4RXxHBBGO120m8c2zZuxYqo+scQ1J7w5M24L0/wjdC/D2EZQdJGZWHPvZOYrPF
	 /WJfEQLKvSkWLx5+OzlOIHfUSntCwQwlpiAsy5h+4H2XLF5kefkmSGyVWspCn5e7US
	 +Gkq4LrWRvyibvL1B82YmRjC3SiULxML+m/yUgCVZDIu5eqfQEd6k6Lf5PL8LNqABj
	 E6TaoHS6z1bUw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	hawk@kernel.org,
	petrm@nvidia.com,
	jdamato@fastly.com,
	willemdebruijn.kernel@gmail.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 3/4] selftests: drv-net: improve the use of ksft helpers in XSK queue test
Date: Tue, 18 Feb 2025 11:50:47 -0800
Message-ID: <20250218195048.74692-4-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250218195048.74692-1-kuba@kernel.org>
References: <20250218195048.74692-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid exceptions when xsk attr is not present, and add a proper ksft
helper for "not in" condition.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/queues.py | 9 +++++----
 tools/testing/selftests/net/lib/py/ksft.py    | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 91e344d108ee..3cbcbaf5eaeb 100755
--- a/tools/testing/selftests/drivers/net/queues.py
+++ b/tools/testing/selftests/drivers/net/queues.py
@@ -2,7 +2,7 @@
 # SPDX-License-Identifier: GPL-2.0
 
 from lib.py import ksft_disruptive, ksft_exit, ksft_run
-from lib.py import ksft_eq, ksft_raises, KsftSkipEx, KsftFailEx
+from lib.py import ksft_eq, ksft_not_in, ksft_raises, KsftSkipEx, KsftFailEx
 from lib.py import EthtoolFamily, NetdevFamily, NlError
 from lib.py import NetDrvEnv
 from lib.py import bkg, cmd, defer, ip
@@ -40,10 +40,11 @@ import struct
                 if q['type'] == 'tx':
                     tx = True
 
-                ksft_eq(q['xsk'], {})
+                ksft_eq(q.get('xsk', None), {},
+                        comment="xsk attr on queue we configured")
             else:
-                if 'xsk' in q:
-                    _fail("Check failed: xsk attribute set.")
+                ksft_not_in('xsk', q,
+                            comment="xsk attr on queue we didn't configure")
 
         ksft_eq(rx, True)
         ksft_eq(tx, True)
diff --git a/tools/testing/selftests/net/lib/py/ksft.py b/tools/testing/selftests/net/lib/py/ksft.py
index 3efe005436cd..fd23349fa8ca 100644
--- a/tools/testing/selftests/net/lib/py/ksft.py
+++ b/tools/testing/selftests/net/lib/py/ksft.py
@@ -71,6 +71,11 @@ KSFT_DISRUPTIVE = True
         _fail("Check failed", a, "not in", b, comment)
 
 
+def ksft_not_in(a, b, comment=""):
+    if a in b:
+        _fail("Check failed", a, "in", b, comment)
+
+
 def ksft_is(a, b, comment=""):
     if a is not b:
         _fail("Check failed", a, "is not", b, comment)
-- 
2.48.1


