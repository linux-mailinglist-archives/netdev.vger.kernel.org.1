Return-Path: <netdev+bounces-219312-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CBA9B40F35
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 23:17:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53BC97011A2
	for <lists+netdev@lfdr.de>; Tue,  2 Sep 2025 21:17:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D8926FDB6;
	Tue,  2 Sep 2025 21:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="WpVnJmpv"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CAA226E716
	for <netdev@vger.kernel.org>; Tue,  2 Sep 2025 21:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756847850; cv=none; b=t5Z/8nARHhRh7w+5SHyikP7HgCas89UdIDe5Z7TTCOHOgOw7KjlDUOYtR6VFbXAI9tyiCyBSYlbZ9x0coSWbKIXglrAor+PIYCyBdWHQvtiFmH327OF7huOBtk4UExhcyC5oFLVRhz5rNTOkzA0kQMdre6tRyVO4ZE/c9bDjzaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756847850; c=relaxed/simple;
	bh=H03yuUjC15ZWrbRBHfh109DgdMsRFONB8zOcN1dFaVs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XtX9xTu13utPJlCIZByyDx5i4ujiw/ROh+J/aDN/9+KIokEpyYUBx0/0xdGUCFsw2qNOfiv57kGuaDv8YqVJZLF4vb5ilst1tyPW3gS5y/OGWrdvnjQglwH5RBNuDZy4vWA9JKAfOcNbC+aTF3SHGegUAWQdXpfpCAikRIdvUTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=WpVnJmpv; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 582Kercu012012;
	Tue, 2 Sep 2025 21:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=n0zU96rAELgZJEDWzRt1H1PvqZEyOoVNBtzqnm8Iz
	No=; b=WpVnJmpvZPAu5WiiTSjAk8bqe7RVspCU1/HaIvLu4NA40ve55RRK/ubIm
	eIgsDUcett76G+21Qq2W3xjXDXNqmd8IZ6p89VVRaIAwmOSYIrx/+fXzc7LtjcKD
	Ma65ayakEwkv7K51geaQQDHkM8qFDqee+42Ftaj9Nd7TMH0CveOpWCAy2L+YjJpi
	/rsQ0TKBS7h/7hd/lB6cE5qJzP5+tyMmOJQqRFeaz/AjH7lYys7YPEwVmPemGG0F
	mtAS/Ew17MjIphAGZOuXTYZbFyrsO1WCXlvoWUG6lZ49GnGZ2h7mgfYj7zHL5LYS
	JzDnp7dnJbsliRrWo4iVhTJMo1O9g==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur0rsj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 21:17:19 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 582LE9hT024837;
	Tue, 2 Sep 2025 21:17:18 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48usur0rsh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 21:17:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 582KEXx3021222;
	Tue, 2 Sep 2025 21:17:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 48vcmpmfba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Sep 2025 21:17:17 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com [10.241.53.105])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 582LHEL74392154
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 2 Sep 2025 21:17:14 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9C7D658055;
	Tue,  2 Sep 2025 21:17:14 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4A23258043;
	Tue,  2 Sep 2025 21:17:14 +0000 (GMT)
Received: from localhost (unknown [9.61.19.179])
	by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  2 Sep 2025 21:17:14 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v5 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Tue,  2 Sep 2025 14:15:51 -0700
Message-ID: <20250902211705.2335007-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODMwMDAzMCBTYWx0ZWRfXyXHJnuZhybpI
 8Q2O+C1WSoQEGDipnRxkYhE5YUevJH63n9pL19eSQdS8C/PYmE5Berp3v6HQoXol9A7QV1MaF1Z
 ji3LaDrPl43XyHXfVl+yH3eVpfIGUr0cXgnrJhI3akYgroS51aNAgsqwuI/aOyYnSbASvW4Gmqr
 vEOTxn7i1zE99CfmEX2rRHMZrP31fIpKCCu5Ho6+aJcVJeU/zq5Whf04PKzRbAIGsMPQ+aF9HQV
 msIkpfp0Aufk4cETs11Ewnyf1XbTD9/D3rX+b/3TD0AbgixuAZFlPYiIT6PgNnwkM+uOTVGy7yw
 CTTopQaZCp7QLy0Dz4Fbdj/NRxRbGov3T7pzN81HdS7lNRRVOeHirUWsMh6IWHwvhWvwbdcR9Rg
 E15TvwOg
X-Proofpoint-GUID: gj0wHFIZvQf6-XCrbuUh18wn84UP1rm6
X-Proofpoint-ORIG-GUID: uMnmKv_hVB-WTYLdhPt85klfGJKoR1ns
X-Authority-Analysis: v=2.4 cv=Ao/u3P9P c=1 sm=1 tr=0 ts=68b75edf cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=yJojWOMRYYMA:10 a=gu6fZOg2AAAA:8 a=VnNF1IyMAAAA:8 a=3W-dOLmQAvCEGWDQBbAA:9
 a=zY0JdQc1-4EAyPf5TuXT:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-02_06,2025-08-28_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 phishscore=0 impostorscore=0 priorityscore=1501 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 malwarescore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508300030

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.  The new logic preserves both forward and backward compatibility with
the kernel and iproute2 versions.

Changes since V4
Changed unneeded print_color_string() to print_string(). Thanks Steve.

Change since V3:
Add __attribute__((packed)) to struct definition
to ensure size calculation is correct for memcpy() and
addattr_l().

Input: arp_ip_target 10.0.0.1[10/20],10.0.0.2[10/20])
Sample JSON output:
...
"arp_ip_target": [
 "10.0.0.1[10/20]",
 "10.0.0.2[10/20]"
],
...

Changes since V2: (bond_print_opt() only)
Based on suggestions from Stephen Hemminger.
1) Removed inline from bond_vlan_tags_parse().
2) Switched to print_color_string() from print_string()
3) Follow kernel style.
4) Fixed JSON output.


Changes since V1:
Updates to support ip link show <bonding-device>.

This change is dependent on this bonding driver patch set:
https://marc.info/?l=linux-netdev&m=175684731919992&w=2

Merge only after the above patch set has been merged.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (1):
  iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.

 ip/iplink_bond.c | 125 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 115 insertions(+), 10 deletions(-)

-- 
2.50.1


