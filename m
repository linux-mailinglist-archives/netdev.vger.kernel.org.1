Return-Path: <netdev+bounces-143976-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A01C89C4F5D
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 08:25:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 58E2B1F2164E
	for <lists+netdev@lfdr.de>; Tue, 12 Nov 2024 07:25:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5821E20ADC0;
	Tue, 12 Nov 2024 07:25:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="nJSJJ653"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05A920A5E1;
	Tue, 12 Nov 2024 07:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731396321; cv=none; b=oXXshUPvXfydNaEYYI2WK0KgRuS0UkwnNr8ebyWvDyiCsnetN9T4yVdMAlprdU23Ai4a3q60FJkJ8yur843/+sjJowsIB3e5F9V667g1JyHIjY+jKAQhcJ9wnUdP7QgtC+/w/c0WZWIHNYN5foyiamceTYEMrMiNgVZH1ac2ScE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731396321; c=relaxed/simple;
	bh=xyopsM7BqzZrYVf2ZRi9qIaLHUvjs5NWZpYOarQWMGs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=J4jla+hEbh0ypbk227zJGn6zG93miNOHLT4sjIGPFrmuXvkHK2/v6uGPsIkT37b8e1uyo2+1MC4BhTcWcb6bOTqYRXDidCYmRuwgdpVHSfMYC/ZzIgZ8xrYQLKylwK/aDl6CaqeO82uJ5MkEf8pihGSQzk9BaFPA6RbLDIYmxuY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=nJSJJ653; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1731396319; x=1762932319;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=xyopsM7BqzZrYVf2ZRi9qIaLHUvjs5NWZpYOarQWMGs=;
  b=nJSJJ65360d7ARdUtD1HAbt+VTDi5F6lrhBsJ7wwEn6Tu3PXfh+vA4If
   b+6oiZix0OGtwGh6jZkmq4ZTT/jLfkb0b1G5ZY07FD0L30YGlExX/0l+2
   deYB60HLn8Kxskw+KLhYMKVJ1ecxyd82K3D60BQoB9H3xhVDEqI00DAkI
   xjEgItvLf2aD32HVFqqhtCp2nUbWkgbkt4/J+mnDH+1CiA/UJFlF7+Ze6
   L7X/9dk3LW5CRW21Gev0KTAgptQqrZgPtktmicawhqm17BP8U/x8vPMum
   I8X5u3Y+ecIYtoaxZfWiFlhq6GMxEargPb9ML7mT818YM7d/logdCpJ0q
   w==;
X-CSE-ConnectionGUID: 2d7KKa0xQQ2V1HXXFuBeDQ==
X-CSE-MsgGUID: xpXn7O1wShq6ilrnPXxuAg==
X-IronPort-AV: E=McAfee;i="6700,10204,11222"; a="31387783"
X-IronPort-AV: E=Sophos;i="6.11,199,1725346800"; 
   d="scan'208";a="31387783"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2024 23:25:19 -0800
X-CSE-ConnectionGUID: 5Sp2DgRqThWVvMbHZi+REA==
X-CSE-MsgGUID: RnwHsSYBQVqVEP1H2VdsXQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,147,1728975600"; 
   d="scan'208";a="87074230"
Received: from unknown (HELO YongLiang-Ubuntu20-iLBPG12.png.intel.com) ([10.88.229.33])
  by fmviesa007.fm.intel.com with ESMTP; 11 Nov 2024 23:25:16 -0800
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
To: Andrew Lunn <andrew@lunn.ch>,
	Heiner Kallweit <hkallweit1@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH net v1 0/2] Fix ethtool --show-eee for stmmac
Date: Tue, 12 Nov 2024 15:24:45 +0800
Message-Id: <20241112072447.3238892-1-yong.liang.choong@linux.intel.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This fix ensures that 'ethtool --show-eee' displays the correct
status for stmmac.

Choong Yong Liang (2):
  net: phy: Introduce phy_update_eee() to update eee_cfg values
  net: stmmac: update eee_cfg after mac link up/down

 .../net/ethernet/stmicro/stmmac/stmmac_main.c |  4 ++++
 drivers/net/phy/phy_device.c                  | 24 +++++++++++++++++++
 include/linux/phy.h                           |  2 ++
 3 files changed, 30 insertions(+)

-- 
2.34.1


