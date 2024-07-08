Return-Path: <netdev+bounces-109911-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3874D92A41B
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 15:53:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 69B691C21B1A
	for <lists+netdev@lfdr.de>; Mon,  8 Jul 2024 13:53:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7ADF913A3FF;
	Mon,  8 Jul 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RGMP8Tzq"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55B84137923
	for <netdev@vger.kernel.org>; Mon,  8 Jul 2024 13:52:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720446778; cv=none; b=icMr9n1R/tXoBrB5fHMiS82+s1IQ5GfGFNT3Pee0m1NUpWd4Y58c0Z2EMV2Hh8WoWAaTxcEVJatcalP6If3TcmkHO5tTCdnMqK07Q2Z76+HZa+EreTgNbYl5NsgYKO/26K2CFPrwej8sMM/s/HlwQcXcQPIFzFKNoSXDyOloM0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720446778; c=relaxed/simple;
	bh=Y4BaQbuYt8F1sF8Wrtz6aYSuj6Q/I8XFlw9K1Vcdx8g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L2CobNm5ils19xfuT7+bJJw9hcvL22wgTPlKLH/3oiHt7medRBJSz8rJW9KfuNRp9dPVK1c0QboVsA/cPR3TLawdlS7h+XtFvGO3LBYbbq1PQ9Gm4+/jEKlJCHsNHNcDav0w12Mb7NAdp9qLofMkyIqmPtJaKg6lJaSsNhTRjUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RGMP8Tzq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D9C0C116B1;
	Mon,  8 Jul 2024 13:52:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720446777;
	bh=Y4BaQbuYt8F1sF8Wrtz6aYSuj6Q/I8XFlw9K1Vcdx8g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=RGMP8Tzq72Wg3XlfBFCl2MJJMKMhE/11B+fiUX20XruvA4UvO29P8MSKEkFjOTkXL
	 Rv7ZRTVG6TkeA5LpWYiGKp1ao6ujhAvrN/yzaDvRDjUohQvPxLmyNHiplOTWoEuaPL
	 oXSDhrX+umgjlpDaTUj+RQaLJNv9nz6t1Wwaefusx7vp1krk/TQvp5OzTRI2dxyZvf
	 RPtrDupIy7880+ggoWpE6ORxfQu4ShCF/vwQIBjILOVSW6Lyw+yN2WfyhlOu4RwfjY
	 KMmoiVZrEpqA4t7rFnTOA4fekSgGCQwBYLvGx0SZrk7s2EcYc3xp4qWcytVMyw4YNi
	 VR8PzW9ghfR8A==
Date: Mon, 8 Jul 2024 14:52:54 +0100
From: Simon Horman <horms@kernel.org>
To: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
	Stefan Wegrzyn <stefan.wegrzyn@intel.com>,
	Jedrzej Jagielski <jedrzej.jagielski@intel.com>,
	Jan Glaza <jan.glaza@intel.com>
Subject: Re: [PATCH iwl-next v8 3/7] ixgbe: Add link management support for
 E610 device
Message-ID: <20240708135254.GV1481495@kernel.org>
References: <20240704122655.39671-1-piotr.kwapulinski@intel.com>
 <20240704122655.39671-4-piotr.kwapulinski@intel.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240704122655.39671-4-piotr.kwapulinski@intel.com>

On Thu, Jul 04, 2024 at 02:26:51PM +0200, Piotr Kwapulinski wrote:
> Add low level link management support for E610 device. Link management
> operations are handled via the Admin Command Interface. Add the following
> link management operations:
> - get link capabilities
> - set up link
> - get media type
> - get link status, link status events
> - link power management
> 
> Co-developed-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Signed-off-by: Stefan Wegrzyn <stefan.wegrzyn@intel.com>
> Co-developed-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Signed-off-by: Jedrzej Jagielski <jedrzej.jagielski@intel.com>
> Reviewed-by: Jan Glaza <jan.glaza@intel.com>
> Signed-off-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>

Thanks for addressing my review of v7.

Reviewed-by: Simon Horman <horms@kernel.org>

