Return-Path: <netdev+bounces-223363-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9281FB58DF1
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 07:37:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B02CE7B048E
	for <lists+netdev@lfdr.de>; Tue, 16 Sep 2025 05:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C3A525743D;
	Tue, 16 Sep 2025 05:37:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="i2knMQ0e"
X-Original-To: netdev@vger.kernel.org
Received: from mx0b-00190b01.pphosted.com (mx0b-00190b01.pphosted.com [67.231.157.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AEC1223DF6
	for <netdev@vger.kernel.org>; Tue, 16 Sep 2025 05:37:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.157.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758001034; cv=none; b=kwThOzNOi+oJpQY3FdKBIWAXZR5p7lJqjQhbJyj+RNTOyerpZwBnRVu2JaL/vnKzSkACQl7Ei/9l+E/3Xgs03qDWazaII82UfRRwJfstLR+pwpKzGhaSXNEfcNF5Lm1XugSZPGu91+8OKaKqqXqHZVJkDcuvkCUAMwb6x1Jj9b8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758001034; c=relaxed/simple;
	bh=6n2+F+6WCeEdX7IBCd3sAzOpY2dA2TDymEX5m8E9vL8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=cHaF+2TcWtAnZINClUIgmqJwLhrMh952EUVFQKn6ltCR/lGP44gNgxXYMULam7G2LR3K1gvvmUO9uc1MD8n7inOU8jVpTB4ZYjnFYNXIiovSSMUsZ9bGqpRvKGJ8ZovYfPJ2sSF5HNvwY8zPxT8YQvDIDZDr/cRKjAlmxBDoxUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=i2knMQ0e; arc=none smtp.client-ip=67.231.157.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0050096.ppops.net [127.0.0.1])
	by m0050096.ppops.net-00190b01. (8.18.1.2/8.18.1.2) with ESMTP id 58G3jhpO013704;
	Tue, 16 Sep 2025 04:48:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=MzE24RzG3TGvfyXQs95e7HHxFLJkCbCCa
	v26MuCefMw=; b=i2knMQ0ep71edMbrU+xXADrsVWgJS+I1MqzNpm/eQQh+Aq7+N
	Nz0ZRpYVe0LSQTbOCoeEwm4re/U7szs02AjX9I3r9ipq37oFZY9AKuI99fZzEq4f
	ViwoEVL+rXd3HtDDhZEazJTdvVKVBf1qpMNvnDYk9pjlUJTF58sL918VrqAHtZ1J
	835KjRt6swxM1nxbQ+VbzqjowE0o0LjHV+kB6GO6KYeH5aM5+X4mKw/e3ul4yhho
	jh/YTg+vAS3v0xC0Ts9DhPq8FGKVM+83pBTfRa/f/Jdz55dRuwgKEldIeoQuDggV
	azGoSfOVZIvgzU401yBIamaUV2AH8P+QyvyUA==
Received: from prod-mail-ppoint6 (prod-mail-ppoint6.akamai.com [184.51.33.61])
	by m0050096.ppops.net-00190b01. (PPS) with ESMTPS id 496gst2m1k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 16 Sep 2025 04:48:58 +0100 (BST)
Received: from pps.filterd (prod-mail-ppoint6.akamai.com [127.0.0.1])
	by prod-mail-ppoint6.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 58FMJulB004097;
	Mon, 15 Sep 2025 23:48:57 -0400
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint6.akamai.com (PPS) with ESMTP id 495j1t6pwc-1;
	Mon, 15 Sep 2025 23:48:57 -0400
Received: from bos-lhv9ol.bos01.corp.akamai.com (bos-lhv9ol.bos01.corp.akamai.com [172.28.41.79])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 3900689;
	Tue, 16 Sep 2025 03:48:57 +0000 (UTC)
From: Jason Baron <jbaron@akamai.com>
To: davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
        pabeni@redhat.com
Cc: netdev@vger.kernel.org
Subject: [PATCH net] net: allow alloc_skb_with_frags() to use MAX_SKB_FRAGS
Date: Mon, 15 Sep 2025 23:48:41 -0400
Message-Id: <20250916034841.2317171-1-jbaron@akamai.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=801 adultscore=0
 suspectscore=0 mlxscore=0 bulkscore=0 malwarescore=0 spamscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2508110000 definitions=main-2509160035
X-Proofpoint-ORIG-GUID: uvAI5RuVY1yeEB6H4ccF8_D1VO7JAtHJ
X-Proofpoint-GUID: uvAI5RuVY1yeEB6H4ccF8_D1VO7JAtHJ
X-Authority-Analysis: v=2.4 cv=WeEMa1hX c=1 sm=1 tr=0 ts=68c8de2a cx=c_pps
 a=WPLAOKU3JHlOa4eSsQmUFQ==:117 a=WPLAOKU3JHlOa4eSsQmUFQ==:17
 a=yJojWOMRYYMA:10 a=X7Ea-ya5AAAA:8 a=NhSYdsD-4wXDxyF7mi0A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTE1MDA5NSBTYWx0ZWRfX2E0I6gdI7mHq
 4D9WfbrMWM0JbEid2e0+Hfdcydv0aRgaca5HHBR05vUdCRvl7pzXL7xwlCNOM/i97bm2yXYsTzC
 A9MHcRgnTRll56v9o3p9szBRs4yQ9bpLaZ7CgAG/DSvNn7vbYsR+P5ElRGBEg0uQrljkAn7M6vd
 TcpLoIdJ20kG62Ea9Ykezrq/VMZNVlqUvkg2cYT07bIs2b8Y+k5ovv0Ftl4NhVht2b+F38FVZT/
 PDKGoGqyL4k3fq5euOfvq5OVF3eTWC9aY3yxfZhVuvIYlQRke6HuDrY3I/GfV1Iexv3+nMtnS2z
 pW339pCocRwhJEB/cqzT6FYbxqXzhddEQSz/lsmuAxIGCdkJCYbu0T1KPz1nXvoY7TyLLWsY14m
 7+49ecAgExrWS+PuU6+yX50xLtRYjA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-16_01,2025-09-12_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 priorityscore=1501 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 adultscore=0 malwarescore=0 clxscore=1015 phishscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2508280000
 definitions=main-2509150095

Currently, alloc_skb_with_frags() will only fill (MAX_SKB_FRAGS - 1)
slots. I think it should use all MAX_SKB_FRAGS slots, as callers of
alloc_skb_with_frags() will size their allocation of frags based
on MAX_SKB_FRAGS.

Signed-off-by: Jason Baron <jbaron@akamai.com>
---
 net/core/skbuff.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 23b776cd9879..df942aca0617 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -6669,7 +6669,7 @@ struct sk_buff *alloc_skb_with_frags(unsigned long header_len,
 		return NULL;
 
 	while (data_len) {
-		if (nr_frags == MAX_SKB_FRAGS - 1)
+		if (nr_frags == MAX_SKB_FRAGS)
 			goto failure;
 		while (order && PAGE_ALIGN(data_len) < (PAGE_SIZE << order))
 			order--;
-- 
2.25.1


