Return-Path: <netdev+bounces-286975-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yBgVGTzSAmoNxgEAu9opvQ
	(envelope-from <netdev+bounces-286975-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:09:48 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A397151B813
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 09:09:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4BBB9300187D
	for <lists+netdev@lfdr.de>; Tue, 12 May 2026 07:09:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE2B635A387;
	Tue, 12 May 2026 07:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IoY5bW/s"
X-Original-To: netdev@vger.kernel.org
Received: from mail-ot1-f43.google.com (mail-ot1-f43.google.com [209.85.210.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70E5A379C4A
	for <netdev@vger.kernel.org>; Tue, 12 May 2026 07:09:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778569760; cv=none; b=Uey82jcujLezi2tqABcA3YToEIhbDJbcjyeAW6YMcJYYb4wSFqSgNBfqbf2YMjYNcR77BB3o6hIF3hH/FaLHGysMTNv2Tdfa5jYjRXvGsgDNCH6CKoQ6gdzY87HlHU4OdypNqtUl1iMNAVpepXXjIF2z6W8M7D4NbYoR8fZFUU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778569760; c=relaxed/simple;
	bh=GQeOcJ4x5WRRquDnsAee0Zm2Twr2g7DVIbPAVoTtP+o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E+rTTwjZmke+rqw0/JYsXJUyIzUCDfAGBniPXl2cHbvGWptvVmUttdzvcNjHVD0ssfAlVdSMZQtYQ2A3Jng3VRi9Dq57SuOLsXqGJv5fnWNGW+taDjzBWIsKjU6FMGjjr2LJPUkqRoAX+IgJ4UMMLMBlwzWLR/+IJQbmRz16cSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IoY5bW/s; arc=none smtp.client-ip=209.85.210.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f43.google.com with SMTP id 46e09a7af769-7d1872504cbso4806569a34.0
        for <netdev@vger.kernel.org>; Tue, 12 May 2026 00:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778569754; x=1779174554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CzF0t66wEszl2BcU24gnomwmHovPmL+M9vg4PdgRwyk=;
        b=IoY5bW/sfWTh5wk4leCRcGmEgbvQNkK/BMPCEUhqCi/+y6F3X5AGO3RTwN/D+pkozh
         iImJOTeK4S2/cmKNHxq2mM+ggay7qOePV8W+aSh7tKIlGgTCxSCcp6LNRLOXMn3O5rcM
         F+iajYmse97EZlNLBuEJBMmn9yuAXNBAhEpRHqNmJ/dV3AhQeD0uS3hs7GDS62tHjyRy
         Q78Fc7cwCLfLqgTb3jCpeYUkrB6eNbpz1w85XqebkAaIQ4r7rLxQSpcxPqe9GLdhr0RA
         d4D/sZm/KbooAjF4P8txgNVWQdjD6wP+T8ul3lRqKOS59ZWn3eeccKgjORW/BxMDbTEB
         siGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778569754; x=1779174554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CzF0t66wEszl2BcU24gnomwmHovPmL+M9vg4PdgRwyk=;
        b=g0qxCHxzG2iXYCCzthk97O8BzLS5V3J2gcE1xquotC8tcjAU9ClJvxojRbcGE0WXqP
         yhafpVVUU3CEBajW70rvf9VXB3Aqh12TuKLSusCmMZ/1At42dxe3JV+y6hDcZBuE/eRz
         unTj5vaYa8JOkcigY+/5CTOlMFFgFbVcH/mSjTDlCSuEejRzrEPWe9YTVM02CV5ZfJEy
         xQl4l9qs75kPglXETFHoY3ETeTanpmrW/uGonQIrXzs1kNKYHU5F0vcgrOSreANTziuy
         L7hL8ucRYirymVrjbUGrMe0nQFNvv2NLDZdOPus7wq+EYdSxE+kKkQtvhiq8UA1QpPnj
         WJTQ==
X-Gm-Message-State: AOJu0YziwScq06sVYriafLkNhVeDiKEyPb4c6reVOKE1p6g6nWTu0gv5
	nkpAlQ3JkfQ96u8V/y0ffeBOATKa6sC9aSinHIGTgpDZsd7KfEYdMFAAQNuqPVvn8itc4g==
X-Gm-Gg: Acq92OECB8By5k+pWdvplpjvLqfbUjl+n3x0Gitb4oe2cE/ruk1hFlIfEYHRREIVdsP
	8UyisGVmpJxRzD1uA9OdguIOXik9VBl7jalK2UmlLemcyNkqh8S7H8c/QYtB0zrDruVnlJlvaTt
	ORC6HRuXZM9f12KGFgO6dOr9KetbFerAUy+vG9J0tfG6ClNuhhL9FziztnvuFgoAmW5RYAJdpiU
	cVHRMSJxycFHNVmotJeWFoGcVS/2h3swHYSnHrabXscK1tD8nejEH1EKlgyJan7o7n6CptRZsF/
	MfgOdGW9NX/6E7vlnS/FOYVUAo+ntMmWXcYUn43U3T5ZBACIB8znYd2C3PPg+VOUA7UKTo6/+oU
	U+B2+N0Lv56meVnxU10HELBhyf2KOdPP7r4hO63d1HUdLG/n6PfPsH5vTz1BhXnTQrClW4XbXS0
	NS0iM8a0ASlztYhFQ=
X-Received: by 2002:a05:6830:c8d:b0:7dc:d7b8:aa80 with SMTP id 46e09a7af769-7e3bd3a1d5cmr1022984a34.17.1778569754252;
        Tue, 12 May 2026 00:09:14 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-7e367a18481sm8417658a34.0.2026.05.12.00.09.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 00:09:12 -0700 (PDT)
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
Subject: [PATCH net-next v10 2/2] selftests: openvswitch: add pop_vlan test
Date: Tue, 12 May 2026 15:08:41 +0800
Message-ID: <20260512070841.1183581-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260512070841.1183581-1-houminxi@gmail.com>
References: <20260509135423.3433910-1-houminxi@gmail.com>
 <20260512070841.1183581-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A397151B813
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[openvswitch.org,vger.kernel.org,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-286975-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
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


