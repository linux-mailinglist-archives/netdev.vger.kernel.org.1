Return-Path: <netdev+bounces-299371-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id N0qfFinBL2pdFwUAu9opvQ
	(envelope-from <netdev+bounces-299371-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:08:57 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 09976684E75
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 11:08:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=F2VSxmuZ;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-299371-lists+netdev=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="netdev+bounces-299371-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 121E6301FB02
	for <lists+netdev@lfdr.de>; Mon, 15 Jun 2026 09:05:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E08693C3BFF;
	Mon, 15 Jun 2026 09:05:20 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 542B430568A
	for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 09:05:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781514320; cv=none; b=gq+wIqHwPRzhNFN60MQCNE984j1oSFnHl9c80/L1T1USgq+w7fFlhMYdxjD3tLugwCHwMdl7hJUWO3MEsLs0CI60y4mEe1xFUXbJlyyP4fJH6zXd7KVkzVZ/BOCdcqPksRlvraCl9gYLyl9YUJEgJHFwJ+xgJdgXGDAX+Na95A8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781514320; c=relaxed/simple;
	bh=is0aUcqvIZ1xcT2jK43lwzQy9+ksca8vwiUx2SlLA9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ouXUF7lfYkSteADq3fsa5A/dg8MOUFysxOTpbCCO4YbEuNsLqAf/ttr8mt/rWQX3lMwyI9x6DywkgbEnPOrrKnEx4KZbO/BMKCBZ90n1Bj1QOlxwTMY1jZ87X0PgFwdP0EaPSud4KTO0+83fh7jSD0GJoufTOjGHKB4arbXTZr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F2VSxmuZ; arc=none smtp.client-ip=209.85.219.47
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-8ccd1f57b32so39986756d6.2
        for <netdev@vger.kernel.org>; Mon, 15 Jun 2026 02:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781514318; x=1782119118; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OvV17BgpJQmVQrI1yyaY3qROAJv7ED+Gi/LtXIZqMPI=;
        b=F2VSxmuZK3+lLiaTVErbvzZRXcA0gpZd111o4WAO/7BG2E47jI/iYOeprIWpPMJ7DT
         edFsRWqxMHU4K7Sd8Q3D0UDbeRhqUfgBr1aEX4Yfks42AjeWLGOsGujU6DEsXa7C64tj
         7I+UqBD6kA/a91zOzFprsyECq0COBq/I/Uk9a9q2C/EYfStgf5ux4UFp4xGGyc8PckAf
         3pjOma9ymSGyzmmjB9ZoH7JaGVlzl78NnK5ktAQH73+Y76bV0cz7sBFqs3TFX3rg4GKG
         zQu6m150M6jVXc+n4wb4CLKIln0+U9qpVOidX1Sm52UTfppfG56mFKlgWYEuM9o4tKgB
         XNIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781514318; x=1782119118;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=OvV17BgpJQmVQrI1yyaY3qROAJv7ED+Gi/LtXIZqMPI=;
        b=U63P0yGJ7yeeUg0ThP5vfpGv0FVPNs9kES8RArS+awZ+Pylc3YDhtYbqrcUtIAWPRW
         PVumXpYGLzuV+mWcRZBgX6RDVz/1QlBau4oPqhd8M/9+vmboSxIv1a4RYfvZuC+pR+nK
         q+W8s+h4FHRGP1TBFIa0LlyrnY1EN+YmcQuGegh9GlBI4v90jJAKGAPDUAiHmU1R83gq
         WexkXzCeIPggkTBEkNobZhFhzK2g9bc+UvQyuXQ2E0cNm4ppD9kgZWC80Pbif57Szs1O
         6mB9qap6naog0MRRegnodDnc0UE9s/kgrG6ScG0rjs0TBq7z/bq91OjycnZCaSxjdzO2
         bf0g==
X-Gm-Message-State: AOJu0Yw1BihzlYsTzaZB8+T7jmjOzYn7I0jO43cCiI61KVovvEuA4LcF
	GsEdgOF3OSHb40ulUSZKh9yGKUU8bqW6jc8LBWDOtg/QK5tL8RAneYeA0gQoxXOhPVw=
X-Gm-Gg: Acq92OFT6wWheSFRbPBRi4vGfge8ORUG98giMLPWNRVXnIy9rh7f/omyGBE5pqhK82P
	OpcuZEoQC2m8lzdvXYwLR7x16c7lJbg6e+r8UKbyvmFAzoEXOOWJwtytmX42pN1kuuQd0nTKP5s
	Gw+zcgjm4UutnrwpgfFonXQ1QDsPz9nnwGPP27GWGfVPC8OYFUN+r3lYR3xZfsGYgwj7YR+bfIO
	y0ROoIgLVF8c3j+/9/s219BHU/Tz2ewZ7laPg106RcWQm3cK4tFlzvcXZ+rn26+kTPb8tySr9cm
	KPYQlGWLpK0YT4cynrHkC/CfPyKgvPt8HTW8wCvkzZ9JgTNsnPDljAINyWwdH9v92XMvDLA+ZTy
	Si14OpMOmIZzv2p0xnJLDaFwifSr0fXV7UbegqHtM9oEFXcu0loFbWMp52awoBYEUHLL+pCX1lF
	cYKY/eRFqRyNuBJEAOWFU5a50=
X-Received: by 2002:ad4:5761:0:b0:8ae:62aa:665a with SMTP id 6a1803df08f44-8d32d858216mr244104566d6.28.1781514318228;
        Mon, 15 Jun 2026 02:05:18 -0700 (PDT)
Received: from houminxi.lan ([163.123.141.225])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8d302114676sm109704966d6.20.2026.06.15.02.05.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 02:05:17 -0700 (PDT)
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
Subject: [PATCH net-next v2] selftests/net/openvswitch: add ICMPv6 echo type match test
Date: Mon, 15 Jun 2026 17:05:07 +0800
Message-ID: <20260615090507.3647256-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260613141429.3084962-1-houminxi@gmail.com>
References: <20260613141429.3084962-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-299371-lists,netdev=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 09976684E75

Register OVS_KEY_ATTR_ICMPV6 in the flow key parser so that
icmpv6(type=...) can be used in flow specifications. Without this
registration the parser silently drops the token and the kernel
rejects the flow with EINVAL because the expected ICMPv6 key
attribute is missing.

While here, add convert_int() to the ovs_key_ipv6 and ovs_key_icmp
fields_map entries so that specifying a field value produces the
correct wildcard mask. The IPv6 flow label uses convert_int(20) to
produce a 20-bit mask (0x000FFFFF), matching the kernel constraint in
flow_netlink.c that rejects masks with bits 20-31 set; byte-wide
fields use convert_int(8). The ipv4 counterpart already does this via
convert_int(); the ipv6 and icmp classes were simply missing the fifth
tuple element. Existing callers that pass empty parentheses are
unaffected because convert_int("") returns (0, 0).

Add test_icmpv6 exercising the ICMPv6 echo flow key. The test uses
static neighbour entries to bypass NDP, then verifies in three steps:
install icmpv6(type=128) and icmpv6(type=129) flows and confirm ping
works, remove the flows and confirm ping fails, reinstall and confirm
recovery.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
v2: fix ovs_key_ipv6 label mask to use convert_int(20) instead of
    convert_int(32); the IPv6 flow label is 20 bits and the kernel
    rejects masks with bits 20-31 set in validate_set().

 .../selftests/net/openvswitch/openvswitch.sh  | 63 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 26 +++++---
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index d533decca5c1..8923224fa88e 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -31,6 +31,7 @@ tests="
 	pop_vlan				vlan: POP_VLAN action strips tag
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
+	icmpv6					icmpv6: ICMPv6 echo type match
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -377,6 +378,68 @@ test_flow_set() {
 	return 0
 }
 
+test_icmpv6() {
+	sbx_add "test_icmpv6" || return $?
+	ovs_add_dp "test_icmpv6" icmpv6 || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_icmpv6" "icmpv6" \
+			"$ns" "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add fd00::1/64 dev c1 nodad
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add fd00::2/64 dev s1 nodad
+	ip netns exec server ip link set s1 up
+
+	local cl_mac sl_mac
+	cl_mac=$(ip netns exec client \
+		ip link show c1 | awk '/link\/ether/ {print $2}')
+	[ -z "$cl_mac" ] && \
+		{ info "failed to get c1 hwaddr"; return 1; }
+	sl_mac=$(ip netns exec server \
+		ip link show s1 | awk '/link\/ether/ {print $2}')
+	[ -z "$sl_mac" ] && \
+		{ info "failed to get s1 hwaddr"; return 1; }
+	ip netns exec client \
+		ip -6 neigh add fd00::2 lladdr "$sl_mac" dev c1
+	ip netns exec server \
+		ip -6 neigh add fd00::1 lladdr "$cl_mac" dev s1
+
+	ovs_add_flow "test_icmpv6" icmpv6 \
+	  'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=128)' \
+	  '2' || return 1
+	ovs_add_flow "test_icmpv6" icmpv6 \
+	  'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=129)' \
+	  '1' || return 1
+
+	info "verify ICMPv6 echo with type-specific flows"
+	ovs_sbx "test_icmpv6" ip netns exec client \
+		ping -6 -c 1 -W 2 fd00::2 || return 1
+
+	ovs_del_flows "test_icmpv6" icmpv6
+
+	info "verify ping fails without echo flows"
+	ovs_sbx "test_icmpv6" ip netns exec client \
+		ping -6 -c 1 -W 2 fd00::2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail without flows"
+		     return 1; }
+
+	ovs_add_flow "test_icmpv6" icmpv6 \
+	  'in_port(1),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=128)' \
+	  '2' || return 1
+	ovs_add_flow "test_icmpv6" icmpv6 \
+	  'in_port(2),eth(),eth_type(0x86dd),ipv6(proto=58),icmpv6(type=129)' \
+	  '1' || return 1
+
+	info "verify connectivity restored"
+	ovs_sbx "test_icmpv6" ip netns exec client \
+		ping -6 -c 1 -W 2 fd00::2 || return 1
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index e1ecfad2c03e..f3edd198223f 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -1255,11 +1255,16 @@ class ovskey(nla):
                 lambda x: ipaddress.IPv6Address(x).packed if x else 0,
                 convert_ipv6,
             ),
