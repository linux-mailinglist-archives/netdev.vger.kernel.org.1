Return-Path: <netdev+bounces-163294-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CBAA29DB4
	for <lists+netdev@lfdr.de>; Thu,  6 Feb 2025 00:55:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2A13F3A59A5
	for <lists+netdev@lfdr.de>; Wed,  5 Feb 2025 23:55:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FE9521B19F;
	Wed,  5 Feb 2025 23:55:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="VY7SYnER"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A68618A6BA
	for <netdev@vger.kernel.org>; Wed,  5 Feb 2025 23:55:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738799736; cv=none; b=pplu9tqoE32YrrmDUZETt5GOrMvTi4YNEsxkL51dQuMTg3GBwTJmJDnm/kEtLEpZCL2Z/nvtha2H55qLngm7vSTO9nOZ6kG8toGznWP7YzWpau9Jxcfen/Z/r7QXIzji8q4BE7nByBAj7tGbfc9S5kdiAyhiidlxoCg85G3glyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738799736; c=relaxed/simple;
	bh=55QeOGOw7wr2Rz9o5LVhV1mqpCy0NuFDG0DMEIWoSig=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=kiYL1y4S5kKLm9b3AkG3RVu0CNEfLGmvVu2qBzVlveDQe+zwEj3KMeof1qIsKBE47brNqi8H5GErZcInyeFL0JmiTUOwv4ncumCCto2hhh93FA4sqJ08modX64RZvnnfSEyIuotBmSF3eZQAZtUxJLE0XMWtmc8VCPL8gsYPUQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=VY7SYnER; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2519; q=dns/txt; s=iport;
  t=1738799734; x=1740009334;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Oz6bqcAG+/Uh1xGLxco0JsxVhnmnm8I7NnI5Hjbki7s=;
  b=VY7SYnER2z0MlPVocj3tXn9MMCSuHbGLlckZcdUed739FkNhcfmg+0l4
   N0VMu1HIWuQEUqVIAU8R5RKugrfJGfWKKgQoiRqUoDCmUduPowPPNO8q+
   rI9N/+bgVKpPHEHcHXegXSmQlJc0Z+dF71YIVaYCcn8FzFPYeUPVeke3H
   M=;
X-CSE-ConnectionGUID: 3sUANSjxTeyDXlj+31w4vw==
X-CSE-MsgGUID: LhyFSfJpQZaPqPgga3kH5Q==
X-IPAS-Result: =?us-ascii?q?A0AnAABv+aNn/43/Ja1aHAEBAQEBAQcBARIBAQQEAQGBf?=
 =?us-ascii?q?wcBAQsBgkqBT0NIjHJfiHSeFxSBEQNWDwEBAQ9EBAEBhQeLAgImNAkOAQIEA?=
 =?us-ascii?q?QEBAQMCAwEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZdNgFGgQwyEoMCg?=
 =?us-ascii?q?mUDsFGCLIEB3jSBboFIAYVrh19whHcnG4FJRIQOb4QpZ4V3BIIvgUCDb5cki?=
 =?us-ascii?q?1BIgSEDWSwBVRMNCgsHBYE5OAMgCgsMCxQcFQIUHQ8GEARqRDeCR2lJOgINA?=
 =?us-ascii?q?jWCHiRYgiuEWoRDhE2CQ1SCRIISdIEagjKGCkADCxgNSBEsNwYOGwY+bgedT?=
 =?us-ascii?q?TyEFgEBgQ0BeytuFFGTDwmSIaEEhCWBY59jGjOqU5h8IqNvN4RmgWc8gVkzG?=
 =?us-ascii?q?ggbFYMiUhkP2mklMjwCBwsBAQMJkXwBAQ?=
