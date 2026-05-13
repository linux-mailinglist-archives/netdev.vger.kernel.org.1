Return-Path: <netdev+bounces-287571-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEE6HUxrBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287571-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:15:08 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BE70532E4B
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:15:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A92E303990F
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:13:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2851402435;
	Wed, 13 May 2026 12:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="h2KsDwGD"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8675038E8B0
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674432; cv=none; b=X7+e8qHbtHc6DwTJmWl2T8SPx1QUcAE1dCFS8Q3lcXaVVgOqW0GTIYYN9JKqhWhWBlAvuEA8IuXyZzST7oAe9Remllj+gM7JaG6jZxxvOo5HDL4jk5aKcvTkZ9rAYyfYqvgMA57wVtgsFEKzWOBQIyTYl+DfDyWEc4GQvDLsAnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674432; c=relaxed/simple;
	bh=23gPDVut3hAD3+v5gDtMrdU0xDJjdqXO5nPer0+kcwI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m6HP3YM/UoqzyhdIf8yF5a+L/GRT5abPZZfKv/EGQ53H8JrLh78Rp1cprAwGPLfLZnlBYAnB9vqAqIW64nxG29OETDcNvccceYN9OlS2+/ZKFtu+4m0WjbvFRAQxVF7w7IdeOsS7YB0ISIFyUz7DBv3ds5iyHKcXDqGEUej1zqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=h2KsDwGD; arc=none smtp.client-ip=209.85.160.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-439f000476eso40660fac.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:13:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778674429; x=1779279229; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MeAceCauaZcfmyWzTKzMFMsKAoGCg8wvWu5S5P0h4yE=;
        b=h2KsDwGDE+ca9xZXWckt8Y7R27fUkQ31v/PljISCzQReJl7QJ99kGj/2d47vXUKlIV
         HkC/iOIxEbe1UtcnKDInRSHh8PnUcxS7Pwv8AnJynBwnwnQJ8pLCris4QU8i12ya4c3V
         XAnm1cVi+yeoMN6QCSETIFDIcsOhJvZJIOYTj72xwCcz/FaPDyvjR/j6PQZSlL6WF3me
         cPh6+d+AsEOQ3bMcMg0jxb1NSzqPXlf3M9st0gf74k4fo3zoHrtEeJJnEkB33gIHVlwp
         vn/m30hk0l+Z3ry7/GKSQmkwtl8nj2wEzPdSVYifjIGxINHVrZrYvFsIsquYmaZWpeGL
         U4iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674429; x=1779279229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MeAceCauaZcfmyWzTKzMFMsKAoGCg8wvWu5S5P0h4yE=;
        b=fxrfeHqA+ePTJdgmBa7guWsqCDO3d4yVJxwULoGpBtoIF5sVVVr7qazIJZehU6H18h
         0JBiw9TUZWae7+LAhCTsYTK7QEO9nZHNWRHuqmyo6ULDtPDCjNxa0cPNl9XFVmXIyRtF
         UF+uANwxtrgbxGNOqBcEV88Zcxa1tVjrldRBHEVBa5HXjP1XzrLDvR70rlivNvVZbdSD
         jwsEso42/eD/1mVCG12BQeMACQBR/pFY9JjOcxlxzbNcsOq9C50wVGRCo65+Uqeuh3wc
         MisZ3T5mF/my1XLlDTAHYpDUvoDqL0nN1JZJAkOUB+bmSwP3EuTO+H3W66unGrbg16/l
         JfmA==
X-Gm-Message-State: AOJu0YwALSEb3+BmjrWzc6PNE4tB6ay6Vk9M21feU6E9yeVkE4tVqNJ/
	hVJ6IyG40yySc7RuQu2Vp2FVaizY/9+ycAIpNE8Jr3CD8YyiYW7fiFT7bF2JY8Qi8QM=
X-Gm-Gg: Acq92OGPxtKELwqYPzyIEqTOLUzoGvhirTHniPKeEDV/UVLZ6/Eua4GmVCPwHwMvUbN
	AymbthmqhUcBWvk7Pa+DcLSXoxPTHzFpYwwc+O3WvjiQ1N4XUeZprdYoaMYk7p4EEiFgMl2pZMq
	G/sVfbsgH5n8YiPzVMsy367HqiARt5+0tBbI1IIZj+IKG5Wt2zxo27d5bLEQDo8pYO1tIhoUHlq
	o2DcRd+OjcVAXqTiXRXyjRlQlQZlkYcLZLx0PWzOy/muQPsEfv4mKauI7mfotAl2NAjC4kWmmht
	LCn/SGnBI+W5dATnhdn9zw0as+Liqwy1vIjeUCv55ud9XNOGmIBr/GRKcDLC/pwz5rNKRzijIO5
	xfr4a28F/Ral7c0PrBK38+inEohnqDWEYmCPrbecWQ+sZUfKRHk9t9QcXNuuN/73UIN0qNBgRyM
	LY2ciPRXoih2T3qt4=
X-Received: by 2002:a05:6870:fb89:b0:42f:dd2e:e41e with SMTP id 586e51a60fabf-439ce17b232mr1617454fac.17.1778674428988;
        Wed, 13 May 2026 05:13:48 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm15189442fac.11.2026.05.13.05.13.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:13:48 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next 3/5] selftests: openvswitch: rename classes and variables in ovs-dpctl.py
Date: Wed, 13 May 2026 20:12:38 +0800
Message-ID: <20260513121240.2590767-4-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260513121240.2590767-1-houminxi@gmail.com>
References: <20260513121240.2590767-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 1BE70532E4B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-287571-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Rename classes to PascalCase and variables to snake_case to fix
C0103 pylint warnings. Update nla_map type strings and
nlmsg_atoms registrations to match the new class names.

pyroute2 nla_map resolution uses getattr(self, type_string), so
renaming the class and its nla_map string together is safe.

Other fixes:
  - Add @staticmethod to type_to_str() and str_to_type() (E0213)

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 374 +++++++++---------
 1 file changed, 188 insertions(+), 186 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 5ce054768f48..6a9cf48948fd 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -107,11 +107,11 @@ def intparse(statestr, defmask="0xffffffff"):
 
 
 def parse_flags(flag_str, flag_vals):
-    bitResult = 0
-    maskResult = 0
+    bit_result = 0
+    mask_result = 0
 
     if len(flag_str) == 0:
-        return flag_str, bitResult, maskResult
+        return flag_str, bit_result, mask_result
 
     if flag_str[0].isdigit():
         idx = 0
