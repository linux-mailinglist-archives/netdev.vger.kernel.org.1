Return-Path: <netdev+bounces-158542-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7145AA126AD
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 15:59:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E7391684A2
	for <lists+netdev@lfdr.de>; Wed, 15 Jan 2025 14:59:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 609E0136E37;
	Wed, 15 Jan 2025 14:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hsWqHpTr"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE801514F6
	for <netdev@vger.kernel.org>; Wed, 15 Jan 2025 14:59:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736953156; cv=none; b=pz4OctobGEAvUd2JKJ/xxgTvKw8xs64oACDVIOIMlwaYKJz1kJBqNB1J27gc93C9O/obqq6mQOwPquesZTjeXiYwwQ+nckXdFKvke2sgdyPlUszyGUGQfpJUMgX7zWax33hvKmRaiPMJitZBZk54GbZksc/ZnEUDW8rQ2Xy6E8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736953156; c=relaxed/simple;
	bh=Hj6bIC3mtXLykVYNSIKTjD3hXyxWOTzH3f+l3vfESQA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ii0XdY0X0l60LQY0cdPh7jGcPVd/L+dO0daCvghFEuzlHkrwISTOPyNupVWNIi7UzoOOkaS9o44q33zYP29Q4GdjivovJz3L4Cds5+ZTSsgJoLv6+N5ZiRRhc8Pigze0qJFKg54YJeyUxPgTavOmXo4EmRZJ1nWjUhZTD1/oQnE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hsWqHpTr; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736953155; x=1768489155;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Hj6bIC3mtXLykVYNSIKTjD3hXyxWOTzH3f+l3vfESQA=;
  b=hsWqHpTr/tUZ/rKCDO3QoxQH+F9+T7vLMjv1+eK31Pc07s3LP/f2y1jk
   czDWKresCZNmCwy3nmIyFwpknC0t1tEi2T5Zjk9oQAyuzOEa9gnF4Q7R2
   3njYYZWX116ObOEYN2bK8WpmneF3oec7ezBoz2HeYEMc1qZ5ob0Q2dtou
   GR1oGZBwt0N+mMOD2xfJy4+88ppMYKljahPfOHZKX+2BtBi9NrtM51aoB
   ZmVs95gAnVgqz7xcgT37agGwkmSSzrcbwrBhM4ni5y8nwfKyJO/bCIcu2
   pxPLCF8Ek57LdhiZszVssg4lg8jOiADA/PNzQRm0wNVbiLvneaUpe2ji8
   w==;
X-CSE-ConnectionGUID: Ghf7dPk1RbKg5Sl/lqrG1Q==
X-CSE-MsgGUID: hOp8SlyHQfi3lfJMObl/bg==
X-IronPort-AV: E=McAfee;i="6700,10204,11316"; a="37320384"
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="37320384"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Jan 2025 06:59:14 -0800
X-CSE-ConnectionGUID: tDEcJ+pIT/6IFim1fvi2PA==
X-CSE-MsgGUID: s2KFV/+3Q8u8cs4UnkQUQw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,206,1732608000"; 
   d="scan'208";a="104918805"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.119.85])
  by orviesa009.jf.intel.com with ESMTP; 15 Jan 2025 06:59:11 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	yuehaibing@huawei.com,
	przemyslaw.kitszel@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next] ixgbe: Fix possible skb NULL pointer dereference
Date: Wed, 15 Jan 2025 15:59:04 +0100
Message-ID: <20250115145904.7023-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Check both skb NULL pointer dereference and error in ixgbe_put_rx_buffer().

Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20..c682c3d 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2098,14 +2098,14 @@ static struct ixgbe_rx_buffer *ixgbe_get_rx_buffer(struct ixgbe_ring *rx_ring,
 
 static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 				struct ixgbe_rx_buffer *rx_buffer,
-				struct sk_buff *skb,
-				int rx_buffer_pgcnt)
+				struct sk_buff *skb, int rx_buffer_pgcnt,
+				int xdp_res)
 {
 	if (ixgbe_can_reuse_rx_page(rx_buffer, rx_buffer_pgcnt)) {
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && !xdp_res && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
@@ -2415,7 +2415,8 @@ static int ixgbe_clean_rx_irq(struct ixgbe_q_vector *q_vector,
 			break;
 		}
 
-		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt);
+		ixgbe_put_rx_buffer(rx_ring, rx_buffer, skb, rx_buffer_pgcnt,
+				    xdp_res);
 		cleaned_count++;
 
 		/* place incomplete frames back on ring for completion */
-- 
2.43.0


