Return-Path: <netdev+bounces-108868-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 932979261A0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 15:17:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3F1B3B2BEF0
	for <lists+netdev@lfdr.de>; Wed,  3 Jul 2024 13:16:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAD517967E;
	Wed,  3 Jul 2024 13:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gNWzv+RM"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65674171095
	for <netdev@vger.kernel.org>; Wed,  3 Jul 2024 13:16:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720012579; cv=none; b=uPy2h6YJQ5BaJrRO9/B1FKBNRbqnmgE+We2CU6OllGcocgmwb7SnNQDarAG2DXhcnA032q0u3TQ18PTL1DENWtvcn/0JQhkG0MIt1eOE7h7HtV/MBdQG+HgkFllFK0dDNF9anOSww1oIJA4CpffLQbaiLHgeymkPSoZoyPDuWxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720012579; c=relaxed/simple;
	bh=RmFFuiWyudqqJH/BIdZhqZUPBJUMygqHGKWV0ukvic0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=NfK6WaWRXyxl11Oe1ha8bS5CH8RIe5iiXkpQPTlIkBaoPGO6D+pI/TZQSXgcD8HLte/1Txnxv8UymbJGWcYEQwN4EnMq57KhlH2Shw5uz8eEeylB0ifOb09cd4KW5g55KKverWiJ3bTPXzFo3yi/bywH5uekvUEK5O3N+2vsAEM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gNWzv+RM; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1720012579; x=1751548579;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=RmFFuiWyudqqJH/BIdZhqZUPBJUMygqHGKWV0ukvic0=;
  b=gNWzv+RMH2bzbX5DWfDiA/9i5FuWUF2oNuim7yO/6UxPUbVcJNnyUqoq
   w/ZEigvjgYKoUloc0CCSrjwwsqPHGCiYY93G85IarJMzslkb8YI8l+EQc
   YCr15pl263fiMEDW4MaXRs6RrHADNJ8gg+ezd0UtPkyQZ751gF2WzR3dE
   rApozrP/1Wvg4g7FCgb+OU8rwzhGnRhyV/jvN4YOyIZ2M3PVP0ySbVPVt
   vueRsp9PjjFeLNOtE/DH/BCFxTK3oD9JIBjw0yJM/VrSxiFLr308ZgVeq
   MxLrkFUt8S+5kUaJIjza4q6wMIR9t/yB2MmcitfxxtRfBY3esBJbnpGD7
   w==;
X-CSE-ConnectionGUID: 5McSNQf4SwK+sOSuDJJtyA==
X-CSE-MsgGUID: Bxg2uiaTQZaKd9hz+19ymA==
X-IronPort-AV: E=McAfee;i="6700,10204,11121"; a="17195087"
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="17195087"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2024 06:16:15 -0700
X-CSE-ConnectionGUID: FqYrvja0RNeacWloGBNzng==
X-CSE-MsgGUID: e6dx5BRcRLisInHUVMyelw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,182,1716274800"; 
   d="scan'208";a="83805884"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa001.jf.intel.com with ESMTP; 03 Jul 2024 06:16:11 -0700
Received: from vecna.igk.intel.com (vecna.igk.intel.com [10.123.220.17])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id CDD2728778;
	Wed,  3 Jul 2024 14:16:10 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: Stephen Hemminger <stephen@networkplumber.org>,
	David Ahern <dsahern@kernel.org>
Cc: netdev@vger.kernel.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>
Subject: [PATCH iproute2-next 1/3] man: devlink-resource: add missing words in the example
Date: Wed,  3 Jul 2024 15:15:19 +0200
Message-Id: <20240703131521.60284-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.39.3
In-Reply-To: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
References: <20240703131521.60284-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add missing "size" and "path" words in the example, as the current example
is incorrect and will be rejected by the command.

The keywords were missing from very inception of devlink-resource man page

Fixes: 58b48c5d75e2 ("devlink: Update man pages and add resource man")
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 man/man8/devlink-resource.8 | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/man/man8/devlink-resource.8 b/man/man8/devlink-resource.8
index 8c3158076a92..c4f6918c9b03 100644
--- a/man/man8/devlink-resource.8
+++ b/man/man8/devlink-resource.8
@@ -63,7 +63,7 @@ devlink resource show pci/0000:01:00.0
 Shows the resources of the specified devlink device.
 .RE
 .PP
-devlink resource set pci/0000:01:00.0 /kvd/linear 98304
+devlink resource set pci/0000:01:00.0 path /kvd/linear size 98304
 .RS 4
 Sets the size of the specified resource for the specified devlink device.
 .RE
-- 
2.39.3


