Return-Path: <netdev+bounces-191242-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D8C35ABA74C
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 02:14:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F7111C01CEA
	for <lists+netdev@lfdr.de>; Sat, 17 May 2025 00:14:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2796A175A5;
	Sat, 17 May 2025 00:13:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cOf26Age"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED43BEEB5
	for <netdev@vger.kernel.org>; Sat, 17 May 2025 00:13:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747440814; cv=none; b=dm8115HyRiAwf0OMjnnfczlMFHx1LWC841hBYeP3KPEfgCF3if5OURZq3TfdKOSz3Rg8Me+J87pGbakoh9BaOEQ1SkyGlQIdtUWpcnr0WfApT7jy68E/SiFoSBrfNcq+po2WB5cCisML2G47rrr765KvViWNT7bwvwCC58onsP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747440814; c=relaxed/simple;
	bh=lTTjHdTVWId5wZjuM0boAho0KU3rTDKPqCXX5WMRKzM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tm3WoOgG11thwzZVy9uqb2Zrma+9W1Ox7lAWzFpLItMDoPwpOs5U5SDxefmHjOLPpE4Ah20L19ESxkgZbrTWScZp4Zn1McrPv3YW+0LxAwgYTGsUGTD3JpvDa6R1F1256mJI1Xsew3OcLj/Q8RZdFedgKR/pLQnyWVwav5pwO2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cOf26Age; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87A1DC4CEE4;
	Sat, 17 May 2025 00:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747440813;
	bh=lTTjHdTVWId5wZjuM0boAho0KU3rTDKPqCXX5WMRKzM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cOf26AgeHogB62iKRM5+BriBU115X8AagS7LIp8ls7Z5Gb8vNMLfNTf/Ze2ImD4uk
	 W3fJ+FVuDO1bjiDjrhw3WUQCidehFWIXHLEF/0vxtBzBxXqqRWUcec7/duPN4w2Zh2
	 rhazfG9ZXtqhs/SaHlM825NfZIER0DDL7d9PKZ9Yx5j/mMshEG4nXvUY2VscwKTl9U
	 NngFRlXToapqhV9B+iRTFWKo6reVt/5d71Wpmb6lKIJHoChL6KI3n9zm05GpkGaNc9
	 sjH06h9Fudy3c7/uvKZGY92pi4lt/gsy4HaIOg83Gfo/onZPuhrPeqSF0cJhZrQMVB
	 16YNfswhnutzw==
From: Jakub Kicinski <kuba@kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org,
	edumazet@google.com,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	horms@kernel.org,
	donald.hunter@gmail.com,
	jacob.e.keller@intel.com,
	sdf@fomichev.me,
	jstancek@redhat.com,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH net-next 04/11] netlink: specs: tc: drop the family name prefix from attrs
Date: Fri, 16 May 2025 17:13:11 -0700
Message-ID: <20250517001318.285800-5-kuba@kernel.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250517001318.285800-1-kuba@kernel.org>
References: <20250517001318.285800-1-kuba@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All attribute sets and messages are prefixed with tc-.
The C codegen also adds the family name to all structs.
We end up with names like struct tc_tc_act_attrs.
Remove the tc- prefixes to shorten the names.
This should not impact Python as the attr set names
are never exposed to user, they are only used to refer
to things internally, in the encoder / decoder.

Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 Documentation/netlink/specs/tc.yaml | 334 ++++++++++++++--------------
 1 file changed, 167 insertions(+), 167 deletions(-)

diff --git a/Documentation/netlink/specs/tc.yaml b/Documentation/netlink/specs/tc.yaml
index 8d5e5cb439e4..6e8db7adde3c 100644
--- a/Documentation/netlink/specs/tc.yaml
+++ b/Documentation/netlink/specs/tc.yaml
@@ -35,7 +35,7 @@ protonum: 0
         name: info
         type: u32
   -
-    name: tc-cls-flags
+    name: cls-flags
     enum-name:
     type: flags
     entries:
@@ -45,7 +45,7 @@ protonum: 0
       - not-in-nw
       - verbose
   -
-    name: tc-flower-key-ctrl-flags
+    name: flower-key-ctrl-flags
     name-prefix: tca-flower-key-flags-
     enum-name:
     type: flags
