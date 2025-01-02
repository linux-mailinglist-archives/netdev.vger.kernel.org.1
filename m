Return-Path: <netdev+bounces-154851-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A2F89A0012E
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 23:26:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6C145163081
	for <lists+netdev@lfdr.de>; Thu,  2 Jan 2025 22:26:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F34A51B423B;
	Thu,  2 Jan 2025 22:26:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="fXBSfWwW"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-4.cisco.com (alln-iport-4.cisco.com [173.37.142.91])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BBBF192B8C
	for <netdev@vger.kernel.org>; Thu,  2 Jan 2025 22:26:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735856782; cv=none; b=K+A9SjogrLjV9nHmHHQe/7h8WX8lKQiULnjnmEgkdneOzjOc9OHIB4+v3hDyJ9JHS/zlW7fN0YHMcaQi1CWhRKobPBQeZl3pLV/GsJhgOYnaPe7HgGkClF8I425r9Pg0XWblFv87hVS91iNDa3vVNSildxP+4klUO0kkdQNG8/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735856782; c=relaxed/simple;
	bh=RORmIHOPK0kcdA4FF5ZN7f/vgZqCcBGRgD73Rn7lHHU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=AqkDdmYqMxKThe5cewmW64M5EQM9pDeV+K51/LbYxNIV6WA9frS37EkW8GLobulHMa1mW3MhDDoe0V11f3653lyVUuyHszzt5gOKCGeuVtDjhEfpw44t4dCOTwvXCkvPSZfPU5ENW3KyxTZyWz2PV0v6Sv3pVh7tbbLWGEQOKl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=fXBSfWwW; arc=none smtp.client-ip=173.37.142.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2580; q=dns/txt; s=iport;
  t=1735856781; x=1737066381;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=JgaQjsnXXe04jy52YeskEwBquLcoaHkw0vFrNptWWrE=;
  b=fXBSfWwWCyyKgEqoYV0jRq7PeHJj9QwEZ3/ocpxVeWzkniZAjCiEr+hR
   vocYcvi2oHvwlR9VPzurOQj6FNJOCrgD+y56m0Hw2YHjXy3FBj80l/MGI
   95k6hXW/It7BCAlI+gcDQQcPtldgJ3JwBs3prbP7mwXVFoW0R4hKo/6cl
   k=;
X-CSE-ConnectionGUID: OcWeyPGSRwKy/N4BC9xQYg==
X-CSE-MsgGUID: lNXFRfQhRBmKTAEgaF5DvQ==
X-IPAS-Result: =?us-ascii?q?A0AkAQBsEXdnj4wQJK1aHgEBCxIMgggLhBpDSI1RiHKeG?=
 =?us-ascii?q?xSBEQNWDwEBAQ9EBAEBhQeKcQImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBQEBAQIBBwUUAQEBAQEBOQUOO4YIhl02AUaBDDISgwGCZQOzHoIsgQHeM?=
 =?us-ascii?q?4FtgUiFa4dfcIR3JxuBSUSEDm+EKWeFdwSCHBeBJYFAg3CdV0iBIQNZLAFVE?=
 =?us-ascii?q?w0KCwcFgTk6AyILCwwLFBwVAoEagQIUBhUEgQtFPYJIaUk3Ag0CNoIgJFiCK?=
 =?us-ascii?q?4RdhEeEVoJJVYJIghd8gRqCKkADCxgNSBEsNwYOGwY+bgebeTyDboEOARNoK?=
 =?us-ascii?q?x1RFD4CEZMhkhWhA4QkgWOfYxozqlKYfCKjbTeEZoFnOoFbMxoIGxWDIlIZD?=
 =?us-ascii?q?44tDQmwcyUyPAIHCwEBAwmPWQaBdwEB?=
