Return-Path: <netdev+bounces-174153-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D5DCA5D9E8
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 10:53:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6491D169B99
	for <lists+netdev@lfdr.de>; Wed, 12 Mar 2025 09:53:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BB1823BFBC;
	Wed, 12 Mar 2025 09:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="f0Ej49jq"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17D6223BD0F
	for <netdev@vger.kernel.org>; Wed, 12 Mar 2025 09:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741773190; cv=none; b=aXQRCmjo3+41wKxuT4NikoC0XHS/2L1EukuSR34STdJHJ4+2sjpKxpD6MRd27PYuazgNWn3cvKVo6IGoc0a1ONwHVaG4govDNotiOGEoyKFwtEkRdMZr8G4DHpVb3zKBI9ZzeipVn7YxYp0nmjXrENwiImCnbGiscdX4uNzez0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741773190; c=relaxed/simple;
	bh=FH9YD2zRJdA6n0MIqi4Jckz2dwoTWm0d8C5gVvoRgGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hz6SJ20xcuqE6/fKK1Fjbd0zO5X344agnIlnGwlUBXv+Yq92O4U/RnziDOQCC/q08hMyhunbCwaX7s29Y73XA8RrlYNZNcp0rmDyxEcjzyjVbPQ64gM3jP9wts3KkYNTkWXMevGBtMCk1dKT+MrZI6kn+FzdH4J6bkY6yqhBvi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=f0Ej49jq; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1741773189; x=1773309189;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FH9YD2zRJdA6n0MIqi4Jckz2dwoTWm0d8C5gVvoRgGE=;
  b=f0Ej49jqSTYE13QWzAcGmxHTO/ai04GV8gWT6MefkshE7fRKPJviQkBj
   XlaK0qNQmJgm8zelDH6im+ZWwQ6DS2yH0sonndO0/jwt1Xfexue9ZZrJq
   xhtgJt7mUVpDasgVsxDTzqZ9fIn5BbRooZasxmvZv+fPzu1tX2VwOJuPP
   TogNQAwbtDQ3IfcGrITmywbHtWIR2/Q2ALmgZKnofrD/dcMc97YsWcOWy
   WiiiSf5qGUPHoD1SPJ8/LcKAvdsdsk0tF+J90SgDxi6du/LSB7wAh/EWX
   VEfv8YoqYUMhrmheELmoBHdWyk1XKBkvm3qd+lK5qwdcyDP5bThkCMfi9
   g==;
X-CSE-ConnectionGUID: cEU3f9zSQR6U9Hej1QhL/w==
X-CSE-MsgGUID: dubbKF/WTpe9yP1epmTt9A==
X-IronPort-AV: E=McAfee;i="6700,10204,11370"; a="60246396"
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="60246396"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Mar 2025 02:53:08 -0700
X-CSE-ConnectionGUID: WhrC76X7S5qriPvuzwJ9fw==
X-CSE-MsgGUID: BCHfpvc1TEqsc1AwWsLiJg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.14,241,1736841600"; 
   d="scan'208";a="151548095"
Received: from gk3153-dr2-r750-36946.igk.intel.com ([10.102.20.192])
  by fmviesa001.fm.intel.com with ESMTP; 12 Mar 2025 02:53:05 -0700
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
Subject: [PATCH net v2 2/3] dpll: fix xa_alloc_cyclic() error handling
Date: Wed, 12 Mar 2025 10:52:50 +0100
Message-ID: <20250312095251.2554708-3-michal.swiatkowski@linux.intel.com>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
References: <20250312095251.2554708-1-michal.swiatkowski@linux.intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In case of returning 1 from xa_alloc_cyclic() (wrapping) ERR_PTR(1) will
be returned, which will cause IS_ERR() to be false. Which can lead to
dereference not allocated pointer (pin).

Fix it by checking if err is lower than zero.

This wasn't found in real usecase, only noticed. Credit to Pierre.

Fixes: 97f265ef7f5b ("dpll: allocate pin ids in cycle")
Signed-off-by: Michal Swiatkowski <michal.swiatkowski@linux.intel.com>
---
 drivers/dpll/dpll_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dpll/dpll_core.c b/drivers/dpll/dpll_core.c
index 32019dc33cca..1877201d1aa9 100644
--- a/drivers/dpll/dpll_core.c
+++ b/drivers/dpll/dpll_core.c
@@ -505,7 +505,7 @@ dpll_pin_alloc(u64 clock_id, u32 pin_idx, struct module *module,
 	xa_init_flags(&pin->parent_refs, XA_FLAGS_ALLOC);
 	ret = xa_alloc_cyclic(&dpll_pin_xa, &pin->id, pin, xa_limit_32b,
 			      &dpll_pin_xa_id, GFP_KERNEL);
-	if (ret)
+	if (ret < 0)
 		goto err_xa_alloc;
 	return pin;
 err_xa_alloc:
-- 
2.42.0


