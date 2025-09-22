Return-Path: <netdev+bounces-225411-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 370ADB937DF
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 00:37:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6E16B444871
	for <lists+netdev@lfdr.de>; Mon, 22 Sep 2025 22:37:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9CA0C27A906;
	Mon, 22 Sep 2025 22:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Ot8Axgfx"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69CA19A288
	for <netdev@vger.kernel.org>; Mon, 22 Sep 2025 22:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758580639; cv=none; b=u5zRwNTbv5b0hHxKxsv3uWraM2eX4wgxf2E6sg62QznbyjN7073LTBpxkrw0jyIM8NB8TIAJwhmqzkjFrCUBY9iJhRrGKJZNCSTB6/fyTEiV5ezYoa95Ares2fP+7zddtNBL08bgeBWOXZqNfr3YzAk3pFS2xsDsail/NgWmsU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758580639; c=relaxed/simple;
	bh=daQB+jn26DIxOJN3O5sxbnitYQSC1yNgxeq4S9MoSC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PqNlQCK2yNo+Qp5SwTrkuQbdtsZ3LaoTnx1/gz4cpdBGq12yOFAQ7GR+RMRN/ZjH+WkFhtKTm8ip5YCvcxrdiX8ozfKC2i5CXiXtCu5R0UiSe5swzSPvuMXagCvP+yC4EJ+TGqSYO605ZqMvNPuLHVt9zWaiNEuNSuNZHUQIPhU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Ot8Axgfx; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58MILXh5027350;
	Mon, 22 Sep 2025 22:37:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=bqOy9VPeyKs/ukj93Q4tpEVSN3BRY/AkxjbmeQ7bx
	us=; b=Ot8AxgfxXs4CrpdhUvMCazpwXKQbGDtoaH3duztHmNqMNnsat7ImqDzYE
	unu5QNgQRCzgFzp4CtquSe1HIAPACU39/5NQQNfHf/4/0Xh+ywH/hQNoDiVXro3T
	l8P4yoGU0V4Mb0yH2nEkmpLCvh1bBVChVHy43QVM/pT2I2wW6pby4GTpELCE/d03
	sxiU+K3VbDzG+zko8zFiBScc5vIsTjRneLVuj/U/FhnAn69cI1b3fKBlA82iiBUm
	1Zkl8Vpd0wkp0YRc3LIsd5AJE/sEAU7aY2Py8CYDWoN2yA1/rUZbUUXO2Cc5Z7k5
	aIw4mJDFZQcShfF/jY2Q8aKNj99qw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyd3tb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 22:37:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 58MMb1EV030073;
	Mon, 22 Sep 2025 22:37:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 499kwyd3t9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 22:37:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 58ML1nUe019671;
	Mon, 22 Sep 2025 22:37:00 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49a83k092k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 22 Sep 2025 22:37:00 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 58MMawhl31130326
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Sep 2025 22:36:58 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21EBE58054;
	Mon, 22 Sep 2025 22:36:58 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D49D05804E;
	Mon, 22 Sep 2025 22:36:57 +0000 (GMT)
Received: from localhost (unknown [9.61.77.150])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 22 Sep 2025 22:36:57 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v6 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Mon, 22 Sep 2025 15:35:10 -0700
Message-ID: <20250922223640.2170084-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=J5Cq7BnS c=1 sm=1 tr=0 ts=68d1cf8e cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=yJojWOMRYYMA:10 a=gu6fZOg2AAAA:8 a=VnNF1IyMAAAA:8 a=RNaQjXq8lTWM3Ygt9oIA:9
 a=zY0JdQc1-4EAyPf5TuXT:22 a=2RSlZUUhi9gRBrsHwhhZ:22
X-Proofpoint-GUID: UoZ-jiaEqPmfnyIl5WRzWueQCFcApvZm
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTIwMDAxNSBTYWx0ZWRfX2FxzGv3XHvbE
 OU+BCR17mJdI2xjW1Y8tE/4ED3wj+c1ZXfTK/5+dSrbM47UxQexqwoxWq+Jr+vU1tK9Dj+x55LO
 dAMQEivr14EP1+wQyHR/bR/2sEpfZqB562d/nbxq2a9LF57XzHPnuKIvdKJvVJig4mG6FHfWDqx
 esZqXKDFnInMYY9CXSkKEk5fCbH8gz1/po6KTdPZln0HikyLYaeWYd78FLzzXLJD4zmpyecbWO4
 Lz+tJyhBKhRqdbcQ5Kb0YUQ4uK7twoMAg1fdzpGCffglUwB8HqWsogTnhxcuxERItGfKKRvHGdJ
 zJG8L0cB3Bcp+DZVvXfVosag4XOpewfFw8C2R8gfwt13TjtkL84zbROJfZhFVzoLOSZSDQZZrpe
 yKHw/LrR
X-Proofpoint-ORIG-GUID: xq6urgV2YrB1QGEQ6QY34zsTVwKkwmuP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-22_04,2025-09-22_05,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0 bulkscore=0
 phishscore=0 clxscore=1031 adultscore=0 suspectscore=0 classifier=typeunknown
 authscore=0 authtc= authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2509200015

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.  The new logic preserves both forward and backward compatibility with
the kernel and iproute2 versions.

Changes since V5
Thanks to Stephen Hemminger for help on these changes:
- Use array for vlans
- Removed use of packed and Capitalization
- fix incorrect use of color
- Removed temporary string buffer.
- make vlan print a function for likely future IPv6 usage.

Output for "ip -d --json <bond-name>" has been updated. Example:
"arp_ip_target":["addr":"10.0.0.1","vlan":[4080,4081,4082,4083,4084]],

- changes to error reporting in bond_vlan_tags_parse() for invalid vlan_ids.

Changes since V4
Changed unneeded print_color_string() to print_string(). Thanks Steve.

Change since V3:
1) Add __attribute__((packed)) to struct definition
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

 ip/iplink_bond.c | 146 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 120 insertions(+), 26 deletions(-)

-- 
2.50.1