@@ -1383,7 +1383,7 @@ protonum: 0
         type: s32
 attribute-sets:
   -
-    name: tc-attrs
+    name: attrs
     name-prefix: tca-
     attributes:
       -
@@ -1392,7 +1392,7 @@ protonum: 0
       -
         name: options
         type: sub-message
-        sub-message: tc-options-msg
+        sub-message: options-msg
         selector: kind
       -
         name: stats
@@ -1443,7 +1443,7 @@ protonum: 0
         name: ext-warn-msg
         type: string
   -
-    name: tc-act-attrs
+    name: act-attrs
     name-prefix: tca-act-
     attributes:
       -
@@ -1452,7 +1452,7 @@ protonum: 0
       -
         name: options
         type: sub-message
-        sub-message: tc-act-options-msg
+        sub-message: act-options-msg
         selector: kind
       -
         name: index
@@ -1480,7 +1480,7 @@ protonum: 0
         name: in-hw-count
         type: u32
   -
-    name: tc-act-bpf-attrs
+    name: act-bpf-attrs
     name-prefix: tca-act-bpf-
     header: linux/tc_act/tc_bpf.h
     attributes:
@@ -1513,7 +1513,7 @@ protonum: 0
         name: id
         type: binary
   -
-    name: tc-act-connmark-attrs
+    name: act-connmark-attrs
     name-prefix: tca-connmark-
     header: linux/tc_act/tc_connmark.h
     attributes:
@@ -1528,7 +1528,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-csum-attrs
+    name: act-csum-attrs
     name-prefix: tca-csum-
     header: linux/tc_act/tc_csum.h
     attributes:
@@ -1543,7 +1543,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-ct-attrs
+    name: act-ct-attrs
     name-prefix: tca-ct-
     header: linux/tc_act/tc_ct.h
     attributes:
@@ -1607,7 +1607,7 @@ protonum: 0
         name: helper-proto
         type: u8
   -
-    name: tc-act-ctinfo-attrs
+    name: act-ctinfo-attrs
     name-prefix: tca-ctinfo-
     header: linux/tc_act/tc_ctinfo.h
     attributes:
@@ -1643,7 +1643,7 @@ protonum: 0
         name: stats-cpmark-set
         type: u64
   -
-    name: tc-act-gate-attrs
+    name: act-gate-attrs
     name-prefix: tca-gate-
     header: linux/tc_act/tc_gate.h
     attributes:
@@ -1679,7 +1679,7 @@ protonum: 0
         name: clockid
         type: s32
   -
-    name: tc-act-ife-attrs
+    name: act-ife-attrs
     name-prefix: tca-ife-
     header: linux/tc_act/tc_ife.h
     attributes:
@@ -1706,7 +1706,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-mirred-attrs
+    name: act-mirred-attrs
     name-prefix: tca-mirred-
     header: linux/tc_act/tc_mirred.h
     attributes:
@@ -1724,7 +1724,7 @@ protonum: 0
         name: blockid
         type: binary
   -
-    name: tc-act-mpls-attrs
+    name: act-mpls-attrs
     name-prefix: tca-mpls-
     header: linux/tc_act/tc_mpls.h
     attributes:
@@ -1756,7 +1756,7 @@ protonum: 0
         name: bos
         type: u8
   -
-    name: tc-act-nat-attrs
+    name: act-nat-attrs
     name-prefix: tca-nat-
     header: linux/tc_act/tc_nat.h
     attributes:
@@ -1771,7 +1771,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-pedit-attrs
+    name: act-pedit-attrs
     name-prefix: tca-pedit-
     header: linux/tc_act/tc_pedit.h
     attributes:
@@ -1796,7 +1796,7 @@ protonum: 0
         name: key-ex
         type: binary
   -
-    name: tc-act-simple-attrs
+    name: act-simple-attrs
     name-prefix: tca-def-
     header: linux/tc_act/tc_defact.h
     attributes:
@@ -1814,7 +1814,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-skbedit-attrs
+    name: act-skbedit-attrs
     name-prefix: tca-skbedit-
     header: linux/tc_act/tc_skbedit.h
     attributes:
@@ -1850,7 +1850,7 @@ protonum: 0
         name: queue-mapping-max
         type: u16
   -
