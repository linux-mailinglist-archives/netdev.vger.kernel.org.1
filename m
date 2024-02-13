Return-Path: <netdev+bounces-71498-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C20348539F6
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 19:33:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E1E9F1C22BA5
	for <lists+netdev@lfdr.de>; Tue, 13 Feb 2024 18:33:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60C84C8D2;
	Tue, 13 Feb 2024 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="U0hzwrdu"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22DC111A1
	for <netdev@vger.kernel.org>; Tue, 13 Feb 2024 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707849195; cv=none; b=C/PqosJKatFbsOPdbjVoUPmKP42KNh6dfnJfurBHWpRigh2Wbkolbe0IAMGfnn6bjV13XvWqlP2J5dBtBZzbPf5dq7cszYaAV1BBppO4odAUvwk37nSySOpZWG9/BSbB+ptqFi5QjsX4JP5DgCY8276RyJXEV1N8AAyKOF0Lu4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707849195; c=relaxed/simple;
	bh=LC6XxqmFM4KKHWeC00HvMPCSlAkwEBmHanqwkfXbpw4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=OVXzIHyMeyV5HH/yIqGcvByT/JJfPHzq+R0v+HdDsGFKLf2Br/yHcypVxEv/f2pQWy4gM8DEz7CG3ReikTRDC0hKg/OSRBov8bOv17H01eJrD0mY0U7TWgksbcxi422cNbJC7wl7uuBNPKfaX1Fv5Y1Ls9IeOVksRX55YwurwdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com; spf=none smtp.mailfrom=linux.vnet.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=U0hzwrdu; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.vnet.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.vnet.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 41DHTUMx006974;
	Tue, 13 Feb 2024 18:33:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=pp1;
 bh=Is5JKbi2K4Eo9oew8bX0De1jJLBosVgSu3olWLcq2kM=;
 b=U0hzwrduX+qlUD/TW13lIucmzWP1TnNLAIGPKXwBuvOFmcCxC/F9m5wFGA7ThnFmKrRb
 pbVTwtfPkAd9VylIo2QZqOTvO6aDE6c+Ul9imlWfG6HYzi9VwZ+EIEOgjE/0UM5I2xox
 xeVgcNjbZN8rttkrGU8Gm76mVWwCqmG7AnR9Nx+g7PL2SJlGcAgnXB7xto+6eAKBkd9Z
 nw/nBIai2U6wo4q0Q/xaLZLiJ653vE24C54jsFWd4PHz+RD/VdhFH3uS8YhPL/Coqvmq
 6fxbNNMu6wDtDBdTazo7GTRhGcAIYWg/wMbj3/FoUtzLTO1rZRTM4lQA94DHuZMm9rE0 kg== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8cd32caa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:33:06 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 41DI6wmm029778;
	Tue, 13 Feb 2024 18:33:06 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w8cd32c9p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:33:05 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 41DH0oMp032578;
	Tue, 13 Feb 2024 18:33:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w6kfthdeh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Feb 2024 18:33:04 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com [10.241.53.102])
	by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 41DIX0qI5571316
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Feb 2024 18:33:02 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6564258063;
	Tue, 13 Feb 2024 18:33:00 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DF9058056;
	Tue, 13 Feb 2024 18:32:59 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.41.99.4])
	by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Feb 2024 18:32:59 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.vnet.ibm.com>
To: kuba@kernel.org
Cc: netdev@vger.kernel.org, davem@davemloft.net, manishc@marvell.com,
        pabeni@redhat.com, skalluru@marvell.com, simon.horman@corigine.com,
        edumazet@google.com, VENKATA.SAI.DUGGI@ibm.com, drc@linux.vnet.ibm.com,
        abdhalee@in.ibm.com, thinhtr@linux.vnet.ibm.com
