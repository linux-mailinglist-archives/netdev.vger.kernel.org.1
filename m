Return-Path: <netdev+bounces-283594-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELcuHlU792kddwIAu9opvQ
	(envelope-from <netdev+bounces-283594-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:11:01 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 10C2E4B5851
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 410873007362
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69159223323;
	Sun,  3 May 2026 12:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Gw0s0Lg6"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4FC03AEF44
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 12:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810208; cv=none; b=c2v6ahPXbSx85eaT6nASg3ACsCR52lqAqIlJfUut9ZEarZ+QGak2mbDOmgHMTMfoKYCC16dxwryTixX4jvARosDNG5W0cvhasqnbGKzPnyS8hjHkmKbEycLseNl8UzMYHXBibBOZahTxgRIOFvvLmT8gmti0A2NH2OL9k+o6mBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810208; c=relaxed/simple;
	bh=JHmA4rMTC2MHuEjdVmobCJFO6Xefic4QUwemwnkLCCA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=U/WCPkaCO6AcjIOcNxaYGOK/Y1pxMHNnXVyl1RnLyUNSyL5oltt7Y3nviykuVRWpqmlNOajv2TTEE8uacgHM5OcjCvnnyRPktxNNxHeJHC7GTrPpm43eLuID9bnI39KK+HQpobh2JNjpu3blrzd/oYpHqAD9FxUhfPTfKgdXMeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Gw0s0Lg6; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-827270d50d4so2948690b3a.3
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 05:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810206; x=1778415006; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6utT0Hv2eGgWU4nshWAYScicxAuDmTSqPVs1o0+nlVk=;
        b=Gw0s0Lg6UIZSJoZQdcivZ1IN+uUj3EhZJG3XtQtjWvlWeXvkStkxyKNa8YOCq7CWLz
         KC5LF+W7iaJLhNF70fmbSgW99GlxapV7yPNTW2fW8ABVekmTcBzByaSGGa3EuHNWAvEB
         oafADK7sZrFfMW5aX5hcyurHf+qXv3t+EUdbc0PboPXreJ6jBE+B8nApjFDvoQvzW8BC
         sHt4q80tlgRyjmhjG0HRPLP6UC+2jXyhVQd1qwPgePHyzx47cQJqZQE3y1TyaChf1itJ
         tZQ5yOHyCv27h5H4DwQWsSFLapIGnpuwv7wEM6Y07AH9WqV1aqO4D9ZBxMRe6Q7SoslB
         4E/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810206; x=1778415006;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6utT0Hv2eGgWU4nshWAYScicxAuDmTSqPVs1o0+nlVk=;
        b=hb7OaKjp3T8fbiCD/EUR9zmaUFY22lgTW4/pFXnmoNIkcf9M5M9y1Wa1SupHUR9mJU
         j+NhlyeiBufTOkEFxwJzmq738jBLB7SRJc1Q7qvdMpwjV58jPDAKUMnkWL6VP92ckR6O
         bTP2YXU7I3EvuntBs+QqMIv3L6u72yTUUdmaepL9JOHqTiboZq7EG7qmmeqOGEJb8BXh
         ht1d1vfpLG56xbqAkkaexjSfXCpzDY3iywaUCf3jjwEIcHinTqn27mFVSuwqerCextxa
         UpYdE5ax9oRqo+aebLCsZmiUSydimUIW1ufwN4GllkE1j6CuAXC8U6vv0r4xoKPwm166
         ayng==
X-Gm-Message-State: AOJu0YweZqpwBF50AgH/ruK/iw/eIESglXbtKuKFs9ksOmVzD0PdnoHw
	+XotWa10VUhLz/8QHC6NATGpW48PM4SwVr24xmVTg9uyzF3VurRYXl1h48H/KYDZixM=
X-Gm-Gg: AeBDietfq3omljAqC7Q/dvXmYHHD3mL6u5Z94UzdiOqrEKGqZ0a4iMQAZLqYgUTWCQe
	07VHWqoUvqBO+d2L9piqehNwK3gaqyE0trQPklmHG+xBhrzQmBecdXXIPmSA1gyvHRAZrf5zoAK
	crKZzjnf9vIs/UxzJS7rA8ASQgPrksR9vXyDFjGmk4OIzAztIm6PL59pZ7TEmleTEJR9G2ma/K0
	31JQmOEc4FZC4GM2X3x0PMIn+pqcUnntqEfn/0qiaaPwuPiXUSRjMwTNv6LqNJlcCoK02ilHfIi
	27Xbc1lqcmLCDadL5qgI9w/9/EkGu5jaAaCbpAozqa1eV7oTRFC9N3H70pjq38KVOKZ79RbwGQe
	AlLd7TmR3hmJd+gEffw1Qv9a4TRYoYu2RoxFqAOICHeuoDugVMgJlkiigpki07f1f6nXs4H0PaV
	dokT8zgeZTDfCIBhUeSEnhgQxtsZo=
X-Received: by 2002:a05:6a00:2441:b0:82f:6e9:d1c3 with SMTP id d2e1a72fcca58-8352d21aa3fmr6674819b3a.29.1777810205340;
        Sun, 03 May 2026 05:10:05 -0700 (PDT)
Received: from houminxi ([151.242.165.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515acfd8csm8240218b3a.29.2026.05.03.05.10.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:04 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 1/2] selftests: openvswitch: add vlan() and encap() flow string parsing
Date: Sun,  3 May 2026 20:09:45 +0800
Message-ID: <20260503120946.51869-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503120946.51869-1-houminxi@gmail.com>
References: <20260503120946.51869-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 10C2E4B5851
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283594-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add VLAN TCI formatting and parsing support to ovs-dpctl.py:

- Add _vlan_dpstr() to decompose TCI into vid/pcp/cfi fields,
  with raw tci=0x%04x fallback when cfi=0 for round-trip safety.
- Add _parse_vlan_from_flowstr() boundary check for missing ')'.
- Add encap_ovskey subclass restricting nla_map to L2-L4 attributes
  (slots 0-21) that appear inside 802.1Q ENCAP, with metadata
  attributes set to "none".
- Check parse() return value for unrecognized trailing content.
- Support callable format functions in dpstr() output.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/ovs-dpctl.py    | 267 +++++++++++++++++-
 1 file changed, 259 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 848f61fdcee0..87b1ab7bf201 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -901,11 +901,11 @@ class ovskey(nla):
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
@@ -1636,6 +1636,204 @@ class ovskey(nla):
     class ovs_key_mpls(nla):
         fields = (("lse", ">I"),)
 
+    # 802.1Q CFI (Canonical Format Indicator) bit, always set for Ethernet
+    _VLAN_CFI_MASK = 0x1000
+    _MAX_ENCAP_DEPTH = 4
+    _encap_depth = 0  # single-threaded usage assumed
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
+                        raise ValueError(
+                            "encap(): unmatched ')' at position %d" % i)
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
+            inner_key = encap_ovskey()
+            inner_mask = encap_ovskey()
+            remaining = inner_key.parse(inner_str, inner_mask)
+            if remaining and re.search(r'[^\s,)]', remaining):
+                raise ValueError(
+                    "encap(): unrecognized trailing "
+                    "content '%s'" % remaining.strip())
+
+            return flowstr, inner_key, inner_mask
+        finally:
+            ovskey._encap_depth -= 1
+
     def parse(self, flowstr, mask=None):
         for field in (
             ("OVS_KEY_ATTR_PRIORITY", "skb_priority", intparse),
@@ -1657,6 +1855,16 @@ class ovskey(nla):
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
@@ -1794,6 +2002,9 @@ class ovskey(nla):
                 True,
             ),
             ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
+            ("OVS_KEY_ATTR_VLAN", "vlan", ovskey._vlan_dpstr,
+                lambda x: False, True),
+            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
             (
                 "OVS_KEY_ATTR_ETHERTYPE",
                 "eth_type",
@@ -1821,22 +2032,61 @@ class ovskey(nla):
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
+                        if callable(fmt):
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
+    are set to "none" — they never appear inside ENCAP per
+    ovs_nla_put_vlan() in net/openvswitch/flow_netlink.c.
+
+    nla_map indexes must match OVS_KEY_ATTR_* enum values in
+    include/uapi/linux/openvswitch.h.
+    """
+    nla_map = (
+        ("OVS_KEY_ATTR_UNSPEC", "none"),       # 0
+        ("OVS_KEY_ATTR_ENCAP", "none"),        # 1 — placeholder, no recursion
+        ("OVS_KEY_ATTR_PRIORITY", "none"),       # 2 — skb metadata, not in ENCAP
+        ("OVS_KEY_ATTR_IN_PORT", "none"),       # 3 — skb metadata, not in ENCAP
+        ("OVS_KEY_ATTR_ETHERNET", "ethaddr"),   # 4
+        ("OVS_KEY_ATTR_VLAN", "be16"),          # 5
+        ("OVS_KEY_ATTR_ETHERTYPE", "be16"),     # 6
+        ("OVS_KEY_ATTR_IPV4", "ovs_key_ipv4"),  # 7
+        ("OVS_KEY_ATTR_IPV6", "ovs_key_ipv6"),  # 8
+        ("OVS_KEY_ATTR_TCP", "ovs_key_tcp"),    # 9
+        ("OVS_KEY_ATTR_UDP", "ovs_key_udp"),    # 10
+        ("OVS_KEY_ATTR_ICMP", "ovs_key_icmp"),  # 11
+        ("OVS_KEY_ATTR_ICMPV6", "ovs_key_icmpv6"),  # 12
+        ("OVS_KEY_ATTR_ARP", "ovs_key_arp"),    # 13
+        ("OVS_KEY_ATTR_ND", "ovs_key_nd"),      # 14
+        ("OVS_KEY_ATTR_SKB_MARK", "none"),      # 15 — metadata, not in ENCAP
+        ("OVS_KEY_ATTR_TUNNEL", "none"),        # 16 — tunnel metadata, not in ENCAP
+        ("OVS_KEY_ATTR_SCTP", "ovs_key_sctp"),  # 17
+        ("OVS_KEY_ATTR_TCP_FLAGS", "be16"),     # 18
+        ("OVS_KEY_ATTR_DP_HASH", "none"),       # 19 — metadata, not in ENCAP
+        ("OVS_KEY_ATTR_RECIRC_ID", "none"),     # 20 — metadata, not in ENCAP
+        ("OVS_KEY_ATTR_MPLS", "array(ovs_key_mpls)"),  # 21
+    )
+
+
 class OvsPacket(GenericNetlinkSocket):
     OVS_PACKET_CMD_MISS = 1  # Flow table miss
     OVS_PACKET_CMD_ACTION = 2  # USERSPACE action
@@ -2576,6 +2826,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
 
 
 def main(argv):
+    nlmsg_atoms.encap_ovskey = encap_ovskey
     nlmsg_atoms.ovskey = ovskey
     nlmsg_atoms.ovsactions = ovsactions
 
-- 
2.53.0