-    name: tc-act-skbmod-attrs
+    name: act-skbmod-attrs
     name-prefix: tca-skbmod-
     header: linux/tc_act/tc_skbmod.h
     attributes:
@@ -1874,7 +1874,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-tunnel-key-attrs
+    name: act-tunnel-key-attrs
     name-prefix: tca-tunnel-key-
     header: linux/tc_act/tc_tunnel_key.h
     attributes:
@@ -1926,7 +1926,7 @@ protonum: 0
         name: no-frag
         type: flag
   -
-    name: tc-act-vlan-attrs
+    name: act-vlan-attrs
     name-prefix: tca-vlan-
     header: linux/tc_act/tc_vlan.h
     attributes:
@@ -1957,7 +1957,7 @@ protonum: 0
         name: push-eth-src
         type: binary
   -
-    name: tc-basic-attrs
+    name: basic-attrs
     name-prefix: tca-basic-
     attributes:
       -
@@ -1966,16 +1966,16 @@ protonum: 0
       -
         name: ematches
         type: nest
-        nested-attributes: tc-ematch-attrs
+        nested-attributes: ematch-attrs
       -
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: pcnt
         type: binary
@@ -1984,18 +1984,18 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-bpf-attrs
+    name: bpf-attrs
     name-prefix: tca-bpf-
     attributes:
       -
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: classid
         type: u32
@@ -2024,7 +2024,7 @@ protonum: 0
         name: id
         type: u32
   -
-    name: tc-cake-attrs
+    name: cake-attrs
     name-prefix: tca-cake-
     attributes:
       -
@@ -2082,7 +2082,7 @@ protonum: 0
         name: fwmark
         type: u32
   -
-    name: tc-cake-stats-attrs
+    name: cake-stats-attrs
     name-prefix: tca-cake-stats-
     attributes:
       -
@@ -2116,7 +2116,7 @@ protonum: 0
         name: tin-stats
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-cake-tin-stats-attrs
+        nested-attributes: cake-tin-stats-attrs
       -
         name: deficit
         type: s32
@@ -2136,7 +2136,7 @@ protonum: 0
         name: blue-timer-us
         type: s32
   -
-    name: tc-cake-tin-stats-attrs
+    name: cake-tin-stats-attrs
     name-prefix: tca-cake-tin-stats-
     attributes:
       -
@@ -2215,7 +2215,7 @@ protonum: 0
         name: flow-quantum
         type: u32
   -
-    name: tc-cbs-attrs
+    name: cbs-attrs
     name-prefix: tca-cbs-
     attributes:
       -
@@ -2223,23 +2223,23 @@ protonum: 0
         type: binary
         struct: tc-cbs-qopt
   -
-    name: tc-cgroup-attrs
+    name: cgroup-attrs
     name-prefix: tca-cgroup-
     attributes:
       -
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: ematches
         type: binary
   -
-    name: tc-choke-attrs
+    name: choke-attrs
     name-prefix: tca-choke-
     attributes:
       -
@@ -2256,7 +2256,7 @@ protonum: 0
         name: max-p
         type: u32
   -
-    name: tc-codel-attrs
+    name: codel-attrs
     name-prefix: tca-codel-
     attributes:
       -
@@ -2275,14 +2275,14 @@ protonum: 0
         name: ce-threshold
         type: u32
   -
-    name: tc-drr-attrs
+    name: drr-attrs
     name-prefix: tca-drr-
     attributes:
       -
         name: quantum
         type: u32
   -
-    name: tc-ematch-attrs
+    name: ematch-attrs
     name-prefix: tca-ematch-
     attr-max-name: tca-ematch-tree-max
     attributes:
@@ -2294,7 +2294,7 @@ protonum: 0
         name: tree-list
         type: binary
   -
-    name: tc-flow-attrs
+    name: flow-attrs
     name-prefix: tca-flow-
     attributes:
       -
@@ -2327,7 +2327,7 @@ protonum: 0
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: ematches
         type: binary
@@ -2335,7 +2335,7 @@ protonum: 0
         name: perturb
         type: u32
   -
-    name: tc-flower-attrs
+    name: flower-attrs
     name-prefix: tca-flower-
     attributes:
       -
@@ -2348,7 +2348,7 @@ protonum: 0
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: key-eth-dst
         type: binary
