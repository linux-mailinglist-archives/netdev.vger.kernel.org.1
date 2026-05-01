Return-Path: <netdev+bounces-283172-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ABUjBMOc9GloCwIAu9opvQ
	(envelope-from <netdev+bounces-283172-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:29:55 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AC094AC66A
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 14:29:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D152C3026F3C
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 12:28:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7DBA3A3813;
	Fri,  1 May 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V1R5u+HW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A87F3A2572
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 12:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777638496; cv=none; b=ER0x3TGk0l95Y7MnQRwLflAqTCno5GIIw+Hrl4JSmYV7FnYuBumwpYmGV9yzX3vp6w/SK2S+DQx2Wryg+ajByW1RtL5rXWNAy0HJmAWwHVPKomCR3wgw3LfzxpOQ9gK1x/hq/KnVwbSaOn20i4j19ZwlMJA4igN8gGqW0Y5aA9E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777638496; c=relaxed/simple;
	bh=9TjFmxMAJxEeP15Mp+otopDVbPHM2YTsOimVxWwo2go=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dGADbkCL/2vKX/WmR9PpkYlSu1pC9uPW+a/tHLGZkaysGIkzZnFQDaDvkMVOniK/Kp94GVfkRUg4XQQAEIN4/H5hOTQXTZ4EwX24vubK26c+dYjvnPsqL5qbbM5bOQ8e/uQ71YXGuglEQXW9i/SMA/6kC7WPxIwCV8937C0spXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V1R5u+HW; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2ad9a9be502so10634585ad.0
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 05:28:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777638494; x=1778243294; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEYXiPSD8teEVjafPyld1dLG1JDxUCAY+nTRXNsUO0Y=;
        b=V1R5u+HWQ+/78n/3APuT+DwksG+sYnd+Iynum3HfOlNEM9ybfU5/yOMUHOjDC+yh+k
         qxEgGmDGoRpI+D6Kf+Gd8T/ES7xTuVIe7FroxNx5Zxp6eXvktLHGj26ezgI9V5xDn4tj
         fqDbKixMLh7RfjJUzenfasfZ6O5/SLl7SGD0+rX+gYz98Pi1MacmpIOwpR7281vJYWh6
         ZN3Dd37rKWJ903OeW2PPUer4kfr/SFTtxeNd9Mv7ffmzyzK0ndNiWk0w+5iXHf2IXXaS
         Uu+BemB06RaZdrE8gM9a/DXS7dS/1JnQ8OJMWV2gmPBsvw48vRHYPggIMIvdh2ecdggr
         EkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777638494; x=1778243294;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JEYXiPSD8teEVjafPyld1dLG1JDxUCAY+nTRXNsUO0Y=;
        b=bmcg0uuFTu/YNH4USQ7xHJAVn/vAbu/nWYAUZOjrLEcHZKDrJ/fbNt5tsmmWLIe0Cu
         1rQ6lxKdm6ol+oRdwXeuff3gRd9/NGVUxhG57bS6ToNJ3/xRqnhfJJcX692Bt/CzIFKV
         EcBfnV9bus1AJmVflaGmahUiUuus4jS1k5vTbRel2lxr3od+Yvc+ahGJ/8pu+ZViZMT2
         Tyz6oll57Jbyb5htGvAC7tZo2WLcMuZZKac+P/Uuhdan3a+y2ijP0DhhNMo2bziWAuPO
         7ZkPnpN0uz+ldH0/jl5VHf2XptzhbgmiinVYAfARd7QCB9mEI/zoQwWmQmcQ33aKbVgC
         phSQ==
X-Gm-Message-State: AOJu0YyBeoqpIiuGJF8qpH9HUIKMmZMdLCUbZihG/TPs07cR14XccWVW
	urnYxq2yVjehwSRqm99HvdmGcM17KdERSC4dzGdzBlbnirYUW5VjcYKP3qtgFoAspW0hcw==
X-Gm-Gg: AeBDiesVVglrEuFQ1HS5IGHZCh0iStTIUYRYgX54zdC2iVB2JeHKtjWNi3aDpONqpp3
	H1a5RQHlUpYQDjeEW1ksLBX77a+nxa0RfTqsfd4bXgJh80sTocklo/sJXqE45wa5fvqrbCFxSX1
	ONngNQVzPTyQBKQMqVT8uwuRxEOcH9yiobYruX+KvRpgsVpNGwxDy503xV9O4igIseP/1puRbVD
	yI0kRChViK6o9IRPw92tWauDs9P8KJ1ypa2YePQmpYcrZsRYjWhDsqwZ06OX//qlO3ViPC2umKi
	7z88xJJ01KNeZGHLViCZkHcdCGnqrKYS//NVbd8Jo8ocpxNYZ0kn7Uu/cTaSOARIijZAarwbk1y
	IWIJrrECu6ksQom/UvDEpI+qiso638eZxqLwGAIuAQb1gMKPspG6lEgNlsfUXpORCMcmbxyuaTm
	vgOgzLjbu3UB+b9N4jc6/DVqydvOw=
X-Received: by 2002:a17:902:76ca:b0:2b0:ac1e:973a with SMTP id d9443c01a7336-2b9a2524332mr51585155ad.39.1777638493923;
        Fri, 01 May 2026 05:28:13 -0700 (PDT)
Received: from houminxi ([38.207.130.223])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b9ca953894sm23370395ad.0.2026.05.01.05.28.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 05:28:13 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Minxi Hou <houminxi@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] selftests: openvswitch: add vlan() and encap() flow string parsing
Date: Fri,  1 May 2026 20:27:55 +0800
Message-ID: <20260501122756.3081754-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501122756.3081754-1-houminxi@gmail.com>
References: <20260501122756.3081754-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5AC094AC66A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,openvswitch.org,gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-283172-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[ovs-dpctl.py:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Extend the ovs-dpctl.py flow parser to support vlan() and encap()
match strings.  vlan() accepts tci=, vid=, pcp=, and cfi=
parameters and generates the OVS_KEY_ATTR_VLAN attribute with a TCI
value in network byte order.  encap() parses nested flow strings
and returns OVS_KEY_ATTR_ENCAP with inner key attributes as a
recursive NLA container.

The encap nla_map type is changed from "none" to "nested" so that
pyroute2 recursively encodes the inner flow key attributes.  The
VLAN nla_map type is changed from "uint16" to "be16" to match the
kernel's big-endian wire format.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 190 +++++++++++++++++-
 1 file changed, 188 insertions(+), 2 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 848f61fdcee0..317be7878937 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -901,11 +901,11 @@ class ovskey(nla):
     nla_flags = NLA_F_NESTED
     nla_map = (
         ("OVS_KEY_ATTR_UNSPEC", "none"),
-        ("OVS_KEY_ATTR_ENCAP", "none"),
+        ("OVS_KEY_ATTR_ENCAP", "nested"),
         ("OVS_KEY_ATTR_PRIORITY", "uint32"),
         ("OVS_KEY_ATTR_IN_PORT", "uint32"),
         ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),
-        ("OVS_KEY_ATTR_VLAN", "uint16"),
+        ("OVS_KEY_ATTR_VLAN", "be16"),
         ("OVS_KEY_ATTR_ETHERTYPE", "be16"),
         ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),
         ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),
