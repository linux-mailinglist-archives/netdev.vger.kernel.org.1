Return-Path: <netdev+bounces-269293-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4ASfOiN0u2mckQIAu9opvQ
	(envelope-from <netdev+bounces-269293-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:57:23 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F8B42C5C1D
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 04:57:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 926BF30B9FAC
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 03:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99EDD33FE27;
	Thu, 19 Mar 2026 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H15fmwNE"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75A7433263E;
	Thu, 19 Mar 2026 03:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773892633; cv=none; b=LOKVshtuGxXp95hxkbGdQibSQM2HQRewuLzeGkLbV3OXcGGQ4eNGDqbpRmxwIMVIxOj4MxjDTUTmCiQqCDz4JkF2Pt1rFwFa5UDtq4YmPbj1uwjy/DRRZa1TGehg+ZfNht7ng0VAsVPG9kHnNYc40FjxgOt7NzuVHr18Obxrr5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773892633; c=relaxed/simple;
	bh=emdFY7RfW3M1nJe3blkZEZcRiajQ+G4C88lIFs82nek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Iz8IGnDwcwn6UumMnoEk4tUyZYUZTL1sS2IOyIDCbtxMfYBMnWqVkJTn5ibCNF62dwCF6DysqsN+Iyf4WR+eHyM0DctruRUYwZYn5idQYvbsSim1KI1oPQpYYUFE89g5KaSd0ToUEqXJwiCQ7AoPC0AWkoHZSTs5p/JGtRy+JEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H15fmwNE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07A7C2BCB1;
	Thu, 19 Mar 2026 03:57:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773892633;
	bh=emdFY7RfW3M1nJe3blkZEZcRiajQ+G4C88lIFs82nek=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H15fmwNERPCgXFxOKkr5EkTkRH8gGGrKAG/mi58xlHeR1xHRQ2R4gTvGP8+N121U/
	 ufQahNF6DyQeHsM2bSbdxzFiYKocX/LwYA2OZQmEZIoT771goD+nI+hkmcI5QN59YG
	 e8hj25gbJWFIa2LT1+ap50zt0K4jpDgPmkkoNdF8fPar2KL8hc/dJi+mC789LChKJ3
	 F2RWZfkMCQGC+yiPtT17s0zMn978+qH+8dyGfZJYv0JbYIAzioaZv4aN2e/UlO+qSa
	 paAmUgvcO45OaVXc9RMgVVNfxTQ0sxrqWLMvCPRhUaUQqEYZeZZRVROZALljXsQkKY
	 KDZGN/RkEsHyA==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	matttbe@kernel.org,
	chuck.lever@oracle.com,
	hawk@kernel.org,
	linux-kselftest@vger.kernel.org,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 2/2] selftests: net: add tests for filtered dumps of page pool
Date: Wed, 18 Mar 2026 20:56:48 -0700
Message-ID: <20260319035649.2396137-2-kuba@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319035649.2396137-1-kuba@kernel.org>
References: <20260319035649.2396137-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,oracle.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[13];
	TAGGED_FROM(0.00)[bounces-269293-lists,netdev=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.895];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4F8B42C5C1D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add tests for page pool dumps of a specific ifindex.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 tools/testing/selftests/net/nl_netdev.py | 119 ++++++++++++++++++++++-
 1 file changed, 117 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/nl_netdev.py b/tools/testing/selftests/net/nl_netdev.py
index eff55c64a012..ceb44c8e1fec 100755
--- a/tools/testing/selftests/net/nl_netdev.py
+++ b/tools/testing/selftests/net/nl_netdev.py
@@ -9,7 +9,7 @@ import errno
 from os import system
 from lib.py import ksft_run, ksft_exit
 from lib.py import ksft_eq, ksft_ge, ksft_ne, ksft_raises, ksft_busy_wait
-from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
+from lib.py import NetdevFamily, NetdevSimDev, NlError, defer, ip
 
 
 def empty_check(nf) -> None:
@@ -255,6 +255,117 @@ from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
         nsim.dfs_write("pp_hold", "y")
 
 
