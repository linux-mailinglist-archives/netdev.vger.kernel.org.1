Return-Path: <netdev+bounces-208256-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDFE5B0ABB0
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 23:37:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 126693B5202
	for <lists+netdev@lfdr.de>; Fri, 18 Jul 2025 21:37:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A23321FF4A;
	Fri, 18 Jul 2025 21:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="ic0IlxGN"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7685B21CA0C
	for <netdev@vger.kernel.org>; Fri, 18 Jul 2025 21:36:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752874584; cv=none; b=W9zj2igiHLDXz407lbQ4G4/PTllUy8fxMPP2rDYjmhU4J+GI8MBpbEs9MojBRxUeQaBtGmVLRgoVwbNhJmhvL0Gdjm3Qb0cjxRrQPBz/b0PiF5XJfgC2BWb+wg2y+HJsdJ1Tm8AGDA1bvMMoEORf55raALY3XVHHwJRNFhZc8dw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752874584; c=relaxed/simple;
	bh=k7XigeBkwWALVVnnCFmveDBIjhjokltQzKbzDldkLDE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XdaTkAQKYMVfHXzUgG+xwbT/WlRcRTdlUsvY2sbOcIDPNdQUNuZnTZYeWc+EaRpEUxZxPCmlyUTvn+lJOYPsH5VMjqClL5PEKfBuxKLPDa/R95IgjtHIWbZDhiBB5JhhCc/TyL/7rEWSkuS/bksit71wEah+PdOjqdIM/7UZLkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=ic0IlxGN; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 56IL0kKE004602;
	Fri, 18 Jul 2025 21:36:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=1k17fQb+rTCB7OGNMho9o/1QtFzUoA9jNvnw5Elij
	JQ=; b=ic0IlxGNxAO86yBlpeKHXei71Tdj28SHdzX1fVf7soSL0LKVftGkXl3Yd
	godWCy/m7tZKIkQ0wmuUThOxvRxJ8jUB2EWMOrJtPkh1bBpM3UsXAcGqgHwlkPJj
	+e97LpcpKk3AoxUdcRiMBozLO8wngCugaUfX6II+gM6/rQtIoDrbzGq1guPbKh41
	xsRtmbajriytPm9H8KMB0nkET9Gvv13dom3+Kiy9M74WlRAfRBSbYZQZZc3Ac5lA
	SQPZykp7NDBbTgziMGqxpLA7AmWADpGlqtmabs8aJyPzZmShSmfsDPLWY8kN0cc6
	x6Ot20RH8sRP076EvYuHWpmY2kJSQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7k8w1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:36:14 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 56ILaEIi023268;
	Fri, 18 Jul 2025 21:36:14 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47ufc7k8w0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:36:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 56IHkNeB031904;
	Fri, 18 Jul 2025 21:36:13 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47v21ukc4y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Jul 2025 21:36:13 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 56ILaC2s31261246
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Jul 2025 21:36:12 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E95A158054;
	Fri, 18 Jul 2025 21:36:11 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A961A5803F;
	Fri, 18 Jul 2025 21:36:11 +0000 (GMT)
Received: from localhost (unknown [9.61.165.151])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Jul 2025 21:36:11 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v3 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Fri, 18 Jul 2025 14:34:53 -0700
Message-ID: <20250718213606.1970470-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Je68rVKV c=1 sm=1 tr=0 ts=687abe4f cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=Wb1JkmetP80A:10 a=OLL_FvSJAAAA:8 a=VnNF1IyMAAAA:8 a=oVP8NikHpuCn6rvPd-QA:9 a=p55mOFvggx8A:10 a=yFz1PgGgZpsA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNzE4MDE3MyBTYWx0ZWRfXzdJDvyRRbeSR cBrM4YwwphJBVxlt6kDWRU09awLz6UAtmE5+AA2KXtTapkBS8Cli80L7pD131l9KILU7pYGXuUz dUR3Uu2YlF4eJHcNMvdwUVpbe6fbth9jGvSeo9p2De6rUY4L70oLWKDV/tMMViXNEG1slb90Efo
 bkV3VLrMnF/zyeoXlx4WhA2byHJI3nNZb/KSc271ohIGMVaEO20RgXp4TlbPf/MVnbSSbGgBSxO 3QzrVJtudOb6etIfUjHnKPL/zMk8LxTBLcqjCj78vhTAe4AvetTSsNO0nQPo/PMBB3Xs+dpBg5S ieJ7wuMBlHioFvcFm+/LXu1qSHj+49sr4l0B8Don09WZ66n8Thx4rkVH3TWOm6YvniWZhDZCyTM
 XJ4nps2rkVDgm11Ep1ohuXWudlzTad0a/Z03Pnm1USQt/CgHe3wpuPnvbB3SosJ5iSVQAQ5f
