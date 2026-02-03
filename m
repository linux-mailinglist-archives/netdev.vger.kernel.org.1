Return-Path: <netdev+bounces-256487-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id y4RWEnyAgmneVgMAu9opvQ
	(envelope-from <netdev+bounces-256487-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:10:52 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FAEEDF959
	for <lists+netdev@lfdr.de>; Wed, 04 Feb 2026 00:10:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4C5DD30A35DD
	for <lists+netdev@lfdr.de>; Tue,  3 Feb 2026 23:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B295C367F38;
	Tue,  3 Feb 2026 23:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="joQOtqo7"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0a-00082601.pphosted.com [67.231.145.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BCD7318BBE;
	Tue,  3 Feb 2026 23:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.145.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770160242; cv=none; b=HGh6k3q2EZm3yOZ04XNcsb/38x+WAAGNC70elaaW1tDPXU3tr7klPXyI+T3k0YvCszxaY2Fja2+iBpLV7Mf96k5jFVJnexAUg86kxidmmCALtF5gW7+ZZE+0ifHLlI2Imbr9toaaeyGGSJzaKO5UmgBoiykVz9JR6q6J6GU7yX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770160242; c=relaxed/simple;
	bh=5Ni3Bp0ge2za6+KRPRoM9DCnjRIUA72HGSHLNaiPoTE=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=pMqPnnsc81DggxaaL1x/5jPHSPVijBdb+FqisB0rGDrxQ0vNmYa9cHJFH8UM1mi+kcAqirn/9OXpKEb9eKE94DNapTlnrPpd/epVgq+17ZKtQXSWQFXFTXfi7DUvt14NvhKiphJ8/7CcsZibagIHv4x8sw/H/iVap3BP85xUznU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=joQOtqo7; arc=none smtp.client-ip=67.231.145.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 613KM0nC2623180;
	Tue, 3 Feb 2026 15:10:24 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=vmLrkjZ47OrE/0/EWl
	+bj5Aa4RWDwurlR0xRhx4++MI=; b=joQOtqo7YTzRiaxkXHtBlwzNrS1/Ad25dh
	2q8WEeOTJXH8x3oWrFPVZGEBCBc0jo8Xuf3dxIx32uzJFbsqRZ7QF0tSSqafxmII
	7wMjcN8s0/jdz6f+ftOYqWRyAfzW71gfSgwaOjfHlTdAi8+iTR9q8lNcX4suGZJg
	YzU6WjMSGFVQOTGQ/Hq4a5hk/spyPv2BK7C0kJ8NqRBUasjk0RDD3Q+YG+5jHLIc
	UO2ytiFxKY1zwXsQIIN1IKz2n9vA203Lu2YkSM1ZSN7mfsxEypN3PQfWhZ/1+5gy
	QonhjqkorJj+//+BF1ffEW/rEBZFpO3HvGiaC6kLscqJ5kSLy+6w==
Received: from maileast.thefacebook.com ([163.114.135.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 4c3mcxvwv2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Tue, 03 Feb 2026 15:10:23 -0800 (PST)
Received: from localhost (2620:10d:c0a8:1c::1b) by mail.thefacebook.com
 (2620:10d:c0a9:6f::237c) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Tue, 3 Feb
 2026 23:10:22 +0000
From: Vishwanath Seshagiri <vishs@meta.com>
To: "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
CC: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        =?UTF-8?q?Eugenio=20P=C3=A9rez?=
	<eperezma@redhat.com>,
        Andrew Lunn <andrew+netdev@lunn.ch>,
        "David S .
 Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>, Jakub
 Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, David Wei
	<dw@davidwei.uk>,
        Matteo Croce <technoboy85@gmail.com>,
        Ilias Apalodimas
	<ilias.apalodimas@linaro.org>,
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>, <kernel-team@meta.com>
Subject: [PATCH net-next v3 0/2] virtio_net: add page_pool support
Date: Tue, 3 Feb 2026 15:10:17 -0800
Message-ID: <20260203231021.1331392-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: DC3EAMjeT32f4nTpPSPjcSybcNmPubn5
X-Authority-Analysis: v=2.4 cv=HuJ72kTS c=1 sm=1 tr=0 ts=6982805f cx=c_pps
 a=MfjaFnPeirRr97d5FC5oHw==:117 a=MfjaFnPeirRr97d5FC5oHw==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8 a=hDwN4JN7PfQbqHSwlsoA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: DC3EAMjeT32f4nTpPSPjcSybcNmPubn5
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjAzMDE4MiBTYWx0ZWRfX7cqMQqUcGWl+
 jj4I5kEZF9lyNJk64VvK24JLQBWXERFbQATSLOomGOk/dtrDIpscrb1qYRq4c6HTtIdNf6ooEK3
 RNbp0g9Dsjk34Yzx9QSk/gO+fDMtGRRIVrM2PT6/bqhx1LxEYt1y7e8BBxSxYENCnJHYItnT3zD
 0vUuCMZiLx3i0S6zc0sJpew3qISA+tJqGCo3WLdVdbgOV2wGFBNFKYP2BGBwhNdg4+i/VKoXm2o
 qeBBRgaNr/4qtASACJtFPdpy5MlE7E3dgtr3IYJ8Djy6FsCmKf8H5/VQe/0gYMpiG3PbUGstz1c
 mIvOIQquDeGPg4qRsIY36jN+a9ouNR9WjC/YU4L+iV1dF5/RxE7DM9F5C3RRVLweAtYBeLk/n5o
 1Npu4X8jQKQd76fXoRchEF+tVexgZh7lyhpDG4K+eTqztZHwJn13CJky/XOUe6pAPZPxKcjhkjI
 3WttbfoT6ZYscfkXaBQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-03_06,2026-02-03_01,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256487-lists,netdev=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux.alibaba.com,redhat.com,lunn.ch,davemloft.net,google.com,kernel.org,davidwei.uk,gmail.com,linaro.org,vger.kernel.org,lists.linux.dev,meta.com];
	DKIM_TRACE(0.00)[meta.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,meta.com:mid,meta.com:dkim]
X-Rspamd-Queue-Id: 8FAEEDF959
X-Rspamd-Action: no action

Introduce page_pool support in virtio_net driver to enable page
recycling in RX buffer allocation and avoid repeated page allocator
calls. This applies to mergeable and small buffer modes.

Beyond performance improvements, this patch is a prerequisite for
enabling memory provider-based zero-copy features in virtio_net, 
specifically devmem TCP and io_uring ZCRX, which require drivers to 
use page_pool for buffer management.

The implementation preserves the DMA premapping optimization introduced 
in commit 31f3cd4e5756 ("virtio-net: rq submits premapped per-buffer")
by conditionally using PP_FLAG_DMA_MAP when the virtio backend supports 
standard DMA API (vhost, virtio-pci), and falling back to
allocation-only mode for backends with custom DMA mechanisms (VDUSE).

================================================================================
                      VIRTIO-NET PAGE POOL BENCHMARK RESULTS
================================================================================

CONFIGURATION
-------------
- Host: pktgen TX → tap interface → vhost-net
- Guest: virtio-net RX → XDP_DROP
- Packet sizes: small buffers - 64; merge receivable 64, 1500

SMALL PACKETS (64 bytes) 
==================================================
Queues | Base (pps)  | Page Pool (pps) | Improvement | Base (Gb/s) |PP (Gb/s)
-------|-------------|-----------------|-------------|-------------|----------
  1Q   |    853,493  |      868,923    |   +1.8%     |    0.44     | 0.44
  2Q   |  1,655,793  |    1,696,707    |   +2.5%     |    0.85     | 0.87
  4Q   |  3,143,375  |    3,302,511    |   +5.1%     |    1.61     | 1.69
  8Q   |  6,082,590  |    6,156,894    |   +1.2%     |    3.11     | 3.15


RECEIVE MERGEABLE (64 bytes) 
======================================================
Queues | Base (pps)  | Page Pool (pps) | Improvement | Base (Gb/s) |PP (Gb/s)
-------|-------------|-----------------|-------------|-------------|----------
   1Q  |    766,168  |      814,493    |   +6.3%     |    0.39     | 0.42
   2Q  |  1,384,871  |    1,670,639    |  +20.6%     |    0.71     | 0.86
   4Q  |  2,773,081  |    3,080,574    |  +11.1%     |    1.42     | 1.58
   8Q  |  5,600,615  |    6,043,891    |   +7.9%     |    2.87     | 3.10


RECEIVE MERGEABLE (1500 bytes) 
========================================================
Queues | Base (pps)  | Page Pool (pps) | Improvement | Base (Gb/s) |PP (Gb/s)
-------|-------------|-----------------|-------------|-------------|----------
  1Q   |    741,579  |      785,442    |   +5.9%     |    8.90     | 9.43
  2Q   |  1,310,043  |    1,534,554    |  +17.1%     |   15.72     | 18.41
  4Q   |  2,748,700  |    2,890,582    |   +5.2%     |   32.98     | 34.69
  8Q   |  5,348,589  |    5,618,664    |   +5.0%     |   64.18     | 67.42

The page_pool implementation showed consistent performance improvements
by eliminating per packet overhead of allocating and deallocating
memory. When running the performance benchmarks, I noticed that
page_pool also had a consistent throughput performance compared to the
base patch where performance variability was due to accessing free_list
for getting the next set of pages.


Changes in v3
=============

Addressing reviewer feedback from v2:

- Fix CI null-ptr-deref crash: use max_queue_pairs instead of 
curr_queue_pairs in virtnet_create_page_pools() to ensure page pools 
are created for all queues (Jason Wang, Jakub Kicinski)
- Preserve big_packets mode page->private chaining in page_to_skb() with 
conditional checks (Jason Wang)
- Use page_pool_alloc_pages() in xdp_linearize_page() and 
mergeable_xdp_get_buf() to eliminate xdp_page tracking logic and simplify 
skb_mark_for_recycle() calls (Jason Wang)
- Add page_pool_page_is_pp() check in virtnet_put_page() to safely
  handle both page_pool and non-page_pool pages (Michael S. Tsirkin)
- Remove unrelated rx_mode_work_enabled changes (Jason Wang)
- Selftest: use random ephemeral port instead of hardcoded port to avoid conflicts 
when running tests in parallel (Michael S. Tsirkin)
- v2 link: https://lore.kernel.org/virtualization/20260128212031.1431746-1-vishs@meta.com/ 

Changes in v2
=============

Addressing reviewer feedback from v1:

- Add "select PAGE_POOL" to Kconfig (Jason Wang)
- Move page pool creation from ndo_open to probe for device lifetime
  management (Xuan Zhuo, Jason Wang)
- Implement conditional DMA strategy using virtqueue_dma_dev():
  - When non-NULL: use PP_FLAG_DMA_MAP for page_pool-managed DMA
    premapping
  - When NULL (VDUSE): page_pool handles allocation only
- Use page_pool_get_dma_addr() + virtqueue_add_inbuf_premapped() to
  preserve DMA premapping optimization from commit 31f3cd4e5756
  ("virtio-net: rq submits premapped per-buffer") (Jason Wang)
- Remove dual allocation code paths - page_pool now always used for
  small/mergeable modes (Jason Wang)
- Remove unused virtnet_rq_alloc/virtnet_rq_init_one_sg functions
- Add comprehensive performance data (Michael S. Tsirkin)
- v1 link:
  https://lore.kernel.org/virtualization/20260106221924.123856-1-vishs@meta.com/


Vishwanath Seshagiri (2):
  virtio_net: add page_pool support for buffer allocation
  selftests: virtio_net: add buffer circulation test

 drivers/net/Kconfig                           |   1 +
 drivers/net/virtio_net.c                      | 360 ++++++++++--------
 .../drivers/net/virtio_net/basic_features.sh  |  86 +++++
 3 files changed, 292 insertions(+), 155 deletions(-)

-- 
2.47.3


