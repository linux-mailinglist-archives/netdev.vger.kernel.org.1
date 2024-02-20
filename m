Return-Path: <netdev+bounces-73250-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD25E85B9AF
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 11:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1AA801C246D5
	for <lists+netdev@lfdr.de>; Tue, 20 Feb 2024 10:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9FD94657D5;
	Tue, 20 Feb 2024 10:55:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mx3pVopm"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44E25657CA
	for <netdev@vger.kernel.org>; Tue, 20 Feb 2024 10:55:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708426542; cv=none; b=tLt5cITtAWRh6JwNneHTlFq6/l375wk8hp146T8nPh9LlLPEvjPAKqhjVjdpvDc6wUoFbvXq3eHEButdNr4FgoeEP+FoUzwgVSuCiaKpPgzIg7DFlkS6VlQc1LNwOP1J/D22Di4E1OS3QqFt283Y0BsbjU9La2GS3PMIr2+0JHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708426542; c=relaxed/simple;
	bh=FOQu5qKbXJVFuxXYfcyWb7ERDO73+C1UvTc0Xxrvbj8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YH+Ow6Ol1CGcji071nPdPXWedYZSKV7zYXXtxc9xelaBs9MCZBiDuGRjO8C2pXIrGhTteFet7iE5zEiLRpkSIfG4ZwXEGLTYi7KLgMy4A5zYrs3hNhwvyIWsnK+C/H6UPO9N5Y3iFiAl+XjKEzyLsvq1mLC9J9RLbnUU27M9OcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mx3pVopm; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708426541; x=1739962541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FOQu5qKbXJVFuxXYfcyWb7ERDO73+C1UvTc0Xxrvbj8=;
  b=Mx3pVopmTM3uALrA8V6qxqo0PjwhR7n87ANhSYcU74b+XC0wcljyueKx
   4ig7RRX+3FtTkOtxwe3j09q6tTpb64LfWwZnX8RDHyqWnVKwc7dWo6n7x
   17p3muBB3SIm6sAntHUsVm/T2cazdXRm2tBoBhIx2gdtsdMLKPMS85nHv
   CinlKNIxzkH4lOVK7ppQlCO5iIxtQb6l1R52++d6wQeJt4pQRHoUaeRPy
   Dzij22D6azW2DCi6ELcoPGtP04MNxmNpRM1n9wOoHQoYK6Xa/7VX9avcF
   lVS4gqJy51mimGuhfltB4r8BVqZ4DsObxR8OdTe8Eh1e42LQeP2UgIrvA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10989"; a="13934159"
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="13934159"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Feb 2024 02:55:41 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,172,1705392000"; 
   d="scan'208";a="4734485"
Received: from wasp.igk.intel.com (HELO GK3153-DR2-R750-36946.localdomain.com) ([10.102.20.192])
  by fmviesa010.fm.intel.com with ESMTP; 20 Feb 2024 02:55:39 -0800
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	marcin.szycik@intel.com,
	sridhar.samudrala@intel.com,
	wojciech.drewek@intel.com,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [iwl-next v1 0/2] ice: extend tc flower offload
Date: Tue, 20 Feb 2024 11:59:48 +0100
Message-ID: <20240220105950.6814-1-michal.swiatkowski@linux.intel.com>
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

Michal Swiatkowski (2):
  ice: tc: check src_vsi in case of traffic from VF
  ice: tc: allow ip_proto matching

 drivers/net/ethernet/intel/ice/ice_tc_lib.c | 25 +++++++++++++++++++--
 drivers/net/ethernet/intel/ice/ice_tc_lib.h |  1 +
 2 files changed, 24 insertions(+), 2 deletions(-)

-- 
2.42.0


