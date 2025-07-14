Return-Path: <netdev+bounces-206896-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 97EA0B04B15
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 00:56:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DABE94A5091
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 22:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71C5327991C;
	Mon, 14 Jul 2025 22:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="YmtXM3xs"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF245279347
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 22:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752533759; cv=none; b=SYI88xrkYHLr2TBx7AxC3kyZ4yltAkdIQyEUzSVhVmMEoSrZf1Sou4HGaY0kTJ8fpUDbt6iLD5ROtWnMjGqFFJ9RPbE/31RI80jFXhPnEDXiF7UGip6UDNZBaQ1WojXi6klPR0LV+SML3Sr6tVpnvKUQysctKjLipjl5IMjHm+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752533759; c=relaxed/simple;
	bh=+vvvGQC8tr6WnlLMxtyD2vc0zZiPEokAFlul7GzREdc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qQWgkp9m68jQcz6svcg+FDnP40R7HONU2G5j50jfj32QP8tgZdXQwyrsmCoXguZCymalfdV5Y5ijh/Wjag2tbb5oS3HMolpcVaeSG9lSXOur7+XPOQ01McPvEzhtqNOVrFBufknaUkKsKg4sT3oAVOFZavs0LyelQC1C3/4xnFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=YmtXM3xs; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56ELbHGF004602;
	Mon, 14 Jul 2025 22:55:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=iPlcgZKUMnCeKKJhzuIKcMq5k3MxpKsoj5hdX4rbh
	Kk=; b=YmtXM3xs2pi/12uI39V7aLlnz1NEErtcyQhNkbSHrtooWHZek/qTzFVC/
	vyX8rFOwKBSjHJW0WuGDvRPF3wGtumulULSX1KrtEvURog3NlQOwUAdCa04iVUeL
	byf/jSSCuI0E5T5dsWzueUVkNEVYUKDpD7uh90BinRGkMCUfu0G8G5txtEtyAX5O
	gI930XkgY7DfvNo+EJx/RBHCrh44kZ9hRwqPApOXKO367+clwlfMeE7+Mr45tTc7
	9JdUO5tXRGysdOlGOPlePlvUvLlpKq1U5p4pc6UqJm8C906Znr7QfftkekbSVEcl
	CYc6/xsI77WQb01aQFoZ0iySmBpxQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc6uvcv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:46 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EJcY9P032738;
	Mon, 14 Jul 2025 22:55:45 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v48kyky8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 22:55:45 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com [10.39.53.232])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EMthK632768454
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 22:55:43 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 276B658059;
	Mon, 14 Jul 2025 22:55:43 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB7C858053;
	Mon, 14 Jul 2025 22:55:42 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 22:55:42 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v5 0/7] bonding: Extend arp_ip_target format to allow for a list of vlan tags.
Date: Mon, 14 Jul 2025 15:54:45 -0700
Message-ID: <20250714225533.1490032-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=68758af2 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=_9dExB9TU08cRdUV:21 a=Wb1JkmetP80A:10 a=VnNF1IyMAAAA:8 a=5ZApepXBbOjBgHogCoAA:9 a=zY0JdQc1-4EAyPf5TuXT:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfX3OKzMVzzxl3w YSQIupxFXJ9wcv2/cV3pDOL+OCFU/fyowXpD8n7EZz+m+DRUfYigfPlcN+PFoSs1rmg3U2HNjPT Pvr6BKocCWDqtbSsKGSA9vv/5fPTsNyIxJWddMQqvQZC4eEnzCJuDvj06I+pU4N0vAO1rJM+lf0
 MAcXqfJo1UW5+zFkyWygUeDiG3JSpU9Y0YMNIOUbm7md976GspBWFXWEL9RwaIq92FQuTaD3iky 8TqqgR9v3bXcA6ZccoWyBmo+RX2b0/qDGbNPxz4b9U+TOHvffjmLgyyb14BiAiMks9q38kUT8T8 F331nqurb+WIhc9+JTlSFdezsO2ciKd+Ud98gIZuaelMGGXmjw2Tb3w4TeStHKF+kWwyoy41LXS
 orgd1ZJvmE8sb74+RYOajdPgMshZAyeMVN3Xkt9zIZ2Eflgk4dwSgxG8c+T4vyAkfIxDxkoq
X-Proofpoint-GUID: pG1cEpPlruTK7x3GAgvgcUliwPShRHXX
X-Proofpoint-ORIG-GUID: pG1cEpPlruTK7x3GAgvgcUliwPShRHXX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140159

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
 drivers/net/bonding/bond_netlink.c            |  33 +++-
 drivers/net/bonding/bond_options.c            |  95 +++++++---
 drivers/net/bonding/bond_procfs.c             |   4 +-
 drivers/net/bonding/bond_sysfs.c              |   4 +-
 include/net/bond_options.h                    |  29 ++-
 include/net/bonding.h                         |  61 +++++-
 .../selftests/drivers/net/bonding/Makefile    |   3 +-
 .../drivers/net/bonding/bond-arp-ip-target.sh | 179 ++++++++++++++++++
 10 files changed, 393 insertions(+), 73 deletions(-)
 create mode 100755 tools/testing/selftests/drivers/net/bonding/bond-arp-ip-target.sh

-- 
2.43.5


