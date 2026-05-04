Return-Path: <netdev+bounces-284015-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIfdDTLr+Gmi3AIAu9opvQ
	(envelope-from <netdev+bounces-284015-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C526C4C2C64
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 20:53:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E613430089AE
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 18:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F7613E6DF5;
	Mon,  4 May 2026 18:53:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b="C+rj/FIg"
X-Original-To: netdev@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FF5D3E7161
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 18:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777920792; cv=none; b=rfbsP19qjlb6Qh3AZ1ipeEjUqTyrm4vj2JmHPJwZh2+OCIPm1bnpsmk8XVGyT38wPPZIlIihBx8ZzQ/2+SnqNtuMG/h7u0KJY1cM3dg7PlTjyuXeuKzcrcSib+wMRbbbka1AV5SvUPHcdO2g3WAA1c5xzMHZXVHAUVptHdTx3io=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777920792; c=relaxed/simple;
	bh=iJ2NA1FXz3YjtzDoVXwtg1EvknYhkdUQFmDKScejO4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KADxaqUvACoW50srj2M3Uq+fjB3EcJsWa4azkn5Bwd8laWSpSXZxJ6hHiaBQi4Ij+FpMP3coD7fKqlsLCoTUodZVS9f0hHnxg7jyHl7+TcfIxKgHw9tOaGBS8k+d1MSc2PBl9GPt5EbXspyclGM8U3nmUMfOzl82Ig/KK+70fxQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com; spf=pass smtp.mailfrom=herbertland.com; dkim=pass (2048-bit key) header.d=herbertland.com header.i=@herbertland.com header.b=C+rj/FIg; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=herbertland.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=herbertland.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2ba895adfeaso4743343eec.0
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 11:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=herbertland.com; s=google; t=1777920790; x=1778525590; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hSK4Y2l4CD5+dUD89bzO+Mp0HgBF70jz33/7jd4SThw=;
        b=C+rj/FIg98UFvoGed5E+stz1na+Id2hVnsE91OveUOHWQKykJKr0qI6VWCYi8fRS6G
         Vlsi0Z2762fa1ZClZadRLcPog1wAzdjTDE2ySkizWPIvRDJpaFHmGvb+rUfDj1o1PQVE
         3lfhXOB65cwwslhPH5Rmx02Rp/wK3+7KDdIyafizmUZ4tJj7c/yQYLWJSn0gkYMKw4nc
         zfzrov1QIfgAyuaua+j+edC5BZBgGbDu0pIniXgEaUkTNCltyxs/PfjLkIsDrFltBRtE
         smv+vxAblaDRBzPN7i47R/n+rwN5y/2VvvojtfllpsHA30okl67o38z0KlQD174Mjpk4
         +e6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777920790; x=1778525590;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hSK4Y2l4CD5+dUD89bzO+Mp0HgBF70jz33/7jd4SThw=;
        b=RqykCi7Wf25EvuBd344UDUrALUBCkeDQRuYtaqJESvekDCgljqysd1daEe6fTWq4sF
         m5HbPWYnOSNa0T60taxKC08CzfjtWQmtfvnrP1b5gQIzatLsEw/kBmtizT+VsHfGPJhq
         AsVkKyvJY92tyo2iEE1YgY8i6x8+9T0f3KlYRzCSXlLtBWjYv6EU/412TdUNOS6VnEZp
         rQYqsR8TsXq79MEIwT2gP1aBosaRhmeGbzgJ3JFk63k8gDwN8LpwUPs5qPYhFjYjIAUO
         LuCXBI9a45lh8oYi19jmnJOpeBfuN69VISaASKY+OkllkaeOmqbfWpnbG3bqrZdC7lun
         SIPw==
X-Forwarded-Encrypted: i=1; AFNElJ8XJT4jXi8BebcAOAMq1n4NGIbmnZUR4AWLvQVUSFTA9S4t4CRc0UTj+XH+PFqkNvK02KrR6ho=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIOwy8GmOxiw2I/zhMeiDLgRQM5yMOT4tepSJjSU6eOIZLqdU3
	TisqzfZG+C8gUtwVj9qX/tEoMZ2IfZJ0iL8pBmftKy9lsf4ELojI/jnbsOYVZXDiTQ==
X-Gm-Gg: AeBDietwsXNoHdy2cDSlAOxABc3bhXnQzewmkgh3cvg7ynupb8Yo1V9bW/DiazjBjvq
	jUKHWk/eHmNPWbZFg1ykXSz8r1LvhKLjCHlL+6SI3KsKm20u9zRfTw3PKuAS4Vs3YDDHgAZYGcd
	g6UFzhZh5FcLF3r+QijFAwKX/i3v+NwEJw8fWC75afmlzcsi/HiSlvC4yuU2ZviubKiltPMSPia
	KgZjrEGs9WJFH9ej1WCzk+g6m/I+9PlLAshi5AGRh9OrFfqYXRXXw+wU943UiNFUhGlFcnHIOSB
	zt85hYWOX4pnHXPbDg2aN7L2DxNamtKvZwEMLJQ0fdYz+hiwzkxEW9g3Q8yiMU00uzE4nCyscMm
	PL6NMkUcj5bFitugZjRz6XTlWHOObSdUUxZj32pUnuyD2X+sDMS8GMQfXLXlgMQ8a3yF54kGSFx
	RKqDm9JcpVz0nEtrcCY+H9A3sPNx5bI/IJzejtoqWs1KuwpA75VtSkb2U2FEeSBGmQkZm2ay38y
	e7eDit4YNo=
X-Received: by 2002:a05:7301:100c:b0:2d8:b814:29af with SMTP id 5a478bee46e88-2efb7bdc837mr5190350eec.3.1777920789380;
        Mon, 04 May 2026 11:53:09 -0700 (PDT)
Received: from pong.herbertland.com ([2601:646:8980:b330:8e62:719f:fc3d:b6ad])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ee3889d657sm17186262eec.4.2026.05.04.11.53.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 11:53:08 -0700 (PDT)
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
Subject: [PATCH net-next v10 10/10] test: Add networking selftest for eh limits
Date: Mon,  4 May 2026 11:51:22 -0700
Message-ID: <20260504185122.50642-11-tom@xdpnet.ai>
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
X-Rspamd-Queue-Id: C526C4C2C64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[herbertland.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[herbertland.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-284015-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,xdpnet.ai:mid,herbertland.com:dkim,herbertland.com:email,eh_limits.sh:url,eh_limits.py:url]

From: Tom Herbert <tom@herbertland.com>

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
 tools/testing/selftests/net/Makefile     |   2 +
 tools/testing/selftests/net/eh_limits.py | 349 +++++++++++++++++++++++
 tools/testing/selftests/net/eh_limits.sh | 210 ++++++++++++++
 3 files changed, 561 insertions(+)
 create mode 100755 tools/testing/selftests/net/eh_limits.py
 create mode 100755 tools/testing/selftests/net/eh_limits.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index d0f98081d702..dad57f1f6ee8 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -26,6 +26,8 @@ TEST_PROGS := \
 	cmsg_time.sh \
 	double_udp_encap.sh \
 	drop_monitor_tests.sh \
+	eh_limits.py \
+	eh_limits.sh \
 	ext_hdr.py \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
diff --git a/tools/testing/selftests/net/eh_limits.py b/tools/testing/selftests/net/eh_limits.py
new file mode 100755
index 000000000000..46a460b9149e
--- /dev/null
+++ b/tools/testing/selftests/net/eh_limits.py
@@ -0,0 +1,349 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+
+# Test of extension header limits
+
+import getopt
+import struct
+import sys
+import socket
+import scapy.all
+import proto_nums
+import ext_hdr
+
+# Constants
+
+VERBOSE = False
+SOURCE_MAC = "00:11:22:33:44:55"
+DESTINATION_MAC = "AA:BB:CC:DD:EE:FF"
+SOURCE_IP = "2001:db8::7"
+DESTINATION_IP = "2001:db8::8"
+PACKET_LIST = []
+PCAP_OUT=""
+GLOB_IDENT = 1111
+ETHER_FRAME = scapy.all.Raw()
+WITH_ETH = False
+
+# Parse command line options
+def cli_args():
+    global VERBOSE, SOURCE_MAC, DESTINATION_MAC, SOURCE_IP
+    global DESTINATION_IP, PCAP_OUT
+
+    args = sys.argv[1:]
+
+    try:
+        opts, args = getopt.getopt(args, "vw:",
+                        ["verbose", "src_eth=", "dst_eth", "src_ip=",
+                         "dst_ip=", "pcap_out="])
+    except getopt.GetoptError as err:
+        # Print error message and exit
+        print(err)
+        sys.exit(2)
+
+    for opt, arg in opts:
+        if opt in ("-v", "--verbose"):
+            VERBOSE = True
+        elif opt in ("--src_eth"):
+            SOURCE_MAC = arg
+        elif opt in ("--dst_eth"):
+            DESTINATION_MAC = arg
+        elif opt in ("--src_ip"):
+            SOURCE_IP = arg
+        elif opt in ("--dst_ip"):
+            DESTINATION_IP = arg
+        elif opt in ("-w", "--pcap_out"):
+            PCAP_OUT = arg
+
+# Make an ICMP echo request packet with the requested Extension Header chain
+def make_packet(text_name, eh_list):
+    global GLOB_IDENT
+
+    hdr = scapy.all.Raw()
+    plen = 0
+
+    hdr = scapy.all.ICMPv6EchoRequest(id=GLOB_IDENT)/hdr
+    plen += 8
+
+    pair = ext_hdr.make_eh_chain(
+            proto_nums.IP_Proto.IP_PROTO_IPv6_ICMP.value, eh_list)
+    hdr = pair[0]/hdr
+    plen += pair[1]
+
+    ipv6_pkt = scapy.all.IPv6(src=SOURCE_IP, dst=DESTINATION_IP,
+                              nh=pair[2], plen=plen)
+    hdr = ipv6_pkt / hdr
+    plen += 40
+
+    if WITH_ETH:
+        hdr = ETHER_FRAME/hdr
+        plen += 14
+
+    PACKET_LIST.append((hdr, plen, GLOB_IDENT, pair[3], text_name))
+    GLOB_IDENT += 1
+
+# Write a pacp file with all the created packets
+def write_pcap(pcap_out):
+    global ETHER_FRAME, WITH_ETH
+
+    ETHER_FRAME = scapy.all.Ether(src=SOURCE_MAC, dst=DESTINATION_MAC,
+                                  type=0x86DD)
+    WITH_ETH = True
+
+    packets=[]
+    for packet in PACKET_LIST:
+        packets.append(packet[0])
+
+    scapy.all.wrpcap(pcap_out, packets)
+
+def process_return(recvd_it, packet):
+    if VERBOSE:
+        if recvd_it:
+            if packet[3]:
+                print(f"TEST: {packet[4]}: Received as expected")
+            else:
+                print(f"TEST: {packet[4]}: Unexpected receive")
+        else:
+            if packet[3]:
+                print(f"TEST: {packet[4]}: Didn't receive, "
+                      "but receive expected")
+            else:
+                print(f"TEST: {packet[4]}: Didn't receive as expected")
+
+    if (recvd_it and packet[3] is not True):
+        # We got a reply but weren't expecting one
+        print(f"FAIL: Receive was unexpected for {packet[4]}")
+        return False
+
+    if (not recvd_it and packet[3]):
+        # We didn't get a reply but weret expecting one
+        print(f"FAIL: Expected to receive for {packet[4]}")
+        return False
+
+    return True
+
+# Run ping test
+def run_test():
+    # Open raw ICMP socket
+    try:
+        sock = socket.socket(socket.AF_INET6, socket.SOCK_RAW,
+                  socket.IPPROTO_ICMPV6)
+    except PermissionError:
+        print("This script requires root privileges.")
+        return 2
+
+    # Bind to interface by its IP address
+    sock.bind((SOURCE_IP, 0))
+
+    # Run through each packet
+    for packet in PACKET_LIST:
+        # Send packet
+        scapy.all.send(packet[0], verbose=False)
+
+        sock.settimeout(0.100)
+        recvd_it = False
+
+        # Try to get ICMP echo reply
+        try:
+            while not recvd_it:
+                rpacket, _addr = sock.recvfrom(1024)
+                icmp_type = rpacket[0]
+                identifier = struct.unpack(">H", rpacket[4:6])
+                if (icmp_type ==
+                    proto_nums.ICMP6_Type.ICMPV6_ECHO_REPLY.value and
+                    identifier[0] == packet[2]):
+                    recvd_it = True
+
+        except socket.timeout:
+            pass
+
+        process_return(recvd_it, packet)
+
+    return 0
+
+# Make packets for various test cases
+def make_test_packets():
+    # Two non-padding options in HBH and DestOpt, should succeed
+    # with default sysctls
+    make_packet("Two non-padding options in HBH and DestOpts",
+        [
+            ("H", [(11, 4), (0, 0), (0, 0), (12, 3)]),
+            ("D", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+            ("D", [(1, 4), (12, 3)]),
+        ])
+
+    # Big destination option, should fail when
+    # net.ipv6.max_dst_opts_length equals 64
+    make_packet("Big destination option",
+        [
+            ("H", [(11, 4), (0, 0), (0, 0), (12, 3)]),
+            ("D", [(1, 4), (12, 255)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+        ])
+
+    # Almost Big HBH option should succeed when
+    # net.ipv6.max_hbh_length equals 64
+    make_packet("Almost Big HBH option",
+        [
+            ("H", [(11, 53), (1, 0), (12, 3)]),
+            ("D", [(1, 4), (12, 1)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+        ])
+
+    # Big Hop-by-Hop option, should fail when
+    # net.ipv6.max_hbh_length equals 64
+    make_packet("Big HBH option",
+        [
+            ("H", [(11, 53), (1, 0), (0, 0), (12, 3)]),
+            ("D", [(1, 4), (12, 1)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+        ])
+
+    # Too much HBH padding, should always fail
+    make_packet("Too much HBH padding",
+        [
+            ("H", [(12, 3), (1, 8)]),
+            ("D", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+            ("D", [(1, 4), (12, 3)]),
+        ])
+
+    # Too much DestOpt padding, should always fail
+    make_packet("Too much DestOpt padding",
+        [
+            ("H", [(12, 3), (1, 8)]),
+            ("D", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+            ("D", [(1, 4), (12, 3), (0, 0), (1, 6), (0, 0), (12, 3)]),
+        ])
+
+    # Too much DestOpt padding, should always fail
+    make_packet("Too much DestOpt padding #2",
+        [
+            ("H", [(12, 3)]),
+            ("D", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+            ("D", [(1, 4), (12, 3), (0, 0), (0, 0), (0, 0), (0, 0),
+                   (0, 0), (0, 0), (0, 0), (0, 0), (12, 3)]),
+        ])
+
+    # Too much DestOpt padding, should always fail
+
+    make_packet("Too much DestOpt padding #3",
+        [
+            ("D", [(0, 0), (0, 0), (0, 0), (0, 0),
+                   (0, 0), (0, 0), (0, 0), (0, 0)]),
+        ])
+
+    # Almost too much DestOpt padding, should succeed with default
+    # sysctl settings
+    make_packet("Almost too much DestOpt padding #2",
+        [
+            ("H", [(12, 3)]),
+            ("D", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("F", (0x89abcdef)),
+            ("D", [(1, 4), (12, 3), (0, 0), (0, 0), (0, 0), (0, 0),
+                   (0, 0), (0, 0), (0, 0), (12, 3)]),
+        ])
+
+    # Two Dest Ops, should fail unless net.ipv6.enforce_ext_hdr_order
+    # equals 1
+    make_packet("Two Dest Ops",
+        [
+            ("D", []),
+            ("D", []),
+        ])
+
+    # OOO Routing headers, should fail unless
+    # net.ipv6.enforce_ext_hdr_order equals 1
+    make_packet("OOO Routing header",
+        [
+            ("F", (0x89abcdef)),
+            ("R", [ "888::1", "9999::1"]),
+        ])
+
+    # Two Routing headers, should fail unless
+    # net.ipv6.enforce_ext_hdr_order equals 1
+    make_packet("Two Routing headers",
+        [
+            ("R", [ "888::1", "9999::1"]),
+            ("R", [ "888::1", "9999::1"]),
+        ])
+
+    # Two DestOpt headers with Routing header should succeed with default
+    # sysctl settings
+    make_packet("Two Destination options okay",
+        [
+            ("D", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3)]),
+        ])
+
+    # Two DestOpt headers without Routing header should fail unless
+    # net.ipv6.enforce_ext_hdr_order equals 1
+    make_packet("Two Destination options",
+        [
+            ("D", [(1, 4), (12, 3)]),
+            ("D", [(1, 4), (12, 3)]),
+        ])
+
+    # Two DestOpt headers after Routing header, should fail unless
+    # net.ipv6.enforce_ext_hdr_order equals 1
+    make_packet("Two Destination options after RH",
+        [
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3)]),
+            ("D", [(1, 4), (12, 3)]),
+        ])
+
+    # Many extension headers, should fail unless
+    # net.ipv6.enforce_ext_hdr_order equals 1
+    make_packet("Many EH OOO",
+        [
+            ("H", [(1, 4), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3)]),
+            ("D", [(1, 4), (12, 3), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3)]),
+            ("F", (0x89abcdef)),
+            ("D", [(1, 4), (12, 3), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3), (12, 3)]),
+            ("R", [ "888::1", "9999::1"]),
+            ("R", [ "888::1", "9999::1"]),
+            ("D", [(1, 4), (12, 3), (12, 3)]),
+        ])
+
+    # Two fragment headers, should always fail due to stack
+    # implementation
+    make_packet("Two fragment Headers",
+        [
+            ("F", (0x89abcdef)),
+            ("F", (0x89abcdef)),
+        ])
+
+cli_args()
+
+make_test_packets()
+
+if PCAP_OUT != "":
+    write_pcap(PCAP_OUT)
+    STATUS = 0
+else:
+    STATUS = run_test()
+
+sys.exit(STATUS)
diff --git a/tools/testing/selftests/net/eh_limits.sh b/tools/testing/selftests/net/eh_limits.sh
new file mode 100755
index 000000000000..ad87b0062e56
--- /dev/null
+++ b/tools/testing/selftests/net/eh_limits.sh
@@ -0,0 +1,210 @@
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
+	if [ "${rc}" -eq "${expected}" ]; then
+		printf "    TEST: %-60s  [ OK ]\n" "${msg}"
+		nsuccess=$((nsuccess+1))
+	else
+		nfail=$((nfail+1))
+		printf "    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+		echo
+			echo "hit enter to continue, 'q' to quit"
+			read -r a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+
+	if [ "${PAUSE}" = "yes" ]; then
+		echo
+		echo "hit enter to continue, 'q' to quit"
+		read -r a
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
+	# Note that we can't double quote $ip_addrs below to prevent globbing.
+	# This is not an issues since ip_addrs is always set. Similarly, don't
+	# double quote $VERBOSE in the exec commands, if it's empty then that's
+	# okay
+
+	if [ "$VERBOSE" = "-v" ]; then
+		echo ">>>>> Default"
+	fi
+
+	# Run the test with default sysctl settings
+	$NS_EXEC "$ns1" python3 ./eh_limits.py $VERBOSE $ip_addrs
+	$NS_EXEC "$ns1" python3 ./eh_limits.py $ip_addrs
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
+require_command scapy
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
+# make sure we don't pause twice
+[ "${PAUSE}" = "yes" ] && PAUSE_ON_FAIL=no
+
+ksft_skip=4
+
+if [ "$(id -u)" -ne 0 ];then
+	echo "SKIP: Need root privileges"
+	exit "$ksft_skip"
+fi
+
+if [ ! -x "$(command -v ip)" ]; then
+	echo "SKIP: Could not run test without ip tool"
+	exit "$ksft_skip"
+fi
+
+if [ ! -x "$(command -v socat)" ]; then
+	echo "SKIP: Could not run test without socat tool"
+	exit "$ksft_skip"
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


