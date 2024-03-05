Return-Path: <netdev+bounces-77634-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3A14B872718
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 19:57:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF16A288F60
	for <lists+netdev@lfdr.de>; Tue,  5 Mar 2024 18:57:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA6A91C29B;
	Tue,  5 Mar 2024 18:57:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="NKToP1a2"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0331B597
	for <netdev@vger.kernel.org>; Tue,  5 Mar 2024 18:57:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709665066; cv=none; b=p43PeG4nakgH6eLlhELWy3oGa8LqhR8HUKBKj4fJbVIvhSQBcmKAXQeFMsUtTUONhKBYFVdQHJERzqvs1loAOpTv3JHIcACZ8aIV+wm/SDmbrWc/GPypz8bV8LzVgpTM1PDgvMq9LY+V4SfH9IemyWitorlnEww1u0UeDc99LuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709665066; c=relaxed/simple;
	bh=qCA4EyK+WTr3Lgxt1HDcamE/XI2NPF6F1on+1c0zeRQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SP17PmnFPDaNsgRNU1dqQSzLLuAqTA1VFfu8W+1x2eD5w48b2yIxTknqbNvx8jIdmxWh51jIojeU5ACZm/U8Bm2xNymOqy2P5C4xTDzdWx+bwURmlsfXMxzWkRiXzW0zSWY7lQxKJUw+JElGniAyJavJCPxEM6uqDkEkT+3x4cw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=NKToP1a2; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1709665065; x=1741201065;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qCA4EyK+WTr3Lgxt1HDcamE/XI2NPF6F1on+1c0zeRQ=;
  b=NKToP1a2XiUZwASL7v6TAWsExA5FwspsWFdhyHFFLDKCiftOlV/3fmDf
   IXuTVKA9w9A1weZPq1VKdFE295kysde/X6dxU+va4rU6QEpFZ+ZaSSohL
   jfK7Ea46P/MdvMHPlBnSO/xkaAO/Awp+qxio6MJQUFYY790+h31MwPVzB
   jsmhGbgj6OLX8kplW4gn2FEXqEJj9fFAE+o03byEcX3Z+5+wox44pg2D0
   cqVXZlWgTjrtT4/B5WT4JbnSLADU1eG9hF14Hhs4nplvYx7Cx3WcPQTc6
   sg2NAOCrk5PYO2ETgeyx+ZcOrKm9rvF6O/MMfieZLbfwb0OAu1ViMh0ya
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,11004"; a="4822183"
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="4822183"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Mar 2024 10:57:43 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,206,1705392000"; 
   d="scan'208";a="9337193"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa007.fm.intel.com with ESMTP; 05 Mar 2024 10:57:43 -0800
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Emil Tantilov <emil.s.tantilov@intel.com>,
	anthony.l.nguyen@intel.com,
	willemb@google.com,
	Jesse Brandeburg <jesse.brandeburg@intel.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Alan Brady <alan.brady@intel.com>,
	Simon Horman <horms@kernel.org>,
	Krishneil Singh <krishneil.k.singh@intel.com>
Subject: [PATCH net 1/8] idpf: disable local BH when scheduling napi for marker packets
Date: Tue,  5 Mar 2024 10:57:29 -0800
Message-ID: <20240305185737.3925349-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
References: <20240305185737.3925349-1-anthony.l.nguyen@intel.com>
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

After the patch when disabling local BH before calling napi_schedule:
ifconfig   [003] d.... 22993.928336: softirq_raise: vec=3 [action=NET_RX]
ifconfig   [003] ..s1. 22993.928337: softirq_entry: vec=3 [action=NET_RX]

Fixes: c2d548cad150 ("idpf: add TX splitq napi poll support")
Reviewed-by: Jesse Brandeburg <jesse.brandeburg@intel.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Signed-off-by: Emil Tantilov <emil.s.tantilov@intel.com>
Signed-off-by: Alan Brady <alan.brady@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Krishneil Singh <krishneil.k.singh@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
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
2.41.0


