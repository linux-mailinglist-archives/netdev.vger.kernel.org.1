Return-Path: <netdev+bounces-304021-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ID4VA+QZRmocKAsAu9opvQ
	(envelope-from <netdev+bounces-304021-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:57:24 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DE6806F47E5
	for <lists+netdev@lfdr.de>; Thu, 02 Jul 2026 09:57:22 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=OM+roVe9;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-304021-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-304021-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 2F87C300C7EF
	for <lists+netdev@lfdr.de>; Thu,  2 Jul 2026 07:51:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 176833CAA57;
	Thu,  2 Jul 2026 07:50:58 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com [209.85.128.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C883C7E0B
	for <netdev@vger.kernel.org>; Thu,  2 Jul 2026 07:50:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782978657; cv=none; b=hMn/DxTXaNLNSOTr1i34mEyQ4ZD6w6NvTvxlUkTD5NUnfdRK+4MmDXNK0T4XJKJh/BwGeZsl5HTrjJ7TPudvXCyRKhIfdTimhFy++BY42BjvWv9rfcjxZM5u+ydjj7vAS4yBrI7FEQ7qcB+kn8sn6BQLHz5SasyDq64eCdVa1Gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782978657; c=relaxed/simple;
	bh=LPKKzLAxEoXPH5mOcbq24gwcNHHJ3iPYqHxz0xV9nWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=br98kAtTFzLt/N5GZ/IcSW3sstZVeWlnBFAiKcC4AEIpBG2WDza0lhXXn4OCJZWoPwQmtdHX3gk6FEiKNN4lAMqyZ/g+27L0g7lMedSlFszvTXHrqPnr7p4hH+9vDCYfv0KqREE0JhSrvgebPsr6ti/7KbruqDo4/kSwbfjssXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OM+roVe9; arc=none smtp.client-ip=209.85.128.172
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-8143d904b01so8659327b3.3
        for <netdev@vger.kernel.org>; Thu, 02 Jul 2026 00:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1782978652; x=1783583452; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LnSLH8TarCnofbwejfF0AMt0gJL72Ru2Rk6q84rX6ps=;
        b=OM+roVe9de9Mg6L10BfPWL+CzGN7eq4VB9nTmOa6iQ8AWJ/CRYMMQBFonxZP3G8404
         OrLy7OcYGosH/tcmdQ7NyztsayQP4YOp3WO+trqZ4MzPn65MdrYkzmNOEnXtb4wVYy7Y
         KQ1DZ2xscXpEF2syhr+Z60AL3FVvpTFqjIAYrsqdLmEgGaWbY3lnOPBaVI6s2DJAQoEm
         YU709uJk7a6ySXpmoeweMPbYpd1FbrRK8GE984TuqOcczJ3J3QIWSDAxEos9mnYkw0jo
         MxY7yHa9RwIPDi3Ayp7MKtY+IrJhWRXl+sfipSWp3xZ5ZK2KbZt7xc98YjGQpNlCI37T
         kBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782978652; x=1783583452;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LnSLH8TarCnofbwejfF0AMt0gJL72Ru2Rk6q84rX6ps=;
        b=RI991u7PYHdHKXLbWDdwVfSh922SBPmRH9fmshx9LHISXODmCB1BGjUE6TLLMpcGOK
         Kximy6ZKJ+goSraag+LMc2R5R+Ev8Dhv1kRwnwpvk7M/D++p1eSCQJBm2jfshRsMu3Y/
         Vvh9yNlLevg8vQINcxezGmXUp2RCO4pfSmbsg0p0rYn3K2GX+a5TGHdf11mVTSK8av+C
         QFHiFsEK0WzdEWe3VYhcDJ+xal54fihjJIg2HG872P/MUvHg+4tBo8rnXhytKADVgXO8
         BBGbE4vSk7z8AOB8pKm2FBGq5iwfh8x8GUxyqvRBA7mD3wv70UUSTg7VydxsUyOYee7q
         PYgg==
X-Gm-Message-State: AOJu0YzV8dugw/i1mGcDRb2QlT0WK5Khuk20JpAM4n7sOgx7GC8jU30G
	OoCzgf365EfRtICeuXaTs7UQVPnhaqnM9TbDAcWZHMGvswwMHLiyzmxYVbdMqu4KuP8JtQ==
X-Gm-Gg: AfdE7clK3WkDshDGjnAGA8ZHhCK2/x74CFb+sfO3PBI7/KALS2G72rTSV7BKAoa1rP2
	GNbLEXiQQi6c12x5WOUhEZ/JZco976U/41HUKVsWPlC1Zul3DINpXSF7bb/c4urm6FkLz5sbdEm
	+1UEzs5bd1K/1cJqYUMd6qdQJRD4PA31+jUzGY0EpyiRjiklZaKBk9YXnfBAJ/QRtQcQoiifERt
	YZrq1/tMx5gnpQIps3k1oFPm9kBxOl9AIxHbxI53rcGGh4KSaYeXwQ5QwkUfVAWOMTiFuoHmqH6
	l7tTLstxsEZchkprd7wzL0k32U1n0pBqEzu+mV8Y6I/nurkaUgfAw6eKdtVAvOrXTckPU5D3FpD
	f86sK5xyy7iIbk6BVi743zWByTGE1Vf12aJJsiHBBGIG60of0rhK6y5bD7Qe4LcBEpiFQPAJmTJ
	v5einA
X-Received: by 2002:a05:690c:6201:b0:80c:aff6:9d47 with SMTP id 00721157ae682-812e8dfa5e7mr54752167b3.4.1782978652164;
        Thu, 02 Jul 2026 00:50:52 -0700 (PDT)
Received: from houminxi ([23.133.88.228])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-8144b049939sm9451747b3.32.2026.07.02.00.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jul 2026 00:50:51 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: Minxi Hou <houminxi@gmail.com>,
	aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org
Subject: [PATCH net-next v4] selftests/net/openvswitch: add ICMPv6 echo type match test
Date: Thu,  2 Jul 2026 03:50:44 -0400
Message-ID: <20260702075044.1176798-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-304021-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:houminxi@gmail.com,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: DE6806F47E5

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
static neighbour entries with nud permanent to prevent racy NDP, then
verifies in three steps: install icmpv6(type=128) and
icmpv6(type=129) flows and confirm ping works, remove the flows and
confirm ping fails, reinstall and confirm recovery.

Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
 .../selftests/net/openvswitch/openvswitch.sh  | 70 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 26 +++++--
 2 files changed, 89 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 2954245129a2..f88cefa71559 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -32,6 +32,7 @@ tests="
 	dec_ttl					ttl: dec_ttl decrements IP TTL
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
+	icmpv6					icmpv6: ICMPv6 echo type match
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -443,6 +444,75 @@ test_action_set() {
 	return 0
 }
 
+# icmpv6 test
+# - static neighbours to bypass NDP (nud permanent)
+# - icmpv6(type=128) echo request, icmpv6(type=129) echo reply
+# - remove flows and verify ping fails, reinstall and recover
+test_icmpv6() {
+	local t="test_icmpv6"
+	local v6="eth_type(0x86dd),ipv6(proto=58)"
+
+	sbx_add "$t" || return $?
+	ovs_add_dp "$t" icmpv6 || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "$t" "icmpv6" \
+		    "$ns" "${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add fd00::1/64 dev c1 nodad
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add fd00::2/64 dev s1 nodad
+	ip netns exec server ip link set s1 up
+
+	local cl_mac sl_mac
+	cl_mac=$(ip netns exec client ip link show c1 \
+	    | awk '/link\/ether/ {print $2}')
+	[ -z "$cl_mac" ] && \
+	    { info "failed to get c1 hwaddr"; return 1; }
+	sl_mac=$(ip netns exec server ip link show s1 \
+	    | awk '/link\/ether/ {print $2}')
+	[ -z "$sl_mac" ] && \
+	    { info "failed to get s1 hwaddr"; return 1; }
+	ip netns exec client ip -6 neigh add fd00::2 \
+	    lladdr "$sl_mac" nud permanent dev c1 || return 1
+	ip netns exec server ip -6 neigh add fd00::1 \
+	    lladdr "$cl_mac" nud permanent dev s1 || return 1
+
+	ovs_add_flow "$t" icmpv6 \
+	    "in_port(1),eth(),$v6,icmpv6(type=128)" \
+	    '2' || return 1
+	ovs_add_flow "$t" icmpv6 \
+	    "in_port(2),eth(),$v6,icmpv6(type=129)" \
+	    '1' || return 1
+
+	info "verify ICMPv6 echo with type-specific flows"
+	ovs_sbx "$t" ip netns exec client \
+	    ping -6 -c 1 -W 2 fd00::2 || return 1
+
+	ovs_del_flows "$t" icmpv6
+
+	info "verify ping fails without echo flows"
+	ovs_sbx "$t" ip netns exec client \
+	    ping -6 -c 1 -W 2 fd00::2 >/dev/null 2>&1 \
+	    && { info "ping should fail without flows"
+	         return 1; }
+
+	ovs_add_flow "$t" icmpv6 \
+	    "in_port(1),eth(),$v6,icmpv6(type=128)" \
+	    '2' || return 1
+	ovs_add_flow "$t" icmpv6 \
+	    "in_port(2),eth(),$v6,icmpv6(type=129)" \
+	    '1' || return 1
+
+	info "verify connectivity restored"
+	ovs_sbx "$t" ip netns exec client \
+	    ping -6 -c 1 -W 2 fd00::2 || return 1
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


