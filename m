Return-Path: <netdev+bounces-96127-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BDEE8C4688
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 19:56:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3538281351
	for <lists+netdev@lfdr.de>; Mon, 13 May 2024 17:56:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 912D82C190;
	Mon, 13 May 2024 17:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="n5UhJLes"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B9217E
	for <netdev@vger.kernel.org>; Mon, 13 May 2024 17:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715622972; cv=none; b=G18PSVKh29r3bF1d/oFZHKXd9/bFeUqLKDPXA07HrDOEYvpWQGD8iGpCPSpMx1ks7w49IF7cSyWEgOWHEu8gxHHY8QSwgatTqVBmWtz5B8yExezhgM1xeJCe4MxRCToVGV4dg22N9VlUmvOsXtJGjtiL0ScEYI8RgR0f45iTcbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715622972; c=relaxed/simple;
	bh=DCDVhwIx/2ZsYBqnxqiKxaEbmeYebsD/4k+J7Km8/ss=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Poq2XsEOnwyCAVn/+5wzso9CkTFwEcN1AonDBf60uss2shql0hfheaeAu5jOPqQxuJvg7BPXZLTjN/bSweT4mlInwwE3Jow7h1hDbWYlWB946fGRRuA1FUueqH4XnsrX6bhHaIx3kpClVfesCMpZkqB8NwJ/pOvWxqTM8U0a8q8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=n5UhJLes; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44DHHaYC019056;
	Mon, 13 May 2024 17:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=bb5nVfg2yDPfEYdzRm119sZApL1G/cmjqb9W6ilfcgs=;
 b=n5UhJLesKLtt/Irse/yUHVasI9eqviu8cDybpNnCv78Iw8Q6t1kPGqAek6PCAMSm53xI
 Jao9lu8vitb/JWc4RdGdZ9Qxl59HDQuly52fgzfnkgZE0i09cUPmSqH+Yb465IhlFa/F
 zPL2fJ42ogI0G+IB/MRULEmZVAu0RqGsv/CdY09z2XWY3IkpbHKJY0ZgaCZAgpBJ2fOs
 zCaj7fwJuhJkG8QMYietPoPxo4D5x6FvIvjAzA2QunWyjHRTARWV08WCF2nIlqYbuZj9
 AkSXqH1sm7/R4vCjLtBKJlGUYCGUbZAwmSQbSUuwaUX02U1d99iHPycdxwagcrcHgb09 eA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y3q4hg2ud-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:56:04 +0000
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44DHu3TZ012368;
	Mon, 13 May 2024 17:56:04 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y3q4hg2ua-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:56:03 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44DHWXej002252;
	Mon, 13 May 2024 17:56:02 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y2m0p0v5b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 May 2024 17:56:02 +0000
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com [10.39.53.233])
	by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44DHtxb025821780
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 17:56:01 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 695C55804E;
	Mon, 13 May 2024 17:55:59 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCE0858055;
	Mon, 13 May 2024 17:55:58 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.196])
	by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 May 2024 17:55:58 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com, Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH iwl-net V2,0/2] Fix repeated EEH reports in MSI domain
Date: Mon, 13 May 2024 12:55:47 -0500
Message-Id: <20240513175549.609-1-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: k71oce3T2qYAnC5KFqL6gQJEJMwmh9Yq
X-Proofpoint-GUID: DdH1lbPWu9Ie0zJPf2HVENEFCkckX8gb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-13_12,2024-05-10_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 mlxlogscore=682 spamscore=0 clxscore=1015 phishscore=0 malwarescore=0
 mlxscore=0 adultscore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405130119

The patch fixes an issue where repeated EEH reports with a single error
on the bus of Intel X710 4-port 10G Base-T adapter in the MSI domain
causes the device to be permanently disabled.  It fully resets and
restarts the device when handling the PCI EEH error.

Two new functions, i40e_io_suspend() and i40e_io_resume(), have been
introduced.  These functions were factored out from the existing
i40e_suspend() and i40e_resume() respectively.  This factoring was
done due to concerns about the logic of the I40E_SUSPENSED state, which
caused the device not able to recover.  The functions are now used in the
EEH handling for device suspend/resume callbacks.

- In the PCI error detected callback, replaced i40e_prep_for_reset()
  with i40e_io_suspend(). The change is to fully suspend all I/O
  operations
- In the PCI error slot reset callback, replaced pci_enable_device_mem()
  with pci_enable_device(). This change enables both I/O and memory of 
  the device.
- In the PCI error resume callback, replaced i40e_handle_reset_warning()
  with i40e_io_resume(). This change allows the system to resume I/O 
  operations

v2: fixed typos and split into two commits

Thinh Tran (2):
  i40e: fractoring out i40e_suspend/i40e_resume
  i40e: Fully suspend and resume IO operations in EEH case

 drivers/net/ethernet/intel/i40e/i40e_main.c | 257 +++++++++++---------
 1 file changed, 140 insertions(+), 117 deletions(-)

-- 
2.25.1


