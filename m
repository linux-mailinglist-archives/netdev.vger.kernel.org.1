Return-Path: <netdev+bounces-235238-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7865BC2E19D
	for <lists+netdev@lfdr.de>; Mon, 03 Nov 2025 22:10:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C3B7E1895077
	for <lists+netdev@lfdr.de>; Mon,  3 Nov 2025 21:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD1D2C2366;
	Mon,  3 Nov 2025 21:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="gjOt4Kzy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.20])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2743E2C21E6
	for <netdev@vger.kernel.org>; Mon,  3 Nov 2025 21:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.20
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762204194; cv=none; b=tWMg07PwHNO4xQD6zPYJbZAtmjMylMeyjeHZFfBBUE3N5pgCOzCz+PCsPsUnV6/eXDQ7FfQIQFTxPlyDfdgqeln4TPB3aV4nyWX09YJpn5Blk4EKt63x0oJ8FILP8LY2Vh8RuqHcUADC38xinTTZEcFpOtWWLwoIWNFqKgtq3Ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762204194; c=relaxed/simple;
	bh=nHyUw7CH5fqHOkzGJzjMZOpnhWd4lMtXz+aZjNJ3p9c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Knqq48V/cFD1vuoByKRcs/31ZDAWrOLxfEzd4Eufdmiu3TV+ReEY7a+41qWAJgjRZ6EH70gvhTNiK9vaT7LSb7DY9+FDVq0/2EPd1Yhxe0gxjcz5XfUQVBsA6FUfhyNokJBSTG1ZZ+Da6u3Iyx0UbDOPnqqYE0g/qODlpopeOq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=gjOt4Kzy; arc=none smtp.client-ip=198.175.65.20
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1762204193; x=1793740193;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=nHyUw7CH5fqHOkzGJzjMZOpnhWd4lMtXz+aZjNJ3p9c=;
  b=gjOt4KzyHe2Beyfc7buCr7QM2Y1jezf+6EXWftg+QA0572kMkgdjuZID
   92J2rezN+wwCtaTwCdhFzLvi3gbg/NJaab5QX6zJqdSvz9u+kcUEjEbG/
   OYrWUpUKzOz6dkPSkjMMfTg/VmBZU9MXpJjypYd1eRIIG79Wz83QrzH7o
   M8Bk9qnoZXQF3dMd18zMMQFz1SO1yRM5fQibgXM58vuAiYe07fyDMKeK8
   nFMbnaK8kt3wsStVCi9KPlB8VB5LLzA9dLzdmrMsp83HZg+fIqSbGoQLS
   40amYB/iMKdbFNDl+MdACNaByjHltJYPhb0Vlkz2RaRcFCou2sRLfpZOZ
   g==;
X-CSE-ConnectionGUID: JDeFYkX+TDuxDN8aN6R1tw==
X-CSE-MsgGUID: eno+jUsRRBKx5BI3foh1pQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11602"; a="63987731"
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="63987731"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
  by orvoesa112.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Nov 2025 13:09:52 -0800
X-CSE-ConnectionGUID: +DecENeHQMqgOLLCvjIoHA==
X-CSE-MsgGUID: lAAtYi4yT/mi97Y2uTqotg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.19,277,1754982000"; 
   d="scan'208";a="187121168"
Received: from dcskidmo-m40.jf.intel.com ([10.166.241.14])
  by orviesa008.jf.intel.com with ESMTP; 03 Nov 2025 13:09:53 -0800
From: Joshua Hay <joshua.a.hay@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Joshua Hay <joshua.a.hay@intel.com>,
	Alexander Lobakin <aleksander.lobakin@intel.com>,
	Madhu Chittim <madhu.chittim@intel.com>
Subject: [Intel-wired-lan][PATCH iwl-net] idpf: cap maximum Rx buffer size
Date: Mon,  3 Nov 2025 13:20:36 -0800
Message-Id: <20251103212036.2788093-1-joshua.a.hay@intel.com>
X-Mailer: git-send-email 2.39.2
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW only supports a maximum Rx buffer size of 16K-128. On systems
using large pages, the libeth logic can configure the buffer size to be
larger than this. The upper bound is PAGE_SIZE while the lower bound is
MTU rounded up to the nearest power of 2. For example, ARM systems with
a 64K page size and an mtu of 9000 will set the Rx buffer size to 16K,
which will cause the config Rx queues message to fail.

Initialize the bufq/fill queue buf_len field to the maximum supported
size. This will trigger the libeth logic to cap the maximum Rx buffer
size by reducing the upper bound.

Fixes: 74d1412ac8f37 ("idpf: use libeth Rx buffer management for payload buffer")
Signed-off-by: Joshua Hay <joshua.a.hay@intel.com>
Acked-by: Alexander Lobakin <aleksander.lobakin@intel.com>
Reviewed-by: Madhu Chittim <madhu.chittim@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 8 +++++---
 drivers/net/ethernet/intel/idpf/idpf_txrx.h | 1 +
 2 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 828f7c444d30..dcdd4fef1c7a 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -695,9 +695,10 @@ static int idpf_rx_buf_alloc_singleq(struct idpf_rx_queue *rxq)
 static int idpf_rx_bufs_init_singleq(struct idpf_rx_queue *rxq)
 {
 	struct libeth_fq fq = {
-		.count	= rxq->desc_count,
-		.type	= LIBETH_FQE_MTU,
-		.nid	= idpf_q_vector_to_mem(rxq->q_vector),
+		.count		= rxq->desc_count,
+		.type		= LIBETH_FQE_MTU,
+		.buf_len	= IDPF_RX_MAX_BUF_SZ,
+		.nid		= idpf_q_vector_to_mem(rxq->q_vector),
 	};
 	int ret;
 
@@ -754,6 +755,7 @@ static int idpf_rx_bufs_init(struct idpf_buf_queue *bufq,
 		.truesize	= bufq->truesize,
 		.count		= bufq->desc_count,
 		.type		= type,
+		.buf_len	= IDPF_RX_MAX_BUF_SZ,
 		.hsplit		= idpf_queue_has(HSPLIT_EN, bufq),
 		.xdp		= idpf_xdp_enabled(bufq->q_vector->vport),
 		.nid		= idpf_q_vector_to_mem(bufq->q_vector),
diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.h b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
index 75b977094741..a1255099656f 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.h
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.h
@@ -101,6 +101,7 @@ do {								\
 		idx = 0;					\
 } while (0)
 
+#define IDPF_RX_MAX_BUF_SZ			(16384 - 128)
 #define IDPF_RX_BUF_STRIDE			32
 #define IDPF_RX_BUF_POST_STRIDE			16
 #define IDPF_LOW_WATERMARK			64
-- 
2.39.2


