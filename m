Return-Path: <netdev+bounces-267794-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KKBAH9KetWms2gAAu9opvQ
	(envelope-from <netdev+bounces-267794-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:54 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F3DC28E2FA
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 18:45:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1D883300F7AB
	for <lists+netdev@lfdr.de>; Sat, 14 Mar 2026 17:44:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 407342F25F4;
	Sat, 14 Mar 2026 17:44:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="PehLrKkW"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f45.google.com (mail-dl1-f45.google.com [74.125.82.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98A00313E03
	for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 17:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773510272; cv=none; b=NcLpR/8RAVDz0+0ykLdbaB71DPniUff9sDXjVezIXkRvpu1JffV8nV9F1pnHL5/XgGihQTp+DWxQ0yxmCyQRHbPVXcBx7uSNXbBFG/jWNWIvIgJRNKEbRKPFO5tY//NIJkE7DJO/bpISJICnexp/hOCpiAXKLjBfBFH6fgFn8Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773510272; c=relaxed/simple;
	bh=DWv1MOmxt890lcf/UuiZ0uUKpHOoZ8FWIJ2hagH4kQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F5YGhNNyTUBJqE0NGae+hTftCyXxEjgzmgTc7Ds4xdHOWoPazs1Bt8O+D9KNrOu+/5yemnJpxqeNungsOhuHAuTQjB/golfCnLTahE703FRmy3z5KjpRH7oJp8Bl7q4qSVYgNcBxFl+hwAgJCeRhabI+G8aqNvlXIsKk4bg8MJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=PehLrKkW; arc=none smtp.client-ip=74.125.82.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f45.google.com with SMTP id a92af1059eb24-126ea4e9694so1506128c88.1
        for <netdev@vger.kernel.org>; Sat, 14 Mar 2026 10:44:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1773510270; x=1774115070; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j9Wt3fDKSccSjzjybUCK3RbN9BdTwO7O1SPfjvfxGcU=;
        b=PehLrKkWsN7Hnf7P1qm3X7RRdXGRttRxAvpXR7Y7nlvgBSyQ4605y6VJIXNtHx4FOj
         cN97rZGb9Qgk+qhcT57s4hPgW+IH093XIbu7aVuBUGUbley6dfNSOnnJ6ZunsqBfjbyv
         T+LosbJQpACeuO83Hb9M61TppFPhlkZQkNtrmOARTsI7r1xR1sU/6T+wJbCYqHGk12zM
         zQpGuHDtySqWU+kfj8t48Ssbd+MpVMtBwkFNsNGgMLDJ8lEGdl0GEUrN2lE17ibumUIf
         Z/CJP3Q808Rb4M++KAUOlWAJZDY1q9TOh/d0mon8Jw4+mnTo/iDGJhHOILgS9zPwfqq3
         4vNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773510270; x=1774115070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=j9Wt3fDKSccSjzjybUCK3RbN9BdTwO7O1SPfjvfxGcU=;
        b=pqJ3lKuA0Ou6ALNMyw2jQ76K1YYS3I1lbN9a3Bzn0THi53dprHFZMdz6j+6H5MQMUc
         UwRGaZOrJ6Pp8KKOtqLGm4+//ore1jjOnBHBJYHTq4Tnpv5Onz8UW+FAodFM7p0m3UnV
         B/PuvMO68oAIP5u4xLKsJJMQ7OEqjiFPGoay6+WjFFT9Uzfg28Vkcw52/XCM3YDjlzWe
         1MG1zr4bFUiRXZeK9rI+3x+oOab8Hq0C2oAJIsIIfsuDQN9NUARQ3/3eQyoMuIFxhyCL
         Yzz1p8XlO2YuYDgIX1dkZL48nakpze2CqFtm3Oy3Sni+10taSjxSJLnqddI7tvnuBrBZ
         3MPw==
X-Forwarded-Encrypted: i=1; AJvYcCUgC3IrrwIn5QB/kPgbf6hYzQC04Owh0h81uqgaCp0YT7ZtCkktR72DWRyBvhVRhq/ORfpZt60=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2kFV7VzNSfgyWQuBv3WdcsmW2dAsYieGqXKO+anCOaFy2dcKt
	oo2jW8MzcHC00hxts6KT+VKGc0W0GcRfQ8dKVCZPoWmeseKPPCZhqgcY9TYK8ba9OQ==
X-Gm-Gg: ATEYQzw+AF3V/HzXz9q7iuwVjMTZTc4ultazAEKlAFhG60dhvPLx5pbCt3+19vY9bFp
	e4gahFiB0jkYwhHqSgZPftDN7cfKSDT7+Of4JlOYJCMKqQma0xW9uigLlaf3vdhWDPb7v0h3CIB
	YGkDYUmLnwYdtmaJBdyG5aQnhDrnq5wjJjE8SOOtZquzew4pmZjKzzyOGFPR1iyou2zilMgON/V
	IRTagOfSZxPZ/fv1xtm/oCJsxG30A4mxuC5JkHmzxKyvC0X0RvfO2d3w1vOxmfEES4Veo0QtXr5
	7RqAwY2BX5GX6032eABY2ZG+bEWvv1Jbfcjix2IYJNd8/D2vn1KdV1fvAV7yntZJLEU2wSMkx0p
	T3tzjRYUa1Ce76ZUGpoZ00IqnYqXC23VpJGqZhrWLTAzigXS1mc3xioDVnRcXGeA3bADd9JUYZR
	ACnwvhpdIKTGfcjCid4BKImwcnDIPeEa3Y3q2eI3ZcLkukXkE4/oSoWgXuiwe72c6ZRzTCMg==
X-Received: by 2002:a05:7022:e25:b0:121:a01a:8e2f with SMTP id a92af1059eb24-128f3e471camr3354025c88.42.1773510269489;
        Sat, 14 Mar 2026 10:44:29 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:eb38:94c4:209f:a764])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-128f62837ccsm8326734c88.3.2026.03.14.10.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 14 Mar 2026 10:44:29 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [net-next v8 09/10] test: Add ext_hdr.py in networking selftests
Date: Sat, 14 Mar 2026 10:43:32 -0700
Message-ID: <20260314174333.46406-10-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260314174333.46406-1-tom@herbertland.com>
References: <20260314174333.46406-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	TAGGED_FROM(0.00)[bounces-267794-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,herbertland.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,shlex.split:url]
X-Rspamd-Queue-Id: 7F3DC28E2FA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add ext_hdr.py that contains various Extension Header format definitions
and related helper functions.

This includes the Make_EH_Chain function that creates an Extension
Header chain based on an input list. The input list has the format:

   [(<type>, <args>), (<type>, <args>), ... (<type>, <args>)]

where <type> is "H" for Hop-by-Hop Options, "D" for Destination
Options, "R" for Routing Header, "F" for Fragment header, "A" for
Authentication Header, and "E" for ESP header.

<args> is specific to the type of extension header. For Hop-by-Hop
and Destination Options <args> is a list of options in the format:

   [(<opt_type>, <opt_length>), (<opt_type>, <opt_length>), ...
					(<opt_type>, <opt_length>)]

For the Routing Header, <args> is a list of SIDs in the format:

    [IPv6_address, IPv6_address, ... IPv6_address]

For the Fragment Header, <args> is the identifier number

Authentication and ESP are not currently supported by Make_EH_Chain

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 tools/testing/selftests/net/ext_hdr.py | 385 +++++++++++++++++++++++++
 1 file changed, 385 insertions(+)
 create mode 100755 tools/testing/selftests/net/ext_hdr.py

diff --git a/tools/testing/selftests/net/ext_hdr.py b/tools/testing/selftests/net/ext_hdr.py
new file mode 100755
index 000000000000..bfb7da4a7c88
--- /dev/null
+++ b/tools/testing/selftests/net/ext_hdr.py
@@ -0,0 +1,385 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Helper functions for creating extension headers using scapy
+
+import ctypes
+import shlex
+import socket
+import sys
+import subprocess
+import scapy
+import proto_nums
+
+
+# Read a sysctl
+def sysctl_read(name):
+    try:
+        # shlex.split helps handle arguments correctly
+        command = shlex.split(f"sysctl -n {name}")
+        # Use check=True to raise an exception if the command fails
+        result = subprocess.run(command, check=True,
+                    capture_output=True, text=True)
+        value = result.stdout.strip()
+    except subprocess.CalledProcessError as ex:
+        print(f"Error reading sysctl: {ex.stderr}")
+    except FileNotFoundError:
+        print("The 'sysctl' command was not found. "
+              "Check your system's PATH.")
+
+    return int(value)
+
+# Common definitions for Destination and Hop-by-Hop options
+
+# Common Destination and Hop-by-Hop Options header
+class HbhDstOptions(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("next_hdr", ctypes.c_uint8),
+        ("hdr_ext_len", ctypes.c_uint8)
+    ]
+
+    def __init__(self, next_hdr, length):
+        self.next_hdr = next_hdr
+        self.hdr_ext_len = length
+
+# Common single Destination and Hop-by-Hop Option header
+class HbhDstOption(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("opt_type", ctypes.c_uint8),
+        ("opt_data_len", ctypes.c_uint8),
+    ]
+
+    def __init__(self, opt_type, length):
+        self.opt_type = opt_type
+        self.opt_data_len = length
+
+# Make PAD1 option
+def make_hbh_dst_option_pad1():
+    opt_bytes = bytearray(1)
+    opt_bytes[0] = proto_nums.HBHDst_Types.HBHDST_TYPE_PAD1.value
+    return (scapy.all.Raw(opt_bytes), 1)
+
+# Make a full DestOpt or HBH Option with some length
+def make_hbh_dst_option_with_data(opt_type, opt_len):
+    hdr = scapy.all.Raw(load=HbhDstOption(opt_type, opt_len))
+    opt_bytes = scapy.all.Raw(bytearray(opt_len))
+    allhdr = hdr/opt_bytes
+    return (scapy.all.Raw(allhdr), 2 + opt_len)
+
+# Make PADN option
+def make_hbh_dst_option_pad_n(opt_len):
+    return make_hbh_dst_option_with_data(
+            proto_nums.HBHDst_Types.HBHDST_TYPE_PADN.value, opt_len)
+
+# Make a Destination or Hop-by-Hop Options list. Input is list of pairs as
+# (type, length). Option data is set to zeroes.
+#
+# Return value is (hdr, len, outcome) where hdr is the raw bytes and length
+# is the length of the header including two bytes for the common extension
+# header (the returned header does not include the two byte common header).
+# outcome is True or False depending on whether the options are expected to
+# exceed a sysctl limit and would be dropped
+def make_hbh_dst_options_list(opt_list, max_cnt, max_len):
+    hdr = scapy.all.Raw()
+    eh_len = 0
+
+    num_non_padding_opts = 0
+    max_consect_pad_len = 0
+
+    consect_padlen = 0
+
+    # Create the set of options
+    for opt_type, jlen in opt_list:
+        if opt_type == proto_nums.HBHDst_Types.HBHDST_TYPE_PAD1.value:
+            # PAD1 is a special case
+            pair = make_hbh_dst_option_pad1()
+            consect_padlen += pair[1]
+        else:
+            pair = make_hbh_dst_option_with_data(opt_type, jlen)
+
+            if opt_type == proto_nums.HBHDst_Types.HBHDST_TYPE_PADN.value:
+                consect_padlen += pair[1]
+            else:
+                if consect_padlen > max_consect_pad_len:
+                    max_consect_pad_len = consect_padlen
+                consect_padlen = 0
+                num_non_padding_opts += 1
+
+        # Append the option, add to cumulative length
+        hdr = hdr/pair[0]
+        eh_len += pair[1]
+
+    # Add two to length to account for two byte extension header
+    eh_len += 2
+
+    if eh_len % 8 != 0:
+        # The extension header length must be a multiple of eight bytes.
+        # If we're short add a padding option
+        plen = 8 - (eh_len % 8)
+        if plen == 1:
+            pair = make_hbh_dst_option_pad1()
+        else:
+            pair = make_hbh_dst_option_pad_n(plen - 2)
+
+        consect_padlen += pair[1]
+        hdr = hdr/pair[0]
+        eh_len += plen
+
+    if consect_padlen > max_consect_pad_len:
+        max_consect_pad_len = consect_padlen
+
+    outcome = True
+    if num_non_padding_opts > max_cnt:
+        # The number of options we created is greater then the sysctl
+        # limit, so we expect the packet to be dropped
+        outcome = False
+    if eh_len > max_len:
+        # The length of the extension is greater then the sysctl limit,
+        # so we expect the packet to be dropped
+        outcome = False
+    if max_consect_pad_len > 7:
+        # The maximum consecutive number of bytes of padding is
+        # greater than seven, so we expect the packet to be dropped
+        outcome = False
+
+    return (hdr, eh_len - 2, outcome)
+
+# Make a full Hop-by-Hop or Destination Options header
+def make_full_hbh_dst_options_list(next_hdr, opt_list, max_cnt, max_len):
+    pair = make_hbh_dst_options_list(opt_list, max_cnt, max_len)
+    opt_len = pair[1] + 2
+
+    opts = HbhDstOptions(next_hdr, (opt_len - 1) // 8)
+    hdr = scapy.all.Raw(load=opts)/pair[0]
+
+    return (hdr, opt_len, pair[2])
+
+# Routing header definitions
+
+# Base Routing Header
+class RoutingHdr(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("next_hdr", ctypes.c_uint8),
+        ("hdr_ext_len", ctypes.c_uint8),
+        ("routing_type", ctypes.c_uint8),
+        ("segments_left", ctypes.c_uint8)
+    ]
+
+# SRv6 Routing Header
+class Srv6RoutingHdr(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("rh", RoutingHdr),
+        ("last_entry", ctypes.c_uint8),
+        ("flags", ctypes.c_uint8),
+        ("tags", ctypes.c_uint16),
+        # Variable list
+        # TLV options
+   ]
+
+    def __init__(self, next_hdr, hdr_ext_len, segments_left, last_entry):
+        self.rh.next_hdr = next_hdr
+        self.rh.hdr_ext_len = hdr_ext_len
+        self.rh.routing_type = proto_nums.RoutingTypes.ROUTING_TYPE_SRH.value
+        self.rh.segments_left = segments_left
+
+        self.last_entry = last_entry
+
+# Make an SRv6 Routing Header (with no segments left)
+def make_srv6_routing_hdr(next_hdr, sids):
+
+    bhdr = scapy.all.Raw()
+    num_sids = 0
+
+    # Set up each SID in the list
+    for sid in sids:
+        sid_bytes = socket.inet_pton(socket.AF_INET6, sid)
+        bhdr = bhdr/scapy.all.Raw(load=sid_bytes)
+        num_sids += 1
+
+    eh_len = num_sids * 16
+
+    hdr = Srv6RoutingHdr(next_hdr, eh_len // 8, 0, num_sids - 1)
+
+    bhdr = scapy.all.Raw(load=hdr)/bhdr
+
+    return (bhdr, eh_len + 8, True)
+
+# Fragment header
+
+# Basic Fragment Header
+class FragmentHdr(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("next_hdr", ctypes.c_uint8),
+        ("rsvd", ctypes.c_uint8),
+        ("fragment_offset", ctypes.c_uint16, 13),
+        ("rsvd2", ctypes.c_uint16, 2),
+        ("more", ctypes.c_uint16, 1),
+        ("identfication", ctypes.c_uint32),
+    ]
+
+    def __init__(self, next_hdr, fragment_offset, more, ident):
+        self.next_hdr = next_hdr
+        self.fragment_offset = fragment_offset
+        self.more = more
+        self.identfication = ident
+
+# Make a raw fragment header
+def make_fragment_hdr(next_hdr, fragment_offset, more, ident):
+    hdr = FragmentHdr(next_hdr, fragment_offset, more, ident)
+
+    return (scapy.all.Raw(load=hdr), 8, True)
+
+# Authentication Header
+
+# Base Authentication Header
+class AuthHdr(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("next_hdr", ctypes.c_uint8),
+                ("payload_len", ctypes.c_uint8),
+        ("spi", ctypes.c_uint32)
+        # ICV is variable length
+    ]
+
+    def __init__(self, next_hdr, payload_len, spi):
+        self.next_hdr = next_hdr
+        self.payload_len = payload_len
+        self.spi = spi
+
+# ESP
+
+# Base ESP header
+class EspHdr(ctypes.BigEndianStructure):
+    _pack_ = 1
+    _fields_ = [
+        ("spi", ctypes.c_uint32),
+        ("seqno", ctypes.c_uint32)
+        # Payload data + padding
+        # ICV is variable length
+    ]
+
+    def __init__(self, spi, seqno):
+        self.spi = spi
+        self.seqno = seqno
+
+# Check if EH list is out of order
+def check_eh_order(eh_list):
+    # OOO is okay if sysctl is not enforcing in order
+    do_check = sysctl_read("net.ipv6.enforce_ext_hdr_order")
+
+    seen = 0
+    for eh_type, _args in eh_list:
+        if eh_type == "H":
+            order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_HOP.value
+        elif eh_type == "D":
+            if (seen &
+                proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_ROUTING.value):
+                order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_DEST.value
+            else:
+                order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH.value
+        elif eh_type == "R":
+            order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_ROUTING.value
+        elif eh_type == "F":
+            order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_FRAGMENT.value
+            if seen & order != 0:
+                # Linux stack doesn't allow more than one
+                # Fragment Header in a packet
+                return False
+        elif eh_type == "A":
+            order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_AUTH.value
+        elif eh_type == "E":
+            order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_ESP.value
+
+        if (do_check and seen >= order):
+            return False
+        seen |= order
+
+    return True
+
+# Compute the next headers for an EH chain. Returns a new list of EHs
+# with the next header attached to each element
+def compute_next_hdrs(next_hdr, eh_list):
+    nlist = []
+
+    # Run through the list in reverse and set the next header up for each
+    # enty
+    for eh_type, args in reversed(eh_list):
+        entry = (eh_type, args, next_hdr)
+        nlist.insert(0, entry)
+        if eh_type == "H":
+            next_hdr = proto_nums.IP_Proto.IP_PROTO_HOPOPT.value
+        elif eh_type == "D":
+            next_hdr = proto_nums.IP_Proto.IP_PROTO_IPv6_Opts.value
+        elif eh_type == "R":
+            next_hdr = proto_nums.IP_Proto.IP_PROTO_IPv6_Route.value
+        elif eh_type == "F":
+            next_hdr = proto_nums.IP_Proto.IP_PROTO_IPv6_Frag.value
+        elif eh_type == "A":
+            next_hdr = proto_nums.IP_Proto.IP_PROTO_AH.value
+        elif eh_type == "E":
+            next_hdr = proto_nums.IP_Proto.IP_PROTO_ESP.value
+
+    return nlist, next_hdr
+
+# Make an extension header chain from a list
+# The list contains a set of pairs in the form (<eh_type>, <args>)
+# <eh_type> is:
+#   "H"-- Hop-by-Hop Options
+#   "D"-- Destination Options
+#   "R"-- Routing Header
+#   "F"-- Fragment Header
+#   "A"-- Authentication Header
+#   "E"-- ESP
+#
+# <args> is specific to EH type
+def make_eh_chain(next_hdr, eh_list):
+    nlist = []
+
+    # Run through the list in reverse and set the next header up for each
+    # enty
+    nlist, next_hdr = compute_next_hdrs(next_hdr, eh_list)
+
+    outcome = check_eh_order(eh_list)
+
+    hdr = scapy.all.Raw()
+    eh_len = 0
+
+    for eh_type, args, nnext_hdr in reversed(nlist):
+        if eh_type == "H":
+            # args is a list of (<opt_type>, <opt_len>) pairs
+            pair = make_full_hbh_dst_options_list(nnext_hdr, args,
+                sysctl_read("net.ipv6.max_hbh_opts_number"),
+                sysctl_read("net.ipv6.max_hbh_length"))
+        elif eh_type == "D":
+            # args is a list of (<opt_type>, <opt_len>) pairs
+            pair = make_full_hbh_dst_options_list(nnext_hdr, args,
+                sysctl_read("net.ipv6.max_dst_opts_number"),
+                sysctl_read("net.ipv6.max_dst_opts_length"))
+        elif eh_type == "R":
+            # args is a list of IPv6 address string
+            pair = make_srv6_routing_hdr(nnext_hdr, args)
+        elif eh_type == "F":
+            # Arg is (<identifier>)
+            pair = make_fragment_hdr(nnext_hdr, 0, False, args)
+        elif eh_type == "A":
+            print("Auth type not supported for test")
+            sys.exit(1)
+        elif eh_type == "E":
+            print("ESP type not supported for test")
+            sys.exit(1)
+        else:
+            print("Unknown EH type character")
+            sys.exit(1)
+
+        hdr = pair[0]/hdr
+        eh_len += pair[1]
+
+        if pair[2] is False:
+            outcome = False
+
+    return (hdr, eh_len, next_hdr, outcome)
-- 
2.43.0


