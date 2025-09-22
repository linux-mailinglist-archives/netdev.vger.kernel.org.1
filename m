Return-Path: <netdev+bounces-225410-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 81A73B937DC
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:37:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 322062E1277
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:37:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF493279334;
	Mon, 22 Sep 2025 22:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ckKJSAJJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 049C119A288
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580631; cv=none; b=mZ6rjOCePEqyAiE2GPxRciYaZeN/WbvIT2fXYMiVjtQgnxaBO827roJnTyBbfEmkbIahGVobi09RXkx4h/Tb5o7mMza4Vb33zNjpf39UXEzXY7J34seau51CXaPf02vv8vUhN/THDY032m9vNxMW+GSAmkv/S506s9/bjcWI4H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580631; c=relaxed/simple;
	bh=wi10xT+hFJjbtKNY3+jUTG1o0wa+m599w/36l2Z0j6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tSsG3a8zNHCDIEdMC6q20RPzFESr0z0iBsaXfJtK6bAm6uqTwkRWzNU9pR3djczZ9OC9BUVbyvXMUAYVkUOakLkTdTbohPZ75dTTUaZQpKSZS7b2VbdIcLT8DgO5xzicK/OT1ahbb8MaZ5/7h4yOyGnGrHaU71HRoOA4QqPGbt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ckKJSAJJ; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MIPb9g005818;
	Mon, 22 Sep 2025 22:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bvJRZkED0BvU4Xaxn
	hXh4BaumdbMGbjRg+xOwobAcu8=; b=ckKJSAJJkU6pkz4Zm2KChen3y8HryXWdg
	rVZ9TmJajBmaPGf8CcNhgNUiwd9P7MiYjGOfYKyQUErcO9Eqj+PLO8dVj2/T631X
	DIcm27lhrcBGzec1gz8WhvluZT+6Y9sOqJZ2OPHAITm063q7QCHD+4av/JKPgDl+
	KrfTlqqBitX1gBsvT7QkrcBVdDLKbf01ZxzAN/HsovOAOyM6bjsdCY+PU9m3aHVb
	RofCIZ7BXRqtBiVqpigv19xj/QPQ5gqYPlYxCtVPvbZNmCrfYpqByTu6PuERoBHI
	YYz3xmPonMKRbsd+GaUsCenpwH8JRz9Tj4PUkZq8uNNWElcrOz8Ig==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jdfmt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 22:37:01 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58MMb12S007430;
	Mon, 22 Sep 2025 22:37:01 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499n0jdfmr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 22:37:01 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58MLcx4D030356;
	Mon, 22 Sep 2025 22:37:00 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49a9a102db-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 22:37:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MMaxBa9372188
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 22:36:59 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F3EF258064;
	Mon, 22 Sep 2025 22:36:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B431B58056;
	Mon, 22 Sep 2025 22:36:58 +0000 (GMT)
Received: from localhost (unknown [9.61.77.150])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 22:36:58 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v6 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Mon, 22 Sep 2025 15:35:11 -0700
Message-ID: <20250922223640.2170084-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250922223640.2170084-1-wilder@us.ibm.com>
References: <20250922223640.2170084-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAzMyBTYWx0ZWRfX3VZ1dYcHsgSb
 LxWTNg061ZOncBYaZxa+4laA2MYNdveZeTIcyyzQSS6LiUjmKQoZV/fYwwmPF9bSxu8u8HorOV4
 i/WD7C/tfib24SakfzqGMaamXQBRugMFBsyGX800W8IbBncpIbhO06EliB2aXgF9q4Pmb+Oxvgh
 WaKcyeljLAhrWUlqPO+Fxe/SVn5SfZBhnnxIOMfN/AhycPkX26cn9+m0rnkCEGhAnXBQoB1ogfT
 3e5riaVKhh+a2IiCqnAcpRTPVF5L5Xo9Q4AfDvH/Ith8IMJpOZvO42YhHn+hf0SCxNpwNClhNRL
 mQKbu7GuJ3YnrJFt/M313+aLAi9jcy1SpYIz9nv51eOyEe8Kj8MXzsGOblZAL5ScVpWMUM2QW6Y
 wa09MHQk
