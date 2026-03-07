Return-Path: <netdev+bounces-265176-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDNeHjKOrGkYqwEAu9opvQ
	(envelope-from <netdev+bounces-265176-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:44:34 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F1222D8C1
	for <lists+netdev@lfdr.de>; Sat, 07 Mar 2026 21:44:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 130343016264
	for <lists+netdev@lfdr.de>; Sat,  7 Mar 2026 20:44:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74653374747;
	Sat,  7 Mar 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EoNCPlCA"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51C8336D4FC;
	Sat,  7 Mar 2026 20:44:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772916271; cv=none; b=Ruu3smn44fR38uGxSLy/qA0CIqs5grE7IYt9AMj9Z1U5EQf+z0oposOwPmavETU72jBC6FC9nc6ORHEngLaHgX1beuTqPwcEivyilnPc3+ZlvJ3FRKL2goBb+/5VPyWufFDVwp7Ph/kgqL5VcKZYZv8QDYXcFx0huE/RcqZyE4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772916271; c=relaxed/simple;
	bh=ATuLAR1sfOT/I7RRK0Fh5KcHBOQUGFu6jWdlyU5vu1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YQwvnxeTP3AbgOwqpw+rPsJv50/E6ftPF3IXmQltZzZGDk91fHZNjEl+/3M5ErwQnUSCNpAqI/CAiBYs5hAcu1R7jlYmDIopqlVX66VsTtSYC7sxzWoH5x9yKMLSzf/dRYNediiWCgNKgTeixOZbQ0I9SjOSAz+cPPDvDeokcLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EoNCPlCA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D31C2BC87;
	Sat,  7 Mar 2026 20:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772916270;
	bh=ATuLAR1sfOT/I7RRK0Fh5KcHBOQUGFu6jWdlyU5vu1I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EoNCPlCAH0+pZmiybC2lFiBmedFQmqkY3HqfRZvg54o2fISYf6JAcY1NR/uhROG0S
	 6Q5gT22LDssppeg3me6Q7mTG94IvgKY99zht1q3Gih8do7Z0fyKVp2hCFeRdFZh24R
	 +j6vGsQdzkdLvRKGLRSZqpMIfTYUMvMk0dDB9FVxFWRDtN2uvoTXjAO96LQLsttSU/
	 PijEricOAmYFXRP5VxLgzS1zNOGEundMMOG2XSOu52zDPKRddaF2IRDprJLP8iCB/0
	 7PHjHclmjkneuH5bkYSQF+fxdOdEF8dEfium96CZFqJTLB7Bf6KjaRuuncwARWiy6X
	 AEGZah0i1ubgw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	shuah@kernel.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next 2/2] selftests: net: make sure that Netlink rejects unknown attrs in dump
Date: Sat,  7 Mar 2026 12:44:25 -0800
Message-ID: <20260307204425.1900467-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260307204425.1900467-1-kuba@kernel.org>
References: <20260307204425.1900467-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 00F1222D8C1
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-265176-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,lib.py:url]
X-Rspamd-Action: no action

Add a test case for rejecting attrs if policy is not set.
dev_get dump has no input policy (accepts no attrs).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/nl_netdev.py | 33 +++++++++++++++++++-----
 1 file changed, 27 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 5c66421ab8aa..e3bebd8b5d35 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -1,11 +1,15 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
 
-import time
+"""
+Tests for the netdev netlink family.
+"""
+
+import errno
 from os import system
-from lib.py import ksft_run, ksft_exit, ksft_pr
-from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_busy_wait
-from lib.py import NetdevFamily, NetdevSimDev, ip
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
+from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
 
 
 def empty_check(nf) -> None:
@@ -19,6 +23,16 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
     ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
 
 
+def dev_dump_reject_attr(nf) -> None:
+    """Test that dev-get dump rejects attributes (no dump request policy)."""
+    with ksft_raises(NlError) as cm:
+        nf.dev_get({'ifindex': 1}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -errno.EINVAL)
+    ksft_eq(cm.exception.nl_msg.extack['msg'],
+            'Attribute failed policy validation', 'bad-attr')
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
+
+
 def napi_list_check(nf) -> None:
     with NetdevSimDev(queue_count=100) as nsimdev:
         nsim = nsimdev.nsims[0]
@@ -243,9 +257,16 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
 
 
 def main() -> None:
+    """ Ksft boiler plate main """
     nf = NetdevFamily()
-    ksft_run([empty_check, lo_check, page_pool_check, napi_list_check,
-              dev_set_threaded, napi_set_threaded, nsim_rxq_reset_down],
+    ksft_run([empty_check,
+              lo_check,
+              dev_dump_reject_attr,
+              napi_list_check,
+              napi_set_threaded,
+              dev_set_threaded,
+              nsim_rxq_reset_down,
+              page_pool_check],
              args=(nf, ))
     ksft_exit()
 
-- 
2.53.0


