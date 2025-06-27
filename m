Return-Path: <netdev+bounces-202032-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 19285AEC0C4
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:19:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D9BEB3AAD43
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:19:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4440321578F;
	Fri, 27 Jun 2025 20:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="CVacth8A"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B37CB1FE455
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055586; cv=none; b=CZ79AF9FHU4cfH8f+JBlAJPQ65UZaGfPOoesTI3C0uWp1FqnZaQinJAY7QVLCFFiHYpXX+RF69MSwu+aNyAMv3bJruDvTVJKB+idJk6nTaTe2+yun3f9DMoX2MFFG9qdoWdUM7ZKX+hqsfZmD6M5UNYJpQ4dGxiZLb9yaDSZIls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055586; c=relaxed/simple;
	bh=sELqKvE2C/19Ej2MYJfDSBHLsfjspUOugk7jSetD5m0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WFcBK5VpbFbIv9ylroqwI3Glk24KbH5epXTME0PZBFNGfGeA9uXuIJ5YUmnotbi3Y+kJH0oK4fIuc8QrmvEbTRQeys+ZkSH6pDcnSe5bB8l1sGekMQb+Tm/CFuBY3Ig3bq7K628YJoHM6H0VkO7IbVMCLYEuRdGsE2VspsjFPzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=CVacth8A; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RJh1PV015796;
	Fri, 27 Jun 2025 20:19:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=FkHBCFq4tajGZH8ZEBmfLDsaPcp805gaaenU8SRTk
	4Y=; b=CVacth8AAGY2EmLbPiiNWB+/N47o6l66S0i0oomZCW2TNjlXTKh3qkpUE
	gwS3iGeUlrONxe24HB3pFSFZwI28o94oO46Fjug3EFzvjhTKHBsXTwWaNPMFs/U3
	ZBC+/1rdKz9Qjh3QcwVpAby66znd1yYcy9rQfqo8UEE4YIw9lk0UL0R9hdlRarx7
	JFspMWNavJ7X0nCPhZzUg2ARUTwH3rxAIveh17tRdhbshN3/PnFffVZOtx8oNZpG
	+VXWJBmomskXizbuFiTjOkX//Kr585w8RQp860sXha5MpojXaU7+ekQYG8aLHEB8
	0Rc+JH91G9WIYZm9WGwmOx9JLJfMQ==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47dm8jyu3w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:37 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RKCrHw006414;
	Fri, 27 Jun 2025 20:19:35 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47e82pny9b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:19:35 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKJXcq4588254
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:19:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8BF975805D;
	Fri, 27 Jun 2025 20:19:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5E05D58043;
	Fri, 27 Jun 2025 20:19:33 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:19:33 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v4 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Fri, 27 Jun 2025 13:17:13 -0700
Message-ID: <20250627201914.1791186-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfX76/jfICGq+95 A2Qg+oMYuP0Id64b2Ilx8rXw5RDBjlFhSZgUhlIsuPzf+HpabamavYBKnqeu87OIg/Ctyujwhmq hXramSwWdnzTzlK0Q1Y6p/UR4O+NgYwMdZ6HnUQrSmXOdRcxhJKIScCW2z0wEGxOilJtHEcXOBO
 L8MQurk7tXoZoFcLU4gJKS0iDUE1UVg02uwANTCghQ6fBW6ymkC828gOyCfoq7aO+7APuxA/7E4 npI4LAdpYbCrjRYeA9ziE/VRV7NVX801NitN4Vt78KjVYgcaaf8fmMyhPPDY5q7QsW/QltR+XTR O8Ug2cl4hPiOqQ4tp7diLnNm9PeemWPuVeOaW43jQd4AbSk7hPrzL85JIWDFjJypvps19oZEbjD
 iXf8E+wj+/23ODwxrExruexNfovh8WEM1OvoR46QafFjP+fcMRlfIH0QV12KtFVf1v+UMWpl
X-Proofpoint-GUID: eBjsAEy4FcPye-T_ECNNUQsiKA5DGjOI
X-Proofpoint-ORIG-GUID: eBjsAEy4FcPye-T_ECNNUQsiKA5DGjOI
X-Authority-Analysis: v=2.4 cv=combk04i c=1 sm=1 tr=0 ts=685efcd9 cx=c_pps a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17 a=_9dExB9TU08cRdUV:21 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=m26nBx2qpUGDVhJa_tEA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 spamscore=0 adultscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 mlxscore=0 phishscore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

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

The extended format of arp_ip_target is only supported by using the ip command when
creating the bond. Module parameters and the sysfs file do not allow the use of the
extended format.

Changes since V3:

1) Moved the parsing of the extended arp_ip_target out of the kernel and into
   userspace (ip command). A separate patch to iproute2 to follow shortly.
2) Split up the patch set to make review easier.
--

I have run into issues with the ns_ip6_target feature.  I am unable to get
the existing code to function with vlans. Therefor I am unable to support
A this change for ns_ip6_target.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (7):
  bonding: Adding struct bond_arp_target
  bonding: Adding extra_len field to struct bond_opt_value.
  bonding: arp_ip_target helpers.
  bonding: Processing extended arp_ip_target from user space.
  bonding: Update to bond_arp_send_all() to use supplied vlan tags
  bonding: Update to bond's sysfs and procfs for extended arp_ip_target
    format.
  bonding: Selftest and documentation for the arp_ip_target parameter.

 Documentation/networking/bonding.rst          |  11 +
 drivers/net/bonding/bond_main.c               |  47 +++--
 drivers/net/bonding/bond_netlink.c            |   9 +-
 drivers/net/bonding/bond_options.c            |  95 ++++++---
 drivers/net/bonding/bond_procfs.c             |   7 +-
 drivers/net/bonding/bond_sysfs.c              |   9 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  60 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 194 ++++++++++++++++++
 10 files changed, 390 insertions(+), 74 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.43.5


