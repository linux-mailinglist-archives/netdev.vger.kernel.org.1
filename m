Return-Path: <netdev+bounces-218022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 263A8B3AD69
	for <lists+netdev@lfdr.de>; Fri, 29 Aug 2025 00:20:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D8835582D08
	for <lists+netdev@lfdr.de>; Thu, 28 Aug 2025 22:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 066B9293B75;
	Thu, 28 Aug 2025 22:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="drwAyuU9"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563F32853F2
	for <netdev@vger.kernel.org>; Thu, 28 Aug 2025 22:19:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756419578; cv=none; b=ZgZ9wBOhpwRLno+WZAQ94Js05ziIEeWA+/DVxgdn14l14r3BYv51617K/ixD2INsst36ojEmG1Qq0eFS8XRNTXukBRwyzQnSttMx4MOOU8bPgYlt+fSFc1GekWz3w994N8O+sFvM/qP1ji7QVyvfxT5D5Bp/6fu4JUiQXcZMEJQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756419578; c=relaxed/simple;
	bh=ktKmCWGCfTBYlVJDihdIwBcNQ4l6jpsyn9SRJNPMgG0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=AXT/+d8s8y3punim2J4EVcdm2IBlgf9YDEq4RIUYTLa+cWwPJadxTL5lK1YlHoNDbGZHcJ/UDAN1X4ARUTb2n7fNAJnx6c90fJjQ6lteVUXSC/STVoSjbv+vefGfUrHggxEtBhLvJy5aSDjHYgB0GQYSMooTCZYOfJ7r1HPpI/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=drwAyuU9; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57SCA8pa008960;
	Thu, 28 Aug 2025 22:19:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PaDV+FgykL7klyBP6ETOM7jTFj9+mZVasmgwyuzax
	Pw=; b=drwAyuU9dzDlDeqEoBZh2u/nQEuaYQcBe0nQlgpdbBo9PtX2ri2bxCOLU
	YPYsz4e+5QuI06RvAX9Xa6N4XuP7zt/wSxgbMLqJufgR3bEM0xZJg82jdyNgWBoS
	Kqwl2x2FGwirm0GOJ5S5gmLsY9RQpgRDkkxlV4VC17+xogIPFu/AWbZ74l2X8hwg
	RWpc8W4Gx9H6impTyvlN46nJIy59LZhJjatvAzyDlKsGWaSyaXJp9ETnGtofGUPN
	pGOfC6SuoQo3+YZZpoP2OlapYsUcGhU1YQevgON80Ggoa2Q1c02JlFdhG+Nui9K2
	FetK80asQrtOuJBbFIQfCgI11ZmEQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48q558cma2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57SLXrfx002502;
	Thu, 28 Aug 2025 22:19:19 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48qrypy49g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 28 Aug 2025 22:19:19 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57SMJIg520120290
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 28 Aug 2025 22:19:18 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F0D6458050;
	Thu, 28 Aug 2025 22:19:17 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 890A058045;
	Thu, 28 Aug 2025 22:19:17 +0000 (GMT)
Received: from localhost (unknown [9.61.155.164])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 28 Aug 2025 22:19:17 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v8 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Thu, 28 Aug 2025 15:18:02 -0700
Message-ID: <20250828221859.2712197-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EoY2zTJk_neRV1GgfZqz5rR4dYRyOMyG
X-Proofpoint-ORIG-GUID: EoY2zTJk_neRV1GgfZqz5rR4dYRyOMyG
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODIzMDAyMSBTYWx0ZWRfX9zqij3gEBevR
 d6GMbF/BVRjVHtgLoPRZHYbXdW94b1VlLa7XOkvKb/W/BSp2sXozhdsH47LmFk42wwHK779nAgT
 e62DNih6gzcoA/6oXka9ENpc9dF83bDUM86jFv7OFD+3Soc4crpXsmw7NcoCmtUfcBwFjaTk8rr
 35qkwEpAt4tKhpaakAe5x1DNJoZl/ZFM7xdUgRqdQvPYjJAjJF0zSE0BXcxAbsnsXStmAAjw0lP
 aInC8NwNbV699iNjkAt+oLKd1srjaZIzXhQHsukoa9emJpoFya+fEsfAfUtu9cBk2SJYrgEaSEY
 6BI329jrZgEKezyWQyAAOFFdE94ucJLH5Xpg0c4dS6aVY54BQH2KcDRMFsCZc3xJpU5Y6UAk+ya
 8B9mdXm4
X-Authority-Analysis: v=2.4 cv=A8ZsP7WG c=1 sm=1 tr=0 ts=68b0d5e8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=_9dExB9TU08cRdUV:21 a=2OwXVqhp2XgA:10 a=VnNF1IyMAAAA:8
 a=gJKeHePEuPHtG-X8aiYA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-28_04,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 priorityscore=1501 suspectscore=0 clxscore=1015
 spamscore=0 impostorscore=0 malwarescore=0 bulkscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508230021

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

Changes since V7:
These changes should eliminate the CI failures I have been seeing.
1) patch 2, changed type of bond_opt_value.extra_len to size_t.
2) Patch 4, added bond_validate_tags() to validate the array of bond_vlan_tag provided by
 the user.

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
 drivers/net/bonding/bond_options.c            | 135 +++++++++----
 drivers/net/bonding/bond_procfs.c             |   4 +-
 drivers/net/bonding/bond_sysfs.c              |   4 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  61 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 180 ++++++++++++++++++
 .../selftests/drivers/net/bonding/config      |   1 +
 11 files changed, 433 insertions(+), 77 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.50.1


