Return-Path: <netdev+bounces-118563-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAC4E952142
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 19:33:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6364F280F22
	for <lists+netdev@lfdr.de>; Wed, 14 Aug 2024 17:33:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 034D81BC075;
	Wed, 14 Aug 2024 17:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JwvW5Raw"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AE781B3F32
	for <netdev@vger.kernel.org>; Wed, 14 Aug 2024 17:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723656806; cv=none; b=RJOVt89JUEeELThZH6YB88pbEnLqDYViSKukChH4Z/zau5qE1HXimP5eRmXi3CL5uUxdgBgHplW/SVmEWJAdgw4Cw4mH9crin3nlN4mfm1CCeOj2FTIAYxArVWMqqhYYM6QSjPGrBTwzZYoevTiu54WfIchtLvrBWk5lRwoUqcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723656806; c=relaxed/simple;
	bh=zdggDbqf0i2HzGkZWjpTnm9jpLvM1GcOdg7VH+w1Sok=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=N5GzJSC9XwsQyN1UO5ANcpzbjaRHHMc8p5Aid13nMy9F+0iwxhw+oVTn1fWL8LeH5PEXWvhO4RAj2luE5gzZjoIjCykffQ08VRb2ecJhnhm6xKOZq3oS1s6b7IEIur9lLRjO+m65Al+GxW4CHDhs1M0yZmMUT6K52P5d4omV1e4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JwvW5Raw; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1723656805; x=1755192805;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=zdggDbqf0i2HzGkZWjpTnm9jpLvM1GcOdg7VH+w1Sok=;
  b=JwvW5RawQWJi8YN9rwrEI8mVC0Vj9i+qHDXN7cVH3k2ZemMB+305QUC5
   jzWXFzQNCZJRaneLyDoN+T4tGBPStpRYMm5zQosN4EeF+/lgK4FDX5UUw
   uBwEoPDfNkK4x0IKYwaAAhPyWM711Bynk9i5jqBNhpB9hFmhvSsijgxO2
   frZhvqIvAlIOaV4c0NRIPpq/CRtS+Vs80Ig9ahNlMp/7HDVmJNYz3aVY/
   gWX8EW9p63ekSD3hc2jLzg5OBk0eATNhpUwGjGwVEvGFW/eyrL+kfwdQy
   7N0i/qchu5CSUFmhSRHL6bSMB3GqBOB2NIaijMtAfdsMh4N7RtjmTLXO9
   Q==;
X-CSE-ConnectionGUID: x6oqvEY6Ti+yghFel72y+Q==
X-CSE-MsgGUID: zxoEGi1vT26ZweRv3gdUWA==
X-IronPort-AV: E=McAfee;i="6700,10204,11164"; a="21860553"
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="21860553"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Aug 2024 10:33:23 -0700
X-CSE-ConnectionGUID: roy7vHKORZePPSqBoiZ3ew==
X-CSE-MsgGUID: zz5KjpNmRzeuuHdAHqhxqg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,146,1719903600"; 
   d="scan'208";a="59233853"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa010.fm.intel.com with ESMTP; 14 Aug 2024 10:33:23 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	joshua.a.hay@intel.com,
	michal.kubiak@intel.com,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com
Subject: [PATCH net-next 0/9][pull request] idpf: XDP chapter II: convert Tx completion to libeth
Date: Wed, 14 Aug 2024 10:32:57 -0700
Message-ID: <20240814173309.4166149-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Alexander Lobakin says:

XDP for idpf is currently 5 chapters:
* convert Rx to libeth;
* convert Tx completion and stats to libeth (this);
* generic XDP and XSk code changes;
* actual XDP for idpf via libeth_xdp;
* XSk for idpf (^).

Part II does the following:
* introduces generic libeth per-queue stats infra;
* adds generic libeth Tx completion routines;
* converts idpf to use generic libeth Tx comp routines;
* fixes Tx queue timeouts and robustifies Tx completion in general;
* fixes Tx event/descriptor flushes (writebacks);
* fully switches idpf per-queue stats to libeth.

Most idpf patches again remove more lines than adds.
The perf difference is not visible by eye in common scenarios, but
the stats are now more complete and reliable, and also survive
ifups-ifdowns.
---
iwl: https://lore.kernel.org/intel-wired-lan/20240806131240.800259-1-aleksander.lobakin@intel.com/

The following are changes since commit 2984e69a24affc8e5624069b7bb44593e09037e8:
  net: ethernet: dlink: replace deprecated macro
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/next-queue 200GbE

Alexander Lobakin (6):
  unroll: add generic loop unroll helpers
  libeth: add common queue stats
  libie: add Tx buffer completion helpers
  idpf: convert to libie Tx buffer completion
  netdevice: add netdev_tx_reset_subqueue() shorthand
  idpf: switch to libeth generic statistics

Joshua Hay (2):
  idpf: refactor Tx completion routines
  idpf: enable WB_ON_ITR

Michal Kubiak (1):
  idpf: fix netdev Tx queue stop/wake

 drivers/net/ethernet/intel/idpf/idpf.h        |  21 +-
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   2 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 498 ++--------------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  32 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 172 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 539 +++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 144 ++---
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  37 +-
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  33 +-
 drivers/net/ethernet/intel/libeth/Makefile    |   4 +-
 drivers/net/ethernet/intel/libeth/netdev.c    | 157 +++++
 drivers/net/ethernet/intel/libeth/priv.h      |  21 +
 drivers/net/ethernet/intel/libeth/rx.c        |   5 -
 drivers/net/ethernet/intel/libeth/stats.c     | 360 ++++++++++++
 include/linux/netdevice.h                     |  13 +-
 include/linux/unroll.h                        |  50 ++
 include/net/libeth/netdev.h                   |  31 +
 include/net/libeth/stats.h                    | 141 +++++
 include/net/libeth/tx.h                       | 127 +++++
 include/net/libeth/types.h                    | 247 ++++++++
 21 files changed, 1634 insertions(+), 1002 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/libeth/netdev.c
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 drivers/net/ethernet/intel/libeth/stats.c
 create mode 100644 include/linux/unroll.h
 create mode 100644 include/net/libeth/netdev.h
 create mode 100644 include/net/libeth/stats.h
 create mode 100644 include/net/libeth/tx.h
 create mode 100644 include/net/libeth/types.h

-- 
2.42.0


