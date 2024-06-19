Return-Path: <netdev+bounces-105031-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2659490F764
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 22:08:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D0EC71F23821
	for <lists+netdev@lfdr.de>; Wed, 19 Jun 2024 20:08:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7480774068;
	Wed, 19 Jun 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="paFRKlCT"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E704A55
	for <netdev@vger.kernel.org>; Wed, 19 Jun 2024 20:08:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718827698; cv=none; b=Jz1Yv+jzaSdEij7XYlExe7ySwCWcvyv1ixyOKYUCv5S8AaPJrL7sn7fhlJ0s6yJpeH5tN6CWp6Awt5+W/Npkiunhg5Kazzb7xJNx8q6zwjoOygnpFwt9Wp7tgi/0xEajyp8dZEblqYHdIQWIKq8JU17xmLH+fbd+8+OsPuJj24I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718827698; c=relaxed/simple;
	bh=5xEtFMCIaQTn7HO7l/DCWngeD1PUOHL9dWkteD82VqY=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hs7JvnDbYzDrndv3oxTEON6Ooq2oYv5Jfqlc2p3EEnZvYpvZSbR1zeCxWDWVWiXd8yAe2kMDplP9OF7BBuKED74HyKQzQaYgb1p5J9uOM0E7cBN4+q/XC+tEKx6erLw+bX1pyCD0g+1jJRI6M5GbK6ngUbkeGlZhiDFAZyYsDuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=paFRKlCT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 001A4C2BBFC;
	Wed, 19 Jun 2024 20:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718827697;
	bh=5xEtFMCIaQTn7HO7l/DCWngeD1PUOHL9dWkteD82VqY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=paFRKlCTUKPgbAQLTtpMleOowvTUfMPqPyYGnYOMSb/UkbLSKd6/eyryTyE+THkSj
	 eSJKMCFWg03S50CL9FWcL5hOQpk826+xuPxip3GE5u1XVsSDPx7UmOoS2NFAiNeGhV
	 9zsnoyXBxZYNOS1NrnGiyfIfZAn0Lg5dV90kKXpAg3WwFUk8PIlmeeZGeJxgIdi3KI
	 eHy1NzK/ZJLeANly/yp9bBhKCVIv47eA1y4F4BlKx5j1gL07n8HOTF5LB/nNyckRYM
	 BhKSD1cqxyE05/lG8N1DpThp2PYDoaU+iTZltu0R0Y09Pc3+BXV6B6tAMNsb1K9SiR
	 Vu1tcNVNXYZ/g==
Date: Wed, 19 Jun 2024 13:08:15 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: <edward.cree@amd.com>
Cc: <linux-net-drivers@amd.com>, <davem@davemloft.com>,
 <edumazet@google.com>, <pabeni@redhat.com>, Edward Cree
 <ecree.xilinx@gmail.com>, <netdev@vger.kernel.org>,
 <habetsm.xilinx@gmail.com>, <sudheer.mogilappagari@intel.com>,
 <jdamato@fastly.com>, <mw@semihalf.com>, <linux@armlinux.org.uk>,
 <sgoutham@marvell.com>, <gakula@marvell.com>, <sbhatta@marvell.com>,
 <hkelam@marvell.com>, <saeedm@nvidia.com>, <leon@kernel.org>,
 <jacob.e.keller@intel.com>, <andrew@lunn.ch>, <ahmed.zaki@intel.com>
Subject: Re: [PATCH v5 net-next 4/7] net: ethtool: let the core choose RSS
 context IDs
Message-ID: <20240619130815.7876d2af@kernel.org>
In-Reply-To: <20240619102435.52b7be88@kernel.org>
References: <cover.1718750586.git.ecree.xilinx@gmail.com>
	<7552f2ab4cf66232baf03d3bc3a47fc1341761f9.1718750587.git.ecree.xilinx@gmail.com>
	<20240619102435.52b7be88@kernel.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 19 Jun 2024 10:24:35 -0700 Jakub Kicinski wrote:
> On Tue, 18 Jun 2024 23:44:24 +0100 edward.cree@amd.com wrote:
> > + * @create_rxfh_context: Create a new RSS context with the specified RX flow
> > + *	hash indirection table, hash key, and hash function.
> > + *	Parameters which are set to %NULL or zero will be populated to
> > + *	appropriate defaults by the driver.  
> 
> The defaults will most likely "inherit" whatever is set in context 0.
> So the driver _may_ init the values according to its preferences
> but they will not be used by the core (specifically not reported to
> user space via ethtool netlink)
> 
> Does that match your thinking?

I was thinking about the key, hfunc and xfrm. Indirection table
needs to get reported.

