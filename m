Return-Path: <netdev+bounces-130957-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E30E398C37E
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 18:32:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20D5E1C23D7B
	for <lists+netdev@lfdr.de>; Tue,  1 Oct 2024 16:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03F701CB51D;
	Tue,  1 Oct 2024 16:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NLKZ4Cce"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AF41C9B81
	for <netdev@vger.kernel.org>; Tue,  1 Oct 2024 16:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727800344; cv=none; b=TflNTGeBGsIkzOOcx69nC8G8k7fL358j/7M8Hm5BVimZZ30CKO2OiBJvpU75SE9Fq10Cgcfpl49SuzIQFxQ0D1jNg/b6wBLHbYX/ZCsPAesSgsFupBKZFoJ1al1+4wwnlG+VstfpxlEySygPTDsfv4GcUYJm5TuwEf0mSn5gMX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727800344; c=relaxed/simple;
	bh=YtE+GUvAds8hg7iqFDaPiZ0shh8Q+HdM3E0nfw+NBB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BhE9+6ncAIOyPEjgSHhdsczDl3QDry1q6ah4InVfoWLHNqq/DW/eva6csbWPNlmbcbif7TlNeu2QT28E7Cz0HI1CL4TMvwJYeIU/RBYrK+8diss8DDYNpfBQebIirfD9K65FX5tJ/lXAOc0TIZ6iPqxoUYlpSXKZnIRvWBadOPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NLKZ4Cce; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 491GLrUc019836;
	Tue, 1 Oct 2024 16:32:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=o1KN2A7+t+YzX
	JBh/+b+m6V8IRWPuqSd2E1zF5ZIUKU=; b=NLKZ4CceYr3pPCKn+qhXLHCtOTNpC
	p6ChjsjzieF5K0ex4pf4xC7xCRUsQ4F+p4jpI6d/SQVzz1z6iZvcaE8H3vOwQq6V
	MN9dFQVOWm2GIXvBDnwHQDdQV+XRkuWHo8bQV6MAMk0BlOlHpIgutOsFZAbfSUf6
	+TanwZzO1RuajQlumEhhFjAbk9apzneL0Kj9uix4J1c+638LTPP67+9c3aAr73D3
	+3piUlIRoeleZ6BbOOlh8fb4YvioUereAFIMzO/CiN9eyJUI+w5MBUaZX21VG/zX
	dkpm8halTe7N4DpXZVvUT4iYLZAweyAOxZ1KjsKRfahgNVDvN+pLRhK6w==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 420mhdr253-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:32:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 491GQFg0013070;
	Tue, 1 Oct 2024 16:32:19 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 41xxbjd98t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 01 Oct 2024 16:32:19 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 491GWEHF35652206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 1 Oct 2024 16:32:14 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8C1525803F;
	Tue,  1 Oct 2024 16:32:14 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 692565805A;
	Tue,  1 Oct 2024 16:32:14 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.141.187])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  1 Oct 2024 16:32:14 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: horms@kernel.org, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net v2 1/1] ibmvnic: Inspect header requirements before using scrq direct
Date: Tue,  1 Oct 2024 11:32:00 -0500
Message-ID: <20241001163200.1802522-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <20241001163200.1802522-1-nnac123@linux.ibm.com>
References: <20241001163200.1802522-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ciql70Hv4OmyPL4sTA9UY9nl41HW-25s
X-Proofpoint-ORIG-GUID: Ciql70Hv4OmyPL4sTA9UY9nl41HW-25s
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-01_13,2024-09-30_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=765
 priorityscore=1501 suspectscore=0 clxscore=1015 spamscore=0 phishscore=0
 malwarescore=0 impostorscore=0 adultscore=0 lowpriorityscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2410010105

Previously, the TX header requirement for standard frames was ignored.
This requirement is a bitstring sent from the VIOS which maps to the
type of header information needed during TX. If no header information,
is needed then send subcrq direct can be used (which can be more
performant).

This bitstring was previously ignored for standard packets (AKA non LSO,
non CSO) due to the belief that the bitstring was over-cautionary. It
turns out that there are some configurations where the backing device
does need header information for transmission of standard packets. If
the information is not supplied then this causes continuous "Adapter
error" transport events. Therefore, this bitstring should be respected
and observed before considering the use of send subcrq direct.

Fixes: 74839f7a8268 ("ibmvnic: Introduce send sub-crq direct")
Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 53b309ddc63b..cca2ed6ad289 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -2473,9 +2473,11 @@ static netdev_tx_t ibmvnic_xmit(struct sk_buff *skb, struct net_device *netdev)
 	/* if we are going to send_subcrq_direct this then we need to
 	 * update the checksum before copying the data into ltb. Essentially
 	 * these packets force disable CSO so that we can guarantee that
-	 * FW does not need header info and we can send direct.
+	 * FW does not need header info and we can send direct. Also, vnic
+	 * server must be able to xmit standard packets without header data
 	 */
-	if (!skb_is_gso(skb) && !ind_bufp->index && !netdev_xmit_more()) {
+	if (*hdrs == 0 && !skb_is_gso(skb) &&
+	    !ind_bufp->index && !netdev_xmit_more()) {
 		use_scrq_send_direct = true;
 		if (skb->ip_summed == CHECKSUM_PARTIAL &&
 		    skb_checksum_help(skb))
-- 
2.43.5