@@ -2427,7 +2427,7 @@ protonum: 0
       -
         name: flags
         type: u32
-        enum: tc-cls-flags
+        enum: cls-flags
         enum-as-flags: true
       -
         name: key-vlan-id
@@ -2532,13 +2532,13 @@ protonum: 0
         name: key-flags
         type: u32
         byte-order: big-endian
-        enum: tc-flower-key-ctrl-flags
+        enum: flower-key-ctrl-flags
         enum-as-flags: true
       -
         name: key-flags-mask
         type: u32
         byte-order: big-endian
-        enum: tc-flower-key-ctrl-flags
+        enum: flower-key-ctrl-flags
         enum-as-flags: true
       -
         name: key-icmpv4-code
@@ -2661,11 +2661,11 @@ protonum: 0
       -
         name: key-enc-opts
         type: nest
-        nested-attributes: tc-flower-key-enc-opts-attrs
+        nested-attributes: flower-key-enc-opts-attrs
       -
         name: key-enc-opts-mask
         type: nest
-        nested-attributes: tc-flower-key-enc-opts-attrs
+        nested-attributes: flower-key-enc-opts-attrs
       -
         name: in-hw-count
         type: u32
@@ -2712,7 +2712,7 @@ protonum: 0
       -
         name: key-mpls-opts
         type: nest
-        nested-attributes: tc-flower-key-mpls-opt-attrs
+        nested-attributes: flower-key-mpls-opt-attrs
       -
         name: key-hash
         type: u32
@@ -2740,7 +2740,7 @@ protonum: 0
       -
         name: key-cfm
         type: nest
-        nested-attributes: tc-flower-key-cfm-attrs
+        nested-attributes: flower-key-cfm-attrs
       -
         name: key-spi
         type: u32
@@ -2753,36 +2753,36 @@ protonum: 0
         name: key-enc-flags
         type: u32
         byte-order: big-endian
-        enum: tc-flower-key-ctrl-flags
+        enum: flower-key-ctrl-flags
         enum-as-flags: true
       -
         name: key-enc-flags-mask
         type: u32
         byte-order: big-endian
-        enum: tc-flower-key-ctrl-flags
+        enum: flower-key-ctrl-flags
         enum-as-flags: true
   -
-    name: tc-flower-key-enc-opts-attrs
+    name: flower-key-enc-opts-attrs
     name-prefix: tca-flower-key-enc-opts-
     attributes:
       -
         name: geneve
         type: nest
-        nested-attributes: tc-flower-key-enc-opt-geneve-attrs
+        nested-attributes: flower-key-enc-opt-geneve-attrs
       -
         name: vxlan
         type: nest
-        nested-attributes: tc-flower-key-enc-opt-vxlan-attrs
+        nested-attributes: flower-key-enc-opt-vxlan-attrs
       -
         name: erspan
         type: nest
-        nested-attributes: tc-flower-key-enc-opt-erspan-attrs
+        nested-attributes: flower-key-enc-opt-erspan-attrs
       -
         name: gtp
         type: nest
-        nested-attributes: tc-flower-key-enc-opt-gtp-attrs
+        nested-attributes: flower-key-enc-opt-gtp-attrs
   -
-    name: tc-flower-key-enc-opt-geneve-attrs
+    name: flower-key-enc-opt-geneve-attrs
     name-prefix: tca-flower-key-enc-opt-geneve-
     attributes:
       -
@@ -2795,14 +2795,14 @@ protonum: 0
         name: data
         type: binary
   -
-    name: tc-flower-key-enc-opt-vxlan-attrs
+    name: flower-key-enc-opt-vxlan-attrs
     name-prefix: tca-flower-key-enc-opt-vxlan-
     attributes:
       -
         name: gbp
         type: u32
   -
-    name: tc-flower-key-enc-opt-erspan-attrs
+    name: flower-key-enc-opt-erspan-attrs
     name-prefix: tca-flower-key-enc-opt-erspan-
     attributes:
       -
@@ -2818,7 +2818,7 @@ protonum: 0
         name: hwid
         type: u8
   -
-    name: tc-flower-key-enc-opt-gtp-attrs
+    name: flower-key-enc-opt-gtp-attrs
     name-prefix: tca-flower-key-enc-opt-gtp-
     attributes:
       -
