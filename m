Return-Path: <netdev+bounces-222300-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A9D5B53CE8
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 22:07:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01A0D1CC63A3
	for <lists+netdev@lfdr.de>; Thu, 11 Sep 2025 20:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FBF727B35C;
	Thu, 11 Sep 2025 20:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b="KTps+Ak3"
X-Original-To: netdev@vger.kernel.org
Received: from mail1.fiberby.net (mail1.fiberby.net [193.104.135.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D06C272814;
	Thu, 11 Sep 2025 20:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.104.135.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757621137; cv=none; b=UCbJUjWVRY+9UI/Uk3DfvSOsUKBexl3BpDz7zmuY92s9cfdmN2c847A4a84xv4fs44chYcu5zntpRd60SUFe3tfUXBakuPOJO3AA8+0w7u0ZTXTXfDuWvdvRVg44j4h0vnCa/ZWpgh2CxeFwgbGpReFoYXFFj1wVat7Fslrjz68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757621137; c=relaxed/simple;
	bh=lcInuRuB+vNuJa4fGRHJlvJD9iDvGJACqmazL3h49mo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MHvVTUvh4Rmkgv4YC7Kne2OuCSirs5E3mwIN9WMH36YS6Vx1zSNjrRhVzHg6RId/f9j4ZUnFsa3Vd9AB7+KSbqb6OSCCOiaU4mwTfza8ftr4jEekUQy1vx7xeqjAV/ySKPSJB7phcYhpU5lOMLMECRlRsnrhtv1NwyRm87ttSh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net; spf=pass smtp.mailfrom=fiberby.net; dkim=pass (2048-bit key) header.d=fiberby.net header.i=@fiberby.net header.b=KTps+Ak3; arc=none smtp.client-ip=193.104.135.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fiberby.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fiberby.net
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=fiberby.net;
	s=202008; t=1757621127;
	bh=lcInuRuB+vNuJa4fGRHJlvJD9iDvGJACqmazL3h49mo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KTps+Ak3z9B88aI2xES6gW/itFyEksAj2Na5VSiHTFw496zhNGJYX75h/HwL4u6Yi
	 zhLSI75/6qifk21s3i+vDBYCe44U3iVHaDscqq/tIuX9qV5swoIdgtib92Iw5zMl4Y
	 G6MCd63pj4T84dTcJskwwpIRY5aGMYjBnlGaJSALslf1HWrO4EzJUd1gm1gw+40FXi
	 4SywbKNn86VDw6I8xRGLE4Qo0kfnrx084mFu4CIOk76S095+VqzlRNqTNbSvsKdsNj
	 wInScr1wtH4WUzXGdl2GAmSVmKI0zeWMcLAFyfzRcY9RJZc/wtSIvUjFzjXu6RCK3J
	 TH1xTKvzl/Ylw==
Received: from x201s (193-104-135-243.ip4.fiberby.net [193.104.135.243])
	by mail1.fiberby.net (Postfix) with ESMTPSA id 2C1D460137;
	Thu, 11 Sep 2025 20:05:27 +0000 (UTC)
Received: by x201s (Postfix, from userid 1000)
	id 20275204CAF; Thu, 11 Sep 2025 20:05:21 +0000 (UTC)
From: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: =?UTF-8?q?Asbj=C3=B8rn=20Sloth=20T=C3=B8nnesen?= <ast@fiberby.net>,
	Donald Hunter <donald.hunter@gmail.com>,
	Simon Horman <horms@kernel.org>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Sabrina Dubroca <sd@queasysnail.net>,
	wireguard@lists.zx2c4.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v3 07/13] tools: ynl-gen: avoid repetitive variables definitions
Date: Thu, 11 Sep 2025 20:05:00 +0000
Message-ID: <20250911200508.79341-8-ast@fiberby.net>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250911200508.79341-1-ast@fiberby.net>
References: <20250911200508.79341-1-ast@fiberby.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

In the generated attribute parsing code, avoid repetitively
defining the same variables over and over again, local to
the conditional block for each attribute.

This patch consolidates the definitions of local variables
for attribute parsing, so that they are defined at the
function level, and re-used across attributes, thus making
the generated code read more natural.

If attributes defines identical local_vars, then they will
be deduplicated, attributes are assumed to only use their
local variables transiently.

The example below shows how `len` was defined repeatedly in
tools/net/ynl/generated/nl80211-user.c:

nl80211_iftype_data_attrs_parse(..) {
   [..]
   ynl_attr_for_each_nested(attr, nested) {
     unsigned int type = ynl_attr_type(attr);

     if (type == NL80211_BAND_IFTYPE_ATTR_IFTYPES) {
       unsigned int len;
       [..]
     } else if (type == NL80211_BAND_IFTYPE_ATTR_HE_CAP_MAC) {
       unsigned int len;
       [..]
     [same pattern 8 times, so 11 times in total]
     } else if (type == NL80211_BAND_IFTYPE_ATTR_EHT_CAP_PPE) {
       unsigned int len;
       [..]
     }
   }
   return 0;
}

This patch results in this diffstat for the generated code:

$ diff -Naur pre/ post/ | diffstat
  devlink-user.c      |  187 +++----------------
  dpll-user.c         |   10 -
  ethtool-user.c      |   49 +----
  fou-user.c          |    5
  handshake-user.c    |    3
  mptcp_pm-user.c     |    3
  nfsd-user.c         |   16 -
  nl80211-user.c      |  159 +---------------
  nlctrl-user.c       |   21 --
  ovpn-user.c         |    7
  ovs_datapath-user.c |    9
  ovs_flow-user.c     |   89 ---------
  ovs_vport-user.c    |    7
  rt-addr-user.c      |   14 -
  rt-link-user.c      |  183 ++----------------
  rt-neigh-user.c     |   14 -
  rt-route-user.c     |   26 --
  rt-rule-user.c      |   11 -
  tc-user.c           |  380 +++++----------------------------------
  tcp_metrics-user.c  |    7
  team-user.c         |    5
  21 files changed, 175 insertions(+), 1030 deletions(-)

The changed lines are mostly `unsigned int len;` definitions:

$ diff -Naur pre/ post/ | grep ^[-+] | grep -v '^[-+]\{3\}' |
  grep -v '^.$' | sed -e 's/\t\+/ /g' | sort | uniq -c | sort -nr
    488 - unsigned int len;
    153 + unsigned int len;
     24 - const struct nlattr *attr2;
     18 + const struct nlattr *attr2;
      1 - __u32 policy_id, attr_id;
      1 + __u32 policy_id, attr_id;
      1 - __u32 op_id;
      1 + __u32 op_id;
      1 - const struct nlattr *attr_policy_id, *attr_attr_id;
      1 + const struct nlattr *attr_policy_id, *attr_attr_id;
      1 - const struct nlattr *attr_op_id;
      1 + const struct nlattr *attr_op_id;

Suggested-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Asbjørn Sloth Tønnesen <ast@fiberby.net>
---
 tools/net/ynl/pyynl/ynl_gen_c.py | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/tools/net/ynl/pyynl/ynl_gen_c.py b/tools/net/ynl/pyynl/ynl_gen_c.py
index b3ce0901a19b..d63b63ac0b8e 100755
--- a/tools/net/ynl/pyynl/ynl_gen_c.py
+++ b/tools/net/ynl/pyynl/ynl_gen_c.py
@@ -247,7 +247,7 @@ class Type(SpecAttr):
         raise Exception(f"Attr get not implemented for class type {self.type}")
 
     def attr_get(self, ri, var, first):
-        lines, init_lines, local_vars = self._attr_get(ri, var)
+        lines, init_lines, _ = self._attr_get(ri, var)
         if type(lines) is str:
             lines = [lines]
         if type(init_lines) is str:
@@ -255,10 +255,6 @@ class Type(SpecAttr):
 
         kw = 'if' if first else 'else if'
         ri.cw.block_start(line=f"{kw} (type == {self.enum_name})")
-        if local_vars:
-            for local in local_vars:
-                ri.cw.p(local)
-            ri.cw.nl()
 
         if not self.is_multi_val():
             ri.cw.p("if (ynl_attr_validate(yarg, attr))")
@@ -2124,6 +2120,7 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             else:
                 raise Exception("Per-op fixed header not supported, yet")
 
+    var_set = set()
     array_nests = set()
     multi_attrs = set()
     needs_parg = False
@@ -2141,6 +2138,13 @@ def _multi_parse(ri, struct, init_lines, local_vars):
             multi_attrs.add(arg)
         needs_parg |= 'nested-attributes' in aspec
         needs_parg |= 'sub-message' in aspec
+
+        try:
+            _, _, l_vars = aspec._attr_get(ri, '')
+            var_set |= set(l_vars) if l_vars else set()
+        except Exception:
+            pass  # _attr_get() not implemented by simple types, ignore
+    local_vars += list(var_set)
     if array_nests or multi_attrs:
         local_vars.append('int i;')
     if needs_parg:
-- 
2.51.0


