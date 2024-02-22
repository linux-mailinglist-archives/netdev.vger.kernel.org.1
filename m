Return-Path: <netdev+bounces-73976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 350E585F849
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3C53283B6E
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 12:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BB312C809;
	Thu, 22 Feb 2024 12:35:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="livp2Xch"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D78D1F95E
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 12:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708605338; cv=none; b=RiIAah6RXRN0//EDlUnYAZgMDV/O/LLYihuUBNnSrSAeTEGHWuwLALmZmcHTo+JDiNQrx/Y5RBc2HC1EIvvdg4iqPG9gSHLeXlmGuovmDuQWnCCn7HJ+oDE1Rx4hcyUXLSO8Z7NHJ47Tz+Iz5GEkugcYoj21C7V6a8ZmL8Hen20=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708605338; c=relaxed/simple;
	bh=ca+MGruxEMjqLGI3yzKt+M6So4IKI0th6ySBztaxHTk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z0EMzMElNLHyJtVDq+VR3c1xaYjNpxa/nG8MJg+sMddyZVlZDHncCuj38HFn4n+STLBQ7HIGbkVo5R+jS5tuc8op0c/5SghLeQcJ5/W1sWl6xnZDKbUFKWwzighTi6DQB+ayuTs9E1JlwjBsC4/1iDb3CQMgHYoMF7iR2BveMvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=livp2Xch; arc=none smtp.client-ip=192.198.163.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708605337; x=1740141337;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ca+MGruxEMjqLGI3yzKt+M6So4IKI0th6ySBztaxHTk=;
  b=livp2XchVIQjz0S+JEX1VzAlniam4letry49nWaI/r2UDXE8K9KyBRlw
   Nm7GivyW4MvT+JEmrIECnM2WR4YpsXZuOJ5S/qWa2LIloIC/cm7N2UU3m
   c8ppMn+wuA7d1AQjKltMO2sJL5UkP51HFH0rGkuTh/KrxhYIQLmMySi2J
   DcxwYFQtJw66KqrHED10KqeQY1qfHlPNRZ3CpegM7MAFKx1PIKgPwHz0C
   QtHAigmvB5JhvO6lJDxOrVZ+eO3tpC9MPg5pEc3ke2aEz/x42i1vwU4tR
   2mUasrO/9xvTRXvhX5HWIWe3B6D02pqLj0GlvPwSOzHW4r5/pNfmtoDst
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="28267850"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="28267850"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 04:35:36 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="10216247"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by orviesa005.jf.intel.com with ESMTP; 22 Feb 2024 04:35:35 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	pmenzel@molgen.mpg.de,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v2 0/2] ice: extend tc flower offload
Date: Thu, 22 Feb 2024 13:39:54 +0100
Message-ID: <20240222123956.2393-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Extend hardware support for tc flower to match ip_proto field (patch 2)
and source VSI metadata when the packets are sent from VF (patch 1).

v1 --> v2: [1]
 * fix commit message, add more examples

 [1] https://lore.kernel.org/netdev/20240220105950.6814-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (2):
  ice: tc: check src_vsi in case of traffic from VF
  ice: tc: allow ip_proto matching

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 25 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.42.0


