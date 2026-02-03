Return-Path: <netdev+bounces-256052-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sFPmBhhHgWkZFQMAu9opvQ
	(envelope-from <netdev+bounces-256052-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:53:44 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A372D329A
	for <lists+netdev@lfdr.de>; Tue, 03 Feb 2026 01:53:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B7EC430675B2
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 00:49:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94CB1217722;
	Tue,  3 Feb 2026 00:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="dAS3JvWG"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f173.google.com (mail-dy1-f173.google.com [74.125.82.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C6932165EA
	for <netdev@vger.kernel.org>; Tue,  3 Feb 2026 00:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770079779; cv=none; b=jl6ukPadO+cqOadTmVULFR1EJm2h3Ngm1dmM1qOiSqVkPQqzkSgDzis+JyxB4Jaetk9f9+HISC7bChrGW329WhTkZPlyOj2z1pva9OxWN29I1ZWrP/fNr8dBBJ2gD5WV8hdjB3uHRzzuRyvPBgfhO3oaYzQNfc0vYKCpdf3/3u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770079779; c=relaxed/simple;
	bh=gioJCSc3E6x/X5AhjxKtgQFKZWZs28mmwv59fWo7dis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nX4qKO9W9xUSoHD3ySf/342z/VwQHgPXmN80WuXKutKn+HmHCuVP6N691qGnUNn54z4xQj3ki/mDD+7RwKmXuGP/eZCxHsdjJPWWkri4gnSL3U8ekbQnA4t5rucsYDuR57mZQlvwrKrF3dC7hn3//IFFUgKODCbuRIklKa0RKy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=dAS3JvWG; arc=none smtp.client-ip=74.125.82.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f173.google.com with SMTP id 5a478bee46e88-2b4520f6b32so9000315eec.0
        for <netdev@vger.kernel.org>; Mon, 02 Feb 2026 16:49:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1770079776; x=1770684576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DKlBHvvPAzy5iUZFuDcJ9Mk61OjspfAZbOUZM15hj8o=;
        b=dAS3JvWGz2tlHDqI2aRqZSNEtIhxLFo3TLMowCAg4MmaYRSeAESBMnRUfsviS8qmzH
         l60RjPY/SNVbpUBP1h65Vd10YpvcvFFsILdqzC7WYltliwqOdzyIwLWXAPZl3BqitIjo
         LIJl3x2Y8/I+9GrvafaRDWGp9TRlGb+ptrbIAGSBAY9Z+ak52+MxYCyZzcAC40ukPskr
         X8657xr9QSM+oi6wr7qc2r1aqLHJqrAcLyIu8g3UMuJ+/rd3lP1ZJlU9gAt/+NZZmhNu
         RE/MdnZFtGnpZNjk+GIi54MZgKzQ6frg30DoGtLTaSEj4Sl5e5bc+KIeeB6fohaDKc24
         dCZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770079776; x=1770684576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DKlBHvvPAzy5iUZFuDcJ9Mk61OjspfAZbOUZM15hj8o=;
        b=PulydTyuHH4QJNpIwBbQvjUKqKh1OFbjNcDiidtdlAAAtp6K5dmyEl6D7PA/czPDpW
         xo7TMuNd5hO9pR0w9dBt7HIXW8yYRye3ibWIIrUsCAgGJmHaDYXFzKScaceNu02K3Onp
         m3Oke462Hf8MlCRiFan3fZSOEHla7sxoWgSm7O3JkuniNI4wimCOaRyE8vAgvpMEL4vm
         OfkL2BzHYpwTsB3khdCf+IUHAI+W6D1ZmXvy77irzSoLagWsY9bBq3/4bjzWNzzvZchP
         kdlMHUppUfpPELBK3/GLaQnOjVg/UPdXP0TDhZ2b77d+WGthCQdaqjYl01rx68bUqK6/
         V5ww==
X-Forwarded-Encrypted: i=1; AJvYcCUEfsDaCxqW9Nypj0NdwzFLw6/Zhy1u4WuekfEoHEYLySCqaLBMgfGFcBOEjSaFpOlKSd4aviE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwNuTYqafXkxPY236U4T18QMbd7XnTRn13VLQxjeCnMCqUPWboN
	OxVuzOkpuvtWLhE5Xgj8Yg5Ji00tonG+25ND/CgWPbKgHsthh2u0Fa4TEX1zuG/Qug==
X-Gm-Gg: AZuq6aIZgCbU1wLqW+GyukKathmsi1Jq12NRV2AVbL4bDdPZjPqYm95/I4bDO9QGGRG
	Oh0quE8pb6PYkOGnJV5cRS4nht3zYKh+7RD2JdbGAiomztdOW9V4TOonHfxfk0oQpVYIYztZwnF
	SNnNG9zcLHPFs9FMDCUHmer+msSaCohd6Xj67bKN8+BBH0HiJo78McINm7C9N5DGaVYJMZGm9Pc
	OWqFsnJN5xLHbndhxZdkh/ArBnobx1NBoQjes3uSG9EU5M3LKn8F2tJcepyY3vVnn1ioGRUi8U/
	pnKnLbdVtgEB/uWA3YtEhNzGL87SG2WRR35sjMqfwU2qX/i3SVcabpvEHfs9LZZty5Luvom5mdP
	UXBp+JR9aB4QxEItmbpuej2OFMICJzx5UuJl3Dglmk2RCv42aqk+bI4AnbdeEYi89aMLC7Bhbtv
	APg6IhDw0exPFzY5+S/jJ1MbI85+hbipACeMha1MsM3EoU3Ahy8nexuUf+
X-Received: by 2002:a05:693c:3944:b0:2b0:5929:4d1f with SMTP id 5a478bee46e88-2b7c890281bmr3878217eec.33.1770079776354;
        Mon, 02 Feb 2026 16:49:36 -0800 (PST)
Received: from pong.herbertland.com ([2601:646:8980:b330:d7c2:35ea:5a4f:74f9])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2b7a1abe92dsm21017016eec.17.2026.02.02.16.49.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 16:49:35 -0800 (PST)
From: Tom Herbert <tom@herbertland.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	netdev@vger.kernel.org,
	justin.iurman@uliege.be,
	willemdebruijn.kernel@gmail.com
Cc: Tom Herbert <tom@herbertland.com>
Subject: [PATCH net-next v6 10/10] test: Add networking sefltest for eh limits
Date: Mon,  2 Feb 2026 16:48:53 -0800
Message-ID: <20260203004853.94438-11-tom@herbertland.com>
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
	TAGGED_FROM(0.00)[bounces-256052-lists,netdev=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[herbertland.com:email,herbertland.com:dkim,herbertland.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lib.sh:url]
X-Rspamd-Queue-Id: 5A372D329A
X-Rspamd-Action: no action

Add a networking selftest for Extension Header limits. The
limits to test are in systcls:

	net.ipv6.enforce_ext_hdr_order
	net.ipv6.max_dst_opts_number
	net.ipv6.max_hbh_opts_number
	net.ipv6.max_hbh_length
	net.ipv6.max_dst_opts_length

The basic idea of the test is to fabricate ICMPv6 Echo Request
packets with various combinations of Extension Headers. The packets
are sent to a host in another namespace. If a an ICMPv6 Echo Reply
is received then the packet wasn't dropped due to a limit being
exceeded, and if it was dropped then we assume that a limit was
exceeded. For each test packet we derive an expectation as to
whether the packet will be dropped or not. Test success depends
on whether our expectation is matched. i.e. if we expect a reply
then the test succeeds if we see a reply, and if we don't expect a
reply then the test succeeds if we don't see a reply.

The test is divided into a frontend bash script (eh_limits.sh) and a
backend Python script (eh_limits.py).

The frontend sets up two network namespaces with IPv6 addresses
configured on veth's. We then invoke the backend to send the
test packets. This first pass is done with default sysctl settings.
On a second pass we change the various sysctl settings and run
again.

The backend runs through the various test cases described in the
Make_Test_Packets function. This function calls Make_Packet for
a test case where arguments provide the Extension Header chain to
be tested. The Run_Test function loops through the various packets
and tests if a reply is received versus the expectation. If a test
case fails then an error status is returned by the backend.

The backend script can also be run with the "-w <pcap_file>" to
write the created packets to a pcap file instead of running the
test.

Signed-off-by: Tom Herbert <tom@herbertland.com>
---
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/eh_limits.py | 352 +++++++++++++++++++++++
 tools/testing/selftests/net/eh_limits.sh | 205 +++++++++++++
 3 files changed, 558 insertions(+)
 create mode 100755 tools/testing/selftests/net/eh_limits.py
 create mode 100755 tools/testing/selftests/net/eh_limits.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index afdea6d95bde..73195a2e8f1e 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -24,6 +24,7 @@ TEST_PROGS := \
 	cmsg_time.sh \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
+	eh_limits.sh \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
 	fcnal-other.sh \
diff --git a/tools/testing/selftests/net/eh_limits.py b/tools/testing/selftests/net/eh_limits.py
new file mode 100755
index 000000000000..01fcf15c6b94
--- /dev/null
+++ b/tools/testing/selftests/net/eh_limits.py
@@ -0,0 +1,352 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Test of extension header limits
+
+import ext_hdr
+import getopt
+import proto_nums
+import shlex
+
+from scapy.all import *
+
+# Constants
+
+verbose = False
+source_mac = "00:11:22:33:44:55"
+destination_mac = "AA:BB:CC:DD:EE:FF"
+source_ip = "2001:db8::7"
+destination_ip = "2001:db8::8"
+packet_list = []
+pcap_out=""
+glob_ident = 1111
+ether_frame = Raw()
+with_eth = False
+
+# Parse command line options
+def Cli_Args():
+	global verbose, source_mac, destination_mac, source_ip
+	global destination_ip, pcap_out
+
+	args = sys.argv[1:]
+
+	try:
+		opts, remainder = getopt.getopt(args, "vw:",
+			["verbose", "src_eth=", "dst_eth", "src_ip=",
+			 "dst_ip=", "pcap_out="])
+	except getopt.GetoptError as err:
+		# Print error message and exit
+		print(err)
+		sys.exit(2)
+
+	for opt, arg in opts:
+		if opt in ("-v", "--verbose"):
+			verbose = True
+		elif opt in ("--src_eth"):
+			source_mac = arg
+		elif opt in ("--dst_eth"):
+			destination_mac = arg
+		elif opt in ("--src_ip"):
+			source_ip = arg
+		elif opt in ("--dst_ip"):
+			destination_ip = arg
+		elif opt in ("-w", "--pcap_out"):
+			pcap_out = arg
+
+# Make an ICMP echo request packet with the requested Extension Header chain
+def Make_Packet(text_name, eh_list):
+	global glob_ident,  packet_list, with_eth
+
+	hdr = Raw()
+	len = 0
+
+	hdr = ICMPv6EchoRequest(id=glob_ident)/hdr
+	len += 8
+
+	pair = ext_hdr.Make_EH_Chain(
+		proto_nums.IP_Proto.IP_PROTO_IPv6_ICMP.value, eh_list)
+	hdr = pair[0]/hdr
+	len += pair[1]
+
+	ipv6_pkt = IPv6(src=source_ip, dst=destination_ip, nh=pair[2], plen=len)
+	hdr = ipv6_pkt / hdr
+	len += 40
+
+	if (with_eth):
+		hdr = ether_frame/hdr
+		len += 14
+
+	packet_list.append((hdr, len, glob_ident, pair[3], text_name))
+	glob_ident += 1
+
+# Write a pacp file with all the created packets
+def Write_Pcap(pcap_out):
+	global packet_list, ether_frame, with_eth
+
+	ether_frame = Ether(src=source_mac, dst=destination_mac, type=0x86DD)
+	with_eth = True
+
+	packets=[]
+	for packet in packet_list:
+		packets.append(packet[0])
+	wrpcap(pcap_out, packets)
+
+# Run ping test
+def Run_Test():
+	global packet_list, verbose, source_ip, destination_ip
+
+	# Open raw ICMP socket
+	try:
+	    s = socket.socket(socket.AF_INET6, socket.SOCK_RAW,
+			      socket.IPPROTO_ICMPV6)
+	except PermissionError:
+		print("This script requires root privileges.")
+		return 2
+
+	# Bind to interface by its IP address
+	s.bind((source_ip, 0))
+
+	# Run through eACH PACKET
+	for packet in packet_list:
+		# Send packet
+		send(packet[0], verbose=False)
+
+		s.settimeout(0.100)
+		found_it = False
+
+		# Try to get ICMP echo reply
+		try:
+			while (found_it == False):
+				rpacket, addr = s.recvfrom(1024)
+				x = struct.unpack(">H", rpacket[0:2])
+				icmp_type, icmp_code = struct.unpack("BB",
+								rpacket[0:2])
+				checksum = struct.unpack("H", rpacket[2:4])
+				identifier = struct.unpack(">H", rpacket[4:6])
+				seqno = struct.unpack(">H", rpacket[6:8])
+				if (icmp_type ==
+				    proto_nums.ICMP6_Type.ICMPV6_ECHO_REPLY.value and
+				    identifier[0] == packet[2]):
+					found_it = True
+
+		except socket.timeout:
+			pass
+
+		if (verbose):
+			if (found_it):
+				if (packet[3]):
+					print("TEST: %s: Received as expected" %
+								packet[4])
+				else:
+					print("TEST: %s: Unexpedted receive" %
+								packet[4])
+			else:
+				if (packet[3]):
+					print("TEST: %s: Didn't receive, "
+					      "but receive expected" %
+								packet[4])
+				else:
+					print("TEST: %s: Didn't receive as "
+					      "expected" % packet[4])
+
+
+		if (found_it and packet[3] != True):
+			# We got a reply but weren't expecting one
+			print("FAIL: Receive was unexpected for %s" % packet[4])
+			return 1
+		elif (not found_it and packet[3]):
+			# We didn't get a reply but weret expecting one
+			print("FAIL: Expected to receive for %s" % packet[4])
+			return 1
+
+	return 0
+
+# Make packets for various test cases
+def Make_Test_Packets():
+	global packet_list
+
+	# Two non-padding options in HBH and DestOpt, should succeed
+	# with default sysctls
+	Make_Packet("Two non-padding options in HBH and DestOpts",
+	    [
+		("H", [(11, 4), (0, 0), (0, 0), (12, 3)]),
+		("D", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+		("D", [(1, 4), (12, 3)]),
+	    ])
+
+	# Big destination option, should fail when
+	# net.ipv6.max_dst_opts_length equals 64
+	Make_Packet("Big destination option",
+	    [
+		("H", [(11, 4), (0, 0), (0, 0), (12, 3)]),
+		("D", [(1, 4), (12, 255)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+	    ])
+
+	# Almost Big HBH option should succeed when
+	# net.ipv6.max_hbh_length equals 64
+	Make_Packet("Almost Big HBH option",
+	    [
+		("H", [(11, 53), (1, 0), (12, 3)]),
+		("D", [(1, 4), (12, 1)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+	    ])
+
+	# Big Hop-by-Hop option, should fail when
+	# net.ipv6.max_hbh_length equals 64
+	Make_Packet("Big HBH option",
+	    [
+		("H", [(11, 53), (1, 0), (0, 0), (12, 3)]),
+		("D", [(1, 4), (12, 1)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+	    ])
+
+	# Too much HBH padding, should always fail
+	Make_Packet("Too much HBH padding",
+	    [
+		("H", [(12, 3), (1, 8)]),
+		("D", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+		("D", [(1, 4), (12, 3)]),
+	    ])
+
+	# Too much DestOpt padding, should always fail
+	Make_Packet("Too much DestOpt padding",
+	    [
+		("H", [(12, 3), (1, 8)]),
+		("D", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+		("D", [(1, 4), (12, 3), (0, 0), (1, 6), (0, 0), (12, 3)]),
+	    ])
+
+	# Too much DestOpt padding, should always fail
+	Make_Packet("Too much DestOpt padding #2",
+	    [
+		("H", [(12, 3)]),
+		("D", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+		("D", [(1, 4), (12, 3), (0, 0), (0, 0), (0, 0), (0, 0),
+		       (0, 0), (0, 0), (0, 0), (0, 0), (12, 3)]),
+	    ])
+
+	# Too much DestOpt padding, should always fail
+
+	Make_Packet("Too much DestOpt padding #3",
+	    [
+		("D", [(0, 0), (0, 0), (0, 0), (0, 0),
+		       (0, 0), (0, 0), (0, 0), (0, 0)]),
+	    ])
+
+	# Almost too much DestOpt padding, should succeed with default
+	# sysctl settings
+	Make_Packet("Almost too much DestOpt padding #2",
+	    [
+		("H", [(12, 3)]),
+		("D", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("F", (0x89abcdef)),
+		("D", [(1, 4), (12, 3), (0, 0), (0, 0), (0, 0), (0, 0),
+		       (0, 0), (0, 0), (0, 0), (12, 3)]),
+	    ])
+
+	# Two Dest Ops, should fail unless net.ipv6.enforce_ext_hdr_order
+	# equals 1
+	Make_Packet("Two Dest Ops",
+	    [
+		("D", []),
+		("D", []),
+	    ])
+
+	# OOO Routing headers, should fail unless
+	# net.ipv6.enforce_ext_hdr_order equals 1
+	Make_Packet("OOO Routing header",
+	    [
+		("F", (0x89abcdef)),
+		("R", [ "888::1", "9999::1"]),
+	    ])
+
+	# Two Routing headers, should fail unless
+	# net.ipv6.enforce_ext_hdr_order equals 1
+	Make_Packet("Two Routing headers",
+	    [
+		("R", [ "888::1", "9999::1"]),
+		("R", [ "888::1", "9999::1"]),
+	    ])
+
+	# Two DestOpt headers with Routing header should succeed with default
+	# sysctl settings
+	Make_Packet("Two Destination options okay",
+	    [
+		("D", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3)]),
+	    ])
+
+	# Two DestOpt headers without Routing header should fail unless
+	# net.ipv6.enforce_ext_hdr_order equals 1
+	Make_Packet("Two Destination options",
+	    [
+		("D", [(1, 4), (12, 3)]),
+		("D", [(1, 4), (12, 3)]),
+	    ])
+
+	# Two DestOpt headers after Routing header, should fail unless
+	# net.ipv6.enforce_ext_hdr_order equals 1
+	Make_Packet("Two Destination options after RH",
+	    [
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3)]),
+		("D", [(1, 4), (12, 3)]),
+	    ])
+
+	# Many extension headers, should fail unless
+	# net.ipv6.enforce_ext_hdr_order equals 1
+	Make_Packet("Many EH OOO",
+	    [
+		("H", [(1, 4), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3)]),
+		("D", [(1, 4), (12, 3), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3)]),
+		("F", (0x89abcdef)),
+		("D", [(1, 4), (12, 3), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3), (12, 3)]),
+		("R", [ "888::1", "9999::1"]),
+		("R", [ "888::1", "9999::1"]),
+		("D", [(1, 4), (12, 3), (12, 3)]),
+	    ])
+
+	# Two fragment headers, should always fail due to stack
+	# implementation
+	Make_Packet("Two fragment Headers",
+	    [
+		("F", (0x89abcdef)),
+		("F", (0x89abcdef)),
+	    ])
+
+Cli_Args()
+
+Make_Test_Packets()
+
+if (pcap_out != ""):
+	Write_Pcap(pcap_out)
+	status = 0
+else:
+	status = Run_Test()
+
+exit(status)
diff --git a/tools/testing/selftests/net/eh_limits.sh b/tools/testing/selftests/net/eh_limits.sh
new file mode 100755
index 000000000000..4a101930ab54
--- /dev/null
+++ b/tools/testing/selftests/net/eh_limits.sh
@@ -0,0 +1,205 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+# Tests extension header limits.
+#
+# We start by setting up two network namespaces with IPv6 addresses.
+# Then we create ICMPv6 Echo Request packets with various combinations of
+# Extension Headers, and send them from one namespace to the other and
+# check if a reply is received. Based on the sysctl settings certain packets
+# are expected to produce echo replies and others are expected to be drop
+# because an Extension Header related limit is exceeded. If an Echo Reply is
+# received or not received per our expectations then the test passes,
+# otherwise if the result is unexpected that's a test failure.
+# Tests extension header limits.
+
+source lib.sh
+
+ret=0
+
+# all tests in this script. Can be overridden with -t option
+TESTS="eh_limits"
+
+VERBOSE=""
+PAUSE_ON_FAIL=no
+PAUSE=no
+NAME="EH-limits"
+
+IP1="2001:db8::1"
+IP2="2001:db8::2"
+
+log_test()
+{
+	local rc=$1
+	local expected=$2
+	local msg="$3"
+
+	if [ ${rc} -eq ${expected} ]; then
+		printf "    TEST: %-60s  [ OK ]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+		echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo
+		echo "hit enter to continue, 'q' to quit"
+		read a
+		[ "$a" = "q" ] && exit 1
+	fi
+}
+
+################################################################################
+# Setup
+
+setup()
+{
+	set -e
+
+	setup_ns ns1 ns2
+
+	NS_EXEC="ip netns exec"
+
+	ip link add veth1 type veth peer name veth2
+
+	ip link set veth1 netns "$ns1"
+	ip link set veth2 netns "$ns2"
+
+	$NS_EXEC "$ns1" ip addr add ${IP1}/64 dev veth1
+	$NS_EXEC "$ns1" ip link set veth1 up
+	$NS_EXEC "$ns1" ip link set lo up
+
+	$NS_EXEC "$ns2" ip addr add ${IP2}/64 dev veth2
+	$NS_EXEC "$ns2" ip link set veth2 up
+	$NS_EXEC "$ns2" ip link set lo up
+
+	# Enable SRv6 on the receiver since that's the type of routing header
+	# used in the test
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.conf.all.seg6_enabled=1 > /dev/null
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.conf.veth2.seg6_enabled=1 > /dev/null
+
+	set +e
+
+	# Send a ping to do neighuor discovery
+	$NS_EXEC "$ns1" ping6 -w 2 $IP2 -c 1 > /dev/null
+}
+
+exit_cleanup_all()
+{
+	cleanup_all_ns
+	exit "${EXIT_STATUS}"
+}
+
+eh_limits_test()
+{
+	local ip_addrs="--src_ip $IP1 --dst_ip $IP2"
+
+	if [ "$VERBOSE" = "-v" ]; then
+		echo ">>>>> Default"
+	fi
+
+	# Run the test with default sysctl settings
+	$NS_EXEC "$ns1" python3 ./eh_limits.py $VERBOSE $ip_addrs
+
+	log_test $? 0 "$NAME - default sysctls"
+
+	if [ "$VERBOSE" = "-v" ]; then
+		echo ">>>>> No order enforce, 8 options, 66 length limit"
+	fi
+
+	# Set extension header limit sysctls. We do this on both sides since
+	# the sender reads the sysctl's to determine pass/fail expectations
+
+	$NS_EXEC "$ns1" sysctl -w net.ipv6.enforce_ext_hdr_order=0 > /dev/null
+	$NS_EXEC "$ns1" sysctl -w net.ipv6.max_dst_opts_number=8 > /dev/null
+	$NS_EXEC "$ns1" sysctl -w net.ipv6.max_hbh_opts_number=8 > /dev/null
+	$NS_EXEC "$ns1" sysctl -w net.ipv6.max_hbh_length=64 > /dev/null
+	$NS_EXEC "$ns1" sysctl -w net.ipv6.max_dst_opts_length=64 > /dev/null
+
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.enforce_ext_hdr_order=0 > /dev/null
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.max_dst_opts_number=8 > /dev/null
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.max_hbh_opts_number=8 > /dev/null
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.max_hbh_length=64 > /dev/null
+	$NS_EXEC "$ns2" sysctl -w net.ipv6.max_dst_opts_length=64 > /dev/null
+
+	# Run the test with modified sysctl settings
+	$NS_EXEC "$ns1" python3 ./eh_limits.py $VERBOSE $ip_addrs
+
+	log_test $? 0 "$NAME - modified sysctls"
+}
+
+################################################################################
+# usage
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/} OPTS
+
+        -t <test>   Test(s) to run (default: all)
+                    (options: $TESTS)
+        -p          Pause on fail
+        -P          Pause after each test before cleanup
+        -v          verbose mode (show commands and output)
+EOF
+}
+
+################################################################################
+# main
+
+while getopts :t:pPhv o
+do
+	case $o in
+		t) TESTS=$OPTARG;;
+		p) PAUSE_ON_FAIL=yes;;
+		P) PAUSE=yes;;
+		v) VERBOSE="-v";;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+PEER_CMD="ip netns exec ${PEER_NS}"
+
+# make sure we don't pause twice
+[ "${PAUSE}" = "yes" ] && PAUSE_ON_FAIL=no
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit $ksft_skip;
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit $ksft_skip
+fi
+
+if [ ! -x "$(command -v socat)" ]; then
+	echo "SKIP: Could not run test without socat tool"
+	exit $ksft_skip
+fi
+
+# start clean
+cleanup &> /dev/null
+
+for t in $TESTS
+do
+	case $t in
+	eh_limits)		setup; eh_limits_test; cleanup_all_ns;;
+
+	help) echo "Test names: $TESTS"; exit 0;;
+	esac
+done
+
+if [ "$TESTS" != "none" ]; then
+	printf "\nTests passed: %3d\n" ${nsuccess}
+	printf "Tests failed: %3d\n"   ${nfail}
+fi
-- 
2.43.0


