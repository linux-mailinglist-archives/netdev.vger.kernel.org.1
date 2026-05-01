Return-Path: <netdev+bounces-283184-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uAvJHV6t9GkwDgIAu9opvQ
	(envelope-from <netdev+bounces-283184-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:40:46 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C91174ACCED
	for <lists+netdev@lfdr.de>; Fri, 01 May 2026 15:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3080F302DB6B
	for <lists+netdev@lfdr.de>; Fri,  1 May 2026 13:39:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4023B2FCC;
	Fri,  1 May 2026 13:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LSR3tq9N"
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 656DF36921B
	for <netdev@vger.kernel.org>; Fri,  1 May 2026 13:39:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777642789; cv=none; b=BDTOjoVeVGaArR4joSQAgg4FUdoRkF3OP+A3YxxWia2NKkgNvoNIdRnwgKRUmJBjWiApGbwjXiRi0OPWcErnuystD++mTuNGGlUDDX++uH6dE3QAIMwBGUw/YD6dUObezwxw4mMao+a/TBLsfEOpZHPQHYqp7pNhYd966vO/v7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777642789; c=relaxed/simple;
	bh=zyAEpvzmz1i1vmWVvojLR0++WnR+rfzCXhcO9WdNd+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VXazOU+avx7HKJDCD2i+9WTFcQWDk9SJFq4XWGrq8GKEHH5/CIwTBt+nHTXhIACK7fHBu5gCK/a5YMj7zJC4YECZBGOF6ZZWf1gxftNvBUJNhv0EURYa8Cph/Aq8mj2j15tCSLLN00GKIZDG49bJbm/bNIs+Rj1hs4DVWcLa0xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LSR3tq9N; arc=none smtp.client-ip=209.85.216.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f53.google.com with SMTP id 98e67ed59e1d1-36505450d0dso154863a91.1
        for <netdev@vger.kernel.org>; Fri, 01 May 2026 06:39:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777642787; x=1778247587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=S9dujcCTcBtWqsxKxFY2R1ovfB7aW0cYQVgKhmNRcsw=;
        b=LSR3tq9NgZbnoIgOXegxrHVkU1ym0EfBlRIEM41dprLiDy7DLsXqR/A9U5KY9hvsdH
         M8SK58CRrFJ3X4w4oYO9UaFp6jVwKi4k8VjOlSp8uvzXHOSGWhs9nit0VTku88PnNNFT
         z276O5Vz1EmMrilCqwepYY4qihddCC7kXXYiOkbJTCc/TNHA78isZ0PiHwjq9+zkewGO
         dVE9yQ52eTV2o/fHPlyY+wSKAhoemiV8RdHmKu1Tv8yxMD9XWaAEeKvhQCUFl7kos5lw
         uDJ8lYDYQGFtViAzJmH13RhlSKu1LyFy+e6dJJ3cHJLznm/U2WgVSDeWzSkWJkohhp64
         tZ6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777642787; x=1778247587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=S9dujcCTcBtWqsxKxFY2R1ovfB7aW0cYQVgKhmNRcsw=;
        b=Ekd+uCYEnHnEwkY1nmEauLNXcwx0YsKcuSU/f9wPUH0pMk7qzVhxdCdevTM2zO7frX
         kFdUSNboYCSmucHmf0Ppo15fZezRGuNiZtlWYD/uCdh0FZPJ7ZfyQ169pMd1nuMqT/ws
         CYsSM/68L9RzD9Lqe27IKr+fs1k2DEE3cPMC2eH7W3RvadaOUdmDk+MsAkbsImPz21Nc
         ypk5Wl4tD3phNzpKIjpgshkJvQD+CVuisRiwulSpybUfS2+MoNSSjX8Zm6u0jXhVReRt
         ECheAyooj2UjY9VV39FXihizxkAnzDbsnVm52yde80dLbNo8I/c+ry6PtPPzF984qJiF
         xYdQ==
X-Gm-Message-State: AOJu0Yxt62CXp/KijXgKRF/kJr1HAKH9GdKbHgB73S+14ur5hw5OmED2
	KI9I44vgDeLqedivnm9515cW96e4DEfeGg1HBitrHvGhcYSOoKW6OXVMFzR0nLlMIPZcNw==
X-Gm-Gg: AeBDiev8Jp1ijWgpGfXXARb5qTJBC0CcgPrwLd4EkkBGKRReg4QWS8yahSOzP5/bv99
	tk7KOwsIDQFnVYHb1LvmlKD+0rbuL/vt7Z6b3n6oFfrCn6gMLPlLo/uYH5c6ffQaXh7itP69xNY
	GCowpSjsD2CjyjXuJ+30b2RsMoACRfntoGnpfl3xwlN3ICUrkfpyPDDOUTHaqvMIl4FzSdxw31c
	VRHJF7ysfSbrAdSuMGM9+DNWEy1Zd91/hWUmu3r8GvYvORPA9B3v1Jct7z4Db4lqHgP2YqNPXp+
	ipiKAq3H1y2CPFq5W/jyv3ui/GXC3/O3HwH1dPbdv0fnaKjgERUrVfJ+Tzpx9RxA+9/byozOrV/
	NN43VrDlhD7vh0Xdu5uMtjoxEq76Wc9FhBQ3nVKr9p2dDN25e3pIVLvNnVAsfi4GgqZmyjyPD52
	mFoLsXPxKa/94v0iD/SHtBKNVm1BU=
X-Received: by 2002:a05:6a20:6a0a:b0:3a2:d838:bfda with SMTP id adf61e73a8af0-3a45fe26b94mr3744683637.46.1777642787200;
        Fri, 01 May 2026 06:39:47 -0700 (PDT)
Received: from houminxi ([38.207.130.223])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-835158aa1ffsm2548386b3a.22.2026.05.01.06.39.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 May 2026 06:39:46 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org,
	dev@openvswitch.org,
	Minxi Hou <houminxi@gmail.com>,
	Aaron Conole <aconole@redhat.com>,
	Eelco Chaudron <echaudro@redhat.com>,
	Ilya Maximets <i.maximets@ovn.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Shuah Khan <shuah@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 2/2] selftests: openvswitch: add pop_vlan test
