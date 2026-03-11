Return-Path: <netdev+bounces-266451-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCYkJIvhsGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266451-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:29:15 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09C9C25B986
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:29:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E42B2306FE97
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:28:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F2BA37188E;
	Wed, 11 Mar 2026 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OiU9BdgF"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A85A371888;
	Wed, 11 Mar 2026 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199726; cv=none; b=eD2W4skFQ4e6jZiVzuJY1LHu3N0xK2DTD8qIlsyZVdV5Up1i0WTiI1RNgvn5QbyMscER1TBgCAlmcTKrDJPOVXft2q/VhZz8iJCQ+FXY7tP0zmOa30aIxwdLhDGkYinWJAQkz3+kC1OGi//1TasbKLjNf3IZIWoRcX4fa7AY0z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199726; c=relaxed/simple;
	bh=xXqrMi940VX6pdNh68HNEHsETYj1LwTIR9IFPpAjd3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k3O/E2o9e7D3LokPJzMqhz5EmJfXeAOQ3+lmlLvX3APp2/sL845ewV7f+QeBsZAtsyCAuYW7WzVO4ze6szh5Wk0Qcd5/iGRN202KpOfen7LuYebkHnXNmtRXuHTI5H6Xx2nuj/nyKRYG8fp7jRyJUetrZyskqcE/BWpOuO+DPFI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OiU9BdgF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5AA6C2BCB0;
	Wed, 11 Mar 2026 03:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199726;
	bh=xXqrMi940VX6pdNh68HNEHsETYj1LwTIR9IFPpAjd3M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OiU9BdgFp2DrcxJpNj5KGtYBsWYSfOB8SpexSftxR3Y59nfLq5J5PMNTjjQYfKTlG
	 0dh5p0nxd3mbUXQvvJOhWE3JgjV9VDdEDBmaVYTHJy2rDIuGeCB37Utb/dlMeLGdPY
	 Xn0vUvK3UiBE8cEqxI+34zzylWyagTwwUoLh9Z0NP6lHOijqyqtfA82l2SYB9g+8ld
	 AqCGyue7hBaiTlxMnyKzv0XBcdPoTO9evuC2Tpt2VhbBd2eB55iXF452hGSFpMjigH
	 ZtFuMj/RHLF9wNJjSAGv2E0bVyrvvxXXlIZIEshk1dPNJrZBQl8QW6ssk/efEzu2Ks
	 YudscpxTzildw==
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
Subject: [PATCH net-next v2 3/4] selftests: net: make sure that Netlink rejects unknown attrs in dump
Date: Tue, 10 Mar 2026 20:28:38 -0700
Message-ID: <20260311032839.417748-4-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260311032839.417748-1-kuba@kernel.org>
References: <20260311032839.417748-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 09C9C25B986
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-266451-lists,netdev=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Add a test case for rejecting attrs if policy is not set.
dev_get dump has no input policy (accepts no attrs).

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
CC: shuah@kernel.org
CC: linux-kselftest@vger.kernel.org
---
 tools/testing/selftests/net/nl_netdev.py | 32 +++++++++++++++++++-----
 1 file changed, 26 insertions(+), 6 deletions(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index 5c66421ab8aa..eff55c64a012 100755
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
@@ -19,6 +23,15 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
     ksft_eq(len(lo_info['xdp-rx-metadata-features']), 0)
 
 
+def dev_dump_reject_attr(nf) -> None:
+    """Test that dev-get dump rejects attributes (no dump request policy)."""
+    with ksft_raises(NlError) as cm:
+        nf.dev_get({'ifindex': 1}, dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -errno.EINVAL)
+    ksft_eq(cm.exception.nl_msg.extack['msg'], 'Unknown attribute type')
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.ifindex')
+
+
 def napi_list_check(nf) -> None:
     with NetdevSimDev(queue_count=100) as nsimdev:
         nsim = nsimdev.nsims[0]
@@ -243,9 +256,16 @@ from lib.py import NetdevFamily, NetdevSimDev, ip
 
 
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


