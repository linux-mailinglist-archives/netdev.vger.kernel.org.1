Return-Path: <netdev+bounces-80181-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2834C87D5E4
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 21:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 978E41F26931
	for <lists+netdev@lfdr.de>; Fri, 15 Mar 2024 20:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DE55490B;
	Fri, 15 Mar 2024 20:55:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="tbFNiN7k"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D02295491B
	for <netdev@vger.kernel.org>; Fri, 15 Mar 2024 20:55:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710536157; cv=none; b=KSbXGMi57rfRaPTcioeYSVFVH3NA2kXbCEEMjJ2bvUADLI2erMakNWhBc4lAFYfjWhRSSWF2K5upXoMERc1MWZRYhwxClv/wzYMyRnc/kLQQUnQx5Vh4glFXpPu5uBp7QNVqs/IDb/HZrCsn5ScsjsHmtt+S8OuJr/o9AfhZHno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710536157; c=relaxed/simple;
	bh=hfNHhmDDWN+dbQdilshGCaxND4ISEcI0fHnTElzvT3w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=HrB6ZxiAL6cIf/qBaG3TZ1podfYTm9K7NdPfuVCqPHaULmuZ09CN2/VbWdRKsIXmuelxsoOcpo9LsxtADFQQjcJnTO/W+aSblpei/kSBnJgn5rBiLME55PNtbA8cMBjWUnrBVs8lBfQnpXRjWuTpd7/l8Per4pbVPEqkjLxBITI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=tbFNiN7k; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 42FKOLld029646;
	Fri, 15 Mar 2024 20:55:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=KD7Y6SiEoO4l2wX/2qtGPwmnQRqgUewSjIM7RObafeE=;
 b=tbFNiN7kPzWnPYD+6oG8qwlaLMupOvbtij8B/K0uMWN3lNsaBL4aNcgDqqTqCTEr/PLU
 acjut3VbcKjUC4n9vwpdgXjCdsMFEKXaltgNAWZ+W5jWPhVY1uOjUhPtqdmmTlJqTjPB
 45762/rdX98xe9gKpZ05WKE/WfxJ535JbVm4hsNbERFAXw3QkprbZx34l4tov02l93B3
 aujxtvJTxJrt744mu5XlN4j0XgpwZUKfa9iAgAdOChw4E66/E3Zp+nkiNSgWZUjoZ0/0
 0HMWhgfS/NLNGQ35Aokzd/RKcxCOxxYneHMdSDt9PiUS5+Xbf/DIvM3tJ/ZMgCuGreh+ cw== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvupm1egk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 20:55:48 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42FKs7B9022170;
	Fri, 15 Mar 2024 20:55:47 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wvupm1ege-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 20:55:47 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 42FJHHfH014394;
	Fri, 15 Mar 2024 20:55:46 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wvsyf1c48-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Mar 2024 20:55:46 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com [10.241.53.100])
	by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 42FKtegi25231734
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 15 Mar 2024 20:55:42 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7B2EA5805D;
	Fri, 15 Mar 2024 20:55:40 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0AEAA58058;
	Fri, 15 Mar 2024 20:55:39 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.67.38.237])
	by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 15 Mar 2024 20:55:38 +0000 (GMT)
From: Thinh Tran <thinhtr@linux.ibm.com>
To: jacob.e.keller@intel.com, kuba@kernel.org
Cc: netdev@vger.kernel.org, VENKATA.SAI.DUGGI@ibm.com, abdhalee@in.ibm.com,
        aelior@marvell.com, davem@davemloft.net, drc@linux.vnet.ibm.com,
        edumazet@google.com, manishc@marvell.com, pabeni@redhat.com,
        simon.horman@corigine.com, skalluru@marvell.com,
        Thinh Tran <thinhtr@linux.ibm.com>
Subject: [PATCH v11] net/bnx2x: Prevent access to a freed page in page_pool
Date: Fri, 15 Mar 2024 15:55:35 -0500
Message-Id: <20240315205535.1321-1-thinhtr@linux.ibm.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: a-qIHcp5xFqXAYzNiIYMTUt7bKQEvDYG
X-Proofpoint-ORIG-GUID: lhbyxyqgm3trt8Ti6WIHTzCvdUP38pxF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-15_07,2024-03-15_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 phishscore=0 clxscore=1011 bulkscore=0
 mlxscore=0 priorityscore=1501 impostorscore=0 malwarescore=0 spamscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403150167

Fix race condition leading to system crash during EEH error handling

During EEH error recovery, the bnx2x driver's transmit timeout logic
could cause a race condition when handling reset tasks. The
bnx2x_tx_timeout() schedules reset tasks via bnx2x_sp_rtnl_task(),
which ultimately leads to bnx2x_nic_unload(). In bnx2x_nic_unload()
SGEs are freed using bnx2x_free_rx_sge_range(). However, this could
overlap with the EEH driver's attempt to reset the device using
bnx2x_io_slot_reset(), which also tries to free SGEs. This race 
condition can result in system crashes due to accessing freed memory
locations in bnx2x_free_rx_sge()

799  static inline void bnx2x_free_rx_sge(struct bnx2x *bp,
800				struct bnx2x_fastpath *fp, u16 index)
801  {
802	struct sw_rx_page *sw_buf = &fp->rx_page_ring[index];
803     struct page *page = sw_buf->page;
....
where sw_buf was set to NULL after the call to dma_unmap_page() 
by the preceding thread.


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

Signed-off-by: Thinh Tran <thinhtr@linux.ibm.com>

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