@@ -1636,6 +1636,180 @@ class ovskey(nla):
     class ovs_key_mpls(nla):
         fields = (("lse", ">I"),)
 
+    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
+    _VLAN_CFI_MASK = 0x1000
+    _MAX_ENCAP_DEPTH = 4
+    _encap_depth = 0  # single-threaded usage assumed
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
+                raise ValueError("vlan(): expected key=value, got '%s'" % flowstr)
+            key = flowstr[:eq].strip()
+            flowstr = flowstr[eq + 1:]
+
+            end = flowstr.find(',')
+            end2 = flowstr.find(')')
+            if end == -1 or (end2 != -1 and end2 < end):
+                end = end2
+            val = flowstr[:end].strip()
+            flowstr = flowstr[end:]
+
+            if not val:
+                raise ValueError("vlan(): empty value for key '%s'" % key)
+            try:
+                v = int(val, 16) if val.startswith(('0x', '0X')) else int(val)
+            except ValueError:
+                raise ValueError("vlan(): invalid value '%s' for key '%s'" %
+                                 (val, key))
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
+        if ovskey._encap_depth >= ovskey._MAX_ENCAP_DEPTH:
+            raise ValueError("encap(): max nesting depth %d exceeded" %
+                             ovskey._MAX_ENCAP_DEPTH)
+        try:
+            ovskey._encap_depth += 1
+            depth = 1
+            end = -1
+            for i, c in enumerate(flowstr):
+                if c == '(':
+                    depth += 1
+                elif c == ')':
+                    depth -= 1
+                    if depth < 0:
+                        raise ValueError("encap(): unmatched ')' at position %d" % i)
+                    if depth == 0:
+                        end = i
+                        break
+
+            if end == -1:
+                if depth > 1:
+                    raise ValueError("encap(): missing ')' at end")
+                raise ValueError("encap(): missing closing ')'")
+
+            inner_str = flowstr[:end].strip()
+            if not inner_str:
+                raise ValueError("encap(): empty inner flow")
+
+            flowstr = flowstr[end + 1:]
+            if flowstr.lstrip().startswith(')'):
+                raise ValueError("encap(): unmatched ')' after encap()")
+            # parse() strips trailing ',', ')', ' ' as inter-field separators,
+            # so we do not need to call strspn here.
+
+            inner_key = ovskey()
+            inner_mask = ovskey()
+            inner_key.parse(inner_str, inner_mask)
+
+            return flowstr, inner_key, inner_mask
+        finally:
+            ovskey._encap_depth -= 1
+
     def parse(self, flowstr, mask=None):
         for field in (
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
@@ -1657,6 +1831,16 @@ class ovskey(nla):
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
@@ -1794,6 +1978,8 @@ class ovskey(nla):
                 True,
             ),
             ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
+            ("OVS_KEY_ATTR_VLAN", "vlan", "0x%04x", lambda x: False, True),
+            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
             (
                 "OVS_KEY_ATTR_ETHERTYPE",
                 "eth_type",
-- 
2.53.0