Date: Fri,  1 May 2026 21:39:23 +0800
Message-ID: <20260501133924.3100680-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260501133924.3100680-1-houminxi@gmail.com>
References: <20260501133924.3100680-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: C91174ACCED
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,openvswitch.org,gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-283184-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Add a test for the OVS datapath POP_VLAN action.  The test uses
the VLAN sub-interface of a veth pair to generate 802.1Q tagged
frames and verifies that pop_vlan correctly strips the VLAN tag
before delivery via pcap frame capture.

The test has two verifications:
- Negative: forward tagged frames without pop_vlan, verify the
  VLAN tag is still present on the egress interface.
- Positive: apply pop_vlan, verify the tag is removed and an
  untagged ICMP echo request arrives at the egress interface.

Static ARP entries avoid the complexity of VLAN-tagged ARP
resolution (the egress side has no VLAN sub-interface and cannot
process tagged ARP).

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
v1 -> v2: rebase to latest net-next/main, drop --base=auto

 .../selftests/net/openvswitch/openvswitch.sh  | 132 ++++++++++++++++++
 1 file changed, 132 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index b327d3061ed5..cd614ff7b740 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -27,6 +27,7 @@ tests="
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
 	drop_reason				drop: test drop reasons are emitted
+	pop_vlan					vlan-pop: POP_VLAN action strips 802.1Q tag
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -830,6 +831,137 @@ test_tunnel_metadata() {
 	return 0
 }
 
