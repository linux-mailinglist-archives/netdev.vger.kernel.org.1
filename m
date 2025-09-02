Return-Path: <netdev+bounces-219304-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E839B40F0E
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AEF107A3CD3
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:08:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66E7F350828;
	Tue,  2 Sep 2025 21:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mtWUKrBl"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DB72340D85
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847428; cv=none; b=S4iRckSmtnRTxkWHA9SDvhFqqsGX/NV35pTrv4Crj//Gr4TQTy4dZ/c41P/yOfm0guuOuPC1HK1QLLVEhESvnd8ML+Ei7LbxHp3SDSXBXoV6ky4yMBu2XYzRcDfFEVZZK4bpSN46Yz7jxYQTKpz0kQBn0VraP8b1QCTRl5naYs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847428; c=relaxed/simple;
	bh=EFhbyz2tfkHaZKCjnL5gqSbShUvMI5ZHICllwqN4qj0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bwfOQXNY41xPShBq1Lx/6724uaCyiDfdjZ3eFsYijFC4uN377glmJ8+jjNlNnGNEcQJa7ivLhZWA3XDxv6tjYSZ0DYR1oUYAseVUAfdwEzGhJaDFdi2fuPhJQxz4rgnBo8wUThIWCpbNhJiliut83GcdUhv03YF7hCS1WuzsPqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mtWUKrBl; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582DHm90032521;
	Tue, 2 Sep 2025 20:43:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FNclQ2BLV6Kx1bdeZ0vW0+WfoxoID3aK9ryhWYqhA
	54=; b=mtWUKrBlccoOmLUJMtzBFyVoP/hm52eHGkaLwWuVMs5628pdUwnMi1TkF
	4Ic/6p7WcwKhYYhXCEpgqbYBlJErX5i+KuKGR2Wm594tlNHkWpoh2aOWm/qqbl10
	T5fjZpapVdqh5TEj0OllmRaW1y/bWByPquL0BKD+AGR9yk9QNF6ibste8556GKaJ
	DnzATClnvV5jTA1xCPnnXO+ezL2n2ayQpRtGgqZNSWthwdCiAE7zZzJp5pWhQRrb
	zGS06WI2CC62g9tfGc5vHeRftKXT8fn8Ti60bp5rAy9dVkMSIQ8EqFKGn7Qe+LOT
	iDaJuPlzRnMyzdztYgMx5NGXFyvXg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48wshevhd9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582H3sQR009056;
	Tue, 2 Sep 2025 20:43:49 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vdumc6b9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 20:43:49 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582KhlKM31982318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 20:43:47 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 739D558064;
	Tue,  2 Sep 2025 20:43:47 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 37C3358052;
	Tue,  2 Sep 2025 20:43:47 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 20:43:47 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v9 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Tue,  2 Sep 2025 13:42:56 -0700
Message-ID: <20250902204340.2315079-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: sVzzoXyKQCpg_Ay3h0LcStSzbhjio5H9
X-Authority-Analysis: v=2.4 cv=do3bC0g4 c=1 sm=1 tr=0 ts=68b75706 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=_9dExB9TU08cRdUV:21 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8
 a=gJKeHePEuPHtG-X8aiYA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-ORIG-GUID: sVzzoXyKQCpg_Ay3h0LcStSzbhjio5H9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTAyMDA0MCBTYWx0ZWRfXx5C6sG6gRDBf
 JVk8jkrsubmwtvnRtLCkdHkv5+/rzPHXzecaZhxjkqRARXctGnbGK3hWnmIclh32wA49OaG6yeH
 BYf9LGSWD/DRJEuLGw3v8Zv/gX0H0iC/KHmAoZQi8+MhAMM5B5Jrlxmj8P7nexw9iBCcVi10mo2
 4hUPKXoQltb5qlHpwV4j0lPf9y39zcMvCWHCBuxSmrbSaZicyry+EdkatpSm2apECwJysl120le
 YbDMuazdUyhlU5nK4zjQ80GMnEE2TPFGq2fJlMG0cVyAfu4HuWl2wH1UdIVuggBkAoR/+SctfUw
 7hj77B9Z1xqvN1jmzSXoCFFMWaoCF2RNVj91nZAyfjoav5uiomw60O/S21Cr45jJOTtKLxPmCmK
 UXBYzRC/
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 clxscore=1015 impostorscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 spamscore=0 priorityscore=1501 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2507300000 definitions=main-2509020040

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

Changes since V8:
Moved the #define BOND_MAX_VLAN_TAGS from patch 6 to patch 3.
Thanks Simon for catching the bisection break.

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


