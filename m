Return-Path: <netdev+bounces-167928-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B4169A3CDD8
	for <lists+netdev@lfdr.de>; Thu, 20 Feb 2025 00:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94E931892EE5
	for <lists+netdev@lfdr.de>; Wed, 19 Feb 2025 23:50:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 72B5E262D26;
	Wed, 19 Feb 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MzG/R12I"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA7625E479
	for <netdev@vger.kernel.org>; Wed, 19 Feb 2025 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740009009; cv=none; b=kYDeAo/yiUvyCiZwQ3J4Mp1KjLu4IYYjVh618TNq47kFKrLLtKcmUhyvg7+9yI6A6GaEzrbjNDD6/ujA+VgkTdRMIZKXVI08mZw3jL/xdpSamKKJASPFkrt5xaCrZDAkQDBxYy17jhySQS0ZzhB/ALP8fxhxrEPO86vHz206YO0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740009009; c=relaxed/simple;
	bh=K92hjK5SPjER4n4Havay7VhRL//p46mV6wd8UCB7zOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rhz+MazErtJWucO6fApQYjT9uw/gJgmeQmezS/pCyEku8uJBA0lAJ13XIuGQjxCmUWIi5lWqNHPHeiXMlyyjHK0TZUoEfA3lklOP1z4yHq2myhAkFN49Wp17FI5zEv3I0BDqxXAO8IwDYUCrOPvQ+I6ntUj5L3sCe1K4W52jAGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MzG/R12I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC7A6C4CEE8;
	Wed, 19 Feb 2025 23:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740009009;
	bh=K92hjK5SPjER4n4Havay7VhRL//p46mV6wd8UCB7zOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MzG/R12Ia4lk7X9hQl/FcBQygZ9id5Sb/lvfJQ7uC9zRDzf4lJiRu8ZNpGdyaeCVk
	 LrEAUEEVD/N2e15pAlN/wVGBshyDKwyP833kM89LgyfKKaypAWrX2khOJDKGFwYB/W
	 P7X5PdujcokFt9l5laYXpX6oS40+rMvpKxaT42E3FuYWT7Chb926qqG1QHO+mtNpgN
	 f1Uu//2pIKlpvyKIpKJ05W44ufxICs61/noRbRwOsdqhdhipKWzcHh+zZgAmSxiz7n
	 iSKYf2EVo1z9zH7PgblamFBx5KFhuUgDkxXrD/Sf3FeoBaK47qIDvxBg4wK+NSmqdw
	 rJa+gspc6hfJg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	jdamato@fastly.com,
	stfomichev@gmail.com,
	petrm@nvidia.com,
	Jakub Kicinski <kuba@kernel.org>,
	Stanislav Fomichev <sdf@fomichev.me>
Subject: [PATCH net-next v2 6/7] selftests: drv-net: improve the use of ksft helpers in XSK queue test
Date: Wed, 19 Feb 2025 15:49:55 -0800
Message-ID: <20250219234956.520599-7-kuba@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219234956.520599-1-kuba@kernel.org>
References: <20250219234956.520599-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid exceptions when xsk attr is not present, and add a proper ksft
helper for "not in" condition.

Acked-by: Stanislav Fomichev <sdf@fomichev.me>
Reviewed-by: Joe Damato <jdamato@fastly.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/queues.py | 9 +++++----
 tools/testing/selftests/net/lib/py/ksft.py    | 5 +++++
 2 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/queues.py b/tools/testing/selftests/drivers/net/queues.py
index 7af2adb61c25..a49f1a146e28 100755
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
@@ -47,10 +47,11 @@ import struct
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


