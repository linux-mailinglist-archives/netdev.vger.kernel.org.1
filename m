Return-Path: <netdev+bounces-224603-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DF5DB86C1C
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 21:49:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5A70B7A93AE
	for <lists+netdev@lfdr.de>; Thu, 18 Sep 2025 19:47:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 103B62D8DD4;
	Thu, 18 Sep 2025 19:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b="PDuQ5ErG"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F2DB2D6401
	for <netdev@vger.kernel.org>; Thu, 18 Sep 2025 19:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.177.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758224945; cv=none; b=IWRK2MpEB5upiwCOWalCTEAfE+AERg0R3wAi4QqHuFk5KkzufaqtOKn60/44yB5OQsWCw0jyCl5YRR6eEHHGp38yWq+wemADsaaVr1sBNM7jyWMDv/nAe4xZWp7M7stvyM1iB0IvlkFrGHpeks6FqMT6C3I9q0a/dzOz4tEAGbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758224945; c=relaxed/simple;
	bh=KUt7EboCdSFy3JaqFb2Zzm0rgiRoBnLLm9z65x/EYeY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qu1dFQLliWRrORqmtAs+otSkZY0lSfsPKaeEuwyxXe1fSoc5aj8gCrwYhgOhQI0AeETSnqeWHrxbTHL0kY5EeJXb2WBK+z/MxU0JsoFD47Y1oR1++pYfuKf4utu8GvSS0IH1rNn+axunZVGAiVQhUsPl+D/fSPcaMb7F0vjCueA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com; spf=pass smtp.mailfrom=oracle.com; dkim=pass (2048-bit key) header.d=oracle.com header.i=@oracle.com header.b=PDuQ5ErG; arc=none smtp.client-ip=205.220.177.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=oracle.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=oracle.com
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
	by mx0b-00069f02.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 58IGMvKO029860;
	Thu, 18 Sep 2025 19:48:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=corp-2025-04-25; bh=dfaVHNGKRnB1zjTR+0VsKsaxchOR9
	BG369ZO7ueAt8U=; b=PDuQ5ErGI2QQA5ywFVjbBCuqlQJneLTUwR+0mQRQXJ6Hq
	wLwWJY819qh08ewwQjJ1UVznDYc0hAoG8GF/EjrPCieUizOOnojxeqJy9w57biZy
	pJnnEGR9otQo0H5q6HEL5azObSXTGny4bDfzxH4LaAo9EYdDoB1rCU0tgS9CWQ8y
	6MysHeKGD/x3tOlFJ7KAxn7+SUCmljK+5d2RWnuvq7BZ1WQhDe1S1/gbzPXJj8yZ
	vKwTWNUElpwK2m6ukE5uXr4eMWDBw7YKSQNzTOugQFtGjAkmGm/mILsxEOuZip4N
	oZukBTgt2jCRl6onxPQUKBZpDHl+2c/b6Mn6rdHBw==
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.appoci.oracle.com [147.154.18.20])
	by mx0b-00069f02.pphosted.com (PPS) with ESMTPS id 497fxd47xt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 19:48:50 +0000 (GMT)