@@ -120,11 +120,11 @@ def parse_flags(flag_str, flag_vals):
         digits = flag_str[:idx]
         flag_str = flag_str[idx:]
 
-        bitResult = int(digits, 0)
-        maskResult = int(digits, 0)
+        bit_result = int(digits, 0)
+        mask_result = int(digits, 0)
 
     while len(flag_str) > 0 and (flag_str[0] == "+" or flag_str[0] == "-"):
-        setFlag = flag_str[0] == "+"
+        set_flag = flag_str[0] == "+"
 
         flag_str = flag_str[1:]
 
@@ -140,21 +140,21 @@ def parse_flags(flag_str, flag_vals):
         flag = flag_str[0:flag_len]
 
         if flag in flag_vals:
-            if maskResult & flag_vals[flag]:
+            if mask_result & flag_vals[flag]:
                 raise KeyError(
                     f"Flag {flag} set once, cannot be set in multiples"
                 )
 
-            if setFlag:
-                bitResult |= flag_vals[flag]
+            if set_flag:
+                bit_result |= flag_vals[flag]
 
-            maskResult |= flag_vals[flag]
+            mask_result |= flag_vals[flag]
         else:
             raise KeyError(f"Missing flag value: {flag}")
 
         flag_str = flag_str[flag_len:]
 
-    return flag_str, bitResult, maskResult
+    return flag_str, bit_result, mask_result
 
 
 def parse_ct_state(statestr):
@@ -348,7 +348,7 @@ def parse_attrs(actstr, attr_desc):
     return attrs, actstr[1:]
 
 
-class ovs_dp_msg(genlmsg):
+class OvsDpMsg(genlmsg):
     # include the OVS version
     # We need a custom header rather than just being able to rely on
     # genlmsg because fields ends up not expressing everything correctly
@@ -356,23 +356,23 @@ class ovs_dp_msg(genlmsg):
     fields = genlmsg.fields + (("dpifindex", "I"),)
 
 
-class ovsactions(nla):
+class OvsActions(nla):
     nla_flags = NLA_F_NESTED
 
     nla_map = (
         ("OVS_ACTION_ATTR_UNSPEC", "none"),
         ("OVS_ACTION_ATTR_OUTPUT", "uint32"),
-        ("OVS_ACTION_ATTR_USERSPACE", "userspace"),
-        ("OVS_ACTION_ATTR_SET", "ovskey"),
-        ("OVS_ACTION_ATTR_PUSH_VLAN", "push_vlan"),
+        ("OVS_ACTION_ATTR_USERSPACE", "Userspace"),
+        ("OVS_ACTION_ATTR_SET", "OvsKey"),
+        ("OVS_ACTION_ATTR_PUSH_VLAN", "PushVlan"),
         ("OVS_ACTION_ATTR_POP_VLAN", "flag"),
-        ("OVS_ACTION_ATTR_SAMPLE", "sample"),
+        ("OVS_ACTION_ATTR_SAMPLE", "Sample"),
         ("OVS_ACTION_ATTR_RECIRC", "uint32"),
         ("OVS_ACTION_ATTR_HASH", "none"),
         ("OVS_ACTION_ATTR_PUSH_MPLS", "none"),
         ("OVS_ACTION_ATTR_POP_MPLS", "flag"),
-        ("OVS_ACTION_ATTR_SET_MASKED", "ovskey"),
-        ("OVS_ACTION_ATTR_CT", "ctact"),
+        ("OVS_ACTION_ATTR_SET_MASKED", "OvsKey"),
+        ("OVS_ACTION_ATTR_CT", "CtAct"),
         ("OVS_ACTION_ATTR_TRUNC", "uint32"),
         ("OVS_ACTION_ATTR_PUSH_ETH", "none"),
         ("OVS_ACTION_ATTR_POP_ETH", "flag"),
@@ -385,10 +385,10 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
         ("OVS_ACTION_ATTR_DROP", "uint32"),
-        ("OVS_ACTION_ATTR_PSAMPLE", "psample"),
+        ("OVS_ACTION_ATTR_PSAMPLE", "Psample"),
     )
 
-    class psample(nla):
+    class Psample(nla):
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -420,16 +420,16 @@ class ovsactions(nla):
 
             return actstr
 
-    class push_vlan(nla):
+    class PushVlan(nla):
         fields = (("vlan_tpid", "!H"), ("vlan_tci", "!H"))
 
-    class sample(nla):
+    class Sample(nla):
         nla_flags = NLA_F_NESTED
 
         nla_map = (
             ("OVS_SAMPLE_ATTR_UNSPEC", "none"),
             ("OVS_SAMPLE_ATTR_PROBABILITY", "uint32"),
-            ("OVS_SAMPLE_ATTR_ACTIONS", "ovsactions"),
+            ("OVS_SAMPLE_ATTR_ACTIONS", "OvsActions"),
         )
 
         def dpstr(self, more=False):
@@ -447,7 +447,7 @@ class ovsactions(nla):
 
         def parse(self, actstr):
             def parse_nested_actions(actstr):
-                subacts = ovsactions()
+                subacts = OvsActions()
                 parsed_len = subacts.parse(actstr)
                 return subacts, actstr[parsed_len :]
 
