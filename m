Return-Path: <netdev+bounces-153816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D58FF9F9C74
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 22:52:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F05F9188FF8E
	for <lists+netdev@lfdr.de>; Fri, 20 Dec 2024 21:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEC10222568;
	Fri, 20 Dec 2024 21:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="Wm8BjhQb"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-8.cisco.com (alln-iport-8.cisco.com [173.37.142.95])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC9D3157A48
	for <netdev@vger.kernel.org>; Fri, 20 Dec 2024 21:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.95
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734731549; cv=none; b=q6nDku5xiScMXO5kwCbQzEPzITuhb1r5vkqk2W3JwLJoQ5XmwSAXUKlD+Uk2Ch/dVoUa18MmA24eArNDBaEnMkhvtdVy/BWSuKUh1NSXSLETRCd4UuWbEATEpJ3p6fGuLqJNQhS7rStOdL7SWCpEgdp6pglBtK4GeUjpmJxdRak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734731549; c=relaxed/simple;
	bh=QRwOM6l287Nj2Ubh9/zkapCTb62NQCgP1nhXW3HlzaI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CYjiEpTZ15ElexuuhOAyPJnGGoQg9HWZNdxbs+Z8JTaWVlxCTNBzyi0VpPvsLLMGVttzFHQyzLOC3nYK1//l5BGU7qXOrRFjN4WwhGs2jqDA4PJpkHSNQMu3HUvu+bQpZkIvZmplLomwjVXrkojROtEdetLvxIJSShhz81ZC5/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=Wm8BjhQb; arc=none smtp.client-ip=173.37.142.95
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=1785; q=dns/txt; s=iport;
  t=1734731547; x=1735941147;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=dLVIvOQVsyOoATYsGukrwHFVqEreG+Y/yG137fh2SCk=;
  b=Wm8BjhQb5kEIPugva8vfm6UWoANbztson7AENQaK/x5T6HAYfrTuvzIv
   Y7hcqqyancoHGidxqoMMn2dVOK9gs5lF1HgjZZJzjDj0S+FDsGzL1ciQh
   acORzjtOX1wXsfGRAU5VT8Tuqg1NabGtjhpth0a7BcXsq1eNRRhRSSkCg
   Y=;
X-CSE-ConnectionGUID: m5JaZi5DTRuNZC77ghjbZg==
X-CSE-MsgGUID: CU47+vKmTIaNzIUWKl6A1A==
X-IPAS-Result: =?us-ascii?q?A0AiAQB75mVnj4v/Ja1aHgEBCxIMgggLhBpDjhmIcp4bg?=
 =?us-ascii?q?X4PAQEBD0QEAQGFB4puAiY0CQ4BAgQBAQEBAwIDAQEBAQEBAQEBAQELAQEFA?=
 =?us-ascii?q?QEBAgEHBRQBAQEBAQE5BUmGCIZdNgFGgQwygxOCZQOwLIIsgQHeM4FtgUiFa?=
 =?us-ascii?q?4dfcIR3JxuBSUSEDm+FEIV3BIIhgT6BQIN4nk5IgSEDWSwBVRMNCgsHBYE5O?=
 =?us-ascii?q?gMiDAsMCxQcFQKBHoECFAYVBIELRT2CSmlJNwINAjaCICRYgk2FGIRhhFeCS?=
 =?us-ascii?q?VWCfIIXfIEdgXFAAwsYDUgRLDcGDhsGPm4HoQaBDgETaCsdURQ+ApMykhOhA?=
 =?us-ascii?q?4QkgWOfYxozqlKYeyKkI4RmgWc6gVszGggbFYMjURkPji0NCbp5JW4CBwsBA?=
 =?us-ascii?q?QMJjy4GgXcBAQ?=
