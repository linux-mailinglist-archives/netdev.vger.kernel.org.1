Return-Path: <netdev+bounces-228992-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 20D4CBD6D10
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:58:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52DF34F5C08
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:58:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27F872FE057;
	Mon, 13 Oct 2025 23:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ocKz2BhP"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6238124338F
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399924; cv=none; b=gk2R4ZnbbH8715l8u+qhfevhjUSXWPXVU/kqtaTdnukPX6A/MXgXGsBiH2Ee1MSCb361m2Z/602IFDA6c7mWeFeeBh8rLvhOwhz5fkUQM0J/01H/LMuRSD8wX+EUBS5jFa08H4e8IknuSs6Ll3QaI6gJrpTLA7QaaipSdnoFT9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399924; c=relaxed/simple;
	bh=RjVX0+fh60icQs4qAmVz5aiY4ZsI2zoYCS/N63llVfY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FlUrC9K2MMusxdcvYe5tox4Bf7vTbarR+UapraI7dn5AhcXvx2bxn4fzVepvD3D1tOchrL1EenFKTUBlvT9pEblggzFYMcXioIuoB14DMPxzxZpWOsmEpDuwTYwuxW565wbHkKgMGs2vipN307bPLkS1UVUQf3nk0blPyDVGZeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ocKz2BhP; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DMh1OT006283;
	Mon, 13 Oct 2025 23:58:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=hvYhcvH+hR8nemcby
	JPEGtNOLvvnXKTeNbzANEjooyA=; b=ocKz2BhPZyHr0q4HJyqPhb5XnLR1InApg
	fYKr0+EIGd3Ny1SYG3jvYDbep5b1frDraFWM3xfF1tCjOu56enfLyjk8GTPw0ani
	Yte+bzAj2u+vQrU2/VvM/iUfTX1JeXS9tnWIVkD5FZ2rA7QsxPA5GCIa8iwPXKJr
	ajLJ+6bUG6mumWed/EdBT2W/n/4zRWd9JEOmxssFn0MRLBcc/2IxPn5/bTfYC7P6
	GrlSz0EyAZ5SnIHPbbec7L/Nkc8SgMAHJvFHp5UuDkGKWXyongycFYvA7R1Pk9lP
	ReXzacRgqlCW1tCpA5iArmfdekcbHO/LoG/CRONmajOg6W4znCFbw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyuaaa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:58:36 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNwaeq015949;
	Mon, 13 Oct 2025 23:58:36 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qevyuaa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:58:36 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DN3792018362;
	Mon, 13 Oct 2025 23:58:35 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49s3rf1xe6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:58:35 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNwWxY27394788
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:58:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B42B958052;
	Mon, 13 Oct 2025 23:58:32 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4F6E858045;
	Mon, 13 Oct 2025 23:58:32 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:58:32 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v7 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Mon, 13 Oct 2025 16:57:40 -0700
Message-ID: <20251013235827.1291202-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251013235827.1291202-1-wilder@us.ibm.com>
References: <20251013235827.1291202-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: pCcsdxF8O_LCBgtorjrG1kSTzBLH5Jqt
X-Authority-Analysis: v=2.4 cv=eJkeTXp1 c=1 sm=1 tr=0 ts=68ed922c cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=ih_k2vk3dtMi9XJ1s-oA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAxNCBTYWx0ZWRfXxaVVF0tPi+Zv
 7KTendz4p1uCJz1cYZpRfMhtUoFiT34MutzW5IZO2mmLjUSt81tu2c1qWUOLdXRX0irBlVg5TnV
 g7BeqaEQ4Qu0Dns2yCcd9Y4lYORfyIVf7CbU9+y5zwMsDFIBmMW1vroBXUeDp1fGXoimoeO8Mjv
 a+mGA5rgR6kO+W8ZTMf4UGLjftKqckqqNz+w4dt3AVHSIJ0Dwzn0fTFzeUo+bKgo4DAh1NOYy63
 7SHhCqmtaT5zsjWEaEEsIFZfnGGYpr9mrEu0IKbK+hCxt8q3/YbrLAnX18a5hL85wI2FoprFN8s
 /vvecrgto916Zi8snloR8cuVvxpPjy6vmIamJT8srkwTQo7Y3uiTDV0h9ioswxytbosjLuT8FZj
 /RBViJcNMKQoN+gftthY16IXWXQU3A==
X-Proofpoint-GUID: UjTeQnNqKIVB7Lw8sD1ASGKnfSqv5cv2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 lowpriorityscore=0 spamscore=0 clxscore=1031 impostorscore=0
 phishscore=0 malwarescore=0 adultscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110014

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
 ip/iplink_bond.c | 149 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 123 insertions(+), 26 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index d6960f6d..0f34125d 100644
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
@@ -499,24 +580,44 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
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
@@ -528,8 +629,7 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 	if (tb[IFLA_BOND_NS_IP6_TARGET]) {
 		struct rtattr *ip6tb[BOND_MAX_NS_TARGETS + 1];
 
-		parse_rtattr_nested(ip6tb, BOND_MAX_NS_TARGETS,
-				    tb[IFLA_BOND_NS_IP6_TARGET]);
+		parse_rtattr_nested(ip6tb, BOND_MAX_NS_TARGETS, tb[IFLA_BOND_NS_IP6_TARGET]);
 
 		if (ip6tb[0]) {
 			open_json_array(PRINT_JSON, "ns_ip6_target");
@@ -538,14 +638,11 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 
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


