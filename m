Return-Path: <netdev+bounces-95517-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 292B88C27CB
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 17:29:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77985B259BF
	for <lists+netdev@lfdr.de>; Fri, 10 May 2024 15:29:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 521D0176FD3;
	Fri, 10 May 2024 15:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nxlYdGVu"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F28BD1779A9;
	Fri, 10 May 2024 15:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715354884; cv=none; b=FLDV51WlRJtrLfMXy01XDMQAj064zte2wZSz09uO4ApI/2YthmOp1XT+wB2T1cXDmQEpaGnMXFA0kmo4pOHyz43eWRtrDpb4pCZnp2zDH51+Gg+cHnjjZVb36Ob9v1+UpDUFqz5OJTp9LfxDYO7zrqj+6w3dzE8GLSYa0SiWiLI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715354884; c=relaxed/simple;
	bh=Yn7lGldHXX5OMvMMtk0QpXcGdcB3Y+0iq/q74WMS+28=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PVYPCvagLYNwc2cF7aN9kKMtXGkUjcCCzRc1q0hdVCa2ozoRuaC7RQ0ZS+uN7HRMrZgnBNtxHVwHlrPDpK3lyo93N+/407ers5VF+lijyfzDvvYiSmb0zSaV81zJnyoJ/+yKzvSKSWyWQgQeynsFFd4pYMfMLk4iJCZUScBIOZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nxlYdGVu; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1715354870; x=1746890870;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Yn7lGldHXX5OMvMMtk0QpXcGdcB3Y+0iq/q74WMS+28=;
  b=nxlYdGVuWJq2VVVaT0fwwzfxmpIa5XcGfksLctxBlPNKSOHYA2Qw7J/9
   jG+WrK45F6DcqySibgcasPmsBYRPvYDi7AdhbgF/YdaRc4YPrKYt+I+XD
   V/dc67hFQ3pq8XRHQTe81AznbkweKg7ejbPz7Jg3bKicsAcsFCTgqciUq
   fBnDGme6f4BGDqsxBb4B3uuLYYes1qfFhojAPCuTFYK+rIV17G5S6xen5
   q1p6oypDzTTH7TIVUZSeKpl/w6c0cEpSrrnlhUILyEZQfOwzZVObAE0Ln
   hVAXoa8eWOMtXNjeY28EllNytENEaBL5jwiowp9Z6PPuC62UASxTvAlHI
   w==;
X-CSE-ConnectionGUID: LwzuHNPzTQuOjBaht870DQ==
X-CSE-MsgGUID: gkW6RCDMTuqyyX+7w8v4Bw==
X-IronPort-AV: E=McAfee;i="6600,9927,11068"; a="15152627"
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="15152627"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 May 2024 08:27:41 -0700
X-CSE-ConnectionGUID: qYimk+drTNisAs3/kNNFPg==
X-CSE-MsgGUID: nHt+izmCS16DdI97daUsKw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,151,1712646000"; 
   d="scan'208";a="30208277"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by orviesa008.jf.intel.com with ESMTP; 10 May 2024 08:27:38 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH RFC iwl-next 07/12] idpf: compile singleq code only under default-n CONFIG_IDPF_SINGLEQ
Date: Fri, 10 May 2024 17:26:15 +0200
Message-ID: <20240510152620.2227312-8-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
References: <20240510152620.2227312-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, there's no HW supporting idpf in the singleq model. Still,
this dead code is supported by the driver and often times add hotpath
branches and redundant cacheline accesses.
While it can't currently be removed, add CONFIG_IDPF_SINGLEQ and build
the singleq code only when it's enabled manually. This corresponds to
-10 Kb of object code size and a good bunch of hotpath checks.
idpf_is_queue_model_split() works as a gate and compiles out to `true`
when the config option is disabled.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 drivers/net/ethernet/intel/Kconfig            | 13 +---------
 drivers/net/ethernet/intel/idpf/Kconfig       | 26 +++++++++++++++++++
 drivers/net/ethernet/intel/idpf/Makefile      |  3 ++-
 drivers/net/ethernet/intel/idpf/idpf.h        |  3 ++-
 drivers/net/ethernet/intel/idpf/idpf_txrx.c   |  2 +-
 .../net/ethernet/intel/idpf/idpf_virtchnl.c   | 15 ++++++++---
 6 files changed, 43 insertions(+), 19 deletions(-)
 create mode 100644 drivers/net/ethernet/intel/idpf/Kconfig

diff --git a/drivers/net/ethernet/intel/Kconfig b/drivers/net/ethernet/intel/Kconfig
index e0287fbd501d..0375c7448a57 100644
--- a/drivers/net/ethernet/intel/Kconfig
+++ b/drivers/net/ethernet/intel/Kconfig
@@ -384,17 +384,6 @@ config IGC_LEDS
 	  Optional support for controlling the NIC LED's with the netdev
 	  LED trigger.
 
-config IDPF
-	tristate "Intel(R) Infrastructure Data Path Function Support"
-	depends on PCI_MSI
-	select DIMLIB
-	select PAGE_POOL
-	select PAGE_POOL_STATS
-	help
-	  This driver supports Intel(R) Infrastructure Data Path Function
-	  devices.
-
-	  To compile this driver as a module, choose M here. The module
-	  will be called idpf.
+source "drivers/net/ethernet/intel/idpf/Kconfig"
 
 endif # NET_VENDOR_INTEL