X-Proofpoint-GUID: jxKJec0WP-jovgVp3pvfpM-Dmir4Rlej
X-Proofpoint-ORIG-GUID: Rqc4kLqPbjSZWGC0svkS2gw7PzTtaaXJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-07-18_05,2025-07-17_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 clxscore=1031 bulkscore=0 phishscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2507180173

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.  The new logic preserves both forward and backward compatibility with
the kernel and iproute2 versions.

Changes since V1:
Updates to support ip link show <bonding-device>.

Changes since V2: (bond_print_opt() only)
Based on suggestions from Stephen Hemminger.
1) Removed inline from bond_vlan_tags_parse().
2) Switched to print_color_string() from print_string()
3) Follow kernel style.
4) Fixed JSON output.

Input: arp_ip_target 10.0.0.1[10/20],10.0.0.2[10/20])
Sample JSON output:
...
"arp_ip_target": [
 "10.0.0.1[10/20]",
 "10.0.0.2[10/20]"
],
...

I tested "link add bond0 type bond arp_ip_target $test", "ip link show $bond"
and "ip --json link show $bond" for the following values and verified
expected results.

10.0.0.1 # No tag
10.0.0.1[] # empty tag
10.0.0.1[10] # valid tags
10.0.0.1[10/20] 
10.0.0.1[100/150] 
10.0.0.1[10/20/30/40/50] # BOND_MAX_VLAN_TAGS
10.0.0.1[10/20/30/40/50/60] # > BOND_MAX_VLAN_TAGS
10.0.0.1,10.0.0.2 # multiple targets
10.0.0.1[],10.0.0.2 
10.0.0.1[10/20],10.0.0.2[10/20]
10.0.0.1,10.0.0.2,10.0.0.3,10.0.0.4,10.0.0.5,\  # BOND_MAX_ARP_TARGETS
10.0.0.6,10.0.0.7,10.0.0.8,10.0.0.9,10.0.0.10,\
10.0.0.11,10.0.0.12,10.0.0.13,10.0.0.14,10.0.0.15,\
10.0.0.16 

10.0.0.1[],10.0.0.2[],10.0.0.3[],10.0.0.4[],10.0.0.5[],\ 
10.0.0.6[],10.0.0.7[],10.0.0.8[],10.0.0.9[],10.0.0.10[],\
10.0.0.11[],10.0.0.12[],10.0.0.13[],10.0.0.14[],10.0.0.15[],\
10.0.0.16[]

10.0.0.1,10.0.0.2,10.0.0.3,10.0.0.4,10.0.0.5,\ # > BOND_MAX_ARP_TARGETS
10.0.0.6,10.0.0.7,10.0.0.8,10.0.0.9,10.0.0.10,\
10.0.0.11,10.0.0.12,10.0.0.13,10.0.0.14,10.0.0.15,\
10.0.0.16,10.0.0.17 

# Bad input
10.0.0 \
bad-address \
10.0.0.1[ \
10.0.0.1[10/ \
10.0.0.1 10/20


This change is dependent on this bonding driver patch set:
<https://www.spinics.net/lists/netdev/msg1109449.html>

Merge only after the above patch set has been merged.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (1):
  iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.

 ip/iplink_bond.c | 127 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 11 deletions(-)

-- 
2.43.5


