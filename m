Return-Path: <netdev+bounces-306207-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id /u1SNc6OT2qVjgIAu9opvQ
	(envelope-from <netdev+bounces-306207-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:06:38 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 39CCD730D09
	for <lists+netdev@lfdr.de>; Thu, 09 Jul 2026 14:06:38 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=Luztgaru;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-306207-lists+netdev=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="netdev+bounces-306207-lists+netdev=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6F4F33048A29
	for <lists+netdev@lfdr.de>; Thu,  9 Jul 2026 12:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D4473A75B8;
	Thu,  9 Jul 2026 12:05:55 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B1F438D3E4
	for <netdev@vger.kernel.org>; Thu,  9 Jul 2026 12:05:52 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783598755; cv=none; b=GqZHVC9rVedWfvXPHtFlmKjbDs7V8I19iMqkNdOp8ZfIQQnPzdbLb7u2+ky6Fv+sULmXaD8NJDyXDnB8V7T667kbOKQDs4jIyRcUSew33PBFeCVv8Ta+hW6+AJ31BYzffNVp7dtY3sUzn+EaFFkugcWYaQz5BnF/LuanugyZyTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783598755; c=relaxed/simple;
	bh=Xpm6MQWDX7aRAweX1OV+RWi+RLDWSMe7HAgl/tiRlIc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KeHZiGU0wVk52+mWblZKpUGXOk4rwhuJOftgknVuNzyMUovMmKSGo6qKdqR4GuQINImBKhbNUBR2RBCHyDuJTImi1FPXIUxchFFM/BY6praq6iO5xCr8DOMYJQyMupmk0yWmaJx7/uCxyK8OQZgIjhZkJmWi/gEstAEWipzez2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Luztgaru; arc=none smtp.client-ip=209.85.216.43
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-3811e59df58so1161054a91.1
        for <netdev@vger.kernel.org>; Thu, 09 Jul 2026 05:05:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783598752; x=1784203552; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MvOYhABQBZgVCYLrX1qUOXEJIIllSDeJsuhmTp6V9I0=;
        b=LuztgarujTjh73/fdI918NkHjhm64W+5lURKYMSeS+raAbQqshtwJx/mW7kgpCSBKC
         2flspSNlrEne/j/6582stkGLYIberPknLCEIV43b2DcisGS0GFo9+ONKeB6ijvhHrRA1
         f/Sjz+QV6AC4ZoNDcJlAYOA49texq3cHOkz1F80fSJNW/0tZvv/c8qdWArjH1dHZgBrr
         TqmYuRushuWtGNr6Kb4QSYKpmNmDIYYLTDbifjyUKuF29/JRG9ZPyRmWnmqz4lGZ1hyU
         EaMFQm/pVpdkAklBBbrsr24dHPfmhE66o5xh4auqD4TSD4dY4ZlD2GmbrbHpm83x2HpG
         2eIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783598752; x=1784203552;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MvOYhABQBZgVCYLrX1qUOXEJIIllSDeJsuhmTp6V9I0=;
        b=MfO9hM1ZYlrLqDq24y4l0jQ9JdlPgq+lKh7UII+lBVZcKSw7jbNRwjjKAFuLs8nFXH
         MslT5pn+gCBjbYRSTbeXhstMXpUA8BHeE8vas8luxxjLP1O0ZYDkiUSV2mnOlCv3UgyR
         CrRF3BAkroM+PQFcV+3tKU5akRvZekSbq/Ksach8hKPi/yL4VJ0J7Z+KR5UpIt1BeNn6
         Cc9svvCrYLSisOO8BsO8OVr/GijJ1b3Ta9642eAyFvh2w0v84B2QqQ1IdAfs6E8TXKMZ
         nqSgIzN99KR2T7benn7JzNcP/ZyqDlyABpN0nhWnM66tCU9cTw/82Qa9LdgSzxeElmf2
         uppA==
X-Gm-Message-State: AOJu0YzxAnzZg2snk3Xh0szsnntUe5Mlr72q9ur2j6O6VminfXYL8wIJ
	L/BhL8e7v6Pq++bVPhusPyYXAffcPqT2soAsrperwVQVstDMlKxWeuiqjKq1fqCzkkBYNw==
X-Gm-Gg: AfdE7cn1yfpk/G2vfU1ujxLNOVYEvg8HVmtHFtXH6D8KK18hmI8oa1kCtu1JrxV2MQL
	8cPiBGoAKkf66GcQB9TappXyE/APcmVsbUoULnEpmvEwFPN8pv2piUrbuXltcC+Obhya4LQv8Yf
	F5+/fkI04tMT19o9qdLrZbP9HB6WrrL5URJ8xYqAsnRujvQiaH1B91zn8WZJRJDTvauDFC754xR
	tQSA+fr2e2+xzshysx8UzMLScO8FYxqQo8eUp/x9xwqCq364HrZDHdq1VYIjC+GhMMp+d4qj5mZ
	NVNxrqIZ37aNmaYKdKR9KtukkM6wVgHppEJA9iYNxhbNi+JF19ETQ3Pm9I9IcG7JJKSqD5LnWSJ
	NclVF1C+E2vETlYcK54UEzjWPrmBEsQ6lXvMxttZAO3I23khfSH0Iqe2NiIqaG7aLMO+37gJoPw
	aQYg3csxkr6WQAPQQTsg==
X-Received: by 2002:a17:90b:350c:b0:36d:7b62:4767 with SMTP id 98e67ed59e1d1-3893fe5b986mr7411064a91.5.1783598751625;
        Thu, 09 Jul 2026 05:05:51 -0700 (PDT)
Received: from houminxi ([104.167.197.198])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38a52238e12sm1131084a91.0.2026.07.09.05.05.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2026 05:05:50 -0700 (PDT)
From: Minxi Hou <houminxi@gmail.com>
To: netdev@vger.kernel.org
Cc: aconole@redhat.com,
	echaudro@redhat.com,
	i.maximets@ovn.org,
	i.maximets@redhat.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	shuah@kernel.org,
	dev@openvswitch.org,
	linux-kselftest@vger.kernel.org,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v5] selftests/net/openvswitch: add ICMPv6 echo type match test
