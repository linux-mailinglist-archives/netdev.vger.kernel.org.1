Return-Path: <netdev+bounces-106161-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 204D391505F
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 16:44:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C55A21F217D3
	for <lists+netdev@lfdr.de>; Mon, 24 Jun 2024 14:44:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A325D19AD9D;
	Mon, 24 Jun 2024 14:43:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="HcVdYVLo"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242F312FF84
	for <netdev@vger.kernel.org>; Mon, 24 Jun 2024 14:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719240235; cv=none; b=l5U7JPtiJDbijOE7Z7m41zCLfk3Pe0/TozrHL5jpaIZ1c35OcVLTZd18yF8i5/dcLMT2/vzdw6mFy8IJcfiDPOM2019nKEiyJWl9k9IXIXtC8NMPO7zn8v9DgrL1aj5FauX5l5uSB0oMjkdRZBVxzbnNn0URN40xubzhzESIQk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719240235; c=relaxed/simple;
	bh=gckpsvZo1hpmuZZTaF5mdtc3rJrEAJ/Uaxexu9VVlQU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UrOFi6oMbqitNcy8elgDr+K3miQZbKrtzPrUe5kyjHOXTPqozmb4Jch9x0zrD7KNaJVIShK5I2/Ye0hXHMpt3KXiKIEfg1RN9PDQcKbSJSQq5epSFEYKcf1kTPgnurVXcdHapaGMY0exZ/USlozDPfB2CHNuOitl6k6ecFdojWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=HcVdYVLo; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719240234; x=1750776234;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=gckpsvZo1hpmuZZTaF5mdtc3rJrEAJ/Uaxexu9VVlQU=;
  b=HcVdYVLokcqDnN5eayMotBU7f7sEHDRSUseAAxnUDrKZ+Ko9KJRRcvVN
   OmvfjZ5RzALsJO43bMjd5oMpCxgTgwgdh9r8lvAGiLmEH9K5g9n2mh59e
   FHU7t+lFqXMeVWAYk9sQ4DE3YUE5VWCDc9rMWb8HWSKV8Wvp3u+P21NK8
   NLD94LpuzCvCkLG7hhTUGXHgsplq0pt4fQDKzRzKbQ7OwBLmyiEn8Lmr9
   qIn1O6+hV/M4CSxrY9bdoKtJ7pdLSVL8cxXYGEqBtisXTxXK1fnqS1YY0
   9fCCPnuW97RrrMasNB23lSU5eURIKN8NeHkHrkTcCRMgvfGVH7Apjrtjr
   Q==;
X-CSE-ConnectionGUID: eNEa1p7xSi2KMF6WxkSOLg==
X-CSE-MsgGUID: dx4QnRp1RUKJqVG6pT9LPQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11113"; a="16040461"
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="16040461"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jun 2024 07:43:53 -0700
X-CSE-ConnectionGUID: VTlOlLroTR6v1fCDzLg7Uw==
X-CSE-MsgGUID: PDAMYMA2SNWP4X8C4XcaSQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,262,1712646000"; 
   d="scan'208";a="44022036"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa008.jf.intel.com with ESMTP; 24 Jun 2024 07:43:52 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 9DDDB27BB0;
	Mon, 24 Jun 2024 15:43:39 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	michal.swiatkowski@linux.intel.com,
	przemyslaw.kitszel@intel.com,
	aleksander.lobakin@intel.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>
Subject: [PATCH iwl-next v2 0/7] Switch API optimizations
Date: Mon, 24 Jun 2024 16:45:23 +0200
Message-ID: <20240624144530.690545-1-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Optimize the process of creating a recipe in the switch block by removing
duplicate switch ID words and changing how result indexes are fitted into
recipes. In many cases this can decrease the number of recipes required to
add a certain set of rules, potentially allowing a more varied set of rules
to be created. Total rule count will also increase, since less words will
be left unused/wasted. There are only 64 rules available in total, so every
one counts.

After this modification, many fields and some structs became unused or were
simplified, resulting in overall simpler implementation.

Marcin Szycik (4):
  ice: Remove unused struct ice_prot_lkup_ext members
  ice: Optimize switch recipe creation
  ice: Remove unused members from switch API
  ice: Add tracepoint for adding and removing switch rules

Michal Swiatkowski (3):
  ice: Remove reading all recipes before adding a new one
  ice: Simplify bitmap setting in adding recipe
  ice: remove unused recipe bookkeeping data

 drivers/net/ethernet/intel/ice/ice_common.c   |  11 +-
 .../ethernet/intel/ice/ice_protocol_type.h    |  43 +-
 drivers/net/ethernet/intel/ice/ice_switch.c   | 674 ++++++------------
 drivers/net/ethernet/intel/ice/ice_switch.h   |  20 +-
 drivers/net/ethernet/intel/ice/ice_trace.h    |  18 +
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 +
 6 files changed, 272 insertions(+), 496 deletions(-)

---
v2:
* Nicify checking sizeof struct field
* Add a tracepoint for tracking recipe/rule utilization (patch 7)
v1: [1]

[1] https://lore.kernel.org/intel-wired-lan/20240618141157.1881093-1-marcin.szycik@linux.intel.com/T/#t
-- 
2.45.0


