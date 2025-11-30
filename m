Return-Path: <netdev+bounces-242815-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DC59C9513D
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 16:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 896B1342E29
	for <lists+netdev@lfdr.de>; Sun, 30 Nov 2025 15:21:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DABD20102B;
	Sun, 30 Nov 2025 15:21:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="q3uiP5Y6"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2EF18A6B0;
	Sun, 30 Nov 2025 15:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764516100; cv=none; b=q3l1sUgleqaXqbbXhpfjg1rjBdnjUp4+wT8pItgXkhz/rPgA1t67WQ8AZF+jrOiposoa2QMiRY6YtplgrMTF2j0Aj+6F3Q4+slD/tgx4rsxOTVwBdKjK9rxAerHxIG4g7QFuGDYYkRKapuNRFOAMnoJhQRfuA+UCwIaEAigRs04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764516100; c=relaxed/simple;
	bh=pMTncD5y5MD7k0FBUjmMN/tECkD9pl+gr5TROajFk/0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BZ9lHbcA5qw0li8UUZHp5i/gPc5ROwb7xAE4hSLcJMdPf20EdENUcVrAMPaGypCQPpcLACbHSrO20KIPM+2Z55NwAea9H1deEbkS5ceLb00AhzMxvS3mKUJFdztRVB5lKk8A4uM1e6Zt0gvwLmh5ueB2qkHQfLuPM87PbXxq+us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=q3uiP5Y6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF42FC4CEF8;
	Sun, 30 Nov 2025 15:21:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764516099;
	bh=pMTncD5y5MD7k0FBUjmMN/tECkD9pl+gr5TROajFk/0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=q3uiP5Y6dTYm8XzQsS3utKBrPxsSjxYKJzn2FYxkjl74iBY5S0/fRozppYrrT5mCk
	 e5nvDI0QEgJC+ngv3zKe5LWd9p6YvQR3iodgsp85J3gH+aGQlAEIkDZIjdsUEEIsiA
	 jHcoZhW6IsDIuD9YT2n333o387EXDxgP3Qu8swolTmyRu94eS3H8jEv7WjBXCWzA/T
	 7N8YjoGRR5KK4h3/+PnCCOqd4oKga4EQKNJ5d2vpdkJTLJ9lg/mmsO1NT8reZ+RHuP
	 enlLcIfv7Jf3biqSCUevUaHBV5dCcsunqAJxwq1CV0uG9Vc8AYC9nOnIIlfsrU1qv6
	 Timq86SfmyNgg==
Date: Sun, 30 Nov 2025 15:21:34 +0000
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
Subject: Re: [PATCH net-next 1/3] net: gianfar: convert to use
 .get_rx_ring_count
Message-ID: <aSxg_r0k4QtoFGW2@horms.kernel.org>
References: <20251128-gxring_freescale-v1-0-22a978abf29e@debian.org>
 <20251128-gxring_freescale-v1-1-22a978abf29e@debian.org>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251128-gxring_freescale-v1-1-22a978abf29e@debian.org>

On Fri, Nov 28, 2025 at 05:11:45AM -0800, Breno Leitao wrote:
> Convert the gianfar driver to use the new .get_rx_ring_count
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


