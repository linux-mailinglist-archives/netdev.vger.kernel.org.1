Return-Path: <netdev+bounces-286388-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cNgENcTcAGoXNwEAu9opvQ
	(envelope-from <netdev+bounces-286388-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:30:12 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AE57505FBB
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 21:30:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E70C030238CA
	for <lists+netdev@lfdr.de>; Sun, 10 May 2026 19:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5DE33122D;
	Sun, 10 May 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DI/WKJbL"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A93230E0FB;
	Sun, 10 May 2026 19:29:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778441351; cv=none; b=THM9lGJqe0JnyOax28iam9wq0QCkh7b/j245275gEdjiQBe2vNRAH3tgcF9ba6gBhRMzmKOR5gtH6kxI/Kl7EQ1eC7pPViGbQNWGtQIheAR4bjSbfq94jRegDwQ3OI3mvSqR0ajeUDEQu/NkksiXMh5LRJH+ifZ5iTXEGTKYOu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778441351; c=relaxed/simple;
	bh=ulH3VHS2YbgcvT8ePyIjSHRGnYpsHGT6k+KARYDWE5E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DgxzFvUTVc7B4kOp8SW3RWVr9CYuzCBcF48kXo0aIfr7/gKbhR2UllBXuUyy4RfiBwYa4KoTEK3+Bco3XaR3z09GE1FRVze9wKnwClx1+z15uQKB7sbzzY33n09qP354z02ucYkB7qhxptaBwJaiWBocL+hCnJOwlb3qIQsmL6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DI/WKJbL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC94C32781;
	Sun, 10 May 2026 19:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778441350;
	bh=ulH3VHS2YbgcvT8ePyIjSHRGnYpsHGT6k+KARYDWE5E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DI/WKJbL/kbw/Opa3tMEZNA8Lx0PTvTEwgfkvCT7X4cXrmTHV6VOktasP9z56SAzg
	 c+HMpzOT2O10d7OaWvE0+pUDI6BRM4Gbqk7+xG8FaLfWqsTjwYRf0CgAEeJ6QoDPGt
	 Ju4LAwVqDwi9ptc64mQVKx8EgSB2KouOuWk+7TQESy2WgkNGCYVcGiTOgDnQKNl4II
	 eJJSqdtkAaD0W7Yvo3S/zNHqUWP1TnC3ZIqi4E2qrL8nB9oofafEnkULn5RUGZLCJ6
	 dlCTpTwJra2B+2FErsLxZb0LL2Hy4yuTR9UtO/y8WMlrKL3d/TE2+e7oSOvmyK9u9L
	 ndL8BoJy5BrUA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net v2 04/10] selftests: drv-net: add shaper test for duplicate leaves
Date: Sun, 10 May 2026 12:28:58 -0700
Message-ID: <20260510192904.3987113-5-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260510192904.3987113-1-kuba@kernel.org>
References: <20260510192904.3987113-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 2AE57505FBB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-286388-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.980];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add test exercising duplicate leaves.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/shaper.py | 24 +++++++++++++++++--
 1 file changed, 22 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 11310f19bfa0..e39d270e688d 100755
--- a/tools/testing/selftests/drivers/net/shaper.py
+++ b/tools/testing/selftests/drivers/net/shaper.py
@@ -1,7 +1,10 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-from lib.py import ksft_run, ksft_exit, ksft_eq, ksft_true, KsftSkipEx
+import errno
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_raises, ksft_true, KsftSkipEx
 from lib.py import EthtoolFamily, NetshaperFamily
 from lib.py import NetDrvEnv
 from lib.py import NlError
@@ -438,6 +441,21 @@ from lib.py import cmd
         nl_shaper.delete({'ifindex': cfg.ifindex,
                           'handle': {'scope': 'queue', 'id': i}})
 
+def dup_leaves(cfg, nl_shaper) -> None:
+    """ Ensure that the kernel rejects duplicate leaves. """
+    if not cfg.groups:
+        raise KsftSkipEx("device does not support node scope")
+
+    with ksft_raises(NlError) as cm:
+        nl_shaper.group({
+                   'ifindex': cfg.ifindex,
+                   'leaves':[{'handle': {'scope': 'queue', 'id': 0}},
+                             {'handle': {'scope': 'queue', 'id': 0}}],
+                   'handle': {'scope':'node'},
+                   'metric': 'bps',
+                   'bw-max': 10000})
+    ksft_eq(cm.exception.error, errno.EINVAL)
+
 def main() -> None:
     with NetDrvEnv(__file__, queue_count=4) as cfg:
         cfg.queues = False
@@ -453,7 +471,9 @@ from lib.py import cmd
                   basic_groups,
                   qgroups,
                   delegation,
-                  queue_update], args=(cfg, NetshaperFamily()))
+                  dup_leaves,
+                  queue_update],
+                 args=(cfg, NetshaperFamily()))
     ksft_exit()
 
 
-- 
2.54.0