+def page_pool_dump_ifindex(nf) -> None:
+    """Test page pool dump filtering by ifindex."""
+    nsimdev1 = NetdevSimDev(queue_count=3)
+    rm_nsim1 = defer(nsimdev1.remove)
+    nsimdev2 = NetdevSimDev(queue_count=5)
+    defer(nsimdev2.remove)
+
+    nsim1 = nsimdev1.nsims[0]
+    nsim2 = nsimdev2.nsims[0]
+
+    ip(f"link set dev {nsim1.ifname} up")
+    ip(f"link set dev {nsim2.ifname} up")
+
+    # Unfiltered dump should have pools from both devices
+    all_pp = nf.page_pool_get({}, dump=True)
+    pp1_all = [pp for pp in all_pp
+               if pp.get("ifindex") == nsim1.ifindex]
+    pp2_all = [pp for pp in all_pp
+               if pp.get("ifindex") == nsim2.ifindex]
+    ksft_ge(len(pp1_all), 1)
+    ksft_ge(len(pp2_all), 1)
+
+    # Filtered dump should only return pools for that device
+    pp1_flt = nf.page_pool_get({'ifindex': nsim1.ifindex}, dump=True)
+    ksft_eq(pp1_flt, pp1_all)
+
+    pp2_flt = nf.page_pool_get({'ifindex': nsim2.ifindex}, dump=True)
+    ksft_eq(pp2_flt, pp2_all)
+
+    # Non-existent ifindex should return empty dump
+    pp_none = nf.page_pool_get({'ifindex': 12345678}, dump=True)
+    ksft_eq(len(pp_none), 0)
+
+    # Device down - no pools for that ifindex
+    ip(f"link set dev {nsim1.ifname} down")
+    pp1_down = nf.page_pool_get({'ifindex': nsim1.ifindex}, dump=True)
+    ksft_eq(len(pp1_down), 0)
+
+    # Remove device, dump by its old ifindex should return empty
+    old_ifindex = nsim1.ifindex
+    rm_nsim1.exec()
+    pp1_gone = nf.page_pool_get({'ifindex': old_ifindex}, dump=True)
+    ksft_eq(len(pp1_gone), 0)
+
+
+def page_pool_ifindex_leak_check(nf) -> None:
+    """Test that zombie page pools don't show up under the original ifindex."""
+    nsimdev = NetdevSimDev()
+    rm_nsim = defer(nsimdev.remove)
+    nsim = nsimdev.nsims[0]
+
+    ip(f"link set dev {nsim.ifname} up")
+    nsim.dfs_write("pp_hold", "y")
+
+    pp_up = nf.page_pool_get({'ifindex': nsim.ifindex}, dump=True)
+    ksft_ge(len(pp_up), 1)
+
+    # Remove device with leaked page - pool becomes zombie (orphaned to lo)
+    old_ifindex = nsim.ifindex
+    rm_nsim.exec()
+
+    # Zombie pool should NOT appear under the original device
+    pp_down = nf.page_pool_get({'ifindex': old_ifindex}, dump=True)
+    ksft_eq(len(pp_down), 0)
+
+    # But it should appear in an unfiltered dump (under loopback)
+    pp_all = nf.page_pool_get({}, dump=True)
+    orphans = [pp for pp in pp_all
+               if "detach-time" in pp and "ifindex" not in pp]
+    ksft_ge(len(orphans), 1)
+
+
+def page_pool_stats_ifindex_check(nf) -> None:
+    """Test page pool stats dump filtering by ifindex."""
+    nsimdev1 = NetdevSimDev(queue_count=3)
+    defer(nsimdev1.remove)
+    nsimdev2 = NetdevSimDev(queue_count=5)
+    defer(nsimdev2.remove)
+
+    nsim1 = nsimdev1.nsims[0]
+    nsim2 = nsimdev2.nsims[0]
+
+    ip(f"link set dev {nsim1.ifname} up")
+    ip(f"link set dev {nsim2.ifname} up")
+
+    # Unfiltered stats dump
+    all_stats = nf.page_pool_stats_get({}, dump=True)
+    s1_all = [s for s in all_stats
+              if s.get("info", {}).get("ifindex") == nsim1.ifindex]
+    s2_all = [s for s in all_stats
+              if s.get("info", {}).get("ifindex") == nsim2.ifindex]
+    ksft_ge(len(s1_all), 1)
+    ksft_ge(len(s2_all), 1)
+
+    # Filtered stats dump
+    s1_flt = nf.page_pool_stats_get({'info': {'ifindex': nsim1.ifindex}},
+                                    dump=True)
+    ksft_eq(s1_flt, s1_all)
+
+    # Non-existent ifindex should return empty
+    s_none = nf.page_pool_stats_get({'info': {'ifindex': 12345678}}, dump=True)
+    ksft_eq(len(s_none), 0)
+
+    # info.id should be rejected for stats dump
+    with ksft_raises(NlError) as cm:
+        nf.page_pool_stats_get({'info': {'id': s1_all[0]['info']['id']}},
+                               dump=True)
+    ksft_eq(cm.exception.nl_msg.error, -errno.EINVAL)
+    ksft_eq(cm.exception.nl_msg.extack['bad-attr'], '.info.id')
+
+
 def main() -> None:
     """ Ksft boiler plate main """
     nf = NetdevFamily()
@@ -265,7 +376,11 @@ from lib.py import NetdevFamily, NetdevSimDev, NlError, ip
               napi_set_threaded,
               dev_set_threaded,
               nsim_rxq_reset_down,
-              page_pool_check],
+              page_pool_check,
+              page_pool_dump_ifindex,
+              page_pool_ifindex_leak_check,
+              page_pool_stats_ifindex_check
+              ],
              args=(nf, ))
     ksft_exit()
 
-- 
2.53.0