Received: from pps.filterd (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (8.18.1.2/8.18.1.2) with ESMTP id 58IILeGl035094;
	Thu, 18 Sep 2025 19:48:50 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTPS id 494y2nxbva-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 18 Sep 2025 19:48:50 +0000
Received: from iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 58IJi0Mh008266;
	Thu, 18 Sep 2025 19:48:49 GMT
Received: from ca-dev112.us.oracle.com (ca-dev112.us.oracle.com [10.129.136.47])
	by iadpaimrmta02.imrmtpd1.prodappiadaev1.oraclevcn.com (PPS) with ESMTP id 494y2nxbty-1;
	Thu, 18 Sep 2025 19:48:49 +0000
From: Alok Tiwari <alok.a.tiwari@oracle.com>
To: sankararaman.jayaraman@broadcom.com, ajay.kaher@broadcom.com,
        ronak.doshi@broadcom.com, bcm-kernel-feedback-list@broadcom.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
        netdev@vger.kernel.org
Cc: alok.a.tiwari@oracle.com
Subject: [PATCH net] vmxnet3: remove incorrect register dump of RX data ring
Date: Thu, 18 Sep 2025 12:46:49 -0700
Message-ID: <20250918194844.1946640-1-alok.a.tiwari@oracle.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-18_02,2025-09-18_02,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 bulkscore=0 suspectscore=0 mlxlogscore=999 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2508110000
 definitions=main-2509180177
X-Proofpoint-GUID: jVVDYr8KJkqXvL6G7yLU8ntpM4kBcmRr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE2MDIwMiBTYWx0ZWRfX4PM+coQvm398
 4QCto4HVCg6TrFWSMRMl4vIy30kAIj5kczB1AGdPr+iA8pP0sRHnTHNMhqNZRYaLbmiCBljS+v0
 /ioHYWdj9uWF6MBi8Oae+aNG8oJwDbZqX2C8IWBAltDpd3DS+Sww2S5L8MT2h6a5HTzIj7QZOlF
 NYy2wSOXTyfzTU+Io0ZHX3PyRrBEpYk21kwpMKz+j9v1nlPByCojrnbDAdytaxm85I9YE2Pl0Dk
 MLS14FA4Edh5yq821vrLNjmawmeGOIVUJmWcE6YMW0FVOYdQKVger8FtTp+QZlvqQZhQR5CT/Kz
 nUZg0335a+kXAGfHNTy5+n31ZvvgGG8cKNaJ0CtYIrdJ9WLZJd0ftBYg8k/Xkdj6/MKAwni1fFL
 7NnmLFV0h4x4ktPBnA6FWc6nhC4enA==
X-Authority-Analysis: v=2.4 cv=cerSrmDM c=1 sm=1 tr=0 ts=68cc6223 b=1 cx=c_pps
 a=e1sVV491RgrpLwSTMOnk8w==:117 a=e1sVV491RgrpLwSTMOnk8w==:17
 a=yJojWOMRYYMA:10 a=yPCof4ZbAAAA:8 a=qPOv6JDsv7PWW1c7V-cA:9 cc=ntf
 awl=host:13614
X-Proofpoint-ORIG-GUID: jVVDYr8KJkqXvL6G7yLU8ntpM4kBcmRr

The ethtool get_regs() implementation incorrectly dumps
rq->rx_ring[0].size in the RX data ring section. rq->rx_ring[0].size
belongs to the RX descriptor ring, not the data ring, and is already
reported earlier. The RX data ring only defines desc_size, which is
already exported.

Remove the redundant and invalid rq->rx_ring[0].size dump to avoid
confusing or misleading ethtool -d output.

Fixes: b6bd9b5448a9 ("Driver: Vmxnet3: Extend register dump support")
Signed-off-by: Alok Tiwari <alok.a.tiwari@oracle.com>
---
 drivers/net/vmxnet3/vmxnet3_ethtool.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/net/vmxnet3/vmxnet3_ethtool.c b/drivers/net/vmxnet3/vmxnet3_ethtool.c
index cc4d7573839d..82f5a6156178 100644
--- a/drivers/net/vmxnet3/vmxnet3_ethtool.c
+++ b/drivers/net/vmxnet3/vmxnet3_ethtool.c
@@ -598,7 +598,6 @@ vmxnet3_get_regs(struct net_device *netdev, struct ethtool_regs *regs, void *p)
 
 		buf[j++] = VMXNET3_GET_ADDR_LO(rq->data_ring.basePA);
 		buf[j++] = VMXNET3_GET_ADDR_HI(rq->data_ring.basePA);
-		buf[j++] = rq->rx_ring[0].size;
 		buf[j++] = rq->data_ring.desc_size;
 
 		buf[j++] = VMXNET3_GET_ADDR_LO(rq->comp_ring.basePA);
-- 
2.50.1


