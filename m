Return-Path: <netdev+bounces-286969-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YPE2HWPMAmo+wwEAu9opvQ
	(envelope-from <netdev+bounces-286969-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:44:51 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA2B51B339
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:44:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93DE030DB714
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:39:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3888930F927;
	Tue, 12 May 2026 06:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WVT1Q9Ci"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5823E357D1C
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567967; cv=none; b=M77EP4X/4tu4UTxB1Xj1blaMPLMC1OHF8TguZtuPIuvWh+U/gSXjatxBr+ezw3mz7Inuief8M3WqKTog5eF3PeED+OuiFuF6L+kIbjoXfSoYcw/x+FpijsWDlzGj9jKNI7UZzIrOe2SSdGw68SGCdF20cjGmsp9Qy03TEhneTqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567967; c=relaxed/simple;
	bh=F0D9uBMI5aGMEztB75k87gNX78j9wlAlaSDvefDdL9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qr5N1I7hdQoyBY3xNVV7AM5WJMKkVzzXncAURxb4hxwt3egwUaJ4rAvzSpQYg5GHboxO/g+ErqAmKCkAKclruwbZPN5/0EMzzdbalvzEdN0y6Ewi1wQTJ7o2MG096e9FFK1Xu9/sqsRCkiXFmxxZLkdkAZ3LTT4GPHgpZTsmelM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WVT1Q9Ci; arc=none smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7dbec19732eso4790848a34.3
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567950; x=1779172750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ptrFwQmMmjwCIA4td+4pg3ne0cwkuwhONvtajOVMhB0=;
        b=WVT1Q9CivYkwRF3QTrdhq4YH+2u9yFajKr4SSfRGHTvopbps5WiCqpgmsaxk6NsQNP
         VbT4OYO0SgsE4H+jAPZtnKyg7mrBjbnWX+0D9ETsyse8JII5pJ3yKiLP1XU9MoRhUKY7
         4N7Bm1ognzVX0fYwqRuyhA+dMFR5pl+CIGc8EebS+gsE3buDJKK/TEKFYZC6YE7FzP+P
         fawFZqgze7X8aFozQ5hYKInbRC536ZIYatqFSV8wU9u6AzmZo0wW6gm4oqMtfCNeHXK/
         th2ht2SmAdNJ5I4NWXeHDmTT/iZR7UXVVSLbOL0fIYnxQFR30gu7FB+0Jl4x3vACreQw
         59mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567950; x=1779172750;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ptrFwQmMmjwCIA4td+4pg3ne0cwkuwhONvtajOVMhB0=;
        b=mje94CX/2G2TKB3JwBAcGCRI6uzNjF4OyyC/XwwPdpGtIN4+2klmRIiVPDBfisrhpw
         Oocaj2fBYPH9OdmC3uYfVbSw2pkLiZa8b5iZSWCfdQGXQr+Btk/NnLruRLLO735zFmFN
         4M24XtaHtENZ0zqtykfuCvZ7Mwkn2X5oNaATOFX/o9iAOxMVF29Sm3TdAXB9U0pd7FGh
         I2ocHjo9rbf6bx1Bjm2cleuBi3iSkPVgaSSi8P+zSMm8LHjCSiXaO8v9PHeJseiMFp/7
         W2F4xN2MywnSE3tG7XrLr/5cBJb/6ugpy+VEBroav2JmE8F+mNXHYPJi5rvaIYOhYY2X
         688A==
X-Gm-Message-State: AOJu0YzD2i5EZpmfgn3lRCZAtKtXOG0CcdbnaqqP8mrNvjf8H8xv2B48
	Sue1Y14ZLkWzCX3VyHpbwez/jZOYTRxHW9m022KS2NG9AMXSjDI+ccIHiJsaI6rFiGhJaQ==
X-Gm-Gg: Acq92OFKhILu3NAnG6qiDZNXa2moB6ikMOBCPxxLdWViY4zXiUYquXTF8DX0Mrp1riV
	yGew0t/5JEy7N3DltDp/NFhlzC9O9s14T5U8bruLU68lik5bIAQkQ5lDt1RpE96V4nuORN+DHMn
	H+PGIeGIf4WNkX0yTsOrRE2ooCHgVyocUF1FhZ9BBqm7Y+BZ3r/lNxF0bUbCAKhyPBBcPEu7hPc
	t+5ZQV8AAoJaJ0U/LFXdkY96cTBk5E1wTUG4ZvV++2+DG7S4R/G46NIY74sSrhUHUHGktvDdqJF
	M4KU+4b9agzVlC+miCUNUlqoxgisDAy5nAo/Fronu8zeC4oHqniIixDMgxbWxcCTXDVS0+LdNQt
	hUWl42DveKl+HPw2r/7dGPJQD+tRi/z9Xv2BCbIAhrtFnHXxSPJcHex/C0fiHwOfUnbSktJfYHT
	A8FD4SZ/mDjFIsqAdQzhiTd8ltEQ==
X-Received: by 2002:a05:6830:7105:b0:7dc:e30d:6498 with SMTP id 46e09a7af769-7e1dee81549mr16665875a34.1.1778567950459;
        Mon, 11 May 2026 23:39:10 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d9d788sm8183783a34.24.2026.05.11.23.39.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:39:09 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH v10 1/2] selftests: openvswitch: add vlan() and encap() flow string parsing
