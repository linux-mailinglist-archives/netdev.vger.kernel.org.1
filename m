Return-Path: <netdev+bounces-249907-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 41BC1D2085F
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 18:23:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 5533D3059A75
	for <lists+netdev@lfdr.de>; Wed, 14 Jan 2026 17:22:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2308C30101F;
	Wed, 14 Jan 2026 17:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YDx4oWTR"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 466612FF643
	for <netdev@vger.kernel.org>; Wed, 14 Jan 2026 17:21:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768411324; cv=none; b=RFlrTBZjRN29hmB8hFZEJjUlPfagH+3Fj4U2sT4hLK915AvhSD22alsrMS8L8DngzC1qpjHNnJ8Waz6z3WtC4M5w14Zp6OlWIUgbxlKePmRBPaRKmvEbEJ6CGktm+CIePtMThLaCP8xw7DXHFp3ScBEkcYVYds0pS3YKgCT51hE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768411324; c=relaxed/simple;
	bh=q/1Vdn/mRuXZMfBrJGr6NN+UJULjFY21F+jYLeMz3KY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SyMJsqIQe0KHfUFzr4KDHBqGOe+vWZji982xmb2BdvkYCpp9YqcjJUUEX/b8Q+bPM82LdI1dLIhE4Ojde64Qyni0VCxMiKaNiNqyx1KL8AE69yM9iU25V7MByyVjvibF1j+xKQf4F29E4Uf2z+aXZjMLGEzS/EJcPn5F9KJbjMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YDx4oWTR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1768411316;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HkDq8Wa5YosiITgIkvPkZk3Pfc4bnZiJ9sn2hq2y/Po=;
	b=YDx4oWTRkJbmES/mZxN3RplL5rVF8+20rpeOaMAEIEU3sZGf7KGIJVnU2VNfTO2j9WT+V3
	kmTshuprmwMDr3isWnaCyoDtP/tLCRfpyru6m0vMGrtyue2ZBqqFfDM+VnyBJow3lzxPpp
	t9haZRPY8H1FgoMqJOd4rSpoSNIgd2Q=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-413-7a56r8LyNkWsxPVeiArhjA-1; Wed,
 14 Jan 2026 12:21:53 -0500
X-MC-Unique: 7a56r8LyNkWsxPVeiArhjA-1
X-Mimecast-MFC-AGG-ID: 7a56r8LyNkWsxPVeiArhjA_1768411311
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 42E1F1956088;
	Wed, 14 Jan 2026 17:21:51 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.224.130])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 828CB19560A7;
	Wed, 14 Jan 2026 17:21:47 +0000 (UTC)
From: Paolo Abeni <pabeni@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Simon Horman <horms@kernel.org>,
	Donald Hunter <donald.hunter@gmail.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Shuah Khan <shuah@kernel.org>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	sdf@fomichev.me,
	petrm@nvidia.com,
	razor@blackwall.org,
	idosch@nvidia.com
Subject: [PATCH v3 net-next 10/10] selftests: net: tests for add double tunneling GRO/GSO
Date: Wed, 14 Jan 2026 18:20:43 +0100
Message-ID: <551e2839d870351c34f656530bfd5865b9b131bc.1768410519.git.pabeni@redhat.com>
In-Reply-To: <cover.1768410519.git.pabeni@redhat.com>
References: <cover.1768410519.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

Create a simple, netns-based topology with double, nested UDP tunnels and
perform TSO transfers on top.

Explicitly enable GSO and/or GRO and check the skb layout consistency with
different configuration allowing (or not) GSO frames to be delivered on
the other end.

The trickest part is account in a robust way the aggregated/unaggregated
packets with double encapsulation: use a classic bpf filter for it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v1 -> v2:
  - fixed a few shellcheck issues
  - added bpf filter to improve accounting
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../testing/selftests/net/double_udp_encap.sh | 394 ++++++++++++++++++
 3 files changed, 396 insertions(+)
 create mode 100755 tools/testing/selftests/net/double_udp_encap.sh

diff --git a/tools/testing/selftests/net/Makefile b/tools/testing/selftests/net/Makefile
index b66ba04f19d9..063155f42cd7 100644
--- a/tools/testing/selftests/net/Makefile
+++ b/tools/testing/selftests/net/Makefile
@@ -22,6 +22,7 @@ TEST_PROGS := \
 	cmsg_so_mark.sh \
 	cmsg_so_priority.sh \
 	cmsg_time.sh \
