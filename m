Return-Path: <netdev+bounces-74022-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3295285FA5A
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 14:53:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E0F4E289F12
	for <lists+netdev@lfdr.de>; Thu, 22 Feb 2024 13:53:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80713148FFA;
	Thu, 22 Feb 2024 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="jicDaKEl"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.9])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C52E1487E6
	for <netdev@vger.kernel.org>; Thu, 22 Feb 2024 13:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.9
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708609952; cv=none; b=pMmylsjXSUgjGw/kEokRDBuxRdFYIxuDqsyIqr1U8rtVBXIDn8HTZ81kQR2G49VRPMq3+kV8ybP5XayGytorGF/a7kVFO5Ixq58/nS7mH+/J3SgSVjNe6t0eP2bJOFomL2BkoTRmKOuX0S6u+DtQpSKuKeCIiqS01O+AmSX2EpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708609952; c=relaxed/simple;
	bh=okDN9skIyTEGp8a+Kir+3FckEcXNTLEnbwIFZOEO+K0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=BYlzqoFfS1u+5iKR1uTXgGQ3rn2Zt2uFykaPvfol50OSKO+Uq9XpT7/SNQqKBlmg8GLa5nHqXEwaOsw6DV6/HqrDsQKfTpCK5igjawuldvQ3fxc5OvNOzvrS9DRuvOPshOTBSGmXrx8D7wq6/ySu1GaIu+L5CvXb791f3OGg/3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=jicDaKEl; arc=none smtp.client-ip=192.198.163.9
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1708609950; x=1740145950;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=okDN9skIyTEGp8a+Kir+3FckEcXNTLEnbwIFZOEO+K0=;
  b=jicDaKElSz4wkahVxzvIHhhTLMOVgemdzKTV04p7koryuyGUJVNG5Dhd
   smKclRlQkURNjdn9fJAuMd4GVVU/qhzxn68ZtqUcpUAZFZNTd6z8L1Ccg
   FEwkWRhyNiLaDRd5yb4H0Cjkurod6Luz+FVLRAy42kCKLdFlJAejNFx1G
   VGmRaN6MzlRXmUYR20OixUat896kLMdDZELpMHuDRli1uzXBEF7HENf5a
   PBkQTtvovqvVRtOazSG6Eh3C3VDtWwp1IVgnPzlo5MbQDFgpyKOUoCrES
   4qV/JWA8gygdTngSxJ3D3ELUR0W07vDOlx1zQTv8HC2t8CDH5Zei9xey/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10991"; a="13534156"
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="13534156"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Feb 2024 05:52:30 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.06,177,1705392000"; 
   d="scan'208";a="36331628"
Received: from pglc0455.png.intel.com ([10.221.89.106])
  by orviesa002.jf.intel.com with ESMTP; 22 Feb 2024 05:52:26 -0800
From: Rohan G Thomas <rohan.g.thomas@intel.com>
To: kurt@linutronix.de
Cc: alexandre.torgue@foss.st.com,
	andriy.shevchenko@linux.intel.com,
	bigeasy@linutronix.de,
	davem@davemloft.net,
	edumazet@google.com,
	joabreu@synopsys.com,
	kuba@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-stm32@st-md-mailman.stormreply.com,
	mcoquelin.stm32@gmail.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	rohan.g.thomas@intel.com
Subject: [PATCH net] net: stmmac: Fix EST offset for dwmac 5.10
Date: Thu, 22 Feb 2024 21:52:22 +0800
Message-Id: <20240222135222.7332-1-rohan.g.thomas@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>
References: <20240220-stmmac_est-v1-1-c41f9ae2e7b7@linutronix.de>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Kurt,

On Tue, Feb 20, 2024 at 09:22:46AM +0100, Kurt Kanzenbach wrote:
> Fix EST offset for dwmac 5.10.
> 
> Currently configuring Qbv doesn't work as expected. The schedule is
> configured, but never confirmed:
> 
> |[  128.250219] imx-dwmac 428a0000.ethernet eth1: configured EST
> 
> The reason seems to be the refactoring of the EST code which set the wrong
> EST offset for the dwmac 5.10. After fixing this it works as before:
> 
> |[  106.359577] imx-dwmac 428a0000.ethernet eth1: configured EST [
> |128.430715] imx-dwmac 428a0000.ethernet eth1: EST: SWOL has been
> |switched
> 
> Tested on imx93.
> 
> Fixes: c3f3b97238f6 ("net: stmmac: Refactor EST implementation")
> Signed-off-by: Kurt Kanzenbach <kurt@linutronix.de>
> ---

Thanks for fixing this. Sorry for the typo.

Best Regards,
Rohan


