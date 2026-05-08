Return-Path: <netdev+bounces-285854-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJAgMsHo/WkPkgAAu9opvQ
	(envelope-from <netdev+bounces-285854-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:44:33 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 71C2F4F7457
	for <lists+netdev@lfdr.de>; Fri, 08 May 2026 15:44:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1433B301DE7E
	for <lists+netdev@lfdr.de>; Fri,  8 May 2026 13:44:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 287D93ECBF1;
	Fri,  8 May 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UFYN6zP9"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f51.google.com (mail-oa1-f51.google.com [209.85.160.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDF73E6398
	for <netdev@vger.kernel.org>; Fri,  8 May 2026 13:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778247821; cv=none; b=TfFPjEx1oa//fAN5+l70QApvYp4PnWRLyUxQ8BX/RE4oPl2XIpsIdRGWISRseiFhbSQ35FKNHY840uQ/8XuFs6vLNcKRTeCTe0a1DoPW/EqkeNkwr5F8rQU/qzt5Nfo8IefteTpfcHs1zJK96kxtpca6g+SfO9MLxCwXz9eGXa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778247821; c=relaxed/simple;
	bh=QbDAcqmCs39fePaBHuY30LnIJo4+WAkx22s1UP1/KKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mg5sqgnHbiGLhLmXVCZqr8jArAmr7BN1nfMemH7XIV8/ljWU5tS9FXO6EvfoG+zztBd3S1tSh8yvhsawf00ZqlXXNTbrp6CjKk5O1TB1wLUF+Gk9dDwlx+40ZtFfVGNWBLRwp8sQEgZ1H1RdSLT6HGPIxHlFFEj9RUrhDrNK5G8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UFYN6zP9; arc=none smtp.client-ip=209.85.160.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f51.google.com with SMTP id 586e51a60fabf-42fe552aedeso714487fac.0
        for <netdev@vger.kernel.org>; Fri, 08 May 2026 06:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778247818; x=1778852618; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G++PmIEZH/3IDDChHFNdq5UZKsic2mGL2G/u53vWWPc=;
        b=UFYN6zP9IjzK2OCGFAdUrGI6JQR6HbBcfL1bCmwk6c1sMVx/K4Yp/MdFeqoXr1fxmz
         hytjyq8u8q9TcvTpC4qwJWeOFGgmflng5MPM9PhmDeDZZBSI1naZHm6Hg2HBUv0GH0CK
         ypbHaKx1qfbQSaoocxnnwzZ2SIDxeULxKchpPwPISPp9rvHB4Npq8rcNzHglFZHVNw9m
         YdKUx0oc4F8TTMo4Wf5E8nIAMjqrHQRxP/3myxwtSLnFx3eVtNbg3JX+n0kWUcpry1Ni
         8pQ9U2ZaJrUgL42YhzlNNoY5A+/0Ht4i+W21/MUOw1PXLPlbeSaBJ+Qa8lMwEQ2+gRr6
         vl4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778247818; x=1778852618;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G++PmIEZH/3IDDChHFNdq5UZKsic2mGL2G/u53vWWPc=;
        b=aL/+4coZGeHckmvN5hQxAt/uc70WqdSjwNQyoEJ8QWjqgaerLE3j3lMeGXCKT+3mLS
         /UFij30Pd5fxVF6+IjGGJKxVEsm0XSTw9nE8jwx+WQtq/J+yJQVo02h3JWzzPon8Z41g
         3PTzEIEuL1kUVkS/+Ttju5PWrg4aYsXdUzxPF/W+2AJ7SVMPSopO0ChWE/oR6Wy9Zqny
         oGlCDb+3OPpERbJa4IOGHxYkQ5YPE2LyCjo7cRuEoPEz0XT4uN/KfDKCwrdof9K9uZbf
         +NEd86YgyLzj2DutZbd79Lhu4ndp+kHGG8vfEG406awZOwNQueO0n955OmLeHWlfVatr
         ElSA==
X-Gm-Message-State: AOJu0YzIHTD8N77y7nlstZbNJNhtdZvUCsYTJKwq3qBbgR7/qIaO+prD
	Jm9Y27CUXHFIitpo7mgj5U1PGGLK1rzaxXoFMT5hTLH38YlinzVK6KjhZ3FLJoL3R9I=
X-Gm-Gg: AeBDiev2sOuq2df37WhaJ4xspHVmvMPRQwXunrsFuTTQ2W8Sn8BZyGdPmi05vSRF9I/
	0svRrKTc0xLTGaNv3GxGq8RCRqQttRF7AwASe2C6+A0ut8M4yNLaO7cBTSvxvrMtAT34uD6YLaN
	Y69eA3Sv6U3FLutMkmFgauDuSLG/V13TKoTUC+uoO7dH1uwDf0r37KXmeFrChKQGVBE9Gmv0wPx
	rxjsuBAJrV2pg98X8qt4Fc3TQvzxIOhwz60f3edJRtAfRX7aqO/jGaHTvkuD13FDmsl5EmeE6ms
	cFhErtIt2CUZQ5nPd+rT0vl/4/hxyZJDcC5S/Knt8a29Q8+2nrEiLF2qHt8GL45dRCbUKHQg8IX
	1rT5SUhfuMl9V+a6NlxCoUAhJsoTAhiJWDfjnOibccynDi+t8VjUklYic5gM5wiraxiZxuoN2tq
	MoN4x50by43T1W/G8=
X-Received: by 2002:a05:6820:61e:b0:67b:bd89:90ed with SMTP id 006d021491bc7-69998d30169mr7387370eaf.41.1778247818205;
        Fri, 08 May 2026 06:43:38 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-69b25c76cc4sm1119108eaf.6.2026.05.08.06.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 May 2026 06:43:37 -0700 (PDT)
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
	linux-kernel@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v8 2/2] selftests: openvswitch: add pop_vlan test
Date: Fri,  8 May 2026 21:43:08 +0800
Message-ID: <20260508134308.2857449-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260508134308.2857449-1-houminxi@gmail.com>
References: <20260508134308.2857449-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 71C2F4F7457
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	TAGGED_FROM(0.00)[bounces-285854-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[]
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
---
 .../selftests/net/openvswitch/openvswitch.sh  | 77 +++++++++++++++++++
 1 file changed, 77 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index b327d3061ed5..a0e8e6cbd301 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -27,6 +27,7 @@ tests="
 	upcall_interfaces			ovs: test the upcall interfaces
 	tunnel_metadata				ovs: test extraction of tunnel metadata
 	drop_reason				drop: test drop reasons are emitted
+	pop_vlan				vlan: POP_VLAN action strips tag
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -830,6 +831,82 @@ test_tunnel_metadata() {
 	return 0
 }
 
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
+	return 0
+}
+
 run_test() {
 	(
 	tname="$1"
-- 
2.53.0


