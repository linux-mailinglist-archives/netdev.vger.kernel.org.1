Return-Path: <netdev+bounces-269495-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WPuMGj8UvGnbrwIAu9opvQ
	(envelope-from <netdev+bounces-269495-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:20:31 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C5212CD999
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 16:20:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9309430603D5
	for <lists+netdev@lfdr.de>; Thu, 19 Mar 2026 15:14:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E403E1CFB;
	Thu, 19 Mar 2026 15:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b="eXj+SHQW"
X-Original-To: netdev@vger.kernel.org
Received: from mout-b-203.mailbox.org (mout-b-203.mailbox.org [195.10.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FE7B3A7581;
	Thu, 19 Mar 2026 15:14:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.10.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773933257; cv=none; b=jz4uxL0sRo0LSK/SDhhKTilPzdcXjI0vfAMzSZ5DgJze/RQeOksCbY851yIAxaQixgn959L0aU/pbbHtHqJHn2h1VTjb2iZkmtdQL2igEXSfOiunjixmhBoCG5YUp5nWMirmL57uti8HtE3Z6qs8itQhY5Ajzm6YaZ4r8nsxWi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773933257; c=relaxed/simple;
	bh=n8R0lxQXS/WRXKTyJKSYL9wuO+24uiQFtgi6nZnJAK0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i4UyGRsm6kyNRxUsKAKKHYj7PcCbaXtWpTnsh+LoEejLIJOwLvNxWyQApDjFC/F57ZKKbJ7coRRMaA5bfEUP9haIfF2zrfoMSPi1XztrDm3bMNlSwe7rK4bFYcuIo3VHraz2VaSN5m39B4IrO81CSA5VcExB3i3hTcb2TIi7ODY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com; spf=pass smtp.mailfrom=mandelbit.com; dkim=pass (2048-bit key) header.d=mandelbit.com header.i=@mandelbit.com header.b=eXj+SHQW; arc=none smtp.client-ip=195.10.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mandelbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mandelbit.com
Received: from smtp102.mailbox.org (smtp102.mailbox.org [10.196.197.102])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-b-203.mailbox.org (Postfix) with ESMTPS id 4fc8P035MVz9xDr;
	Thu, 19 Mar 2026 16:14:12 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mandelbit.com;
	s=MBO0001; t=1773933252;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=S7WhGtrDIV2TD9WUU8l0miYi1zOi2sYafJlFAbioGLo=;
	b=eXj+SHQWkzay4JN2jAsFgEcsoQ6qBvwrc+fMFsOvi57VNcHgsLtzEwkW4S/hlQr/p1E8so
	b0GYT8qyij5Xyb4/XwU54hkh/SHYay95u+LvQ+z2kUFx5tGX2fS333VM6VSjJ80YEzxITE
	iYE8No1V8Aplil1Fs80lxtFGa0FL2mNbj8TkRMJqC6/HIo+6Yj9RhjTxzAllFOFLAD+jXe
	nEegOeRm3LLn7XNtTeDWzSw/CIzl/3/vZ8OHR2h7XgvQowXhe3rxtV5mk40z1QEMCTKBp5
	j/cuBk8EArFEx7/U5hZTR1qyE3WDCm37rB9mRo2q7Zh/vCTZduCJMjGMSo/nbw==
From: Ralf Lici <ralf@mandelbit.com>
To: netdev@vger.kernel.org
Cc: =?UTF-8?q?Daniel=20Gr=C3=B6ber?= <dxld@darkboxed.org>,
	Antonio Quartulli <antonio@mandelbit.com>,
	Ralf Lici <ralf@mandelbit.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Shuah Khan <skhan@linuxfoundation.org>,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC net-next 15/15] Documentation: networking: add ipxlat translator guide
Date: Thu, 19 Mar 2026 16:12:24 +0100
Message-ID: <20260319151230.655687-16-ralf@mandelbit.com>
In-Reply-To: <20260319151230.655687-1-ralf@mandelbit.com>
References: <20260319151230.655687-1-ralf@mandelbit.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[mandelbit.com:s=MBO0001];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[mandelbit.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269495-lists,netdev=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ralf@mandelbit.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[mandelbit.com:+];
	NEURAL_HAM(-0.00)[-0.995];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,darkboxed.org:email,mandelbit.com:dkim,mandelbit.com:email,mandelbit.com:mid]
X-Rspamd-Queue-Id: 7C5212CD999
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Daniel Gröber <dxld@darkboxed.org>

Add user and reviewer documentation for the ipxlat virtual netdevice in
Documentation/networking/ipxlat.rst.

The document describes the datapath model, stateless IPv4/IPv6 address
translation rules, ICMP handling, control-plane configuration, and test
topology assumptions. It also records the intended runtime configuration
contract and current behavior limits so deployment expectations are
clear.

Signed-off-by: Daniel Gröber <dxld@darkboxed.org>
Signed-off-by: Ralf Lici <ralf@mandelbit.com>
---
 Documentation/networking/ipxlat.rst | 190 ++++++++++++++++++++++++++++
 1 file changed, 190 insertions(+)
 create mode 100644 Documentation/networking/ipxlat.rst

diff --git a/Documentation/networking/ipxlat.rst b/Documentation/networking/ipxlat.rst
new file mode 100644
index 000000000000..5a0ad02c05be
--- /dev/null
+++ b/Documentation/networking/ipxlat.rst
@@ -0,0 +1,190 @@
+.. SPDX-License-Identifier: GPL-2.0+
+.. Copyright (C) 2026 Daniel Gröber <dxld@debian.org>
+
+==============================================
+IPXLAT - IPv6<>IPv4 IP/ICMP Translation (SIIT)
+==============================================
+
+ipxlat (``CONFIG_IPXLAT=y``) provides a virtual netdevice implementing
+stateless IP packet translation between IP versions 6 and 4. This is a
+building block for establishing layer 3 connectivity between otherwise
+uncommunicative IPv6-only and/or IPv4-only networks.
+
+
+Creation and Configuration Parameters
+=====================================
+
+An ipxlat netdevice can be created and configured using YNL like so::
+
+    $ ip link add siit0 type ipxlat
+
+    $ IID=$(cat /sys/class/net/siit0/ifindex)
+
+    $ ADDR_HEX=$(python3 -c 'import ipaddress,sys; \
+        print(ipaddress.IPv6Address(sys.argv[1]).packed.hex())' \
+        64:ff9b:: | tee /dev/stderr)
+    0064ff9b000000000000000000000000
+
+    $ ./tools/net/ynl/pyynl/cli.py --family ipxlat --json '{"ifindex": $IID, \
+        "config": {"xlat-prefix6": "'$HEX_ADDR'", "prefix-len": 96} }'
+
+(TODO: Once implemented) A ipxlat netdevice can be configured using
+iproute2::
+
+    $ ip link add siit0 type ipxlat [ OPTIONS ]
+
+    # where OPTIONS can include (TODO: iproute2 patch):
+    #
+    #   prefix ADDR          (default 64:ff9b::/96)
+    #
+    #   lowest-ipv6-mtu MTU  (default 1280)
+
+
+Introduction to Packet-level IPv6<>IPv4 Translation
+===================================================
+
+Translatable packets delivered into an ipxlat device as either of the IP
+protocol versions loop-back as the other. Untranslatable packets are
+rejected with ICMP errors of the same IP version as appropriate or dropped
+silently if required by RFC-SIIT_.
+
+.. _RFC-SIIT: https://datatracker.ietf.org/doc/html/rfc7915
+
+Supported upper layer protocols (TCP/UDP/ICMP) have their checksums
+recomputed as-needed as part of translation. Unsupported IP protocols
+(IPPROTO\_*) are passed through unmodified. This will make them fail at the
+receiver except in special cases.
+
+Differences in IP layer semantic concerns are handled using several
+different strategies, here we'll only give a high-level summary in the
+areas of most friction:
+  Fragmentation approach, Path MTU Discovery (PMTUD), IP Options and Extension
+  Headers.
+
+**Fragmentation Approach** (v4: on-path vs v6: end-to-end) is smoothed over by:
+ | 4->6: Fragmenting (DF=0) IPv4 packets when needed. See "lowest-ipv6-mtu".
+ | 6->4: Using on-path frag. down the line for v4 pkts smaller than 1260.
+ Details are tedious, check RFC-SIIT_.
+
+**PMTUD** is maintained by recalculating advised MTU values in ICMP
+PKT_TOO_BIG and FRAG_NEEDED messages as they're being translated. Taking
+into account the necessary header re-sizing and post-translation nexthop
+MTU in the main routing table.
+
+**IP Options and IPv6 Extension Headers** except the Fragment Header are
+dropped or ignored expept where more specific behaviour is specified in
+RFC-SIIT_.
+
+
+Address Translation
+-------------------
+
+The ipxlat address translation algorithm is stateless, per RFC-ADDR_, all
+possible IPv4 addressess are mapped one-to-one into the translation prefix,
+optionally including a non-standard "suffix". See `RFC-ADDR Section 2.2
+<https://datatracker.ietf.org/doc/html/rfc6052#section-2.2>`_.
+
+.. _RFC-ADDR: https://datatracker.ietf.org/doc/html/rfc6052
+
+IPv6 addressess outside this prefix are rejected with ICMPv6 errors with
+the notable exception of ICMPv6 errors originating from untranslatable
+source addressess. These are translated to be sourced from the IPv4 Dummy
+Address ``192.0.0.8`` (per I-D-dummy_) instead to maintain IPv4 traceroute
+visibility.
+
+.. _I-D-dummy:
+   https://datatracker.ietf.org/doc/draft-ietf-v6ops-icmpext-xlat-v6only-source/
+
+In a basic bidirectional 6<>4 connectivity scenario this means IPv6 hosts
+must be addressed wholly from inside the translation prefix and per
+RFC-ADDR_. Plain vanilla SLAAC doesn't cut it here, static addressing or
+DHCPv6 is needed, unless that is we introduce statefulnes (RFC-NAT64_) into
+the mix. See below on that.
+
+.. _RFC-NAT64: https://datatracker.ietf.org/doc/html/rfc6146
+
+
+Stateful Translation (NAT64)
+----------------------------
+
+Using NAT64 has several drawbacks, it's necessary only when your control
+over IPv4 or IPv6 addressing of hosts is limited.
+
+Using nftables we can turn a system into a stateful translator. For example
+to make the IPv4 internet reachable to a IPv6-only LAN having this system
+as it's default route, further assuming we have an IPv4 default route and
+``192.0.2.1/32`` is routed to this system::
+
+ $ ip link add siit0 type ipxlat
+ $ ip link set dev siit0 up
+ $ ip route 192.0.2.1/32 dev siit0
+ $ ip route 64:ff9b::/96 dev siit0
+ $ sysctl -w net.ipv4.conf.all.forwarding=1
+ $ sysctl -w net.ipv6.conf.all.forwarding=1
+ $ nft -f- <<EOF
+ table ip6 nat {
+         chain postrouting {
+                 type nat hook postrouting priority filter; policy accept;
+                 oifname "siit0" snat to 64:ff9b::c002:1 comment "::192.0.2.1"
+         }
+ }
+ table ip nat {
+         chain postrouting {
+                 type nat hook postrouting priority filter; policy accept;
+                 iifname "siit0" masquerade
+         }
+ }
+ EOF
+
+Note: Keep reading when replacing the 192.0.2.0/24 documentation
+placeholder with RFC 1918 "private IPv4" space.
+
+
+Translation Prefix Choice and Complications
+-------------------------------------------
+
+Several prefix sizes between /32 and /96 are supported by ipxlat. Using
+a /96 prefix is often convenient as it allows using the dotted quad IPv6
+notation, eg.: "64:ff9b::192.0.2.1". RFC-ADDR_ "3.3. Choice of Prefix for
+Stateless Translation Deployments" has more detailed recommendations.
+
+The "Well-Known Prefix" (WKP) 64:ff9b::/96, while a convenient and short
+choice for LANs, comes with some IETF baggage. As specified (at time of
+writing) addressess drawn from RFC 1918 "private IPv4" space "MUST NOT" be
+used with the WKP. While ipxlat does not enforce this other network
+elements may.
+
+If I-D-WKP-1918_ makes it through the IETF process this complication for
+the cautious network engineer may dissapear in the future.
+
+.. _I-D-WKP-1918:
+   https://datatracker.ietf.org/doc/draft-ietf-v6ops-nat64-wkp-1918/
+
+In the meantime the newer and more lax prefix allocated by RFC-LWKP_ or an
+entirely Network-Specific Prefix may be a better fit. We'd recommend using
+the checksum-neutral ``64:ff9b:1:fffe::/96`` prefix from the larger /48
+allocation.
+
+.. _RFC-LWKP: https://datatracker.ietf.org/doc/html/rfc8215
+
+
+RFC Considerations for Userspace
+--------------------------------
+
+- Per `RFC 7915
+  <https://datatracker.ietf.org/doc/html/rfc7915#section-4.5>`_,
+  ipxlat SHOULD drop UDPv4 zero checksum packets, yet we chose to always
+  recalculate checksums for unfragmented packets.
+
+  If you want your translator to follow the SHOULD add a netfilter rule
+  dropping such packets. For example using ``nft(8)`` syntax::
+
+    nft add rule filter ip postrouting -- oifkind ipxlat udp checksum 0 log drop
+
+- Per `RFC 6146
+  <https://datatracker.ietf.org/doc/html/rfc6146#section-3.4>`_,
+  Fragmented UDPv4 zero checksum recalculation by reassembly is not
+  supported.
+
+- I-D-dummy_: Adding a Node Identity Object to for IPv4-side traceroute
+  disambiguation is not yet supported.
-- 
2.53.0