Date: Tue, 12 May 2026 14:38:49 +0800
Message-ID: <20260512063850.1133046-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512063850.1133046-1-houminxi@gmail.com>
References: <20260509135423.3433910-1-houminxi@gmail.com>
 <20260512063850.1133046-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BCA2B51B339
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286969-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.997];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add VLAN TCI formatting and parsing support to ovs-dpctl.py:

- Add _vlan_dpstr() to decompose TCI into vid/pcp/cfi fields,
  with raw tci=0x%04x fallback when cfi=0 for round-trip safety.
- Add _parse_vlan_from_flowstr() boundary check for missing ')'.
- Add encap_ovskey subclass restricting nla_map to L2-L4 attributes
  (slots 0-21) that appear inside 802.1Q ENCAP, with metadata
  attributes set to "none".
- Check encap parse() return value for unrecognized trailing content.
- Support callable format functions in dpstr() output.
- Change OVS_KEY_ATTR_VLAN type from uint16 to be16 to match the
  kernel __be16 wire format; uint16 decodes in host byte order,
  which gives wrong values on little-endian architectures.
- Change OVS_KEY_ATTR_ENCAP type from none to encap_ovskey to
  enable recursive parsing of 802.1Q encapsulated flow keys.
- Add push_vlan action class with fields matching kernel struct
  ovs_action_push_vlan (vlan_tpid, vlan_tci as network-order u16).
- Add push_vlan dpstr format and parse with range validation
  (vid 0-4095, pcp 0-7, tpid 0-0xFFFF) and CFI forced to 1.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 324 +++++++++++++++++-
 1 file changed, 314 insertions(+), 10 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index bbe35e2718d2..3b6a26e265a4 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -369,7 +369,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
         ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
         ("OVS_ACTION_ATTR_SET", "ovskey"),
-        ("OVS_ACTION_ATTR_PUSH_VLAN", "none"),
+        ("OVS_ACTION_ATTR_PUSH_VLAN", "push_vlan"),
         ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
         ("OVS_ACTION_ATTR_SAMPLE", "sample"),
         ("OVS_ACTION_ATTR_RECIRC", "uint32"),
@@ -426,6 +426,9 @@ class ovsactions(nla):
 
             return actstr
 
+    class push_vlan(nla):
+        fields = (("vlan_tpid", "!H"), ("vlan_tci", "!H"))
+
     class sample(nla):
         nla_flags = NLA_F_NESTED
 
@@ -632,6 +635,14 @@ class ovsactions(nla):
                 print_str += "ct_clear"
             elif field[0] == "OVS_ACTION_ATTR_POP_VLAN":
                 print_str += "pop_vlan"
