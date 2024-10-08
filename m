Return-Path: <netdev+bounces-133339-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E6F46995B4C
	for <lists+netdev@lfdr.de>; Wed,  9 Oct 2024 01:01:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B01882834C3
	for <lists+netdev@lfdr.de>; Tue,  8 Oct 2024 23:01:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16ED42185AA;
	Tue,  8 Oct 2024 23:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="I/4qA0oZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EAF2217917
	for <netdev@vger.kernel.org>; Tue,  8 Oct 2024 23:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728428476; cv=none; b=NBO/LNmSReX4HxvrUd2KXA8m4Wh5cuBhe6nmFmMzmAtbB9U954HgMvxSx+p2r0Eo6vrFB1FaVGANQFaTkn1RiQgpSmr5Ye6qwCGozWrgCT3GXYwAv8Q4Psqq8nYnMkRwykFrwuXaCN/toz4ASFUjzDPwrtETqeCo4mKU80asJfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728428476; c=relaxed/simple;
	bh=0xK1D8s3/kwNY+pPqvR9Rv+snPRHt0bdPjaGhzN48zQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N/DHYcbQDvuGyjjKhkTum5mF0MI+5WrhGGnKUQWcVm5PO6NBbtHfOMOmPKO1s8yJYZcJiEQNJUSs5TlXmTnm3okrMmobLZMNuIb06zQ9yz46vIVKtuxyfyTS8igtAsODjjAk979qu24CaWlRELAvLWNXcs/IdqNGk2HnEjDI/pA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=I/4qA0oZ; arc=none smtp.client-ip=192.198.163.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1728428474; x=1759964474;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=0xK1D8s3/kwNY+pPqvR9Rv+snPRHt0bdPjaGhzN48zQ=;
  b=I/4qA0oZPXyoMLfj2KEytNcc4pH+tP3XM2bL85uNvwUS2ORuFTQ4xcX2
   jfkUR/kZTKm6Et6EntqeJG7os/IGH4dxiPm2hKz3nwOGzcXgpjt62abMK
   mYpvh4gQbbIZLF1Dp5XRYVV03RcsM8CVosL+RhVCE3DuPw8QCYLgxR6dE
   uwhviiF9L8OG/+QHLCtQSo8ZX0C1BdCFgG1T7PlJmjtuV8yXYCUQmf4JB
   qjuTMUqp/oLsNiGp08HXIYtuh3V1m0OMp82/FvgrfZrBgawwH3E+2UgOq
   6QUT1ni5kILWU9owwW4RUQchfNXu8ZtVlyNEz8pG3CgSwFgtGTeO8e7jP
   w==;
X-CSE-ConnectionGUID: NH9jf0i7Sam00+3PQ+IRmA==
X-CSE-MsgGUID: FqHsyLzaT3eAp/J8KzHj6Q==
X-IronPort-AV: E=McAfee;i="6700,10204,11219"; a="15302430"
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="15302430"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa110.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 16:01:11 -0700
X-CSE-ConnectionGUID: 983Gs98PSn+elBIm26YCJw==
X-CSE-MsgGUID: VmcsW7CgSvayJNrJ9D33fA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.11,188,1725346800"; 
   d="scan'208";a="106787607"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by fmviesa001.fm.intel.com with ESMTP; 08 Oct 2024 16:01:06 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@google.com,
	netdev@vger.kernel.org
Cc: Vitaly Lifshits <vitaly.lifshits@intel.com>,
	anthony.l.nguyen@intel.com,
	dima.ruinskiy@intel.com,
	Mor Bar-Gabay <morx.bar.gabay@intel.com>
Subject: [PATCH net 7/7] e1000e: change I219 (19) devices to ADP
Date: Tue,  8 Oct 2024 16:00:45 -0700
Message-ID: <20241008230050.928245-8-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.46.0.522.gc50d79eeffbf
In-Reply-To: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
References: <20241008230050.928245-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Vitaly Lifshits <vitaly.lifshits@intel.com>

Sporadic issues, such as PHY access loss, have been observed on I219 (19)
devices. It was found that these devices have hardware more closely
related to ADP than MTP and the issues were caused by taking MTP-specific
flows.

Change the MAC and board types of these devices from MTP to ADP to
correctly reflect the LAN hardware, and flows, of these devices.

Fixes: db2d737d63c5 ("e1000e: Separate MTP board type from ADP")
Signed-off-by: Vitaly Lifshits <vitaly.lifshits@intel.com>
Tested-by: Mor Bar-Gabay <morx.bar.gabay@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/e1000e/hw.h     | 4 ++--
 drivers/net/ethernet/intel/e1000e/netdev.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/e1000e/hw.h b/drivers/net/ethernet/intel/e1000e/hw.h
index 4b6e7536170a..fc8ed38aa095 100644
--- a/drivers/net/ethernet/intel/e1000e/hw.h
+++ b/drivers/net/ethernet/intel/e1000e/hw.h
@@ -108,8 +108,8 @@ struct e1000_hw;
 #define E1000_DEV_ID_PCH_RPL_I219_V22		0x0DC8
 #define E1000_DEV_ID_PCH_MTP_I219_LM18		0x550A
 #define E1000_DEV_ID_PCH_MTP_I219_V18		0x550B
-#define E1000_DEV_ID_PCH_MTP_I219_LM19		0x550C
-#define E1000_DEV_ID_PCH_MTP_I219_V19		0x550D
+#define E1000_DEV_ID_PCH_ADP_I219_LM19		0x550C
+#define E1000_DEV_ID_PCH_ADP_I219_V19		0x550D
 #define E1000_DEV_ID_PCH_LNP_I219_LM20		0x550E
 #define E1000_DEV_ID_PCH_LNP_I219_V20		0x550F
 #define E1000_DEV_ID_PCH_LNP_I219_LM21		0x5510
diff --git a/drivers/net/ethernet/intel/e1000e/netdev.c b/drivers/net/ethernet/intel/e1000e/netdev.c
index f103249b12fa..07e903346358 100644
--- a/drivers/net/ethernet/intel/e1000e/netdev.c
+++ b/drivers/net/ethernet/intel/e1000e/netdev.c
@@ -7899,10 +7899,10 @@ static const struct pci_device_id e1000_pci_tbl[] = {
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V17), board_pch_adp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_LM22), board_pch_adp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_RPL_I219_V22), board_pch_adp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_LM19), board_pch_adp },
+	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_ADP_I219_V19), board_pch_adp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM18), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V18), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_LM19), board_pch_mtp },
-	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_MTP_I219_V19), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM20), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_V20), board_pch_mtp },
 	{ PCI_VDEVICE(INTEL, E1000_DEV_ID_PCH_LNP_I219_LM21), board_pch_mtp },
-- 
2.42.0


