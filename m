Return-Path: <netdev+bounces-111040-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81F3692F82C
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 11:44:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71DE1C21BA6
	for <lists+netdev@lfdr.de>; Fri, 12 Jul 2024 09:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A78BA14A4EF;
	Fri, 12 Jul 2024 09:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LyBIbhzZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68AF3143C51;
	Fri, 12 Jul 2024 09:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720777493; cv=none; b=POiWDyDt5K/S5HLIq85/VrvAU/cY4IvSTvX4kxf+G0cEGtTgGPDMP54mOnJwxd+fNJfbvCK9FU+6hVgswcBkpwIx61cvf3fCj5zFytrZdewqIxWEtFxBgT7yulJaDfLwS9q/7yuNWPu3s23ISX7RwWgX9YeDJN2WK3FoJDi3sUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720777493; c=relaxed/simple;
	bh=pye52lxJTMqD0ED0N9d93NrRojesTispGsNfpnuU8S4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=aGc0E2q12NIwlIhrQHGRf9YK81RkHzJVg/COIckGhuxC+mgDcITF8NJe/2FWx+qA9Izd50iJSUuaYIj+BkaSyRg87CPQcd8p32C9IP7Juie7ghtLvaZsNsba3nAiqFheXE/anrN8j+9WdAARQN5PNNrZSwBeJntir5LgexIeGG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LyBIbhzZ; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720777491; x=1752313491;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=pye52lxJTMqD0ED0N9d93NrRojesTispGsNfpnuU8S4=;
  b=LyBIbhzZhxUFWjTOsedoiY0dgWo0EOi+NcAPucNMhVdTp/MDwyT8peSA
   mUpZHpHkz8+wHvZiTaHtpMjgHgGKu4Z8U+Fkzj1LlgKDAsrwkos/4wcVl
   K+2JW8IhZBKQHcctUB7eRghchWzqr7gUMx22iXqurVCvIeK9BUvtii2vf
   b/jllQIb6aBj7BtKZDidvLRqISblQmVxBucA2IJRXRY6974rmmIp498Yg
   EaULivB/sg3+YSocw6YneIJSXJT5jYpHodccPu8V+T3KKJ9KLLTw16OzB
   wikR+T9FM2MrWS5M0mu+8DGbTanJlm/l4h+zzChf8kj4qb8B33UVGb9hZ
   g==;
X-CSE-ConnectionGUID: pMjvJMMrQFebfrtl5fsSFQ==
X-CSE-MsgGUID: zXTLhCynQxiXVlideBB7VA==
X-IronPort-AV: E=McAfee;i="6700,10204,11130"; a="18076945"
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="18076945"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2024 02:44:51 -0700
X-CSE-ConnectionGUID: G4rJcSO1Qeu3ga65EOemYQ==
X-CSE-MsgGUID: tiuiRH0xSFm8EmaZmNG+vg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,202,1716274800"; 
   d="scan'208";a="49524299"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa007.jf.intel.com with ESMTP; 12 Jul 2024 02:44:48 -0700
Received: from fedora.igk.intel.com (Metan_eth.igk.intel.com [10.123.220.124])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 7D46D12409;
	Fri, 12 Jul 2024 10:44:46 +0100 (IST)
From: Mateusz Polchlopek <mateusz.polchlopek@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: apw@canonical.com,
	joe@perches.com,
	dwaipayanray1@gmail.com,
	lukas.bulwahn@gmail.com,
	akpm@linux-foundation.org,
	willemb@google.com,
	edumazet@google.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	Mateusz Polchlopek <mateusz.polchlopek@intel.com>
Subject: [Intel-wired-lan] [PATCH iwl-next v2 0/6] Add support for devlink health events
Date: Fri, 12 Jul 2024 05:32:45 -0400
Message-Id: <20240712093251.18683-1-mateusz.polchlopek@intel.com>
X-Mailer: git-send-email 2.38.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reports for two kinds of events are implemented, Malicious Driver
Detection (MDD) and Tx hang.

Patches 1, 2: minor core improvements (checkpatch.pl and devlink extension)
Patches 3, 4, 5: ice devlink health infra + straightforward status reports
Patch 6: extension to dump also skb on Tx hang, this patch have much of
 copy-paste from:
 - net/core/skbuff.c (function skb_dump() - modified to dump into buffer)
 - lib/hexdump.c (function print_hex_dump() - adjusted)

---
v2:
- added additional cast to long in function ice_tx_hang_reporter_dump() - patch 3
- removed size_mul() in devlink_fmsg_binary_pair_put() call - patch 3

v1:
- initial series
https://lore.kernel.org/netdev/20240703125922.5625-1-mateusz.polchlopek@intel.com/
---

Ben Shelton (1):
  ice: Add MDD logging via devlink health

Przemek Kitszel (5):
  checkpatch: don't complain on _Generic() use
  devlink: add devlink_fmsg_put() macro
  ice: add Tx hang devlink health reporter
  ice: print ethtool stats as part of Tx hang devlink health reporter
  ice: devlink health: dump also skb on Tx hang

 drivers/net/ethernet/intel/ice/Makefile       |   1 +
 .../intel/ice/devlink/devlink_health.c        | 484 ++++++++++++++++++
 .../intel/ice/devlink/devlink_health.h        |  45 ++
 drivers/net/ethernet/intel/ice/ice.h          |   2 +
 drivers/net/ethernet/intel/ice/ice_ethtool.c  |  10 +-
 drivers/net/ethernet/intel/ice/ice_ethtool.h  |   2 +
 .../ethernet/intel/ice/ice_ethtool_common.h   |  19 +
 drivers/net/ethernet/intel/ice/ice_main.c     |  17 +-
 include/net/devlink.h                         |  11 +
 scripts/checkpatch.pl                         |   2 +
 10 files changed, 585 insertions(+), 8 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.c
 create mode 100644 drivers/net/ethernet/intel/ice/devlink/devlink_health.h
 create mode 100644 drivers/net/ethernet/intel/ice/ice_ethtool_common.h

-- 
2.38.1