IronPort-Data: A9a23:KspvU68CnrHddiaW262rDrUDon+TJUtcMsCJ2f8bNWPcYEJGY0x3y
 TAWXGCPOayNa2f2KNwnOou19E4CupWDyoc2T1Nv/yFEQiMRo6IpJzg2wmQcns+2BpeeJK6yx
 5xGMrEsFOhtEDmE4E/rauW5xZVF/fngbqLmD+LZMTxGSwZhSSMw4TpugOdRbrRA2bBVOCvT/
 4qpyyHjEAX9gWMsaDpJs/jrRC5H5ZwehhtJ5jTSWtgT1LPuvyF9JI4SI6i3M0z5TuF8dsamR
 /zOxa2O5WjQ+REgELuNyt4XpWVTH9Y+lSDX4pZnc/DKbipq/0Te4Y5nXBYoUnq7vh3S9zxHJ
 HqhgrTrIeshFvWkdO3wyHC0GQkmVUFN0OevzXRSLaV/wmWeG0YAzcmCA2ltJrAx3N11EV1D5
 NAoLDJONUmc2/yplefTpulE3qzPLeHxN48Z/3UlxjbDALN+HdbIQr7B4plT2zJYasJmRKmFI
 ZFGL2AyMVKZP0Qn1lQ/UPrSmM+qgXn5fzRcpXqepLE85C7YywkZPL3Fa4OII4XTFJwF9qqej
 kbG7krCDDMCDe6W8SO9/X2l3ezvwBquDer+E5X9rJaGmma7ymUNBRg+WVKlrPy9jUCiHdRSN
 yQ89yYzqKEg+VCDQd76UBm15nWDu3Y0WMdaGsU55RuLx66S5ByWbkANSDJbZcNlssIqSTE0/
 luUmdWvDjwHmKWcQ3+b95+OoD+yMDRTJmgHDQcCQBcJ7sfLvo4+lFTMQ8xlHarzicf6cQwc2
 BiQpyQ4wrFWhskR2uDjoRbMgimnod7CSQtdChjrY19JJzhRPOaND7FEI3CChRqcBO51lmW8g
 UU=
IronPort-HdrOrdr: A9a23:XUrQQ6Gq7JW+nUIbpLqE48eALOsnbusQ8zAXPo5KJiC9Ffbo8v
 xG88576faZslsssRIb6LK90de7IU80nKQdieJ6AV7IZmfbUQWTQL2KlbGSoAEJ30bFh4lgPW
 AKSdkbNOHN
X-Talos-CUID: 9a23:csfwEm3P+9ATYscdur5cU7xfQdsYW1vmzmfsLl6UOWJrC+bMVgOO5/Yx
X-Talos-MUID: =?us-ascii?q?9a23=3AEIbXUQ2kqbHRPBjF52HbfJf2VzUjx6S/JnsDs40?=
 =?us-ascii?q?/icC8LBR/ND7GjxTqe9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,262,1732579200"; 
   d="scan'208";a="315111918"
Received: from rcdn-l-core-04.cisco.com ([173.37.255.141])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 05 Feb 2025 23:54:25 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-04.cisco.com (Postfix) with ESMTP id 8B4461800019D;
	Wed,  5 Feb 2025 23:54:25 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 5B1CD20F2003; Wed,  5 Feb 2025 15:54:25 -0800 (PST)
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
Subject: [PATCH net-next v8 0/4] enic: Use Page Pool API for receiving packets
Date: Wed,  5 Feb 2025 15:54:12 -0800
Message-Id: <20250205235416.25410-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-04.cisco.com

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
- Added return code check for page_pool_create()

Change in v8:
- removed vestiges of rx copybreak

John Daley (4):
  enic: Move RX functions to their own file
  enic: Simplify RX handler function
  enic: Use the Page Pool API for RX
  enic: remove copybreak tunable

 drivers/net/ethernet/cisco/enic/Makefile      |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h        |   4 +-
 .../net/ethernet/cisco/enic/enic_ethtool.c    |  39 ---
 drivers/net/ethernet/cisco/enic/enic_main.c   | 274 ++----------------
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 242 ++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |  10 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 7 files changed, 290 insertions(+), 283 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.44.0


