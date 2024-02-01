Return-Path: <netdev+bounces-68150-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 21676845EDD
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 18:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C48352843E0
	for <lists+netdev@lfdr.de>; Thu,  1 Feb 2024 17:49:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAABC7C6D9;
	Thu,  1 Feb 2024 17:48:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="htW36TcJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD38A7C6CB
	for <netdev@vger.kernel.org>; Thu,  1 Feb 2024 17:48:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706809736; cv=none; b=kB0X7h1Sfh5L3IAH7xoHz938sOzG+MhwMjnIgqA2H5v7kom6WQWcx1UYFgxBRzUby3rn7I++b9bCf9p7mRJRaoHF3+c3z8tK3j2LQ/wwZSrAgvCHzXlajCT0L2MQAwjPUnYMqkxiAlp0M3NaEFud9d5GkaV7LcaXTDY6HajvXLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706809736; c=relaxed/simple;
	bh=08DF4yXTgpHxDXu7eNqsfzgzdFSjjoxuwL/BcCS2bVI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ZQY3chrGtZMtmaGGrtXqNHknMJVlZRnzWZ0cV60pxxAsr2+R6zTvoIXnxsNkqXCNfuSswbSm8H2Hb2br9/adxR2ofT9W3+fCnIRoU/ZWIemD0SIkl9h7/5wAc57giWzcm82E7ko4KRny6yK0iow3WVT+sfzaAAe+gjPuTpsgLds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=htW36TcJ; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 411HDN47017063;
	Thu, 1 Feb 2024 17:48:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=b+d93bM5mUmjMV4zPKK7srAL4eG+kehYUxGDesXwt78=;
 b=htW36TcJObOvwbY53qrtVzVRiYzmvdECDCkRdNrb4JoC36OpiaUj0tEOLmepKGlP/1RC
 JBvRqBs1oRul4l0DdPuQqS4ZRMyeL5tpiU/un7nP7Q5D8pVozO+tp8hkAFgdYp1qq4P4
 WAIjaPWp1tQGv5RtzCgPCsHJBY80vQyiYQXUFu6o8toWB6+ghkLmqMx2QcuaxOdgc8W3
 SaLsjhoWpFgHyNW7NLDXiubVk3CGpOjJOiLCSmZWxlvTU509NdKGTifTt3Xu4HeAgR7w
 dI4vZe2RDRsavzY+fa31wkH6GZofk1l9ulGhp8N0BcfPqJNNSNlh1SCAphq1R3GD5C8b 8A== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0fgrgy1p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:48:46 +0000
Received: from m0353723.ppops.net (m0353723.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 411HDbLE017392;
	Thu, 1 Feb 2024 17:48:46 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w0fgrgy19-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:48:45 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 411FsvTb008234;
	Thu, 1 Feb 2024 17:48:45 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3vwdnmdu0m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Feb 2024 17:48:45 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 411Hmhi440632958
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Feb 2024 17:48:44 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AFA5E5805A;
	Thu,  1 Feb 2024 17:48:43 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7397458052;
	Thu,  1 Feb 2024 17:48:43 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Feb 2024 17:48:43 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        thinhtr@linux.vnet.ibm.com
Subject: [PATCH v7 0/2] bnx2x: Fix error recovering in switch configuration
Date: Thu,  1 Feb 2024 11:48:20 -0600
Message-Id: <cover.1706804455.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ptbgtv0r_RmVGF2gLwGp9PqnuGhq241T
X-Proofpoint-ORIG-GUID: SEcE_v6RR7CRM7oglTYTaugoQWvlZcUZ
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-01_04,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 suspectscore=0 bulkscore=0 adultscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxscore=0
 mlxlogscore=359 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402010138


Please refer to the initial cover letter
https://lore.kernel.org/all/20230818161443.708785-1-thinhtr@linux.vnet.ibm.com

In series Version 6, the patch 
   [v6,1/4] bnx2x: new flag for tracking HW resource
was successfully made it to the mainline kernel
https://github.com/torvalds/linux/commit/bf23ffc8a9a777dfdeb04232e0946b803adbb6a9
but the rest of the patches did not.

The following patch has been excluded from this series: 
    net/bnx2x: prevent excessive debug information during a TX timeout
based on concerns raised by some developers that it might omit valuable 
debugging details as in some other scenarios may cause the TX timeout.


Hereby resubmitting the two patches below:

Thinh Tran (2):
  net/bnx2x: Prevent access to a freed page in page_pool
  net/bnx2x: refactor common code to bnx2x_stop_nic()

 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.c   | 28 +++++++++++--------
 .../net/ethernet/broadcom/bnx2x/bnx2x_cmn.h   |  7 +++--
 .../net/ethernet/broadcom/bnx2x/bnx2x_main.c  | 25 +++--------------
 .../net/ethernet/broadcom/bnx2x/bnx2x_vfpf.c  | 12 ++------
 4 files changed, 27 insertions(+), 45 deletions(-)

-- 
2.25.1


