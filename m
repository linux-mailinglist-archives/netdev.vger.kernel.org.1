Return-Path: <netdev+bounces-303078-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id GnWiFS+cQ2o3dQoAu9opvQ
	(envelope-from <netdev+bounces-303078-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:36:31 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D7816E2F64
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 12:36:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=eX6+ia+x;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-303078-lists+netdev=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="netdev+bounces-303078-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0FEBC303B0C2
	for <lists+netdev@lfdr.de>; Tue, 30 Jun 2026 10:22:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA5D93ECBE5;
	Tue, 30 Jun 2026 10:22:32 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AFD42D9484
	for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 10:22:30 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782814952; cv=none; b=VA/42mih0EJAXvaS/UKoRg9tQllTGM5ZOeh1XkB1U11T20s6je0pSX/mOG4iPkx7PTerHaE0R3EO6C8dFSAW9L4omgJS+eeweXZk4zISHoAOtExonqncDpBa+Ky4dgbGKE1wLu+olGdLousJeTpI5B3q9ioe4y1PiOshDFY3/do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782814952; c=relaxed/simple;
	bh=tJ5AgHmPU81+bXp/Y3F1T3O00XWjFbNB1wRNx7RqxE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YPhTBMuMBnq1C/8+pwBIPeB/4Kcxq9gcWeI1JCVPd+yx5YGjOsh9iU3M4cR18lQHf7xGQd/xJt86KDuQ5K/vJ0qZpzRrX5NvQgjafMMMqR8N+UCv+koY0xcabuUrR70SKgmUFj0z5P3kk8ZUudjeastVq8Nm2mxEmowm5l4Hn6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eX6+ia+x; arc=none smtp.client-ip=209.85.216.45
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-37f7a5a217fso1894868a91.0
        for <netdev@vger.kernel.org>; Tue, 30 Jun 2026 03:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782814950; x=1783419750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YDnQ+qekbSxhRRRlAXPldbekViVZJ6Onugh7Hv1Mdig=;
        b=eX6+ia+x6DnKV3+wf2lZDfBQ2a3ExrfumM71J62mAHC17ZCuVpv7Mx8elF/YMGNaD4
         cw71bTJ0VRZjXwHJzXmemolO4cWY0aK+GYCWBHcosDo9KgW/MCABk2QK075abSscZVPf
         pVtSpdGWaJeLgYFn3ssyznXEBY2G+Vq3/OfW9xH/zIT8NKtvYW/Wh+h4wkVCGQj8YqL7
         U4+VRXnkocnR480CBnK2XLukmoSZL02WjTZxaP66D8NWTsuUXh36yAttJQHPrHzU8+BG
         7AtIeG5ok6gaMmxskV71DIxtOG2WJ/3Z4Cl6VDwYjFU9Ygb/S46MJSuO6lQ82w3S0AYZ
         FpRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782814950; x=1783419750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YDnQ+qekbSxhRRRlAXPldbekViVZJ6Onugh7Hv1Mdig=;
        b=V/CRzjFWJtQyDskpYMl5cqzYSZ1PoXgO48Y+uWIAWfSGnwapkyINgW1r/PrDr0pWDj
         DacPd5aeOjtjSns2nyG0fUwGbqTjPr2rNfgkAXrJz+pxNnvLWhqvrYZoVKPM0bfjVCZy
         LOq0Bdt+ZDRSzfUZTCDn6mDkknpHxNI2obvaHBtlvQUMadjECGA7FYHfTX7UGeuE3Sx7
         8KiEvjIv1ZM4z0By6YDPowJZeJKe/LEUZMcAz7+PT6/egERo+Ua5Gcmas4tYEMuKBjxi
         PDuM1p/i9pCrwR6cCaZcU5DBtZg/JxDoiSl0Ut3nqokH3j/V/qvWWrnliZ/jy0r7MaBm
         JzUQ==
X-Gm-Message-State: AOJu0Yxl0MsbNwIjQA5A7xpNYskmbZNKCk5TAAzfxIHZbppyRkKw53H5
	k0S6WkkEHQLY15+NqzPZ2rHz6hQZtBkfW5s+15OnKhAGxyQ91fCxC8bFatwLuUQ66r+9xQ==
X-Gm-Gg: AfdE7cn3rCNJJ3VQE7TFmjaET5/2FzlNH26l9j9zYUdyOGzdckoEEJENe5miz7rX5fP
	gWYG18jSVf41vTdu2fgFkbvcAVZCtYBSjQ+M6oXzj9p3wQkRi74XbZIFzWwgMrdcvNMMQs8PGYc
	v8oKB78L5Y67TV1G1mH0ZMWhIbi83Sy59w8++/Eo/m7QgFHRIsHkhGoIwJX9dZWNBUl8gn/F9i2
	r7EXOTFVQFqfxumrmmxggmNUCatBM65gX082oPBTremyJNr8R1y6p4gfeAFGuInzsvw4GY/fDKU
	3VOu7i9H7vAWeCC3zHuJhp+hSifosIbe8CHNh086teeVpRJFS+1HUF9H1mGfhvW6N7xJ2JyL7j8
	/Se3JNb7whoGKNTQ43iZ1pcDsjkybNoqqda4qESyp376dC4+lUJIz5vkMBSk4VddoWm1H+8kUti
	9zotm8
X-Received: by 2002:a17:90b:4b8d:b0:37f:9ce1:735b with SMTP id 98e67ed59e1d1-3805277fbadmr2212775a91.28.1782814949656;
        Tue, 30 Jun 2026 03:22:29 -0700 (PDT)
Received: from houminxi ([166.0.188.190])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-380529ab9f4sm1425597a91.7.2026.06.30.03.22.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 03:22:29 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	aconole@redhat.com,
	echaudro@redhat.com,
	linux-kselftest@vger.kernel.org
Subject: [PATCH v3] selftests/net/openvswitch: add ICMPv6 echo type match test
Date: Tue, 30 Jun 2026 18:22:25 +0800
Message-ID: <20260630102225.29733-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-303078-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:houminxi@gmail.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 5D7816E2F64

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
 .../selftests/net/openvswitch/openvswitch.sh  | 63 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 26 +++++---
 2 files changed, 82 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..2de01137bb50 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	icmpv6					icmpv6: ICMPv6 echo type match
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,68 @@ test_action_set() {
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

base-commit: cef9d6804030793cf8b8796fd6936197d065dd3e
-- 
2.54.0


