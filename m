Return-Path: <netdev+bounces-251988-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDGgDNkFcWmgbAAAu9opvQ
	(envelope-from <netdev+bounces-251988-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:59:05 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FBC85A3E9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C4752B200D9
	for <lists+netdev@lfdr.de>; Wed, 21 Jan 2026 16:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26DF747A0B5;
	Wed, 21 Jan 2026 16:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmFnnjBk"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3C52423A85
	for <netdev@vger.kernel.org>; Wed, 21 Jan 2026 16:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769011988; cv=none; b=mfU+8KTys5vDA1KIXeWzJEfCw1srEOdRV8H/boxy4EdIIjbUzpiqKqCRiM5RfJOrvhN0hASfaK4VbP7o6YsjV7W7m3k2p2VzG34fHH1hdSzR9VlVf/zhv9PkyZGndBypHLhopubSXRyOoae0yBgTh+bqq0dvvkAYvl1TSwqzWkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769011988; c=relaxed/simple;
	bh=p8RaxsVAwV1jY3wu0PYV2U94OYD/sSFWQprZn6WrA+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nhG5ngb/ZgfGbzyRRwFna5sT+Ws0Vs3CVigy9Si1gPszvSQD0EC1UmHpph6BL1/nH16i4kU66hNA2T3oPcC3roUZC7QVLoqUvObNGYqd+ZngCEtcLPs/aw7iCW7/+y8/1C0LuX04oDQoo4AJewMEwEWVZ3fZPa46PwcH6Yh86b4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AmFnnjBk; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769011983;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R350v4NZb92rcK636RJga6sGbdNCvbPGnoUXK2ix8Po=;
	b=AmFnnjBk7J0vuJBkVCLf/mjCi0GyGBtZBiYAG5bOrxGCMSbpYzKtl+Oq0kFbcb/5eJMiVp
	TIJfkAJ/H2PoWeEDQ+XU8+13bTpNm2A8mc7NoGRDPSa2AmD1P7A4zScdKfxa766juFhe5n
	PswqSoJkRV0jjS6KMCWHRvsHchHUBp8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-327-CcO84MppNKmffBd_eQnBtg-1; Wed,
 21 Jan 2026 11:12:55 -0500
X-MC-Unique: CcO84MppNKmffBd_eQnBtg-1
X-Mimecast-MFC-AGG-ID: CcO84MppNKmffBd_eQnBtg_1769011974
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1321E18005B0;
	Wed, 21 Jan 2026 16:12:54 +0000 (UTC)
Received: from gerbillo.redhat.com (unknown [10.45.225.3])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 516881800240;
	Wed, 21 Jan 2026 16:12:50 +0000 (UTC)
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
Subject: [PATCH v5 net-next 10/10] selftests: net: tests for add double tunneling GRO/GSO
Date: Wed, 21 Jan 2026 17:11:36 +0100
Message-ID: <61f2c98ba0f73057c2d6f6cb62eb807abd90bf6b.1769011015.git.pabeni@redhat.com>
In-Reply-To: <cover.1769011015.git.pabeni@redhat.com>
References: <cover.1769011015.git.pabeni@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Spamd-Result: default: False [1.04 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-251988-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,gmail.com,lunn.ch,fomichev.me,nvidia.com,blackwall.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FROM_NEQ_ENVFROM(0.00)[pabeni@redhat.com,netdev@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	DKIM_TRACE(0.00)[redhat.com:+];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,lib.sh:url]
X-Rspamd-Queue-Id: 9FBC85A3E9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Create a simple, netns-based topology with double, nested UDP tunnels and
perform TSO transfers on top.

Explicitly enable GSO and/or GRO and check the skb layout consistency with
different configuration allowing (or not) GSO frames to be delivered on
the other end.

The trickest part is account in a robust way the aggregated/unaggregated
packets with double encapsulation: use a classic bpf filter for it.

Signed-off-by: Paolo Abeni <pabeni@redhat.com>
---
v3 -> v4:
  - use xfail_on_slow and moved the main tests loop in its own function
  - deduplicated some code in create_ns_gso()
  - consistently re-intented all multi-line statements

v1 -> v2:
  - fixed a few shellcheck issues
  - added bpf filter to improve accounting
---
 tools/testing/selftests/net/Makefile          |   1 +
 tools/testing/selftests/net/config            |   1 +
 .../testing/selftests/net/double_udp_encap.sh | 393 ++++++++++++++++++
 3 files changed, 395 insertions(+)
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
index 000000000000..9aaf97cdf141
--- /dev/null
+++ b/tools/testing/selftests/net/double_udp_encap.sh
@@ -0,0 +1,393 @@
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
+	   --do newlink  --json "{\"ifname\": \"$gnv_dev\",
+	       \"linkinfo\": {\"kind\":\"geneve\",
+	       \"data\": $gnv_json } }" > /dev/null
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
+	   remote "$bm_rem_addr" "${opts[@]}"
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
+	   peer name "veth$DST" netns "$NS_DST"
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
+		   sysctl -qw net.ipv4.tcp_wmem="4096 4194304 4194304"
+
+		# note that 3 - $SRC == $DST and 3 - $DST == $SRC
+		if [ $FAMILY = "4" ]; then
+			ip -n "$ns" addr add dev "veth$id" "$NET_V4$id/24"
+			$create_endpoint "$ns" "$NET_V4$((3 - id))" \
+			   "$dev$id" 4 "$options"
+			ip -n "$ns" addr add dev "$dev$id" "$OL1_NET_V4$id/24"
+
+			# nested tunnel devices
+			# pmtu can't be propagated to upper layer devices;
+			# need manual adjust
+			$create_endpoint "$ns" "$OL1_NET_V4$((3 - id))" \
+			   "$dev"_nst"$id" 40 "$nested_opt"
+			ip -n "$ns" addr add dev "$dev"_nst"$id" \
+			   "$OL2_NET_V4$id/24"
+			ip -n "$ns" link set dev "$dev"_nst"$id" mtu 1392
+		else
+			ip -n "$ns" addr add dev "veth$id" "$NET_V6$id/64" \
+			   nodad
+			$create_endpoint "$ns" "$NET_V6$((3 - id))" \
+			   "$dev"6"$id" 6 "$options"
+			ip -n "$ns" addr add dev "$dev"6"$id" \
+			   "$OL1_NET_V6$id/64" nodad
+
+			$create_endpoint "$ns" "$OL1_NET_V6$((3 - id))" \
+			   "$dev"6_nst"$id" 60 "$nested_opt"
+			ip -n "$ns" addr add dev "$dev"6_nst"$id" \
+			   "$OL2_NET_V6$id/64" nodad
+			ip -n "$ns" link set dev "$dev"6_nst"$id" mtu 1352
+		fi
+		id=$((id+1))
+	done
+
+	# enable GRO heuristic on the veth peer and ensure UDP L4 over tunnel is
+	# actually segmented
+	for feature in tso tx-udp_tnl-segmentation; do
+		ip netns exec "$NS_SRC" ethtool -K "veth$SRC" \
+		   "$feature" off 2>/dev/null
+	done
+}
+
+create_ns_gso() {
+	local dev
+
+	create_ns "$@"
+	if [ "$ENCAP" = "geneve" ]; then
+		dev=gnv
+	else
+		dev=vx
+	fi
+	[ "$FAMILY" = "6" ] && dev="$dev"6
+	ip netns exec "$NS_SRC" ethtool -K "$dev$SRC" \
+	   tx-gso-partial on \
+	   tx-udp_tnl-segmentation on \
+	   tx-udp_tnl-csum-segmentation on
+}
+
+create_ns_gso_gro() {
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
+	   -m length --length 600:65535 -m bpf --bytecode "$bpf_filter"
+	ip netns exec "$NS_DST" "$ipt" -A INPUT -p udp --dport "$dport" \
+	   -m length --length 600:65535 -m bpf --bytecode "$bpf_filter"
+	ip netns exec "$NS_DST" ./udpgso_bench_rx -C 2000 -t -R 100 \
+	   -n "$pkts" "${rx_args[@]}" &
+	local pid=$!
+	wait_local_port_listen "$NS_DST" 8000 tcp
+	ip netns exec "$NS_SRC" ./udpgso_bench_tx -"$FAMILY" -t -M 1 \
+	   -s "$total_size" -D "$dst"
+	local ret=$?
+	check_err "$ret" "client failure exit code $ret"
+	wait "$pid"
+	ret=$?
+	check_err "$ret" "sever failure exit code $ret"
+
+	snd=$(ip netns exec "$NS_SRC" "$ipt"-save -c |
+	    grep "dport $dport" | sed -e 's/\[//' -e 's/:.*//')
+
+	[ "$snd" = "$wire_pkts" ]
+	# shellcheck disable=SC2319 # known false positive
+	check_err $? "send $snd packets on the lowest link, expected $wire_pkts"
+
+	rcvpkts=$(ip netns exec "$NS_DST" "$ipt"-save -c | \
+	   grep "dport $dport" | sed -e 's/\[//' -e 's/:.*//')
+
+	[ "$rcvpkts" = "$encappkts" ]
+	check_err $? "received $rcvpkts $ENCAP packets, expected $encappkts"
+	log_test "$msg"
+}
+
+run_tests() {
+	for FAMILY in 4 6; do
+		NET=$OL2_NET_V4
+		GSO_SIZE=1340 # 1392 - 20 - 32
+
+		if [ $FAMILY = 6 ]; then
+			NET=$OL2_NET_V6
+			GSO_SIZE=1280 # 1352 - 40 - 32
+		fi
+
+		echo "IPv$FAMILY"
+
+		unset USE_HINT
+		unset INHERIT
+
+		# "geneve" must be last encap in list, so that later
+		# test cases will run on it
+		for ENCAP in "vxlan" "geneve"; do
+			create_ns
+			run_test "No GSO - $ENCAP" $((GSO_SIZE * 4)) 4 4
+			cleanup_all_ns
+
+			create_ns_gso
+			run_test "GSO without GRO - $ENCAP" $((GSO_SIZE * 4)) \
+			   4 1
+			cleanup_all_ns
+
+			# IPv4 only test
+			[ $FAMILY = "4" ] || continue
+			create_ns_gso
+			ip netns exec "$NS_SRC" \
+			   sysctl -qw net.ipv4.ip_no_pmtu_disc=1
+			run_test "GSO disable due to no fixedid - $ENCAP" \
+			   $((GSO_SIZE * 4)) 4 4
+			cleanup_all_ns
+		done
+
+		# GRO tests imply/require geneve encap, the only one providing
+		# GRO hints
+		create_ns_gso_gro
+		run_test "double tunnel GRO, no hints" $((GSO_SIZE * 4)) 4
+		cleanup_all_ns
+
+		# hint option is expected for all the following tests in the RX
+		# path
+		USE_HINT=true
+		create_ns_gso_gro \
+		   '"gro-hint":1,"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1' \
+		   '"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1'
+		run_test "double tunnel GRO" $((GSO_SIZE * 4)) 1
+		cleanup_all_ns
+
+		create_ns_gso_gro '"gro-hint":1,"udp-csum":1' '"udp-csum":1'
+		run_test "double tunnel GRO - csum complete" $((GSO_SIZE * 4))\
+		   1
+		cleanup_all_ns
+
+		create_ns_gso_gro '"gro-hint":1' \
+		   '"udp-csum":0,"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1'
+		run_test "double tunnel GRO - no nested csum" \
+		   $((GSO_SIZE * 4)) 1
+		cleanup_all_ns
+
+		create_ns_gso_gro \
+		   '"gro-hint":1,"udp-zero-csum6-tx":1,"udp-zero-csum6-rx":1' \
+		   '"udp-csum":1'
+		run_test "double tunnel GRO - nested csum, outer 0-csum, skip"\
+		   $((GSO_SIZE * 4)) 4
+		cleanup_all_ns
+
+		INHERIT=true
+		create_ns_gso_gro '"gro-hint":1,"udp-csum":1' \
+		   '"udp-csum":1,"inner-proto-inherit":1'
+		run_test "double tunnel GRO - nested inherit proto" \
+		   $((GSO_SIZE * 4)) 1
+		cleanup_all_ns
+		unset INHERIT
+
+		create_ns_gso_gro '"gro-hint":1'
+		run_test "double tunnel GRO - short last pkt" \
+		   $((GSO_SIZE * 4 + GSO_SIZE / 2)) 2
+		cleanup_all_ns
+	done
+}
+
+require_command nfbpf_compile
+require_command jq
+
+# tcp retransmisions will break the accounting
+xfail_on_slow run_tests
+exit "$EXIT_STATUS"
-- 
2.52.0


