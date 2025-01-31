Return-Path: <netdev+bounces-161768-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA08A23D9A
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 13:15:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 496803A9075
	for <lists+netdev@lfdr.de>; Fri, 31 Jan 2025 12:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B8171BD018;
	Fri, 31 Jan 2025 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="g2lbXVb7"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D70B016A956
	for <netdev@vger.kernel.org>; Fri, 31 Jan 2025 12:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738325697; cv=none; b=Ulqtpz381pesOrg8a6BUXn9zi4plnbFv+trzm4mvveU5rbrzElu76Kl5kfIqMm5ytF8G/IuG9D5hpImE5eUy45fsmRwoOGUiJ+bQZjAH1zelxPTDI1JG1Vt4u1HPCoctSrue0LWuUOQ3MOumMbUU/bR53qbc1FVQoN3Iqio3iuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738325697; c=relaxed/simple;
	bh=ectFna4j8mXYtc7xq5aabbYrNLki2dKAI/mLOsusxLw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZyX/V2qB1kldjUpTkz6mR953QSmiNwGOlwjTyJm2ejXjosbB007qzMrAGJ4BfY8Yd5pqJOBsk3Nbdv40yhj9bFTG/z0Xi+XPMAxlMQ7fZH3OvwalR2Mz7HYjM9BTB9Gu1pLEAjV+amD0O7okDgpGiX6CUkCFF7QiOilgukkrtqY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=g2lbXVb7; arc=none smtp.client-ip=198.175.65.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1738325694; x=1769861694;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ectFna4j8mXYtc7xq5aabbYrNLki2dKAI/mLOsusxLw=;
  b=g2lbXVb7mzwig4WRFnuYc9nPPT7TIBp8ixI87XHFDJPqg/OcQYjNlNjq
   LMsmVepsUyUW2voAvDPlJ6eK7mg7lLu1Sa5FnO6i5JV6PjBJn0ucO0/8y
   yfNNVOONFtpO90VZ0bkNarjtMfRPYmHw0mW3bW9pUlgVeXn3lBB5YIlpL
   ZhUZyiU/TzEYXRawbeBSO4nyyMwRDRjywpj98zZQnEDprRMvt6RGn6Bv1
   8dV8g9zKTTgkeNzPKIymqiK/DKbrCCM8aL2n9+1/4oelGqTtTo7uqItVA
   lvI9Hwn4Ywp9C4Hj14l08cncXM7+cDGksW9P7QctZP9KcsHJsVBpewYYC
   A==;
X-CSE-ConnectionGUID: xVBreTusQ++bc4EPOXKuLA==
X-CSE-MsgGUID: 0jo4dw65R2mBxwpfA2UNjQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11332"; a="39032061"
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="39032061"
Received: from fmviesa010.fm.intel.com ([10.60.135.150])
  by orvoesa108.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jan 2025 04:14:54 -0800
X-CSE-ConnectionGUID: btKywjmAQYae50aS/oLvFA==
X-CSE-MsgGUID: +6GzjmJKRzezzRJA42f4+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.13,248,1732608000"; 
   d="scan'208";a="110188597"
Received: from pkwapuli-mobl1.ger.corp.intel.com (HELO vbox-pkwap.ger.corp.intel.com) ([10.245.87.141])
  by fmviesa010.fm.intel.com with ESMTP; 31 Jan 2025 04:14:52 -0800
From: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	dan.carpenter@linaro.org,
	yuehaibing@huawei.com,
	maciej.fijalkowski@intel.com,
	przemyslaw.kitszel@intel.com,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH iwl-next v4] ixgbe: Fix possible skb NULL pointer dereference
Date: Fri, 31 Jan 2025 13:14:50 +0100
Message-ID: <20250131121450.11645-1-piotr.kwapulinski@intel.com>
X-Mailer: git-send-email 2.43.5
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The commit c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in
ixgbe_run_xdp()") stopped utilizing the ERR-like macros for xdp status
encoding. Propagate this logic to the ixgbe_put_rx_buffer().

The commit also relaxed the skb NULL pointer check - caught by Smatch.
Restore this check.

Fixes: c824125cbb18 ("ixgbe: Fix passing 0 to ERR_PTR in ixgbe_run_xdp()")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Acked-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
---
v1 -> v2
  Provide extra details in commit message for motivation of this patch
v2 -> v3
  Simplify the check condition
v3 -> v4
  Rebase to net-queue
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
index 7236f20..467f812 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_main.c
@@ -2105,7 +2105,7 @@ static void ixgbe_put_rx_buffer(struct ixgbe_ring *rx_ring,
 		/* hand second half of page back to the ring */
 		ixgbe_reuse_rx_page(rx_ring, rx_buffer);
 	} else {
-		if (!IS_ERR(skb) && IXGBE_CB(skb)->dma == rx_buffer->dma) {
+		if (skb && IXGBE_CB(skb)->dma == rx_buffer->dma) {
 			/* the page has been released from the ring */
 			IXGBE_CB(skb)->page_released = true;
 		} else {
-- 
2.43.0


