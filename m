Return-Path: <netdev+bounces-181782-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 647F5A8678B
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 22:46:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BCF874C514D
	for <lists+netdev@lfdr.de>; Fri, 11 Apr 2025 20:45:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDFD29C356;
	Fri, 11 Apr 2025 20:44:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="D/zZGzMU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D70429AB16;
	Fri, 11 Apr 2025 20:44:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744404256; cv=none; b=JH36IRhmwZwXrNOTYpKXxGaRtJ/xMtKd+4zaxX4mDhm7vqVF05Jib2/oYVECyl9L98FXlWLjEjA7oJIDGu0qMomQyJfA0nGoJ3yykwnRKxFVql4QIFuVg1wkoVg92b6uWKe8oZwUhYphOX6NlZk4naomIF6uBoAnBkYv7Spuap8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744404256; c=relaxed/simple;
	bh=ArzkR0jpaFqHXVe3C+l5JXr+B9OrfNxZZX7vXYV2pVk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Sf4p76TcsNQrD+g+WE/oS11k2+b3NmTunhMAldRbl7eb0yHHwiPo1W+zRMS/RYSYzcw7OXMo54rK11nW7hPDbGlAkBqlCWQ9w7aiLA16/LKNk5v2gHIRcag4BGBP3W3nTYYlYuqU8CSXs0D8HH6i2rReMYaK4K52YpZfoAg+0kw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=D/zZGzMU; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1744404255; x=1775940255;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=ArzkR0jpaFqHXVe3C+l5JXr+B9OrfNxZZX7vXYV2pVk=;
  b=D/zZGzMUMjltbJXhUBlUtJJInH8QMgCC8Dht6wuIptQFiXrPjVRZt0/Y
   Q0PhVNUSv3e77/hJD54UTEoukmbp2AGvSschlR3pYZdgXQjNjWLf2Rrru
   9wFmPIGUxi21oXr/VEZ5fBQmKUtXkufQzi7mVwLrvWpKzbo6ZoUn8WWi2
   gyDvMA9NGUGcmIRZOZRpjfDDK9dCWIKqkb/pbtWc5utk5j3coKP7MnYic
   mzOoP3L4Lw4tf1YSUPGlrxnAiBN26lSxd18W3MhD1rjVfrVKrdwgtrFX4
   +nsIFjRsddyONkm8H458YXGwGGN5yj3hYMNM9dOd/rBk6ADEPpmb8jPO5
   Q==;
X-CSE-ConnectionGUID: 3YMm6SuoTwuXllsr0hRsUw==
X-CSE-MsgGUID: TgtkDMz0Qe2EBZ1ilnffwA==
X-IronPort-AV: E=McAfee;i="6700,10204,11401"; a="45103908"
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="45103908"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Apr 2025 13:44:07 -0700
X-CSE-ConnectionGUID: 2SJQ2noATS+NBEaJZRlG6Q==
X-CSE-MsgGUID: BLU5cVZaSIqLXNckHiNJVA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.15,206,1739865600"; 
   d="scan'208";a="129241826"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 11 Apr 2025 13:44:07 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Colin Ian King <colin.i.king@gmail.com>,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	kernel-janitors@vger.kernel.org,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 11/15] ice: make const read-only array dflt_rules static
Date: Fri, 11 Apr 2025 13:43:52 -0700
Message-ID: <20250411204401.3271306-12-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
References: <20250411204401.3271306-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Colin Ian King <colin.i.king@gmail.com>

Don't populate the const read-only array dflt_rules on the stack at run
time, instead make it static.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
index 1d118171de37..aceec184e89b 100644
--- a/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
+++ b/drivers/net/ethernet/intel/ice/ice_ethtool_fdir.c
@@ -1605,7 +1605,7 @@ void ice_fdir_replay_fltrs(struct ice_pf *pf)
  */
 int ice_fdir_create_dflt_rules(struct ice_pf *pf)
 {
-	const enum ice_fltr_ptype dflt_rules[] = {
+	static const enum ice_fltr_ptype dflt_rules[] = {
 		ICE_FLTR_PTYPE_NONF_IPV4_TCP, ICE_FLTR_PTYPE_NONF_IPV4_UDP,
 		ICE_FLTR_PTYPE_NONF_IPV6_TCP, ICE_FLTR_PTYPE_NONF_IPV6_UDP,
 	};
-- 
2.47.1


