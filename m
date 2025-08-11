Return-Path: <netdev+bounces-212646-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 79B72B21916
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3004A6210D9
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 432D81D61BC;
	Mon, 11 Aug 2025 23:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="B2brWp5k"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BE00487BF
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954373; cv=none; b=kkMloEVpjcUXdWeZQCPq2rUD2sHqiLP2e604hL+AvyV84fQ7ijGUj585e0Ic4Q0TI5K6XnncPgZ4Q+MfO1fXtWk21Ea9PTgFQbf2FXCJP1mlB+lg0EzjTWWZtW4ZOqAzglsEXZNnO2PB8+6j7vJz14zi2XJMpqbddfby65IIuss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954373; c=relaxed/simple;
	bh=axQ0Qayn8e+QUg/qcMp390LiG/hZ3YEQjfsbDU8xKJw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gb7S1PtmDZpjy8tTbLT5rlpjl9xbenLk7xMNb1QCYlo4vyHf3gzX0wuVIiIZnRIswI+VUQiv1pqMZUUwIEZimaUx0z1NAy1mFocEhNrKh/0TVhC51ZGrA8t/CXu0JM81GlZpsehoHHdwesJXzpsGWgiMYvAwidBqiG86gaReyUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=B2brWp5k; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDqPhC025088;
	Mon, 11 Aug 2025 23:19:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Ni4EbkigGybqwRbqPvGEnsZC0LYBHixe5v4typDyg
	rk=; b=B2brWp5k+D5B4bBb92kjBGHpp1NjlHqTma6wthE8OkBei6pbIfGVAaSR+
	hSVWMT3yeBY70/IbyVHPvfWV34ncxVgdHm9vAIAko5pixZM02YxjxN+QiqlhPgCl
	X3zkYDaZADdkJ1NtKleDETTODE8BRNASV4Da5ihAntofyFAo8aVt3D8JMR6rOIsM
	AL3DilO/EJXXxAf8ZRD4msxWrE/Ysv6GcT4HYfp51GPhOb/uht8y0ZIV4rtO9aSi
	/a6ujpg2EfU2LRx1XZspzoaCU3f3kM1k2dR+1JuzK2Zi9mX4rA9/61o5ewQeu04p
	Kdo5kNOykAcN8sHnfVSlZQRd4ekAg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48dvrnugt7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:17 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKYVXP017606;
	Mon, 11 Aug 2025 23:19:16 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3fknq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:19:16 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNJEEd32637574
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:19:14 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 801135804E;
	Mon, 11 Aug 2025 23:19:14 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1CD895803F;
	Mon, 11 Aug 2025 23:19:14 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:19:13 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v7 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Mon, 11 Aug 2025 16:17:59 -0700
Message-ID: <20250811231909.1827080-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE2NSBTYWx0ZWRfX5NtVf+fFsPPQ
 eaVOGCs5+9CfVlQZDQkKCmsD+Spiq71IhkckC+PMZAPI5v4YwoqhqMZZxyUvNKjS43KnLBuwnzE
 0qOhjJDsCPabFg5h6zr1L6Mt8JsK32Rta/XYrJM+8k2PP+9RszTFMkJinLVQmPgK7PLJ9bMo/PX
 upRXdIxRUaD1QCln0BXaLVSRrnwNp/JpgTrq66rbUVWJcioo3HFOYQHNLQm9cbmGugjKB1ObWIG
 ISbsyVn4EXbBCt60/B4K9ks4/IgYARKir4UWmpqm/JojfdqCsRK/wAD/SsmVPvB3tboc7/bNWLz
 et7fhG6A9DUKLCOX2HhtLSXebrcTe2H3WumwsXQYmZWe+C/JkN5Uz12xujHGtRnaMOpnErEs1Ql
 /KQe7r2xTbY0xLm9oEK9adDc1S82U3hPESUZidr6O0/zAkvSq91GJ0CsyWwQham+DkRP287E
