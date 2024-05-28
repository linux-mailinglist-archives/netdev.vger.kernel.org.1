Return-Path: <netdev+bounces-98587-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 388838D1D63
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 15:49:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5D0941C22427
	for <lists+netdev@lfdr.de>; Tue, 28 May 2024 13:49:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE5C013C822;
	Tue, 28 May 2024 13:49:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="AJapwwED"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA00A1DFEB;
	Tue, 28 May 2024 13:49:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904160; cv=none; b=KLAqT19aLfkTSL4Z18WIdg9HPIGOPWuvyGZmuqkeY61uccCmvPgFGPB/7ekuXnM0nysXR4GGXe0vFJLlC/yjkjRMQzbkqN7hXRjSNK+Q98etyZHmnu3i7loHmQrMBvJheDYGPsJw57jo8+WXRBqGHMKeYjqp+i00ntAgMrKd+Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904160; c=relaxed/simple;
	bh=N1n/J3TdFsoMMp9tMgptlou6ON9SzyuaBDHKPoaxhO0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HV5fsrk9oGkdRVbZe3Uv5emjuic6lW93Z9gAH+WfnqfG+yllAmDwj8KXtNeVKQEcc7CNT2DrMKLOL1XyFk4bnzXfUpz/wmZqBgjbNGpQvrMUXmPQC6u2hpyjZdMp/SVxYSRRBqplthEjMZ5pmlQ76dLnmunPu0aGu583ar4z+w0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=AJapwwED; arc=none smtp.client-ip=192.198.163.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716904159; x=1748440159;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=N1n/J3TdFsoMMp9tMgptlou6ON9SzyuaBDHKPoaxhO0=;
  b=AJapwwEDARSA0jgRc1mGnbyyzNkJx6n7Qg36Z0wX/UOcfAELbev1LesG
   9t9s3nHgsVlHGHKS0HTzRvRCq+AfZQSh/RSH7sdiFB8fSbORJ/aKMiZBB
   68qa8ucSBLmg8mX9auGsCLAkSmW6dRacybuocIoE62rbl5745b7NrkING
   e844gSBn5RXba3bwQRg2q+T15C5AeVFPkEVsboy12rRnUosB8oog1FE7p
   4fzfZlFO1ZV4zvqYZQC5GREh0jxwTrxlEZXMp3BU7vbDz/mZyc6N9Sx10
   On49IPKFesMnt8HaWrKNPdUldl18cSlbYxtevyhXVR/eYmdOH4vmIyvAr
   Q==;
X-CSE-ConnectionGUID: wUQO/k3STrO/w3emnxrJNw==
X-CSE-MsgGUID: nptX5GCSQRq2XaS8tBZumw==
X-IronPort-AV: E=McAfee;i="6600,9927,11085"; a="13436973"
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="13436973"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa109.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 May 2024 06:49:18 -0700
X-CSE-ConnectionGUID: HsgTr1Q9QTGVYZLBynusyA==
X-CSE-MsgGUID: MZgd4IstT7inPchGoX479A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,195,1712646000"; 
   d="scan'208";a="35577389"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 28 May 2024 06:49:15 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Mina Almasry <almasrymina@google.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 00/12] idpf: XDP chapter I: convert Rx to libeth
Date: Tue, 28 May 2024 15:48:34 +0200
Message-ID: <20240528134846.148890-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

Alexander Lobakin (12):
  libeth: add cacheline / struct alignment helpers
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
 scripts/kernel-doc                            |    1 +
 drivers/net/ethernet/intel/idpf/idpf.h        |   11 +-
 .../net/ethernet/intel/idpf/idpf_lan_txrx.h   |    2 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   |  800 +++++-----
 include/net/libeth/cache.h                    |  100 ++
 include/net/libeth/rx.h                       |   19 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    |  152 +-
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |   88 +-
 drivers/net/ethernet/intel/idpf/idpf_main.c   |    1 +
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   |  311 ++--
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 1410 +++++++++--------
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  178 ++-
 drivers/net/ethernet/intel/libeth/rx.c        |  132 +-
 16 files changed, 1824 insertions(+), 1423 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig
 create mode 100644 include/net/libeth/cache.h

---
Applies on top of "idpf: don't enable NAPI and interrupts prior to
allocating Rx buffers" from the -net tree, otherwise may work unstable.

From RFC[0]:
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

Note that I'm on a vacation starting 30th May and return 10th of June.
I may sometimes reply, but no new versions in the meantime =\

[0] https://lore.kernel.org/netdev/20240510152620.2227312-1-aleksander.lobakin@intel.com
-- 
2.45.1


