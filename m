Return-Path: <netdev+bounces-105354-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF919109CF
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:25:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 04812280DBE
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:25:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D99A1AF68B;
	Thu, 20 Jun 2024 15:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="IrzcIueO"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DB48158DCE
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:25:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897147; cv=none; b=pLbcj462T0FE5m2PpPa8A6uH3peJcFagc6wnVn3ariZf5NuOF8xJY2qo7QYIpvcW6nC1mEUJFpdSYHSLZ7op02qsGnnWkwqRntPMrC/3yxEPOAGdn/7CSXkl0AdkPVbfGDPGDqFkUhgJMjKBJF3VZPT/+fsyCAvekqSszWhDeOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897147; c=relaxed/simple;
	bh=INUOEUhlAvNTS3tIm2O+mBzEItr9KJRnSuwJHVA3Srs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=NnfmHwNcDemY8aUGdzD1oPf+zQZifffJ+SSe9ih7Zbl4NPnN66qAZ8B0nHzW09/XfHRJ9AXhSmQ+Kn88jfDiNVDQ3xF26QaByEy68MQ30AT7+M095Ch//2IA4wW6tGlLExajam2cmJYcaaSTvkQo8KxkPFR+/+YU9H0WLLoq8Tw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=IrzcIueO; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353723.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KChqWx028752
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:25:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding; s=pp1; bh=9sC9KiGqlARRgyp9W2wslKM9vn
	pGn8NTYLofEddYoQY=; b=IrzcIueOXFb3Ku4V3wvnJyXpU51J5iKkb58hQtkblO
	bCXRfQEHsG7vscv6pFvgOz9sZxqbWRRvcqpAMLiYJHLueSh+NUqvjaGBb7VzplpC
	I150wB6z3rENdqxDxEFb4mDzHCM6/gBMmu6FNhZtBSl/62Y/bprST0xrb0vB7cc9
	oMbL8TiDNOAp8dGiq5mOFPqQvacEOGEVXJPybWHLaVRfS2qQqbssI5czBC479KLI
	iBQBPsaGtXoHbEqUHuWjHwGKW8sTT2pnh3MDqeZE+C5bt8X/kOQVmUEWHuCm7FN2
	FxgvCbHlHx/d855kNpq/Ope4DJYy6JuB2AzUDiALl2OQ==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvg2s95tk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:25:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KESGJP011022
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:23:32 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3yspsnq84b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:23:32 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45KFNQQV45285918
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:23:28 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5B77158067;
	Thu, 20 Jun 2024 15:23:26 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C8165804B;
	Thu, 20 Jun 2024 15:23:26 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.39.25])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 15:23:25 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: nick.child@ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net 0/2] ibmvnic: Fix TX skb leak after device reset
Date: Thu, 20 Jun 2024 10:23:10 -0500
Message-Id: <20240620152312.1032323-1-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ne_w10Rm1KTKCYJJbM6AbfXiKBsnXTu4
X-Proofpoint-ORIG-GUID: Ne_w10Rm1KTKCYJJbM6AbfXiKBsnXTu4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxscore=0
 clxscore=1011 impostorscore=0 lowpriorityscore=1 malwarescore=0
 adultscore=0 suspectscore=0 bulkscore=1 phishscore=0 priorityscore=1501
 mlxlogscore=957 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200111

These 2 patches focus on resolving a possible skb leak after
a subset of the ibmvnic reset processes.

Essentially, the driver maintains a free_map which contains indexes to a
list of tracked skb's addresses on xmit. Due to a mistake during reset,
the free_map did not accurately map to free indexes in the skb list.
This resulted in a leak in skb because the index in free_map was blindly
trusted to contain a NULL pointer. So this patchset addresses 2 issues:
  1. We shouldn't blindly trust our free_map (lets not do this again)
  2. We need to ensure that our free_map is accurate in the first place

The first patch is more cautionary to detect these leaks in any future
bugs (while also helping to justify the leak fixed in the second patch).
In this case it is due to device resets which free the tx complete irq
but do not free the outstanding skb's which would have been freed by the
irq handler ibmvnic_complete_tx().

These outstanding SKB's MUST be freed any time we free the IRQ. We are
not going to get an IRQ to free them later on! Also, further in the
reset path init_tx_pools() is going to mark all buffers free! This is
addressed by the second patch.

Nick Child (2):
  ibmvnic: Add tx check to prevent skb leak
  ibmvnic: Free any outstanding tx skbs during scrq reset

 drivers/net/ethernet/ibm/ibmvnic.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

-- 
2.39.3


