Return-Path: <netdev+bounces-189059-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11973AB02BE
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 20:30:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 885C05027E9
	for <lists+netdev@lfdr.de>; Thu,  8 May 2025 18:30:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36AF9217F26;
	Thu,  8 May 2025 18:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U+2b8Q73"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E88D433B3
	for <netdev@vger.kernel.org>; Thu,  8 May 2025 18:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746729055; cv=none; b=pUywxICfVjD3RCOaE3o+GnZM8eDXxF3Xi/Lz31HwswxyoTJx8e145jQ/NWGAQieRjBYyPt5Uslqi+3bc++d7tc7LQjq5lX1YQsFFHlmEUePFJOA1SCLynMtR7Y9Slx+G39rtqNF87uCFCIq6wE8RZAzsvCA0nN80ih/QTSZTm3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746729055; c=relaxed/simple;
	bh=VK2L2z5MTfVXCqNUjh48lhzQRTtp6uIdkhCQK+JFBOI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=j/h8WWjjOAZ2bab/1xJSBEbod++UXgxK0t6OQlHUacwQMDlYqaC2eRWfFX8cTYErdMBBoo/rs2eJFKEuwSvdtTZWM/klU53KgmUJ4nbUEQWEEbXmCWy4nziSNNjfcXL1Xq0T4Z+7oLabEVpBmJmxFwNw5R/JXACgfU+tgqib6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U+2b8Q73; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548IIwON000394;
	Thu, 8 May 2025 18:30:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=USjzX5ybBh1SdjOGicI8Oqb5QPHNTC7q/O6Onv01h
	n4=; b=U+2b8Q737eJ0BzJ1yej9JC7coVmOZsVE2NOeo//vX6W63SaQJPBbilPCc
	d6wENNcj1Kop9WuOqbdtQM6KxWqkiUOlbDoqELBlTl9xX+eKCSWMWncub0aFkvhb
	KGq7xluVjRZHERlAL/CsfA2EdT41KPzPFnnqu4slyXiO8IBBifEjGXN5jni4L9dl
	ZzlyX2zxOn7u9YG1VH6qNYtzC5uBvcU4Sr4fpK2RTXnu2ezSd8vbA+0P7Fx33EV6
	oPutz9DIb7zxeToVYg3ePcMjEsnUvbdH4dbd9TeZXr4BQ6A5nzC9Ddv3Flt/DIu8
	FgOJXUfbsCCW/jVOKxW4k9SCKXMEg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gf3kwbrd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 18:30:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548FZ6Lg013861;
	Thu, 8 May 2025 18:30:42 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 46e062prsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 May 2025 18:30:42 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 548IUd7030016000
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 May 2025 18:30:39 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7020958053;
	Thu,  8 May 2025 18:30:39 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2771B58043;
	Thu,  8 May 2025 18:30:39 +0000 (GMT)
Received: from localhost (unknown [9.61.84.219])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 May 2025 18:30:38 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v1 0/2] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Thu,  8 May 2025 11:29:27 -0700
Message-ID: <20250508183014.2554525-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HxLj02p855VokReWDkzXXZaK0vpTelXu
X-Proofpoint-GUID: HxLj02p855VokReWDkzXXZaK0vpTelXu
X-Authority-Analysis: v=2.4 cv=S/rZwJsP c=1 sm=1 tr=0 ts=681cf853 cx=c_pps a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17 a=_9dExB9TU08cRdUV:21 a=dt9VzEwgFbYA:10 a=OLL_FvSJAAAA:8 a=DmfIYXWFCepvYDxV7JYA:9 a=sGdGxwBg9nkA:10 a=GK_l4UeXyvsA:10
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDE2MSBTYWx0ZWRfX0XGKs4tQOglt klI4/HalpbB5scbKLAEOF5l4+1TdNe08kpbenYTLpWGaIBXtlcjNcY+7CcLpacb0DEi9UAOAfw4 dZ+6fozKP9PYLvq99q4sbNG40y7MbUS5Xk3CqHZxJM5Z7LKWQSO+uOB4Nd6hJCmrb186KSWH3t+
 xcJ1n9DIMD4o7m8GpLYqvW/BGnET0KrvA67lGncGJPSsJ6TZByP5QwWbY2oI16D6/FMFM5YIFNc hBzmAcCSlNhDkx3pc9wXEDPa5DgAmqFHMsCrPwJjwq3Efrn8Jrq/Qs4IuUaQ8mTsM/E6AdLh+PL f44e5mG6UrNdCWW8sDOjBXbgo5atWVMB8JsI5vrocCyF+/qJItlfGcUn6ztmYrsAztYLE/1rgvL
 VKmzArrp1iBfwJzCqc86019suINsQ/HO3UyO8Q0Rcovaz2B+i+vgl3OV1G6CBqTHNaqSuNS7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_05,2025-05-08_02,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 bulkscore=0 malwarescore=0 lowpriorityscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 suspectscore=0 phishscore=0
 clxscore=1015 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080161

This is a followup to this discussion:
  https://www.spinics.net/lists/netdev/msg1085428.html

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

The purposed new format for arp_ip_target is:
arp_ip_target=ipv4-address[vlan-tag\...],...

Examples:
arp_ip_target=10.0.0.1,10.0.0.2 (Determine tags automatically for both targets)
arp_ip_target=10.0.0.1[]        (Don't add any tags, don't gather tags)
arp_ip_target=10.0.0.1[100/200] (Don't gather tags, use supplied list of tags)
arp_ip_target=10.0.0.1,10.0.0.2[100] (add vlan 100 tag for 10.0.0.2.
                                      Gather tags for 10.0.0.1.)

This is a work in process. I am requesting feedback on my approach.
This patch allows the extended format only when setting arp_ip_target values with
modules parameters.

TBD: Add support for sysfs, netlink and procfs.
TBD: Kernel self tests.
TBD: Documentation.

David J Wilder (2):
  bonding: Adding struct arp_target
  bonding: Extend arp_ip_target format to allow for a list of vlan tags.

 drivers/net/bonding/bond_main.c    | 163 ++++++++++++++++++++++++-----
 drivers/net/bonding/bond_netlink.c |   4 +-
 drivers/net/bonding/bond_options.c |  18 ++--
 drivers/net/bonding/bond_procfs.c  |   4 +-
 drivers/net/bonding/bond_sysfs.c   |   4 +-
 include/net/bonding.h              |  15 ++-
 6 files changed, 161 insertions(+), 47 deletions(-)

-- 
2.43.5


