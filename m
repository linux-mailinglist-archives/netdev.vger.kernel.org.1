Return-Path: <netdev+bounces-110633-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15A1092DA13
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 22:30:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 55EA1B23689
	for <lists+netdev@lfdr.de>; Wed, 10 Jul 2024 20:30:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6EE7B19007C;
	Wed, 10 Jul 2024 20:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q4EEDafw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 758DA8289A
	for <netdev@vger.kernel.org>; Wed, 10 Jul 2024 20:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720643444; cv=none; b=p/jj1Ejl9sYbXfdNQzxwZbDQdOj10qrhFASaUsexJEHvSfKNRXGPJSriY2P+pCsHwI5GNL4BqIos3PgNZuFC9uLuSs5l2HmCfpwGVzXKGkzcc3lLYFe7AnVdGEoeoFAsvR+GP8qICF/KKg/a3y9bwVhxfmfX0f/mg81QOo9oRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720643444; c=relaxed/simple;
	bh=XhoJ7YU7632p9mi75mEFLVD2h03O1F1IBn9qV6xOvtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WHrfh0LVy7qn2tfBmj7njy/l+eZkbNvgAH7sg2OFjaCaQQPZZwZGN4mONTEPDnDcH2a6fMYaxU/ASC5ePFPNSOG0vV0XIhijjiEXnvNctB1CPUGOPl2V9axPR9QwwL3Ogf4trhTBj6fVY6nTzGyjufTWEW9k5n/cc1yIIZlspPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q4EEDafw; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720643442; x=1752179442;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=XhoJ7YU7632p9mi75mEFLVD2h03O1F1IBn9qV6xOvtc=;
  b=Q4EEDafw5ISAkvRrbLm/EGvqDe2VUFpM3yzzdxJJhX+JIkSxBXmikjk3
   cJ3OzsHnwIoBjaeDkmNrI1zcf34JRnYyZJqa9uZ/Qa7vLmMB0s8M6VXNa
   KB99zXmr8/iiOREbYYSGmQPsnkhyWx7ioMtWMp5/SI3ZnnfDYufpEs8YP
   XdG24ngFHsKh2LR9gogU37wC4IHXZtT6JQo+X4GNL6UdT4Vh3s2l0Cab2
   nJuNFtvQuclUdTrbjBjOQ6yjRMGpS2rcIWqwjipIMt444evj2ywcrHCwE
   m6RziLcTcKsamJcPbgxWQqg0yClZOAZ1P7/HPQu0mvC5XyPEkvsGoWfbm
   g==;
X-CSE-ConnectionGUID: nNaPT6w6TjKEDw6FJzjN/A==
X-CSE-MsgGUID: UdszTNO4SGS+X9qob3i6GA==
X-IronPort-AV: E=McAfee;i="6700,10204,11129"; a="12483736"
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="12483736"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2024 13:30:41 -0700
X-CSE-ConnectionGUID: CnTd4yOLS/+wmBBb1YO8eg==
X-CSE-MsgGUID: z2VoZNqHQp2nlbJpvKx2HQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,198,1716274800"; 
   d="scan'208";a="48223850"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 10 Jul 2024 13:30:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	lihong.yang@intel.com,
	willemb@google.com,
	almasrymina@google.com
Subject: [PATCH net-next 00/14][pull request] idpf: XDP chapter I: convert Rx to libeth
Date: Wed, 10 Jul 2024 13:30:16 -0700
Message-ID: <20240710203031.188081-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

XDP for idpf is currently 5 chapters:
* convert Rx to libeth (this);
* convert Tx and stats to libeth;
* generic XDP and XSk code changes, libeth_xdp;
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part I does the following:
* splits &idpf_queue into 4 (RQ, SQ, FQ, CQ) and puts them on a diet;
* ensures optimal cacheline placement, strictly asserts CL sizes;
* moves currently unused/dead singleq mode out of line;
* reuses libeth's Rx ptype definitions and helpers;
* uses libeth's Rx buffer management for both header and payload;
* eliminates memcpy()s and coherent DMA uses on hotpath, uses
  napi_build_skb() instead of in-place short skb allocation.

Most idpf patches, except for the queue split, removes more lines
than adds.
Expect far better memory utilization and +5-8% on Rx depending on
the case (+17% on skb XDP_DROP :>).
---
IWL history:
From v1[0]:
*  *: pick Reviewed-bys from Jake;
* 01: new, add generic __cacheline_group_{begin,end}_aligned() and
      a couple more cache macros;
* 02: new, make use of new macros from 01;
* 03: use macros from 01 (no more struct_group()), leave only
      aggressive assertions here;
* 07: adjust to the changes made in 01 and 03;
      fix typos in the kdocs;
* 13: fix typos in the commit message (Jakub);
* 14: fix possible unhandled null skb (Simon, static checker).

From RFC[1]:
*  *: add kdocs where needed and fix the existing ones to build cleanly;
      fix minor checkpatch and codespell warnings;
      add RBs from Przemek;
* 01: fix kdoc script to understand new libeth_cacheline_group() macro;
      add an additional assert for queue struct alignment;
* 02: pick RB from Mina;
* 06: make idpf_chk_linearize() static as it's now used only in one file;
* 07: rephrase the commitmsg: HW supports it, but never wants;
* 08: fix crashes on some configurations (Mina);
* 11: constify header buffer pointer in idpf_rx_hsplit_wa().

Testing hints: basic Rx regression tests (+ perf and memory usage
before/after if needed).

[0] https://lore.kernel.org/netdev/20240528134846.148890-1-aleksander.lobakin@intel.com
[1] https://lore.kernel.org/netdev/20240510152620.2227312-1-aleksander.lobakin@intel.com

The following are changes since commit ce2f84ebcd857556f5ae9fc2d4ac720df1eb49d1:
  Merge branch 'aquantia-phy-aqr115c' into main
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (14):
  cache: add __cacheline_group_{begin, end}_aligned() (+ couple more)
  page_pool: use __cacheline_group_{begin, end}_aligned()
  libeth: add cacheline / struct layout assertion helpers
  idpf: stop using macros for accessing queue descriptors
  idpf: split &idpf_queue into 4 strictly-typed queue structures
  idpf: avoid bloating &idpf_q_vector with big %NR_CPUS
  idpf: strictly assert cachelines of queue and queue vector structures
  idpf: merge singleq and splitq &net_device_ops
  idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
  idpf: reuse libeth's definitions of parsed ptype structures
  idpf: remove legacy Page Pool Ethtool stats
  libeth: support different types of buffers for Rx
  idpf: convert header split mode to libeth + napi_build_skb()
  idpf: use libeth Rx buffer management for payload buffer

 drivers/net/ethernet/intel/Kconfig            |   13 +-
 drivers/net/ethernet/intel/idpf/Kconfig       |   26 +
 drivers/net/ethernet/intel/idpf/Makefile      |    3 +-
 drivers/net/ethernet/intel/idpf/idpf.h        |   11 +-
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  152 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    2 +
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   88 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  306 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 1412 +++++++++--------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  734 +++++----
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  178 ++-
 drivers/net/ethernet/intel/libeth/rx.c        |  132 +-
 include/linux/cache.h                         |   59 +
 include/net/libeth/cache.h                    |   66 +
 include/net/libeth/rx.h                       |   19 +
 include/net/page_pool/types.h                 |   22 +-
 net/core/page_pool.c                          |    3 +-
 18 files changed, 1824 insertions(+), 1403 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig
 create mode 100644 include/net/libeth/cache.h

-- 
2.41.0


