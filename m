Return-Path: <netdev+bounces-116081-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E2A76949075
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 15:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 52F4DB21BF0
	for <lists+netdev@lfdr.de>; Tue,  6 Aug 2024 13:13:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8141D1F48;
	Tue,  6 Aug 2024 13:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JQx0Sbzp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C509F1D1752;
	Tue,  6 Aug 2024 13:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722949989; cv=none; b=gupnet6czl3Q5NN3OPQRXEyBQrHpL4GoH0+4ACMQR/aiObsQM49BONt0nJ1GOc+PK6Thg7xXKH+Eb6cdzs7HxE6pHGra6QC4xeCvdSgcn9PrvrZzyrkGIV07xPrWGL5wCbYvN34z6sdgiZiTbjLf6bJ1v/20YeEPNgIzm81IhnQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722949989; c=relaxed/simple;
	bh=DKGJLrTyOqt1XPnoqbqhrpWB91AlQVU5IgRU+XQcuyQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mCYsseVRMvm6IJpe0Pey0hl2yYXcmW+7namGDa03Nuo90lZQ8WtUCh65k4FQK3f7MMmb3iNsh5ruPgq4hqNBibIEyi4DHVfZypOy2wJ/zv4eylljhWMtbpkEvTU1V/J5mxl9DJR25ZI+ZGFj+EyIJPMiuQkYDZx5uKafx9TCJsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JQx0Sbzp; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1722949987; x=1754485987;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DKGJLrTyOqt1XPnoqbqhrpWB91AlQVU5IgRU+XQcuyQ=;
  b=JQx0Sbzp1LhpczdHgszdH5V+gj2PNMfM/CTfM5qd8N994+7lk2rjoPO2
   wT0gUxslH6TmqjKR3CWLMKc6EjuMRTI/pgbnGiejgmwfWBHLEHVBT++4f
   1cEABHYYKBhoduM6l4rgj/Tha74Ia0DcYgJOxyY0tfcleZby0TbY65wla
   v6wyr1HGncKdTPs9rRLY5Nkd9XqQooFu9Mb5llMcXbcnWv+LC/gs7tKl2
   xki/O9jAVWZ105xUoTpO0OV2P3+Kw3938E5VkjqyJjXxdy74Fr9C5yJKF
   oTTcqlQiVh3d5PcroDdwTQcMp6qj9onPW3l9obgiuaIYZk3bdIZhwffgt
   Q==;
X-CSE-ConnectionGUID: ApkRmJywRxyK5F78cdIrTA==
X-CSE-MsgGUID: p88sJf8GRMiYcFeggLkd9Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11156"; a="20842068"
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="20842068"
Received: from fmviesa009.fm.intel.com ([10.60.135.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2024 06:13:07 -0700
X-CSE-ConnectionGUID: /XC1YCq0SWGEmSlaI7KRDA==
X-CSE-MsgGUID: a8y5dv21SYG/Lnl1X4NGKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,267,1716274800"; 
   d="scan'208";a="56475793"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa009.fm.intel.com with ESMTP; 06 Aug 2024 06:13:04 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Joshua Hay <joshua.a.hay@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH iwl-next 0/9] idpf: XDP chapter II: convert Tx completion to libeth
Date: Tue,  6 Aug 2024 15:12:31 +0200
Message-ID: <20240806131240.800259-1-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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

 drivers/net/ethernet/intel/libeth/Makefile    |   4 +-
 include/net/libeth/types.h                    | 247 ++++++++
 drivers/net/ethernet/intel/idpf/idpf.h        |  21 +-
 drivers/net/ethernet/intel/idpf/idpf_txrx.h   | 144 ++---
 drivers/net/ethernet/intel/idpf/virtchnl2.h   |  33 +-
 drivers/net/ethernet/intel/libeth/priv.h      |  21 +
 include/linux/netdevice.h                     |  13 +-
 include/linux/unroll.h                        |  50 ++
 include/net/libeth/netdev.h                   |  31 +
 include/net/libeth/stats.h                    | 141 +++++
 include/net/libeth/tx.h                       | 127 +++++
 drivers/net/ethernet/intel/idpf/idpf_dev.c    |   2 +
 .../net/ethernet/intel/idpf/idpf_ethtool.c    | 498 ++--------------
 drivers/net/ethernet/intel/idpf/idpf_lib.c    |  32 +-
 .../ethernet/intel/idpf/idpf_singleq_txrx.c   | 172 +++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   | 538 +++++++++---------
 drivers/net/ethernet/intel/idpf/idpf_vf_dev.c |   2 +
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   |  37 +-
 drivers/net/ethernet/intel/libeth/netdev.c    | 157 +++++
 drivers/net/ethernet/intel/libeth/rx.c        |   5 -
 drivers/net/ethernet/intel/libeth/stats.c     | 360 ++++++++++++
 21 files changed, 1633 insertions(+), 1002 deletions(-)
 create mode 100644 include/net/libeth/types.h
 create mode 100644 drivers/net/ethernet/intel/libeth/priv.h
 create mode 100644 include/linux/unroll.h
 create mode 100644 include/net/libeth/netdev.h
 create mode 100644 include/net/libeth/stats.h
 create mode 100644 include/net/libeth/tx.h
 create mode 100644 drivers/net/ethernet/intel/libeth/netdev.c
 create mode 100644 drivers/net/ethernet/intel/libeth/stats.c

-- 
2.45.2


