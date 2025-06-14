Return-Path: <netdev+bounces-197699-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B171BAD9987
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 590B74A0DE7
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:49:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BD992AEE4;
	Sat, 14 Jun 2025 01:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="o33fs3He"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1305A7462
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749865770; cv=none; b=HJYJxoujek9rjNiHoxpGd2lTAhwW2s06gOf38H2rUZIrpSSOy6nICg8Q6gUQ1b1VvDJQFWrso85cY1yDpZRhU8pXV2iH/ZAKp8+Liq2MmwshBBzJl4BAh9R45e7Sib6V/n/7bO4IylcbnZ0WhwihjTC/KB++AuWIHjcZtqoNY1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749865770; c=relaxed/simple;
	bh=MDuJPq9t8amyABer69SP4kfiEVKBrHVRMNokp/RApBk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=oGkpaUiAeGbh6p725j8LO+W5mV33aFWbYs9pg1tKq/mE/TTPlAfCy42wsWltYHjNZr8pnFOfZaChROwsxjxMvX/qWPVtczglgMFQ2wIDeHcObE3vbouX6Kju2hqygO2Mx+skydD1HRgbWjVYZ8kMGg5ZIAbtTmmn5kGDvm9i3L0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=o33fs3He; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DJ9FTC004072;
	Sat, 14 Jun 2025 01:49:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=53CiOY2zRNnmvebx8e8KMJwy4GTAAPKWK6e0LFMoc
	a0=; b=o33fs3He21gTQZbtEVVGSRqwk6cS2+T3VPdVGK3bugTTufYxnmDgFl/7b
	cW9q/N55dnsb8Cso8WQctosE/13N1LLAYJsG5vcn/xHywlcy3+BtVr7VYReA/fdU
	rHdaQaD4iL5uPuNOgsXRh36Q/D/8W6mnE2KxjgCJNHMzl7Jedpw5bNpnVAPxd2DG
	Z64dRK9W8Lyp98MaNeil+dn8GvxhaKbkQJ5I8x+sr8hW6PbE0Iq0lOSisR/Z5wtS
	V7ZQqd7ZurDeQWWvKs/FyrkycuoM9OkUDymzGjlNagwD2yHDsgd5g3e1FKi8StHs
	1XUMyeXaZ6emNVwVN4z0d98Tgvp1A==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 474dv846vt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55E0OONR019623;
	Sat, 14 Jun 2025 01:49:18 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4752f2ve3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:18 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55E1nGTu20251198
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 01:49:16 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 02F8158053;
	Sat, 14 Jun 2025 01:49:16 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B368D58043;
	Sat, 14 Jun 2025 01:49:15 +0000 (GMT)
Received: from localhost (unknown [9.61.34.221])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Jun 2025 01:49:15 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v3 0/4] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Fri, 13 Jun 2025 18:48:26 -0700
Message-ID: <20250614014900.226472-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wb8v7wy6L9kLFiZvc0Ne6y4RXq3Xu20x
X-Proofpoint-GUID: wb8v7wy6L9kLFiZvc0Ne6y4RXq3Xu20x
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDAxMiBTYWx0ZWRfX9/RMiJ+ORCRo zeuzxAydiZrQXrNQ6gDiTbSjz6zRsc7nKSkMmg4m+4grVA2tq/AYG+/+uRmMw270dv6iATqCnaH GOukLtK7+BEKqhSqRnFN2tHvln+bXvmam5nJYXaJEv7gYLGrI7wams8l9BUtw7rq0aQ+ts+yDZB
 ghqueZZQ8skS0zuj/gHFobtMZagARtI2elwKEy2HnN8PXoWWMybSgjj+s/YAzI34tkUmZzAMnoA IGjdfZHVkb/brEKHR5ZkwpYpXQ/u+/XLnsQ670Y2SduM+EGvXT29541mlTBVADcp/ZCqXNUymo6 +QACEyBzFYo05ddO1AjYKFX+6W2bjEUMmKkeNSL64RCZlsw8tFDfkhYrYUIrfk3LQJ0A/J9qRDL
 xtCtEBS0D6B4+gmoijCllcmkXwu/8rnPkw8WENYVvkL91IMSZ6MKjXVLZXNTM97bWEmT6V33
X-Authority-Analysis: v=2.4 cv=CfMI5Krl c=1 sm=1 tr=0 ts=684cd51f cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=_9dExB9TU08cRdUV:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=IXH6Wj34hWgUOTDioh0A:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 impostorscore=0 mlxscore=0
 suspectscore=0 mlxlogscore=999 adultscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506140012

Changes since V1:
Changed the name of struct ip_arp_target to struct bond_arp_target.
Added patch 2, 3 and 4 to the patch set.

Changes since V2
Patch 1 was updated to add a flags element to struct bond_arp_target and
I moved the definition from bonding.h to bond_options.h.

Reduced a large stack allocation.

Cleaned up declarations to use the reverse Christmas tree order.

Updated iproute changes to allow for backward compatibility. See below.
--
I have run into issues with the ns_ip6_target feature.  I am unable to get
the existing code to function with vlans. My changes have the same issue.
I found that a multicast ns (with no vlan header) is not passed by the interface
to the it's vlan siblings. Broadcast arps will be propagated to the sibling so no
issue is seen with ipv4. I will post a RFC patch with my ns_ip6_target changes
along with my test code. Let me know if you have any ideas as to the problem with
the existing code.

I don't want the issue with the ns_ip6_target feature to hold up the review
and acceptance of the ip_arp_target changes. If the ns_ip6_target issues can
be resolved they can be submitted as a separate patch set.

Thank you for your time and reviews.

Note:
The iprout2 package will also need to be updated with the following change:

@@ -242,9 +242,14 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
                                int i;
 
                                for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
-                                       __u32 addr = get_addr32(target);
-
-                                       addattr32(n, 1024, i, addr);
+                                       inet_prefix ipaddr;
+                                       __u32 addr;
+                                       if (get_addr_1(&ipaddr, target, AF_INET)) {
+                                               addattrstrz(n, 1024, i, target);
+                                       } else {
+                                               addr = get_addr32(target);
+                                               addattr32(n, 1024, i, addr);
+                                       }
                                        target = strtok(NULL, ",");
                                }
                                addattr_nest_end(n, nest);

Signed-off-by: David Wilder <wilder@us.ibm.com>

David J Wilder (1):
  bonding: Update to the bonding documentation.

David Wilder (3):
  bonding: Adding struct bond_arp_target
  bonding: Extend arp_ip_target format to allow for a list of vlan tags.
  bonding: Selftest for the arp_ip_target parameter.

 Documentation/networking/bonding.rst          |  11 +
 drivers/net/bonding/bond_main.c               |  74 ++++---
 drivers/net/bonding/bond_netlink.c            |  15 +-
 drivers/net/bonding/bond_options.c            |  71 ++++---
 drivers/net/bonding/bond_procfs.c             |   7 +-
 drivers/net/bonding/bond_sysfs.c              |   9 +-
 include/net/bond_options.h                    |  20 ++
 include/net/bonding.h                         | 161 ++++++++++++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 194 ++++++++++++++++++
 10 files changed, 484 insertions(+), 81 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.43.5


