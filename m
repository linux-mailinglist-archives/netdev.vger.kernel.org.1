Return-Path: <netdev+bounces-206903-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 08329B04BA9
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:10:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 154F717DC98
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 23:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8154428A72F;
	Mon, 14 Jul 2025 23:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Q7pb0Gay"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA3E5289E1C
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 23:06:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534391; cv=none; b=KRyJ92n7hpmNK2PjEXA1dbrcmkBvit8VioEhkec++VVXBWTymLlnWRiq19/dLi0LJLQPAAZJj+osbgN3q11nVW1HA0nhyy4k3Bg+g3bUSAxWQWywleCBXjZyrwZNvvBFUf1zhCOPdLIhLWak2GfskHpDbMCV2aJvZBVMj5jQ27w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534391; c=relaxed/simple;
	bh=myofwm8EooAlPpgypAK2r3poM2LwpQsJHbt22Zbu9C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3QfPo/Gos8mvFi4KcWJa8BsxLHQA2r+QRGn6s2oqNFQzLSAkBaSWwyFxK2mu8vva8PuE4m16yAz6aKf4l1WwJAKKrJwvbPnIdgFBiYA5FIEuJX4qeQTpJAoBagW0fnqoKwIdd5IJqmOrb65tTLBHA8D9Ftl13FR95hG7mF4Tbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Q7pb0Gay; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EIdrsG028477;
	Mon, 14 Jul 2025 23:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UPJ6R0Ta29cCMzUaH
	n5eG+abY76JhBEfR8uf70dNT6I=; b=Q7pb0Gay/ts1IzTvp2HUNUbAC3nCGXp2s
	kl2qdlkntdvYWrV8iRRAbF2UuPTg8m1GBXwL/xAvJ7RbobJ8kCtCeNU4WsvKvvTa
	h3RI07LBa297oXfzin4ePD/KOy5sljuHWzZS2fgq6N+vt8MXWgw4zEwZ7XWEk6f7
	pko5xilCcQzu8QInjncF5M0V2Mv+hq6zzzNJLau4oD29yzWNcBLeJB3j3bjwn8wu
	qwzzeDMTQoOt2QWO8wVmfq04z+hr+RDofgJ7ra0tUjN84lP73cBXvpmf3wU1tA6x
	3KcO/LN3GqTC1f0UrCfiY6CbMp8SBY18rKEv2prurBW5GKGxjagvA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tv1g5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:06:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56EN6NYG008737;
	Mon, 14 Jul 2025 23:06:23 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tv1g1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:06:23 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EK6r8n000741;
	Mon, 14 Jul 2025 23:06:22 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48kyn8r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:06:22 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EN6K8t18285262
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 23:06:20 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2ACE658055;
	Mon, 14 Jul 2025 23:06:20 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E9B445806A;
	Mon, 14 Jul 2025 23:06:19 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 23:06:19 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v2 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Mon, 14 Jul 2025 16:05:40 -0700
Message-ID: <20250714230613.1492094-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250714230613.1492094-1-wilder@us.ibm.com>
References: <20250714230613.1492094-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68758d6f cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=FrZ5YI-8fMnmKrPFi-gA:9
X-Proofpoint-GUID: Ta0NypfBm78K3jQde5_9ypNubS6tcNrP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX+42eDtZ5O551 PNP3aPjWylBJAGgSxbUQ+XrxS3hB43uf5DCKPz4xTE+8utaOTV9ZZU6poZ0SQ535SA4/GhlgBnL T43wcQIwgyMUfOjYB2Hc0TMDXBAF/hNBGLqzGc9bntm2XW7rNFRQqh51t09IfkmF1pwZzk0IPJB
 r1S3EMhzyQWP/Y2tYWz4EJNVngi6VxcvH5bEXeA8TTXxnSmnhCyQW4eHSLVWFYOQBwZ5tJw4hmF lTWCJxXicOTF3lUo5Fzi3rte5SNK5by+Uyj1VTLu49KSOMMo1PHAJJ+pc2XlHu9sBIGxoojyeFl r2DUP7VrMlc7knXz5MfY4WSr2aAecPaXr2/xSaUuvgci171C6sXvUU7P8P1LBOPe9HA18cxhygx
 lm/g+xay2/qAixbArR/fxOa9GJ0f/Iqm62AO1v3l/uedLoTPqA1f6TCYhtSr5BZw99ovpEwl
X-Proofpoint-ORIG-GUID: ujrOvAMKo2Bo1zPeFJ9dDmccl1egsiTm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=956
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1031 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140159

This change extends the "arp_ip_target" parameter format to allow for
a list of vlan tags to be included for each arp target.

The new format for arp_ip_target is:
arp_ip_target=ipv4-address[vlan-tag\...],...

Examples:
arp_ip_target=10.0.0.1[10]
arp_ip_target=10.0.0.1[100/200]

The inclusion of a list of vlan tags is optional. The new logic
preserves both forward and backward compatibility with the kernel
and iproute2 versions.

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 ip/iplink_bond.c | 117 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 9 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 62dd907c..c4db68a7 100644
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
+static inline struct bond_vlan_tag *bond_vlan_tags_parse(char *vlan_list, int level, int *size)
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
@@ -507,12 +571,47 @@ static void bond_print_opt(struct link_util *lu, FILE *f, struct rtattr *tb[])
 			print_string(PRINT_FP, NULL, "arp_ip_target ", NULL);
 		}
 
-		for (i = 0; i < BOND_MAX_ARP_TARGETS; i++) {
-			if (iptb[i])
-				print_string(PRINT_ANY,
-					     NULL,
-					     "%s",
-					     rt_addr_n2a_rta(AF_INET, iptb[i]));
+		for (int i = 0; i < BOND_MAX_ARP_TARGETS && iptb[i]; i++) {
+			struct Data {
+				__u32 addr;
+				struct bond_vlan_tag vlans[BOND_MAX_VLAN_TAGS + 1];
+			} data;
+
+			if (RTA_PAYLOAD(iptb[i]) < sizeof(data.addr) ||
+			    RTA_PAYLOAD(iptb[i]) > sizeof(data)) {
+				fprintf(stderr, "Internal Error: Bad payload for arp_ip_target.\n");
+				exit(1);
+			}
+			memcpy(&data, RTA_DATA(iptb[i]), RTA_PAYLOAD(iptb[i]));
+
+			print_string(PRINT_ANY,
+				     NULL,
+				     "%s",
+				     rt_addr_n2a(AF_INET, sizeof(data.addr), &data.addr));
+
+			if (RTA_PAYLOAD(iptb[i]) > sizeof(data.addr) && !is_json_context()) {
+				print_string(PRINT_ANY, NULL, "[", NULL);
+
+				for (int level = 0;
+				     (data.vlans[level].vlan_proto != BOND_VLAN_PROTO_NONE);
+				     level++) {
+
+					if (level > BOND_MAX_VLAN_TAGS) {
+						fprintf(stderr,
+							"Internal Error: too many vlan tags.\n");
+						exit(1);
+					}
+
+					if (level != 0)
+						print_string(PRINT_ANY, NULL, "/", NULL);
+
+					print_uint(PRINT_ANY,
+						   NULL, "%u", data.vlans[level].vlan_id);
+				}
+
+				print_string(PRINT_ANY, NULL, "]", NULL);
+			}
+
 			if (!is_json_context()
 			    && i < BOND_MAX_ARP_TARGETS-1
 			    && iptb[i+1])
-- 
2.43.5