Date: Thu,  9 Jul 2026 08:05:41 -0400
Message-ID: <20260709120541.3556748-1-houminxi@gmail.com>
X-Mailer: git-send-email 2.55.0
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
	TAGGED_FROM(0.00)[bounces-306207-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:i.maximets@redhat.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:houminxi@gmail.com,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[houminxi@gmail.com,netdev@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[14];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 39CCD730D09

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
Reviewed-by: Aaron Conole <aconole@redhat.com>
---
v4 -> v5: rebase onto latest net-next (2026-07-09), add ksft_skip probe for ICMPv6 key support
 .../selftests/net/openvswitch/openvswitch.sh  | 81 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 26 ++++--
 2 files changed, 100 insertions(+), 7 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f75ee723415a..853dbc1b00d7 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -33,6 +33,7 @@ tests="
 	flow_set				flow-set: Flow modify
 	action_set				set: SET action rewrites fields
 	trunc					trunc: output truncation
+	icmpv6					icmpv6: ICMPv6 echo type match
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -530,6 +531,86 @@ test_trunc() {
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
+	# Probe: check if kernel supports icmpv6 flow key.
+	ovs_add_flow "$t" icmpv6 \
+	    "in_port(1),eth(),$v6,icmpv6(type=128)" \
+	    '2' &>/dev/null
+	if [ $? -ne 0 ]; then
+		info "no support for icmpv6 key - skipping"
+		ovs_exit_sig
+		return $ksft_skip
+	fi
+	ovs_del_flows "$t" icmpv6
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
2.55.0


