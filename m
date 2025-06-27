Return-Path: <netdev+bounces-202041-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 087AAAEC0DA
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 22:24:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B449E565682
	for <lists+netdev@lfdr.de>; Fri, 27 Jun 2025 20:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F5F21FF54;
	Fri, 27 Jun 2025 20:24:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="jk+EOwm4"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78803C2FB
	for <netdev@vger.kernel.org>; Fri, 27 Jun 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751055889; cv=none; b=IlBTjICveQuxSbfaGZgRxzDWe0MLKOf0PC1z2VWTlR/6RMKIv6Q8W+WGzgaKCRQKV4FGd8XOGIaPznnGaSS4MX0Gq322o8Lh90j+fIlHy7VHYshL0whcJeWVawzVabSkuAFiRnVRsbnCTndK75OvpPJpw9mse2Hrww70RPyqLvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751055889; c=relaxed/simple;
	bh=9iLHpe1TuKNP2Fsb0YQ/fMEvtO9GAckVBrll2oNyIp4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JTmAP+kQ9jH3+yL2juYl3FyJKyaeHl+FIf0ukprsZ1MxZFYiaj6PaJE+FxBkn513dmfrn1O4BKkoe86HRJk6xgsoLxi7mthmOiXlkMh/maLpsmW+Iv51b3lK8WhYHJL7WqUbFohxS8oyJzv/yOkh8ERNimuD0XegKwMO21mkA7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=jk+EOwm4; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55RI0XxT010463;
	Fri, 27 Jun 2025 20:24:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=ysIVRlW6Od3N1xcko7N8p00X9hM16jedQhhLnz6HE
	N8=; b=jk+EOwm4ooGXPFSTQ/JQ5ICQS9/GZSWQHJS09RDo013ekifaTPIX19GcL
	+3PWR5c/6N8k8FawN5tXckRA1lF4raRt1HHfXLLWADB2Mzkx/f8lSMplALJFGSHP
	JYFkCG6hhqPiu6DMiHuN3ViDjPy26lj9xABftrmblUZeIKH0fyThw41JlNsOq4k+
	t7i5TOkpASuLatL3ETTJw/pjayazUqLxQNh4g4ZkOxpXv4eLGxBIhmI0eDBJjTWK
	OuFG6jkVas+2gYMtoKr0l6uwlN0dTkgL78HPNTKfdf8aB5pwn/Xwhfwtz/YtAPtG
	saiNIG6JBKEA9GYD6EoIgTVVN3Qkg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphwph0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:24:38 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 55RKLVY6014340;
	Fri, 27 Jun 2025 20:24:37 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 47gsphwpgy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:24:37 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55RJPjLY014951;
	Fri, 27 Jun 2025 20:24:36 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 47e72u64w9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 27 Jun 2025 20:24:36 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com [10.39.53.231])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55RKOYfn62914948
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Jun 2025 20:24:34 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 30D2B58052;
	Fri, 27 Jun 2025 20:24:34 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8E7A58045;
	Fri, 27 Jun 2025 20:24:33 +0000 (GMT)
Received: from localhost (unknown [9.61.49.21])
	by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 27 Jun 2025 20:24:33 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com, stephen@networkplumber.org, dsahern@gmail.com
Subject: [PATCH iproute2-next v1 0/1] iproute2-next: Extending bonding's arp_ip_target to include a list of vlan tags.
Date: Fri, 27 Jun 2025 13:23:43 -0700
Message-ID: <20250627202430.1791970-1-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: mGFcTUPweM_UMpTGLIhB7YLcADgHwPZr
X-Proofpoint-ORIG-GUID: 6yadboEXQtgEoxj4w_B5Ttj8mXqipobb
X-Authority-Analysis: v=2.4 cv=Hul2G1TS c=1 sm=1 tr=0 ts=685efe06 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=OLL_FvSJAAAA:8 a=VnNF1IyMAAAA:8 a=MdQn5gnp1V2VywMwy1AA:9 a=i3390INrWYwA:10 a=A8PjhCl33ZoA:10
 a=zY0JdQc1-4EAyPf5TuXT:22 a=oIrB72frpwYPwTMnlWqB:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjI3MDE2NCBTYWx0ZWRfXwqoksCXquqaE 2FrZHAYXxTcl1QAx8aYp3yV2VqHLASwzFRwGWwMN6Fozy2+/ofs/2+zwiMQQLETDeZZwU9yhuPH fwO9TFRfkoD32j1dESSuenMgu76TbM6hKyKde48UFOxHUnQYRns6dY2fJY6ioBLORgw+2dyF8Vs
 su4LxgdwJ+dn5gdo9SHbWaFKgnpPYEO40fzeldWWY3i0ftK1VcFILhn/E5gsVDQmFqbHwoDVJsq EJs2riD2Uu3nKSDIpKgiF2iBclCuiMZbVOx3r1SVVnzpuUuqcjQRh5wVqXw36FhfEbAgFhO7G0G W/J/wW/jlBpcLxSbFnCv+pSkZ4o/S3ICy1BoD76ndUpjHfyzw/7WwgVMHU/2RICnshaO5R9rBaB
 g285692roi5Dj+1NVtkpjBaaEwBg4lba7hw+jA5haEcQojs+aeTJXZEZS7NAJhLxwZqS2P14
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.7,FMLib:17.12.80.40
 definitions=2025-06-27_05,2025-06-27_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=828 bulkscore=0 mlxscore=0 adultscore=0 spamscore=0
 impostorscore=0 clxscore=1031 priorityscore=1501 lowpriorityscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506270164

This change extends the "arp_ip_target" option format to allow for a list of
vlan tags to be included for each arp target. This new list of tags is optional
and may be omitted to preserve the current format and process of discovering
vlans.

This change is dependent on this bonding driver patch set:
https://www.spinics.net/lists/netdev/msg1103232.html

Merge only after the above patch set has been merged.

Thank you for your time and reviews.

Signed-off-by: David Wilder <wilder@us.ibm.com>

David Wilder (1):
  iproute: Extend bonding's "arp_ip_target" parameter to add vlan tags.

 ip/iplink_bond.c | 62 +++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 59 insertions(+), 3 deletions(-)

-- 
2.43.5


