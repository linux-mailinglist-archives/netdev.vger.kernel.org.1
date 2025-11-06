Return-Path: <netdev+bounces-236432-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D46AC3C2CB
	for <lists+netdev@lfdr.de>; Thu, 06 Nov 2025 16:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5B5414E7DFF
	for <lists+netdev@lfdr.de>; Thu,  6 Nov 2025 15:51:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ADDE3321CE;
	Thu,  6 Nov 2025 15:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b="kwkmwFnA"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00190b01.pphosted.com (mx0a-00190b01.pphosted.com [67.231.149.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B025D2848BB;
	Thu,  6 Nov 2025 15:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.149.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762444262; cv=none; b=qrF75yVYO67GHUoSZMiuy6HRbuVw3HTyZ1+l4xWXUBXH8Quw9GzgUjwGm8PD3bVTbXEqmT2SDjBOYuSuRRBfwXKIgO4TwKIj9VdWecdmauyX4WNyvpj6TxYmGcjDElp7Xh1hBULvGfkofqU/KuFKZac9ZLCGsq8xugc1tY5hzm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762444262; c=relaxed/simple;
	bh=jomUrgYc9xgbDApjQkV5XS/9o90uPMm+ByzWfZNCXXo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hQUmCrVWxianfn9DUafi8uDfrqE7qKWo8ZjvBR9ywnA6fuJV7p9tiQw08sYO+e9q36IeFSWFuy+qpfeSOR+CLplOoRfVWoQ+avU97yOfOvw1cRgMeLUkDVjxz1XHf7c8eS4gslqwROoyjFUfNDf46NHJI/NQpec0monvzxO4YX0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com; spf=pass smtp.mailfrom=akamai.com; dkim=pass (2048-bit key) header.d=akamai.com header.i=@akamai.com header.b=kwkmwFnA; arc=none smtp.client-ip=67.231.149.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=akamai.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=akamai.com
Received: from pps.filterd (m0409409.ppops.net [127.0.0.1])
	by m0409409.ppops.net-00190b01. (8.18.1.11/8.18.1.11) with ESMTP id 5A67bMl52441394;
	Thu, 6 Nov 2025 15:50:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=akamai.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=jan2016.eng; bh=jWcYnZUprnC8Bonm7kotjCeKQDsqwwK8o
	CJh2WFE+J8=; b=kwkmwFnA8Bs2fJLzKkDV4d9Yd0wPlPilq/YsFulTpE/tb/ZIS
	4Pj09IF2pNG0K9RoZtxSzmP3thr5C8QslLQ1bTtnzh2FHLobzreCnFfZaZwwpF5x
	I5ZPPC4MTUrm47cTsXYq+J9pmq4A/rQmy4XmYZobLHXM60D3xDG4M+XxLFAAIOYg
	es0Eip0wgbsJtEL1mFvjdugN/w14pXTu+2pCUg8VAgRiH6lyYHINQ7SeBvLlAUgq
	6ZdRnzuABENE7s4hTg19Kf18MowWNq6MGP3DcYtaoQ+J2TAFj7ekBCBVVKhoW2gi
	1CxejJHt2/JRbFgJ0FT11zQIr0P5usBL8aO6Q==
Received: from prod-mail-ppoint1 (prod-mail-ppoint1.akamai.com [184.51.33.18])
	by m0409409.ppops.net-00190b01. (PPS) with ESMTPS id 4a8b3yam9f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Nov 2025 15:50:35 +0000 (GMT)
Received: from pps.filterd (prod-mail-ppoint1.akamai.com [127.0.0.1])
	by prod-mail-ppoint1.akamai.com (8.18.1.2/8.18.1.2) with ESMTP id 5A6FB8AO012867;
	Thu, 6 Nov 2025 10:50:34 -0500
Received: from prod-mail-relay01.akamai.com ([172.27.118.31])
	by prod-mail-ppoint1.akamai.com (PPS) with ESMTP id 4a8x37g5d2-1;
	Thu, 06 Nov 2025 10:50:33 -0500
Received: from muc-lhvdhd.munich.corp.akamai.com (muc-lhvdhd.munich.corp.akamai.com [172.29.1.160])
	by prod-mail-relay01.akamai.com (Postfix) with ESMTP id 5226E80;
	Thu,  6 Nov 2025 15:50:32 +0000 (UTC)
From: Nick Hudson <nhudson@akamai.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
        Jason Wang <jasowang@redhat.com>, Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>
Cc: Nick Hudson <nhudson@akamai.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] tun: use skb_attempt_defer_free in tun_do_read
Date: Thu,  6 Nov 2025 15:50:07 +0000
Message-Id: <20251106155008.879042-1-nhudson@akamai.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 bulkscore=0 phishscore=0
 mlxlogscore=999 suspectscore=0 malwarescore=0 adultscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2510240000
 definitions=main-2511060125
X-Proofpoint-GUID: NDJTtRlnsc21hUfiTLP6ar_OE_3heU_E
X-Authority-Analysis: v=2.4 cv=VZL6/Vp9 c=1 sm=1 tr=0 ts=690cc3cb cx=c_pps
 a=StLZT/nZ0R8Xs+spdojYmg==:117 a=StLZT/nZ0R8Xs+spdojYmg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=Zt7HYAVMxCZQc_9Cv-EA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTA2MDEyNiBTYWx0ZWRfX8smhO4luLpM/
 /mSSVWegeEqNEcEgu5Oie6IZ4Qw2oOXtBfe254hTsVY8IOYPc8W6rmcPmwK/h476w8NJK3NMfCM
 jBqmxYIFiJE7qQuyzvkXMCzc8W7n9miFTYU+8TsCpsZHHVDTSks5uHQCFFxGcMLRstaqkFAP+AY
 0EbQAzcNU1mS4KEjwIfckVoXGO3KpUiO5UJE2xPNigBGgP+7UD1SdZrdM73O+ypx+2ffZydCcc3
 osN1j4Evp4VKfnlAfiwS9/jmNO4KmGkXYGUj5WH5YVXQ9V+PoQBKSn/zqnBIgfl/tA9k8bkFawG
 47gX0rbnlRSPVLCwDXejsVd2yvMvbS0jdU7ObKJKX+6RSEbqb4IYE8Bj6WVgZet5Quff0jbKPtF
 ebQvoeAxHe6RsGCtUAE2AC1nLCM9zA==
X-Proofpoint-ORIG-GUID: NDJTtRlnsc21hUfiTLP6ar_OE_3heU_E
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-06_03,2025-11-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0
 clxscore=1011 malwarescore=0 bulkscore=0 priorityscore=1501 suspectscore=0
 adultscore=0 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2510240001 definitions=main-2511060126

On a 640 CPU system running virtio-net VMs with the vhost-net driver, and
multiqueue (64) tap devices testing has shown contention on the zone lock
of the page allocator.

A 'perf record -F99 -g sleep 5' of the CPUs where the vhost worker threads run shows

    # perf report -i perf.data.vhost --stdio --sort overhead  --no-children | head -22
    ...
    #
       100.00%
                |
                |--9.47%--queued_spin_lock_slowpath
                |          |
                |           --9.37%--_raw_spin_lock_irqsave
                |                     |
                |                     |--5.00%--__rmqueue_pcplist
                |                     |          get_page_from_freelist
                |                     |          __alloc_pages_noprof
                |                     |          |
                |                     |          |--3.34%--napi_alloc_skb
    #

That is, for Rx packets
- ksoftirqd threads pinned 1:1 to CPUs do SKB allocation.
- vhost-net threads float across CPUs do SKB free.

One method to avoid this contention is to free SKB allocations on the same
CPU as they were allocated on. This allows freed pages to be placed on the
per-cpu page (PCP) lists so that any new allocations can be taken directly
from the PCP list rather than having to request new pages from the page
allocator (and taking the zone lock).

Fortunately, previous work has provided all the infrastructure to do this
via the skb_attempt_defer_free call which this change uses instead of
consume_skb in tun_do_read.

Testing done with a 6.12 based kernel and the patch ported forward.

Server is Dual Socket AMD SP5 - 2x AMD SP5 9845 (Turin) with 2 VMs
Load generator: iPerf2 x 1200 clients MSS=400

Before:
Maximum traffic rate: 55Gbps

After:
Maximum traffic rate 110Gbps
---
 drivers/net/tun.c | 2 +-
 net/core/skbuff.c | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 8192740357a0..388f3ffc6657 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -2185,7 +2185,7 @@ static ssize_t tun_do_read(struct tun_struct *tun, struct tun_file *tfile,
 		if (unlikely(ret < 0))
 			kfree_skb(skb);
 		else
-			consume_skb(skb);
+                       skb_attempt_defer_free(skb);
 	}
 
 	return ret;
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 6be01454f262..89217c43c639 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -7201,6 +7201,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	DEBUG_NET_WARN_ON_ONCE(skb_dst(skb));
 	DEBUG_NET_WARN_ON_ONCE(skb->destructor);
 	DEBUG_NET_WARN_ON_ONCE(skb_nfct(skb));
+	DEBUG_NET_WARN_ON_ONCE(skb_shared(skb));
 
 	sdn = per_cpu_ptr(net_hotdata.skb_defer_nodes, cpu) + numa_node_id();
 
@@ -7221,6 +7222,7 @@ nodefer:	kfree_skb_napi_cache(skb);
 	if (unlikely(kick))
 		kick_defer_list_purge(cpu);
 }
+EXPORT_SYMBOL(skb_attempt_defer_free);
 
 static void skb_splice_csum_page(struct sk_buff *skb, struct page *page,
 				 size_t offset, size_t len)
-- 
2.34.1


