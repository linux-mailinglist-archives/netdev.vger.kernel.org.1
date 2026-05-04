Return-Path: <netdev+bounces-284014-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ADadDmHr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284014-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:54:25 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F644C2CC9
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:54:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34E22302158C
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:53:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC3073E6DF5;
	Mon,  4 May 2026 18:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="IqFk7Jto"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f47.google.com (mail-dl1-f47.google.com [74.125.82.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EE633E6383
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920789; cv=none; b=E9XsL56kZinPifLJAaI+k44sN/4Y4AobHEI7pHNfZ+yLAde6xeJLDOJIfD/cFHD4eU28ycDtRnGA8aVa5+3cCtSrWKb0z95mIsxcWRCC3qyDy8xpbPsr52WATtEf7T6B5BvF5m+PNtRaFi1rqs4PxlvrHaKiAKjBWInUA8FNImA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920789; c=relaxed/simple;
	bh=rAZ4O12mQMt/V2JxpVYuANQjlNTYeWa/pk7rs4oLiok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eBl+5msBXDSKFxTksPov4PI+KUx0fIfTOxrFW/+OOp/V7bWtLDTeK1Y3lewUQij2JLs0eXKSFUbn1iw3KXkfMZtJH/7CMTRA9mlnlFcwQSaeUtWyo808E0nEYDwwzH+wD85E4RlV1D0gMUkWibgrIlumW0BugK4k89GA1t2eH5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=IqFk7Jto; arc=none smtp.client-ip=74.125.82.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f47.google.com with SMTP id a92af1059eb24-12ddbe104ccso4528908c88.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920787; x=1778525587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JbaCNAkrvT0+fBSMiERTy4cCfhMqy13VCtnukl+0EeI=;
        b=IqFk7JtoW41yfJFe2N89BpENuIoC3gmBKXmXYOmlyKemK84GssKDNMfU+CfqDOtjQK
         D71KphACGwxt7suuEGhh0TpvYtTLHRdvkH7v+GiIUkIWdenGbwh5suXYnhuyIWXgsmF0
         3085/t3ubShoj+f+kY1nUSNkWz6+UQSUOtb+ZgkiT9xOYVJ99Fm0fk6ycAB77e0lHuLs
         iaXUKZlUok8zY7W+TmWXg2xVBh09D1VfAkkXkX87EZYh4pldz2dxEgrSBWLfzkh3rnnY
         WtoChNz0fRmJ/ollwB/BHqSFVgNJscVSZXhUgB6RndwOmjXWW8QSm6tl6L6nlBhy9y+R
         InPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920787; x=1778525587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JbaCNAkrvT0+fBSMiERTy4cCfhMqy13VCtnukl+0EeI=;
        b=ID9JvNtJq3MThMdZH4mluTpggRnhRJiv/kcX9GPn438FFlTjMpsAgXHOtU/PgCXrbx
         kcrG1zLhAa2ufBNbXQ+moWcYH4vHYXWmKkLRZY0px3EQZAUlglUiOvmlxOJYyJLQ1Yku
         dMPQOmNYuAyJoollWYpiAW9cXo/X9K0JZ9FWblDU1iYYNDVGYUOMCgtoKh6CiM91IaW7
         8X1Mazky2D5EavWuhN+fRMSXoN1muCUXn0lzotIPXBJLZRB2LSuN4kEjt2jHvw+TR0cF
         VdOUE/1+rDt+wALd4ZjNgA6cwFEQftw1kEtv6k+uQoAEKhxVQeZNl4J9c6Hmaz4GS4pr
         khww==
X-Forwarded-Encrypted: i=1; AFNElJ+LzPncwPtypBPbfwi7AmTYG1cRj+nm0RB8giwUSaoS0T76KjZIJPM1RH9zPBoOmQwMgijm1y0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxpuYPJqNrDojSpVWC7kfYXcxBS3zUGhS9a8fBPYhfihuJIyekL
	Dt0gNn5iXyNNKruX1wAqz98thRFMW5cd3sdXAGPNvNTBuJjEVMwjXlilGSee7XPVcA==
X-Gm-Gg: AeBDietlA0irifx4havqt7g6ca03m47MeFngsAt90rasZ1k+QCy41Fq9xCcp83db28h
	RLBkOK/AP4LWjbCIJAtoiirvs4D55AqtCzgXfMSH5afQaWCih6n1IrVCWyNEdGLf3HLYeYU6p0K
	duANvlZ2KaRRe6LFtK1Stf//+v1pGRNF40LZi4OIinswco7xBVFy2PfgA0gqtQP9EZWj6s+ociI
	5r4RYWYbOiLa1c5OhgwZUqX9Zevqm9Z0R95moXL8YEr/LNVuiciVx1vR8c1BxA9iHCHqIfLsitI
	ExOrr3He3GT3D+v4XXsb2poilBtnfXS6GX6Ke5sSfAsLAlPKWX5CTW6OCBPGKJf/fR8A/SY8btm
	Cw6a464eJoN5nbGPwrPM22okPtA1WnQGDB668ALdgy2UGi1ZX3qGJ+nORuuj9/EqjcHh6c6nTT+
	9YL4Zh5OpWnvh/JAHHy1GTNArAMzLmn4/Bt47eVVyKz1178FZPJXgN0DrarMqIYGUP4mH0eSlMz
	ibP9hS3pYo=
X-Received: by 2002:a05:7022:ea2f:b0:128:c77a:6c8e with SMTP id a92af1059eb24-130b1c6f540mr53920c88.28.1777920787011;
        Mon, 04 May 2026 11:53:07 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:53:06 -0700 (PDT)
From: Tom Herbert <tom@herbertland.com>
X-Google-Original-From: Tom Herbert <tom@xdpnet.ai>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com,
	pabeni@redhat.com,
	horms@kernel.org
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v10 09/10] test: Add ext_hdr.py in networking selftests
Date: Mon,  4 May 2026 11:51:21 -0700
Message-ID: <20260504185122.50642-10-tom@xdpnet.ai>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504185122.50642-1-tom@xdpnet.ai>
References: <20260504185122.50642-1-tom@xdpnet.ai>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A2F644C2CC9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284014-lists,netdev=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[herbertland.com:+];
	TAGGED_RCPT(0.00)[netdev];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:dkim,herbertland.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,xdpnet.ai:mid,shlex.split:url]

From: Tom Herbert <tom@herbertland.com>

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
 tools/testing/selftests/net/Makefile   |   1 +
 tools/testing/selftests/net/ext_hdr.py | 385 +++++++++++++++++++++++++
 2 files changed, 386 insertions(+)
 create mode 100755 tools/testing/selftests/net/ext_hdr.py

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 21897ee81916..d0f98081d702 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -26,6 +26,7 @@ TEST_PROGS := \
 	cmsg_time.sh \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
+	ext_hdr.py \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
 	fcnal-other.sh \
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


