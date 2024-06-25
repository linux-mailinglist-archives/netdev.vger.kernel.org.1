Return-Path: <netdev+bounces-106298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AB36E915B73
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 03:03:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D99061C2182C
	for <lists+netdev@lfdr.de>; Tue, 25 Jun 2024 01:03:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4F42168B7;
	Tue, 25 Jun 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="klAZSoAJ"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A184314F90
	for <netdev@vger.kernel.org>; Tue, 25 Jun 2024 01:02:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719277336; cv=none; b=srKj8uZlkciMkjYOjlX5H6/TRdtm633sMw6zgIG6lha4dg7hnno61W4KiDQuPBxWVDUjKC7SwuGa3x9FROirZyq4Or0rnf4BkqbC0ReYIHrwyxWjFCudn2x+T34LyhCyVdUuEkVf2xPpeb/QZ96H1mqIIYj2lyD869/B7b4tLhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719277336; c=relaxed/simple;
	bh=UZLpIt9v/JaLsv8C56SS9odPop5WCz+Ct7WzDHvHfwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FPesZzXQufY2qngF8PAMsFYhzp0L+boq55PWbZbk3h+tHqg80veYeotPJgDG0ZzhOvzLdGIqdOpVKAveO2A5dZCqxEvILxqWLIX2Bd9sP1jILoT4KbXZOZzHpuckpEgFsE9WnCFU0Tu/DEXqRMnCO9O2+g1jANgtFza8c6CjcsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=klAZSoAJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2101C4AF09;
	Tue, 25 Jun 2024 01:02:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719277336;
	bh=UZLpIt9v/JaLsv8C56SS9odPop5WCz+Ct7WzDHvHfwI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=klAZSoAJxqn+Iz3HTLtnZIsDrl/Pl6CASlNaXp1c+gcwX4BvwwuIio6aQbA+fj1nR
	 R5/y1zymgdlcB8QRSU5x6IWeA7IBW6n22QS4d8aRpM+GXvwtU+MfZ4fXBW+yjpyrce
	 izSMGMOPrnsqDlwPwuNuZuy1W4vCqm9dmtwozeuz1EDg7xAnUVwMLkbfD14+yjSR20
	 NP5+jd3H2G8qXAXjT1kvPvCaHJzqS231ELM3LWSyPdNNje6lOTbup7SNYHm9Fe9qPX
	 oDFZB69TEel7jLzfzfx54N+w2nmIcNfu2WmLJRb3GPdpTzPLfiwfjVbOXzLouijLgM
	 M5u1gCa/oTCyg==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 1/4] selftests: drv-net: try to check if port is in use
Date: Mon, 24 Jun 2024 18:02:07 -0700
Message-ID: <20240625010210.2002310-2-kuba@kernel.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240625010210.2002310-1-kuba@kernel.org>
References: <20240625010210.2002310-1-kuba@kernel.org>
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

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - remove v4 check (Willem)
 - update comment (David, Przemek)
 - cap the iterations (Przemek)
---
 tools/testing/selftests/net/lib/py/utils.py | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 0540ea24921d..16907b51e034 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -3,6 +3,7 @@
 import json as _json
 import random
 import re
+import socket
 import subprocess
 import time
 
@@ -79,9 +80,18 @@ import time
 
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
+            if e.errno != 98:  # already in use
+                raise
+    raise Exception("Can't find any free unprivileged port")
 
 
 def wait_port_listen(port, proto="tcp", ns=None, host=None, sleep=0.005, deadline=5):
-- 
2.45.2


