Return-Path: <netdev+bounces-102202-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91843901DFE
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 11:21:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F2B8B27140
	for <lists+netdev@lfdr.de>; Mon, 10 Jun 2024 09:21:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AD89F745E7;
	Mon, 10 Jun 2024 09:20:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Som7xlVF"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1166F309
	for <netdev@vger.kernel.org>; Mon, 10 Jun 2024 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718011256; cv=none; b=crfHK+BU+iXlnYWLXfn+wt6ieAEV6Rp5Z567zAcdGLdzMTzC9E9KNMQGO5WbrwvKpG4KjYapTU0AIrht+u9UW0/ett/xRjxu7QXuHlyLUDbNiGAizlKmLtxSvV5vn0V+jDiHv8nj+Hnx+YjeAT9XQ3tnA+ryoby+vnue3er3M04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718011256; c=relaxed/simple;
	bh=bDTvNB9fOQLsPNiAhGc0YuMpaJwu7W5qy+IM0gYMbSA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JGuKzf8bD4PVn4Z8JMyle9ey1EeCi3erE/NRSTZ2tNRpbEtoPKLPufRxZKhT0pV6OqCMl6vuyKlRcRIGwMhbRE2H5wJSZmNiNgFx5x+FSykA1E/pIQc7vBFBvEtd3jYo3lFWJjUHXPhcxunCxfTrDebfbLTZQSFy1K68Qtu9Hyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Som7xlVF; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1718011254; x=1749547254;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bDTvNB9fOQLsPNiAhGc0YuMpaJwu7W5qy+IM0gYMbSA=;
  b=Som7xlVFWEbIWQ0SxwsI8XESjGoQ0kzGky+YeiNJU7Afd9NgjSW4L4Dq
   Vf6FJyJcNtbs8LcLvx6wIIB8N6yzHTXyh3MrKysz2pP/TYhRIy2nBfntL
   /yIvTqocFOpwRe7D0N8E0NuVb4pzScgyDxeShzC/L2m3X1Z+CCkF4TbT0
   3QZ/AGMlxbQWwSvcPgO2+vfPjN4VAeSc5fUeobypxM7fjOlhqTJE5Du13
   gZc6+JZgLAjr8DBu71FGnrzgZZ7zSYFg76fTo8agX9E8uY0vBXC+LWO/k
   GGG4uWJQsWKGTxqw03v87LYmvvcW44QD3BZJefJtxuJ2O5BhjqEbB/LTi
   w==;
X-CSE-ConnectionGUID: DjVBfFXhS/aCLOnrOF4kgg==
X-CSE-MsgGUID: AykGBufwQEqQ2ZjVhDOqjg==
X-IronPort-AV: E=McAfee;i="6600,9927,11098"; a="14393359"
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="14393359"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jun 2024 02:20:54 -0700
X-CSE-ConnectionGUID: +S6XmkOvRLiDzAjtbsD9pQ==
X-CSE-MsgGUID: pBEmnid1SZ2X7/dejh3tTA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,227,1712646000"; 
   d="scan'208";a="38835258"
Received: from unknown (HELO amlin-019-225.igk.intel.com) ([10.102.19.225])
  by fmviesa007.fm.intel.com with ESMTP; 10 Jun 2024 02:20:52 -0700
From: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	anthony.l.nguyen@intel.com,
	aleksandr.loktionov@intel.com
Cc: netdev@vger.kernel.org,
	Kelvin Kang <kelvin.kang@intel.com>,
	Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Subject: [PATCH iwl-net] i40e: fix hot issue NVM content is corrupted after nvmupdate
Date: Mon, 10 Jun 2024 11:20:51 +0200
Message-Id: <20240610092051.2030587-1-aleksandr.loktionov@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

After 230f3d53a547 patch all I/O errors are being converted into EAGAIN
which leads to retries until timeout so nvmupdate sometimes fails after
more than 20 minutes!

Remove misleading EIO to EGAIN conversion and pass all errors as is.

Fixes: 230f3d53a547 ("i40e: remove i40e_status")
Co-developed-by: Kelvin Kang <kelvin.kang@intel.com>
Signed-off-by: Kelvin Kang <kelvin.kang@intel.com>
Reviewed-by: Arkadiusz Kubalewski <arkadiusz.kubalewski@intel.com>
Signed-off-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_adminq.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_adminq.h b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
index ee86d2c..55b5bb8 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_adminq.h
+++ b/drivers/net/ethernet/intel/i40e/i40e_adminq.h
@@ -109,10 +109,6 @@ static inline int i40e_aq_rc_to_posix(int aq_ret, int aq_rc)
 		-EFBIG,      /* I40E_AQ_RC_EFBIG */
 	};
 
-	/* aq_rc is invalid if AQ timed out */
-	if (aq_ret == -EIO)
-		return -EAGAIN;
-
 	if (!((u32)aq_rc < (sizeof(aq_to_posix) / sizeof((aq_to_posix)[0]))))
 		return -ERANGE;
 
-- 
2.25.1


