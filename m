Return-Path: <netdev+bounces-105356-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 781909109D6
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 17:27:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 326B82820A8
	for <lists+netdev@lfdr.de>; Thu, 20 Jun 2024 15:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40572158DCE;
	Thu, 20 Jun 2024 15:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="mVmfqjoF"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D0821AED46
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:27:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718897259; cv=none; b=Z5AFhXry7Xgs0L9/PfBmZZ49GGcw75nj1t+fsPBNeVqxI7gosedB/aI4X+Xu1lOn8riXzmjsJzBpLc2G4nW3GWOKuYIf4je9l6nX74sPPMDncyf+zGSrD+JCUiW06dEli0XvbqqHrIDHbEKJ95y+qfa8fsRipIKqWMNn80yzguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718897259; c=relaxed/simple;
	bh=MpFakcow3PkSbqhHhn3NzhQLiCBT20uhaAyMOVuV/S8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Fuu/MHfVsSa1qppbxPwE3kr/EKLZVUOl5n0iKo/0XW+f1E+qJUVg51E8UtG3Fpsd/Em2JYGtebDdsFElzI/obHERhfd40PKgcEgsU8FzrSWQ+GPEbIWyXRaQI1ieVvCLzc0cBAtY4AECYpcZz9qDq6zFygwWPaVNHbAvyk+gFv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=mVmfqjoF; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45KFQSke012331
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=M3x/fNov4Q5Al
	NCFcjoPBVtSyft+Tgz0KJ0g5bElVlI=; b=mVmfqjoF1rj0qtNDGNV4Yq6m4zKTy
	HokM1jLF56aXbEdhFvmEW+Aey9norDWZK5HeTU0fVwMx5iCvCH/WCeiKFVAisJ1i
	VvotmOcGf63bJQmNX7Aho0Lq3AVbYtUw20bHdkTiK0f3wxHcHt+/fqA6or/z9Yxx
	tiC0gGtuZ2Ci1F3cqKsxUl9jp+ZDT0LnIeHhfCDHqLiUtvC1xUrj9RffCU6Bu8tw
	xLxttZmXSh6ANKlmBMy9i4rvvZXug4yFrwip8Vicuh1EuOum3PThst7p6wyZtMeD
	nJ4MdDJ76zW42aXHDb04gTzxoEXHQC8t35RsgYrhbD2/E5OEa8n8k6IBg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3yvpneg30c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:27:36 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 45KEacGj009422
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:23:40 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3ysqgn72qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 20 Jun 2024 15:23:40 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com [10.39.53.228])
	by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 45KFNZfk42664534
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Jun 2024 15:23:37 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 66D9A58063;
	Thu, 20 Jun 2024 15:23:35 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D17BF58068;
	Thu, 20 Jun 2024 15:23:34 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.39.25])
	by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu, 20 Jun 2024 15:23:34 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: nick.child@ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net 2/2] ibmvnic: Free any outstanding tx skbs during scrq reset
Date: Thu, 20 Jun 2024 10:23:12 -0500
Message-Id: <20240620152312.1032323-3-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240620152312.1032323-1-nnac123@linux.ibm.com>
References: <20240620152312.1032323-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: JDT0LstHQHk4lfDqpuxGePwl_I9MZyQh
X-Proofpoint-ORIG-GUID: JDT0LstHQHk4lfDqpuxGePwl_I9MZyQh
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-20_07,2024-06-20_04,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 mlxlogscore=999
 spamscore=0 mlxscore=0 phishscore=0 priorityscore=1501 adultscore=0
 lowpriorityscore=0 suspectscore=0 malwarescore=0 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406200111

There are 2 types of outstanding tx skb's:
Type 1: Packets that are sitting in the drivers ind_buff that are
waiting to be batch sent to the NIC. During a device reset, these are
freed with a call to ibmvnic_tx_scrq_clean_buffer()
Type 2: Packets that have been sent to the NIC and are awaiting a TX
completion IRQ. These are free'd during a reset with a call to
clean_tx_pools()

During any reset which requires us to free the tx irq, ensure that the
Type 2 skb references are freed. Since the irq is released, it is
impossible for the NIC to inform of any completions.

Furthermore, later in the reset process is a call to init_tx_pools()
which marks every entry in the tx pool as free (ie not outstanding).
So if the driver is to make a call to init_tx_pools(), it must first
be sure that the tx pool is empty of skb references.

This issue was discovered by observing the following in the logs during
EEH testing:
	TX free map points to untracked skb (tso_pool 0 idx=4)
	TX free map points to untracked skb (tso_pool 0 idx=5)
	TX free map points to untracked skb (tso_pool 1 idx=36)

Fixes: 65d6470d139a ("ibmvnic: clean pending indirect buffs during reset")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 887d92a88403..23ebeb143987 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -4073,6 +4073,12 @@ static void release_sub_crqs(struct ibmvnic_adapter *adapter, bool do_h_free)
 		adapter->num_active_tx_scrqs = 0;
 	}
 
+	/* Clean any remaining outstanding SKBs
+	 * we freed the irq so we won't be hearing
+	 * from them
+	 */
+	clean_tx_pools(adapter);
+
 	if (adapter->rx_scrq) {
 		for (i = 0; i < adapter->num_active_rx_scrqs; i++) {
 			if (!adapter->rx_scrq[i])
-- 
2.39.3


