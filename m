Return-Path: <netdev+bounces-231841-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B6062BFDDB2
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:30:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 0D4993570DC
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:30:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FD6434D901;
	Wed, 22 Oct 2025 18:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MQiBlAyk"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52C0E348451
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:29:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157777; cv=none; b=PpwwJZ0t5MHuEufIZK11TqdPQminVCIUsVKx02ZPck8vMyndJ8JCqn6ezDIsWmHjHKGKZxMYb52efv+y2AZEk4ouWN+Q5ZDCXwGZc3Yy9gLQ16jHnq5OLYGBG3cE1/0lc+IvxMqdyu3MYGcnduAXJ/gqzvT4F1LOw1WGtv89Jho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157777; c=relaxed/simple;
	bh=scvJrHAsNeYI70O2oiBuz5DBSl3BBH3zIYvHO6/lLU4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LRrpG7i16AAoiCwkPQcK6fLBupmAJhrRY0K8UDPQ8C2rOLkREQP0hbdwsPrMcPna+zHIk0r3kZPxT/EPUg7jzcck4Lfc7GGkiFtR62f2gdAmS2GQQdLgF3By8ZGPKZaWTmX3ABN9rKE/CkHlRHyZv6Nd6UJmO8n6GCpjcG7XnUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MQiBlAyk; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MCwmgP000967;
	Wed, 22 Oct 2025 18:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=WuWo9nv2gnqc3IkdT
	hukkb1iyWldDfiTC6hhScxmd0I=; b=MQiBlAykHOMVEk8Hz5mo5qNT0f2G7KGmh
	iOU02XbYKh3Lb/+4Fh3fMiJA6pFNaF2X0PFVa3yd3rLNiRtf+Aq+L6K/tGRkgMi5
	BZwAAx3UwYL8zdGfXDUy6nTciItWIRtgthJ/A7qBuE3eIHYH7nwYhnrUZwyDpToZ
	Kmin29XCZIL1vjMfXitooDO2t/pkB/LIXsYIXzd8x0N6Xo8MQuduozUdd4etaqd6
	Cd3ebF8PYaaaDimrIGyaBKExsZHAPYSBdoCoqW7h1v4I46xH5E9y2xXMDFh/xXsE
	ENcUu2p54BoTu1GTbkbiJ1FTHxINHZw79q+JgRPFAOX4KuDjA5A6g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1t8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:29:29 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIPFpl018953;
	Wed, 22 Oct 2025 18:29:29 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v31cd1t4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:29:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHgt3q024687;
	Wed, 22 Oct 2025 18:29:28 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vpqk1u57-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:29:28 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MITQ1k26215002
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:29:26 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0EBB558062;
	Wed, 22 Oct 2025 18:29:26 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B12F35805E;
	Wed, 22 Oct 2025 18:29:25 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:29:25 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v8 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Wed, 22 Oct 2025 11:28:45 -0700
Message-ID: <20251022182915.2568814-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251022182915.2568814-1-wilder@us.ibm.com>
References: <20251022182915.2568814-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: FlcnjHqbceqXNZibBFpds5NB30f0w2Rw
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4YXXqpVW+Eh4
 BqrVN9O6iAR/EwX7anvq/ht7hseLFZvEILVm05fNqbf7gMIHrCkUp/S/g4BL2rdoIiN2RMMHPmG
 3+0lNy1e6yym1r+8rTVO9APMioDbT7TI06O0YMVAxUWX2feyXyo1QgxnB4pxEYNzXq7UlCVv2MY
 DSDgyq7DpF7QbnZ9oS7osh2OqWLIcHLL5t4VQ6zYTfirTs6yjjl+Yvgaixtij/xXfJK1Z6wOuAn
 9EcBClQS3iWviCt0dS+mQIt4VgU0U/MlZKcZnoEt9G9Zre/8EPJ6St80KlUQao3W3Lac1aaEe1r
 4fFmCz1tG9RhMM0GeoyeB0t8A7hKe7NnXIhaY80Z4IYq4EFtrYkESWokdkWv8mprEJlQSshINbJ
 n5KSdmSWkCrJmdJb4LMtC9798lkeYw==
X-Proofpoint-GUID: hTfzhnEMsUGHSUD4ON7WTznacAxMloYp
X-Authority-Analysis: v=2.4 cv=SKNPlevH c=1 sm=1 tr=0 ts=68f92289 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ih_k2vk3dtMi9XJ1s-oA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 suspectscore=0 clxscore=1031 priorityscore=1501
 spamscore=0 impostorscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

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
 ip/iplink_bond.c | 152 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 126 insertions(+), 26 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 714fe7bd..a2a7b1b1 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -176,6 +176,58 @@ static void explain(void)
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
+static struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level,
+						  int *size)
+{
+	struct bond_vlan_tag *tags = NULL;
+	char *vlan;
+	int n;
+
+	if (level > BOND_MAX_VLAN_TAGS) {
+		fprintf(stderr,
+			"Error: Too many vlan tags specified, maximum is %d.\n",
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
+		if (n != 1 || tags[level].vlan_id < 1 ||
+		    tags[level].vlan_id >= VLAN_VID_MASK) {
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
@@ -243,12 +295,28 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
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
@@ -439,6 +507,22 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
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
@@ -509,24 +593,44 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
+			open_json_object(NULL);
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
+
+			close_json_object();
 		}
 
 		if (iptb[0]) {
@@ -538,8 +642,7 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BOND_NS_IP6_TARGET]) {
 		struct rtattr *ip6tb[BOND_MAX_NS_TARGETS + 1];
 
-		parse_rtattr_nested(ip6tb, BOND_MAX_NS_TARGETS,
-				    tb[IFLA_BOND_NS_IP6_TARGET]);
+		parse_rtattr_nested(ip6tb, BOND_MAX_NS_TARGETS, tb[IFLA_BOND_NS_IP6_TARGET]);
 
 		if (ip6tb[0]) {
 			open_json_array(PRINT_JSON, "ns_ip6_target");
@@ -548,14 +651,11 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 
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


