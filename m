Return-Path: <netdev+bounces-70362-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CED884E89B
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 20:00:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AED7A1F2D1AD
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 19:00:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9A036139;
	Thu,  8 Feb 2024 18:55:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="H0bdHNSH"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96FA025635
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 18:55:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707418548; cv=none; b=eYHZkuKaB36gtFZNLRZiD5FJjF2DrP2MGwyQgFUNlgwqzoK/x17V+hqiYP5fjXYwc9xKU0X9jcgHGI+093ZDJ3jgSZsyTl7NOyhQlK6X6O9UEeuSkh/nAZAZuEyrtiKw+tZqDFlBR1I56MZrIk3nizMAZRmKIh79rmNO/zn6jr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707418548; c=relaxed/simple;
	bh=dHGOU61HQSqaJhlYRsALMZ3R0z0AxNN1dF9RKu2vYlI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=YCsRzAtRPknc3bvoUcia1MCqaSNN5eUjb5W5WEIWpDZcUIQRuNJbnk0LZ2aw8VYIFe81ODBF3SCM4fObg9RZUIn3cwY/mDcmYoDsbHO9AvORbMZphZWQSyCHqbwHXK1SjMoi3yEfxG5X7FZmV1unJ5FJvjZs3YssXUO5VVu1GnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=H0bdHNSH; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 418HWaP8008402;
	Thu, 8 Feb 2024 18:55:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : content-transfer-encoding
 : mime-version; s=pp1; bh=miSG4muuZGsPpnOW7MVxcad4bvcKBUlGBbT1m7JySuY=;
 b=H0bdHNSH5PsvLlL/dTOWMgvR1oVOIOWPulqlqHrN3nD/3B3vQoE50QR13GEyo5cwKlRI
 nmDNdZm94HSbM7dJYRQFIvKKeM4oweTsPGcayCam39ugtb/MsWFFwwdvw+oxsBkSBg6L
 kVE7v8ebPIFsQmYgiP6+XuNg7AJv+W3zhq+4YoSpNNUN5wHacha7gg8kKLcAC7+Psy3v
 Hyae50SZBrItohHS5I2616+THTshf0s4oOSC0Vn7APiW96Hhbw6oB6KQ2OHs1MjNCeBv
 CnoXOK97IowbzET5JB9ZcoD6+0ahbOfb+sUXmiD52y2kR/4btRB8mnCtasaM65y99olV mA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w53ejhy5a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 18:55:40 +0000
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 418IscLW015281;
	Thu, 8 Feb 2024 18:55:39 GMT
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w53ejhy4w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 18:55:39 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 418Ist4A016137;
	Thu, 8 Feb 2024 18:55:38 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w22h2e1dh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 08 Feb 2024 18:55:38 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com [10.241.53.103])
	by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 418ItaM419071536
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 8 Feb 2024 18:55:36 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 335F058064;
	Thu,  8 Feb 2024 18:55:36 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E176758056;
	Thu,  8 Feb 2024 18:55:35 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  8 Feb 2024 18:55:35 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, aelior@marvell.com, davem@davemloft.net,
        manishc@marvell.com, pabeni@redhat.com, skalluru@marvell.com,
        simon.horman@corigine.com, edumazet@google.com,
        VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com, abdhalee@in.ibm.com,
        Thinh Tran <thinhtr@linux.vnet.ibm.com>
Subject: [PATCH v8 0/2] bnx2x: Fix error recovering in switch configuration
Date: Thu,  8 Feb 2024 12:55:14 -0600
Message-Id: <cover.1707414045.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1706804455.git.thinhtr@linux.vnet.ibm.com>
References: <cover.1706804455.git.thinhtr@linux.vnet.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Miw7vtASpuCmW9eF-DFdsjHleo7OBEJM
X-Proofpoint-GUID: mEU2PxczTfabP6pmpuNkVgFNHjPZjFPf
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
 definitions=2024-02-08_08,2024-02-08_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 mlxlogscore=458 spamscore=0 clxscore=1011
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 adultscore=0
 malwarescore=0 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2311290000 definitions=main-2402080099

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

v8: adding stack trace to commit messages for patch
    net/bnx2x: Prevent access to a freed page in page_pool

v7: resubmitting patches. 

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


