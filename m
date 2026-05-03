Return-Path: <netdev+bounces-283595-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CAcOHyg792kddwIAu9opvQ
	(envelope-from <netdev+bounces-283595-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:10:16 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194804B57EE
	for <lists+netdev@lfdr.de>; Sun, 03 May 2026 14:10:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 502E530041D7
	for <lists+netdev@lfdr.de>; Sun,  3 May 2026 12:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4323AD53B;
	Sun,  3 May 2026 12:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PY4AcKbu"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117D93AE6F7
	for <netdev@vger.kernel.org>; Sun,  3 May 2026 12:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777810212; cv=none; b=i1E1ASA9dBV4OLLWErF9zs7cPFzL3sDrNHy5BWOM5rIEJ06PzBV+tUZCbgv0F60bjnf0S/JkHnTfW/9R850+StW+uKR8gnHyv3BnUUVtgBLQuWsFlgEp2jCa7tsDTK31NpLflDiO8NBv44l/5Yx/P2wMA8EK0kQETl8fu+qaf9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777810212; c=relaxed/simple;
	bh=XlUugGJtLnGBZa4wpf2pYBuA26BXI5OIqvgYb1MXFd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dZBYc0TbRoPENoEdwqiezyQFosgarXyBYSqbvVBldUt+smh5/PitM3hlkZvoTuP7WoXVRaD7hkE8GOK+RKVcs6DrQAv0XnPYrV0pekJmp7NyfHgBpRRdNBJPNkgFrQDaqHSIP+nZaSRbj5UoamZShoN5RKAXcyr42Zoqb7nHQrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PY4AcKbu; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-82d0b68837aso1665637b3a.2
        for <netdev@vger.kernel.org>; Sun, 03 May 2026 05:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777810210; x=1778415010; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bBT87zeulFbQawsr/F70tT9UHb1ai/WZa/Vf0WYk0fw=;
        b=PY4AcKbuKGfGGbyvvPdZagWtDqwcQyjtdKdttjOGd04hNnMia78aFtGApetRQRLv6s
         iygGCjZHdcZfl28hbbVnikGjPAm2oz8P+De/lb3LeJFlXUK3qBI/qmIUAnhegBnGpIsm
         O2OV6eiuNpq33nn85MwyMuq6sBr0aYBj6CPZgnNOkxcqnfpTDDBc8e1CSrEyYwF4zBSm
         bzyLbkx9QHNzFlOLW4qkwygdT5FwHxl/4AlX+POdVvwhJfDPs7b7c4BZJE9w0JoS0IxW
         ueLloIa0S4tqfA9vSA3GN7VisVrjDjqBngOtLs2b/KUr23uGj/N9xLMezCf9SZJGAHVC
         x22Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777810210; x=1778415010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bBT87zeulFbQawsr/F70tT9UHb1ai/WZa/Vf0WYk0fw=;
        b=Bsr8IaQBgKLlC+pAYwFENmjdsP0xQo8AqDFX1bDhDXnrybFIRPOYrzuuPas6Zl/u2X
         md5O/0yjO6VETyYvIxg04K8H6tB7IBo5ZD0J1lzJD2SWhXvNYvxpSCR+fKeoGC851EJ+
         C9TbYVlcNEIcOn04kyFSe0DCgwysSmTWzwsrzV2TU6ChTyqbIyDmtzlSSZ0P9R6aHO70
         YIntvLFYD0mtm05qBCxSSp9o6uV2uWwvcqHUo5cjLunslQIzdHJZBiNJYoOFOAOcC1Q8
         I0J2rDJUgHTr69PehgIr8nXF1jfigVdieUKdhgckDFb6krxtaB4f8Q/IAa+NhX4LDjNM
         cEMQ==
X-Gm-Message-State: AOJu0YwCp3CuZT63968kteizGCdfASp86Dg0qR7bu98L2DhAdyKZD64M
	JnL5QZj0vF2MT1Nu/XNPTuQTWRY+3BfB8solOWOKHW6sDFxKFqhx6nBJBt5s+agYjrU=
X-Gm-Gg: AeBDievw5XEGoqtl1gyByz/xe5W3G8ZDFriYvrhttDLoiYM/pl8OFAu8vgY2qVVlEIZ
	5SroMlwl4tq42t3PlNIEs1Waa7Pp11sT/bj9XLz50P/T7/NdGRccfzFHjuvK9giDdsUZD7qcrL4
	1PqNI5kFozLrr6eR5E0QoB6JwmL0/fZ1pbBr8WBvMwRvOu3CiGVK4smOOjbXUsNPgtsje5oWpzQ
	9kPwOx6VmjVabvf48YPOYGVua79oJzozpOhRdWcKPn0nVa9wzTSzKsnrDQ2HGp60JoXcTI7WL9v
	0XvUQJVMjXOuS4tSgUhR7Uioja9p3/C7SqFMCsGN9/O4vSLWeZ/HjLgQJ+oTT5kIX0XVf1u5xKn
	qRBpEVBYwJyxrMwmEo29BBCRvnuv7AW/ZxpBkRNHTYh/EA4eH6ELau1dSxXf/EMX83SK/Xp9xaf
	xVwY+RG3arOWvFKxLV+hQRkC8CWPA=
X-Received: by 2002:aa7:9a87:0:b0:82f:abc8:ae0 with SMTP id d2e1a72fcca58-8352d1f76fdmr5689460b3a.17.1777810209792;
        Sun, 03 May 2026 05:10:09 -0700 (PDT)
Received: from houminxi ([151.242.165.70])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83515acfd8csm8240218b3a.29.2026.05.03.05.10.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 May 2026 05:10:08 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v3 2/2] selftests: openvswitch: add pop_vlan test
Date: Sun,  3 May 2026 20:09:46 +0800
Message-ID: <20260503120946.51869-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260503120946.51869-1-houminxi@gmail.com>
References: <20260503120946.51869-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 194804B57EE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-283595-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[netdev];
	RCPT_COUNT_SEVEN(0.00)[11];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