-            ("label", "label", "%d", lambda x: int(x) if x else 0),
-            ("proto", "proto", "%d", lambda x: int(x) if x else 0),
-            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0),
-            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0),
-            ("frag", "frag", "%d", lambda x: int(x) if x else 0),
+            ("label", "label", "%d", lambda x: int(x) if x else 0,
+                convert_int(20)),
+            ("proto", "proto", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("tclass", "tclass", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("hlimit", "hlimit", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("frag", "frag", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
         )
 
         def __init__(
@@ -1344,8 +1349,10 @@ class ovskey(nla):
         )
 
         fields_map = (
-            ("type", "type", "%d", lambda x: int(x) if x else 0),
-            ("code", "code", "%d", lambda x: int(x) if x else 0),
+            ("type", "type", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
+            ("code", "code", "%d", lambda x: int(x) if x else 0,
+                convert_int(8)),
         )
 
         def __init__(
@@ -1982,6 +1989,11 @@ class ovskey(nla):
                 "icmp",
                 ovskey.ovs_key_icmp,
             ),
+            (
+                "OVS_KEY_ATTR_ICMPV6",
+                "icmpv6",
+                ovskey.ovs_key_icmpv6,
+            ),
             (
                 "OVS_KEY_ATTR_TCP_FLAGS",
                 "tcp_flags",
-- 
2.54.0


