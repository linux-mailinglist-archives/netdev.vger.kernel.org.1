Return-Path: <netdev+bounces-120635-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA7595A0EC
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 17:07:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 851871F23E4F
	for <lists+netdev@lfdr.de>; Wed, 21 Aug 2024 15:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D21FB1494B1;
	Wed, 21 Aug 2024 15:07:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jzpIPrPy"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3857C13BAFA;
	Wed, 21 Aug 2024 15:07:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724252832; cv=none; b=FMJ/KY056QFVQFAqTPEhsvDOpIK/t5N+N0a90f8/jj/Rne1gN10ZcVxaw9kKIUYrz7U6KbcJO2fH2RwTjpboLROqw2fFahEm8K+e0zBrxmEyDe7swm4wXbEHZsw+cLsKMD+Yr04Uj3hhhwrrtH14NuHtZbG4ZcZG1lnjvYp6jow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724252832; c=relaxed/simple;
	bh=woYhd7Pq2fFt3GpzZxfcv8sw/HeuUSpkUpISS4LUeuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jquKkTDSscY9Cibu7rga37pVoWaeg8AjOFKfb9wx4En43SBh17EzjeWOG3dsMCDzLdWbtoStfdqlzAOQU1b0nN+r4hR6neMPw6OUq7MPBjx2/dgV251Ac2C8nnjIDF6yYNA3iMTBPGS59b6M44m2WK6k3SSdiUpY8NR7nuRt1vE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jzpIPrPy; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1724252831; x=1755788831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=woYhd7Pq2fFt3GpzZxfcv8sw/HeuUSpkUpISS4LUeuE=;
  b=jzpIPrPydprF2A7VQsijcocTcAp1Xe5SNfvXT6uHIw7C9u+fUO6WucNe
   rPzu3BV4mfeZYXW9OV97vPm8fhxXNtfTHbJ5rr+eLGxLiQBK1H/uetIMD
   4CO9VnSfkmRB9AG3sc5u+bfw4FGa8nvzNyj5QXFSxSRwXsikASqIzKfYa
   IzW/phHCD0W7guDqE7SGETIpJs8nuRXVzuaihmVPLMvhsP6auVtIfEB7/
   EY0gNd6rcGbyCcZ89/JoP4XyGPHxvFbwB1WiBJtBumq2irjDf2D7UjWPa
   J8y6qgNDQkZ1cfQAubmdHfm8Lrzym2CLMcXl9G2GQfNYliqP/s9Y4SD4J
   A==;
X-CSE-ConnectionGUID: bK+9ZdVgSHakIbdpIZDN5A==
X-CSE-MsgGUID: hlqNZjlSSPCO8gsN8PvjlQ==
X-IronPort-AV: E=McAfee;i="6700,10204,11171"; a="22769223"
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="22769223"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2024 08:07:11 -0700
X-CSE-ConnectionGUID: oZF0jAC5QSGfXSPm8ypJ4A==
X-CSE-MsgGUID: iexDDM84SMKikD8WRtF5hQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.10,164,1719903600"; 
   d="scan'208";a="84291260"
Received: from newjersey.igk.intel.com ([10.102.20.203])
  by fmviesa002.fm.intel.com with ESMTP; 21 Aug 2024 08:07:08 -0700
From: Alexander Lobakin <aleksander.lobakin@intel.com>
To: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Alexander Lobakin <aleksander.lobakin@intel.com>,
	David Ahern <dsahern@kernel.org>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	nex.sw.ncis.osdt.itp.upstreaming@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v4 2/6] netdev_features: remove unused __UNUSED_NETIF_F_1
Date: Wed, 21 Aug 2024 17:06:56 +0200
Message-ID: <20240821150700.1760518-3-aleksander.lobakin@intel.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
References: <20240821150700.1760518-1-aleksander.lobakin@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

NETIF_F_NO_CSUM was removed in 3.2-rc2 by commit 34324dc2bf27
("net: remove NETIF_F_NO_CSUM feature bit") and became
__UNUSED_NETIF_F_1. It's not used anywhere in the code.
Remove this bit waste.

It wasn't needed to rename the flag instead of removing it as
netdev features are not uAPI/ABI. Ethtool passes their names
and values separately with no fixed positions and the userspace
Ethtool code doesn't have any hardcoded feature names/bits, so
that new Ethtool will work on older kernels and vice versa.

Signed-off-by: Alexander Lobakin <aleksander.lobakin@intel.com>
---
 include/linux/netdev_features.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/linux/netdev_features.h b/include/linux/netdev_features.h
index 7c2d77d75a88..44c428d62db4 100644
--- a/include/linux/netdev_features.h
+++ b/include/linux/netdev_features.h
@@ -14,7 +14,6 @@ typedef u64 netdev_features_t;
 enum {
 	NETIF_F_SG_BIT,			/* Scatter/gather IO. */
 	NETIF_F_IP_CSUM_BIT,		/* Can checksum TCP/UDP over IPv4. */
-	__UNUSED_NETIF_F_1,
 	NETIF_F_HW_CSUM_BIT,		/* Can checksum all the packets. */
 	NETIF_F_IPV6_CSUM_BIT,		/* Can checksum TCP/UDP over IPV6 */
 	NETIF_F_HIGHDMA_BIT,		/* Can DMA to high memory. */
-- 
2.46.0


