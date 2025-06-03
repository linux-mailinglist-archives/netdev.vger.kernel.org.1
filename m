Return-Path: <netdev+bounces-194692-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD9EACBEF2
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F2AE116F29A
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5F872613;
	Tue,  3 Jun 2025 03:52:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Qb4Hr67c"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F05F1798F
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922771; cv=none; b=doF5Wa8zhoWBLdA/vtWy0QP9OOu98Z6lu0Ct/aARUpYUt0O2RHX3FpI3ALxv/RXKCCcJV089wnZjSXl/zcpC3pk/2RdGSlEHPD0AqI/v2Zi7gxqGLLEHtgShHYOQfnzgI+1CquGGtYacKo/1zwjuqK0+5A8AR2RWvC79uTp19NI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922771; c=relaxed/simple;
	bh=CqU/ZdlBWBnydL5vBs80dTwJ2FyhsQGQfciYGUekJEw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version; b=GOBNnKVnpI+MCLBvh63O4Hf4h31TJRdLQJ0aueNsa0tXpM29t155PP/GIfftH6bSNqqHIbTp4U1L0LtUa8TielwwJmwXaqmBYjMFDeSPkTIPV6WBkL8NnLxSi63gXoMTnoTre/yYTKkdtT6Yl4XQxdg/N2zzG55iHhSwGR8aToY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Qb4Hr67c; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552I319R026868
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=vh5vuU4gYHriHVfXSN1MuWvUYrVCmyE8lRwp44VVj
	kU=; b=Qb4Hr67cprT5BFR2MZrgxgzheUC2zVsJ60aZcrqzPqXlWuB3zyl/+JYz+
	QdufZyr7sEADStEfICk4q6TR8zt/RCbnX5j3NxSowiKMhxcTg9Q2jB+nxzqZZwEt
	7daqARiK8BV0fpGShfQ3KRoYISqDART3QVKQJmok59sItpjhIiSPSL07eVO0whlk
	CDV5/eUrZ6+eQuc6jpJQkqE6e4kb+7K0EdHYgqwzHzf0Uxi0D/PaLOt5jsJam673
	CYLDYaloirfiYxclk64982hmH6g2tJzVATuDhxIIsJxfySBuzYMYmwc5D+c61MHG
	OU+vvZr0TSMU3x0pI968Tf0lUPk9w==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gw1sx1q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:47 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5530TZww024904
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:47 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470dkm8yck-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:47 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5533qkXB39191274
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:47 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BB4F058059
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:46 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8913E58055
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:46 +0000 (GMT)
Received: from localhost (unknown [9.61.177.224])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:46 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 0/4] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Mon,  2 Jun 2025 20:51:46 -0700
Message-ID: <20250603035243.402806-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAzMCBTYWx0ZWRfXxCCdEbC1H5fx Hpt2qrVs/rCc4DjMpiANkmjDdfSNlGLocbeA4AmHAoaJEAEL7NuDUsdvmfVHd76xl4eYRdPlrsu Sytc3BW7gtDWVHZh7JQ9QmCyuEa03Co4TJ6S1H8q2vGwDxTaltQFBgmMt4Y5bLcvahDnCO+UEx0
 dNfpQl2sQjkVgPpp9q/k5KYTJxPsYFelz1x58X5wKh4qrCgr9CxYV/eEoeYRHpuyqasZz6tmZV1 jwdxe9vCA/+iqXVIiamN5a5flI5mbc/P5PZ4rmb8zK43p/oXiANUJv71xRiEHPw8sR0Jndg7cup Cfkx8/yDwVcriEWhipT4YjE/JGByDv5LZgaIzbq6WDbOlwu22jZmA9mYihJgeJ1svzmgZ2usAop
 hrgM2EHBGIDtsAovVvDejdTWXAJAs5pK4AIraXf3zJEc3z+ZYobL7M3gZUgz+drn4A1ZCeyX
X-Proofpoint-ORIG-GUID: 2mFkRw4iAP2bmv6_2rzo0Nl-qXDO31y6
X-Authority-Analysis: v=2.4 cv=HcIUTjE8 c=1 sm=1 tr=0 ts=683e7190 cx=c_pps a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17 a=_9dExB9TU08cRdUV:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=x0SfsRj0LE_BUXfXMqQA:9
X-Proofpoint-GUID: 2mFkRw4iAP2bmv6_2rzo0Nl-qXDO31y6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 mlxlogscore=999 suspectscore=0 malwarescore=0
 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0 mlxscore=0
 adultscore=0 priorityscore=1501 classifier=spam authscore=0 authtc=n/a
 authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2505280000 definitions=main-2506030030

The current implementation of the arp monitor builds a list of vlan-tags by
following the chain of net_devices above the bond. See: bond_verify_device_path().
Unfortunately with some configurations this is not possible. One example is
when an ovs switch is configured above the bond.

This change extends the "arp_ip_target" parameter format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of gathering tags.
When provided the list of tags circumvents the process of gathering tags by
using the supplied list. An empty list can be provided to simply skip the the
process of gathering tags.

The new optional format for arp_ip_target is:
arp_ip_target=ipv4-address[vlan-tag\...],...

Examples:
arp_ip_target=10.0.0.1,10.0.0.2 (Determine tags automatically for both targets)
arp_ip_target=10.0.0.1[]        (Don't add any tags, don't gather tags)
arp_ip_target=10.0.0.1[100/200] (Don't gather tags, use supplied list of tags)
arp_ip_target=10.0.0.1,10.0.0.2[100] (add vlan 100 tag for 10.0.0.2.
                                      Gather tags for 10.0.0.1.)

This set of patches updates the arp_ip_target functionality.

This new functional is yet to be included to the ns_ip6_target feature.

The iprout2 package will also need to be updated with the following change:


diff --git a/ip/iplink_bond.c b/ip/iplink_bond.c
index 19af67d0..b599cbae 100644
--- a/ip/iplink_bond.c
+++ b/ip/iplink_bond.c
@@ -242,9 +242,7 @@ static int bond_parse_opt(struct link_util *lu, int argc, char **argv,
                                int i;
 
                                for (i = 0; target && i < BOND_MAX_ARP_TARGETS; i++) {
-                                       __u32 addr = get_addr32(target);
-
-                                       addattr32(n, 1024, i, addr);
+                                       addattrstrz(n, 1024, i, target);
                                        target = strtok(NULL, ",");
                                }
                                addattr_nest_end(n, nest);

Signed-off-by: David J Wilder <wilder@us.ibm.com>

David J Wilder (4):
  bonding: Adding struct bond_arp_target
  bonding: Extend arp_ip_target format to allow for a list of vlan tags.
  bonding: Selftest for the arp_ip_target parameter.
  bonding: Update to the bonding documentation.

 Documentation/networking/bonding.rst          |  11 +
 drivers/net/bonding/bond_main.c               |  72 ++++---
 drivers/net/bonding/bond_netlink.c            |  16 +-
 drivers/net/bonding/bond_options.c            |  71 ++++---
 drivers/net/bonding/bond_procfs.c             |   7 +-
 drivers/net/bonding/bond_sysfs.c              |   9 +-
 include/net/bond_options.h                    |  20 ++
 include/net/bonding.h                         | 161 ++++++++++++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 194 ++++++++++++++++++
 10 files changed, 484 insertions(+), 80 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.43.5


