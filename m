Return-Path: <netdev+bounces-156214-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D6ED3A058EB
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 11:59:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692893A4239
	for <lists+netdev@lfdr.de>; Wed,  8 Jan 2025 10:58:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E4761F75AB;
	Wed,  8 Jan 2025 10:58:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="hOHOVQYZ"
X-Original-To: netdev@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0CA1F63CC
	for <netdev@vger.kernel.org>; Wed,  8 Jan 2025 10:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736333919; cv=none; b=RlZyTAirn1VWoBYUzVKgd+spUs8BpgqucNmRorCuGJ/51wels9J4AHlDr883HS+wGwp24mzHB3itP3DMXw+pE8QEnFB6kRLjbMIEOqs4InYNno8WW5TnEgfFh4mSoJXwe45vVIR1tjb/1t8R9hSLCPJRoJXxRnsZv9pykw/XT9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736333919; c=relaxed/simple;
	bh=JAru+JCMinYwvPV/IOHYvgN8V7XoWvB4jQe0QBv0C0s=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DXi8yYcPbXbHqVHweCmnXRsm/5fEVqa0lJfWbLJjJURaN7T7i3BROeNNgDFcM7eAk2vzpHMYlOyz7aqK5W5ps1zRovsrgz8sM6KgVVF2bvP+RRC1Svkd5o1saAGuAHCLXSh1pbrGwhqpnp6r+8Tn6BZb+PmKuvH7wagjOggGWpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=hOHOVQYZ; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1736333918; x=1767869918;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=JAru+JCMinYwvPV/IOHYvgN8V7XoWvB4jQe0QBv0C0s=;
  b=hOHOVQYZQzQejPj+ZmHepuShH7WxtKjsyWmI4+9cwTlNblrrnhQavlrD
   P5g2k4WZDLhLe4z/ehuOGA/9XNzWozVqW4zXZqv/XMx28poN2kb9wwSg5
   DV8EHOiGve0dNkOu11eVSMJl9xIVrIhv2uYNLgSpO/kGl5hQRCHuisgsi
   VTb1sMlxa+KzR/KO2c170V2Ly5E/4WTDMVJrJXV197EjN8KlOfgIy9ZKS
   9ZHemuayqj1mikJ4IWyiQzXlui+yC/5ama0kemctEcFfADpg22cpOzeI0
   T39AkB//rQJQU7H0ylb6TWBJd5BgqSYsQpPADyPSeIBrqQ8AIJHZrrZ2v
   g==;
X-CSE-ConnectionGUID: rHj/VEm0QfC7VZkciozUEQ==
X-CSE-MsgGUID: z7zRyLbsSvyo4qZeAQobCg==
X-IronPort-AV: E=McAfee;i="6700,10204,11308"; a="47970597"
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="47970597"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 02:58:37 -0800
X-CSE-ConnectionGUID: nm4SBxDATruaz+8W47XtvA==
X-CSE-MsgGUID: Uj7pV1SWSdqWs7QCL2E5Rg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.12,298,1728975600"; 
   d="scan'208";a="133900895"
Received: from choongyo-mobl.gar.corp.intel.com (HELO [10.247.39.73]) ([10.247.39.73])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jan 2025 02:58:33 -0800
Message-ID: <3ddc0625-15ea-4010-a830-21020569d685@linux.intel.com>
Date: Wed, 8 Jan 2025 18:58:28 +0800
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v3 02/18] net: stmmac: move tx_lpi_timer tracking
 to phylib
To: "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc: Andrew Lunn <andrew@lunn.ch>, Heiner Kallweit <hkallweit1@gmail.com>,
 Alexandre Torgue <alexandre.torgue@foss.st.com>,
 Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller"
 <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Jose Abreu <joabreu@synopsys.com>,
 linux-arm-kernel@lists.infradead.org,
 linux-stm32@st-md-mailman.stormreply.com,
 Maxime Coquelin <mcoquelin.stm32@gmail.com>, netdev@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>
References: <Z31V9O8SATRbu2L3@shell.armlinux.org.uk>
 <E1tVCRZ-007Y35-9N@rmk-PC.armlinux.org.uk>
 <66b95153-cb12-494d-851c-093a0006547f@linux.intel.com>
 <Z35WKDhVGMvPIi7d@shell.armlinux.org.uk>
Content-Language: en-US
From: Choong Yong Liang <yong.liang.choong@linux.intel.com>
In-Reply-To: <Z35WKDhVGMvPIi7d@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit



On 8/1/2025 6:40 pm, Russell King (Oracle) wrote:
> Hi,
> 
> On Wed, Jan 08, 2025 at 03:36:57PM +0800, Choong Yong Liang wrote:
>> Tested-by: Choong Yong Liang <yong.liang.choong@linux.intel.com>
> 
> Please let me know if this is for the entire series.
> 
> Thanks.
> 

Yes, the test is for the entire series.

The only issue that was discovered is that during the initial state, the 
"tx_lpi_timer" is not set correctly.
The "tx_lpi_timer" with a value of 0 causes the EEE to be unable to enter 
LPI mode.

