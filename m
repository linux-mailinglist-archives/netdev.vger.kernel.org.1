Return-Path: <netdev+bounces-284834-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uG93GrE/+2nTYQMAu9opvQ
	(envelope-from <netdev+bounces-284834-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:18:41 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B57C44DADE9
	for <lists+netdev@lfdr.de>; Wed, 06 May 2026 15:18:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E0A30B6D4A
	for <lists+netdev@lfdr.de>; Wed,  6 May 2026 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09E3047884D;
	Wed,  6 May 2026 13:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ndtEbbpy"
X-Original-To: netdev@vger.kernel.org
Received: from mail-oa1-f48.google.com (mail-oa1-f48.google.com [209.85.160.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BD4A4779BE
	for <netdev@vger.kernel.org>; Wed,  6 May 2026 13:12:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778073171; cv=none; b=Re3/IV2BQbp4/e+6FRvoQ8J9wZoZZFk1TsRFoB4Vr8Qd4QgE9QGIYWFDfqJgP957ke+KKg3hvG8aGR7eUpr1WzTHad2pzjnLmusn+QkUGynXveZfcg8o/bN/yB3YioUaiA+ew47XYwBLZuv6pLmXFluklnKqKVPUQSi7e4wlMaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778073171; c=relaxed/simple;
	bh=7anuFwbxVPib5Qwdrz+mL3upuMV9kt6FzTMasaXomEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uxh6LzttX/3wQO/sDQPiwOioPQJYopavEgJqMPX0TofZHucjQ4cmWMS7n6fo6O//OpIJbq1dDslbis+vZSB5egO/I/jlEiupMAU1f3tDwZB5Px/8uSlOxE8HqY0EH6hyC4oBzTeteKA0p5aHl/7wS3zuiceC3QojePIrwYSQxT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ndtEbbpy; arc=none smtp.client-ip=209.85.160.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f48.google.com with SMTP id 586e51a60fabf-408778a8ec4so3669084fac.0
        for <netdev@vger.kernel.org>; Wed, 06 May 2026 06:12:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778073169; x=1778677969; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TtDHstlKXDMwZVDImgv2Go/2LwRbeKrLJRmqWEJNiDM=;
        b=ndtEbbpyjL6PTXhGzuuXUUNYgkpn41uTsrQGl96ZzWth1JedXi82z/MV7y/CWRkfLY
         yLJ0Suk7lsfSJrOWqEuWxkHv8wN/8uhAAYS8rY+U5HBuSlqEtoAFyPDsW8EdYiSTTsHP
         +8eW5XDBXIoxNY0nUcbafblovAtET+oV3wjHGEVEPCedkIGHaU3F25rnFEwzVxu0DzsI
         DYn9XvYaJWVHpz1MGANLgMpOX/iC/r7A98KdkWsoWvvUQr5laCmeJVwkPE0S2Pc7yfp9
         Pzo2flvKcUBJ+dtajWe/rziU8/usCKaYm8YOK/ZbO7p6wGsi6diarzyN/dlB5Vn7J4mB
         hN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778073169; x=1778677969;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TtDHstlKXDMwZVDImgv2Go/2LwRbeKrLJRmqWEJNiDM=;
        b=YoYbyBRUUDD2GWGQgdjpM/mX7Stzl865oWWbymSF4qWzontTV5TsBw7vN80ZCQ+Pxb
         2GRT7pXre04T/sSCpQO7BEqSZKYfMW4tiIDwFFVLqnu+NL2SYHW5OJOjgkB0qW6GCVUf
         wGU9r0Zm7iKucHSJkPmybLIRHDG3IcRI/syLTgA5vuRlbda6ZfN1y6cZhbOjXnK4xA0f
         VXN+Bku66fcCp5Qohlr4mSspUydEhrAzdx8i8eWrV3MqR1tPFBA4zImicrBwRI80gg5+
         cgYfs6zuC8iAWRbX8dEmLPGrUt+8nPlDTxV32eehcMJl6dnEfZi2ilWWOOmmoELZFOwZ
         pQiA==
X-Gm-Message-State: AOJu0Yyi/FlNzpVbsdI03JAUxmi9w4Sd+jBiditTr37i9PK8aZi7K9b4
	5tgCOoYeopoGJPPcxaHPW8zhewRVZt/kl3Pc3w0cvZrbcgv8o7zX1eZzCmIEPn/PKaxPpA==
X-Gm-Gg: AeBDietuNQDkqN9u1eq00aMxUj79NakCBHkVooGqX++z3JDOkIl0cdLddunHiO2sVn+
	/f2tZFoEyzO9tnMTggMOJffFOPrEOPUtEBgxvbcl/e91l5OYtSena/L+cxoj9pszOyjrpQNy3yB
	hB7s+83X0D+hBg1rf/umGH59qkyia/o8XKS6KdeppTcIn7j4ifqjviyvxd7dKyd+HWEodq4+1zu
	VTA4ZHbDJ284nUlthYFgBj9/dA+FWxK5w0fGZWyitJ9fwAIhlh+DGMQA67OddZjIYh8PtHJW4fb
	j0+TvGJsExoKTomC80RzyzXIdFoduntc3QO9vau3yShaiq/rt79uRfLq1Xas15fPrV8wno56X8y
	MwWdRKGLhCM6kBgztSZ23ht0rjKowirudlBBoBa+h4No1D5lnyHRS/vc79ybP50x64o4oJSd2/h
	RGItdedQUC1ATZYKadgxCwlvuFIQ==
X-Received: by 2002:a05:6870:c18e:b0:42d:c200:4214 with SMTP id 586e51a60fabf-434f663b9ecmr1936790fac.18.1778073169035;
        Wed, 06 May 2026 06:12:49 -0700 (PDT)
Received: from houminxi ([72.244.37.221])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-434548d9decsm17327859fac.3.2026.05.06.06.12.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2026 06:12:48 -0700 (PDT)
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
Subject: [PATCH net-next v6 2/2] selftests: openvswitch: add pop_vlan test
Date: Wed,  6 May 2026 21:12:18 +0800
Message-ID: <20260506131218.1880852-3-houminxi@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260506131218.1880852-1-houminxi@gmail.com>
References: <20260506131218.1880852-1-houminxi@gmail.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: B57C44DADE9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-284834-lists,netdev=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
index b327d3061ed5..a5636881760b 100755
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
+	modprobe -q 8021q 2>/dev/null || true
+	[ -d /sys/module/8021q ] || \
+		{ info "CONFIG_VLAN_8021Q missing"; return $ksft_skip; }
+
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
+	ns2mac=$(ip -n ns2 link show ns2veth \
+		| awk '/link\/ether/ {print $2}')
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


