Return-Path: <netdev+bounces-120596-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 275A8959ED8
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5A99C1C22797
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 13:39:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF78A1A7AE0;
	Wed, 21 Aug 2024 13:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="MBPWDRgP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 086FB1A7AD1
	for <netdev@vger.kernel.org>; Wed, 21 Aug 2024 13:37:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724247455; cv=none; b=X3x1GqqpLMZT2TcVwVWxyicX5bYUaWROmQbuE2eWsbbuYe+NcnlGrIuzppUOceIwDVN9N9YTwI58bIuEERxhMLOwUvN48Fu0JWTxuI5B2fwDSTD0JdrYcdIk7WOEnsRoIp2xztDRSwrEUC3Ic7ADcoigfCjtd9Kz2gadig8HXZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724247455; c=relaxed/simple;
	bh=C4YGL94zd28OY9b3SHsBgN1gjLYmukUt1HPDlsN5xx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lxha6yHVa+BLVEtJJbuEj3SD31tf+fe5ERHu0176F7aPlKiCFYC8HsdPZKUXtdrjD6m0rohPg9zLguPe2vBigwkZ+KabCdqtHSNX/NNqYKVx3CwQT5xRGCXN+ZqYkiXL5Xud9vEkl1IK5HGBO+nxSZIu+xHc3SvwtEvTgegtsbc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=MBPWDRgP; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724247455; x=1755783455;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=C4YGL94zd28OY9b3SHsBgN1gjLYmukUt1HPDlsN5xx0=;
  b=MBPWDRgPduCK4OfTC9aym8hRRGehlUuUfqrmb3nMEG+dDVEukSjlu3E5
   NRoxWDJoGgEP81Tywj4M8rE57d/dpq4oInebHWnaBFUtYprgL+b6600ac
   B/aRpXdH2cbr6nX5Z31nKh9H4f2KJ7/4xcHdkoF3P0lW56i2TiGZTVXIp
   W1tdm9Vwvyptr/t1VBI+7z97yWa8Qfd7fvS0K4qJ9vE6VDpXDjAdSJSvH
   p9G/fJb+HOF4yP9UlDDNOMCtLDXIM8g+gTayk1kruqfJg3cBEmAfwhbUG
   r5L0+OEekemI8x1aEV8Chaj+zrRwZNxjoCnWlDsg4EDGzZkU2JQyJfXfn
   Q==;
X-CSE-ConnectionGUID: YZyd3yhbTGqR0DEc61mF6w==
X-CSE-MsgGUID: OIpfOSj7QK+1444wmFMcKQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="45131405"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="45131405"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 06:37:34 -0700
X-CSE-ConnectionGUID: ptWVRNfGQeWM7abrUttSgA==
X-CSE-MsgGUID: 3A+IInRBR1mPbfXWksXaBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="61071242"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by fmviesa008.fm.intel.com with ESMTP; 21 Aug 2024 06:37:30 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id EE17F2878C;
	Wed, 21 Aug 2024 14:37:27 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Jiri Pirko <jiri@resnulli.us>,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Jakub Kicinski <kuba@kernel.org>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next v3 0/6] ice: add support for devlink health events
Date: Wed, 21 Aug 2024 15:37:08 +0200
Message-Id: <20240821133714.61417-1-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reports for two kinds of events are implemented, Malicious Driver
Detection (MDD) and Tx hang.

Patches 1, 2, 3: core improvements (checkpatch.pl, devlink extension)
Patches 3, 4, 5: ice devlink health infra + reporters

Mateusz did good job caring for this series, and hardening the code,
but he's on long vacation now :)

---
v3: - extracted devlink_fmsg_dump_skb(), and thus removed ugly copy-pasta
      present in v2 (Jakub);
    - tx hang reported is now called from service_task, to resolve calling
      it from atomic (watchog) context - patch 4

v2: patch 3 (patch 4 in v3)
    - added additional cast to long in ice_tx_hang_reporter_dump()
    - removed size_mul() in devlink_fmsg_binary_pair_put() call
https://lore.kernel.org/netdev/20240712093251.18683-1-mateusz.polchlopek@intel.com

v1:
https://lore.kernel.org/netdev/20240703125922.5625-1-mateusz.polchlopek@intel.com
---

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Mateusz Polchlopek (1):
  devlink: add devlink_fmsg_dump_skb() function

Przemek Kitszel (4):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: add Tx hang devlink health reporter
  ice: dump ethtool stats and skb by Tx hang devlink health reporter

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 scripts/checkpatch.pl                         |   2 +
 .../intel/ice/devlink/devlink_health.h        |  59 ++++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   |  19 ++
 include/net/devlink.h                         |  13 +
 .../intel/ice/devlink/devlink_health.c        | 302 ++++++++++++++++++
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_main.c     |  24 +-
 net/devlink/health.c                          |  67 ++++
 11 files changed, 491 insertions(+), 10 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.c


base-commit: 5c820c0d09067ec782a6a84b5362e899662eafea
-- 
2.39.3


