Return-Path: <netdev+bounces-64769-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E59A837140
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 19:57:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB9361F2241C
	for <lists+netdev@lfdr.de>; Mon, 22 Jan 2024 18:57:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63F4A3F8C4;
	Mon, 22 Jan 2024 18:24:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="UP3VMXaP"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 023C33EA9B
	for <netdev@vger.kernel.org>; Mon, 22 Jan 2024 18:24:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705947878; cv=none; b=XeirlgJ0fAK5hN7SN/9pCCrxRnkhrTsOd6smbrH5Xtaw4BVHUiu2MMrepSaoQNh/0Owou84wVekd9GoUFzoPFKls70BlVHLYRJP0IPN+PmNMnhVHwnZA6loJFZFVzxC+u/gJMVPOcC8vCRBjY2NZGYT1U/x3aWDqW6LM2XEQXm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705947878; c=relaxed/simple;
	bh=BN2puuDkxpWwMAj4amtMey5YY1b0Tb3TkcyzNi6w7IQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Cwy+Z+aq+qxp/sjxJ3DKTV5ulB5MeqlANSdJLEXbiRcNhcpVHHLKagi/muVVTNgxjRSSJ72IaVgrbt2QITnC2JY05pGd1SHvoqbPot8u5AS2kPREq8X8mCw/LpEef0gC8z9IcuQpove8NyXeQ2B5OqxoWGELQWrL8/nUhcPEkLI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=UP3VMXaP; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1705947876; x=1737483876;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=BN2puuDkxpWwMAj4amtMey5YY1b0Tb3TkcyzNi6w7IQ=;
  b=UP3VMXaPvKF/bT8IfGfmHezCRhhBEDm1tLpBwMyEnCHgzFS0BrAVWYxT
   AI0ET3MgdP+3PDV/lcG+xAxuzsMaDMmhf9COyHsVWiNhMeYqimcW6i3N2
   0BVKKoyigPvFxsLaWNcwHrZ6kkKwekPUzh+CuFTmrm5ycEwtJlUjoc3vD
   sErhmm11czBPZ7Q/KVVagfapEN/hpSIE9PAtSQ+qECZZ5Gcz3CDRGMRuD
   upDzrKxwOTnysvImx/cYxPVv4czRAAia6TsYh+IAZNeLQ+kevZs/iW6yf
   W8/Nhc140Zf1/ANtU2Qm35+scgLLh40fsGSqTI0p73k3dwnTpXPXDmBma
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="22766524"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="22766524"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jan 2024 10:24:35 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10961"; a="819804060"
X-IronPort-AV: E=Sophos;i="6.05,211,1701158400"; 
   d="scan'208";a="819804060"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orsmga001.jf.intel.com with ESMTP; 22 Jan 2024 10:24:34 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>,
	netdev@vger.kernel.org,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-next] ice: remove duplicate comment
Date: Mon, 22 Jan 2024 10:24:17 -0800
Message-ID: <20240122182419.889727-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>

Remove a comment that was not correct; this structure has nothing
to do with FW alignment.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Paul M Stillwell Jr <paul.m.stillwell.jr@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_debugfs.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_debugfs.c b/drivers/net/ethernet/intel/ice/ice_debugfs.c
index c2bfba6b9ead..85aa31dd86b1 100644
--- a/drivers/net/ethernet/intel/ice/ice_debugfs.c
+++ b/drivers/net/ethernet/intel/ice/ice_debugfs.c
@@ -64,9 +64,6 @@ static const char * const ice_fwlog_level_string[] = {
 	"verbose",
 };
 
-/* the order in this array is important. it matches the ordering of the
- * values in the FW so the index is the same value as in ice_fwlog_level
- */
 static const char * const ice_fwlog_log_size[] = {
 	"128K",
 	"256K",
-- 
2.41.0


