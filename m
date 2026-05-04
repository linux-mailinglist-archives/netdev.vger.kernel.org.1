Return-Path: <netdev+bounces-284049-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aF1LEhYT+WnV5AIAu9opvQ
	(envelope-from <netdev+bounces-284049-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:43:50 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 085EC4C4321
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 23:43:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9CE3F301BEE5
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 21:43:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F23AC3624CC;
	Mon,  4 May 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z2WdCDwH"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB7C3624B3;
	Mon,  4 May 2026 21:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777931021; cv=none; b=sJPaVf/8vslI21e/YnhSqSLgqfjyCJgwZyuIONEM4MHJPnyk4/8lfjyXw/6gHKecP34g2uLG6SLoPz8vvCI+31iAovMNDZ4VjEouadCQRvn1ZmXWlPa+j0cjO5pZvyb6lLpRtnv7byXJpQfvNmoNovInm+0lHMVUOBFN56ydr1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777931021; c=relaxed/simple;
	bh=9Ptp10PVdxM5901DDTI7Qpmca/trm2cZRPvlKUxSONQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fzGIufhKdi4HdaVKnJzZI+mqXoTo1U+Rei4y+/YWUyhP5F3Udi239PKaiJLT0NgnEWmRw9fnccN1ko7+KE6wrHrDmVGyfKPYVBMOkZv5E6Onxp/jm7KKoCpGTGvepyElkiCRqrk3/Wcr3aU12+bViumdmeidVpyWQnhvgGrQAE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z2WdCDwH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 230E9C2BCB9;
	Mon,  4 May 2026 21:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777931021;
	bh=9Ptp10PVdxM5901DDTI7Qpmca/trm2cZRPvlKUxSONQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Z2WdCDwHhwGsr1t0zH//zBJ75Hj7dyz/GqDhgfTNpIGLWfxC7/PNaqPPYToBZipuV
	 8/INhvrafqP9yxnVdbjn4pv8TW8TB/f41RsZMLSCo3KmmxABr1Ure5S/pMgukZGH/f
	 /jxe5+WFcqezAPEDNHF8Z4ZxtAiA+keDcQ0D3Sh5ml89pnX2amoNnfoioTTajG84X7
	 vrhzCdZhWHsCFXHppkhV6TOnU+ocY0+CP0ULUCArrWnzGce1Xe7yn5igolhKzXYJDW
	 RVVxOpU2CV0iS20BVMaCiQ3OldDRcj9DQ0zN9XByDBzxzcwhvsQP1fVeTVTBhqLNTc
	 EA7jCyn+BaFkQ==
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
	hawk@kernel.org,
	linux-kselftest@vger.kernel.org,
	maxime.chevallier@bootlin.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 2/2] selftests: net: add tests for filtered dumps of page pool
Date: Mon,  4 May 2026 14:43:36 -0700
Message-ID: <20260504214336.613107-2-kuba@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504214336.613107-1-kuba@kernel.org>
References: <20260504214336.613107-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 085EC4C4321
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-284049-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,redhat.com,lunn.ch,kernel.org,gmail.com,bootlin.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kuba@kernel.org,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[info.id:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

Add tests for page pool dumps of a specific ifindex.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v2:
 - add CONFIG_PAGE_POOL_STATS=y to the config
v1: https://lore.kernel.org/20260319035649.2396137-2-kuba@kernel.org
---
 tools/testing/selftests/net/config       |   1 +
 tools/testing/selftests/net/nl_netdev.py | 119 ++++++++++++++++++++++-
 2 files changed, 118 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 94d722770420..d07c5ac5cab7 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -117,6 +117,7 @@ CONFIG_OPENVSWITCH=m
 CONFIG_OPENVSWITCH_GENEVE=m
 CONFIG_OPENVSWITCH_GRE=m
 CONFIG_OPENVSWITCH_VXLAN=m
+CONFIG_PAGE_POOL_STATS=y
 CONFIG_PROC_SYSCTL=y
 CONFIG_PSAMPLE=m
 CONFIG_RPS=y
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
2.54.0


