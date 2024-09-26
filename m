Return-Path: <netdev+bounces-129988-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C4AC29876ED
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 17:51:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 241A7B230FC
	for <lists+netdev@lfdr.de>; Thu, 26 Sep 2024 15:51:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7053515699D;
	Thu, 26 Sep 2024 15:51:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QvQCl6FS"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E96114B086;
	Thu, 26 Sep 2024 15:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727365905; cv=none; b=TFiZc5YcWAh9LjrTALEHMvLV/v/keJaioPI9ZKsxy7nHWWLA/58MEEJ3gBdmxkZxfna2stAyrZj5mwX6AhLMWc9rjj6vMU9rgP0SPFPWkK2eOsSpADziD0kS8puzjEhNFaXznmkcvnUuH7eWWKwIHAYOL2qgxdlU559QJc1QWRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727365905; c=relaxed/simple;
	bh=/zmH17S5Vfm0yDytaFwUjhdEpjDpunAgDGO95mzmn78=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I9mPRNf/zeKy+AB87CUct64stczqnafLyMnHZzeLCNAbaNp2A5bwsqlYEEf33dC7BSfaI4C38QWNuVzvGih6dJIlX2NdXnGsPXk1RoyqrH1rlQn4ff1e4CFasXnMTEnCXgWrJOEw17fSrIQeVpu/9b3Gqun5eXHw7AuzwBHdN/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QvQCl6FS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38176C4CECD;
	Thu, 26 Sep 2024 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727365904;
	bh=/zmH17S5Vfm0yDytaFwUjhdEpjDpunAgDGO95mzmn78=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QvQCl6FSrEpR+YD4IdpGNf5jOLSpCK692o5EO2AREFk5LGAmlfF+8M8Kb14Byd1D7
	 eMKg2sCrIvIBGKVnhfrcXTY6+VGHZEsF3c6SgI7wA3P4af0i6Qxim6Sm2m1Qgmm2IC
	 MpidG1X6ef2cQoViHH5w6OG08jZk1TDAdSQwfA9fL+aq0dMChmFjzzJHygigIjOOPx
	 Z1WG75ndQjbX7QAcXgwv6fEC+T7QYujEr0hfkcP/LuL20QP5AQIW2Wk834EIPUW7eR
	 WamG+oq40/tuDpYkpDnicKs9qlPKM6vMk6mfjqmeGbM2hFxp2i9rBxb8d3k0GHl7gK
	 N0vg7GEl4vBHw==
Date: Thu, 26 Sep 2024 16:51:39 +0100
From: Simon Horman <horms@kernel.org>
To: Dan Carpenter <dan.carpenter@linaro.org>
Cc: Roger Quadros <rogerq@kernel.org>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Julien Panis <jpanis@baylibre.com>,
	Chintan Vankar <c-vankar@ti.com>,
	Alexander Sverdlin <alexander.sverdlin@siemens.com>,
	Grygorii Strashko <grygorii.strashko@ti.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org
Subject: Re: [PATCH net] net: ethernet: ti: am65-cpsw: Fix forever loop in
 cleanup code
Message-ID: <20240926155139.GG4029621@kernel.org>
References: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ae659b4e-a306-48ca-ac3c-110d64af5981@stanley.mountain>

On Thu, Sep 26, 2024 at 12:50:45PM +0300, Dan Carpenter wrote:
> This error handling has a typo.  It should i++ instead of i--.  In the
> original code the error handling will loop until it crashes.
> 
> Fixes: da70d184a8c3 ("net: ethernet: ti: am65-cpsw: Introduce multi queue Rx")
> Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>

Hi Dan,

Unfortunately this patch didn't apply cleanly to net
which throws our CI off. So, unfortunately, I think it needs to
be rebased and reposted (after the 24h grace period).

-- 
pw-bot: changes-requested

