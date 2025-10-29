Return-Path: <netdev+bounces-234186-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 171BBC1DA88
	for <lists+netdev@lfdr.de>; Thu, 30 Oct 2025 00:15:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CCB9118943D2
	for <lists+netdev@lfdr.de>; Wed, 29 Oct 2025 23:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B7F52FFFB6;
	Wed, 29 Oct 2025 23:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gHQ4yqwO"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 550362FAC0D
	for <netdev@vger.kernel.org>; Wed, 29 Oct 2025 23:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761779631; cv=none; b=SsAv1dalRTM2/+2b/qNeHJgBmz9nfwhQ+fo7hb7S1uGYT4YqHRTshtgiXmuJSBecjlDVG2rfmZahhGm5HzI1NRVZQ3gKEuQGqtTPPtbeXBmnSdKs8VztyheE1vD9HbIO7h92Ha3DZisIg7IgIsoie+kGkaXzA7pPCEm6qq7o9YA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761779631; c=relaxed/simple;
	bh=KBc76Nq0nlH9dOBIydBOUX7LHnW6rRilL6Dqdc6iaqY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IDck9tbN8iyEqbe0QbuK/U/SMWRANs+w+1tEIYwO3qwL/BBBxYxG9TBL0wENxVWQpkosNkeQ2SGF6pS6/Rfp7pk7H9t60thYfvHlJVC79FZY44RXGog5qXzAzv+6a2vHSZZki30wJTksTYmiGE44vYY1ErW/li+yDm3xH6S7mJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gHQ4yqwO; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1761779630; x=1793315630;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=KBc76Nq0nlH9dOBIydBOUX7LHnW6rRilL6Dqdc6iaqY=;
  b=gHQ4yqwOau9XD+zn342Ef2/LT8EZL2bRqsFyNIAInjOBU2nrz7IvrWla
   J9Px5r5pJ7enCHIjxQfUVKa0pHXF1pf48jh3KbFt5JGOEbaAIopcEpjgc
   VTchbgi5eP4Cn0XjBBJIjkpEC3CYsu4gzNRBCcVlJckOqlF8unJvOPFvd
   47VLwCNjZamNMk7MxF36NuiYeYdz2zBWAbvlbgxBC/vlB2Bhjn8uI2Qow
   5plUMVp0V1hH86yJ5xk8BV3PoHWNJg7pcAaz0+dsrZ/cKI/0nre769VVl
   hdkS/AUw3YGk7zayiyIKMKvuK/nOGKYdUm/P4PutNWPqUY0lCmKLPaEiJ
   g==;
X-CSE-ConnectionGUID: 3QcloyOiS5y0hFnitzeJSw==
X-CSE-MsgGUID: K358G3U3T9u0ScIibneR6g==
X-IronPort-AV: E=McAfee;i="6800,10657,11531"; a="63817607"
X-IronPort-AV: E=Sophos;i="6.17,312,1747724400"; 
   d="scan'208";a="63817607"
Received: from orviesa007.jf.intel.com ([10.64.159.147])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Oct 2025 16:13:47 -0700
X-CSE-ConnectionGUID: khok7wMCSuqynKmZt6iGAg==
X-CSE-MsgGUID: 6vUIvkT4QAuW8SHKUefgCA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,265,1754982000"; 
   d="scan'208";a="185729698"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa007.jf.intel.com with ESMTP; 29 Oct 2025 16:13:47 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Grzegorz Nitka <grzegorz.nitka@intel.com>,
	anthony.l.nguyen@intel.com,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Simon Horman <horms@kernel.org>,
	Rinitha S <sx.rinitha@intel.com>
Subject: [PATCH net-next 5/9] ice: Allow 100M speed for E825C SGMII device
Date: Wed, 29 Oct 2025 16:12:12 -0700
Message-ID: <20251029231218.1277233-6-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
References: <20251029231218.1277233-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Grzegorz Nitka <grzegorz.nitka@intel.com>

Add E825C 10GbE SGMII device to the list of devices supporting 100Mbit
link mode. Without that change, 100Mbit link mode is ignored in ethtool
interface. This change was missed while adding the support for E825C
devices family.

Testing hints (please note, for previous version, 100baseT/Full entry
was missing):
[root@localhost]# ethtool eth3
Settings for eth3:
        Supported ports: [ TP ]
        Supported link modes:   100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
        Supported pause frame use: Symmetric
        Supports auto-negotiation: Yes
        Supported FEC modes: None
        Advertised link modes:  100baseT/Full
                                1000baseT/Full
                                10000baseT/Full
	...

Signed-off-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Rinitha S <sx.rinitha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index b097cc8b175c..83f5217bce9f 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3392,6 +3392,7 @@ bool ice_is_100m_speed_supported(struct ice_hw *hw)
 	case ICE_DEV_ID_E822L_SGMII:
 	case ICE_DEV_ID_E823L_1GBE:
 	case ICE_DEV_ID_E823C_SGMII:
+	case ICE_DEV_ID_E825C_SGMII:
 		return true;
 	default:
 		return false;
-- 
2.47.1


