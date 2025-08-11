Return-Path: <netdev+bounces-212655-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7301B2196E
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:33:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 77447624D4D
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:32:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B376279DD8;
	Mon, 11 Aug 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GygNh+ME"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A4B20E314
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954969; cv=none; b=uK87JLmpvWlP8WxpATnQJE2SlvUIInPeVASF3SeuDoPABDIW+zV5abUf+gMGbUW5olFrVTzWZds9PREaziTSe5DFIpgrDRVB4dqRhRiIXrLbJ1Lec76G/LJstzcuYnbcdBwVz2y6mNlgYebwNn/M6CxMrEfKyfEFnhJwMj2a130=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954969; c=relaxed/simple;
	bh=X32JlWuf4W2i8CrGozhM/P++BigahpClHV8MZFk0tu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J70yc47F9JeB8JbMShEgPXpwAjNQOoVtsMDIbkb7a27jzdEFhz94uaFwbrQ0jD6PdEodXItzR4IDyIHWv7KQl99AhQbn1zQSeKQ0gn7JtGW6gDrLYf5qCXd9/NuzHv4sDnK6DsDleaFh2CpZ4zt6ydUu3Azi8WkepZ5YfZzUTKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GygNh+ME; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BN0PFt002652;
	Mon, 11 Aug 2025 23:29:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=HiE0rT4dMPzhrlOk7
	8M/x1kTQe2BdvLbrHKF/rAZ2ZQ=; b=GygNh+MEA6QRZrpmU/IfvLNJkNmOME9ux
	Mh1jV43elYhh4zxjJIXowIjSQ3toRVFFF5s4m5ue+NCjbrNiA0azBwCLarnbaVZb
	ht9zViGgagOW0Kx+hMfEn3D5q4MC0oXfq55aotQHTjI5RnEc9V2/Bg1Vq9a1ecbq
	zDtpsllBGB8Om0lIfrIJguuaUUZteDRiF0QMae+vXbT5e89Bdq+k2VK6vjEnLeu4
	lx/T5cNXiXfMHIx+JgKO5JZl/gEYQSgFU5vbxHUUeSZbmIRNM90dKH2HNeBKwli4
	vMWw168EYK7DMkun9UGFVLpA6BpDcTVFytYSJGvNJ84s7YG7biyOQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9yy0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:29:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BNTLVj010029;
	Mon, 11 Aug 2025 23:29:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9yy0s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:29:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BN0I6N010832;
	Mon, 11 Aug 2025 23:29:20 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48egnug55y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:29:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNTAXE17367710
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:29:10 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 264ED58056;
	Mon, 11 Aug 2025 23:29:18 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E238D58052;
	Mon, 11 Aug 2025 23:29:17 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:29:17 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v4 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Mon, 11 Aug 2025 16:28:18 -0700
Message-ID: <20250811232857.1831486-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250811232857.1831486-1-wilder@us.ibm.com>
References: <20250811232857.1831486-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689a7cd1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8 a=tutZqjyPK2kbOQtnScoA:9
X-Proofpoint-ORIG-GUID: bSEuT-cSBBuYLdtNwI5WRZ2gHKEyaLjY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE3MCBTYWx0ZWRfXwgDijY6VE1Mq
 VUY8yhrydwj1pehqLAREz38ZpyT8As08pQyrMxo1pH9JtIjFoJJ+bWtmjUjYc2J8TbEXfyhYhpv
 9JRhOWCorAEffddUDcvqA5XnLrn/rjWnCDJk1QLo9efhD/xu6nlf4iYXCPKQnsmWzxOTOcooc0u
 +PDjvlaBjx36UNj6si+B7LaNUmW0o9r6mtGkzu7QVt6vayjCHkTO/ycB5tEv2DvLrSR0Nls7hX+
 R0TYPW9CS7kvzX/4yVBa/iVHo+3xaoQLcFhkxrVHddZtl1yvBHEE2vlPxOeC9sNJ7S4IaUsnpqz
 aZHZHVMrwRgw1mM5zsWUu8J3GtMJW2Sj1YEGdTAnPmzmZUvmQ8p02DqcMEpIw3OxTeE2Yn61OWT
 2+lFWX9LOBlBjh3D29aPxw6dSftcx585zaMigqywsP2oTrDx0nrr/wCUoA5CFpvJNh5Rrgh3
X-Proofpoint-GUID: 1IzJ3G99R4eDzCKid1991bRdm8eFUx0A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1031 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110170

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
index 62dd907c..441064e2 100644
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
+					struct __attribute__((packed)) Data {
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
+			struct __attribute__((packed)) Data {
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
2.50.1


