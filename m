Return-Path: <netdev+bounces-184470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 23BC0A9596E
	for <lists+netdev@lfdr.de>; Tue, 22 Apr 2025 00:30:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D90A93B52EC
	for <lists+netdev@lfdr.de>; Mon, 21 Apr 2025 22:29:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A081522C35E;
	Mon, 21 Apr 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hUFLJbza"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C7BC22B8DB
	for <netdev@vger.kernel.org>; Mon, 21 Apr 2025 22:28:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745274527; cv=none; b=DpwEKsUPvxuUJBCc96XaIJimJtIreTSm6sIN9nmT8wuCLyqJqHmQtGSW7FPjcghjk55cciE99HIOE2C9pn2OQjOtLw2O1RvnjQDWrK+qNyeybkkWe+OhRB3vm71Blzc4S1FE/wF4UBWv68TUaZrc77IXfU5S5+TkeG2JutMvIlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745274527; c=relaxed/simple;
	bh=g0X22CIPu9a1gBIdq+JC3XUWfmAb3yHPt0FusfwHCog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=prR78wQDLjp06MRHov6IvOlzre8RGDVGElxEaNc37TgXJj2fTYlG9zPcQXxQO1NY5UT/X13VZqfkY2J/Lx03zyoB2Qj+koXAkKNO6v2FskjYOYR5lC5/X+lBtXEa2s0JlklyuUAglvOSOdTJ7QwpAsTruarYOYTFXVQIiGzI9bY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hUFLJbza; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5101C4CEEF;
	Mon, 21 Apr 2025 22:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745274527;
	bh=g0X22CIPu9a1gBIdq+JC3XUWfmAb3yHPt0FusfwHCog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hUFLJbzaH/dp3+BRAdLwCyT5eipDTCfnFbve/LE3HHg157WiVmIHd3vAdeO6E29EC
	 1QM2jguFPiION5eq1m5/aPXx2VXtguaHXvlthHBzk9S5MOFgIKirJHVjroUirTmnuZ
	 ycF8C4HcUCj4vEM/AWUdWDBABLIsKGCgM/JkzuXNI3RSLiOppCu7HX60hirQuOqeKL
	 qqZE3+DlYrsVbadydTgaikmAPBW4zTqFpq3HOvLHLxaZx6Xgvw4HBsSwE8s4mBnIfS
	 OsnFrwOPp99Qn511/tgLRd7jpBxUYWT9Tc3wekRsMFJZr4fWbnZpRCZf/KZ9RESHjq
	 GM6OTg5Plbr+Q==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	sdf@fomichev.me,
	almasrymina@google.com,
	dw@davidwei.uk,
	asml.silence@gmail.com,
	ap420073@gmail.com,
	jdamato@fastly.com,
	dtatulea@nvidia.com,
	michael.chan@broadcom.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [RFC net-next 21/22] selftests: drv-net: add helper/wrapper for bpftrace
Date: Mon, 21 Apr 2025 15:28:26 -0700
Message-ID: <20250421222827.283737-22-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250421222827.283737-1-kuba@kernel.org>
References: <20250421222827.283737-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bpftrace is very useful for low level driver testing. perf or trace-cmd
would also do for collecting data from tracepoints, but they require
much more post-processing.

Add a wrapper for running bpftrace and sanitizing its output.
bpftrace has JSON output, which is great, but it prints loose objects
and in a slightly inconvenient format. We have to read the objects
line by line, and while at it return them indexed by the map name.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/lib/py/utils.py | 33 +++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/tools/testing/selftests/net/lib/py/utils.py b/tools/testing/selftests/net/lib/py/utils.py
index 34470d65d871..760ccf6fcccc 100644
--- a/tools/testing/selftests/net/lib/py/utils.py
+++ b/tools/testing/selftests/net/lib/py/utils.py
@@ -185,6 +185,39 @@ global_defer_queue = []
     return tool('ethtool', args, json=json, ns=ns, host=host)
 
 
+def bpftrace(expr, json=None, ns=None, host=None, timeout=None):
+    """
+    Run bpftrace and return map data (if json=True).
+    The output of bpftrace is inconvenient, so the helper converts
+    to a dict indexed by map name, e.g.:
+     {
+       "@":     { ... },
+       "@map2": { ... },
+     }
+    """
+    cmd_arr = ['bpftrace']
+    # Throw in --quiet if json, otherwise the output has two objects
+    if json:
+        cmd_arr += ['-f', 'json', '-q']
+    if timeout:
+        expr += ' interval:s:' + str(timeout) + ' { exit(); }'
+    cmd_arr += ['-e', expr]
+    cmd_obj = cmd(cmd_arr, ns=ns, host=host, shell=False)
+    if json:
+        # bpftrace prints objects as lines
+        ret = {}
+        for l in cmd_obj.stdout.split('\n'):
+            if not l.strip():
+                continue
+            one = _json.loads(l)
+            if one.get('type') != 'map':
+                continue
+            for k, v in one["data"].items():
+                ret[k] = v
+        return ret
+    return cmd_obj
+
+
 def rand_port(type=socket.SOCK_STREAM):
     """
     Get a random unprivileged port.
-- 
2.49.0