+            elif field[0] == "OVS_ACTION_ATTR_PUSH_VLAN":
+                datum = self.get_attr(field[0])
+                tpid = datum["vlan_tpid"]
+                tci = datum["vlan_tci"]
+                vid = tci & 0x0FFF
+                pcp = (tci >> 13) & 0x7
+                print_str += "push_vlan(vid=%d,pcp=%d" \
+                    ",tpid=0x%04x)" % (vid, pcp, tpid)
             elif field[0] == "OVS_ACTION_ATTR_POP_ETH":
                 print_str += "pop_eth"
             elif field[0] == "OVS_ACTION_ATTR_POP_NSH":
@@ -725,7 +736,57 @@ class ovsactions(nla):
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-            if parse_starts_block(actstr, "clone(", False):
+            if parse_starts_block(actstr, "push_vlan(", False):
+                actstr = actstr[len("push_vlan("):]
+                vid = 0
+                pcp = 0
+                tpid = 0x8100
+                if ")" not in actstr:
+                    raise ValueError(
+                        "push_vlan(): missing ')'")
+                paren = actstr.index(")")
+                if not actstr[:paren].strip():
+                    raise ValueError("push_vlan(): no fields")
+                for kv in actstr[:paren].split(","):
+                    if "=" not in kv:
+                        raise ValueError(
+                            "push_vlan(): bad field '%s'"
+                            % kv.strip())
+                    k = kv[:kv.index("=")].strip()
+                    v = kv[kv.index("=") + 1:].strip()
+                    if k == "vid":
+                        vid = int(v, 0)
+                        if vid < 0 or vid > 0xFFF:
+                            raise ValueError(
+                                "push_vlan(): vid=%d out of "
+                                "range (0-4095)" % vid)
+                    elif k == "pcp":
+                        pcp = int(v, 0)
+                        if pcp < 0 or pcp > 7:
+                            raise ValueError(
+                                "push_vlan(): pcp=%d out of "
+                                "range (0-7)" % pcp)
+                    elif k == "tpid":
+                        tpid = int(v, 0)
+                        if tpid < 0 or tpid > 0xFFFF:
+                            raise ValueError(
+                                "push_vlan(): tpid=0x%x out "
+                                "of range (0-0xffff)" % tpid)
+                    else:
+                        raise ValueError(
+                            "push_vlan(): unknown key '%s'"
+                            % k)
+                tci = (vid & 0x0FFF) | ((pcp & 0x7) << 13) \
+                    | 0x1000
+                pvact = self.push_vlan()
+                pvact["vlan_tpid"] = tpid
+                pvact["vlan_tci"] = tci
+                self["attrs"].append(
+                    ["OVS_ACTION_ATTR_PUSH_VLAN", pvact])
+                actstr = actstr[paren + 1:]
+                parsed = True
+
+            elif parse_starts_block(actstr, "clone(", False):
                 parencount += 1
                 subacts = ovsactions()
                 actstr = actstr[len("clone("):]
