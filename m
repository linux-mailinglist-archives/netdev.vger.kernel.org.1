Return-Path: <netdev+bounces-266452-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6IYVJpPhsGkuoAIAu9opvQ
	(envelope-from <netdev+bounces-266452-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:29:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3572B25B99E
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 04:29:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CA5B13042FDC
	for <lists+netdev@lfdr.de>; Wed, 11 Mar 2026 03:28:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E6A5437267D;
	Wed, 11 Mar 2026 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TXxXpKim"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3315371897;
	Wed, 11 Mar 2026 03:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773199726; cv=none; b=aE8ltHQ4+/9iCG/vh67YWg9TJrZtNVsjOXyc53Dc3sFp3sWc3Kxf+c1Fo/tJVos1K5Lnp2FaFZPV3p5M+WVDFDhmspu3yH1ULWvzJ+jh7FMAHrG1jfRUoryz2pnEt9KaSL+A9OkhhtWgijuvV1TOHssrnRZ34aYD9z05eQyHGVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773199726; c=relaxed/simple;
	bh=ozkFpTiB6QF7JITd+KpqRuvxbeNYrnmmlp2eJSkGLM8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N3QpJgRSSuIzz0EzSbu9OnowBGjmgSj8P3JxmAc2RwHBYfBfQLwachor08t4TZloqmz61lzMjwXiucBYe8PgeBZ+hVuT2K0X6BmY0aWJr8b1BTZsYJcg118YEZBr3yRjAWHAN/+yRad+Eel0w2yWGGzTGCkSR5qDe2OXsYgjbGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TXxXpKim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A861C116C6;
	Wed, 11 Mar 2026 03:28:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773199726;
	bh=ozkFpTiB6QF7JITd+KpqRuvxbeNYrnmmlp2eJSkGLM8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TXxXpKimkpqq6GEezpclNwBACek76JrO0lUouYmZmunEcw6G9oOSWltpmSwAKUSKl
	 gruePLmrq1eme8HVlhpjosWYDZindYMwJAf8PyqrAc1sy9BEqnFKgE+2lvQ2gEJ7r/
	 aZtghXIabUe32CGVjTIsQ7de2WCMRA4BQ0AjPHvkSfgabDgFsc7HWyvSD7URzM7emM
	 NtVAO2RbvXzuZKM1AqJeN0zyH0HpDgZq5PnWGHfmKhHj3PpW6USN41SqqZKmQSLZ4K
	 hXZJt6CQbObS1J623eZKCfoaR7duzgVzKCQCa9j7IDkFExgkhfia4sEOpMg5GKGISb
	 HTmpk/fWxEGWA==
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
Subject: [PATCH net-next v2 4/4] selftests: net: add test for Netlink policy dumps
Date: Tue, 10 Mar 2026 20:28:39 -0700
Message-ID: <20260311032839.417748-5-kuba@kernel.org>
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
X-Rspamd-Queue-Id: 3572B25B99E
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
	TAGGED_FROM(0.00)[bounces-266452-lists,netdev=lfdr.de];
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

Add validation for the nlctrl family, accessing family info and
dumping policies.

  TAP version 13
  1..4
  ok 1 nl_nlctrl.getfamily_do
  ok 2 nl_nlctrl.getfamily_dump
  ok 3 nl_nlctrl.getpolicy_dump
  ok 4 nl_nlctrl.getpolicy_by_op
  # Totals: pass:4 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/Makefile          |   1 +
 .../testing/selftests/net/lib/py/__init__.py  |   5 +-
 tools/testing/selftests/net/lib/py/ynl.py     |  10 +-
 tools/testing/selftests/net/nl_nlctrl.py      | 135 ++++++++++++++++++
 4 files changed, 148 insertions(+), 3 deletions(-)
 create mode 100755 tools/testing/selftests/net/nl_nlctrl.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index a24ea64e2ae8..6bced3ed798b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -65,6 +65,7 @@ TEST_PROGS := \
 	netns-name.sh \
 	netns-sysctl.sh \
 	nl_netdev.py \
+	nl_nlctrl.py \
 	pmtu.sh \
 	psock_snd.sh \
 	reuseaddr_ports_exhausted.sh \
diff --git a/tools/testing/selftests/net/lib/py/__init__.py b/tools/testing/selftests/net/lib/py/__init__.py
index 54e84282781c..e0c920041a58 100644
--- a/tools/testing/selftests/net/lib/py/__init__.py
+++ b/tools/testing/selftests/net/lib/py/__init__.py
@@ -15,7 +15,8 @@ from .nsim import NetdevSim, NetdevSimDev
 from .utils import CmdExitFailure, fd_read_timeout, cmd, bkg, defer, \
     bpftool, ip, ethtool, bpftrace, rand_port, rand_ports, wait_port_listen, \
     wait_file, tool
-from .ynl import NlError, YnlFamily, EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
+from .ynl import NlError, NlctrlFamily, YnlFamily, \
+    EthtoolFamily, NetdevFamily, RtnlFamily, RtnlAddrFamily
 from .ynl import NetshaperFamily, DevlinkFamily, PSPFamily, Netlink
 
 __all__ = ["KSRC",
@@ -31,4 +32,4 @@ __all__ = ["KSRC",
            "NetdevSim", "NetdevSimDev",
            "NetshaperFamily", "DevlinkFamily", "PSPFamily", "NlError",
            "YnlFamily", "EthtoolFamily", "NetdevFamily", "RtnlFamily",
-           "RtnlAddrFamily", "Netlink"]
+           "NlctrlFamily", "RtnlAddrFamily", "Netlink"]
diff --git a/tools/testing/selftests/net/lib/py/ynl.py b/tools/testing/selftests/net/lib/py/ynl.py
index e8aa97936f6c..2e567062aa6c 100644
--- a/tools/testing/selftests/net/lib/py/ynl.py
+++ b/tools/testing/selftests/net/lib/py/ynl.py
@@ -30,7 +30,8 @@ from .ksft import ksft_pr, ktap_result
 __all__ = [
     "NlError", "NlPolicy", "Netlink", "YnlFamily", "SPEC_PATH",
     "EthtoolFamily", "RtnlFamily", "RtnlAddrFamily",
-    "NetdevFamily", "NetshaperFamily", "DevlinkFamily", "PSPFamily",
+    "NetdevFamily", "NetshaperFamily", "NlctrlFamily", "DevlinkFamily",
+    "PSPFamily",
 ]
 
 #
@@ -63,6 +64,13 @@ __all__ = [
         super().__init__((SPEC_PATH / Path('net_shaper.yaml')).as_posix(),
                          schema='', recv_size=recv_size)
 
+
+class NlctrlFamily(YnlFamily):
+    def __init__(self, recv_size=0):
+        super().__init__((SPEC_PATH / Path('nlctrl.yaml')).as_posix(),
+                         schema='', recv_size=recv_size)
+
+
 class DevlinkFamily(YnlFamily):
     def __init__(self, recv_size=0):
         super().__init__((SPEC_PATH / Path('devlink.yaml')).as_posix(),
diff --git a/tools/testing/selftests/net/nl_nlctrl.py b/tools/testing/selftests/net/nl_nlctrl.py
new file mode 100755
index 000000000000..d19e206c2c02
--- /dev/null
+++ b/tools/testing/selftests/net/nl_nlctrl.py
@@ -0,0 +1,135 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+"""
+Tests for the nlctrl genetlink family (family info and policy dumps).
+"""
+
+from lib.py import ksft_run, ksft_exit
+from lib.py import ksft_eq, ksft_ge, ksft_true, ksft_in, ksft_not_in
+from lib.py import NetdevFamily, EthtoolFamily, NlctrlFamily
+
+
+def getfamily_do(ctrl) -> None:
+    """Query a single family by name and validate its ops."""
+    fam = ctrl.getfamily({'family-name': 'netdev'})
+    ksft_eq(fam['family-name'], 'netdev')
+    ksft_true(fam['family-id'] > 0)
+
+    # The format of ops is quite odd, [{$idx: {"id"...}}, {$idx: {"id"...}}]
+    # Discard the indices and re-key by command id.
+    ops_by_id = {v['id']: v for op in fam['ops'] for v in op.values()}
+    ksft_eq(len(ops_by_id), len(fam['ops']))
+
+    # All ops should have a policy (either do or dump has one)
+    for op in ops_by_id.values():
+        ksft_in('cmd-cap-haspol', op['flags'],
+                comment=f"op {op['id']} missing haspol")
+
+    # dev-get (id 1) should support both do and dump
+    ksft_in('cmd-cap-do', ops_by_id[1]['flags'])
+    ksft_in('cmd-cap-dump', ops_by_id[1]['flags'])
+
+    # qstats-get (id 12) is dump-only
+    ksft_not_in('cmd-cap-do', ops_by_id[12]['flags'])
+    ksft_in('cmd-cap-dump', ops_by_id[12]['flags'])
+
+    # napi-set (id 14) is do-only and requires admin
+    ksft_in('cmd-cap-do', ops_by_id[14]['flags'])
+    ksft_not_in('cmd-cap-dump', ops_by_id[14]['flags'])
+    ksft_in('admin-perm', ops_by_id[14]['flags'])
+
+    # Notification-only commands (dev-add/del/change-ntf etc.) must
+    # not appear in the ops list since they have no do/dump handlers.
+    for ntf_id in [2, 3, 4, 6, 7, 8]:
+        ksft_not_in(ntf_id, ops_by_id,
+                    comment=f"ntf-only cmd {ntf_id} should not be in ops")
+
+
+def getfamily_dump(ctrl) -> None:
+    """Dump all families and verify expected entries."""
+    families = ctrl.getfamily({}, dump=True)
+    ksft_ge(len(families), 2)
+
+    names = [f['family-name'] for f in families]
+    ksft_in('nlctrl', names, comment="nlctrl not found in family dump")
+    ksft_in('netdev', names, comment="netdev not found in family dump")
+
+
+def getpolicy_dump(_ctrl) -> None:
+    """Dump policies for ops using get_policy() and validate results.
+
+    Test with netdev (split ops) where do and dump can have different
+    policies, and with ethtool (full ops) where they always share one.
+    """
+    # -- netdev (split ops) --
+    ndev = NetdevFamily()
+
+    # dev-get: do has a real policy with ifindex, dump has no policy
+    # (only the reject-all policy with maxattr=0)
+    pol = ndev.get_policy('dev-get', 'do')
+    ksft_in('ifindex', pol.attrs,
+            comment="dev-get do policy should have ifindex")
+    ksft_eq(pol.attrs.get('ifindex', {}).get('type'), 'u32')
+
+    pol_dump = ndev.get_policy('dev-get', 'dump')
+    ksft_eq(len(pol_dump.attrs), 0,
+            comment="dev-get should not accept any attrs")
+
+    # napi-get: both do and dump have real policies
+    pol_do = ndev.get_policy('napi-get', 'do')
+    ksft_ge(len(pol_do.attrs), 1)
+
+    pol_dump = ndev.get_policy('napi-get', 'dump')
+    ksft_ge(len(pol_dump.attrs), 1)
+
+    # -- ethtool (full ops) --
+    et = EthtoolFamily()
+
+    # strset-get (has both do and dump, full ops share policy)
+    pol_do = et.get_policy('strset-get', 'do')
+    ksft_ge(len(pol_do.attrs), 1, comment="strset-get should have a do policy")
+
+    pol_dump = et.get_policy('strset-get', 'dump')
+    ksft_ge(len(pol_dump.attrs), 1,
+            comment="strset-get should have a dump policy")
+
+    # Same policy means same attribute names
+    ksft_eq(set(pol_do.attrs.keys()), set(pol_dump.attrs.keys()))
+
+    # linkinfo-set is do-only (SET command), no dump
+    pol_do = et.get_policy('linkinfo-set', 'do')
+    ksft_ge(len(pol_do.attrs), 1,
+            comment="linkinfo-set should have a do policy")
+
+    pol_dump = et.get_policy('linkinfo-set', 'dump')
+    ksft_eq(pol_dump, None,
+            comment="linkinfo-set should not have a dump policy")
+
+
+def getpolicy_by_op(_ctrl) -> None:
+    """Query policy for specific ops, check attr names are resolved."""
+    ndev = NetdevFamily()
+
+    # dev-get do policy should have named attributes from the spec
+    pol = ndev.get_policy('dev-get', 'do')
+    ksft_ge(len(pol.attrs), 1)
+    # All attr names should be resolved (no 'attr-N' fallbacks)
+    for name in pol.attrs:
+        ksft_true(not name.startswith('attr-'),
+                  comment=f"unresolved attr name: {name}")
+
+
+def main() -> None:
+    """ Ksft boiler plate main """
+    ctrl = NlctrlFamily()
+    ksft_run([getfamily_do,
+              getfamily_dump,
+              getpolicy_dump,
+              getpolicy_by_op],
+             args=(ctrl, ))
+    ksft_exit()
+
+
+if __name__ == "__main__":
+    main()
-- 
2.53.0