IronPort-Data: A9a23:YBThjKt+q2UVLwTmNuHtnloyJOfnVLNeMUV32f8akzHdYApBsoF/q
 tZmKWzTOPqIZWX0KYh0aIizo0IO7cTcmt5rTQE++y5jE3wRgMeUXt7xwmUckM+xwmwvaGo9s
 q3yv/GZdJhcokf0/0nrav656yEhjclkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1vlV
 eja/YuGYjdJ5xYuajhJs/vb8ks01BjPkGpwUmIWNKgjUGD2zxH5PLpHTYmtIn3xRJVjH+LSb
 47r0LGj82rFyAwmA9Wjn6yTWhVirmn6ZFXmZtJ+AsBOszAazsAA+v9T2Mk0NS+7vw60c+VZk
 72hg3AfpTABZcUgkMxFO/VR/roX0aduoNcrKlDn2SCfItGvn3bEm51T4E8K0YIw3e1IDHB22
 sciNxMcKTbfrcnn0IuKRbw57igjBJGD0II3s3Vky3TdSP0hW52GG/6M7t5D1zB2jcdLdRrcT
 5NGMnw0MlKZPVsWZg9/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9JoTVGZgNwxvCz
 o7A12DfMj8gOuWf8xCA0U6Fq+DGs37XRrtHQdVU8dYx3QXMnTZMYPEMbnO3qOe0j2ayUsxSL
 kgT9DZoq6UunGSmQsT4Vg+1vFaLuRkTX9cWGOo/gCmO16DdywWUHG4JSnhGctNOnMYwSSYny
 RyPks/lCCJHtKCTTzSW9t+8tTq4NC4UBXUPaS8NUU0O5NyLiIc+kh7CUP59H6OvyN74Azf9x
 3aNtidWulkIpccP06P++RXMhCih48CSCAU0/Q7QGGmi62uVebJJeaSP4mfW/M5vF7yGbUjGm
 iQusJmO1dEBWMTleDO2fM0BG7Sg5vCgOTLagEJyE5RJy9hL0yD4FWy3yG8iTHqFIvo5lSnVj
 Fg/UD69BaO/3lP3NMebgKroV6zGKJQM8/y+B5g4ifIVOfBMmPevpn0GWKJp9zmFfLIQua8+I
 4yHVs2nEGwXD69qpBLvGLxAjuJ1nXxllDyJLXwe8/hB+efPDJJyYepUWGZikshjt8toXS2Mq
 Y8GbJrQo/mheLChPnePmWLsEbz6BSNmXc+t8ZM/mh+rKQt9E2ZpEO7K3b4kYMRkma8T/tokD
 VnjMnK0PGHX3CWdQS3TMygLQOq2Af5X8ylhVQRyZgnA5pTWSdr0hEvpX8dsJeF/nAGipNYoJ
 8Q4lzKoW60eGmmeqm1HPfEQbuVKLXyWuO5HBAL9CBBXQnKqb1WhFgPMFuc3yBQzMw==
IronPort-HdrOrdr: A9a23:Mh5K46P2kmPKTcBcTsqjsMiBIKoaSvp037Dk7S9MoHtuA6mlfq
 +V/cjzuSWYtN9zYgBDpTn/Asm9qBrnnPYfi7X5Vo3NYOCJggeVxflZnOjfK/mKIVyYygabvp
 0QF5RDNA==
X-Talos-CUID: 9a23:txOftG3emQTDlcHy7tS5qrxfPcsaf2zl40zqPGypTkA1YpbEWWah9/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AySHt1w4mUeyQbv8Q2RXx1PDXxoxsxZSAMk40ka8?=
 =?us-ascii?q?svuq4HAF/MhnAoCqOF9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,286,1728950400"; 
   d="scan'208";a="407450552"
Received: from alln-l-core-03.cisco.com ([173.36.16.140])
  by alln-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 02 Jan 2025 22:25:12 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by alln-l-core-03.cisco.com (Postfix) with ESMTP id 49BB6180001D3;
	Thu,  2 Jan 2025 22:25:12 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 18CD920F2003; Thu,  2 Jan 2025 14:25:12 -0800 (PST)
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
Subject: [PATCH net-next v4 0/6] enic: Use Page Pool API for receiving packets
Date: Thu,  2 Jan 2025 14:24:21 -0800
Message-Id: <20250102222427.28370-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: alln-l-core-03.cisco.com

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

Changes in v3:
- Moved a function to before where is was called and removed the forward
  declaration. Reworded a commit message. No functional changes.

Changes in v4:
- Replaced call to page_pool_put_page() with page_pool_put_full_page()
  since page_pool_dev_alloc() API is used and page_pool is created with
  PP_FLAG_DMA_SYNC_DEV flag.
- Reworded final commit message one more time to try to make it clear
  that there is just one fix for the commit.

John Daley (6):
  enic: Refactor RX path common code into helper functions
  enic: Remove an unnecessary parameter from function enic_queue_rq_desc
  enic: Use function pointers for buf alloc, free and RQ service
  enic: Use the Page Pool API for RX when MTU is less than page size
  enic: Move RX coalescing set function
  enic: Obtain the Link speed only after the link comes up

 drivers/net/ethernet/cisco/enic/Makefile      |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h        |  15 +
 .../net/ethernet/cisco/enic/enic_ethtool.c    |   1 +
 drivers/net/ethernet/cisco/enic/enic_main.c   | 229 ++++++---------
 drivers/net/ethernet/cisco/enic/enic_res.h    |  10 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 260 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |  27 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 8 files changed, 400 insertions(+), 146 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.35.2


