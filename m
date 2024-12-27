Return-Path: <netdev+bounces-154318-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C7FE9FCFC8
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 04:15:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55B3163A25
	for <lists+netdev@lfdr.de>; Fri, 27 Dec 2024 03:15:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5282027721;
	Fri, 27 Dec 2024 03:15:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="cHpvP3Kq"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-3.cisco.com (alln-iport-3.cisco.com [173.37.142.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8575E1361
	for <netdev@vger.kernel.org>; Fri, 27 Dec 2024 03:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735269344; cv=none; b=Sf5lSvSyCfxFwAOKN+eCD3jNVTUMDnlNz9j7kQQr3m6YtxTZRUyFThrgR649RT9yQlxqdzbrMUIFKYYehKDDrSkQbtEZRP5iYZKwJL7+aBFgsfp1PPGRC69DpMh3Oo4AO7A8tN2fq8GGk2oylnk/FcBG90Qb18QZX+xVyFU/S14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735269344; c=relaxed/simple;
	bh=1qaayROm4yEHzdTRVcROBGwnF5+n6UDFpn3FZPpbK74=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fxSPKgc9iB8TDFjONx2Ao6i54Sb8f3ByLvsy6DRPXRQXzNxwDvpJ/flPQI/K7IjBT5PUfmEzfwMZ47+pndspnnUYPzC44ZNR0+Lo8+WCfSY2p1QhKSA9oQjxK+CM9RvEsgqjjqKpcqP4HBWnWKXUVLgKjXj0ayxA0L45yaj+HvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=cHpvP3Kq; arc=none smtp.client-ip=173.37.142.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2096; q=dns/txt; s=iport;
  t=1735269342; x=1736478942;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ivIxNN1KskEAITPbXYnM1G6k2NZBJGPsmigbCqQ0RBs=;
  b=cHpvP3KqdhE0e/FLCPlOOpEMfkWDBpymjwBFMy0I4s8c6k/7cuM9hMnv
   SDPIuYggkMBLgIpj+wP59Q1gmvndXelR5s43/Jj9A91pL6Yk0WVvgVYwt
   CPsYkunAQjPRklLQFkJ/RetHBnZVA+OBay2jfH8vgKLgkTtp6wW7VfS/7
   k=;
X-CSE-ConnectionGUID: PsQBqBQDTYyfUXZWxQQNRA==
X-CSE-MsgGUID: HMgtuPQYScqDWkAmofuIYQ==
X-IPAS-Result: =?us-ascii?q?A0BbAwDbGm5n/4//Ja1aHgEBCxIMgggLgkuBT0NIjVGIc?=
 =?us-ascii?q?p4bgSUDVg8BAQEPRAQBAYUHinACJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBA?=
 =?us-ascii?q?QsBAQUBAQECAQcFgQ4ThgiGXTYBRoEMMhKDAYJlA68VgiyBAd4zgW2BSIVrh?=
 =?us-ascii?q?19whHcnG4FJRIQOb4UQhXcEgh8XgSeBQIN4nnVIgSEDWSwBVRMNCgsHBYE5O?=
 =?us-ascii?q?gMiDAsMCxQcFQKBHoECFAYVBIELRT2CSmlJNwINAjaCICRYgk2FF4RhhFeCS?=
 =?us-ascii?q?VWCe4IXfIEdgiVAAwsYDUgRLDcGDhsGPm4HnGRGg3SBDgETaCsdURQ+AhGTI?=
 =?us-ascii?q?ZIVoQOEJIFjn2MaM6pSmHwio203hGaBZzyBWTMaCBsVgyJSGQ+OLRa2EiUyP?=
 =?us-ascii?q?AIHCwEBAwmPOgaBdwEB?=
IronPort-Data: A9a23:VvZ936pMLa6EYsGaKxbRP+qAN/FeBmI6ZBIvgKrLsJaIsI4StFCzt
 garIBmHMvfYNGbze41+aYzj8koOuJ/cn9BqGgJl+ywwFngSpOPIVI+TRqvS04x+DSFioGZPt
 Zh2hgzodZhsJpPkjk7zdOCn9T8kiPngqoPUUIbsIjp2SRJvVBAvgBdin/9RqoNziLBVOSvV0
 T/Ji5OZYQXNNwJcaDpOt/vZ8kw35ZwehRtB1rAATaET1LPhvyF94KI3fcmZM3b+S49IKe+2L
 86r5K255G7Q4yA2AdqjlLvhGmVSKlIFFVHT4pb+c/HKbilq/kTe4I5iXBYvQRs/ZwGyojxE4
 I4lWapc5useFvakdOw1C3G0GszlVEFM0OevzXOX6aR/w6BaGpfh660GMa04AWEX0t5sOEtX3
 8U0FAEcYC2ztd2m+YudcMA506zPLOGzVG8ekmtrwTecCbMtRorOBv2Uo9RZxzw3wMtJGJ4yZ
 eJANmEpN0uGOUASfA5LU/rSn8/w7pX7Wz9fqFSZrK46y2PS1wd2lrPqNbI5f/TWHJQIxRfE/
 ziuE2LRIjQVKMGn8Au++WuAuezmmCT1RaMjLejtnhJtqBjJroAJMzUaXEW2pNG1g1CzXtZYJ
 VBS/CcyxYA/+FGuR8vwQzW3p3mLuhNaUN1Ve8U59QuE4qnZ+QCUAi4DVDEpQNUguNU7Wn8s2
 0OFks3BASFptvueSRq17r6eoDWzETIYIW8LeWkPSg5ty9/uvI0+kDrRQdt5Vq24lNv4HXf32
 T/ikcQlr68YgchO0+Cw+krKxmry4JPIVQUyoA7QWwpJ8z9EWWJsXKTwgXCz0BqKBN/xooWp1
 JTcp/Wj0Q==
IronPort-HdrOrdr: A9a23:tJPOAKNu/dljS8BcTsqjsMiBIKoaSvp037Dk7S9MoHtuA6mlfq
 +V/cjzuSWYtN9zYgBDpTn/Asm9qBrnnPYfi7X5Vo3NYOCJggeVxflZnOjfK/mKIVyYygabvp
 0QF5RDNA==
X-Talos-CUID: 9a23:UVsej25ed6MzJRHEc9sszFUtMNkPS1Hh/WbeHn+KNnZQcZuvYArF
X-Talos-MUID: =?us-ascii?q?9a23=3A8a+5/Q+okHLCJ4kqRJP74sCQf+dN7LizMHk8qp4?=
 =?us-ascii?q?fl/aHHCl3NSq8vQ3iFw=3D=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,268,1728950400"; 
   d="scan'208";a="419539412"
Received: from rcdn-l-core-06.cisco.com ([173.37.255.143])
  by alln-iport-3.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 27 Dec 2024 03:14:34 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-06.cisco.com (Postfix) with ESMTP id DBC2D18000254;
	Fri, 27 Dec 2024 03:14:33 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id B027D20F2003; Thu, 26 Dec 2024 19:14:33 -0800 (PST)
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
Subject: [PATCH net-next v2 0/5] enic: Use Page Pool API for receiving packets
Date: Thu, 26 Dec 2024 19:14:05 -0800
Message-Id: <20241227031410.25607-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-06.cisco.com

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

Signed-off-by: John Daley <johndale@cisco.com>

---
Changes in v2:
- Fixed a valid warning found by build_clang where a variable was used
  before it was initialized. The warnings in include/linux/mm.h were not
  addressed since they do not appear to be realated to this patchset.

---
John Daley (5):
  enic: Refactor RX path common code into helper functions
  enic: Remove an unnecessary parameter from function enic_queue_rq_desc
  enic: Use function pointers for buf alloc, free and RQ service
  enic: Use the Page Pool API for RX when MTU is less than page size
  enic: Obtain the Link speed only after the link comes up

 Makefile                                      |   2 +-
 drivers/net/ethernet/cisco/enic/Makefile      |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  15 +
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 171 +++++-------
 drivers/net/ethernet/cisco/enic/enic_res.h    |  10 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 261 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |  27 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 9 files changed, 374 insertions(+), 117 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.35.2


