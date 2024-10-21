Return-Path: <netdev+bounces-137672-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 104499A9422
	for <lists+netdev@lfdr.de>; Tue, 22 Oct 2024 01:26:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D163B2138F
	for <lists+netdev@lfdr.de>; Mon, 21 Oct 2024 23:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 089231FF60C;
	Mon, 21 Oct 2024 23:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="C5rBptL9"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CCDD1FE11F
	for <netdev@vger.kernel.org>; Mon, 21 Oct 2024 23:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729553194; cv=none; b=OoLQClVaYaoMep4li8MKNL5PYscgh/vsz3C+PBQ+TC59xmx+SwD6cgqLcsNQ8LO1VaK0jlspgod0EL521vFTyl+a/7R9lmF2N1mg+XcYpNGdPx0HtDXZa5cFBw90uN+7swZv785M2Uygyu48BawNQcmGBrc3NpxZuleGo+JSIZs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729553194; c=relaxed/simple;
	bh=jG32Dq6xXOw+2hDpSvDEFNka9a5pGgLqoyXxxqoU0Io=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=VTkvMTh2SBgDU4Z0nGkYF9erc6h4rwyyOVHdiBiEPFo1Ziz2SRa7ohPbG3pX2F+NR5+FFG0q+MLMRX9rVi7EZ1AXRYKyfFu+aI66/ov1pzkfJgNZ9s+LvIiHr78FLoa5atcyMVOEUXmsAVaJaSUH+spSXwtT1CsALUmnHjap9FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=C5rBptL9; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1729553193; x=1761089193;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:references:in-reply-to:to:cc;
  bh=jG32Dq6xXOw+2hDpSvDEFNka9a5pGgLqoyXxxqoU0Io=;
  b=C5rBptL9IsLhrcvbkQ/EAEjrZYphXmW8m/S1kUzFkox4q1owR/6dilnz
   YzCvU5hOVeZ/LNSxItFM+seceA4tJMGCfnDVwQgpvrJ+NyhEgWH8nNPfw
   2egYYUV/jv8V8ihpCllMZUrDkY46nXbHfwxP6kWJUFBTy4ke1XH0CNIVY
   v88+gLaE9vAp5c95fNfUOMmKvyGZBzFhpLDAfcLY+I9nXGHcE5avgjUny
   /PKO+OFv+T/R4M73nppIwu/U7Loh+O9A7c80fHrLb7FNPXdUrssyUtyj2
   rHa16P9qcTndU5ryWi4t5FVeS2PKJNWzMoBdZhDPN+GIFOfdUGVnMe/X4
   A==;
X-CSE-ConnectionGUID: ZkGOlpSGTImkrnKxli9cHg==
X-CSE-MsgGUID: 63PbGpOfTMyPdXyjF8i83g==
X-IronPort-AV: E=McAfee;i="6700,10204,11232"; a="31927051"
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="31927051"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:31 -0700
X-CSE-ConnectionGUID: Kwz0C4QUQ1+OVTsaCwl6cA==
X-CSE-MsgGUID: 48ebeuz7Rw+9bsVZY8PNdg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,221,1725346800"; 
   d="scan'208";a="79761747"
Received: from jekeller-desk.jf.intel.com ([10.166.241.20])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Oct 2024 16:26:30 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Date: Mon, 21 Oct 2024 16:26:25 -0700
Subject: [PATCH net 2/3] ice: block SF port creation in legacy mode
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-2-a50cb3059f55@intel.com>
References: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
In-Reply-To: <20241021-iwl-2024-10-21-iwl-net-fixes-v1-0-a50cb3059f55@intel.com>
To: Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Jeff Garzik <jgarzik@redhat.com>, 
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, 
 Piotr Raczynski <piotr.raczynski@intel.com>, 
 Vadim Fedorenko <vadim.fedorenko@linux.dev>, 
 Milena Olech <milena.olech@intel.com>, 
 Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>, 
 Michal Michalik <michal.michalik@intel.com>, 
 netdev <netdev@vger.kernel.org>
Cc: Jiri Pirko <jiri@resnulli.us>, Jacob Keller <jacob.e.keller@intel.com>, 
 Kalesh AP <kalesh-anakkur.purayil@broadcom.com>, 
 Rafal Romanowski <rafal.romanowski@intel.com>
X-Mailer: b4 0.14.1

From: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>

There is no support for SF in legacy mode. Reflect it in the code.

Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Fixes: eda69d654c7e ("ice: add basic devlink subfunctions support")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
Reviewed-by: Kalesh AP <kalesh-anakkur.purayil@broadcom.com>
Tested-by: Rafal Romanowski <rafal.romanowski@intel.com>
Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
 drivers/net/ethernet/intel/ice/devlink/devlink_port.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
index 928c8bdb6649..c6779d9dffff 100644
--- a/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
+++ b/drivers/net/ethernet/intel/ice/devlink/devlink_port.c
@@ -989,5 +989,11 @@ ice_devlink_port_new(struct devlink *devlink,
 	if (err)
 		return err;
 
+	if (!ice_is_eswitch_mode_switchdev(pf)) {
+		NL_SET_ERR_MSG_MOD(extack,
+				   "SF ports are only supported in eswitch switchdev mode");
+		return -EOPNOTSUPP;
+	}
+
 	return ice_alloc_dynamic_port(pf, new_attr, extack, devlink_port);
 }

-- 
2.47.0.265.g4ca455297942


