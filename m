Return-Path: <netdev+bounces-238161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 786A0C54E6B
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 01:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id D755E348F6E
	for <lists+netdev@lfdr.de>; Thu, 13 Nov 2025 00:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D6D1E868;
	Thu, 13 Nov 2025 00:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Bvgv5qyq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60FCF1E89C
	for <netdev@vger.kernel.org>; Thu, 13 Nov 2025 00:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762993859; cv=none; b=DPH1z94xcyi1uGN+/dow9rcBintNZHH5q9FVM4o0xxBccMhcqOHZz9HSXTDChqyZVlt/W5TSS5tohJOXTIyWAJb8zo/NjXk8haoE0vTxP33qVRRKFpaKzjlxH8c+rB2jmXZxXGQnScV5KrJMmwaW7VVp/G5Ibdi2AtjCSCxhgec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762993859; c=relaxed/simple;
	bh=bqiGwZWBSOW8OWX12O0Etl/S678/8vxVit3LLhrgjBA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=dW9KBjKmm5tRJIM7MTIr4bq/suL2JNImqQ62UqzHVR9gH1mlr2QZvcFszcx1na4ezAS04WsJ3mdIh6duF2zVGrf9/yc2chzB2RStZZ1HbZFaUJD1DktFc4LgZwBdjItyuTH+Q6wn4E5Mm//TV5+2qZdtrIH71CtniDUkDpaFGPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Bvgv5qyq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762993857; x=1794529857;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bqiGwZWBSOW8OWX12O0Etl/S678/8vxVit3LLhrgjBA=;
  b=Bvgv5qyqJBsZuO536yJ9MhpEI2rmB8fYOwiQ4u5nbaOXexMqbT7CppDB
   wTMfozQTSSZb2XjJrAy20dhAXDUPU/YnT/rYN2HLkJRFgyHZpR6qbD2++
   VtmH2mCSExc9fPO3r7qHqg6Z5PAd+mVrMP4Z2n9XqDDmPswHF0Hk2P4bF
   86t4qnzzDzFYQB0NtCJAC6cz/JtBocsGqai9PSl4BGu98yJxezdHM2gMi
   Cw7qkdegx9OrYgmiLbXNL0UcWZCBLUniPDHkiVfy8E65iSeLlXGE0EF48
   uli8+CHXyE5tfBK6Le+O3BIIpvKLsM47emGDxeeVcPM9+6ECWKM/cclp6
   Q==;
X-CSE-ConnectionGUID: PUE45ynqTR+Rk6rOt8+0iQ==
X-CSE-MsgGUID: GCJqe61QRYmPStrujeHWGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11611"; a="82465645"
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="82465645"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Nov 2025 16:30:56 -0800
X-CSE-ConnectionGUID: AJCU0pI1R8+guqM+HWsmSg==
X-CSE-MsgGUID: 1XI4YxzURBCorGfNQo7+Bw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,300,1754982000"; 
   d="scan'208";a="190099550"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by fmviesa010.fm.intel.com with ESMTP; 12 Nov 2025 16:30:56 -0800
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org
Subject: [Intel-wired-lan][PATCH iwl-next v10 00/10] refactor IDPF resource
Date: Wed, 12 Nov 2025 16:41:33 -0800
Message-Id: <20251113004143.2924761-1-joshua.a.hay@intel.com>
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
v10:
* resolved queue_chunk memory leak and added queue_chunk deinit helper
func
* rebased on tip of dev-queue 

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
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 1045 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.h   |   88 +-
 drivers/net/ethernet/intel/idpf/xdp.c         |   48 +-
 drivers/net/ethernet/intel/idpf/xdp.h         |    6 +-
 drivers/net/ethernet/intel/idpf/xsk.c         |   12 +-
 13 files changed, 1386 insertions(+), 1127 deletions(-)

-- 
2.39.2


