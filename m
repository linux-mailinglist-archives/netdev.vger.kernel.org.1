Return-Path: <netdev+bounces-286186-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uFmFO+w8/2kS3wAAu9opvQ
	(envelope-from <netdev+bounces-286186-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:55:56 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D3474FFEED
	for <lists+netdev@lfdr.de>; Sat, 09 May 2026 15:55:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id AF7BB302BBC9
	for <lists+netdev@lfdr.de>; Sat,  9 May 2026 13:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D13F394787;
	Sat,  9 May 2026 13:54:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n5bKHCiK"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f41.google.com (mail-ot1-f41.google.com [209.85.210.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D3EE39479F
	for <netdev@vger.kernel.org>; Sat,  9 May 2026 13:54:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778334897; cv=none; b=Q1F44K8c7wtjbPqixlmy4b8JLLZlrsUPmmE0ZhmpKdZKbh23fTihc4+HxZrpKw6A6XbZsP4ihxo7y+uiDRE/M2f1K68G7fQ8BpBGyMjM6rBVgCZnpSKKncz11T7K4ymqHq5aKqwFuxBGBhtOGoXUQAy6YpemGdUv+aSazqAiEMQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778334897; c=relaxed/simple;
	bh=GQeOcJ4x5WRRquDnsAee0Zm2Twr2g7DVIbPAVoTtP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ah6R8TzJ7bTlJlq9gBieNMb4zj5XTFXAYFs06Q+Y3hzspzkVp+d0J6T8aeYwf+E1wZe79FKkGL87o60ylrZqsv+tdRNPVmKw+BI6nrPfn1FGV7CcyjYRekcPcdRxHJx8WUxVnlB092MuTzC12dU7cP/e5xbhs62raff7J6tZKCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n5bKHCiK; arc=none smtp.client-ip=209.85.210.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f41.google.com with SMTP id 46e09a7af769-7dcdaf06498so2164306a34.2
        for <netdev@vger.kernel.org>; Sat, 09 May 2026 06:54:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778334894; x=1778939694; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzF0t66wEszl2BcU24gnomwmHovPmL+M9vg4PdgRwyk=;
        b=n5bKHCiKKGSziil6l64CunkGbkyg8GxMtjA/uk4N45MDBTufAG/cFI4WaWoOHVZQt7
         nSzqRj7E8lZkN4vSJ6iLZakif6an4onGXG6pFSTWL6PmScvKVbdc8l2tAV3BaTSaKLXy
         jF7mc3EU6GK7Le57oEc3ZG2xYSKkK85WOvkxAiHgkx2e+LdTXta+CcvF+HDWxN0KAMh9
         hLF2PyKF/0JONP+qLBrJCPSM/tR4bpJKL1+wN6J+yEJHXzWzAEaRSvpN1Veuj5aKaAv2
         Y2DcAViDwsY10pithaAexUXmMyIp8uGKFlnhOt0+nr1oXvNVhpdFLJEN805Btbhxize0
         /1tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778334894; x=1778939694;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzF0t66wEszl2BcU24gnomwmHovPmL+M9vg4PdgRwyk=;
        b=UJc3E660ptRaWycppCv7/zNeALgwyUi2XN1Z2GQ7MzWZxjov/VTJWhCmpppiFg7EfS
         tBSK0jzonskZxBeEl12CeqpjQNErt0KGTnQYque5jNkFeFqV9SPOvd/ZxM3i1LIxKaG8
         CT3JZOSB738E2ojG+iBkUgyRMyoV9yGyhW0xa3Ovf78A0/kq7+zQqMHSvupaPwEj2SIL
         EIDYYNmvqPa0y9QHjnWdx/O3+yMxJOFrv60LYYPkmFjqo9Ilkozr8qNcvkkRiOGaLK8y
         DuFONUxbeEcyV+aRSMlj1aV8XHteXA41fQfPtXSZR+DLQX7ueSoGwd7eE8ye7LaTLpDA
         tQSQ==
X-Gm-Message-State: AOJu0YxPa0+l50EubZuQdxMRm4JEC8sblo9WqLfSM+2BMNDXYN6gfTXl
	C2NU3xnjUK1p5jtmxkQAMiWgJb2F73ljo9fuR0QecA3pvA/TVxQ5C5M5Y1kpIuFT34s=
X-Gm-Gg: Acq92OGivS8OGaO4IzTvTdm1QQPY9h0l5TxCn7CoBSoH86f6fcHfz0MY3plM/qQp5Rw
	Xc2abHeE1WalT7nQ35MbJXzvRBY+vYZayOGNvzcNDC8ajSFFsGALgILYKbJSFUwaMvgpsTDK+Cz
	UTcqkS/4CZwfPiUzLLOL7wTBg9xxxyVGr60kgeRp79z1hzB47Y9Nmn0bbsLof31vn1XwSGnERPf
	ZoM+03CzBYTwiOeVHS4GF3/Bah5wapnUlJ9dEehkO/hstyrra0Q9tl69VKrrwIUurvYQWOtnM31
	JSw7irEML+LJgWJXErRB4GaIojmkCfZvs2QFyvDY9S77J9J0oe44wVBJY3cOparQ+NNzwuTSbpV
	la1DIL3GUQp0ChJZA8w9jzFTm8d7jg/UduZROQXSmA8NkKEztk21IDrju8fpOpSGdJ2+x3KWuo8
	rqMKxe5Xmsc/mm5QI=
X-Received: by 2002:a05:6830:6d29:b0:7dc:e37b:b5d2 with SMTP id 46e09a7af769-7e1dee9c9a7mr10654591a34.8.1778334894011;
        Sat, 09 May 2026 06:54:54 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367c04e66sm3098110a34.8.2026.05.09.06.54.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 09 May 2026 06:54:52 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v9 2/2] selftests: openvswitch: add pop_vlan test
