Return-Path: <netdev+bounces-157310-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D34B5A09EB4
	for <lists+netdev@lfdr.de>; Sat, 11 Jan 2025 00:33:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DA2A03A9A0C
	for <lists+netdev@lfdr.de>; Fri, 10 Jan 2025 23:32:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98EC121D010;
	Fri, 10 Jan 2025 23:32:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b="CxcHR4A0"
X-Original-To: netdev@vger.kernel.org
Received: from alln-iport-7.cisco.com (alln-iport-7.cisco.com [173.37.142.94])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC52214A9E
	for <netdev@vger.kernel.org>; Fri, 10 Jan 2025 23:32:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.37.142.94
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736551976; cv=none; b=S1DLXPDw+ptbyoteiF2G4AE2n03toaNfFhJYiQ2f6Sa6yvMYz5Z2YJCiiZsK9SWGwEUu1wxs0tBVl/B+UVwoouVoPlgYXvkLN3TTkpozsLneovzlhs6PnkuuQ7v8Pg28S22KxbvoKF+BqfTNtxPCLnJhpccYAT8DGxEUVpSJ3cQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736551976; c=relaxed/simple;
	bh=LRuIKveQyqKBI5m0KJvqEi9ofplTJRjv+B2LUIZQ39A=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qmS0qcv5QA8zickGdwZwWS/yvkEpn+/Qt+Rm5IrDrt4m/Vqk4MIi/5FOfKFM13P70skYKF/JdwdqZ7y7lv96HEn4OeOnm/m/b+cqkdCheRX5ZrG+/890A1yBixtVj13mVluoqIBHdgM2pE5Zd5h/59+a4Fvzznv/3diHGX4t6jE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com; spf=pass smtp.mailfrom=cisco.com; dkim=pass (1024-bit key) header.d=cisco.com header.i=@cisco.com header.b=CxcHR4A0; arc=none smtp.client-ip=173.37.142.94
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=cisco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cisco.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=cisco.com; i=@cisco.com; l=2981; q=dns/txt; s=iport;
  t=1736551974; x=1737761574;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Vg8/RvYngGCei2tfozojNQdvnfKIM6AzSwp04lSARFU=;
  b=CxcHR4A0W7nXEUjTcoSsAPoGsUGEh4WMDseEx+JRZ+9xy8bJ6Hrcan1z
   lMwF4mR5P1G/5L+ARoK3rmQDPOCAke3UG+r0Rb8uC9bTxs1zvs+qb7Ejv
   7ejaspVpgK45s0ZOE5wYm3VNhLzlzmRqlTJsE6MdkZl9ji63vgV5Ue2/5
   M=;
X-CSE-ConnectionGUID: RJ5OhfEsQi2k2TaVzTsk5g==
X-CSE-MsgGUID: zpcjNsyySX6+cU+lJQWVYw==
X-IPAS-Result: =?us-ascii?q?A0AjAQD8rIFnj4r/Ja1aHgEBCxIMgggLhBpDSI1RiHKeG?=
 =?us-ascii?q?xSBEQNWDwEBAQ9EBAEBhQeKdgImNAkOAQIEAQEBAQMCAwEBAQEBAQEBAQEBC?=
 =?us-ascii?q?wEBBQEBAQIBBwUUAQEBAQEBOQVJhgiGXTYBRoEMMhKDAYJlA7RNgiyBAd4zg?=
 =?us-ascii?q?W2BSIVrh19whHcnG4FJRIQOb4QpZ4V3BIIbF4FHg26eUkiBIQNZLAFVEw0KC?=
 =?us-ascii?q?wcFgTg6AyILCwwLFBwVAhUfEQYQBG1EN4JGaUs6Ag0CNYIeJFiCK4RchEeEV?=
 =?us-ascii?q?IJLVYJHghR6gRmCP4FCQAMLGA1IESw3Bg4bBj5uB5snPINvgQ4BE2grHVEUP?=
 =?us-ascii?q?gIRkyGSFaEDhCWBY59jGjOqU5h8IqNuN4RmgWc6gVszGggbFYMiUhkPjjq8Z?=
 =?us-ascii?q?SUyPAIHCwEBAwmPIQaBdwEB?=
