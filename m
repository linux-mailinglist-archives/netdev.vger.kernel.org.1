Return-Path: <netdev+bounces-202040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB6F3AEC0D9
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:24:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01778646431
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:24:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC19F21ADC9;
	Fri, 27 Jun 2025 20:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="QrTZQH2G"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51EA3C2FB
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055886; cv=none; b=itp0shoCxESFVr5J771ARxtwltuEc7zAdj5MkmyiuwH/e5P58+rj/8COsf6icybz214q0UuPyL02bdq6I+rSvjkG8OgNrOsrQf+Ev0XD0fddSny8/nu1ecCtsG51q82ii6XnV+PhEzG93ZRVlbrV+DiuyVPbg/lV7Xy8g84aUKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055886; c=relaxed/simple;
	bh=t1IC2Xb3n/4rgnaY/ZmATJfGMPTYsKQ2cSWarMwK8aM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VuiOcQdbM1qs6y/iBBnuuIq8YzhFBrStwwsUauOloseW04FasNpxpoA68GBZNkaj6MsAJMLoX+olSaV0+car9pOJqILDaLhD9q7T9ZJXH986bFzgY416FXlm7lpnirO7J6iHH+wGek3n/AUV/UW/tou8ThSwTf6j+psckDXLHww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=QrTZQH2G; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RCJNt0019644;
	Fri, 27 Jun 2025 20:24:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=cgsGsS9MWnBOr/X+K
	3rWsXxEg51P8OdNnNx0wg381iA=; b=QrTZQH2GF0qMcTpbAloXRav3cWz/BiE0s
	45n+zbvYhMYYHkeFIb6LIyh0P/zwTfljuXAIZb6zIDVkzlRoBIXBAZuAD2utQQci
	Fut5ZeKvTORFsJLJp/9bXbVyvRoEYpAd2UMrmyzUZsIFzqrJnDfBXJNXZSJQ+BWF
	bHoq6VDUdD1zWN4rjnjHIsTv5ixljTFVmSA200gJiFg7UX/D0WgcB/i75QOh8AfO
	0dC4sVc+KiA1QLLESgZzq9Am5uMBaFDdX5WS1w+6NSQjC7TVG1uZIcAP5+r0WQ43
	9XubongREWCxIhNV/+lLG8HBBVQyP2Omu6NiHN+7zM53WjRIiD11Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3q8tm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:24:38 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55RKL7NA006437;
	Fri, 27 Jun 2025 20:24:38 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dmf3q8tj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:24:38 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RJqt4b015033;
	Fri, 27 Jun 2025 20:24:37 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72u64wa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:24:37 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKOZ7t32113068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:24:35 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 326AE5805F;
	Fri, 27 Jun 2025 20:24:35 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E5B8058059;
	Fri, 27 Jun 2025 20:24:34 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:24:34 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v1 1/1] iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.
Date: Fri, 27 Jun 2025 13:23:44 -0700
Message-ID: <20250627202430.1791970-2-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250627202430.1791970-1-wilder@us.ibm.com>
References: <20250627202430.1791970-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=M5FNKzws c=1 sm=1 tr=0 ts=685efe06 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=Y09vYAkWHWKlsp3Wz-kA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfX8uaw/LJFO10u jCMeJ8baMwSrR4xaDQ9iUeGmTsBTgw8+UuOoTh+21M/KkDjitZs+vxEMLeUzjrcRm6cEqWgr109 RHnw8TtN2u8AYdWvQB96cUQ93fmyfWhm2QXHy6D7XSL0o3ODFMBYA03hkE3wb4f+N5+NUJ/JfbM
 nMsh8/mXSgAcHZ1+FBujr52P95DqFzuyVEaBhMmw88FKMP+N5+KtJZAowSev7QaibbkeRk5b2lb NTtXBqvYFyJVGyYGsWYgCQ+zAZ8gzzoDMQEc8Zo+xdAMJAXgSI1Ne4dWMD8YyYltrF7rMOrNnff iJKM6VXXju35lSJJh9PbSuuzgkPdq/nYrNh9Bl5UA+drdC6sNw9kwmUjwJuo8mkkpr5H5a9/EEw
 FWOyPQ/qvgnOmQNQ8oREBtPegxnhjhuFTjOAM9XTpj3CtTp7OOTvo85dhYXB41oknYTHmCYe
X-Proofpoint-GUID: G7AiiACXdMS4l_QTxQQkloi_HpQ-YaG3
X-Proofpoint-ORIG-GUID: yJ4rnhDrXhc-jrhE9qx-zKeUj-paPV68
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 priorityscore=1501 phishscore=0 spamscore=0 clxscore=1031 adultscore=0
 mlxscore=0 mlxlogscore=819 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

This change extends the "arp_ip_target" parameter format to allow for
a list of vlan tags to be included for each arp target.

The new format for arp_ip_target is:
arp_ip_target=ipv4-address[vlan-tag\...],...

Examples:
arp_ip_target=10.0.0.1[10]
arp_ip_target=10.0.0.1[100/200]

Signed-off-by: David Wilder <wilder@us.ibm.com>
---
 ip/iplink_bond.c | 62 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..bb0b6e84 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -173,6 +173,45 @@ static void explain(void)
 	print_explain(stderr);
 }
 
+#define BOND_VLAN_PROTO_NONE htons(0xffff)
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
@@ -239,12 +278,29 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
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
-- 
2.43.5