Date: Sat,  9 May 2026 21:54:23 +0800
Message-ID: <20260509135423.3433910-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260509135423.3433910-1-houminxi@gmail.com>
References: <20260509135423.3433910-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9D3474FFEED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286186-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Add test_pop_vlan() to verify OVS kernel datapath pop_vlan action
correctly strips 802.1Q VLAN tags from frames.

Test structure:
- Baseline: untagged forwarding validates basic connectivity.
- Negative: forward without pop_vlan, tagged frame is invisible
  to ns2 (no VLAN sub-interface), ping fails.
- Positive: pop_vlan strips tag on forward path, push_vlan
  restores tag on return path, ping succeeds.

Use static ARP entries to avoid VLAN-tagged ARP complexity.
Rely on ping success/failure for verification -- no tcpdump or
pcap files needed.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
Reviewed-by: Aaron Conole <aconole@redhat.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 78 +++++++++++++++++++
 1 file changed, 78 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 3cdd953f6813..8cd5b3d894ab 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -28,6 +28,7 @@ tests="
 	tunnel_metadata				ovs: test extraction of tunnel metadata
 	tunnel_refcount				ovs: test tunnel vport reference cleanup
 	drop_reason				drop: test drop reasons are emitted
+	pop_vlan				vlan: POP_VLAN action strips tag
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -864,6 +865,83 @@ test_tunnel_refcount() {
 		ovs_wait dev_removed dp-${tun_type} || return 1
 		ovs_wait dev_removed ovs-${tun_type}0 || return 1
 	done
+
+	return 0
+}
+
+test_pop_vlan() {
+	local sbx="test_pop_vlan"
+	sbx_add "$sbx" || return $?
+	ovs_add_dp "$sbx" vlandp || return 1
+
+	ovs_add_netns_and_veths "$sbx" vlandp \
+		ns1 veth1 ns1veth 192.0.2.1/24 || return 1
+	ovs_add_netns_and_veths "$sbx" vlandp \
+		ns2 veth2 ns2veth 192.0.2.2/24 || return 1
+
+	# Baseline: untagged bidirectional forwarding
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+	ovs_sbx "$sbx" ip netns exec ns1 ping -c 3 -W 2 \
+		192.0.2.2 || return 1
+
+	# VLAN topology: ns1 uses VLAN sub-interface, ns2 is plain
+	ip -n ns1 link add link ns1veth name ns1veth.10 \
+		type vlan id 10 || return 1
+	on_exit "ip -n ns1 link del ns1veth.10 2>/dev/null"
+	ip -n ns1 addr add 198.51.100.1/24 dev ns1veth.10 || return 1
+	ip -n ns1 link set ns1veth.10 up || return 1
+	ip -n ns2 addr add 198.51.100.2/24 dev ns2veth || return 1
+
+	ovs_del_flows "$sbx" vlandp
+
+	# Static ARP: avoids VLAN-tagged ARP complexity
+	local ns1veth10mac ns2mac
+	ns1veth10mac=$(ip -n ns1 link show ns1veth.10 \
+		| awk '/link\/ether/ {print $2}')
+	[ -z "$ns1veth10mac" ] && \
+		{ info "failed to get ns1veth10mac"; return 1; }
+	ns2mac=$(ip -n ns2 link show ns2veth \
+		| awk '/link\/ether/ {print $2}')
+	[ -z "$ns2mac" ] && \
+		{ info "failed to get ns2mac"; return 1; }
+	ip -n ns1 neigh replace 198.51.100.2 lladdr "$ns2mac" \
+		dev ns1veth.10 nud permanent || return 1
+	ip -n ns2 neigh replace 198.51.100.1 \
+		lladdr "$ns1veth10mac" \
+		dev ns2veth nud permanent || return 1
+
+	local vlan_match='in_port(1),eth(),eth_type(0x8100),'
+	vlan_match+='vlan(vid=10),'
+	vlan_match+='encap(eth_type(0x0800),'
+	vlan_match+='ipv4(src=198.51.100.1,proto=1),icmp())'
+
+	# Negative: forward without pop_vlan -- tagged frame
+	# is invisible to ns2 (no VLAN sub-interface), ping fails
+	ovs_add_flow "$sbx" vlandp "$vlan_match" '2' || return 1
+	ovs_sbx "$sbx" ip netns exec ns1 ping -I ns1veth.10 \
+		-c 3 -W 1 198.51.100.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail without pop_vlan"
+		     return 1; }
+
+	ovs_del_flows "$sbx" vlandp
+
+	# Positive: pop_vlan strips tag on forward path,
+	# push_vlan restores tag on return path -- ping succeeds
+	ovs_add_flow "$sbx" vlandp \
+		"$vlan_match" 'pop_vlan,2' || return 1
+	ovs_add_flow "$sbx" vlandp \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' \
+		'push_vlan(vid=10,pcp=0,tpid=0x8100),1' || return 1
+	ovs_sbx "$sbx" ip netns exec ns1 ping -I ns1veth.10 \
+		-c 3 -W 2 198.51.100.2 || return 1
+
 	return 0
 }
 
-- 
2.53.0


