Return-Path: <netdev+bounces-206904-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EB2B04BAB
	for <lists+netdev@lfdr.de>; Tue, 15 Jul 2025 01:10:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 705021AA1CB4
	for <lists+netdev@lfdr.de>; Mon, 14 Jul 2025 23:10:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1A228B40A;
	Mon, 14 Jul 2025 23:06:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="f6Y51RNC"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B9428A1EE
	for <netdev@vger.kernel.org>; Mon, 14 Jul 2025 23:06:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752534392; cv=none; b=pjuzXkho302Kk9w5XiVYRp8tKHntFnoAS6rDtNnG1J3ALQ8qi+EJzJ3R1oxhYusX5ILJxX7h4c3G4DimNnZkW8wO9a4C8kToA19YynNDXJ7Y8npj9R+IYIxg27xMRkTa99OgFwwey48Of2BYCvRZujo+15QEgNEFxt43RU1lmHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752534392; c=relaxed/simple;
	bh=grwvdQDEd3JvXV7byrUiYe2oNAEZfb/QFyV560v2p+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RucJct+Iys4dSd4Oe98byqmmonpSFUTDrNU3/Q1zwJA4hvEciTZggU5bGybVm13M7x5TsTNaMzjsPhKA+Y2BVXjlB+fHqV8uCfgtOllliNYSx1kq66ZzyvGE2xxxGQ+qaD1zgVRZCtdK3Oqc54M21ac7Jwylk3c/CDb/pXCs3pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=f6Y51RNC; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56EG4XYt029124;
	Mon, 14 Jul 2025 23:06:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=9NeRnV2TjChgAOd+mvNVINPvHUd3XcE7rJZVwO37T
	uA=; b=f6Y51RNChCN72/5OGoE/mcJfP+kli2q2pUq+91SpyAGu8Ikt0jqdVHq5Z
	cdZwQV2vsH1GHASiXZajIfBqVfeoDf8xj+p5m8IaS3DryI05q2D9iXaJom63+6hZ
	vBENMSl4Bo85uGFmI5vRA4MLKa0Op488ExR3hZ7f/eKzSNc1sG6ODt2hcizXBBe5
	xAnUaF1jKSdsWW5vu60LPctjxy0hgjvWS3DNlHnqgNoLuEcGhyczRBja/IYVd0+p
	hm4MojGO9fNqAIamVnw7lifKGxKJ7fS9Q4EOyvLfWb4/EDCvm+P/CSQU7HE/6O0D
	HnuUXzU0xoF57Ipw05ro6znz8Mxeg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tv1g3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:06:23 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56EN6Msl008732;
	Mon, 14 Jul 2025 23:06:22 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ue4tv1fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:06:22 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56EMbnZd008180;
	Mon, 14 Jul 2025 23:06:21 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 47v2e0g1wu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 14 Jul 2025 23:06:21 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56EN6JO433817228
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 14 Jul 2025 23:06:19 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C9FE58063;
	Mon, 14 Jul 2025 23:06:19 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2A8B558062;
	Mon, 14 Jul 2025 23:06:19 +0000 (GMT)
Received: from localhost (unknown [9.61.28.64])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 14 Jul 2025 23:06:19 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v2 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Mon, 14 Jul 2025 16:05:39 -0700
Message-ID: <20250714230613.1492094-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=baBrUPPB c=1 sm=1 tr=0 ts=68758d6f cx=c_pps a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=VnNF1IyMAAAA:8 a=MdQn5gnp1V2VywMwy1AA:9 a=c3_ZXEU0JW4A:10 a=ymvSR0DJbCYA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-GUID: oMJJJzfxp8kJnx0WTZ-cinQrh_XGwDNy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE0MDE1OSBTYWx0ZWRfXy/5HmTR+cb4X 9FKe8VJJ/feboZpA9m6mGqXB07ApYKJNHYYPOOpX/j1TXG9Sy9qphTPfjj7uY8jTNbdiW6cIyNH loIbEgCedOqq6As/yfBms3GySJNoNaVzeLMswPjpt1ZDz47ttyDr/5TbBY667LZ8bwFWMWGIhUb
 htaJllHTDI3v544l1HS8ntTVzMwic2zxvEPHYaeDVTkwRCC9g9fCXk8inmpFtAP+E0BZrb07jL6 rD7pXvIwSfbWk0SQqluumG+aWlCtOjpBOhBc+CKEQe9BGLZvCFGylZ88qSTb+G02nMI1J5DOH3I cic8gQH/D+frCv8rlAx4HrU6gicLKmren1jHzduSV6z/1YBnXUSR9jppduZDgfXBuhje86icpGT
 j3pz23ZGWqMIqIuEChBVVMQ2uYRDfpik9QIAFN+4uplXzjRPAZJwz2vJFNr4HbfDLCVrbNxh
X-Proofpoint-ORIG-GUID: E-ycJnlwd5k28xfo1sFBK-y_vgc_Af6Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-07-14_02,2025-07-14_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=969
 suspectscore=0 adultscore=0 impostorscore=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1031 mlxscore=0
 malwarescore=0 spamscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507140159

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.  The new logic preserves both forward and backward compatibility with
the kernel and iproute2 versions.

Changes since V1:
Updates to support ip link show <bonding-device>.

This change is dependent on this bonding driver patch set:
<https://www.spinics.net/lists/netdev/msg1108095.html>

Merge only after the above patch set has been merged.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (1):
  iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.

 ip/iplink_bond.c | 117 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 108 insertions(+), 9 deletions(-)

-- 
2.43.5