+	double_udp_encap.sh \
 	drop_monitor_tests.sh \
 	fcnal-ipv4.sh \
 	fcnal-ipv6.sh \
diff --git a/tools/testing/selftests/net/config b/tools/testing/selftests/net/config
index 1e1f253118f5..61b866dca311 100644
--- a/tools/testing/selftests/net/config
+++ b/tools/testing/selftests/net/config
@@ -76,6 +76,7 @@ CONFIG_NET_DROP_MONITOR=m
 CONFIG_NETFILTER=y
 CONFIG_NETFILTER_ADVANCED=y
 CONFIG_NETFILTER_XTABLES_LEGACY=y
+CONFIG_NETFILTER_XT_MATCH_BPF=m
 CONFIG_NETFILTER_XT_MATCH_LENGTH=m
 CONFIG_NETFILTER_XT_MATCH_POLICY=m
 CONFIG_NETFILTER_XT_NAT=m
diff --git a/tools/testing/selftests/net/double_udp_encap.sh b/tools/testing/selftests/net/double_udp_encap.sh
new file mode 100755
index 000000000000..055f65b4d18d
--- /dev/null
+++ b/tools/testing/selftests/net/double_udp_encap.sh
@@ -0,0 +1,394 @@
+#!/bin/bash
+# SPDX-License-Identifier: GPL-2.0
+
+source lib.sh
+
+# shellcheck disable=SC2155 # prefer RO variable over return value from cmd
+readonly CLI="$(dirname "$(readlink -f "$0")")/../../../net/ynl/pyynl/cli.py"
+
+readonly SRC=1
+readonly DST=2
+
+readonly NET_V4=192.168.1.
+readonly NET_V6=2001:db8::
+readonly OL1_NET_V4=172.16.1.
+readonly OL1_NET_V6=2001:db8:1::
+readonly OL2_NET_V4=172.16.2.
+readonly OL2_NET_V6=2001:db8:2::
+
+trap cleanup_all_ns EXIT
+
+# shellcheck disable=SC2329 # can't figure out usage trough a variable
+is_ipv6() {
+	if [[ $1 =~ .*:.* ]]; then
+		return 0
+	fi
+	return 1
+}
+
+# shellcheck disable=SC2329 # can't figure out usage trough a variable
+create_gnv_endpoint() {
+	local -r netns=$1
+	local -r bm_rem_addr=$2
+	local -r gnv_dev=$3
+	local -r gnv_id=$4
+	local opts=$5
+	local gnv_json
+	local rem
+
+	if is_ipv6 "$bm_rem_addr"; then
+		rem=remote6
+	else
+		rem=remote
+	fi
+
+	# add ynl opt separator, if needed
+	[ -n "$opts" ] && opts=", $opts"
+
+	gnv_json="{ \"id\": $gnv_id, \"$rem\": \"$bm_rem_addr\"$opts }"
+	ip netns exec "$netns" "$CLI" --family rt-link --create --excl \
+		--do newlink  --json "{\"ifname\": \"$gnv_dev\",
+				       \"linkinfo\": {\"kind\":\"geneve\",
+				       \"data\": $gnv_json } }" > /dev/null
+	ip -n "$netns" link set dev "$gnv_dev" up
+}
+
+# shellcheck disable=SC2329 # can't figure out usage trough a variable
+create_vxlan_endpoint() {
+	local -r netns=$1
+	local -r bm_rem_addr=$2
+	local -r vxlan_dev=$3
+	local -r vxlan_id=$4
+	local -r opts_str=$5
+	local oldifs
+	local -a opts
+	local opt
+
+	# convert the arguments from yaml format
+	oldifs=$IFS
+	IFS=','
+	for opt in $opts_str; do
+		local pattern='"port":'
+
+		[ -n "$opt" ] || continue
+
+		opts+=("${opt/$pattern*/dstport}" "${opt/$pattern/}")
+	done
+	IFS=$oldifs
+	[ ${#opts[@]} -gt 0 ] || opts+=("dstport" "4789")
+
+	ip -n "$netns" link add "$vxlan_dev" type vxlan id "$vxlan_id" \
+		remote "$bm_rem_addr" "${opts[@]}"
+	ip -n "$netns" link set dev "$vxlan_dev" up
+}
+
+create_ns() {
+	local nested_opt='"port":6082'
+	local create_endpoint
+	local options="$1"
+	local feature
+	local dev
+	local id
+	local ns
+
+	RET=0
+
+	#  +-------------+    +-------------+
+	#  | NS_SRC      |    | NS_NST_DST  |
+	#  |             |    |             |
+	#  |   gnv_nst1  |    |  gnv_nst2   |
+	#  |   +         |    |         +   |
+	#  |   |         |    |         |   |
+	#  |   +         |    |         +   |
+	#  |  gnv1       |    |        gnv2 |
+	#  |   +         |    |         +   |
+	#  |   |         |    |         |   |
+	#  |   + veth1 +--------+ veth2 +   |
+	#  |             |    |             |
+	#  +-------------+    +-------------+
+
+	setup_ns NS_SRC NS_DST
+
+	# concatenate caller provided options and default one
+	[ -n "$2" ] && nested_opt="$nested_opt,$2"
+
+	ip link add name "veth$SRC" netns "$NS_SRC" type veth \
+		peer name "veth$DST" netns "$NS_DST"
+	case "$ENCAP" in
+	vxlan)
+		create_endpoint=create_vxlan_endpoint
+		dev=vx
+		;;
+	geneve)
+		create_endpoint=create_gnv_endpoint
+		dev=gnv
+		;;
+	esac
+
+	id=1
+	for ns in "${NS_LIST[@]}"; do
+		ip -n "$ns" link set dev "veth$id" up
+
+		# ensure the sender can do large write just after 3whs
+		ip netns exec "$ns" \
+			sysctl -qw net.ipv4.tcp_wmem="4096 4194304 4194304"
+
+		# note that 3 - $SRC == $DST and 3 - $DST == $SRC
+		if [ $FAMILY = "4" ]; then
+			ip -n "$ns" addr add dev "veth$id" "$NET_V4$id/24"
+			$create_endpoint "$ns" "$NET_V4$((3 - id))" \
+				"$dev$id" 4 "$options"
+			ip -n "$ns" addr add dev "$dev$id" "$OL1_NET_V4$id/24"
+
+			# nested tunnel devices
+			# pmtu can't be propagated to upper layer devices;
+			# need manual adjust
+			$create_endpoint "$ns" "$OL1_NET_V4$((3 - id))" \
+				"$dev"_nst"$id" 40 "$nested_opt"
+			ip -n "$ns" addr add dev "$dev"_nst"$id" \
+				"$OL2_NET_V4$id/24"
+			ip -n "$ns" link set dev "$dev"_nst"$id" mtu 1392
+		else
+			ip -n "$ns" addr add dev "veth$id" "$NET_V6$id/64" \
+				nodad
+			$create_endpoint "$ns" "$NET_V6$((3 - id))" \
+				"$dev"6"$id" 6 "$options"
+			ip -n "$ns" addr add dev "$dev"6"$id" \
+				"$OL1_NET_V6$id/64" nodad
+
+			$create_endpoint "$ns" "$OL1_NET_V6$((3 - id))" \
+				"$dev"6_nst"$id" 60 "$nested_opt"
+			ip -n "$ns" addr add dev "$dev"6_nst"$id" \
+				"$OL2_NET_V6$id/64" nodad
+			ip -n "$ns" link set dev "$dev"6_nst"$id" mtu 1352
+		fi
+		id=$((id+1))
+	done
+
+	# enable GRO heuristic on the veth peer and ensure UDP L4 over tunnel is
+	# actually segmented
+	for feature in tso tx-udp_tnl-segmentation; do
+		ip netns exec "$NS_SRC" ethtool -K "veth$SRC" \
+			"$feature" off 2>/dev/null
+	done
+}
+
+create_ns_gso()
+{
+	local dev
+
+	create_ns "$@"
+	if [ "$ENCAP" = "geneve" ]; then
+		dev=gnv
+	else
+		dev=vx
+	fi
+	if [ "$FAMILY" = "4" ]; then
+		ip netns exec "$NS_SRC" ethtool -K "$dev$SRC" \
+			tx-gso-partial on \
+			tx-udp_tnl-segmentation on \
+			tx-udp_tnl-csum-segmentation on
+	else
+		ip netns exec "$NS_SRC" ethtool -K "$dev"6"$SRC" \
+			tx-gso-partial on \
+			tx-udp_tnl-segmentation on \
+			tx-udp_tnl-csum-segmentation on
+	fi
+}
+
+create_ns_gso_gro()
+{
+	create_ns_gso "$@"
+	ip netns exec "$NS_DST" ethtool -K "veth$DST" gro on
+	ip netns exec "$NS_SRC" ethtool -K "veth$SRC" tx off >/dev/null 2>&1
+}
+
+run_test() {
+	local -r dst=$NET$DST
+	local -r msg=$1
+	local -r total_size=$2
+	local -r encappkts=$3
+	local inner_proto_offset=0
+	local inner_maclen=14
+	local rx_family="-4"
+	local ipt=iptables
+	local bpf_filter
+	local -a rx_args
+	local wire_pkts
+	local rcvpkts
+	local encl=8
+	local dport
+	local pkts
+	local snd
+
+	if [ $FAMILY = "6" ]; then
+		ipt=ip6tables
+	else
+		# rx program does not support '-6' and implies ipv6 usage by
+		# default
+		rx_args=("$rx_family")
+	fi
+
+	# The received can only check fixed size packet
+	pkts=$((total_size / GSO_SIZE))
+	if [ -n "$4" ]; then
+		wire_pkts=$4
+	elif [ $((total_size % GSO_SIZE)) -eq 0 ]; then
+		wire_pkts=1
+		rx_args+=("-l" "$GSO_SIZE")
+	else
+		wire_pkts=2
+		pkts=$((pkts + 1))
+	fi
+
+	if [ "$ENCAP" = "geneve" ]; then
+		dport=6081
+	else
+		dport=4789
+	fi
+
+	# Either:
+	# - IPv4, nested tunnel carries UDP over IPv4, with dport 6082,
+	#   innermost is TCP over IPv4 on port 8000
+	# - IPv6, nested tunnel carries UDP over IPv6, with dport 6082,
+	#   innermost is TCP over IPv6 on port 8000
+	# The nested tunnel port is 6082 and the nested encap len is 8
+	# regardless of the encap type (no geneve opts).
+	# In inherit protocol mode there is no nested mac hdr and the nested
+	# l3 protocol type field belongs to the geneve hdr.
+	[ "$USE_HINT" = true ] && encl=16
+	[ "$INHERIT" = true ] && inner_maclen=0
+	[ "$INHERIT" = true ] && inner_proto_offset=-4
+	local inner=$((inner_maclen+encl))
+	local proto=$((inner_maclen+encl+inner_proto_offset))
+	bpf_filter=$(nfbpf_compile "(ip &&
+		ip[$((40+encl))] == 0x08 && ip[$((41+encl))] == 0x00 &&
+		ip[$((51+encl))] == 0x11 &&
+		ip[$((64+encl))] == 0x17 && ip[$((65+encl))] == 0xc2 &&
+		ip[$((76+proto))] == 0x08 && ip[$((77+proto))] == 0x00 &&
+		ip[$((87+inner))] == 0x6 &&
+		ip[$((100+inner))] == 0x1f && ip[$((101+inner))] == 0x40) ||
+		(ip6 &&
+		ip6[$((60+encl))] == 0x86 && ip6[$((61+encl))] == 0xdd &&
+		ip6[$((68+encl))] == 0x11 &&
+		ip6[$((104+encl))] == 0x17 && ip6[$((105+encl))] == 0xc2 &&
+		ip6[$((116+proto))] == 0x86 && ip6[$((117+proto))] == 0xdd &&
+		ip6[$((124+inner))] == 0x6 &&
+		ip6[$((160+inner))] == 0x1f && ip6[$((161+inner))] == 0x40)")
+
+	# ignore shorts packet, to avoid arp/mld induced noise
+	ip netns exec "$NS_SRC" "$ipt" -A OUTPUT -p udp --dport "$dport" \
+		-m length --length 600:65535 \
+		-m bpf --bytecode "$bpf_filter"
+	ip netns exec "$NS_DST" "$ipt" -A INPUT -p udp --dport "$dport" \
+		-m length --length 600:65535 \
+		-m bpf --bytecode "$bpf_filter"
+	ip netns exec "$NS_DST" ./udpgso_bench_rx -C 2000 -t -R 100 \
+		-n "$pkts" "${rx_args[@]}" &
+	local pid=$!
+	wait_local_port_listen "$NS_DST" 8000 tcp
+	ip netns exec "$NS_SRC" ./udpgso_bench_tx -"$FAMILY" -t -M 1 \
+		-s "$total_size" -D "$dst"
+	local ret=$?
+	check_err "$ret" "client failure exit code $ret"
+	wait "$pid"
+	ret=$?
+	check_err "$ret" "sever failure exit code $ret"
+
+	snd=$(ip netns exec "$NS_SRC" "$ipt"-save -c |
+		    grep "dport $dport" | sed -e 's/\[//' -e 's/:.*//')
+
+	[ "$snd" = "$wire_pkts" ]
+	# shellcheck disable=SC2319 # known false positive
+	check_err $? "send $snd packets on the lowest link, expected $wire_pkts"
+
+	rcvpkts=$(ip netns exec "$NS_DST" "$ipt"-save -c | \
+		grep "dport $dport" | sed -e 's/\[//' -e 's/:.*//')
+
+	[ "$rcvpkts" = "$encappkts" ]
+	check_err $? "received $rcvpkts $ENCAP packets, expected $encappkts"
+	log_test "$msg"
+}
+
+require_command nfbpf_compile
+require_command jq
+
+# tcp retransmisions will break the accounting
+[ "$KSFT_MACHINE_SLOW" = yes ] && FAIL_TO_XFAIL=yes
+for FAMILY in 4 6; do
+	NET=$OL2_NET_V4
+	GSO_SIZE=1340 # 1392 - 20 - 32
+
+	if [ $FAMILY = 6 ]; then
+		NET=$OL2_NET_V6
+		GSO_SIZE=1280 # 1352 - 40 - 32
+	fi
+
+	echo "IPv$FAMILY"
+
+	unset USE_HINT
+	unset INHERIT
+
+	# "geneve" must be last encap in list, so that later
+	# test cases will run on it
+	for ENCAP in "vxlan" "geneve"; do
+		create_ns
+		run_test "No GSO - $ENCAP" $((GSO_SIZE * 4)) 4 4
+		cleanup_all_ns
+
+		create_ns_gso
+		run_test "GSO without GRO - $ENCAP" $((GSO_SIZE * 4)) 4 1
+		cleanup_all_ns
+
+		# IPv4 only test
+		[ $FAMILY = "4" ] || continue
+		create_ns_gso
+		ip netns exec "$NS_SRC" sysctl -qw net.ipv4.ip_no_pmtu_disc=1
+		run_test "GSO disable due to no fixedid - $ENCAP" \
+			$((GSO_SIZE * 4)) 4 4
+		cleanup_all_ns
+	done
+
+	# GRO tests imply/require geneve encap, the only one providing
+	# GRO hints
+	create_ns_gso_gro
+	run_test "double tunnel GRO, no hints" $((GSO_SIZE * 4)) 4
+	cleanup_all_ns
+
+	USE_HINT=true
+	create_ns_gso_gro \
+		'"gro-hint":1,"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1' \
+		'"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1'
+	run_test "double tunnel GRO" $((GSO_SIZE * 4)) 1
+	cleanup_all_ns
+
+	create_ns_gso_gro '"gro-hint":1,"udp-csum":1' '"udp-csum":1'
+	run_test "double tunnel GRO - csum complete" $((GSO_SIZE * 4)) 1
+	cleanup_all_ns
+
+	create_ns_gso_gro '"gro-hint":1' \
+		'"udp-csum":0,"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1'
+	run_test "double tunnel GRO - no nested csum" $((GSO_SIZE * 4)) 1
+	cleanup_all_ns
+
+	create_ns_gso_gro \
+		'"gro-hint":1,"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1' \
+		'"udp-csum":1'
+	run_test "double tunnel GRO - skip due nested csum with outer 0-csum" \
+		$((GSO_SIZE * 4)) 4
+	cleanup_all_ns
+
+	INHERIT=true
+	create_ns_gso_gro '"gro-hint":1,"udp-csum":1' \
+		'"udp-csum":1,"inner-proto-inherit":1'
+	run_test "double tunnel GRO - nested inherit proto" $((GSO_SIZE * 4)) 1
+	cleanup_all_ns
+	unset INHERIT
+
+	create_ns_gso_gro '"gro-hint":1'
+	run_test "double tunnel GRO - short last pkt" \
+		$((GSO_SIZE * 4 + GSO_SIZE / 2)) 2
+	cleanup_all_ns
+done
+
+exit "$EXIT_STATUS"
-- 
2.52.0


