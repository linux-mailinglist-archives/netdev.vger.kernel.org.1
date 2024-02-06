Return-Path: <netdev+bounces-69470-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BC72584B607
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 14:12:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3AB43B26888
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 13:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B044B130E46;
	Tue,  6 Feb 2024 13:11:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ERFpZUdE"
X-Original-To: netdev@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282F3130E2E
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 13:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707225116; cv=none; b=iKyGL6L7KD9eEaQGg42CVgV686bYLRTTGDZmZPhXFt3FWYVGH/xhfTPBRs5mQ8CzzztZDoP+o0RuqGKHLFfqjsGc0EIYgBmUM44xtoBDtVh+zvYA6j22WULL6mlW3mlQmaXxh4XXWhgIO60QhzNY8Ez6B4p0eExGhhCabqu3pAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707225116; c=relaxed/simple;
	bh=rIyVf4kV6BaoeCtKpNOhavupwvSR0wERy6rx2HpiSkw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tRaJ439KZYq1DQ//pGQSBnU9eSrYyxT5e5GtJ//eT3jwdEJrc+c71Sd72SXs4Vy1gBWPvuoOoM3Oj29k8Xt7nvIAaKGAUvTsT/Pgvi41Vo/O9ZWVC8YX27xBc1HF4qooWWNHfN4KNkBc8jHXb8ezDr/rex9kxS0bj1icZR9MeDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ERFpZUdE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707225112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bV/sn9acX+AcYHI7dxpYyku1szU8bZPM4h5SUT5sGxY=;
	b=ERFpZUdEXSzWiOOrhCRR44zMrPBHj8NG3dizu7jgGeh9SKQz8Y31sHD7I59FHB3HwW6IBc
	YfB8Pq63vQ4FDL7kx2ictGykF8pXW6RFpmqOhVlWn7ROq8XTN/zd6401Jbrlgn/nRQnKg/
	jb6As18uvpk6It5UMODVDz683NJLbLs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-Vj_9-Pv1PeqIBxRlgJgnYg-1; Tue,
 06 Feb 2024 08:11:49 -0500
X-MC-Unique: Vj_9-Pv1PeqIBxRlgJgnYg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31898383E126;
	Tue,  6 Feb 2024 13:11:49 +0000 (UTC)
Received: from RHTPC1VM0NT.lan (unknown [10.22.8.151])
	by smtp.corp.redhat.com (Postfix) with ESMTP id BB5E92026D06;
	Tue,  6 Feb 2024 13:11:48 +0000 (UTC)
From: Aaron Conole <aconole@redhat.com>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Pravin B Shelar <pshelar@ovn.org>,
	dev@openvswitch.org,
	Ilya Maximets <i.maximets@ovn.org>,
	Simon Horman <horms@ovn.org>,
	Eelco Chaudron <echaudro@redhat.com>
Subject: [PATCH net 2/2] selftests: openvswitch: Add validation for the recursion test
Date: Tue,  6 Feb 2024 08:11:47 -0500
Message-ID: <20240206131147.1286530-3-aconole@redhat.com>
In-Reply-To: <20240206131147.1286530-1-aconole@redhat.com>
References: <20240206131147.1286530-1-aconole@redhat.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Add a test case into the netlink checks that will show the number of
nested action recursions won't exceed 16.  Going to 17 on a small
clone call isn't enough to exhaust the stack on (most) systems, so
it should be safe to run even on systems that don't have the fix
applied.

Signed-off-by: Aaron Conole <aconole@redhat.com>
---
NOTE: This patch may be safely omitted for trees that don't
      include the selftests

 .../selftests/net/openvswitch/openvswitch.sh  | 13 ++++
 .../selftests/net/openvswitch/ovs-dpctl.py    | 71 +++++++++++++++----
 2 files changed, 69 insertions(+), 15 deletions(-)

diff --git a/tools/testing/selftests/net/openvswitch/openvswitch.sh b/tools/testing/selftests/net/openvswitch/openvswitch.sh
index f8499d4c87f3..30cb9d3b035d 100755
--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -502,7 +502,20 @@ test_netlink_checks () {
 	    wc -l) == 2 ] || \
 	      return 1
 
+	info "Checking clone depth"
 	ERR_MSG="Flow actions may not be safe on all matching packets"
+	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
+	ovs_add_flow "test_netlink_checks" nv0 \
+		'in_port(1),eth(),eth_type(0x800),ipv4()' \
+		'clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(clone(drop)))))))))))))))))' \
+		&> /dev/null && return 1
+	POST_TEST=$(dmesg | grep -c "${ERR_MSG}")
+
+	if [ "$PRE_TEST" == "$POST_TEST" ]; then
+		info "failed - clone depth too large"
+		return 1
+	fi
+
 	PRE_TEST=$(dmesg | grep -c "${ERR_MSG}")
 	ovs_add_flow "test_netlink_checks" nv0 \
 		'in_port(1),eth(),eth_type(0x0806),arp()' 'drop(0),2' \
diff --git a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
index b97e621face9..5e0e539a323d 100644
--- a/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
+++ b/tools/testing/selftests/net/openvswitch/ovs-dpctl.py
@@ -299,7 +299,7 @@ class ovsactions(nla):
         ("OVS_ACTION_ATTR_PUSH_NSH", "none"),
         ("OVS_ACTION_ATTR_POP_NSH", "flag"),
         ("OVS_ACTION_ATTR_METER", "none"),
