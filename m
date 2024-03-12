Return-Path: <netdev+bounces-79389-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 187C0878ECE
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 07:24:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 47E6A1C21CC6
	for <lists+netdev@lfdr.de>; Tue, 12 Mar 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FF9836135;
	Tue, 12 Mar 2024 06:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="SblZ1hx5"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3956EB66F
	for <netdev@vger.kernel.org>; Tue, 12 Mar 2024 06:24:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710224652; cv=none; b=Ln2Vtk90/h1y+geaQE89A88T/GWZYZE9yo/Mzz7GQocF/SkNcjuv4paSL9gZvVE9GXnDQOFa7wBH1UWkTLwJNdKUee7a2YZnWEvGJT5McF7nGSADrTTm+/BeBKNICd0Oonu4w4vjnEDR5+mE/xyFXujau23qfBzHpOs2Hpw31cg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710224652; c=relaxed/simple;
	bh=HFmYdtht2S1tq2WRFLbKiPgUuAdBrRBdc/C9kSsUF10=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=TFyf/+O56rCFAxPhcUSHvO2RTgDZxmp3/Dx++wJYn3PuYrh09vwLYkkF9/dyARhuoi8NPkY86GFm53FnWBxrcDrgcaqqV3mzn4pGLslrW+LBywIlQ7dHWH1uZFuyXDw/wuIKVqPXqjaU2idsCFq4B11zfttlW69nty/Hg1YTFXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=SblZ1hx5; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1710224650; x=1741760650;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HFmYdtht2S1tq2WRFLbKiPgUuAdBrRBdc/C9kSsUF10=;
  b=SblZ1hx5+qD8bs/1RHAwwXIoRoeZ85G/CuUyKsCpr3JZ7yQh5IPDh3Uc
   KOscv6bIpE1MA8sJZArrLE8VtdczrGHvtFVOMGUY5iEV06MDf7Q0AwsQZ
   DPCuBFl5Yqaxwj25ySB7Bs+lTidU+CieaE5uWlYuy+cSONwgffWaHW6PO
   ze2KVGyBSy0Gfs/zQxDp/HdXM35qshoGzOzbrS1IZhRX506C57ILdK0AB
   knU509rGEM3pmGhstflXz5K/K0TBwb5tBDsFILR8k3se/Hivk7abkrJ1H
   152bLhENXhfaGVHPqjjQIo9KMje4Z5sPaeip+UR2xSyiM8VyomzaHi6f+
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,11010"; a="4775877"
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="4775877"
Received: from orviesa001.jf.intel.com ([10.64.159.141])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Mar 2024 23:24:09 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,118,1708416000"; 
   d="scan'208";a="48875249"
Received: from unknown (HELO intel-71.bj.intel.com) ([10.238.154.71])
  by orviesa001.jf.intel.com with ESMTP; 11 Mar 2024 23:24:07 -0700
From: Zhu Yanjun <yanjun.zhu@intel.com>
To: jesse.brandeburg@intel.com,
	anthony.l.nguyen@intel.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	intel-wired-lan@lists.osuosl.org,
	netdev@vger.kernel.org
Cc: Zhu Yanjun <yanjun.zhu@linux.dev>
Subject: [PATCH 1/1] idpf: Clean up the vmvf_type for ctlq_recv functions
Date: Tue, 12 Mar 2024 14:15:20 +0800
Message-Id: <20240312061520.4112782-1-yanjun.zhu@intel.com>
X-Mailer: git-send-email 2.27.0
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Yanjun <yanjun.zhu@linux.dev>

In the original source code, add vmvf_type to ctrl_msg for ctlq_recv
functions. These new types will be implemented and used. But currently
these types are not used. So remove them.

Signed-off-by: Zhu Yanjun <yanjun.zhu@linux.dev>
---
 drivers/net/ethernet/intel/idpf/idpf_controlq_api.h | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h b/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
index 8dee098bbfb0..e1b6ee87ad95 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_controlq_api.h
@@ -37,9 +37,6 @@ struct idpf_ctlq_reg {
 /* Generic queue msg structure */
 struct idpf_ctlq_msg {
 	u8 vmvf_type; /* represents the source of the message on recv */
-#define IDPF_VMVF_TYPE_VF 0
-#define IDPF_VMVF_TYPE_VM 1
-#define IDPF_VMVF_TYPE_PF 2
 	u8 host_id;
 	/* 3b field used only when sending a message to CP - to be used in
 	 * combination with target func_id to route the message
-- 
2.39.2


