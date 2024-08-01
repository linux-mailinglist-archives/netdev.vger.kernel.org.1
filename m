Return-Path: <netdev+bounces-115131-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BDC1C945419
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 23:24:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 49F2D1F239D9
	for <lists+netdev@lfdr.de>; Thu,  1 Aug 2024 21:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DE0A14C583;
	Thu,  1 Aug 2024 21:23:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="Up6MUe6E"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54B161482E2
	for <netdev@vger.kernel.org>; Thu,  1 Aug 2024 21:23:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722547436; cv=none; b=V9A0MYxWrVhSphWaHvadZi/UflEmUPNeYbpTSAC3xf/nMCEKhh9VWpVPGFmgkiK6vIaSJiEeNBPRRpBHvAKJnmxgCmb+ZLuiEYOsQZJv8gXVarVPnsNEC/lMHTh0mbxdl3ofQbB2BpNicaHTeD8JjOXPVYTMg4NZhj+Z23F02eA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722547436; c=relaxed/simple;
	bh=5aRgmwjzDXGtjq+Vbl0Pa8AXRWww+jkev0i51c5eepY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oo+Be+K/aKFF+AAfnzSr4kfwFNsqWOzw6e5dDzm4ydKEhevsZDfG7VHWOHprJWZzA56EuK/5Rs6hBfcd/PAlb8rziCQSO7es2CP49HtQ+W4iOGE33clQC21WW6+MaCL3sSKxvSJHtSicRzBdj8npsVVqoBi2G+cw39mhpUo5Dqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=Up6MUe6E; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 471KmUH8015440
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from
	:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding; s=pp1; bh=QIAYAXrsT1CXG
	d3IRy+2NikBB5/uSeba2Bjjl1+FiqE=; b=Up6MUe6Eg6//FTtL1e+Wb740PwaPR
	Gcam78esvec1Wu7+KTCWxjHz0gRs2xECkcoYueCsSRtFasHGZw9sSrZoNw1xc8ko
	aByMInbQvjLMcEAmsn5xqi5M0mV15sv5RcNrm7pHolyS4yGbGPf5JSLAxPJbHTs+
	kN78rbeIKCGQG/ZzjQg1Y0EuPS8sg3kYIh/cPOB1o2SUuuwgK18GWgSvtae79eg9
	7t2oIfjSZNTA0NWjJaLxzrQjus52H04hzuZQo1bKqmi9hmFSSNLoUfFgFqjDsF63
	rbNq3GScqFmYSKhA9w2YQhYfk+7Ych/UFyVYOg9EFObQnvyFF8CNnaYkg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 40rhe4g3pf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:52 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 471IEYPZ029100
	for <netdev@vger.kernel.org>; Thu, 1 Aug 2024 21:23:50 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40nbm1449q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <netdev@vger.kernel.org>; Thu, 01 Aug 2024 21:23:50 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com [10.39.53.229])
	by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 471LNihq23331460
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 21:23:46 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8CAB558060;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 430765805C;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
Received: from tinkpad.ibmuc.com (unknown [9.61.139.48])
	by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Aug 2024 21:23:44 +0000 (GMT)
From: Nick Child <nnac123@linux.ibm.com>
To: netdev@vger.kernel.org
Cc: bjking1@linux.ibm.com, haren@linux.ibm.com, ricklind@us.ibm.com,
        Nick Child <nnac123@linux.ibm.com>
Subject: [PATCH net-next 1/7] ibmvnic: Only replenish rx pool when resources are getting low
Date: Thu,  1 Aug 2024 16:23:34 -0500
Message-ID: <20240801212340.132607-2-nnac123@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240801212340.132607-1-nnac123@linux.ibm.com>
References: <20240801212340.132607-1-nnac123@linux.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: gFiAMetgtcDV0PcEmu0wBFrUxfzrWsHO
X-Proofpoint-GUID: gFiAMetgtcDV0PcEmu0wBFrUxfzrWsHO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-01_18,2024-08-01_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=566 phishscore=0
 clxscore=1015 impostorscore=0 malwarescore=0 mlxscore=0 bulkscore=0
 lowpriorityscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2407110000 definitions=main-2408010142

Previously, the driver would replenish the rx pool if the polling
function consumed less than the budget. The logic being that the driver
did not exhaust its budget so that must mean that the driver is not busy
and has cycles to spare for replenishing the pool.

So pool replenishment happens on every poll which did not consume
the budget. This can very costly during request-response tests.

In fact, an extra ~100pps can be seen in TCP_RR_150 tests when we remove
this conditional. Trace results (ftrace, graph-time=1) for the poll
function are below:
Previous results:
    ibmvnic_poll = 64951846.0 us / 4167628.0 hits = AVG 15.58
    replenish_rx_pool = 17602846.0 us / 4710437.0 hits = AVG 3.74
Now:
    ibmvnic_poll = 57673941.0 us / 4791737.0 hits = AVG 12.04
    replenish_rx_pool = 3938171.6 us / 4314.0 hits = AVG 912.88

While the replenish function takes longer, it is hit less frequently
meaning the ibmvnic_poll function, on average, is faster.

Furthermore, this change does not have a negative effect on
performance bandwidth/latency measurements.

Signed-off-by: Nick Child <nnac123@linux.ibm.com>
---
 drivers/net/ethernet/ibm/ibmvnic.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/ibm/ibmvnic.c b/drivers/net/ethernet/ibm/ibmvnic.c
index 23ebeb143987..857d585bd229 100644
--- a/drivers/net/ethernet/ibm/ibmvnic.c
+++ b/drivers/net/ethernet/ibm/ibmvnic.c
@@ -3527,9 +3527,8 @@ static int ibmvnic_poll(struct napi_struct *napi, int budget)
 	}
 
 	if (adapter->state != VNIC_CLOSING &&
-	    ((atomic_read(&adapter->rx_pool[scrq_num].available) <
-	      adapter->req_rx_add_entries_per_subcrq / 2) ||
-	      frames_processed < budget))
+	    (atomic_read(&adapter->rx_pool[scrq_num].available) <
+	      adapter->req_rx_add_entries_per_subcrq / 2))
 		replenish_rx_pool(adapter, &adapter->rx_pool[scrq_num]);
 	if (frames_processed < budget) {
 		if (napi_complete_done(napi, frames_processed)) {
-- 
2.43.0


