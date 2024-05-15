Return-Path: <netdev+bounces-96640-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 837198C6D7F
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 23:08:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 22B85B228D4
	for <lists+netdev@lfdr.de>; Wed, 15 May 2024 21:08:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4FA915B11D;
	Wed, 15 May 2024 21:07:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="oK3t0s5K"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5008A15B0E3
	for <netdev@vger.kernel.org>; Wed, 15 May 2024 21:07:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715807275; cv=none; b=rXg7Oi2QR5nwHvgYN5rV4pkzuyoftc0fjz4znNITw/7kgNp+BhqGj3r66FJbFC3Ym0/tApnLamUdVcKcagQtehWBotVfo1j7kgcPUxZ7swta5HIi7NHcdCNvCJYz/Cx8gBuH/hwrJTMMmD0UJ7J7YzMf2BxcxN4oqWkw5L0o/qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715807275; c=relaxed/simple;
	bh=VcplMxc4jMBTfA+f759CN+t2rMdYPy4WfxA4HsKzzJk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=uO/q+QFVulB9fBeD39ofJxNivK1b7aJ3NKYz3u8wLWq7m5tHw1LS/5onoAzfJluh6pzL8Ibyql88Wkze6L1Wn1gXwdTh712vVdov/tZNh8VLxeVHJeShgy5kXzwURF+yT59gTWRjvUNC82gPgH7ixER0rNgVq+ttawN+oN2ZP08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=oK3t0s5K; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 44FKpFno032430;
	Wed, 15 May 2024 21:07:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=fEmp8SdkykMnHlhu8WJmsie23k6v1/njxSQO7Bfp1fU=;
 b=oK3t0s5K4qovTr59fpnZUZm6eKK8hiYglAXjQjGc9ZZEokXxxkFTMdo4Sp0OBA0es/5V
 QCaMbIizIvoE6KDMmr+h1d5bie/6uxcB6cMsNMdPdDg57kDQPbSDv3uaFbBE/aKz/gDL
 WGFUUUmhzhrbH6vJLAQqBrYGvhaDZWCWyEfbFOqrqpLyZkr0OMN/vrLIuaQwO8zfjBgn
 E0CDLDj2cQXbaSDGIXU/h6s0zH7V/k30EDL2lWPEfV9Bk5nDKWCgOVedXoRFM+IA6pY8
 IHtEgLV21nRjU28myzLfJdsNAKU7skjLyF7nREpwlfa28qxpIG7wl94lekWj2q45SnIY pQ== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y53keg4wf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:07:29 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44FL7SU2025096;
	Wed, 15 May 2024 21:07:28 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y53keg4wb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:07:28 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 44FJNBr4029571;
	Wed, 15 May 2024 21:07:28 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2n7kwjbq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 May 2024 21:07:28 +0000
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com [10.241.53.101])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 44FL7Ovr33227134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 May 2024 21:07:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2D4905805C;
	Wed, 15 May 2024 21:07:24 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EA1EF58051;
	Wed, 15 May 2024 21:07:23 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.196])
	by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 15 May 2024 21:07:23 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: netdev@vger.kernel.org, kuba@kernel.org, anthony.l.nguyen@intel.com,
        aleksandr.loktionov@intel.com, przemyslaw.kitszel@intel.com,
        pmenzel@molgen.mpg.de
Cc: jesse.brandeburg@intel.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, intel-wired-lan@lists.osuosl.org,
        rob.thomas@ibm.com, Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH iwl-net V4,0/2] Fix repeated EEH reports in MSI domain
Date: Wed, 15 May 2024 16:07:03 -0500
Message-Id: <20240515210705.620-1-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: we3XOqy5_0dY0P8KZZmsq8RwZi7lHzTj
X-Proofpoint-ORIG-GUID: PKC2rlUkkVPzpcSxwQn3Ht_ioDdGy-wO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-15_13,2024-05-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=740
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 suspectscore=0
 spamscore=0 priorityscore=1501 phishscore=0 impostorscore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405150150

The patch fixes an issue where repeated EEH reports with a single error
on the bus of Intel X710 4-port 10G Base-T adapter in the MSI domain
cause the device to be permanently disabled.  It fully resets and
restarts the device when handling the PCI EEH error.

v4: corrected another typos.
v3: moved text commit messages from the cover letter to appropriate
    patches.
v2: fixed typos and split into two commits

Thinh Tran (2):
  i40e: factoring out i40e_suspend/i40e_resume
  i40e: Fully suspend and resume IO operations in EEH case

 drivers/net/ethernet/intel/i40e/i40e_main.c | 257 +++++++++++---------
 1 file changed, 140 insertions(+), 117 deletions(-)

-- 
2.25.1


