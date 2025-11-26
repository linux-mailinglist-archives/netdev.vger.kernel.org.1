Return-Path: <netdev+bounces-241966-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1F5C8B1D6
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 18:03:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 08EF63A6283
	for <lists+netdev@lfdr.de>; Wed, 26 Nov 2025 17:02:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82F7433B974;
	Wed, 26 Nov 2025 17:02:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gtcz/UMU"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 824DC28467D
	for <netdev@vger.kernel.org>; Wed, 26 Nov 2025 17:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764176563; cv=none; b=bkYpgE8NJAqnuBdn67b9+JFS6jOOtGjjZf0dU5YI9+8ZXSzByyCMc+t3Y1ldV81sBfJGTyR2r/LBN30ai5ceP2bdP2fPd0Et4JghskF9OCdMckV1PPCLnsibge5FLyZao72npflQbtpMOrKFRvFf5J6rtdh3JvVGYz13qVfq4us=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764176563; c=relaxed/simple;
	bh=EbPZvKqXXrNf0b8dZGogEugflK6zEWvJUPwarJAdyhQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=e/xIgUQmq+pcxGI1Jf0hAvDZz09t9fomaW/Js2W1Z9bOBN08r5omO+novr/jfpUIPyfvHrImTJRyrd8h+lCwc4xi4ncb36Lbe5BdOtNozdzwjxCakKlrAtZKk8NBDilfhEmhv1Kl49vBAt1/pbkB8S0cDJ8jdDX0NKvKc/jL7hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gtcz/UMU; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1764176562; x=1795712562;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=EbPZvKqXXrNf0b8dZGogEugflK6zEWvJUPwarJAdyhQ=;
  b=gtcz/UMUeUQSuc3fFBrLbliqZEiK+dxBAWqnWONpI/TPhccEravThS8K
   rdGH8oTjsFg6Hnd8YPy0F8ocMBldgbvcsGR/OGyyG4Bbcxk8YmygTRYwa
   YtbpMkP/xRIGbB5a9+6V1VbsJpE177JmPjuCWWwDPwPOSzd5hNtn/e6bb
   fxW6OxIGgT/oStQMedS9QHGjzengLc/arCgNwx8MAjd3QC068iK2bfwQ+
   H9SNbLVBz6kaJTLYU7apo8uUA0E8X3898OoXFdR7YlQlSc3irW2rGGtLm
   r55QpFtYGhvJATPFquIuphieRZJZQ03hnLGrwQyJgeY5tpcGZolHQJVrE
   Q==;
X-CSE-ConnectionGUID: FUaGwtVjTcu/T2y7cqD7bQ==
X-CSE-MsgGUID: jsGpaIPMQvKF/OtWyuyuHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="66182459"
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="66182459"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 09:02:41 -0800
X-CSE-ConnectionGUID: Ma5upuRRRvy9s8OUz7r8rQ==
X-CSE-MsgGUID: PfNrhph2QHqVBO7XMhU4AQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,228,1758610800"; 
   d="scan'208";a="198104632"
Received: from aus-labsrv3.an.intel.com ([10.123.116.23])
  by orviesa005.jf.intel.com with ESMTP; 26 Nov 2025 09:02:41 -0800
From: Sreedevi Joshi <sreedevi.joshi@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sreedevi Joshi <sreedevi.joshi@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-next] idpf: update idpf_up_complete() return type to void
Date: Wed, 26 Nov 2025 11:02:16 -0600
Message-Id: <20251126170216.267289-1-sreedevi.joshi@intel.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

idpf_up_complete() function always returns 0 and no callers use this return
value. Although idpf_vport_open() checks the return value, it only handles
error cases which never occur. Change the return type to void to simplify
the code.

Signed-off-by: Sreedevi Joshi <sreedevi.joshi@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_lib.c | 15 ++-------------
 1 file changed, 2 insertions(+), 13 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_lib.c b/drivers/net/ethernet/intel/idpf/idpf_lib.c
index 69eb72ed6b99..b9424cfb13c7 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_lib.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_lib.c
@@ -1444,10 +1444,8 @@ static int idpf_set_real_num_queues(struct idpf_vport *vport)
 /**
  * idpf_up_complete - Complete interface up sequence
  * @vport: virtual port structure
- *
- * Returns 0 on success, negative on failure.
  */
-static int idpf_up_complete(struct idpf_vport *vport)
+static void idpf_up_complete(struct idpf_vport *vport)
 {
 	struct idpf_netdev_priv *np = netdev_priv(vport->netdev);
 
@@ -1457,8 +1455,6 @@ static int idpf_up_complete(struct idpf_vport *vport)
 	}
 
 	set_bit(IDPF_VPORT_UP, np->state);
-
-	return 0;
 }
 
 /**
@@ -1610,20 +1606,13 @@ static int idpf_vport_open(struct idpf_vport *vport, bool rtnl)
 		goto disable_vport;
 	}
 
-	err = idpf_up_complete(vport);
-	if (err) {
-		dev_err(&adapter->pdev->dev, "Failed to complete interface up for vport %u: %d\n",
-			vport->vport_id, err);
-		goto deinit_rss;
-	}
+	idpf_up_complete(vport);
 
 	if (rtnl)
 		rtnl_unlock();
 
 	return 0;
 
-deinit_rss:
-	idpf_deinit_rss(rss_data);
 disable_vport:
 	idpf_send_disable_vport_msg(adapter, vport_id);
 disable_queues:
-- 
2.25.1


