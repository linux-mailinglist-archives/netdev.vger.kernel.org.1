Return-Path: <netdev+bounces-207319-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F143DB06A4B
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 02:05:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 29C07563CB7
	for <lists+netdev@lfdr.de>; Wed, 16 Jul 2025 00:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4279A1ACECE;
	Wed, 16 Jul 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vHUZOTf4"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F8A31A9B24
	for <netdev@vger.kernel.org>; Wed, 16 Jul 2025 00:04:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752624263; cv=none; b=clz8CgK+mYcQAVYy6P0DRCf1v8ePatddnJ248z6ogRRcspReqtMkkXT50FbAN4UboYV3Z8Zu1TY3163MB8h6eJgnUaXSsWPZlEvWRgLiF+UtuTdaXVXdEFwtgTtbH/wYd4cmqrPIjJKPrat39+NlCoVPPHNehjqwbGSzqk2lvX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752624263; c=relaxed/simple;
	bh=7+wBwbU6dXdaUqeIdyLq2v4VeSYGd18qQ+BvnY0ffsk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cYhwpBIZd7sfwyzdUD+DOo0ywFtoDFcl2UCAorwjsY8ImHxW83P12Hk/BSQu2A28cPPjN4TkUbdqeGFXWEhELhc5+X47E6LuQ7wZS/+E0xCu85mOC2fReoe4D4l08miRLowpvHXEbC9wDWR1IO6DraNAryyeGf+7zNq8ZoV0/88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vHUZOTf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FC7AC4CEF8;
	Wed, 16 Jul 2025 00:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752624263;
	bh=7+wBwbU6dXdaUqeIdyLq2v4VeSYGd18qQ+BvnY0ffsk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vHUZOTf40M6XF8FJ7Wk6xKB2HyTf47sURBA8j+ctp/leQ7BFSH/anIgryDAYQFaOi
	 BUA6mnuU0AZAW8/vNtraRzazU5KkcVjIR7cKFBpyLw1i6jWp6xRvHFlnVf93/AM/+P
	 x7t4z+MP7pIvpTUrr8sZWHGAXjNQwS3TAVxV8nSp+kVZlZBz9FowFtmwnQooGOQ3fQ
	 Cz+YtNxdVkMdJqC7HXkUU5ynuxDaqW2gIyWucW1CQ/WOaS/FANLczgNcYOHxO5wABM
	 lxctTEqinFf13IbPfhFPV4ERJ5dM8SUoQpxMYzu9AchfXrYC2Ux3f4uUWgGcQ9AxTR
	 lli7gVkfsXSqg==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	shuah@kernel.org,
	kory.maincent@bootlin.com,
	maxime.chevallier@bootlin.com,
	sdf@fomichev.me,
	ecree.xilinx@gmail.com,
	gal@nvidia.com,
	jdamato@fastly.com,
	andrew@lunn.ch,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v3 11/11] selftests: drv-net: rss_api: test input-xfrm and hash fields
Date: Tue, 15 Jul 2025 17:03:31 -0700
Message-ID: <20250716000331.1378807-12-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250716000331.1378807-1-kuba@kernel.org>
References: <20250716000331.1378807-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Test configuring input-xfrm and hash fields with all the limitations.
Tested on mlx5 (CX6):

  # ./ksft-net-drv/drivers/net/hw/rss_api.py
  TAP version 13
  1..10
  ok 1 rss_api.test_rxfh_nl_set_fail
  ok 2 rss_api.test_rxfh_nl_set_indir
  ok 3 rss_api.test_rxfh_nl_set_indir_ctx
  ok 4 rss_api.test_rxfh_indir_ntf
  ok 5 rss_api.test_rxfh_indir_ctx_ntf
  ok 6 rss_api.test_rxfh_nl_set_key
  ok 7 rss_api.test_rxfh_fields
  ok 8 rss_api.test_rxfh_fields_set
  ok 9 rss_api.test_rxfh_fields_set_xfrm
  ok 10 rss_api.test_rxfh_fields_ntf
  # Totals: pass:10 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
v3:
 - adjust after input_xfrm became a set
v2:
 - make defer() cleanup more intelligent WRT ordering
---
 .../selftests/drivers/net/hw/rss_api.py       | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index 6d48799a423c..424743bb583b 100755
--- a/tools/testing/selftests/drivers/net/hw/rss_api.py
+++ b/tools/testing/selftests/drivers/net/hw/rss_api.py
@@ -247,6 +247,149 @@ from lib.py import NetDrvEnv
                 comment="Config for " + fl_type)
 
 
