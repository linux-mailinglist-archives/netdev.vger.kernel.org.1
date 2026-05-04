Return-Path: <netdev+bounces-283822-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0KBIDxST+Gl8wgIAu9opvQ
	(envelope-from <netdev+bounces-283822-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:37:40 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 38FE64BCF8B
	for <lists+netdev@lfdr.de>; Mon, 04 May 2026 14:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 41FBC30055D7
	for <lists+netdev@lfdr.de>; Mon,  4 May 2026 12:37:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 885A73D331A;
	Mon,  4 May 2026 12:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qFv9L3DX"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1253D3CEB
	for <netdev@vger.kernel.org>; Mon,  4 May 2026 12:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777898253; cv=none; b=OMyHd8WcxoqqhI6FMWS/cfe7hB1rrDKpl7DijjIiuLcxh5QhX5gHy3At7BS6mo9GNrI7XKc6t/6bL23GE6cI1oANKVYWII1zPIrtYW9HVNd4VG47F6qEW+F1z7v2V1B/zWbAwfmlVxgU8ENrqnOO4O5PW53D/T0pKuhIXJu2+uw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777898253; c=relaxed/simple;
	bh=+DI8avLOTl13b/FN2R/ZRTSiP+A/b8wgoK6wpcZeDTg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CjjY8H+nEarWIL3w4YtOXRjH6+uY9cHI58TkmWhounzvGhnZuL+E+i+xpamE7/hoOTszxqWP7yhfw8m9lr+XK3b0GiRsv12J2U2nPd7R189CvGIyyyuwICaDeTFDvxuRxJfyR/cNkTjmNl6G4Cx/aQDALENIJZeQUZKYSv4h9XQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qFv9L3DX; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-364c5317d67so4113475a91.2
        for <netdev@vger.kernel.org>; Mon, 04 May 2026 05:37:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777898251; x=1778503051; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EFdz31SzddWNFV55d5zIFCSNbMbmhSAASGr0Zgjcreg=;
        b=qFv9L3DX65FNxN3J+tcRafI+0gfSTsjhpYY6QrJdQNzA8rachNXGRxwNTbFk/81B3L
         430JT2nKyDiGx/voQynzb23DqZgfapPB+by5R+rgqbcBDHEroF7jAoUAMEHNaCfNfpl0
         K1quQIU47fLIXiJInuZJlqYxklxebxuaW044DrBXtFNOq5WcNDHq6WZBd0ZJOIA06+MO
         s8UcT2+NmLQgMypYEHM4RcqtdbTD0DHsEe+uR1LnaZ443JTt0A41ACIzyYy9Eh6b2uGq
         5h9EPNFJlfexm3nu0Uz2l6JTpAlbBTJFBv4EBu9aUZ2exjEHnyaPW5egYpkFAJmaOFT5
         GbZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777898251; x=1778503051;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EFdz31SzddWNFV55d5zIFCSNbMbmhSAASGr0Zgjcreg=;
        b=h4w7XJRWC/uuLBKUA6eGkBvOK75wJnzC1faB1WuVWThx9baDXZdqqP1UGcDMpX9E3X
         12e9K1MXphNbF5uW2izbk+kMALRPE7KFIu5GbUJXTs4VII3pGemGpuBaVZnJ2RneZCoh
         rkiZm8dSmd+bp4+ueCGBWJ18ITP9TsBYoMrXyB6B86PM/jP+6OcnlJCXXDU9DYfdIL6Y
         GUlMQTz6CVfExoAjEKJeWTviwJEk6zwsij6013EHvKkyG3Bd1j6vxZoqcI8nCTgEshlm
         InrHIVZIrvwLVJbcYC4mp75yHXV+dL/V+xkaF/WtVIh47fSezZqfUafaCrrKdoVphZ4m
         E52g==
X-Gm-Message-State: AOJu0YxfhXFPX8Jyp6biJT9PtPKIhIy66Y6VJuSaachNlYL5/eFEiytJ
	smyYe0cGrii+bnvyiUS+xak0zbEQ79oPAtuKPpL1Xyt8sMDqWISfG4a0171BCBMEzpc=
X-Gm-Gg: AeBDievYoLSVYJKvVfd9k6teImflm4mGdFGwpVWm66rqodZ5g8QG4NZXtW0y1Ar8CfU
	Wyd4ujRdHhscIrA0kRI/HGydKfGqZOcIeF9KaPWuVW62HzdVRsxPRQawuj8x5bcluBlD3dUw5cj
	5EKiXx/Oyf49y3tTK71Iq5NpRZX4kQWnaZkofDxB+248ptazMUCZoSql7urhqexpzc341kgMd/f
	6iHfmwTHDKTAfJJB8yNk2hnI8pbP8g7vzgo7Id+1jz4HOCmZmFq7x0MEDS7aaL9iJ7qOrNPtv6Q
	88K6qFFM9RDNmo7nhBoGgIcmM9g8cMAkhhbvZDDAw4yRkqArJOPQQQyqSRNjaa9Ps1keDDCdIHH
	A2LbO31Shidi01DuMxxVWzkDm5iHysqHuDldBHSvQizbm384vPGBwLpHccPX7LBla+H40WJRSrk
	gnL4W4r/RpK2Sl6/oFF7wA4gwobDc=
X-Received: by 2002:a17:90b:5830:b0:34c:2db6:578f with SMTP id 98e67ed59e1d1-3650cec2b2bmr9884224a91.19.1777898250947;
        Mon, 04 May 2026 05:37:30 -0700 (PDT)
Received: from houminxi ([151.242.165.70])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-364f4558e0dsm5883550a91.2.2026.05.04.05.37.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:37:30 -0700 (PDT)
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
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v4 2/2] selftests: openvswitch: add pop_vlan test
Date: Mon,  4 May 2026 20:37:13 +0800
Message-ID: <20260504123713.555461-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260504123713.555461-1-houminxi@gmail.com>
References: <20260504123713.555461-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 38FE64BCF8B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-283822-lists,netdev=lfdr.de];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]

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
 .../selftests/net/openvswitch/openvswitch.sh  | 196 ++++++++++++++++++
 1 file changed, 196 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index b327d3061ed5..95fb8f824b15 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -27,6 +27,7 @@ tests="
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
 	drop_reason				drop: test drop reasons are emitted
+	pop_vlan				vlan: POP_VLAN action strips tag
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -830,6 +831,201 @@ test_tunnel_metadata() {
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
+	on_exit "ip -n ns2 addr del 198.51.100.2/24 dev ns2veth 2>/dev/null"
+
+	# veth: disable VLAN offload + GRO (force software tag processing)
+	if command -v ethtool >/dev/null 2>&1; then
+		ip netns exec ns1 ethtool -k ns1veth 2>/dev/null \
+			| grep -q vlan-offload && \
+			ip netns exec ns1 ethtool -K ns1veth \
+				rx-vlan-offload off tx-vlan-offload off \
+				gro off 2>/dev/null || true
+		ip netns exec ns2 ethtool -k ns2veth 2>/dev/null \
+			| grep -q vlan-offload && \
+			ip netns exec ns2 ethtool -K ns2veth \
+				rx-vlan-offload off tx-vlan-offload off \
+				gro off 2>/dev/null || true
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
+	# assert: no VLAN tag (POP succeeded), untagged ICMP arrived
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


