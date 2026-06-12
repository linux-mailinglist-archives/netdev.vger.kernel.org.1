Return-Path: <netdev+bounces-298650-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SELVDCEELGqqJgQAu9opvQ
	(envelope-from <netdev+bounces-298650-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:05:37 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AB5CA6799E7
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 15:05:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=f6cRqZhu;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-298650-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-298650-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 653613007CBF
	for <lists+netdev@lfdr.de>; Fri, 12 Jun 2026 13:05:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B33F352017;
	Fri, 12 Jun 2026 13:05:26 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EAA3E557A
	for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 13:05:22 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781269526; cv=none; b=PTvjdIRyF0Nkq6qR6CczfodZlCoe6iY6Hbpte+TyTRadmCVH/rDva7pKBmrQ0PS3jTDGlcXIh/x3qJ5JD9oVwrHPx0Xu+P1sQq/wxSui0sHTkiZoKPvxvc02Ed64Q8qjII0FUDEn7Q20rBC1bE4hQpd2J40PSpjuaDCV9bFg3Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781269526; c=relaxed/simple;
	bh=/u5n0ZLTjcOeOWVFdcyyVpxGewb/+5l0WRaVCdRb5Gg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y/dZcAPIhHycxzF6OZQyftDwoTlYolniXP2OQSq1Nr7cG2htoQvzpDBSLai190QZhyFw/+lt7aUPzvc6/ZVg1rGUW7kX5gKgN8dlXr7HREUaVlTnkYwhzcPPHAgrhGckPVvvjMP7r0iTlVm8JmZ6+xZDKZ+KskfljvqBrSxn3Kk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f6cRqZhu; arc=none smtp.client-ip=209.85.222.181
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-9157b94a07aso102182385a.0
        for <netdev@vger.kernel.org>; Fri, 12 Jun 2026 06:05:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781269521; x=1781874321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=fvXXwXWTSGYXKy5X/ooRPGvrZHiscmZ8mdP5qLv/Du4=;
        b=f6cRqZhuVt8KayVC3XtlRngSYe5LtJZSBKIvqqj6w46+GBCF+xZHvukTCWzjxvxjcC
         tmsuAMrzf6rW19MNdZWnWHfAV9FIyc+IizXZ3dUhegnPv4/gHTFaT/JQ/0nJM12RqwJF
         153KF/xdtu/A/GN+lSGz45Qhx0KFYMBzp3lHdzRdI/Bmpt0D4l131lu6aM2n6MCID6+6
         gINuiYfSoY9uw+YU29eeV7l9d3PAix9hykrsfm0itg4SmaTZCpTlHfV01VEcPpQcvyN1
         z3mTLkCwtfNuMne/+Eua/63TuAgcRhsUAP8eiLBIQCTvFDLO8n8nXIyZ5m5Q6iKO71HM
         Xaow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781269521; x=1781874321;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvXXwXWTSGYXKy5X/ooRPGvrZHiscmZ8mdP5qLv/Du4=;
        b=IvnLZcnpGsmxOacoqOzkCuyEhuVd+CPorrSEaopd8KPNHGdn6Jcj4ZEzR/cuydDMLI
         JYxtKxFotlvXe/KXW9w2VH7ZoR/OjuIQ8m137M+0Ki4lqlClxQkiZzf3fxMx9uJrorqm
         HziOmftk1azpteuXQwaQ89J3jVd8C+zrblMsGWUg633WC+bbzA+SV3rwJ8oqbP2exLm+
         iD+Uuq1kHE41Jb9aEX+ci8as6kYQb7oZVXFsoQVZ5MMNHTaD7TaMHPtlDtR5ebnoYyLH
         Y7+97S+R6h4pMXg2HOKYv1kXF83MieUcI///3g2vvjEZR6ocONZ4QklfN5EaPWx9kfbV
         WkGQ==
X-Gm-Message-State: AOJu0Yy9gTLmwU1VuDQDa3W76J+in6JEylsMksY9FLamnAxWS1BiFABO
	9ZqGNNxSk93TbKgyBSUCXnUKH4jiNflddudnoTh8XU2hAZJZkBFyovdOtLfAQIbu2C0=
X-Gm-Gg: Acq92OHg5Mi6sk0n8H3/UFiTGkHaW5Qc1UqJMzf3Czj9Sz79NjYhYg3gq/b89fBhXsN
	8W0JuzRuM6V4wLuYX3gZKLqkx5gApGncogiuoAE3L4BlKyZ+cncBaFZyBEUREX1UBH5oNmHIfqx
	xiE0tYc7s2rOZ8kQwH0nqvjXAYw2lDssLGZfbeq37aNfGVtqYOgX8jxhuPZeNzPNjSUDZSgiJ3h
	DIrqoFqBiKYmw3DaflpzJwEhttC8gDZqEFt+/JwyD8fSyD59SEa9BBbi1cFuQwnGM1iVM0UsHPm
	Bo2TwUtRsGbL1M6k790RdHKXP3N6OUD0QACResYK7SRSMQLEV00B/upVfX8od/llZ2LgcRjg5bT
	0hnl30OQbqqqv3ei+qAbhtCPCX+apeFgeirsxfHP3bmriRIVHi/N4i9Bge8ADcv5XLtlXzGHKdx
	PauIIPYUKLtqSRV0CAZw==
X-Received: by 2002:a05:620a:448f:b0:915:cda5:2805 with SMTP id af79cd13be357-9161bf57505mr368410585a.52.1781269521084;
        Fri, 12 Jun 2026 06:05:21 -0700 (PDT)
Received: from houminxi ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-91619ed7857sm201511485a.4.2026.06.12.06.05.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Jun 2026 06:05:20 -0700 (PDT)
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
Subject: [PATCH net-next] selftests/net/openvswitch: add SET action test
Date: Fri, 12 Jun 2026 21:05:03 +0800
Message-ID: <20260612130503.311240-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
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
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-298650-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[13];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: AB5CA6799E7

Add test_action_set exercising OVS_ACTION_ATTR_SET with an ipv4 dst
rewrite. The test verifies the SET action in three steps: first
confirm normal forwarding, then apply set(ipv4(dst=10.0.0.99)) to
rewrite the destination to an address nobody owns and verify ping
fails, then restore normal forwarding and verify connectivity
recovers.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 66 +++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index d533decca5c1..2954245129a2 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -31,6 +31,7 @@ tests="
 	pop_vlan				vlan: POP_VLAN action strips tag
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
+	action_set				set: SET action rewrites fields
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -377,6 +378,71 @@ test_flow_set() {
 	return 0
 }
 
+test_action_set() {
+	sbx_add "test_action_set" || return $?
+	ovs_add_dp "test_action_set" settest || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_action_set" "settest" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 10.0.0.1/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 10.0.0.2/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ovs_add_flow "test_action_set" settest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	ovs_add_flow "test_action_set" settest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify connectivity without SET"
+	ovs_sbx "test_action_set" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	ovs_del_flows "test_action_set" settest
+	ovs_add_flow "test_action_set" settest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	info "set ipv4 dst to unreachable address"
+	ovs_add_flow "test_action_set" settest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' \
+		'set(ipv4(dst=10.0.0.99)),2' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify ping fails with rewritten dst"
+	ovs_sbx "test_action_set" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail with dst rewritten"
+		     return 1; }
+
+	ovs_del_flows "test_action_set" settest
+	ovs_add_flow "test_action_set" settest \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(1),eth(),eth_type(0x0800),ipv4()' '2' || return 1
+	ovs_add_flow "test_action_set" settest \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify connectivity restored without SET"
+	ovs_sbx "test_action_set" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
-- 
2.54.0


