Return-Path: <netdev+bounces-231426-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F3FCBF9332
	for <lists+netdev@lfdr.de>; Wed, 22 Oct 2025 01:20:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0474A4E1F96
	for <lists+netdev@lfdr.de>; Tue, 21 Oct 2025 23:20:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3A1C29D276;
	Tue, 21 Oct 2025 23:20:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AWswjstq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 088AB143C61
	for <netdev@vger.kernel.org>; Tue, 21 Oct 2025 23:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761088812; cv=none; b=BmZqH89CXHHyOiqHxeBUdjvhsfCHpAAnfo4NX0XbWilME710CFWkku58qbFZnyWHOBMNGmH1PWSUPLrJJhfhIIqhGoCuEr8P46b1+QAwlfrDlC2GYR341Cxn2eBJZnqXbCHCYjt01mg2tjyZodnHGKFaE+Mw0h1+V95QuB67N1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761088812; c=relaxed/simple;
	bh=qVMCjY2QkM8JoERwPFi7tBz4Ibd7sbmtbKBrJpNEjAk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=tNtFJcnuEPQZHhhRduTJCiRnrSwrgMwmhtQg29Iubs1PEaEJt9epSOztGZG2KKIUWkRsfi6XbjEUd5BkkV6Ko6tBZehyWIMjg8qM/+S3c6lcELlYLnGqQwxfM1QkN41FhWaROH5jZ6gSLtZDUHCTzWLK6JGNtHvEfZ576Brr3vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AWswjstq; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761088811; x=1792624811;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=qVMCjY2QkM8JoERwPFi7tBz4Ibd7sbmtbKBrJpNEjAk=;
  b=AWswjstq879I2rDIKcVZKw+6/y5mIhFkHkj9yBq9LudY1w5U8bBLSmTG
   cwhe9InY8N2YQWW0dcC9IOBVBrG8/l5EP340yZzRiOjisANuMR6LLFO99
   EAyEYCy2k7aEm49mvuKog1aQNuN0awxp5MjZ2rWDBAKTbKzwycSX+Lu6d
   8xC7D9qkIaUKrGYOTv+ulocxQ7lhPSiGZA2Mo0xyQZlilVUgpoQ/7f7Aa
   I4xZntBSCe2TUla7yutRQM9+AkrZ+Yv81xROGqSMLuYvuGz7t8eNsIbQO
   hjmzyB1nOmUKPOq5UsrGqSfvujuWqN6Dh5zBSqjqsupDJ90D8n7kzz+ji
   g==;
X-CSE-ConnectionGUID: Q0OFSd3jT4O4Jcm6z7D6Lw==
X-CSE-MsgGUID: tJDeYeDNT4mw41BI3opwIA==
X-IronPort-AV: E=McAfee;i="6800,10657,11586"; a="66868444"
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="66868444"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2025 16:20:11 -0700
X-CSE-ConnectionGUID: 6TdtskARQSiNezQLV8XLmA==
X-CSE-MsgGUID: EtelkaLQT76r+j+wATuKlQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,246,1754982000"; 
   d="scan'208";a="214352297"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa002.jf.intel.com with ESMTP; 21 Oct 2025 16:20:11 -0700
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-next v9 00/10] refactor IDPF resource
Date: Tue, 21 Oct 2025 16:30:46 -0700
Message-Id: <20251021233056.1320108-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Queue and vector resources for a given vport, are stored in the
idpf_vport structure. At the time of configuration, these
resources are accessed using vport pointer. Meaning, all the
config path functions are tied to the default queue and vector
resources of the vport.

There are use cases which can make use of config path functions
to configure queue and vector resources that are not tied to any
vport. One such use case is PTP secondary mailbox creation
(it would be in a followup series). To configure queue and interrupt
resources for such cases, we can make use of the existing config
infrastructure by passing the necessary queue and vector resources info.

To achieve this, group the existing queue and vector resources into
default resource group and refactor the code to pass the resource
pointer to the config path functions.

This series also includes patches which generalizes the send virtchnl
message APIs and mailbox API that are necessary for the implementation
of PTP secondary mailbox.

---
v9:
* move iterator declaration changes to separate commit

v8:
* rebase on AF_XDP series [1]
* drop one commit as it was no longer necessary
* add new commit ("idpf: remove vport pointer from queue sets")
to make recently introduced queue_sets compatible with resoure
refactor and corresponding API changes

v7:
* modify idpf_q_vec_rsrc declaration in idpf_vport struct to not
mess with memcpy in idpf_initiate_soft_reset
* reshuffle vport struct fields to avoid holes

v6:
* packed idpf_queue_id_reg_chunk struct
* fixed inconsistent use of caps/small case for kdoc
* initialized loop iterator inloop and used the right type
* moved adapter out of the loop in idpf_rxq_group_alloc

v5:
* update function parameters to pass chunks as needed
* revert back the 'idpf_is_feature_ena' changes
* remove redundant vport parameter in idpf_[add/del]_mac_filter
* refactor all send_virtchnl APIs to avoid accessing vport pointer
* refactor get_ptypes to avoid calling it for each vport

v4:
* introduce local idpf structure to store virtchnl queue chunks
* remove 'req_qs_chunks' field
* fix function doc comments to use caps or lower case letters

v3:
* update commit message of 6th patch

v2:
* fix kdoc issues (s/rss/RSS, add return statement)
* rename structure idpf_rsrc to idpf_q_vec_rsrc
* reshuffle struct members to avoid holes created in idpf_q_vec_rsrc and
idpf_vport structures
* introduce additional 2 patches to the series which generalizes the
send virtchnl message APIs and mailbox APIs
* fix unintialized usage of a variable in idpf_initiate_soft_reset
(reported by kernel bot)

[1]
https://lists.osuosl.org/pipermail/intel-wired-lan/Week-of-Mon-20250908/050286.html

Joshua Hay (2):
  idpf: move some iterator declarations inside for loops
  idpf: remove vport pointer from queue sets

Pavan Kumar Linga (8):
  idpf: introduce local idpf structure to store virtchnl queue chunks
  idpf: introduce idpf_q_vec_rsrc struct and move vector resources to it
  idpf: move queue resources to idpf_q_vec_rsrc structure
  idpf: reshuffle idpf_vport struct members to avoid holes
  idpf: add rss_data field to RSS function parameters
  idpf: generalize send virtchnl message API
  idpf: avoid calling get_rx_ptypes for each vport
  idpf: generalize mailbox API

 drivers/net/ethernet/intel/idpf/idpf.h        |  177 +--
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   18 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |   93 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  212 ++--
 drivers/net/ethernet/intel/idpf/idpf_ptp.c    |   17 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  735 ++++++------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |   41 +-
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   21 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1038 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   81 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |   48 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |    6 +-
 drivers/net/ethernet/intel/idpf/xsk.c         |   12 +-
 13 files changed, 1372 insertions(+), 1127 deletions(-)

-- 
2.39.2


