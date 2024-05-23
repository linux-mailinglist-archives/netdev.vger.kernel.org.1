Return-Path: <netdev+bounces-97865-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 676868CD958
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 19:46:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C60AB282119
	for <lists+netdev@lfdr.de>; Thu, 23 May 2024 17:46:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEDAB1BC39;
	Thu, 23 May 2024 17:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XH3sobeJ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D4AA953
	for <netdev@vger.kernel.org>; Thu, 23 May 2024 17:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716486361; cv=none; b=Yk0Wee/JVCXwwDLIKoeqoJz/wmuyhq41Q2wy9e9aF3Lsx7V301fz/iweWoPMlTHBQlVSwO2GzY195IUy1JliP6/9djYi7G2UEBv4vMUTfuFb70TDjHw1hPMeH1yV9YFtP8gAQj6OKG3Q9uE3vDl82q2u7+jedMzHOOCqZBmGyaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716486361; c=relaxed/simple;
	bh=BeE2gFVzSG4StC8kL+So0txKtcyZ5Ah+xHwIKe6ydHI=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=mCvSRzTxmLXUNReWfXct4LoljB0sjdfUNhkFVTtXK8G6/Gv+wDLS6mQl4iXceTPcO7MXSe2VqiY7X16RzGZsnOEY+u+fm3tlLqglAG2maOeZ1vFKPF2SAwNDjD4gfCV8nFpGChYaZpGufPjGD6Lys15ePXADj64DiF34bga+K9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XH3sobeJ; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1716486360; x=1748022360;
  h=from:subject:date:message-id:mime-version:
   content-transfer-encoding:to:cc;
  bh=BeE2gFVzSG4StC8kL+So0txKtcyZ5Ah+xHwIKe6ydHI=;
  b=XH3sobeJOXTUuY7bKi4yX5/Nkh632YPK061TGibodB2RWBxrvcXr6ItB
   Ehsi4+Ae3CSNb79NNXUUofWlKZKn7IA/vkKD83CUMShZ+ZyMAOjZhpGtD
   2P7WfxUsXvt6M7B2YIhrn+UX1Y5RS61ZPP3fadI4tj8JIPW9z2sONozyw
   PQST7VK1tsA8m/6GFGInlQGjJzbqs/X10MUoBwL768jLCq4x4nGBO4JyO
   kJMSG64OjR1e7gxJASaNUaMFxZmPv9dQuKeIy9oRRQzkB1vmAqXBuQSAq
   fLXGlT5OnPxlRPlkl7X+BZktz1iWn9hZGjFZ/oxrh88v10fhuJE3sXHQ/
   g==;
X-CSE-ConnectionGUID: 5hG/LO+QT/mPZfwywt2ntw==
X-CSE-MsgGUID: LKZ9GUp3T4uHzu8/nOwIpQ==
X-IronPort-AV: E=McAfee;i="6600,9927,11081"; a="12675510"
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="12675510"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:46:00 -0700
X-CSE-ConnectionGUID: hxndgXa1QYWtRKDJktnKkw==
X-CSE-MsgGUID: JRvNGXgOR+K90GAbfCP2jw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.08,183,1712646000"; 
   d="scan'208";a="33719177"
Received: from jekeller-desk.amr.corp.intel.com ([10.166.241.1])
  by fmviesa008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 May 2024 10:45:59 -0700
From: Jacob Keller <jacob.e.keller@intel.com>
Subject: [PATCH net 0/2] Intel Wired LAN Driver Updates 2024-05-23 (ice,
 idpf)
Date: Thu, 23 May 2024 10:45:28 -0700
Message-Id: <20240523-net-2024-05-23-intel-net-fixes-v1-0-17a923e0bb5f@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALiAT2YC/x3MUQqAIBAE0KvEfrdgmkVdJfqIXGshLDQikO7e1
 uebGSZDosiUoC8yRLo48R4EVVnAvE5hIWQnBq10raw2GOjED6gsCjmctP2h55sStl1deWNco50
 FOTki/YV8DCAzGJ/nBTocLMF1AAAA
To: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>, 
 David Miller <davem@davemloft.net>
Cc: Jacob Keller <jacob.e.keller@intel.com>, 
 Alexander Lobakin <aleksander.lobakin@intel.com>, 
 Michal Kubiak <michal.kubiak@intel.com>, 
 Wojciech Drewek <wojciech.drewek@intel.com>, 
 Simon Horman <horms@kernel.org>, 
 Krishneil Singh <krishneil.k.singh@intel.com>, 
 Pucha Himasekhar Reddy <himasekharx.reddy.pucha@intel.com>
X-Mailer: b4 0.13.0

This series contains two fixes which finished up testing.

First, Alexander fixes an issue in idpf caused by enabling NAPI and
interrupts prior to actually allocating the Rx buffers.

Second, Jacob fixes the ice driver VSI VLAN counting logic to ensure that
addition and deletion of VLANs properly manages the total VSI count.

Signed-off-by: Jacob Keller <jacob.e.keller@intel.com>
---
Alexander Lobakin (1):
      idpf: don't enable NAPI and interrupts prior to allocating Rx buffers

Jacob Keller (1):
      ice: fix accounting if a VLAN already exists

 drivers/net/ethernet/intel/ice/ice_vsi_vlan_lib.c | 11 ++++++-----
 drivers/net/ethernet/intel/idpf/idpf_lib.c        |  1 +
 drivers/net/ethernet/intel/idpf/idpf_txrx.c       | 12 +++++++-----
 drivers/net/ethernet/intel/idpf/idpf_txrx.h       |  1 +
 4 files changed, 15 insertions(+), 10 deletions(-)
---
base-commit: c71e3a5cffd5309d7f84444df03d5b72600cc417
change-id: 20240523-net-2024-05-23-intel-net-fixes-7941f33d62d5

Best regards,
-- 
Jacob Keller <jacob.e.keller@intel.com>


