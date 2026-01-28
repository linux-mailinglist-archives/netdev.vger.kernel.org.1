Return-Path: <netdev+bounces-254467-lists+netdev=lfdr.de@vger.kernel.org>
Delivered-To: lists+netdev@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mHxlF7d9emld7AEAu9opvQ
	(envelope-from <netdev+bounces-254467-lists+netdev=lfdr.de@vger.kernel.org>)
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:20:55 +0100
X-Original-To: lists+netdev@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DA812A9102
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 22:20:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E0D3D3032CE2
	for <lists+netdev@lfdr.de>; Wed, 28 Jan 2026 21:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 316E633971D;
	Wed, 28 Jan 2026 21:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b="OPd6+2Iw"
X-Original-To: netdev@vger.kernel.org
Received: from mx0a-00082601.pphosted.com (mx0b-00082601.pphosted.com [67.231.153.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7856F2F2607;
	Wed, 28 Jan 2026 21:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=67.231.153.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769635251; cv=none; b=Q5mW/R8KOa+mCTyWXHZDpxzNUrDjyemuL8DRTh9lNgjV4hwnpVd1o8fK2Sj5z9N/0KrANCI4Diz5ayDGP/cn3h8qbn6jhgbWDzVSO0TfTnHgJCSCgHbZtmxmUXb2EA4BnOVmfQAAE5giYE0JTHR6VKAvIPCU34E61ZLWpDNVCjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769635251; c=relaxed/simple;
	bh=wn5v/V+2EUq/lEmGg/gJCY2hXS+vDV6F+wR0dcdjHjQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rjAGtl38j1MHe1tI70WkPMzcwcXsrpp0tTZhDOusgt8JnD8WsxTwINHHuTt1NjU9MDdOrNPrNvXHwgKahgxbtgi0CJ1BdGPw4LHkWNuCEjGyE3imPOWSSvRTOJ7QlIULy8AFIUEH9X5AZKdPe5yNQkjvHD4DvQG1uSNzbfUX2KQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com; spf=pass smtp.mailfrom=meta.com; dkim=pass (2048-bit key) header.d=meta.com header.i=@meta.com header.b=OPd6+2Iw; arc=none smtp.client-ip=67.231.153.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=meta.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=meta.com
Received: from pps.filterd (m0089730.ppops.net [127.0.0.1])
	by m0089730.ppops.net (8.18.1.11/8.18.1.11) with ESMTP id 60SL8rkr2548542;
	Wed, 28 Jan 2026 13:20:33 -0800
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
	:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=s2048-2025-q2; bh=LmXLcKewuigFUq6sRk
	uqS5Po4xQNSEMQZ+IXS2rItqk=; b=OPd6+2Iw+QYz39OnZviwi5Y6UiRyGCE/dy
	RMcAfTW1jcLupqtGdpJfnHst5kjVt7IiCERQGyZNUBUf2ndHmIWJTFejgnlpOpxy
	ZouCfgOCAON3mMMqro5iqu2G9e4A/TbiWcbcBYmuXXQdjXkBEDEicqvuPaEcW0jz
	lyRECYw4g+vTURC8q14+LuyapLfQQlorBxpmmEMTmx0FKrncgalVvQrr0YO8J6Uk
	r80PCdFDKTFMNjtXhZJwiWyKMeu8KjtDgndSVR980tFkQpZGbx0oKmwOgB5QFuSR
	a3smdeTpR9DPiLkmLxvfge44rSj5c2LTQeqxX6FYkzw1gjIp2duQ==
Received: from mail.thefacebook.com ([163.114.134.16])
	by m0089730.ppops.net (PPS) with ESMTPS id 4byt46r3y3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
	Wed, 28 Jan 2026 13:20:33 -0800 (PST)
Received: from localhost (2620:10d:c085:208::f) by mail.thefacebook.com
 (2620:10d:c08b:78::2ac9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.2.2562.35; Wed, 28 Jan
 2026 21:20:32 +0000
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
        <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH v2 net-next 0/2] virtio_net: add page_pool support
Date: Wed, 28 Jan 2026 13:20:29 -0800
Message-ID: <20260128212031.1431746-1-vishs@meta.com>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI4MDE3NiBTYWx0ZWRfX+hh/kW2xoHn5
 71QOj4pJFt5XM5tosXgMuqY0lg8IW38w6TB4etBOqNAPr/juaGGVE/TQnkoSIiD7R5bc22fZ416
 W8qMkVtjCYPKpAfW3hFqcQIbxtd65aRsDBlV0xLwK7Ep48ZQUCccD3ZhmSHLyuyHURIOHlAQouz
 WiY8J8XJjbGjjd5LpCH0YlF88rYjPQh1ehO5lsBRk0XEG7McExfdi4YVG+Fyu7YN1wlmAOpiUsA
 77K8WFLRRJugwGHz9rKQIAzPgC71iOXk4V3nZat6EbKrO/JRVFlEfJDO4+tDY3jEH+oCiRVfwvT
 S4cOBhHNDm/dAffvgCNnmdgUrMoGnvpwU0XiRA1GWuZkMf03yMeKafVW4uD0qtkOKyfq+81kp1Z
 tcH/GtgmXz+phhdE7j15H9QqgZlqx9t1Fah/vSma5aogspTb+LWSBftB/kq2YahPKeHiwyLJx76
 JBBLFwG0Cm/WSF37KjA==
X-Authority-Analysis: v=2.4 cv=K98v3iWI c=1 sm=1 tr=0 ts=697a7da1 cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VwQbUJbxAAAA:8 a=VabnemYjAAAA:8
 a=9s9GJ8xVjcLqawB-9w0A:9 a=gKebqoRLp9LExxC7YDUY:22
X-Proofpoint-ORIG-GUID: opVtKESr1WJwXufoAjBRDVctZ1TpnAc_
X-Proofpoint-GUID: opVtKESr1WJwXufoAjBRDVctZ1TpnAc_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-28_06,2026-01-28_03,2025-10-01_01
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[meta.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[meta.com:s=s2048-2025-q2];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254467-lists,netdev=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vishs@meta.com,netdev@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[meta.com:+];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[netdev];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[meta.com:mid,meta.com:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DA812A9102
X-Rspamd-Action: no action

Introduce page_pool support in virtio_net driver to enable page recycling
in RX buffer allocation and avoid repeated page allocator calls. This
applies to mergeable and small buffer modes.

Beyond performance improvements, this patch is a prerequisite for enabling
memory provider-based zero-copy features in virtio_net, specifically devmem
TCP and io_uring ZCRX, which require drivers to use page_pool for buffer
management.

The implementation preserves the DMA premapping optimization introduced in
commit 31f3cd4e5756 ("virtio-net: rq submits premapped per-buffer") by
conditionally using PP_FLAG_DMA_MAP when the virtio backend supports
standard DMA API (vhost, virtio-pci), and falling back to allocation-only
mode for backends with custom DMA mechanisms (VDUSE).

Changes in v2
=============

Addressing reviewer feedback from v1:

- Add "select PAGE_POOL" to Kconfig (Jason Wang)
- Move page pool creation from ndo_open to probe for device lifetime
  management (Xuan Zhuo, Jason Wang)
- Implement conditional DMA strategy using virtqueue_dma_dev():
  - When non-NULL: use PP_FLAG_DMA_MAP for page_pool-managed DMA premapping
  - When NULL (VDUSE): page_pool handles allocation only
- Use page_pool_get_dma_addr() + virtqueue_add_inbuf_premapped() to
  preserve DMA premapping optimization from commit 31f3cd4e5756
  ("virtio-net: rq submits premapped per-buffer") (Jason Wang)
- Remove dual allocation code paths - page_pool now always used for
  small/mergeable modes (Jason Wang)
- Remove unused virtnet_rq_alloc/virtnet_rq_init_one_sg functions
- Add comprehensive performance data (Michael S. Tsirkin)
- v1 link: https://lore.kernel.org/virtualization/20260106221924.123856-1-vishs@meta.com/

Performance Results
===================

Tested using iperf3 TCP_STREAM with virtio-net on vhost backend.
300-second runs, results show throughput and TCP retransmissions.
The base kernel is synced to net tree and commit: 709bbb015538.

Mergeable Buffer Mode (mrg_rxbuf=on, GSO enabled, MTU 1500):
+--------+---------+---------+------------+------------+--------+--------+
| Queues | Streams |  Patch  | Throughput |   Retries  | Delta  | Retry% |
+--------+---------+---------+------------+------------+--------+--------+
|   1    |    1    |  base   |  25.7 Gbps |      0     |   -    |   -    |
|   1    |    1    |   pp    |  26.2 Gbps |      0     | +1.9%  |   0%   |
+--------+---------+---------+------------+------------+--------+--------+
|   8    |    8    |  base   |  95.6 Gbps |  236,432   |   -    |   -    |
|   8    |    8    |   pp    |  97.9 Gbps |  188,249   | +2.4%  | -20.4% |
+--------+---------+---------+------------+------------+--------+--------+

Small Buffer Mode (mrg_rxbuf=off, GSO disabled, MTU 1500):
+--------+---------+---------+------------+------------+--------+--------+
| Queues | Streams |  Patch  | Throughput |   Retries  | Delta  | Retry% |
+--------+---------+---------+------------+------------+--------+--------+
|   1    |    1    |  base   |  9.17 Gbps |    15,152  |   -    |   -    |
|   1    |    1    |   pp    |  9.19 Gbps |    12,203  | +0.2%  | -19.5% |
+--------+---------+---------+------------+------------+--------+--------+
|   8    |    8    |  base   | 43.0 Gbps  |   974,500  |   -    |   -    |
|   8    |    8    |   pp    | 44.7 Gbps  |   717,411  | +4.0%  | -26.4% |
+--------+---------+---------+------------+------------+--------+--------+

Testing
=======

The patches have been tested with:
- iperf3 bulk transfer workloads (multiple queue/stream configurations)
- Included selftests for buffer circulation verification
- Edge case testing: device unbind/bind cycles, rapid interface open/close,
  traffic during close, ethtool feature toggling, close with pending refill
  work, and data integrity verification

Vishwanath Seshagiri (2):
  virtio_net: add page_pool support for buffer allocation
  selftests: virtio_net: add buffer circulation test

 drivers/net/Kconfig                           |   1 +
 drivers/net/virtio_net.c                      | 353 ++++++++++--------
 .../drivers/net/virtio_net/basic_features.sh  |  70 ++++
 3 files changed, 273 insertions(+), 151 deletions(-)

--
2.47.3