diff --git a/drivers/net/ethernet/intel/idpf/Kconfig b/drivers/net/ethernet/intel/idpf/Kconfig
new file mode 100644
index 000000000000..bee83a40f218
--- /dev/null
+++ b/drivers/net/ethernet/intel/idpf/Kconfig
@@ -0,0 +1,26 @@
+# SPDX-License-Identifier: GPL-2.0-only
+# Copyright (C) 2024 Intel Corporation
+
+config IDPF
+	tristate "Intel(R) Infrastructure Data Path Function Support"
+	depends on PCI_MSI
+	select DIMLIB
+	select PAGE_POOL
+	select PAGE_POOL_STATS
+	help
+	  This driver supports Intel(R) Infrastructure Data Path Function
+	  devices.
+
+	  To compile this driver as a module, choose M here. The module
+	  will be called idpf.
+
+if IDPF
+
+config IDPF_SINGLEQ
+	bool "idpf singleq support"
+	help
+	  This option enables support for legacy single Rx/Tx queues w/no
+	  completion and fill queues. Only enable if you have such hardware
+	  as it increases the driver size and adds runtme checks on hotpath.
+
+endif # IDPF
diff --git a/drivers/net/ethernet/intel/idpf/Makefile b/drivers/net/ethernet/intel/idpf/Makefile
index 6844ead2f3ac..2ce01a0b5898 100644
--- a/drivers/net/ethernet/intel/idpf/Makefile
+++ b/drivers/net/ethernet/intel/idpf/Makefile
@@ -12,7 +12,8 @@ idpf-y := \
 	idpf_ethtool.o		\
 	idpf_lib.o		\
 	idpf_main.o		\
-	idpf_singleq_txrx.o	\
 	idpf_txrx.o		\
 	idpf_virtchnl.o 	\
 	idpf_vf_dev.o
+
+idpf-$(CONFIG_IDPF_SINGLEQ)	+= idpf_singleq_txrx.o
diff --git a/drivers/net/ethernet/intel/idpf/idpf.h b/drivers/net/ethernet/intel/idpf/idpf.h
index f9e43d171f17..5d9529f5b41b 100644
--- a/drivers/net/ethernet/intel/idpf/idpf.h
+++ b/drivers/net/ethernet/intel/idpf/idpf.h
@@ -599,7 +599,8 @@ struct idpf_adapter {
  */
 static inline int idpf_is_queue_model_split(u16 q_model)
 {
-	return q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
+	return !IS_ENABLED(CONFIG_IDPF_SINGLEQ) ||
+	       q_model == VIRTCHNL2_QUEUE_MODEL_SPLIT;
 }
 
 #define idpf_is_cap_ena(adapter, field, flag) \
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 4aa5ee781bd7..2bc1a5a0b50f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -1306,7 +1306,7 @@ static void idpf_vport_calc_numq_per_grp(struct idpf_vport *vport,
 static void idpf_rxq_set_descids(const struct idpf_vport *vport,
 				 struct idpf_rx_queue *q)
 {
-	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
+	if (idpf_is_queue_model_split(vport->rxq_model)) {
 		q->rxdids = VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M;
 	} else {
 		if (vport->base_rxd)
diff --git a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
index 44602b87cd41..d1705fcb701a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_virtchnl.c
@@ -1256,12 +1256,12 @@ int idpf_send_create_vport_msg(struct idpf_adapter *adapter,
 	vport_msg->vport_type = cpu_to_le16(VIRTCHNL2_VPORT_TYPE_DEFAULT);
 	vport_msg->vport_index = cpu_to_le16(idx);
 
-	if (adapter->req_tx_splitq)
+	if (adapter->req_tx_splitq || !IS_ENABLED(CONFIG_IDPF_SINGLEQ))
 		vport_msg->txq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SPLIT);
 	else
 		vport_msg->txq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SINGLE);
 
-	if (adapter->req_rx_splitq)
+	if (adapter->req_rx_splitq || !IS_ENABLED(CONFIG_IDPF_SINGLEQ))
 		vport_msg->rxq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SPLIT);
 	else
 		vport_msg->rxq_model = cpu_to_le16(VIRTCHNL2_QUEUE_MODEL_SINGLE);
@@ -1323,10 +1323,17 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
 
 	vport_msg = adapter->vport_params_recvd[vport->idx];
 
+	if (!IS_ENABLED(CONFIG_IDPF_SINGLEQ) &&
+	    (vport_msg->rxq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE ||
+	     vport_msg->txq_model == VIRTCHNL2_QUEUE_MODEL_SINGLE)) {
+		dev_err(&adapter->pdev->dev, "singleq mode requested, but not compiled-in\n");
+		return -EOPNOTSUPP;
+	}
+
 	rx_desc_ids = le64_to_cpu(vport_msg->rx_desc_ids);
 	tx_desc_ids = le64_to_cpu(vport_msg->tx_desc_ids);
 
-	if (vport->rxq_model == VIRTCHNL2_QUEUE_MODEL_SPLIT) {
+	if (idpf_is_queue_model_split(vport->rxq_model)) {
 		if (!(rx_desc_ids & VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M)) {
 			dev_info(&adapter->pdev->dev, "Minimum RX descriptor support not provided, using the default\n");
 			vport_msg->rx_desc_ids = cpu_to_le64(VIRTCHNL2_RXDID_2_FLEX_SPLITQ_M);
@@ -1336,7 +1343,7 @@ int idpf_check_supported_desc_ids(struct idpf_vport *vport)
 			vport->base_rxd = true;
 	}
 
-	if (vport->txq_model != VIRTCHNL2_QUEUE_MODEL_SPLIT)
+	if (!idpf_is_queue_model_split(vport->txq_model))
 		return 0;
 
 	if ((tx_desc_ids & MIN_SUPPORT_TXDID) != MIN_SUPPORT_TXDID) {
-- 
2.45.0