+test_pop_vlan() {
+	modprobe -q openvswitch 2>/dev/null || true
+	[ -d /sys/module/openvswitch ] || return $ksft_skip
+	ip netns add __test_pop_vlan_netns__ 2>/dev/null || \
+		{ info "CONFIG_NET_NS missing"; return $ksft_skip; }
+	ip netns del __test_pop_vlan_netns__ 2>/dev/null
+	modprobe -q 8021q 2>/dev/null || true
+	[ -d /sys/module/8021q ] || { info "CONFIG_VLAN_8021Q missing"; return $ksft_skip; }
+
+	local sbx="test_pop_vlan"
+	sbx_add "$sbx" || return $ksft_skip
+	ovs_add_dp "$sbx" vlandp || return 1
+
+	# --- baseline: untagged forwarding ---
+	ovs_add_netns_and_veths "$sbx" vlandp ns1 veth1 ns1veth 192.0.2.1/24 || return 1
+	ovs_add_netns_and_veths "$sbx" vlandp ns2 veth2 ns2veth 192.0.2.2/24 || return 1
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
+	# Register cleanup before creating resources (safe on failure paths)
+	on_exit "ip -n ns1 link del ns1veth.10 2>/dev/null || true
+		 ip -n ns2 addr del 198.51.100.2/24 dev ns2veth 2>/dev/null || true"
+
+	# ns1: VLAN sub-interface generates tagged frames
+	ip -n ns1 link add link ns1veth name ns1veth.10 type vlan id 10
+	ip -n ns1 addr add 198.51.100.1/24 dev ns1veth.10
+	ip -n ns1 link set ns1veth.10 up
+
+	# ns2: no VLAN sub-interface. POP delivers untagged frames to ns2veth
+	ip -n ns2 addr add 198.51.100.2/24 dev ns2veth
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
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(1),eth(),eth_type(0x8100),vlan(vid=10),encap(eth_type(0x0800),ipv4(src=198.51.100.1,proto=1),icmp())' \
+		'2' || return 1
+
+	local pcap_no_pop
+	pcap_no_pop=$(mktemp --suffix=.pcap)
+	on_exit "rm -f $pcap_no_pop"
+	ip netns exec ns2 tcpdump -nei ns2veth -w "$pcap_no_pop" -U &
+	local tpid_no_pop=$!
+	on_exit "kill $tpid_no_pop 2>/dev/null || true"
+	sleep $((WAIT_TIMEOUT / 5 < 2 ? 2 : WAIT_TIMEOUT / 5))
+
+	ip netns exec ns1 ping -I ns1veth.10 -c 3 -W 1 198.51.100.2 \
+		>/dev/null 2>&1 || true
+	kill $tpid_no_pop 2>/dev/null || true; wait $tpid_no_pop 2>/dev/null || true
+
+	# assert: VLAN tag still present (no pop_vlan in action)
+	tcpdump -nr "$pcap_no_pop" 'vlan' 2>/dev/null | grep -q . || {
+		info "FAIL: negative check: no VLAN tag (expected tag present)"; return 1
+	}
+
+	ovs_del_flows "$sbx" vlandp
+
+	# --- Positive: pop_vlan strips tag ---
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(1),eth(),eth_type(0x8100),vlan(vid=10),encap(eth_type(0x0800),ipv4(src=198.51.100.1,proto=1),icmp())' \
+		'pop_vlan,2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	local pcap
+	pcap=$(mktemp --suffix=.pcap)
+	on_exit "rm -f $pcap"
+	ip netns exec ns2 tcpdump -nei ns2veth -w "$pcap" -U &
+	local tpid=$!
+	on_exit "kill $tpid 2>/dev/null || true"
+	sleep $((WAIT_TIMEOUT / 5 < 2 ? 2 : WAIT_TIMEOUT / 5))
+
+	# ping reply unreachable: ns1veth.10 only accepts tagged frames,
+	# ns2 sends untagged reply -> dropped by ns1veth.10.
+	local ping_rc=0
+	ip netns exec ns1 ping -I ns1veth.10 -c 3 -W 1 198.51.100.2 \
+		>/dev/null 2>&1 || ping_rc=$?
+	kill $tpid 2>/dev/null || true; wait $tpid 2>/dev/null || true
+
+	# ping failure is expected (reply path asymmetric)
+	[ "$ping_rc" -ne 0 ] || \
+		info "NOTE: ping succeeded unexpectedly (reply reached ns1veth.10)"
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