X-Authority-Analysis: v=2.4 cv=TOlFS0la c=1 sm=1 tr=0 ts=68d1cf8e cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=ih_k2vk3dtMi9XJ1s-oA:9
X-Proofpoint-ORIG-GUID: vV5dCa_KuN0roLIodaveNElqsakh8On3
X-Proofpoint-GUID: hcDkeKybKPaGkOHHcSzNqzxrJ3-Jl-zp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0
 suspectscore=0 spamscore=0 bulkscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200033

This change extends the "arp_ip_target" parameter format to allow for
a list of vlan tags to be included for each arp target.

The new format for arp_ip_target is:
arp_ip_target=ipv4-address[vlan-tag\...],...

Examples:
arp_ip_target=10.0.0.1[10]
arp_ip_target=10.0.0.1[100/200]

The inclusion of the list of vlan tags is optional. The new logic
preserves both forward and backward compatibility with the kernel
and iproute2 versions.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 ip/iplink_bond.c | 146 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 120 insertions(+), 26 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index d6960f6d..6f9d70c0 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -173,6 +173,55 @@ static void explain(void)
 	print_explain(stderr);
 }
 
+#define BOND_VLAN_PROTO_NONE htons(0xffff)
+#define BOND_MAX_VLAN_TAGS 5
+#define VLAN_VID_MASK 0x0fff
+
+struct bond_vlan_tag {
+	__be16  vlan_proto;
+	__be16  vlan_id;
+};
+
+static struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level, int *size)
+{
+	struct bond_vlan_tag *tags = NULL;
+	char *vlan;
+	int n;
+
+	if (level > BOND_MAX_VLAN_TAGS) {
+		fprintf(stderr, "Error: Too many vlan tags specified, maximum is %d.\n",
+			BOND_MAX_VLAN_TAGS);
+		exit(1);
+	}
+
+	if (!vlan_list || strlen(vlan_list) == 0) {
+		tags = calloc(level + 1, sizeof(*tags));
+		*size = (level + 1) * (sizeof(*tags));
+		if (tags)
+			tags[level].vlan_proto = BOND_VLAN_PROTO_NONE;
+		return tags;
+	}
+
+	for (vlan = strsep(&vlan_list, "/"); (vlan != 0); level++) {
+		tags = bond_vlan_tags_parse(vlan_list, level + 1, size);
+		if (!tags)
+			continue;
+
+		tags[level].vlan_proto = htons(ETH_P_8021Q);
+		n = sscanf(vlan, "%hu", &(tags[level].vlan_id));
+
+		if (n != 1 || tags[level].vlan_id < 1 || tags[level].vlan_id >= VLAN_VID_MASK) {
+			fprintf(stderr, "Error: Invalid vlan_id specified: %hu\n",
+				tags[level].vlan_id);
+			exit(1);
+		}
+
+		return tags;
+	}
+
+	return NULL;
+}
+
 static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 			  struct nlmsghdr *n)
 {
@@ -239,12 +288,28 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 				NEXT_ARG();
 				char *targets = strdupa(*argv);
 				char *target = strtok(targets, ",");
-				int i;
+				struct bond_vlan_tag *tags;
+				int size, i;
 
 				for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
-					__u32 addr = get_addr32(target);
-
-					addattr32(n, 1024, i, addr);
+					struct {
+						__u32 addr;
+						struct bond_vlan_tag vlans[];
+					} data;
+					char *vlan_list, *dup;
+
+					dup = strdupa(target);
+					data.addr = get_addr32(strsep(&dup, "["));
+					vlan_list = strsep(&dup, "]");
+
+					if (vlan_list) {
+						tags = bond_vlan_tags_parse(vlan_list, 0, &size);
+						memcpy(&data.vlans, tags, size);
+						addattr_l(n, 1024, i, &data,
+							  sizeof(data.addr)+size);
+					} else {
+						addattr32(n, 1024, i, data.addr);
+					}
 					target = strtok(NULL, ",");
 				}
 				addattr_nest_end(n, nest);
@@ -429,6 +494,22 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 	return 0;
 }
 