@@ -2828,7 +2828,7 @@ protonum: 0
         name: qfi
         type: u8
   -
-    name: tc-flower-key-mpls-opt-attrs
+    name: flower-key-mpls-opt-attrs
     name-prefix: tca-flower-key-mpls-opt-
     attr-max-name: tca-flower-key-mpls-opt-lse-max
     attributes:
@@ -2848,7 +2848,7 @@ protonum: 0
         name: lse-label
         type: u32
   -
-    name: tc-flower-key-cfm-attrs
+    name: flower-key-cfm-attrs
     name-prefix: tca-flower-key-cfm-
     attributes:
       -
@@ -2858,7 +2858,7 @@ protonum: 0
         name: opcode
         type: u8
   -
-    name: tc-fw-attrs
+    name: fw-attrs
     name-prefix: tca-fw-
     attributes:
       -
@@ -2867,7 +2867,7 @@ protonum: 0
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: indev
         type: string
@@ -2875,12 +2875,12 @@ protonum: 0
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: mask
         type: u32
   -
-    name: tc-gred-attrs
+    name: gred-attrs
     name-prefix: tca-gred-
     attributes:
       -
@@ -2955,7 +2955,7 @@ protonum: 0
         name: flags
         type: u32
   -
-    name: tc-hfsc-attrs
+    name: hfsc-attrs
     attributes:
       -
         name: rsc
@@ -2967,7 +2967,7 @@ protonum: 0
         name: usc
         type: binary
   -
-    name: tc-hhf-attrs
+    name: hhf-attrs
     name-prefix: tca-hhf-
     attributes:
       -
@@ -2992,7 +2992,7 @@ protonum: 0
         name: non-hh-weight
         type: u32
   -
-    name: tc-htb-attrs
+    name: htb-attrs
     name-prefix: tca-htb-
     attributes:
       -
@@ -3025,7 +3025,7 @@ protonum: 0
         name: offload
         type: flag
   -
-    name: tc-matchall-attrs
+    name: matchall-attrs
     name-prefix: tca-matchall-
     attributes:
       -
@@ -3035,7 +3035,7 @@ protonum: 0
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: flags
         type: u32
@@ -3047,7 +3047,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-etf-attrs
+    name: etf-attrs
     name-prefix: tca-etf-
     attributes:
       -
@@ -3055,7 +3055,7 @@ protonum: 0
         type: binary
         struct: tc-etf-qopt
   -
-    name: tc-ets-attrs
+    name: ets-attrs
     name-prefix: tca-ets-
     attributes:
       -
@@ -3067,7 +3067,7 @@ protonum: 0
       -
         name: quanta
         type: nest
-        nested-attributes: tc-ets-attrs
+        nested-attributes: ets-attrs
       -
         name: quanta-band
         type: u32
@@ -3075,13 +3075,13 @@ protonum: 0
       -
         name: priomap
         type: nest
-        nested-attributes: tc-ets-attrs
+        nested-attributes: ets-attrs
       -
         name: priomap-band
         type: u8
         multi-attr: true
   -
-    name: tc-fq-attrs
+    name: fq-attrs
     name-prefix: tca-fq-
     attributes:
       -
@@ -3153,7 +3153,7 @@ protonum: 0
         sub-type: s32
         doc: Weights for each band
   -
-    name: tc-fq-codel-attrs
+    name: fq-codel-attrs
     name-prefix: tca-fq-codel-
     attributes:
       -
@@ -3190,7 +3190,7 @@ protonum: 0
         name: ce-threshold-mask
         type: u8
   -
-    name: tc-fq-pie-attrs
+    name: fq-pie-attrs
     name-prefix: tca-fq-pie-
     attributes:
       -
@@ -3230,7 +3230,7 @@ protonum: 0
         name: dq-rate-estimator
         type: u32
   -
-    name: tc-netem-attrs
+    name: netem-attrs
     name-prefix: tca-netem-
     attributes:
       -
@@ -3252,7 +3252,7 @@ protonum: 0
       -
         name: loss
         type: nest
-        nested-attributes: tc-netem-loss-attrs
+        nested-attributes: netem-loss-attrs
       -
         name: rate
         type: binary
