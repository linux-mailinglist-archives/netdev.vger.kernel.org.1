Return-Path: <netdev+bounces-270275-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gL4MMroyv2mtygMAu9opvQ
	(envelope-from <netdev+bounces-270275-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:07:22 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A7D22E7B29
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 01:07:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AA24B301D324
	for <lists+netdev@lfdr.de>; Sun, 22 Mar 2026 00:07:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC52E347C6;
	Sun, 22 Mar 2026 00:07:05 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.4.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B862D79CD;
	Sun, 22 Mar 2026 00:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=160.80.4.37
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774138025; cv=none; b=Qs5Zv+WhI4KTRFs4tVm3aTmaBkhVIqVe+mZiXAtnrpfC2fdcnk/XuqMof3fqo4ay3wy+fZlfWHD6iMRpXdkDSorlyI4q1d8xU0w/JpUExFwVHPnNlqfzPlmHG+okctCvB9M8K5wLP3uvVHaC7LFeSqBb0zcKdF7UG8RwHrxng5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774138025; c=relaxed/simple;
	bh=S10CNGulsSsjB4/T4ThdvAJzj/O2sy1yX3ScZIOapXY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Z9SEQZhe8lmlmnr8GT6ALJl3ER9c/kVAu0RH1DZJkxGYluUgGdisZU//tGu1SAF1mjcLuIiR/93PRBvz0I63+EQj4SQRtUvQvEmC9NzNPi8fuEuIRotM9xQKc2xEVpIiRs8R2zayPVaUE1muisNF7xdTm7oh6bNl7BxE4UQi4x4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it; spf=pass smtp.mailfrom=uniroma2.it; arc=none smtp.client-ip=160.80.4.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=uniroma2.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=uniroma2.it
Received: from localhost.localdomain ([160.80.103.126])
	by smtp-2015.uniroma2.it (8.14.4/8.14.4/Debian-8) with ESMTP id 62M06J56021482;
	Sun, 22 Mar 2026 01:06:25 +0100
From: Andrea Mayer <andrea.mayer@uniroma2.it>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>, David Ahern <dsahern@kernel.org>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>,
        Stefano Salsano <stefano.salsano@uniroma2.it>,
        Paolo Lungaroni <paolo.lungaroni@uniroma2.it>,
        Ahmed Abdelsalam <ahabdels@cisco.com>,
        Justin Iurman <justin.iurman@6wind.com>, linux-kernel@vger.kernel.org,
        Andrea Mayer <andrea.mayer@uniroma2.it>, Shuah Khan <shuah@kernel.org>,
        linux-kselftest@vger.kernel.org
Subject: [RFC PATCH net-next 3/3] selftests: seg6: add SRv6 srl2 + End.DT2U L2 VPN test
Date: Sun, 22 Mar 2026 01:05:57 +0100
Message-Id: <20260322000557.12559-4-andrea.mayer@uniroma2.it>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
References: <20260322000557.12559-1-andrea.mayer@uniroma2.it>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.100.0 at smtp-2015
X-Virus-Status: Clean
X-Spamd-Result: default: False [0.14 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[uniroma2.it : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-270275-lists,netdev=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andrea.mayer@uniroma2.it,netdev@vger.kernel.org];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,srv6_srl2_l2vpn_test.sh:url,uniroma2.it:email,uniroma2.it:mid]
X-Rspamd-Queue-Id: 8A7D22E7B29
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Add a selftest for the srl2 Ethernet pseudowire device exercising the
full L2 VPN data path: srl2 for encapsulation and End.DT2U for
decapsulation, connected through a Linux bridge.

The test verifies IPv4/IPv6 host-to-host and host-to-gateway
connectivity over a two-router topology.

Cc: Shuah Khan <shuah@kernel.org>
Cc: linux-kselftest@vger.kernel.org
Signed-off-by: Andrea Mayer <andrea.mayer@uniroma2.it>
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../selftests/net/srv6_srl2_l2vpn_test.sh     | 621 ++++++++++++++++++
 3 files changed, 623 insertions(+)
 create mode 100755 tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index 6bced3ed798b..d2301387b21c 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -92,6 +92,7 @@ TEST_PROGS := \
 	srv6_end_x_next_csid_l3vpn_test.sh \
 	srv6_hencap_red_l3vpn_test.sh \
 	srv6_hl2encap_red_l2vpn_test.sh \
+	srv6_srl2_l2vpn_test.sh \
 	stress_reuseport_listen.sh \
 	tcp_fastopen_backup_key.sh \
 	test_bpf.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 2a390cae41bf..77d5c7941969 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -48,6 +48,7 @@ CONFIG_IPV6_ROUTER_PREF=y
 CONFIG_IPV6_RPL_LWTUNNEL=y
 CONFIG_IPV6_SEG6_LWTUNNEL=y
 CONFIG_IPV6_SIT=y
+CONFIG_IPV6_SRL2=m
 CONFIG_IPV6_VTI=y
 CONFIG_IPVLAN=m
 CONFIG_IPVTAP=m
diff --git a/tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh b/tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh
new file mode 100755
index 000000000000..eefc1274e139
--- /dev/null
+++ b/tools/testing/selftests/net/srv6_srl2_l2vpn_test.sh
@@ -0,0 +1,621 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+#
+# author: Andrea Mayer <andrea.mayer@uniroma2.it>
+#
+# This script tests the full SRv6 L2 VPN data path using the srl2
+# virtual Ethernet device for L2 frame encapsulation and the End.DT2U
+# behavior (RFC 8986, Section 4.11) for decapsulation.
+#
+# This test exercises the full SRv6 L2 VPN data path using the srl2
+# device as the TX-side encapsulator. Each SRv6 router uses a bridge
+# (br0) with two ports:
+#   - veth-hs: connects to the host
+#   - srl2-0: SRv6 L2 tunnel device for encap/decap
+#
+# TX path: the host sends an L2 frame via veth-hs. The bridge forwards
+# the frame to srl2-0 (L2 forwarding based on dst MAC). srl2-0
+# encapsulates the frame in IPv6+SRH and transmits.
+#
+# RX path: an SRv6 packet arrives carrying an inner Ethernet frame.
+# End.DT2U decapsulates and delivers the frame on srl2-0 via
+# netif_rx(). Since srl2-0 is a bridge port, the bridge performs MAC
+# learning and L2 forwarding to deliver the frame to veth-hs.
+#
+# Note: no static MAC addresses or neighbor entries are needed here.
+# ARP works naturally through the
+# bridge and the SRv6 tunnel: ARP requests are broadcast, flooded by
+# the bridge to srl2-0, encapsulated, decapsulated by End.DT2U on the
+# remote side, and flooded to the destination host.
+#
+# Topology:
+#
+#              cafe::1                                cafe::2
+#             10.0.0.1                               10.0.0.2
+#            +--------+                             +--------+
+#            |        |                             |        |
+#            |  hs-1  |                             |  hs-2  |
+#            |        |                             |        |
+#            +---+----+                             +----+---+
+#   cafe::/64    |                                       |      cafe::/64
+# 10.0.0.0/24    |                                       |    10.0.0.0/24
+#          +-----+------+                         +------+-----+
+#          |   veth-hs  |                         |  veth-hs   |
+#          |      |     |   fcf0:0:1:2::/64       |     |      |
+#          |    br0     +-------------------------+   br0      |
+#          |      |     |                         |     |      |
+#          |   srl2-0   |                         |  srl2-0    |
+#          |    rt-1    |                         |   rt-2     |
+#          +------------+                         +------------+
+#
+#
+# Every fcf0:0:x:y::/64 network interconnects the SRv6 routers rt-x with
+# rt-y in the IPv6 operator network.
+#
+# Local SID table
+# ===============
+#
+# Each SRv6 router is configured with a Local SID table in which SIDs are
+# stored. Considering the given SRv6 router rt-x, the following SID is
+# configured in the Local SID table:
+#
+#   Local SID table for SRv6 router rt-x
+#   +-----------------------------------------------------------+
+#   |fcff:x::d20 is associated with the SRv6 End.DT2U behavior |
+#   +-----------------------------------------------------------+
+#
+# SRv6 L2 encapsulation
+# =====================
+#
+# Each router's srl2-0 device is configured with a SID list pointing to
+# the remote router's End.DT2U SID:
+#
+#   rt-1 srl2-0: segs fcff:2::d20  (encap towards rt-2)
+#   rt-2 srl2-0: segs fcff:1::d20  (encap towards rt-1)
+#
+# Each SID list consists of only one SID. The srl2 device encapsulates
+# the L2 frame in an outer IPv6 header with an SRH containing the
+# segment list.
+#
+
+source lib.sh
+
+readonly DUMMY_DEVNAME="dum0"
+readonly SRL2_DEVNAME="srl2-0"
+readonly RT2HS_DEVNAME="veth-hs"
+readonly BRIDGE_DEVNAME="br0"
+readonly HS_VETH_NAME="veth0"
+readonly LOCALSID_TABLE_ID=90
+readonly IPv6_RT_NETWORK=fcf0:0
+readonly IPv6_HS_NETWORK=cafe
+readonly IPv4_HS_NETWORK=10.0.0
+readonly VPN_LOCATOR_SERVICE=fcff
+readonly DT2U_FUNC=0d20
+
+PING_TIMEOUT_SEC=4
+PAUSE_ON_FAIL=${PAUSE_ON_FAIL:=no}
+
+ROUTERS=''
+HOSTS=''
+
+SETUP_ERR=1
+
+ret=${ksft_skip}
+nsuccess=0
+nfail=0
+
+log_test()
+{
+	local rc="$1"
+	local expected="$2"
+	local msg="$3"
+
+	if [ "${rc}" -eq "${expected}" ]; then
+		nsuccess=$((nsuccess+1))
+		printf "\n    TEST: %-60s  [ OK ]\n" "${msg}"
+	else
+		ret=1
+		nfail=$((nfail+1))
+		printf "\n    TEST: %-60s  [FAIL]\n" "${msg}"
+		if [ "${PAUSE_ON_FAIL}" = "yes" ]; then
+			echo
+			echo "hit enter to continue, 'q' to quit"
+			read a
+			[ "$a" = "q" ] && exit 1
+		fi
+	fi
+}
+
+print_log_test_results()
+{
+	printf "\nTests passed: %3d\n" "${nsuccess}"
+	printf "Tests failed: %3d\n"   "${nfail}"
+
+	if [ "${ret}" -ne 1 ]; then
+		ret=0
+	fi
+}
+
+log_section()
+{
+	echo
+	echo "################################################################################"
+	echo "TEST SECTION: $*"
+	echo "################################################################################"
+}
+
+test_command_or_ksft_skip()
+{
+	local cmd="$1"
+
+	if [ ! -x "$(command -v "${cmd}")" ]; then
+		echo "SKIP: Could not run test without \"${cmd}\" tool";
+		exit "${ksft_skip}"
+	fi
+}
+
+get_rtname()
+{
+	local rtid="$1"
+
+	echo "rt_${rtid}"
+}
+
+get_hsname()
+{
+	local hsid="$1"
+
+	echo "hs_${hsid}"
+}
+
+create_router()
+{
+	local rtid="$1"
+	local nsname
+
+	nsname="$(get_rtname "${rtid}")"
+	setup_ns "${nsname}"
+}
+
+create_host()
+{
+	local hsid="$1"
+	local nsname
+
+	nsname="$(get_hsname "${hsid}")"
+	setup_ns "${nsname}"
+}
+
+cleanup()
+{
+	cleanup_all_ns
+
+	if [ "${SETUP_ERR}" -ne 0 ]; then
+		echo "SKIP: Setting up the testing environment failed"
+		exit "${ksft_skip}"
+	fi
+
+	exit "${ret}"
+}
+
+add_link_rt_pairs()
+{
+	local rt="$1"
+	local rt_neighs="$2"
+	local neigh
+	local nsname
+	local neigh_nsname
+
+	eval nsname=\${$(get_rtname "${rt}")}
+
+	for neigh in ${rt_neighs}; do
+		eval neigh_nsname=\${$(get_rtname "${neigh}")}
+
+		ip link add "veth-rt-${rt}-${neigh}" netns "${nsname}" \
+			type veth peer name "veth-rt-${neigh}-${rt}" \
+			netns "${neigh_nsname}"
+	done
+}
+
+get_network_prefix()
+{
+	local rt="$1"
+	local neigh="$2"
+	local p="${rt}"
+	local q="${neigh}"
+
+	if [ "${p}" -gt "${q}" ]; then
+		p="${q}"; q="${rt}"
+	fi
+
+	echo "${IPv6_RT_NETWORK}:${p}:${q}"
+}
+
+setup_rt_networking()
+{
+	local rt="$1"
+	local rt_neighs="$2"
+	local nsname
+	local net_prefix
+	local devname
+	local neigh
+
+	eval nsname=\${$(get_rtname "${rt}")}
+
+	for neigh in ${rt_neighs}; do
+		devname="veth-rt-${rt}-${neigh}"
+
+		net_prefix="$(get_network_prefix "${rt}" "${neigh}")"
+
+		ip -netns "${nsname}" addr \
+			add "${net_prefix}::${rt}/64" dev "${devname}" nodad
+
+		ip -netns "${nsname}" link set "${devname}" up
+	done
+
+	ip -netns "${nsname}" link add "${DUMMY_DEVNAME}" type dummy
+
+	ip -netns "${nsname}" link set "${DUMMY_DEVNAME}" up
+	ip -netns "${nsname}" link set lo up
+
+	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
+	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
+	ip netns exec "${nsname}" sysctl -wq net.ipv6.conf.all.forwarding=1
+	ip netns exec "${nsname}" sysctl -wq net.ipv4.ip_forward=1
+}
+
+setup_rt_local_sids()
+{
+	local rt="$1"
+	local rt_neighs="$2"
+	local net_prefix
+	local devname
+	local nsname
+	local neigh
+
+	eval nsname=\${$(get_rtname "${rt}")}
+
+	for neigh in ${rt_neighs}; do
+		devname="veth-rt-${rt}-${neigh}"
+
+		net_prefix="$(get_network_prefix "${rt}" "${neigh}")"
+
+		# set underlay network routes for SIDs reachability
+		ip -netns "${nsname}" -6 route \
+			add "${VPN_LOCATOR_SERVICE}:${neigh}::/32" \
+			table "${LOCALSID_TABLE_ID}" \
+			via "${net_prefix}::${neigh}" dev "${devname}"
+	done
+
+	# Local End.DT2U behavior: decapsulate L2 frames and deliver on
+	# srl2-0 which is a bridge port; the bridge then forwards to the
+	# host connected via veth-hs.
+	ip -netns "${nsname}" -6 route \
+		add "${VPN_LOCATOR_SERVICE}:${rt}::${DT2U_FUNC}" \
+		table "${LOCALSID_TABLE_ID}" \
+		encap seg6local action End.DT2U l2dev "${SRL2_DEVNAME}" \
+		dev "${DUMMY_DEVNAME}"
+
+	# all SIDs for VPNs start with a common locator. Routes and SRv6
+	# Endpoint behaviors instances are grouped together in the 'localsid'
+	# table.
+	ip -netns "${nsname}" -6 rule add \
+		to "${VPN_LOCATOR_SERVICE}::/16" \
+		lookup "${LOCALSID_TABLE_ID}" prio 999
+}
+
+setup_hs()
+{
+	local hs="$1"
+	local rt="$2"
+	local hsname
+	local rtname
+
+	eval hsname=\${$(get_hsname "${hs}")}
+	eval rtname=\${$(get_rtname "${rt}")}
+
+	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.all.accept_dad=0
+	ip netns exec "${hsname}" sysctl -wq net.ipv6.conf.default.accept_dad=0
+
+	ip -netns "${hsname}" link add "${HS_VETH_NAME}" type veth \
+		peer name "${RT2HS_DEVNAME}" netns "${rtname}"
+
+	ip -netns "${hsname}" addr add "${IPv6_HS_NETWORK}::${hs}/64" \
+		dev "${HS_VETH_NAME}" nodad
+	ip -netns "${hsname}" addr add "${IPv4_HS_NETWORK}.${hs}/24" \
+		dev "${HS_VETH_NAME}"
+
+	ip -netns "${hsname}" link set "${HS_VETH_NAME}" up
+	ip -netns "${hsname}" link set lo up
+
+	# veth-hs is a bridge port; IPs go on br0 (see setup_bridge)
+	ip -netns "${rtname}" link set "${RT2HS_DEVNAME}" up
+}
+
+# Create srl2 device, bridge, and wire them together.
+# The srl2 device encapsulates L2 frames in IPv6+SRH towards the
+# remote router's End.DT2U SID. The bridge connects the host (via
+# veth-hs) with the SRv6 tunnel (via srl2-0).
+# args:
+#  $1 - router id
+#  $2 - remote router id (for SID list)
+setup_bridge()
+{
+	local rt="$1"
+	local remote_rt="$2"
+	local nsname
+
+	eval nsname=\${$(get_rtname "${rt}")}
+
+	# create the srl2 device pointing to the remote End.DT2U SID
+	ip -netns "${nsname}" link add "${SRL2_DEVNAME}" type srl2 \
+		segs "${VPN_LOCATOR_SERVICE}:${remote_rt}::${DT2U_FUNC}"
+	ip -netns "${nsname}" link set "${SRL2_DEVNAME}" up
+
+	# create bridge and add ports
+	ip -netns "${nsname}" link add "${BRIDGE_DEVNAME}" type bridge
+	ip -netns "${nsname}" link set "${BRIDGE_DEVNAME}" up
+
+	ip -netns "${nsname}" link set "${RT2HS_DEVNAME}" master \
+		"${BRIDGE_DEVNAME}"
+	ip -netns "${nsname}" link set "${SRL2_DEVNAME}" master \
+		"${BRIDGE_DEVNAME}"
+
+	# IP addresses on br0 (gateway for the hosts)
+	ip -netns "${nsname}" addr add "${IPv6_HS_NETWORK}::254/64" \
+		dev "${BRIDGE_DEVNAME}" nodad
+	ip -netns "${nsname}" addr \
+		add "${IPv4_HS_NETWORK}.254/24" dev "${BRIDGE_DEVNAME}"
+}
+
+setup()
+{
+	local i
+
+	# create routers
+	ROUTERS="1 2"; readonly ROUTERS
+	for i in ${ROUTERS}; do
+		create_router "${i}"
+	done
+
+	# create hosts
+	HOSTS="1 2"; readonly HOSTS
+	for i in ${HOSTS}; do
+		create_host "${i}"
+	done
+
+	# set up the links for connecting routers
+	add_link_rt_pairs 1 "2"
+
+	# set up the basic connectivity of routers and routes required for
+	# reachability of SIDs.
+	setup_rt_networking 1 "2"
+	setup_rt_networking 2 "1"
+
+	# set up the hosts connected to routers
+	setup_hs 1 1
+	setup_hs 2 2
+
+	# set up srl2 devices and bridges on each router.
+	# rt-1's srl2-0 encapsulates towards rt-2's End.DT2U SID and
+	# vice versa.
+	setup_bridge 1 2
+	setup_bridge 2 1
+
+	# set up SRv6 Endpoints (i.e. SRv6 End.DT2U)
+	setup_rt_local_sids 1 "2"
+	setup_rt_local_sids 2 "1"
+
+	# testing environment was set up successfully
+	SETUP_ERR=0
+}
+
+check_rt_connectivity()
+{
+	local rtsrc="$1"
+	local rtdst="$2"
+	local prefix
+	local rtsrc_nsname
+
+	eval rtsrc_nsname=\${$(get_rtname "${rtsrc}")}
+
+	prefix="$(get_network_prefix "${rtsrc}" "${rtdst}")"
+
+	ip netns exec "${rtsrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
+		"${prefix}::${rtdst}" >/dev/null 2>&1
+}
+
+check_and_log_rt_connectivity()
+{
+	local rtsrc="$1"
+	local rtdst="$2"
+
+	check_rt_connectivity "${rtsrc}" "${rtdst}"
+	log_test $? 0 "Routers connectivity: rt-${rtsrc} -> rt-${rtdst}"
+}
+
+check_hs_ipv6_connectivity()
+{
+	local hssrc="$1"
+	local hsdst="$2"
+	local hssrc_nsname
+
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
+
+	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
+		"${IPv6_HS_NETWORK}::${hsdst}" >/dev/null 2>&1
+}
+
+check_hs_ipv4_connectivity()
+{
+	local hssrc="$1"
+	local hsdst="$2"
+	local hssrc_nsname
+
+	eval hssrc_nsname=\${$(get_hsname "${hssrc}")}
+
+	ip netns exec "${hssrc_nsname}" ping -c 1 -W "${PING_TIMEOUT_SEC}" \
+		"${IPv4_HS_NETWORK}.${hsdst}" >/dev/null 2>&1
+}
+
+check_and_log_hs2gw_connectivity()
+{
+	local hssrc="$1"
+
+	check_hs_ipv6_connectivity "${hssrc}" 254
+	log_test $? 0 "IPv6 Hosts connectivity: hs-${hssrc} -> gw"
+
+	check_hs_ipv4_connectivity "${hssrc}" 254
+	log_test $? 0 "IPv4 Hosts connectivity: hs-${hssrc} -> gw"
+}
+
+check_and_log_hs_ipv6_connectivity()
+{
+	local hssrc="$1"
+	local hsdst="$2"
+
+	check_hs_ipv6_connectivity "${hssrc}" "${hsdst}"
+	log_test $? 0 "IPv6 Hosts connectivity: hs-${hssrc} -> hs-${hsdst}"
+}
+
+check_and_log_hs_ipv4_connectivity()
+{
+	local hssrc="$1"
+	local hsdst="$2"
+
+	check_hs_ipv4_connectivity "${hssrc}" "${hsdst}"
+	log_test $? 0 "IPv4 Hosts connectivity: hs-${hssrc} -> hs-${hsdst}"
+}
+
+check_and_log_hs_connectivity()
+{
+	local hssrc="$1"
+	local hsdst="$2"
+
+	check_and_log_hs_ipv4_connectivity "${hssrc}" "${hsdst}"
+	check_and_log_hs_ipv6_connectivity "${hssrc}" "${hsdst}"
+}
+
+router_tests()
+{
+	local i
+	local j
+
+	log_section "IPv6 routers connectivity test"
+
+	for i in ${ROUTERS}; do
+		for j in ${ROUTERS}; do
+			if [ "${i}" -eq "${j}" ]; then
+				continue
+			fi
+
+			check_and_log_rt_connectivity "${i}" "${j}"
+		done
+	done
+}
+
+host2gateway_tests()
+{
+	local hs
+
+	log_section "IPv4/IPv6 connectivity test among hosts and gateways"
+
+	for hs in ${HOSTS}; do
+		check_and_log_hs2gw_connectivity "${hs}"
+	done
+}
+
+host_vpn_tests()
+{
+	log_section "SRv6 srl2 + End.DT2U L2 VPN connectivity test hosts (h1 <-> h2)"
+
+	check_and_log_hs_connectivity 1 2
+	check_and_log_hs_connectivity 2 1
+}
+
+test_dummy_dev_or_ksft_skip()
+{
+	local test_netns
+
+	test_netns="dummy-$(mktemp -u XXXXXXXX)"
+
+	if ! ip netns add "${test_netns}"; then
+		echo "SKIP: Cannot set up netns for testing dummy dev support"
+		exit "${ksft_skip}"
+	fi
+
+	modprobe dummy &>/dev/null || true
+	if ! ip -netns "${test_netns}" link \
+		add "${DUMMY_DEVNAME}" type dummy; then
+		echo "SKIP: dummy dev not supported"
+
+		ip netns del "${test_netns}"
+		exit "${ksft_skip}"
+	fi
+
+	ip netns del "${test_netns}"
+}
+
+test_srl2_dev_or_ksft_skip()
+{
+	local test_netns
+
+	test_netns="srl2-$(mktemp -u XXXXXXXX)"
+
+	if ! ip netns add "${test_netns}"; then
+		echo "SKIP: Cannot set up netns for testing srl2 dev support"
+		exit "${ksft_skip}"
+	fi
+
+	modprobe srl2 &>/dev/null || true
+	if ! ip -netns "${test_netns}" link \
+		add srl2-test type srl2 \
+		segs fc00::1; then
+		echo "SKIP: srl2 dev not supported"
+
+		ip netns del "${test_netns}"
+		exit "${ksft_skip}"
+	fi
+
+	ip netns del "${test_netns}"
+}
+
+test_iproute2_supp_or_ksft_skip()
+{
+	if ! ip route help 2>&1 | grep -qo "End.DT2U"; then
+		echo "SKIP: Missing SRv6 End.DT2U support in iproute2"
+		exit "${ksft_skip}"
+	fi
+
+	if ! ip link help srl2 2>&1 | grep -qo "srl2"; then
+		echo "SKIP: Missing srl2 link type support in iproute2"
+		exit "${ksft_skip}"
+	fi
+}
+
+if [ "$(id -u)" -ne 0 ]; then
+	echo "SKIP: Need root privileges"
+	exit "${ksft_skip}"
+fi
+
+# required programs to carry out this selftest
+test_command_or_ksft_skip ip
+test_command_or_ksft_skip ping
+test_command_or_ksft_skip sysctl
+test_command_or_ksft_skip grep
+
+test_iproute2_supp_or_ksft_skip
+test_dummy_dev_or_ksft_skip
+test_srl2_dev_or_ksft_skip
+
+set -e
+trap cleanup EXIT
+
+setup
+set +e
+
+router_tests
+host2gateway_tests
+host_vpn_tests
+
+print_log_test_results
-- 
2.20.1


