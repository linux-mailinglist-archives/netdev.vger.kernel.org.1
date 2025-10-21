Return-Path: <netdev+bounces-231374-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 88AD5BF81E7
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 20:41:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B8DE74F5370
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 18:41:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769142417C6;
	Tue, 21 Oct 2025 18:41:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="e459gABJ"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E71CC1A2392
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 18:41:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.165.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761072088; cv=none; b=YtRUJwzzrqcYKAmyYD2nHRKIxqx7Rw4lBgldMScqNpFzOUr/uHXC4Z63JWde0io5MAmrYQZ+2XaWrl5d2kzjYnkw7SfgyIrzeO5UgODK+aXGbzw3cVNuE+sfVD+semMpuuhwQKcQHAiipMUz91rPmXPxZtvK+HSB0H9Wd3fG+7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761072088; c=relaxed/simple;
	bh=RvGTeeEPCH8UhJrkvj7R5VoW7jzZcipbUJLkT68cHmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OGrxhTEtYBxMWG6Gn4scdeSYC10offk6TK6bZwtm0TlUAR62jzsxMZXFCAyKphIQL7j6Yl7xqdAnsES10xMpQ53HLHV9QaSIebaGAWglo+5nzUQhY91zfFgvlUiBUESZtEsl11nRRxURWCQkg0WzW9NxsSQZyXzwKPkTKhax7v4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=e459gABJ; arc=none smtp.client-ip=205.220.165.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0333521.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59LHcc5S001979;
	Tue, 21 Oct 2025 18:41:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=corp-2025-04-25; bh=+pRwS
	y6ulWeC1IqnsQS8bnPvtmx0Q9D9xGrMDNT1qOw=; b=e459gABJxTYUWuRPNP17y
	A8CWsRT/VG4cr/++cIlJLZLtp10SONuCyRC2/HjMoz0kdPlw7irioi/2Jl/dKeKa
	ZEotoc4NGtIONpN7q/BGm2Kz03Igpv56NKHhzRr3BHgusUlKlTLCmXznKM4hLrWz
	wJGVoFLAoE82swWb0qzGwAHFBr7VzxXLxmNLtH3/sAUIZa6kGG+USXAuSYgWOcVJ
	bmc7rdczbw755Pz5a0qTUEddXD6uw8rpjfpCeHVGO5gLW+YSre8vWU96VVr9tEHt
	/zmDtKnIY05Z5YeJEJH/LCqj/v2VjiXUxzoGbhCMymjFesdTu6g4I8exh3A5ceu2
	w==
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.appoci.oracle.com [138.1.114.2])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 49v31d6cvj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 18:41:13 +0000 (GMT)
Received: from pps.filterd (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 59LGnBoF025371;
	Tue, 21 Oct 2025 18:41:13 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTPS id 49v1bc7et1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Oct 2025 18:41:13 +0000
Received: from phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 59LIfBlf014153;
	Tue, 21 Oct 2025 18:41:12 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by phxpaimrmta01.imrmtpd1.prodappphxaev1.oraclevcn.com (PPS) with ESMTP id 49v1bc7es9-2;
	Tue, 21 Oct 2025 18:41:12 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
        andrew+netdev@lunn.ch, kuba@kernel.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
        intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org
Cc: alok.a.tiwarilinux@gmail.com, alok.a.tiwari@oracle.com
Subject: [PATCH net-next 2/2] idpf: fix typos and correct doc comments in idpf driver
Date: Tue, 21 Oct 2025 11:40:55 -0700
Message-ID: <20251021184108.2390121-2-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
References: <20251021184108.2390121-1-alok.a.tiwari@oracle.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-21_02,2025-10-13_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 spamscore=0
 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510020000
 definitions=main-2510210149
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDE4MDAyMyBTYWx0ZWRfXzSmZe1HKZQY2
 0PFDQBcxG1HkbXJq+4AFpht137BxiCy4J+rSPlLNwKam42uPlIl1BpLpkMXW/KFoPv21tv7HibK
 iKoKqQQp1leelbmkypRTGyGu2EUHv/uVCKOKCsSWH9cTlH/+IqkclQcnLUNCSHcnn2O1W6jzfuS
 C+ECrTABWshyxDZRW/DgtmMbMuRz8HQN5tVe01O0mNj7RV5jvqboKGuxlg3bGYZeE6AhjwbTzzd
 OAFgrSTBkjfo6eqlgV4Oe+gGNEL7ATbABgHUJx2+APfmKFCKEmYt67ic3KQffDac13UXLbXe18A
 aOoaBrM+ndRhk5ZpOHDSlVnBMELNRN12mHBZ1rKKetb/YwQNhZGY2J9DYeCGiU53z0UHn79WO0S
 RM/Ck04gQQBWM36jPHJNC3iF2XBWog==
X-Proofpoint-GUID: YKTMMUfSzjDXF9dY4y-eCiM_8mQkoPiA
X-Authority-Analysis: v=2.4 cv=KoZAGGWN c=1 sm=1 tr=0 ts=68f7d3c9 cx=c_pps
 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:117 a=XiAAW1AwiKB2Y8Wsi+sD2Q==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=yPCof4ZbAAAA:8
 a=U-lh4RRolC2rDeatFzEA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: YKTMMUfSzjDXF9dY4y-eCiM_8mQkoPiA

- Corrected a typo: "controq" -> "control"
- Updated return value description to accurately reflect behaviour:
  changed "Returns true if there's any budget left" ->
  "Returns number of packets cleaned from this queue"

Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq.c     | 2 +-
 drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq.c b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
index 67894eda2d29..59558e2f45cf 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq.c
@@ -92,7 +92,7 @@ static void idpf_ctlq_init_rxq_bufs(struct idpf_ctlq_info *cq)
  * @hw: pointer to hw struct
  * @cq: pointer to the specific Control queue
  *
- * The main shutdown routine for any controq queue
+ * The main shutdown routine for any control queue
  */
 static void idpf_ctlq_shutdown(struct idpf_hw *hw, struct idpf_ctlq_info *cq)
 {
diff --git a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
index 61e613066140..ffc24a825129 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_singleq_txrx.c
@@ -1029,7 +1029,7 @@ static void idpf_xdp_run_pass(struct libeth_xdp_buff *xdp,
  * @rx_q: rx queue to clean
  * @budget: Total limit on number of packets to process
  *
- * Returns true if there's any budget left (e.g. the clean is finished)
+ * Returns number of packets cleaned from this queue
  */
 static int idpf_rx_singleq_clean(struct idpf_rx_queue *rx_q, int budget)
 {
-- 
2.50.1


