Return-Path: <netdev+bounces-129506-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 535FE9842E6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 12:02:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28BABB28EE6
	for <lists+netdev@lfdr.de>; Tue, 24 Sep 2024 10:02:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9417E1494CE;
	Tue, 24 Sep 2024 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Z+uK1mme"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4D116D33F
	for <netdev@vger.kernel.org>; Tue, 24 Sep 2024 10:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727172137; cv=none; b=VE/47Mt7C3ch7+hG8fddK8TpsdujpGZ/Htlf1ZpTauKVxkso7Gb5TEB8VQJ/D98xL2QXwRcLhyghDc/cyqGISZpbuampg2tbdrizbtOHqsz+5XgqapGxzXTNdqGhzmDdHHgrBbNf73XJ4hWAf0JclYDSBmKLlf+2U6/rBAFlOZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727172137; c=relaxed/simple;
	bh=9pTCtvoU8bZ1CmLxI3yN4pIXZkad/QyzLZAJMugUkNo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TOdLYZp70OzMDFDzXXEtqrglmMQ1c9uWfvROSTNuwWLAMS3KiOvOasck6AtlLwt0EwyWmQqWfMU2/fdnltstPtsU9Zj5i6mQbr19MwOd/b4fWEBkU950ni5RMQRhnG0n2KOlUdlPU9gWncFJ0Z46897quNe9bZfLI83iiijdwUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Z+uK1mme; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1727172136; x=1758708136;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9pTCtvoU8bZ1CmLxI3yN4pIXZkad/QyzLZAJMugUkNo=;
  b=Z+uK1mmeo3Ve8z/a0x0GB3H1/0goxKDhJDJf6kLO0kGp+blcocYAYveI
   lmHZPYDZgynrC7UxlgLwZ8k+uetXhmyxXTLWOW2iGs+uh2yi89UMDsKAw
   54cLFLeFTyOJ8GAKX9DgLGLLFmRn4X0GlhWWICGJ3K50mOUPpCaH5zdXu
   eHPSwZBc7PFHzvCngaQzftj4gYsNpTE7h75576Jca2r76M1gTUHekQov3
   oBWvvotA9h8EqEk0YqYl4NNrvg/DT/thuEVKTsDx5BTyPGXuFxSI5eP5m
   VQkuiFG9Dn7O3sqbgYjdxhQTxV/OBEMUTs5ys0NAImahU3K6ARFxf7TV7
   g==;
X-CSE-ConnectionGUID: 8j1yezLTQwGs0zzypl+dVg==
X-CSE-MsgGUID: iRRAyZr4TKOtFJd+Yni3uA==
X-IronPort-AV: E=McAfee;i="6700,10204,11204"; a="36725592"
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="36725592"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Sep 2024 03:02:14 -0700
X-CSE-ConnectionGUID: k4NHMK89TyeiUggX//f82g==
X-CSE-MsgGUID: TCMOIc3WTj29KK6OBIcttg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,254,1719903600"; 
   d="scan'208";a="76285974"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa004.jf.intel.com with ESMTP; 24 Sep 2024 03:02:13 -0700
Received: from mystra-4.igk.intel.com (mystra-4.igk.intel.com [10.123.220.40])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 8269027BA0;
	Tue, 24 Sep 2024 11:02:11 +0100 (IST)
From: Marcin Szycik <marcin.szycik@linux.intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	mateusz.polchlopek@intel.com,
	maciej.fijalkowski@intel.com,
	bcreeley@amd.com,
	Marcin Szycik <marcin.szycik@linux.intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iwl-net v3 2/2] ice: Fix netif_is_ice() in Safe Mode
Date: Tue, 24 Sep 2024 12:04:24 +0200
Message-ID: <20240924100422.8010-4-marcin.szycik@linux.intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240924100422.8010-3-marcin.szycik@linux.intel.com>
References: <20240924100422.8010-3-marcin.szycik@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

netif_is_ice() works by checking the pointer to netdev ops. However, it
only checks for the default ice_netdev_ops, not ice_netdev_safe_mode_ops,
so in Safe Mode it always returns false, which is unintuitive. While it
doesn't look like netif_is_ice() is currently being called anywhere in Safe
Mode, this could change and potentially lead to unexpected behaviour.

Fixes: df006dd4b1dc ("ice: Add initial support framework for LAG")
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Marcin Szycik <marcin.szycik@linux.intel.com>
---
 drivers/net/ethernet/intel/ice/ice_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_main.c b/drivers/net/ethernet/intel/ice/ice_main.c
index 7a84d3c4c305..b1e7727b8677 100644
--- a/drivers/net/ethernet/intel/ice/ice_main.c
+++ b/drivers/net/ethernet/intel/ice/ice_main.c
@@ -87,7 +87,8 @@ ice_indr_setup_tc_cb(struct net_device *netdev, struct Qdisc *sch,
 
 bool netif_is_ice(const struct net_device *dev)
 {
-	return dev && (dev->netdev_ops == &ice_netdev_ops);
+	return dev && (dev->netdev_ops == &ice_netdev_ops ||
+		       dev->netdev_ops == &ice_netdev_safe_mode_ops);
 }
 
 /**
-- 
2.45.0


