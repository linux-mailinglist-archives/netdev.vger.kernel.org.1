Return-Path: <netdev+bounces-283821-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Ox7AiWT+Gl8wgIAu9opvQ
	(envelope-from <netdev+bounces-283821-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:37:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A20814BCFA2
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:37:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A523B30221E2
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:37:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 704B43D3483;
	Mon,  4 May 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lzonI8K1"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D519E3D3308
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:37:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898251; cv=none; b=LvcriPkcYqQ7J4LEeK0hoojV2iTkmpu3i1+kvTokLhqP7ePjtNUoEIpeHsoo+H7Ogyq7EHkXnoIS/HfJbQE4rOzx5M8xaoMJdJKNEo2bhfA+bbxC5XEm+svSo25yhX/8rZlGMtAKDN2vIbxmp8X/Nkzx3ceggjIIA4L8mzJZCNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898251; c=relaxed/simple;
	bh=XO9FBl1PcJXzOHCzO3GVxidUoMn/0+IUe1iVTaJvf4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YjZPyHD57kP6K0vWFXQYWm2wYa1R1dCEwTmmjDtcpbIK5vHavlU1aG7tHENw8z/xc1rUmM+U01hOit3nFNxrjBxsFObaffk6/1jfDGGvqAeOmIUDuVz5XEB7sGtrWn4etvxmWmI5mGC61LpJKwSrYdUanCwCzwv4/vZkeJaB60I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lzonI8K1; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-364eef1891dso1831387a91.1
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 05:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898248; x=1778503048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=agutMrElMg2MPsolLH1NdtyiOQw7eL1Pi15Oozv4tTY=;
        b=lzonI8K1vxSyek/hWofq27wyjamAtw4oaUolZ6LvBWuBc2dQ69ne3tApwvCcKptqja
         W5qePTH/L1BsukCS1XbNGzZxnzmgV/yrHjN8tiuINar79f3ru3Ti+oGHCHSjzFshN3xD
         lE9NVp6cHy3GW1nS/x5pqJg5SIAeUK3e+ofgMi/0FoASqY1siiIKDcOcLJYCT+2swnqo
         +5XTBXfvCb3N+WKhOVEYWlh6g1VZk03nVuPH0siKLRBYKeMqGy6HEgzRfm49s+mEstPn
         VFGZorodeIHm2fw65ZJ+ZNBFhxiRWdLOpHONTRn0GzSODGNtt3a0K30I/SVLNHUGz/+g
         /btA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898248; x=1778503048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=agutMrElMg2MPsolLH1NdtyiOQw7eL1Pi15Oozv4tTY=;
        b=QeySA5nNz7AcsskfRW8xQnkLaLsGANTa5NMu/ZPqLk6tq9/6R6YBLIkmFVPsHFQiqJ
         iRSgWtyju6rXhyquqSLWzCVkafNELZfexlpnLLZW2HwvrQAoKxSY18mIbnfHpHSY6Vji
         lvTYUiWJPkgC/86+NZ1+Xx0fjaDotnm/lUIxAYuD1QqQqy7aGSsh8dZag9oFTPECWrR9
         j6KDuKDhARYxvC0+qYgwDyn5auXxKSwZ2W6vaVLUzN3mwilqzkpunAFqDK9c9XmOD/Ei
         ilZOWZaXikSksT+bHGdi8EFCamsA3qtvkdBpg3A/eGIcwGsStCAp9i/BfDFfyUIFbYxT
         18CA==
X-Gm-Message-State: AOJu0Yy9ZCajnjo6NTwyt1vdrFjk8G7N05sXAjfq1fYY098Vh39WJMBq
	+Urb6PQuj2bT+6YqiWVXFcfQuEkk05+R3GT7YaEbEDiCJgV2PLR2GW8Mwzu6WMVt1YU=
X-Gm-Gg: AeBDievkaJq12qLxXZj8qTVMOH5Hl9G9WiaTm1uT6N2Cgw9sQ0vfpZ9tSz+4ctRjTg1
	JLqqhfLctBgPoyw1faG9qIGjfHoCYIXwVzXzcEaERV4ZgPiWxgz+kwYYc5RibU85otTPo120J13
	/yCjOINLl6m/t3ozseyyrH+262S76HWRrf2yM8WWgew1U9PDFGUPjyKVYd48bgMsZFy3DQZhcbm
	dVnnw3ihQJBvslGwUP8X3k6nzrgIsY3FjTGrnua6NEAM46ZdaydvMo9F8qi/SPOAj7la8vd21hB
	2V3jLeXu76JBUM2TiVxOtc9KroMgGqhEA5i3RA8UK3QjSRcuILAxl5KSbwsujvQgGepZsnDkomf
	rI/zeRic8RkACMR5mtTl/c2xsVnrtlLfXiLj+7f5Lwj017yhF3die8a31j99d7KB6L05ThpDatg
	a+dkvndM+PxJU8jz/7GSBEltEi/lpoEn8IoG5xFQ==
X-Received: by 2002:a17:90a:c10e:b0:364:7a37:4066 with SMTP id 98e67ed59e1d1-3650cdff554mr9079106a91.14.1777898247586;
        Mon, 04 May 2026 05:37:27 -0700 (PDT)
Received: from houminxi ([151.242.165.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f4558e0dsm5883550a91.2.2026.05.04.05.37.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:37:26 -0700 (PDT)
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
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 1/2] selftests: openvswitch: add vlan() and encap() flow string parsing
Date: Mon,  4 May 2026 20:37:12 +0800
Message-ID: <20260504123713.555461-2-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504123713.555461-1-houminxi@gmail.com>
References: <20260504123713.555461-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A20814BCFA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283821-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
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
 .../selftests/net/openvswitch/ovs-dpctl.py    | 268 +++++++++++++++++-
 1 file changed, 260 insertions(+), 8 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 848f61fdcee0..285a325fe4d3 100644
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
@@ -1636,6 +1636,205 @@ class ovskey(nla):
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
@@ -1657,6 +1856,16 @@ class ovskey(nla):
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
@@ -1794,6 +2003,9 @@ class ovskey(nla):
                 True,
             ),
             ("OVS_KEY_ATTR_ETHERNET", None, None, False, False),
+            ("OVS_KEY_ATTR_VLAN", "vlan", ovskey._vlan_dpstr,
+                lambda x: False, True),
+            ("OVS_KEY_ATTR_ENCAP", None, None, False, False),
             (
                 "OVS_KEY_ATTR_ETHERTYPE",
                 "eth_type",
@@ -1821,22 +2033,61 @@ class ovskey(nla):
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
@@ -2576,6 +2827,7 @@ def print_ovsdp_full(dp_lookup_rep, ifindex, ndb=NDB(), vpl=OvsVport()):
 
 
 def main(argv):
+    nlmsg_atoms.encap_ovskey = encap_ovskey
     nlmsg_atoms.ovskey = ovskey
     nlmsg_atoms.ovsactions = ovsactions
 
-- 
2.53.0


