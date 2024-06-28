Return-Path: <netdev+bounces-107819-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91A8591C72A
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 22:16:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 47879287AD8
	for <lists+netdev@lfdr.de>; Fri, 28 Jun 2024 20:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D973778285;
	Fri, 28 Jun 2024 20:13:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gS7e7C8T"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53C40139566
	for <netdev@vger.kernel.org>; Fri, 28 Jun 2024 20:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719605624; cv=none; b=kEIxnA2sEIuccD/Xf8oDHPQeEP+Lb0G7oz3brkmRrBorI/abnCCOluIiEQbiubGxeKuhRnjClO5XGVDjuG/BSWEwC/F5ztYfyJvI+tPXyM19/YJE7a7fkSZIO8QhMurK265cOOe2t9KYckDyzDnUHYgLU1y4m7HAosIT5SoJaJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719605624; c=relaxed/simple;
	bh=dCuzEPV0cRPvXlLaCm+FzHbMF/7LdZEG0DVnVzRUOKo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kdFjaaMfsDwYUL7qnaiCPgkrPa7D6kT4C3VQjETfiN/xLavfq1CKulG7VI2KKH4XTFjejE0iB4Jxl7sbgHLgZiqRMSai8+PDAvkkW16beQ0NPyk0SOU2xQWXjEPS+XHcgyIBtbouVeppBmj9+voPpSdrtLlTqZQmzKNOY5E3CGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gS7e7C8T; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1719605623; x=1751141623;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=dCuzEPV0cRPvXlLaCm+FzHbMF/7LdZEG0DVnVzRUOKo=;
  b=gS7e7C8T1DIznubau4Uzy8GiUO+EPZ+hlHI3v6qcJxSpnRdt2lJMCpxA
   AVZx4FLvP9XUkN6OCuAAy/hmqHRShRCJijBHR+u1dCMb1K0xLKGF1n7+r
   WKBSoV/v1aFafffZwwqC0+kNlwP/9ohFxeVPl/GnMe0Mo0rZ8dFbASF9h
   R5UKFgzOiMZrnoXWmeOw8E+ND8iHbLWqqE82pqBrEJAgTnSLBG+2Te06k
   q/d/7iIqZgMHrGbOdujtQNRkeKCDGKrLxWODXOMiLRfNyufnozu1bygSM
   i9ctaIsjjkoo91s6QA+h+3oaceOR9BPMIhefOckcLipnDFudDzj81Kmtv
   A==;
X-CSE-ConnectionGUID: poMfYY6JQHOsjOTkLxiCEw==
X-CSE-MsgGUID: ShTBOxZDRo2te2rYMujl4Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11117"; a="20674902"
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="20674902"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jun 2024 13:13:42 -0700
X-CSE-ConnectionGUID: TmqDj21uQWCVhNNJzbn3Kw==
X-CSE-MsgGUID: /bxAUluoR6+WboSpodBXUQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.09,170,1716274800"; 
   d="scan'208";a="49735522"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa003.jf.intel.com with ESMTP; 28 Jun 2024 13:13:42 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Jesse Brandeburg <jesse.brandeburg@intel.com>,
	anthony.l.nguyen@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Paul Menzel <pmenzel@molgen.mpg.de>
Subject: [PATCH net-next 1/6] MAINTAINERS: update Intel Ethernet maintainers
Date: Fri, 28 Jun 2024 13:13:19 -0700
Message-ID: <20240628201328.2738672-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
References: <20240628201328.2738672-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jesse Brandeburg <jesse.brandeburg@intel.com>

Since Jesse has moved to a new role, replace him with a new maintainer
to work with Tony on representing Intel networking drivers in the
kernel.

Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Acked-by: Paul Menzel <pmenzel@molgen.mpg.de>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 22328600cfd0..e0b6b419318f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11051,8 +11051,8 @@ F:	include/drm/xe*
 F:	include/uapi/drm/xe_drm.h
 
 INTEL ETHERNET DRIVERS
-M:	Jesse Brandeburg <jesse.brandeburg@intel.com>
 M:	Tony Nguyen <anthony.l.nguyen@intel.com>
+M:	Przemek Kitszel <przemyslaw.kitszel@intel.com>
 L:	intel-wired-lan@lists.osuosl.org (moderated for non-subscribers)
 S:	Supported
 W:	https://www.intel.com/content/www/us/en/support.html
-- 
2.41.0


