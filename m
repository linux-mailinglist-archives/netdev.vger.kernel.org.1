Return-Path: <netdev+bounces-160855-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 37895A1BDE3
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 22:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3273B3AEDCA
	for <lists+netdev@lfdr.de>; Fri, 24 Jan 2025 21:32:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7ACF1E7C36;
	Fri, 24 Jan 2025 21:32:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="TVBM9GV+"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 204E51DDC2F
	for <netdev@vger.kernel.org>; Fri, 24 Jan 2025 21:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737754342; cv=none; b=Y+it/EyvIhTjLUhPFLkyPMXOMxTh17A2cs0MKgfTtiLYGctRdMaByyjdN455jtDNMMohvGCusSU+NUVw3Fxu7E+14wWGLb94zYp24qXAIvjnlWZgjR/KosDZqsth/uROEMcOKwS5R+qNiExS1YuFj4lTtlhww2GYb3Cr085RuDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737754342; c=relaxed/simple;
	bh=0beSTsiL0hSjQwcJ07iG4UnIPxjt0aY9WhObxi/LZYE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LUimAbDfRnA/3KkqmQ5kAVbQv4AKcS5D1YrZGlbiqsW6MitYPkn4qzKa7QEaldzo/AQZdX2ol3lNXPPFyyfZQg3ooOLovepYFPaoZFwOniV1r+D9teBekgHY1LyPEFqx8HyKZAX+TImInW8n09g9Y++RjtuN0pNOb2p0NMB73HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=TVBM9GV+; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1737754341; x=1769290341;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0beSTsiL0hSjQwcJ07iG4UnIPxjt0aY9WhObxi/LZYE=;
  b=TVBM9GV+IRXieNryvqNq/tW/auQ75l/bRYhfzZcwzRGCy9+zkILE5G/m
   p+kQrVDAnxWFz8B0FGvbSvgIcMhfRhapEimhOEOFW9qmbigNt8tqvRvs2
   ZZ2huPYB9/OrL0DtWhrhDwyI2UYeXAZy46rojsFpOwDft8w46LBYHTBpX
   dHBHEQvFUGOaB68B1GlQxBpaGgHkMtllsETEpV2Z2WgA8l2LYuSYRc3VM
   heGS2kW1cluH1WqzXVZbmP4eZWJjpUpUwaJZcde0H1YYXnU2nPzwxuZjp
   ri7tD0opIC6li3BJKNzKF2K4ESBUKjfBJhLYzsSyoNIIcRHIZiDQN/EkQ
   Q==;
X-CSE-ConnectionGUID: fzAaVxB3Qtea5u1FZvCd4g==
X-CSE-MsgGUID: mz92tVZTSqeFOvOetsQsJg==
X-IronPort-AV: E=McAfee;i="6700,10204,11325"; a="41140395"
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="41140395"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Jan 2025 13:32:17 -0800
X-CSE-ConnectionGUID: K+lvaiEBQ62jJrI6M5VAyw==
X-CSE-MsgGUID: EQ/xM1E5TgmtsnAJBYzFdQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,232,1732608000"; 
   d="scan'208";a="107861083"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa006.jf.intel.com with ESMTP; 24 Jan 2025 13:32:17 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Manoj Vishwanathan <manojvishy@google.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	anjali.singhai@intel.com,
	przemyslaw.kitszel@intel.com,
	sridhar.samudrala@intel.com,
	jacob.e.keller@intel.com,
	pavan.kumar.linga@intel.com,
	vivekmr@google.com,
	brianvv.kernel@gmail.com,
	decot@google.com,
	Brian Vazquez <brianvv@google.com>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 3/8] idpf: Acquire the lock before accessing the xn->salt
Date: Fri, 24 Jan 2025 13:32:05 -0800
Message-ID: <20250124213213.1328775-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
References: <20250124213213.1328775-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Manoj Vishwanathan <manojvishy@google.com>

The transaction salt was being accessed before acquiring the
idpf_vc_xn_lock when idpf has to forward the virtchnl reply.

Fixes: 34c21fa894a1 ("idpf: implement virtchnl transaction manager")
Signed-off-by: Manoj Vishwanathan <manojvishy@google.com>
Signed-off-by: David Decotigny <decot@google.com>
Signed-off-by: Brian Vazquez <brianvv@google.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Pavan Kumar Linga <pavan.kumar.linga@intel.com>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 7639d520b806..99bdb95bf226 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -612,14 +612,15 @@ idpf_vc_xn_forward_reply(struct idpf_adapter *adapter,
 		return -EINVAL;
 	}
 	xn = &adapter->vcxn_mngr->ring[xn_idx];
+	idpf_vc_xn_lock(xn);
 	salt = FIELD_GET(IDPF_VC_XN_SALT_M, msg_info);
 	if (xn->salt != salt) {
 		dev_err_ratelimited(&adapter->pdev->dev, "Transaction salt does not match (%02x != %02x)\n",
 				    xn->salt, salt);
+		idpf_vc_xn_unlock(xn);
 		return -EINVAL;
 	}
 
-	idpf_vc_xn_lock(xn);
 	switch (xn->state) {
 	case IDPF_VC_XN_WAITING:
 		/* success */
-- 
2.47.1


