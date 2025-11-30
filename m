Return-Path: <netdev+bounces-242816-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C91B5C95143
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B08323A202B
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E17C1222597;
	Sun, 30 Nov 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX/ZypLz"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B33DE18A6B0;
	Sun, 30 Nov 2025 15:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516115; cv=none; b=CENjYtfyo/99tMP0kGI42B3BrkI5OS0rY/NulwdSNxMQC4CaFVL9jKopx8JvSNi80YXnnk6wMPwloKX26TyebLzB5eh3hs7DLnj49uP+3arOpV2kQfLHFVmSEydnzhD+3DjvXKzsWZV5w+RhYf5/GSbRgHnqWFiw6EcoFfMn0BA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516115; c=relaxed/simple;
	bh=aKJe0wPuPNGDikxUgHVHDs0NG3zndJQ2kqVNU7ssVHc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=abz56JIzm37jt9HH6vCNjhyaJ2IuKnDmVlrqt3QJTyolnVklczFmaiBMtcYAVG0o6VYyZww9w7NwKczGNTpQ20UnnB1OOSgiUMzVAPoPJfAi/Whmy2eZZpB1DL2zBJDcbDmskWvXW1sBZrfGmqVLCs0aBBW+Row9DF4lTos63Zg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX/ZypLz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99DFC4CEF8;
	Sun, 30 Nov 2025 15:21:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516115;
	bh=aKJe0wPuPNGDikxUgHVHDs0NG3zndJQ2kqVNU7ssVHc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XX/ZypLzsCSXdQQ/gUb3n4IWnhjUs5ZwIKn+5U2T5Bb8UD6C/bYKaKVuLNULCzx8+
	 mnpIRTZUOWbbYiWNhF7DvavlMT1FSvtsZCEcw9J9X91cs/Nv9irTsa7+px4DB6msX+
	 QF+wcSsbRzrLtntYgHLQc997/pT4iK2KyagKz+w4a+elvnhiOnfpw/Ay0T8oBYm1Xw
	 lVA6DrEZ21o+J8GnEI0E9MkuFKgDUKyGaC/XsO6tGf9JPZC1YKKw+mZdJsSVIv9bFN
	 4t7zsoTPVWg/6FQO2bUHVhiROTWz781Fe8Zd6ePYmYe9K0peHUzm5fXtPEK3zPaG5K
	 BnLI7vTEj3oOA==
Date: Sun, 30 Nov 2025 15:21:50 +0000
From: Simon Horman <horms@kernel.org>
To: Breno Leitao <leitao@debian.org>
Cc: Claudiu Manoil <claudiu.manoil@nxp.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Ioana Ciornei <ioana.ciornei@nxp.com>,
	Vladimir Oltean <vladimir.oltean@nxp.com>,
	Wei Fang <wei.fang@nxp.com>, Clark Wang <xiaoning.wang@nxp.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	imx@lists.linux.dev
Subject: Re: [PATCH net-next 2/3] net: dpaa2: convert to use
 .get_rx_ring_count
Message-ID: <aSxhDoapDk7cOL1i@horms.kernel.org>
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
 <20251128-gxring_freescale-v1-2-22a978abf29e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-gxring_freescale-v1-2-22a978abf29e@debian.org>

On Fri, Nov 28, 2025 at 05:11:46AM -0800, Breno Leitao wrote:
> Convert the dpaa2 driver to use the new .get_rx_ring_count
> ethtool operation instead of implementing .get_rxnfc for handling
> ETHTOOL_GRXRINGS command. This simplifies the code by removing the
> ETHTOOL_GRXRINGS case from the switch statement and replacing it with
> a direct return of the queue count.
> 
> The driver still maintains .get_rxnfc for other commands including
> ETHTOOL_GRXCLSRLCNT, ETHTOOL_GRXCLSRULE, and ETHTOOL_GRXCLSRLALL.
> 
> Signed-off-by: Breno Leitao <leitao@debian.org>

Reviewed-by: Simon Horman <horms@kernel.org>


