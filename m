Return-Path: <netdev+bounces-97397-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B7FD8CB452
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 21:40:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 39F331C216C0
	for <lists+netdev@lfdr.de>; Tue, 21 May 2024 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0279C433AD;
	Tue, 21 May 2024 19:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="eORDribQ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01F576FDC
	for <netdev@vger.kernel.org>; Tue, 21 May 2024 19:39:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716320398; cv=none; b=IZ+ryoGtrucwPMkfbiX8E6U1goDKDVAnw7nU+4RGzvT/+vUQMDpxp3XiQ9xXWJgmBMo2gI6cp0EelU6k7bVlEISHcUs2f7Wc+LiiyhcgBR4aanTYi5L0TcPT5G+//mERK2L/PVpa7XyMKFb3TkChsk0xKdkUAkaviJ3d4xS4YLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716320398; c=relaxed/simple;
	bh=mIziefOiIuZuelaWf72tQC5B86XwZjV5PuNPtMLAerQ=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=N6JL2FoqTOvEqhK6u05Is9sraaUw3boOS2jfjJAUFiAMYfI4u6ScliBhR2n4QwVKDhuQlYZzzISLvpC82CP2fwH31tn85bAVyiZzy6XlAdefCaKfsUvs6Zv5kd27vGg9cAoBaTGJTMN3SoTK51KCxKMyOxhP5LyLzz3O91VKc1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=eORDribQ; arc=none smtp.client-ip=198.175.65.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716320397; x=1747856397;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=mIziefOiIuZuelaWf72tQC5B86XwZjV5PuNPtMLAerQ=;
  b=eORDribQda3vkv/6FYDvcxkHKocHwBwInVTTeSuyQwOp6bDgU5e3ydaA
   MvCqjdnv71QI1bqFlUnPzU+4cKXz5LBMVBAREOtbc/FOhcNT8N1pUINw5
   LsBZ9QALgrZTdNV5ncbbZRqaKUACxUwdnnS2B76kBS4Jq06mMTdGwxIwv
   43bABY1Xvc5Y8hdQAlsli7GjDNmI6D3xeUR/EeKu0jiBhwdUV+HwPdcMk
   34f9aXHTzvZJ0OXpaJuIlSOLcRj5lenDTsRnpOd/YOXN2vGOweHPVIDbl
   LES1DK0RKBfP3bvFcpalixvIHKuISNsWPRJRz5pbehJNAudrPt2dNgHpW
   A==;
X-CSE-ConnectionGUID: QDAER4/pREK6SpT1UOnirA==
X-CSE-MsgGUID: StO2AdRjSJaClsz5EPYkPw==
X-IronPort-AV: E=McAfee;i="6600,9927,11079"; a="35049754"
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="35049754"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:39:56 -0700
X-CSE-ConnectionGUID: yJgUBNHkRm6wl4iXUPsZ/w==
X-CSE-MsgGUID: kFYuC58VTumMGFxN3Xx1cg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,178,1712646000"; 
   d="scan'208";a="33462475"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by orviesa006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 May 2024 12:39:57 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net v2 0/2] intel: Interpret .set_channels() input
 differently
Date: Tue, 21 May 2024 12:39:52 -0700
Message-Id: <20240521-iwl-net-2024-05-14-set-channels-fixes-v2-0-7aa39e2e99f1@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIj4TGYC/52NQQ6CMBBFr2Jm7ZjSFmhceQ/DAsogk2AxLUEN4
 e4OrNzq8v0/8/4CiSJTgvNhgUgzJx6DgD4ewPd1uBFyKwxaaavyzCI/Bww04RagylGiJLgdBxo
 SdvyihDpvqOiUrV3RgrgekfZCVFeQd6gk7DlNY3zv23O2Vz/OzBkqdMaUTtW+NLa7cJhoOPnxv
 q3+Y6Mmc61zZJQ3X7ZqXdcPY64wBy0BAAA=
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
 netdev <netdev@vger.kernel.org>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Larysa Zaremba <larysa.zaremba@intel.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Chandan Kumar Rout <chandanx.rout@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Igor Bagnucki <igor.bagnucki@intel.com>, 
 Krishneil Singh <krishneil.k.singh@intel.com>, 
 Simon Horman <horms@kernel.org>
X-Mailer: b4 0.13.0

The ice and idpf drivers can trigger a crash with AF_XDP due to incorrect
interpretation of the asymmetric Tx and Rx parameters in their
.set_channels() implementations:

1. ethtool -l <IFNAME> -> combined: 40
2. Attach AF_XDP to queue 30
3. ethtool -L <IFNAME> rx 15 tx 15
   combined number is not specified, so command becomes {rx_count = 15,
   tx_count = 15, combined_count = 40}.
4. ethnl_set_channels checks, if there are any AF_XDP of queues from the
   new (combined_count + rx_count) to the old one, so from 55 to 40, check
   does not trigger.
5. the driver interprets `rx 15 tx 15` as 15 combined channels and deletes
   the queue that AF_XDP is attached to.

This is fundamentally a problem with interpreting a request for asymmetric
queues as symmetric combined queues.

Fix the ice and idpf drivers to stop interpreting such requests as a
request for combined queues. Due to current driver design for both ice and
idpf, it is not possible to support requests of the same count of Tx and Rx
queues with independent interrupts, (i.e. ethtool -L <IFNAME> rx 15 tx 15)
so such requests are now rejected.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Changes in v2:
- Remove the unnecessary combined_count check in the ice fix.
- Link to v1: https://lore.kernel.org/r/20240514-iwl-net-2024-05-14-set-channels-fixes-v1-0-eb18d88e30c3@intel.com

---
Larysa Zaremba (2):
      ice: Interpret .set_channels() input differently
      idpf: Interpret .set_channels() input differently

 drivers/net/ethernet/intel/ice/ice_ethtool.c   | 19 ++-----------------
 drivers/net/ethernet/intel/idpf/idpf_ethtool.c | 21 ++++++---------------
 2 files changed, 8 insertions(+), 32 deletions(-)
---
base-commit: e4a87abf588536d1cdfb128595e6e680af5cf3ed
change-id: 20240514-iwl-net-2024-05-14-set-channels-fixes-25be6f04a86d

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


