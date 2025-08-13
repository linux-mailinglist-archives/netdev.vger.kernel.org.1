Return-Path: <netdev+bounces-213298-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CAE3FB247A5
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 12:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5DA941B65A94
	for <lists+netdev@lfdr.de>; Wed, 13 Aug 2025 10:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3B832F1FDF;
	Wed, 13 Aug 2025 10:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="GmNH//Xx"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BAFD2BE039
	for <netdev@vger.kernel.org>; Wed, 13 Aug 2025 10:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755081960; cv=none; b=dsyFGhMsWsdEeZNy0JLLkNWswl5Cm8AnoObUkGdx5TMf4JjbAexv3Xewq/6Uj1vfsVAQni9w6tfS7kvqy85FBc+XAqfAIzQVbYQPGB3KiSsDpOpEOCxPH1cQ6Vg9saInwtt7c1xFeFF6NrWkhHkA7hRuhdzkYH/WSg8Qo6B/7jU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755081960; c=relaxed/simple;
	bh=gzjTia0MFvA46MJrvE6KGNXiL+mTIZUTKeoYjZs3DZs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h9+KOi5R8jZROXTrF9dif85nnEJmfUnlWR0jY3JxA7vnCMM1oNQNnIP8zzbmop/YYG+yzgO0yOFVslDZGwUn/Wh1nE/e/VxVBUkvBUx8Xkcfz7bkqQkK9PWc+MyPY2EQ8Q3iSKV40qJncrd2lD6yLHJWSw1gn0WvY1LokpFpaYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=GmNH//Xx; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755081959; x=1786617959;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gzjTia0MFvA46MJrvE6KGNXiL+mTIZUTKeoYjZs3DZs=;
  b=GmNH//Xx+V4AElR7Whsg3KNSe5xoparuKJQwZtAn38cOoJTwl2SCyv2Y
   cWFlkeV4G9tH/SB8J+QV//Bb3cRLqoa595PNN06aU6KdCEAB3wCrrnwZq
   yuwCGedNhfN8vaIYi5j8E8H/wshfu9eMLQ6LDtQ7dpHXpGdNcVyDdZtF/
   D6bLV8Q+D9OHsGvbMmTtwZ2PyXTWHr/YYMlhlTwHzyJ/6AFVqhx/rnUyU
   /xS1I3mVXeeTmytdOoWfBWYxsiO/zFiNsAjV1uZcajotH6JRlrNAnlew8
   GXHRykdnBdWVdwhB1eq2rdufbRur1NVOqbq5hNIq0rD2k+cnX3CGnw8fB
   w==;
X-CSE-ConnectionGUID: PgoeiriHSqC5Gudyn518nw==
X-CSE-MsgGUID: 8cyCEI+sTCiMGQU7Q6vKVg==
X-IronPort-AV: E=McAfee;i="6800,10657,11520"; a="44949615"
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="44949615"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2025 03:45:57 -0700
X-CSE-ConnectionGUID: a8uBAcgMTyW7dIYPdBWarw==
X-CSE-MsgGUID: g3V2TMqyTYasW1IdMbRPxg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,285,1747724400"; 
   d="scan'208";a="166066905"
Received: from irvmail002.ir.intel.com ([10.43.11.120])
  by orviesa009.jf.intel.com with ESMTP; 13 Aug 2025 03:45:56 -0700
Received: from pkitszel-desk.tendawifi.com (unknown [10.245.245.219])
	by irvmail002.ir.intel.com (Postfix) with ESMTP id 5F99A28782;
	Wed, 13 Aug 2025 11:45:54 +0100 (IST)
From: Przemek Kitszel <przemyslaw.kitszel@intel.com>
To: intel-wired-lan@lists.osuosl.org,
	Tony Nguyen <anthony.l.nguyen@intel.com>
Cc: netdev@vger.kernel.org,
	Greg KH <gregkh@linuxfoundation.org>,
	jeremiah.kyle@intel.com,
	leszek.pepiak@intel.com,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Lukasz Czapnik <lukasz.czapnik@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH iwl-net 1/8] i40e: add validation for ring_len param
Date: Wed, 13 Aug 2025 12:45:11 +0200
Message-ID: <20250813104552.61027-2-przemyslaw.kitszel@intel.com>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
References: <20250813104552.61027-1-przemyslaw.kitszel@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Lukasz Czapnik <lukasz.czapnik@intel.com>

The `ring_len` parameter provided by the virtual function (VF)
is assigned directly to the hardware memory context (HMC) without
any validation.

To address this, introduce an upper boundary check for both Tx and Rx
queue lengths. The maximum number of descriptors supported by the
hardware is 8k-32.
Additionally, enforce alignment constraints: Tx rings must be a multiple
of 8, and Rx rings must be a multiple of 32.

Fixes: 5c3c48ac6bf5 ("i40e: implement virtual device interface")
Cc: stable@vger.kernel.org
Signed-off-by: Lukasz Czapnik <lukasz.czapnik@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
---
 drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
index 9b8efdeafbcf..cb37b2ac56f1 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_virtchnl_pf.c
@@ -653,6 +653,13 @@ static int i40e_config_vsi_tx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	tx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 8 */
+	if (!IS_ALIGNED(info->ring_len, 8) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_context;
+	}
 	tx_ctx.qlen = info->ring_len;
 	tx_ctx.rdylist = le16_to_cpu(vsi->info.qs_handle[0]);
 	tx_ctx.rdylist_act = 0;
@@ -716,6 +723,13 @@ static int i40e_config_vsi_rx_queue(struct i40e_vf *vf, u16 vsi_id,
 
 	/* only set the required fields */
 	rx_ctx.base = info->dma_ring_addr / 128;
+
+	/* ring_len has to be multiple of 32 */
+	if (!IS_ALIGNED(info->ring_len, 32) ||
+	    info->ring_len > I40E_MAX_NUM_DESCRIPTORS_XL710) {
+		ret = -EINVAL;
+		goto error_param;
+	}
 	rx_ctx.qlen = info->ring_len;
 
 	if (info->splithdr_enabled) {
-- 
2.50.0


