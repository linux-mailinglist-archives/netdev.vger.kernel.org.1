Return-Path: <netdev+bounces-225725-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8ACFB9789E
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 22:57:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E847D1B21978
	for <lists+netdev@lfdr.de>; Tue, 23 Sep 2025 20:57:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8F2B28134F;
	Tue, 23 Sep 2025 20:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NA/yMDQp"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 177D930ACF7
	for <netdev@vger.kernel.org>; Tue, 23 Sep 2025 20:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758661027; cv=none; b=bT5pl19+Tq63X3Q43GsFLLcvmWT8q9QoGDrDv1fP3yIAxP5oznpprJZvM51AZc5WOAKKjfYHxJqOsaJlTAfeH1bKYsMhzye49/Gu5/13j1//5V7cx1fNBZQkcDiznQ4CJhyucVDqMPG8YJkSZ3irw2StZ/oHayVzR3k3wkTzG90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758661027; c=relaxed/simple;
	bh=DUltzVLRltYGAvTt76bjQkWcoea8gDK9MIF1iaSQ0Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TNHE5MqsfFOiwmLCXIvQq8umXbWAjv+bVNlsqeGeXf1+ukmjk63iE39nZbZlbYztW43QoqiNkiVWDTiWSQVmcWyb436S7kCTWxpY3k5pFuPLrfeOfYT+jE5T+/i9Sb6pVXpHGo6DoN+PdvMT31HdhyIPHRVKFIdiBLmqPSg/uHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NA/yMDQp; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1758661026; x=1790197026;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=DUltzVLRltYGAvTt76bjQkWcoea8gDK9MIF1iaSQ0Ds=;
  b=NA/yMDQpfcn2DupEJ07ta4VH/OXDPEgh2V0FKabyPOpqquTgPuC4fQ/M
   RLbcqNIejZKV8pdfaHwyOl4jj4DLm6ZtUm77Cc0wSumaFtGMDuJxyP04y
   E1nV7E7TD3KqvE63MThzjUdlZLkNUFo9pM6qJ1TrR/iv7LMJ7R/Az+eyU
   zUaM9T50iQzi3d8XtJu0iWO30sJydq21QRPphZC/dsOholUaVCXWYQ6PX
   5oa623ty2fI4P0lsBuwIyoRI/1dBY2RlaxtIojZChulO98laRCl6pRsJw
   ZC2sXghpMQH1+dTgYZ2Ad6yTSUlZQiGDIRl0GQ9VQH4XsrK3YBJExRUgT
   w==;
X-CSE-ConnectionGUID: oKVfE+2ZREyq5TsN04pgng==
X-CSE-MsgGUID: OYaY9+CUQCecgW//Jh2ELQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11561"; a="60654909"
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="60654909"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Sep 2025 13:57:05 -0700
X-CSE-ConnectionGUID: 6J0jhgjrS1OKOzI4hggwyA==
X-CSE-MsgGUID: elKy0kj1TbSMvbb2VpsAaQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.18,289,1751266800"; 
   d="scan'208";a="176459496"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 23 Sep 2025 13:57:04 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Jacob Keller <jacob.e.keller@intel.com>,
	anthony.l.nguyen@intel.com,
	michal.swiatkowski@linux.intel.com,
	aleksander.lobakin@intel.com,
	przemyslaw.kitszel@intel.com,
	Paul Menzel <pmenzel@molgen.mpg.de>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net] libie: fix string names for AQ error codes
Date: Tue, 23 Sep 2025 13:56:56 -0700
Message-ID: <20250923205657.846759-1-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jacob Keller <jacob.e.keller@intel.com>

The LIBIE_AQ_STR macro() introduced by commit 5feaa7a07b85 ("libie: add
adminq helper for converting err to str") is used in order to generate
strings for printing human readable error codes. Its definition is missing
the separating underscore ('_') character which makes the resulting strings
difficult to read. Additionally, the string won't match the source code,
preventing search tools from working properly.

Add the missing underscore character, fixing the error string names.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
Fixes: 5feaa7a07b85 ("libie: add adminq helper for converting err to str")
Reviewed-by: Paul Menzel <pmenzel@molgen.mpg.de>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
I found this recently while reviewing the libie code. I believe this
warrants a net fix because it is both simple, and because users may attempt
to pass printed error codes into search tools like grep, and will be unable
to locate the error values without manually adding the missing '_'.

 drivers/net/ethernet/intel/libie/adminq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/libie/adminq.c b/drivers/net/ethernet/intel/libie/adminq.c
index 55356548e3f0..7b4ff479e7e5 100644
--- a/drivers/net/ethernet/intel/libie/adminq.c
+++ b/drivers/net/ethernet/intel/libie/adminq.c
@@ -6,7 +6,7 @@
 
 static const char * const libie_aq_str_arr[] = {
 #define LIBIE_AQ_STR(x)					\
-	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC" #x
+	[LIBIE_AQ_RC_##x]	= "LIBIE_AQ_RC_" #x
 	LIBIE_AQ_STR(OK),
 	LIBIE_AQ_STR(EPERM),
 	LIBIE_AQ_STR(ENOENT),
-- 
2.47.1


