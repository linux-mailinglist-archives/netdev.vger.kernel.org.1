Return-Path: <netdev+bounces-287572-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UGQYEPhrBGprIQIAu9opvQ
	(envelope-from <netdev+bounces-287572-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:18:00 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D31F6532F1A
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 14:17:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7599C30D9FD3
	for <lists+netdev@lfdr.de>; Wed, 13 May 2026 12:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CABD38E8B0;
	Wed, 13 May 2026 12:14:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AdGHwcVe"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oo1-f53.google.com (mail-oo1-f53.google.com [209.85.161.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32B1440148F
	for <netdev@vger.kernel.org>; Wed, 13 May 2026 12:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778674442; cv=none; b=nphnKCeNWULwCK+2/UUXyalc+xOtEJd3qVp3hYfq7wDG3oiRaV3cufltDW7fyjGf6/BElT3Qj8zpdoXgerqgxkskz6Ng55NxBA40xjedvv78kbIKA66WoZz65QLrFOexgFWDYVp5XHhfmiztcXGxzzJkwafb3Leb1ocurL5xzlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778674442; c=relaxed/simple;
	bh=CcqQJJBks6kC+vG0jRlgOKD+6l3bXviPjg9CpZxMBJQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZHWD9m34H3WpfUG9OhL8j1b4J2iT7HIMjyuPw1IA10obSeeuoHXlhkvi2Mr1Zr7n4jIYPInv+94Tbh/iTqlPg1ChvJo2ZG1jJLbp3Jg4nQR5a+l70vV03a18vXl50FFJ7Jp9b+cNzk2kEnkDdl25d+rAJZd6oM5FiXa+umw3Sf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AdGHwcVe; arc=none smtp.client-ip=209.85.161.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f53.google.com with SMTP id 006d021491bc7-696ad0c2c2fso3644727eaf.0
        for <netdev@vger.kernel.org>; Wed, 13 May 2026 05:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778674439; x=1779279239; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IYmtWjdonQdBE+XBQZ5XkATSFr9jw+jhULGmcan1NUU=;
        b=AdGHwcVedLTKaA4dSkiZD9l8HnO7XSTcUo3kDIZyd7YhgosrbuCJyYskroBpjl2GZH
         jgo9Lf1Oylc1D+K5aQUGCOTNOVNvxzOJKcNJmaVVKQxFsHe6XjwK79HIsA6NXG7bgBZD
         i4azi/v+wGs4p2U6kaUPeKmkSF7+QUr1KHuLXALmIKcA1T3wkyS1MqGmu7j3AbJtsUpO
         XfyHNQgLT6i6+RC628K2aTetlOCbwzH9u+4i1o7VfYUqtTCFQpWta66KMroVi3OAvaIP
         w3Y33vRIGVvtvxPgpRnVL8QDJpu7CJTq8upnZ0x41nFczIIc72yrYGukywnqt/kyCEoi
         7kxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778674439; x=1779279239;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IYmtWjdonQdBE+XBQZ5XkATSFr9jw+jhULGmcan1NUU=;
        b=g10BYrkDep02Yt31dc9IPuwOGbN3V72qSVLeJAazTIsiWFn4fWNA0XU1kOuo9HUmmP
         04P1H6VNrphVkz+lrzfqOMpt1uAq9+F/6a35qS23ANna0FVu367G34V9VFEwZdjF3iO3
         rX9JAizeD6IuYSBCqM66MKji0TFhtFyOBulu0V/HAWrYwbVT4LBrhsPh/VtoNG1DJm0j
         n3/0uq3UM7mgO/LkXaKYAjPbidLtfBsOWO6AaEWwHpt1CR2QT7BV4SdWrLRCe4FsQbr1
         /tnegO7KzSqhEq8KGex1awVAeh/h8p2x2J2/xhHBKYgwL7GACJkfWoqx4dr70fre56Vc
         1yyw==
X-Gm-Message-State: AOJu0YzBwmsQeXuptNhysn8Q5Tx7E2gbdFGHZ6AiABTFf+8/XLj0jenI
	sItO+/OWyJy1+T5PzvSR6N2LWU0TOqG98QN02jRlUUahms349VLjADSHdwlozfCWxVw=
X-Gm-Gg: Acq92OHy2CUfcgQwuF3jnzs7yZiVNyMu1DkHdpRe9UdrjPGKm4JGVEpCAPYFg5lWMny
	1ntoTJySaX07Xjn+917O8egoqTejWOXbt1L8tTGPlvqZO1pB3KMKHEG2kYPd003PllZ+LMayWQB
	8dW2Yv/M6cwUQoYMiiv1V71cnNK09xSHpQvZsQA0mYVVFUCm8F6sBjGOKrFa4RjgEiSIOWhQK9m
	JkxMPf25Lt48F1leR2+gYyc+l3d3Q3RyeEyQB97FuLC5bAGQJuBnJRhZeD3sR6QYJO6i+vM1eno
	c9ZF58/ysB34l5FHn5if8cOWjSWiXe/6bn+fWqs1Y6ohkR5mp7U4NnyROQxr+W6OcQLCtNDT0wJ
	+ocunt8kjToz6ZvOQIu9hb8Xk/I32A9w8tHpGdQ2uOWOINkbdQ/fI0dNDgg7LeLkdSXrvr15hUh
	mDd5eCy+sgFIysMmc=
X-Received: by 2002:a05:6820:1b12:b0:68a:af54:cb61 with SMTP id 006d021491bc7-69b78defac3mr1523556eaf.60.1778674438562;
        Wed, 13 May 2026 05:13:58 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4355736dbc0sm15189442fac.11.2026.05.13.05.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 May 2026 05:13:58 -0700 (PDT)
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
Subject: [PATCH net-next 4/5] selftests: openvswitch: add missing docstrings in ovs-dpctl.py
Date: Wed, 13 May 2026 20:12:39 +0800
Message-ID: <20260513121240.2590767-5-houminxi@gmail.com>
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
X-Rspamd-Queue-Id: D31F6532F1A
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
	TAGGED_FROM(0.00)[bounces-287572-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
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
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add one-line docstrings to all module, class, and method
definitions to fix C0114, C0115, and C0116 pylint warnings.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 94 ++++++++++++++++++-
 1 file changed, 91 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 6a9cf48948fd..3683796ba2e2 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1,5 +1,6 @@
 #!/usr/bin/env python3
 # SPDX-License-Identifier: GPL-2.0
+"""OVS datapath control utility for kernel selftests."""
 
 # Controls the openvswitch module.  Part of the kselftest suite, but
 # can be used for some diagnostic purpose as well.
@@ -64,11 +65,13 @@ OVS_FLOW_CMD_SET = 4
 UINT32_MAX = 0xFFFFFFFF
 
 def macstr(mac):
+    """Format MAC address bytes as colon-separated hex string."""
     outstr = ":".join([f"{i:02X}" for i in mac])
     return outstr
 
 
 def strcspn(str1, str2):
+    """Return index of first char in str1 that is in str2."""
     tot = 0
     for char in str1:
         if str2.find(char) != -1:
@@ -78,6 +81,7 @@ def strcspn(str1, str2):
 
 
 def strspn(str1, str2):
+    """Return index of first char in str1 that is not in str2."""
     tot = 0
     for char in str1:
         if str2.find(char) == -1:
@@ -87,6 +91,7 @@ def strspn(str1, str2):
 
 
 def intparse(statestr, defmask="0xffffffff"):
+    """Parse an integer with optional mask from a state string."""
     totalparse = strspn(statestr, "0123456789abcdefABCDEFx/")
     # scan until "/"
     count = strspn(statestr, "x0123456789abcdefABCDEF")
@@ -107,6 +112,7 @@ def intparse(statestr, defmask="0xffffffff"):
 
 
 def parse_flags(flag_str, flag_vals):
+    """Parse flag string into bitmask and mask values."""
     bit_result = 0
     mask_result = 0
 
@@ -158,6 +164,7 @@ def parse_flags(flag_str, flag_vals):
 
 
 def parse_ct_state(statestr):
+    """Parse conntrack state flags string."""
     ct_flags = {
         "new": 1 << 0,
         "est": 1 << 1,
@@ -173,6 +180,7 @@ def parse_ct_state(statestr):
 
 
 def convert_mac(data):
+    """Convert MAC address string with optional mask to bytes."""
     def to_bytes(mac):
         mac_split = mac.split(":")
         ret = bytearray([int(i, 16) for i in mac_split])
@@ -188,6 +196,7 @@ def convert_mac(data):
     return to_bytes(mac_str), to_bytes(mask_str)
 
 def convert_ipv4(data):
+    """Convert IPv4 address string with optional mask to integers."""
     ip, _, mask = data.partition('/')
 
     if not ip:
@@ -200,6 +209,7 @@ def convert_ipv4(data):
     return int(ipaddress.IPv4Address(ip)), int(ipaddress.IPv4Address(mask))
 
 def convert_ipv6(data):
+    """Convert IPv6 address string with optional mask to packed bytes."""
     ip, _, mask = data.partition('/')
 
     if not ip:
@@ -212,6 +222,7 @@ def convert_ipv6(data):
     return ipaddress.IPv6Address(ip).packed, ipaddress.IPv6Address(mask).packed
 
 def convert_int(size):
+    """Return a converter for integer fields of the given bit size."""
     def convert_int_sized(data):
         value, _, mask = data.partition('/')
 
@@ -224,6 +235,7 @@ def convert_int(size):
     return convert_int_sized
 
 def parse_starts_block(block_str, scanstr, returnskipped, scanregex=False):
+    """Check if block_str starts with scanstr, optionally skip it."""
     if scanregex:
         m = re.search(scanstr, block_str)
         if m is None:
@@ -250,6 +262,7 @@ def parse_starts_block(block_str, scanstr, returnskipped, scanregex=False):
 def parse_extract_field(
     block_str, fieldstr, scanfmt, convert, masked=False, defval=None
 ):
+    """Extract a field value from block_str using regex scanfmt."""
     if fieldstr and not block_str.startswith(fieldstr):
         return block_str, defval
 
@@ -349,6 +362,7 @@ def parse_attrs(actstr, attr_desc):
 
 
 class OvsDpMsg(genlmsg):
+    """OVS datapath generic netlink message."""
     # include the OVS version
     # We need a custom header rather than just being able to rely on
     # genlmsg because fields ends up not expressing everything correctly
@@ -357,6 +371,7 @@ class OvsDpMsg(genlmsg):
 
 
 class OvsActions(nla):
+    """OVS datapath actions netlink attribute."""
     nla_flags = NLA_F_NESTED
 
     nla_map = (
@@ -389,6 +404,7 @@ class OvsActions(nla):
     )
 
     class Psample(nla):
+        """Packet sampling action attributes."""
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -398,6 +414,7 @@ class OvsActions(nla):
         )
 
         def dpstr(self, more=False):
+            """Format psample attributes as dpctl string."""
             args = f"group={self.get_attr('OVS_PSAMPLE_ATTR_GROUP')}"
 
             cookie = self.get_attr("OVS_PSAMPLE_ATTR_COOKIE")
@@ -407,6 +424,7 @@ class OvsActions(nla):
             return f"psample({args})"
 
         def parse(self, actstr):
+            """Parse psample attributes from dpctl string."""
             desc = (
                 ("group", "OVS_PSAMPLE_ATTR_GROUP", int),
                 ("cookie", "OVS_PSAMPLE_ATTR_COOKIE",
@@ -421,9 +439,11 @@ class OvsActions(nla):
             return actstr
 
     class PushVlan(nla):
+        """Push VLAN action fields (tpid + tci)."""
         fields = (("vlan_tpid", "!H"), ("vlan_tci", "!H"))
 
     class Sample(nla):
+        """Sample action attributes."""
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -433,6 +453,7 @@ class OvsActions(nla):
         )
 
         def dpstr(self, more=False):
+            """Format sample attributes as dpctl string."""
             args = []
 
             prob = 100 * self.get_attr(
@@ -446,6 +467,7 @@ class OvsActions(nla):
             return f"sample({','.join(args)})"
 
         def parse(self, actstr):
+            """Parse sample attributes from dpctl string."""
             def parse_nested_actions(actstr):
                 subacts = OvsActions()
                 parsed_len = subacts.parse(actstr)
@@ -456,7 +478,7 @@ class OvsActions(nla):
                 return int(math.floor(UINT32_MAX * (percent / 100.0) + .5))
 
             desc = (
-                ("Sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
+                ("sample", "OVS_SAMPLE_ATTR_PROBABILITY", percent_to_rate),
                 ("actions", "OVS_SAMPLE_ATTR_ACTIONS", parse_nested_actions),
             )
             attrs, actstr = parse_attrs(actstr, desc)
@@ -467,6 +489,7 @@ class OvsActions(nla):
             return actstr
 
     class CtAct(nla):
+        """Conntrack action attributes."""
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -483,6 +506,7 @@ class OvsActions(nla):
         )
 
         class NatAttr(nla):
+            """NAT sub-action attributes."""
             nla_flags = NLA_F_NESTED
 
             nla_map = (
@@ -499,6 +523,7 @@ class OvsActions(nla):
             )
 
             def dpstr(self, more=False):
+                """Format NAT attributes as dpctl string."""
                 print_str = "nat("
 
                 if self.get_attr("OVS_NAT_ATTR_SRC"):
@@ -537,6 +562,7 @@ class OvsActions(nla):
                 return print_str
 
         def dpstr(self, more=False):
+            """Format conntrack attributes as dpctl string."""
             print_str = "ct("
 
             if self.get_attr("OVS_CT_ATTR_COMMIT") is not None:
@@ -558,6 +584,7 @@ class OvsActions(nla):
             return print_str
 
     class Userspace(nla):
+        """Userspace action attributes."""
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -568,6 +595,7 @@ class OvsActions(nla):
         )
 
         def dpstr(self, more=False):
+            """Format userspace attributes as dpctl string."""
             print_str = "userspace("
             if self.get_attr("OVS_USERSPACE_ATTR_PID") is not None:
                 print_str += f"pid={self.get_attr('OVS_USERSPACE_ATTR_PID')},"
@@ -583,6 +611,7 @@ class OvsActions(nla):
             return print_str
 
         def parse(self, actstr):
+            """Parse userspace attributes from dpctl string."""
             attrs_desc = (
                 ("pid", "OVS_USERSPACE_ATTR_PID", int),
                 ("userdata", "OVS_USERSPACE_ATTR_USERDATA",
@@ -597,6 +626,7 @@ class OvsActions(nla):
             return actstr
 
     def dpstr(self, more=False):
+        """Format all actions as dpctl string."""
         print_str = ""
 
         for field in self["attrs"]:
@@ -652,12 +682,13 @@ class OvsActions(nla):
                 else:
                     try:
                         print_str += datum.dpstr(more)
-                    except:
-                        print_str += "{ATTR: %s not decoded}" % field[0]
+                    except Exception:
+                        print_str += f"{{ATTR: {field[0]} not decoded}}"
 
         return print_str
 
     def parse(self, actstr):
+        """Parse actions from dpctl string."""
         totallen = len(actstr)
         while len(actstr) != 0:
             parsed = False
@@ -934,6 +965,7 @@ class OvsActions(nla):
 
 
 class OvsKey(nla):
+    """OVS flow key netlink attribute."""
     nla_flags = NLA_F_NESTED
     nla_map = (
         ("OVS_KEY_ATTR_UNSPEC", "none"),
@@ -972,6 +1004,7 @@ class OvsKey(nla):
     )
 
     class OvsKeyProto(nla):
+        """Protocol key fields (ethertype)."""
         fields = (
             ("src", "!H"),
             ("dst", "!H"),
@@ -1004,6 +1037,7 @@ class OvsKey(nla):
             )
 
         def parse(self, flowstr, type_inst):
+            """Parse protocol key from dpctl string."""
             if not flowstr.startswith(self.proto_str):
                 return None, None
 
@@ -1045,6 +1079,7 @@ class OvsKey(nla):
             return flowstr, k, m
 
         def dpstr(self, masked=None, more=False):
+            """Format protocol key as dpctl string."""
             outstr = f"{self.proto_str}("
             first = False
             for f in self.fields_map:
@@ -1073,6 +1108,7 @@ class OvsKey(nla):
             return outstr
 
     class EthAddr(OvsKeyProto):
+        """Ethernet address key fields."""
         fields = (
             ("src", "!6s"),
             ("dst", "!6s"),
@@ -1114,6 +1150,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyIpv4(OvsKeyProto):
+        """IPv4 key fields."""
         fields = (
             ("src", "!I"),
             ("dst", "!I"),
@@ -1167,6 +1204,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyIpv6(OvsKeyProto):
+        """IPv6 key fields."""
         fields = (
             ("src", "!16s"),
             ("dst", "!16s"),
@@ -1218,6 +1256,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyTcp(OvsKeyProto):
+        """TCP key fields (src/dst port)."""
         def __init__(
             self,
             data=None,
@@ -1237,6 +1276,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyUdp(OvsKeyProto):
+        """UDP key fields (src/dst port)."""
         def __init__(
             self,
             data=None,
@@ -1256,6 +1296,7 @@ class OvsKey(nla):
             )
 
     class OvsKeySctp(OvsKeyProto):
+        """SCTP key fields (src/dst port)."""
         def __init__(
             self,
             data=None,
@@ -1275,6 +1316,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyIcmp(OvsKeyProto):
+        """ICMP key fields (type/code)."""
         fields = (
             ("type", "B"),
             ("code", "B"),
@@ -1304,6 +1346,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyIcmpv6(OvsKeyIcmp):
+        """ICMPv6 key fields (type/code)."""
         def __init__(
             self,
             data=None,
@@ -1323,6 +1366,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyArp(OvsKeyProto):
+        """ARP key fields."""
         fields = (
             ("sip", "!I"),
             ("tip", "!I"),
@@ -1383,6 +1427,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyNd(OvsKeyProto):
+        """Neighbor discovery key fields."""
         fields = (
             ("target", "!16s"),
             ("sll", "!6s"),
@@ -1419,6 +1464,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyCtTupleIpv4(OvsKeyProto):
+        """Conntrack original tuple key (IPv4)."""
         fields = (
             ("src", "!I"),
             ("dst", "!I"),
@@ -1466,6 +1512,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyCtTupleIpv6(nla):
+        """Conntrack original tuple key (IPv6)."""
         fields = (
             ("src", "!16s"),
             ("dst", "!16s"),
@@ -1511,6 +1558,7 @@ class OvsKey(nla):
             )
 
     class OvsKeyTunnel(nla):
+        """Tunnel key fields."""
         nla_flags = NLA_F_NESTED
 
         nla_map = (
@@ -1534,6 +1582,7 @@ class OvsKey(nla):
         )
 
         def parse(self, flowstr, mask=None):
+            """Parse tunnel key from dpctl string."""
             if not flowstr.startswith("tunnel("):
                 return None, None
 
@@ -1626,6 +1675,7 @@ class OvsKey(nla):
             return flowstr, k, mask
 
         def dpstr(self, mask=None, more=False):
+            """Format tunnel key as dpctl string."""
             print_str = "tunnel("
 
             flagsattrs = []
@@ -1668,6 +1718,7 @@ class OvsKey(nla):
             return print_str
 
     class OvsKeyMpls(nla):
+        """MPLS key fields."""
         fields = (("lse", ">I"),)
 
     # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
@@ -1857,6 +1908,7 @@ class OvsKey(nla):
         return flowstr, inner_key, inner_mask
 
     def parse(self, flowstr, mask=None):
+        """Parse flow key from dpctl string."""
         for field in (
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
             ("OVS_KEY_ATTR_SKB_MARK", "skb_mark", intparse),
@@ -1943,6 +1995,7 @@ class OvsKey(nla):
         return flowstr
 
     def dpstr(self, mask=None, more=False):
+        """Format flow key as dpctl string."""
         print_str = ""
 
         for field in (
@@ -2112,11 +2165,13 @@ class EncapOvsKey(OvsKey):
 
 
 class OvsPacket(GenericNetlinkSocket):
+    """OVS packet command message."""
     OVS_PACKET_CMD_MISS = 1  # Flow table miss
     OVS_PACKET_CMD_ACTION = 2  # USERSPACE action
     OVS_PACKET_CMD_EXECUTE = 3  # Apply actions to packet
 
     class OvsPacketMsg(OvsDpMsg):
+        """OVS packet message header."""
         nla_map = (
             ("OVS_PACKET_ATTR_UNSPEC", "none"),
             ("OVS_PACKET_ATTR_PACKET", "array(uint8)"),
@@ -2137,6 +2192,7 @@ class OvsPacket(GenericNetlinkSocket):
         self.bind(OVS_PACKET_FAMILY, OvsPacket.OvsPacketMsg)
 
     def upcall_handler(self, up=None):
+        """Listen for packet upcall messages."""
         print("listening on upcall packet handler:", self.epid)
         while True:
             try:
@@ -2157,6 +2213,7 @@ class OvsPacket(GenericNetlinkSocket):
 
 
 class OvsDatapath(GenericNetlinkSocket):
+    """OVS datapath management."""
     OVS_DP_F_VPORT_PIDS = 1 << 1
     OVS_DP_F_DISPATCH_UPCALL_PER_CPU = 1 << 3
 
@@ -2178,6 +2235,7 @@ class OvsDatapath(GenericNetlinkSocket):
         )
 
         class DpStats(nla):
+            """Datapath statistics."""
             fields = (
                 ("hit", "=Q"),
                 ("missed", "=Q"),
@@ -2186,6 +2244,7 @@ class OvsDatapath(GenericNetlinkSocket):
             )
 
         class MegaflowStats(nla):
+            """Megaflow cache statistics."""
             fields = (
                 ("mask_hit", "=Q"),
                 ("masks", "=I"),
@@ -2199,6 +2258,7 @@ class OvsDatapath(GenericNetlinkSocket):
         self.bind(OVS_DATAPATH_FAMILY, OvsDatapath.DpCmdMsg)
 
     def info(self, dpname, ifindex=0):
+        """Get datapath information by name."""
         msg = OvsDatapath.DpCmdMsg()
         msg["cmd"] = OVS_DP_CMD_GET
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2222,6 +2282,7 @@ class OvsDatapath(GenericNetlinkSocket):
     def create(
         self, dpname, should_upcall=False, version_str=None, p=OvsPacket()
     ):
+        """Create a new datapath."""
         msg = OvsDatapath.DpCmdMsg()
         msg["cmd"] = OVS_DP_CMD_NEW
         if version_str is None:
@@ -2263,6 +2324,7 @@ class OvsDatapath(GenericNetlinkSocket):
         return reply
 
     def destroy(self, dpname):
+        """Destroy a datapath."""
         msg = OvsDatapath.DpCmdMsg()
         msg["cmd"] = OVS_DP_CMD_DEL
         msg["version"] = OVS_DATAPATH_VERSION
@@ -2285,6 +2347,7 @@ class OvsDatapath(GenericNetlinkSocket):
 
 
 class OvsVport(GenericNetlinkSocket):
+    """OVS virtual port management."""
     OVS_VPORT_TYPE_NETDEV = 1
     OVS_VPORT_TYPE_INTERNAL = 2
     OVS_VPORT_TYPE_GRE = 3
@@ -2292,6 +2355,7 @@ class OvsVport(GenericNetlinkSocket):
     OVS_VPORT_TYPE_GENEVE = 5
 
     class OvsVportMsg(OvsDpMsg):
+        """Vport info message."""
         nla_map = (
             ("OVS_VPORT_ATTR_UNSPEC", "none"),
             ("OVS_VPORT_ATTR_PORT_NO", "uint32"),
@@ -2306,6 +2370,7 @@ class OvsVport(GenericNetlinkSocket):
         )
 
         class VportOpts(nla):
+            """Vport options attributes."""
             nla_map = (
                 ("OVS_TUNNEL_ATTR_UNSPEC", "none"),
                 ("OVS_TUNNEL_ATTR_DST_PORT", "uint16"),
@@ -2313,6 +2378,7 @@ class OvsVport(GenericNetlinkSocket):
             )
 
         class VportStats(nla):
+            """Vport traffic statistics."""
             fields = (
                 ("rx_packets", "=Q"),
                 ("tx_packets", "=Q"),
@@ -2326,6 +2392,7 @@ class OvsVport(GenericNetlinkSocket):
 
     @staticmethod
     def type_to_str(vport_type):
+        """Convert vport type integer to string."""
         if vport_type == OvsVport.OVS_VPORT_TYPE_NETDEV:
             return "netdev"
         if vport_type == OvsVport.OVS_VPORT_TYPE_INTERNAL:
@@ -2340,6 +2407,7 @@ class OvsVport(GenericNetlinkSocket):
 
     @staticmethod
     def str_to_type(vport_type):
+        """Convert vport type string to integer."""
         if vport_type == "netdev":
             return OvsVport.OVS_VPORT_TYPE_NETDEV
         if vport_type == "internal":
@@ -2358,6 +2426,7 @@ class OvsVport(GenericNetlinkSocket):
         self.upcall_packet = packet
 
     def info(self, vport_name, dpifindex=0, portno=None):
+        """Get vport information by name or port number."""
         msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_GET
@@ -2383,6 +2452,7 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def attach(self, dpindex, vport_ifname, ptype, dport, lwt):
+        """Attach a new vport to a datapath."""
         msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_NEW
@@ -2449,6 +2519,7 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def reset_upcall(self, dpindex, vport_ifname, p=None):
+        """Reset vport upcall PID."""
         msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_SET
@@ -2474,6 +2545,7 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def detach(self, dpindex, vport_ifname):
+        """Remove a vport from a datapath."""
         msg = OvsVport.OvsVportMsg()
 
         msg["cmd"] = OVS_VPORT_CMD_DEL
@@ -2495,11 +2567,14 @@ class OvsVport(GenericNetlinkSocket):
         return reply
 
     def upcall_handler(self, handler=None):
+        """Start upcall handler for packet events."""
         self.upcall_packet.upcall_handler(handler)
 
 
 class OvsFlow(GenericNetlinkSocket):
+    """OVS flow table management."""
     class OvsFlowMsg(OvsDpMsg):
+        """Flow info message."""
         nla_map = (
             ("OVS_FLOW_ATTR_UNSPEC", "none"),
             ("OVS_FLOW_ATTR_KEY", "OvsKey"),
@@ -2515,12 +2590,14 @@ class OvsFlow(GenericNetlinkSocket):
         )
 
         class FlowStats(nla):
+            """Flow packet and byte counters."""
             fields = (
                 ("packets", "=Q"),
                 ("bytes", "=Q"),
             )
 
         def dpstr(self, more=False):
+            """Format flow as dpctl string."""
             ufid = self.get_attr("OVS_FLOW_ATTR_UFID")
             ufid_str = ""
             if ufid is not None:
@@ -2587,6 +2664,7 @@ class OvsFlow(GenericNetlinkSocket):
             return print_str
 
         def parse(self, flowstr, actstr, dpidx=0):
+            """Parse flow from dpctl string."""
             ovs_ufid_f_omit_key = 1 << 0
             ovs_ufid_f_omit_mask = 1 << 1
             ovs_ufid_f_omit_actions = 1 << 2
@@ -2731,6 +2809,7 @@ class OvsFlow(GenericNetlinkSocket):
         return rep
 
     def miss(self, packetmsg):
+        """Handle flow table miss upcall."""
         seq = packetmsg["header"]["sequence_number"]
         keystr = "(none)"
         key_field = packetmsg.get_attr("OVS_PACKET_ATTR_KEY")
@@ -2743,13 +2822,16 @@ class OvsFlow(GenericNetlinkSocket):
         print(f"MISS upcall[{seq}/{pktpres}]: {keystr}", flush=True)
 
     def execute(self, packetmsg):
+        """Handle packet execute command."""
         print("userspace execute command", flush=True)
 
     def action(self, packetmsg):
+        """Handle userspace action upcall."""
         print("userspace action command", flush=True)
 
 
 class PsampleSample(genlmsg):
+    """Psample generic netlink event handler."""
     nla_map = (
         ("PSAMPLE_ATTR_IIFINDEX", "none"),
         ("PSAMPLE_ATTR_OIFINDEX", "none"),
@@ -2770,6 +2852,7 @@ class PsampleSample(genlmsg):
     )
 
     def dpstr(self):
+        """Format psample attributes as string."""
         fields = []
         data = ""
         for (attr, value) in self["attrs"]:
@@ -2787,6 +2870,7 @@ class PsampleSample(genlmsg):
 
 
 class PsampleMsg(Marshal):
+    """Psample generic netlink message."""
     PSAMPLE_CMD_SAMPLE = 0
     PSAMPLE_CMD_GET_GROUP = 1
     PSAMPLE_CMD_NEW_GROUP = 2
@@ -2796,11 +2880,13 @@ class PsampleMsg(Marshal):
 
 
 class PsampleEvent(EventSocket):
+    """Psample event listener."""
     genl_family = "psample"
     mcast_groups = ["packets"]
     marshal_class = PsampleMsg
 
     def read_samples(self):
+        """Read psample events in a loop."""
         print("listening for psample events", flush=True)
         while True:
             try:
@@ -2811,6 +2897,7 @@ class PsampleEvent(EventSocket):
 
 
 def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
+    """Print full OVS datapath information."""
     dp_name = dp_lookup_rep.get_attr("OVS_DP_ATTR_NAME")
     base_stats = dp_lookup_rep.get_attr("OVS_DP_ATTR_STATS")
     megaflow_stats = dp_lookup_rep.get_attr("OVS_DP_ATTR_MEGAFLOW_STATS")
@@ -2852,6 +2939,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
 
 
 def main(argv):
+    """Entry point for ovs-dpctl utility."""
     nlmsg_atoms.EncapOvsKey = EncapOvsKey
     nlmsg_atoms.OvsKey = OvsKey
     nlmsg_atoms.OvsActions = OvsActions
-- 
2.53.0


