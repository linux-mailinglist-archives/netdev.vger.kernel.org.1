Return-Path: <netdev+bounces-206884-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C7CEFB04A9E
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:28:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 746064A32EE
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC5C1281513;
	Mon, 14 Jul 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GH2Ddqh6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8783E281357
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752532075; cv=none; b=J67YO/55eX2VgTov/YP6DUoEKaETWQXe3e+oP4qtHwmnUGmcHfp03MwJmnGYVSGrSrq94TD9wnzJqpFOnab3eRYE5vwJBJKxXjgWCmnBaRVG23hYt5IThQftkDfzXh39NmFqii+jsdcLdnSXJdauad+fK7bDaxQoRbhPApVN4JE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752532075; c=relaxed/simple;
	bh=erWXXhAUJRZBCJac6p6SmQrSwW0QXrCTar6xyDRnWB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJKkI0KtjILU05fTlLEKGHS5NrPWOyairh5pvsYMSG1ytMhxretZBYqnkrv3w6kKqZ1YmtrJHwaCBh9wiKlBG4pubGPLLl0GXKxaBY7Vd2STmbH6fpL5VC9FLdfedluxPd6WasAH+RRV/gwCXpPUoLhd+WdwuwSl8U5ADpjOAiI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GH2Ddqh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F37B2C4CEED;
	Mon, 14 Jul 2025 22:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752532075;
	bh=erWXXhAUJRZBCJac6p6SmQrSwW0QXrCTar6xyDRnWB8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GH2Ddqh6zBDvQaySZWEF0+KEMdESHBe3gMKfzlcc2AiOVJHwCnpdVSzojYoxKMvgg
	 nafJflLOh99lO85C2yH8YbDT3n/lvE6Mlt2wfgXTqXzF/qU72ZeqhrwRIcX98rlZDW
	 f4INc65VqkskS1GLQw4+xpwmyAu42laDIQqMnv19zpaPwabS/2L9cr3JxfPkqcXgt9
	 oqWIhn4vP2GjsbdmwhPRyqReRg0pbPbR1xFtpndtpGrBo79LrrQfrQYgOmPDe0ZjqX
	 ct5y0ZhxlKUBhUQUM7ToCBfBFqAtu9c0ueNQmrk0YvAOaY8224kOJhuky7wjQjkzai
	 wdSfaU//BdzkQ==
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
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next v2 11/11] selftests: drv-net: rss_api: test input-xfrm and hash fields
Date: Mon, 14 Jul 2025 15:27:29 -0700
Message-ID: <20250714222729.743282-12-kuba@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250714222729.743282-1-kuba@kernel.org>
References: <20250714222729.743282-1-kuba@kernel.org>
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
v2:
 - make defer() cleanup more intelligent WRT ordering
---
 .../selftests/drivers/net/hw/rss_api.py       | 143 ++++++++++++++++++
 1 file changed, 143 insertions(+)

diff --git a/tools/testing/selftests/drivers/net/hw/rss_api.py b/tools/testing/selftests/drivers/net/hw/rss_api.py
index 4de566edb313..7a1a1c3b5f6e 100755
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
+               {"input-xfrm": cfg_old.get("input-xfrm", 0),}]
+    if cfg_old.get("input-xfrm"):
+        changes = list(reversed(changes))
+    for old in changes:
+        defer(cfg.ethnl.rss_set, {"header": {"dev-index": cfg.ifindex},} | old)
+
+    # symmetric hashing prevents some of the configs below
+    if cfg_old.get("input-xfrm", None):
+        cfg.ethnl.rss_set({"header": {"dev-index": cfg.ifindex},
+                           "input-xfrm": 0})
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
+               {"input-xfrm": cfg_old.get("input-xfrm", 0),}]
+    if cfg_old.get("input-xfrm"):
+        changes = list(reversed(changes))
+    for old in changes:
+        defer(cfg.ethnl.rss_set, {"header": {"dev-index": cfg.ifindex},} | old)
+
+    # Make sure we start with input-xfrm off, and tcp4 config non-sym
+    set_rss(cfg, 0, {})
+    set_rss(cfg, 0, {"tcp4": {"ip-src"}})
+
+    # Setting sym and fixing tcp4 config not expected to pass right now
+    with ksft_raises(NlError):
+        set_rss(cfg, "sym-xor", {"tcp4": {"ip-src", "ip-dst"}})
+    # One at a time should work, hopefully
+    set_rss(cfg, 0, {"tcp4": {"ip-src", "ip-dst"}})
+    no_support = False
+    try:
+        set_rss(cfg, "sym-xor", {})
+    except NlError:
+        try:
+            set_rss(cfg, "sym-or-xor", {})
+        except NlError:
+            no_support = True
+    if no_support:
+        raise KsftSkipEx("no input-xfrm supported")
+    # Disabling two at once should not work either without kernel changes
+    with ksft_raises(NlError):
+        set_rss(cfg, 0, {"tcp4": {"ip-src"}})
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


