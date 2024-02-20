Return-Path: <netdev+bounces-73448-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D328285CA3B
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 22:46:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 196951C223E3
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 21:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B93C7151CF9;
	Tue, 20 Feb 2024 21:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FchdcB8y"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C24B151CDC
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 21:46:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708465591; cv=none; b=UcF+GXlgmHj0yQJ2cEMerKjCBBWCaYRNsODVaJybHwmFIekcfa1uf9YO3PwfMxLFySqqNCprs9ur7+t9dxWV1dqbVEhx3AVMnsRJ/zAhX812UjfC5wctBvQ9zEpiFkWQE3DlVZE54hLk0jqVesNEMQVoLQF1/5KwWfIXaGnZfU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708465591; c=relaxed/simple;
	bh=2XHz7+3JkvXaG06/fQQuuRquQdZa2NdRVMlfweA4+1M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=R5VLA2PUeuOhdOKcST1DB1gtYRe9azQpuufhVkNoYLWOzQNdwKOB0SYNXCtLAO9/dSBrdecYqZVDqnM9tc6A4UWnlnhccI+eCor3YnqHRzoHIRCGFZHrlGX85m/eGOafJfOGz8AsJ6qMMC9xzqfFHVq2ViJSmgrA2SKTB8O5MgE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FchdcB8y; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708465591; x=1740001591;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2XHz7+3JkvXaG06/fQQuuRquQdZa2NdRVMlfweA4+1M=;
  b=FchdcB8yFD03ha4ZUNxfewHfUQsKv0MfqHKjhB/x0gHV+XRP2uo+DvSO
   OnTOhp1Z/xifjy/beQuFQj9IQtkQmbefxrVNE0fkdg5FfTns/E5dl67MN
   vg8KRuW3/x/vcl8hNNW3kPrMt8JTGsYpEJE8SCyVNgsjn7nn0kwmrz0Se
   KbNZA3YX8z/++6R4FmPsDwzBC7A6YPnvVSpVdbAf+pQfDRcrJMsFK575P
   lrL7Wes19yNxl8Y7T54OJ2j7P+RYalKgTNyeuqC0H5ZPEllYuU3T1ubna
   0WaM/mKOyq8p/byOKAJF7ZcfTKWtWY/Ho9P04yYD14iWjp7dkq0araN6q
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10990"; a="2462661"
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="2462661"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 13:46:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,174,1705392000"; 
   d="scan'208";a="35681878"
Received: from boxer.igk.intel.com ([10.102.20.173])
  by orviesa002.jf.intel.com with ESMTP; 20 Feb 2024 13:46:28 -0800
From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	magnus.karlsson@intel.com,
	Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Subject: [PATCH iwl-net 0/3] intel: fix routines that disable queue pairs
Date: Tue, 20 Feb 2024 22:45:50 +0100
Message-Id: <20240220214553.714243-1-maciej.fijalkowski@intel.com>
X-Mailer: git-send-email 2.35.3
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi,

It started out as an issue on ixgbe reported by Pavel [0] which first
patch is supposed to fix, but apparently i40e and ice have queue pair
disabling flow a bit out of order, so I addressed them as well. More
info is included in commit messages.

FWIW we are talking here about AF_XDP ZC when xsk_pool is sent down to
driver. Typically these routines are executed when there is already XDP
program running on interface.

Thanks!

[0]: https://lore.kernel.org/netdev/CAJEV1ijxNyPTwASJER1bcZzS9nMoZJqfR86nu_3jFFVXzZQ4NA@mail.gmail.com/

Maciej Fijalkowski (3):
  ixgbe: {dis,en}able irqs in ixgbe_txrx_ring_{dis,en}able
  i40e: disable NAPI right after disabling irqs when handling xsk_pool
  ice: reorder disabling IRQ and NAPI in ice_qp_dis

 drivers/net/ethernet/intel/i40e/i40e_main.c   |  2 +-
 drivers/net/ethernet/intel/ice/ice_xsk.c      |  9 +--
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 56 ++++++++++++++++---
 3 files changed, 55 insertions(+), 12 deletions(-)

-- 
2.34.1