@@ -456,7 +456,7 @@ class ovsactions(nla):
                 return int(math.floor(UINT32_MAX * (percent / 100.0) + .5))
 
             desc = (
-                ("sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
+                ("Sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
                 ("actions", "OVS_SAMPLE_ATTR_ACTIONS", parse_nested_actions),
             )
             attrs, actstr = parse_attrs(actstr, desc)
@@ -466,7 +466,7 @@ class ovsactions(nla):
 
             return actstr
 
-    class ctact(nla):
+    class CtAct(nla):
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -476,13 +476,13 @@ class ovsactions(nla):
             ("OVS_CT_ATTR_MARK", "none"),
             ("OVS_CT_ATTR_LABELS", "none"),
             ("OVS_CT_ATTR_HELPER", "asciiz"),
-            ("OVS_CT_ATTR_NAT", "natattr"),
+            ("OVS_CT_ATTR_NAT", "NatAttr"),
             ("OVS_CT_ATTR_FORCE_COMMIT", "flag"),
             ("OVS_CT_ATTR_EVENTMASK", "uint32"),
             ("OVS_CT_ATTR_TIMEOUT", "asciiz"),
         )
 
-        class natattr(nla):
+        class NatAttr(nla):
             nla_flags = NLA_F_NESTED
 
             nla_map = (
@@ -557,7 +557,7 @@ class ovsactions(nla):
             print_str += ")"
             return print_str
 
-    class userspace(nla):
+    class Userspace(nla):
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -755,7 +755,7 @@ class ovsactions(nla):
                             f"push_vlan(): unknown key '{k}'")
                 tci = (vid & 0x0FFF) | ((pcp & 0x7) << 13) \
                     | 0x1000
-                pvact = self.push_vlan()
+                pvact = self.PushVlan()
                 pvact["vlan_tpid"] = tpid
                 pvact["vlan_tci"] = tci
                 self["attrs"].append(
@@ -765,15 +765,15 @@ class ovsactions(nla):
 
             elif parse_starts_block(actstr, "clone(", False):
                 parencount += 1
-                subacts = ovsactions()
+                subacts = OvsActions()
                 actstr = actstr[len("clone("):]
-                parsedLen = subacts.parse(actstr)
+                parsed_len = subacts.parse(actstr)
                 self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
-                actstr = actstr[parsedLen:]
+                actstr = actstr[parsed_len:]
                 parsed = True
             elif parse_starts_block(actstr, "set(", False):
                 parencount += 1
-                k = ovskey()
+                k = OvsKey()
                 actstr = actstr[len("set("):]
                 actstr = k.parse(actstr, None)
                 self["attrs"].append(("OVS_ACTION_ATTR_SET", k))
@@ -782,8 +782,8 @@ class ovsactions(nla):
                 parsed = True
             elif parse_starts_block(actstr, "set_masked(", False):
                 parencount += 1
-                k = ovskey()
-                m = ovskey()
+                k = OvsKey()
+                m = OvsKey()
                 actstr = actstr[len("set_masked("):]
                 actstr = k.parse(actstr, m)
                 self["attrs"].append(("OVS_ACTION_ATTR_SET_MASKED", [k, m]))
@@ -793,7 +793,7 @@ class ovsactions(nla):
             elif parse_starts_block(actstr, "ct(", False):
                 parencount += 1
                 actstr = actstr[len("ct(") :]
-                ctact = ovsactions.ctact()
+                ctact = OvsActions.CtAct()
 
                 for scan in (
                     ("commit", "OVS_CT_ATTR_COMMIT", None),
@@ -820,7 +820,7 @@ class ovsactions(nla):
                     # sub-action and this lets it sit anywhere in the ct() action
                     if actstr.startswith("nat"):
                         actstr = actstr[3:]
-                        natact = ovsactions.ctact.natattr()
+                        natact = OvsActions.CtAct.NatAttr()
 
                         if actstr.startswith("("):
                             parencount += 1
@@ -884,19 +884,19 @@ class ovsactions(nla):
                 parsed = True
 
             elif parse_starts_block(actstr, "sample(", False):
-                sampleact = self.sample()
+                sampleact = self.Sample()
                 actstr = sampleact.parse(actstr[len("sample(") : ])
                 self["attrs"].append(["OVS_ACTION_ATTR_SAMPLE", sampleact])
                 parsed = True
 
             elif parse_starts_block(actstr, "psample(", False):
-                psampleact = self.psample()
+                psampleact = self.Psample()
                 actstr = psampleact.parse(actstr[len("psample(") : ])
                 self["attrs"].append(["OVS_ACTION_ATTR_PSAMPLE", psampleact])
                 parsed = True
 
             elif parse_starts_block(actstr, "userspace(", False):
-                uact = self.userspace()
+                uact = self.Userspace()
                 actstr = uact.parse(actstr[len("userspace(") : ])
                 self["attrs"].append(["OVS_ACTION_ATTR_USERSPACE", uact])
                 parsed = True
@@ -933,37 +933,37 @@ class ovsactions(nla):
         return totallen - len(actstr)
 
 
-class ovskey(nla):
+class OvsKey(nla):
     nla_flags = NLA_F_NESTED
     nla_map = (
         ("OVS_KEY_ATTR_UNSPEC", "none"),
-        ("OVS_KEY_ATTR_ENCAP", "encap_ovskey"),
+        ("OVS_KEY_ATTR_ENCAP", "EncapOvsKey"),
         ("OVS_KEY_ATTR_PRIORITY", "uint32"),
         ("OVS_KEY_ATTR_IN_PORT", "uint32"),
-        ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
+        ("OVS_KEY_ATTR_ETHERNET", "EthAddr"),
         ("OVS_KEY_ATTR_VLAN", "be16"),
         ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
-        ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
-        ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
-        ("OVS_KEY_ATTR_TCP", "ovs_key_tcp"),
-        ("OVS_KEY_ATTR_UDP", "ovs_key_udp"),
-        ("OVS_KEY_ATTR_ICMP", "ovs_key_icmp"),
-        ("OVS_KEY_ATTR_ICMPV6", "ovs_key_icmpv6"),
-        ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),
-        ("OVS_KEY_ATTR_ND", "ovs_key_nd"),
+        ("OVS_KEY_ATTR_IPV4", "OvsKeyIpv4"),
+        ("OVS_KEY_ATTR_IPV6", "OvsKeyIpv6"),
+        ("OVS_KEY_ATTR_TCP", "OvsKeyTcp"),
+        ("OVS_KEY_ATTR_UDP", "OvsKeyUdp"),
+        ("OVS_KEY_ATTR_ICMP", "OvsKeyIcmp"),
+        ("OVS_KEY_ATTR_ICMPV6", "OvsKeyIcmpv6"),
+        ("OVS_KEY_ATTR_ARP", "OvsKeyArp"),
+        ("OVS_KEY_ATTR_ND", "OvsKeyNd"),
         ("OVS_KEY_ATTR_SKB_MARK", "uint32"),
-        ("OVS_KEY_ATTR_TUNNEL", "ovs_key_tunnel"),
-        ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),
+        ("OVS_KEY_ATTR_TUNNEL", "OvsKeyTunnel"),
+        ("OVS_KEY_ATTR_SCTP", "OvsKeySctp"),
         ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),
         ("OVS_KEY_ATTR_DP_HASH", "uint32"),
         ("OVS_KEY_ATTR_RECIRC_ID", "uint32"),
-        ("OVS_KEY_ATTR_MPLS", "array(ovs_key_mpls)"),
+        ("OVS_KEY_ATTR_MPLS", "array(OvsKeyMpls)"),
         ("OVS_KEY_ATTR_CT_STATE", "uint32"),
         ("OVS_KEY_ATTR_CT_ZONE", "uint16"),
         ("OVS_KEY_ATTR_CT_MARK", "uint32"),
         ("OVS_KEY_ATTR_CT_LABELS", "none"),
-        ("OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV4", "ovs_key_ct_tuple_ipv4"),
-        ("OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV6", "ovs_key_ct_tuple_ipv6"),
+        ("OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV4", "OvsKeyCtTupleIpv4"),
+        ("OVS_KEY_ATTR_CT_ORIG_TUPLE_IPV6", "OvsKeyCtTupleIpv6"),
         ("OVS_KEY_ATTR_NSH", "none"),
         ("OVS_KEY_ATTR_PACKET_TYPE", "none"),
         ("OVS_KEY_ATTR_ND_EXTENSIONS", "none"),
@@ -971,7 +971,7 @@ class ovskey(nla):
         ("OVS_KEY_ATTR_IPV6_EXTENSIONS", "none"),
     )
 