Subject: [PATCH v10 1/2] net/bnx2x: Prevent access to a freed page in page_pool
Date: Tue, 13 Feb 2024 12:32:45 -0600
Message-Id: <f6b3a268be868e9a528f2549392bf2bdf16e285d.1707848297.git.thinhtr@linux.vnet.ibm.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
References: <cover.1707848297.git.thinhtr@linux.vnet.ibm.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: _MlSUEsAKv2KXz_J05NttTY_2v4aileM
X-Proofpoint-GUID: qBL9BrrtkrIpMzzqPRlMLQsiq4rZwe0i
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-13_10,2024-02-12_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 mlxscore=0 malwarescore=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 mlxlogscore=878 impostorscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402130146

Fix race condition leading to system crash during EEH error handling

During EEH error recovery, the bnx2x driver's transmit timeout logic
could cause a race condition when handling reset tasks. The
bnx2x_tx_timeout() schedules reset tasks via bnx2x_sp_rtnl_task(),
which ultimately leads to bnx2x_nic_unload(). In bnx2x_nic_unload()
SGEs are freed using bnx2x_free_rx_sge_range(). However, this could
overlap with the EEH driver's attempt to reset the device using
bnx2x_io_slot_reset(), which also frees SGEs. This race condition can
result in system crashes due to accessing freed memory locations.

[  793.003930] EEH: Beginning: 'slot_reset'
[  793.003937] PCI 0011:01:00.0#10000: EEH: Invoking bnx2x->slot_reset()
[  793.003939] bnx2x: [bnx2x_io_slot_reset:14228(eth1)]IO slot reset initializing...
[  793.004037] bnx2x 0011:01:00.0: enabling device (0140 -> 0142)
[  793.008839] bnx2x: [bnx2x_io_slot_reset:14244(eth1)]IO slot reset --> driver unload
[  793.122134] Kernel attempted to read user page (0) - exploit attempt? (uid: 0)
[  793.122143] BUG: Kernel NULL pointer dereference on read at 0x00000000
[  793.122147] Faulting instruction address: 0xc0080000025065fc
[  793.122152] Oops: Kernel access of bad area, sig: 11 [#1]
.....
[  793.122315] Call Trace:
[  793.122318] [c000000003c67a20] [c00800000250658c] bnx2x_io_slot_reset+0x204/0x610 [bnx2x] (unreliable)
[  793.122331] [c000000003c67af0] [c0000000000518a8] eeh_report_reset+0xb8/0xf0
[  793.122338] [c000000003c67b60] [c000000000052130] eeh_pe_report+0x180/0x550
[  793.122342] [c000000003c67c70] [c00000000005318c] eeh_handle_normal_event+0x84c/0xa60
[  793.122347] [c000000003c67d50] [c000000000053a84] eeh_event_handler+0xf4/0x170
[  793.122352] [c000000003c67da0] [c000000000194c58] kthread+0x1c8/0x1d0
[  793.122356] [c000000003c67e10] [c00000000000cf64] ret_from_kernel_thread+0x5c/0x64

To solve this issue, we need to verify page pool allocations before
freeing.

Fixes: 4cace675d687 ("bnx2x: Alloc 4k fragment for each rx ring buffer element")

Signed-off-by: Thinh Tran <thinhtr@linux.vnet.ibm.com>


---
 drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
index d8b1824c334d..0bc1367fd649 100644
--- a/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
+++ b/drivers/net/ethernet/broadcom/bnx2x/bnx2x_cmn.h
@@ -1002,9 +1002,6 @@ static inline void bnx2x_set_fw_mac_addr(__le16 *fw_hi, __le16 *fw_mid,
 static inline void bnx2x_free_rx_mem_pool(struct bnx2x *bp,
 					  struct bnx2x_alloc_pool *pool)
 {
-	if (!pool->page)
-		return;
-
 	put_page(pool->page);
 
 	pool->page = NULL;
@@ -1015,6 +1012,9 @@ static inline void bnx2x_free_rx_sge_range(struct bnx2x *bp,
 {
 	int i;
 
+	if (!fp->page_pool.page)
+		return;
+
 	if (fp->mode == TPA_MODE_DISABLED)
 		return;
 
-- 
2.25.1