X-Authority-Analysis: v=2.4 cv=GrpC+l1C c=1 sm=1 tr=0 ts=689a7a75 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=_9dExB9TU08cRdUV:21 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8
 a=5ZApepXBbOjBgHogCoAA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-GUID: 9GwlS5WR1jqnFh1THgBfNYGD8PF_9WfV
X-Proofpoint-ORIG-GUID: 9GwlS5WR1jqnFh1THgBfNYGD8PF_9WfV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 suspectscore=0 phishscore=0 bulkscore=0 mlxlogscore=999
 malwarescore=0 clxscore=1015 adultscore=0 mlxscore=0 spamscore=0
 lowpriorityscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110165

The current implementation of the arp monitor builds a list of vlan-tags by
following the chain of net_devices above the bond. See bond_verify_device_path().
Unfortunately, with some configurations, this is not possible. One example is
when an ovs switch is configured above the bond.

This change extends the "arp_ip_target" parameter format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.

The new format for arp_ip_target is:
arp_ip_target ipv4-address[vlan-tag\...],...

For example:
arp_ip_target 10.0.0.1[10/20]
arp_ip_target 10.0.0.1[] (used to disable vlan discovery)

Changes since V6:
1) I made a number of changes to fix the failure seen in the
kernel CI.  I am still unable to reproduce the this failure, hopefully I
have fixed it.  These change are in patch #4 to functions:
bond_option_arp_ip_targets_clear() and
bond_option_arp_ip_targets_set()

Changes since V5: Only the last 2 patches have changed since V5.
1) Fixed sparse warning in bond_fill_info().
2) Also in bond_fill_info() I resolved data.addr uninitialized when if condition is not met.
Thank you Simon for catching this. Note: The change is different that what I shared earlier.
3) Fixed shellcheck warnings in test script: Blocked source warning, Ignored specific unassigned
references and exported ALL_TESTS to resolve a reference warning.

Changes since V4:
1)Dropped changes to proc and sysfs APIs to bonding.  These APIs 
do not need to be updated to support new functionality.  Netlink
and iproute2 have been updated to do the right thing, but the
other APIs are more or less frozen in the past.

2)Jakub reported a warning triggered in bond_info_seq_show() during
testing.  I was unable to reproduce this warning or identify
it with code inspection.  However, all my changes to bond_info_seq_show()
have been dropped as unnecessary (see above).
Hopefully this will resolve the issue. 

3)Selftest script has been updated based on the results of shellcheck.
Two unresolved references that are not possible to resolve are all
that remain.

4)A patch was added updating bond_info_fill()
to support "ip -d show <bond-device>" command.

The inclusion of a list of vlan tags is optional. The new logic
preserves both forward and backward compatibility with the kernel
and iproute2 versions.

Changes since V3:
1) Moved the parsing of the extended arp_ip_target out of the kernel and into
   userspace (ip command). A separate patch to iproute2 to follow shortly.
2) Split up the patch set to make review easier.

Please see iproute changes in a separate posting.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (7):
  bonding: Adding struct bond_arp_target
  bonding: Adding extra_len field to struct bond_opt_value.
  bonding: arp_ip_target helpers.
  bonding: Processing extended arp_ip_target from user space.
  bonding: Update to bond_arp_send_all() to use supplied vlan tags
  bonding: Update for extended arp_ip_target format.
  bonding: Selftest and documentation for the arp_ip_target parameter.

 Documentation/networking/bonding.rst          |  11 ++
 drivers/net/bonding/bond_main.c               |  47 +++--
 drivers/net/bonding/bond_netlink.c            |  35 +++-
 drivers/net/bonding/bond_options.c            |  96 +++++++---
 drivers/net/bonding/bond_procfs.c             |   4 +-
 drivers/net/bonding/bond_sysfs.c              |   4 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  61 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 180 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   1 +
 11 files changed, 395 insertions(+), 76 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.50.1


