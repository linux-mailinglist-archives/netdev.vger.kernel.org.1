Return-Path: <netdev+bounces-154404-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 166A79FD862
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 01:12:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AC4CF3A1DF2
	for <lists+netdev@lfdr.de>; Sat, 28 Dec 2024 00:12:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 772CC2111;
	Sat, 28 Dec 2024 00:12:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="DRv2sg0o"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-4.cisco.com (rcdn-iport-4.cisco.com [173.37.86.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C29A1635
	for <netdev@vger.kernel.org>; Sat, 28 Dec 2024 00:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735344727; cv=none; b=E3VRdjCN9D04N1fSZ/m6uEyaKBJeqBE6/7nDVYx90rTXFMe2dsMSx9ZFklA3h7yfPNunnS1pg5yPHL8qQ/+oy3/ZVpXcb7IfAXtcMEhCXa9bh2SDMCYrazrdHkNJ8SKY/YH1WfhGZbjRZEcrcpIfZd1pvPWKy1QxlSZ0pembKWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735344727; c=relaxed/simple;
	bh=JafIP02PO98uLZKXO0izV+3usrl3hFYSBRFV6/i6/pU=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=PSOaBe3iQ6S12bY7LvvjSHtoZS07lyqAXCIOcyJLGFiX7xU/kYBQUDpmm0H796MDmNU3VCPPhtKB7QvCt6PqziXPYDWiivWvdtABMTp6X3daNOV6DLI5voRK+MbwNuNwiSf8t9aGzDGJf1ldktm7LTSgxSMoHDOYlCz1taa+AQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=DRv2sg0o; arc=none smtp.client-ip=173.37.86.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2266; q=dns/txt; s=iport;
  t=1735344725; x=1736554325;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kKCGtv0yJ7J7+k1hTKbyErreujSmpcX/Lt98Wk7ACsg=;
  b=DRv2sg0ou+fsBMSEt7dXSb1+boDzLWksXjnbmXTqrq8amnilQkAb/ek2
   FTbEZnghdWRF1VVb3y1lEMAms7t/qlalBC5bbqWG4y6iNlcVXDe7p7WmR
   h+J8VOQIVNLmvPSRjqMtzlR6cyUes87HcRNNlsc349q3uZEs1E2qT23sR
   8=;
X-CSE-ConnectionGUID: 4ejswKsdRhiraQy94VOKlw==
X-CSE-MsgGUID: 8Zvg1p1qQuepciEL6+D+8A==
X-IPAS-Result: =?us-ascii?q?A0BcAwDJQG9n/4r/Ja1aglyCS4FPQ0iNUYhynhsUgREDV?=
 =?us-ascii?q?g8BAQEPRAQBAYUHinACJjQJDgECBAEBAQEDAgMBAQEBAQEBAQEBAQsBAQUBA?=
 =?us-ascii?q?QECAQcFgQ4ThgiGXTYBRoEMMhKDAYJlA7E5giyBAd4zgW2BSIVrh19whHcnG?=
 =?us-ascii?q?4FJRIQOb4QpZ4V3BIIfF4EngUCDeJ5ySIEhA1ksAVUTDQoLBwWBOToDIgwLD?=
 =?us-ascii?q?AsUHBUCgR6BAhQGFQSBC0U9gkppSTcCDQI2giAkWIJNhReEXoRWgklVgnuCF?=
 =?us-ascii?q?3yBGoIlQAMLGA1IESw3Bg4bBj5uB5xfRoNzgQ4BE2grHVEUPgIRkyGSFaEDh?=
 =?us-ascii?q?CSBY59jGjOqUph8IqNtN4RmgWc8gVkzGggbFYMiUhkPji0WtSAlMjwCBwsBA?=
 =?us-ascii?q?QMJjzYGgXcBAQ?=
IronPort-Data: A9a23:PQlD/anmjPjYJEQoUosw4A3o5gyjJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIbUD3VOvuKa2uhfookaI619hsAuZHVztU1TQRvqy02F1tH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pe31GONgWYubjtOsf3b9HuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FdEV+P1oInpCz
 /wZMjk0f0HfucWVxK3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMiaBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQUaj/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKOIoTVFZ0FxxvwS
 mTur1bnDUgCbcWm1Ded+XOBorGMsWCrcddHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAiexTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxa8owFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:5drDAa79A2vDwgkwogPXwMPXdLJyesId70hD6qm+c3Nom6uj5q
 WTdZsgtCMc5Ax9ZJhCo6HjBED/exPhHPdOiOF7V4tKNzOJhILHFu1fBPPZsl7d8+mUzJ876U
 +mGJIObOHNMQ==
X-Talos-CUID: 9a23:nl0fa2BqGK09Dt/6E3Vq9lULOdspSH3c1n7pMh7kN0FKTKLAHA==
X-Talos-MUID: =?us-ascii?q?9a23=3AWiJNRw1FH60A5yKu0auTB8CH+jUjs5awBxkVyIw?=
 =?us-ascii?q?/psScPi1dH2neoHfna9py?=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,269,1728950400"; 
   d="scan'208";a="300780815"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by rcdn-iport-4.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 28 Dec 2024 00:10:57 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTP id 9A3421800029F;
	Sat, 28 Dec 2024 00:10:57 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id 70F1620F2003; Fri, 27 Dec 2024 16:10:57 -0800 (PST)
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
Subject: [PATCH net-next v3 0/6] enic: Use Page Pool API for receiving packets
Date: Fri, 27 Dec 2024 16:10:49 -0800
Message-Id: <20241228001055.12707-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-01.cisco.com

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
- Moved a function to before where is was and removed the forward
  declaration. Reworded a commit message. No functional changes.

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
 drivers/net/ethernet/cisco/enic/enic_rq.c     | 261 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h     |  27 ++
 drivers/net/ethernet/cisco/enic/vnic_rq.h     |   2 +
 8 files changed, 401 insertions(+), 146 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.35.2


