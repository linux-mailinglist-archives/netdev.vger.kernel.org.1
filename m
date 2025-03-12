Return-Path: <netdev+bounces-174151-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6710A5D9E6
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:53:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7084B18977C3
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:53:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FAE623AE95;
	Wed, 12 Mar 2025 09:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q/T7ugvh"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 817CA1DED5C
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:53:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773184; cv=none; b=PU5GLwPXb61YCpvmt3xiiLwwchdsOcNdni3B5UJSteZDOMwRIaTe1VbNcJ9X1VrptBgtyWuFJU/C1nlHdU3RVqem3o8nN5do0eUabY3YSqpiWqD2PBthzYOePHgBG8lNWWZBfXgmGYG/sqKAsrFWDCyAN976QpG+eE5d2kJ1e+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773184; c=relaxed/simple;
	bh=h/GCSGZ2AlVEDxD9YbF091URDbUZAht+PK2Vjm99CY8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ttdz6kRb2aMXJjbUVUC0woDGQpp+HBL8NQ7/S84zPrE+K4uRxeiLeVbB1KLY5PPP3uZioo4EpOcrjW86Fo9x14+ZJpsJKQyz8qAG9k7+5lzUiDMmSiQisws9/0fq2svLjBeBXUnaNGHciVQA87WXMiFD+rIjRdixT0rAsk8PN60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q/T7ugvh; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741773182; x=1773309182;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=h/GCSGZ2AlVEDxD9YbF091URDbUZAht+PK2Vjm99CY8=;
  b=Q/T7ugvhdZJMx/CUMdNJyUC+HmCqoj4opebSHf3qPpJmM+zh1d8jrwUY
   jF2thJQq7zS1heUucG3vZCUjKc48fnbPIszbTrmW7O7X8JbPvZJ44Tthf
   BIO6+N+ZhejO3llZidp85c9Vr+LgYSQ8XBH4SUZd8yAxqYiXOqpC09Xhs
   +DSt58KnMCJSi5PpLHvuXeqjUtedti3vmf4+Dqd2bl97lqwwR58GgDrrq
   cC0z3iehHqnzlttf9FQOmoXuZDFaGwx7kGs80sB3rGlv7vf/4ToSwM4Zo
   dvCtRTQ2KAtQqIm3arC9JVLnSIcoHGAkQTkTqPgBYbeweeX2xeM3rdBN5
   Q==;
X-CSE-ConnectionGUID: Uquq1CGtR7aOPWRT02rmVQ==
X-CSE-MsgGUID: kcQFuEqCSNqv6SLQpb9iIQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60246370"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="60246370"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:53:01 -0700
X-CSE-ConnectionGUID: 1uWK7k22QoO7Pai6iUsTcQ==
X-CSE-MsgGUID: d17Ohp3JR5GdYUGX+wTwUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151548009"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 02:52:58 -0700
From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
To: netdev@vger.kernel.org
Cc: jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	pierre@stackhpc.com,
	hkallweit1@gmail.com,
	linux@armlinux.org.uk,
	maxime.chevallier@bootlin.com,
	christophe.leroy@csgroup.eu,
	arkadiusz.kubalewski@intel.com,
	vadim.fedorenko@linux.dev,
	Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Subject: [PATCH net v2 0/3] fix xa_alloc_cyclic() return checks
Date: Wed, 12 Mar 2025 10:52:48 +0100
Message-ID: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Pierre Riteau <pierre@stackhpc.com> found suspicious handling an error
from xa_alloc_cyclic() in scheduler code [1]. The same is done in few
other places.

v1 --> v2: [2]
 * add fixes tags
 * fix also the same usage in dpll and phy

[1] https://lore.kernel.org/netdev/20250213223610.320278-1-pierre@stackhpc.com/
[2] https://lore.kernel.org/netdev/20250214132453.4108-1-michal.swiatkowski@linux.intel.com/

Michal Swiatkowski (3):
  devlink: fix xa_alloc_cyclic() error handling
  dpll: fix xa_alloc_cyclic() error handling
  phy: fix xa_alloc_cyclic() error handling

 drivers/dpll/dpll_core.c            | 2 +-
 drivers/net/phy/phy_link_topology.c | 2 +-
 net/devlink/core.c                  | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

-- 
2.42.0