@@ -900,11 +961,11 @@ class ovskey(nla):
     nla_flags = NLA_F_NESTED
     nla_map = (
         ("OVS_KEY_ATTR_UNSPEC", "none"),
-        ("OVS_KEY_ATTR_ENCAP", "none"),
+        ("OVS_KEY_ATTR_ENCAP", "encap_ovskey"),
         ("OVS_KEY_ATTR_PRIORITY", "uint32"),
         ("OVS_KEY_ATTR_IN_PORT", "uint32"),
         ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
-        ("OVS_KEY_ATTR_VLAN", "uint16"),
+        ("OVS_KEY_ATTR_VLAN", "be16"),
         ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
         ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
         ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
@@ -1635,6 +1696,194 @@ class ovskey(nla):
     class ovs_key_mpls(nla):
         fields = (("lse", ">I"),)
 
+    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
+    _VLAN_CFI_MASK = 0x1000
+
+    @staticmethod
+    def _vlan_dpstr(tci):
+        """Format VLAN TCI as vid=X,pcp=Y,cfi=Z or tci=0xNNNN.
+
+        When cfi=1 (standard Ethernet VLAN), outputs decomposed
+        vid/pcp/cfi fields. When cfi=0 (truncated VLAN header),
+        falls back to raw tci=0x%04x to ensure round-trip
+        correctness: the parser auto-adds cfi=1 for vid/pcp
+        format, so cfi=0 would be lost on re-parse."""
+        vid = tci & 0x0FFF
+        pcp = (tci >> 13) & 0x7
+        cfi = (tci >> 12) & 0x1
+        if cfi:
+            return "vid=%d,pcp=%d,cfi=%d" % (vid, pcp, cfi)
+        return "tci=0x%04x" % tci
+
+    @staticmethod
+    def _parse_vlan_from_flowstr(flowstr):
+        """Parse vlan(tci=X) or vlan(vid=X[,pcp=Y,cfi=Z]) from flowstr.
+
+        Returns (remaining_flowstr, key_tci, mask_tci).
+        TCI values use standard bit layout (VID bits 0-11,
+        CFI bit 12, PCP bits 13-15); byte order conversion to
+        big-endian happens in pyroute2 be16 NLA serialization.
+        The mask covers only the fields the caller specified:
+        vid -> 0x0FFF, pcp -> 0xE000, cfi -> 0x1000, tci -> 0xFFFF.
+
+        The tci= key sets the raw TCI bitfield (no CFI validation) to allow
+        non-Ethernet use cases.  Use cfi=1 for standard Ethernet VLAN matching.
+        """
+        tci = 0
+        mask = 0
+        has_tci = False
+        has_vid = has_pcp = has_cfi = False
+        _tci_mix_err = "vlan(): 'tci' cannot be mixed " \
+                       "with 'vid'/'pcp'/'cfi'"
+        first = True
+        while True:
+            flowstr = flowstr.lstrip()
+            if not flowstr:
+                raise ValueError("vlan(): missing ')'")
+            if flowstr[0] == ')':
+                break
+            if not first:
+                flowstr = flowstr[1:]  # skip ','
+                if not flowstr:
+                    raise ValueError("vlan(): missing ')' after trailing comma")
+                flowstr = flowstr.lstrip()
+                if flowstr and flowstr[0] == ')':
+                    break
+                if flowstr and flowstr[0] == ',':
+                    raise ValueError(
+                        "vlan(): empty or extra comma in field list")
+            first = False
+
+            eq = flowstr.find('=')
+            if eq == -1:
+                raise ValueError(
+                    "vlan(): expected key=value, got '%s'" % flowstr)
+            key = flowstr[:eq].strip()
+            flowstr = flowstr[eq + 1:]
+
+            end = flowstr.find(',')
+            end2 = flowstr.find(')')
+            if end == -1 and end2 == -1:
+                raise ValueError("vlan(): missing ')'")
+            if end == -1 or (end2 != -1 and end2 < end):
+                end = end2
+            val = flowstr[:end].strip()
+            flowstr = flowstr[end:]
+
+            if not val:
+                raise ValueError("vlan(): empty value for key '%s'" % key)
+            try:
+                v = int(val, 0)
+            except ValueError as exc:
+                raise ValueError(
+                    "vlan(): invalid value '%s' for key '%s'"
+                    % (val, key)) from exc
+
+            if key == 'tci':
+                if has_tci:
+                    raise ValueError("vlan(): duplicate 'tci'")
+                if has_vid or has_pcp or has_cfi:
+                    raise ValueError(_tci_mix_err)
+                if v > 0xFFFF or v < 0:
+                    raise ValueError("vlan(): tci=0x%x out of range" % v)
+                tci = v
+                mask = 0xFFFF
+                has_tci = True
+            elif key == 'vid':
+                if has_tci:
+                    raise ValueError(_tci_mix_err)
+                if has_vid:
+                    raise ValueError("vlan(): duplicate 'vid'")
+                if v < 0 or v > 0xFFF:
+                    raise ValueError("vlan(): vid=%d out of range (0-4095)" % v)
+                tci |= v
+                mask |= 0x0FFF
+                has_vid = True
+            elif key == 'pcp':
+                if has_tci:
+                    raise ValueError(_tci_mix_err)
+                if has_pcp:
+                    raise ValueError("vlan(): duplicate 'pcp'")
+                if v < 0 or v > 7:
+                    raise ValueError("vlan(): pcp=%d out of range (0-7)" % v)
+                tci |= (v & 0x7) << 13
+                mask |= 0xE000
+                has_pcp = True
+            elif key == 'cfi':
+                if has_tci:
+                    raise ValueError(_tci_mix_err)
+                if has_cfi:
+                    raise ValueError("vlan(): duplicate 'cfi'")
+                if v != 1:
+                    raise ValueError("vlan(): cfi must be 1 for Ethernet")
+                tci |= ovskey._VLAN_CFI_MASK
+                mask |= ovskey._VLAN_CFI_MASK
+                has_cfi = True
+            else:
+                raise ValueError("vlan(): unknown key '%s'" % key)
+
+        flowstr = flowstr[1:]  # skip ')'
+        # Catch immediate '))' (user error).  A ')' after ',' is consumed
+        # by parse()'s strspn(flowstr, "), ") inter-field separator stripping.
+        if flowstr.lstrip().startswith(')'):
+            raise ValueError("vlan(): unmatched ')'")
+        # parse() strips trailing ',', ')', ' ' as inter-field separators,
+        # so we do not need to call strspn here.
+
+        if mask == 0:
+            raise ValueError("vlan(): no fields specified, "
+                             "use vlan(vid=X[,pcp=Y,cfi=Z]) or vlan(tci=X)")
+        if not has_tci:
+            tci |= ovskey._VLAN_CFI_MASK
+            mask |= ovskey._VLAN_CFI_MASK
+        return flowstr, tci, mask
+
+    @staticmethod
+    def _parse_encap_from_flowstr(flowstr):
+        """Parse encap(inner_flow) from flowstr.
+
+        Returns (remaining_flowstr, inner_key_dict, inner_mask_dict)
+        where each dict has an 'attrs' key for recursive NLA encoding.
+        Parenthesis-depth tracking handles nested encap() calls but not
+        quoted strings containing literal parentheses.
+        """
+        depth = 1
+        end = -1
+        for i, c in enumerate(flowstr):
+            if c == '(':
+                depth += 1
+            elif c == ')':
+                depth -= 1
+                if depth < 0:
+                    raise ValueError(
+                        "encap(): unmatched ')' at position %d" % i)
+                if depth == 0:
+                    end = i
+                    break
+
+        if end == -1:
+            if depth > 1:
+                raise ValueError("encap(): missing ')' in nested encap")
+            raise ValueError("encap(): missing ')'")
+
+        inner_str = flowstr[:end].strip()
+        if not inner_str:
+            raise ValueError("encap(): empty inner flow")
+
+        flowstr = flowstr[end + 1:]
+        if flowstr.lstrip().startswith(')'):
+            raise ValueError("encap(): unmatched ')' after encap()")
+
+        inner_key = encap_ovskey()
+        inner_mask = encap_ovskey()
+        remaining = inner_key.parse(inner_str, inner_mask)
+        if remaining and re.search(r'[^\s,)]', remaining):
+            raise ValueError(
+                "encap(): unrecognized trailing "
+                "content '%s'" % remaining.strip())
+
+        return flowstr, inner_key, inner_mask
+
     def parse(self, flowstr, mask=None):
         for field in (
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
@@ -1656,6 +1905,16 @@ class ovskey(nla):
                 "eth_type",
                 lambda x: intparse(x, "0xffff"),
             ),
+            (
+                "OVS_KEY_ATTR_VLAN",
+                "vlan",
+                ovskey._parse_vlan_from_flowstr,
+            ),
+            (
+                "OVS_KEY_ATTR_ENCAP",
+                "encap",
+                ovskey._parse_encap_from_flowstr,
+            ),
             (
                 "OVS_KEY_ATTR_IPV4",
                 "ipv4",
@@ -1793,6 +2052,9 @@ class ovskey(nla):
                 True,
             ),
             ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
+            ("OVS_KEY_ATTR_VLAN", "vlan", ovskey._vlan_dpstr,
+                lambda x: False, True),
+            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
             (
                 "OVS_KEY_ATTR_ETHERTYPE",
                 "eth_type",
@@ -1820,22 +2082,63 @@ class ovskey(nla):
             v = self.get_attr(field[0])
             if v is not None:
                 m = None if mask is None else mask.get_attr(field[0])
+                fmt = field[2]  # str format or callable
                 if field[4] is False:
                     print_str += v.dpstr(m, more)
                     print_str += ","
                 else:
                     if m is None or field[3](m):
-                        print_str += field[1] + "("
-                        print_str += field[2] % v
-                        print_str += "),"
+                        val = fmt(v) if callable(fmt) else fmt % v
+                        print_str += field[1] + "(" + val + "),"
                     elif more or m != 0:
-                        print_str += field[1] + "("
-                        print_str += (field[2] % v) + "/" + (field[2] % m)
-                        print_str += "),"
+                        if field[0] == "OVS_KEY_ATTR_VLAN":
+                            val = "tci=0x%04x/0x%04x" % (v, m)
+                        elif callable(fmt):
+                            val = fmt(v) + "/" + fmt(m)
+                        else:
+                            val = (fmt % v) + "/" + (fmt % m)
+                        print_str += field[1] + "(" + val + "),"
 
         return print_str
 
 
+class encap_ovskey(ovskey):
+    """Inner flow key attributes valid inside 802.1Q ENCAP.
+
+    Only L2-L4 key attributes (slots 0-21) appear inside ENCAP.
+    Metadata-only attributes (SKB_MARK, DP_HASH, RECIRC_ID, etc.)
+    are set to "none" -- they never appear inside ENCAP per
+    ovs_nla_put_vlan() in net/openvswitch/flow_netlink.c.
+
+    nla_map indexes must match OVS_KEY_ATTR_* enum values in
+    include/uapi/linux/openvswitch.h.
+    """
+    nla_map = (
+        ("OVS_KEY_ATTR_UNSPEC", "none"),
+        ("OVS_KEY_ATTR_ENCAP", "none"),  # placeholder, parsed by ovskey
+        ("OVS_KEY_ATTR_PRIORITY", "none"),  # skb metadata, not in ENCAP
+        ("OVS_KEY_ATTR_IN_PORT", "none"),  # skb metadata, not in ENCAP
+        ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
+        ("OVS_KEY_ATTR_VLAN", "be16"),
+        ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
+        ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
+        ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
+        ("OVS_KEY_ATTR_TCP", "ovs_key_tcp"),
+        ("OVS_KEY_ATTR_UDP", "ovs_key_udp"),
+        ("OVS_KEY_ATTR_ICMP", "ovs_key_icmp"),
+        ("OVS_KEY_ATTR_ICMPV6", "ovs_key_icmpv6"),
+        ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),
+        ("OVS_KEY_ATTR_ND", "ovs_key_nd"),
+        ("OVS_KEY_ATTR_SKB_MARK", "none"),  # metadata, not in ENCAP
+        ("OVS_KEY_ATTR_TUNNEL", "none"),  # tunnel metadata, not in ENCAP
+        ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),
+        ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),
+        ("OVS_KEY_ATTR_DP_HASH", "none"),  # metadata, not in ENCAP
+        ("OVS_KEY_ATTR_RECIRC_ID", "none"),  # metadata, not in ENCAP
+        ("OVS_KEY_ATTR_MPLS", "array(ovs_key_mpls)"),
+    )
+
+
 class OvsPacket(GenericNetlinkSocket):
     OVS_PACKET_CMD_MISS = 1  # Flow table miss
     OVS_PACKET_CMD_ACTION = 2  # USERSPACE action
@@ -2583,6 +2886,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
 
 
 def main(argv):
+    nlmsg_atoms.encap_ovskey = encap_ovskey
     nlmsg_atoms.ovskey = ovskey
     nlmsg_atoms.ovsactions = ovsactions
 
-- 
2.53.0


