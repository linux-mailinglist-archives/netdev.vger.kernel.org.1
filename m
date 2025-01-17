Return-Path: <netdev+bounces-159178-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E109A14A99
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 09:02:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 22592160926
	for <lists+netdev@lfdr.de>; Fri, 17 Jan 2025 08:02:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC06D1F791E;
	Fri, 17 Jan 2025 08:01:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="KO0tS2NM"
X-Original-To: netdev@vger.kernel.org
Received: from rcdn-iport-9.cisco.com (rcdn-iport-9.cisco.com [173.37.86.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D52C31F7911
	for <netdev@vger.kernel.org>; Fri, 17 Jan 2025 08:01:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.86.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737100911; cv=none; b=Lp+PHy+aNcufECa7VZGLopIjES23g06wlqjRygmojAiHbZqtoeSkKP7mXXzPRrIHIUkz3e+/0gtjkaa6uK7c12K72GzrZyEGtBLz2yqYIoKbaNm/zL/PqZMCcRoO1M7uSKOuYEokVNBzBV47NT1s6Gn47irjyYEinG/kWoAQj4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737100911; c=relaxed/simple;
	bh=CD3z4D6+KGCya1f0p2QM0edD2+4kXFPHcQctqjoD+I8=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aHk0X4qY2ctP2fAT7+aPp+i4E9I6cCQ96WG+1L01Zl1b2LbpjTys3LINbn0cuM1sI3ulVPadKbi2VUFJ6VvSIbVXXj7Fgr0k30xNW2BZ/ZL5Sl5yH7Nd8Wp+lLxTQat/+lLEUZ5/L8pQ4MhtKgq6Tn8v43mZLu8YDq2oXvS4Mss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=KO0tS2NM; arc=none smtp.client-ip=173.37.86.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2314; q=dns/txt; s=iport;
  t=1737100909; x=1738310509;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kXoVI7oyXn7P7i7VP0IK65FLIVy4Cm4cahbGupIiaGk=;
  b=KO0tS2NMn3cArpHZEAmMAYJQqDYYyK7k2v65leP95afIQ2ZxomFAxtxI
   KOBx9yYxJgYZsBhc0yWD2r/FYY3NGrgYZbrWy5dSSCHwoVOOOiRBwbvhL
   o06t2zn2P9PxASzhKqIiqASKAnKtSSqinfZobgn0WgXjK8+2RBj5JiQvX
   k=;
X-CSE-ConnectionGUID: u4wGIz+QQTypq6tetp4bBg==
X-CSE-MsgGUID: 9hsFcGNES6mZsho+Qn2/Bg==
X-IPAS-Result: =?us-ascii?q?A0BBAADmDIpn/5P/Ja1aHQEBAQEJARIBBQUBgX8IAQsBg?=
 =?us-ascii?q?kqBT0NIjHJfiHOeGxSBEQNWDwEBAQ9EBAEBhQeKdQImNAkOAQIEAQEBAQMCA?=
 =?us-ascii?q?wEBAQEBAQEBAQEBCwEBBQEBAQIBBwWBDhOGCIZdNgFGgQwyEoMBgmUDsx+CL?=
 =?us-ascii?q?IEB3jOBbYFIAYVqh19whHcnG4FJRIQOb4QpZ4V3BIIygUWDbp8ySIEhA1ksA?=
 =?us-ascii?q?VUTDQoLBwWBOTgDIgsLDAsUHBUCFR0PBhAEbUQ3gkZpSTcCDQI1gh4kWIIrh?=
 =?us-ascii?q?FyERYRRgkdUgkeCFHqBGoI3gjhAAwsYDUgRLDcGDhsGPm4Hm1M8g3OBDgF7K?=
 =?us-ascii?q?24UUZMOCZIfoQOEJYFjn2MaM6pTmHwio243hGaBZzyBWTMaCBsVgyJSGQ/QB?=
 =?us-ascii?q?SUyPAIHCwEBAwmRXgEB?=
IronPort-Data: A9a23:p4wA/qlstqGTGDgTa0lnt1Lo5gyjJ0RdPkR7XQ2eYbSJt1+Wr1Gzt
 xIYD23SbPeLM2X3Ko11bdzlo0JVscCGmNI3SgNrqik2EFtH+JHPbTi7wugcHM8zwunrFh8PA
 xA2M4GYRCwMZiaC4E/rav658CEUOZigHtLUEPTDNj16WThqQSIgjQMLs+Mii+aEu/Dha++2k
 Y20+pa31GONgWYubzpNsv3b8XuDgdyr0N8mlg1mDRx0lAe2e0k9VPo3Oay3Jn3kdYhYdsbSb
 /rD1ryw4lTC9B4rDN6/+p6jGqHdauePVeQmoiM+t5mK2nCulARrukoIHKZ0hXNsttm8t4sZJ
 OOhGnCHYVxB0qXkwIzxWvTDes10FfUuFLTveRBTvSEPpqHLWyOE/hlgMK05FZBE5clWEyJ3z
 MAJMClTch2fn7686r3uH4GAhux7RCXqFJkUtnclyXTSCuwrBMmbBa7L/tRfmjw3g6iiH96HO
 JFfMmUpNkmdJUQTZT/7C7pm9Ausrnv4cztUoVaYjaE2+GPUigd21dABNfKOIoLaFJ4Jxx3wS
 mTurmTiLBo1EvGklz+36XKrxdbJx2TRV9dHfFG/3rsw6LGJ/UQfAQMbUHO3qOe0j0q5Vc4ZL
 UEIkgIjobU3/V6mUvHyWBq3pHPCtRkZM/JTDuczwAKA0KzZ50CeHGdsZjdHZMYrq4wwSCAm2
 0Ghm87vA3pksNW9UXuX+7GVhSm/NSgcMSkJYipsZQ0I/9XuvqktgR/VCNVuCqi4ipvyAz6Y/
 tyRhDI1i7NWiYsA0L+2uAmfxTmtvZPOCAUy4207Q16Y0++wX6b9D6TA1LQRxa8owFqxJrVZg
 EU5pg==
IronPort-HdrOrdr: A9a23:Tq9uzKxMI5JfWfeAIqK8KrPwJ71zdoMgy1knxilNoNJuHfBw8P
 re+cjzuiWUtN98YhwdcLO7Scu9qA3nlaKdiLN5VdzJYOCMggWVxe9ZgbcKuweQeBEXMoVmpM
 Bdm28UMqyVMWRH
X-Talos-CUID: =?us-ascii?q?9a23=3APMoHEWql3U81poJVpEPV38HmUd15bVL83jTpGnO?=
 =?us-ascii?q?pEX83VLCJUQOa0qwxxg=3D=3D?=
X-Talos-MUID: 9a23:gLYw8QjTVHE+cZWj+uqe2cMpZcdzza+BLm02z5A0oMmDdhV2YXC3g2Hi
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.13,211,1732579200"; 
   d="scan'208";a="306893413"
Received: from rcdn-l-core-10.cisco.com ([173.37.255.147])
  by rcdn-iport-9.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 17 Jan 2025 08:01:41 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-10.cisco.com (Postfix) with ESMTP id CFF4C1800026D;
	Fri, 17 Jan 2025 08:01:41 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id A6D6420F2003; Fri, 17 Jan 2025 00:01:41 -0800 (PST)
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
Subject: [PATCH net-next v6 0/3] enic: Use Page Pool API for receiving packets
Date: Fri, 17 Jan 2025 00:01:36 -0800
Message-Id: <20250117080139.28018-1-johndale@cisco.com>
X-Mailer: git-send-email 2.35.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Outbound-SMTP-Client: 10.193.184.48, savbu-usnic-a.cisco.com
X-Outbound-Node: rcdn-l-core-10.cisco.com

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

John Daley (3):
  enic: Move RX functions to their own file
  enic: Simplify RX handler function
  enic: Use the Page Pool API for RX

 drivers/net/ethernet/cisco/enic/Makefile    |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h      |   3 +
 drivers/net/ethernet/cisco/enic/enic_main.c | 264 ++------------------
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 242 ++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h   |  10 +
 drivers/net/ethernet/cisco/enic/vnic_rq.h   |   2 +
 6 files changed, 283 insertions(+), 240 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.35.2


