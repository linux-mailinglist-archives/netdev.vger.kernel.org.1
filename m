Return-Path: <netdev+bounces-219313-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBD5B40F38
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:17:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B64F7701422
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:17:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 048642E0412;
	Tue,  2 Sep 2025 21:17:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="DIozPkAj"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4266826FA70
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847851; cv=none; b=aKahjo5nl2WyiJhMFTGLl+crQkaQBsOtck0oUdhT4Gh/VKy815Vth/nRwhmOtTClvL4RbDmuqJD54/b1qGDh/z8VBMqpXz3QXygofud3su/z6VsPTdkX0ZXd6Cg3+T/9Gp69wa/MzX1iRBePgE3KvBLhIg/BJMLEeuE+FMe5mWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847851; c=relaxed/simple;
	bh=j2OqqVUaIO+qM0yNhf6NCqFoL4CSdZO+AoMa2smhugQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MEnjlKCJw74dE0m7R2xbwDdyhrYgHv8DkhmTBG3fWD0mKNRA7bWUU0FI5hkoimBy2R/hkkAvEILOADxLloMPB52l2pxHuR7zb24lG8IVk0S7bcZuZMvcgsHue0fl47d4Ua+fzlQyQxaaFhi9PFLBLyQSmEnLS8OzQhVf5Juvdd8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=DIozPkAj; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582KULBD000630;
	Tue, 2 Sep 2025 21:17:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UZKurEzmY6grSBvAx
	dTdGJxhWIXxAvCWIyfqiuPm4ps=; b=DIozPkAjs4SGf2Jvj1PoOWFP+W6T6P0JU
	K/1MGapOeAGJQsjLX42sSfNbd+1/ghoCK1luJdY64YuIs+6eB2vl2TSNr4k7qXni
	mTtQWgoI5If0mSRCoGzaGF6MLcAowq4uMqWNwb3l99E8DWRgBaj+5doYU/1qNT7s
	diDnv/bKPum7+iD4mHBwo7z6qDm0thN45N1eOLs4HN3xwKNomCJkbiEwwiMU9rgZ
	WlzRqYKUVys8G9zw9MWpE0CVX1C8+MAkw8tHEEpj/kqG3v/IwcyEwdyPIxxvZq1N
	1ZrUDf9y6eW9gM/5CO7Fe+UpqlrlcH+ZAv4Qvb/UVcHQaaO4gva5Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur0rt9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 21:17:21 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 582L8f3d012779;
	Tue, 2 Sep 2025 21:17:21 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur0rss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 21:17:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582IjD4D019924;
	Tue, 2 Sep 2025 21:17:20 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmu4pt2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 21:17:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582LHHYH18940440
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 21:17:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4546258056;
	Tue,  2 Sep 2025 21:17:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1262458052;
	Tue,  2 Sep 2025 21:17:17 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 21:17:16 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v5 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Tue,  2 Sep 2025 14:15:52 -0700
Message-ID: <20250902211705.2335007-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250902211705.2335007-1-wilder@us.ibm.com>
References: <20250902211705.2335007-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX9OSO8pZQ++3l
 y9408kFiiLh+W0AlzDFluDIs4VDHTgFDthlODUxg2ksRN9cnC7LqhhOID8Q/D1ZP3pDdgAxgCO6
 cQjCY1abP7twza+2QN5ub41+nojx5QTkpdVDRYLocp+UIdiLahopva+E6gGDuTp6D+MeRM5qB9h
 raCrHXfNwU7wuGR0xjARmOKQbbFCVKGFitAxV2IGkD+mAYzzFxxLTuiXY5KN/XGzCLZazMt0zmH
 2J00vdpPQO1kTKKYuAj1u9OokZSYC/D0BtlHNO++oqBw2JWFtO4jJhtMJCZRziHNz6cs9FJqWL5
 7plkwhOTXyUyJnxxC+dbr4riYI8fc5voUW6EEoXdJUcx50gqkuejLQdVZA0/zLyd2nWdMJDXSDV
 TROpXwEp
X-Proofpoint-GUID: fk3TSdwR3Os5tciNBx4ex419gHMPRY8r
X-Proofpoint-ORIG-GUID: ucWTnLr22GkIDtP99LG894i8QBxpB2tj
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b75ee1 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8 a=tutZqjyPK2kbOQtnScoA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

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
 ip/iplink_bond.c | 125 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 10 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index d6960f6d..7dbe9d58 100644
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
-- 
2.50.1


