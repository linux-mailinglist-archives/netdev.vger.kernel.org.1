Return-Path: <netdev+bounces-133735-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E16E996D23
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 16:03:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 239061C220F1
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 14:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B839B1A00F2;
	Wed,  9 Oct 2024 14:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Kdqz2JFA"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23D28199EA1
	for <netdev@vger.kernel.org>; Wed,  9 Oct 2024 14:02:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.15
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728482551; cv=none; b=gY4xd9YRRFpGKxjuG2Jyn+fohISOcLiAEEEaOUIeLAKDIFOC0I3Aub8NYyf/guOUT5Wa6ySi1PCpdsL4J9dTqTeSJcj8xM9R3fLq1/lUO8/NlVEBaY+bQCDKUIBRRpCNs3qpWOPpRuYKANDB6sZEORCrOPp6j9qLxKKDD2oIco0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728482551; c=relaxed/simple;
	bh=aFp+U0p8vHdTdyh3f5RRGyUMZSbdRdCviTrmYy4UqZo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=S8cQTWFiU2gZYU7qBnY/HywkwXFLJri92p4s6Oc5zlXJAuK4th0QxumKkyq8kLlg2jTUY4dZJ2RQGCCX5AStkRpTgG1wyfTh28gW3YJQqtPStS+dvni3/h5rbj/cGnfBd/54t/RWiXY2gLmMY+dCiIvolfzxQWlu5lGSKiWyCy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Kdqz2JFA; arc=none smtp.client-ip=198.175.65.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728482550; x=1760018550;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=aFp+U0p8vHdTdyh3f5RRGyUMZSbdRdCviTrmYy4UqZo=;
  b=Kdqz2JFAV6L80RbpIfcra2ay5DPEjKBzq61oLAvfmv+K0gGV5IdM3yot
   xQBGkQqRqPpjGUa6TvA4npQfFiam5P8IGNBBa0pTCo0jN082TVocj6n9K
   zSOLLcpV+h+HgTIfaf8K749ddfObMY7U4e0o2s8GWEepw1LLCTE8oRGoG
   A+KLJNXaBIKILDlOGB6cNVgQGBp9zHgn5fkyVAhslCPLURlfJwGgGC9VB
   ZdvUG1P3PIVj44wwjw6VK8Ww8fEu965gh6aWNrdlaKVFrrJfy89IK3q1q
   dpM/UmMElq0mnNb+J/Yn/4k/WsIi5H2FrOslwnHvvTtsNm4dKlU71wctV
   g==;
X-CSE-ConnectionGUID: Z6yPkNeMSbu9uKqR435WOQ==
X-CSE-MsgGUID: XSwddpIIR2KD4pvuSJzqkw==
X-IronPort-AV: E=McAfee;i="6700,10204,11220"; a="31483926"
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="31483926"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2024 07:02:29 -0700
X-CSE-ConnectionGUID: jVTH4o7HRrOoknzvWGf9MA==
X-CSE-MsgGUID: iTDfwJNATV699zloEh/pBw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,189,1725346800"; 
   d="scan'208";a="76210718"
Received: from kkolacin-desk1.ger.corp.intel.com (HELO kkolacin-desk1.igk.intel.com) ([10.217.160.108])
  by orviesa009.jf.intel.com with ESMTP; 09 Oct 2024 07:02:28 -0700
From: Karol Kolacinski <karol.kolacinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	Karol Kolacinski <karol.kolacinski@intel.com>
Subject: [PATCH v2 iwl-next 0/4] Fix E825 initialization
Date: Wed,  9 Oct 2024 15:59:25 +0200
Message-ID: <20241009140223.1918687-1-karol.kolacinski@intel.com>
X-Mailer: git-send-email 2.46.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

E825 products have incorrect initialization procedure, which may lead to
initialization failures and register values.

Fix E825 products initialization by adding correct sync delay, checking the
PHY
revision only for current PHY and adding proper destination device when
reading
port/quad.

In addition, E825 uses PF ID for indexing per PF registers and as a primary
PHY
lane number, which is incorrect.


Karol Kolacinski (4):
  ice: Fix E825 initialization
  ice: Fix quad registers read on E825
  ice: Fix ETH56G FC-FEC Rx offset value
  ice: Add correct PHY lane assignment

 drivers/net/ethernet/intel/ice/ice_common.c   |  42 ++-
 drivers/net/ethernet/intel/ice/ice_common.h   |   1 +
 drivers/net/ethernet/intel/ice/ice_main.c     |   6 +-
 drivers/net/ethernet/intel/ice/ice_ptp.c      |  23 +-
 drivers/net/ethernet/intel/ice/ice_ptp.h      |   4 +-
 .../net/ethernet/intel/ice/ice_ptp_consts.h   |  77 +----
 drivers/net/ethernet/intel/ice/ice_ptp_hw.c   | 285 +++++++++---------
 drivers/net/ethernet/intel/ice/ice_ptp_hw.h   |  40 ++-
 drivers/net/ethernet/intel/ice/ice_sbq_cmd.h  |   7 +-
 drivers/net/ethernet/intel/ice/ice_type.h     |   2 -
 10 files changed, 243 insertions(+), 244 deletions(-)

V1 -> V2: Removed net-next hunks from "ice: Fix E825 initialization",
          whole "ice: Remove unnecessary offset calculation for PF
          scoped registers" patch and fixed kdoc in "ice: Fix quad
          registers read on E825"

base-commit: af8cac359cecaab37a171039fc82cfd1f7aca501
-- 
2.46.2