@@ -3284,7 +3284,7 @@ protonum: 0
         name: prng-seed
         type: u64
   -
-    name: tc-netem-loss-attrs
+    name: netem-loss-attrs
     name-prefix: netem-loss-
     attributes:
       -
@@ -3298,7 +3298,7 @@ protonum: 0
         doc: Gilbert Elliot models
         struct: tc-netem-gemodel
   -
-    name: tc-pie-attrs
+    name: pie-attrs
     name-prefix: tca-pie-
     attributes:
       -
@@ -3326,7 +3326,7 @@ protonum: 0
         name: dq-rate-estimator
         type: u32
   -
-    name: tc-police-attrs
+    name: police-attrs
     name-prefix: tca-police-
     attributes:
       -
@@ -3365,7 +3365,7 @@ protonum: 0
         name: pktburst64
         type: u64
   -
-    name: tc-qfq-attrs
+    name: qfq-attrs
     name-prefix: tca-qfq-
     attributes:
       -
@@ -3375,7 +3375,7 @@ protonum: 0
         name: lmax
         type: u32
   -
-    name: tc-red-attrs
+    name: red-attrs
     name-prefix: tca-red-
     attributes:
       -
@@ -3398,7 +3398,7 @@ protonum: 0
         name: mark-block
         type: u32
   -
-    name: tc-route-attrs
+    name: route-attrs
     name-prefix: tca-route4-
     attributes:
       -
@@ -3416,14 +3416,14 @@ protonum: 0
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
   -
-    name: tc-taprio-attrs
+    name: taprio-attrs
     name-prefix: tca-taprio-attr-
     attributes:
       -
@@ -3433,14 +3433,14 @@ protonum: 0
       -
         name: sched-entry-list
         type: nest
-        nested-attributes: tc-taprio-sched-entry-list
+        nested-attributes: taprio-sched-entry-list
       -
         name: sched-base-time
         type: s64
       -
         name: sched-single-entry
         type: nest
-        nested-attributes: tc-taprio-sched-entry
+        nested-attributes: taprio-sched-entry
       -
         name: sched-clockid
         type: s32
@@ -3465,18 +3465,18 @@ protonum: 0
       -
         name: tc-entry
         type: nest
-        nested-attributes: tc-taprio-tc-entry-attrs
+        nested-attributes: taprio-tc-entry-attrs
   -
-    name: tc-taprio-sched-entry-list
+    name: taprio-sched-entry-list
     name-prefix: tca-taprio-sched-
     attributes:
       -
         name: entry
         type: nest
-        nested-attributes: tc-taprio-sched-entry
+        nested-attributes: taprio-sched-entry
         multi-attr: true
   -
-    name: tc-taprio-sched-entry
+    name: taprio-sched-entry
     name-prefix: tca-taprio-sched-entry-
     attributes:
       -
@@ -3492,7 +3492,7 @@ protonum: 0
         name: interval
         type: u32
   -
-    name: tc-taprio-tc-entry-attrs
+    name: taprio-tc-entry-attrs
     name-prefix: tca-taprio-tc-entry-
     attributes:
       -
@@ -3505,7 +3505,7 @@ protonum: 0
         name: fp
         type: u32
   -
-    name: tc-tbf-attrs
+    name: tbf-attrs
     name-prefix: tca-tbf-
     attributes:
       -
@@ -3534,7 +3534,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-sample-attrs
+    name: act-sample-attrs
     name-prefix: tca-sample-
     header: linux/tc_act/tc_sample.h
     attributes:
@@ -3559,7 +3559,7 @@ protonum: 0
         name: pad
         type: pad
   -
-    name: tc-act-gact-attrs
+    name: act-gact-attrs
     name-prefix: tca-gact-
     header: linux/tc_act/tc_gact.h
     attributes:
@@ -3626,7 +3626,7 @@ protonum: 0
         name: pkt64
         type: u64
   -
-    name: tc-u32-attrs
+    name: u32-attrs
     name-prefix: tca-u32-
     attributes:
       -
@@ -3648,12 +3648,12 @@ protonum: 0
       -
         name: police
         type: nest
-        nested-attributes: tc-police-attrs
+        nested-attributes: police-attrs
       -
         name: act
         type: indexed-array
         sub-type: nest
