Return-Path: <netdev+bounces-143463-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 814439C28A9
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 01:12:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468D628296E
	for <lists+netdev@lfdr.de>; Sat,  9 Nov 2024 00:12:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F01F53D68;
	Sat,  9 Nov 2024 00:12:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="K58wjspK"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18E75367
	for <netdev@vger.kernel.org>; Sat,  9 Nov 2024 00:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731111141; cv=none; b=dvD5tvZVk7qCO2jT/+AIzIkwiVc6nzRhwwzM8JrvM7luB82z4u3Nk/J2RcHYzgOs1D3cBfcOXWbc4CDIxCpKmpU+QZueXE+ZVijgVLFMoLsxAC99TyNK8454bXMrQQh4xwLzpovOchvu3tL9+V5NOdQAg1RHQ2CmIx9CjyFtBYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731111141; c=relaxed/simple;
	bh=98KyeWcoZifTNbYdbHJCzag20uPxI5T6PBTFheZ9in8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AwfbIrFJp3IDWzI8014kh5qjB+iw7FKSQEurN7OKVD3UBNG95Pcp9vDtWS65wWivBD0d+ccd5BQtH8wYIZTdFO71Tr1uf+zEzdaVvcdPns0dukilI5BWcvvIwaN1IxRl30NRuK4DTwwvqqh4qmgif1xiqNc47/vDCgTyh5tH45U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=K58wjspK; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731111140; x=1762647140;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=98KyeWcoZifTNbYdbHJCzag20uPxI5T6PBTFheZ9in8=;
  b=K58wjspKiUOgwvlH6vcy22wvUcYeSD4lrOwWdrAbzX2dLwtkCnb+whan
   d9K4+a838+Ty08gfFnrdFpmMbVp8NG/zOj91dhCsIYr3oglvu5Vz8XJ+W
   NGodq0uqdgqKyOiAU8Ir1A5ESU94LhTLr7jIIO69OiVOzWsTN7Vtclc/F
   NSJXPPI9Y/3oWJ6Iy1Z8FOvuKqtSaeoXXlOA9Vx90Wa3+yUq3Dop+Btq7
   qP3m6Zn4GswxrFYrYk0lyxC1nV1GSY/kFoNx99oXFWhVLM18UD0mBIj0c
   Cvs9Kl/JonfoXiTUVjV0zxqfe1JQDBxT372K4BoInTpvbzuHJGOyBF/8E
   w==;
X-CSE-ConnectionGUID: Frezv7UtRTm1ptR6B0r01w==
X-CSE-MsgGUID: yn8cRv23R9Cah/eI1K44jQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11250"; a="34795121"
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="34795121"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:12:20 -0800
X-CSE-ConnectionGUID: o4AE/ydaTDayxZwki/mftg==
X-CSE-MsgGUID: vOxGXtlWRUaX5lK6nlke/Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,139,1728975600"; 
   d="scan'208";a="90905982"
Received: from dneilan-mobl1.ger.corp.intel.com (HELO azaki-desk1.intel.com) ([10.245.245.163])
  by orviesa004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Nov 2024 16:12:18 -0800
From: Ahmed Zaki <ahmed.zaki@intel.com>
To: intel-wired-lan@lists.osuosl.org
Cc: netdev@vger.kernel.org,
	Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>,
	Ahmed Zaki <ahmed.zaki@intel.com>
Subject: [PATCH iwl-net 2/2] idpf: finish pending IRQ handling before freeing interrupt
Date: Fri,  8 Nov 2024 17:12:06 -0700
Message-ID: <20241109001206.213581-3-ahmed.zaki@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241109001206.213581-1-ahmed.zaki@intel.com>
References: <20241109001206.213581-1-ahmed.zaki@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>

Wait for pending IRQs to be handled before an interrupt is free'd up.

Fixes: d4d558718266 ("idpf: initialize interrupts and enable vport")
Reviewed-by: Ahmed Zaki <ahmed.zaki@intel.com>
Signed-off-by: Sudheer Mogilappagari <sudheer.mogilappagari@intel.com>
Signed-off-by: Ahmed Zaki <ahmed.zaki@intel.com>
---
 drivers/net/ethernet/intel/idpf/idpf_txrx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/ethernet/intel/idpf/idpf_txrx.c b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
index 82e0e3698f10..08acdd383b8d 100644
--- a/drivers/net/ethernet/intel/idpf/idpf_txrx.c
+++ b/drivers/net/ethernet/intel/idpf/idpf_txrx.c
@@ -3584,6 +3584,7 @@ static void idpf_vport_intr_rel_irq(struct idpf_vport *vport)
 
 		/* clear the affinity_mask in the IRQ descriptor */
 		irq_set_affinity_notifier(irq_num, NULL);
+		synchronize_irq(irq_num);
 		kfree(free_irq(irq_num, q_vector));
 	}
 }
-- 
2.43.0


