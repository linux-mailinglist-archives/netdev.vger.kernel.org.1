Return-Path: <netdev+bounces-228991-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AF58DBD6D0D
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 01:58:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D60DE1892D72
	for <lists+netdev@lfdr.de>; Mon, 13 Oct 2025 23:59:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E59A2C11F5;
	Mon, 13 Oct 2025 23:58:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="nnMVjUBh"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA221EADC
	for <netdev@vger.kernel.org>; Mon, 13 Oct 2025 23:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760399922; cv=none; b=alYtVi02vRkCKnoRHi5ZVAyYlGakScTD7Uz3SygEZvZa1PMZSnm/u65XMCH7nlD5lPFUl/8XMU+k9DpHXYE28tJyT5u1A2BgcTp08x+zIscBQh3CTQRX8swY7I0VGOFVJVCUlauCqkpi1KXHWR5YJwvjLkbgl/G8FhQC/QEEQe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760399922; c=relaxed/simple;
	bh=vaLa6g5s2QScGRO/wX7EmitWXFCHYcbiB4E/jHPgjyA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=t81vE8vAjqSHRD8gcLMqYvFdGWo8vwsznhck2anNt5jY/jmhDlc1ZzZsJJl5ZEebAFv2zcQGMiPtYnPJNv5tUKwe+xl9KDLaGhRFPhAmBxVGxOelhUkbCy1ShUgO9eXT88zOBasfQOt/EME+peNkRCp0TgSMlxirUgyxEpLG8kY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=nnMVjUBh; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59DLH8Gn015294;
	Mon, 13 Oct 2025 23:58:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=x//QpzDj6bcgPBo2Z0+L/sBq2MUB58Z13CV9qI/P7
	Bk=; b=nnMVjUBhZM34G0sAgGlzUOIoR5kZVWv/5Q1natd+t4ihYjBVVS8G/Eqmg
	rpHlpFZtu/VFu1fJjjWLYZKhPEsWysy/hfQ6Jx8fKRjer6u3OYg+Pu8qUG2a6SfN
	PL6RoYS5qbY8fOfnx8I1K9nbDjqx1oVnCVEBidm8D2k/UOt5OS/iT07jFp9iJV1h
	XMu13SHcFEdlz+PQYZdl+61nk+8LvBJHkOhEb3OABCcdl7lI3MXQ1JU3y5MSWzUK
	p2THywfPrOKinCjSw4PrJBKPw9WR03gWrBJbypidedPUtrjsFXhz0rGt1ReNo9eW
	XqCadxerdWTYr3dnJ7HzF/PYdVM4A==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpbfw8-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:58:34 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 59DNsMsW020511;
	Mon, 13 Oct 2025 23:58:34 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49qdnpbfw5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:58:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59DLCPba003626;
	Mon, 13 Oct 2025 23:58:33 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 49r1xxreht-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Oct 2025 23:58:33 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59DNwVhJ23724786
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Oct 2025 23:58:31 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 768555805E;
	Mon, 13 Oct 2025 23:58:31 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2FAF958052;
	Mon, 13 Oct 2025 23:58:31 +0000 (GMT)
Received: from localhost (unknown [9.61.176.140])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Oct 2025 23:58:31 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeep@us.ibm.com,
        i.maximets@ovn.org, amorenoz@redhat.com, haliu@redhat.com,
        stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v7 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Mon, 13 Oct 2025 16:57:39 -0700
Message-ID: <20251013235827.1291202-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDExMDAwNSBTYWx0ZWRfXzyUmFtrgvdM/
 tDTDu4pTHFuxuahKzrY+Aa52yLExeZ9CFfUKwrjmmGPED+7JyetzbrL7O88o04EQBVte9Rx51sZ
 0x8sYGd+BvTgIrTN09ONrXZRWqHUu6luv8Ol8OhBNTiwqgVcUuviUIi2JQAVpmpy/BUC2mhpd2g
 WfBLryWV5OHWM6U2jM7vy06146xv6cbtogTw5qkVBJihq63q8gAbdGZGQmqSZYuMOoo/U/IraMa
 oRYcEp1hJF70TMGOeuvMjPId5ooAmBucnEuX+xRJOxwqj+2x7saP5NX2RUWukfyf3h0eSHiYogG
 qiCDEPIoGGm6qk7drZGcenms04o/7dXuTF/MFdwyOe3x+4bdz37N4JqQyZUSpPefUKQju7vNxGR
 DpQ+g5745erZ2oeJoiy/ptsvIYJDBw==
X-Proofpoint-ORIG-GUID: vFyCFSkjhe6faAYk2ABx55myisidy3Mz
X-Proofpoint-GUID: 9l1qA64WS5lWSvtDq-b2fP34x8x8xpnw
X-Authority-Analysis: v=2.4 cv=MoxfKmae c=1 sm=1 tr=0 ts=68ed922a cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=gu6fZOg2AAAA:8 a=VnNF1IyMAAAA:8
 a=zQ4LAhLgmqmo3uJZ4jEA:9 a=zY0JdQc1-4EAyPf5TuXT:22 a=2RSlZUUhi9gRBrsHwhhZ:22
 a=poXaRoVlC6wW9_mwW8W4:22 a=cPQSjfK2_nFv0Q5t_7PE:22 a=pHzHmUro8NiASowvMSCR:22
 a=n87TN5wuljxrRezIQYnT:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-13_09,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 suspectscore=0 phishscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 clxscore=1031 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510110005

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.  The new logic preserves both forward and backward compatibility with
the kernel and iproute2 versions.

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

 ip/iplink_bond.c | 149 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 123 insertions(+), 26 deletions(-)

-- 
2.50.1


