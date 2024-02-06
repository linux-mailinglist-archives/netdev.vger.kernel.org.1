Return-Path: <netdev+bounces-69635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C696784BF31
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 22:28:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 79FAE1F24A67
	for <lists+netdev@lfdr.de>; Tue,  6 Feb 2024 21:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1BF8E1B949;
	Tue,  6 Feb 2024 21:28:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JDNaayGp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C611BF37
	for <netdev@vger.kernel.org>; Tue,  6 Feb 2024 21:28:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707254910; cv=none; b=q21xrXDfeUneKk4UrjRdrRHswQ7iLqSl1BY7kqUZnYZKf+NNI86bd+VzQ8WR45GXdX9VoCA8bl2vK3iB7UBvJ5Y1M+z7Z+MOYd/FujlAmUUu1Z5E+XyxAIe7ZXe2mvdY7LTFP2qFiPS/iWbzpzLSavogkF5SR0dMZXrDCEAcX2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707254910; c=relaxed/simple;
	bh=QyhOxibb/k07QQ675nsd72zpDBi0zfE02cIZaAHYgys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=H9IJyWciCJNUYcGj29/n3nKnODTPD4uAN4HBjS/HVREgQJW8Wf3vFwevpEm9IDGui7C8Wwz3nf64+S+ayzLqbeqTr7MkaePJ5lsEHadvSo+oBhAMBmlk/u6xs5YWHsGIRGqIyoE8LOMnyex9smplOPg8jQ3gfYWnU5rSND/OJRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JDNaayGp; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707254908; x=1738790908;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=QyhOxibb/k07QQ675nsd72zpDBi0zfE02cIZaAHYgys=;
  b=JDNaayGpoInhK0LFPP9VFnWrvQ47oDZMB9hO3sh19hKX9YAvgVlysLXl
   R9VutDd6NHgIn3S4de0tcndZxMUxsrQkqomYSZ8UElQ9pUXxJ/Xc4GEjS
   kIqRTo6mFa3M4vERzdwVnLVMM0/qXaIqiBGA5FBH9FWCFnPZD1dxZrv1a
   NDq5xwmMy3NGx6zEU3gnJctXFXISQy5c2Yw7wp1ccjLMLiqenn/N/x+MZ
   lzVZFZouOalNuem8vofOMU3YfjHbG4Yz7+mhSy9HRKTw30KwtfRtK2bBX
   kMjbAfQqgLyxAXqQkhtnnW1U0RItxdPLK+HpGmYYqvhnP4OR1VcgejXpA
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10976"; a="11583399"
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="11583399"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Feb 2024 13:28:27 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.05,248,1701158400"; 
   d="scan'208";a="5748280"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa004.fm.intel.com with ESMTP; 06 Feb 2024 13:28:26 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Tony Nguyen <anthony.l.nguyen@intel.com>
Subject: [PATCH net 0/2][pull request] Intel Wired LAN Driver Updates 2024-02-06 (igb, igc)
Date: Tue,  6 Feb 2024 13:28:16 -0800
Message-ID: <20240206212820.988687-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This series contains updates to igb and igc drivers.

Kunwu Chan adjusts firmware version string implementation to resolve
possible NULL pointer issue for igb.

Sasha removes workaround on igc.

The following are changes since commit 1ce2654d87e2fb91fea83b288bd9b2641045e42a:
  net: stmmac: xgmac: fix a typo of register name in DPP safety handling
and are available in the git repository at:
  git://git.kernel.org/pub/scm/linux/kernel/git/tnguy/net-queue 1GbE

Kunwu Chan (1):
  igb: Fix string truncation warnings in igb_set_fw_version

Sasha Neftin (1):
  igc: Remove temporary workaround

 drivers/net/ethernet/intel/igb/igb.h      |  2 +-
 drivers/net/ethernet/intel/igb/igb_main.c | 35 ++++++++++++-----------
 drivers/net/ethernet/intel/igc/igc_phy.c  |  6 +---
 3 files changed, 20 insertions(+), 23 deletions(-)

-- 
2.41.0


