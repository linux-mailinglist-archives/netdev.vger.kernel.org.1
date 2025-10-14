Return-Path: <netdev+bounces-229120-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 96EBDBD856C
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 11:02:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 27E604E9DE6
	for <lists+netdev@lfdr.de>; Tue, 14 Oct 2025 09:02:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93B4827F01E;
	Tue, 14 Oct 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u7jOQ7DP"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62B681F0E29;
	Tue, 14 Oct 2025 09:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760432537; cv=none; b=uSz0FX1Xsu7/iDAjAWA5BsNyrG+uJTdumV2S933uupSbnSIxULq4d1//5z2YmKjbe1NDOcXmVFDbHVaVTK6E08ZPqDOQjVNgruK/PybImTfWv3CQstvoTcrq3+jEvzJB6mVX6vZemeHWa8agKRY2YDedH8wMSwsGrUvgi7487as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760432537; c=relaxed/simple;
	bh=ry8KhHMIfiIYH3yk4s8ADrqwhIKfYKtZkWPKaB0kT1s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uhZlkBLnjG0BBgQMjI/to5yF8McUwfpZ6dRM4mPWfF/qjgqPOtsc8MyoLlJJsEMNM2oxCK7m2Bq16eZVfseoS65nei264Bd2nEiOSll3ZEneBeX7s2ApfCJRiVrz1AJle+0hxvQ/fDmj0GhtTeMWZrSrEYh526F/3f3I3XwgMLA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u7jOQ7DP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A88CC4CEE7;
	Tue, 14 Oct 2025 09:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760432536;
	bh=ry8KhHMIfiIYH3yk4s8ADrqwhIKfYKtZkWPKaB0kT1s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u7jOQ7DPaBIFvEMu0ilKESVAgt2P9lo1qNuRU0MOCVqQlZ17ZsdmKEP6VfqCSNkTB
	 osu48qHDTDVqAHi0XvvF50j+32n8z9EZ3bxzFA4Q2BrOQohdk7YyK1RN7+vPbPSw3s
	 CBCCVcuhpLScxI39lbOgoxOA7aEE8SuHtSfp6aFJKU4iwH6VPI3FoQzkpcCaLg/Qje
	 t+60E9RzshfUk9aKna+Qx+zzgQ5fJ2CaOwCnMmpveuEJRfWSGttmZRCIp1QbqK4iAf
	 /0i5v/xbRZJWbfWDpBuDZlwc6T4wIr0sg3X/xwOjVrrxXf8CkbWsVmL80WxDA056Av
	 v9Qy0AQJUSJIA==
Date: Tue, 14 Oct 2025 10:02:12 +0100
From: Simon Horman <horms@kernel.org>
To: Kory Maincent <kory.maincent@bootlin.com>
Cc: Oleksij Rempel <o.rempel@pengutronix.de>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	kernel@pengutronix.de,
	Dent Project <dentproject@linuxfoundation.org>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next v2 2/3] net: pse-pd: pd692x0: Separate
 configuration parsing from hardware setup
Message-ID: <aO4RlCCL5Nb-az8t@horms.kernel.org>
References: <20251013-feature_pd692x0_reboot_keep_conf-v2-0-68ab082a93dd@bootlin.com>
 <20251013-feature_pd692x0_reboot_keep_conf-v2-2-68ab082a93dd@bootlin.com>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251013-feature_pd692x0_reboot_keep_conf-v2-2-68ab082a93dd@bootlin.com>

On Mon, Oct 13, 2025 at 04:05:32PM +0200, Kory Maincent wrote:
> From: Kory Maincent (Dent Project) <kory.maincent@bootlin.com>
> 
> Cache the port matrix configuration in driver private data to enable
> PSE controller reconfiguration. This refactoring separates device tree
> parsing from hardware configuration application, allowing settings to be
> reapplied without reparsing the device tree.
> 
> This refactoring is a prerequisite for preserving PSE configuration
> across reboots to prevent power disruption to connected devices.
> 
> Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>

Reviewed-by: Simon Horman <horms@kernel.org>