-        nested-attributes: tc-act-attrs
+        nested-attributes: act-attrs
       -
         name: indev
         type: string
@@ -3674,78 +3674,78 @@ protonum: 0
 
 sub-messages:
   -
-    name: tc-options-msg
+    name: options-msg
     formats:
       -
         value: basic
-        attribute-set: tc-basic-attrs
+        attribute-set: basic-attrs
       -
         value: bpf
-        attribute-set: tc-bpf-attrs
+        attribute-set: bpf-attrs
       -
         value: bfifo
         fixed-header: tc-fifo-qopt
       -
         value: cake
-        attribute-set: tc-cake-attrs
+        attribute-set: cake-attrs
       -
         value: cbs
-        attribute-set: tc-cbs-attrs
+        attribute-set: cbs-attrs
       -
         value: cgroup
-        attribute-set: tc-cgroup-attrs
+        attribute-set: cgroup-attrs
       -
         value: choke
-        attribute-set: tc-choke-attrs
+        attribute-set: choke-attrs
       -
         value: clsact # no content
       -
         value: codel
-        attribute-set: tc-codel-attrs
+        attribute-set: codel-attrs
       -
         value: drr
-        attribute-set: tc-drr-attrs
+        attribute-set: drr-attrs
       -
         value: etf
-        attribute-set: tc-etf-attrs
+        attribute-set: etf-attrs
       -
         value: ets
-        attribute-set: tc-ets-attrs
+        attribute-set: ets-attrs
       -
         value: flow
-        attribute-set: tc-flow-attrs
+        attribute-set: flow-attrs
       -
         value: flower
-        attribute-set: tc-flower-attrs
+        attribute-set: flower-attrs
       -
         value: fq
-        attribute-set: tc-fq-attrs
+        attribute-set: fq-attrs
       -
         value: fq_codel
-        attribute-set: tc-fq-codel-attrs
+        attribute-set: fq-codel-attrs
       -
         value: fq_pie
-        attribute-set: tc-fq-pie-attrs
+        attribute-set: fq-pie-attrs
       -
         value: fw
-        attribute-set: tc-fw-attrs
+        attribute-set: fw-attrs
       -
         value: gred
-        attribute-set: tc-gred-attrs
+        attribute-set: gred-attrs
       -
         value: hfsc
         fixed-header: tc-hfsc-qopt
       -
         value: hhf
-        attribute-set: tc-hhf-attrs
+        attribute-set: hhf-attrs
       -
         value: htb
-        attribute-set: tc-htb-attrs
+        attribute-set: htb-attrs
       -
         value: ingress # no content
       -
         value: matchall
-        attribute-set: tc-matchall-attrs
+        attribute-set: matchall-attrs
       -
         value: mq # no content
       -
@@ -3757,7 +3757,7 @@ protonum: 0
       -
         value: netem
         fixed-header: tc-netem-qopt
-        attribute-set: tc-netem-attrs
+        attribute-set: netem-attrs
       -
         value: pfifo
         fixed-header: tc-fifo-qopt
@@ -3769,7 +3769,7 @@ protonum: 0
         fixed-header: tc-fifo-qopt
       -
         value: pie
-        attribute-set: tc-pie-attrs
+        attribute-set: pie-attrs
       -
         value: plug
         fixed-header: tc-plug-qopt
@@ -3778,13 +3778,13 @@ protonum: 0
         fixed-header: tc-prio-qopt
       -
         value: qfq
-        attribute-set: tc-qfq-attrs
+        attribute-set: qfq-attrs
       -
         value: red
-        attribute-set: tc-red-attrs
+        attribute-set: red-attrs
       -
         value: route
-        attribute-set: tc-route-attrs
+        attribute-set: route-attrs
       -
         value: sfb
         fixed-header: tc-sfb-qopt
@@ -3793,79 +3793,79 @@ protonum: 0
         fixed-header: tc-sfq-qopt-v1
       -
         value: taprio
-        attribute-set: tc-taprio-attrs
+        attribute-set: taprio-attrs
       -
         value: tbf
-        attribute-set: tc-tbf-attrs
+        attribute-set: tbf-attrs
       -
         value: u32
-        attribute-set: tc-u32-attrs
+        attribute-set: u32-attrs
   -
