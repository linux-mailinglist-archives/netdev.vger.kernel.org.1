Return-Path: <netdev+bounces-240370-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id F3C6FC73E5D
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 13:10:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id BB15F356AAD
	for <lists+netdev@lfdr.de>; Thu, 20 Nov 2025 12:09:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 476CF33122F;
	Thu, 20 Nov 2025 12:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="G9O3Ie07"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8540420459A
	for <netdev@vger.kernel.org>; Thu, 20 Nov 2025 12:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763640543; cv=none; b=NDxW1EoJIWZrgJ8phV0rm7HOnUZ6PKH9i1fjyRszFoPtNypLeZ0ec/XNcYch8Dtc3bAWvxmRlJ2SXg73pDSKkunbXVeIcOU74MQxDDcJ/fqDCYNPEU1kGs5dtRSro5Vn/RSzJv9gK8iZpQcxhopbVzNsrnz0KHtga8tzCsLxNlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763640543; c=relaxed/simple;
	bh=ngJsEfYjg8B/DGcvuWFHXohdm36j18EsWZbz8HmumaY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qN9Ab5U4rn3kgL+wg1h5igUCFI/HXh8Vf6vWEovmClF6OmrKTSa4v7qbg+XfXsEPEeWY9nIdqy6jsnL2C75PLR7Yh0JJCuiPL+Gdvxc2LvqCjPRdWUK2tYwCHQBO5nUIje72+PJeQxP3sNECkPqVTYwzYkogVHPkLR+ipKDWZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=G9O3Ie07; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1763640541; x=1795176541;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ngJsEfYjg8B/DGcvuWFHXohdm36j18EsWZbz8HmumaY=;
  b=G9O3Ie07bTaeuGodo8AKBDnmbpRC331kDW8X46yBgaYEk0ZMfb9JOaG1
   eEV3tq5uown/1MeaWH+MoqWnkY0NXDkQsR4CrQeXBNA7ET9aoHb8g1Zo1
   4mEAnbftCoPtNP0wvy3Jq1D9WVD/IVWpouqTcj37YBfNhAMNCjyADEq4a
   lFpOmahhSyL0/rbe4n19nuM1Sl2TJ4noYHDs0dUM2ETjMp+8CBgd6E8mq
   39pFh3vmeniiZYI85nD29yk7BtG3Iz8ocfX+ln1lBiJc4shLKUggFx9d/
   IQvX8bWg2ci85ncUIE/+geWmrkn4W59WCsQIPgv5fojXlg/P0R39r5VxC
   g==;
X-CSE-ConnectionGUID: sOsGZUi6TpmMHd4E2i6m9g==
X-CSE-MsgGUID: T5cmG3IMQAKr3j5i0W/vjQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11618"; a="65599812"
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="65599812"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2025 04:08:58 -0800
X-CSE-ConnectionGUID: GgQhKsAqQJyAfeJ8AKhLMQ==
X-CSE-MsgGUID: FP8kXtrLQdW+Eo5llxQphg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.20,213,1758610800"; 
   d="scan'208";a="195485157"
Received: from pae-d-dell-r7525-263.igk.intel.com ([172.28.191.240])
  by orviesa003.jf.intel.com with ESMTP; 20 Nov 2025 04:08:55 -0800
From: "Korba, Przemyslaw" <przemyslaw.korba@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	"Korba, Przemyslaw" <przemyslaw.korba@intel.com>,
	Grzegorz Nitka <grzegorz.nitka@intel.com>,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net] i40e: fix scheduling in set_rx_mode
Date: Thu, 20 Nov 2025 13:07:28 +0100
Message-ID: <20251120120750.400715-2-przemyslaw.korba@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add service task schedule to set_rx_mode.
In some cases there are error messages printed out in PTP application
(ptp4l):

ptp4l[13848.762]: port 1 (ens2f3np3): received SYNC without timestamp
ptp4l[13848.825]: port 1 (ens2f3np3): received SYNC without timestamp
ptp4l[13848.887]: port 1 (ens2f3np3): received SYNC without timestamp

This happens when service task would not run immediately after
set_rx_mode, and we need it for setup tasks. This service task checks, if
PTP RX packets are hung in firmware, and propagate correct settings such
as multicast address for IEEE 1588 Precision Time Protocol.
RX timestamping depends on some of these filters set. Bug happens only
with high PTP packets frequency incoming, and not every run since
sometimes service task is being ran from a different place immediately
after starting ptp4l.

Fixes: 0e4425ed641f ("i40e: fix: do not sleep in netdev_ops")
Reviewed-by: Grzegorz Nitka <grzegorz.nitka@intel.com>
Reviewed-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemyslaw Korba <przemyslaw.korba@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_main.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_main.c b/drivers/net/ethernet/intel/i40e/i40e_main.c
index f3b1b70d824f..a1b600ab0397 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_main.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_main.c
@@ -2234,6 +2234,7 @@ static void i40e_set_rx_mode(struct net_device *netdev)
 		vsi->flags |= I40E_VSI_FLAG_FILTER_CHANGED;
 		set_bit(__I40E_MACVLAN_SYNC_PENDING, vsi->back->state);
 	}
+	i40e_service_event_schedule(vsi->back);
 }
 
 /**

base-commit: be983dcd591c53cb76f92448afc61f91fd7c5fe7
-- 
2.43.0


