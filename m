Return-Path: <netdev+bounces-198430-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4ECADC276
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 08:34:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDF7B3AB9DD
	for <lists+netdev@lfdr.de>; Tue, 17 Jun 2025 06:34:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2D7A28B503;
	Tue, 17 Jun 2025 06:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b="eKF33h08"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 147C016B3B7;
	Tue, 17 Jun 2025 06:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.148.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750142066; cv=none; b=CQj2bWj46NiVM1JnRaVrePEAMCUzKn+D0niu3voH2A8wBhJRtGhEfiUhSj+92fnT1qGg1UIjhzhNFGsQ+WLITDC86TpvPjAd0sjS9EdLg2VsLjFQBX8t/rQhGkOXrxOJ4AsJdBxffI+pBFICh/QUjenjYTsHIzlOMyMqmawCLxk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750142066; c=relaxed/simple;
	bh=waS7//7mESOoJ0KPrUPjr8RYE0ggAPYjN8HDSpBN9fU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SBFDUZX6U0jriUd3ipBBGmr6tYnfd1RwXoWGGM8OWwK6ik6zghaj9bOEyzg8rssyYFl8/k/Z/6qA4y5rTibzR6vPapKkoxNeChU5UEKD20gBPiGWSNjlviOH/5UMgDsp6pbBq8PyakeWPKiLrqi5w2A5xfqLdYM+KBIwkW+yvK4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com; spf=pass smtp.mailfrom=marvell.com; dkim=pass (2048-bit key) header.d=marvell.com header.i=@marvell.com header.b=eKF33h08; arc=none smtp.client-ip=67.231.148.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=marvell.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=marvell.com
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
	by mx0a-0016f401.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55GNXmk7031454;
	Mon, 16 Jun 2025 23:34:12 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=pfpt0220; bh=AV2HzGw9EyINSKLyYtsSssn
	pW4NDyvKSwe7LrSIKmic=; b=eKF33h08JZlWHXP+4zMpn36crA1zadCAX9EkV8e
	URn2OPMFax00VtM8bKrCWyPrJAH2hncKpjLI4gVoalYK12J0Hb/GUc6YN7fQM44A
	wVSU9atmIxSlsBq3+3fIAk0APszvxSpCN1lhYCMJbBsFicWPHh9C+DcpNgpE5urB
	04zK4AeLFoeeAlxjozte0L2SbQ6sq53wguNzGkeSe99B/1EiOPIywxtmFLn6n1B5
	VGlTe0fqv81xhEOW3hIuI87/JlXHgSdrKZiIPEkt3TFbVMGNLETj9Tgh7fbt8pPR
	xRM0pcx+ZCJFDj53caVjXwi/z88OJzgCmjyCCNtAry+7rOA==
Received: from dc5-exch05.marvell.com ([199.233.59.128])
	by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 47aw21rpta-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 16 Jun 2025 23:34:12 -0700 (PDT)
Received: from DC5-EXCH05.marvell.com (10.69.176.209) by
 DC5-EXCH05.marvell.com (10.69.176.209) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Mon, 16 Jun 2025 23:34:11 -0700
Received: from maili.marvell.com (10.69.176.80) by DC5-EXCH05.marvell.com
 (10.69.176.209) with Microsoft SMTP Server id 15.2.1544.4 via Frontend
 Transport; Mon, 16 Jun 2025 23:34:11 -0700
Received: from test-OptiPlex-Tower-Plus-7010.marvell.com (unknown [10.29.37.157])
	by maili.marvell.com (Postfix) with ESMTP id 9F6E562676B;
	Mon, 16 Jun 2025 23:34:07 -0700 (PDT)
From: Hariprasad Kelam <hkelam@marvell.com>
To: <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: Hariprasad Kelam <hkelam@marvell.com>,
        Sunil Goutham
	<sgoutham@marvell.com>,
        Geetha sowjanya <gakula@marvell.com>,
        "Subbaraya
 Sundeep" <sbhatta@marvell.com>,
        Bharat Bhushan <bbhushan2@marvell.com>,
        "Andrew Lunn" <andrew+netdev@lunn.ch>,
        "David S. Miller"
	<davem@davemloft.net>,
        "Eric Dumazet" <edumazet@google.com>,
        Jakub Kicinski
	<kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>
