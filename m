Return-Path: <netdev+bounces-81756-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3672A88B5D6
	for <lists+netdev@lfdr.de>; Tue, 26 Mar 2024 01:12:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DD1FDC02154
	for <lists+netdev@lfdr.de>; Mon, 25 Mar 2024 20:07:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9062B487AE;
	Mon, 25 Mar 2024 20:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="BFjQ4LrN"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C424B3FBA0
	for <netdev@vger.kernel.org>; Mon, 25 Mar 2024 20:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711397231; cv=none; b=kSBujNO5Xk8fZiQyQsVQp1uKk/nlAOx4s86fif+Y4APUyD4ng/nDryHWA9se2z5F8J0V2VWkY25Uv2x3x8ta3a5pc4fTmeZbMKzfIDfY79bHImpyxaR0nxKzfE0bZSujeloYrvzG1ECIRR8wa0a03UBUjaOk6mzpyfdmIOO0XzE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711397231; c=relaxed/simple;
	bh=t3EhsLkJdIPIAXe/SCQVAdB8niG5CtMDr0/Jn+yd1hc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tb+hPXc420LCFYaTFcTHbOvNxEkJAcsARkFGX74BXv2hDD36g4A05H1NQoSRSDFHgV4piwqa56yQBRD7rRu9VbFnb6oyK5S5SSCnSZt0MFxcsS8ibI2ppp/u+N5PUDZLcZxhZV5rpAZS5BvCmJ/n2YI6VSAnNZ0b7PUa3bcMJx4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=BFjQ4LrN; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1711397230; x=1742933230;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t3EhsLkJdIPIAXe/SCQVAdB8niG5CtMDr0/Jn+yd1hc=;
  b=BFjQ4LrN1G16FgyXRULLnw6G1g1CxRPMy8Ve2XlGAg8PTMY3hhUChl4s
   ISfc61/C38ZvnhsxYB22/NN5m5/kmFYpue5NwbJcEa96MoNsUtylcfiAw
   8xjNDPABlMDDHRsgfb9g5/rMbq4/IjNRyklQxUt7GKuHmrF6Luf7rDcHH
   Tx5uttsmsjxDQ2ZAoIbD7PfBPj/YxbqnDnA6KhBY9vjypRgNF5gRt2AsY
   EmCKl3eAffiHYaFhe6yIooG2EyS3rIYAT2bl0RXbd8sBhE5D4xRfmA9Br
   Mk2uUJ+SyyFvPRW0d1brPfJ8pKcsT+qHqBcG9Ts5N0dq6mzKQ9Kn4oHjA
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,11024"; a="17855106"
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="17855106"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Mar 2024 13:07:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.07,154,1708416000"; 
   d="scan'208";a="20459299"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 25 Mar 2024 13:07:05 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	anthony.l.nguyen@intel.com,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Michal Kubiak <michal.kubiak@intel.com>,
	Shannon Nelson <shannon.nelson@amd.com>,
	Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
Subject: [PATCH net 3/4] ixgbe: avoid sleeping allocation in ixgbe_ipsec_vf_add_sa()
Date: Mon, 25 Mar 2024 13:06:47 -0700
Message-ID: <20240325200659.993749-4-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
References: <20240325200659.993749-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Przemek Kitszel <przemyslaw.kitszel@intel.com>

Change kzalloc() flags used in ixgbe_ipsec_vf_add_sa() to GFP_ATOMIC, to
avoid sleeping in IRQ context.

Dan Carpenter, with the help of Smatch, has found following issue:
The patch eda0333ac293: "ixgbe: add VF IPsec management" from Aug 13,
2018 (linux-next), leads to the following Smatch static checker
warning: drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c:917 ixgbe_ipsec_vf_add_sa()
	warn: sleeping in IRQ context

The call tree that Smatch is worried about is:
ixgbe_msix_other() <- IRQ handler
-> ixgbe_msg_task()
   -> ixgbe_rcv_msg_from_vf()
      -> ixgbe_ipsec_vf_add_sa()

Fixes: eda0333ac293 ("ixgbe: add VF IPsec management")
Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
Link: https://lore.kernel.org/intel-wired-lan/db31a0b0-4d9f-4e6b-aed8-88266eb5665c@moroto.mountain
Reviewed-by: Michal Kubiak <michal.kubiak@intel.com>
Signed-off-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Reviewed-by: Shannon Nelson <shannon.nelson@amd.com>
Tested-by: Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com> (A Contingent worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
index 13a6fca31004..866024f2b9ee 100644
--- a/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
+++ b/drivers/net/ethernet/intel/ixgbe/ixgbe_ipsec.c
@@ -914,7 +914,13 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		goto err_out;
 	}
 
-	xs = kzalloc(sizeof(*xs), GFP_KERNEL);
+	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
+	if (unlikely(!algo)) {
+		err = -ENOENT;
+		goto err_out;
+	}
+
+	xs = kzalloc(sizeof(*xs), GFP_ATOMIC);
 	if (unlikely(!xs)) {
 		err = -ENOMEM;
 		goto err_out;
@@ -930,14 +936,8 @@ int ixgbe_ipsec_vf_add_sa(struct ixgbe_adapter *adapter, u32 *msgbuf, u32 vf)
 		memcpy(&xs->id.daddr.a4, sam->addr, sizeof(xs->id.daddr.a4));
 	xs->xso.dev = adapter->netdev;
 
-	algo = xfrm_aead_get_byname(aes_gcm_name, IXGBE_IPSEC_AUTH_BITS, 1);
-	if (unlikely(!algo)) {
-		err = -ENOENT;
-		goto err_xs;
-	}
-
 	aead_len = sizeof(*xs->aead) + IXGBE_IPSEC_KEY_BITS / 8;
-	xs->aead = kzalloc(aead_len, GFP_KERNEL);
+	xs->aead = kzalloc(aead_len, GFP_ATOMIC);
 	if (unlikely(!xs->aead)) {
 		err = -ENOMEM;
 		goto err_xs;
-- 
2.41.0


