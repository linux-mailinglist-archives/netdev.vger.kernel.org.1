Return-Path: <netdev+bounces-159653-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C868BA163C8
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 21:01:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FCBE1885025
	for <lists+netdev@lfdr.de>; Sun, 19 Jan 2025 20:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09B6719D072;
	Sun, 19 Jan 2025 20:01:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="kXXIqc9v"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-6.cisco.com (rcdn-iport-6.cisco.com [173.37.86.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304621632E6
	for <netdev@vger.kernel.org>; Sun, 19 Jan 2025 20:01:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737316891; cv=none; b=r1q433tky2kCXnaxZCpGwQhVvv7aLVh57231QmDJkED9qMh6KopTs8Kn+1uiFQGPDCcRGgtOJS4w/dJFoEL3+q2tPUHHN1VKEbZYyKp32xSRg4sBSZce/0yi+wUfuygzJQ3jIAX9e0DrJLo79uqTZlCnC52Yrahjoyfms9kS8MU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737316891; c=relaxed/simple;
	bh=tHisr3zdFluxDXejgq2gykRvT+dQeDRfK1rEGACmUDE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=hOR/sX7a5a9UB9+AJq8DMpViE+SVrgjxqTfiNzH8G9Xj5fn2m/ERTm5iUgNG2vBLmsx93x9Fyy07pRb80Y7z6Ysyttj3HajelLZ3CTqToOpp6mbVsRUDQNLjDbyXWIGZOyevLfPOuCnJHUkpukzNgqU8hE59z9GsWPTzBjSCxhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=kXXIqc9v; arc=none smtp.client-ip=173.37.86.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2389; q=dns/txt; s=iport;
  t=1737316890; x=1738526490;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=+Bbhlt7V2w8uh1bi5elPxMg2z56+wEKaV2cUd3aeiNM=;
  b=kXXIqc9v/HW5NuOeHhsE0yO7333sXvrRnoACakQgh60TnOmJxo7AzPei
   ZTjzZ9RcKvH0Kdcjnar5weTeXn+K4UxPCn25yaJrnxzDK3O8T5FEBoD0g
   IvJJi6KGB9nv3dv7Cdnjm6nNG2Qvh6XJrByKrsFLkG0gt4HXWgfyRB86H
   g=;
X-CSE-ConnectionGUID: b4lo9JixTTql77aT/AP6Cg==
X-CSE-MsgGUID: Nbl1hQA6QfyLIvLlsqdH6g==
X-IPAS-Result: =?us-ascii?q?A0AnAAAUWY1n/4z/Ja1aHAECAgEHARQBBAQBggAHAQwBg?=
 =?us-ascii?q?kqBT0NIjHJfiHOeGxSBEQNWDwEBAQ9EBAEBhQeKdQImNAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZdNgFGgQwyEoMBgmUDtH6CL?=
 =?us-ascii?q?IEB3jOBbYFIAYVqh19whHcnG4FJRIQOb4QpZ4V3BIIygUWDbp9SSIEhA1ksA?=
 =?us-ascii?q?VUTDQoLBwWBOTgDIgsLDAsUHBUCFR0PBhAEbUQ3gkZpSTcCDQI1gh4kWIIrh?=
 =?us-ascii?q?FqERYRTgkNUgkWCFHqBHII3gllAAwsYDUgRLDcGDhsGPm4Hm2U8g3Z7EwF7K?=
 =?us-ascii?q?24UUZMOCZIfoQOEJYFjn2MaM6pTmHwio243hGaBZzyBWTMaCBsVgyJSGQ/RG?=
 =?us-ascii?q?iUyPAIHCwEBAwmRZQEB?=
IronPort-Data: A9a23:ow/coKhU6dgXrcphyUeaAdgEX161QhEKZh0ujC45NGQN5FlHY01je
 htvDW7Vb6mDYjeneNx0bIW1pkwAu8DQztFrQQU+ry48H3hjpJueD7x1DKtf0wB+jyHnZBg6h
 ynLQoCYdKjYdleF+FH1dOCn9SQkvU2xbuKUIPbePSxsThNTRi4kiBZy88Y0mYcAbeKRW2thg
 vus5ZSEULOZ82QsaD9MsvvS8EkHUMna4Vv0gHRvPZing3eG/5UlJMp3Db28KXL+Xr5VEoaSL
 87fzKu093/u5BwkDNWoiN7TKiXmlZaLYGBiIlIPM0STqkAqSh4ai87XB9JAAatjsAhlqvgqo
 Dl7WTNcfi9yVkHEsLx1vxC1iEiSN4UekFPMCSDXXcB+UyQqflO0q8iCAn3aMqUSpuJwUENP5
 cAkMTRSMRm/wMuOnpm0H7wEasQLdKEHPasFsX1miDWcBvE8TNWbGOPB5MRT23E7gcUm8fT2P
 pVCL2EwKk6dPlsWZg9/5JEWxI9EglH9dD1epFuRqII84nPYy0p6172F3N/9IYTaHJgFxRrJz
 o7A10LzBkgaDfXB8DSU1lOyouvUhC/bBo1HQdVU8dYv2jV/3Fc7BBQIWF6TrfCnh0u6XNxDb
 UoZ5kIGoKQv8UW5Q8XVUBq/r3qJ+BUbXrJ4EPAw4SmOx7DS7gLfAXILJhZIbtA8udB1QzE22
 lKXt9f0Azopu739YWqU/LqSrBuoNCQVJHNEbigBJSMD7sXvrZ8bkB3CVJBgHbSzg9mzHiv/q
 w1mtwAkjLkVyMpO3KKh8BWf2HSnp4PCSUg+4QC/sn+Z0z6VrbWNP+SAgWU3J94ZRGpFZjFtZ
 EQ5pvU=
IronPort-HdrOrdr: A9a23:Fqxi0q01ZSKYfEsH/LsCTAqjBLkkLtp133Aq2lEZdPWaSKOlfq
 eV7ZEmPHDP6Qr5NEtMpTniAtjjfZqjz/5ICOAqVN/INjUO01HHEGgN1+ffKkXbak7DHio379
 YGT0C4Y+eAaWRHsQ==
X-Talos-CUID: 9a23:og9jW2+WEepjt5X2eJaVv0RIHsd0UHzN8EvJJxDnAFouYYXLYlDFrQ==
X-Talos-MUID: =?us-ascii?q?9a23=3AoDLqcQ6EHgu7jpDqURXb7uaRxoxO6aD3CHkkz6w?=
 =?us-ascii?q?Iqu2lKwh0IC6RrGq4F9o=3D?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,218,1732579200"; 
   d="scan'208";a="308158349"
Received: from rcdn-l-core-03.cisco.com ([173.37.255.140])
  by rcdn-iport-6.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 19 Jan 2025 20:00:20 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-03.cisco.com (Postfix) with ESMTP id 56140180001F3;
	Sun, 19 Jan 2025 20:00:20 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 2D5ED20F2003; Sun, 19 Jan 2025 12:00:20 -0800 (PST)
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
Subject: [PATCH net-next v7 0/3] enic: Use Page Pool API for receiving packets
Date: Sun, 19 Jan 2025 12:00:15 -0800
Message-Id: <20250119200018.5522-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-03.cisco.com

Use the Page Pool API for RX. The Page Pool API improves bandwidth and
CPU overhead by recycling pages instead of allocating new buffers in the
driver. Also, page pool fragment allocation for smaller MTUs is used
allow multiple packets to share pages.

RX code was moved to its own file and some refactoring was done
beforehand to make the page pool changes more trasparent and to simplify
the resulting code.

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

Changes in v5:
- Removed link related patches from the patchset. These were merged
  seperately.
- Removed inappropriate calls to napi_free_frags()
- Moved pp_alloc_error out of ethtool stats and accumulate into netdev
  queue stat 'alloc_error'.

Changes in v6:
- Use the page pool API for all MTUs, not just <= PAGE_SIZE. Use page
  pool 'order' field to accomodate MTUs > PAGE_SIZE. Remove the
  function pointers and functions that handled the bigger MTUs.

Changes in v7:
- Add error return code handling for page_pool_create()

John Daley (3):
  enic: Move RX functions to their own file
  enic: Simplify RX handler function
  enic: Use the Page Pool API for RX

 drivers/net/ethernet/cisco/enic/Makefile    |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h      |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 268 +++-----------------
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 242 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h   |  10 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h   |   2 +
 6 files changed, 287 insertions(+), 240 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.35.2


