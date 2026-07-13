Return-Path: <netdev+bounces-307148-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id +GjiARveVGpWgAAAu9opvQ
	(envelope-from <netdev+bounces-307148-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:46:19 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 68C1074B105
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 14:46:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-307148-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-307148-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34591301C97C
	for <lists+netdev@lfdr.de>; Mon, 13 Jul 2026 12:46:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4132440BCD2;
	Mon, 13 Jul 2026 12:46:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from eidolon.nox.tf (eidolon.nox.tf [185.142.180.128])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A24C940E8CA
	for <netdev@vger.kernel.org>; Mon, 13 Jul 2026 12:46:00 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783946764; cv=none; b=WIIWn05CcIjALIBGDkU7AsihiXRCeTuyCPIes/+fXGSJ9u+fvujabKyqF1m5hJ4eDzRux8ugjkEBskN3EtZfFOWml/ya+V9tP8WLbe0UbUhd2WXvYptUhQF3GWLcH2Gk839YkuHrZsh4k3uLeQLgbSk5kDkx4r+BdBzPMvPQsPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783946764; c=relaxed/simple;
	bh=lZqqaFw2bG/+bpGh5kDbcjzKXxKX21qxXTXIO2HKPuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DUWxNXaj6Zee+NZU8x/bST19x96d6YIAg0tIOlfMpHOPTZYd/dxh6Pl+qmZ69Np8jhCijWAcVLWJ5IZpGtsAGFYBiYzxSi8WyAWxoyrRWsL5Bne2HorWIv7pft4L25dy4tJCZjIgs1dmUNGCuy8QBLmkRKu+4kfOAESpO0l1cUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=diac24.net; spf=pass smtp.mailfrom=diac24.net; arc=none smtp.client-ip=185.142.180.128
Received: from [2a07:2ec0:2185:8e:f1c9:c246:22b4:8471] (helo=alea)
	by eidolon.nox.tf with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.98.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2n-00000001VV7-11Nj;
	Mon, 13 Jul 2026 14:45:57 +0200
Received: from equinox by alea with local (Exim 4.99.2)
	(envelope-from <equinox@diac24.net>)
	id 1wjG2m-00000001wVC-1Y9t;
	Mon, 13 Jul 2026 14:45:56 +0200
From: David 'equinox' Lamparter <equinox@diac24.net>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David 'equinox' Lamparter <equinox@diac24.net>
Subject: [RFC PATCH net-next 2/2] selftests/net: selftest for AF_LLC jumbo frames
Date: Mon, 13 Jul 2026 14:43:39 +0200
Message-ID: <20260713124545.462790-3-equinox@diac24.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713124545.462790-1-equinox@diac24.net>
References: <20260713124545.462790-1-equinox@diac24.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.04 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-307148-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[diac24.net];
	FORGED_SENDER(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:equinox@diac24.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[equinox@diac24.net,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_FIVE(0.00)[5];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[7];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,diac24.net:from_mime,diac24.net:email,diac24.net:mid,vger.kernel.org:from_smtp,lib.py:url,llc_jumbo.py:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 68C1074B105

This selftest just checks that AF_LLC correctly in- & output frames
below and above the jumbo frame threshold (1500 bytes).  It more or less
also doubles as basic AF_LLC test.

Unfortunately AF_LLC can't be used in a netns, so this test must run as
root in the initial netns.

Signed-off-by: David 'equinox' Lamparter <equinox@diac24.net>
---
 MAINTAINERS                              |   1 +
 tools/testing/selftests/net/Makefile     |   1 +
 tools/testing/selftests/net/llc_jumbo.py | 337 +++++++++++++++++++++++
 3 files changed, 339 insertions(+)
 create mode 100644 tools/testing/selftests/net/llc_jumbo.py

diff --git a/MAINTAINERS b/MAINTAINERS
index f3218abefd0c..8ca5afa39734 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -15057,6 +15057,7 @@ F:	include/linux/llc.h
 F:	include/net/llc*
 F:	include/uapi/linux/llc.h
 F:	net/llc/
+F:	tools/testing/selftests/net/llc_jumbo.py
 
 LM73 HARDWARE MONITOR DRIVER
 M:	Guillaume Ligneul <guillaume.ligneul@gmail.com>
diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 708d960ae07d..4b3d5491909b 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -57,6 +57,7 @@ TEST_PROGS := \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
 	link_netns.py \
+	llc_jumbo.py \
 	lwt_dst_cache_ref_loop.sh \
 	macvlan_mcast_shared_mac.sh \
 	msg_zerocopy.sh \
diff --git a/tools/testing/selftests/net/llc_jumbo.py b/tools/testing/selftests/net/llc_jumbo.py
new file mode 100644
index 000000000000..51c23ea6f812
--- /dev/null
+++ b/tools/testing/selftests/net/llc_jumbo.py
@@ -0,0 +1,337 @@
+#!/usr/bin/env python3
+# SPDX-License-Identifier: GPL-2.0
+"""
+Copyright (C) 2026 David 'equinox' Lamparter
+
+Linux kernel self-test for AF_LLC sockets, specifically jumbo frame (802.1AC)
+support.
+"""
+
+from __future__ import annotations
+
+import os
+import signal
+import struct
+import binascii
+import functools
+import errno
+import ctypes
+from typing import Callable
+
+from socket import socket, htons, SOCK_DGRAM, SOCK_RAW, AF_PACKET, ETH_P_ALL
+
+from lib.py import ksft_run, ksft_exit, ksft_eq, KsftSkipEx
+from lib.py import ip
+
+# from lib.py import NetNS, NetNSEnter
+
+
+ETH_P_8021AC = 0x8870
+AF_LLC = 26
+
+
+class ContextSkip:
+    """
+    convert exception from context manager into KsftSkipEx with message
+    """
+
+    def __init__(self, ctx, message):
+        self._ctx = ctx
+        self._message = message
+
+    def __enter__(self):
+        try:
+            return self._ctx.__enter__()
+        except Exception as e:
+            raise KsftSkipEx(self._message + "[" + repr(e) + "]") from e
+
+    def __exit__(self, exc_type, exc_value, traceback):
+        self._ctx.__exit__(exc_type, exc_value, traceback)
+
+
+# Python's socket.bind() has no clue about AF_LLC
+c_macaddr = ctypes.c_ubyte * 6
+
+
+class sockaddr_llc(ctypes.Structure):
+    _fields_ = [
+        ("sllc_family", ctypes.c_ushort),
+        ("sllc_arphrd", ctypes.c_ushort),
+        ("sllc_test", ctypes.c_ubyte),
+        ("sllc_xid", ctypes.c_ubyte),
+        ("sllc_ua", ctypes.c_ubyte),
+        ("sllc_sap", ctypes.c_ubyte),
+        ("sllc_mac", c_macaddr),
+        ("pad", ctypes.c_ubyte * 2),
+    ]
+
+    @classmethod
+    def make(
+        cls,
+        sllc_family=AF_LLC,
+        sllc_arphrd=0,
+        sllc_test=0,
+        sllc_xid=0,
+        sllc_ua=0,
+        sllc_sap=0,
+        sllc_mac: None | str | bytes = None,
+    ) -> sockaddr_llc:
+        if sllc_mac is None:
+            _sllc_mac = c_macaddr(0, 0, 0, 0, 0, 0)
+        elif isinstance(sllc_mac, str):
+            _sllc_mac = c_macaddr(*(int(b, 16) for b in sllc_mac.split(":")))
+        else:
+            _sllc_mac = c_macaddr(*(b for b in sllc_mac))
+        return cls(
+            sllc_family, sllc_arphrd, sllc_test, sllc_xid, sllc_ua, sllc_sap, _sllc_mac
+        )
+
+
+assert len(bytes(sockaddr_llc())) == 16
+
+
+libc = ctypes.CDLL(None, use_errno=True)
+libc.bind.argtypes = (ctypes.c_int, ctypes.POINTER(sockaddr_llc), ctypes.c_int)
+libc.bind.restype = ctypes.c_int
+libc.sendto.argtypes = (
+    ctypes.c_int,
+    ctypes.c_voidp,
+    ctypes.c_size_t,
+    ctypes.c_int,
+    ctypes.POINTER(sockaddr_llc),
+    ctypes.c_int,
+)
+libc.sendto.restype = ctypes.c_int
+
+
+def llc_bind(fd: socket, addr: sockaddr_llc) -> None:
+    ret = libc.bind(fd.fileno(), addr, len(bytes(addr)))
+    if ret:
+        err = ctypes.get_errno()
+        raise OSError(err, errno.errorcode.get(err, str(err)))
+
+
+def llc_sendto(fd: socket, addr: sockaddr_llc, data: bytes, flags=0) -> None:
+    ret = libc.sendto(fd.fileno(), data, len(data), flags, addr, len(bytes(addr)))
+    if ret < 0:
+        err = ctypes.get_errno()
+        raise OSError(err, errno.errorcode.get(err, str(err)))
+    return ret
+
+
+def wrap_common_setup(testfn: Callable[[socket, socket], None]) -> Callable[[], None]:
+    """
+    common setup for all LLC tests
+
+    (create netns, create AF_LLC + AF_PACKET sockets)
+    """
+
+    def inner1() -> None:
+        if os.path.exists("/sys/class/net/testveth0"):
+            raise KsftSkipEx("already have a testveth0 netdev")
+        if os.path.exists("/sys/class/net/testveth1"):
+            raise KsftSkipEx("already have a testveth1 netdev")
+
+        ip(
+            "link add name testveth0 address 02:00:00:00:00:00 "
+            + "type veth peer name testveth1 address 02:11:11:11:11:11"
+        )
+        with open(
+            "/proc/sys/net/ipv6/conf/testveth0/disable_ipv6", "w", encoding="ASCII"
+        ) as fd:
+            fd.write("1\n")
+        with open(
+            "/proc/sys/net/ipv6/conf/testveth1/disable_ipv6", "w", encoding="ASCII"
+        ) as fd:
+            fd.write("1\n")
+        ip("link set testveth0 mtu 9000 up")
+        ip("link set testveth1 mtu 9000 up")
+
+        try:
+            with ContextSkip(
+                socket(AF_LLC, SOCK_DGRAM, 0), "AF_LLC not enabled in kernel?"
+            ) as sock0_llc:
+                llc_bind(
+                    sock0_llc,
+                    sockaddr_llc.make(sllc_sap=0xFE, sllc_mac="02:00:00:00:00:00"),
+                )
+
+                with ContextSkip(
+                    socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)),
+                    "AF_PACKET not enabled in kernel?",
+                ) as sock1_pkt:
+                    sock1_pkt.bind(("testveth1", ETH_P_ALL))
+
+                    signal.alarm(10)
+                    testfn(sock0_llc, sock1_pkt)
+
+        finally:
+            signal.alarm(0)
+            ip("link del testveth0")
+
+    @functools.wraps(testfn)
+    def inner() -> None:
+        if os.getuid() == 0:
+            inner1()
+        else:
+            raise KsftSkipEx(
+                "this test requires root since AF_LLC has no netns support (yet?)"
+            )
+            # with NetNS() as ns1:
+            #    with NetNSEnter(str(ns1)):
+            #        inner1()
+
+    return inner
+
+
+def pkt_check(fd: socket, expectlen: int, data: None | bytes = None):
+    # ignore non-LLC packets
+    # (since we can't run in netns, random junk may show up)
+    proto_len = -1
+    while not (0 <= proto_len < 1536 or proto_len == 0x8870):
+        pkt = fd.recv(4096)
+        proto_len = struct.unpack(">H", pkt[12:14])[0]
+
+    assert binascii.b2a_hex(pkt[0:6]) == b"021111111111"
+    assert binascii.b2a_hex(pkt[6:12]) == b"020000000000"
+
+    if expectlen <= 1497:
+        ksft_eq(proto_len, expectlen + 3)
+    else:
+        ksft_eq(proto_len, ETH_P_8021AC, "802.1AC ethertype (0x8870)")
+
+    if data is None:
+        data = b"\00" * expectlen
+    else:
+        data = (data + b"\00" * expectlen)[:expectlen]
+
+    ksft_eq(binascii.b2a_hex(pkt[14:17]).decode("ASCII").upper(), "FEFE03")
+    ksft_eq(pkt[17:], data)
+
+
+def test_llc_tx(sock0_llc: socket, sock1_pkt: socket) -> None:
+    llc_sendto(
+        sock0_llc,
+        sockaddr_llc.make(sllc_sap=0xFE, sllc_mac="02:11:11:11:11:11"),
+        b"\x00" * 1400,
+    )
+    pkt_check(sock1_pkt, 1400)
+
+    llc_sendto(
+        sock0_llc,
+        sockaddr_llc.make(sllc_sap=0xFE, sllc_mac="02:11:11:11:11:11"),
+        b"\x00" * 1497,
+    )
+    pkt_check(sock1_pkt, 1497)
+
+
+def test_llc_tx_jumbo(sock0_llc: socket, sock1_pkt: socket) -> None:
+    llc_sendto(
+        sock0_llc,
+        sockaddr_llc.make(sllc_sap=0xFE, sllc_mac="02:11:11:11:11:11"),
+        b"\x00" * 1498,
+    )
+    pkt_check(sock1_pkt, 1498)
+
+    llc_sendto(
+        sock0_llc,
+        sockaddr_llc.make(sllc_sap=0xFE, sllc_mac="02:11:11:11:11:11"),
+        b"\x00" * 4000,
+    )
+    pkt_check(sock1_pkt, 4000)
+
+
+machdr = binascii.a2b_hex("020000000000" + "021111111111")
+
+
+def test_llc_rx(sock0_llc: socket, sock1_pkt: socket) -> None:
+    sock1_pkt.send(
+        machdr + struct.pack(">H", 1403) + binascii.a2b_hex("FEFE03") + b"\x00" * 1400
+    )
+    rxdata = sock0_llc.recv(4096)
+    ksft_eq(len(rxdata), 1400)
+    ksft_eq(rxdata, b"\x00" * 1400)
+
+    sock1_pkt.send(
+        machdr + struct.pack(">H", 1500) + binascii.a2b_hex("FEFE03") + b"\x00" * 1497
+    )
+    rxdata = sock0_llc.recv(4096)
+    ksft_eq(len(rxdata), 1497)
+    ksft_eq(rxdata, b"\x00" * 1497)
+
+
+def test_llc_rx_jumbo(sock0_llc: socket, sock1_pkt: socket) -> None:
+    sock1_pkt.send(
+        machdr
+        + struct.pack(">H", ETH_P_8021AC)
+        + binascii.a2b_hex("FEFE03")
+        + b"\x00" * 1498
+    )
+    rxdata = sock0_llc.recv(4096)
+    ksft_eq(len(rxdata), 1498)
+    ksft_eq(rxdata, b"\x00" * 1498)
+
+    sock1_pkt.send(
+        machdr
+        + struct.pack(">H", ETH_P_8021AC)
+        + binascii.a2b_hex("FEFE03")
+        + b"\x00" * 4000
+    )
+    rxdata = sock0_llc.recv(4096)
+    ksft_eq(len(rxdata), 4000)
+    ksft_eq(rxdata, b"\x00" * 4000)
+
+
+def test_llc_rx_reject_smuggling(sock0_llc: socket, sock1_pkt: socket) -> None:
+    """
+    make sure smaller packets can't be smuggled in using 0x8870 ethertype
+    """
+    # these tests use a 2nd packet to check first one was dropped, relying on ordering
+
+    sock1_pkt.send(
+        machdr
+        + struct.pack(">H", ETH_P_8021AC)
+        + binascii.a2b_hex("FEFE03")
+        + b"\x00" * 1497
+    )
+    sock1_pkt.send(
+        machdr + struct.pack(">H", 131) + binascii.a2b_hex("FEFE03") + b"\x00" * 128
+    )
+    rxdata = sock0_llc.recv(4096)
+    ksft_eq(len(rxdata), 128)
+    ksft_eq(rxdata, b"\x00" * 128)
+
+    sock1_pkt.send(
+        machdr
+        + struct.pack(">H", ETH_P_8021AC)
+        + binascii.a2b_hex("FEFE03")
+        + b"\x00" * 250
+    )
+    sock1_pkt.send(
+        machdr + struct.pack(">H", 131) + binascii.a2b_hex("FEFE03") + b"\x00" * 128
+    )
+    rxdata = sock0_llc.recv(4096)
+    ksft_eq(len(rxdata), 128)
+    ksft_eq(rxdata, b"\x00" * 128)
+
+
+def main() -> None:
+    ksft_run(
+        [
+            wrap_common_setup(test_llc_tx),
+            wrap_common_setup(test_llc_tx_jumbo),
+            wrap_common_setup(test_llc_rx),
+            wrap_common_setup(test_llc_rx_jumbo),
+            wrap_common_setup(test_llc_rx_reject_smuggling),
+        ]
+    )
+    ksft_exit()
+
+
+def sigalrm(sig, frame):
+    raise TimeoutError("SIGALRM")
+
+
+if __name__ == "__main__":
+    signal.signal(signal.SIGALRM, sigalrm)
+    main()
-- 
2.53.0


