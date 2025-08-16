Return-Path: <netdev+bounces-214258-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E9F36B28A8F
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 06:41:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 462671B68916
	for <lists+netdev@lfdr.de>; Sat, 16 Aug 2025 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDAD41C8626;
	Sat, 16 Aug 2025 04:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b="jnGuCZvU"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-2.cisco.com (alln-iport-2.cisco.com [173.37.142.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EFAF1C7015
	for <netdev@vger.kernel.org>; Sat, 16 Aug 2025 04:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755319302; cv=none; b=kWriAs3Hfc1bplvBq9oCyCzgpqRdoBi+10VCytdC1aq6HdvkedSK3jyTE1JFLTqQnIZFeoKyEr1leq5eT7GM+lfUQOyMpy0Wm4sple5Ehqfu0Q5+2wYh8CnYXjsvZzsuH/sXYYRQ2vdQXLZUT6X9Tlvqcutdk4zoat1lFbJkOCQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755319302; c=relaxed/simple;
	bh=nak1WHXiv2dKHTKcqggVW6w5Guq4Ovxh/4C3oHCqbyM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=l5TZoIGAaF2KU2f9vxfBZVqgR+3wHtX9RPjYfUeCDMCdHd1+CiVYlMaFmzJo1PbTPbKAddyvGs9ao3lVAPcec9ZdVZJ9u8L8gbPF+eWtv9ahvPZXR85KWMhgWL9GgDxVn2QytZrir2v1tc/V0nz3y/MoMBBtef4rFS1/Ax+pNtw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (2048-bit key) header.d=cisco.com header.i=@cisco.com header.b=jnGuCZvU; arc=none smtp.client-ip=173.37.142.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=5358; q=dns/txt;
  s=iport01; t=1755319300; x=1756528900;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=rZ45E8uRt6lN/hvDsnSCm2r8Z/0epp+vTKFKDlCTErA=;
  b=jnGuCZvU2W/rDetSOpqt0AQ250b2iJVxd97rEuNA1JxSvLGvUjjDDoDl
   rJqVdnD4QFHvTkepsgub3IXCOleTkqWA2Xe601fPC9yn7uGN4TQ3JjfIJ
   hbSRQTGmuRN6tR62Yrfp7oi9rUE9ktMrMoHeke1KF2wvaGPdLBet2L48b
   y846bfQoATdAQzEQzmaqO+x75IEcE440WrYwr8hmFM51yrhySrmu+r/W1
   +2qKMudbqcrDZtTmyIaPexFL+5EY6YK9u7VpIpXpMrJjmK5Ydx8gIjuUq
   3l6YL5/YCv0DiTBT8o1BLvRmUhE+ZtBLak406HkOvl3bvp17ZXeOURVBl
   w==;
X-CSE-ConnectionGUID: A9EckXdmTJWW5lD2X+6vTg==
X-CSE-MsgGUID: mOrbGNqcTK6ukx8BYXglHg==
X-IronPort-AV: E=Sophos;i="6.17,293,1747699200"; 
   d="scan'208";a="530114137"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-2.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 16 Aug 2025 03:11:53 +0000
Received: from mrghosh-ub.cisco.com (unknown [10.160.1.156])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: mrghosh@cisco.com)
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTPSA id C806C18000237;
	Sat, 16 Aug 2025 03:11:52 +0000 (GMT)
From: Mrinmoy Ghosh <mrghosh@cisco.com>
To: netdev@vger.kernel.org
Cc: bridge@lists.linux-foundation.org,
	mrghosh@cisco.com,
	mrinmoy_g@hotmail.com,
	Mike Mallin <mmallin@cisco.com>,
	Patrice Brissette <pbrisset@cisco.com>
Subject: [PATCH iproute2] bridge:fdb: Protocol field in bridge fdb
Date: Sat, 16 Aug 2025 03:11:45 +0000
Message-ID: <20250816031145.1153429-1-mrghosh@cisco.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authenticated-User: mrghosh@cisco.com
X-Outbound-SMTP-Client: 10.160.1.156, [10.160.1.156]
X-Outbound-Node: rcdn-l-core-02.cisco.com

From: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>

This is to add optional "protocol" field for bridge fdb entries.
The introduction of the 'protocol' field in the bridge FDB for EVPN Multihome, addresses the need to distinguish between MAC addresses learned via the control plane and those learned via the data plane with data plane aging. Specifically:
* A MAC address in an EVPN Multihome environment can be learned either through the control plane (static MAC) or the data plane (dynamic MAC with aging).
* The 'protocol' field uses values such as 'HW' for data plane dynamic MACs and 'ZEBRA' for control plane static MACs.
* This distinction allows the application to manage the MAC address state machine effectively during transitions, which can occur due to traffic hashing between EVPN Multihome peers or mobility of MAC addresses across EVPN peers.
* By identifying the source of the MAC learning (control plane vs. data plane), the system can handle MAC aging and mobility more accurately, ensuring synchronization between control and data planes and improving stability and reliability in MAC route handling.

This mechanism supports the complex state transitions and synchronization required in EVPN Multihome scenarios, where MAC addresses may move or be learned differently depending on network events and traffic patterns.

This change:
fdb.c: Allows 'bridge fdb [add | replace]' with optional protocol field.

e.g:

$ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto hw

$ bridge -d -j -p fdb show dev hostbond2

...

[ {
        "mac": "00:00:00:00:00:88",
        "vlan": 1000,
        "flags": [ "extern_learn" ],
        "master": "br1000",
        "flags_ext": [ ],
        "protocol": "hw",
        "state": ""
    },{
...

Transition to Zebra:

$ bridge -d fdb show dev hostbond2 | grep 00:00:00:00:00:88
00:00:00:00:00:88 vlan 1000 extern_learn master br1000 proto zebra

$ bridge -d -j -p fdb show dev hostbond2
...
[ {
        "mac": "00:00:00:00:00:88",
        "vlan": 1000,
        "flags": [ "extern_learn" ],
        "master": "br1000",
        "flags_ext": [ ],
        "protocol": "zebra",
        "state": ""
    },
...

Signed-off-by: Mrinmoy Ghosh <mrghosh@cisco.com>
Co-authored-by: Mrinmoy Ghosh <mrinmoy_g@hotmail.com>
Co-authored-by: Mike Mallin <mmallin@cisco.com>
Co-authored-by: Patrice Brissette <pbrisset@cisco.com>
---
 bridge/fdb.c                   | 20 +++++++++++++++++++-
 include/uapi/linux/rtnetlink.h |  1 +
 lib/rt_names.c                 |  1 +
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/bridge/fdb.c b/bridge/fdb.c
index d57b5750..9c5dd763 100644
--- a/bridge/fdb.c
+++ b/bridge/fdb.c
@@ -41,7 +41,7 @@ static void usage(void)
 		"              [ sticky ] [ local | static | dynamic ] [ vlan VID ]\n"
 		"              { [ dst IPADDR ] [ port PORT] [ vni VNI ] | [ nhid NHID ] }\n"
 		"	       [ via DEV ] [ src_vni VNI ] [ activity_notify ]\n"
-		"	       [ inactive ] [ norefresh ]\n"
+		"	       [ inactive ] [ norefresh ] [ protocol PROTO ]\n"
 		"       bridge fdb [ show [ br BRDEV ] [ brport DEV ] [ vlan VID ]\n"
 		"              [ state STATE ] [ dynamic ] ]\n"
 		"       bridge fdb get [ to ] LLADDR [ br BRDEV ] { brport | dev } DEV\n"
@@ -306,8 +306,18 @@ int print_fdb(struct nlmsghdr *n, void *arg)
 		print_string(PRINT_ANY, "master", "master %s ",
 			     ll_index_to_name(rta_getattr_u32(tb[NDA_MASTER])));
 
+	if (tb[NDA_PROTOCOL]) {
+		__u8 proto = rta_getattr_u8(tb[NDA_PROTOCOL]);
+		if (proto != RTPROT_UNSPEC) {
+			SPRINT_BUF(b1);
+			print_string(PRINT_ANY, "protocol", "proto %s ",
+					 rtnl_rtprot_n2a(proto, b1, sizeof(b1)));
+		}
+	}
 	print_string(PRINT_ANY, "state", "%s\n",
 			   state_n2a(r->ndm_state));
+
+
 	close_json_object();
 	fflush(fp);
 	return 0;
@@ -478,6 +488,7 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	char *endptr;
 	short vid = -1;
 	__u32 nhid = 0;
+	__u32 proto = RTPROT_UNSPEC;
 
 	while (argc > 0) {
 		if (strcmp(*argv, "dev") == 0) {
@@ -555,6 +566,10 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 			inactive = true;
 		} else if (strcmp(*argv, "norefresh") == 0) {
 			norefresh = true;
+		} else if (matches(*argv, "protocol") == 0) {
+			NEXT_ARG();
+			if (rtnl_rtprot_a2n(&proto, *argv))
+				invarg("\"protocol\" value is invalid\n", *argv);
 		} else {
 			if (strcmp(*argv, "to") == 0)
 				NEXT_ARG();
@@ -615,6 +630,9 @@ static int fdb_modify(int cmd, int flags, int argc, char **argv)
 	if (via)
 		addattr32(&req.n, sizeof(req), NDA_IFINDEX, via);
 
+	if (proto != RTPROT_UNSPEC)
+		addattr8(&req.n, sizeof(req), NDA_PROTOCOL, proto);
+
 	req.ndm.ndm_ifindex = ll_name_to_index(d);
 	if (!req.ndm.ndm_ifindex)
 		return nodev(d);
diff --git a/include/uapi/linux/rtnetlink.h b/include/uapi/linux/rtnetlink.h
index 085bb139..1ff9dbee 100644
--- a/include/uapi/linux/rtnetlink.h
+++ b/include/uapi/linux/rtnetlink.h
@@ -314,6 +314,7 @@ enum {
 #define RTPROT_OSPF		188	/* OSPF Routes */
 #define RTPROT_RIP		189	/* RIP Routes */
 #define RTPROT_EIGRP		192	/* EIGRP Routes */
+#define RTPROT_HW		193	/* HW Generated Routes */
 
 /* rtm_scope
 
diff --git a/lib/rt_names.c b/lib/rt_names.c
index 7dc194b1..b9bc1b50 100644
--- a/lib/rt_names.c
+++ b/lib/rt_names.c
@@ -148,6 +148,7 @@ static char *rtnl_rtprot_tab[256] = {
 	[RTPROT_OSPF]	    = "ospf",
 	[RTPROT_RIP]	    = "rip",
 	[RTPROT_EIGRP]	    = "eigrp",
+	[RTPROT_HW]	    = "hw",
 };
 
 struct tabhash {
-- 
2.43.0


