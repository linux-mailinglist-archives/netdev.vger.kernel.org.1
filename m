Return-Path: <netdev+bounces-227402-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C1DEBAEC94
	for <lists+netdev@lfdr.de>; Wed, 01 Oct 2025 01:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AECBD172138
	for <lists+netdev@lfdr.de>; Tue, 30 Sep 2025 23:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8DC82D249A;
	Tue, 30 Sep 2025 23:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GFN2ejYJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C85C12D238F
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759275544; cv=none; b=tzQRko4PCrodm/yp/6FTy/nRMAZTiof8AOJzdvcXfEcwkhsbfEJSwvKyMSDYucZ/pH9UKh/8BYxbwH/mBWnlNUaPnD0nxnuRi/CL8pIBxkC63v0m2A9jpwSRzlNuVxHYcDUhHT/cIogakkbb7eA1pLpL28OO2OAiRdPQ05cRq5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759275544; c=relaxed/simple;
	bh=QMIIAAhl0LzpcqAm4Itk3TlQ9jFBhMkbxm82mBG5e1o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWREmPoxJPUorcQmi6PL2phCz2niWFH7JA85Lfv3Q6hcVT+313e5omDP6re0+rxmoDH1UhhkJc+VUUdvW0D1ffY0NbW/EzqmyZGX63jZ1NTnD3MbZZNXSXAtfYnDVIJu6VQYYwgLzly9zS7IzGSbAR8B01zeZ+vdZ1/oLjuPAlU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GFN2ejYJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58UJc6Hh015793
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=cWpDQ29monLvCYB6v3pm9XiFLfDN3SUmJ/zZf4FHW
	YY=; b=GFN2ejYJJbwahpJcfR/m7xwEvZZFRE3gpD/bwyXZc7vudVB9LkRszY81W
	Y4tgmwggmm9NaDPYvuCFjkVDyvi1Bq1DtrLjlJYw5HFEfFax2OcFHxrw54fV06NV
	3qskFlTlpvxzRlPqsSXR1GMDrmpdJHocgnHRvZbi9gbz/j9hyn9FAfHRj1XlnkCX
	SfUPAD1jBqyS/ewLD1A7g6fHI0X6FVBuBg0pgmBvffLgcs8t4idad29zHD+RADjA
	C0w/iyW+y1Vpp1EilTCvat9dy18tOsw4RxUXro36ZKGvcn8jJ5XM8L71qulZvXnR
	Bw1Wj0Sfa1uCK0N8UW8iWcDo2/M0A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49e5bquv73-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:01 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58UNAYEg003325
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:00 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49etmxx7g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 30 Sep 2025 23:39:00 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58UNcwJT12780236
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Sep 2025 23:38:58 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9ABF058045;
	Tue, 30 Sep 2025 23:38:58 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 33CC758052;
	Tue, 30 Sep 2025 23:38:58 +0000 (GMT)
Received: from localhost (unknown [9.61.4.160])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 30 Sep 2025 23:38:57 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: wilder@us.ibm.com
Subject: [PATCH net-next v12 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Tue, 30 Sep 2025 16:38:00 -0700
Message-ID: <20250930233849.2871027-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTI2MDIxNCBTYWx0ZWRfXwlNV/48t9BV/
 ba8mVbB7B9YCfANosuQWmRo7pNwaQ5jz9uvE2CEdwmc2kCnlmU7ErwAdb9nIq+d8yoOfwAk+BrF
 G48qo9lc+DQcQUKKJ0U8OHtEKnfcMi+JjdOWtBZQ6MtLmlC7EQD8vPgSsuGYXowYUgzGFgd14b4
 8e0Iv0UULTpDVK7tjyeKhby29VDwQHKKrOOJnXc4ua2iRo2uXWNw/QdZd04S3AaWJVWKOqUEdgZ
 ZEixBPEUsii4b+5hMoMc/ApujG7t/MtrTMNTIMXP48OleOsBqjcU327GW2PKuZcE3R3tH6n6oaN
 W2qJ1X2NvGz90C8t/Stcp0U4Z4VWdQLA80Y9diTQMkEcXQnHBdg4MlsP0+UKd3XDgzClkAGRXew
 2gN8H+hVhgx2/zdILOPHJ0Pne4ESPw==
X-Proofpoint-GUID: QE68ianq_Dcr0KJDBP8v9O4oIrBhJp-9
X-Authority-Analysis: v=2.4 cv=LLZrgZW9 c=1 sm=1 tr=0 ts=68dc6a15 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=_9dExB9TU08cRdUV:21 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8
 a=R5gRUO9LV5Qi41pJStYA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-ORIG-GUID: QE68ianq_Dcr0KJDBP8v9O4oIrBhJp-9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-30_05,2025-09-29_04,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 bulkscore=0 malwarescore=0 suspectscore=0
 clxscore=1015 priorityscore=1501 phishscore=0 lowpriorityscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2509260214

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

Changes since V11
** No Change **  debug only.

Changes since V10
Thanks Paolo:
- 1/7 Changed the layout of struct bond_arp_target to reduce size of the struct.
- 3/7 Fixed format 'size-num' -> 'size - num'
- 7/7 Updated selftest (bond-arp-ip-target.sh). Removed sleep 10 in check_failure_count().
      Added call to tc to verify arp probes are reaching the target interface. Then I verify that
      the Link Failure counts are not increasing over "time".  Arp probes are sent every 100ms,
      two missed probes will trigger a Link failure. A one second wait between checking counts
      should be be more than sufficient.  This speeds up the execution of the test.

Thanks Nikolay:
- 4/7 In bond_option_arp_ip_targets_clear() I changed the definition of empty_target to empty_target = {}.
-     bond_validate_tags() now verifies input is a multiple of sizeof(struct bond_vlan_tag).
      Updated VID validity check to use: !tags->vlan_id || tags->vlan_id >= VLAN_VID_MASK) as suggested.
-     In bond_option_arp_ip_targets_set() removed the redundant length check of target.target_ip.
-     Added kfree(target.tags) when bond_option_arp_ip_target_add() results in an error.
-     Removed the caching of struct bond_vlan_tag returned by bond_verify_device_path(), Nikolay
      pointed out that caching tags prevented the detection of VLAN configuration changes. 
      Added a kfree(tags) for tags allocated in bond_verify_device_path().

Jay, Nikolay and I had a discussion regarding locking when adding, deleting or changing vlan tags.
Jay pointed out that user supplied tags that are stashed in the bond configuration and can only be
changed via user space this can be done safely in an RCU manner as netlink always operates with RTNL
held. If user space provided tags and then replumbs things, it'll be on user space to update the tags
in a safe manor.  

I was concerned about changing options on a configured bond,  I found that attempting to change
a bonds configuration (using "ip set") will abort the attempt to make a change if the bond's state is
"UP" or has slaves configured. Therefor the configuration and operational side of a bond is separated.
I agree with Jay that the existing locking scheme is sufficient.

Change since V9
Fix kdoc build error.

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

 Documentation/networking/bonding.rst          |  11 +
 drivers/net/bonding/bond_main.c               |  48 ++--
 drivers/net/bonding/bond_netlink.c            |  35 ++-
 drivers/net/bonding/bond_options.c            | 140 +++++++++---
 drivers/net/bonding/bond_procfs.c             |   4 +-
 drivers/net/bonding/bond_sysfs.c              |   4 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  61 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 205 ++++++++++++++++++
 10 files changed, 464 insertions(+), 76 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.50.1


