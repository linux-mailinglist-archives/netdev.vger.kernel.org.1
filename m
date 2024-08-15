Return-Path: <netdev+bounces-118882-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D523A95367F
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 17:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 17B211C24F91
	for <lists+netdev@lfdr.de>; Thu, 15 Aug 2024 15:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A759E1A01BB;
	Thu, 15 Aug 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BoHC+pD6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F75819DF9C;
	Thu, 15 Aug 2024 15:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723734143; cv=none; b=ojrdm9QVtsaa821I5wI1x0bGsNCFKAtpjFfG1I3WvsCGcDKXSWdUhwhElqD1gmiDZw/TVrdHdrH0I4GoaRb+2eaR6xviporDE0V80BbVtIvQ53K2zYJ1TD9P4hfZgzgEk40vRidmIIWReSIiEKlbhFbSrkce5B7UknTItAiVI74=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723734143; c=relaxed/simple;
	bh=rRi+6EmOs7+pVG1EHAvt51XP2hQn0UWhMGz5gSVJY24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Z6G8Um0assXQMLKJaJGn0U4gxsh9a2t8qSKGUTGP1+mKjyVrzWUj3ftDQ6vSYZicv4BOpaNFIwb7NgM7s2dTkTKkvt44tjIGAfbp4jMU7ZzOdudosZpdkvcvr4yK46Uig0eZwrVirI5UuFdDaWxk4P8iw1sugGREC2EggCxiedg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BoHC+pD6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AFDFC32786;
	Thu, 15 Aug 2024 15:02:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723734143;
	bh=rRi+6EmOs7+pVG1EHAvt51XP2hQn0UWhMGz5gSVJY24=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BoHC+pD6oPocFglcJdtHSimP1f3hS2iNbMAN4Fp4aTg4UBQdiyg7VE99+0IzEtN5R
	 5jiiIKs+pVdzrvYL5LaAgwcJSi4+8jf8eC5zkk0Y9r4Qph8JpoNf6RyGV2YCyYcevV
	 ZJsTQxKACkyHks19UcEOOU4TWfygXXYsQ0Lh3X//SKhx3KRfh1iq8b7l378Ekzv+YZ
	 oWRzJ/trg3FzanoJz7NQL7Gd5V1PPFLrFfh0rbB+C7AjsuXQO7Czke1Y7Sw2Z6HOub
	 9UVEA3bEEfv5Tm5aGebkx/ChHD00ssmCdB46Lvt8u0bFA1EMJNQsRsNGfJz+Ng6iVr
	 RnVj6CDw2OD5A==
Date: Thu, 15 Aug 2024 16:02:18 +0100
From: Simon Horman <horms@kernel.org>
To: Sean Anderson <sean.anderson@linux.dev>
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew@lunn.ch>, Michal Simek <michal.simek@amd.com>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Paolo Abeni <pabeni@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	linux-arm-kernel@lists.infradead.org,
	Jakub Kicinski <kuba@kernel.org>,
	Ariane Keller <ariane.keller@tik.ee.ethz.ch>
Subject: Re: [PATCH net-next 4/4] net: xilinx: axienet: Support IFF_ALLMULTI
Message-ID: <20240815150218.GJ632411@kernel.org>
References: <20240812200437.3581990-1-sean.anderson@linux.dev>
 <20240812200437.3581990-5-sean.anderson@linux.dev>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240812200437.3581990-5-sean.anderson@linux.dev>

On Mon, Aug 12, 2024 at 04:04:37PM -0400, Sean Anderson wrote:
> Add support for IFF_ALLMULTI by configuring a single filter to match the
> multicast address bit. This allows us to keep promiscuous mode disabled,
> even when we have more than four multicast addresses. An even better
> solution would be to "pack" addresses into the available CAM registers,
> but that can wait for a future series.
> 
> Signed-off-by: Sean Anderson <sean.anderson@linux.dev>

My comment on patch 1/4 notwithstanding, this looks good to me.

Reviewed-by: Simon Horman <horms@kernel.org>