IronPort-Data: A9a23:r+7pLa6J1umUBymZXNSm4wxRtN3HchMFZxGqfqrLsTDasY5as4F+v
 mROUTvQa/7bMWHzfooja4+xpk1U6MKEnIUyT1E+rnpgZn8b8sCt6fZ1gavT04J+CuWZESqLO
 u1HMoGowPgcFyGa/lH1dOC89RGQ7InQLpLkEunIJyttcgFtTSYlmHpLlvUw6mJSqYDR7zil5
 5Wr+aUzBHf/g2QpajtNs/rYwP9SlK2aVA0w7wRWic9j5Dcyp1FNZLoDKKe4KWfPQ4U8NoaSW
 +bZwbilyXjS9hErB8nNuu6TnpoiG+O60aCm0xK6aoD66vRwjnVaPpUTaJLwXXxqZwChxLid/
 jniWauYEm/FNoWU8AgUvoIx/ytWZcWq85efSZSzXFD6I0DuKxPRL/tS4E4eB69F3eZ5LHp39
 KYbcgwEUAK/nOHrz+fuIgVsrpxLwMjDJogTvDRkiDreF/tjGcmFSKTR7tge1zA17ixMNa+BP
 IxCNnw1MUmGOkYfUrsUIMpWcOOAhH7/dTFRrF+9rqss6G+Vxwt0uFToGIaMI4XUHJ8Exy50o
 ErU52/7JAoLJeevl3mOzzGopNbwoxLkDdd6+LqQraMy3wbJmQT/EiY+WVKlrPyRhkegVtdbL
 EIIvCwjscAa+UC2S9DvUgGQr3mDsRoRHdFXFoUS6xyHw4LX7hyfC2xCSSROAPQvssMsSCNp0
 FKVk973LThytrvTQnL13q+dpz60OAAPIGMCbDNCRgwAi/HlrZ0/gwznUNluCui2g8fzFDW2x
 CqFxBXSnJ0JhsINkqH+9lfdjnf0/97CTxU+4UPcWWfNAh5FiJCNXa71zljVwO15LdyaFGWIg
 mo4gMvD47VbZX2SrxClTOIIFbCvwv+KNjzAnFJid6XNERzzoBZPmqgOu1lDyFdVDyoSRdP+j
 KbuVeJtCH17YSDCgUxfOt7Z5yEWIU7ITouNuhf8NYUmX3SJXFXblByCnGbJt4wXrGAikLskJ
 bCQetu2AHARBMxPlWXtGbtBjuJ3mnxglQs/oKwXKTz6jtJyg1bIGN843KemNLpRAF6s+V+Mq
 ogDZ6NmNT0AALWkOUE7DrL/3XhRcCBkXsqpwyCmXuWCOQFhUHowEOPcxKhpeopu2cxoehTgo
 BmAtrtj4AOn3xXvcFzSAlg6MeOHdcgk9xoTY3dzVWtELlB/Ou5DGo9DLMNvJdHKNYVLkZZJc
 hXyU5zcU6gWGm6aoVzwr/DV9eRfSfhivirWVwLNXdT1V8UIq9DhkjM8QjbSyQ==
IronPort-HdrOrdr: A9a23:uk5Lsq4Nx0NLbdexRQPXwMPXdLJyesId70hD6qm+c3Nom6uj5q
 WTdZsgtCMc5Ax9ZJhCo6HjBED/exPhHPdOiOF7V4tKNzOJhILHFu1fBPPZsl7d8+mUzJ876U
 +mGJIObOHNMQ==
X-Talos-CUID: 9a23:K7zzt2wWqoG3QxvaVbq1BgUuOJ0CcnPw107ReUziNW9XWoGOSgKfrfY=
X-Talos-MUID: 9a23:Dk9sAgkjlPByj/QpTpZ1dnpwLMxqxb+/GXs9z9YNhoqAFxVPBQaC2WE=
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="6.12,305,1728950400"; 
   d="scan'208";a="411161291"
Received: from rcdn-l-core-01.cisco.com ([173.37.255.138])
  by alln-iport-7.cisco.com with ESMTP/TLS/TLS_AES_256_GCM_SHA384; 10 Jan 2025 23:32:53 +0000
Received: from cisco.com (savbu-usnic-a.cisco.com [10.193.184.48])
	by rcdn-l-core-01.cisco.com (Postfix) with ESMTP id 0DBC018000295;
	Fri, 10 Jan 2025 23:32:53 +0000 (GMT)
Received: by cisco.com (Postfix, from userid 392789)
	id D835C20F2003; Fri, 10 Jan 2025 15:32:52 -0800 (PST)
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
Subject: [PATCH net-next v5 0/4] enic: Use Page Pool API for receiving packets
Date: Fri, 10 Jan 2025 15:32:45 -0800
Message-Id: <20250110233249.23258-1-johndale@cisco.com>
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

Older hardware does not support receiving a packet into multiple
discontiguous pages. We elected not to use page pool order greater than
0 for large packets because of the potential for wasted memory. E.g.
if MTU is 9000 the page pool order would have to be 2 and one full
page would be wasted per buffer. For this reason, page_pool is not
used if MTU is greater than PAGE_SIZE and the original RX path where
netdev_alloc_skb_ip_align() is used for buffer allocation. Function
pointers are used to select functions based on the MTU.

Some refactoring was done so that common code can be shared. The
refactored functions and the new functions using page pool are in a
new file called enic_rq.c.

Removed an unused parameter from a function which was found during this
effort.

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
*** BLURB HERE ***

John Daley (4):
  enic: Refactor RX path common code into helper functions
  enic: Remove an unnecessary parameter from function enic_queue_rq_desc
  enic: Use function pointers for buf alloc, free and RQ service
  enic: Use the Page Pool API for RX when MTU is less than page size

 drivers/net/ethernet/cisco/enic/Makefile    |   2 +-
 drivers/net/ethernet/cisco/enic/enic.h      |  15 ++
 drivers/net/ethernet/cisco/enic/enic_main.c | 167 +++++---------
 drivers/net/ethernet/cisco/enic/enic_res.h  |  10 +-
 drivers/net/ethernet/cisco/enic/enic_rq.c   | 243 ++++++++++++++++++++
 drivers/net/ethernet/cisco/enic/enic_rq.h   |  27 +++
 drivers/net/ethernet/cisco/enic/vnic_rq.h   |   2 +
 7 files changed, 352 insertions(+), 114 deletions(-)
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.c
 create mode 100644 drivers/net/ethernet/cisco/enic/enic_rq.h

-- 
2.44.0


