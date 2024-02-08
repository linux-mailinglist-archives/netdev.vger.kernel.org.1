Return-Path: <netdev+bounces-70049-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA16E84D742
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 01:43:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C5A441C228F4
	for <lists+netdev@lfdr.de>; Thu,  8 Feb 2024 00:43:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4A9C10FD;
	Thu,  8 Feb 2024 00:43:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GI+oxt3p"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAC51E86C
	for <netdev@vger.kernel.org>; Thu,  8 Feb 2024 00:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707352981; cv=none; b=TPTgb90sRUcQrGibPwn+oL+MTkhgMGHJIC3yf/2NSY/Qa4+Mlak/jGwNjl6sMnbfiJ9t77F+XM8AuAf2TUPxc/yaUiODNW7ajHuooJJeo1b6AJcIzXBoq7vkEUMDol6LL9S1jU6xMxVBbCVCxX4+rHxabAZ1Wa/joxjwWg0F33s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707352981; c=relaxed/simple;
	bh=jEyCQpqCsP+w6uiCCI1xLzXp4P9t7xwd5YUEwCWLgTs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Tz+as6s3bfsMHd75CchsQsoGIiHvLd8lNQD2YrJ3nmAhLtltDerlS7pwDZAsePtcbrt/CcVuj2R3DL/smom1bQ7G6RTMrEZaVbuL4+F79hOgY81uIzsiTw/rGKLJL0C1A+Szm3kTlYS9NtJo4MzXBw0xJHGhyR4SImqUx/c1Ua8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GI+oxt3p; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1707352979; x=1738888979;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jEyCQpqCsP+w6uiCCI1xLzXp4P9t7xwd5YUEwCWLgTs=;
  b=GI+oxt3pcmNNl3Kt4/eC4/TEgEqZO0p00gDl07mGCwZZ/Bt4TXBY/24h
   9aHEDOsbnHSDvXzJTH47TmqVLTyVVJGKYjAodLtn4Ke9gcEfnadiWPafD
   /3VkRfIm/xcm4f1MyHNFZwBCeP1n8gmSD0mn3WLm/yyHCG51VsjM4QNHw
   31e/y2yFkyktT+INX5iC+CKlC6EZ3JFComrwYTRSjEe3VS5PoWr+U+K5Z
   cJAfGQ9oYv7JNyeSJqKMn+ltK1PNNgrSab1I+Kom8eUBpdIgmfUgdnhIv
   52dmt2obdreAxQO5ntZ8eeCzZy32M6SxCOtUV9FfsMdY3L9BjZGBM7BbM
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="12470117"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="12470117"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Feb 2024 16:42:58 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10977"; a="910168063"
X-IronPort-AV: E=Sophos;i="6.05,252,1701158400"; 
   d="scan'208";a="910168063"
Received: from dev1-atbrady.jf.intel.com ([10.166.241.35])
  by fmsmga002.fm.intel.com with ESMTP; 07 Feb 2024 16:42:58 -0800
From: Alan Brady <alan.brady@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Emil Tantilov <emil.s.tantilov@intel.com>,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alan Brady <alan.brady@intel.com>
Subject: [PATCH 1/1 iwl-net] idpf: disable local BH when scheduling napi for marker packets
Date: Wed,  7 Feb 2024 16:42:43 -0800
Message-ID: <20240208004243.1762223-1-alan.brady@intel.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Emil Tantilov <emil.s.tantilov@intel.com>

Fix softirq's not being handled during napi_schedule() call when
receiving marker packets for queue disable by disabling local bottom
half.

The issue can be seen on ifdown:
NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #08!!!

Using ftrace to catch the failing scenario:
ifconfig   [003] d.... 22739.830624: softirq_raise: vec=3 [action=NET_RX]
<idle>-0   [003] ..s.. 22739.831357: softirq_entry: vec=3 [action=NET_RX]

No interrupt and CPU is idle.

After the patch, with BH locks:
ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_virtchnl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index d0cdd63b3d5b..390977a76de2 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -2087,8 +2087,10 @@ int idpf_send_disable_queues_msg(struct idpf_vport *vport)
 		set_bit(__IDPF_Q_POLL_MODE, vport->txqs[i]->flags);
 
 	/* schedule the napi to receive all the marker packets */
+	local_bh_disable();
 	for (i = 0; i < vport->num_q_vectors; i++)
 		napi_schedule(&vport->q_vectors[i].napi);
+	local_bh_enable();
 
 	return idpf_wait_for_marker_event(vport);
 }
-- 
2.43.0


