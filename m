Return-Path: <netdev+bounces-286968-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wM+HECPLAmo+wwEAu9opvQ
	(envelope-from <netdev+bounces-286968-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:39:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id B78C051B23A
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 08:39:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3EA6D30166EF
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 06:39:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 07F4D4E379B;
	Tue, 12 May 2026 06:39:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbCCn2/o"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com [209.85.210.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B47E731578E
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 06:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778567963; cv=none; b=jXPX0ZQcTIrRS9Em6GMutxOVjoHpaiQ4HuKP5u73TvLOmXwARfMeNcLeALpFC3ZroqFxqnlLSorCLBEdOk7124gW0Kxqdv34ytOavE9+Th16icuH7IrUz6ziN3Eh/dxKs6vW6f6rZ6QqB0QiVHkbNu2aiZpkS6qt949CY8ZpWeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778567963; c=relaxed/simple;
	bh=GQeOcJ4x5WRRquDnsAee0Zm2Twr2g7DVIbPAVoTtP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=icXWs4qYRF9Iih0JysFiWu+CR6eBkKLgH2wpHn0Unt5apzngyAFjQrnDFuV9fdT3srX21Lw68oRKQW+oreCGr5OUFnVTi8481ObzYwBhoJcW84Pw6Eba/fuw5DAidUUx//hkFhVoYbPAf1dmLukH9grgHpJHPY0TrBFQJlQpPJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbCCn2/o; arc=none smtp.client-ip=209.85.210.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f45.google.com with SMTP id 46e09a7af769-7dcd89701acso4815973a34.1
        for <netdev@vger.kernel.org>; Mon, 11 May 2026 23:39:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778567956; x=1779172756; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzF0t66wEszl2BcU24gnomwmHovPmL+M9vg4PdgRwyk=;
        b=QbCCn2/o24e7gJIgYYugmJ3OwDw7113fUb0SMJUpYXErZhIRwXp6LOVWgqTF3teBfE
         iZXSbTUwt3g/5uim69DPkAC5HXRZ1zyJDUAgMbW5tR2sOX7Yl8wJXokkSJVFNwsQ2xwR
         S+GCf4W4rI8tvAc+F7zZZiBWDY/YAmTIslrJeMrF4Fd9Cin8Ys+Z2DgFfh6JmQuhD+vZ
         iJunyOmOdnW9Wk9MQSSpK5RSzSj7mi2Lk1gWwQGnMExQ7hxWv2Y5DkX5smU/m9aji/Ws
         3OLOxMuNj5zWFsH2UnIP59fnpKRM6y/50TENEwPEgOEBY6Sj5qsXIVTbCqSGWre9kurV
         VC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778567956; x=1779172756;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzF0t66wEszl2BcU24gnomwmHovPmL+M9vg4PdgRwyk=;
        b=pzzs0eY170YgitVoqOKHfuEldEDOPX7w1wqbAfd90OjanxUQnOLzQw/epA448Ib74F
         Iy7E6W0CKp6qLHO8I2EvNKNuabNGS43+9OTstgKLTIsVQ5o53p+xahPDOngGy/4ul+Jm
         4Vn96KCzs6j7tRR9QE/INuMJW7Hzkwy1EOYxa5uq3fDeXgmi/so+VKn6m8WtJ/fQhJG/
         pLPuVPP5qrRsmdVs8wtQ6/yHAUOInwXiBV8EDoYw+LoDb3HLJUlt+D3M29mGQUu0DG3i
         vIw8I3GEsNXwRIOaBq6sioL7XDpCKy9a3JHKlsDCNZiz1fzImHpsrTPnLE6mvL//fnFk
         JxPQ==
X-Gm-Message-State: AOJu0YyyL2Ob/cSt09BM4kLVBIZUGiisALhpzvcMkUvSLumGxsk4HHFG
	wUglHdtbw26lx1ceM8PBQpqtnp9HxEswTPD9xR758hDIFhYuRzjb+IW9wyDFcSUbFP3qqg==
X-Gm-Gg: Acq92OHekSKLOOApvZY8c73XBoDEu9hUAJLyXYzwfknLITn1AuplHL6MnpBIS6e13G3
	tEt2plL1nZ43XUClW+2VmoZ8PGk0fWZ2wXBjygEigcwSbqhSWBq0G3UXiUCBKy5Zi8hRkubWYtY
	SQ6MluuaZRwiQOEcFqPGoNV7N572yjUB/+3q4M5zeI9FJSKST3I06OzVP/aWl9gHuy0ucvb7MJ4
	i18D498y3/eGIF774X2Ho1in2ovO/GKANqFTCLPGJKm4LG6h2C3JOwKy6D2w6gsooyeg7KlAbkj
	DzhWrktkhbr9+GiuABs14fIH9mOZHIoKDPyKzTyQolRCBkKdgwZsbeJV75fBjTP1ZNEVbVrecZt
	17C56CjuaV1NEksUsBvKm88+OJNJCbIJcBcXzBVU7wfeT+q+VLX8b2PcZ5VFLR8256YHh8F78+H
	iRRFQnQ0Ufa+rwl0U0v1X7GiUbxA==
X-Received: by 2002:a05:6830:6d48:b0:7dc:d0cc:922 with SMTP id 46e09a7af769-7e1df194678mr16537449a34.27.1778567956356;
        Mon, 11 May 2026 23:39:16 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367d9d788sm8183783a34.24.2026.05.11.23.39.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2026 23:39:15 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH v10 2/2] selftests: openvswitch: add pop_vlan test
Date: Tue, 12 May 2026 14:38:50 +0800
Message-ID: <20260512063850.1133046-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512063850.1133046-1-houminxi@gmail.com>
References: <20260509135423.3433910-1-houminxi@gmail.com>
 <20260512063850.1133046-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B78C051B23A
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
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286968-lists,netdev=lfdr.de];
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


