Return-Path: <netdev+bounces-212656-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8673AB2196F
	for <lists+netdev@lfdr.de>; Tue, 12 Aug 2025 01:33:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33F8D18873F0
	for <lists+netdev@lfdr.de>; Mon, 11 Aug 2025 23:33:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A88927AC31;
	Mon, 11 Aug 2025 23:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="pYNYh42x"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C494F27A455
	for <netdev@vger.kernel.org>; Mon, 11 Aug 2025 23:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754954971; cv=none; b=rhuN9DGZzIj472ni/t4TH4c4Z0dhAXw+zmPI077oCHO9wH3BqAapVpw6oHsahf+IcaBsWfqJl+J5zMxYjgRMGlXdq4OEO5ytwp/pKbShmevPIpxFlilnOlz1hM/7xd+6XlvZIsVm/0CDkQNKlHg5sJqdaWmufuLpDB/KNGyFXDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754954971; c=relaxed/simple;
	bh=2AzZiqDamBnoCGRx9JNwoyOD+AkTgtlB4tq8iWxmdaw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YhxDwXO+tRufdTG6GatSnRIwyK4Cf9KQm37EqwZCpNlgjVgem2Xk5yhDeEQwt3nkb4FQPWVEv/Mz7qXXR+IPr/zSglpfuLomwS0iPLFiZr/ofIVJYad5HJUh2m/gEowpidV+aYd4INWQs/nOVKrN5ThouN8DE6qaA/WcpYtMgqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=pYNYh42x; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57BDAwks018804;
	Mon, 11 Aug 2025 23:29:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=Lb1AEDEBZc0TA3njmWeRUC/m/BIPQVaSlr8mdOwKU
	sU=; b=pYNYh42xTvnDfI9k+eSCvO5LAh6/NzJoNYBSNB+8ITN+WqkpxHsDXkhsX
	ebS7ekZ1UqesG+ilC7L8Nc0985YA7PQynayJKQQqyvMWZEYt7m5gRqHmILcRsgCS
	CE+6/FS57xVwXsbCfSHCVMO5bT2bw+qdZvDNCpawWEh5UG8PiMTeVFbPkxkDZBDl
	HpKQW+lMDKPVqe5wKyCaFsFIdbn8/AMOQjm8PKs4MZJOOrqWNijY8++9exwpTheH
	RORkNMkkjQXDQnAIf9b+ZQ8hF+w6Rvm0AD35BsfIbDu5BvZGTE5ElUZ2GoP3C0wj
	mmOsSw4TNyCVaBf9D1giVfH7P72BQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9yy0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:29:21 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 57BNTKH0010017;
	Mon, 11 Aug 2025 23:29:20 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 48eha9yy0r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:29:20 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 57BKgIAI017581;
	Mon, 11 Aug 2025 23:29:20 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 48ekc3fma9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Aug 2025 23:29:20 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 57BNTH3X30409308
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 11 Aug 2025 23:29:17 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 61B6058056;
	Mon, 11 Aug 2025 23:29:17 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2E46058052;
	Mon, 11 Aug 2025 23:29:17 +0000 (GMT)
Received: from localhost (unknown [9.61.174.150])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 11 Aug 2025 23:29:17 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v4 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Mon, 11 Aug 2025 16:28:17 -0700
Message-ID: <20250811232857.1831486-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KPRaDEFo c=1 sm=1 tr=0 ts=689a7cd1 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=2OwXVqhp2XgA:10 a=OLL_FvSJAAAA:8 a=VnNF1IyMAAAA:8 a=RNaQjXq8lTWM3Ygt9oIA:9
 a=0aDvxedHzIIA:10 a=CXBIAlbQQvwA:10 a=zY0JdQc1-4EAyPf5TuXT:22
 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-ORIG-GUID: Iks0TsL2MP6dEf2wnvCJb-1hS_ybs_x8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODExMDE3MCBTYWx0ZWRfX0rKf4K1xDWXT
 C20jfO3swGXgDHPV5BSA3vcj8/dTRql/48w/jfpEc+aikvqExBDcFVlOYzrINTqQ1CIBGbO0JnH
 oepZip5jDS422d0syT0dpj/Aqso4hMFOVkr4VAn5uDHDTfmg9rXAN8EGtH7Nf/UJrlujElCaXii
 2N4J803H4o9gjw6oJYLFxTjeY/FCeXyH557IzJTaMnxwxfw+xAHs9JRac5IxyUnJOc9KJ1n3bpf
 o5eWxBTeYC8tgoQ8pXRvdVl5A+h6arqLIKI+PQVXgIkn4PZYvAj419nAfe6aGVIl0WmnaaSgtLv
 BZInjvdDlrazZ8Wiz2J2m+AtMx2mGa/3HcOi6WfzjcI4wjDna3UKJIsNW74wPXenYZsp4lWs0RE
 wTiWzD6JPgoLQMnPn8Y2y4EkI1XtXA8cM0L1+aJWmYCQfttSyty8EEu/witTA2+p0tz0R+wD
X-Proofpoint-GUID: kF9G5memwcE0XlvrsicNwREGTWm6l5Vi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-11_05,2025-08-11_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 bulkscore=0 mlxlogscore=999 spamscore=0
 clxscore=1031 adultscore=0 priorityscore=1501 malwarescore=0
 lowpriorityscore=0 mlxscore=0 suspectscore=0 classifier=spam authscore=0
 authtc=n/a authcc= route=outbound adjust=0 reason=mlx scancount=1
 engine=8.19.0-2507300000 definitions=main-2508110170

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

This change is dependent on this bonding driver patch set:
<https://www.spinics.net/lists/netdev/msg1113845.html>

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (1):
  iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.

 ip/iplink_bond.c | 127 +++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 116 insertions(+), 11 deletions(-)

-- 
2.50.1


