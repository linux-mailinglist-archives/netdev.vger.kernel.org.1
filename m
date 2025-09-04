Return-Path: <netdev+bounces-219956-lists+netdev=lfdr.de@vger.kernel.org>
X-Original-To: lists+netdev@lfdr.de
Delivered-To: lists+netdev@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 90136B43DE4
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66FDD3BB51B
	for <lists+netdev@lfdr.de>; Thu,  4 Sep 2025 13:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14AB5305E24;
	Thu,  4 Sep 2025 13:58:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qDoVutz3"
X-Original-To: netdev@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D60CE3054EF;
	Thu,  4 Sep 2025 13:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756994320; cv=none; b=X7c61fq/I2UOA9n7fUrBlqmdufZsooyw3P1vF2b9y3kbmLBRaoERRAibGlj0mTueHBgztWkghc8JIBUcb49MLkF/GAkjA6YXAQf+4u8FR50yK1qrk3yJOGuO8BTp+yDv3BSyOYSFmmnEd4h9hto6YTdwC/mKVfxjmz6N6ReppHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756994320; c=relaxed/simple;
	bh=N/Qp4UfTrFxuQDy7aW5dgEG9BDiJ5iLJ9du9+/e2c9E=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=YhNIpbS49QBJdVHprjZ00vcHNMH06xI6eulBKwBpn4XxWndBFJwzkVM3Kj8WYv9z4jKRZCn/Fqno3wF5pFc0YRgTEHm+MMVsD5Y85C1Pv4rvWwXN1RUrCuf5hnHsoC/EH8iYfX7Go3dmRF1wVWLAYen/z9A1oxWD7+AmSqumlm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qDoVutz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D297EC4CEF1;
	Thu,  4 Sep 2025 13:58:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756994318;
	bh=N/Qp4UfTrFxuQDy7aW5dgEG9BDiJ5iLJ9du9+/e2c9E=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=qDoVutz3BBQvdD9u+iHhWWRSb6NpRWxXOWoYYaEmrvSDoSfCMRQ+z4bw9I3czpNEY
	 dwekC1/2rHlws4pu+G2DcMGeyx00UOEQ8dVfHIRq/QmXmvY7WcAmLmF/uHLTliNyP7
	 hJ8pWI61an42dgvC/+D9n7O/QhKCzgtENKlvhFDi8idH/7UwA4ZVqverJfluaXuCAf
	 /nfZqk6ubZdXgy2Vg4xXgQy1eLB2qOOyFwS1mok7ali5URrp5m9x3i8wpeOsl+OdFX
	 V4/T31bBVEcvnOTXe5RfV5A4Zq2AFgRQFGwz+pvVatHr/Q4IBXpdx1m13spyp3xwn5
	 6XWIkL7a+2hHQ==
Date: Thu, 4 Sep 2025 06:58:36 -0700
From: Jakub Kicinski <kuba@kernel.org>
To: Stefan Wahren <wahrenst@gmx.net>
Cc: Wei Fang <wei.fang@nxp.com>, Shenwei Wang <shenwei.wang@nxp.com>, Clark
 Wang <xiaoning.wang@nxp.com>, Andrew Lunn <andrew+netdev@lunn.ch>, "David
 S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Paolo
 Abeni <pabeni@redhat.com>, imx@lists.linux.dev, netdev@vger.kernel.org,
 Christoph Niedermaier <cniedermaier@dh-electronics.com>, Richard Leitner
 <richard.leitner@skidata.com>
Subject: Re: [PATCH net] net: fec: Fix possible NPD in
 fec_enet_phy_reset_after_clk_enable()
Message-ID: <20250904065836.5d0f4486@kernel.org>
In-Reply-To: <20250904091334.53965-1-wahrenst@gmx.net>
References: <20250904091334.53965-1-wahrenst@gmx.net>
Precedence: bulk
X-Mailing-List: netdev@vger.kernel.org
List-Id: <netdev.vger.kernel.org>
List-Subscribe: <mailto:netdev+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:netdev+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Thu,  4 Sep 2025 11:13:34 +0200 Stefan Wahren wrote:
>  		phy_dev = of_phy_find_device(fep->phy_node);
>  		phy_reset_after_clk_enable(phy_dev);
> -		put_device(&phy_dev->mdio.dev);
> +		if (phy_dev)
> +			put_device(&phy_dev->mdio.dev);

Looks correct, but isn't it better to also wrap
phy_reset_after_clk_enable() with the if()?
Up to you..

