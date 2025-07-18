Return-Path: <netdev+bounces-208250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C78CDB0AB68
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:25:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC9A9AA3C60
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5891B221286;
	Fri, 18 Jul 2025 21:25:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fiwbV1/B"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A02CB21FF4E
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:24:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752873900; cv=none; b=YnswvS7ShvmDd0QBIwVRfPKR8zkXKBn4YlBWBABy8r0zml9jcXmpeADJyuxheIdB+/pelY9bG97qcdw0sQAp9ZUyedAA/WTFSJuDy/dgcXND4O9Hnw8fJkKfFWBYpc5T0FEwHciXf3eZKz3JRndml87gkpbAmY7c+XD8qfI5sik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752873900; c=relaxed/simple;
	bh=yUe7zx555Q60yQnr48IyEUA2xCVUbPjm+i/jaP9M7QY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YETGufPxqO7M0TdgkIiIeRhq0KrPZRQkMeaMpTPSFaC3lCIrgH3TW6wW32CsMQDy2AcTd+3yAUNWKSTA4rHVw2Dpsil+BfBYjnkkUDI5/UCMnZ4N10jiEu4IypHhYq8Qd7L4GNABN4sJO0ZQs+5nGrAvAgEiRe+yjVpUatyYmTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fiwbV1/B; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHxpVZ027402;
	Fri, 18 Jul 2025 21:24:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=LdJquIIpFXz3GmPvMXknx+PKnJ0rR97Cl+CPZM3gH
	kg=; b=fiwbV1/BzBCP5uaflduc/Sr9xQ7KF4YOswTnFn8SPfYv3rsHeiW9ypfDR
	MM8RrTkKeJgNjWb9Umlq6SUc53K0RiX2lqYFAoEqlesqRBKBGAcK8qDoFdJyWriq
	IilZZUrF3NcnYwXcPRt3d3hq7A7ks29gcF6agRg8ZIS6y6shre+0KKHGF4qSAewX
	v+r694JeFhqdHWu/GLgYihvDDEWRFTIw26A/ZCSHkv3JOC5g6OL7IryHzJF4pZ+Z
	iDeTYG4ERuD0lNrq6OkEEmX0hXmEcC5P1sD+S96Zh3LLqrGK0NRgvsk750nvo/CV
	a2D9sslIkGQI5kTMcRPQivJ4elpaQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7k7h4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56II1eo0008145;
	Fri, 18 Jul 2025 21:24:44 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e137yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:24:44 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILOgPb6095478
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:24:42 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3713A5805D;
	Fri, 18 Jul 2025 21:24:42 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EEB9258052;
	Fri, 18 Jul 2025 21:24:41 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:24:41 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v6 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Fri, 18 Jul 2025 14:23:36 -0700
Message-ID: <20250718212430.1968853-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=687abb9c cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=_9dExB9TU08cRdUV:21 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=5ZApepXBbOjBgHogCoAA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfXz/pTki0ozKwn e73rczxcwxK59bC2gOJmmL8zL+dRGSPgX57+2qN+f4NB5SRhLOFnRzZzCLoLMbBI7YaSzftQwPS lkkXowsfsmIs2xfcTUFxJ9KB9fzh+VWQZLMQIx0dJC0mXSKC4qh+DMePMvQdiZ6yv+KLojfwWT1
 D862LOkTvq2DevJ5aPlHxhTO4A5ZI8tZeYybYwNNDBYgcdgKDrOAzvHUUl0FiPgmqTrlbNwsLCN WD/kW4I7vyHaZ7wJxti+C+E20wBsrmcfGBPw6SkE48rzy4iXrHpOCHAXl6CuwEBbxggASCwJUns 1tqfrBTzpPP9SE93tanReIPL0+5KUzhm6r1Yh/IAPo60homRVgXPVeq+w/ypi1pYsqYwaEJFIeu
 xu+sCuPEdfAtc1JAPcb9N7C5oXrjqj8VjvL3wCEG3I+Y1xhs+jZhSF+lbVx0K9LGOnpTxmZA
X-Proofpoint-GUID: La6wFwO986Pocd7rN_KhXMwwSoJ_ZdK_
X-Proofpoint-ORIG-GUID: La6wFwO986Pocd7rN_KhXMwwSoJ_ZdK_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180173

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
 drivers/net/bonding/bond_netlink.c            |  34 +++-
 drivers/net/bonding/bond_options.c            |  95 +++++++---
 drivers/net/bonding/bond_procfs.c             |   4 +-
 drivers/net/bonding/bond_sysfs.c              |   4 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  61 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 178 ++++++++++++++++++
 10 files changed, 393 insertions(+), 73 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.43.5