+def test_rxfh_fields_set(cfg):
+    """ Test configuring Rx Flow Hash over Netlink. """
+
+    flow_types = ["tcp4", "tcp6", "udp4", "udp6"]
+
+    # Collect current settings
+    cfg_old = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    # symmetric hashing is config-order-sensitive make sure we leave
+    # symmetric mode, or make the flow-hash sym-compatible first
+    changes = [{"flow-hash": cfg_old["flow-hash"],},
+               {"input-xfrm": cfg_old.get("input-xfrm", {}),}]
+    if cfg_old.get("input-xfrm"):
+        changes = list(reversed(changes))
+    for old in changes:
+        defer(cfg.ethnl.rss_set, {"header": {"dev-index": cfg.ifindex},} | old)
+
+    # symmetric hashing prevents some of the configs below
+    if cfg_old.get("input-xfrm"):
+        cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                           "input-xfrm": {}})
+
+    for fl_type in flow_types:
+        cur = _ethtool_get_cfg(cfg, fl_type)
+        if cur == "sdfn":
+            change_nl = {"ip-src", "ip-dst"}
+            change_ic = "sd"
+        else:
+            change_nl = {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"}
+            change_ic = "sdfn"
+
+        cfg.ethnl.rss_set({
+            "header": {"dev-index": cfg.ifindex},
+            "flow-hash": {fl_type: change_nl}
+        })
+        reset = defer(ethtool, f"--disable-netlink -N {cfg.ifname} "
+                      f"rx-flow-hash {fl_type} {cur}")
+
+        cfg_nl = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+        ksft_eq(change_nl, cfg_nl["flow-hash"][fl_type],
+                comment=f"Config for {fl_type} over Netlink")
+        cfg_ic = _ethtool_get_cfg(cfg, fl_type)
+        ksft_eq(change_ic, cfg_ic,
+                comment=f"Config for {fl_type} over IOCTL")
+
+        reset.exec()
+        cfg_nl = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+        ksft_eq(cfg_old["flow-hash"][fl_type], cfg_nl["flow-hash"][fl_type],
+                comment=f"Un-config for {fl_type} over Netlink")
+        cfg_ic = _ethtool_get_cfg(cfg, fl_type)
+        ksft_eq(cur, cfg_ic, comment=f"Un-config for {fl_type} over IOCTL")
+
+    # Try to set multiple at once, the defer was already installed at the start
+    change = {"ip-src"}
+    if change == cfg_old["flow-hash"]["tcp4"]:
+        change = {"ip-dst"}
+    cfg.ethnl.rss_set({
+        "header": {"dev-index": cfg.ifindex},
+        "flow-hash": {x: change for x in flow_types}
+    })
+
+    cfg_nl = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    for fl_type in flow_types:
+        ksft_eq(change, cfg_nl["flow-hash"][fl_type],
+                comment=f"multi-config for {fl_type} over Netlink")
+
+
+def test_rxfh_fields_set_xfrm(cfg):
+    """ Test changing Rx Flow Hash vs xfrm_input at once.  """
+
+    def set_rss(cfg, xfrm, fh):
+        cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                           "input-xfrm": xfrm, "flow-hash": fh})
+
+    # Install the reset handler
+    cfg_old = cfg.ethnl.rss_get({"header": {"dev-index": cfg.ifindex}})
+    # symmetric hashing is config-order-sensitive make sure we leave
+    # symmetric mode, or make the flow-hash sym-compatible first
+    changes = [{"flow-hash": cfg_old["flow-hash"],},
+               {"input-xfrm": cfg_old.get("input-xfrm", {}),}]
+    if cfg_old.get("input-xfrm"):
+        changes = list(reversed(changes))
+    for old in changes:
+        defer(cfg.ethnl.rss_set, {"header": {"dev-index": cfg.ifindex},} | old)
+
+    # Make sure we start with input-xfrm off, and tcp4 config non-sym
+    set_rss(cfg, {}, {})
+    set_rss(cfg, {}, {"tcp4": {"ip-src"}})
+
+    # Setting sym and fixing tcp4 config not expected to pass right now
+    with ksft_raises(NlError):
+        set_rss(cfg, {"sym-xor"}, {"tcp4": {"ip-src", "ip-dst"}})
+    # One at a time should work, hopefully
+    set_rss(cfg, 0, {"tcp4": {"ip-src", "ip-dst"}})
+    no_support = False
+    try:
+        set_rss(cfg, {"sym-xor"}, {})
+    except NlError:
+        try:
+            set_rss(cfg, {"sym-or-xor"}, {})
+        except NlError:
+            no_support = True
+    if no_support:
+        raise KsftSkipEx("no input-xfrm supported")
+    # Disabling two at once should not work either without kernel changes
+    with ksft_raises(NlError):
+        set_rss(cfg, {}, {"tcp4": {"ip-src"}})
+
+
+def test_rxfh_fields_ntf(cfg):
+    """ Test Rx Flow Hash notifications. """
+
+    cur = _ethtool_get_cfg(cfg, "tcp4")
+    if cur == "sdfn":
+        change = {"ip-src", "ip-dst"}
+    else:
+        change = {"l4-b-0-1", "l4-b-2-3", "ip-src", "ip-dst"}
+
+    ethnl = EthtoolFamily()
+    ethnl.ntf_subscribe("monitor")
+
+    ethnl.rss_set({
+        "header": {"dev-index": cfg.ifindex},
+        "flow-hash": {"tcp4": change}
+    })
+    reset = defer(ethtool,
+                  f"--disable-netlink -N {cfg.ifname} rx-flow-hash tcp4 {cur}")
+
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("No notification received after IOCTL change")
+    ksft_eq(ntf["name"], "rss-ntf")
+    ksft_eq(ntf["msg"]["flow-hash"]["tcp4"], change)
+    ksft_eq(next(ethnl.poll_ntf(duration=0.01), None), None)
+
+    reset.exec()
+    ntf = next(ethnl.poll_ntf(duration=0.2), None)
+    if ntf is None:
+        raise KsftFailEx("No notification received after Netlink change")
+    ksft_eq(ntf["name"], "rss-ntf")
+    ksft_ne(ntf["msg"]["flow-hash"]["tcp4"], change)
+    ksft_eq(next(ethnl.poll_ntf(duration=0.01), None), None)
+
+
 def main() -> None:
     """ Ksft boiler plate main """
 
-- 
2.50.1


