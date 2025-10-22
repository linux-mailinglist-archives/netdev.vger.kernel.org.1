Return-Path: <netdev+bounces-231842-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5195EBFDDB3
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 20:30:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF6FF1A066F9
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 18:31:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6B55347FF1;
	Wed, 22 Oct 2025 18:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="khG4IcmL"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 113BF1E832A
	for <netdev@vger.kernel.org>; Wed, 22 Oct 2025 18:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761157778; cv=none; b=WKZz1sHButqUvE34ysLumKIhf7TdU8mMlN2+SurbXp38+PWFL2nlKXBDtGkqQCFd4pDtSKznsAStPL2WtiYCFcciIQI8s3cz80tZi7HE8/C8r9+aB/IOlcVSzyhdChP5+bZQi9myK5S82KB9r17LDs8eSLJ8U2005nR4mzLE2LE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761157778; c=relaxed/simple;
	bh=nhGsrDx0wzJs0qO5eiN7ONxuisI3kUnBGKaJn2hVszc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RFXspXjLodJTe+3gd3P1B9Q6HfHYczUy5SqzFYnSfo0pmLf8/GAfHuqIIiJ8VdQf1yFEsiVvmMrOn3pH4A+iAHWK7AaDkb5tO7tadEM9MyLi+8N08GoLMoxRgzN/m4PBCStcuTSmp11vwtf7OQ8TuzwUk9LS2MvURI7rSwra4TQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=khG4IcmL; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59MHatgZ010978;
	Wed, 22 Oct 2025 18:29:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=OmSAPFQ/nRHT9H/LAnW1/BLKJnA7L0n3qt2RTmQgd
	DE=; b=khG4IcmLnV1rZmGUw/Tw9AVyKZn/sBimZ9qUZymM8wKerx7Tl1Ih+uLBK
	MvTvUOeO2qsBBghRgbmIS7W5pNjIU0rU8nsyopmMiyniAH++kPG3k5Dp5ZQzCVJ6
	WOW+agsnRmB5IkWCqF7Q19w23OOl6dU3RE6JppVVui1PSvo8JyrVDrF/C/M8HbxP
	LUUA2eGxtRKqU7I21N0s2/gzdqXb1uH74pnwEPjmZD3cgqU5o03FSW6d6dMiZQY3
	7liJ3pWMDYRqzdW9Yqx1oR30isCAO4wDPe2Cd3bW8r3S5D6DW5FyRd5JvW5IE7WZ
	k8bEkG5/clEHkCUcok+xOvFiaCKew==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33feeg3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:29:29 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59MIQlWY008085;
	Wed, 22 Oct 2025 18:29:29 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49v33feeg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:29:29 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59MH0HXl017117;
	Wed, 22 Oct 2025 18:29:27 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49vnky211c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Oct 2025 18:29:27 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59MITP0M31588950
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Oct 2025 18:29:25 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 21E4958054;
	Wed, 22 Oct 2025 18:29:25 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C8EFB5805F;
	Wed, 22 Oct 2025 18:29:24 +0000 (GMT)
Received: from localhost (unknown [9.61.190.208])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 22 Oct 2025 18:29:24 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v8 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Wed, 22 Oct 2025 11:28:44 -0700
Message-ID: <20251022182915.2568814-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=FMYWBuos c=1 sm=1 tr=0 ts=68f92289 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gu6fZOg2AAAA:8 a=VnNF1IyMAAAA:8
 a=zQ4LAhLgmqmo3uJZ4jEA:9 a=zY0JdQc1-4EAyPf5TuXT:22 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-GUID: czqmlh9v39lJ4Snmtm1mbR3a9v-kodUk
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMiBTYWx0ZWRfX4NvJhuZk2w1X
 bUnLYGqANbtYF8535jCbAm+9O41DTQCyl/cT9Ppz+vC45vALmoYo8qQGLAZlU11/jtX9IRvbroh
 dTmBhMLIv5PJh8InvKIqMSkz8qm9+fD5YVIkvGD4jFKK615EmwmD8171zfdcyaydhg/n2D3JxH/
 sonZEZYkPt22Veqtgkw80jLzS4/d8Rry/x7nrpy6aYU6l5ib35ui6J9hlp76PIgBKa4qHaXP2GV
 wjtlSq0unfZ1QLyn5FifkdW/p3ZR+kWrNR3D7Hl5xaAgA7DPd5FasBBU8t+8m9lGdl9DhNxHyjn
 dCfx/7ejDH8IWcpKDka1146pUGQu3J7iPZCPfJCSEmk0IZLffV7e9E/CESOH17+fdGEbPohhDYk
 LYS0+iZ9s+9KrVtWeDQ7rUwS4NrHAQ==
X-Proofpoint-ORIG-GUID: 7CS-085o02YXqggwHuidtJ_yQQzW8R75
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-22_07,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1031 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 phishscore=0 spamscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510180022

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.  The new logic preserves both forward and backward compatibility with
the kernel and iproute2 versions.

Changes since V7
Fixed some long lines.

Changes since V6
As each member of the arp_ip_target array consists of
one "addr" key-value pair and one optional "vlan" array it was necessary to
make each arp_ip_target array entry a JSON object.  Here is the new output
(using jq to format).

       "arp_ip_target": [
          {
            "addr": "10.0.0.1",
            "vlan": [
              10,
              20
            ]
          },
          {
            "addr": "10.0.0.2",
            "vlan": [
              5
            ]
          }
        ],

Changes since V5
Thanks to Stephen Hemminger for help on these changes:
- Use array for vlans
- Removed use of packed and Capitalization
- fix incorrect use of color
- Removed temporary string buffer.
- make vlan print a function for likely future IPv6 usage.

Output for ip -d --json <bond-name> has been updated. Example:
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

 ip/iplink_bond.c | 152 +++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 126 insertions(+), 26 deletions(-)

-- 
2.50.1