IronPort-Data: A9a23:Nk/JQqOJqnkd2qDvrR1Bl8FynXyQoLVcMsEvi/4bfWQNrUoggmcEy
 zZOWmuHafvZMGChcth2O97n/RgCu8LVx9E1TXM5pCpnJ55oRWUpJjg4wmPYZX76whjrFRo/h
 ykmQoCeaphyFjmE+0/F3oHJ9RFUzbuPSqf3FNnKMyVwQR4MYCo6gHqPocZh6mJTqYb/WlnlV
 e/a+ZWFZAb/gWYsaAr41orawP9RlKWq0N8nlgRWicBj5Df2i3QTBZQDEqC9R1OQapVUBOOzW
 9HYx7i/+G7Dlz91Yj9yuu+mGqGiaue60Tmm0hK6aYD76vRxjnBaPpIACRYpQRw/ZwNlMDxG4
 I4lWZSYEW/FN0BX8QgXe0Ew/ypWZcWq9FJbSJSymZT78qHIT5fj6/AzLkgEPNA0xtxqJ1Nlq
 qMXKDIHXB/W0opawJrjIgVtrt4oIM+uOMYUvWttiGmDS/0nWpvEBa7N4Le03h9p2ZsIRqmYP
 ZdEL2M0PXwsYDUXUrsTIJA5nOGkj33yWzZZs1mS46Ew5gA/ySQtiOO9bIuIIoHiqcN9tXvE+
 SHY3GHFIxg8Jv2i9hmBrFv1r7qa9c/8cNlPTOLjrKECbEeo7mAaFhATfVeyv/S8jkmwR5RZJ
 lB80icisK075kG3Ztb6WBK8rTiPuRt0c9lNGeQS6wyXzKfQpQGDCQAsRzhNctE598k7WTAny
 HeNgtXvQzdv2JWNQHiQ8La8tz6+OSEJa2QFYEcsSwYZ79T9iJ88gwiJTdt5FqOxyNrvFlnNL
 yuitiMygfAXyMUMzaj+pQqBiDO3rZ+PRQkwjunKYo67xgYkRoeXZtGE1WLGy8Rrc9mWTluLj
 ndRzqBy89syJZ2KkSWMRsAEE7eo++uJPVXgbbhHQcNJG9OFpSfLQGxA3AySMnuFJSrtRNMIX
 KMxkV4IjHOwFCL2BUOSX25XI592pUQHPY+5Ps04lvIUPvBMmPavpUmCn3K40WH3i1QLmqoiI
 5qdesvEJS9FUvg5l2HsGrlHjedDKsUCKYX7GM+TI/OPjOr2WZJpYe1fWLdzRrljtPje+F29H
 yh3apXXl0U3vBLCjtn/qtNLcgtQchDX9Lj9qtdccaaYMxF6FWQ6Q/7XyvVJRmCWt/o9qws8x
 VnkAhUw4AOm3RXvcFzaAlg9M+mHdcgk8hoG0dkEYQ3AN44LPd33tP93mlpeVeVPydGPOtYuF
 qRVIpnRW64TItkFkhxEBaTAQEVZXEzDrWqz0+CNOVDTo7YIq9T1x+LZ
IronPort-HdrOrdr: A9a23:JCySD6rwwa+cx8N3nTsEZVYaV5ogeYIsimQD101hICG9vPb2qy
 nIpoV/6faaslcssR0b9OxoW5PwI080i6QU3WB5B97LN2PbUQCTQr2Kg7GP/9SZIVycygaYvp
 0QFJSXz7bLfDxHsfo=
X-Talos-CUID: 9a23:GbjY+23NANwjJlmoIUgz6rxfH50He0/ckVvsGVKeO002F7KVS1Wi9/Yx
X-Talos-MUID: 9a23:/TbaIwgGR8S2YJOJ4W+OD8MpH/o0vOewK0UxsJwgqei5Cg90ZR7EpWHi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,251,1728950400"; 
   d="scan'208";a="403849505"
Received: from rcdn-l-core-02.cisco.com ([173.37.255.139])
  by alln-iport-8.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 20 Dec 2024 21:51:19 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-02.cisco.com (Postfix) with ESMTP id 7362418000224;
	Fri, 20 Dec 2024 21:51:19 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 4AEF220F2003; Fri, 20 Dec 2024 13:51:19 -0800 (PST)
From: John Daley <johndale@cisco.com>
To: benve@cisco.com,
	satishkh@cisco.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Cc: John Daley <johndale@cisco.com>
Subject: [PATCH net-next 0/5] enic: Use Page Pool API for receiving packets
Date: Fri, 20 Dec 2024 13:50:53 -0800
Message-Id: <20241220215058.11118-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-02.cisco.com

When the MTU is less than PAGE_SIZE, use the Page Pool API for RX.

The Page Pool API improves bandwidth and CPU overhead by recycling
pages instead of allocating new buffers in the driver. Also, page
pool fragment allocation for smaller MTUs allow multiple packets
to share a page.

Since older hardware does not support receiving packets into
multiple discontiguous pages, the original RX path where
netdev_alloc_skb_ip_align() is used for buffer allocation is now
used only when MTU > PAGE_SIZE. Function pointers are used to select
functions based on the MTU. Some refactoring was done so that common
code can be shared. The refactored functions and the new functions
using page pool are in a new file called enic_rq.c.

Fixed bug in the RX adaptive coalescing and did a minor cleanup.

John Daley (5):
  enic: Refactor RX path common code into helper functions
  enic: Remove an unnecessary parameter from function enic_queue_rq_desc
  enic: Use function pointers for buf alloc, free and RQ service
  enic: Use the Page Pool API for RX when MTU is less than page size
  enic: Obtain the Link speed only after the link comes up

 drivers/net/ethernet/cisco/enic/Makefile      |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  15 +
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 171 +++++-------
 drivers/net/ethernet/cisco/enic/enic_res.h    |  10 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 261 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |  27 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 8 files changed, 373 insertions(+), 116 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.35.2


