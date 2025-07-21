Return-Path: <netdev+bounces-208661-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E079EB0C9C8
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 19:37:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F9731AA1424
	for <lists+netdev@lfdr.de>; Mon, 21 Jul 2025 17:38:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 84EA32DECD2;
	Mon, 21 Jul 2025 17:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Y34iCGVC"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0491D2E11AD
	for <netdev@vger.kernel.org>; Mon, 21 Jul 2025 17:37:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753119462; cv=none; b=Po1lBAZ3auixEO1uinSL+ds+VKSc0T5K/yUDo03xRadffzGJlMu0wEtnqbW9Usx5l1JUI17ugQA3fXi1HP27IU6NuBh/JrMX8M0SmLhTPaeUtOjSvznTW/Wzh/pJJyldHarfKatYdmxn+URGVlfbB0ISHOV8k9/fSrZMKPI24cw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753119462; c=relaxed/simple;
	bh=U33D7Ggo4901SjIq8nqFRQSf0OmN6QQsO4GqiAznGW4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lGah9slq0/g0ICbXAVm/4yHDtVOnvUUZNcDKVcgaX+0CewFiRN2EhjU2BJ0yRdkC1VCPVuuxHSt/XDhE6/fqJolXRrUCMEMYyKKqW3hRMoBAqYER5V/g9mD4FAZRa8GXNSJunedOVtoeQkByfuDgdsJfhqx4x5JZePG9XKdX1/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Y34iCGVC; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1753119461; x=1784655461;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=U33D7Ggo4901SjIq8nqFRQSf0OmN6QQsO4GqiAznGW4=;
  b=Y34iCGVCKVfG1ZzeUd2vqb1eEL0CsrcrX6FLqNpSwyHMT6n8VJJrOanI
   Y0DorPp1fj/wA6kA2SWcpcMOMOQMoJTehjw4WLn02jE2/RAAKaWLgnRwn
   PJtQA3yz07Wtv4zr4id5quWobflMNSV2jSNI6a2H963uJHGYvza30EDPz
   BhzGa+Vt2PJVEHt96+1RktPSL40MzLbok4Wj9zU9F6oqppSFlcXCIW/yj
   9eXGQDBCSgbx+fOrWI7xPx7g1BEzQMy2+YMhz3CilhwvAEqTLSUOxwQin
   uBWvD2sBbhXVQVEl6VYKpa2jZFugvtP3oshzq9/PmkEDT/29PJ/spiIIb
   g==;
X-CSE-ConnectionGUID: cAYN7SjLTbOIf7/zcDXfnQ==
X-CSE-MsgGUID: ILVPWkKCT02uYuZ/bBEuGg==
X-IronPort-AV: E=McAfee;i="6800,10657,11499"; a="55193173"
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="55193173"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Jul 2025 10:37:41 -0700
X-CSE-ConnectionGUID: 80SW/4A1QJaeW5xB1ELuOQ==
X-CSE-MsgGUID: fyB1d6X+QwKMRIvYc8RsHw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.16,329,1744095600"; 
   d="scan'208";a="158231556"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 21 Jul 2025 10:37:41 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/5][pull request] Intel Wired LAN Driver Updates 2025-07-21 (i40e, ice, e1000e)
Date: Mon, 21 Jul 2025 10:37:21 -0700
Message-ID: <20250721173733.2248057-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For i40e:
Dennis Chen adjusts reporting of VF Tx dropped to a more appropriate
field.

Jamie Bainbridge fixes a check which can cause a PF set VF MAC address
to be lost.

For ice:
Haoxiang Li adds an error check in DDP load to prevent NULL pointer
dereference.

For e1000e:
Jacek Kowalski adds workarounds for issues surrounding Tiger Lake
platforms with uninitialized NVMs.

The following are changes since commit 81e0db8e839822b8380ce4716cd564a593ccbfc5:
  Merge branch 'mlx5-misc-fixes-2025-07-17'
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 40GbE

Dennis Chen (1):
  i40e: report VF tx_dropped with tx_errors instead of tx_discards

Haoxiang Li (1):
  ice: Fix a null pointer dereference in ice_copy_and_init_pkg()

Jacek Kowalski (2):
  e1000e: disregard NVM checksum on tgp when valid checksum bit is not
    set
  e1000e: ignore uninitialized checksum word on tgp

Jamie Bainbridge (1):
  i40e: When removing VF MAC filters, only check PF-set MAC

 drivers/net/ethernet/intel/e1000e/defines.h        | 3 +++
 drivers/net/ethernet/intel/e1000e/ich8lan.c        | 2 ++
 drivers/net/ethernet/intel/e1000e/nvm.c            | 6 ++++++
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 6 +++---
 drivers/net/ethernet/intel/ice/ice_ddp.c           | 2 ++
 5 files changed, 16 insertions(+), 3 deletions(-)

-- 
2.47.1


