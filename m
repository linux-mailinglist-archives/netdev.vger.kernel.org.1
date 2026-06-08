Return-Path: <netdev+bounces-296558-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jfNvDdnBJmpXkAIAu9opvQ
	(envelope-from <netdev+bounces-296558-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:21:29 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C79065691E
	for <lists+netdev@lfdr.de>; Mon, 08 Jun 2026 15:21:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=QdqCy3aI;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-296558-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-296558-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B4CE03068901
	for <lists+netdev@lfdr.de>; Mon,  8 Jun 2026 13:11:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4D133803F2;
	Mon,  8 Jun 2026 13:11:19 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-wr1-f67.google.com (mail-wr1-f67.google.com [209.85.221.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2185437F00D
	for <netdev@vger.kernel.org>; Mon,  8 Jun 2026 13:11:16 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780924279; cv=none; b=sBInrTcFlG1/l43YANkJtWBhSeIR5B+SmHSVoTTgDStVC43/4qiNnTAJQTs6A9LQewMXuPo6JpT/29yTKg3COtzG7ysIdOWiaega9WK1pbA91AhyjaN4pUPjtnZXIF3KXH3SNTDZDMOFEB7oEkGBLMttEDatoSRYMEHfpAXkLLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780924279; c=relaxed/simple;
	bh=223Q5Hr97oZ5Zmq0kEPxe1iyf0cbfKzncLFicdBFWcM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZifA8RlDOa1xut9P8ZX5ktgZgeB/Ks+E/SjTUdmWxJ28WMQQ+B4xkTcBRDjoYL3J/hAvpUFoI5G/+EOLWTX8lTH/RfhypL81pceGBou50j3Ee/O4KeAVeHGzhom0LW7cKN9BLS+ThQkuxBR+xNCt1bCw9ipuwzHojHG4Eqy/MSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QdqCy3aI; arc=none smtp.client-ip=209.85.221.67
Received: by mail-wr1-f67.google.com with SMTP id ffacd0b85a97d-45ef0ccccfcso313460f8f.0
        for <netdev@vger.kernel.org>; Mon, 08 Jun 2026 06:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780924275; x=1781529075; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5h7CwNZys8rbMICJjJA560eRsQe+FNPPWO/a4fGqEw=;
        b=QdqCy3aIO9rlACxRlp5reuJYy0pyfSdOH4F7/t7y7x8t9Wu11C1P42tE4OP/T8W8Ts
         gmdDENJxmD0RTXkNzrkCeb7yoKepqMiYCyaHLA6v3IV3KCzY7JLpPOld68prTtj4MkYy
         9PBtgE0UbCnnfTqEmahRMj37IpwcC4gV8ql4j3dEWwP+99pACw4jqBRVZ9DI3mewNDBz
         kksasQmsHOxIX4T3L4iICxrKXRqEI3zeAsj7RTGzM0PbGaosx63ujy39XBDvMXgwG3ox
         0rjjLf1QDC9eiRSJvqHpNYcfYd5+PhPf5JjP3zQawgHudDY++izvHluZpbccfJrtrJrn
         mm7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780924275; x=1781529075;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=O5h7CwNZys8rbMICJjJA560eRsQe+FNPPWO/a4fGqEw=;
        b=RW0QatA+kVL6cotyPIIZlBncrseeOa/I8NrLftRr14rerZjnJTdj9Y6HHCP8iqJY8g
         95GfjdMHivD10skmw2jnDYbg7BC1KvYsSLp/fZe4rgdJQZmynfA8a62xEZ0DBr/1WKbA
         7dfeer8IOjnx0v71Q/8gZtyPDPoTPTGrjlz7FvfKSKMzNdH4+al0AK0QeIY3cam+Lj2y
         p072WzwoMl23D9SbRP96s7S+koaJN/RwHGaN3CO0p9mTqcJhi5Qm435k3qv66Gm2QKZq
         O14Nu8i2Yx8AcIYLlVWKN1PNHeebMRBshdcizPuPS1902Dg+mxPiecFeWioQKJi7G/rG
         GDow==
X-Gm-Message-State: AOJu0Yx2WGRAB7Rcm7fa3SsqP5ryi9GuF72u13Vibndr7dEJPIkPltHt
	UHYZ8W1vlopE15T95D2NKJcBsTccslc1Hsdl9egA9yQ47AyFdFY936Bo15j3W/BB
X-Gm-Gg: Acq92OHTSRAZ/eIsfuzpngPmRvoIJ5dY5Z7qlnzBaozhsHl2+gUqWBTOzdx/KNoT/QL
	xU/RXl0QrmnUwXdApVyNFMxD3mt4nKgKTlFH/x43OgK/YHbYY9UkgsOmTP2pMEErw67zFPTW5SJ
	/xDgirruVJUZeqU8XljGVXbOA7ugWY1ODxLMVfgVUFwyNFd2xFmsvFXs7dQPuaKFDRWPtrbGoM4
	eLXcEnG9d5QRav35kT+Fo9zoXUuX0ZlBOiLPdfQT74q68Aj+DAE/6Klr7vNRYJYTmmPwzLN3nHX
	GIZfkggbhvBXlgUJc3nMeU0Fsg8awmMiJJEM3ux05S1JwAR/HUsMJKcfp1Rxl8pyaZ1WfRdKIRQ
	eRUUkb0zG5bOjAeS+amRgFzRU/BLCVQdOnOwrJGEp0DbrzcrZX7XPrVh/T4gGglTpljVDLLzFKj
	GCwmg2a3AAKEuaeJ4IFRH5w5www02XDnk=
X-Received: by 2002:a05:600c:314e:b0:490:bc36:9b2b with SMTP id 5b1f17b1804b1-490c258a138mr97296285e9.2.1780924275202;
        Mon, 08 Jun 2026 06:11:15 -0700 (PDT)
Received: from localhost ([104.28.193.185])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490c2d37edbsm300135675e9.2.2026.06.08.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jun 2026 06:11:14 -0700 (PDT)
From: Mariusz Klimek <maklimek97@gmail.com>
To: netdev@vger.kernel.org
Cc: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	dsahern@kernel.org,
	idosch@nvidia.com,
	ncardwell@google.com,
	shuah@kernel.org,
	kuniyu@google.com,
	alice@isovalent.com,
	Mariusz Klimek <maklimek97@gmail.com>
Subject: [PATCH net-next 08/10] selftests/net: test sending TCP jumbograms over veth
Date: Mon,  8 Jun 2026 15:07:53 +0200
Message-ID: <20260608130755.5626-9-maklimek97@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260608130755.5626-1-maklimek97@gmail.com>
References: <20260608130755.5626-1-maklimek97@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-296558-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:andrew+netdev@lunn.ch,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:dsahern@kernel.org,m:idosch@nvidia.com,m:ncardwell@google.com,m:shuah@kernel.org,m:kuniyu@google.com,m:alice@isovalent.com,m:maklimek97@gmail.com,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FREEMAIL_FROM(0.00)[gmail.com];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_CC(0.00)[lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,nvidia.com,isovalent.com,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[maklimek97@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,jumbogram.sh:url,pfd.events:url,big_tcp.sh:url]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7C79065691E

This patch adds a selftest that tests TCP connections over large MTUs. The
test uses three network namespaces called NS_CLIENT, NS_ROUTER and
NS_SERVER. Messages are sent from NS_CLIENT to NS_SERVER through NS_ROUTER,
which are connected through veth pairs. The test verifies that the messages
are properly sent and received and that jumbograms are received if the MTUs
allow it.

The jumbogram_tx and jumbogram_rx helper programs are used to send and
receive large TCP messages. The programs are loosely based on
udpgso_bench_tx and udpgso_bench_rx.

The jumbogram.bpf.c bpf program is used to keep track of the largest packet
size received during the connection. If jumbograms are expected to be
delivered, the largest observed packet size is checked to be above the
expected size. We only check that at least one packet was a jumbogram
because packets received early in the connection may have been smaller due
to the small initial window size.

This test is loosely based on big_tcp.sh. The jumbogram.sh test is separate
from big_tcp.sh because they are technically different features, and
big_tcp.sh would require heavy modification anyway to properly test non-GSO
jumbograms.

Signed-off-by: Mariusz Klimek <maklimek97@gmail.com>
---
 tools/testing/selftests/net/Makefile        |   3 +
 tools/testing/selftests/net/jumbogram.bpf.c |  36 ++
 tools/testing/selftests/net/jumbogram.sh    | 380 ++++++++++++++++++++
 tools/testing/selftests/net/jumbogram_rx.c  | 199 ++++++++++
 tools/testing/selftests/net/jumbogram_tx.c  | 139 +++++++
 5 files changed, 757 insertions(+)
 create mode 100644 tools/testing/selftests/net/jumbogram.bpf.c
 create mode 100755 tools/testing/selftests/net/jumbogram.sh
 create mode 100644 tools/testing/selftests/net/jumbogram_rx.c
 create mode 100644 tools/testing/selftests/net/jumbogram_tx.c

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 5ca6c557fc3f..0e08ca29bcea 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -53,6 +53,7 @@ TEST_PROGS := \
 	ipv6_force_forwarding.sh \
 	ipv6_route_update_soft_lockup.sh \
 	ipvtap_test.sh \
+	jumbogram.sh \
 	l2_tos_ttl_inherit.sh \
 	l2tp.sh \
 	link_netns.py \
@@ -146,6 +147,8 @@ TEST_GEN_FILES := \
 	ipsec \
 	ipv6_flowlabel \
 	ipv6_flowlabel_mgr \
+	jumbogram_rx \
+	jumbogram_tx \
 	msg_zerocopy \
 	nettest \
 	psock_fanout \
diff --git a/tools/testing/selftests/net/jumbogram.bpf.c b/tools/testing/selftests/net/jumbogram.bpf.c
new file mode 100644
index 000000000000..2bef831bc90f
--- /dev/null
+++ b/tools/testing/selftests/net/jumbogram.bpf.c
@@ -0,0 +1,36 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bpf.h>
+#include <linux/pkt_cls.h>
+#include <bpf/bpf_helpers.h>
+
+struct {
+	__uint(type, BPF_MAP_TYPE_ARRAY);
+	__uint(max_entries, 1);
+	__type(key, __u32);
+	__type(value, __u32);
+} max_packet_size SEC(".maps");
+
+SEC("ingress")
+int track_max_size(struct __sk_buff *skb)
+{
+	__u32 *max_size_ptr, *count;
+	__u32 max_size;
+	__u32 key = 0;
+
+	max_size_ptr = bpf_map_lookup_elem(&max_packet_size, &key);
+	if (max_size_ptr)
+		max_size = *max_size_ptr;
+	else
+		max_size = 0;
+
+	if (skb->len >= max_size) {
+		max_size = skb->len;
+		bpf_map_update_elem(&max_packet_size, &key, &max_size,
+				    BPF_ANY);
+	}
+
+	return TC_ACT_OK;
+}
+
+char _license[] SEC("license") = ("GPL");
diff --git a/tools/testing/selftests/net/jumbogram.sh b/tools/testing/selftests/net/jumbogram.sh
new file mode 100755
index 000000000000..bec5197c0a12
--- /dev/null
+++ b/tools/testing/selftests/net/jumbogram.sh
@@ -0,0 +1,380 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# This test is for checking IPv6 jumbogram passthrough through high MTUs.
+#
+# The test uses three namespaces: A client namespace, a server namespace and a
+# router namespace that forwards packets between the client and the server.
+#
+# +------------------------------------+
+# | NS_CLIENT                          |
+# |            veth$CLIENT             |
+# |                 +                  |
+# +-----------------|------------------+
+#                   |
+# +-----------------|------------------+
+# | NS_ROUTER       +                  |
+# |         veth$ROUTER_CLIENT         |
+# |                                    |
+# |         veth$ROUTER_SERVER         |
+# |                 +                  |
+# +-----------------|------------------+
+#                   |
+# +-----------------|------------------+
+# | NS_SERVER       +                  |
+# |            veth$SERVER             |
+# |                                    |
+# +------------------------------------+
+
+source lib.sh
+
+# All the tests in this script. Can be overridden with -t option.
+TESTS="
+	test_mtu_low_high
+	test_mtu_high_low
+	test_mtu_high_medium
+	test_mtu_high_high
+	test_mtu_probe
+	test_gso
+	test_fastopen
+"
+VERBOSE=0
+
+declare NS_CLIENT
+declare NS_ROUTER
+declare NS_SERVER
+
+readonly CLIENT=1
+readonly ROUTER_CLIENT=2
+readonly ROUTER_SERVER=3
+readonly SERVER=4
+
+readonly CLIENT_ADDR="2001:db8:$CLIENT::$CLIENT"
+readonly ROUTER_CLIENT_ADDR="2001:db8:$CLIENT::$ROUTER_CLIENT"
+readonly ROUTER_SERVER_ADDR="2001:db8:$SERVER::$ROUTER_SERVER"
+readonly SERVER_ADDR="2001:db8:$SERVER::$SERVER"
+
+readonly PORT=8000
+
+readonly MTU=500000
+# Leave enough space for headers.
+readonly PACKET_SIZE=$((MTU - 100))
+readonly PACKET_COUNT=30
+
+################################################################################
+# Utilities
+
+run_cmd()
+{
+	local out
+	if ((VERBOSE)); then
+		echo "COMMAND: $*"
+		out="$("$@")"
+	else
+		out="$("$@" 2>/dev/null)"
+	fi
+
+	local rc="$?"
+	if ((VERBOSE)) && [[ -n "$out" ]]; then
+		echo "    $out"
+	fi
+
+	return "$rc"
+}
+
+################################################################################
+# Setup
+
+setup()
+{
+	setup_ns NS_CLIENT NS_ROUTER NS_SERVER
+
+	# Connect the namespaces with veth pairs.
+	run_cmd ip link add \
+		name "veth$CLIENT" netns "$NS_CLIENT" type veth peer \
+		name "veth$ROUTER_CLIENT" netns "$NS_ROUTER"
+
+	run_cmd ip link add \
+		name "veth$SERVER" netns "$NS_SERVER" type veth peer \
+		name "veth$ROUTER_SERVER" netns "$NS_ROUTER"
+
+	run_cmd ip -n "$NS_CLIENT" link set dev "veth$CLIENT" up
+	run_cmd ip -n "$NS_ROUTER" link set dev "veth$ROUTER_CLIENT" up
+	run_cmd ip -n "$NS_ROUTER" link set dev "veth$ROUTER_SERVER" up
+	run_cmd ip -n "$NS_SERVER" link set dev "veth$SERVER" up
+
+	run_cmd ip -n "$NS_CLIENT" addr add dev \
+		"veth$CLIENT" "$CLIENT_ADDR/64" nodad
+	run_cmd ip -n "$NS_ROUTER" addr add dev \
+		"veth$ROUTER_CLIENT" "$ROUTER_CLIENT_ADDR/64" nodad
+	run_cmd ip -n "$NS_ROUTER" addr add dev \
+		"veth$ROUTER_SERVER" "$ROUTER_SERVER_ADDR/64" nodad
+	run_cmd ip -n "$NS_SERVER" addr add dev \
+		"veth$SERVER" "$SERVER_ADDR/64" nodad
+
+	# Set up forwarding through NS_ROUTER.
+	run_cmd ip netns exec "$NS_ROUTER" \
+		sysctl -wq "net.ipv6.conf.all.forwarding=1"
+	run_cmd ip netns exec "$NS_ROUTER" \
+		sysctl -wq "net.ipv6.conf.veth$ROUTER_CLIENT.forwarding=1"
+	run_cmd ip netns exec "$NS_ROUTER" \
+		sysctl -wq "net.ipv6.conf.veth$ROUTER_SERVER.forwarding=1"
+
+	run_cmd ip -n "$NS_CLIENT" -6 route add "$SERVER_ADDR" \
+		via "$ROUTER_CLIENT_ADDR" dev "veth$CLIENT"
+	run_cmd ip -n "$NS_SERVER" -6 route add "$CLIENT_ADDR" \
+		via "$ROUTER_SERVER_ADDR" dev "veth$SERVER"
+
+	# Disable GSO and GRO.
+	run_cmd ip netns exec "$NS_CLIENT" ethtool -K "veth$CLIENT" gso off
+	run_cmd ip netns exec "$NS_CLIENT" ethtool -K "veth$CLIENT" tso off
+
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_SERVER" gso off
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_SERVER" tso off
+
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_CLIENT" gro off
+	run_cmd ip netns exec "$NS_SERVER" ethtool -K "veth$SERVER" gro off
+}
+
+cleanup()
+{
+	cleanup_all_ns
+}
+
+set_mtus()
+{
+	local client_mtu="$1"
+	local server_mtu="$2"
+
+	run_cmd ip -n "$NS_CLIENT" link set "veth$CLIENT" mtu "$client_mtu"
+	run_cmd ip -n "$NS_ROUTER" link set "veth$ROUTER_CLIENT" mtu "$client_mtu"
+
+	run_cmd ip -n "$NS_SERVER" link set "veth$SERVER" mtu "$server_mtu"
+	run_cmd ip -n "$NS_ROUTER" link set "veth$ROUTER_SERVER" mtu "$server_mtu"
+}
+
+set_gso_max_size()
+{
+	local gso_max_size="$1"
+
+	run_cmd ip -n "$NS_CLIENT" link set dev "veth$CLIENT" gso_max_size "$gso_max_size"
+	run_cmd ip netns exec "$NS_CLIENT" ethtool -K "veth$CLIENT" gso on
+	run_cmd ip netns exec "$NS_CLIENT" ethtool -K "veth$CLIENT" tso on
+
+	run_cmd ip -n "$NS_ROUTER" link set dev "veth$ROUTER_CLIENT" gso_max_size "$gso_max_size"
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_CLIENT" gso on
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_CLIENT" tso on
+
+	run_cmd ip -n "$NS_ROUTER" link set dev "veth$ROUTER_SERVER" gso_max_size "$gso_max_size"
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_SERVER" gso on
+	run_cmd ip netns exec "$NS_ROUTER" ethtool -K "veth$ROUTER_SERVER" tso on
+
+	run_cmd ip -n "$NS_SERVER" link set dev "veth$SERVER" gso_max_size "$gso_max_size"
+	run_cmd ip netns exec "$NS_SERVER" ethtool -K "veth$SERVER" gso on
+	run_cmd ip netns exec "$NS_SERVER" ethtool -K "veth$SERVER" tso on
+}
+
+################################################################################
+# Tests
+
+# Attach a BPF program that keeps track of the maximum packet size it observes.
+observe_packets_start() {
+	run_cmd tc -n "$NS_SERVER" qdisc add dev "veth$SERVER" clsact
+	run_cmd tc -n "$NS_SERVER" filter add dev "veth$SERVER" ingress \
+   		bpf object-file jumbogram.bpf.o section ingress
+}
+
+max_observed_packet_size() {
+	bpftool map lookup name max_packet_size key 0 0 0 0 | jq ".value"
+}
+
+observe_packets_stop() {
+	run_cmd tc -n "$NS_SERVER" filter del dev "veth$SERVER" ingress
+	run_cmd tc -n "$NS_SERVER" qdisc del dev "veth$SERVER" clsact
+}
+
+# Check jumbograms are received by the server.
+check_jumbogram_passthrough()
+{
+	local success="$1"
+	local expected_size="${2-$PACKET_SIZE}"
+	local args=("${@:3}")
+
+	# Start the server.
+	local server_stdout="$(mktemp server-stdout-XXXXXX)"
+	local server_stderr="$(mktemp server-stderr-XXXXXX)"
+	ip netns exec "$NS_SERVER" \
+		./jumbogram_rx -p "$PORT" -l $((PACKET_SIZE * PACKET_COUNT)) \
+		-C 4000 -R 20 "${args[@]}" >"$server_stdout" 2>"$server_stderr" &
+	local server_pid="$!"
+
+	# Wait for the server to start listening.
+	for i in {1..4}; do
+		if grep -q "listening" "$server_stdout"; then
+			break
+		fi
+		sleep 1
+	done
+
+	if ! grep -q "listening" "$server_stdout"; then
+		check_err 1 "failed to start server"
+		kill "$server_pid"
+		wait "$server_pid"
+		return
+	fi
+
+	observe_packets_start
+
+	# Start the client.
+	local client_out="$(mktemp client-out-XXXXXX)"
+	ip netns exec "$NS_CLIENT" \
+		./jumbogram_tx -D "$SERVER_ADDR" -p "$PORT" -M "$PACKET_COUNT" \
+		-s "$PACKET_SIZE" "${args[@]}" >"$client_out" 2>&1
+
+	check_err "$?" "$(cat "$client_out")"
+	rm "$client_out"
+
+	# Make sure the server received the correct amount of data.
+	run_cmd wait "$server_pid"
+	check_err "$?" "$(cat "$server_stderr")"
+	rm "$server_stderr" "$server_stdout"
+
+	# Check if at least on packet was not segmented by checking the maximum
+	# observed packet size. The first packets are always segmented due to
+	# the small initial window size.
+	local max_size="$(max_observed_packet_size)"
+	observe_packets_stop
+
+	((max_size >= expected_size))
+	check_err_fail $((success ^ 1)) "$?" \
+		"expected >=$expected_size received $max_size; jumbogram passthrough"
+}
+
+# If one side has MTU < 65536, the negotiated MSS should be < 65536.
+test_mtu_low_high()
+{
+	set_mtus 1500 "$MTU"
+	check_jumbogram_passthrough 0
+	log_test "TCP jumbograms over veth" "client:   1500, server: $MTU"
+}
+
+test_mtu_high_low()
+{
+	set_mtus "$MTU" 1500
+	check_jumbogram_passthrough 0
+	log_test "TCP jumbograms over veth" "client: $MTU, server:   1500"
+}
+
+# If both sides have MTU > 65535 but the message size is above the server MTU,
+# smaller jumbograms should still be delivered.
+test_mtu_high_medium()
+{
+	local server_mtu=$((MTU / 2))
+	set_mtus "$MTU" "$server_mtu"
+	check_jumbogram_passthrough 0 "$PACKET_SIZE"
+	check_jumbogram_passthrough 1 $((server_mtu - 100))
+	log_test "TCP jumbograms over veth" "client: $MTU, server: $server_mtu"
+}
+
+# If both ends have MTU > 65535, message-sized jumbograms should pass through.
+test_mtu_high_high()
+{
+	set_mtus "$MTU" "$MTU"
+	check_jumbogram_passthrough 1
+	log_test "TCP jumbograms over veth" "client: $MTU, server: $MTU"
+}
+
+# MTU probing can't currently settle on MSS > 65535 even if the MTUs allow for
+# it due to the MTU-search-range upper bound of 65535. At least make sure that
+# the MSS reaches close to 65535.
+test_mtu_probe()
+{
+	run_cmd ip netns exec "$NS_CLIENT" \
+		sysctl -wq "net.ipv4.tcp_mtu_probing=2"
+
+	set_mtus "$MTU" "$MTU"
+	check_jumbogram_passthrough 0 "$PACKET_SIZE"
+	check_jumbogram_passthrough 1 49000
+	log_test "High MTUs with MTU probing"
+}
+
+# If gso_max_size < MTU then GSO shouldn't be used. gso_max_size > MTU is tested
+# in big_tcp.sh.
+test_gso()
+{
+	local gso_max_size=$((MTU - 100))
+
+	set_mtus "$MTU" "$MTU"
+	set_gso_max_size "$gso_max_size"
+	check_jumbogram_passthrough 1
+	log_test "High MTUs with lower gso_max_size"
+}
+
+# Make sure TCP fastopen works with MTU > 65535.
+test_fastopen()
+{
+	run_cmd ip netns exec "$NS_CLIENT" \
+		sysctl -wq "net.ipv4.tcp_fastopen=3"
+	run_cmd ip netns exec "$NS_SERVER" \
+		sysctl -wq "net.ipv4.tcp_fastopen=3"
+
+	set_mtus "$MTU" "$MTU"
+	check_jumbogram_passthrough 1 "$PACKET_SIZE" -f
+	# The same cookie as the previous connection should be used.
+	check_jumbogram_passthrough 1 "$PACKET_SIZE" -f
+	log_test "High MTUs with TCP fastopen"
+}
+
+################################################################################
+# Usage
+
+usage()
+{
+	cat <<EOF
+usage: ${0##*/} OPTS
+
+        -t <test>   Test(s) to run (default: all)
+                    (options: $TESTS)
+        -p          Pause on fail
+        -v          Verbose mode (show commands and output)
+        -h          Show this help message
+EOF
+}
+
+################################################################################
+# Main
+
+while getopts :t:phv o
+do
+	case "$o" in
+		t) TESTS="$OPTARG";;
+		p) PAUSE_ON_FAIL=yes;;
+		v) VERBOSE=$((VERBOSE + 1));;
+		h) usage; exit 0;;
+		*) usage; exit 1;;
+	esac
+done
+
+if [[ "$(id -u)" -ne 0 ]]; then
+	echo "SKIP: Need root privileges"
+	exit "$ksft_skip";
+fi
+
+require_command bpftool
+require_command ethtool
+require_command ip
+require_command iptables
+require_command jq
+require_command tc
+
+# Start clean.
+cleanup
+
+trap cleanup EXIT
+
+for t in $TESTS
+do
+	setup; "$t"; cleanup;
+done
+
+exit "$EXIT_STATUS"
diff --git a/tools/testing/selftests/net/jumbogram_rx.c b/tools/testing/selftests/net/jumbogram_rx.c
new file mode 100644
index 000000000000..5880704114c4
--- /dev/null
+++ b/tools/testing/selftests/net/jumbogram_rx.c
@@ -0,0 +1,199 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <arpa/inet.h>
+#include <error.h>
+#include <errno.h>
+#include <netinet/tcp.h>
+#include <poll.h>
+#include <stdbool.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <sys/wait.h>
+
+#define POLL_TIMEOUT 10
+#define RCVBUF_SIZE (1 << 21)
+
+static const char *cfg_bind_addr = "::";
+static int cfg_connect_timeout_ms;
+static int cfg_rcv_timeout_ms;
+static int cfg_port = 8000;
+static int cfg_total_len;
+static int cfg_fastopen;
+
+static unsigned long bytes;
+static bool interrupted;
+
+static void sigint_handler(int signum)
+{
+	if (signum == SIGINT)
+		interrupted = true;
+}
+
+static void wait_for_data(int fd, int timeout_ms)
+{
+	struct pollfd pfd;
+
+	pfd.events = POLLIN;
+	pfd.revents = 0;
+	pfd.fd = fd;
+
+	while (true) {
+		int ret = poll(&pfd, 1, POLL_TIMEOUT);
+
+		if (interrupted || (ret > 0 && pfd.revents == POLLIN))
+			break;
+		else if (ret > 0)
+			error(1, errno, "poll: 0x%x expected 0x%x\n",
+			      pfd.revents, POLLIN);
+		else if (ret == -1)
+			error(1, errno, "poll");
+
+		if (!timeout_ms)
+			continue;
+
+		timeout_ms -= POLL_TIMEOUT;
+		if (timeout_ms <= 0) {
+			interrupted = true;
+			break;
+		}
+
+		/* no events and more time to wait, do poll again */
+	}
+}
+
+static int accept_connection(void)
+{
+	static struct sockaddr_in6 addr;
+	int server_fd, fd;
+	int val;
+
+	server_fd = socket(PF_INET6, SOCK_STREAM, 0);
+	if (server_fd == -1)
+		error(1, errno, "socket");
+
+	val = RCVBUF_SIZE;
+	if (setsockopt(server_fd, SOL_SOCKET, SO_RCVBUF, &val, sizeof(val)))
+		error(1, errno, "setsockopt rcvbuf");
+
+	val = 1;
+	if (setsockopt(server_fd, SOL_SOCKET, SO_REUSEPORT, &val, sizeof(val)))
+		error(1, errno, "setsockopt reuseport");
+
+	if (cfg_fastopen &&
+	    setsockopt(server_fd, SOL_TCP, TCP_FASTOPEN, &val, sizeof(val)))
+		error(1, errno, "setsockopt fastopen");
+
+	addr.sin6_family = AF_INET6;
+	addr.sin6_port = htons(cfg_port);
+	if (inet_pton(AF_INET6, cfg_bind_addr, &addr.sin6_addr) != 1)
+		error(1, 0, "ipv6 parse error: %s", cfg_bind_addr);
+
+	if (bind(server_fd, &addr, sizeof(addr)))
+		error(1, errno, "bind");
+
+	if (listen(server_fd, 1))
+		error(1, errno, "listen");
+
+	puts("listening for connection");
+
+	wait_for_data(server_fd, cfg_connect_timeout_ms);
+	if (interrupted)
+		exit(0);
+
+	fd = accept(server_fd, NULL, NULL);
+	if (fd == -1)
+		error(1, errno, "accept");
+
+	if (close(server_fd))
+		error(1, errno, "close accept fd");
+
+	return fd;
+}
+
+static bool receive_packets(int fd)
+{
+	int ret;
+
+	while (true) {
+		ret = recv(fd, NULL, RCVBUF_SIZE, MSG_TRUNC | MSG_DONTWAIT);
+		if (ret > 0)
+			bytes += ret;
+		else if (ret == 0)
+			return true;
+		else if (errno == EAGAIN)
+			return false;
+		else
+			error(1, errno, "recv");
+	}
+
+}
+
+
+static void usage(const char *filepath)
+{
+	error(1, 0, "Usage: %s [-C connect_timeout] [-b addr] [-f] [-p port]"
+	      " [-l total_len] [-n packetnr] [-R rcv_timeout]",
+	      filepath);
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "b:C:fhl:p:R:")) != -1) {
+		switch (c) {
+		case 'b':
+			cfg_bind_addr = optarg;
+			break;
+		case 'C':
+			cfg_connect_timeout_ms = strtoul(optarg, NULL, 0);
+			break;
+		case 'f':
+			cfg_fastopen = true;
+			break;
+		case 'h':
+			usage(argv[0]);
+			break;
+		case 'l':
+			cfg_total_len = strtoul(optarg, NULL, 0);
+			break;
+		case 'p':
+			cfg_port = strtoul(optarg, NULL, 0);
+			break;
+		case 'R':
+			cfg_rcv_timeout_ms = strtoul(optarg, NULL, 0);
+			break;
+		default:
+			exit(1);
+		}
+	}
+
+	if (optind != argc)
+		usage(argv[0]);
+}
+
+int main(int argc, char **argv)
+{
+	parse_opts(argc, argv);
+
+	signal(SIGINT, sigint_handler);
+
+	int fd = accept_connection();
+	int stop = false;
+
+	while (!interrupted && !stop) {
+		wait_for_data(fd, cfg_rcv_timeout_ms);
+		stop = receive_packets(fd);
+	}
+
+	if (cfg_total_len && (bytes != cfg_total_len))
+		error(1, 0, "wrong data length! got %ld, expected %d\n",
+		      bytes, cfg_total_len);
+
+	if (close(fd))
+		error(1, errno, "close");
+
+	return 0;
+}
diff --git a/tools/testing/selftests/net/jumbogram_tx.c b/tools/testing/selftests/net/jumbogram_tx.c
new file mode 100644
index 000000000000..53d1ea4aec44
--- /dev/null
+++ b/tools/testing/selftests/net/jumbogram_tx.c
@@ -0,0 +1,139 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#define _GNU_SOURCE
+
+#include <arpa/inet.h>
+#include <error.h>
+#include <errno.h>
+#include <netinet/ip6.h>
+#include <netinet/tcp.h>
+#include <stdbool.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/wait.h>
+
+#define RCVBUF_SIZE (1 << 21)
+
+static const char *cfg_bind_addr = "::";
+static int cfg_payload_len = 499700;
+static int cfg_port = 8000;
+static int cfg_msg_nr = 1;
+static bool cfg_fastopen;
+
+static char buf[RCVBUF_SIZE];
+static bool interrupted;
+
+static void sigint_handler(int signum)
+{
+	if (signum == SIGINT)
+		interrupted = true;
+}
+
+static void send_message(int fd, const char *buf, size_t len)
+{
+	int done = 0;
+	int ret;
+
+	while (done < len) {
+		ret = send(fd, &buf[done], len - done, 0);
+		if (ret < 0)
+			error(1, errno, "send");
+
+		done += ret;
+	}
+}
+
+static int connect_to_server(void)
+{
+	struct sockaddr_in6 addr;
+	int ret;
+	int fd;
+
+	fd = socket(PF_INET6, SOCK_STREAM, 0);
+	if (fd == -1)
+		error(1, errno, "socket");
+
+	addr.sin6_family = AF_INET6;
+	addr.sin6_port = htons(cfg_port);
+	if (inet_pton(AF_INET6, cfg_bind_addr, &addr.sin6_addr) != 1)
+		error(1, 0, "ipv6 parse error: %s", cfg_bind_addr);
+
+	if (cfg_fastopen) {
+		ret = sendto(fd, &buf, cfg_payload_len, MSG_FASTOPEN, &addr,
+			     sizeof(addr));
+		if (ret < 0)
+			error(1, errno, "sendto");
+
+		send_message(fd, &buf[ret], cfg_payload_len - ret);
+		cfg_msg_nr--;
+	} else if (connect(fd, &addr, sizeof(addr))) {
+		error(1, errno, "connect");
+	}
+
+	return fd;
+}
+
+static void usage(const char *filepath)
+{
+	error(1, 0, "Usage: %s [-D dst ip] [-f] [-M messagenr] [-p port]"
+		    " [-s sendsize]",
+		    filepath);
+}
+
+static void parse_opts(int argc, char **argv)
+{
+	int c;
+
+	while ((c = getopt(argc, argv, "D:fhM:p:s:")) != -1) {
+		switch (c) {
+		case 'D':
+			cfg_bind_addr = optarg;
+			break;
+		case 'f':
+			cfg_fastopen = true;
+			break;
+		case 'h':
+			usage(argv[0]);
+			break;
+		case 'M':
+			cfg_msg_nr = strtoul(optarg, NULL, 10);
+			break;
+		case 'p':
+			cfg_port = strtoul(optarg, NULL, 0);
+			break;
+		case 's':
+			cfg_payload_len = strtoul(optarg, NULL, 0);
+			break;
+		default:
+			exit(1);
+		}
+	}
+
+	if (optind != argc)
+		usage(argv[0]);
+
+	if (cfg_payload_len > RCVBUF_SIZE)
+		error(1, 0, "payload length %u exceeds max %u",
+		      cfg_payload_len, RCVBUF_SIZE);
+}
+
+int main(int argc, char **argv)
+{
+	int fd;
+	int i;
+
+	parse_opts(argc, argv);
+
+	memset(buf, 'A', sizeof(buf));
+
+	signal(SIGINT, sigint_handler);
+
+	fd = connect_to_server();
+	for (i = 0; i < cfg_msg_nr && !interrupted; i++)
+		send_message(fd, buf, cfg_payload_len);
+
+	if (close(fd))
+		error(1, errno, "close");
+
+	return 0;
+}
-- 
2.47.3


