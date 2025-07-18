Return-Path: <netdev+bounces-208257-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C21B8B0ABAF
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:37:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 146591C826EB
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:37:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C04321FF4E;
	Fri, 18 Jul 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="bZBPbfpo"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B56621FF51
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874584; cv=none; b=EEdMAqi9keFO8gvt/MpAYlRgFrVErauOJc+Mym0bXxu0NPr5Wh9hoOVfNlphnaxYFofGCu3ApIG8KOS/AMmuMItFmWBYrzB2WncubNJ4DC7wq5COmFgbwgNs+PJ6+BYs0Co24QEte17HFoTZjhowMlF/qGtnf/zSWHUmL2FUHP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874584; c=relaxed/simple;
	bh=2c57EOYfS2UIVk+6Jsr4cWd/Kudc0Na1qOu8DYtXkpI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KbBZ0TmtF0bR2ckSWhS/riQzh9pqk+PFRW/wBbhYCG3dm07L2F35RQap/2wfXkZGyxf1xeb+ovDgCwzFtDpWER2TD5nfZ7xOig0YLRG+xblwq5y5OSowLB1V7QkRKxCIXO0LChmP3Y36vSyGySvBb6CAjgr8HAqXdNMluIR+VM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=bZBPbfpo; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IIG449028253;
	Fri, 18 Jul 2025 21:36:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=x+VFZIqXfDsNnzHwu
	S/Nq5Fiw7JS+FguXjuFTTomhyE=; b=bZBPbfpot4HStZFY0ZVbkQyHNllikVeVA
	aUgHsAuXJNDWh1u3M1uxWct1GasNlMo/iTfwlT/JsCmwYNGJ82A/hfBbBvSQc3gn
	edkojPyG7y5IH7Ulak5oHb+cqUPzVYKs9G9Rm8HiOlp2zhu+IpkCFnRGFz5vb/lu
	Ke+QBzQFX8dr5GdwJgaPV+ACz7r73wXpVjiHGSfzX7csIl+z4hs/YAXQ7Wqh+Igy
	08yZboRNslq6boNOYpY+0hpkTc6JJfza/mj3nmoO3CUmXbmIbqhJa8cr1gBBbDtE
	JbJYrvBHXEvHxWwZmkl7EbHIOCpPK/kDUQ0VSIzjPsunj2rsU244w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47yud50udn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:36:16 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56ILaF0b014485;
	Fri, 18 Jul 2025 21:36:15 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47yud50udk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:36:15 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56ILMPtN032147;
	Fri, 18 Jul 2025 21:36:15 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21ukc54-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:36:14 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILaCPX17695418
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:36:13 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BE27B58056;
	Fri, 18 Jul 2025 21:36:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8A94558052;
	Fri, 18 Jul 2025 21:36:12 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:36:12 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v3 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Fri, 18 Jul 2025 14:34:54 -0700
Message-ID: <20250718213606.1970470-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250718213606.1970470-1-wilder@us.ibm.com>
References: <20250718213606.1970470-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfX55UINf3Os4Ct lMuZX2L2anEcHpixbJiKztWtOVVQwgdghM5FWhTOpYunzWyzPx1rkD7z2q3Q6S5iblG+f/MMZwb Mj7oSQVxpvs5MHD/QwMmYWF9A6fGUmdtOPl8MRo2wXil0NdKEiiv6GoXMuaIb4opeoCSNCSTsYL
 wIlzUYTtrXk5dgz1rO4ZIrmqMeYcajqdF4idKzpK3Zm+kby4BiEIznHcq74kyP72QhfE7m7KBal aP4ZFN/MQDJIlgIMHLGdQu5rPgmWUdsJc5j+tHoSDPwuEYZr9tosM77l2D/zFt7McQxyJIpTqxd TEHtfHzTq+3TkGysFKNtj4ZeV7G/PwJvpPNAJctUPjf55ZAyHP75SgW7N8RvMdgSR2hj5RDXwOQ
 IOuAzr5Up6cE7x1Bc5AUYlk6GuK2k2N/nTJKR65WWR0GsBtQJAtl/YJljzH1x2szaYF2OS74
X-Authority-Analysis: v=2.4 cv=dIqmmPZb c=1 sm=1 tr=0 ts=687abe50 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=tutZqjyPK2kbOQtnScoA:9
X-Proofpoint-GUID: SgxBhxpXwBCBWHpk8n6wNt6a4IJIvX7m
X-Proofpoint-ORIG-GUID: v0m6SRXuDqkyUcLKO_6NH9TYyseeginF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1031 phishscore=0
 suspectscore=0 impostorscore=0 priorityscore=1501 adultscore=0
 mlxlogscore=892 mlxscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180173