Subject: [net] Octeontx2-pf: Fix Backpresure configuration
Date: Tue, 17 Jun 2025 12:04:02 +0530
Message-ID: <20250617063403.3582210-1-hkelam@marvell.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-GUID: hJvi0UwyBlPuEQToEF_8xjL_R591C_iW
X-Proofpoint-ORIG-GUID: hJvi0UwyBlPuEQToEF_8xjL_R591C_iW
X-Authority-Analysis: v=2.4 cv=DfMXqutW c=1 sm=1 tr=0 ts=68510c64 cx=c_pps a=rEv8fa4AjpPjGxpoe8rlIQ==:117 a=rEv8fa4AjpPjGxpoe8rlIQ==:17 a=6IFa9wvqVegA:10 a=M5GUcnROAAAA:8 a=cIFZUDyxDlkkEMaN0r4A:9 a=OBjm3rFKGHvpk9ecZwUJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjE3MDA1MiBTYWx0ZWRfX43+QRQoJQsNI t9vpXvjvDE46T1s4+fiqNA/GDkVe7t4Nwv0QNQKm3Ocrko8sgBd52nAnQYTz00Qbf07Jq36b/3R SxV5GFrn8qwLekr1gPxVMXgBrIdMFUZOf1KdJ8zpz92zKNnsWZ/Xu0RLX7EtR6fvik7XE/AOFjg
 BlVHXN4qrIhZsb8+PEsLbBPPtgqlmQQCx2Jp/l/1KF2vvbh5aHlT8hdC7cPF14VWXC9rq0Gi6Bx XAKOmOnXWSUWTQ5jN3/bLP50Qo86AgJNYhB8q2eyw5HBk4Q+swiFFWwz60eZnzRxhY+1QzFBHpv fASbeS/brH1Q3iGcrG3N5A6EhlKbd0XaHS8PWYH+k5MKpWL9fHgnLyO3FUuZP2Lru4LtbsaKmGt
 ZoejZ5GoUcb/4hG9z4fYT3MzPukFPIFaSrpaZxmu5tGpbbaWEzIcFoSv9rDVHcE99vRK/STg
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-17_02,2025-06-13_01,2025-03-28_01

NIX block can receive packets from multiple links such as
MAC (RPM), LBK and CPT.

       -----------------
 RPM --|     NIX       |
       -----------------
             |
             |
            LBK

Each link supports multiple channels for example RPM link supports
16 channels. In case of link oversubsribe, NIX will assert backpressure
on receive channels.

The previous patch considered a single channel per link, resulting in
backpressure not being enabled on the remaining channels

Fixes: a7ef63dbd588 ("octeontx2-af: Disable backpressure between CPT and NIX")
Signed-off-by: Hariprasad Kelam <hkelam@marvell.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
index 6f572589f1e5..6b5c9536d26d 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.c
@@ -1822,7 +1822,7 @@ int otx2_nix_config_bp(struct otx2_nic *pfvf, bool enable)
 		req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
 		req->bpid_per_chan = 1;
 	} else {
-		req->chan_cnt = 1;
+		req->chan_cnt = pfvf->hw.rx_chan_cnt;
 		req->bpid_per_chan = 0;
 	}
 
@@ -1847,7 +1847,7 @@ int otx2_nix_cpt_config_bp(struct otx2_nic *pfvf, bool enable)
 		req->chan_cnt = IEEE_8021QAZ_MAX_TCS;
 		req->bpid_per_chan = 1;
 	} else {
-		req->chan_cnt = 1;
+		req->chan_cnt = pfvf->hw.rx_chan_cnt;
 		req->bpid_per_chan = 0;
 	}
 
-- 
2.34.1