-    class ovs_key_proto(nla):
+    class OvsKeyProto(nla):
         fields = (
             ("src", "!H"),
             ("dst", "!H"),
@@ -1003,12 +1003,12 @@ class ovskey(nla):
                 init=init,
             )
 
-        def parse(self, flowstr, typeInst):
+        def parse(self, flowstr, type_inst):
             if not flowstr.startswith(self.proto_str):
                 return None, None
 
-            k = typeInst()
-            m = typeInst()
+            k = type_inst()
+            m = type_inst()
 
             flowstr = flowstr[len(self.proto_str) :]
             if flowstr.startswith("("):
@@ -1072,7 +1072,7 @@ class ovskey(nla):
             outstr += ")"
             return outstr
 
-    class ethaddr(ovs_key_proto):
+    class EthAddr(OvsKeyProto):
         fields = (
             ("src", "!6s"),
             ("dst", "!6s"),
@@ -1103,7 +1103,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "eth",
                 data=data,
@@ -1113,7 +1113,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_ipv4(ovs_key_proto):
+    class OvsKeyIpv4(OvsKeyProto):
         fields = (
             ("src", "!I"),
             ("dst", "!I"),
@@ -1156,7 +1156,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "ipv4",
                 data=data,
@@ -1166,7 +1166,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_ipv6(ovs_key_proto):
+    class OvsKeyIpv6(OvsKeyProto):
         fields = (
             ("src", "!16s"),
             ("dst", "!16s"),
@@ -1207,7 +1207,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "ipv6",
                 data=data,
@@ -1217,7 +1217,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_tcp(ovs_key_proto):
+    class OvsKeyTcp(OvsKeyProto):
         def __init__(
             self,
             data=None,
@@ -1226,7 +1226,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "tcp",
                 data=data,
@@ -1236,7 +1236,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_udp(ovs_key_proto):
+    class OvsKeyUdp(OvsKeyProto):
         def __init__(
             self,
             data=None,
@@ -1245,7 +1245,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "udp",
                 data=data,
@@ -1255,7 +1255,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_sctp(ovs_key_proto):
+    class OvsKeySctp(OvsKeyProto):
         def __init__(
             self,
             data=None,
@@ -1264,7 +1264,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "sctp",
                 data=data,
@@ -1274,7 +1274,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_icmp(ovs_key_proto):
+    class OvsKeyIcmp(OvsKeyProto):
         fields = (
             ("type", "B"),
             ("code", "B"),
@@ -1293,7 +1293,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "icmp",
                 data=data,
@@ -1303,7 +1303,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_icmpv6(ovs_key_icmp):
+    class OvsKeyIcmpv6(OvsKeyIcmp):
         def __init__(
             self,
             data=None,
@@ -1312,7 +1312,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "icmpv6",
                 data=data,
@@ -1322,7 +1322,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_arp(ovs_key_proto):
+    class OvsKeyArp(OvsKeyProto):
         fields = (
             ("sip", "!I"),
             ("tip", "!I"),
@@ -1372,7 +1372,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "arp",
                 data=data,
@@ -1382,7 +1382,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_nd(ovs_key_proto):
+    class OvsKeyNd(OvsKeyProto):
         fields = (
             ("target", "!16s"),
             ("sll", "!6s"),
@@ -1408,7 +1408,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "nd",
                 data=data,
@@ -1418,7 +1418,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_ct_tuple_ipv4(ovs_key_proto):
+    class OvsKeyCtTupleIpv4(OvsKeyProto):
         fields = (
             ("src", "!I"),
             ("dst", "!I"),
@@ -1455,7 +1455,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "ct_tuple4",
                 data=data,
@@ -1465,7 +1465,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_ct_tuple_ipv6(nla):
+    class OvsKeyCtTupleIpv6(nla):
         fields = (
             ("src", "!16s"),
             ("dst", "!16s"),
@@ -1500,7 +1500,7 @@ class ovskey(nla):
             length=None,
             init=None,
         ):
-            ovskey.ovs_key_proto.__init__(
+            OvsKey.OvsKeyProto.__init__(
                 self,
                 "ct_tuple6",
                 data=data,
@@ -1510,7 +1510,7 @@ class ovskey(nla):
                 init=init,
             )
 
-    class ovs_key_tunnel(nla):
+    class OvsKeyTunnel(nla):
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -1537,9 +1537,9 @@ class ovskey(nla):
             if not flowstr.startswith("tunnel("):
                 return None, None
 
-            k = ovskey.ovs_key_tunnel()
+            k = OvsKey.OvsKeyTunnel()
             if mask is not None:
-                mask = ovskey.ovs_key_tunnel()
+                mask = OvsKey.OvsKeyTunnel()
 
             flowstr = flowstr[len("tunnel("):]
 
@@ -1667,7 +1667,7 @@ class ovskey(nla):
             print_str += ")"
             return print_str
 
-    class ovs_key_mpls(nla):
+    class OvsKeyMpls(nla):
         fields = (("lse", ">I"),)
 
     # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
@@ -1789,8 +1789,8 @@ class ovskey(nla):
                     raise ValueError("vlan(): duplicate 'cfi'")
                 if v != 1:
                     raise ValueError("vlan(): cfi must be 1 for Ethernet")
-                tci |= ovskey._VLAN_CFI_MASK
-                mask |= ovskey._VLAN_CFI_MASK
+                tci |= OvsKey._VLAN_CFI_MASK
+                mask |= OvsKey._VLAN_CFI_MASK
                 has_cfi = True
             else:
                 raise ValueError(f"vlan(): unknown key '{key}'")
@@ -1807,8 +1807,8 @@ class ovskey(nla):
             raise ValueError("vlan(): no fields specified, "
                              "use vlan(vid=X[,pcp=Y,cfi=Z]) or vlan(tci=X)")
         if not has_tci:
-            tci |= ovskey._VLAN_CFI_MASK
-            mask |= ovskey._VLAN_CFI_MASK
+            tci |= OvsKey._VLAN_CFI_MASK
+            mask |= OvsKey._VLAN_CFI_MASK
         return flowstr, tci, mask
 
     @staticmethod
@@ -1847,8 +1847,8 @@ class ovskey(nla):
         if flowstr.lstrip().startswith(')'):
             raise ValueError("encap(): unmatched ')' after encap()")
 
-        inner_key = encap_ovskey()
-        inner_mask = encap_ovskey()
+        inner_key = EncapOvsKey()
+        inner_mask = EncapOvsKey()
         remaining = inner_key.parse(inner_str, inner_mask)
         if remaining and re.search(r'[^\s,)]', remaining):
             raise ValueError(
@@ -1861,7 +1861,7 @@ class ovskey(nla):
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
             ("OVS_KEY_ATTR_SKB_MARK", "skb_mark", intparse),
             ("OVS_KEY_ATTR_RECIRC_ID", "recirc_id", intparse),
-            ("OVS_KEY_ATTR_TUNNEL", "tunnel", ovskey.ovs_key_tunnel),
+            ("OVS_KEY_ATTR_TUNNEL", "tunnel", OvsKey.OvsKeyTunnel),
             ("OVS_KEY_ATTR_DP_HASH", "dp_hash", intparse),
             ("OVS_KEY_ATTR_CT_STATE", "ct_state", parse_ct_state),
             ("OVS_KEY_ATTR_CT_ZONE", "ct_zone", intparse),
@@ -1870,7 +1870,7 @@ class ovskey(nla):
             (
                 "OVS_KEY_ATTR_ETHERNET",
                 "eth",
-                ovskey.ethaddr,
+                OvsKey.EthAddr,
             ),
             (
                 "OVS_KEY_ATTR_ETHERTYPE",
@@ -1880,42 +1880,42 @@ class ovskey(nla):
             (
                 "OVS_KEY_ATTR_VLAN",
                 "vlan",
-                ovskey._parse_vlan_from_flowstr,
+                OvsKey._parse_vlan_from_flowstr,
             ),
             (
                 "OVS_KEY_ATTR_ENCAP",
                 "encap",
-                ovskey._parse_encap_from_flowstr,
+                OvsKey._parse_encap_from_flowstr,
             ),
             (
                 "OVS_KEY_ATTR_IPV4",
                 "ipv4",
-                ovskey.ovs_key_ipv4,
+                OvsKey.OvsKeyIpv4,
             ),
             (
                 "OVS_KEY_ATTR_IPV6",
                 "ipv6",
-                ovskey.ovs_key_ipv6,
+                OvsKey.OvsKeyIpv6,
             ),
             (
                 "OVS_KEY_ATTR_ARP",
                 "arp",
-                ovskey.ovs_key_arp,
+                OvsKey.OvsKeyArp,
             ),
             (
                 "OVS_KEY_ATTR_TCP",
                 "tcp",
-                ovskey.ovs_key_tcp,
+                OvsKey.OvsKeyTcp,
             ),
             (
                 "OVS_KEY_ATTR_UDP",
                 "udp",
-                ovskey.ovs_key_udp,
+                OvsKey.OvsKeyUdp,
             ),
             (
                 "OVS_KEY_ATTR_ICMP",
                 "icmp",
-                ovskey.ovs_key_icmp,
+                OvsKey.OvsKeyIcmp,
             ),
             (
                 "OVS_KEY_ATTR_TCP_FLAGS",
@@ -2024,7 +2024,7 @@ class ovskey(nla):
                 True,
             ),
             ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
-            ("OVS_KEY_ATTR_VLAN", "vlan", ovskey._vlan_dpstr,
+            ("OVS_KEY_ATTR_VLAN", "vlan", OvsKey._vlan_dpstr,
                 lambda x: False, True),
             ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
             (
@@ -2074,7 +2074,7 @@ class ovskey(nla):
         return print_str
 
 
-class encap_ovskey(ovskey):
+class EncapOvsKey(OvsKey):
     """Inner flow key attributes valid inside 802.1Q ENCAP.
 
     Only L2-L4 key attributes (slots 0-21) appear inside ENCAP.
@@ -2087,27 +2087,27 @@ class encap_ovskey(ovskey):
     """
     nla_map = (
         ("OVS_KEY_ATTR_UNSPEC", "none"),
-        ("OVS_KEY_ATTR_ENCAP", "none"),  # placeholder, parsed by ovskey
+        ("OVS_KEY_ATTR_ENCAP", "none"),  # placeholder, parsed by OvsKey
         ("OVS_KEY_ATTR_PRIORITY", "none"),  # skb metadata, not in ENCAP
         ("OVS_KEY_ATTR_IN_PORT", "none"),  # skb metadata, not in ENCAP
-        ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
+        ("OVS_KEY_ATTR_ETHERNET", "EthAddr"),
         ("OVS_KEY_ATTR_VLAN", "be16"),
         ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
-        ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
-        ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
-        ("OVS_KEY_ATTR_TCP", "ovs_key_tcp"),
-        ("OVS_KEY_ATTR_UDP", "ovs_key_udp"),
-        ("OVS_KEY_ATTR_ICMP", "ovs_key_icmp"),
-        ("OVS_KEY_ATTR_ICMPV6", "ovs_key_icmpv6"),
-        ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),
-        ("OVS_KEY_ATTR_ND", "ovs_key_nd"),
+        ("OVS_KEY_ATTR_IPV4", "OvsKeyIpv4"),
+        ("OVS_KEY_ATTR_IPV6", "OvsKeyIpv6"),
+        ("OVS_KEY_ATTR_TCP", "OvsKeyTcp"),
+        ("OVS_KEY_ATTR_UDP", "OvsKeyUdp"),
+        ("OVS_KEY_ATTR_ICMP", "OvsKeyIcmp"),
+        ("OVS_KEY_ATTR_ICMPV6", "OvsKeyIcmpv6"),
+        ("OVS_KEY_ATTR_ARP", "OvsKeyArp"),
+        ("OVS_KEY_ATTR_ND", "OvsKeyNd"),
         ("OVS_KEY_ATTR_SKB_MARK", "none"),  # metadata, not in ENCAP
         ("OVS_KEY_ATTR_TUNNEL", "none"),  # tunnel metadata, not in ENCAP
-        ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),
+        ("OVS_KEY_ATTR_SCTP", "OvsKeySctp"),
         ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),
         ("OVS_KEY_ATTR_DP_HASH", "none"),  # metadata, not in ENCAP
         ("OVS_KEY_ATTR_RECIRC_ID", "none"),  # metadata, not in ENCAP
-        ("OVS_KEY_ATTR_MPLS", "array(ovs_key_mpls)"),
+        ("OVS_KEY_ATTR_MPLS", "array(OvsKeyMpls)"),
     )
 
 
@@ -2116,12 +2116,12 @@ class OvsPacket(GenericNetlinkSocket):
     OVS_PACKET_CMD_ACTION = 2  # USERSPACE action
     OVS_PACKET_CMD_EXECUTE = 3  # Apply actions to packet
 
-    class ovs_packet_msg(ovs_dp_msg):
+    class OvsPacketMsg(OvsDpMsg):
         nla_map = (
             ("OVS_PACKET_ATTR_UNSPEC", "none"),
             ("OVS_PACKET_ATTR_PACKET", "array(uint8)"),
-            ("OVS_PACKET_ATTR_KEY", "ovskey"),
-            ("OVS_PACKET_ATTR_ACTIONS", "ovsactions"),
+            ("OVS_PACKET_ATTR_KEY", "OvsKey"),
+            ("OVS_PACKET_ATTR_ACTIONS", "OvsActions"),
             ("OVS_PACKET_ATTR_USERDATA", "none"),
             ("OVS_PACKET_ATTR_EGRESS_TUN_KEY", "none"),
             ("OVS_PACKET_ATTR_UNUSED1", "none"),
@@ -2134,7 +2134,7 @@ class OvsPacket(GenericNetlinkSocket):
 
     def __init__(self):
         GenericNetlinkSocket.__init__(self)
-        self.bind(OVS_PACKET_FAMILY, OvsPacket.ovs_packet_msg)
+        self.bind(OVS_PACKET_FAMILY, OvsPacket.OvsPacketMsg)
 
     def upcall_handler(self, up=None):
         print("listening on upcall packet handler:", self.epid)
@@ -2160,7 +2160,7 @@ class OvsDatapath(GenericNetlinkSocket):
     OVS_DP_F_VPORT_PIDS = 1 << 1
     OVS_DP_F_DISPATCH_UPCALL_PER_CPU = 1 << 3
 
-    class dp_cmd_msg(ovs_dp_msg):
+    class DpCmdMsg(OvsDpMsg):
         """
         Message class that will be used to communicate with the kernel module.
         """
@@ -2169,15 +2169,15 @@ class OvsDatapath(GenericNetlinkSocket):
             ("OVS_DP_ATTR_UNSPEC", "none"),
             ("OVS_DP_ATTR_NAME", "asciiz"),
             ("OVS_DP_ATTR_UPCALL_PID", "array(uint32)"),
-            ("OVS_DP_ATTR_STATS", "dpstats"),
-            ("OVS_DP_ATTR_MEGAFLOW_STATS", "megaflowstats"),
+            ("OVS_DP_ATTR_STATS", "DpStats"),
+            ("OVS_DP_ATTR_MEGAFLOW_STATS", "MegaflowStats"),
             ("OVS_DP_ATTR_USER_FEATURES", "uint32"),
             ("OVS_DP_ATTR_PAD", "none"),
             ("OVS_DP_ATTR_MASKS_CACHE_SIZE", "uint32"),
             ("OVS_DP_ATTR_PER_CPU_PIDS", "array(uint32)"),
         )
 
-        class dpstats(nla):
+        class DpStats(nla):
             fields = (
                 ("hit", "=Q"),
                 ("missed", "=Q"),
@@ -2185,7 +2185,7 @@ class OvsDatapath(GenericNetlinkSocket):
                 ("flows", "=Q"),
             )
 
-        class megaflowstats(nla):
+        class MegaflowStats(nla):
             fields = (
                 ("mask_hit", "=Q"),
                 ("masks", "=I"),
@@ -2196,10 +2196,10 @@ class OvsDatapath(GenericNetlinkSocket):
 
     def __init__(self):
         GenericNetlinkSocket.__init__(self)
-        self.bind(OVS_DATAPATH_FAMILY, OvsDatapath.dp_cmd_msg)
+        self.bind(OVS_DATAPATH_FAMILY, OvsDatapath.DpCmdMsg)
 
     def info(self, dpname, ifindex=0):
-        msg = OvsDatapath.dp_cmd_msg()
+        msg = OvsDatapath.DpCmdMsg()
         msg["cmd"] = OVS_DP_CMD_GET
         msg["version"] = OVS_DATAPATH_VERSION
         msg["reserved"] = 0
@@ -2220,23 +2220,23 @@ class OvsDatapath(GenericNetlinkSocket):
         return reply
 
     def create(
-        self, dpname, shouldUpcall=False, versionStr=None, p=OvsPacket()
+        self, dpname, should_upcall=False, version_str=None, p=OvsPacket()
     ):
-        msg = OvsDatapath.dp_cmd_msg()
+        msg = OvsDatapath.DpCmdMsg()
         msg["cmd"] = OVS_DP_CMD_NEW
-        if versionStr is None:
+        if version_str is None:
             msg["version"] = OVS_DATAPATH_VERSION
         else:
-            msg["version"] = int(versionStr.split(":")[0], 0)
+            msg["version"] = int(version_str.split(":")[0], 0)
         msg["reserved"] = 0
         msg["dpifindex"] = 0
         msg["attrs"].append(["OVS_DP_ATTR_NAME", dpname])
 
         dpfeatures = 0
-        if versionStr is not None and versionStr.find(":") != -1:
-            dpfeatures = int(versionStr.split(":")[1], 0)
+        if version_str is not None and version_str.find(":") != -1:
+            dpfeatures = int(version_str.split(":")[1], 0)
         else:
-            if versionStr is None or versionStr.find(":") == -1:
+            if version_str is None or version_str.find(":") == -1:
                 dpfeatures |= OvsDatapath.OVS_DP_F_DISPATCH_UPCALL_PER_CPU
                 dpfeatures &= ~OvsDatapath.OVS_DP_F_VPORT_PIDS
 
@@ -2246,7 +2246,7 @@ class OvsDatapath(GenericNetlinkSocket):
                 procarray += [int(p.epid)]
             msg["attrs"].append(["OVS_DP_ATTR_UPCALL_PID", procarray])
         msg["attrs"].append(["OVS_DP_ATTR_USER_FEATURES", dpfeatures])
-        if not shouldUpcall:
+        if not should_upcall:
             msg["attrs"].append(["OVS_DP_ATTR_UPCALL_PID", [0]])
 
         try:
@@ -2263,7 +2263,7 @@ class OvsDatapath(GenericNetlinkSocket):
         return reply
 
     def destroy(self, dpname):
-        msg = OvsDatapath.dp_cmd_msg()
+        msg = OvsDatapath.DpCmdMsg()
         msg["cmd"] = OVS_DP_CMD_DEL
         msg["version"] = OVS_DATAPATH_VERSION
         msg["reserved"] = 0
@@ -2291,28 +2291,28 @@ class OvsVport(GenericNetlinkSocket):
     OVS_VPORT_TYPE_VXLAN = 4
     OVS_VPORT_TYPE_GENEVE = 5
 
-    class ovs_vport_msg(ovs_dp_msg):
+    class OvsVportMsg(OvsDpMsg):
         nla_map = (
             ("OVS_VPORT_ATTR_UNSPEC", "none"),
             ("OVS_VPORT_ATTR_PORT_NO", "uint32"),
             ("OVS_VPORT_ATTR_TYPE", "uint32"),
             ("OVS_VPORT_ATTR_NAME", "asciiz"),
-            ("OVS_VPORT_ATTR_OPTIONS", "vportopts"),
+            ("OVS_VPORT_ATTR_OPTIONS", "VportOpts"),
             ("OVS_VPORT_ATTR_UPCALL_PID", "array(uint32)"),
-            ("OVS_VPORT_ATTR_STATS", "vportstats"),
+            ("OVS_VPORT_ATTR_STATS", "VportStats"),
             ("OVS_VPORT_ATTR_PAD", "none"),
             ("OVS_VPORT_ATTR_IFINDEX", "uint32"),
             ("OVS_VPORT_ATTR_NETNSID", "uint32"),
         )
 
-        class vportopts(nla):
+        class VportOpts(nla):
             nla_map = (
                 ("OVS_TUNNEL_ATTR_UNSPEC", "none"),
                 ("OVS_TUNNEL_ATTR_DST_PORT", "uint16"),
                 ("OVS_TUNNEL_ATTR_EXTENSION", "none"),
             )
 
-        class vportstats(nla):
+        class VportStats(nla):
             fields = (
                 ("rx_packets", "=Q"),
                 ("tx_packets", "=Q"),
@@ -2324,6 +2324,7 @@ class OvsVport(GenericNetlinkSocket):
                 ("tx_dropped", "=Q"),
             )
 
+    @staticmethod
     def type_to_str(vport_type):
         if vport_type == OvsVport.OVS_VPORT_TYPE_NETDEV:
             return "netdev"
@@ -2337,6 +2338,7 @@ class OvsVport(GenericNetlinkSocket):
             return "geneve"
         raise ValueError(f"Unknown vport type:{vport_type}")
 
+    @staticmethod
     def str_to_type(vport_type):
         if vport_type == "netdev":
             return OvsVport.OVS_VPORT_TYPE_NETDEV
@@ -2352,11 +2354,11 @@ class OvsVport(GenericNetlinkSocket):
 
     def __init__(self, packet=OvsPacket()):
         GenericNetlinkSocket.__init__(self)
-        self.bind(OVS_VPORT_FAMILY, OvsVport.ovs_vport_msg)
+        self.bind(OVS_VPORT_FAMILY, OvsVport.OvsVportMsg)
         self.upcall_packet = packet
 
     def info(self, vport_name, dpifindex=0, portno=None):
-        msg = OvsVport.ovs_vport_msg()
+        msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_GET
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2381,7 +2383,7 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def attach(self, dpindex, vport_ifname, ptype, dport, lwt):
-        msg = OvsVport.ovs_vport_msg()
+        msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_NEW
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2394,11 +2396,11 @@ class OvsVport(GenericNetlinkSocket):
             ["OVS_VPORT_ATTR_UPCALL_PID", [self.upcall_packet.epid]]
         )
 
-        TUNNEL_DEFAULTS = [("geneve", 6081),
+        tunnel_defaults = [("geneve", 6081),
                            ("gre", 0),
                            ("vxlan", 4789)]
 
-        for tnl in TUNNEL_DEFAULTS:
+        for tnl in tunnel_defaults:
             if ptype == tnl[0]:
                 if not dport:
                     dport = tnl[1]
@@ -2408,7 +2410,7 @@ class OvsVport(GenericNetlinkSocket):
                         # GRE tunnels have no options.
                         break
 
-                    vportopt = OvsVport.ovs_vport_msg.vportopts()
+                    vportopt = OvsVport.OvsVportMsg.VportOpts()
                     vportopt["attrs"].append(
                         ["OVS_TUNNEL_ATTR_DST_PORT", dport]
                     )
@@ -2447,7 +2449,7 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def reset_upcall(self, dpindex, vport_ifname, p=None):
-        msg = OvsVport.ovs_vport_msg()
+        msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_SET
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2472,7 +2474,7 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def detach(self, dpindex, vport_ifname):
-        msg = OvsVport.ovs_vport_msg()
+        msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_DEL
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2497,22 +2499,22 @@ class OvsVport(GenericNetlinkSocket):
 
 
 class OvsFlow(GenericNetlinkSocket):
-    class ovs_flow_msg(ovs_dp_msg):
+    class OvsFlowMsg(OvsDpMsg):
         nla_map = (
             ("OVS_FLOW_ATTR_UNSPEC", "none"),
-            ("OVS_FLOW_ATTR_KEY", "ovskey"),
-            ("OVS_FLOW_ATTR_ACTIONS", "ovsactions"),
-            ("OVS_FLOW_ATTR_STATS", "flowstats"),
+            ("OVS_FLOW_ATTR_KEY", "OvsKey"),
+            ("OVS_FLOW_ATTR_ACTIONS", "OvsActions"),
+            ("OVS_FLOW_ATTR_STATS", "FlowStats"),
             ("OVS_FLOW_ATTR_TCP_FLAGS", "uint8"),
             ("OVS_FLOW_ATTR_USED", "uint64"),
             ("OVS_FLOW_ATTR_CLEAR", "none"),
-            ("OVS_FLOW_ATTR_MASK", "ovskey"),
+            ("OVS_FLOW_ATTR_MASK", "OvsKey"),
             ("OVS_FLOW_ATTR_PROBE", "none"),
             ("OVS_FLOW_ATTR_UFID", "array(uint32)"),
             ("OVS_FLOW_ATTR_UFID_FLAGS", "uint32"),
         )
 
-        class flowstats(nla):
+        class FlowStats(nla):
             fields = (
                 ("packets", "=Q"),
                 ("bytes", "=Q"),
@@ -2585,9 +2587,9 @@ class OvsFlow(GenericNetlinkSocket):
             return print_str
 
         def parse(self, flowstr, actstr, dpidx=0):
-            OVS_UFID_F_OMIT_KEY = 1 << 0
-            OVS_UFID_F_OMIT_MASK = 1 << 1
-            OVS_UFID_F_OMIT_ACTIONS = 1 << 2
+            ovs_ufid_f_omit_key = 1 << 0
+            ovs_ufid_f_omit_mask = 1 << 1
+            ovs_ufid_f_omit_actions = 1 << 2
 
             self["cmd"] = 0
             self["version"] = 0
@@ -2602,18 +2604,18 @@ class OvsFlow(GenericNetlinkSocket):
                 flowstr = flowstr[count + 1 :]
             else:
                 ufidstr = str(uuid.uuid4())
-            uuidRawObj = uuid.UUID(ufidstr).fields
+            uuid_raw_obj = uuid.UUID(ufidstr).fields
 
             self["attrs"].append(
                 [
                     "OVS_FLOW_ATTR_UFID",
                     [
-                        uuidRawObj[0],
-                        uuidRawObj[1] << 16 | uuidRawObj[2],
-                        uuidRawObj[3] << 24
-                        | uuidRawObj[4] << 16
-                        | uuidRawObj[5] & (0xFF << 32) >> 32,
-                        uuidRawObj[5] & (0xFFFFFFFF),
+                        uuid_raw_obj[0],
+                        uuid_raw_obj[1] << 16 | uuid_raw_obj[2],
+                        uuid_raw_obj[3] << 24
+                        | uuid_raw_obj[4] << 16
+                        | uuid_raw_obj[5] & (0xFF << 32) >> 32,
+                        uuid_raw_obj[5] & (0xFFFFFFFF),
                     ],
                 ]
             )
@@ -2621,27 +2623,27 @@ class OvsFlow(GenericNetlinkSocket):
                 [
                     "OVS_FLOW_ATTR_UFID_FLAGS",
                     int(
-                        OVS_UFID_F_OMIT_KEY
-                        | OVS_UFID_F_OMIT_MASK
-                        | OVS_UFID_F_OMIT_ACTIONS
+                        ovs_ufid_f_omit_key
+                        | ovs_ufid_f_omit_mask
+                        | ovs_ufid_f_omit_actions
                     ),
                 ]
             )
 
-            k = ovskey()
-            m = ovskey()
+            k = OvsKey()
+            m = OvsKey()
             k.parse(flowstr, m)
             self["attrs"].append(["OVS_FLOW_ATTR_KEY", k])
             self["attrs"].append(["OVS_FLOW_ATTR_MASK", m])
 
-            a = ovsactions()
+            a = OvsActions()
             a.parse(actstr)
             self["attrs"].append(["OVS_FLOW_ATTR_ACTIONS", a])
 
     def __init__(self):
         GenericNetlinkSocket.__init__(self)
 
-        self.bind(OVS_FLOW_FAMILY, OvsFlow.ovs_flow_msg)
+        self.bind(OVS_FLOW_FAMILY, OvsFlow.OvsFlowMsg)
 
     def add_flow(self, dpifindex, flowmsg):
         """
@@ -2678,7 +2680,7 @@ class OvsFlow(GenericNetlinkSocket):
         into the OvsDatapath lookup
         """
 
-        flowmsg = OvsFlow.ovs_flow_msg()
+        flowmsg = OvsFlow.OvsFlowMsg()
         flowmsg["cmd"] = OVS_FLOW_CMD_DEL
         flowmsg["version"] = OVS_DATAPATH_VERSION
         flowmsg["reserved"] = 0
@@ -2706,7 +2708,7 @@ class OvsFlow(GenericNetlinkSocket):
         flowpsec is a string which represents a flow in the dpctl
         format.
         """
-        msg = OvsFlow.ovs_flow_msg()
+        msg = OvsFlow.OvsFlowMsg()
 
         msg["cmd"] = OVS_FLOW_CMD_GET
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2747,7 +2749,7 @@ class OvsFlow(GenericNetlinkSocket):
         print("userspace action command", flush=True)
 
 
-class psample_sample(genlmsg):
+class PsampleSample(genlmsg):
     nla_map = (
         ("PSAMPLE_ATTR_IIFINDEX", "none"),
         ("PSAMPLE_ATTR_OIFINDEX", "none"),
@@ -2784,19 +2786,19 @@ class psample_sample(genlmsg):
         return (f"{','.join(fields)} {data}").strip()
 
 
-class psample_msg(Marshal):
+class PsampleMsg(Marshal):
     PSAMPLE_CMD_SAMPLE = 0
     PSAMPLE_CMD_GET_GROUP = 1
     PSAMPLE_CMD_NEW_GROUP = 2
     PSAMPLE_CMD_DEL_GROUP = 3
     PSAMPLE_CMD_SET_FILTER = 4
-    msg_map = {PSAMPLE_CMD_SAMPLE: psample_sample}
+    msg_map = {PSAMPLE_CMD_SAMPLE: PsampleSample}
 
 
 class PsampleEvent(EventSocket):
     genl_family = "psample"
     mcast_groups = ["packets"]
-    marshal_class = psample_msg
+    marshal_class = PsampleMsg
 
     def read_samples(self):
         print("listening for psample events", flush=True)
@@ -2850,9 +2852,9 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
 
 
 def main(argv):
-    nlmsg_atoms.encap_ovskey = encap_ovskey
-    nlmsg_atoms.ovskey = ovskey
-    nlmsg_atoms.ovsactions = ovsactions
+    nlmsg_atoms.EncapOvsKey = EncapOvsKey
+    nlmsg_atoms.OvsKey = OvsKey
+    nlmsg_atoms.OvsActions = OvsActions
 
     # version check for pyroute2
     prverscheck = pyroute2.__version__.split(".")
@@ -3034,7 +3036,7 @@ def main(argv):
         if rep is None:
             print(f"DP '{args.flbr}' not found.")
             return 1
-        flow = OvsFlow.ovs_flow_msg()
+        flow = OvsFlow.OvsFlowMsg()
         flow.parse(args.flow, args.acts, rep["dpifindex"])
         ovsflow.add_flow(rep["dpifindex"], flow)
     elif hasattr(args, "flsbr"):
-- 
2.53.0


