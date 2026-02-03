Return-Path: <netdev+bounces-256051-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Fh7BvhGgWnNFAMAu9opvQ
	(envelope-from <netdev+bounces-256051-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:53:12 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F7C6D327B
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:53:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8593A3060BD9
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63750214812;
	Tue,  3 Feb 2026 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="DN7/p0hr"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dl1-f43.google.com (mail-dl1-f43.google.com [74.125.82.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E2D621770A
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079777; cv=none; b=lHGxA9KJ/zr3I6ZUENGij8ANDQuGGMYrtB6+IeW7Z8qTcZKJUA+l3dGL1ne8NQKNAWnnGvTYAkYo3KYdc/KxIPhkoK+4uViNGwVLwEd5utLBkdQR9JYoYhXsT6vvY6hdJJvOmDxvD87kRijM6MdWt7EKdlnoNO+Wx8i6thLfHNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079777; c=relaxed/simple;
	bh=PoCOl4nYfSo+HtZKtoirhyekgCROZpgS9Vuh3hTFu3g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jTBT9DdavYS6Qs1FUy74+JYUVx6JX268X7uGl5cQj+xPp52MXx4lN/zwIQTeTaiD69uLFSm5WHxr9NEDrItXcMbvF1aEkvMmCUG3/4AFoD1JR+UG3vBwO4LNCCv6Jrzyy5ceOCWYbHFuAM8CbIs9DEKWL/ltSGDeVDaMLkPb7L8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=DN7/p0hr; arc=none smtp.client-ip=74.125.82.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dl1-f43.google.com with SMTP id a92af1059eb24-1248d27f293so931575c88.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079775; x=1770684575; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XdWK1lXi2/8U+ODrJcq1ZHPxz8MpW4pBb4PAg3cBaRQ=;
        b=DN7/p0hrMxgBRuxyAHSQAcMhnZZRKnVIJMxSvlbosIJ0nujtJG/ILUFPUNQtMNfgTX
         UkJ32VOYuQ0cXcyvrYgKWt9HptvKMLEOa5Ijzp5RWWS7Jz2cAkkWIHNC8qdDFT2J2Aib
         O3wU7sbmn4GSPWZOabgTpCdqVB5t7PEhFnrUIksZelVI35W8SPP1jCdjxzGtxXouhNSx
         iUYtAmLw3AuBdURR2xE4uAn/429uz3J8kuAHiP7/KRP0lGVI65YHX6S4DOjAigSew9gn
         OTJ/AQsx0kkkCEv/mP9Wd0kk00PYOyyrjeyrxD3qh//H+XU1uyMotPlrT4ZG6EO2pGFI
         H4Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079775; x=1770684575;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=XdWK1lXi2/8U+ODrJcq1ZHPxz8MpW4pBb4PAg3cBaRQ=;
        b=VuHRZC72nM5qVNzL2j3tOt9Wdz5vsnvjWfhCM9O3uDMJRlvBzEAtcKrs5qilbGu0lM
         uJTK/nJctmX7FdoWNBG8clh/rdb8gsByCNjPg9msDPP1D8HgwnFhMSxe+LbZnXLb6cq1
         l/VF9cMFoCR2VcFH3XlRwBsocXzY8e8iV0Sm1KOYFoM7IBhfPC0Ek+OXsG1czBAhfbCM
         0MWslWT3nAhBfk1wtPnWkn/prmmEy/R0Hii49aaWYy8X6DV1zCNwcOG46a2g0lHxS7GK
         0REWvihwKdpB5LMR+fHqmpsTgklavmfdeNuTp5QGsRqdMDs4hzkzx7kUQUKgqIPtT3a5
         u1bw==
X-Forwarded-Encrypted: i=1; AJvYcCUxS4/SgLMN+VlIzKay3emSmbd3EfkHT0sSBFONHY+PeoXm1Aa5bGQEVHMkbSLt1hdw/9fU/HY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxBDOTEZj49GryKxO4Hewn75UdLL7YnoJVlqk9TzUDLI2UPqE++
	vkYDwSErqAy1qZME5/zMHEpmjzNPx6vuvBqLWFM2fspGAp9J/XgEcIsehLK8ErPU8g==
X-Gm-Gg: AZuq6aLPaDA+jLCzwEaMJLSfWZLlOd1xFdcvh0REP/lmz7+rd3K7qlG2Z+H2gP6a9aw
	nrAEFqHFlPbFM7I025ytZTAF+FGZKAm9ynhiJqpSowP5HM4RVhXUrIOqepU/+h7KOe3Wy92LcZH
	Y5rDtBJ4NV94mZANJbSyH0O0X3cMPgsM0ElpZLK2hJjKRdzUf4nKw62rV/DSFOYHM4HdcB3+N5i
	mhMoi8N2pzgffS1R0MTV1u6V2nr8R0hWedF+9/UR6ESOJ5m/OXw4tCfxnflrx+XSmkxbfQ9zEkr
	zvje/LVuP/h7RwpTDDDV+oqqu8yPLzZrY62BllWEnrNJ9MwJRqkDTHbR2yz+dpp6mmbtclJXP4z
	2pXWMcFnCSfsWZYedeiuGa743i8b959fl1VDXNJ68DxwJi6EWKqjrzI9uDdFw/o6/EZq+ZZLOxS
	9E2MFHnXGQWP8DscpJz7CrDhMIeVeOdP6gBk7g8Jdq/xg71n64H3Oktyjf
X-Received: by 2002:a05:7022:6197:b0:123:34f5:bb02 with SMTP id a92af1059eb24-125c0fad4d9mr6795383c88.20.1770079774508;
        Mon, 02 Feb 2026 16:49:34 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:33 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v6 09/10] test: Add ext_hdr.py in networking selftests
Date: Mon,  2 Feb 2026 16:48:52 -0800
Message-ID: <20260203004853.94438-10-tom@herbertland.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260203004853.94438-1-tom@herbertland.com>
References: <20260203004853.94438-1-tom@herbertland.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_TO(0.00)[davemloft.net,kernel.org,vger.kernel.org,uliege.be,gmail.com];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256051-lists,netdev=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tom@herbertland.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[herbertland.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,ext_hdr.py:url]
X-Rspamd-Queue-Id: 6F7C6D327B
X-Rspamd-Action: no action

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
 tools/testing/selftests/net/ext_hdr.py | 400 +++++++++++++++++++++++++
 1 file changed, 400 insertions(+)
 create mode 100755 tools/testing/selftests/net/ext_hdr.py

diff --git a/tools/testing/selftests/net/ext_hdr.py b/tools/testing/selftests/net/ext_hdr.py
new file mode 100755
index 000000000000..1226e31392f0
--- /dev/null
+++ b/tools/testing/selftests/net/ext_hdr.py
@@ -0,0 +1,400 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Helper functions for creating extension headers using scapy
+
+import ctypes
+import os
+import proto_nums
+import shlex
+import socket
+import sys
+from enum import Enum
+from scapy.all import *
+
+# Read a sysctl
+def SysctlRead(name):
+	try:
+		# shlex.split helps handle arguments correctly
+		command = shlex.split("sysctl -n %s" % (name))
+		# Use check=True to raise an exception if the command fails
+		result = subprocess.run(command, check=True,
+					capture_output=True, text=True)
+		value = result.stdout.strip()
+	except subprocess.CalledProcessError as e:
+		print(f"Error reading sysctl: {e.stderr}")
+	except FileNotFoundError:
+		print("The 'sysctl' command was not found. "
+		      "Check your system's PATH.")
+
+	return int(value)
+
+# Common definitions for Destination and Hop-by-Hop options
+
+# Common Destination and Hop-by-Hop Options header
+class hbh_dst_options(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("next_hdr", ctypes.c_uint8),
+		("hdr_ext_len", ctypes.c_uint8)
+	]
+
+# Make a common Destination and Hop-by-Hop Options header
+def Make_HBHDst_Options(next_hdr, length):
+	hdr = hbh_dst_options()
+	hdr.next_hdr = next_hdr
+	hdr.hdr_ext_len = length
+
+	return hdr
+
+# Common single Destination and Hop-by-Hop Option header
+class dst_hbh_option(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("opt_type", ctypes.c_uint8),
+		("opt_data_len", ctypes.c_uint8),
+	]
+
+# Make common single Destination and Hop-by-Hop Option header
+def Make_HBHDst_Option(type, length):
+	hdr = dst_hbh_option()
+	hdr.opt_type = type
+	hdr.opt_data_len = length
+
+	return hdr
+
+# Make PAD1 option
+def Make_HBHDst_Option_pad1():
+	bytes = bytearray(1)
+	bytes[0] = proto_nums.HBHDst_Types.HBHDST_TYPE_PAD1.value
+	return (Raw(bytes), 1)
+
+# Make a full DestOpt or HBH Option with some length
+def Make_HBHDst_Option_with_Data(type, len):
+	hdr = Raw(load=Make_HBHDst_Option(type, len))
+	bytes = Raw(bytearray(len))
+	allhdr = hdr/bytes
+	return (allhdr, 2 + len)
+
+# Make PADN option
+def Make_HBHDst_Option_padN(len):
+	return Make_HBHDst_Option_with_Data(
+			proto_nums.HBHDst_Types.HBHDST_TYPE_PADN.value, len)
+
+# Make a Destination or Hop-by-Hop Options list. Input is list of pairs as
+# (type, length). Option data is set to zeroes.
+#
+# Return value is (hdr, len, outcome) where hdr is the raw bytes and length
+# is the length of the header including two bytes for the common extension
+# header (the returned header does not include the two byte common header).
+# outcome is True or False depending on whether the options are expected to
+# exceed a sysctl limit and would be dropped
+def Make_HBHDst_Options_list(list, max_cnt, max_len):
+	hdr = Raw()
+	len = 0
+
+	num_non_padding_opts = 0
+	max_consect_pad1 = 0
+	max_consect_pad_len = 0
+
+	consect_padlen = 0
+
+	# Create the set of options
+	for type, jlen in list:
+		if (type == proto_nums.HBHDst_Types.HBHDST_TYPE_PAD1.value):
+			# PAD1 is a special case
+			pair = Make_HBHDst_Option_pad1()
+			consect_padlen += pair[1]
+		else:
+			pair = Make_HBHDst_Option_with_Data(type, jlen)
+
+			if (type ==
+			    proto_nums.HBHDst_Types.HBHDST_TYPE_PADN.value):
+				consect_padlen += pair[1]
+			else:
+				if (consect_padlen > max_consect_pad_len):
+					max_consect_pad_len = consect_padlen
+				consect_padlen = 0
+				num_non_padding_opts += 1
+
+		# Append the option, add to cumulative length
+		hdr = hdr/pair[0]
+		len += pair[1]
+
+	# Add two to length to account for two byte extension header
+	len += 2
+
+	if (len % 8 != 0):
+		# The extension header length must be a multiple of eight bytes.
+		# If we're short add a padding option
+		plen = 8 - (len % 8)
+		if (plen == 1):
+			pair = Make_HBHDst_Option_pad1()
+		else:
+			pair = Make_HBHDst_Option_padN(plen - 2)
+
+		consect_padlen += pair[1]
+		hdr = hdr/pair[0]
+		len += plen
+
+	if (consect_padlen > max_consect_pad_len):
+		max_consect_pad_len = consect_padlen
+
+	outcome = True
+	if (num_non_padding_opts > max_cnt):
+		# The number of options we created is greater then the sysctl
+		# limit, so we expect the packet to be dropped
+		outcome = False
+	if (len > max_len):
+		# The length of the extension is greater then the sysctl limit,
+		# so we expect the packet to be dropped
+		outcome = False
+	if (max_consect_pad_len > 7):
+		# The maximum consecutive number of bytes of padding is
+		# greater than seven, so we expect the packet to be dropped
+		outcome = False
+
+	return (hdr, len - 2, outcome)
+
+# Make a full Hop-by-Hop or Destination Options header
+def Make_Full_HBHDst_Options_list(next_hdr, list, max_cnt, max_len):
+	pair = Make_HBHDst_Options_list(list, max_cnt, max_len)
+	len = pair[1] + 2
+
+	opts = Make_HBHDst_Options(next_hdr, (len - 1) // 8)
+	hdr = Raw(load=opts)/pair[0]
+
+	return (hdr, len, pair[2])
+
+# Routing header definitions
+
+# Base Routing Header
+class routing_hdr(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("next_hdr", ctypes.c_uint8),
+		("hdr_ext_len", ctypes.c_uint8),
+		("routing_type", ctypes.c_uint8),
+		("segments_left", ctypes.c_uint8)
+	]
+
+# SRv6 Routing Header
+class srv6_routing_hdr(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("rh", routing_hdr),
+		("last_entry", ctypes.c_uint8),
+		("flags", ctypes.c_uint8),
+		("tags", ctypes.c_uint16),
+		# Variable list
+		# TLV options
+   ]
+
+# Make a basic Routing header
+def MakeRouting_Hdr(next_hdr, hdr_ext_len, routing_type, segments_left):
+	hdr = routing_hdr()
+	hdr.next_hdr = next_hdr
+	hdr.hdr_ext_len = hdr_ext_len
+	hdr.routing_type = routing_type
+	hdr.segments_left = segments_left
+
+	return Raw(load=hdr)
+
+# Make an SRv6 Routing Header (with no segments left)
+def MakeSRv6Routing_Hdr(next_hdr, sids, tlvs):
+
+	bhdr = Raw()
+	num_sids = 0
+
+	# Set up each SID in the list
+	for sid in sids:
+		bytes = socket.inet_pton(socket.AF_INET6, sid)
+		bhdr = bhdr/Raw(load=bytes)
+		num_sids += 1
+
+	len = num_sids * 16
+
+	hdr = srv6_routing_hdr()
+
+	hdr.rh.next_hdr = next_hdr
+	hdr.rh.hdr_ext_len = len // 8
+	hdr.rh.routing_type = proto_nums.RoutingTypes.ROUTING_TYPE_SRH.value
+	hdr.rh.segments_left = 0
+
+	hdr.last_entry = num_sids - 1
+	hdr.flags = 0
+	hdr.tags = 0
+
+	bhdr = Raw(load=hdr)/bhdr
+
+	return (bhdr, len + 8, True)
+
+# Fragment header
+
+# Basic Fragment Header
+class fragment_hdr(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("next_hdr", ctypes.c_uint8),
+		("rsvd", ctypes.c_uint8),
+		("fragment_offset", ctypes.c_uint16, 13),
+		("rsvd2", ctypes.c_uint16, 2),
+		("more", ctypes.c_uint16, 1),
+		("identfication", ctypes.c_uint32),
+	]
+
+# Make Fragment Header
+def MakeFragment_Hdr(next_hdr, fragment_offset, more, ident):
+	hdr = fragment_hdr()
+	hdr.next_hdr = next_hdr
+	hdr.fragment_offset = fragment_offset
+	hdr.identfication = ident
+
+	return (Raw(load=hdr), 8, True)
+
+# Authentication Header
+
+# Base Authentication Header
+class auth_hdr(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("next_hdr", ctypes.c_uint8),
+                ("payload_len", ctypes.c_uint8),
+		("spi", ctypes.c_uint32)
+		# ICV is variable length
+	]
+
+# Make and authenrication Header
+def MakeAuth_Hdr(next_hdr, payload_len, spi):
+	hdr = auth_hdr()
+	hdr.next_hdr = next_hdr
+	hdr.payload_len = payload_len
+	hdr.spi = spi
+
+	return hdr
+
+# ESP
+
+# Base ESP header
+class esp_hdr(ctypes.BigEndianStructure):
+	_pack_ = 1
+	_fields_ = [
+		("spi", ctypes.c_uint32),
+		("seqno", ctypes.c_uint32)
+		# Payload data + padding
+		# ICV is variable length
+	]
+
+# Make an ESP header
+def MakeESP_Hdr(next_hdr, spi, seqno):
+	hdr = esp_hdr()
+	hdr.spi = spi
+	hdr.seqno = seqno
+
+	return hdr
+
+# Check if EH list is out of order
+def Check_EH_Order(list):
+	# OOO is okay if sysctl is not enforcing in order
+	do_check = SysctlRead("net.ipv6.enforce_ext_hdr_order")
+
+	seen = 0
+	for type, args in list:
+		if type == "H":
+			order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_HOP.value
+		elif type == "D":
+			if (seen &
+			    proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_ROUTING.value):
+				order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_DEST.value
+			else:
+				order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_DEST_BEFORE_RH.value
+		elif type == "R":
+			order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_ROUTING.value
+		elif type == "F":
+			order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_FRAGMENT.value
+			if (seen & order != 0):
+				# Linux stack doesn't allow more than one
+				# Fragment Header in a packet
+				return False
+		elif type == "A":
+			order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_AUTH.value
+		elif type == "E":
+			order = proto_nums.EH_Order.IPV6_EXT_HDR_ORDER_ESP.value
+
+		if (do_check and seen >= order):
+			return False
+		seen |= order
+
+	return True
+
+# Make an extension header chain from a list
+# The list contains a set of pairs in the form (<eh_type>, <args>)
+# <eh_type> is:
+#	"H"-- Hop-by-Hop Options
+#	"D"-- Destination Options
+#	"R"-- Routing Header
+#	"F"-- Fragment Header
+#	"A"-- Authentication Header
+#	"E"-- ESP
+#
+# <args> is specific to EH type
+def Make_EH_Chain(next_hdr, list):
+	nlist = []
+
+	# Run through the list in reverse and set the next header up for each
+	# enty
+	for type, args in reversed(list):
+		entry = (type, args, next_hdr)
+		nlist.insert(0, entry)
+		if type == "H":
+			next_hdr = proto_nums.IP_Proto.IP_PROTO_HOPOPT.value
+		elif type == "D":
+			next_hdr = proto_nums.IP_Proto.IP_PROTO_IPv6_Opts.value
+		elif type == "R":
+			next_hdr = proto_nums.IP_Proto.IP_PROTO_IPv6_Route.value
+		elif type == "F":
+			next_hdr = proto_nums.IP_Proto.IP_PROTO_IPv6_Frag.value
+		elif type == "A":
+			next_hdr = proto_nums.IP_Proto.IP_PROTO_AH.value
+		elif type == "E":
+			next_hdr = proto_nums.IP_Proto.IP_PROTO_ESP.value
+
+	outcome = Check_EH_Order(list)
+
+	hdr = Raw()
+	len = 0
+
+	for type, args, nnext_hdr in reversed(nlist):
+		if type == "H":
+			# args is a list of (<opt_type>, <opt_len>) pairs
+			pair = Make_Full_HBHDst_Options_list(nnext_hdr, args,
+				SysctlRead("net.ipv6.max_hbh_opts_number"),
+				SysctlRead("net.ipv6.max_hbh_length"))
+		elif type == "D":
+			# args is a list of (<opt_type>, <opt_len>) pairs
+			pair = Make_Full_HBHDst_Options_list(nnext_hdr, args,
+				SysctlRead("net.ipv6.max_dst_opts_number"),
+				SysctlRead("net.ipv6.max_dst_opts_length"))
+		elif type == "R":
+			# args is a list of IPv6 address string
+			pair = MakeSRv6Routing_Hdr(nnext_hdr, args, [])
+		elif type == "F":
+			# Arg is (<identifier>)
+			pair = MakeFragment_Hdr(nnext_hdr, 0, False, args)
+		elif type == "A":
+			print("Auth type not supported for test")
+			sys.exit(1)
+		elif type == "E":
+			print("ESP type not supported for test")
+			sys.exit(1)
+		else:
+			print("Unknown EH type character")
+			sys.exit(1)
+
+		hdr = pair[0]/hdr
+		len += pair[1]
+
+		if (pair[2] == False):
+			outcome = False
+
+	return (hdr, len, next_hdr, outcome)
-- 
2.43.0


