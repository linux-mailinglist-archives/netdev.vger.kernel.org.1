Return-Path: <netdev+bounces-297181-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0AgdLj1IKGpBBgMAu9opvQ
	(envelope-from <netdev+bounces-297181-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:07:09 +0200
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EF38662C1D
	for <lists+netdev@lfdr.de>; Tue, 09 Jun 2026 19:07:09 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=UIK1piuF;
	spf=pass (mail.lfdr.de: domain of "netdev+bounces-297181-lists+netdev=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="netdev+bounces-297181-lists+netdev=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33C9030984C2
	for <lists+netdev@lfdr.de>; Tue,  9 Jun 2026 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 719D64ADD95;
	Tue,  9 Jun 2026 16:57:43 +0000 (UTC)
X-Original-To: netdev@vger.kernel.org
Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5CE54ADD85
	for <netdev@vger.kernel.org>; Tue,  9 Jun 2026 16:57:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781024263; cv=none; b=HwfFQbzd8072ppwZk2JhCahRXZhvfurt86HCqGJJW3C6VLwyVs+gvDUuY1pdjrUmyBruqinFk1eaGDf9j/LVxLXeLigLctvNaU1tvPOfv7l4DQr7UdHaUmskChh6E4S5xHwGbMOfWv/GMY+0R8M2JlIAx8of4BMMgYL/bADQdaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781024263; c=relaxed/simple;
	bh=JZcX41kc/PnmNGyLbsWtRkljYop+3TqNeiSZZrwHmck=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MS7eFOPCwVeFmBFcBYf6BRz/J3nK2fFCQN81bwb5jbdZ2AnTU68K58d4+s+3l90MuXT0QfdALEvA7m3kDrfEUS0fSwCqTl7UCmRsYyid5POAL4oaRejJkBX7X7D5PZZkEU5Nv3Y8mTWBXdUZPo9btiYmGqe5pIFmqzDoDTT3XIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UIK1piuF; arc=none smtp.client-ip=209.85.128.179
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-7e2fa3062easo59313697b3.2
        for <netdev@vger.kernel.org>; Tue, 09 Jun 2026 09:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781024261; x=1781629061; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=av7EYFBoj6gq1ZvLp6d893SbwiyvMCDkkTCv0M4AutE=;
        b=UIK1piuF1PzV/1g9rsMp2cDSLJyyX8YMAM6K5fC4Un4kAvMjLeVHS8Srd9M+B8GUlj
         O1tF/YuXyY/dKf+tsI0OaLMNFWO5Yfolvl2mA8jLgOPaExHB22gpNG3KUsiQAXYUQfh3
         AVkaVkXMCKJDgC6/ryp3MNvaR++cCVBq4tP4++qpdYqKU4fP+BTT0V8E+/gWQp1zj+0i
         zhSL3SgiZ3zGXwGdl/KVKRTRwMKX9oXkPNDd5xvl1GcriZ2oZNUdWq2wpk7WWlb3NjdI
         iq+SdjbfrUFnl/JLyV3QzN52GDEkZRLzpoa0s4vxkKoWSdAO/tiw0yqo22c9+0uS59Rf
         W4yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781024261; x=1781629061;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=av7EYFBoj6gq1ZvLp6d893SbwiyvMCDkkTCv0M4AutE=;
        b=pElVaWKQ4fxMR97zRz0mx4ncA1s9Y6Dc/QL4ikErejHcGowU4KkZx2WNE9466AgOyh
         MExaK/RpYC8txu1BOBSxqOqiLKIcWKHApOPDaF9kxTb/HMt67l8jt0CH/IUe4uaNlOpG
         BL23otg1S1jCc9BrKopBJ0p7kLxV1qXiy0GM78TbvgRlboEAYxJj5J5cPKHyiB3Rmnms
         cMZtacTA67bYLTIPN/f9GBSXgBon7Lv6CYYfzImx8gJwz4x2o6EnaNnQDe6sGZG9/paK
         jZbe7vTXgLCpu0qmh4K/fR376eE4P0lPzABJJ0eTYqv0Chr8pClHRmNVlB3FC0gNshpD
         2e1A==
X-Gm-Message-State: AOJu0YyQqWpCBZG+3Kknc/4ZHTxRXmXKCfgewrQ0K2aHBl5m7tuv2bnN
	AFnUXFgSJECigFxw6V56D7mYaypCgsV4MFag2uUIfVyq/yFOJGXXPsq2qW3RHSgpU/g=
X-Gm-Gg: Acq92OHAjH6lesLQMgNlSyKvpCwYny4KiU0Ypu9OeYBpCiMQEoCG68bufyw0+P7ZFeA
	OAAl60o6/Qxxv+CtoWsuPNzWQX0UYF6rNH9bVn5xvL9/FpXMGhRQcXXEIRkdpRBLyPQqxX1qHuJ
	MBswCIASA3GUZFZpIe1X/WNkncPOkmEzjTYninntcjYy81wr4PmujzQ4N8kt7blxz18hdPs1JPr
	GdiKRA6hpsF6q8VOMfVRdxKcQjjjt0d+s9AsL/bmAavR8EgI8WJ089cnldUImI9iig2cG+ZxACT
	x+GYTs5vkVZAnrNULi7mZ9Xq4Y9BdaZO0h5JryyIeix3v5y34MW0Jo/QAc4dxK+CR5bQyZL8HXH
	LN6y/S8TPOyF5qvdf9d6CDVQIEq5S8h28asGxsLkKnq2TBXObyBdmumGXl9CxiexyuFuTsf4G6r
	DQZyl5WAtgIHqoKl8O9uPPbRuwhVmagf8DSKoS
X-Received: by 2002:a05:690c:710a:b0:7bd:5579:185a with SMTP id 00721157ae682-7ed0c80a062mr196768697b3.25.1781024260523;
        Tue, 09 Jun 2026 09:57:40 -0700 (PDT)
Received: from houminxi ([23.133.88.228])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7ea215825d2sm99814537b3.16.2026.06.09.09.57.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 09:57:40 -0700 (PDT)
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
	amorenoz@redhat.com,
	Minxi Hou <houminxi@gmail.com>
Subject: [PATCH net-next v2] selftests/net/openvswitch: add flow modify test
Date: Wed, 10 Jun 2026 00:57:25 +0800
Message-ID: <20260609165725.107484-1-houminxi@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[redhat.com,ovn.org,davemloft.net,google.com,kernel.org,openvswitch.org,vger.kernel.org,gmail.com];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-297181-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:netdev@vger.kernel.org,m:aconole@redhat.com,m:echaudro@redhat.com,m:i.maximets@ovn.org,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:horms@kernel.org,m:shuah@kernel.org,m:dev@openvswitch.org,m:linux-kselftest@vger.kernel.org,m:amorenoz@redhat.com,m:houminxi@gmail.com,s:lists@lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2EF38662C1D

Add mod_flow() and the mod-flow CLI command to ovs-dpctl.py, exercising
OVS_FLOW_CMD_SET. Add test_flow_set which first modifies an existing
flow with new actions and verifies the change via traffic, then modifies
the same flow without actions and verifies the kernel handles the
no-actions case gracefully.

The no-actions path is unreachable from userspace OVS tools (dpctl
mod-flow requires actions) but reachable via raw netlink. This is the
code path where Adrian Moreno found a possible kfree_skb of ERR_PTR
when reply allocation fails after locking.

Make parse() skip OVS_FLOW_ATTR_ACTIONS when actstr is None so the
kernel enters the post-lock allocation branch in ovs_flow_cmd_set().
After the no-actions set, verify via dump-flows that the flow retained
its drop action.

Suggested-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: Minxi Hou <houminxi@gmail.com>
---
v1 -> v2:
  - Add dump-flows verification after no-actions mod-flow (Aaron)
  - Add docstring to mod_flow() (pylint C0116)
  - Use f-string in DP-not-found message (pylint C0209)
---
 .../selftests/net/openvswitch/openvswitch.sh  | 77 +++++++++++++++++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 40 +++++++++-
 2 files changed, 114 insertions(+), 3 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index 82f066a0ceed..d533decca5c1 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -30,6 +30,7 @@ tests="
 	drop_reason				drop: test drop reasons are emitted
 	pop_vlan				vlan: POP_VLAN action strips tag
 	dec_ttl					ttl: dec_ttl decrements IP TTL
+	flow_set				flow-set: Flow modify
 	psample					psample: Sampling packets with psample"
 
 info() {
@@ -193,6 +194,23 @@ ovs_add_flow () {
 	return 0
 }
 
+ovs_mod_flow () {
+	if [ -n "$4" ]; then
+		info "Modifying flow: sbx:$1 br:$2 flow:$3 act:$4"
+		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py \
+			mod-flow "$2" "$3" "$4"
+	else
+		info "Modifying flow (no actions): sbx:$1 br:$2 flow:$3"
+		ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py \
+			mod-flow "$2" "$3"
+	fi
+	if [ $? -ne 0 ]; then
+		info "Flow modify [ $3 ] failed"
+		return 1
+	fi
+	return 0
+}
+
 ovs_del_flows () {
 	info "Deleting all flows from DP: sbx:$1 br:$2"
 	ovs_sbx "$1" python3 $ovs_base/ovs-dpctl.py del-flows "$2"
@@ -300,6 +318,65 @@ test_dec_ttl() {
 	return 0
 }
 
+test_flow_set() {
+	sbx_add "test_flow_set" || return $?
+	ovs_add_dp "test_flow_set" flowset || return 1
+
+	info "create namespaces"
+	for ns in client server; do
+		ovs_add_netns_and_veths "test_flow_set" "flowset" "$ns" \
+			"${ns:0:1}0" "${ns:0:1}1" || return 1
+	done
+
+	ip netns exec client ip addr add 10.0.0.1/24 dev c1
+	ip netns exec client ip link set c1 up
+	ip netns exec server ip addr add 10.0.0.2/24 dev s1
+	ip netns exec server ip link set s1 up
+
+	ovs_add_flow "test_flow_set" flowset \
+		'in_port(1),eth(),eth_type(0x0806),arp()' '2' || return 1
+	ovs_add_flow "test_flow_set" flowset \
+		'in_port(2),eth(),eth_type(0x0806),arp()' '1' || return 1
+
+	local fwd_flow="ufid:00000001-0002-0003-0004-000500060007"
+	fwd_flow="$fwd_flow,in_port(1),eth(),eth_type(0x0800),ipv4()"
+
+	ovs_add_flow "test_flow_set" flowset "$fwd_flow" '2' \
+		|| return 1
+	ovs_add_flow "test_flow_set" flowset \
+		'in_port(2),eth(),eth_type(0x0800),ipv4()' '1' || return 1
+
+	info "verify initial forwarding"
+	ovs_sbx "test_flow_set" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 || return 1
+
+	info "mod-flow with new actions (change to drop)"
+	ovs_mod_flow "test_flow_set" flowset "$fwd_flow" 'drop' \
+		|| return 1
+
+	info "verify traffic is now dropped"
+	ovs_sbx "test_flow_set" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should fail after mod-flow to drop"
+		     return 1; }
+
+	info "mod-flow without actions"
+	ovs_mod_flow "test_flow_set" flowset "$fwd_flow" || return 1
+
+	info "verify flow retained drop action via dump"
+	python3 "$ovs_base/ovs-dpctl.py" dump-flows flowset \
+		| grep -q "actions:drop" || \
+		{ info "FAIL: flow not showing drop action"; return 1; }
+
+	info "verify drop actions unchanged"
+	ovs_sbx "test_flow_set" ip netns exec client ping -c 1 -W 2 \
+		10.0.0.2 >/dev/null 2>&1 \
+		&& { info "FAIL: ping should still fail after no-actions set"
+		     return 1; }
+
+	return 0
+}
+
 # psample test
 # - use psample to observe packets
 test_psample() {
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index 3342e295293d..e1ecfad2c03e 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -2702,9 +2702,10 @@ class OvsFlow(GenericNetlinkSocket):
             self["attrs"].append(["OVS_FLOW_ATTR_KEY", k])
             self["attrs"].append(["OVS_FLOW_ATTR_MASK", m])
 
-            a = ovsactions()
-            a.parse(actstr)
-            self["attrs"].append(["OVS_FLOW_ATTR_ACTIONS", a])
+            if actstr is not None:
+                a = ovsactions()
+                a.parse(actstr)
+                self["attrs"].append(["OVS_FLOW_ATTR_ACTIONS", a])
 
     def __init__(self):
         GenericNetlinkSocket.__init__(self)
@@ -2738,6 +2739,25 @@ class OvsFlow(GenericNetlinkSocket):
             raise ne
         return reply
 
+    def mod_flow(self, dpifindex, flowmsg):
+        """Modify an existing flow in the kernel."""
+        flowmsg["cmd"] = OVS_FLOW_CMD_SET
+        flowmsg["version"] = OVS_DATAPATH_VERSION
+        flowmsg["reserved"] = 0
+        flowmsg["dpifindex"] = dpifindex
+
+        try:
+            reply = self.nlm_request(
+                flowmsg,
+                msg_type=self.prid,
+                msg_flags=NLM_F_REQUEST | NLM_F_ACK,
+            )
+            reply = reply[0]
+        except NetlinkError as ne:
+            print(flowmsg)
+            raise ne
+        return reply
+
     def del_flows(self, dpifindex):
         """
         Send a del message to the kernel that will drop all flows.
@@ -3013,6 +3033,12 @@ def main(argv):
     addflcmd.add_argument("flow", help="Flow specification")
     addflcmd.add_argument("acts", help="Flow actions")
 
+    modflcmd = subparsers.add_parser("mod-flow")
+    modflcmd.add_argument("modbr", help="Datapath name")
+    modflcmd.add_argument("modflow", help="Flow specification")
+    modflcmd.add_argument("modacts", help="Flow actions",
+                          nargs="?", default=None)
+
     delfscmd = subparsers.add_parser("del-flows")
     delfscmd.add_argument("flsbr", help="Datapath name")
 
@@ -3110,6 +3136,14 @@ def main(argv):
         flow = OvsFlow.ovs_flow_msg()
         flow.parse(args.flow, args.acts, rep["dpifindex"])
         ovsflow.add_flow(rep["dpifindex"], flow)
+    elif hasattr(args, "modbr"):
+        rep = ovsdp.info(args.modbr, 0)
+        if rep is None:
+            print(f"DP '{args.modbr}' not found.")
+            return 1
+        flow = OvsFlow.ovs_flow_msg()
+        flow.parse(args.modflow, args.modacts, rep["dpifindex"])
+        ovsflow.mod_flow(rep["dpifindex"], flow)
     elif hasattr(args, "flsbr"):
         rep = ovsdp.info(args.flsbr, 0)
         if rep is None:
-- 
2.54.0