correctly strips 802.1Q VLAN tags from frames.

Test structure:
- Baseline: untagged forwarding validates basic connectivity.
- Negative: forward without pop_vlan, assert VLAN tag preserved.
- Positive: forward with pop_vlan, assert tag stripped and
  untagged ICMP echo request arrives.

Add start_capture/stop_capture helpers using ovs_wait for
deterministic tcpdump readiness instead of ad-hoc sleep.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 192 ++++++++++++++++++
 1 file changed, 192 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index b327d3061ed5..7c937b48d9b6 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -27,6 +27,7 @@ tests="
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
 	drop_reason				drop: test drop reasons are emitted
+	pop_vlan					vlan-pop: POP_VLAN action strips 802.1Q tag
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -830,6 +831,197 @@ test_tunnel_metadata() {
 	return 0
 }
 
+# Start tcpdump capture with deterministic readiness wait.
+# Usage: start_capture <netns> <iface> <pcap_path> <out_pid_var> <out_log_var>
+# $4 and $5 are variable NAMES — start_capture writes the tcpdump PID
+# and log path into those caller variables via nameref (bash 4.3+).
+# Contract: caller MUST call stop_capture with the returned PID and log
+#           before returning from the function.
+start_capture() {
+	local ns="$1" iface="$2" pcap="$3"
+	local -n _out_pid="$4"
+	local -n _out_log="$5"
+	local log pid
+
+	command -v tcpdump >/dev/null 2>&1 || {
+		info "tcpdump missing"
+		return $ksft_skip
+	}
+
+	log=$(mktemp)
+	ip netns exec "$ns" tcpdump -nei "$iface" \
+		-w "$pcap" -U 2>"$log" &
+	pid=$!
+	ovs_wait grep -q "listening on" "$log" || {
+		kill $pid 2>/dev/null
+		wait $pid 2>/dev/null
+		rm -f "$log"
+		info "FAIL: tcpdump failed to start on $iface"
+		return 1
+	}
+	kill -0 $pid 2>/dev/null || {
+		wait $pid 2>/dev/null
+		rm -f "$log"
+		info "FAIL: tcpdump died after start on $iface"
+		return 1
+	}
+	# $pid/$log expand now (intentional — captures concrete values)
+	on_exit "kill $pid 2>/dev/null; rm -f $log"
+	_out_pid=$pid
+	_out_log=$log
+}
+
+# Stop capture and cleanup temp files.
+# Usage: stop_capture <pid> <log_path>
+stop_capture() {
+	kill "$1" 2>/dev/null
+	wait "$1" 2>/dev/null
+	rm -f "$2"
+}
+
+test_pop_vlan() {
+	modprobe -q openvswitch 2>/dev/null || true
+	[ -d /sys/module/openvswitch ] || return $ksft_skip
+	local ns_err
+	ns_err=$(mktemp)
+	if ! ip netns add __test_pop_vlan_netns__ 2>"$ns_err"; then
+		if grep -q "File exists" "$ns_err"; then
+			ip netns del __test_pop_vlan_netns__ 2>/dev/null
+		else
+			info "CONFIG_NET_NS missing or unavailable"
+			rm -f "$ns_err"
+			return $ksft_skip
+		fi
+	fi
+	ip netns del __test_pop_vlan_netns__ 2>/dev/null
+	rm -f "$ns_err"
+	modprobe -q 8021q 2>/dev/null || true
+	[ -d /sys/module/8021q ] || \
+		{ info "CONFIG_VLAN_8021Q missing"; return $ksft_skip; }
+
+	local sbx="test_pop_vlan"
+	sbx_add "$sbx" || return $?
+	ovs_add_dp "$sbx" vlandp || return 1
+
+	# Validate basic connectivity before testing pop_vlan.
+	# --- baseline: untagged forwarding ---
+	ovs_add_netns_and_veths "$sbx" vlandp \
+		ns1 veth1 ns1veth 192.0.2.1/24 || return 1
+	ovs_add_netns_and_veths "$sbx" vlandp \
+		ns2 veth2 ns2veth 192.0.2.2/24 || return 1
+
+	# ARP + IPv4 bidirectional (all untagged)
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+	ip netns exec ns1 ping -c 3 -W 2 192.0.2.2 || return 1
+
+	# --- POP_VLAN test ---
+	# ns1: VLAN sub-interface generates tagged frames
+	ip -n ns1 link add link ns1veth name ns1veth.10 \
+		type vlan id 10 || return 1
+	on_exit "ip -n ns1 link del ns1veth.10 2>/dev/null || true"
+	ip -n ns1 addr add 198.51.100.1/24 dev ns1veth.10 || return 1
+	ip -n ns1 link set ns1veth.10 up || return 1
+
+	# ns2: no VLAN sub-interface. POP delivers untagged frames to ns2veth
+	ip -n ns2 addr add 198.51.100.2/24 dev ns2veth || return 1
+	on_exit "ip -n ns2 addr del 198.51.100.2/24 dev ns2veth 2>/dev/null || true"
+
+	# veth disable VLAN offload + GRO (ensure kernel software tag processing)
+	if command -v ethtool >/dev/null 2>&1; then
+		ip netns exec ns1 ethtool -k ns1veth 2>/dev/null | grep -q vlan-offload && \
+			ip netns exec ns1 ethtool -K ns1veth rx-vlan-offload off \
+				tx-vlan-offload off gro off 2>/dev/null || true
+		ip netns exec ns2 ethtool -k ns2veth 2>/dev/null | grep -q vlan-offload && \
+			ip netns exec ns2 ethtool -K ns2veth rx-vlan-offload off \
+				tx-vlan-offload off gro off 2>/dev/null || true
+	fi
+
+	ovs_del_flows "$sbx" vlandp
+
+	# Static ARP avoids VLAN-tagged ARP complexity (ns2 has no VLAN
+	# sub-interface, so tagged ARP would be invisible to ns2).
+	local ns1veth10mac ns2mac
+	ns1veth10mac=$(ip -n ns1 link show ns1veth.10 | \
+		awk '/link\/ether/ {print $2}')
+	ns2mac=$(ip -n ns2 link show ns2veth | \
+		awk '/link\/ether/ {print $2}')
+	[ -n "$ns1veth10mac" ] && echo "$ns1veth10mac" | \
+		grep -qE "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$" || return 1
+	[ -n "$ns2mac" ] && echo "$ns2mac" | \
+		grep -qE "^([0-9a-fA-F]{2}:){5}[0-9a-fA-F]{2}$" || return 1
+	ip -n ns1 neigh replace 198.51.100.2 lladdr "$ns2mac" \
+		dev ns1veth.10 nud permanent || return 1
+	ip -n ns2 neigh replace 198.51.100.1 lladdr "$ns1veth10mac" \
+		dev ns2veth nud permanent || return 1
+
+	# --- Negative check: fwd without pop_vlan, VLAN tag stays ---
+	local vlan_match='in_port(1),eth(),eth_type(0x8100),'
+	vlan_match+='vlan(vid=10),'
+	vlan_match+='encap(eth_type(0x0800),'
+	vlan_match+='ipv4(src=198.51.100.1,proto=1),icmp())'
+	ovs_add_flow "$sbx" vlandp "$vlan_match" '2' || return 1
+
+	local pcap_no_pop
+	pcap_no_pop=$(mktemp --suffix=.pcap)
+	on_exit "rm -f $pcap_no_pop"
+	local tpid tlog
+	start_capture ns2 ns2veth "$pcap_no_pop" tpid tlog || return $?
+
+	ip netns exec ns1 ping -I ns1veth.10 -c 3 -W 1 198.51.100.2 \
+		>/dev/null 2>&1 || true
+	stop_capture "$tpid" "$tlog"
+
+	# assert: VLAN tag still present (no pop_vlan in action)
+	tcpdump -nr "$pcap_no_pop" 'vlan' 2>/dev/null | grep -q . || {
+		info "FAIL: negative check: no VLAN tag (expected tag present)"
+		return 1
+	}
+
+	ovs_del_flows "$sbx" vlandp
+
+	# --- Positive: pop_vlan strips tag ---
+	ovs_add_flow "$sbx" vlandp "$vlan_match" 'pop_vlan,2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	local pcap
+	pcap=$(mktemp --suffix=.pcap)
+	on_exit "rm -f $pcap"
+	local tpid2 tlog2
+	start_capture ns2 ns2veth "$pcap" tpid2 tlog2 || return $?
+
+	# ns1veth.10 only accepts tagged frames;
+	# ns2 sends untagged reply → dropped by ns1
+	local ping_rc=0
+	ip netns exec ns1 ping -I ns1veth.10 -c 3 -W 1 198.51.100.2 \
+		>/dev/null 2>&1 || ping_rc=$?
+	stop_capture "$tpid2" "$tlog2"
+
+	# ping failure is expected (reply path asymmetric)
+	[ "$ping_rc" -ne 0 ] || {
+		info "FAIL: ping succeeded unexpectedly"
+		return 1
+	}
+
+	# assert: no VLAN tag (POP succeeded), untagged ICMP echo request arrived
+	tcpdump -nr "$pcap" 'vlan' 2>/dev/null | grep -q . && {
+		info "FAIL: POP_VLAN: VLAN tag still present"; return 1
+	}
+	tcpdump -nr "$pcap" 'icmp and icmp[icmptype]=8' \
+		2>/dev/null | grep -q . || {
+		info "FAIL: POP_VLAN: no untagged ICMP echo request"; return 1
+	}
+
+	return 0
+}
+
 run_test() {
 	(
 	tname="$1"
-- 
2.53.0


