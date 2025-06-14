Return-Path: <netdev+bounces-197702-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5988AD998A
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 03:49:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B6344A0DFB
	for <lists+netdev@lfdr.de>; Sat, 14 Jun 2025 01:49:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F96E86337;
	Sat, 14 Jun 2025 01:49:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="THS1qJ4L"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 115F17260E
	for <netdev@vger.kernel.org>; Sat, 14 Jun 2025 01:49:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749865772; cv=none; b=kBiicr2y4n4iXKklvJitokNs2vPc1D6cg19B5aC1M8CPuYyiuj9K/pjyy4upDGMa8yEI+s0Li0NsaDVHKPXFBvvFC/FpXB0xXCM1PUIvKK8u+Wa800sC0eD789zIk9rMlEv8rzl8DD/acASuAYjnXKr4htEQLZa2KDcQkhJ1Zss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749865772; c=relaxed/simple;
	bh=+7DlzxhUFYTjonbWOaPKQ6T0sgBE7NQA4p1kEoZA7Zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLrFlcN0UEuHBjKZTYcnrlYNsivcUWSr5b+5DwhrHJa3Y8rESvCJ2woDWHyk6I8k67JQv0lEZ4oTnqwYkuj+dhfqx/lnJ1+FPPo4q7VbaXzwA4faNl1EFQTXM5X4bhB0NMztzogwLtRVk4bPCvaY4At8KdAuQ402dlqvsWS+mx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=THS1qJ4L; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=us.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55DJfcBe001686;
	Sat, 14 Jun 2025 01:49:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zqpi7NCI2sh9mKVjk
	9qD8yy/GmAyTU2cgKjAxf5UOw0=; b=THS1qJ4L3VzwsBt7dcHZuyOBhj+pMQLIN
	VKAfB6dfp9dgXZOxs3SyxRMjnzRu6UFQ1Xo+tPu0pHHiN0jZ3bneGBuaaBJCITQf
	rm3ta8eIoWt9W1AusAkpOGmRFyQ1Pbq/45Yrj5Cb30fScMJHol6YIEgjP2my10ao
	Arugx+racYfgPa/C440zYXh6TyyfzqECuvEC5SA0Pfc6LvDMw6pQqW+XHq3YTzmO
	5rIKUD1btri+/Isj79bRneYjtMXO+6sJHlsTU4lRsNpIRPXwDvXiNJH4w5uCG6jN
	Xguc9QAJnHwFlgzGCNvSyN8KEpra8T1f4Rn8Q40H8eDjrg0GmCJfQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4769x0933e-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:24 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 55DN2lGu003347;
	Sat, 14 Jun 2025 01:49:23 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4751ym4kau-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 14 Jun 2025 01:49:23 +0000
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com [10.241.53.104])
	by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 55E1nJnH25821722
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 14 Jun 2025 01:49:19 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7419858056;
	Sat, 14 Jun 2025 01:49:19 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4427758052;
	Sat, 14 Jun 2025 01:49:19 +0000 (GMT)
Received: from localhost (unknown [9.61.34.221])
	by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 14 Jun 2025 01:49:19 +0000 (GMT)
From: David Wilder <wilder@us.ibm.com>
To: netdev@vger.kernel.org
Cc: jv@jvosburgh.net, wilder@us.ibm.com, pradeeps@linux.vnet.ibm.com,
        pradeep@us.ibm.com, i.maximets@ovn.org, amorenoz@redhat.com,
        haliu@redhat.com
Subject: [PATCH net-next v3 4/4] bonding: Update to the bonding documentation.
Date: Fri, 13 Jun 2025 18:48:30 -0700
Message-ID: <20250614014900.226472-5-wilder@us.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20250614014900.226472-1-wilder@us.ibm.com>
References: <20250614014900.226472-1-wilder@us.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Mpl-AIjZ1KcdfzHn5twKSszZNFlihca9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE0MDAwOCBTYWx0ZWRfX1xSIAEWbHhGq myFj1x2lHPxaE4GF5n9w1sxke+teMKITYrnguedclEMfwxX0ZE+zvyygOdFLwvBlUlmP3aqXHOJ 9PfFXqye97q0yd6GoI+APrbCGX2bjn/RbkwwzcdxweSLLFBnuv2nb74CYtsAqgGUBDo+/Zu7hBz
 H9OKO7N33GbX3eg5XXr6Z24itfpjALqoQMD9QZNxRvxdi1EaMHvoJTEOInuizV9AmpbrsBPfp6h vfBVgVGEVUBz2k8W8aQdW+1LLk4ET3zdodx1LW3EKQQwng3hWD+8c71nbOwQG14xIT7ghbmA8Ne Hpzmy6KyZxHQmKelvdN/lH7R/UoKBGW6ju9Y3BTcYMso6Py/EsLWxJ8sF7i76BBv+X/DtKRT8f9
 zjUW+CTUYm78RJJHLh2A440Oc7oHfIU1TZURy49fDvyCcG2v0UuaU/rnoFuI2AO7EzZtzvXz
X-Authority-Analysis: v=2.4 cv=YKGfyQGx c=1 sm=1 tr=0 ts=684cd524 cx=c_pps a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=zDcxO37BirYMXtS84lIA:9
X-Proofpoint-GUID: Mpl-AIjZ1KcdfzHn5twKSszZNFlihca9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-14_01,2025-06-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 malwarescore=0 bulkscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 mlxlogscore=863
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506140008

From: David J Wilder <wilder@us.ibm.com>

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


