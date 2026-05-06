Return-Path: <netdev+bounces-284616-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKEUNy2G+mlIPgMAu9opvQ
	(envelope-from <netdev+bounces-284616-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E9504D4E57
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 02:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DB37E3021BD0
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 00:06:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE14F1F4180;
	Wed,  6 May 2026 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lRkxLM81"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 893581EFFB7;
	Wed,  6 May 2026 00:06:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778025996; cv=none; b=EpRdxqKwazizj9KT7J+15F/WbAHStYF3l4OCK81cqtT9i9aPfUcI7AyqIJFyA6dRSti5EAqZSvqkQ8iHhjsPqoiov0VNMbjVsOJ6XTvxgv3LgAf1837hUMRLSNIlC7qXDDdlufyeCOrya6OXmRqgNtuQPug0Y1PX9kXBUk2qdBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778025996; c=relaxed/simple;
	bh=Z0AVOCyve9aKFf5RrBlLFF6R2YtL0TWMVzfni9CEWKc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sL+BMo5Obof+zdpA+GAC0JBCxGayiB2hDOJ3k8+dFKhf8uGAia85NcPPhxYURx9GP8HtKtvFDU0f9kLNqUBhGsmWeAL408ACHuLfkqW3uRb46iuH2hcFYf84cZ5pDKkqE17JEokRnOWPuX7BGVeqoqEMK26Twe2i0CkVDPXvph4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lRkxLM81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1265C2BCC9;
	Wed,  6 May 2026 00:06:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778025996;
	bh=Z0AVOCyve9aKFf5RrBlLFF6R2YtL0TWMVzfni9CEWKc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lRkxLM81HGBob5W2VcUAFzJ6KoSwcctnYRAilga3qz/wCi2nWukDxu5bgnR2m2ZpH
	 RRhjeqXuKKqw21+6O9ptoRFsNJK/nRA7FOHj16osAbx670f3kstyDFWajKDZJ4LpYy
	 Ee1RnQmjhgilFvfeXb4nogUnn/JNJrAgII1xpnrTNhFAEGV14MY1+2fBd/MijuwOcT
	 Lh5bjXmKJrpLqT5eCiSXg5TWT0u3SwsDJzSh8QSDUj7xR+nFmOO8vhhc+vE2D813ib
	 /6JdKINtq2orrIlNfr9f2SG8LQ+PaOg7n1BbLl3wIOzu7yBu0dBkFPRRtMGqGeHQKL
	 XdcnjtZCf54dg==
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
Subject: [PATCH net 06/12] selftests: drv-net: add shaper test for duplicate leaves
Date: Tue,  5 May 2026 17:06:22 -0700
Message-ID: <20260506000628.1501691-7-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260506000628.1501691-1-kuba@kernel.org>
References: <20260506000628.1501691-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7E9504D4E57
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284616-lists,netdev=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add test exercising duplicate leaves.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/drivers/net/shaper.py | 25 +++++++++++++++++--
 1 file changed, 23 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/drivers/net/shaper.py b/tools/testing/selftests/drivers/net/shaper.py
index 11310f19bfa0..f7872c931bf6 100755
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
@@ -453,7 +471,10 @@ from lib.py import cmd
                   basic_groups,
                   qgroups,
                   delegation,
-                  queue_update], args=(cfg, NetshaperFamily()))
+                  queue_update,
+                  dup_leaves
+                  ],
+                 args=(cfg, NetshaperFamily()))
     ksft_exit()
 
 
-- 
2.54.0