-    name: tc-act-options-msg
+    name: act-options-msg
     formats:
       -
         value: bpf
-        attribute-set: tc-act-bpf-attrs
+        attribute-set: act-bpf-attrs
       -
         value: connmark
-        attribute-set: tc-act-connmark-attrs
+        attribute-set: act-connmark-attrs
       -
         value: csum
-        attribute-set: tc-act-csum-attrs
+        attribute-set: act-csum-attrs
       -
         value: ct
-        attribute-set: tc-act-ct-attrs
+        attribute-set: act-ct-attrs
       -
         value: ctinfo
-        attribute-set: tc-act-ctinfo-attrs
+        attribute-set: act-ctinfo-attrs
       -
         value: gact
-        attribute-set: tc-act-gact-attrs
+        attribute-set: act-gact-attrs
       -
         value: gate
-        attribute-set: tc-act-gate-attrs
+        attribute-set: act-gate-attrs
       -
         value: ife
-        attribute-set: tc-act-ife-attrs
+        attribute-set: act-ife-attrs
       -
         value: mirred
-        attribute-set: tc-act-mirred-attrs
+        attribute-set: act-mirred-attrs
       -
         value: mpls
-        attribute-set: tc-act-mpls-attrs
+        attribute-set: act-mpls-attrs
       -
         value: nat
-        attribute-set: tc-act-nat-attrs
+        attribute-set: act-nat-attrs
       -
         value: pedit
-        attribute-set: tc-act-pedit-attrs
+        attribute-set: act-pedit-attrs
       -
         value: police
-        attribute-set: tc-police-attrs
+        attribute-set: police-attrs
       -
         value: sample
-        attribute-set: tc-act-sample-attrs
+        attribute-set: act-sample-attrs
       -
         value: simple
-        attribute-set: tc-act-simple-attrs
+        attribute-set: act-simple-attrs
       -
         value: skbedit
-        attribute-set: tc-act-skbedit-attrs
+        attribute-set: act-skbedit-attrs
       -
         value: skbmod
-        attribute-set: tc-act-skbmod-attrs
+        attribute-set: act-skbmod-attrs
       -
         value: tunnel_key
-        attribute-set: tc-act-tunnel-key-attrs
+        attribute-set: act-tunnel-key-attrs
       -
         value: vlan
-        attribute-set: tc-act-vlan-attrs
+        attribute-set: act-vlan-attrs
   -
     name: tca-stats-app-msg
     formats:
       -
         value: cake
-        attribute-set: tc-cake-stats-attrs
+        attribute-set: cake-stats-attrs
       -
         value: choke
         fixed-header: tc-choke-xstats
@@ -3904,7 +3904,7 @@ protonum: 0
     -
       name: newqdisc
       doc: Create new tc qdisc.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3919,7 +3919,7 @@ protonum: 0
     -
       name: delqdisc
       doc: Delete existing tc qdisc.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3927,7 +3927,7 @@ protonum: 0
     -
       name: getqdisc
       doc: Get / dump tc qdisc information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3951,7 +3951,7 @@ protonum: 0
     -
       name: newtclass
       doc: Get / dump tc traffic class information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3960,7 +3960,7 @@ protonum: 0
     -
       name: deltclass
       doc: Get / dump tc traffic class information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3968,7 +3968,7 @@ protonum: 0
     -
       name: gettclass
       doc: Get / dump tc traffic class information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3979,7 +3979,7 @@ protonum: 0
     -
       name: newtfilter
       doc: Get / dump tc filter information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3988,7 +3988,7 @@ protonum: 0
     -
       name: deltfilter
       doc: Get / dump tc filter information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -3999,7 +3999,7 @@ protonum: 0
     -
       name: gettfilter
       doc: Get / dump tc filter information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -4022,7 +4022,7 @@ protonum: 0
     -
       name: newchain
       doc: Get / dump tc chain information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -4031,7 +4031,7 @@ protonum: 0
     -
       name: delchain
       doc: Get / dump tc chain information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
@@ -4041,7 +4041,7 @@ protonum: 0
     -
       name: getchain
       doc: Get / dump tc chain information.
-      attribute-set: tc-attrs
+      attribute-set: attrs
       fixed-header: tcmsg
       do:
         request:
-- 
2.49.0