+static void bond_vlan_tags_print(const struct bond_vlan_tag *vlan)
+{
+	for (unsigned int l = 0; l < BOND_MAX_VLAN_TAGS + 1; l++, vlan++) {
+		if (vlan->vlan_proto == BOND_VLAN_PROTO_NONE)
+			return;
+
+		if (l > 0)
+			print_string(PRINT_FP, NULL, "/", NULL);
+
+		print_uint(PRINT_ANY, NULL, "%u", vlan->vlan_id);
+	}
+
+	fprintf(stderr, "Internal Error: too many vlan tags.\n");
+	exit(1);
+}
+
 static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 {
 	int i;
@@ -499,24 +580,41 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BOND_ARP_IP_TARGET]) {
 		struct rtattr *iptb[BOND_MAX_ARP_TARGETS + 1];
 
-		parse_rtattr_nested(iptb, BOND_MAX_ARP_TARGETS,
-				    tb[IFLA_BOND_ARP_IP_TARGET]);
+		parse_rtattr_nested(iptb, BOND_MAX_ARP_TARGETS, tb[IFLA_BOND_ARP_IP_TARGET]);
 
 		if (iptb[0]) {
 			open_json_array(PRINT_JSON, "arp_ip_target");
 			print_string(PRINT_FP, NULL, "arp_ip_target ", NULL);
 		}
 
-		for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-			if (iptb[i])
-				print_string(PRINT_ANY,
-					     NULL,
-					     "%s",
-					     rt_addr_n2a_rta(AF_INET, iptb[i]));
-			if (!is_json_context()
-			    && i < BOND_MAX_ARP_TARGETS-1
-			    && iptb[i+1])
-				fprintf(f, ",");
+		for (unsigned int i = 0; i < BOND_MAX_ARP_TARGETS && iptb[i]; i++) {
+			struct {
+				__u32 addr;
+				struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+			} data;
+
+			if (RTA_PAYLOAD(iptb[i]) < sizeof(data.addr) ||
+				RTA_PAYLOAD(iptb[i]) > sizeof(data)) {
+				fprintf(stderr, "Internal Error: Bad payload for arp_ip_target.\n");
+				exit(1);
+			}
+			memcpy(&data, RTA_DATA(iptb[i]), RTA_PAYLOAD(iptb[i]));
+
+			print_color_string(PRINT_ANY, COLOR_INET, "addr", "%s",
+					   rt_addr_n2a(AF_INET, sizeof(data.addr), &data.addr));
+
+			if (RTA_PAYLOAD(iptb[i]) > sizeof(data.addr)) {
+				open_json_array(PRINT_JSON, "vlan");
+				print_string(PRINT_FP, NULL, "[", NULL);
+
+				bond_vlan_tags_print(data.vlans);
+
+				close_json_array(PRINT_JSON, NULL);
+				print_string(PRINT_FP, NULL, "]", NULL);
+			}
+
+			if (i < BOND_MAX_ARP_TARGETS - 1 && iptb[i+1])
+				print_string(PRINT_FP, NULL, ",", NULL);
 		}
 
 		if (iptb[0]) {
@@ -528,8 +626,7 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BOND_NS_IP6_TARGET]) {
 		struct rtattr *ip6tb[BOND_MAX_NS_TARGETS + 1];
 
-		parse_rtattr_nested(ip6tb, BOND_MAX_NS_TARGETS,
-				    tb[IFLA_BOND_NS_IP6_TARGET]);
+		parse_rtattr_nested(ip6tb, BOND_MAX_NS_TARGETS, tb[IFLA_BOND_NS_IP6_TARGET]);
 
 		if (ip6tb[0]) {
 			open_json_array(PRINT_JSON, "ns_ip6_target");
@@ -538,14 +635,11 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 
 		for (i = 0; i < BOND_MAX_NS_TARGETS; i++) {
 			if (ip6tb[i])
-				print_string(PRINT_ANY,
-					     NULL,
-					     "%s",
-					     rt_addr_n2a_rta(AF_INET6, ip6tb[i]));
-			if (!is_json_context()
-			    && i < BOND_MAX_NS_TARGETS-1
-			    && ip6tb[i+1])
-				fprintf(f, ",");
+				print_color_string(PRINT_ANY, COLOR_INET6, NULL, "%s",
+						   rt_addr_n2a_rta(AF_INET6, ip6tb[i]));
+
+			if (i < BOND_MAX_NS_TARGETS - 1 && ip6tb[i+1])
+				print_string(PRINT_FP, NULL, ",", NULL);
 		}
 
 		if (ip6tb[0]) {
-- 
2.50.1