-        ("OVS_ACTION_ATTR_CLONE", "none"),
+        ("OVS_ACTION_ATTR_CLONE", "recursive"),
         ("OVS_ACTION_ATTR_CHECK_PKT_LEN", "none"),
         ("OVS_ACTION_ATTR_ADD_MPLS", "none"),
         ("OVS_ACTION_ATTR_DEC_TTL", "none"),
@@ -465,29 +465,42 @@ class ovsactions(nla):
                     print_str += "pop_mpls"
             else:
                 datum = self.get_attr(field[0])
-                print_str += datum.dpstr(more)
+                if field[0] == "OVS_ACTION_ATTR_CLONE":
+                    print_str += "clone("
+                    print_str += datum.dpstr(more)
+                    print_str += ")"
+                else:
+                    print_str += datum.dpstr(more)
 
         return print_str
 
     def parse(self, actstr):
+        totallen = len(actstr)
         while len(actstr) != 0:
             parsed = False
+            parencount = 0
             if actstr.startswith("drop"):
                 # If no reason is provided, the implicit drop is used (i.e no
                 # action). If some reason is given, an explicit action is used.
-                actstr, reason = parse_extract_field(
-                    actstr,
-                    "drop(",
-                    "([0-9]+)",
-                    lambda x: int(x, 0),
-                    False,
-                    None,
-                )
+                reason = None
+                if actstr.startswith("drop("):
+                    parencount += 1
+
+                    actstr, reason = parse_extract_field(
+                        actstr,
+                        "drop(",
+                        "([0-9]+)",
+                        lambda x: int(x, 0),
+                        False,
+                        None,
+                    )
+
                 if reason is not None:
                     self["attrs"].append(["OVS_ACTION_ATTR_DROP", reason])
                     parsed = True
                 else:
-                    return
+                    actstr = actstr[len("drop"): ]
+                    return (totallen - len(actstr))
 
             elif parse_starts_block(actstr, "^(\d+)", False, True):
                 actstr, output = parse_extract_field(
@@ -504,6 +517,7 @@ class ovsactions(nla):
                     False,
                     0,
                 )
+                parencount += 1
                 self["attrs"].append(["OVS_ACTION_ATTR_RECIRC", recircid])
                 parsed = True
 
@@ -516,12 +530,22 @@ class ovsactions(nla):
 
             for flat_act in parse_flat_map:
                 if parse_starts_block(actstr, flat_act[0], False):
-                    actstr += len(flat_act[0])
+                    actstr = actstr[len(flat_act[0]):]
                     self["attrs"].append([flat_act[1]])
                     actstr = actstr[strspn(actstr, ", ") :]
                     parsed = True
 
-            if parse_starts_block(actstr, "ct(", False):
+            if parse_starts_block(actstr, "clone(", False):
+                parencount += 1
+                subacts = ovsactions()
+                actstr = actstr[len("clone("):]
+                parsedLen = subacts.parse(actstr)
+                lst = []
+                self["attrs"].append(("OVS_ACTION_ATTR_CLONE", subacts))
+                actstr = actstr[parsedLen:]
+                parsed = True
+            elif parse_starts_block(actstr, "ct(", False):
+                parencount += 1
                 actstr = actstr[len("ct(") :]
                 ctact = ovsactions.ctact()
 
@@ -553,6 +577,7 @@ class ovsactions(nla):
                         natact = ovsactions.ctact.natattr()
 
                         if actstr.startswith("("):
+                            parencount += 1
                             t = None
                             actstr = actstr[1:]
                             if actstr.startswith("src"):
@@ -607,15 +632,29 @@ class ovsactions(nla):
                                     actstr = actstr[strspn(actstr, ", ") :]
 
                         ctact["attrs"].append(["OVS_CT_ATTR_NAT", natact])
-                        actstr = actstr[strspn(actstr, ",) ") :]
+                        actstr = actstr[strspn(actstr, ", ") :]
 
                 self["attrs"].append(["OVS_ACTION_ATTR_CT", ctact])
                 parsed = True
 
-            actstr = actstr[strspn(actstr, "), ") :]
+            actstr = actstr[strspn(actstr, ", ") :]
+            while parencount > 0:
+                parencount -= 1
+                actstr = actstr[strspn(actstr, " "):]
+                if len(actstr) and actstr[0] != ")":
+                    raise ValueError("Action str: '%s' unbalanced" % actstr)
+                actstr = actstr[1:]
+
+            if len(actstr) and actstr[0] == ")":
+                return (totallen - len(actstr))
+
+            actstr = actstr[strspn(actstr, ", ") :]
+
             if not parsed:
                 raise ValueError("Action str: '%s' not supported" % actstr)
 
+        return (totallen - len(actstr))
+
 
 class ovskey(nla):
     nla_flags = NLA_F_NESTED
@@ -2111,6 +2150,8 @@ def main(argv):
     ovsflow = OvsFlow()
     ndb = NDB()
 
+    sys.setrecursionlimit(100000)
+
     if hasattr(args, "showdp"):
         found = False
         for iface in ndb.interfaces:
-- 
2.41.0