This change extends the "arp_ip_target" parameter format to allow for
a list of vlan tags to be included for each arp target.

The new format for arp_ip_target is:
arp_ip_target=ipv4-address[vlan-tag\...],...

Examples:
arp_ip_target=10.0.0.1[10]
arp_ip_target=10.0.0.1[100/200]

The inclusion of the list of vlan tags is optional. The new logic
preserves both forward and backward compatibility with the kernel
and iproute2 versions. Comparability is also persevered for:
ip -d link list.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 ip/iplink_bond.c | 127 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 11 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 62dd907c..e0f3d445 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -173,6 +173,53 @@ static void explain(void)
 	print_explain(stderr);
 }
 
+#define BOND_VLAN_PROTO_NONE htons(0xffff)
+#define BOND_MAX_VLAN_TAGS 5
+
+struct bond_vlan_tag {
+	__be16	vlan_proto;
+	__be16	vlan_id;
+};
+
+static struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level, int *size)
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
+		    tags[level].vlan_id > 4094)
+			return NULL;
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
@@ -239,12 +286,29 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
 				NEXT_ARG();
 				char *targets = strdupa(*argv);
 				char *target = strtok(targets, ",");
-				int i;
+				struct bond_vlan_tag *tags;
+				int size, i;
 
 				for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
-					__u32 addr = get_addr32(target);
+					struct Data {
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
 
-					addattr32(n, 1024, i, addr);
 					target = strtok(NULL, ",");
 				}
 				addattr_nest_end(n, nest);
@@ -498,21 +562,62 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 
 	if (tb[IFLA_BOND_ARP_IP_TARGET]) {
 		struct rtattr *iptb[BOND_MAX_ARP_TARGETS + 1];
+		SPRINT_BUF(pbuf);
+		int i;
 
 		parse_rtattr_nested(iptb, BOND_MAX_ARP_TARGETS,
 				    tb[IFLA_BOND_ARP_IP_TARGET]);
 
 		if (iptb[0]) {
 			open_json_array(PRINT_JSON, "arp_ip_target");
-			print_string(PRINT_FP, NULL, "arp_ip_target ", NULL);
+			print_color_string(PRINT_FP, COLOR_INET, NULL,
+					   "arp_ip_target ", NULL);
 		}
 
-		for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-			if (iptb[i])
-				print_string(PRINT_ANY,
-					     NULL,
-					     "%s",
-					     rt_addr_n2a_rta(AF_INET, iptb[i]));
+		for (i = 0; i < BOND_MAX_ARP_TARGETS && iptb[i]; i++) {
+			struct Data {
+				__u32 addr;
+				struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+			} data;
+			int size = sizeof(pbuf);
+			int num, level;
+
+			if (RTA_PAYLOAD(iptb[i]) < sizeof(data.addr) ||
+			    RTA_PAYLOAD(iptb[i]) > sizeof(data)) {
+				fprintf(stderr, "Internal Error: Bad payload for arp_ip_target.\n");
+				exit(1);
+			}
+			memcpy(&data, RTA_DATA(iptb[i]), RTA_PAYLOAD(iptb[i]));
+
+			num = snprintf(&pbuf[0], size, "%s",
+				       rt_addr_n2a(AF_INET, sizeof(data.addr), &data.addr));
+
+			if (RTA_PAYLOAD(iptb[i]) > sizeof(data.addr)) {
+				num = num + snprintf(&pbuf[num], size - num, "[");
+
+				for (level = 0;
+				     data.vlans[level].vlan_proto != BOND_VLAN_PROTO_NONE;
+				     level++) {
+
+					if (level > BOND_MAX_VLAN_TAGS) {
+						fprintf(stderr,
+							"Internal Error: too many vlan tags.\n");
+						exit(1);
+					}
+
+					if (level != 0)
+						num = num + snprintf(&pbuf[num], size - num, "/");
+
+					num = num + snprintf(&pbuf[num], size - num,
+							     "%u", data.vlans[level].vlan_id);
+				}
+
+				num = num - snprintf(&pbuf[num], size - num, "]");
+
+			}
+
+			print_color_string(PRINT_ANY, COLOR_INET, NULL, "%s", pbuf);
+
 			if (!is_json_context()
 			    && i < BOND_MAX_ARP_TARGETS-1
 			    && iptb[i+1])
@@ -520,7 +625,7 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 		}
 
 		if (iptb[0]) {
-			print_string(PRINT_FP, NULL, " ", NULL);
+			print_color_string(PRINT_FP, COLOR_INET, NULL, " ", NULL);
 			close_json_array(PRINT_JSON, NULL);
 		}
 	}
-- 
2.43.5


