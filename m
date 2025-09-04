Return-Path: <netdev+bounces-220170-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06AFEB44968
	for <lists+netdev@lfdr.de>; Fri,  5 Sep 2025 00:20:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1C189240B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 22:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A21852E8B85;
	Thu,  4 Sep 2025 22:20:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nCcbp5A2"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E85CE28C5B8
	for <netdev@vger.kernel.org>; Thu,  4 Sep 2025 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757024413; cv=none; b=r4gsRYtnm5v1VoXzsw7Bpd04Vy2iAVBmCBIbZ3o0xSR5J+PhadTZh/2sNAVDRCNE2kw11Vxgr1ixqZd1I2djU+uOKDfOg/0g6ZSeWkANoUBTigAw/6L1M/07KtIL4PziuK1gVdoWJCR4JOqK7rimxWWm/eYP8I3DYQt72jn/SPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757024413; c=relaxed/simple;
	bh=pbqDRmDMyO4v2WmrFO26RJAp2Rv23UF3rEggVMzjoK8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=g/T8FvdOgPfbmqrer2AGxJaD/Su/cJPw7DlNpBXOBmEJDWBgr1MaT4GbmT3GuBSBmz1HJptZ2PYNe1xaOmAX5dkhS0rR9hylOWTFHqLrsdDsjiyz15DjSEhRdzFe6d97Yv1NHQPbQJFsFnEClb3DcOkoS+Uu2Xs0qN/v9nAna9w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nCcbp5A2; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 584FXhXB005968;
	Thu, 4 Sep 2025 22:20:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OAY0i5ElU1bNCEH4I4z6BrXkbn+Pv/hiqx24d/pMm
	Mw=; b=nCcbp5A2gGSgq9gihGrIskZuxAoABRM8lFFdfC/OH2kMNotx4WeQAh4S7
	bYdp42GIGEfjBwW8F2SkXOPasDbQJetW0az58kgwBkpslO5UVoJaRdt5Lh7A2dFD
	pWshUkWpQfjJ68RwY9gib/PzZP0yzJUSZrpCjUrra3AbXU3iGCKU1zKnNJwxOCx4
	2Iv9pCZ9kHlxhg+ddW9vm/R8aoKXq0G2/ajrXWkyC4EBC9PAaHeg1K9b1PNAF3nv
	9g+usDr+Bj7dsktcmTJXMeyCCVWujBxIyIVOjSaXBLNLohRECzoqqXp9oMowVVfG
	Q2zKzTrpow/TwyvkTTrihXO70lAwA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usurcyfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 584IQdRk019910;
	Thu, 4 Sep 2025 22:20:00 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 48vbmuex18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 04 Sep 2025 22:20:00 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 584MJwaX15663708
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Sep 2025 22:19:59 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CC9EA58059;
	Thu,  4 Sep 2025 22:19:58 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90EF258043;
	Thu,  4 Sep 2025 22:19:58 +0000 (GMT)
Received: from localhost (unknown [9.61.141.209])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  4 Sep 2025 22:19:58 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, horms@kernel.org
Subject: [PATCH net-next v10 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Thu,  4 Sep 2025 15:18:18 -0700
Message-ID: <20250904221956.779098-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfX8B7xxssJqY/R
 bFBcNPMjHNfi1+eNHzj67c90UMKZQPyo27ueby+Ggl5dmRsVkhdBLqc/JCKjpjcBdfoxr41cbsk
 +0WjpHAw5vOTG/eFkKqHz7X7SDNvXkzXK4VPxNNkZoWv3ImehpwP1dwtu1GLeWWSeIrmDvjXj/8
 plqdoyT5Nhwc1y1jiQlFM3XIz2RBpH6FEN/yIHM+eFDoJqW8voqQM3851yP9/qsQTFX1Nxugstr
 lYA1C+UO2x+pBrQmgzJrShymb8eNxTCqE1rrAOaFlJcRPNjz/lH6N1guxC82oqkXyfWsqfODQi4
 sxKBMw5Ag8CfLOV1IKdpxdRJxueF9RqRYcCr3gIX732z9FlcoEahRcUoAH8GTTwD4bFiVqrMapq
 7SlhJ2EJ
X-Proofpoint-GUID: a7DtaP8xqUR7aWDLLVJ2pNSqGohzF5yS
X-Proofpoint-ORIG-GUID: a7DtaP8xqUR7aWDLLVJ2pNSqGohzF5yS
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68ba1091 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=_9dExB9TU08cRdUV:21 a=yJojWOMRYYMA:10 a=VnNF1IyMAAAA:8
 a=gJKeHePEuPHtG-X8aiYA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-04_07,2025-09-04_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

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


