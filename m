Return-Path: <netdev+bounces-194696-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4715EACBEF8
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 05:53:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9A408188DCED
	for <lists+netdev@lfdr.de>; Tue,  3 Jun 2025 03:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48BBA1A0730;
	Tue,  3 Jun 2025 03:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="rNFB8lyn"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AE8119F471
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748922784; cv=none; b=dNLozMeqveOFQb87mXuX5ksdd9k58KbILXgvnix2oZ1kGMTFI1yHKlZwVfCMsGinvUMPWaM5KwAw3bammDN6x5Qlln16opP7D8A5jV1urTENY4cXAFeXjuR+Yrk+axCKmgycK27OOzVda7PxJXQtn46xMA4fqQrFQlAfosUPTt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748922784; c=relaxed/simple;
	bh=ZMbGzqTM//fcyJnguq1/DXY4O+qhlSLLGZuUoAMjYwo=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Mi8rlbWbkmL0BvJt80NA0es4cSNmgubUWCaIkkcDM4vMnjm8JsTa6SL/uR2jq8hdW/sDQNdYc5XblHxJ51PZrIHfiBfZ2ol9KQNpAhaV295kT19tTRTigrR0Nyb0oSfaz4IEw+OfSdcxxWEq9hbf7MfMAIC/yAMMK8MMI6fYFLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=rNFB8lyn; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 552HY8aM022182
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
	content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=aJAkNRmnePSpaNr03
	y/fCoQolaAmamV1+HwwBlaJTJo=; b=rNFB8lynpt86WGVeCYpaTJw1O4qK38y26
	YcCnENIbEzr2wkFcJ72Qm6i7wIIPAbMZGggCFJ/vXq6q475kivNQbs88wQQoVAwD
	0pjv/kCXKZdaurDLVrdjyuspmaQHZ/QOlF1eGWsbJdCVx5evHrd4RgQO/jLgzB4z
	UvsxMW5PD496hTpObsY2OeBLS/5eO89YwjrtsTxgm6uZQKaDEDZTHkfw4FcuYW+o
	wfIdrtFpa7kELWv0XvLua8lDDWQezEO1sIdEWaLibTnHFHDUMLjzARltfvmucp15
	mUr9d3arFOKH66EBrWjceu7vG0Vbbwe3NTfjilLmhdDmcz4MQRddg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471geyj1yh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5530UQXx022569
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:54 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 470c3t98es-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Tue, 03 Jun 2025 03:52:54 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5533qnJN15729302
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <netdev@vger.kernel.org>; Tue, 3 Jun 2025 03:52:50 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EE6415804E
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:53 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B0B9D5803F
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:53 +0000 (GMT)
Received: from localhost (unknown [9.61.177.224])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP
	for <netdev@vger.kernel.org>; Tue,  3 Jun 2025 03:52:53 +0000 (GMT)
From: David J Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Subject: [PATCH net-next v2 4/4] bonding: Update to the bonding documentation.
Date: Mon,  2 Jun 2025 20:51:50 -0700
Message-ID: <20250603035243.402806-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250603035243.402806-1-wilder@us.ibm.com>
References: <20250603035243.402806-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Z74wd4OYg5K_aHJSszyVSPmKhrZgkk1e
X-Authority-Analysis: v=2.4 cv=DYMXqutW c=1 sm=1 tr=0 ts=683e7197 cx=c_pps a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=zDcxO37BirYMXtS84lIA:9
X-Proofpoint-GUID: Z74wd4OYg5K_aHJSszyVSPmKhrZgkk1e
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjAzMDAzMCBTYWx0ZWRfX4G0g9QnaIq0u 8n2xBes4RxqGv/71Hhcc5IBEq3qZeKLz4vjAm22GiC9VUsVBEsGI3bWR+VmUVhZvpknBAxkBJGW 3cdwnywlpzCC35TGnC2TI9A+IA/0YfbpXg+IwESYsqaOb0wug1V3VfasFmVpTzpKRsaV6NmJ+Ce
 8yfozr6iYDnsSoOZP0D2MANfwbQmatsmYw0MXgWULGuY2K6SpjJqQ6aNQLmKlEv1PvuOfIOB+gO 3QYPdNWh6odD7flsYcGdpPfvr7ThEwYOd04AyMjIvYllFwxqJrnecEljlq+szCGvPAUUs6qOJGd S3dMEsmEdtE/ybSonFmozOEKbGdYxr+LwIfcWjVKNes+uvgaK6XliZZcQZLQ/KOFR4YHOFG/IQ9
 2zmdY+zp0va6tL3keZ8H81jzZcNqVy/HCKc3CjunlkW0mCoCi+Wyc6EevIy87MyLtRLr+aY2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-03_01,2025-06-02_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 mlxscore=0
 priorityscore=1501 clxscore=1015 phishscore=0 mlxlogscore=832 adultscore=0
 malwarescore=0 bulkscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506030030

How to extend the arp_ip_target parameter to include
a list of vlan tags.

Signed-off-by: David J Wilder <wilder@us.ibm.com>
---
 Documentation/networking/bonding.rst | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/networking/bonding.rst b/Documentation/networking/bonding.rst
index a4c1291d2561..aa76b94b1d88 100644
--- a/Documentation/networking/bonding.rst
+++ b/Documentation/networking/bonding.rst
@@ -313,6 +313,17 @@ arp_ip_target
 	maximum number of targets that can be specified is 16.  The
 	default value is no IP addresses.
 
+        When an arp_ip_target is configured the bonding driver will
+        attempt to automatically determine what vlans the arp probe will
+        pass through. This process of gathering vlan tags is required
+        for the arp probe to be sent. However, in some configurations
+        this process may fail. In these cases you may manually
+        supply a list of vlan tags. To specify a list of vlan tags
+        append the ipv4 address with [tag1/tag2...]. For example:
+        arp_ip_target=10.0.0.1[10]. If you simply need to disable the
+        vlan discovery process you may provide an empty list, for example:
+        arp_ip_target=10.0.0.1[].
+
 ns_ip6_target
 
 	Specifies the IPv6 addresses to use as IPv6 monitoring peers when
-- 
2.43.5


